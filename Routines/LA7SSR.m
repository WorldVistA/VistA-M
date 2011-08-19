LA7SSR ;DALISC/SED - ORDERS STATUS  REPORT ;6/5/97 14:00
 ;;5.2;LAB MESSAGING;**27**;Sep 27, 1994
EN ;SELECT THE CRITERIA TO REPORT ON
 K ^TMP($J),DIRUT
STAT S LRMSG="Statuses " D ALL G:$D(DIRUT) EXIT
 K DIRUT,^TMP($J,"S"),DIR
 I +Y'>0 D
 .F  Q:$D(DIRUT)  D
 ..S DIR(0)="PAO^64.061:EMZ",DIR("A")="Select Status: "
 ..S DIR("?")="Select the status to be included on the report."
 ..S DIR("S")="I $P(^(0),U,7)=""U"",('$D(^TMP($J,""S"",+Y)))"
 ..D ^DIR
 ..Q:$D(DIRUT)
 ..S ^TMP($J,"S",+Y)=""
SITE S LRMSG="Collection Sites " D ALL G:$D(DIRUT) STAT
 K DIR,DIRUT,^TMP($J,"C")
 I +Y'>0 D
 .F  Q:$D(DIRUT)  D
 ..S DIR(0)="PAO^4:EMZ",DIR("A")="Select Collection Site: "
 ..S DIR("?")="Select the Collection Site to be included on the report."
 ..S DIR("S")="I '$D(^TMP($J,""C"",+Y))"
 ..D ^DIR
 ..Q:$D(DIRUT)
 ..S ^TMP($J,"C",+Y)=""
MAN S LRMSG="Shipping Manifests" D ALL G:$D(DIRUT) SITE
 K DIR,DIROUT,DUOUT,DIRUT,^TMP($J,"M")
 I +Y'>0 D
 .K Y F  Q:$D(DIRUT)  D
 ..S NDX=0 K ^TMP($J,"LRI")
 ..S LRI=0 F  S LRI=$O(^LRO(69.6,"AD",LRI)) Q:+LRI'>0!$D(DIRUT)  D
 ...Q:$D(^TMP($J,"M",LRI))
 ...S NDX=NDX+1
 ...W !,$J(NDX,3),". ",LRI
 ...S ^TMP($J,"LRI",NDX)=LRI
 ...I NDX>1,NDX#20=0 D SEL(NDX)
 ..I '$D(DIRUT) D SEL(NDX)
 K ^TMP($J,"LRI")
PRINT ;
 S L=0,DIC="69.6",FLDS="[CAPTIONED]",BY="[LA7S EXEP SORT]"
 S DHD="Lab Order Status Report",DIS(0)="D CHECK^LA7SSR I +LRI"
 D EN1^DIP
EXIT ;EXIT
 K ^TMP($J),DIR,LRI,DIRUT,LRMSG,NDX,X,Y,DIC
 Q
ALL S DIR(0)="Y",DIR("B")="YES",DIR("A")="Include All "_LRMSG
 S DIR("?")="Enter (Y)es or return for all entries on the report."
 D ^DIR
 Q
SEL(N) ;MAKE A SELECTION
 K DTOUT,DUOUT,DIROUT
 W ! S DIR(0)="NOA^1:"_N_":0"
 S DIR("A")="Select Shipping Manifest 1 - "_N_": " D ^DIR
 I +Y S ^TMP($J,"M",$G(^TMP($J,"LRI",Y)))=""
 Q
CHECK ;ENTER HERE TO SCREEN THE ENTRIES
 S LRI=1
 I $D(^TMP($J,"S")) D
 .S LRTST=0 F  S LRTST=$O(^LRO(69.6,D0,2,LRTST)) Q:+LRTST'>0  D
 ..S LRST=$P(^LRO(69.6,D0,2,LRTST,0),U,6)
 ..I +$G(LRST)'>0 S LRI=0 Q
 ..S:'$D(^TMP($J,"S",LRST)) LRI=0
 I $D(^TMP($J,"C")),(LRI=1),+$P(^LRO(69.6,D0,0),U,5)'="",'$D(^TMP($J,"C",+$P(^LRO(69.6,D0,0),U,5))) S LRI=0
 I $D(^TMP($J,"M")),(LRI=1),$P(^LRO(69.6,D0,0),U,14)'="",'$D(^TMP($J,"M",$P(^LRO(69.6,D0,0),U,14))) S LRI=0
 Q
