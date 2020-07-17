/* 
           _________________________________________________
           |*************** Stator Generator ***************|   
           *************************************************
           **************** By r0gueSch0lar ***************
           |*************techebob@gmail.com*************|
           _________________________________________________
                                             2013



This module takes seven parameters, which are:

pol_num = number of poles on stator.
stt_hgt = height of stator laying flat.
stt_id = inner diameter of stator's collar.
stt_od = outer diameter of stator's collar.
pol_rat = determines poles length from ratio of stt_od, eg 1.4
cap_rat = determines how wide each poles cap is, eg 0.1-2.0
stat_res = resolution of the cylinders making up the collar.



An example .scad file has been provided for you to play around with (example_0.3.scad). There are also lines commented out with "//" that color the modules and primitives used and can aid in modifying the script by identifying the corrosponding primitives. 

______________________________________________________________
|*************************************************************|
**************************************************************
********************* LEGAL DISCLAIMER *********************
**************************************************************
**************************************************************



THIS SCRIPT IS PROVIDED BY R0GUESCH0LAR ''AS IS'' AND ANY
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL R0GUESCH0LAR BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SCRIPT, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.



______________________________________________________________
**************************************************************
--------------------------------------------------------------------------------------
*/



module collar (col_hgt, col_id, col_od, col_res) {

difference () {
		cylinder (col_hgt, col_od/2, col_od/2, $fn = col_res, center = true);
		translate ([0,0,col_hgt*0.4]) {
			cylinder (col_hgt*2, col_id/2, col_id/2, $fn = col_res, center = true);
		}
	}
}

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

module stator (pol_num, stt_hgt, stt_id, stt_od, pol_rat, cap_rat, stt_res) {
	intersection () {
		union () {
			collar (stt_hgt, stt_id, stt_od, stt_res);
			for (i=[0:pol_num]) {
				rotate (i * 360 / pol_num) {
					translate ([(stt_od/2) * 0.98, 0, 0]) {
						pole (stt_hgt, (stt_od/2) * pol_rat, (stt_od/2) - (stt_id/2), (stt_od/2) - (stt_id/2), (stt_od/2 + ((stt_od/2) * pol_rat) + (stt_od/2) - (stt_id/2)) * 3.14 / pol_num * cap_rat);
					}
				}
			}
		}
            cylinder (stt_hgt, ((stt_od/2) + ((stt_od/2) * pol_rat) + (stt_od/2) - (stt_id/2)) * 0.98, ((stt_od/2) + ((stt_od/2) * pol_rat) + (stt_od/2) - (stt_id/2)) * 0.98, center = true, $fn = stt_res);
	}
}

// debugging


//collar (20, 40, 60, 200);
//pole (20, 40, 20, 20, 60);
stator (6, 30, 22, 30, 1.2, 1.4, 200);