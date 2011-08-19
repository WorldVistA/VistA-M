PRS8AC ;HISC/MRL-DECOMPOSITION, ACTIVITY STRING ;03/26/08
 ;;4.0;PAID;**40,45,54,52,69,75,90,96,112,117,125**;Sep 21, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;The primary purpose of this routine is to create the activity
 ;string [the "W" node] for each day of activity.  While creating
 ;this string certain counts will also be tallied.  These include
 ;Standby, On-Call and the various absence categories.  Actual
 ;Call Back hrs are also counted in this routine for the purpose
 ;of reducing the OC later on in the process.
 ;
 ;Called by Routines:  PRS8EX, PRS8ST.
 ;
 Q:VAR=""
 I $S($P(V,"^",1)="":1,$P(V,"^",2)="":1,1:0) Q  ;no times
 S Q=0
 I DY>0,DY<15 D  G END:Q
 .I DAY(DY,"OFF"),"LSWARUHFGDrZq"[VAR S Q=1 ;exc invalid day off VAR
 K OC,FLAG
 ;
 S DAYZ=DAY(DY,"W")_$G(DAY(DY,"N")),MTM=0
 S DAYH=$G(DAY(DY,"HOL"))_$G(DAY(DY+1,"HOL")) ;holiday node
 N DAYR
 S DAYR=DAY(DY,"r")_$G(DAY(DY,"rN")) ; Recess
 ;
 ;P 45 FIREFIGHTERS F NODE TO TRACK ADDITIONAL FF HRS
 S DAYF=$G(DAY(DY,"F"))
 ;
 F T=+V:1:+$P(V,"^",2) D
 .I +VAR,$E(DAYH,T),$E(DAYZ,T)?1A Q  ;no override holiday
 .; Don't override Recess but allow Unscheduled Regular (VAR=4)
 .I +VAR,VAR'=4,$E(DAYR,T)="r" Q  ; don't override Recess
 .I VAR="A"&(JURY=1) S VAR="J"
 .S VAR1=VAR Q:VAR1=""  S DAYZ(1)=$E(DAYZ,T)
 .I "HhJLSARWMNUnVXYTFGDZq"[VAR1,$E(DAYZ,T)="m" Q
 .I T=+V,"12345E"[VAR1 S DAY(DY,"DWK")=1 ;count days worked
 .I T=+V,"Vh"[VAR1,TYP["I" S DAY(DY,"DWK")=1 ;count days worked for cop
 .I "JLSWNnARUXYFGDZq"[VAR1,T'>96,'$E(DAYZ,T) Q  ;invalid outside tour
 .; Regular employees can't earn ct/use ot during work
 .I +NAWS'=9,"EOPQT4"[VAR1,T'>96,$E(DAYZ,T) Q
 .; 9mo AWS checks
 .I +NAWS=9,"PQT"[VAR1,T'>96,$E(DAYZ,T) Q  ;can't earn ct/use ot during work
 .; Allow CT/OT/UN/ON if posted over Recess otherwise don't allow
 .I +NAWS=9,"4OECQ"[VAR1,T'>96,$E(DAYZ,T),$E(DAYR,T)'="r" S $E(DAYR,T)=VAR1 Q
 .I "OE"[VAR1,"BC"[DAYZ(1),$L(DAYZ(1)) D  ; Change OT or CT to CB/SB OT
 ..S VAR1=$C($A($E(DAYZ,T))+32)
 ..I $E(DAYZ,T)="C",VAR="E" S VAR1="t" ; Comp time on on-call = "t"
 .I "BC"[VAR1,DAYZ(1)="O",$L(DAYZ(1)) D  ; Change CB/SB to CB/SB OT
 ..S VAR1=$C($A($E(VAR1))+32)
 .I "Hh"[VAR1 D  Q:VAR1="H"
 ..S DAYH=$E(DAYH,0,T-1)_$S(VAR1="H":1,$E(DAYZ,T)&($E(DAYZ,T)'=4)!(TYP["I")!(TYP["P"&(TYP["N"!(TYP["H")))!(VAR1="h"):2,1:0)_$E(DAYH,T+1,999) ;holiday node
 ..I VAR1="h" S VAR1="O" ;convert HW to OT
 ..I VAR="h",$E(DAYZ,T)=5 S FLAG=5
 .I $E(DAYZ,T)=5,"ALSRUFGDZq"[VAR1 S VAR1=$E(DAYZ,T)
 .I $E(DAYZ,T)="-","BbCctes"[VAR1 Q  ;unavail for oc/sb or sch ot/ct
 .;
 .I VAR'="r" D
 ..S DAYZ=$E(DAYZ,0,T-1)_VAR1_$E(DAYZ,T+1,999)
 ..I $E($G(DAY(DY-1,"N")),T)'="",VAR1'=$E($G(DAY(DY-1,"N")),T) D
 ...S DAY(DY-1,"N")=$E(DAY(DY-1,"N"),0,T-1)_VAR1_$E(DAY(DY-1,"N"),T+1,999) ;save VAR
 ..; When processing tour time also copy tour into DAYR
 ..I "1235"[VAR1 D
 ...S DAYR=$E(DAYZ,0,T-1)_VAR1_$E(DAYZ,T+1,999)
 ...I $E($G(DAY(DY-1,"N")),T)'="",VAR1'=$E($G(DAY(DY-1,"N")),T) D
 ....S DAY(DY-1,"rN")=$E(DAY(DY-1,"rN"),0,T-1)_VAR1_$E(DAY(DY-1,"rN"),T+1,999)
 .;
 .; The following check will record Recess and will then update VAR1 to 0 which
 .; will result in the normally scheduled tour being marked as being no tour.
 .; This will allow Unscheduled Regular, OT and CT to be posted over the tour.
 .I VAR="r" D
 ..S DAYR=$E(DAYR,0,T-1)_VAR1_$E(DAYR,T+1,999)
 ..S DAYZ=$E(DAYZ,0,T-1)_0_$E(DAYZ,T+1,999) ; Overwrite tour
 ..I $E($G(DAY(DY-1,"rN")),T)'="",VAR1'=$E($G(DAY(DY-1,"rN")),T) D
 ...S DAY(DY-1,"rN")=$E(DAY(DY-1,"rN"),0,T-1)_VAR1_$E(DAY(DY-1,"rN"),T+1,999)
 ...S DAY(DY-1,"N")=$E(DAY(DY-1,"N"),0,T-1)_0_$E(DAY(DY-1,"N"),T+1,999)
 ..S Y=48 D SET ; Count Recess
 .;
 .I VAR1="J" S Y=5 D SET ;set authorized absence for jury duty
 .I VAR1="M" S Y=5 D SET ; authorized absence for ML
 .;ot on non-premium T&L
 .I ("Eocb"[VAR1!(VAR1="O"&'$E(DAYH,T)))&("^^10^11^12^13^15^16^17^"[("^"_$P(V,"^",4)_"^"))!(VAR1=5&("ALSRUFGDZq"[VAR))!(VAR1=4&(TYP["P"!(TYP["I"&(TYP["N"!(TYP["H"!($$HYBRID^PRSAENT1($G(DFN)))))))&("^7^9^11^12^14^17^"[("^"_$P(V,"^",4)_"^"))) D
 ..Q:$E(DAY(DY,"P"),T)=5&("ALSRUFGDZq"'[VAR)
 ..I $D(FLAG) S FLAG=VAR1,VAR1=5
 ..N CODE D
 ...I "^7^8^12^"[("^"_$P(V,"^",4)_"^")&(TYP["N"!(TYP["H")!($$HYBRID^PRSAENT1($G(DFN)))) S CODE="N" Q
 ...I "^7^8^12^"[("^"_$P(V,"^",4)_"^")&(PMP'="")&("^S^T^U^V^"[(U_PMP_U)) S CODE="N" Q
 ...I $P(V,"^",4)=11,($$HYBRID^PRSAENT1($G(DFN))) S CODE="N" Q
 ...I $P(V,"^",4)=11&(PMP'="")&("^S^T^U^V^"[(U_PMP_U)) S CODE="N" Q
 ...I "^7^8^9^11^"[("^"_$P(V,"^",4)_"^")&(TYP'["N")&(TYP'["H")&('$$HYBRID^PRSAENT1($G(DFN))) S CODE="n" Q
 ...I "^7^8^9^11^"[("^"_$P(V,"^",4)_"^")&("^S^T^U^V^"'[(U_PMP_U)) S CODE="n" Q
 ...I $P(V,"^",4)=17 S CODE="N" Q  ; Code 17 - OT/CT with premiums 
 ...I VAR1=5 S CODE=VAR Q
 ...S CODE=1
 ..S DAY(DY,"P")=$E(DAY(DY,"P"),0,T-1)_CODE_$E(DAY(DY,"P"),T+1,999)
 .I "ALSRUFGDZq"[VAR,VAR1=5 S VAR1=VAR
 .I $D(FLAG) S VAR1=FLAG K FLAG
 .;
FOPTHR .; part time hrs (PT/PH 8b codes) for CODE O firefighters
 .I +VAR1,"Ff"[TYP,PMP="O",(NH=448!(NH>320&(NH(1)'=NH(2)))) S Y=32 D SET
 .;
FRCPTHR .; part time hrs (PT/PH 8b codes) for code R & C firefighters
 .; don't include UNSCHEDULED REGULAR (var1=4)
 .I +VAR1,VAR1'=4,"Ff"[TYP,"RC"[PMP S Y=32 D SET
 .;
 .;patch 45 & 54
 .; Set non pay hrs in the basic tour for firefighters with premium
 .;pay indicator of C.
 .I "nW"[VAR1,"Ff"[TYP,"C"=PMP D
 ..;
 ..;  Y designates location in WK array where NT/NH will be stored.
 ..;  F node was set to 1 for periods of addtl ff hrs during 1st pass 
 ..;  thru scheduled ToD.  Count NT/NH if this is not addtl ff hrs.
 ..;
 ..I '$E(DAY(DY,"F"),T) S Y=47 D SET
 .S S="LSWnAREUP HYXOVQTFGDZq" I S[VAR1&(DY>0&(DY<15)!(DY=0&(T>96))) D  ;save in WK array
 ..S S(1)=$F(S,VAR1)-1
 ..S S=$P("1^2^3^4^5^6^0^8^0^9^24^42^43^0^33^54^19^44^45^46^53^55","^",S(1)) ;WK location
 ..Q:S=0
 ..; Patch *40 removed A (authorized absence) from leave counted in LU.
 ..; Patch *125 added LWOP as valid leave counted in LU
 ..; LU is only used to determine if night differential granted for
 ..; leave should be backed out.
 ..I TYP'["D","LSWRUFGDZq"[VAR1 S LU=LU+1 ;increment leave counter
 ..; p117 decrement total leave count for leave outside of pp
 ..I TYP'["D","LSWRUFGDZq"[VAR1,((DY=0)&(T<97))!((DY=14)&(T>96)),LU>0 S LU=LU-1
 ..S Y=S D SET S:TYP["D" Q=1
 ..K S,VAR1
 ;
 S DAY(DY,"W")=$E(DAYZ,1,96) ;todays activity
 S DAY(DY,"N")=$E(DAYZ,97,999) ;tomorrows activity from today/if any
 S DAY(DY,"r")=$E(DAYR,1,96) ; Today's Recess
 S DAY(DY,"rN")=$E(DAYR,97,999) ; Tomorrow's Recess/if any
 S:$E(DAY(DY,"P"),97,999)'="" DAY(DY,"P1")=$E(DAY(DY,"P"),97,999) ;non-prem ot for next day
 S DAY(DY,"P")=$E(DAY(DY,"P"),1,96) ;non-prem ot for today
 I DAY(DY,"N")?1"0"."0",DAY(DY,"rN")'["r" S DAY(DY,"N")=""
 S DAY(DY,"HOL")=$E(DAYH,1,96)
 ;
 ;P 45 FIREFIGHTER ADDITIONAL FIREFIGHTER HRS NODE FOR THIS DAY
 I $G(PRS8AFFH) D
 .  N PRSFFHR,PRSF1,PRSF2,PRSF3,SEG1,SEG2
 .;
 .;GET THE POSITIONAL START AND STOPS FOR THIS SEGMENT
 .  S SEG1=$P(V,U,1),SEG2=$P(V,U,2)
 .;EXISTING PORTION OF F NODE UP TO CURRENT SEGMENT
 .  S PRSF1=$E(DAYF,1,SEG1-1)
 .;CURRENT SEGMENT UP TO END OF DAY
 .  S PRSF2=$E(DAYZ,SEG1,SEG2)
 .;CURRENT F NODE PAST CURRENT SEGMENT TO END OF THE TOUR WHICH
 .;MAY FALL IN TODAY OR NEXT DAY.
 .S PRSF3=$E(DAYF,SEG2+1,999)
 .;
 .;UPDATE THE DAY ARRAY AND THE TMP GLOBAL WITH WORK STRING.
 .;EACH CHAR THAT IS SET TO 1 REPRESENTS A 15 MIN SEGMENT THAT
 .;THE FIREFIGHTER WAS SCHEDULED FOR ADDITIONAL FF HRS.
 .;FOR TOURS CROSSING MIDNIGHT THIS STRING WILL BE LONGER THAN 96
 .;CHARACTERS. CHARACTERS IN POSITIONS PAST 96 REPRESENT TIMES PAST
 .;MIDNIGHT OF THE CURRENT DAY (TOMORROW).
 .S PRSFFHR=PRSF1_PRSF2_PRSF3
 .S DAY(DY,"F")=PRSFFHR
 .S ^TMP($J,"PRS8",DY,"F")=PRSFFHR
 ;
 I DY<15 S X=$E(DAYH,97,999) I X'?."0" S ^TMP($J,"PRS8",DY+1,"HOL")=X_$E($G(^TMP($J,"PRS8",DY+1,"HOL")),$L(X)+1,999),DAY(DY+1,"HOL")=X
 ;
MOVE ; --- entry point for just moving previous days hrs to today
 I $D(DAY(DY-1,"N")),$L(DAY(DY-1,"N")) D
 .S X=DAY(DY-1,"N")_$E(DAY(DY,"W"),$L(DAY(DY-1,"N"))+1,96)
 .S DAY(DY,"W")=X
 I $D(DAY(DY-1,"P1")),$L(DAY(DY-1,"P1")) D
 .S X=DAY(DY-1,"P1")_$E(DAY(DY,"P"),$L(DAY(DY-1,"P1"))+1,96)
 .S DAY(DY,"P")=X
 I $D(DAY(DY-1,"rN")),$L(DAY(DY-1,"rN")) D
 .S X=DAY(DY-1,"rN")_$E(DAY(DY,"r"),$L(DAY(DY-1,"rN"))+1,96)
 .S DAY(DY,"r")=X
 ;
END ; --- all done here
 K CNT,OC,Q,S,SB,SL,SLP,T,VAR1,X,Y Q
 ;
SET ; --- set WK variable
 I (DY=0&(T<97))!(DY=14&(T>96))!(DY>14) Q
 S ZZ=WK,WK=$S(DY>7:2,1:1)
 I TYP'["D",DY=7,T>96 S WK=2
 S $P(WK(WK),"^",Y)=$P(WK(WK),"^",Y)+1
 ;
 ; The passing of Public Law 106-554 allows taking ML in hours.
 ; ML will now be recorded in 15 minute segments in the WK(3) array
 ; for employees entitled to take ML in hours.  PRS*4.0*69
 ;
 I VAR1="M",$$MLINHRS^PRSAENT(DFN) D
 . S WK=3,Y=11
 . S $P(WK(WK),"^",Y)=$P(WK(WK),"^",Y)+1
 ;
 ; IF a part-time employee and they have either LWOP or Non-Pay
 ; THEN decrement total hours for the week and the pay period.
 ; PRS*4.0*52.
 ;
 I "Wn"[VAR1,TYP["P" S TH=TH-1,TH(WK)=TH(WK)-1
 S WK=ZZ Q
