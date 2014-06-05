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
default_version "2.4.9"

version "2.4.9" do
  source md5: "1d0c8913b4671b2e2e66ed546b4e9bbf"
end

source url: "ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-#{version}.tgz"

relative_path "openldap-#{version}"

working_dir = "#{project_dir}/#{relative_path}"

env = { "LDFLAGS"     => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
        "CFLAGS"      => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
        "CPPFLAGS"    => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
        "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command "git clone https://github.com/kvspb/nginx-auth-ldap.git"

  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded"]

  command configure_command.join(" "), :env => env
  
  command "make depend", :env => env
  command "make -j #{max_build_jobs}", :env => env
  command "make install", :cwd => "#{working_dir}/libraries/libldap", :env => env
end
