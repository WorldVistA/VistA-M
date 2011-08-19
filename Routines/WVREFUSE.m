WVREFUSE ;HCIOFO/JWR - Add/Enter/Manipulate procedure refusals ;12/9/98  15:56
 ;;1.0;WOMEN'S HEALTH;**3**;Sep 30, 1998
EDREF ;EDIT AN EXISTING REFUSAL
 D EXIT,SETVARS^WVUTL5
 D TITLE^WVUTL5("EDIT A REFUSED TREATMENT") W !!
 K DIC S DIC("A")="   Select DATE REFUSED: ",WVPOP=0
 S DIC="^WV(790.3,",DIC(0)="QEMALZ" D ^DIC
 I Y'>0!($D(DUOUT))!($D(DTOUT)) D EXIT Q
 S WVDFN=$P($G(^WV(790.3,+Y,0)),U,2),DIDEL=790.3
 D DDS^WVFMAN(790.3,"[WV REFUSED PROCEDURE-ENTRY]",+Y)
 G EDREF
 Q
ADDREF ;ADD A NEW REFUSAL (not used now, use UNIV for adding a refusal)
 D SETVARS^WVUTL5
 D TITLE^WVUTL5("ADD A REFUSED PROCEDURE")
 K DIR S DIR("A")="   Select DATE REFUSED: ",WVDFN=""
 S DIR(0)="DAO",DIR("B")="TODAY"
 D ^DIR K DIR I Y'>0 D EXIT Q
 S DIC("DR")="1;2"
 S DIC="^WV(790.3,",DIC(0)="QEMAL",X=Y
 K DD,DO D FILE^DICN
 Q:Y'>0
 S WVDFN=$P($G(^WV(790.3,+Y,0)),U,2)
 D DDS^WVFMAN(790.3,"[WV REFUSED PROCEDURE-ENTRY]",+Y)
 D EXIT Q
CHECK ;Checks for existing refusals for this patient within 30 day period
 ; for this procedure.
 Q:'$D(^WV(790.3,"C",WVDFN))
 N A,B,C,D,E,F K WVJR,WVJR1,DR,DIC,DA
 S X1=DT,X2=-30 D C^%DTC S A=X
 S X1=DT,X2=+30 D C^%DTC S B=X
 S G=0 F  S G=$O(^WV(790.3,"C",WVDFN,G)) Q:G'>0  S H=$G(^WV(790.3,G,0)) D
 .Q:$P(H,U)'>A!($P(H,U))'<B
 .Q:$P(H,U,3)'=WVJPR
 .S E=$P(H,U,3),D=$P(H,U)
 .S E=$S(E>0:$P($G(^WV(790.2,E,0)),U),1:"")
 .S Y=D D DD^%DT S F=Y
 .S WVJR(D,G)=F_"    "_E
 S C=1,A=0 F  S A=$O(WVJR(A)) Q:A'>0  S B=0 F  S B=$O(WVJR(A,B)) Q:B'>0  D
 .S WVJR1(C)=B_"^"_WVJR(A,B),C=C+1
 S WVC=C-1 I $D(WVJR1) D
 .W !!,"The following Entries for this patient and procedure already exist in the"
 .W !,"Procedure Refusal file.",!
 .D LOOP W !!
 .K DIR S DIR("A")="Is this a NEW Refusal?  ",DIR(0)="YAO"
 .S DIR("B")="Yes" D ^DIR K DIR Q:Y=1!($D(DIRUT))
 .S DIR("A")="Select a Number to edit a refusal from the list.  "
 .S DIR(0)="NAO^1:"_WVC
 .D ^DIR K DIR S WVEDREF=$S(+Y>0:+Y,1:"NS") Q:Y'>0
 Q
UNIV ;Add new Refusal & check other recent (within 30 days) Refusals
 D SETVARS^WVUTL5
 D TITLE^WVUTL5("ADD/EDIT A REFUSED TREATMENT")
 W !! K DIC S DIC("A")="   Select PATIENT: "
 S DIC(0)="AEMQZ",DIC="^WV(790,",DIC("W")="D LOOKL^WVUTL1A(+Y)"
 D ^DIC K DIC I Y'>0 D EXIT Q
 S WVDFN=+Y
 S DIR("A")="   DATE REFUSED: "
 S DIR(0)="DAO"
 D ^DIR K DIR I Y'>0 D EXIT Q
 S WVJDAY=+Y
 S DIR(0)="PAO^790.2:AEMNQZ",DIR("A")="   PROCEDURE: "
 D ^DIR K DIR I Y'>0 D EXIT Q
 S WVJPR=+Y
 K WVEDREF D CHECK I $D(DIRUT) K DIRUT D EXIT G UNIV
 I $G(WVEDREF)>0 D  G UNIV
 .S DIDEL=790.3
 .D DDS^WVFMAN(790.3,"[WV REFUSED PROCEDURE-ENTRY]",+WVJR1(WVEDREF))
 I $G(WVEDREF)="NS" D EXIT G UNIV
 L +^WV(790.3)
 S DIC="^WV(790.3,",DIC(0)="QEMAL",X=WVJDAY
 S DIC("DR")="1////^S X=WVDFN;2////^S X=WVJPR"
 K DD,DO D FILE^DICN
 L -^WV(790.3)
 Q:Y'>0
 S WVDFN=$P($G(^WV(790.3,+Y,0)),U,2)
 D DDS^WVFMAN(790.3,"[WV REFUSED PROCEDURE-ENTRY]",+Y)
 G UNIV
 Q
EXIT ;kill variables
 D KILLALL^WVUTL8 K WVEDREF,WVJPR,WVJDAY
 Q
LOOP ;Loop though the array of refuals for this patient & write them out
 S D=0 F  S D=$O(WVJR1(D)) Q:D'>0  D
 .W !,$J(D,6),".  ",$P($G(WVJR1(D)),U,2)
 Q
