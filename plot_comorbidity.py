#!/usr/bin/python3
#
#
#

#
# load the necessary modules
#
import pandas as pd
import matplotlib as mlp
import matplotlib.pyplot as plt
import os

#
# loads dataset
#
os.chdir("/Users/darino/Desktop/Anaconda/ics-173-project")
dataframe = pd.read_csv("Comorbidity_SUMMARY.csv", index_col=0)
#DEBUG#  print(dataframe.head(10))

#
# sets the style of the bar chart
#


#
# title
#
#LATER# plt.title('COVID-19 Comorbidity by Race', fontsize=20)


#
# plot a horizontal bar chart
#
fig, ax = plt.subplots()
#OFF#  dataframe = dataframe.sort_values('medcond_ct', ascending=False)
ax.barh(dataframe.index, dataframe['medcond_ct'])

ax.set_title('COVID-19 Comorbidity by Race', fontsize=20, horizontalalignment='right')
ax.set_xlabel('Number of cases with comorbidity')

plt.margins(0.2)
plt.subplots_adjust(bottom=0.15)
plt.tight_layout()
plt.savefig("comorbidity_by_race.png")
plt.show();


# EOF #
