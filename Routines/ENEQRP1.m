ENEQRP1 ;(WCIOFO)/DH-Equipment Reports ;10/21/1998
 ;;7.0;ENGINEERING;**21,35,48,59**;Aug 17, 1993
 ;
W ;WARRANTY EXPIRATIONS
 I $D(^ENG(6910.2,"B","WARRANTY EXPIRATION TEMPLATE")) S I=$O(^("WARRANTY EXPIRATION TEMPLATE",0)) I I>0,$P(^ENG(6910.2,I,0),U,2)="L",$D(^DIPT("B","ENZEQ WARRANTY")) S FLDS="[ENZEQ WARRANTY]"
 E  S FLDS="[ENEQ WARRANTY]"
 S BY="WARRANTY EXP. DATE" D DIP G KILL
 ;
R ;REPLACEMENT DATE
 I $D(^ENG(6910.2,"B","EQUIPMENT REPLACEMENT TEMPLATE")) S I=$O(^("EQUIPMENT REPLACEMENT TEMPLATE",0)) I I>0,$P(^ENG(6910.2,I,0),U,2)="L",$D(^DIPT("B","ENZEQ REPLACEMENT")) S FLDS="[ENZEQ REPLACEMENT]"
 E  S FLDS="[ENEQ REPLACEMENT]"
 S BY="REPLACEMENT DATE;S1" D DIP G KILL
 ;
DIP S DIC="^ENG(6914,",L=0,DIOEND="I IOST[""C-"" R !,""Press <RETURN> to continue..."",X:DTIME" D EN1^DIP K ZTSK
 Q
 ;
HS ;EQUIP HIST - SPECIFIC DEVICE
 D GETEQ^ENUTL G:Y<0 KILL S ENDA=+Y
 ;
 ; if equip. is component then offer to start with topmost parent system
 S ENDAP=ENDA,I=0
 F  S X=$P($G(^ENG(6914,ENDAP,0)),U,3) Q:X=""!(I>50)  S ENDAP=X,I=I+1
 W:I>50 $C(7),!!,"Couldn't determine topmost parent system (>50 levels)."
 I ENDAP'=ENDA D  G:ENDA'>0 KILL
 . W !!,"Equipment Entry #",ENDA,"  ",$$GET1^DIQ(6914,ENDA,6)
 . W !,"  is a component of Entry #",ENDAP,"  ",$$GET1^DIQ(6914,ENDAP,6)
 . S DIR(0)="Y",DIR("B")="YES"
 . S DIR("A")="Would you prefer a history of the Entry #"_ENDAP_" system"
 . S DIR("?")="Answer YES to print a history for the parent system (includes components)."
 . D ^DIR K DIR I $D(DIRUT) S ENDA="" Q
 . I Y S ENDA=ENDAP
 ;
 I $P($G(^ENG(6914,ENDA,6,0)),U,4)'>0,'$D(^ENG(6914,"AE",ENDA)) D  G HS
 . W !!,"There is no history recorded for this equipment.",!!
 D T,DEV^ENLIB G:POP KILL
 I $D(IO("Q")) D  G HS
 . S ZTRTN="HS0^ENEQRP1",ZTDESC="Equipment History (Specific Device)"
 . S ZTSAVE("EN*")="" D ^%ZTLOAD,HOME^%ZIS K ZTSK
HS0 ; queued entry point
 S (ENDONE,ENPG,ENR)=0 F I=4:1:9 S ENT(I)=0,ENGT(I)=0
 W:IO'=IO(0) !,"beginning report..."
 D HS1,HS2,HS3 I '$D(^ENG(6914,"AE",ENDA)),$E(IOST,1,2)="C-" D HOLD
 I 'ENDONE K K1 I $D(^ENG(6914,"AE",ENDA)) K ^TMP($J) S K1=0,ENA(K1)=ENDA,ENB(K1)=0 D HSD0
 D KILL G:'$D(ZTQUEUED) HS
 Q
 ;
HS1 Q:ENDONE  U IO I ENPG!($E(IOST,1,2)="C-") W @IOF
 S (ENSN,ENCAT,ENCRIT)=""
 I $D(^ENG(6914,ENDA,1)) S ENSN=$P(^(1),U,3),ENCAT=$P(^(1),U)
 I ENCAT]"",$D(^ENG(6911,ENCAT,0)) S ENCAT=$P(^(0),U)
 S ENPG=ENPG+1
 S X="REPAIR HISTORY: "_ENDA_"  "_$S($D(K1):"(comp) ",1:"")_ENCAT
 I $L(X)>61 S X=$E(X,1,61)
 W X
 S X=ENDATE_" Pg "_ENPG
 W ?62,X
 F J=1:1:3 S ENAC(J)=""
 I $D(^ENG(6914,ENDA,2)) S ENAC(1)=$P(^(2),U,4),ENAC(2)=$P(^(2),U,3),ENAC(3)=$P(^(2),U,6) I ENAC(1)]"" S Y=ENAC(1) X ^DD("DD") S ENAC(1)=Y
 S X="Acq Date: "_ENAC(1)_"  Acq Value: $"_ENAC(2)_"  LE: "_ENAC(3)_"  SN: "_ENSN
 I $L(X)>80 S X=$E(X,1,79)_"*"
 W !,X
 S I=0,ENCRIT="" F  S I=$O(^ENG(6914,ENDA,4,I)) Q:'I  D
 . S J=$P($G(^ENG(6914,ENDA,4,I,0)),U,4) I J>ENCRIT S ENCRIT=J
 S X="Criticality: "_ENCRIT_"  Condition: "_$$GET1^DIQ(6914,ENDA,53)
 W !,X,!
 S X="REFERENCE  WORK ORDER       PM   HRS  LABOR$  MAT'L$ VENDOR$  TOTAL$  WORKER"
 W !,X,! S I=7
 K X S $P(X,"-",79)="-" W X
 Q
HS2 Q:ENDONE  S ENR=$O(^ENG(6914,ENDA,6,ENR)) Q:'ENR
 S ENHS=^ENG(6914,ENDA,6,ENR,0) S I=I+1 F J=1:1:9 S E(J)=$P(ENHS,U,J)
 S:E(1)]"" E(1)=$E(E(1),2,30)
 S E(10)=E(5)+E(6)+E(7),ENT(9)=ENT(9)+E(10) F J=4:1:7 S ENT(J)=ENT(J)+E(J)
 W !,E(1)_" ",?11,E(2),?28,$J(E(3),2),?30,$J(E(4),6,1),?36,$J(E(5),8,0),?44,$J(E(6),8,0),?52,$J(E(7),8,0),?60,$J(E(10),8,0),?69,$E(E(8),1,10)
 S X=$L(E(9)) I X>75 D  S I=I+2
 . F X1=75:-1 Q:$E(E(9),X1)=" "!(X1=65)
 . I X1=65,$E(E(9),X1)'=" " W !,?3,$E(E(9),1,70),!,?3,$E(E(9),71,140) Q
 . W !,?3,$E(E(9),1,X1),!,?3,$E(E(9),X1+1,140)
 I X<76 W !,?3,E(9) S I=I+1
 I I>(IOSL-7) D HS4 Q:ENDONE
 G HS2
HS3 Q:ENDONE  W ! K X S $P(X,"_",79)="_" W X
 W !,"TOTAL",?30,$J(ENT(4),6,1),?36,$J(ENT(5),8,0),?44,$J(ENT(6),8,0),?52,$J(ENT(7),8,0),?60,$J(ENT(9),8,0)
 Q
HS4 I $E(IOST,1,2)="C-" D HOLD Q:ENDONE
 D HS1 Q
HS5 ;Re-init
 F I=4:1:9 S ENGT(I)=ENGT(I)+ENT(I),ENT(I)=0
 Q
HSD0 ;Descendent(s)
 Q:ENDONE  F ENDA=ENB(K1):0 S ENDA=$O(^ENG(6914,"AE",ENA(K1),ENDA)) Q:ENDA'>0  I ENA(K1)'=ENDA,'$D(^ENG(6914,"AE",ENDA,ENA(K1))) D HSD1
 I K1>0 S K1=K1-1 G HSD0
 Q:ENDONE  ;Spiral out of recursion
 F I=4:1:9 S ENGT(I)=ENGT(I)+ENT(I)
 W !! K X S $P(X,"=",79)="=" W X
 W !,"GRAND TOTAL",?30,$J(ENGT(4),6,1),?36,$J(ENGT(5),8,0),?44,$J(ENGT(6),8,0),?52,$J(ENGT(7),8,0),?60,$J(ENGT(9),8,0)
 I $E(IOST,1,2)="C-" D HOLD
 S ENDONE=1
 Q  ;exit
HSD1 Q:$D(^TMP($J,ENA(K1),ENDA))!(ENDONE)  D:$E(IOST,1,2)="C-" HOLD
 S ^TMP($J,ENA(K1),ENDA)="",ENR=0 D HS5,HS1,HS2,HS3 I $D(^ENG(6914,"AE",ENDA)) S K1=K1+1,ENA(K1)=ENDA,ENB(K1)=0 D HSD0
 I K1>0 S ENB(K1)=ENDA
 Q
KILL K %DT,DA,DIC,E,ENDATE,ENEQ,ENHS,ENNDATE,ENR,ENDA,ENT,ENGT,ENAC,ENDONE,I,J,K,O,X,Y,K1,ENPG,ENA,ENB,ENSN,ENCAT,ENCRIT,ENDAP
 K ^TMP($J) W @IOF
 I '$D(ZTQUEUED),$E(IOST,1,2)="P-" D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
T S %DT="",X="T" D ^%DT S ENNDATE=Y X ^DD("DD") S ENDATE=Y K X,Y Q
HOLD Q:ENDONE  S X="" R !!,"Press <RETURN> to continue or ""^"" to exit ",X:DTIME I '$T!($E(X)="^") S ENDONE=1
 Q
 ;ENEQRP1
