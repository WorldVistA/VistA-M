RTL ;MJK/TROY ISC;Label Function Menu; ; 5/14/87  8:46 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
 D DT^DICRW S X=$T(+1),DIK="^DOPT("""_$P(X,";",1)_""","
 G:$D(^DOPT($P(X,";"),4)) A S ^DOPT($P(X,";"),0)=$P(X,";",3)_"^1N^" F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT($P(X,";"),I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A D OVERALL^RTPSET Q:$D(XQUIT)
 W !! S DIC="^DOPT("""_$P($T(+1),";")_""",",DIC(0)="IQEAM" D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Label Formatter
 S IOP="" D ^%ZIS K IOP W:'$D(RTFMT) !!?5,">>> Label Formatter <<<" S DIC("DR")="3////"_+RTAPL,DIC("S")="I $P(^(0),U,3)=+RTAPL",DIC="^DIC(194.4,",DIC(0)="IAEMQL" W ! D ^DIC K DIC G Q1:Y<0
 S (RTFMT,DA)=+Y,DIE="^DIC(194.4,",DR="[RT LABEL EDIT]" D ^DIE I '$D(^DIC(194.4,RTFMT,0)) G Q1
 F I=0:0 S I=$O(^DIC(194.5,I)) Q:I'>0  I $D(^(I,0)) S @$P(^(0),"^",5)=$P(^(0),"^",4)
 W !!,"<<<<<<----------------------------Column No.------------------------------>>>>>>"
 W !!,"0--------1---------2---------3---------4---------5---------6---------7---------8"
 W !,"1        0         0         0         0         0         0         0         0",! S RTEST="",RTNUM=1,IOF="!" D PRT^RTL1 W !! G 1
Q1 F I=0:0 S I=$O(^DIC(194.5,I)) Q:I'>0  I $D(^(I,0)) K @$P(^(0),"^",5)
 K RTEST,RTNUM,I,DUOUT
 K %,%Y1,A,DO,D1,DA,DI,DIC,DIE,DQ,DR,J,K,POP,RTBC,RTFL,RTITLE,Y Q
2 ;;Test Label Format
 G TEST^RTL2
