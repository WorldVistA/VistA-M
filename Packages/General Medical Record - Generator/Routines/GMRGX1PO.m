GMRGX1PO ;HIRMFO/RM-POSTINIT FOR PATCH GMRG*3*1 ;5/3/96
 ;;3.0;Text Generator;**1**;Jan 24, 1996
 ; This routine will do the following:
 ;  1)  Kill off the bad DD nodes as described in patch.
 ;  2)  Set the data in the Date Last Updated (6) field of the GMR
 ;      Text (124.3) file.
 ;  3)  Re-indexes the "AC" cross-reference on the Children (124.21)
 ;      sub-file.
 ;  4)  Put the four Nursing options back in order.
 ;
 D EN1^GMRGXUPD,OOS^GMRGX1PR("@")
 Q
