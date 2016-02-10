#
# Copyright 2012-2014 Chef Software, Inc.
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

name "libtool"
default_version "2.4"

version("2.4")   { source md5: "b32b04148ecdd7344abc6fe8bd1bb021" }
version("2.4.2") { source md5: "d2f3b7d4627e69e13514a40e72a24d50" }
version("2.4.6") { source md5: "addf44b646ddb4e3919805aa88fa7c5e" }


source url: "https://ftp.gnu.org/gnu/libtool/libtool-#{version}.tar.gz"

relative_path "libtool-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  # AIX's old version of patch doesn't like the config.guess patch here
  unless aix?
    # Update config.guess to support newer platforms (like aarch64)
    if version == "2.4"
      patch source: "config.guess_2015-09-14.patch", plevel: 0, env: env
    end
  end

  command "./configure" \
          " --prefix=#{install_dir}/embedded", env: env

  make env: env
  make "install", env: env
end
