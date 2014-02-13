The data used in this paper cannot be distributed with the code for licensing and access reasons.

To run the code you will need to get:

1. AERONET data:
The data for the Chilbolton station, placed in AERONET/lev10 AERONET/lev15 and AERONET/lev20 for the Level 1.0, 1.5 and 2.0 data respectively. This data can be freely downloaded from http://aeronet.gsfc.nasa.gov

2. Chilbolton Present Weather Detector data
This must be downloaded and placed in the PWD folder. This data can be obtained from the BADC at http://badc.nerc.ac.uk/data/chilbolton/ after registration.

3. Met Office data
This should be downloaded and placed in the MetOffice folder, as a CSV file (with all of the default columns etc). This can also be obtained from the BADC, through the MIDAS system - see http://badc.nerc.ac.uk/data/ukmo-midas/, after registration. The data needed is for the Middle Wallop station (src_id = 847), at hourly intervals, and should be saved as a CSV file called `MetoData_2003_2013.csv` with the following column headers:

ob_time, id, id_type, met_domain_name, version_num, src_id, rec_st_ind, wind_speed_unit_id, src_opr_type, wind_direction, wind_speed, prst_wx_id, past_wx_id_1, past_wx_id_2, cld_ttl_amt_id, low_cld_type_id, med_cld_type_id, hi_cld_type_id, cld_base_amt_id, cld_base_ht, visibility, msl_pressure, cld_amt_id_1, cloud_type_id_1, cld_base_ht_id_1, cld_amt_id_2, cloud_type_id_2, cld_base_ht_id_2, cld_amt_id_3, cloud_type_id_3, cld_base_ht_id_3, cld_amt_id_4, cloud_type_id_4, cld_base_ht_id_4, vert_vsby, air_temperature, dewpoint, wetb_temp, stn_pres, alt_pres, ground_state_id, q10mnt_mxgst_spd, cavok_flag, cs_hr_sun_dur, wmo_hr_sun_dur, wind_direction_q, wind_speed_q, prst_wx_id_q, past_wx_id_1_q, past_wx_id_2_q, cld_ttl_amt_id_q, low_cld_type_id_q, med_cld_type_id_q, hi_cld_type_id_q, cld_base_amt_id_q, cld_base_ht_q, visibility_q, msl_pressure_q, air_temperature_q, dewpoint_q, wetb_temp_q, ground_state_id_q, cld_amt_id_1_q, cloud_type_id_1_q, cld_base_ht_id_1_q, cld_amt_id_2_q, cloud_type_id_2_q, cld_base_ht_id_2_q, cld_amt_id_3_q, cloud_type_id_3_q, cld_base_ht_id_3_q, cld_amt_id_4_q, cloud_type_id_4_q, cld_base_ht_id_4_q, vert_vsby_q, stn_pres_q, alt_pres_q, q10mnt_mxgst_spd_q, cs_hr_sun_dur_q, wmo_hr_sun_dur_q, meto_stmp_time, midas_stmp_etime, wind_direction_j, wind_speed_j, prst_wx_id_j, past_wx_id_1_j, past_wx_id_2_j, cld_amt_id_j, cld_ht_j, visibility_j, msl_pressure_j, air_temperature_j, dewpoint_j, wetb_temp_j, vert_vsby_j, stn_pres_j, alt_pres_j, q10mnt_mxgst_spd_j, rltv_hum, rltv_hum_j, snow_depth, snow_depth_q, drv_hr_sun_dur, drv_hr_sun_dur_q

