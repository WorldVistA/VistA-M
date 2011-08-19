RTSM1 ;TROY ISC/MJK,PKE-Record File Initialization Utility ; 5/21/87  4:06 PM ; 1/7/03 11:51am
 ;;2.0;Record Tracking;**4,14,34**;10/22/91
RTTY ;
 F RTHOLD=0:0 S RTHOLD=+$O(RTHOLD(RTHOLD)) Q:'RTHOLD  S RTTY=RTHOLD(RTHOLD) S RT=+$O(^RT("AT",+RTTY,RTE,0)) D CREATE:'RT,LBL:RTION]""
 S RTCNTP=RTCNTP+1 I '(RTCNTP#50) H $S(RTION="":0,1:$S($D(^DIC(195.4,1,"COOL")):^("COOL"),1:0))*60 I '(RTCNTP#100) W !,RTCNTP," patients processed. " D NOW^%DTC S Y=$E(%,1,12) D DT^DIQ
 K RT,RTTY Q
 ;
CREATE ;
 D CREATE^RTDPA1 S:RT RTCNTR=RTCNTR+1 Q
 ;
LBL ;
 H 8 S RTFMT=+$P(RTTY,"^",5) I $D(^DIC(194.4,RTFMT,0)) S IOP=RTION D ^%ZIS K IOP S RTNUM=1,RTIFN=RT U IO D PRT^RTL1 S RTCNTL=RTCNTL+1 Q
 ;
LOAD ;Entry load record from DPT
 ;MUST:
 ; RTAPL
 ; RTMES
 ; RTLOAD
 ; RTDIV
 ; RADPT
 ;
 ;optional:
 ; RTION  -  'name' of printer to labels on (null for no labels)
 ; RTERM  -  list of terminal digits or 'NAME'
 ;
 D SEL^RTSM2 G Q:'$D(RTHOLD) S RTVAR="RADPT^RTDIV^RTMES1^RTLOAD^RTHOLD^RTAPL"_$S($D(RTION):"^RTION",1:"")_$S($D(RTERM):"^RTERM",1:"")_$S($D(RTSTART):"^RTSTART",1:""),RTPGM="START^RTSM1" D ZIS^RTUTL G Q:POP
START K ^TMP($J),RTSHOW,RTADM S (RTCNTR,RTCNTP,RTCNTL)=0,RTBKGRD="" D HOLD S:'$D(RTION) RTION=""
 I $D(RTERM),RTERM'="NAME" F I=1:1 Q:$P(RTERM,"^",I)=""  S RTERM($P(RTERM,"^",I))=""
 W @IOF,!,RTMES1,!!?5,"START TIME: " D NOW^%DTC S Y=$E(%,1,12) D DT^DIQ W !!,"Log",!,"---" D @RTLOAD
 W !,"[TOTAL PATIENTS PROCESSED       : ",RTCNTP,"]"
 W !,"[TOTAL NUMBER OF RECORDS CREATED: ",RTCNTR,"]"
 W !,"[TOTAL RECORD LABELS CREATED    : ",RTCNTL,"]"
 W !!?5,"STOP TIME: " D NOW^%DTC S Y=$E(%,1,12) D DT^DIQ W !
 I RTION]"" S IOP=RTION D ^%ZIS K IOP U IO W !
Q K ^TMP($J),RTERM,RADPT,RTHOLD,RTION,RTMES1,RTLOAD,RTN,RTHOLD,RTBKGRD,RTCNTP,RTCNTL,RTCNTR,RTTY D CLOSE^RTUTL
 K DA,D0,DIC,DIE,DR,I,I1,RTE,RTPGM,RTVAR,RTBC,RTJ,RTPGM,RTXX,X1,Y Q
HOLD F I1=1:1 Q:'$P(RTHOLD,"^",I1)  S Y=$P(RTHOLD,"^",I1) D TYPE1^RTUTL S:$D(RTTY) RTHOLD(Y)=RTTY
 K I1,RTTY Q
 ;
 ;
SORT D NOW^%DTC S $P(^RTV(194.3,1,0),"^",2,3)=%_"^"
 S (DFN,LDFN)=$S($D(^RTV(194.3,1,1,0)):+$P(^(0),"^",3),1:0)
 ;just set it the first time
 I 'DFN D ONETIM^RTSM4,QS Q
 ;check for new records
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  DO
 .S LDFN=DFN
 .I '$D(^RTV(194.3,1,1,DFN,0)) D FILE W:'$D(ZTQUEUED) "." Q
 ;verify/update old records
 S (RTCT,TD)=0 F  S TD=$O(^RTV(194.3,1,1,"AC",TD)) Q:TD=""  DO
 .S DFN=0 F  S DFN=$O(^RTV(194.3,1,1,"AC",TD,DFN)) Q:'DFN  DO
 . .I '$D(^DPT(DFN,0)) K ^RTV(194.3,1,1,"AC",TD,DFN) S DA(1)=1,DA=DFN,DIK="^RTV(194.3,1,1," D ^DIK K DE,DQ Q
 . .S SSN=$P(^DPT(DFN,0),"^",9),RTCT=RTCT+1
 . .I '$D(ZTQUEUED),DFN#1000=0 W ","
 . .I TD'=($E(SSN,8,9)_$E(SSN,6,7)_$E(SSN,1,5)) DO
 . . .;get rid of old xref and entry
 . . .K ^RTV(194.3,1,1,"AC",TD,DFN)
 . . .S DA(1)=1,DA=DFN,DIK="^RTV(194.3,1,1," D ^DIK K DE,DQ
 . . .;update new one
 . . .D FILE Q
QS ;update for next time
 D NOW^%DTC S $P(^RTV(194.3,1,0),"^",3)=%
 S $P(^RTV(194.3,1,1,0),"^",3,4)=LDFN_"^"_RTCT
 K RTCT,LDFN,TD,DFN,SSN,DA,DIC,DIK,DR Q
 ;
FILE I '$D(^RTV(194.3,1,1,0)) S ^(0)="^194.31PA^0^0"
 S DIC="^RTV(194.3,1,1,",DIC(0)="L",DIC("DR")="1///`"_DFN
 K DD,DO S (X,DINUM)=DFN D FILE^DICN Q
 ;
12 ;;Create Terminal Digit Sort Global
 W !!,"RECORD TRACKING SORT GLOBAL Compilation" S Y=""
 I $D(^RTV(194.3,1,0)),$P(^(0),"^",2),$P(^(0),"^",3) DO
 .W !!,*7,"The SORT global already exists.",!?11,"Compilation started: "
 .S Y1=$P(^(0),"^",2,3),Y=$P(Y1,"^") D DT^DIQ ;naked rtv(194.3,1,0)
 .I $S('$D(^RTV(194.3,1,1,0)):1,'$P(^(0),"^",3):1,1:0) Q
 .W !?8,"Last patient processed: ",$P(^(0),"^",3) ;nakd rtv(194.3,1,1,0
 .W !?8,"  Compilation finished: "
 .S Y=$P(Y1,"^",2) D DT^DIQ
 .K Y
 S RTRD(1)="Yes^queue job",RTRD(2)="No^not queue job",RTRD(0)="S",RTRD("B")=2,RTRD("A")="Do you wish to queue a job that will "_$S('$D(Y):"Update-",1:"")_"compile this global? " D SET^RTRD K RTRD G Q12:$E(X)'="Y"
 S RTVAR="",(ION,IOM,IOST)="",RTPGM="SORT^RTSM1" D Q^RTUTL K RTVAR,RTPGM S IOP="" D ^%ZIS
 ;
Q12 K IOP,X1,Y,RTVAR,RTPGM,X,X1,Y1 Q
 ;
13 ;;Delete Terminal Digit Sort Global
 W !,"It is not usually necessary to delete this global, just compile it"
 S RTRD(0)="S",RTRD(1)="Yes^delete global",RTRD(2)="No^keep global",RTRD("A")="Are you sure you want to delete the RT SORT GLOBAL entries? ",RTRD("B")=2 D SET^RTRD K RTRD
 I $E(X)="Y" DO
 .K ^RTV(194.3,1,1)
 .;reset nodes
 .S ^RTV(194.3,1,0)="TERMINAL DIGITS^^"
 .S ^RTV(194.3,1,1,0)="^194.31PA^^"
 .W !?3,"...deleted"
 K Y,X,X1 Q
 ;
 ;set logic 194.3 ac xref
S1943 I $D(^DPT(X,0)) S SSN=$P(^(0),"^",9),DOB=$P(^(0),"^",3) I SSN,DOB DO
 .S DVBDIS=$O(^DPT(X,"DIS",0)) I 'DVBDIS
 .E  S DVBDIS=$S('$D(^(DVBDIS,0)):"",1:$P(^(0),"^",4)) ;nakd dpt(x,dis,0)
 .S ^RTV(194.3,1,1,"AC",$E(SSN,8,9)_$E(SSN,6,7)_$E(SSN,1,5),X)=DVBDIS
 K SSN,DOB,DVBDIS Q
 ;
 ;kill logic 194.3 ac xref
K1943 I $D(^DPT(X,0)) S SSN=$P(^(0),"^",9),DOB=$P(^(0),"^",3) I SSN,DOB DO
 .K ^RTV(194.3,1,1,"AC",$E(SSN,8,9)_$E(SSN,6,7)_$E(SSN,1,5),X)
 K SSN,DOB Q
