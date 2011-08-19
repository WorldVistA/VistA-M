ZISHUNT ;SFISC/AC - HUNT GROUP MANAGER ;11/29/89  15:52
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
EDIT ;Edit Hunt Groups.
 S DIC("A")="Select Hunt Group: ",ZISHG(0)="E" D DIC
 Q
DEL ;Delete Hunt Groups
 K ^TMP($J)
 S DIC("A")="Delete which Hunt Group: ",ZISHG(0)="D",ZISHGK=0 D DIC
 Q:'ZISHGK
 W !,"You have selected for deletion the following Hunt Groups:",!
 F ZISI=1:1:ZISHGK I $D(^TMP($J,"DEL",ZISI)) W !?20,$P(^(ZISI),"^",2)
 W !!,"OK TO DELETE" S %=0,U="^" D YN^DICN
 I %'=1 W *7," ??" K ^TMP($J),ZISI,ZISHGK Q
 F ZISI=1:1:ZISHGK I $D(^TMP($J,"DEL",ZISI)) S ZISY=^(ZISI),DA=+ZISY,DIE="^%ZIS(1,",DR=".01///@" D ^DIE W !?20,$P(ZISY,"^",2)_"  --  DELETED"
 K ^TMP($J),ZISI,ZISHGK,ZISY
 Q
DIC W !,DIC("A") R X:DTIME
 G END:X["^",END:X=""
 I X?1"?" W !," Enter name of Hunt Group",!!," DO YOU WANT THE ENTIRE HUNT GROUP LIST" S %=0,U="^" D YN^DICN G DIC:%'=1 S X="??" D LST G DIC
 I X?2"?" D LST G DIC
 S DIC="^%ZIS(1,",DIC(0)="EMZ",DIC("S")="I $D(^(""TYPE"")),^(""TYPE"")=""HG"""
 I X=$C(32) S X=$S($D(^DISV(DUZ,"^%ZIS(1,")):^("^%ZIS(1,"),1:"") G DIC:'X S X="`"_X
 D ^DIC
 I Y<0 S X1=$O(^%ZIS(1,"B",X)) I X1]"",$P(X1,X)="" G DIC
 I Y<0 X:$D(^DD(3.5,.01,0)) $P(^(0),"^",5) I '$D(X) W *7," ??" G DIC
 G @ZISHG(0)
 ;
LST S DIC="^%ZIS(1,",DIC(0)="EMZ",DIC("S")="I $D(^(""TYPE"")),^(""TYPE"")=""HG""" D ^DIC Q
 ;
E I Y<0 W !?2,*7," ARE YOU ADDING '"_X_"' AS A NEW HUNT GROUP" S %=0,U="^" D YN^DICN W:%'=1 *7," ??" G DIC:%'=1 D ADD
 Q:Y'>0
 S DIE=DIC,DA=+Y,DR=30 D ^DIE
 S DIC("A")="Select Hunt Group: ",ZISHG(0)="E" G DIC
 ;S DIC="^%ZIS(1,",DIC(0)="AEMZ",DIC("A")="Select Hunt Group: ",DIC("S")="I $D(^(""TYPE"")),^(""TYPE"")=""HG""" D ^DIC
 Q
ADD ;Add Hunt Groups
 S DIC(0)="LMZ",DLAYGO=3,DIC("DR")="2////HG" D ^DIC I Y<0 W *7,"<"_X_" DELETED>" Q
 Q
D I Y>0,$P(Y,"^",2)]"" S ZISHGK=ZISHGK+1,^TMP($J,"DEL",ZISHGK)=Y,DIC("A")="Another Hunt Group: "
 W:Y'>0 *7," ??"
 S DIC("A")="Delete which Hunt Group: ",ZISHG(0)="D" G DIC
END K DA,DIC,DIE,DR,X1,X,Y,ZISHG(0) Q
