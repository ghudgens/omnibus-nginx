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
name "libldap"
default_version "2.4.39"

version "2.4.39" do
  source md5: "b0d5ee4b252c841dec6b332d679cf943"
end

source url: "ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-#{version}.tgz"

relative_path "openldap-#{version}"

env = { "LDFLAGS"     => "-L#{install_dir}/embedded/lib -L#{prject_dir}/libraries -I#{install_dir}/embedded/include",
        "CFLAGS"      => "-L#{install_dir}/embedded/lib -L#{prject_dir}/libraries -I#{install_dir}/embedded/include",
        "CPPFLAGS"    => "-L#{install_dir}/embedded/lib -L#{prject_dir}/libraries -I#{install_dir}/embedded/include -D_GNU_SOURCE",
        "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command "git clone https://github.com/kvspb/nginx-auth-ldap.git"

  configure_command = ["./configure",
                       "--disable-slapd",
                       "--disable-slurpd",
                       "--prefix=#{install_dir}/embedded"]

  command configure_command.join(" "), :env => env
  
  command "make depend", :env => env
  command "make -j #{max_build_jobs}", :env => env
  command "make install", :cwd => "#{prject_dir}/libraries/libldap", :env => env
end
