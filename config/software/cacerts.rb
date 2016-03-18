name "cacerts"

default_version "2016.01.20"
source  url: "https://storage.googleapis.com/omnibus_sources/cacert.pem",
        md5: "06629db7f712ff3a75630eccaecc1fe4"

relative_path "cacerts-#{version}"
build do
  mkdir "#{install_dir}/embedded/ssl/certs"
  copy "#{project_dir}/cacert.pem", "#{install_dir}/embedded/ssl/certs/cacert.pem"
  # Windows does not support symlinks
  unless windows?
    link "#{install_dir}/embedded/ssl/certs/cacert.pem", "#{install_dir}/embedded/ssl/cert.pem"
  end
end