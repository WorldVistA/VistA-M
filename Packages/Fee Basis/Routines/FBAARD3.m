FBAARD3 ;AISC/GRR-VOUCHER AUDIT DELETE REJECTS ENTERED IN ERROR ;3/27/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
POST ;entry point to put dollars back into an authorization on the 1358
 ;if rejected in error
 ;first will locate interface ID from PRC(424,"E",IEN of 161.7)
 ;if interface not exist use old call to POST^FBAASCB
 ;I '$$VER^FBAAUTL1() D POST^FBAASCB Q
 I '$O(^PRC(424,"E",+$G(FBN),0)) D POST^FBAASCB Q
 D ADD^FBAAUTL1 Q
 ;
INPOST ;call to put money back into 1358 for inpatient invoices
 ;call will handle both v4 and v3.6 of ifcap
 ;I $G(FBCNH),'$$VER^FBAAUTL1() D POST^FBAASCB Q
 I FBII78["FB583(" D POST Q
 ;find 7078 entry and build variables needed for call
 I '$D(^FB7078(+FBII78,0)) W !,"No 7078 on file for invoice ",J,".  Could not determine 1358.",! S FBERR=1 Q
 S FBI78=$P(^FB7078(+FBII78,0),"^"),DFN=+$P(^(0),"^",3),FBI78=$P(FZ,"^",8)_"-"_$P(FBI78,".")_"-"_$P(FBI78,".",2) D
 .I $D(FBCNH),'$D(^PRC(424,"E",DFN_";"_+FBII78_";"_FBAAON_";"_FBMM)) D POST Q
 .D INPOST^FBAASCB0:$$INTER^FBAASCB0()
 Q
