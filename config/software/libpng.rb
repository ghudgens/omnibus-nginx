#
# Copyright:: Copyright (c) 2012-2014 Chef Software, Inc.
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

name "libpng"
default_version "1.5.17"

dependency "zlib"

case version
#Current releases
when "1.0.61"
  source :md5 => "1d65f75274d2d215fbbe08b0c5ae6b95"
  source :url => "ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng#{version.match(/^(\d+\d+)/)[0]}/libpng-#{version}.tar.gz"
when "1.2.51"
  source :md5 => "e358f9a265f2063b36f10dc454ee0e17"
  source :url => "ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng#{version.match(/^(\d+\d+)/)[0]}/libpng-#{version}.tar.gz"
when "1.4.13"
  source :md5 => "020c19f3216e9e65c8b6de56b13bc001"
  source :url => "ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng#{version.match(/^(\d+\d+)/)[0]}/libpng-#{version}.tar.gz"
when "1.5.18"
  source :md5 => "5266905cef49d1224437465ad4d67fd9"
  source :url => "ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng#{version.match(/^(\d+\d+)/)[0]}/libpng-#{version}.tar.gz"
when "1.6.11"  
  source :md5 => "967be11a119823e32fa6a3b90e8131fa"
  source :url => "ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng#{version.match(/^(\d+\d+)/)[0]}/libpng-#{version}.tar.gz"
#Historical releases
when "1.5.13"
  source :md5 => "9c5a584d4eb5fe40d0f1bc2090112c65"
  source :url => "ftp://ftp.simplesystems.org/pub/libpng/png/src/history/libpng#{version.match(/^(\d+\d+)/)[0]}/libpng-#{version}.tar.gz"
when "1.5.17"
  source :md5 => "d2e27dbd8c6579d1582b3f128fd284b4"
  source :url => "ftp://ftp.simplesystems.org/pub/libpng/png/src/history/libpng#{version.match(/^(\d+\d+)/)[0]}/libpng-#{version}.tar.gz"
else
  source :url => "ftp://ftp.simplesystems.org/pub/libpng/png/src/history/libpng#{version.match(/^(\d+\d+)/)[0]}/libpng-#{version}.tar.gz"
end

relative_path "libpng-#{version}"

configure_env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command "./configure --prefix=#{install_dir}/embedded --with-zlib-prefix=#{install_dir}/embedded", :env => configure_env
  command "make -j #{max_build_jobs}", :env => {"LD_RUN_PATH" => "#{install_dir}/embedded/lib"}
  command "make install"
end