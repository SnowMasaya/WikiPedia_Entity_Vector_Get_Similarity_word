#!/usr/bin/env python
# -*- coding: utf-8 -*-
import codecs
import csv
from gensim.models import word2vec
csv.field_size_limit(1760000000)

class InputFile():
    """Input file class.

    This class read the a varity of file such as the txt
    If you input the file, you only use the this class
    """

    def __init__(self, file_name):
        """
        Args:
            file_name (str): you set the file name.
        """
        self.__file_name = file_name
        self.__data = []
        self.__word_vector = {}
        self.__ann_list = []

    def input_special_format_file(self, input_delimiter=""):
        """
        Examples:
            csv file
                input_special_format_file(",")
            tsv file
                input_special_format_file("\t")
        Args:
            input_delimiter: you set the delimiter.
        """
        if input_delimiter == "":
            file = open(self.__file_name, 'r')
        else:
            f = codecs.open(self.__file_name, 'r', 'utf-8')
            file = csv.reader(f, delimiter=input_delimiter)
        for line in file:
            self.__data.append(line.strip())
        # close
        if input_delimiter == "":
            file.close()
        else:
            f.close()

    def input_fast_large_file(self):
        with open(self.__file_name, encoding='utf-8') as FileObj:
            for lines in FileObj:
                word_vector = lines.strip().split(" ")
                word = word_vector.pop(0)
                word_vector = list(map(float, word_vector))
                if word not in self.__word_vector:
                    self.__word_vector.update({word: word_vector})

    def input_word2vec_binary_file(self):
        model = word2vec.Word2Vec.load_word2vec_format(self.__file_name, binary=True, encoding='utf-8', unicode_errors='ignore')
        for word, vector in model.vocab.items():
            replace_word = word.replace(">>", "").replace("<<", "")
            if word not in self.__word_vector:
                self.__word_vector.update({replace_word: vector})

    def input_list(self, file_dir):
        """
        get the file list and read each file
        """
        with open(self.__file_name, encoding='utf-8') as file_list:
            for lines in file_list:
                with open(file_dir + lines.strip(), encoding='utf-8') as file_data:
                    for data in file_data:
                        split_word = data.strip().split("\t")
                        if len(split_word) > 2:
                            self.__ann_list.append(split_word[2])

    def get_file_data(self):
        """If you get the file data you call this function."""
        return self.__data

    def get_vector(self):
        """If you get the vector file data you call this function."""
        return self.__word_vector

    def get_ann_list(self):
        """If you get the wikificatation data you call this function."""
        return self.__ann_list
