ENEQP ;(WASH ISC)/DH-Direct Posting to Equipment Histories ;10.9.97
 ;;7.0;ENGINEERING;**45**;Aug 17, 1993
EN ;Post info to equipment history sub-file
 N TEMPLT,NUMBER,QUIT,DIC S (ENTMPLT,QUIT)=0
 W @IOF,!!,"This is a utility for posting information directly to the AEMS-MERS",!,"Equipment History sub-file."
 W ! S DIR(0)="Y",DIR("A")="Are you sure you want to proceed",DIR("B")="NO"
 D ^DIR G:Y'>0 EXIT
 W !! S DIR(0)="Y",DIR("A")="Are the Equipment Records to be found in a SORT template",DIR("B")="NO"
 D ^DIR K DIR I Y>0 D GTMPLT G:'ENTMPLT EXIT G POST
 S DIR(0)="PO^6914:AEQM" K ^TMP($J)
 F  W ! D ^DIR Q:Y'>0  S ^TMP($J,+Y)=""
 G:'$D(^TMP($J)) EXIT
 S DIR(0)="Y",DIR("A")="Shall we save these ENTRY NUMBERS in a SORT template for future use",DIR("B")="NO"
 W ! D ^DIR K DIR D:Y>0 STMPLT G:QUIT EXIT
 ;
POST W !!,"Enter as much information as may apply."
 K DIR S DIR(0)="PO^6920.1:AEQM"
 W ! D ^DIR K DIR S ENACTN=$S(Y>0:+Y,1:"") I $E(X)="^" G EXIT
 S DIR(0)="FO^3:12",DIR("A")="WORK ORDER REFERENCE"
 S DIR("?")="Enter 3 to 12 characters.  Optional."
 W ! D ^DIR K DIR G:$E(Y)="?" POST G:$E(Y)="^" EXIT
 S ENREF=Y
 S DIR(0)="SO^P:PASSED;C:CORRECTIVE ACTION REQUIRED;D:DEFERRED"
 S DIR("A")="PM STATUS"
 W ! D ^DIR K DIR S ENSTAT=$S(Y?1U:Y,1:"") I $E(X)="^" G EXIT
 S DIR(0)="NO^0:2080:1",DIR("A")="TOTAL HOURS"
 W ! D ^DIR S ENHRS=$S(Y=+Y:Y,1:"") K DIR I $E(X)="^" G EXIT
 S DIR(0)="NO^0:999999:2",DIR("A")="LABOR COST"
 W ! D ^DIR S ENLABOR=$S(Y=+Y:Y,1:"") K DIR I $E(X)="^" G EXIT
 S DIR(0)="NO^0:999999:2",DIR("A")="MATERIAL COST"
 W ! D ^DIR S ENMATRL=$S(Y=+Y:Y,1:"") K DIR I $E(X)="^" G EXIT
 S DIR(0)="NO^0:999999:2",DIR("A")="VENDOR COST"
 W ! D ^DIR S ENVNDR=$S(Y=+Y:Y,1:"") K DIR I $E(X)="^" G EXIT
 S DIR(0)="FO^3:15",DIR("A")="WORKER",DIR("B")=$E($P(^VA(200,DUZ,0),U),1,15)
 W ! D ^DIR S ENEMP=Y K DIR I $E(X)="^" G EXIT
 S DIR(0)="FO^3:60",DIR("A")="WORK PERFORMED"
 S DIR("?")="Free text.  60 character maximum."
 W ! D ^DIR K DIR S ENWORK=Y I $E(X)="^" G EXIT
 D ^ENEQP1
 G EXIT
 ;
GTMPLT ;Get the SORT template
 S DIC="^DIBT(",DIC(0)="AEQM",DIC("S")="I $E(^(0),1,6)=""ENPOST"",$P(^(0),U,4)=6914"
 S DIC("A")="Select SORT template (must begin with 'ENPOST'): "
 W ! D ^DIC K DIC("A") I Y>0 S ENTMPLT=1,NUMBER=+Y
 Q
 ;
STMPLT ;Create new SORT template
 W !! S DIR(0)="F^6:30^K:$E(X,1,6)'=""ENPOST"" X"
 S DIR("A")="Name of SORT template.  Must begin with 'ENPOST'",DIR("?")="Template name (30 char max) must begin with 'ENPOST' (upper case)."
 D ^DIR K DIR I $E(X)="^" S QUIT=1 Q
 S TEMPLT=Y
 I $D(^DIBT("B",TEMPLT)) D  Q
 . F NUMBER=0:0 S NUMBER=$O(^DIBT("B",TEMPLT,NUMBER)) Q:NUMBER'>0  I $P(^DIBT(NUMBER,0),U,5)=DUZ,$P(^(0),U,4)=6914 D  Q
 .. W !!,"SORT template "_TEMPLT_" already exists."
 .. S DIR(0)="Y",DIR("A")="OK to replace it"
 .. D ^DIR K DIR I Y>0 D  Q
 ... S DIK="^DIBT(",DA=NUMBER D ^DIK K DIK
 ... K DD,DO S DIC="^DIBT(",DIC(0)="X",X=TEMPLT,DINUM=NUMBER
 ... S DIC("DR")="2///^S X=DT;4///^S X=6914;5///^S X=DUZ"
 ... D FILE^DICN I Y'>0 S NUMBER=""
 .. I $E(X)="^" S QUIT=1 Q
 .. S DIR(0)="Y",DIR("A")="OK to add these entries"
 .. D ^DIR K DIR I Y>0 D  Q
 ... F %=0:0 S %=$O(^TMP($J,%)) Q:%'>0  S ^DIBT(NUMBER,1,%)=""
 .. I $E(X)="^" S QUIT=1
CRE8 S DIR(0)="Y",DIR("A")="OK to create new SORT template"
 S DIR("B")="YES"
 D ^DIR K DIR S:$E(X)="^" QUIT=1 Q:Y'>0
 K DD,DO S DIC="^DIBT(",DIC(0)="X",X=TEMPLT
 S DIC("DR")="2///^S X=DT;4///^S X=6914;5///^S X=DUZ"
 D FILE^DICN I Y>0 S NUMBER=+Y D
 . F %=0:0 S %=$O(^TMP($J,%)) Q:%'>0  S ^DIBT(NUMBER,1,%)=""
 Q
 ;
EXIT K ^TMP($J)
 K ENTMPLT,ENREF,ENSTAT,ENHRS,ENLABOR,ENMATRL,ENVNDR,ENEMP,ENWORK
 K ENACTN
 Q
 ;ENEQP
