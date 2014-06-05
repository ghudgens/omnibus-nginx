
name 'nginx'
maintainer 'CHANGE ME'
homepage 'CHANGEME.com'

install_path    '/opt/nginx'
build_version   Omnibus::BuildVersion.semver
build_iteration 1

# creates required build directories
dependency 'preparation'

# nginx dependencies/components
# dependency 'somedep'

# version manifest file
dependency 'version-manifest'

exclude '\.git*'
exclude 'bundler\/git'
