#!/usr/bin/env python

import argparse
import sys
import os
sys.path.append(os.path.join(os.path.dirname(__file__), "../"))
import pyximport
pyximport.install()
from input_file import InputFile
from get_simillair_word import GetSimillairWord
from multi_thread_producer_consumer_get_simillair import ProducerConsumerThread
from os import path
import threading
APP_ROOT = path.dirname(path.abspath( __file__ ))

"""
This script for parallel command multi thread program
"""

if __name__ == '__main__':
    """
    args
    """
    parser = argparse.ArgumentParser()
    parser.add_argument('--consumer_size', '-c', default=100,
                        help='set consumer size')
    parser.add_argument('--wiki_vector', '-wv', default=APP_ROOT + '/data/jawiki_vector_delete_first_utf8.txt',
                        help='set wiki_vector')
    parser.add_argument('--ann_list', '-an', default=APP_ROOT + '/data/jawikify_20160310/ann_list',
                        help='set annon list')
    parser.add_argument('--twitter_data', '-tw', default=APP_ROOT + '/data/twitter_data.txt',
                        help='set twitter data')
    parser.add_argument('--input_dir', '-i', default=APP_ROOT + '/data/jawikify_20160310/',
                        help='set input dir')
    args = parser.parse_args()
    wiki_vector_file_name = args.wiki_vector
    input_ann_list = args.ann_list
    input_twitter_data = args.twitter_data
    input_dir = args.input_dir

    # GEt wiki Vector
    input_module = InputFile(wiki_vector_file_name)
    input_module.input_fast_large_file()
    wiki_vector = input_module.get_vector()
    # Get Wikificatation
    input_module = InputFile(input_ann_list)
    input_module.input_list(input_dir)
    ann_list = input_module.get_ann_list()

    # get Twitter data
    input_module = InputFile(input_twitter_data)
    input_module.input_special_format_file()
    twitter_list = input_module.get_file_data()

    # extract Proper noum int he twitter data
    get_similarity_word = GetSimillairWord(twitter_list, ann_list, wiki_vector)
    get_similarity_word.get_proper_noun_word()
    twitter_proper_noun_list = get_similarity_word.twitter_proper_noun_list

    # start multi thread
    producerConsumer = ProducerConsumerThread(twitter_list, ann_list, wiki_vector)
    multi_thread_producer_crawl_instance = threading.Thread(target=producerConsumer.producer_run, args=([twitter_proper_noun_list]))
    multi_thread_producer_crawl_instance.start()
    consumer_name = "producer"
    for index in range(args.consumer_size):
        multi_thread_consumer_crawl_instance = threading.Thread(target=producerConsumer.consumer_run, name=consumer_name + str(index))
        multi_thread_consumer_crawl_instance.start()


