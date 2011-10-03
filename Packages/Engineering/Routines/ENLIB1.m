ENLIB1 ;(WASH ISC)/DH-Package Utilities ;8/5/1998
 ;;7.0;ENGINEERING;**35,53**;Aug 17, 1993
MNTH S:'$D(ENMN) ENMN="" I ENMN']"" S ENMNTH="" Q
 S ENMNTH=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",ENMN)
 Q
RVMNTH I $D(ENMNTH),$L(ENMNTH)=3 S A=ENMNTH,ENMN=$S(A="JAN":1,A="FEB":2,A="MAR":3,A="APR":4,A="MAY":5,A="JUN":6,A="JUL":7,A="AUG":8,A="SEP":9,A="OCT":10,A="NOV":11,A="DEC":12,1:-1) K A Q
 S ENMN=-1
 Q
RDMNTH S ENMN="" R !,"Select MONTH: ",X:DTIME I X?1.2N,X>0,X<13 S ENMN=+X
 I X="^" S ENMN=-1 Q
 I ENMN="",X?.U S X=$E(X,1,3),ENMN=$S(X="JAN":1,X="FEB":2,X="MAR":3,X="APR":4,X="MAY":5,X="JUN":6,X="JUL":7,X="AUG":8,X="SEP":9,X="OCT":10,X="NOV":11,X="DEC":12,1:"")
 I X?3U,ENMN]"" W "   "_ENMN
 I ENMN="" W !,*7,"Enter month as an integer from 1 to 12." G RDMNTH
 Q
WOCMP S E(1)=$S($D(^ENG(6920,DA,2)):^(2),1:""),E(2)=$P(E(1),U,1) K:E(2)'=35 E Q:$D(E(2))=0  S E=$S($D(^(3)):^(3),1:"") F E(3)=3,6,7,9 K:$P(E,U,E(3))="" X I E(3)=9 K E
 Q
 ;
TECH ;Set ASSIGNED TECH from PRIMARY TECH
 ; called by File 6920 Field 16 "AG" cross-reference set logic
 ; Input DA = work order ien
 ;       X  = entered primary technican (pointer to file 6929)
 ; This code puts a newly entered primary techinician into the
 ; TECHNICIANS ASSIGNED multiple if not already there.
 N EN1,ENR,ENFNO,ENNXL,ENNXT
 Q:'$D(^ENG(6920,DA,2))
 S EN1=$P(^ENG(6920,DA,2),U,2) Q:EN1=""
 I '$D(^ENG("EMP",EN1,0)) Q
 I '$D(^ENG(6920,DA,7,0)) S ^ENG(6920,DA,7,0)="^6920.02PA^1^1",^ENG(6920,DA,7,1,0)=EN1_"^^"_$P(^ENG("EMP",EN1,0),U,10) Q
 F ENR=0:0 S ENR=$O(^ENG(6920,DA,7,ENR)) Q:ENR=""  I $D(^(ENR,0)),$P(^(0),U)=EN1 Q
 G:ENR]"" DNTECH
 S ENFNO=$P(^ENG(6920,DA,7,0),U,1,2),ENNXL=$P(^(0),U,3),ENNXT=$P(^(0),U,4)
TECH1 S ENNXL=ENNXL+1 I $D(^ENG(6920,DA,7,ENNXL)) G TECH1
 S ^ENG(6920,DA,7,ENNXL,0)=EN1_"^^"_$P(^ENG("EMP",EN1,0),U,10),ENNXT=ENNXT+1,^ENG(6920,DA,7,0)=ENFNO_U_ENNXL_U_ENNXT
DNTECH ;
 Q
 ;
INTECH ;Set PRIMARY TECH from ASSIGNED TECH
 ; called by File 6920.02 Field .01 "AE" cross-reference set logic
 ; Input DA(1) = work order ien (file 6920)
 ;       X     = entered technican (pointer to file 6929)
 ; If PRIMARY TECH ASSIGNED (#16) field in the Work Order (#6920) file
 ; is blank then this code will set it equal to the technician just
 ; entered in the 6920.02  subfile (TECHNICIANS ASSIGNED multiple).
 Q:'$D(DA(1))
 Q:$P($G(^ENG(6920,DA(1),2)),U,2)]""  ; primary tech not blank
 S $P(^ENG(6920,DA(1),2),U,2)=X
 Q
 ;
OUTECH ;Update PRIMARY TECH if same as deleted ASSIGNED TECH
 ; called by File 6920.02 Field .01 "AE" cross-reference kill logic
 ; Input DA(1) = work order ien (file 6920)
 ;       X     = deleted technician (pointer to file 6929)
 ; If technician just deleted from the 6920.02 subfile (TECHNICIANS
 ; ASSIGNED) is the primary tech of the work order then this code will
 ; update the PRIMARY TECH ASSIGNED (#16) field of the Work Order (#6920)
 N ENI,ENTECH,ENX
 Q:'$D(DA(1))
 Q:$P($G(^ENG(6920,DA(1),2)),U,2)'=X  ; not primary tech
 ; see if there is another assigned technician to use as primary tech
 S ENTECH=""
 S ENI=0 F  S ENI=$O(^ENG(6920,DA(1),7,ENI)) Q:'ENI  D  Q:ENTECH'=""
 . S ENX=$P($G(^ENG(6920,DA(1),7,ENI,0)),U)
 . I ENX'=X,ENX?1.N S ENTECH=ENX
 ; update primary tech
 S $P(^ENG(6920,DA(1),2),U,2)=ENTECH
 Q
 ;
CMR S IOP="HOME" D ^%ZIS W !,"This CMR is not currently in use. Enter 'A' to add it to the file, 'L' to",!,"see a list of active CMR's, or '^' to abort. L// "
 S R="" R R:DTIME I R'="","Ll"'[$E(R) G CMROUT
CMR1 S ENY=1,I=0 F J=0:0 S I=$O(^ENG(6914,"AD",I)) Q:I=""  W !,I S ENY=ENY+1 I (IOSL-ENY)<6 D CONT Q:R="^"
CMROUT Q:R="A"  W ! K ENY,I S X="" I $D(^ENG(6914,DA,2)) S X=$P(^(2),U,9)
 Q
 ;
IX ;Look-up X-ref ;Expects DIC,ENDX,X
 K EN N S,S1,I,X2,R S I=1,S=X,X2=$L(X),S1="",ENY=1
IX1 S S=$O(@(DIC_""""_ENDX_""",S)")) G:S="" IX2
 I $E(S,1,X2)=X W !,?5,I,?10,S S EN(I)=S,I=I+1,ENY=ENY+1 I (IOSL-ENY)<5 D CONT G:$E(R)="^" IX2
 I S?.N D IXNUM
 I $E(S,1,X2)=X!($E(S1,1,X2)=X) G IX1
 I X?.N S S=X_" ",S1=$O(@(DIC_""""_ENDX_""",S)")) I $E(S1,1,X2)=X G IX1
IX2 S X="" I I>1 S:$D(ENIX) ENIX=1 W !,"Select (1 to ",I-1,"): " R X:DTIME I X]"",X'="^" S X=$S($D(EN(X)):EN(X),1:"")
IXOUT K EN,ENY
 Q
IXNUM S S1=$O(@(DIC_""""_ENDX_""",S)"))
 I S1=+S1,$E(S1,1,X2)'=X S S=S1 G IXNUM
 Q
 ;
SWOPT ;Validate software option selection
 N Y S Y=$P($G(^ENG(6910.2,DA,0)),U) Q:Y=""
 I Y="ASK INCOMING INSPECTION W.O." K:"012"'[X X Q
 I Y="AUTO PRINT NEW W.O." K:"SLN"'[X X Q
 I Y="EQUIPMENT REPLACEMENT TEMPLATE" K:"SL"'[X X Q
 I Y="EXPANDED PM WORK ORDERS" K:X'="Y" X Q
 I Y="INVENTORY TEMPLATE" K:"SL"'[X X Q
 I Y="NOTIFY W.O. REQUESTOR" K:"CSA"'[X X Q
 I Y="PM DEVICE TYPE IDENTIFIER" K:"EM"'[X X Q
 I Y="PM SORT" K:"ECILPS"'[X X Q
 I Y="PRINT BAR CODES ON W.O." K:"NY"'[X X Q
 I Y="SAFETY PRINTOUT" K:"SL"'[X X Q
 I Y="SPACE SURVEY PRINTOUT" K:"SL"'[X X Q
 I Y="WARRANTY EXPIRATION TEMPLATE" K:"SL"'[X X Q
 Q
 ;
BLDG ;Called for Building File
 N X1,I1,X2
 S X2=$P(X,"-",2,3) I X2["-" W !,?7,"BUILDINGS may not contain more than one hyphen." K X Q
 I $D(X),X2'?.NU W "  Incorrect DIVISION format." K X Q
 S X1=$P(X,"-") Q:X1?.NU  F I1=1:1:$L(X1) I $E(X1,I1)'?1NU,"e. "'[$E(X1,I1) K X Q
 I '$D(X) W !,?7,"BUILDING not in proper format."
 Q
 ;
CONT S:$D(ENY) ENY=1 R !!,"<cr> to continue, '^' to stop...",R:DTIME
 Q
 ;ENLIB1
