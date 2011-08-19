PRCPAGPR ;WISC/RFJ/DXH - autogen primary or whse order (rep item list)   ;9.28.99
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
GETRIL() ;  get repetitive item list
 ;  returns repetitive item list number
 N %,CONTPT,COSTCNTR,COUNT,PRCPFLAG,PRCPREPN,PRCSFYT,PRCSQTT,X,Y
 S COSTCNTR=$P($G(^PRCP(445,PRCP("I"),0)),"^",7) I 'COSTCNTR,PRCP("DPTYPE")="W" S COSTCNTR=+$$SUPPLYCC^PRCSCK()
 I 'COSTCNTR W !!,"COST CENTER IS MISSING FOR THIS INVENTORY POINT." Q ""
 W !!,"COST CENTER: ",COSTCNTR
 ;  get control points
 S CONTPT=$$CONTPT(PRC("SITE"),PRCP("I"),COSTCNTR) I 'CONTPT Q ""
 S PRC("CP")=$P($P($G(^PRC(420,PRC("SITE"),1,CONTPT,0)),"^")," ")
 K PRC("FY") D FY^PRCSUT I PRC("FY")["^" Q ""
 K PRC("QTR") D QT^PRCSUT I PRC("QTR")["^" Q ""
 S PRCPREPN=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_PRC("CP")_"-"_COSTCNTR W !!,"I will generate requests for: ",PRCPREPN
 S IOP="HOME" D ^%ZIS K IOP,^TMP($J,"PRCPAGPR")
 S COUNT=1,X=PRCPREPN F  S X=$O(^PRCS(410.3,"B",X)) Q:X=""!($P(X,"-",1,5)'=PRCPREPN)!($G(PRCPFLAG))  S Y=0 F  S Y=$O(^PRCS(410.3,"B",X,Y)) Q:'Y!($G(PRCPFLAG))  D
 .   S %=$G(^PRCS(410.3,Y,0)) I %="" Q
 .   I $P(%,"^",3)'=PRCP("I") Q
 .   I COUNT=1 W !!,"You currently have the following repetitive item lists on file:"
 .   S COUNT=COUNT+1,^TMP($J,"PRCPAGPR",Y)=""
 .   W !?5,X,?35,"created: ",$E($P(%,"^",4),4,5),"-",$E($P(%,"^",4),6,7),"-",$E($P(%,"^",4),2,3),?60,"item count: ",+$P($G(^PRCS(410.3,Y,1,0)),"^",4)
 .   I COUNT#(IOSL-4)=0 D P^PRCPUREP
 I $G(PRCPFLAG) K ^TMP($J,"PRCPAGPR") Q ""
 I $O(^TMP($J,"PRCPAGPR",0)) D  I $G(PRCPFLAG) K ^TMP($J,"PRCPAGPR") Q ""
 .   S XP="Do you want to DELETE all the repetitive item lists on file",XH="Enter 'YES' to delete ALL the repetitive item lists displayed above, 'NO' to",XH(1)="NOT delete them, '^' to exit."
 .   W ! S %=$$YN^PRCPUYN(2)
 .   I %=2 Q
 .   I %'=1 S PRCPFLAG=1 Q
 .   ;  delete repetitive item lists on file
 .   W !,"    deleting repetitive item lists..."
 .   S COUNT=0 F  S COUNT=$O(^TMP($J,"PRCPAGPR",COUNT)) Q:'COUNT  D DELRIL(COUNT)
 K ^TMP($J,"PRCPAGPR")
 Q PRCPREPN
 ;
 ;
CONTPT(V1,V2,V3) ;  get control point tied to invpt
 ;  v1=station number
 ;  v2=inventory point da
 ;  v3=costcenter
 N CONTPT,COUNT,DA,DIC,PRCPCC,PRCPINPT,PRCPSTAT,X,Y,Y1
 S PRCPSTAT=+V1,PRCPINPT=+V2,PRCPCC=+V3
 S PRCPINPT("E")=$$GET1^DIQ(445,PRCPINPT,.01)
 S DIC("S")="I $D(^PRC(420,""C"",DUZ,PRCPSTAT,+Y)),$D(^PRC(420,""AE"",PRCPSTAT,PRCPINPT,+Y)),$S($P(^PRC(420,PRCPSTAT,1,+Y,0),U,12)=2:1,1:$D(^PRC(420,PRCPSTAT,1,+Y,2,PRCPCC,0)))"
 ; look for control points that user has access to
 S (COUNT,CONTPT,Y,Y1)=0 F  S Y=$O(^PRC(420,"AE",PRCPSTAT,PRCPINPT,Y)) Q:'Y  D
 . S Y1=Y1+1,COUNT("PRCP",Y1)=$P(^PRC(420,PRCPSTAT,1,+Y,0),U)
 . I $D(^PRC(420,"C",DUZ,PRCPSTAT,+Y)) S $P(COUNT("PRCP",Y1),U,2)=1
 . I ($P(^PRC(420,PRCPSTAT,1,+Y,0),U,12)=2)!($D(^PRC(420,PRCPSTAT,1,+Y,2,PRCPCC,0))) S $P(COUNT("PRCP",Y1),U,3)=1
 . Q:'$P(COUNT("PRCP",Y1),U,2)!('$P(COUNT("PRCP",Y1),U,3))
 . S CONTPT=Y,COUNT=COUNT+1
 I 'COUNT D  Q ""
 . I 'Y1 W !!,"No FUND CONTROL POINTS tied to INVENTORY POINT '"_PRCPINPT("E")_"'." Q
 . I Y1=1 D  Q
 .. W !!,"FUND CONTROL POINT '"_$P(COUNT("PRCP",Y1),U)_"' is tied to INVENTORY POINT"
 .. W !,"'"_PRCPINPT("E")_"', but "
 .. I '$P(COUNT("PRCP",Y1),U,3) W "it does not include COST CENTER "_PRCPCC W $S('$P(COUNT("PRCP",Y1),U,2):" and",1:".") W:'$P(COUNT("PRCP",Y1),U,2) !
 .. W:'$P(COUNT("PRCP",Y1),U,2) "you lack control point access." W " Can't proceed."
 . W !!,"These FUND CONTROL PTS are tied to INVENTORY POINT '"_PRCPINPT("E")_"':"
 . S Y1=0 F  S Y1=$O(COUNT("PRCP",Y1)) Q:'Y1  W !,?2,$E($P(COUNT("PRCP",Y1),U),1,20),?25 W:'$P(COUNT("PRCP",Y1),U,2) "You lack access. " W:'$P(COUNT("PRCP",Y1),U,3) "COST CENTER "_PRCPCC_" is not included."
 . W !,"Indicated deficiencies must be corrected before we can proceed."
 I COUNT=1,CONTPT S Y=$P($G(^PRC(420,PRCPSTAT,1,CONTPT,0)),"^") I Y'="" W !!,"FUND CONTROL POINT: ",Y Q CONTPT
 S DIC="^PRC(420,"_PRCPSTAT_",1,",DIC(0)="QEAM",DA=PRCPSTAT W ! D ^DIC
 Q $S(Y'>0:0,1:+Y)
 ;
 ;
DELRIL(V1) ;  delete repetitive item list da=v1
 I '$D(^PRCS(410.3,+V1,0)) Q
 N DA,DIC,DIK
 S DIK="^PRCS(410.3,",DA=+V1 D ^DIK Q
 ;
 ;
NEWRIL(V1,V2) ;  add a new repetitve item list
 ;  v1=invpt da
 ;  v2=number to add
 ;  returns da of entry added
 N %,%DT,D0,DA,DI,DIC,DIE,DLAYGO,DQ,DR,INVPT,X,Y
 S INVPT=V1,(PRCPREPN,X)=V2
 D EN1^PRCUTL1(.X) I X="" Q ""
 S DIC="^PRCS(410.3,",DIC(0)="L",DLAYGO=410.3,DIC("DR")="3////"_INVPT_";4///NOW" K DD,D0 D FILE^DICN
 Q $S(Y'>0:0,1:Y)
 ;
 ;
ADDITEM(V1,V2,V3,V4,V5) ;  add items to repetitive item list
 ;  v1=repetitive item list da
 ;  v2=item master number
 ;  v3=qty
 ;  v4=vendor da
 ;  v5=cost
 ;  returns entry number
 I '$D(^PRCS(410.3,+V1,0)) Q ""
 I '$D(^PRCS(410.3,+V1,1,0)) S ^(0)="^410.31IPA^^"
 I '$D(^PRC(441,+V2,0)) Q ""
 I '$D(^PRC(441,+V2,2,0)) S ^(0)="^441.01IP^^"
 N %,D0,DA,DD,DI,DIC,DIE,DLAYGO,DQ,DR,VENDOR,X,Y
 S VENDOR=$P($G(^PRC(440,+V4,0)),"^")
 S (DIC,DIE)="^PRCS(410.3,"_+V1_",1,",DIC(0)="L",DLAYGO=410.3,DA(1)=+V1,X=+V2,DIC("DR")="1////"_+V3_";2////"_VENDOR_";3////"_+V5_";4////"_+V4
 D FILE^DICN
 Q $S(Y'>0:0,1:+Y)
