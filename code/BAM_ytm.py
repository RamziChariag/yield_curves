# import packages
import pandas as pd
import numpy as np
import datetime as dt
import numpy as np
import os

print(os.getcwd())

# Paths 
data_folder = "../data/"
output_folder = "../output/"

# Load data
yield_curve_parameters = pd.read_excel(data_folder + "RS Yield Curve Parameters.xlsx")

# Maturities in days
maturities = [1, 30, 90, 180, 270, 360, 540, 720, 1080, 1440, 1800, 2160, 2520, 2880, 3240, 3600, 5400, 7200]

data = yield_curve_parameters.copy()
data.drop('YieldCurveCode', axis=1, inplace=True)

# Apply formula taking m as residual maturity
output = pd.DataFrame()
output['t'] = data ['TradingDate']
for m in maturities:
    output [str(m)] = data ['Beta0'] + \
        data ['Beta1'] * ((1-np.exp(-m/data ['Tau1']))/(m/data ['Tau1'])) + \
        data ['Beta2'] * ((1-np.exp(-m/data ['Tau1']))/(m/data ['Tau1']) - np.exp(-m/data ['Tau1'])) + \
        data ['Beta3'] * ((1-np.exp(-m/data ['Tau2']))/(m/data ['Tau2'])-np.exp(-m/data ['Tau2'])) 
    
# Save file as:
filename = 'YTM_t by maturity.csv'

output.to_csv(output_folder + filename, index=False)