call bundle install
call gem uninstall bcrypt
call gem install bcrypt --platform=ruby
call gem uninstall mysql2 
call gem install mysql2 --version='0.4.10' --platform=ruby -- '--with-mysql-lib="c:\dev\mysql\lib" --with-mysql-include="c:\dev\mysql\include"'