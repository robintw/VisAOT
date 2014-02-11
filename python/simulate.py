import pandas as pd
from Py6S import *

# def get_stats(col):
# 	df = pd.read_csv("../results/stats.csv")
# 	results = []

# 	s = SixS()
# 	s.atmos_profile = AtmosProfile.PredefinedType(AtmosProfile.MidlatitudeSummer)
# 	s.aero_profile = AeroProfile.PredefinedType(AeroProfile.Maritime)
# 	s.geometry.solar_a = 98.16
# 	s.geometry.solar_z = 12.1
# 	s.geometry.view_a = 98.16
# 	s.geometry.view_z = 0
# 	s.geometry.month = 7
# 	s.geometry.day = 14
# 	s.altitudes.set_sensor_satellite_level()
# 	s.altitudes.set_target_sea_level()

# 	s.ground_reflectance = GroundReflectance.HomogeneousLambertian(GroundReflectance.GreenVegetation)


# 	for i in df.index:
# 		row = df.ix[i]

# 		avg_aot = row['avg_aot']
# 		aots = [avg_aot, avg_aot + row[col], avg_aot - row[col]]
# 		print aots
		
# 		for aot in aots:
# 			if aot < 0.001:
# 				s.aot550 = 0.001
# 			else:
# 				# Set params here
# 				s.aot550 = aot


# 			# Run 6S
# 			radiances = SixSHelpers.Wavelengths.run_landsat_etm(s, output_name='apparent_radiance')

# 			metadata = [i*10, avg_aot, s.aot550]

# 			results.append(metadata + list(radiances[1]))

# 	# Put into a results data frame
# 	newdf = pd.DataFrame(results, columns=['vis', 'avg_aot', 'aot', 'B1', 'B2', 'B3', 'B4', 'B5', 'B7'])

# 	# Calculate NDVI
# 	newdf['ndvi'] = (newdf.B4 - newdf.B3) / (newdf.B4 + newdf.B3)

# 	# Calculate ARVI
# 	arvi_red = newdf.B3 - (newdf.B1 - newdf.B3)
# 	newdf['arvi'] = (newdf.B4 - arvi_red) / (newdf.B4 + arvi_red)

# 	return newdf

# stats_kosch = get_stats('kosch_rmse')
# stats_sixs = get_stats('sixs_rmse')
# stats_modtran = get_stats('modtran_rmse')


results = []

print "Hello!"

s = SixS()
s.atmos_profile = AtmosProfile.PredefinedType(AtmosProfile.MidlatitudeSummer)
s.aero_profile = AeroProfile.PredefinedType(AeroProfile.Maritime)
s.geometry.solar_a = 98.16
s.geometry.solar_z = 12.1
s.geometry.view_a = 98.16
s.geometry.view_z = 0
s.geometry.month = 7
s.geometry.day = 14
s.altitudes.set_sensor_satellite_level()
s.altitudes.set_target_sea_level()

s.ground_reflectance = GroundReflectance.HomogeneousLambertian(GroundReflectance.GreenVegetation)

errors = [0.05, 1.05, 0.76, 0.19, 0.12, 0.08, 0.07]
aots = [0.1, 0.38, 0.38, 0.25, 0.18, 0.13, 0.10]

print "Starting loop"

for error, given_aot in zip(errors, aots):
	aots = [given_aot, given_aot+error, given_aot-error]
	print aots
	for aot in aots:
		if aot < 0.001:
			s.aot550 = 0.001
		else:
			# Set params here
			s.aot550 = aot

		print aot

		# Run 6S
		radiances = SixSHelpers.Wavelengths.run_landsat_etm(s, output_name='apparent_radiance')

		metadata = [given_aot, s.aot550]

		results.append(metadata + list(radiances[1]))

# Put into a results data frame
newdf = pd.DataFrame(results, columns=['avg_aot', 'aot', 'B1', 'B2', 'B3', 'B4', 'B5', 'B7'])

# Calculate NDVI
newdf['ndvi'] = (newdf.B4 - newdf.B3) / (newdf.B4 + newdf.B3)

# Calculate ARVI
arvi_red = newdf.B3 - (newdf.B1 - newdf.B3)
newdf['arvi'] = (newdf.B4 - arvi_red) / (newdf.B4 + arvi_red)

df = newdf.copy()

indices = np.where(df.avg_aot == df.aot)

for i in indices[0]:
	res = df.ix[i+1] - df.ix[i]
	print res
	df.ix[i+1] = res
	df.ix[i+2] = df.ix[i+2] - df.ix[i]