dc simulation of a pmos input single-ended diff pair
.lib './TSMC_90nm.l' TT
M1     4      vin-     2     dd     pch     W=2.1u  L=0.15u       M=2
M2     5      vin+     2     dd     pch     W=2.1u  L=0.15u       M=2
M3     vout   vin-     2     dd     pch     W=2.1u  L=0.15u       M=2
M4     1      vin+     2     dd     pch     W=2.1u  L=0.15u       M=2
M5     4      4        ss    ss     nch     W=0.7u  L=0.15u		M=1
M6     5      5        ss    ss     nch     W=0.7u  L=0.15u		M=1
M7	   4	  5	  	   ss	 ss		nch		W=0.4u	  L=0.15u		M=1
M8	   5	  4	  	   ss	 ss		nch		W=0.4u	  L=0.15u		M=1
M9	   1	  4		   ss	 ss		nch		W=2.64u	  L=0.25u		M=2
M10	   vout	  5		   ss	 ss		nch		W=2.64u	  L=0.25u		M=2
M11	   1	  1		   dd	 dd		pch		W=5.8u	  L=0.25u		M=2
M12	   vout	  1		   dd	 dd		pch		W=6.8u	  L=0.25u		M=2
M13	   2	  3		   dd	 dd		pch		W=5u	  L=0.5u		M=13
M14	   3	  3		   dd	 dd		pch		W=1u	  L=0.15u		M=23
Ib     3      ss       dc=150u
vdd	   dd	  0		   dc=1.2
vss	   ss	  0	       dc=0
cl	   vout	  ss	   1p
CH im0 vin- 1p
g1 input im0 vcr pwl(1) ph1 0 0.0v,10meg 1.2v,10
g2 im0 vout vcr pwl(1) ph2 0 0.0v,10meg 1.2v,10
g3 vin- vout vcr pwl(1) ph1 0 0.0v,10meg 1.2v,10
vph1 ph1 0 pulse(0 1.2 0.7n 0.2n 0.2n 9.1n 20n)
vph2 ph2 0 pulse(1.2 0 0 0.2n 0.2n 10.5n 20n)
vin input 0 pulse(0.45 0.75 0 0.2n 0.2n 10n 20n)
vcmi vin+ 0 dc=0.4
.option accurate=1	delmax=100p
.options post=2
.tran 0.001n 70n
*.probe
.end