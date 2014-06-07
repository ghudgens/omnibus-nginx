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
name "libpng"
default_version "1.6.11"

dependency "zlib"

version "1.6.11" do
  source :md5 => "967be11a119823e32fa6a3b90e8131fa"
end

source :url => "http://downloads.sourceforge.net/libpng/libpng-#{version}.tar.gz"

relative_path "libpng-#{version}"

env = { "LDFLAGS"     => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
        "CFLAGS"      => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
        "CPPFLAGS"    => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
        "LD_RUN_PATH" => "#{install_dir}/embedded/lib"}

build do
  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded",
                       "--with-zlib-prefix=#{install_dir}/embedded"]

  command configure_command.join(" "), :env => env

  command "make -j #{max_build_jobs}", :env => env
  command "make install", :env => env
end
