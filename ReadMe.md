Git Hook
	
	mkdir mywebsite.git
	cd mywebsite.git
	git init --bare
	Then create file hooks/post-receive:
	
	#!/bin/sh
	GIT_WORK_TREE=/path/to/webroot/of/mywebsite git checkout -f
	And make the file executable:
	
	chmod +x hooks/post-receive
	On your local machine,
	
	git remote add production git@myserver.com:mywebsite.git
	git push production +master:refs/heads/master