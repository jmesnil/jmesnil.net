---
layout: post
title: "Deliver Go applications as containers"
date: '2024-10-31 11:07:26'
category: 
tags:
 - containers
---

I switched to a Apple Silicon laptop running on a ARM architecture and I often want to develop Go applications that are running both on ARM architecture (to run it on my laptop) as well as on Intel.


Go makes it very easy to target different architectures at build time but it makes the delivery of the software more complex as I have to deliver multiple binaries (linux on ARM, linux on Intel, Darwin on ARM, Darwin on Intel, etc.)
There are tools for this such as [GoReleaser](https://goreleaser.com) but it still makes the deployment of the software more complex. A potential solution is to have a script file that determines the OS & architecture of the target platform and then download the appropriate executable.

Another solution that I am using more often is to deliver the software as a multi-arch container image. 
The user then just has to pull the image and run it with `podman` or `docker`.

As as simplistic example, let's say I need to write a Go application that gives the SHA-256 checksum of strings.  
To do so, I can create a Go module with a simple `checksum` application:

```bash
$ mkdir checksum
$ cd checksum
$ go mod init checksum
$ mkdir cmd
$ touch cmd/checksum.go
```

The content of the `cmd/checksum.go` is:

```go
package main

import (
        "crypto/sha256"
        "encoding/hex"
        "fmt"
        "os"
)

func main() {

        if len(os.Args) == 1 {
                fmt.Printf("No arguments\n")
                fmt.Printf("Usage: checksum <list of strings to hash>\n")
                os.Exit(1)
        }

        strs := os.Args[1:]

        hash := sha256.New()

        for i, str := range strs {
                h.Reset()
                hash.Write([]byte(str))
                checksum := hash.Sum(nil)
                if i > 0 {
                        fmt.Printf(" ")
                }
                fmt.Printf("%s", hex.EncodeToString(checksum))
        }
        fmt.Printf("\n")
}
```

I can test that the application is working as expected by running it with `go run`:

```bash
$ go run ./cmd/checksum.go foo
2c26b46b68ffc68ff99b453c1d30413413422d706483bfa0f98a5e886266e7ae
```

Now, I need to create a container that provides this application for both the ARM and Intel architectures.

I need a simple `Containerfile` to do so:

```nocode
FROM golang:1.23 AS go-builder

WORKDIR /workspace/
COPY . .
RUN GOOS=linux go build -o ./build/checksum ./cmd/checksum.go

FROM scratch

COPY --from=go-builder /workspace/build/checksum /
ENTRYPOINT [ "/checksum" ]
```

The container build is done in two stages:

1. I use the `golang:1.23` builder to compile the code, targeting the `linux` operating system.
2. I create an image from `scratch` that only contains the executable compiled from the first stage.

Then I can use `podman` to build a multi-arch image (for both `linux/amd64` and `linux/arm64`):

```bash
$ podman build --platform linux/amd64,linux/arm64 --manifest localhost/checksum .
```

The resulting `localhost/checksum` image is small and contains only the `checksum` executable.

I can run it locally with `podman`:

```bash
$ podman run localhost/checksum foo

2c26b46b68ffc68ff99b453c1d30413413422d706483bfa0f98a5e886266e7ae
```

Podman will run the `linux/arm64` image on my ARM laptop but an user on a Intel machine would use the `linux/amd64` image.
I can force Podman to use the Intel variant on my ARM laptop and it would run fine too (with a warning that the image no longer matches
my platform)

```bash
$ podman run --platform linux/amd64 localhost/checksum foo

WARNING: image platform (linux/arm64) does not match the expected platform (linux/amd64)
2c26b46b68ffc68ff99b453c1d30413413422d706483bfa0f98a5e886266e7ae
```

At this point, to make the application available for others, I just need to push it to a container registry on Quay.io or ghcr.io 
and they will be able to use it as I do on my laptop.

This solution works fine for programs that don't need heavy integration with the host operating system. 
If my input would need to access the file system, I would have to mount directories with `-v` to make them available inside the image.
If the integration with the host starts to be more complex, it would be better to provide a shell script that pulls the image and run Podman with the right configuration parameters.
