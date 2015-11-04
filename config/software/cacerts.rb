name "cacerts"

default_version "2015.10.30"
source url: "http://curl.haxx.se/ca/cacert.pem",
     md5: "6f41fb0f0c4b4695c2a6296892278141"

relative_path "cacerts-#{version}"
build do
  mkdir "#{install_dir}/embedded/ssl/certs"
  copy "#{project_dir}/cacert.pem", "#{install_dir}/embedded/ssl/certs/cacert.pem"
  # Windows does not support symlinks
  unless windows?
    link "#{install_dir}/embedded/ssl/certs/cacert.pem", "#{install_dir}/embedded/ssl/cert.pem"
  end
end
