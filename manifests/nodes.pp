node 'puppet.interview.webperfdev.com' {
  include ntp  
}
node 'web1.interview.webperfdev.com' {
  include '::role::mediawiki'
}
node 'web2.interview.webperfdev.com' {
  include ntp 
}
node 'db.interview.webperfdev.com' {
  include ntp 
  include '::profile::mysql'
}
