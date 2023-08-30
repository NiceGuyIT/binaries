# binaries

Single binary applications uncompressed suitable for direct download

## Building with Docker

The repo files need to be modified before building. Trying to do this with Dockerfile is not possible because you can't
[mount a volume to a docker "image"](). Instead, create an image using a basic Dockerfile (i.e. only use the FROM) and
then create a container to run the build. Mount the host volumes in the container as necessary.

[mount a volume to a docker "image"]: https://stackoverflow.com/questions/26050899/how-to-mount-host-volumes-into-docker-containers-in-dockerfile-during-build

## pyOxidizer
This repo has a good example of pyOxidizer.

<https://github.com/henningWoehr/action-pyoxidizer-build>

## RustPython

The following change was made to restrict RustPython's library to the `exec-wrapper` directory. Also, support for
user sites was disabled. This should prevent RustPython from polluting the system.

Ideally, this should be a patch in a docker build script.

`Lib/site.py`

```python
# Prefixes for site-packages; add additional prefixes like /usr/local here
PREFIXES = ["/opt/exec-wrapper"]
# Enable per user site-packages directory
# set it to False to disable the feature or True to force the feature
ENABLE_USER_SITE = False
```

### Static binary

RustPython cannot be compiled statically.

```text
  = note: /usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-linux/bin/ld: /tmp/rustcHd4jjG/liblibsqlite3_sys-84611053fffab11d.rlib(sqlite3.o): in function `unixDlOpen':
          sqlite3.c:(.text.unixDlOpen+0x9): warning: Using 'dlopen' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
```

Comment this out in `~/.cargo/config`, or change the `+` to `-`.

```text
#[target.x86_64-unknown-linux-gnu]
#rustflags = ["-C", "target-feature=+crt-static"]
```

### Cross-compiling RustPython

In order to use `pip`, RustPython needs the ssl library.

```bash
OPENSSL_DIR=/usr \
RUSTFLAGS='-C target-feature=-crt-static' \
cargo build --release --target x86_64-unknown-linux-gnu --features "freeze-stdlib,stdlib,ssl"

OPENSSL_DIR=/usr \
RUSTFLAGS='-C target-feature=-crt-static' \
cargo build --release --target x86_64-pc-windows-gnu --features "freeze-stdlib,stdlib,ssl"
```

```text
  = note: /usr/lib64/gcc/x86_64-w64-mingw32/9.2.0/../../../../x86_64-w64-mingw32/bin/ld: cannot find -lssl
          /usr/lib64/gcc/x86_64-w64-mingw32/9.2.0/../../../../x86_64-w64-mingw32/bin/ld: cannot find -lcrypto
```
