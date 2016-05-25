class hello_world {

   file{"/tmp/vamshi.txt":
	ensure => present,
	content => "Hello Vamshi"
	
   }

}
