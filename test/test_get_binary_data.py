# !/usr/bin/env python
# coding: utf8
import unittest
import sys
import os
from os import path
sys.path.append(os.path.join(os.path.dirname("__file__"), "./../"))
sys.path.append(os.path.join(os.path.dirname("__file__"), "."))
APP_ROOT = path.dirname(path.abspath(__file__))
import pyximport
pyximport.install()
from input_file import InputFile
from get_simillair_word import GetSimillairWord


class Test_MakeSimilarityWord(unittest.TestCase):
    """
    Usage:
        python test/test_check_similarity.py ()
    """

    def setUp(self):
        """
        setting initial paramater
        """
        self.input_ann_list = APP_ROOT + '/../data/jawikify_20160310/ann_list'
        self.input_twitter_data = APP_ROOT + '/../data/twitter_data.txt'
        self.input_dir = APP_ROOT + '/../data/jawikify_20160310/'
        self.ann_list = []

    def test_make_similarity_word(self):
        """
        make similarity word
        """
        wiki_vector_file_name = APP_ROOT + '/../data/jawiki_vector.bin'
        self.input_module = InputFile(wiki_vector_file_name)
        self.input_module.input_word2vec_binary_file()

if __name__ == '__main__':
    unittest.main()
