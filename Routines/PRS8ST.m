PRS8ST ;HISC/MGD-DECOMPOSITION, START-UP ;05/09/07
 ;;4.0;PAID;**45,92,102,112,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine is the one which actually gets everything moving.
 ;It moves the information from the ^TMP global into a local array
 ;[DAY(DAY)] for the three day period it's working with.  It then
 ;processes that information internally and, where necessary, by
 ;calling certain external processes.
 ;
 ;Called by Routines:  PRS8SU
 ;
 K SBY F DAY=1:1:14 D
 .K DAY(DAY-2)
 .S LP=$S(DAY=1:"0,1,2",1:(DAY+1)),JURY=0
 .F II=1:1 S DY=$P(LP,",",II) Q:DY=""  D
 ..F J=0,1,2,4,10,"CP","DH1","DH2","HOL","ML","MT1","MT2","OFF","P","TOUR","TWO","W","r" D
 ...S DAY(DY,J)=$G(^TMP($J,"PRS8",DY,J))
 ...;
 ...;P 45 INITIALIZE THE "F" NODE HERE BY SIMPLY COPYING THE 
 ...;THE "W" NODE FROM TEMP--FOR TESTING PURPOSES.
 ...;THE NODE SHOULD BE INITIALIZED BY COPYING THE "F" NODE
 ...;FROM THE TEMP GLOBAL.
 ...S DAY(DY,"F")=$G(^TMP($J,"PRS8",DY,"W"))
 .F II=1:1 S DY=$P(LP,",",II) Q:DY=""  D
 ..S WK=$S(DY<8:1,1:2)
 ..S TOUR=$S(TYP'["W":1,+DAY(DY,"TOUR"):+DAY(DY,"TOUR"),1:+TOUR(WK))
 ..D MOVE^PRS8AC
 ..S N=DAY(DY,2),WK=$S(DY<8:1,1:2) ;exception node/week
 ..I N["UN" S X1="UN" D 2 ;unavailable
 ..I N["HX" S X1="HX" D 2 ;holiday excused
 ..I N["ON" S X1="ON" D 2 ;on-call
 ..I N["SB" S X1="SB" D 2 ;standby
 ..; Process the scheduled tours
 ..S N=DAY(DY,1),DH=DAY(DY,"DH1"),NN=1 D  I DAY(DY,"TWO") S N=DAY(DY,4),DH=DAY(DY,"DH2"),NN=4 D
 ...S QT=0 F PRS8=1:3 S V=$P(N,"^",PRS8,PRS8+2) Q:QT  D
 ....N PRS8AFFH S PRS8AFFH=0 ;fire fighter additional hours flag
 ....S X=$P(DAY(DY,NN),"^",PRS8,999)
 ....I X="" S QT=1 Q  ;nothing left to check
 ....I X?1"^"."^" S QT=1 Q  ;only ^ left
 ....;
 ....; X = 9 is special tour CODE FOR FF ADDTL HRS.
 ....; It gets converted to 'f'
 ....S X=$P(V,"^",3),VAR=1 I X S VAR=$E("se1BC235f",+X) I '+VAR D ENT Q:Q
 ....;if this segment is addt ff hrs then save a variable to signify
 ....;that, but convert the time back to a 1 to use in the W node.
 ....I "Ff"[TYP,VAR="f" S (PRS8AFFH,VAR)=1
 ....;
 ....I VAR,TYP'["W" S VAR=$S(VAR=5:5,1:1) ;only wg need shifts
 ....S JURY=$G(^TMP($J,"PRS8",DY,2)) I JURY'="" D
 .....F J=4,8,12,16,20,24,28 S:$P(JURY,"^",J)=6 JURY=1 Q
 ....D ^PRS8AC ;build "W" node
 ..; Process the exceptions
 ..S N=DAY(DY,2),WK=$S(DY<8:1,1:2) ;exception node/week
 ..S QT=0
 ..; If there are Recess exceptions, process them first
 ..I N["RS" D
 ...; Since Recess will reduce hours worked in the week add P to TYP
 ...I TYP'["P" S TYP=TYP_"P"
 ...F PRS8=1:4:25 S V=$P(N,"^",PRS8,PRS8+3) Q:QT  D
 ....Q:$P(V,"^",3)'="RS"
 ....I TYP["D",$P(V,"^",3)="" S QT=1 Q  ;doctor
 ....I TYP'["D",'+V,$P(V,"^",3)="" S QT=1 Q  ;all others
 ....S X=$P(V,"^",3)
 ....I "^UN^ON^SB^HX^"'[("^"_X_"^") D ^PRS8EX
 ...;
 ...; Process all other types of exceptions
 ..S QT=0
 ..F PRS8=1:4:25 S V=$P(N,"^",PRS8,PRS8+3) Q:QT  D
 ...Q:$P(V,"^",3)="RS"
 ...I TYP["D",$P(V,"^",3)="" S QT=1 Q  ;doctor
 ...I TYP'["D",'+V,$P(V,"^",3)="" S QT=1 Q  ;all others
 ...S X=$P(V,"^",3)
 ...I "^UN^ON^SB^HX^"'[("^"_X_"^") D ^PRS8EX
 ..;
 ..S ^TMP($J,"PRS8",DY,"W")=DAY(DY,"W") ;save in ^TMP
 ..S ^TMP($J,"PRS8",DY,"P")=DAY(DY,"P") ;save non-prem ot in ^TMP
 ..S ^TMP($J,"PRS8",DY,"HOL")=DAY(DY,"HOL") ;holiday
 ..S ^TMP($J,"PRS8",DY,"r")=DAY(DY,"r") ; Recess for 9mo AWS nurse
 .S WK=$S(DAY<8:1,1:2),OFF=+DAY(DAY,"OFF") ;week/day off
 .S TOUR=$S(TYP'["W":1,+DAY(DAY,"TOUR"):+DAY(DAY,"TOUR"),1:+TOUR(WK))
 .I TYP["I",DAY>0,DAY<15,$G(DAY(DAY,"DWK")) D  ;days worked
 ..S DWK=DWK+1 ;count days worked
 ..I CYA,DAY'<CYA S CAMISC=CAMISC+1 ;calendar year adjustment (CA)
 .S MDY=+DAY D ^PRS8MT I +DAY=1 S MDY=0 D ^PRS8MT
 .Q
 ;
 ;make DAY array available for prior, current, and next day
 F DAY=1:1:14 D
 .; I AWS Nurse check to see if hour counts need to be adjusted
 .S WK=$S(DAY<8:1,1:2)
 .; For each week, TYP should not contain "P" unless:
 .; 36/40 AWS has NP or WP
 .;   9mo AWS has Recess
 .I +NAWS,(DAY=1!(DAY=8)) S TYP=$TR(TYP,"P","") D NAWS
 .;
 .K DAY(DAY-2)
 .S LP=$S(DAY=1:"0,1,2",1:(DAY+1))
 .F II=1:1 S DY=$P(LP,",",II) Q:DY=""  D
 ..F J=0,1,2,4,10,"CP","DH1","DH2","HOL","ML","MT1","MT2","OFF","P","TOUR","TWO","W","F","r" S DAY(DY,J)=$G(^TMP($J,"PRS8",DY,J))
 .;
 .S WK=$S(DAY<8:1,1:2),OFF=+DAY(DAY,"OFF") ;week/day off
 .S TOUR=$S(TYP'["W":1,+DAY(DAY,"TOUR"):+DAY(DAY,"TOUR"),1:+TOUR(WK))
 .;
 .I ((TYP["I")!(TYP["P")),DAY>0,DAY<15 D  ;FOR CY
 ..I $S('CYA:1,DAY<CYA:1,1:0) Q  ;quit if no calendar year adjustment
 ..S IIX=0 I $E(ENT,2)'="D" F II=1:1:$L(DAY(DAY,"W")) D
 ...I "4E"[$E(DAY(DAY,"W"),II) S IIX=IIX+1
 ...S CYA2806=CYA2806+("ALSUMRVW1235OscXYFGDZq"[$E(DAY(DAY,"W"),II))
 ...S:(IIX<33)&(FLX'="C"&(TH(WK)+IIX<163))!(FLX="C"&(TH+IIX<323)) CYA2806=CYA2806+("4E"[$E(DAY(DAY,"W"),II))
 ...;SF2806 adjustment (CY) (163 & 323 because mt subtracted)
 .;
 .I CYA,DAY'<CYA,DAY(DAY,"W")["W" D  ;count wop in hours for CA
 ..F II=1:1:$L(DAY(DAY,"W")) S WPCYA=WPCYA+("W"=$E(DAY(DAY,"W"),II))
 .;
 .I TYP'["D",DAY(DAY,"W")'?1"0"."0" D ^PRS8PP ;nightdiff/shift premiums
 .;
 .F T=1:1:96 S VAR1=$E(DAY(DAY,"W"),T) S OK=0 D
 ..I "BbCct"[VAR1 D  ; process on-call/standby
 ...I T=96!("BbCct"'[$E(DAY(DAY,"W"),T+1)) S OK=T
 ...I DOUB D ^PRS8OC,^PRS8SB Q  ;Prem. Pay of "W" or "V"
 ...I VAR1'=""&("Cct"[VAR1) D ^PRS8OC Q  ;compute on-call/2hr minimum
 ...I "Bb"[VAR1 D ^PRS8SB ;standby
 .I $G(SBY) D UP^PRS8SB
 .;
 .Q
 ;
 ;P 45 CODE O firefighters use PRS8MISC to calculated overtime
 ;but code R and C firefighters use routine PRS8OTFF.
 ;
 I "Ff"[TYP&("RC"[PMP) D
 .  D ^PRS8OTFF
 E  D
 .  D ^PRS8MISC
 K DH,DY,I,J,JURY,K,K1,LP,N,NN,OFF,PRS8L,TOUR,V,VAR,WG,X,Y,Y1
 D ^PRS8WE ;Weekend premiums
 D ^PRS8UP ;finish up Misc and non-time related activities
 Q
 ;
ENT ; --- check entitlement to activity for 1 node non-norm hrs
 S Q=0
 I '$E(ENT,$P("12^28^^29^26^^^29","^",+X)) S Q=1 ;entitlement string
 ;PATCH 45: ADD CHECK FOR FIRE FIGHTER ADDITIONAL HOURS
 ;SINCE THIS TYPE OF TIME IS NOT IN THE ENTITLEMENT TABLE
 ;IT IS SET UP WITH TOUR IND. WITH CODE 9
 I "Ff"[TYP,X=9 S Q=0
 Q:X'=12  I TYP["W",TOUR>1,$E(ENT,11+TOUR) S Q=0
 Q
 ;
2 ; --- get 2 node unavailable/oncall and standby
 F PRS8=1:4:25 S V=$P(N,"^",PRS8,PRS8+2) Q:$P(V,"^",1)=""  D
 .S X=$P(V,"^",3) I X=X1 D ^PRS8EX
 K PRS8,X,V
 Q
 ;
NAWS ; NAWS Nurse Alternate Work Schedules
 ; If any NP or WP has been incurred for a nurse on the 36/40 AWS,
 ; adjust their hours worked counts.  40 hrs/wk will now be used to 
 ; determine their qualification for OT and CT.  Check piece 16 of
 ; 0 node as NH will have been updated to 320 in PRS8SU.
 ;
 I +NAWS=36 D
 .Q:$P(WK(WK),U,3)=""&($P(WK(WK),U,4)="")
 .S TH(WK)=144-($P(WK(WK),U,3)+$P(WK(WK),U,4)) ; Adjust Total Hours per week
 .S TH=TH(1)+TH(2) ; Adjust Total Hours per pay period
 .S NH(WK)=144,NH=288 ; Adjust Normal Hours
 .I TYP'["P" S TYP=TYP_"P" ; Make them into a PT employee
 .S $E(ENT,2)=1 ; Make employee eligible for UN/US
 ;
 ; If any Recess has occurred for a nurse on the 9month AWS, adjust 
 ; their hours worked counts.  These employees will be treated as PT
 ; in determining the eligibility for OT/CT.
 ;
 I +NAWS=9 D
 .Q:$P(WK(WK),U,48)=""
 .S TH(WK)=TH(WK)-$P(WK(WK),U,48) ; Adjust total hours per week
 .S TH=TH(1)+TH(2) ; Adjust Total Hours
 .I TYP'["P" S TYP=TYP_"P" ; Adjust TYP to represent a PT employee
 Q
