### Notice
Starting October 12th, 2023 GitHub is enforcing mandatory [two-factor authentication](https://github.blog/2023-03-09-raising-the-bar-for-software-security-github-2fa-begins-march-13/) on my account.  
I'm not going to comply and move all my activity to GitLab instead.  
Any future updates / releases will be available at: [https://gitlab.com/gitendo/lz4gb](https://gitlab.com/gitendo/lz4gb)  
Thanks and see you there!
___

# LZ4GB
My attempt at creating fast and small [LZ4](https://lz4.org) unpacker in LR35902 assembly. Currently it takes **73** bytes and doesn't use RAM/HRAM during the process. This however required some small changes in data format. I've removed header data, reversed the order of match distance and length bytes and shortened end sequence. Also, match distance is stored as negative value from now on.

- `unlz4gb.asm` - [RGBASM](https://github.com/rednex/rgbds) syntax
- `unlz4gb.s` - Intelligent Systems assembler syntax

To use it in your project compile modified `smalLZ4` from my repo (original by [Stephan Brumme](http://create.stephan-brumme.com/smallz4/)) and compress your data using `-g` option: `smallz4 -g data.raw data.lz4` then decompress on GB/C using included source.

If you're interested how it stands compared to other packers visit my [Game Boy Compression Playground](https://gitendo.github.io/gbcp/) for more detailed info.
