LRLL1A ;SLC/RWF - LOAD LIST CONTROL ; 2/23/89  17:29 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
L1 W !,"All urgencys" S %=1,LRURX="I 1" D YN^DICN G END:%=-1 I %=0 W !,"Build the list with all urgencys or with a range." G L1
 I %=2 S DIC="^LAB(62.05,",DIC("S")="I '$P(^(0),U,3)",DIC(0)="AEMQ",DIC("A")="Most Urgent:" D ^DIC G END:Y<.1 S L1=+Y,DIC("A")="Least Urgent:" D ^DIC G END:Y<.1 S LRURX="I LRUS'<"_+L1_"&(LRUS'>"_+Y_")"
L2 W !,"1  Allow splitting tests from each accession between load/worklists.",!,"2  Require all tests to build or build none at all (for each accession).",!,"Choose: 1//" R X:DTIME G:X="^" END I X'="",'(X=1!(X=2)) W !,"Enter 1 or 2." G L2
 S LRSPLIT=(X'=2),DUOUT=0
 D CLEAR^LRLL3:'$D(^LRO(68.2,LRINST,2)) S LAST=$S($D(^LRO(68.2,LRINST,2)):^(2),1:"^1^1^0^0") G END:DUOUT
 IF +LAST,+LAST'=DT W !!,"LOAD/WORK LIST SET FOR " S Y=+LAST D DD^LRX W Y S %=1 D CLEAR^LRLL3 G END:DUOUT
C1 S LRAD=DT W !,"HOW MANY",$S(LRTYPE:" TRAYS",1:" ENTRIES")," TO BUILD: ALL//" R X:DTIME G END:X["^"
 W:X["?" !,"Accessions will be put on the list only to fill the number of",$S(LRTYPE:" trays",1:" entries")," specified." G C1:X["?" S:X=""!("Aa"[$E(X)) X=9999 S:X<1 X=1 S LRTRACNT=+X
 W:LRAA !,"  ACCESSION LIST: ",$P(^LRO(68,LRAA,0),U,1) I LRAA="" W !,"Need an accession area." S LRDEF=2 D NODEF
 K LRSTAR W !,"USE DEFAULT SETUP" S %=1 D YN^DICN Q:%<1  S LRDEF=% G BUILD:%=1
NODEF K DIC
 W ! D CLEAR^LRLL3
 S DIC="^LRO(68,",DIC(0)="AEOQ",DIC("B")=$P(^LRO(68,LRAA,0),U,1) D ^DIC K DIC Q:Y<1  S LRAA=+Y
 D:$P(^LRO(68,LRAA,0),U,3)="Y" LRSTAR G BUILD:$D(LRSTAR)
DAT R !,"Accession DATE: T//",X:DTIME S:X="" X="T" S %DT="EP" D ^%DT G DAT:X["?" S LRAD=Y
 R !,"ACCESSION NUMBER: FIRST//",LRST:DTIME S LRST=$S(LRST="":1,LRST:+LRST,1:-1) Q:LRST<0
 R !,"            GOTO: LAST//",LRLLT:DTIME S LRLLT=$S(LRLLT="":9999999,LRLLT:+LRLLT,1:-1) Q:LRLLT<0
BUILD S LRTRAY=1+$P(LAST,U,4),LRCUP=1+$P(LAST,U,5)
 W !,$S(LRTYPE:"TRAY",1:"SEQUENCE #")," TO START WITH: ",$S(LRTYPE:LRTRAY,1:LRCUP),"//" R X:DTIME Q:X=U  I X["?" W !?5,"Enter number to start with.",! G BUILD
 S X=$S(X="":$S(LRTYPE:LRTRAY,1:LRCUP),X<1:1,1:+X) S:LRTRAY'=$P(LAST,U,4) LRCUP=1
 S LRTRAY=$S(LRTYPE:+X,1:1),LRCUP=+$S(LRTYPE:$S($D(^LRO(68.2,LRINST,1,LRTRAY)):LRCUP,1:1),1:+X)
 IF $D(^LRO(68.2,LRINST,1,LRTRAY,1,LRCUP,0)) W $C(7),!,"  STARTING POINT IN USE. OK" S %=1 D YN^DICN G BUILD:%'=1
 I LRDEF=1,$P(^LRO(68,LRAA,0),U,3)="Y" D LRSTAR Q:%<0
 G B1:$D(LRSTAR)
 S X=$P(^LRO(68,LRAA,0),U,3),LRAD=$S(X="Y":$E(LRAD,1,3)_"0000","D"[X:LRAD,"M"[X:$E(LRAD,1,5)_"00","Q"[X:$E(LRAD,1,3)_"0000"+(($E(LRAD,4,5)-1)\3*300+100),1:LRAD)
B1 S $P(^LRO(68.2,LRINST,2),U,2,3)=LRTRAY_U_LRCUP S:LRCUP>0 LRCUP=LRCUP-1 K % X LRLLINIT
B2 K IO("Q") W !,"Queue build and print:" S %=2 D YN^DICN Q:%<0  S:%=1 IO("Q")=1 I %=0 W !?5,"Answer YES or NO.",! G B2
 G ^LRLL1
LRSTAR W !,"Do you wish to build by date (rather than by accession number)" S %=1 D YN^DICN G LRSTAR:%=0 Q:%'=1
 S %DT="AEQ",%DT("A")="Enter earliest date received at lab to build: " D ^%DT K %DT S:Y<1 %=-1 Q:Y<0  S LRSTAR=Y
 K DUOUT S %DT="AEQ",%DT("A")="Enter latest date received at lab to build: " D ^%DT K %DT S LRLST=Y,%=$S($D(DUOUT):-1,1:0)
 S LRAD=$E(LRSTAR,1,3)-1_"0000" S:LRLST'=-1 LRWDTL=$E(LRLST,1,3)_"0000",LRLST=LRLST\1+.99 S:LRLST=-1 LRWDTL=$E(DT,1,3)_"0000"
 Q
END G END^LRLL1
 ;LRTRAY = CURRENT TRAY #, LRCUP = CURRENT CUP #
 ;LRTYPE = 0 FOR SEQ., 1 FOR TRAY, 2 FOR BATCH
 ;LRFULL = 0 FOR ALL WORK, 1 FOR FULL TRAY'S ONLY
 ;MAXCUP = # OF LRCUP PER LRTRAY, 0 IF NO LIMIT
