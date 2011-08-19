PSSDDUT ;BIR/LDT-Pharmacy Data Management DD Utility ;09/15/97
 ;;1.0;PHARMACY DATA MANAGEMENT;**13,18,19,38,56**;9/30/97
 ;
SCH ;Called from DRUG file (50), Unit Dose Schedule field 62.04
 ;(Replaces EN^PSGS0)
 I X[""""!($A(X)=45)!(X?.E1C.E)!($L(X," ")>2)!($L(X)>70)!($L(X)<1)!(X["P RN")!(X["PR N") K X Q
 I X?.E1L.E S X=$$ENLU^PSSGMI(X) I '$D(PSGOES) D EN^DDIOL("  ("_X_")","","?0")
 I X["Q0" K X Q
 ;
ENOS ; order set entry
 S (PSGS0XT,PSGS0Y,XT,Y)="" I X["PRN"!(X="ON CALL")!(X="ONCALL")!(X="ON-CALL") G Q
 S X0=X I X,X'["X",(X?2.4N1"-".E!(X?2.4N)) D ENCHK^PSSGS0 S:$D(X) Y=X G Q
 I $S($D(^PS(51.1,"AC","PSJ",X)):1,1:$E($O(^(X)),1,$L(X))=X) D DIC^PSSGS0 I $G(XT)]"" G Q
 I X["@" D DW^PSSGS0 S:$D(X) Y=$P(X,"@",2) G Q
 I Y'>0,$S(X="NOW":1,X="ONCE":1,X="STAT":1,X="ONE TIME":1,X="ONETIME":1,X="1TIME":1,X="1 TIME":1,X="1-TIME":1,1:X="ONE-TIME") D:'$D(PSGOES) EN^DDIOL("  (ONCE ONLY)","","?0") S Y="",XT="O" G Q
 I $G(PSGSCH)=X S PSGS0Y=$G(PSGAT) Q
 ;
NS I Y'>0 D:'$D(PSGOES) EN^DDIOL("  (Nonstandard schedule)","","?0") S X=X0,Y=""
 I $E(X,1,2)="AD" K X G Q
 I $E(X,1,3)="BID"!($E(X,1,3)="TID")!($E(X,1,3)="QID") S XT=1440/$F("BTQ",$E(X)) G Q
 S:$E(X)="Q" X=$E(X,2,99) S:'X X="1"_X S X1=+X,X=$P(X,+X,2),X2=0 S:X1<0 X1=-X1 S:$E(X)="X" X2=1,X=$E(X,2,99)
 S XT=$S(X["'":1,(X["D"&(X'["AD"))!(X["AM")!(X["PM")!(X["HS"&(X'["THS")):1440,X["H"&(X'["TH"):60,X["AC"!(X["PC"):480,X["W":10080,X["M":40320,1:-1) I XT<0,Y'>0 K X G Q
 S X=X0 I XT S:X2 XT=XT\X1 I 'X2 S:$E(X,1,2)="QO" XT=XT*2 S XT=XT*X1
 ;
Q ;
 S PSGS0XT=$S(XT]"":XT,1:""),PSGS0Y=$S(Y:Y,1:"") K QX,SDW,SWD,X0,XT,Z Q
 ;
ENSH5 ; from ^DD(55.06,26,4)
 S:'$D(PSGST) PSGST=$P($G(^PS(55,DA(1),5,DA,0)),"^",7),PSGDDFLG=1 G ENSH
 ;
ENSH ;Called from MEDICATION INSTRUCTION file (51), field 5 Executable Help
 ;(Replaces ENSH^PSSGSH)
 N D,DA,DIC,DIE,DZ,Y
 D EN^DDIOL("'STAT', 'ONCE', 'NOW', and 'DAILY' are acceptable schedules.","","?0") I X?1"???".E F Q=1:1 Q:$P($T(HT+Q),";",3)=""  S PSSHLP(Q)=$P($T(HT+Q),";",3)
 I X?1"???".E D EN^DDIOL(.PSSHLP) K PSSHLP
 I X?1"???".E R !,"(Press RETURN to continue.) ",Q:DTIME D:'$T EN^DDIOL("","","$C(7)") S:'$T Q="^" I Q="^" K:$D(PSGDDFLG) PSGDDFLG,PSGST Q
 K DIC S DIC="^PS(51.1,",DIC(0)="E",D="APPSJ",DIC("W")="W ""  ""," I $D(PSJPWD),PSJPWD S DIC("W")=DIC("W")_"$S($D(^PS(51.1,+Y,1,PSJPWD,0)):$P(^(0),""^"",2),1:$P(^PS(51.1,+Y,0),""^"",2))"
 E  S DIC("W")=DIC("W")_"$P(^(0),""^"",2)"
 I $D(PSGST) S DIC("S")="I $P(^(0),""^"",5)"_$E("'",PSGST'="O")_"=""O"""
 D IX^DIC K DIC K:$D(PSGDDFLG) PSGDDFLG,PSGST Q
 ;
HT ;
 ;;  This is the frequency (ONLY) with which the doses are to be
 ;;administered.  Several forms of entry are acceptable, such as
 ;;Q6H, 09-12-15, STAT, QOD, and MO-WE-FR@AD (where MO-WE-FR are
 ;;days of the week, and AD is the admin times).  The schedule
 ;;will show on the MAR, labels, etc.  No more than ONE space
 ;;(Q3H 4 or Q4H PRN) in the schedule is acceptable.  If the
 ;;letters PRN ;;are found as part of the schedule, no admin
 ;;times will print on the MAR or labels, and the PICK LIST will
 ;;always show a count of zero (0).
 ;;Avoid using notation such as W/F (with food) or WM (with meals)
 ;;in the schedule as it may cause erroneous calculations.  That
 ;;information should be entered into the SPECIAL INSTRUCTIONS.
 ;;  When using the MO-WE-FR@AD schedule, please remember that
 ;;this type of schedule will not work properly without the "@"
 ;;character and at least one admin time, and that at least the
 ;;first two letters of each weekday entered is needed.
 ;
 ;
ENDLP ;Called from Pharmacy System file (59.7), field 60.1 BAXTER ATC
 ;212 DEVICE (Replaces ENDLP^PSGSET)
 S PSGION=$S($D(ION):ION,1:"HOME") K %ZIS S %ZIS="QN",IOP=X D ^%ZIS I POP S IOP=PSGION D ^%ZIS K %ZIS,IOP,PSGION S X="" Q
 D EN^DDIOL($S(X=$E(ION,1,$L(X)):$E(ION,$L(X)+1,$L(ION)),1:"  "_ION),"","?0") S X=ION D ^%ZISC K %ZIS,PSGION,IOP Q
 ;
ENSTH ;Executable help for type of schedule. (Replaces ENSTH^PSJSV0)
 N PSSX S PSSX=1
 S PSSHLP(PSSX)="The TYPE OF SCHEDULE determines how the schedule will be processed."
 S PSSHLP(PSSX,"F")="!!?2",PSSX=PSSX+1
 S PSSHLP(PSSX)="A CONTINUOUS schedule is one in which an action is to take place on a"
 S PSSHLP(PSSX,"F")="!!?2",PSSX=PSSX+1
 S PSSHLP(PSSX)="regular basis, such as 'three times a day' or 'once every two days'."
 S PSSHLP(PSSX,"F")="!",PSSX=PSSX+1
 S PSSHLP(PSSX)="A DAY OF THE WEEK schedule is one in which the action is to take"
 S PSSHLP(PSSX,"F")="!?2",PSSX=PSSX+1
 S PSSHLP(PSSX)="place only on specific days of the week.  This type of schedule"
 S PSSHLP(PSSX,"F")="!",PSSX=PSSX+1
 S PSSHLP(PSSX)="should have admin times entered with it.  If not, the start time of"
 S PSSHLP(PSSX,"F")="!",PSSX=PSSX+1
 S PSSHLP(PSSX)="the order is used as the admin time.  Whenever this type is chosen,"
 S PSSHLP(PSSX,"F")="!",PSSX=PSSX+1
 S PSSHLP(PSSX)="the name of the schedule must be in the form of 'MO-WE-FR'."
 S PSSHLP(PSSX,"F")="!",PSSX=PSSX+1
 G:$S('$D(PSJPP):1,PSJPP="":1,1:PSJPP="PSJ") HOT
 S PSSHLP(PSSX)="A DAY OF THE WEEK-RANGE schedule is one in which the action to take"
 S PSSHLP(PSSX,"F")="!?2",PSSX=PSSX+1
 S PSSHLP(PSSX)="place only on specific days of the week, but at no specific time of"
 S PSSHLP(PSSX,"F")="!",PSSX=PSSX+1
 S PSSHLP(PSSX)="day (no admin times).  Whenever this type is chosen, the name of the"
 S PSSHLP(PSSX,"F")="!",PSSX=PSSX+1
 S PSSHLP(PSSX)="schedule must be in the form of 'MO-WE-FR'."
 S PSSHLP(PSSX,"F")="!",PSSX=PSSX+1
HOT S PSSHLP(PSSX)="A ONE-TIME schedule is one in which the action is to take place once"
 S PSSHLP(PSSX,"F")="!?2",PSSX=PSSX+1
 S PSSHLP(PSSX)="only at a specific date and time."
 S PSSHLP(PSSX,"F")="!",PSSX=PSSX+1
 I $S('$D(PSJPP):1,PSJPP="":1,1:PSJPP="PSJ") D WRITE Q
 S PSSHLP(PSSX)="A RANGE schedule is one in which the action will take place within a"
 S PSSHLP(PSSX,"F")="!?2",PSSX=PSSX+1
 S PSSHLP(PSSX)="given date range."
 S PSSHLP(PSSX,"F")="!",PSSX=PSSX+1
 S PSSHLP(PSSX)="A SHIFT schedule is one in which the action will take place within a"
 S PSSHLP(PSSX,"F")="!?2",PSSX=PSSX+1
 S PSSHLP(PSSX)="given range of times of day."
 S PSSHLP(PSSX,"F")="!",PSSX=PSSX+1
 D WRITE
 Q
WRITE ;Calls EN^DDIOL to write text
 D EN^DDIOL(.PSSHLP) K PSSHLP
 Q
PSS13 ;Screen for CLINIC field - PDM patch PSS*1*13
 N X,PSSDT
 S X1=DT,X2=-7 D C^%DTC S PSSDT=X
 I $P($G(^(0)),U,3)="C",$S('$P($G(^("I")),U):1,($P($G(^("I")),U)>PSSDT):1,(($P($G(^("I")),U)<PSSDT)&($P($G(^("I")),U,2)]"")&(DT>$P($G(^("I")),U,2))):1,1:0)
 Q
PSS19 ;Delete DRUG GROUP/INTERACTION field #7 - PDM patch PSS*1*19
 S DIK="^DD(50,",DA=7,DA(1)=50 D ^DIK
 ;
 ;In File #50, delete "I" node if it is null.
 N PSSIEN
 F PSSIEN=0:0 S PSSIEN=$O(^PSDRUG(PSSIEN)) Q:'PSSIEN  I $D(^PSDRUG(PSSIEN,"I")),$P(^PSDRUG(PSSIEN,"I"),"^")="" K ^PSDRUG(PSSIEN,"I")
 Q
