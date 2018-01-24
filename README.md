# lz4gb
There's not much of a choice when it comes to compression related tools in Game Boy development. [PuCrunch](http://a1bert.kapsi.fi/Dev/pucrunch/) and [Pro Pack](http://aminet.net/package/util/pack/RNC_ProPack) seem to be the only available options ever since I remember. Compared to other 8-bit platforms that's a bit sad. Beating those two in terms of compression ratio would be hard, however we can still get something new. I did some small test compressing random Game Boy data - results are as follows:

| Method        | Size          | Ratio  |
| ------------- |--------------:| ------:|
| Uncompressed  | 4864          |     0% |
| GBComp        | 1908          | 60.77% |
| LZ4           | 1805          | 62.89% |
| C64Pack       | 1661          | 65.85% |
| Pro Pack (-m2)| 1602          | 67.06% |
| Pro Pack (-m1)| 1524          | 68.66% |
| PuCrunch      | 1497          | 69.22% |

As you can see [LZ4](http://www.lz4.org) doesn't provide better compression ratio but at the same time it doesn't fall behind that much. On the other hand it's fastest out of the bunch and has smallest decompression routine. I managed to squeeze it in 79 bytes not using any memory during the decompression process. That however required some small change in data format...

To use it in your project compile modified `smalLZ4` from my repo (original by [Stephan Brumme](http://create.stephan-brumme.com/smallz4/)) and compress your data using `-g` option: `smallz4 -g -9 data.raw data.lz4` then decompress on GB/C using included source. With display enabled you can have that lovely 'depacking raster bars' effect by adding one line of code in `copy` routine. Just write content of `A` to BGP or BCPD.
