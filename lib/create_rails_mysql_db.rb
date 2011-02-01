module CreateRailsMysqlDb
  class Application
    class << self
      def run!(*arguments)

        require 'rubygems'
        require 'yaml'

        @DBPATH='config/database.yml'
        @DBTYPES=['mysql', 'mysql2']

        if arguments.include?('-h')
          puts  <<-eos
create_rails_mysql_db
Without options reads config/database.yml and create listed databases, grant access to username
-g : options to generate new password, and replace username to database name
                eos
          exit
        end

        generate_password=arguments.include?('-g')
        puts "Warning if password empty username=database name, new password will be generated\nconfig/database.yml will be overwrited\n" if (generate_password)

        begin

          def newpwd(len)
            chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
            newpass = ""
            1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
            return newpass
          end
          newpass = newpwd(8)
          changed=0

          File.open(@DBPATH) do |f|
            dbconf=YAML.load(f)
            dbconf.each do |type,db| 
              raise 'Adapter must be mysql' unless @DBTYPES.include?(db['adapter']) 
              raise 'Not defined username' unless db['username']
              if !db['password'] && generate_password
                dbconf[type]['password'] = newpass
                dbconf[type]['username'] = dbconf[type]['database'].length>16 ? dbconf[type]['database'].gsub(/(\_.{4}).*/, '\1') : dbconf[type]['database']
                raise 'Too long username' if dbconf[type]['username'].length>16
                changed+=1
              elsif !db['password']
                raise 'Not defined password' unless db['password']
              end
              raise 'Too long username' if dbconf[type]['username'].length>16
            end

            File.open(@DBPATH, "w") { |f| YAML::dump(dbconf, f) } if (changed>0)
            puts "Enter mysql root password:"
            STDOUT.flush
            system "stty -echo" 
            mysql_root=STDIN.gets.gsub("\n", "")
            system "stty echo" 
            dbconf.each do |type,db|
              mysql_command="mysql -uroot -p\"#{mysql_root}\" -e \"create database #{db['database']}; grant all on #{db['database']}.* to #{db['username']}@'localhost' identified by '#{db['password']}'\";"
              system(mysql_command)
            end
          end
        rescue Errno::ENOENT => e
          puts "Can't open #{@DBPATH}"
        rescue ArgumentError, SyntaxError => e
          puts "Error in yaml format"
        rescue => e
          puts e.message
        end
      end
    end
  end
end


