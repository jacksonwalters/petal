/* STATOR GENERATOR, 2020
Jackson Walters, adapted from r0gueSch0lar.

A stator is the union of six T-shapes (perp. rec. prisms) and a central collar
(symmetric diff. of two cyls.) intersected with a large cylinder.

This module takes seven parameters:

pol_num = number of poles on stator.
stt_hgt = height of stator laying flat.
stt_id = inner diameter of stator's collar.
stt_od = outer diameter of stator's collar.
pol_rat = determines poles length from ratio of stt_od, eg 1.4
cap_rat = determines how wide each poles cap is, eg 0.1-2.0
stat_res = resolution of the cylinders making up the collar.

*/

pi=3.1415926535897932384626433;

/*symmetric difference of two cylinders - a thick washer*/
module collar (col_hgt, col_id, col_od, col_res) {
    difference () {
		cylinder (col_hgt, col_od, col_od, center = true, $fn = col_res);
        /*need to scale height for second cyl due to artifacts*/
		cylinder (col_hgt*1.1, col_id, col_id, center = true, $fn = col_res);
	}
}

/*two perpendicular rectangular prisms - a 3d "T" shape*/
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

/*intersect the union of a collar & six poles with a large cylinder*/
module stator (pol_num, stt_hgt, stt_id, stt_od, pol_rat, cap_rat, stt_res) {
    /*radius of large cylinder*/
    cyl_rad = stt_od*(2+pol_rat) - stt_id;
    intersection () {
		/* union of six T-shapes (two perp. rec. prisms) */
        union () {
			collar (stt_hgt,stt_id,stt_od,stt_res);
			for (i=[0:pol_num]) {
				rotate(i*(360/pol_num) ){
					translate ([stt_od*0.98, 0, 0]) {
						pole (stt_hgt, stt_od*pol_rat,stt_od-stt_id,stt_od-stt_id, cyl_rad*pi/pol_num * cap_rat);
					}
				}
			}
		}
        /*large cylinder*/
        cylinder (stt_hgt, cyl_rad*.98, cyl_rad*.98, center = true, $fn = stt_res);
	}
}

// debugging


//collar (20, 40, 60, 200);
//pole (20, 40, 20, 20, 60);
stator (6, 40, 22.2, 32, 1.2, 1.4, 200);