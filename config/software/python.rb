#
# Copyright:: Copyright (c) 2014 Grant Hudgens.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
name "python"
default_version "2.7.7"

dependency "gdbm"
dependency "ncurses"
dependency "zlib"
dependency "openssl"
dependency "bzip2"

version "2.7.7" do
  source :md5 => "cf842800b67841d64e7fb3cd8acb5663"
end

source :url => "http://python.org/ftp/python/#{version}/Python-#{version}.tgz",

relative_path "Python-#{version}"

env = {
  "CFLAGS" => "-I#{install_dir}/embedded/include -O3 -g -pipe",
  "LDFLAGS" => "-Wl,-rpath,#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib"
}

build do
  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded",
                       "--enable-shared",
                       "--with-dbmliborder=gdbm"]

  command configure_command.join(" "), :env => env

  command "make", :env => env
  command "make install", :env => env
end