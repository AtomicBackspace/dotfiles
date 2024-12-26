# dotfiles

## Requirements
- SOPS

Note: All requirements can be installed by running the install scripts

## Configurations
- [Gitleaks](https://github.com/gitleaks/gitleaks)
- [SOPS](https://github.com/getsops/sops?tab=readme-ov-file#212using-sopsyaml-conf-to-select-kms-pgp-and-age-for-new-files)
- [SOPS & Git](https://devops.datenkollektiv.de/using-sops-with-age-and-git-like-a-pro.html)

## Git Setup
```bash
git config --local gpg.format ssh
git config --local user.signingkey ~/PATH/TO/.SSH/KEY.PUB
echo "$(git config --get user.email) namespaces=\"git\" $(cat ~/PATH/TO/.SSH/KEY.PUB)" >> ~/.ssh/allowed_signers
git config --local gpg.ssh.allowedSignersFile ~/.ssh/allowed_signers
git config --local commit.gpgsign true
git config --local tag.gpgsign true
git config --local core.sshCommand "ssh -i ~/PATH/TO/.SSH/KEY.PUB"
```
