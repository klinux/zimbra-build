# Zimbra 10 FOSS Build
Estes scripts executam o build do Zimbra 10 FOSS para RockyLinux 8.

## Build da imagem
Clone o projeto e entre na pasta
```sh
git clone git@github.com:klinux/zimbra-build.git
cd zimbra-build
```

## Iniciar o build do Zimbra
Para executar o build configure as seguintes variaveis:

### Makefile
```sh
export BUILD_NO="0001"
export BUILD_RELEASE_NO="10.0.1"
make -s build
```

### Manual

Crie uma chave ssh para poder usar o git:
```sh
mkdir ssh
ssh-keygen -t rsa -b 4096 -C "example@example.com" -f $PWD/ssh/id_rsa
```

Crie um diretorio chamado volume:
```sh
mkdir volume
```

## Build da imagem
```sh
docker build -t rockylinux8-zm-build .
```

* BUILD_RELEASE_NO - especifique a versão que deseja compilar. (https://github.com/Zimbra/zm-build/tags)
* BUILD_NO - Versão do build, exemplo, 00001, 00002 e assim por diante para cada build que for usado.

```sh
docker run --rm --name "zimbra-build-rockylinux8" \
-v $PWD/volume:/home/git/zimbra/BUILDS \
-v $PWD/ssh:/root/.ssh \
-e BUILD_NO="0001" \
-e BUILD_RELEASE="DAFFODIL" \
-e BUILD_RELEASE_NO="10.0.1" \
-e BUILD_OS="RHEL8_64" \
-e BUILD_ARCH="amd64" \
-e BUILD_TYPE="FOSS" \
-e PKG_OS_TAG="r8" \
-e BUILD_RELEASE_CANDIDATE="GA" \
-e BUILD_THIRDPARTY_SERVER="files.zimbra.com" \
-e INTERACTIVE="0" \
rockylinux8-zm-build
```

Ou edite o arquivo **create.sh** e coloque as váriaveis e rode o script:
```sh
./create.sh
```
## Artefato
Após o processo terminar, dependendo da máquina que for usada, termina em torno de 25 minutos.
O arquivo final está na pasta **volume** só copiar o arquivo final e instalar ou atualizar o Zimbra.
