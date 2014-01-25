import pandas as pd
from Py6S import *

def get_stats(col):
	df = pd.read_csv("../results/stats.csv")
	results = []

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


	for i in df.index:
		row = df.ix[i]

		avg_aot = row['avg_aot']
		aots = [avg_aot, avg_aot + row[col], avg_aot - row[col]]
		print aots
		
		for aot in aots:
			if aot < 0.001:
				s.aot550 = 0.001
			else:
				# Set params here
				s.aot550 = aot


			# Run 6S
			radiances = SixSHelpers.Wavelengths.run_landsat_etm(s, output_name='apparent_radiance')

			metadata = [i*10, avg_aot, s.aot550]

			results.append(metadata + list(radiances[1]))

	# Put into a results data frame
	newdf = pd.DataFrame(results, columns=['vis', 'avg_aot', 'aot', 'B1', 'B2', 'B3', 'B4', 'B5', 'B7'])

	# Calculate NDVI
	newdf['ndvi'] = (newdf.B4 - newdf.B3) / (newdf.B4 + newdf.B3)

	# Calculate ARVI
	arvi_red = newdf.B3 - (newdf.B1 - newdf.B3)
	newdf['arvi'] = (newdf.B4 - arvi_red) / (newdf.B4 + arvi_red)

	return newdf

stats_kosch = get_stats('kosch_rmse')
stats_sixs = get_stats('sixs_rmse')
stats_modtran = get_stats('modtran_rmse')
