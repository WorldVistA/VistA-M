PSJDDUT ;BIR/LDT-INPATIENT MEDICATIONS DD UTILITY ;21 AUG 97  7:55 AM
 ;;5.0; INPATIENT MEDICATIONS ;**40,44,50,83,116,111,113**;16 DEC 97;Build 63
 ;
 ; Reference to ^PS(51 is supported by DBIA# 2176.
 ; Reference to ^PS(51.1 is supported by DBIA# 2177.
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; 
SPCIN ;Called from Non-Verified Orders File (53.1), Special Instructions
 ;field 8
 S PSJHLP(1)="IF ABBREVIATIONS ARE USED, THE TOTAL LENGTH OF THE EXPANDED"
 S PSJHLP(2)="INSTRUCTIONS ALSO MAY NOT BE LONGER THAN 180 CHARACTERS."
 D WRITE
 Q
CHKSI ;Called from Non-Verified Orders File (53.1), Special Instructions
 ;field 8 (Replaces ^PSGSICHK)
 I $S(X'?.ANP:1,X["^":1,1:$L(X)>180) K X Q
 N Y S Y="" F Y(1)=1:1:$L(X," ") S Y(2)=$P(X," ",Y(1)) I Y(2)]"" D CHK1 Q:'$D(X)
 I $D(X),Y]"",X'=$E(Y,1,$L(Y)-1) D EN^DDIOL("EXPANDS TO:","","!?3") F Y(1)=1:1 S Y(2)=$P(Y," ",Y(1)) Q:Y(2)=""  D:$L(Y(2))+$X>78 EN^DDIOL("","","!") D EN^DDIOL(Y(2)_" ","","?0")
 K Y Q
CHK1 ;
 I $L(Y(2))<31,$D(^PS(51,+$O(^PS(51,"B",Y(2),0)),0)),$P(^(0),"^",2)]"",$P(^(0),"^",4) S Y(2)=$P(^(0),"^",2)
 I $L(Y)+$L(Y(2))>180 K X Q
 S Y=Y_Y(2)_" " Q
 ;
CHK F QQ=1:1:$L(SCH,"-") S WKD=$P(SCH,"-",QQ) I WKD=$E(X,1,$L(WKD)) D TS Q
 Q
TS F Q1=1:1:$L(TS,"-") S C=C+1 I C=PSGDL S X=X1_"."_$P(TS,"-",Q1) Q
 Q
STRDT ;Called from Non-Verified Orders File (53.1),Start Date/Time field 10
 ;(Replaces ENPREV^PSGDL)
 D EN^DDIOL("REVIOUS","","?0") S (X,Y)=0 I '$D(PSGP)!'$D(PSGPDRG) G:$D(DA)[0 POUT S PSGP=$P($G(^PS(53.1,DA,0)),"^",15),PSGPDRG=+$G(^(.2)),Y=1 I 'PSGP!'PSGPDRG D:'PSGPDRG EN^DDIOL("Must have drug from formulary list.","","!?17") G POUT
 F Q=0:0 S Q=$O(^PS(53.1,"AC",PSGP,Q)) Q:'Q  I +$G(^PS(53.1,Q,.2))=PSGPDRG,$D(^PS(53.1,Q,2)),$P(^(2),"^",4)>X S X=$P(^(2),"^",4)
 F Q=0:0 S Q=$O(^PS(55,PSGP,5,"C",PSGPDRG,Q)) Q:'Q  I $D(^PS(55,PSGP,5,Q,2)),$P(^(2),"^",4)>X S X=$P(^(2),"^",4)
 D:'X EN^DDIOL("No other order found with this drug.","","!?17")
 ;
POUT ;
 K:'X X K:Y PSGPDRG,PSGP,Q Q
 ;
UNPD ;Called from Non-Verified Orders File (53.1), Units Per Dose field 13
 S PSJHLP(1)="ONE (1) UNIT PER DOSE WILL BE ASSUMED IF THERE IS NO ENTRY (OR"
 S PSJHLP(2)="AN ENTRY OF ZERO (0)) INTO THIS FIELD."
 D WRITE
 Q
 ;
SCH ;Called from Non-Verified Orders File (53.1), Schedule field 26
 ;(Replaces EN^PSGS0)
 ;/I X[""""!($A(X)=45)!(X?.E1C.E)!($L(X," ")>2)!($L(X)>70)!($L(X)<1)!(X["P RN")!(X["PR N") K X Q
 I X[""""!($A(X)=45)!(X?.E1C.E)!($L(X," ")>3)!($L(X)>70)!($L(X)<1)!(X["P RN")!(X["PR N") K X Q
 I X?.E1L.E S X=$$ENLU^PSGMI(X) I '$D(PSGOES) D EN^DDIOL("  ("_X_")","","?0")
 I X["Q0" K X Q
 ;
ENOS ; order set entry
 S (PSGS0XT,PSGS0Y,XT,Y)="" I X["PRN"!(X="ON CALL")!(X="ONCALL")!(X="ON-CALL") G Q
 S X0=X I X,X'["X",(X?2.4N1"-".E!(X?2.4N)) D ENCHK^PSGS0 S:$D(X) Y=X G Q
 I $S($D(^PS(51.1,"AC","PSJ",X)):1,1:$E($O(^(X)),1,$L(X))=X) D DIC^PSGS0 I XT]"" G Q
 I X["@" D DW^PSGS0 S:$D(X) Y=$P(X,"@",2) G Q
 I Y'>0,$S(X="NOW":1,X="ONCE":1,X="STAT":1,X="ONE TIME":1,X="ONETIME":1,X="1TIME":1,X="1 TIME":1,X="T-TIME":1,1:X="ONE-TIME") D:'$D(PSGOES) EN^DDIOL("  (ONCE ONLY)","","?0") S Y="",XT="O" G Q
 I $G(PSGSCH)=X S PSGS0Y=$G(PSGAT) Q
 ;
NS K PSJNSS I Y'>0 D:'$D(PSGOES) EN^DDIOL("  (Nonstandard schedule)","","?0") S X=X0,Y="",PSJNSS=1
 I $E(X,1,2)="AD" K X Q
 I $E(X,1,3)="BID"!($E(X,1,3)="TID")!($E(X,1,3)="QID") S XT=1440/$F("BTQ",$E(X)) G Q
 S:$E(X)="Q" X=$E(X,2,99) S:'X X="1"_X S X1=+X,X=$P(X,+X,2),X2=0 S:X1<0 X1=-X1 S:$E(X)="X" X2=1,X=$E(X,2,99)
 S XT=$S(X["'":1,(X["D"&(X'["AD"))!(X["AM")!(X["PM")!(X["HS"&(X'["THS")):1440,X["H"&(X'["TH"):60,X["AC"!(X["PC"):480,X["W":10080,X["M":40320,1:-1) I XT<0,Y'>0 K X G Q
 S X=X0 I XT S:X2 XT=XT\X1 I 'X2 S:$E(X,1,2)="QO" XT=XT*2 S XT=XT*X1
 ;
Q ;
 S PSGS0XT=$S(XT]"":XT,1:""),PSGS0Y=$S(Y:Y,1:"") K QX,SDW,SWD,X0,XT,Z Q
 ;
SCH3 ;Called from Non-Verified Orders File (53.1), Schedule field 26
 ;(Replaces ENSH3^PSGSH)
 S:'$D(PSGST) PSGST=$P($G(^PS(53.1,DA,0)),"^",7),PSGDDFLG=1
 N D,DA,DIC,DIE,DZ,Y
 D EN^DDIOL("'STAT', 'ONCE', 'NOW', and 'DAILY' are acceptable schedules.") I X?1"???".E F Q=1:1 Q:$P($T(HT+Q),";",3)=""  S PSJHLP(Q)=$P($T(HT+Q),";",3)
 I X?1"???".E D EN^DDIOL(.PSJHLP) K PSJHLP
 I X?1"???".E R !,"(Press RETURN to continue.) ",Q:DTIME D:'$T EN^DDIOL("","","$C(7)") S:'$T Q="^" I Q="^" K:$D(PSGDDFLG) PSGDDFLG,PSGST Q
 K DIC S DIC="^PS(51.1,",DIC(0)="E",D="APPSJ",DIC("W")="W ""  ""," I $D(PSJPWD),PSJPWD S DIC("W")=DIC("W")_"$S($D(^PS(51.1,+Y,1,PSJPWD,0)):$P(^(0),""^"",2),1:$P(^PS(51.1,+Y,0),""^"",2))"
 ; Naked references on the following two lines refer to the full reference on the line above
 E  S DIC("W")=DIC("W")_"$P(^(0),""^"",2)"
 I $D(PSGST) S DIC("S")="I $P(^(0),""^"",5)"_$E("'",PSGST'="O")_"=""O"""
 S DIC("?N",51.1)=12
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
ADTM2 ;Called from Non-Verified Orders File (53.1), Admin Times field 39    
 S PSJHLP(1)="All times must be the same length (2 or 4 characters), must be"
 S PSJHLP(2)="separated by dashes ( - ), and be in ascending order"
 S PSJHLP(3)=" "
 S PSJHLP(4)="This is the set of administration times for this order."
 S PSJHLP(5)="If the Schedule Type is CONTINUOUS the number of administration"
 S PSJHLP(6)="times cannot exceed that indicated by the schedule.  There can"
 S PSJHLP(7)="be less administration times then indicated by the schedule."
 S PSJHLP(8)="There must be at least one administration time entered."
 S PSJHLP(9)=" "
 S PSJHLP(10)="If the Schedule Type is CONTINUOUS and is an Odd Schedule"
 S PSJHLP(11)="(A schedule whose frequency is not evenly divisible by or"
 S PSJHLP(12)="into 1440 minutes or 1 day), Administration Times are not allowed."
 S PSJHLP(13)="For example Q5H, Q17H - these are not evenly divisible by 1440."
 S PSJHLP(14)=" "
 S PSJHLP(15)="If the Schedule Type is CONTINUOUS with a non-odd frequency of"
 S PSJHLP(16)="greater than 1 day (1440 minutes) then more than one"
 S PSJHLP(17)="administration time is not allowed.  For example schedules of"
 S PSJHLP(18)="Q72H, Q3Day, Q5Day."
 S PSJHLP(19)=" "
 S PSJHLP(20)="If the Schedule Type is ONE TIME it cannot have more than one"
 S PSJHLP(21)="administration time."
 D WRITE
 Q
 ;
WRDGP ;Called from Ward Group File (57.5), Ward Group field .01   
 S PSJHLP(1)="There is at least one PICK LIST for this WARD GROUP.  This WARD"
 S PSJHLP(1,"F")="$C(7),!!?2"
 S PSJHLP(2)="GROUP cannot be deleted until the PICK LIST(s) is purged or deleted."
 D WRITE
 Q
 ;
LBLS ;Called from Inpatient Ward Parameters file (59.6), field .11
 S PSJHLP(1)="ANY NEW LABELS OLDER THAN THE NUMBER OF DAYS SPECIFIED HERE WILL"
 S PSJHLP(2)="AUTOMATICALLY BE PURGED."
 D WRITE
 Q
 ;
SCHTP ;Called from the Unit Dose Multiple of file 55, Schedule Type field 7
 S PSJHLP(1)="CHOOSE FROM:"
 S PSJHLP(1,"F")="!!"
 S PSJHLP(2)="C - CONTINUOUS"
 S PSJHLP(2,"F")="!?3"
 S PSJHLP(3)="O - ONE-TIME"
 S PSJHLP(3,"F")="!?3"
 S PSJHLP(4)="OC - ON CALL"
 S PSJHLP(4,"F")="!?3"
 S PSJHLP(5)="P - PRN"
 S PSJHLP(5,"F")="!?3"
 S PSJHLP(6)="R - FILL ON REQUEST"
 S PSJHLP(6,"F")="!?3"
 D WRITE
 Q
 ;
EN ;Called from Non-Verified Orders file 53.1, Start/Date Time field 10
 ;and Stop Date/Time field 25 (Replaces EN^PSGDL)
 K PSGDLS S ND2=^PS(53.1,DA,2) I $P(ND2,"^",5)!$P(ND2,"^",6) D EN^DDIOL(" ...Dose Limit... ","","?0") G ENGO
 G DONE
 ;
ENGO ;
 N FD
 S SCH=$P(ND2,"^")
 S ST=$S($D(PSGDLS):PSGDLS,1:$P(ND2,"^",2))
 S TS=$P(ND2,"^",5),MN=$P(ND2,"^",6)
 I $P(PSJSYSW0,U,5)=2 D
 . Q:'TS  S:TS'[$P(ST,".",2) $P(PSJSYSW0,U,5)=1 D
 .. N STRING,ND2,SCH,TS,MN S STRING=$G(PSGSD)_"^"_$G(PSGFD)_"^"_$G(PSGSCH)_"^"_$G(PSGST)_"^"_$G(PSGPDRG)_"^"_$G(PSGAT)
 .. S (FD,ST)=$$ENQ^PSJORP2(PSGP,STRING) S:'ST ST=$S($D(PSGDLS):PSGDLS,1:$P(ND2,"^",2))
 . S $P(PSJSYSW0,U,5)=2
 I $G(FD),$P(ND2,"^",4),FD>$P(ND2,"^",4) D  G DONE
 . W !,"There is no schedule and/or administration time that falls between the Start Date/Time"
 . W !,"and Stop Date/Time.  For the order to be valid the schedule and/or administration time"
 . W !,"must fall between the order's Start Date/Time and Stop Date/Time.",!
 S TS=$P(ND2,"^",5),MN=$P(ND2,"^",6)
 G MWF:SCH["@",DONE:'TS&'MN
 I 'TS S AM=MN*PSGDL,X=$$EN^PSGCT(ST,AM) G DONE
 S TM=$E(ST_"00000",9,8+$L($P(TS,"-")))
 F Q=1:1 Q:$P(TS,"-",Q)=""!(TM<$P(TS,"-",Q))
 S X=ST\1,C=0 F Q=Q:1 D:$P(TS,"-",Q)="" ADD S C=C+1 I C=PSGDL S X=X_"."_$P(TS,"-",Q) G DONE
 ;
MWF ; if schedule is similar to monday-wednesday-friday
 S TS=$P(SCH,"@",2),SCH=$P(SCH,"@"),X=$P(ST,"."),C=0 D SCHK G:C=PSGDL DONE F Q=1:1 S X1=$P(ST,"."),X2=Q D C^%DTC S X1=X D DW^%DTC D CHK G:C=PSGDL DONE
SCHK S X1=X D DW^%DTC F Q=1:1:$L(SCH,"-") S WKD=$P(SCH,"-",Q) I WKD=$E(X,1,$L(WKD)) Q
 E  Q
 S TM=$E(ST_"00000",9,8+$L($P(TS,"-"))) F Q=1:1:$L(TS,"-") I TM<$P(TS,"-",Q) S C=C+1 I C=PSGDL S X=X1_"."_$P(TS,"-",Q) Q
 Q
 ;
DONE ;
 K %H,%T,%Y,MN,ND2,ND4,PSGDLS,PSGDL,Q1,QQ,SCH,TM,WKD,TS,X1,X2 Q
 ;
ADD ;
 S X1=$P(X,"."),X2=$S(MN&'(MN#1440):MN\1440,1:1) D C^%DTC S Q=1 Q
 ;
WRITE ;Calls EN^DDIOL to write text
 D EN^DDIOL(.PSJHLP) K PSJHLP Q
