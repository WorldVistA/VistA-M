YSASSEL ;ALB/ASF,HIOFO/FT - ASI SELECTOR ;1/29/13  10:19am
 ;;5.01;MENTAL HEALTH;**24,30,38,76,108**;Dec 30, 1994;Build 17
 ;Reference to ^DPT( supported by DBIA #10035
 ;Reference to VADPT APIs supported by DBIA #10061
 ;Reference to %ZISC supported by IA #10089
 ;Reference to ^XLFDT APIs supported by DBIA #10103
 ;
ADDEDIT ;entry point for YSAS ADD/EDIT ASI option
 ;Patch 108 no longer allows new ASIs through this roll & scroll option, only the MHA GUI.
 N YSASPIEN
 K ^TMP($J,"YSASI")
 D PT
 Q:YSASPIEN<1
 I '$D(^YSTX(604,"C",YSASPIEN)) D ASKNEW,CLEANUP Q
 W @IOF,?25,"***** Add - Edit *****"
 D TLD,TLP
 W !
 S DIR(0)=DIR(0),DIR("A")="Select number: " D ^DIR K DIR
 I Y?1N.N D
 .S YSASSIEN=+^TMP($J,"YSASI",Y)
 . I $P(^TMP($J,"YSASI",Y),U,5)=1 W !,"This ASI has already been signed. You may no longer edit it!",$C(7) Q
 . D OLCL
 . Q
 D CLEANUP
 Q
OLCL ;online vs clerk
 D SCREENH^YSASA2
  K DIR S Y=0,DIR(0)="SA^1:On-line;2:Clerk entry",DIR("A")="Select Entry option: "
 S DIR("B")=$S($P(^YSTX(604.8,1,0),U,3)="C":"Clerk",1:"On-line")
 D:$L(IOXY) ^DIR Q:$D(DIRUT)
 L +^YSTX(604,YSASPIEN):9999 Q:'$T
 D MAIN^YSASOL(YSASPIEN,YSASSIEN):Y=1,MAIN^YSASA2(YSASPIEN,YSASSIEN):Y=2
 L -^YSTX(604,YSASPIEN)
 Q
SELPRINT ;entry point for YSAS ASI PRINT option
 N YSASPIEN
 K ^TMP($J,"YSASI")
 D PT
 Q:YSASPIEN<1
 W @IOF,?25,"***** Item Report ****"
 D TLD,TLP
 W !
 S DIR("A")="Select ASI number: " D ^DIR K DIR W !,X,"  ",Y H 2
 I Y?1N.N W $C(7) S YSASSIEN=+^TMP($J,"YSASI",Y) D EN1^YSASPRT(YSASSIEN)
 D CLEANUP
 Q
NARR ;narrative output
 ;entry point for YSAS NARRATIVE PRINT option
 N YSASPIEN
 K ^TMP($J,"YSASI")
 D PT
 Q:YSASPIEN<1
 W @IOF,?25,"***** Narrative Report ****"
 D TLD,TLP
 W !
 S DIR("A")="Select ASI number: " D ^DIR K DIR
 Q:Y'?1N.N
 S YSASSIEN=+^TMP($J,"YSASI",Y),YSASCL=$P(^YSTX(604,YSASSIEN,0),U,4)
 ;I YSASCL=3 W !!,"Narrative Report not available for follow ups. Please use Item Report",$C(7) Q
 D EN1^YSASNAR(YSASSIEN)
 D ^%ZISC
 D CLEANUP
 Q
ASKNEW ;
 W !,"There are no previous ASI's on file.",!
 W !,"Please use the MHA GUI located on the CPRS Tools Menu to enter new ASIs."
 Q
PT ;patient lookup
 N DIC
 S DIC="^DPT(",DIC(0)="AEMQ"
 D ^DIC
 S YSASPIEN=+Y
 Q
TLD ;load ASI list
 K ^TMP($J,"YSASI")
 K DIR S DIR(0)="" ;"SA^"
 S YSASIEN=0,YSASC=0
 F  S YSASIEN=$O(^YSTX(604,"C",YSASPIEN,YSASIEN)) Q:YSASIEN'>0  D
 . S YSASC=YSASC+1
 . S YSASCL=$$GET1^DIQ(604,YSASIEN_",",.04)
 . S YSASDT=$$GET1^DIQ(604,YSASIEN_",",.05)
 . S YSASINT=$$GET1^DIQ(604,YSASIEN_",",.09)
 . S YSASIG=$$GET1^DIQ(604,YSASIEN_",",.51,"I")
 . S ^TMP($J,"YSASI",YSASC)=YSASIEN_U_YSASDT_U_YSASCL_U_YSASINT_U_YSASIG
 . S DIR(0)=YSASC_":"_YSASDT_";"_$P(DIR(0),";",1,20)
 S DIR(0)="SA^"_DIR(0) ;
 Q
TLP ; print list
 Q:'$D(^TMP($J,"YSASI"))
 S YSL="",$P(YSL,"_",79)=""
 N DFN S DFN=YSASPIEN D DEM^VADPT
 W !,VADM(1),"   ""xxx-xx-",$E($P(VADM(2),U,2),8,11),?45,"Addiction Severity Index History",!
 W " #",?7,"Date",?18,"Class",?30,"Interviewer",!,YSL,!
 S YSASC=0
 F  S YSASC=$O(^TMP($J,"YSASI",YSASC)) Q:YSASC'>0  D
 . S YSASG=^TMP($J,"YSASI",YSASC)
 . W !,$J(YSASC,3)," "
 . W $$FMTE^XLFDT($P(YSASG,U,2),"5ZD")
 . W ?18,$P(YSASG,U,3)
 . W ?28,$P(YSASG,U,4)
 . W ?55,$S($P(YSASG,U,5)=1:"Signed",1:"## Not Signed ##")
 ;
 Q
CLEANUP ;clean up variables
 K DIC,DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 K YSASC,YSASCL,YSASDT,YSASG,YSASIEN,YSASINT,YSASIG,YSL,YSASPIEN,YSASSIEN
 D KVA^VADPT
 Q
BROWSE ;
 D WP^DDBR(604.68,YSA_",",1,"R",YSTITLE)
 Q
ASICHECK ;entry point for YSAS ASI CHECKING GUIDE option
 N YSTITLE,YSA S YSTITLE="ASI CHECKING MANUAL",YSA=$O(^YSTX(604.68,"B",YSTITLE,0)) Q:YSA'>1  D BROWSE
 Q
ASISHORT ;entry point for YSAS SHORT GUIDE option
 N YSTITLE,YSA S YSTITLE="ASI SHORT GUIDE",YSA=$O(^YSTX(604.68,"B",YSTITLE,0)) Q:YSA'>1  D BROWSE
 Q
ASIQE ;entry point for YSAS QUESTIONS AND ERRORS option
 N YSTITLE,YSA S YSTITLE="COMMON QUESTIONS AND ERRORS",YSA=$O(^YSTX(604.68,"B",YSTITLE,0)) Q:YSA'>1  D BROWSE
 Q
ASIHOLL ;entry point for YSAS HOLLINGSHEAD CATEGORIES option
 N YSTITLE,YSA S YSTITLE="HOLLINGSHEAD CATEGORIES",YSA=$O(^YSTX(604.68,"B",YSTITLE,0)) Q:YSA'>1  D BROWSE
 Q
ASIDRUG ;entry point for YSAS ASI COMMON DRUGS
 N YSTITLE,YSA S YSTITLE="LIST OF COMMONLY USED DRUGS",YSA=$O(^YSTX(604.68,"B",YSTITLE,0)) Q:YSA'>1  D BROWSE
 Q
ASIUSER ;entry point for YSAS USER GUIDE option
 N YSTITLE,YSA S YSTITLE="ASI USER GUIDE",YSA=$O(^YSTX(604.68,"B",YSTITLE,0)) Q:YSA'>1  D BROWSE
 Q
