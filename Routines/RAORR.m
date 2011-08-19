RAORR ;HISC/CAH,FPT,GJC AISC/DMK-OE/RR driver ;2/2/98  14:43
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;OE/RR Utility routine for Rad/Nuc Med
 Q:'$D(ORACTION)
 I $$ORVR^RAORDU()'=2.5!(ORACTION="")!("012345678"'[ORACTION) Q
 D @ORACTION
 Q
0 ;Adding new order
 I '$D(ORGY) K RAPKG D ENADD^RAORD1 K RADR1 Q
 I ORGY=0 K RAPKG D ENADD^RAORD1 K RADR1 Q  ;new order
 I ORGY=9 S ORETURN("ORSTS")=5 D ^RAORR1 Q  ;If released & pending
 I ORGY=10 D ^RAORR2 ;verify a signed order
 Q
1 ;Edit order
 I $D(ORPRES),+ORPRES=6 G ^RAORR1
 I $D(ORSTS),ORSTS=11 G ^RAORR1 ;If unreleased
 D NO
 W !,"Cannot edit a Radiology/Nuclear Medicine order once released."
 W !,"To change the order, discontinue the current order and add a"
 W !,"new one.",!
 Q
2 ;RENEW ORDERS
 D NO
 Q
3 ;Flag orders
 D NO
 Q
4 ;Hold orders
 D NO
 W !,"Holding requests is reserved for Radiology/Nuclear Medicine personnel.",!
 Q  ;not used
5 ;Event processor
 D NO
 Q
6 ;Discontinue order
 ; if new order and unreleased, delete entries from Rad/Nuc Med & OE/RR
 ; Orders files.
 N RAXIT S RAXIT=0
 I ORGY=0,ORSTS=11 D CHECK^RAORD Q:OREND  S RAORDS(1)=+ORPK D ENCAN^RAORD Q
 I ORGY=0 D CHECK^RAORD Q:OREND  D REASON^RAORD Q:RAXIT!(+$G(OREND))  D DC^ORX5 Q
 I ORGY=10 D CHECK^RAORD Q
 I ORGY=9 S RAORDS(1)=+ORPK D ENCAN^RAORD Q
 Q
7 ;Purge order
 K RAPKG D ENPUR^RAPURGE1
 Q
8 ;Print order
 K RAPKG D ENDIS^RAORD2 Q
 Q
NO W !,"This action is inappropriate for this order.",!
 Q
