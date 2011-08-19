YSGAF2 ;ASF/ALB- GLOBAL ASSESSMENT OF FUNCTIONNING CONT ;11/13/97  09:09
 ;;5.01;MENTAL HEALTH;**33**;Dec 30, 1994
 Q
EDENT ;edit /error
 N %DT,DA,DIE,DIR,DIRUT,DLAYGO,DR,K,X,X1,X2,Y,G,YSDATE,YSDAYS,YSDATR,YSBY,YSENT,YSGAF
 W !,"Edit Global Assessment of functioning Diagnosis",!
 K DFN
 D ^YSLRP Q:'$D(DFN)
 I '$D(^YSD(627.8,"AX5",DFN)) W !,"No previous GAF on record for this patient",!,"Please enter any new GAF data through the entry options",! H 2 Q
 D LST
 I '$D(^TMP("YSGAF",$J)) W !!,"No Axis 5 dx's by "_$P(^VA(200,DUZ,0),U) H 1 Q
 D SHOW,SEL
 Q:$D(DIRUT)!(Y'>0)
 D APART
 I YSDAYS>2 D
 . W !,"Dx made ",YSDAYS," days ago and cannot be changed. Do you wish to mark it as an error? "
 . K DIR S DIR(0)="Y",DIR("B")="No" D ^DIR Q:$D(DIRUT)
 . I Y D NOW^%DTC S Y=% X ^DD("DD") S DIE="^YSD(627.8,",DR="80///Error: entered in error noted on "_Y_" by "_$P(^VA(200,DUZ,0),U),DA=+G D ^DIE
 . Q
 I YSDAYS<3 D
 . S DIE="^YSD(627.8,",DR=65,DA=+G D ^DIE
 . Q
 Q
SHOW ; display dxs
 W !!
 S K=0 F  S K=$O(^TMP("YSGAF",$J,K)) Q:K'>0  D
 . W:($X>45) !
 . W $J(K,3),". GAF:",$J($P(^TMP("YSGAF",$J,K),U,3),3)_" on "
 . S Y=$P(^TMP("YSGAF",$J,K),U,2) X ^DD("DD") W Y
 . W ?40
 Q
LST ;LIST AXIS 5 FOR CURRENT PT AND DUZ
 K ^TMP("YSGAF",$J) S YSENT=0
 S YSDATR=0 F  S YSDATR=$O(^YSD(627.8,"AX5",DFN,YSDATR)) Q:YSDATR'>0  S DA=0 F  S DA=$O(^YSD(627.8,"AX5",DFN,YSDATR,DA)) Q:DA'>0  D
 . S YSGAF=$P($G(^YSD(627.8,DA,60)),U,3) Q:YSGAF'>0
 . S YSBY=$P(^YSD(627.8,DA,0),U,4) Q:YSBY'=DUZ
 . Q:$L($G(^YSD(627.8,DA,80,1,0)))
 . S YSENT=YSENT+1
 . S ^TMP("YSGAF",$J,YSENT)=DA_U_$P(^YSD(627.8,DA,0),U,3)_U_YSGAF
 Q
SEL ;select dx
  K DIR S DIR(0)="N^1:"_YSENT_":0",DIR("A")="Select GAF to edit: ",DIR("B")=1
 D ^DIR
 Q
APART ;time since dx
 S G=^TMP("YSGAF",$J,Y)
 D NOW^%DTC S X1=%,X2=$P(G,U,2) D ^%DTC S YSDAYS=X
 Q
