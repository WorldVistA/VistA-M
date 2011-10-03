PSXLBLNR ;BIR/HTW,BAB-CMOP Labels-Non Refillable ;[ 12/18/97  12:48 PM ]
 ;;2.0;CMOP;**1,10**;11 Apr 97
TOP W !,?54,COPAY,"     Days Supply: ",$G(TAYS),?102,"Mfg ________ Lot# ________"
 W !,SADD1,?102,"Tech__________RPh__________"
 W !,SCITY,", ",SSTATE,"  ",SZIP
 I $G(PSXBAR) S X="S",X2=BAR S X1=$X W ?54,@IOBARON,X2,@IOBAROFF,*13
 E  W !!!!
 W "FORWARDING SERVICE REQUESTED"
 I '$G(RENW) G NORENEW
NOREFILL ;NO REFILLS REMAIN PRINT SECTION
 W ?54,"* NO REFILLS REMAINING ** PHYSICIAN USE ONLY *"
 W ! I $G(REGMAIL)=1 W ?21,"CERTIFIED MAIL"
 W ?54,"*Signature:____________________________SC NSC*"
 W !,?54,"*Print Name:_________________________________*"
 W !,"***CRITICAL MEDICAL SHIPMENT***"
 W ?54,"*DEA or VA#_________________Date_____________*"
 W ?102,"Routing: MAIL"
 W !,?54,"*Refills: 0 1 2 3 4 5 7 8 9 10 11          *"
 W ?99,"*",?102,"Days Supply: ",$G(TAYS)," Cap: ",$S($G(CAP):"**NON-SAFETY**",1:"SAFETY")
 W !,?54,"***** To be filled in VA Pharmacies only *****"
 W ?102,"Isd: ",$G(ISD)," Exp: ",$G(EXPDT)
 W !,PNAME,?54,$G(PADD1),?102,"Last fill: ",$G(REFLST)
 W !,$G(PADD1),?54,$G(PADD2),?102,"Pat. St ",PSTAT," Clinic: ",CLINIC
 W !,$G(PADD2),?54,$G(PADD3),?102,$S($G(WARN)'="":"DRUG WARNING "_$G(WARN),1:"")
 W !,$G(PADD3),?54,$G(PADD4)
 W !,$G(PADD4),?54,"*Indicate address change on back of this form"
 W !,?54,"[ ] Permanent [ ] Temporary until ",$S($G(PTEMP)]"":PTEMP,1:"__/__/__")
BAR I $G(PSXBAR) S X="S",X2=BAR,X1=$X W ?102,@IOBARON,X2,@IOBAROFF,*13
 Q
NORENEW W ?54,"*** This prescription CANNOT be renewed ***"
 W !?21,$S($G(REGMAIL)=1:"CERTIFIED MAIL",1:""),?54,"*",?96,"*"
 W !,?54,"*     A NEW PRESCRIPTION IS REQUIRED      *"
 W !,"***CRITICAL MEDICAL SHIPMENT***",?54,"*",?96,"*"
 W !,?54,"***** Please contact your physician *******"
 W !,?54,$G(PADD1),?102,"Routing: MAIL"
 W !,?54,PADD2,?102,"Days Supply: ",$G(TAYS)," Cap: ",$S($G(CAP):"**NON-SFTY**",1:"SAFETY")
 W !,PNAME,?54,$G(PADD3),?102,"Isd: ",$G(ISD)," Exp: ",$G(EXPDT)
 W !,PADD1,?54,$G(PADD4),?102,"Last Fill: ",$G(REFLST)
 W !,PADD2,?54,"*Indicate address change on back of this form",?102,"Pat. Stat ",PSTAT," Clinic: ",CLINIC
 W !,$G(PADD3),?54,"[ ] Permanent [ ] Temporary until ",$S($G(PTEMP)]"":PTEMP,1:"__/__/__")
 W ?102,$S($G(WARN)'="":"DRUG WARNING "_$G(WARN),1:"")
 W !,$G(PADD4)
 I $G(PSXBAR) S X="S",X2=BAR,X1=$X W ?102,@IOBARON,X2,@IOBAROFF,*13
 Q
