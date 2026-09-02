ac simulation of a pmos input single-ended diff pair
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
M13	   2	  3		   dd	 dd		pch		W=6u	  L=0.5u		M=13
M14	   3	  3		   dd	 dd		pch		W=1u	  L=0.15u		M=23
Ib     3      ss       dc=150u
vdd	   dd	  0		   dc=1.2
vss	   ss	  0	       dc=0
cl	   vout	  ss	   1p
vin1  vin+   in	ac=1
vin2  vin-   in	ac=1
vindc	in	ss	dc=0.4
.ac    dec    500      10 	 50g
.option acout=0
.options post=2
.probe vdb(vout,ss)
.probe vp(vout,ss)
*.print v(vout)
.measure ac gain find vdb(vout,ss) at=15
.end