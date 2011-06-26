require File.dirname(__FILE__) + "/../.common/definition.rb"

options = {
  :os_type_id => "Ubuntu",
  :iso_file => "ubuntu-10.04.2-server-i386.iso",
  :iso_src => "http://releases.ubuntu.com/10.04.2/ubuntu-10.04.2-server-i386.iso",
  :iso_md5 => "9807160b8935289096df8160832e358e"
}

Veewee::Session.declare(SESSION.merge(options))
