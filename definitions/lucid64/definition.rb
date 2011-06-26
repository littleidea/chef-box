require File.dirname(__FILE__) + "/../.common/definition.rb"

options = {
  :os_type_id => "Ubuntu_64",
  :iso_file => "ubuntu-10.04.2-server-amd64.iso",
  :iso_src => "http://releases.ubuntu.com/10.04.2/ubuntu-10.04.2-server-amd64.iso",
  :iso_md5 => "b446b36430a29f3dcf0c5eb797197cac"
}

Veewee::Session.declare(SESSION.merge(options))
