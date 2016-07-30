#!/usr/bin/env python
# -*- coding: utf-8 -*-
from os import path
import yaml
import re
import mojimoji
import neologdn
import MeCab
from scipy import linalg, mat, dot

APP_ROOT = path.dirname( path.abspath("__file__") )

CONFIG_FILE=APP_ROOT + "/conf/conf.yml"


class GetSimillairWord():
    """
    Get the Similliar word using by the wikipedia entity vector and Wikificatation
        Wikificatation
            http://www.cl.ecei.tohoku.ac.jp/jawikify/
        Japanese Wikipedia Vector
            http://www.cl.ecei.tohoku.ac.jp/%7Em-suzuki/jawiki_vector/
    """

    def __init__(self, data_list, proper_noun_list, wiki_vector={}):
        """
        Setting the initial paramater
        :param data_list(list): setting the analysis data
        :param proper_noun_list(list): setting the wikificatation data(proper noun)
        :param wiki_vector(list): setting the wikipedia entity vector
        """
        self.data_list = data_list
        self.proper_noun_list = proper_noun_list
        self.wiki_vector = wiki_vector
        with open(CONFIG_FILE, encoding="utf-8") as cf:
             e = yaml.load(cf)
             self.mecab_wakati = e["mecab_wakati"]
        self.tagger = MeCab.Tagger(self.mecab_wakati)
        self.twitter_proper_noun_list = []
        self.twitter_proper_noun_wiki_vector_list = []
        self.COSIN_SIMILARITY_LIMIT = 0.7

    def __normalize(self, contents):
        """
        Normalize received text.
        This function is extracted from my_parser.py to use by ruby program.
        :param contents:
        :return:
        """
        readable_article_normalize = re.sub("\r|\r\n|¥n", "\n", neologdn.normalize(mojimoji.zen_to_han(contents)))
        return readable_article_normalize

    def get_proper_noun_word(self):
        """
        Reference:
            http://aidiary.hatenablog.com/entry/20101121/1290339360
        :param readable_article_normalize: normalize contents text
        :return:
        """
        normalize_sentence = list(map(lambda x: self.__normalize(x), self.data_list))
        for wakati_data in normalize_sentence:
            result = self.tagger.parse(wakati_data).strip()
            self.__get_proper_noun(result.split(" "))

    def __get_proper_noun(self, split_word):
        """
        Get the proper noun word
        :param split_word(list): set the split word by mecab
        :return:
        """
        for word in split_word:
            if word in self.proper_noun_list:
                self.twitter_proper_noun_list.append(word)

    def get_simillair_word(self):
        """
        get the simillair word
        """
        for word in self.twitter_proper_noun_list:
            if word in self.wiki_vector:
                for wiki_word, vector in self.wiki_vector.items():
                    cosine_similarity = self.__cosine_similarity(self.wiki_vector[word], vector)
                    if cosine_similarity:
                        self.twitter_proper_noun_wiki_vector_list.append(wiki_word)

    def __cosine_similarity_judge(self, cosine_similarity):
        """
        The cosigne similarty word check
        :param cosine_similarity:
        :return:
        """
        if cosine_similarity > self.COSIN_SIMILARITY_LIMIT:
            return True
        else:
            return False

    def __cosine_similarity(self, vector1, vector2):
        """
        calculate the cosine similarity
        """
        if len(vector1) != len(vector2):
            return 0
        cosine_vector1 = mat(vector1)
        cosine_vector2 = mat(vector2)
        try:
            return dot(cosine_vector1, cosine_vector2.T) / linalg.norm(cosine_vector1) / linalg.norm(cosine_vector2)
        except ZeroDivisionError:
            return 0