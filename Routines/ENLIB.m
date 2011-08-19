ENLIB ;(WASH ISC)/JED/SAW/DH-Package Utilities ;2.17.98
 ;;7.0;ENGINEERING;**35,45,47,48**;Aug 17, 1993
 ;
ENOUT ;ENGINEERING OUTPUT PORT SELECTOR DLM/WASH; 27 JUL 84  8:01 AM
DEV ;DEVICE SELECTION ;devices may be suppressed from listing
 W !!,"Select output device:  ",!,?3,"RETURN",?13,"DISPLAY"
 I '$D(ENXP("NOLIST")) S ENOT="" F  S ENOT=$O(^DIC(6910.1,"B",ENOT)) Q:ENOT=""  S ENOT(0)=$O(^(ENOT,0)) D:ENOT(0)
 . I '$P(^DIC(6910.1,ENOT(0),0),U,4) W !,?3,$P(^(0),U,2),?13,$P(^(0),U,3)
 K ENOT,IO("Q") W ! S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS Q
DEVSHOW ;DEVICE SELECTION
 W !!,"Select output device:  ",!,?3,"RETURN",?13,"DISPLAY"
 S ENOT="" F I=1:1 S ENOT=$O(^DIC(6910.1,"B",ENOT)) Q:ENOT=""  W !,?3,$P(^DIC(6910.1,$O(^DIC(6910.1,"B",ENOT,"")),0),"^",2),?13,$P(^(0),"^",3)
 K ENOT,I W ! S %ZIS("B")="HOME" Q
 ;
 ;SAW/WASH ; 28 AUG 84  6:14 pm
FYS ;SELECT FISCAL YEAR AND QUARTER THEN SELECT DEVICE
 S ENFYT("I")=$E(DT,1,3) I $E(DT,4,7)>1000 S ENFYT("I")=ENFYT("I")+1
 S I=+$E(DT,4,5),ENFYT=$E(ENFYT("I"),2,3),ENQTT=$P("2^2^2^3^3^3^4^4^4^1^1^1","^",I)
FYS1 W !,"SELECT FISCAL YEAR: ",ENFYT,"//" R ENFY:DTIME G EXIT:'$T S:ENFY="" ENFY=ENFYT G:ENFY="^" EXIT I ENFY'?2N G FYS1
QTRS W !,"SELECT QUARTER: ",ENQTT,"//" R ENQT:DTIME G EXIT:'$T S:ENQT="" ENQT=ENQTT G:ENQT="^" EXIT I ENQT<1!(ENQT>4) G QTRS
 K ENFYT,ENQTT G DEV
 ;
FYSONLY ;SELECT FISCAL YEAR AND QUARTER
 S ENFYT("I")=$E(DT,1,3) I $E(DT,4,7)>1000 S ENFYT("I")=ENFYT("I")+1
 S ENFYT=$E(ENFYT("I"),2,3)
FYS1ON W !,"SELECT FISCAL YEAR: ",ENFYT," //" R ENFY:DTIME G EXIT:'$T S:ENFY="" ENFY=ENFYT G:ENFY="^" EXIT I ENFY'?2N G FYS1ON
 K ENFYT Q
 ;
FYQTS ;SELECT FISCAL YEAR AND QUARTER ONLY
 S ENFYT("I")=$E(DT,1,3) I $E(DT,4,7)>1000 S ENFYT("I")=ENFYT("I")+1
 S I=+$E(DT,4,5),ENFYT=$E(ENFYT("I"),2,3),ENQTT=$P("2^2^2^3^3^3^4^4^4^1^1^1","^",I)
FYQTS1 W !,"SELECT FISCAL YEAR: ",ENFYT,"//" R ENFY:DTIME G EXIT:'$T S:ENFY="" ENFY=ENFYT G:ENFY="^" EXIT I ENFY'?2N G FYQTS1
QTS W !,"SELECT QUARTER: ",ENQTT,"//" R ENQT:DTIME G EXIT:'$T S:ENQT="" ENQT=ENQTT G:ENQT="^" EXIT I ENQT<1!(ENQT>4) G QTS
 K ENFYT,ENQTT Q
EXIT K ENFYT,ENFY,ENQTT,ENQT Q
 ;
ROUND ;Round off number
 ;Number in X
 ;Dec places in X(0)
 S ENA=$P(X,".",1),ENB=$P(X,".",2) I X(0)=0 S Y=ENA G DNRND
 I $L(ENB)'>X(0) S Y=ENA_"."_ENB G DNRND
 S X(1)=$E(ENB,X(0)) I $E(ENB,X(0)+1)>4 S X(1)=X(1)+1
 S Y=ENA_"."_$E(ENB,1,(X(0)-1))_X(1)
DNRND K ENA,ENB,X
 Q
 ;
ROOM ;  Check for allowable format
 N X1
 S X1=$TR($P(X,"-"),"e","E") Q:X1?.NUP
 D EN^DDIOL("       ROOM is not in proper format.") K X
 Q
 ;
BLDG ;  Called when BUILDING is not in the file
 N X1
 S X1(1)="  The BUILDING (including DIVISION, if applicable) portion of the ROOM"
 S X1(2)="  NUMBER must be defined in your Building File (6928.3) before this ROOM"
 S X1(3)="  NUMBER may be added to your Space File."
 S X1(4)="  In this case, "_$P(X,"-",2,3)_" does not appear to be in your Building File."
 D EN^DDIOL(.X1)
 Q
 ;
VENPRE ;  Vendor pre-action from ENG DJ screen handler
 ;  DA => IEN for file 6914
 ;  Needed because post-action on acquisition won't execute on deletes
 ;
 I $P($G(^ENG(6914,DA,3)),U,4)="L",$P($G(^(2)),U,3)]"" S DJNX=12,V(14)="",$P(^(2),U,3)="",DJSV=V D N^ENJDPL S V=DJSV ;clear asset value if LEASE
 I "^L^M^"'[(U_$P($G(^ENG(6914,DA,3)),U,4)_U),$P($G(^(2)),U,12)]"" S DJNX=12,V(13)="",$P(^(2),U,12)="",DJSV=V D N^ENJDPL S V=DJSV ;clear lease cost if not LEASE or CAPITAL LEASE
 Q
 ;
X ;EXIT FOR THE INCONSISTENT RESPONSE
 W *7,!,"TRY LATER"
Q ;EXIT POINT
 K %,%DT,%X,%Y,DQTIME,J,X,Y,ZTSK Q
 ;ENLIB
