set -eo pipefail

apk add --no-cache gomplate

atuin_archive_name="atuin-x86_64-unknown-linux-gnu"

chezmoi_version="2.70.0"
chezmoi_dir="chezmoi_${chezmoi_version}_linux-glibc_amd64"
chezmoi_archive="${chezmoi_dir}.tar.gz"

bitwarden_version="2.0.0"
bitwarden_archive="bws-x86_64-unknown-linux-gnu-${bitwarden_version}.zip"

zellij_archive="zellij-x86_64-unknown-linux-musl.tar.gz"

forgejo_runner_version=12.7.1

binary_folder=/binaries
rpm_folder=/rpms

mkdir -p $binary_folder
mkdir -p $rpm_folder

cd /tmp
wget -q "https://github.com/bitwarden/sdk-sm/releases/download/bws-v${bitwarden_version}/${bitwarden_archive}"
unzip $bitwarden_archive
cp bws "${binary_folder}/"

# Install atuin
wget -q "https://github.com/atuinsh/atuin/releases/latest/download/${atuin_archive_name}.tar.gz"
tar -xvf "${atuin_archive_name}.tar.gz"
cp ${atuin_archive_name}/atuin "${binary_folder}/"

# Install chezmoi
wget -q "https://github.com/twpayne/chezmoi/releases/download/v${chezmoi_version}/${chezmoi_archive}"
tar -x chezmoi -f $chezmoi_archive
cp chezmoi "${binary_folder}/"

# Install zellij
wget -q "https://github.com/zellij-org/zellij/releases/latest/download/${zellij_archive}"
tar -xf $zellij_archive
cp zellij "${binary_folder}/"

wget -q -O forgejo-runner "https://code.forgejo.org/forgejo/runner/releases/download/v${forgejo_runner_version}/forgejo-runner-${forgejo_runner_version}-linux-amd64"
chmod +x ./forgejo-runner
cp forgejo-runner "${binary_folder}/"

rm -r /tmp/*
