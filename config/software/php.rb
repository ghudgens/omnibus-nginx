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
name "php"
default_version "5.4.29"

dependency "zlib"
dependency "pcre"
dependency "libxslt"
dependency "libxml2"
dependency "libiconv"
dependency "openssl"

version "5.4.29" do
  source md5: "9caf973b19ba93bb2b78f78c61643d5d"
end

source url: "http://us.php.net/distributions/php-#{version}.tar.gz"

relative_path "php-#{version}"


env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command(["./configure",
           "--prefix=#{install_dir}/embedded",
           "--without-pear",
           "--with-zlib-dir=#{install_dir}/embedded",
           "--with-pcre-dir=#{install_dir}/embedded",
           "--with-xsl=#{install_dir}/embedded",
           "--with-libxml-dir=#{install_dir}/embedded",
           "--with-iconv=#{install_dir}/embedded",
           "--with-openssl-dir=#{install_dir}/embedded",
           "--with-png-dir=#{install_dir}/embedded",
           "--with-gd",
           "--enable-fpm",
           "--with-fpm-user=nginx",
           "--with-fpm-group=nginx"].join(" "),
          :env => env)

  command "make -j #{max_build_jobs}", :env => {"LD_RUN_PATH" => "#{install_dir}/embedded/lib"}
  command "make install"
end