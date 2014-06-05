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

name 'nginx'
maintainer 'nginx'
homepage 'nginx.org'

install_path    '/opt/nginx'
build_version   '1.6.0'
build_iteration 0

# Specify dependency versions to embed
override :'ruby', version: "2.0.0-p451"
override :'passenger-gem', version: "4.0.42"
override :'nginx', version: "1.6.0"

# creates required build directories
dependency 'preparation'

# nginx dependencies/components
# dependency 'somedep'

# version manifest file
dependency 'version-manifest'

exclude '\.git*'
exclude 'bundler\/git'
