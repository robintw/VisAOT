This is the code used to produce the paper 'Are visibility-derived AOT estimates suitable for parameterising satellite data atmospheric correction algorithms?' by Wilson, R.T., Milton, E.J. and Nield, J.

This code is released under the BSD license (see LICENCE.txt), but unfortunately I cannot redistribute the data. The README file in the data directory explains where to acquire the data from.

Once the data has been acquired, load R (preferably using RStudio - it makes it so much nicer!), change to this directory and run:

source('go.r')

This will load the data and configure the environment properly. Then, to reproduce the analyses in the paper, simply source one or more of the files in the `src` folder - all of which have comments explaining what they do.