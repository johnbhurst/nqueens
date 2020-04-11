# Copyright 2020 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2020-04-11

#%% Initialise and load data

import numpy
import os
import pandas
import sys

infile = "../all.csv"

df = pandas.read_csv(infile, index_col="N")
key = lambda col: - df.loc[15][col]
obs = sorted((column for column in df.columns if column != "N"), key=key)

# %% Plot data

df.plot(kind="line", y=obs, logy=True)
