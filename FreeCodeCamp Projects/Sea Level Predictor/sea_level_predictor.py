import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import linregress

def draw_plot():
    # Read data from file
  df = pd.read_csv("epa-sea-level.csv ")
  
    # Create scatter plot
  plt.figure(figsize = (10,7))

  plt.scatter( x = df['Year'], y = df['CSIRO Adjusted Sea Level'], s= 1, c = "b")

  
    # Create first line of best fit

  x = df['Year']
  y = df['CSIRO Adjusted Sea Level'] 

  results = linregress(x, y)
  x_value = pd.Series([i for in range(1880, 2051)])
  y_predicted = results.slope*x_value + results.intercept
  plt.plot(x_value, y_predicted, "r")

  

    # Create second line of best fit

  df_2000 = df[  df['Year' ] >= 2000]
  x1 = df_2000['Year']
  y1 = df_2000['CSIRO Adjusted Sea Level'] 

  results2 = linregress(x1, y1)
  x1_value = pd.Series([i for i in range(1880,2051)])
  y1_predicted = results2.slope*x1_value + results2.intercept
  plt.plot(x1_value, y1_predicted, "b")

  plt.title("Rise in Sea Level", fontsize = 12, color = "k")
  plt.xlabel("Year")
  plt.ylabel(" Sea Level")


    # Add labels and title

  plt.title("Rise in Sea Level", fontsize = 12, color = "k")
  plt.xlabel("Year")
  plt.ylabel("Sea Level (inches)")


    
    # Save plot and return data for testing (DO NOT MODIFY)
    plt.savefig('sea_level_plot.png')
    return plt.gca()