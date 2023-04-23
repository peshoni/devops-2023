install.mariadb: 
  pkg: 
    - name: mariadb
    - installed
install.mysql-server: 
  pkg:
    - name: mysql-server
    - installed

execute.script:
  cmd.run:
    - name: /vagrant/db.sh
    - cwd: /
    - stateful: True
    