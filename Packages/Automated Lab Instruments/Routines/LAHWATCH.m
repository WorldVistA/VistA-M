LAHWATCH ;DALOI/JMC - WATCH DATA IN ^LAH GLOBAL ;Sep 12, 2008
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ;
IN ;
 N %,LREND,LRWL,LREF,LRINST,LPREF,LRMSK,LRHDR,LRNUM,LRNOP,X,Y
 S U="^"
 W !!!,"This routine will allow you to look at the verifiable data in the ^LAH GLOBAL  ",!,"for a specific instrument",!!
 S LREND=0
 F  D FIND Q:LREND
 ;
 Q
 ;
 ;
FIND ;
 N DIC
 S DIC="^LRO(68.2,",DIC(0)="AEMQ" D ^DIC
 I Y<1 S LREND=1 Q
 S LRWL=+Y,LRINST=$P(Y,"^",2)
 I '$O(^LAH(LRWL,1,0)) W !!?5,"No data for ",LRINST,!! Q
 ;
 ;
EN S LREF="^LAH("_LRWL_")",LRMSK=$$GLBR^LRAFUNC(LREF),LRHDR=1
 ;
 ;*** Query user for Listing Format ***
 ;*** Add logic so user can see either ^LAH listing or the interpreted values ***
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SO^1:Non interpreted LAH global;2:Interpreted values",DIR("A")="Select a Listing Format"
 D ^DIR
 I $D(DIRUT) S LREND=1 Q
 I Y=1 D STRT1 Q
 I Y=2 D STRT2 Q
 ;
 Q
 ;
 ;
STRT1 ;
 I 'LRWL W !!,?10,"No load/worklist defined for this instrument ",!!,$C(7) Q
 W !!,"I am about to display the data in ^LAH(",LRWL,")",!,?10,"You may exit at any time by entering the ""^""." H 2
 ;
 D CHK
 I $G(LRNOP) Q
 ;
ALOOP ;
 N DIR,DIRUT,DTOUT,DUOUT,LREND,X,Y
 W @IOF S LREND=0
 F  S LPREF=$S('(LREF[""""):LREF,1:LPREF),LREF=$Q(@(LREF)) Q:'($E(LREF,1,$L(LRMSK))=LRMSK)!(LREF="")!(LREND)  D
 . W !,LREF," = ",@LREF
 . I $Y>21 S DIR(0)="E",LRHDR=1 D ^DIR S LREND=$D(DUOUT) Q:LREND  W @IOF
 ;
 Q
 ;
 ;
STRT2 ;*** Logic to list interpreted ^LAH data ***
 ;
 D CHK
 I $G(LRNOP) Q
 ;
BLOOP ;
 N DIR,DIRUT,DTOUT,DUOUT,LREND,X,Y
 W @IOF
 S LREND=0
 F  S LPREF=$S('(LREF[""""):LREF,1:LPREF),LREF=$Q(@(LREF)) Q:'($E(LREF,1,$L(LRMSK))=LRMSK)!(LREF="")!(LREND)!($P($P(LREF,"(",2),",",3)="B")  D
 . I +$P($P(LREF,"(",2),",",4)=0 W !!?5,"Accession # ",$P(@(LREF),U,5)
 . I LRHDR=1 W !,"Test",?25,"Value" S LRHDR=0
 . I $P($P($P(LREF,"(",2),",",6),")",1)=0 D
 . . W !?5,"Organism:  ",$P($G(^LAB(61.2,+@LREF,0)),U)
 . . I '$D(^LAB(61.2,+@LREF,0)) W !,"***Organism entry points to missing entry # ",+@LREF," in file 61.2 (ETIOLOGY)***"
 . I +$P($P(LREF,"(",2),",",6)>0 S LRNUM=+$P($Q(^LAB(62.06,"AD",+$P($P(LREF,"(",2),",",6))),",",4) I $D(^LAB(62.06,LRNUM,0)) W !,$P(^(0),"^"),?25,@LREF
 . I +$P($P(LREF,"(",2),",",4)>0,$P($P(LREF,"(",2),",",4)[")",$D(^DD(63.04,+$P($P(LREF,"(",2),",",4),0)) W !,$P(^DD(63.04,+$P($P(LREF,"(",2),",",4),0),"^"),?25,+@LREF
 . I $Y>21 S DIR(0)="E",LRHDR=1 D ^DIR S LREND=$D(DUOUT) Q:LREND  W @IOF Q
 ;
 Q
 ;
 ;
CHK ;
 I '$G(LRWL) W !!!,?20,"This instrument has no pointer to ^LAH!",!!! S LRNOP=1 Q
 I '$D(^LAH(LRWL)) W !!!,?20,"No data in ^LAH for this instrument!",!!! S LRNOP=1 Q
 Q
