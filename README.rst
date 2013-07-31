Pipelines for ChipSeq analysis
=============================

:Author: Gina Turco (`gturco <https://github.com/gturco>`_)
:Email: gturco88@gmail.com
:License: MIT
.. contents ::

Description
===========

Contains a general pipeline for running ChipSeq analysis. This involves converting a sequence read archive file (sra) to a fastaq file. The Fastq file is then aligned to a reference genome and count data is obtained. Last but not least, comparisons between different groups of count data can be made with SICER for enrichment. For example differential expression between histone methlyation mark read counts of knockout and wild type can be compared.

Pipelines were developed in the `Brady Lab <http://www-plb.ucdavis.edu/labs/brady/>`_ at UC Davis

Installation
============

  - Download the most recent code here::
              
          git clone git@github.com:BradyLab/ChipSeq.git

**Required Dependencies**

  - Dependencies were installed onto iplant AMI "ChipSeq" and are available through `atmosphere <https://atmo.iplantcollaborative.org/application/>`_  with install instructions `here <https://github.com/BradyLab/atmosphere_images/blob/master/ChipSeq.md>`_
  - Requires bwa,  samtools, pysam, htseq, SICER, MACS, python2.7

