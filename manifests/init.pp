exec { "apt-update":
   command => "apt-get update",
   path => ["/usr/sbin","/sbin","/usr/bin","/bin","/usr/local/bin"],
}

package { ["python-software-properties","python","g++","make"]:
    ensure => "present",
    require => Exec["apt-update"]
}

exec { "nodejs-ppa":
   command => "apt-add-repository -y ppa:chris-lea/node.js && apt-get update",
   unless => "ls /etc/apt/sources.list.d/chris-lea-node_js-precise.list",
   path => ["/usr/sbin","/sbin","/usr/bin","/bin","/usr/local/bin"],
   require => Package["python-software-properties"]
}

package { ["nodejs", "git", "coffeescript"]:
    ensure => "present",
    require => Exec["nodejs-ppa"]
}

exec { "nfn-clone":
   command => "git clone https://github.com/idigbio-citsci-hackathon/notesFromNature.git /usr/local/notesFromNature",
   unless => "ls /usr/local/notesFromNature",
   path => ["/usr/sbin","/sbin","/usr/bin","/bin","/usr/local/bin"],
   require => Package["git"]
}

exec { "nfn-install-step1":
   command => "npm install",
   cwd => "/usr/local/notesFromNature",
   path => ["/usr/sbin","/sbin","/usr/bin","/bin","/usr/local/bin"],
   require => [Exec["nfn-clone"],Package["nodejs"]]
}

exec { "nfn-install-step2":
   command => "coffee build.coffee",
   cwd => "/usr/local/notesFromNature",
   path => ["/usr/sbin","/sbin","/usr/bin","/bin","/usr/local/bin"],
   require => [Exec["nfn-clone"],Package["coffeescript"], Exec["nfn-install-step1"]]
}

exec { "nfn-run":
   command => "hem server &",
   cwd => "/usr/local/notesFromNature",
   path => ["/usr/sbin","/sbin","/usr/bin","/bin","/usr/local/bin", "/usr/local/notesFromNature/node_modules/hem/bin"],
   require => [Exec["nfn-clone"],Exec["nfn-install-step2"]]
}
