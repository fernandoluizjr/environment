# My environments with vagrant and puppet

![Image of my puppet modules classes and type-defined](https://github.com/fernandoluizjr/environment/blob/master/images/puppet_module_class_typedef.png)

When using CI machine, you have to generate key-pairs to sign the packages in repository:

`sudo apt-get install haveged`

`sudo su - jenkins`

`gpg --gen-key`

Choose a RSA key with 2048 bytes of size that never expires. Also insert a name and an e-mail for the key.
Take notes of the fingerprint generated and modify the apt::source resource in the lojavirtual's web.pp manifest.

Export the key into the repository directory:

`gpg --export --armor info@acme.com > /var/lib/apt/repo/devopspkgs.gpg`
