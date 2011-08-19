PSXLBL2 ;BIR/HTW,BAB-CMOP Host Print Labels ;[ 12/18/97  12:48 PM ]
 ;;2.0;CMOP;**1,10**;11 Apr 97
 N I
L1 W ?3,"VAMC ",SCITY,", ",SSTATE,"  ",SZIP
 W ?54,"VAMC ",SCITY,", ",SSTATE,"  ",SZIP
 I $G(REPRINT) W ?102,"(REPRINT)"
L2 W !,?3,SITE,"  ",STEL,"   ",CLKRPH
 W ?54,SITE,"  ",STEL,"   ",CLKRPH
 D NOW^%DTC S Y=% X ^DD("DD") S RNOW=$P(Y,":",1,2) K X,Y,%
 W ?102,SITE," ",CLKRPH," ",RNOW
L3 W !,RX,"  ",FDT,"  Fill ",RFTXT
 W ?54,RX,"  ",FDT,"  Fill ",RFTXT
 W ?102,RX,"  ",FDT,"  Fill ",RFTXT
L4 W !,PNAME,"  ",$P(SSN,"-",2,3),?54,PNAME,"  ",$P(SSN,"-",2,3),?102,PNAME,"  ",$P(SSN,"-",2,3)
 ;    SIG
 S SC=4
 W !
 F I=1:1:SIGN W $G(SIG(I)),?54,$G(SIG(I)),?102,$G(SIG(I)) S SC=SC+1 D
 .I $D(SIG(I+1)),(I#3=0) W @IOF S SC=0 Q
 .I '$D(SIG(I+1)) Q
 .W !
 S SC=7-SC F ZP=1:1:SC W !
L8 W !,$G(PHYS),?54,$G(PHYS),?102,$G(PHYS)
 W !,"Qty: "_$G(QTY)_"  "_$G(VADU)_"  "_$G(NURSE)
 W ?54,"Qty: "_$G(QTY)_"  "_$G(VADU)_"  "_$G(NURSE)
 W ?102,"Qty: "_$G(QTY)_"  "_$G(VADU)_"  "_$G(NURSE)
 K NURSE,VADU,ZP,SC
L10 W !,TRUG,?54,TRUG,?102,TRUG
 I REFREM'>0 D TOP^PSXLBLNR G L13
 S X1=EXPDT1,Y=ISD1,X2=DT D ^%DTC I X<30 G L11
 W !,?54,REFREM," Refills remain prior to ",$G(EXPDT),?102,"Mfg ________ Lot# ________" G L12
L11 W !,?54,"Last fill prior to ",$G(EXPDT),?102,"Mfg ________ Lot# ________"
L12 W !,SADD1,?54,COPAY,"     Days Supply: ",$G(TAYS),?102,"Tech__________RPh_________"
 W !,SCITY,", ",SSTATE,"  ",SZIP
 I $G(PSXBAR) S X="S",X2=BAR S X1=$X W ?54,@IOBARON,X2,@IOBAROFF,*13
 I '$G(PSXBAR) W !!!
 W !,"FORWARDING SERVICE REQUESTED"
 W:($G(REGMAIL)=1) !,?21,"CERTIFIED MAIL"
 W !,?54,$G(PADD1)
 W !,"***CRITICAL MEDICAL SHIPMENT***",?54,$G(PADD2),?102,"Routing: "_$S($G(REGMAIL)=1:"CERTIFIED",1:"REGULAR")_" MAIL"
 W !,?54,$G(PADD3),?102,"Days supply: ",$G(TAYS)," Cap: ",$S($G(CAP):"**NON-SFTY**",1:"SAFETY")
 W !,?54,$G(PADD4),?102,"Isd: ",$G(ISD)," Exp: ",$G(EXPDT)
 W !,PNAME,?54,"*Indicate address change on back of this form",?102,"Last Fill: ",$G(REFLST)
 W !,PADD1,?54,"[ ] Permanent",?102,"Pat. Stat ",PSTAT," Clinic: ",CLINIC
 W !,$G(PADD2),?54,"[ ] Temporary until ",$S($G(PTEMP)]"":PTEMP,1:"__/__/__")
 W ?102,$S($G(WARN)'="":"DRUG WARNING "_$G(WARN),1:"")
 W !,$G(PADD3)
 W !,$G(PADD4),?54,"Signature__________________________________"
 I $G(PSXBAR) S X="S",X2=BAR S X1=$X W ?102,@IOBARON,X2,@IOBAROFF,*13
L13 W @IOF
 ;  PRINT DRUG WARNING
 I $G(WARN)]"" D  W @IOF
 .W ?54,PNAME
 .W !,?54,"Rx# ",RX
 .W !,?54,TRUG
 .W !,?54,"DRUG WARNING:"
 .F W=1:1 S W1=$P(WARN,",",W) Q:W1']""  D
 ..Q:'$D(^PS(54,W1,0))
 ..F W2=0:0 S W2=$O(^PS(54,W1,1,W2)) Q:'W2  D
 ...S W3=^PS(54,W1,1,W2,0) W !,?54,W3
 K W,W1,W2,W3,X
UPDATE ;  UPDATE 552.3
 D NOW^%DTC
 I $G(REPRINT)!($G(PSXBLR)) D
 .F UX=0:0 S UX=$O(^PSX(552.3,UX)) Q:'UX!($G(UXOUT))  S UXN=$G(^(UX,0)) D
 ..I $P(UXN,B,2)[BATREF,($P(UXN,B,3)=RX) S $P(^PSX(552.3,UX,0),B,5)=%,UXOUT=1
 I $G(UXOUT) K UXOUT,UXN,UX Q
ADD L +(^PSX(552.3,0)):DTIME
 S CNT=$P(^PSX(552.3,0),"^",3),CNT=CNT+1
 S CNT4=$P(^PSX(552.3,0),"^",4),CNT4=CNT4+1
AD1 I $D(^PSX(552.3,CNT)) S CNT=CNT+1,CNT4=CNT4+1 G AD1
 L +^PSX(552.3,CNT):1 I '$T G AD1
 S $P(^PSX(552.3,0),"^",3)=CNT,$P(^PSX(552.3,0),"^",4)=CNT4
 S ^PSX(552.3,CNT,0)="ZMP|"_BATREF_B_RX_B_BAR_B_%_B_DUZ
 S ^PSX(552.3,"AP",BAR,CNT)=""
 L -(^PSX(552.3,0),^PSX(552.3,CNT))
 K CNT,CNT4,%,%I,X,UX,UXOUT,UXN
 Q
