/* 

STATOR GENERATOR, 2020.
Jackson Walters, adapted from r0gueSch0lar.

A stator is the union of six T-shapes (perp. rec. prisms) and a central collar
(symmetric diff. of two cyls.) intersected with a large cylinder.

*/

pi=3.1415926535897932384626433;

/* symmetric difference of two cylinders - a thick washer */
module collar (col_hgt, col_id, col_od, col_res) {
    difference () {
		cylinder (col_hgt, col_od, col_od, center = true, $fn = col_res);
        /*need to scale height for second cyl due to artifacts*/
		cylinder (col_hgt*1.1, col_id, col_id, center = true, $fn = col_res);
	}
}

/* two perpendicular rectangular prisms, stem & cap - a "T" shape */
module pole (pol_hgt, stm_lgt, stm_wdt, cap_lgt, cap_wdt,) {
	union () {
		translate ([stm_lgt/2, 0, 0]) {
			cube ([stm_lgt, stm_wdt, pol_hgt], center = true);
		}
		translate ([stm_lgt + cap_lgt / 2, 0, 0]) {
			cube ([cap_lgt, cap_wdt, pol_hgt], center = true);
		}
	}
}

/* intersect the union of a collar & six poles with a large cylinder */
module stator (pol_num, stt_hgt, stt_ir, stt_or, pol_rat, cap_rat, stt_res) {
    /* thickness is difference of stator outer and inner diam */
    thickness = stt_or - stt_ir;
    pol_stm_len = stt_or*pol_rat; /* pole stem length is relative to stator outer diam */
    
    /* radius of large cylinder */
    cyl_rad = pol_stm_len + stt_or + thickness;
    
    /*pole params */
    pol_stm_wdt=thickness; /* pole stem width is same as collar thickness */
    pol_cap_lgt=thickness; /* pole cap length is same as collar thickness */
    pol_cap_wdt=(cyl_rad*pi/pol_num)*cap_rat; /* pole cap width is just arc length of big cyl times a ratio */
    
    intersection () {
		/* union of six T-shapes (two perp. rec. prisms) and collar */
        union () {
            /*collar of height=stt_hgt, inner diam=stt_ir, outer diam=stt_or*/
			collar (stt_hgt,stt_ir,stt_or,stt_res);
            
            /*six "T" shaped poles*/
			for (i=[0:pol_num]) {
                /* rotate by 2pi/n where n is number of poles */
				rotate(i*(360/pol_num) ){
					translate ([stt_or*0.98, 0, 0]) {
                        pole (stt_hgt, pol_stm_len, pol_stm_wdt, pol_cap_lgt, pol_cap_wdt);
					}
				}
			}
		}
        /* large, encompassing cylinder */
        cylinder (stt_hgt, cyl_rad*.98, cyl_rad*.98, center = true, $fn = stt_res);
	}
}

/*
This module takes seven parameters:

pol_num = number of poles on stator.
stt_hgt = height of stator laying flat.
stt_ir = inner radius of stator's collar.
stt_or = outer radius of stator's collar.
pol_rat = determines poles length from ratio of stt_or, eg 1.4
cap_rat = determines how wide each poles cap is, eg 0.1-2.0
stat_res = resolution of the cylinders making up the collar.

*/

stator(6, 41.3, 10.6, 12.55, .20, 1.5, 200);