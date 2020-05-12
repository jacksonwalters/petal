include <stat_gen.scad>

/*
To generate your stator please replace the numbers below with the dimensions and measurements you need or copy and paste the module at the bottom without the "//".
*/

pol_num = 6;	//number of stator poles
stt_hgt = 41.3; //height of stator 
stt_id = 21.2; //inner diameter of stators collar
stt_od = 25.1; //outer diameter of stators collar
pol_rat = .25; //determines poles length from ratio of stt_od, eg 1.4
cap_rat = 1.5; //determines how wide each poles cap is, eg 0.1-2.0
stt_res = 400; //resolution of the cylinders making up the collar

stator (pol_num, stt_hgt, stt_id, stt_od, pol_rat, cap_rat,stt_res);

// stator (12, 10, 15, 20, 1.2, 1.5, 200);