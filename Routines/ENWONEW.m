ENWONEW ;(WASH ISC)/DH-Work Order Entry ;8.28.97
 ;;7.0;ENGINEERING;**1,35,42,43**;Aug 17, 1993
WARD ;  Entry point for Electronic Work Requests
 N SHOPKEY,CODE,NUMBER,DONE,WARD,DA,DIC,DIE,DR
 S U="^",DONE=0,WARD=1
 I $D(^DIC(6910,1,0)),$P(^(0),U,6)]"" S SHOPKEY=$P(^(0),U,6)
 E  S DIC="^DIC(6922,",DIC(0)="AEQ",DIC("S")="I Y#100>89" D ^DIC K DIC("S") S:Y>0 SHOPKEY=+Y
 Q:'$D(SHOPKEY)
 S DR=$S($D(^DIE("B","ENZWOWARD")):"[ENZWOWARD]",1:"[ENWOWARD]")
 D PROCS
 K ENBARCD
 Q
 ;
ENG ;  Entry point for Work Orders to be entered by Facility Management
 N CODE,NUMBER,DONE,WARD,SHOPKEY,ENDONE,DA,DIC,DIE,DR
 S U="^",(DONE,WARD)=0 S:$D(ENSHKEY) SHOPKEY=ENSHKEY
 I '$D(SHOPKEY) S DIC="^DIC(6922,",DIC(0)="AEQ" D ^DIC S:Y>0 SHOPKEY=+Y
 Q:'$D(SHOPKEY)
 S DR=$S($D(^DIE("B","ENZWONEW")):"[ENZWONEW]",1:"[ENWONEW]")
 D PROCS
 K ENBARCD
 Q
 ;
PROCS ;Main process (work order entry)
 N ENDA F  D  Q:DONE
 . W !!,"Want to enter a new work order?"
 . S DIR(0)="Y",DIR("B")=$S($D(CODE):"NO",1:"YES")
 . D ^DIR K DIR I Y'>0 S DONE=1 Q
 . S NUMBER="" D WONUM W:NUMBER]"" !,"WORK ORDER #: ",NUMBER
 . I NUMBER="" S DONE=1 D
 .. W !!,*7,"Can't seem to add to Work Order File."
 .. W !,"Please try again later or contact IRM Service."
 . Q:NUMBER=""
 . S ENDA=DA L +^ENG(6920,ENDA)
 . D WOFILL,WOEDIT D:NUMBER'="" WOPRNT L -^ENG(6920,ENDA)
 Q
 ;
WONUM ;Find next sequence number & use it
 ;Work order # returned in NUMBER, null if unsuccessful
 I '$D(DT) S %DT="",X="T" D ^%DT S DT=+Y
 Q:SHOPKEY'>0  I '$D(^DIC(6922,SHOPKEY,0)) Q
 S CODE=$P(^DIC(6922,SHOPKEY,0),U,2)_$E(DT,2,7)_"-"
 L +^ENG(6920,"B"):20 Q:'$T
 F I=1:1 S X=CODE_$S(I<10:"00"_I,I<100:"0"_I,1:I) I '$D(^ENG(6920,"B",X)),'$D(^ENG(6920,"H",X)) S NUMBER=X Q
 K DD,DO S DIC="^ENG(6920,",DIC(0)="LX" D FILE^DICN S DA=+Y S:DA'>0 NUMBER=""
 L -^ENG(6920,"B")
 Q
 ;
WOFILL ;Fill in known fields
 N DR
 S DIE="^ENG(6920,",DR="1///N;.05///"_NUMBER_";7.5////"_DUZ_";9///"_SHOPKEY
 D ^DIE
 Q:'WARD
 S DR="2///C;7///"_$E($P(^VA(200,DUZ,0),U),1,15)
 I $D(^VA(200,DUZ,.13)),$P(^(.13),U,2)]"" S DR=DR_";8///"_$P(^(.13),U,2)
 D ^DIE
 Q
 ;
WOEDIT ;Edit newly created work order (if desired)
 D ^DIE
 I $D(DTOUT) W !,"    FileMan has timed out due to inactivity.  Work Order DELETED.",*7 S DIK="^ENG(6920," D ^DIK K DIK,DTOUT S NUMBER="" Q
 I '$D(^ENG(6920,DA,1)) W !,"    Work Order DELETED.",*7 S DIK="^ENG(6920," D ^DIK K DIK S NUMBER="" Q
 I $P(^ENG(6920,DA,1),U,2)="" W !,"   Work Order DELETED.",*7 S DIK="^ENG(6920," D ^DIK K DIK S NUMBER="" Q
 I 'WARD D  Q:ENDONE
 . W !!,"Do you want to CLOSE this work order now?"
 . S DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR
 . S ENDONE=$S(Y'>0:0,1:1)
 . I ENDONE D  Q
 .. N DR
 .. S DR=$S($D(^DIE("B","ENZWONEWCLOSE")):"[ENZWONEWCLOSE]",1:"[ENWONEWCLOSE]")
 .. D ^DIE
 W !!,"Edit this new work order?"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR Q:Y'>0
 I WARD D ^DIE Q
 D EDIT1^ENWOD
 Q
 ;
WOPRNT ;Print new work order (if desired)
 N AUTOPRT,DEVICE
 I $D(^ENG(6910.2,1,0)),$P(^(0),U,2)]"" S:$P(^(0),U,2)'="N" AUTOPRT=$P(^(0),U,2)
 I '$D(ENBARCD) S ENBARCD=0 I $D(^ENG(6910.2,"B","PRINT BAR CODES ON W.O.")) S I=$O(^("PRINT BAR CODES ON W.O.",0)) I I>0,$P(^ENG(6910.2,I,0),U,2)="Y" S ENBARCD=1
 I $D(AUTOPRT) D
 . I AUTOPRT="L" D
 .. S DEVICE="" D AUTODEV^ENWONEW2
 .. I DEVICE="" D HOME^%ZIS Q
 .. I DEVICE="HOME" D  Q
 ... I $D(IO("S")) S IOP=ION,%ZIS="" D ^%ZIS
 ... D PRT1^ENWOD
 ... D HOLD^ENWOD2 K ENWO,ENDSTAT,ENX,ENINV
 ... D ^%ZISC
 .. S ZTRTN="PRT1^ENWOD",ZTDESC="Work Order Auto Print (Long)"
 .. S ZTDTH=$H
 .. D TASK
 . I AUTOPRT="S" D
 .. S DEVICE="" D AUTODEV^ENWONEW2
 .. I DEVICE="" D HOME^%ZIS Q
 .. N IOINLOW,IOINHI D ZIS^ENUTL
 .. I DEVICE="HOME" D  Q
 ... I $D(IO("S")) S IOP=ION,%ZIS="" D ^%ZIS
 ... D FDAT4^ENWOP3 D ^%ZISC
 ... K EN,ENAC,ENDPR,ENEQ,ENLOC,ENPRI,ENRDA,ENRQR
 ... K ENSTAT,ENTEC,ENWOR,ENY
 .. S ZTRTN="FDAT4^ENWOP3",ZTDESC="Work Order Auto Print (Short)"
 .. S ZTDTH=$H
 .. D TASK
 I WARD D  Q
 . W !,"Want to print this new work order?"
 . S DIR(0)="Y",DIR("B")="NO" D ^DIR Q:Y'>0
 . K IO("Q") S %ZIS="Q" D ^%ZIS I POP D HOME^%ZIS Q
 . I '$D(IO("Q")) D PRT1^ENEWOD Q
 . D
 .. S ZTRTN="PRT1^ENEWOD",ZTDESC="Electronic Work Order"
 .. D TASK
 .. K IO("Q")
 I '$D(AUTOPRT) D
 . W !,"Print this work order?"
 . S DIR(0)="Y",DIR("B")="YES" D ^DIR Q:Y'>0
 . D DEV^ENLIB I POP D HOME^%ZIS Q
 . I '$D(IO("Q")) D PRT1^ENWOD Q
 . D
 .. S ZTRTN="PRT1^ENWOD",ZTDESC="Engineering Work Order"
 .. D TASK
 .. K IO("Q")
 Q
 ;
TASK ;Print work order in background
 S ZTIO=ION,ZTSAVE("DA")="",ZTSAVE("EN*")=""
 D ^%ZTLOAD K ZTSK,ZTIO,ZTRTN,ZTDESC,ZTDTH,ZTSAVE D HOME^%ZIS
 Q
 ;ENWONEW
