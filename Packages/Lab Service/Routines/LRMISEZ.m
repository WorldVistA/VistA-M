LRMISEZ ;AVAMC/REG/SLC/BA - MICROBIOLOGY INFECTION CONTROL DATA ; 2/14/89  17:10 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;from option LRMISEZ
BEGIN S U="^",LRLOS=0 S:'$D(DTIME) DTIME=999 K ^TMP($J) S IOP="HOME" D ^%ZIS,SURVEY W ! D ^%ZISC
END K ^TMP($J),%,%DT,A1,B,DFN,DIC,DTOUT,DUOUT,I,J,K,LAST,LRAA,LRAAN,LRAC,LRAD,LRADMD,LRADMS,LRAP,LRAO,LRASK,LRBG,LRBN,LRBO,LRBUG,LRDAT,LRDCHD,LRDFN
 K LRDOC,LRDPF,LRDRUG,LREND,LRESULT,LRIDT,LRLLOC,LRLOS,LRLST,LRM,LRMY,LRNAME,LRND,LRNLOC,LROK,LROR,LRPAT,LRPF,LRPG,LRPNM,LRPPT,LRPROMPT,LRQUANT,LRSGL,LRSIT,LRST,LRSTAR,LRSUM,LRTK
 K LRYA,LRYRL,M,O,PNM,POP,R,S,SSN,X,Y,Z,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK,LRZ,LRLIN
 Q
SURVEY W @IOF,?19,"INFECTION CONTROL SURVEY DATA",!! D LRAA^LRMIUT Q:LRAA<1
 S LRAAN=$P(^LRO(68,LRAA,0),U,11)
 F I=0:0 S %=1 W !!,"Use default reports" D YN^DICN Q:%'=0  D INFO
 Q:%<0
 S (LRM("L","S"),LRM("O","S"),LRM("D","S"),LRM("P","S"))="Unknown"
 S LRSIT(1)=$S($D(^LAB(69.9,1,"MIS","B","C")):"C",1:"S") F I="L","P","D","O" S LRM(I)=$S($D(^LAB(69.9,1,"MIS","B",I)):"A",1:"N")
 I %=2 S LREND=0 D ^LRMISEZA Q:LREND
 I LRM("L")="N",LRM("O")="N",LRM("D")="N",LRM("P")="N" W !,"No reports were selected!" Q
 S %DT="AEQ",%DT("A")="Start  Date: " D ^%DT K %DT Q:Y<0  S LRSTAR=Y D D^LRU S LRST=Y I $E(LRSTAR,6,7)="00" S LRSTAR=$S($E(LRSTAR,4,7)="0000":LRSTAR+10000,$E(LRSTAR,4,5)="12":LRSTAR+10100,1:LRSTAR+100)
 S %DT="AEQ",%DT("A")="End    Date: " D ^%DT K %DT Q:Y<0  S LAST=Y D D^LRU S LRLST=Y Q:Y<0  I LRSTAR>LAST S X=LRSTAR,LRSTAR=LAST,LAST=X,X=LRST,LRST=LRLST,LRLST=X
 S Y=LRSTAR D D^LRU S LRST=Y,Y=LAST D D^LRU S LRLST=Y,LRAD=$E(LRSTAR,1,3)-1_"0000",LRYRL=$E(LAST,1,3)_"0000",LAST=LAST\1+.99
DEVICE S %ZIS="NMQ",%ZIS("B")="",IOP="Q" W ! D ^%ZIS K %ZIS Q:POP  S %DT="AET",%DT("A")="TIME TO RUN: T+1@1AM//" D ^%DT S:Y>0 ZTDTH=Y I Y'>0 S %DT="T",X="T+1@1AM" D ^%DT S ZTDTH=Y
 I '$D(IO("Q")) D DQ^LRMISEZ1 Q
 S ZTRTN="DQ^LRMISEZ1",ZTSAVE("L*")="" D ^%ZTLOAD K IO("Q"),ZTSK,ZTRTN,ZTIO,ZTSAVE
 Q
INFO W !,"Default reports are setup in the Laboratory Site file, 69.9."
 W !,"If you answer 'NO', you can select individual surveys grouped by:",!,"organism, location, patient, and/or physician.  You can select all items",!,"or a single item for each group.  You can also select to have all groups"
 W !,"contain a survey of a single organism.  Surveys can be reported by",!,"Site/Specimen or Collection sample."
 Q
