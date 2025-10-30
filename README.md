# LibSsh2 Native Builds

Pre-compiled native libssh2 libraries for multiple platforms. This repository automates the building of [libssh2](https://github.com/libssh2/libssh2) for various operating systems and architectures.

## Supported Platforms

- **Windows**: x64
- **Linux**: x64, ARM64
- **macOS**: x64 (Intel), ARM64 (Apple Silicon)

## Downloads

Download the latest pre-built libraries from the [Releases](../../releases) page.

Each release includes:
- Individual platform-specific archives (e.g., `libssh2-win-x64.zip`, `libssh2-linux-x64.zip`)
- Combined archive with all platforms (`libssh2-all-platforms.zip`)

## Build Information

All libraries are built with:
- OpenSSL 3.0.15 as the crypto backend
- Zlib compression enabled (Linux/macOS)
- Shared library configuration

Release descriptions include the exact libssh2 commit SHA used for building.

## Building from Source

The build process is automated via GitHub Actions. To trigger a build:

1. Create a release tag:
   ```bash
   git tag release/1.0.0
   git push origin release/1.0.0
   ```

2. GitHub Actions will automatically:
   - Build libssh2 for all supported platforms
   - Create a GitHub release with all binaries

### Manual Build

You can also trigger builds manually using the workflow dispatch feature in the Actions tab.

## Project Structure

```
.
├── .github/
│   ├── docker/          # Dockerfiles for cross-platform builds
│   ├── scripts/         # Build scripts
│   └── workflows/       # GitHub Actions workflows
├── libssh2/             # Git submodule pointing to libssh2
└── runtimes/            # Build output (generated during builds)
    ├── win-x64/native/
    ├── linux-x64/native/
    ├── linux-arm64/native/
    ├── osx-x64/native/
    └── osx-arm64/native/
```

## License

This project uses the same BSD-style license as libssh2. See [LICENSE](LICENSE) for full details.

### License Notice

The libssh2 library is licensed under a BSD-style license:

```
Copyright (C) 2004-2023 The libssh2 project and its contributors
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

  Redistributions of source code must retain the above copyright notice,
  this list of conditions and the following disclaimer.

  Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

  Neither the name of the copyright holder nor the names of any other
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
THE POSSIBILITY OF SUCH DAMAGE.
```

## Dependencies

The binaries are built with the following dependencies:

- **OpenSSL**: Version 3.0.15 (statically linked where possible)
- **Zlib**: System-provided or bundled (Linux/macOS only)

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## Related Projects

- [libssh2](https://github.com/libssh2/libssh2) - The upstream libssh2 project
- [libssh2 Documentation](https://www.libssh2.org/)
