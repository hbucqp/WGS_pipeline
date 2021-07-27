#!/usr/bin/env python
#-*- coding:utf-8 -*-

#############################################
# File Name: setup.py
# Author: mage
# Mail: hbucqp1991@sina.cn
# Created Time:  2021-7-26 19:17:34
#############################################


from setuptools import setup, find_packages

setup(
    name="WGS_pipeline",
    version="0.1.0",
    keywords=("pip", "wgs", "biosample", "resfinder"),
    description="wgs data tidy",
    long_description="wgs data tidy(biosample_download, resfinder_sum)",
    license="MIT Licence",

    url="https://github.com/fengmm521/pipProject",
    author="Qingpo",
    author_email="hbucqp1991@sina.cn",

    packages=find_packages(),
    include_package_data=True,
    platforms="any",
    install_requires=[pandas, numpy, os, re, argparse, subprocess]
)
