install.apache.debian: 
  pkg: 
    - name: apache2
    - installed
run.apache.debian:
  service.running: 
    - name: apache2 
    - require: 
      - pkg: apache2
execute.script:
  cmd.run:
    - name: /vagrant/web.sh
    - cwd: /
    - stateful: True      
