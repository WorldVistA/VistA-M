PSALFM ;BIR/LTL-Controlled Connection by FSN Match ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;; 10/24/97
 ;
 D DT^DICRW
START ;compiles data for edit
EXPL W !,"I'll loop through the FSNs in your DRUG file.",!,"If I find a match in the ITEM MASTER file, I'll let you know.",!
 N D0,D1,DA,DIC,DIE,DIR,DIRUT,DIW,DIWF,DIWL,DIWR,DIWT,DLAYGO,DR,DTOUT,DUOUT,PSA,PSAD,PSADD,PSAF,PSAFSN,PSAIT,PSAOUT,X,Y S (PSA,PSAD)=0
LOOP F  S PSAD=$O(^PSDRUG(PSAD)) G:'PSAD!($D(PSAOUT)) END I $P($G(^PSDRUG(PSAD,0)),U,6)]"",'$O(^PSDRUG(PSAD,441,0)),'$D(^PSDRUG(PSAD,"I")) D  G:$G(PSAOUT) END
 .I $Y+5>IOSL S DIR(0)="E" D ^DIR K DIR S:'Y PSAOUT=1 W @IOF Q
FORM .S PSAFSN=$P(^PSDRUG(PSAD,0),U,6) W !,PSAFSN D:$O(^PRC(441,"BB",PSAFSN,0))
 ..N PSADD S PSAIT=$O(^PRC(441,"BB",PSAFSN,"")) D  W !,$E($P(^PSDRUG(PSAD,0),U),1,39)
USED ...I $O(^PSDRUG("AB",PSAIT,"")) S PSADD=$O(^PSDRUG("AB",PSAIT,"")) W !,"**"_$P(^PSDRUG(PSADD,0),U)_" is already linked to Item #"_PSAIT_"**"
INAC ...I $E($G(^PRC(441,PSAIT,3)),1)=1 W !,"Sorry, Item #"_PSAIT_" is INACTIVE, can't link.",! S PSADD=""
 ..I $L($G(^PRC(441,+PSAIT,1,1,0)))<40,'$O(^PRC(441,+PSAIT,1,1)) W ?40,$G(^PRC(441,+PSAIT,1,1,0)),! G SH
 ..K ^UTILITY($J,"W") S DIWL=40,DIWR=80,DIWF="W"
 ..F  S PSA=$O(^PRC(441,+PSAIT,1,PSA)) Q:'PSA  S X=$G(^PRC(441,+PSAIT,1,PSA,0)) D ^DIWP
 ..D ^DIWW S PSA=0
SH ..D:'$D(PSADD) OFFER
END I '$G(PSAOUT) S DIR(0)="EA",DIR("A")="Done with FSN's.  Press <RET> to return to the menu." D ^DIR
QUIT Q
OFFER S DIR(0)="Y",DIR("A")="Do we have a match",DIR("B")="Yes" D ^DIR K DIR S:$D(DIRUT) PSAOUT=1 Q:'Y  D
OK S DIE=50,DA=PSAD,DR="441///^S X=PSAIT" D ^DIE W "  Linked to Item #"_PSAIT
