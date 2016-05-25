
class myvariables($name_is) {

	notice("${name_is}")
	
	file{"/tmp/myvariable.txt":
		ensure => present,
		content => "${name_is}" 
   }
}