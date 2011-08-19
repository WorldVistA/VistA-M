ENY2K5 ;(WASH ISC)/DH-Generate Y2K Work Orders ;7.15.99
 ;;7.0;ENGINEERING;**51,55,59,61**;Aug 17, 1993
 ;  Creates or finds work orders for a specified Y2K worklist
 ;  and then makes calls to print that document
 ;  Global ^TMP($J,"ENY2"... contains sort order and equip entry numbers
 ;
 ;  ENTECH indicates whether 'sort by tech' is in effect
 ;  TECH => IEN for Engineering Employee file
 ;    (0 => tech is undefined)
 ;  ENEMP => employee name as character string (could be "UNASSIGNED")
 ;
PR ;  Begin
 I '$D(^TMP($J,"ENY2")) D  Q
 . W !!,"A Y2K Worklist was requested, but there's nothing to print."
 . D NOW^%DTC S Y=% X ^DD("DD") W !,?5,"Run time: "_Y
 . W !,?5,"Shop: "_$S(ENSHKEY("SEL")="ALL":"ALL",1:$P(^DIC(6922,ENSHKEY("SEL"),0),U))
 . W !,?5,"Estimated Y2K Compliance Date: "_ENY2DT("E")
 N I,J,K,X,X1,EN,ENX,TECH,DA,DIC,DIE
 N H,W,SE,MULT,NODE,HDR,LINE,TIME,VACANT,SHOP
 I IOM>93 S HDR="HDR96^ENY2K6",LINE="LN96^ENY2K7"
 E  S HDR="HDR80^ENY2K6",LINE="LN80^ENY2K7"
 D NOW^%DTC S Y=%,ENDATE=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_($E(Y,1,3)+1700)
 I HDR="HDR96^ENY2K6" X ^DD("DD") S TIME=$P(Y,":",1,2)
 S (TECH,ENPG,ENY)=0,ENEXPAND=1
 U IO S X=""
 S NODE="^TMP($J,""ENY2"",0)",NODE=$Q(@NODE),SUB=$QL(NODE)
 S ENSHKEY=0,ENSHKEY(0)=$O(^TMP($J,"ENY2",0)) K ENXP
 F  Q:$G(X)="^"  S ENSHKEY=$O(^TMP($J,"ENY2",ENSHKEY)) D:ENSHKEY'=ENSHKEY(0) COMP D:ENSHKEY="" HOLD  Q:'ENSHKEY!($G(X)="^")  S:ENTECH'=0 ENEMP=$O(^TMP($J,"ENY2",ENSHKEY,"")) S DA=$QS(NODE,SUB),ENHZ=@NODE D PR1
 I $D(ENXP("LOCK")) W !!,"Abnormal termination. This worklist may be incomplete." H 5
 D TRLR
 G OUT ;Design EXIT
 ;
PR1 S ENSHOP=$P(^DIC(6922,ENSHKEY,0),U,1),ENSHABR=$P(^(0),U,2),ENCODE="Y2-"_ENSHABR_$E(DT,2,5),X=""
 S ENWO=$O(^ENG(6920,"B",ENCODE_"-9999"),-1)
 I ENWO'[ENCODE S ENWO=ENCODE_"-001"
 E  S J=$P(ENWO,"-",3)+1,J=$S($L(J)=1:"00"_J,$L(J)=2:"0"_J,1:J),$P(ENWO,"-",3)=J
 ;
 I ENTECH=0 D  Q  ;Worklist without RESP TECH
 . D TRLR,@HDR S ENPG(0)=ENPG F  Q:$G(X)="^"  D PR2 Q:$G(X)="^"  S NODE=$Q(@NODE) Q:$QS(NODE,3)'=ENSHKEY  S DA=$QS(NODE,SUB),ENHZ=@NODE Q:DA'>0
 ;
 D EMP ;With RESP TECH (may or may not be sorted by tech)
 D TRLR,@HDR S ENPG(0)=ENPG F  Q:$G(X)="^"  D PR2 Q:$G(X)="^"  S NODE=$Q(@NODE) Q:$QS(NODE,3)'=ENSHKEY  D  Q:DA'>0
 . I $QS(NODE,4)'=ENEMP S ENEMP=$QS(NODE,4) D EMP,TRLR,@HDR S ENPG(0)=ENPG
 . S DA=$QS(NODE,SUB),ENHZ=@NODE
 Q  ;Return to design EXIT
 ;
PR2 ;  need a work order?
 Q:'$D(^ENG(6914,DA,11))  S ENWOX="",ENWO("P")=$P(^ENG(6914,DA,11),U,8),ENWO("T")=$P(^(11),U,9)
 I ENWO("T")]"" D
 . S J=0 F  S J=$O(^ENG(6914,DA,6,J)) Q:J'>0  I $P(^ENG(6914,DA,6,J,0),U,2)=ENWO("T") S ENWOX="COMPLETE" Q
 I ENWOX="COMPLETE" S ^TMP($J,"ENY2","COMP",DA)=ENWO("T") Q  ; devices with completed Y2K work orders will not appear on worklist (don't need another work order)
 I ENWO("P")>0,$D(^ENG(6920,ENWO("P"),0)) S ENWOX=ENWO("T") D  Q
 . I $P($G(^ENG(6920,ENWO("P"),4)),U,3)=5 S ^TMP($J,"ENY2","COMP",DA)=ENWO("T") Q  ; wo exists, but is disapproved
 . D PR3 ; use existing Y2K work order
 I ENWO("T")]"" S ENWO=ENWO("T") D PR22,PR3 Q
 D PR22,PR3
 Q  ;back to program segment PR1
 ;
PR22 ;  must create a new work order from the top
 ;  ENWO as set in line PR1+1 or from ENWO("T")
 L +^ENG(6920,"B"):20 I '$T S ENXP("LOCK")=1 Q
 ;
PR221 I $D(^ENG(6920,"B",ENWO)) S J=$P(ENWO,"-",3)+1,J=$S($L(J)=1:"00"_J,$L(J)=2:"0"_J,1:J),ENWO=$P(ENWO,"-",1,2)_"-"_J G PR221
 I ENWO("T")="",$D(^ENG(6914,"AL",ENWO)) S J=$P(ENWO,"-",3)+1,J=$S($L(J)=1:"00"_J,$L(J)=2:"0"_J,1:J),ENWO=$P(ENWO,"-",1,2)_"-"_J G PR221
 S (X,ENWOX)=ENWO
 ;
PR222 ;  create a work order when you already have the number
 K DD,DO S DIC="^ENG(6920,",DIC(0)="LX",X=ENWO D FILE^DICN S ENNXL=+Y
 L:ENNXL>0 +^ENG(6920,ENNXL):1
 L -^ENG(6920,"B")
 I ENNXL'>0 S ENXP("LOCK")=1 Q
 S $P(^ENG(6914,DA,11),U,8)=ENNXL,$P(^(11),U,9)=ENWO,^ENG(6914,"AL",ENWO,DA)=""
 S $P(^ENG(6920,ENNXL,0),U,2)=DT,$P(^(0),U,6)=ENWO,$P(^ENG(6920,ENNXL,3),U,8)=DA,^ENG(6920,"G",DA,ENNXL)="",^ENG(6920,ENNXL,2)=ENSHKEY
 S X(1)=$O(^ENG(6920.1,"B","Y2K COMPLIANCE",0))
 I X(1)>0,$D(^ENG(6920.1,X(1),0)) S ^ENG(6920,ENNXL,8,0)="^6920.035PA^1^1",^ENG(6920,ENNXL,8,1,0)=X(1)
 I $D(^ENG(6914,DA,3)) S EN=^(3),ENPMN=$P(EN,U,6),ENLOC=$P(EN,U,5) S:ENPMN]"" $P(^ENG(6920,ENNXL,3),U)=ENPMN,^ENG(6920,"E",ENPMN,ENNXL)="" I ENLOC]"",ENLOC?.N S $P(^ENG(6920,ENNXL,0),U,4)=ENLOC,^ENG(6920,"C",ENLOC,ENNXL)=""
 S $P(^ENG(6920,ENNXL,5),U,7)=$S($P(^ENG(6914,DA,11),U,12)]"":$P(^(11),U,12),1:"YEAR 2000 compliance.") ; work performed
 I ENTECH=0 D  ; ENEMP not included in input global
 . S TECH=$P(^ENG(6914,DA,11),U,5) S:TECH="" TECH=0 I TECH>0 S:'$D(^ENG("EMP",TECH,0)) TECH=0
 . S:TECH>0 ENEMP=$P(^ENG("EMP",TECH,0),U)
 I TECH>0 D  ;Set ASSIGNED and RESPONSIBLE TECH
 . S $P(^ENG(6920,ENNXL,2),U,2)=TECH
 . S SHOP=$S($P(^ENG(6914,DA,11),U,7)]"":$P(^(11),U,7),$P(^ENG("EMP",TECH,0),U,10)]"":$P(^(0),U,10),1:"")
 . S ^ENG(6920,ENNXL,7,0)="^6920.02PA^1^1",^ENG(6920,ENNXL,7,1,0)=TECH_"^^"_SHOP
 S ENDA=DA,DA=ENNXL D TEST^ENWOCOMP
 I ENEXPAND D ST^ENWOINV S DIE="^ENG(6920,",DR="6///^S X=""Year 2000 compliance.""" D ^DIE
 S DA=ENDA
 I $P(EN,U,2)]""!($P(EN,U,3)]"") D WOCST
 L -^ENG(6920,ENNXL)
 S K=$P(ENWO,"-",3),K=K+1,K=$S($L(K)=1:"00"_K,$L(K)=2:"0"_K,1:K),ENWO=$P(ENWO,"-",1,2)_"-"_K ;increment in preparation for next hit
 Q
 ;
PR3 ;  do the printing
 I ENY+12>IOSL D TRLR,@HDR Q:$G(X)="^"
 D @LINE
 Q
 ;
EMP S VACANT=0 I ENEMP=0 S TECH=0 Q
 S TECH=$O(^ENG("EMP","B",ENEMP,0)) I TECH'>0 S TECH=0 Q
 I '$D(^ENG("EMP",TECH,0)) S (TECH,ENEMP)=0 Q
 S:$P(^ENG("EMP",TECH,0),U,7)="V" VACANT=1
 Q
 ;
WOCST Q
 ;
HOLD I $G(ENPG(0))>0,ENPG=ENPG(0),ENY'>7 W !!,"There are no incomplete Y2K work orders to print.",!
 I $E(IOST,1,2)="C-" R !,"Press <RETURN> to continue, '^' to escape...",X:DTIME S:'$T X=U
 Q
 ;
TRLR ;  Interpret PM STATUS and CONDITION CODE
 I ENPG,($E(IOST,1,2)'="C-"!($D(IO("S")))) D
 . F  Q:$Y>(IOSL-4)  W !
 . K K S $P(K,"-",(IOM-1))="-" W K K K
 . W !,"FC=>Y2K compliant  NC=>Y2K non-compliant  NA=>Not applicable (no Y2K issues)"
 . W !,"CNL=>Could not locate   TI=>Turned-in"
 Q
 ;
COMP ;  devices with completed Y2K work orders (exception messages)
 Q:'$D(^TMP($J,"ENY2","COMP"))  ; no exceptions
 S ENPG=ENPG+1 D HOLD
 W @IOF,"DEVICES WITH COMPLETED Y2K WORK ORDERS   "_ENDATE_"  Page "_ENPG
 W !!,"The following device(s) have a Y2K CATEGORY of CONDITIONALLY COMPLIANT and",!,"yet their Y2K work order(s) are complete. They are not being printed on",!,"this Y2K worklist."
 W !!,"You should probably use the 'Manual Equipment Selection for Y2K' option to",!,"change their Y2K CATEGORY to COMPLIANT."
 K X S $P(X,"-",(IOM-2))="-" W !,X,!
 S DA=0 F  S DA=$O(^TMP($J,"ENY2","COMP",DA)) Q:'DA  W !,?10,DA,?25,"("_^TMP($J,"ENY2","COMP",DA)_")"
 K ^TMP($J,"ENY2","COMP")
 Q
 ;
OUT K ENSHABR,ENCODE,ENWO,ENWOX,ENTECH,ENSRT,ENPG,ENY,ENPMN,ENID,ENMAN,ENMANF,ENMOD,ENSN,ENLID,ENLOC,ENPRC,ENPROC,ENDTYP,ENDVTYP,ENUSE,ENDA
 K ENHZ,ENLVL,ENEMP,ENNXL,ENNXT,ENSTAT,ENFNO,ENSRVC,ENWING,ENHRS,ENMAT,ENEXPAND,ENCOND,ENX,ENMFGR,ENLABOR,ENDATE
 K ^TMP($J)
 I $E(IOST,1,2)'="C-",'$D(ZTQUEUED) D ^%ZISC
 D HOME^%ZIS
 Q
 ;ENY2K5
