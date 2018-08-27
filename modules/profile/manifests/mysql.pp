# Profile to manage mysql
class profile::mysql {
  include ::mysql::server
  create_resources(mysql::db, hiera('mysql::server::db', {}))
}
