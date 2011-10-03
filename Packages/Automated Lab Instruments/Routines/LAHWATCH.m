LAHWATCH ;SLC/RAF/DALISC/TNN - WATCH DATA IN ^LAH GLOBAL ;1/13/92  12:41
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
IN ;
 S U="^" W !!!,"This routine will allow you to look at the verifiable data in the ^LAH GLOBAL  ",!,"for a specific instrument",!!
FIND K DIC S DIC="^LAB(62.4,",DIC(0)="AEMQ",DIC("S")="I Y<100" D ^DIC G END:Y<1 S LRTSK=+Y,LRINST=$P(Y,"^",2),LRWL=+$P(^LAB(62.4,+Y,0),U,4)
 I 'LRWL W !!,?10,"No load/worklist defined for this instrument ",!!,$C(7) G IN
 I '$O(^LAH(LRWL,1,0)) W !!?5,"No data for ",LRINST,!! G IN
EN S LREF="^LAH("_LRWL_")",LRMSK=$$GLBR^LRAFUNC(LREF),LRHDR=1
 ;
 ;*** Query user for Listing Format ***
 ;*** Add logic so user can see either ^LAH listing or the interpreted values ***
 ;
 K DIR S DIR(0)="SO^1:Non interpreted LAH global;2:Interpreted values",DIR("A")="Select a Listing Format"
 D ^DIR K DIR Q:$D(DIRUT)
 I X=1 G STRT1
 I X=2 G STRT2
 D END G IN
 ;
STRT1 I 'LRWL W !!,?10,"No load/worklist defined for this instrument ",!!,$C(7) Q
 W !!,"I am about to display the data in ^LAH(",LRWL,")",!,?10,"You may exit at any time by entering the ""^""." H 2
CHK I '$G(LRWL) W !!!,?20,"This instrument has no pointer to ^LAH!",!!! S LRNOP=1 Q
 I '$D(^LAH(LRWL)) W !!!,?20,"No data in ^LAH for this instrument!",!!! S LRNOP=1 Q
 Q:X=2
ALOOP ;
 W @IOF S LREND=0 F  S LPREF=$S('(LREF[""""):LREF,1:LPREF),LREF=$Q(@(LREF)) Q:'($E(LREF,1,$L(LRMSK))=LRMSK)!(LREF="")!(LREND)  W !,LREF," = ",@LREF D
 . I $Y>21 S DIR(0)="E",LRHDR=1 D ^DIR S LREND=$D(DUOUT) Q:LREND  W @IOF
AQUIT ;
 W !,"Would you like to see if any more data has entered ^LAH(",LRWL,")" S %=2 D YN^DICN G:%=2!(%=-1) NEXT I %=1 S LREF=LPREF G ALOOP
NEXT ;
 W !,"Would you like to view another instruments ^LAH data" S %=2 D YN^DICN G:%=2!(%=-1) END I %=1 D END G FIND
END K X,LRWL,LREF,LRINST,LRTSK,LREND,LPREF,%,Y,LRMSK,DIR,DUOUT,LRHDR,LRNUM,LRNOP
 Q
 ;
STRT2 ;*** Logic to list interpreted ^LAH data ***
 D CHK I $G(LRNOP) D END G FIND
BLOOP ;
 W @IOF S LREND=0 F  S LPREF=$S('(LREF[""""):LREF,1:LPREF),LREF=$Q(@(LREF)) Q:'($E(LREF,1,$L(LRMSK))=LRMSK)!(LREF="")!(LREND)!($P($P(LREF,"(",2),",",3)="B")  D
 . I +$P($P(LREF,"(",2),",",4)=0 W !!?5,"Accession # ",$P(@(LREF),U,5)
 . I LRHDR=1 W !,"Test",?25,"Value" S LRHDR=0
 . I $P($P($P(LREF,"(",2),",",6),")",1)=0 W !?5,"Organism:  ",$P($G(^LAB(61.2,+@LREF,0)),U) D
 . . I '$D(^LAB(61.2,+@LREF,0)) W !,"***Organism entry points to missing entry # ",+@LREF," in file 61.2 (ETIOLOGY)***"
 . I +$P($P(LREF,"(",2),",",6)>0 S LRNUM=+$P($Q(^LAB(62.06,"AD",+$P($P(LREF,"(",2),",",6))),",",4) I $D(^LAB(62.06,LRNUM,0)) W !,$P(^(0),"^"),?25,@LREF
 . I +$P($P(LREF,"(",2),",",4)>0,$P($P(LREF,"(",2),",",4)[")",$D(^DD(63.04,+$P($P(LREF,"(",2),",",4),0)) W !,$P(^DD(63.04,+$P($P(LREF,"(",2),",",4),0),"^"),?25,+@LREF
 . I $Y>21 S DIR(0)="E",LRHDR=1 D ^DIR S LREND=$D(DUOUT) Q:LREND  W @IOF Q
BQUIT ;
 W !,"Would you like to see if any more data has entered ^LAH(",LRWL,")" S %=2 D YN^DICN G:%=2!(%=-1) NEXT I %=1 S LREF=LPREF G BLOOP
 D END G IN
