ENEQPMS5 ;(WASH ISC)/DH-Generate PM Work Orders ;4.10.98
 ;;7.0;ENGINEERING;**35,42,51**;Aug 17, 1993
 ;  Creates or finds work orders for a specified PM worklist
 ;  and then makes calls to print that document
 ;  Global ^TMP($J,... contains sort order and equip entry numbers
 ;
PR ;  Begin
 I '$D(^TMP($J,"ENWL")) W !!,"PM Worklist was requested, but there's nothing to print." Q
 N I,J,K,X,X1,EN,ENX,TECH,DA,DIC,DIE
 N H,W,SE,MULT,NODE,HDR,LINE,TIME,VACANT
 S ENLABOR=$P($G(^DIC(6910,1,0)),U,4)
 I IOM>93 S HDR="HDR96^ENEQPMS6",LINE="LN96^ENEQPMS7"
 E  S HDR="HDR80^ENEQPMS6",LINE="LN80^ENEQPMS7"
 D NOW^%DTC S Y=%,ENDATE=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_($E(Y,1,3)+1700)
 I HDR="HDR96^ENEQPMS6" X ^DD("DD") S TIME=$P(Y,":",1,2)
 S (TECH,ENPG,ENY)=0
 S ENEXPAND=0 S I=$O(^ENG(6910.2,"B","EXPANDED PM WORK ORDERS",0))
 I I>0,$P(^ENG(6910.2,I,0),U,2)="Y" S ENEXPAND=1
 U IO S X=""
 S NODE="^TMP($J,""ENWL"",0)",NODE=$Q(@NODE),SUB=$QL(NODE)
 S ENSHKEY=0 K ENXP
 F  Q:$G(X)="^"  S ENSHKEY=$O(^TMP($J,"ENWL",ENSHKEY)) D:ENSHKEY="" HOLD  Q:'ENSHKEY!($G(X)="^")  S:ENTECH'=0 ENEMP=$O(^TMP($J,"ENWL",ENSHKEY,"")) S DA=$QS(NODE,SUB),ENHZ=@NODE D PR1
 I $D(ENXP("LOCK")) W !!,"Abnormal termination. This worklist may be incomplete." H 5
 D TRLR
 G OUT ;Design EXIT
 ;
PR1 S ENSHOP=$P(^DIC(6922,ENSHKEY,0),U,1),ENSHABR=$P(^(0),U,2),ENCODE="PM-"_ENSHABR_ENPMDT_ENPM,X=""
 S ENWO=$O(^ENG(6920,"B",ENCODE_"-9999"),-1) S:ENWO'[ENCODE ENWO=ENCODE_"-001"
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
PR2 S ENHZ(1)=$P(ENHZ,U,2),SE=$P(ENHZ,U,3),MULT=$P(ENHZ,U,4),ENHZ=$P(ENHZ,U)
 S ENWOX="",X1=0 F  S X1=$O(^ENG(6920,"G",DA,X1)) Q:X1'>0  I $P($G(^ENG(6920,X1,0)),U)[ENCODE S ENWOX=$P(^(0),U) Q
 S X1=0 F  S X1=$O(^ENG(6914,DA,6,X1)) Q:X1'>0  I $P(^(X1,0),U,2)[ENCODE S ENWOX="*" Q
 Q:ENWOX="*"  ;PM already done
 G:ENWOX]"" PR3
 ;
PR22 ;  Must create a new work order
 L +^ENG(6920,"B"):20 I '$T S ENXP("LOCK")=1 Q
PR221 I $D(^ENG(6920,"B",ENWO))!($D(^ENG(6920,"H",ENWO))) S J=$P(ENWO,"-",3)+1,J=$S($L(J)=1:"00"_J,$L(J)=2:"0"_J,1:J),ENWO=$P(ENWO,"-",1,2)_"-"_J G PR221
 K DD,DO S DIC="^ENG(6920,",DIC(0)="LX",X=ENWO D FILE^DICN S ENNXL=+Y
 L:ENNXL>0 +^ENG(6920,ENNXL):1
 L -^ENG(6920,"B")
 I ENNXL'>0 S ENXP("LOCK")=1 Q
 S $P(^ENG(6920,ENNXL,0),U,2)=DT,$P(^ENG(6920,ENNXL,3),U,8)=DA,^ENG(6920,"G",DA,ENNXL)="",^ENG(6920,ENNXL,2)=ENSHKEY
 S X1=$O(^ENG(6920.1,"B","PREVENTIVE MAINTENANCE",0))
 I X1>0,$D(^ENG(6920.1,X1,0)) S ^ENG(6920,ENNXL,8,0)="^6920.035PA^1^1",^ENG(6920,ENNXL,8,1,0)=X1
 I $D(^ENG(6914,DA,3)) S EN=^(3),ENPMN=$P(EN,U,6),ENLOC=$P(EN,U,5) S:ENPMN]"" $P(^ENG(6920,ENNXL,3),U)=ENPMN,^ENG(6920,"E",ENPMN,ENNXL)="" I ENLOC]"",ENLOC?.N S $P(^ENG(6920,ENNXL,0),U,4)=ENLOC,^ENG(6920,"C",ENLOC,ENNXL)=""
 S $P(^ENG(6920,ENNXL,5),U,7)=ENHZ(1)_" PMI"
 S EN=$G(^ENG(6914,DA,4,SE,2,MULT,0)) I EN="" S ENDA=DA,DA=ENNXL,DIK="^ENG(6920," D:$E(^ENG(6920,DA,0),1,3)="PM-" ^DIK K DIK S DA=ENDA Q
 I $P(EN,U,4)]"" S ENLVL=$P(EN,U,4),$P(^ENG(6920,ENNXL,5),U,7)=$P(^ENG(6920,ENNXL,5),U,7)_" Level "_ENLVL
 I $P(EN,U,5)]"" S ENPRC=$P(EN,U,5),ENPROC(2)=$S($D(^ENG(6914.2,ENPRC,0)):$S($P(^(0),U,2)]"":$P(^(0),U,2),1:$P(^(0),U)),1:ENPRC),$P(^ENG(6920,ENNXL,5),U,7)=$P(^ENG(6920,ENNXL,5),U,7)_" "_ENPROC(2)
 I ENTECH=0 S TECH=$P(^ENG(6914,DA,4,SE,0),U,2) S:TECH="" TECH=0 I TECH>0 S:'$D(^ENG("EMP",TECH,0)) TECH=0
 S:TECH=0 ENEMP=0
 I TECH>0 D  ;Set ASSIGNED and RESPONSIBLE TECH
 . S $P(^ENG(6920,ENNXL,2),U,2)=TECH
 . S ^ENG(6920,ENNXL,7,0)="^6920.02PA^1^1",^ENG(6920,ENNXL,7,1,0)=TECH
 . S ENEMP=$P(^ENG("EMP",TECH,0),U)
 S ENDA=DA,DA=ENNXL D TEST^ENWOCOMP
 I ENEXPAND D ST^ENWOINV S:$D(^ENG(6920,DA,5)) $P(^(1),U,2)=$P(^(5),U,7)
 S DA=ENDA
 I $P(EN,U,2)]""!($P(EN,U,3)]"") D WOCST
 L -^ENG(6920,ENNXL)
 S ENWO(1)=ENWO,K=$P(ENWO,"-",3),K=K+1,K=$S($L(K)=1:"00"_K,$L(K)=2:"0"_K,1:K),ENWO=$P(ENWO,"-",1,2)_"-"_K
PR3 ;
 S:ENWOX="" ENWOX=ENWO(1) I ENY+11>IOSL D TRLR,@HDR Q:X="^"
 D @LINE
 Q
 ;
EMP S VACANT=0 I ENEMP=0 S TECH=0 Q
 S TECH=$O(^ENG("EMP","B",ENEMP,0)) I TECH'>0 S TECH=0 Q
 I '$D(^ENG("EMP",TECH,0)) S (TECH,ENEMP)=0 Q
 S:$P(^ENG("EMP",TECH,0),U,7)="V" VACANT=1
 Q
 ;
WOCST S W="" I $G(TECH)>0,$D(^ENG("EMP",TECH,0)) S W=$P(^(0),U,3)
 S:W="" W=ENLABOR
 S H=$P(EN,U,2) I $D(^ENG(6920,ENNXL,7,0)) S $P(^ENG(6920,ENNXL,7,1,0),U,2,3)=H_"^"_ENSHKEY
 I H>0 S $P(^ENG(6920,ENNXL,5),U,3)=H I W>0 S $P(^(5),U,6)=$J(H*W,0,2) ;Labor cost (est.)
 S $P(^ENG(6920,ENNXL,5),U,4)=$P(EN,U,3) ;Material cost (est.)
 Q
 ;
HOLD I $G(ENPG(0))>0,ENPG=ENPG(0),ENY'>7 W !!,"There are no incomplete PM work orders to print.",!
 I $E(IOST,1,2)="C-" R !,"Press <RETURN> to continue, '^' to escape...",X:DTIME S:'$T X=U
 Q
 ;
TRLR ;  Interpret PM STATUS and CONDITION CODE
 I ENPG,($E(IOST,1,2)'="C-"!($D(IO("S")))) D
 . F  Q:$Y>(IOSL-6)  W !
 . W "STATUS:  P=>Pass   C=>Corrective action   D0=>Deferred   D1=>Could not locate"
 . W !," D2=>In use   D3=>Out of service   CONDITION:  LN=>Like new  G=>Good  P=>Poor"
 . W !,"Y2K:  FC=>Fully compl  NC=>Non-compl  CC=>Conditionally compl  NA=>Not appl"
 . W !,"Techs may circle STATUS and/or CONDITION. Y2K CATEGORY is information only."
 Q
 ;
OUT K ENSHABR,ENCODE,ENWO,ENWOX,ENTECH,ENSRT,ENPG,ENY,ENPMN,ENID,ENMAN,ENMANF,ENMOD,ENSN,ENLID,ENLOC,ENPRC,ENPROC,ENDTYP,ENDVTYP,ENUSE,ENDA
 K ENHZ,ENLVL,ENEMP,ENNXL,ENNXT,ENSTAT,ENFNO,ENSRVC,ENWING,ENHRS,ENMAT,ENEXPAND,ENCOND,ENX,ENMFGR,ENLABOR,ENDATE
 K ^TMP($J)
 I $E(IOST,1,2)="P-",'$D(ZTQUEUED) D ^%ZISC
 Q
 ;ENEQPMS5
