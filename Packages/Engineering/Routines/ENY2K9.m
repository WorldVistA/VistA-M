ENY2K9 ;;(WIRMFO)/DH-Equipment Y2K Management ;5.8.98
 ;;7.0;ENGINEERING;**51**;August 17, 1993
 ; extension of ENY2K to handle local ids
LOC1 K ^TMP($J)
 N STOP
 R !!,"Please enter the starting LOCAL ID: ",X:DTIME I '$T!($E(X)="^")!(X="") S ESCAPE=1 Q
 S LOC=X
 I '$D(^ENG(6914,"L",LOC)) D  Q:$G(ESCAPE)  G:LOC="" LOC1
 . S L=$L(LOC),LOC(1)=$O(^ENG(6914,"L",LOC))
 . I $E(LOC(1),1,L)=LOC S LOC=LOC(1) Q
 . S LOC="" W "??",*7
 . S DIR(0)="Y",DIR("A")="Would you like a list of valid LOCAL IDs",DIR("B")="YES"
 . D ^DIR K DIR Q:'Y
 . S %ZIS="" D ^%ZIS I POP S ESCAPE=1 Q
 . S PAGE=0,Y=DT D NOW^%DTC S Y=% X ^DD("DD") S DATE("PRNT")=$P(Y,":",1,2)
 . D LOCHDR S LOC(2)="" F  S LOC(2)=$O(^ENG(6914,"L",LOC(2))) Q:LOC(2)=""  W !,?5,$J(LOC(2),15) I (IOSL-$Y)'>2 D HOLD,LOCHDR Q:$G(STOP)
 W "  ("_LOC_")"
LOC2 W !,"Go thru (or '^' to escape): "_LOC_"// " R END:DTIME I '$T!($E(END)="^") S LOC="" G LOC1
 I LOC]END W !!,"The ending point may not preceed the starting point." S (LOC,END)="" G LOC1
 L +^ENG("LOC",LOC):1 I '$T W !,"Another user is editing this LOCAL ID. Can't proceed." S (LOC,END)="" G LOC1
 F J="PRE","FC","NC","CC","NA" S COUNT(J)=0
 S (DA,COUNT)=0,LOC(0)=LOC F  S DA=$O(^ENG(6914,"L",LOC(0),DA)) Q:'DA  D
 . I $D(^ENG(6914,DA,0)),"^4^5^"'[(U_$P($G(^(3)),U)_U) S COUNT=COUNT+1,^TMP($J,DA)="",X=$P($G(^ENG(6914,DA,11)),U) I X]"" S COUNT("PRE")=COUNT("PRE")+1,COUNT(X)=COUNT(X)+1,^TMP($J,X,DA)=""
 F  S LOC(0)=$O(^ENG(6914,"L",LOC(0))) Q:LOC(0)]END!(LOC(0)="")  S DA=0 F  S DA=$O(^ENG(6914,"L",LOC(0),DA)) Q:'DA  D
 . I $D(^ENG(6914,DA,0)),"^4^5^"'[(U_$P($G(^(3)),U)_U) S COUNT=COUNT+1,^TMP($J,DA)="",X=$P($G(^ENG(6914,DA,11)),U) I X]"" S COUNT("PRE")=COUNT("PRE")+1,COUNT(J)=COUNT(J)+1,^TMP($J,X,DA)=""
 I 'COUNT W !!,"There are no active equipment records within the selected range." L -^ENG("LOC",LOC) S (LOC,END)="" G LOC1
 W !!,"There are "_COUNT_" active equipment records within the selected range.",!,"Would you like to proceed?"
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT) S ESCAPE=1 Q
 S ENY2K("CONT")=Y I 'ENY2K("CONT") L -^ENG("LOC",LOC) S (LOC,END)="" G LOC1
 I COUNT("PRE"),'$D(CRITER) D OVERWRT^ENY2K8
 Q
 ;
LOCHDR ;  header for list of valid LOCAL IDENTIFIERS
 W:PAGE>0!($E(IOST,1,2)="C-") @IOF S PAGE=PAGE+1
 W "LOCAL IDENTIFIERS in Use at this Site  "_DATE("PRNT")_"  Page: "_PAGE
 K LOC(3) S $P(LOC(3),"-",79)="-" W !,LOC(3)
 Q
 ;
HOLD Q:$E(IOST,1,2)'="C-"
 W !,"Press <RETURN> to continue, '^' to escape..." R X:DTIME
 I '$T!($E(X)="^") S STOP=1
 Q
 ;ENY2K9
