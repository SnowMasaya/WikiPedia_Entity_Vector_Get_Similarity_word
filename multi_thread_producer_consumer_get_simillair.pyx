#!/usr/bin/env python
from __future__ import print_function

import sys

sys.path.append('.')
import os
sys.path.append(os.path.join(os.path.dirname("__file__"), "../"))
import random
import queue
import time
import pyximport
pyximport.install()
from get_simillair_word import GetSimillairWord
"""
You setting Queue size for memory
Reference:
    http://ja.pymotw.com/2/Queue/
"""
SEED_DOMAIN_LIST_SIZE = 192
word_queue = queue.Queue(SEED_DOMAIN_LIST_SIZE)
check_queue = queue.Queue(SEED_DOMAIN_LIST_SIZE)
APP_ROOT = os.path.dirname(os.path.abspath("__file__"))


class ProducerConsumerThread(object):
    """
    Producer
    Consumer
    Multi Thread Crawling.
    Using the Consumer Producer pattern
    Reference
        Python Consumer Producer pattern
            http://agiliq.com/blog/2013/10/producer-consumer-problem-in-python/
        Multi Thread Design pattern
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
        self.twitter_proper_noun_wiki_vector_dict = {}

    def producer_run(self, proper_noum_list):
        """
        Running Producer
        Setting seed domain into the Queue
        """
        global word_queue
        global check_queue
        while True:
            if proper_noum_list:
                noum = proper_noum_list.pop()
                if noum not in check_queue.queue:
                    try:
                        log_text = "Produced " + str(noum)
                        print(log_text)
                        word_queue.put(noum)
                        check_queue.put(noum)
                    except word_queue.Full:
                        print("Queue Full")
                        pass
                    else:
                        time.sleep(random.uniform(0.0, 0.5))
            else:
                print("No noum " + str(proper_noum_list))
                break

    def consumer_run(self):
        """
        Running Consumer
        Taking the seed domain
        """
        global word_queue
        while True:
            try:
                noum = word_queue.get()
            except word_queue.Empty:
                print("Queue Empty")
                pass
            else:
                get_similarity_word_module = GetSimillairWord(self.data_list, self.proper_noun_list, self.wiki_vector, self.twitter_proper_noun_wiki_vector_dict)
                self.twitter_proper_noun_wiki_vector_dict = get_similarity_word_module.calc_similiarity_word(noum)
                log_text = "Consume " + str(noum)
                print(log_text)
                print(self.twitter_proper_noun_wiki_vector_dict)
                word_queue.task_done()
                # Setting the wait time, I refered to the bellow link
                #  https://www.w3.org/Protocols/HTTP-NG/http-prob.html
                time.sleep(random.uniform(0.601, 0.602))
