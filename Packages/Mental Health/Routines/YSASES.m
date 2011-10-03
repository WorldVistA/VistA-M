YSASES ;ALB/ASF-ASI SIGNER ;3/19/97  16:47
 ;;5.01;MENTAL HEALTH;**24**;Dec 30, 1994
MAIN ;
 N YSASC,YSASCL,YSASDT,YSASFLD,YSASG,YSASNUM,YSASPT,YSASTRN,YSASX,YSL,YSOK
 I '$D(^YSTX(604,"A.81."_DUZ)) W !,"There are no completed ASIs for you to sign or incomplete ASIs",!,"for you to finish.",*7 H 2 Q
 K ^TMP($J,"YSASI")
 D TLD,TLP
 W !
 K DIR S DIR(0)="NA^1:"_YSASC_":0",DIR("A")="Select ASI number: (1:"_YSASC_") " D ^DIR K DIR
 Q:$D(DIRUT)
 S YSASSIEN=+^TMP($J,"YSASI",Y),YSOK=$P(^(Y),U,6)
 S YSASPIEN=$$GET1^DIQ(604,YSASSIEN_",",.02,"I")
 D ACTION
 G MAIN
 Q
ACTION ;
 K DIR S DIR(0)=$S(YSOK:"SB^V:View;S:Sign;Q:Quit",1:"SB^V:View;E:Edit;Q:Quit"),DIR("A")="Action",DIR("B")="Q"
 D ^DIR K DIR
 I Y="V" D EN1^YSASPRT(YSASSIEN) K DIRUT Q
 I Y="S" D EN^YSASSN(YSASSIEN) Q
 I Y="E" D MAIN^YSASA2(YSASPIEN,YSASSIEN)
 Q
TLD ;load ASI  SIGNING list
 K ^TMP($J,"YSASI")
 S YSASIEN=0,YSASC=0
 F  S YSASIEN=$O(^YSTX(604,"A.81."_DUZ,YSASIEN)) Q:YSASIEN'>0  D
 . S YSASC=YSASC+1
 . S YSASCL=$$GET1^DIQ(604,YSASIEN_",",.04)
 . S YSASDT=$$GET1^DIQ(604,YSASIEN_",",.05)
 . S YSASTRN=$$GET1^DIQ(604,YSASIEN_",",.14)
 . S YSASPT=$$GET1^DIQ(604,YSASIEN_",",.02)
 . D CHECKALL^YSASO2(+YSASIEN,.YSOK)
 . S ^TMP($J,"YSASI",YSASC)=YSASIEN_U_YSASDT_U_YSASPT_U_YSASCL_U_YSASTRN_U_YSOK
 ;
 Q
TLP ; print list
 Q:'$D(^TMP($J,"YSASI"))
 S YSL="",$P(YSL,"_",75)=""
 W @IOF
 W @IOF,"Addiction Severity Index Sign Off Utility",!?7,"*=incomplete x=some questions X or N",!
 W ?8,"Date",?19,"Patient",?51,"Entered by",!,YSL,!
 S YSASNUM=0
 F  S YSASNUM=$O(^TMP($J,"YSASI",YSASNUM)) Q:YSASNUM'>0  D  Q:$D(DIRUT)
 . S YSASG=^TMP($J,"YSASI",YSASNUM)
 . W !,$J(YSASNUM,3),$S($P(YSASG,U,6)=1:"  ",$P(YSASG,U,6)=2:"x ",1:"* ")
 . W $P(YSASG,U,2)
 . W ?19,$P(YSASG,U,3)
 . W ?51,$P(YSASG,U,5)
 . D:$Y+4>IOSL WAIT
 Q
 ;
WAIT ;
 F I0=1:1:IOSL-$Y-2 W !
 N DTOUT,DUOUT,DIRUT
 I IOST?1"C".E W $C(7) K DIR S DIR(0)="E" D ^DIR K DIR
 Q:$D(DIRUT)
 W @IOF
 W ?8,"Date",?19,"Patient",?51,"Entered by",!,YSL,!
 Q
