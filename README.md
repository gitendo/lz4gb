# LZ4GB
My attempt at creating fast and small [LZ4](https://lz4.org) unpacker in LR35902 assembly. Currently it takes **73** bytes and doesn't use RAM/HRAM during the process. This however required some small changes in data format. I've removed header data, reversed the order of match distance and length bytes and shortened end sequence. Also, match distance is stored as negative number from now on.

- `unlz4gb.asm` - [RGBASM](https://github.com/rednex/rgbds) syntax
- `unlz4gb.s` - Intelligent Systems assembler syntax

To use it in your project compile modified `smalLZ4` from my repo (original by [Stephan Brumme](http://create.stephan-brumme.com/smallz4/)) and compress your data using `-g` option: `smallz4 -g data.raw data.lz4` then decompress on GB/C using included source.

If you're interested how it stands compared to other packers visit my [Game Boy Compression Playground](https://gitendo.github.io/gbcp/) for more detailed info.
