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
        self.input_dir = APP_ROOT + '/../data/jawikify_20160310/'

    def test_make_similarity_word(self):
        """
        make similarity word
        """
        #wiki_vector_file_name = APP_ROOT + '/../data/jawiki_vector_delete_first_utf8.txt'
        #self.input_module = InputFile(wiki_vector_file_name)
        #self.input_module.input_fast_large_file()
        #wiki_vector = self.input_module.get_vector()
        self.input_module = InputFile(self.input_ann_list)
        self.input_module.input_list(self.input_dir)
        print(self.input_module.get_ann_list())

if __name__ == '__main__':
    unittest.main()
