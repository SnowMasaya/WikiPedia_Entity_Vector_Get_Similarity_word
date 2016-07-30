Get the Similarity word using the Wikipedia Entity Vector
====

This tool is avable to get the similliar word using by the wikification and wikipedia entity vector

## Description

If you would like to read the japanese description, you read the below link
    http://qiita.com/GushiSnow/private/d7c5a09b38d3ca650abd

#
### Install

If you don't install pyenv and virtualenv you have to install bellow
####Prepare Install
linux
```
apt-get install pyenv
apt-get install virtualenv
```
Mac
```
brew install pyenv
brew install virtualenv
```

####Prepare Inastall2
```
pyenv install 3.5.0
pyenv rehash
pyenv local 3.5.0
```

```
pip install -r pip3.5-requirement.txt
```

####Prepare the Data

#### About Wikificatation

[Wikificatation is the proper noun data](http://www.cl.ecei.tohoku.ac.jp/jawikify/)

#### About Wikipedia Vector

[Japanese WikiPedia Entity Vector](http://www.cl.ecei.tohoku.ac.jp/%7Em-suzuki/jawiki_vector/)

#### About the Data

We collect the twitter data

##Requirements


```
    Python 3.5.0
	Mecab and neolog-dict
	Cython==0.24
    PyYAML==3.11
    future==0.15.2
    mecab-python3==0.7
    mojimoji==0.0.5
    neologdn==0.2
    scipy==0.17.0
```

#
### Usage
#

```
python test/test_make_similarity_word.py
```

#
### Code Directory Structure
#
```
  - data/　　　　　... Set the Data
  - conf/　     　... Configure setting
  - test/　     　... test code
```
#
### Licence
#
```
The MIT License (MIT)

Copyright (c) 2015 Masaya Ogushi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
#
### Author
#
[SnowMasaya](https://github.com/SnowMasaya)
### References
#
>[Japanese Wikipedia Entity Vector](http://www.cl.ecei.tohoku.ac.jp/~m-suzuki/jawiki_vector/)
>[Japanese Wikification](http://www.cl.ecei.tohoku.ac.jp/jawikify/)
