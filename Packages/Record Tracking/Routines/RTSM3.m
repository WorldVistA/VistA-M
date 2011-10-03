RTSM3 ;MJK,PKE/TROY ISC;Site Manager's Menu(cont); ; 5/18/87  10:20 AM ;
 ;;v 2.0;Record Tracking;**14**;10/22/91 
9 ;;Initialize Records
 D BOTH^RTSM Q:'$D(RADPT)
 W !!?5,"This option will use the patients in the",$S(RADPT:" RADIOLOGY",1:"")," PATIENT file"
 W !?5,"as a base to create the necessary ",$S(RADPT:"film jacket",1:"folder")," entries in the"
 W !?5,"RECORDS file.  <This option does not print barcode labels.>"
 ;
NUM S Y=$S($D(^TMP("RTDFNSTART",+RTAPL)):+^(+RTAPL),1:1) W !!,"Start at DFN: ",Y,"// " R X:DTIME S:X="" X=Y W:X["?" !!,"Enter a number." G NUM:X["?",Q9:'$T!('X)!(X'?.N) S ^(+RTAPL)=X
 K RTERM,RTION,^TMP($J) S RTLOAD="LOAD^RTSM3",RTMES1=$S('RADPT:"MAS Patient Folder",1:"Radiology Film Jacket Entry")_" Creation:" G LOAD^RTSM1
Q9 K RADPT
 K X,%I,D Q
 ;
10 ;;Patient Record Labels
 S RTLOAD="PAT^RTSM3"
ASK D BOTH^RTSM G Q10:'$D(RADPT) S RTMES1=$S(RTLOAD["PAT":"P",1:"Inp")_"atient '"_$S(RADPT:"Film Jacket",1:"MAS Folder")_"' Label Creation:"
 K RTLDIV
 S RTRD(4)="Ldivision, Name^,for Last Registration, sort by name of patient"
 S RTRD(3)="Division, Digits^,for Last Registration, sort by Terminal digits"
 S RTRD(1)="Name^sort labels by name of patient"
 S RTRD(2)="Terminal Digits^sort by last 2 numbers of SSN",RTRD("B")=2,RTRD("A")="Sort sequence for labels? ",RTRD(0)="S" D SET^RTRD K RTRD S (X,RTXX)=$E(X) I X'="N",X'="T",X'="D",X'="L" G Q10
 G ASK1:RTLOAD["IN"!(X="N")!(X="L")
 ;I '$D(^UTILITY("RTDPTSORT","START")) W !!,*7,"The ^UTILITY(""RTDPTSORT"") global does NOT exist." D CHKQ^RTSM4 G Q10
 ;I $D(^UTILITY("RTDPTSORT","START")),'$D(^("FINISH")) S S=+$P(^("START"),"^",2) W !!,*7,"The ^UTILITY(""RTDPTSORT"") global is currently being compiled." D CHK^RTSM4 G Q10
 ;
 I $D(^RTV(194.3,1,0)),($E($P(^(0),"^",3),1,3))'=($E(DT,1,3)) DO  Q
 .W !!,*7,"The RECORD TRACKING SORT GLOBAL file(#194.3) "
 .I '$P(^(0),"^",2),'$P(^(0),"^",3) W "needs to be compiled"
 .;naked ref rtv(194.3,1,0)
 .E  I '$P(^(0),"^",3) W "is currently being compiled" D Q10 Q
 .E  W "needs additional compiling"
 .D CHKQ^RTSM4,Q10
 ;
ASK1 K RTERM I "TD"[RTXX D TERM^RTSM2 G Q10:'$D(RTERM) I RTXX="D" K RTLDIV D ^RTLDIV G Q10:'$D(RTLDIV)
 I RTXX="L" K RTLDIV D NAM^RTLDIV G Q10:'$D(RTLDIV)
 S:'$D(RTERM) RTERM="NAME" D PRT G LOAD^RTSM1:$D(RTION)
Q10 K RADPT,RTLOAD,RTMES1,RTERM
 K RTCXX,RTLDIV,X,J,DUOUT,RTXX,RTSTART Q
 ;
LOAD S DFN=$S($D(^TMP("RTDFNSTART",+RTAPL)):^(+RTAPL)-1,1:0)
 F DFN=DFN:0 S DFN=$O(^DPT(DFN)) Q:'DFN  I $D(^DPT(DFN,0)),$S('RADPT:1,$D(^RADPT(DFN,0)):1,1:0) S RTE=DFN_";DPT(" D RTTY^RTSM1 S ^TMP("RTDFNSTART",+RTAPL)=DFN
 K DFN Q
 ;
PAT ;Patient Label Creation
 I RTERM'="NAME" D PAT0 I 1
 E  D PAT1
 K RTRM0,RTRM1,DFN,RTNME,RTNME0,RTRM,RTTD,DFN Q
 ;
PAT0 F RTRM0=1:1 S RTRM=$P(RTERM,"^",RTRM0) Q:RTRM=""  DO
 .S RTTD=$S($D(RTSTART):RTSTART,1:RTRM_"0000000") K RTSTART
 .S RTRM1=0
 .FOR  S RTTD=$O(^RTV(194.3,1,1,"AC",RTTD)) Q:$E(RTTD,1,2)'=RTRM!(RTTD="")  DO
 . .S DFN=0
 . .F  S DFN=$O(^RTV(194.3,1,1,"AC",RTTD,DFN)) Q:'DFN  S X=^(DFN) D LB
 Q
PAT1 S RTNME="" F RTNME0=0:0 S RTNME=$O(^DPT("B",RTNME)) Q:RTNME=""  F DFN=0:0 S DFN=$O(^DPT("B",RTNME,DFN)) Q:'DFN  D:'$D(RTLDIV) LBL I $D(RTLDIV) S X=$O(^DPT(DFN,"DIS",0)) S X=$S('X:"",'$D(^(X,0)):"",X:$P(^(0),"^",4),1:"") D LB
 Q
LB I $D(RTLDIV) S RTLDV="^"_X_"^" I RTLDIV'[RTLDV K X,RTLDV Q
 ;
 ;
LBL I $D(^DPT(DFN,0)),$S('$D(^(.35)):1,'^(.35):1,1:0),$S('RADPT:1,$D(^RADPT(DFN,0)):1,1:0) S RTE=DFN_";DPT(" D RTTY^RTSM1 K RTE Q
 Q
 ;
11 ;;Inpatient Labels
 S RTLOAD="IN^RTSM3" G ASK
 ;
IN ;Inpatient Label
 S RTWARD="" F RTWARD1=0:0 S RTWARD=$O(^DPT("CN",RTWARD)) Q:RTWARD=""  F DFN=0:0 S DFN=$O(^DPT("CN",RTWARD,DFN)) Q:'DFN  D DFN:$S('RADPT:1,$D(^RADPT(DFN,0)):1,1:0)
 W !!,"Printing Labels..." S RTSORT=""
 F RTSORT1=0:0 S RTSORT=$O(^TMP($J,"RTSORT",RTSORT)) Q:RTSORT=""  F DFN=0:0 S DFN=$O(^TMP($J,"RTSORT",RTSORT,DFN)) Q:'DFN  S RTE=DFN_";DPT(" D RTTY^RTSM1:$D(^DPT(DFN,.1))
 K RTWARD,RTWARD1,DFN,RTE,RTSORT,RTSORT1
 K RTXX,X1 Q
DFN Q:'$D(^DPT(DFN,0))  S X=^(0) I RTERM'="NAME" S X=$P(^(0),"^",9) I X S:$D(RTERM($E(X,8,9))) ^TMP($J,"RTSORT",$E(X,8,9)_$E(X,6,7)_$E(X,1,5),DFN)="" Q
 I X S ^TMP($J,"RTSORT",$P(X,"^"),DFN)="" Q
 Q
 ;add check for barcode field, screen for virtual term?
PRT K RTION S DIC(0)="IAEMQ",DIC="^%ZIS(1,",DIC("A")="Select Label Printer: ",DIC("S")="I $D(^(""SUBTYPE"")),$D(^%ZIS(2,+^(""SUBTYPE""),0)),$E(^(0))=""P""" D ^DIC K DIC Q:Y<0  S RTION=$P(Y,"^",2)
 Q
 ;
