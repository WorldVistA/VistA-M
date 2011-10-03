PSOORUT3 ;ISC-BHAM/SAB-build listman screen continued ;12/07/95 18:12
 ;;7.0;OUTPATIENT PHARMACY;**5,25,243**;DEC 1997;Build 22
 ;
 ;Reference to MAIN^TIUEDIT supported by IA# 2410
 ;Reference to RESET^VALM4 supported by IA# 2334
 ;bulids allergy/adverse reactions list
 F DR=0:0 S DR=$O(GMRAL(DR)) Q:'DR  S ^TMP($J,"AL",$S($P(GMRAL(DR),"^",4):1,1:2),$S('$P(GMRAL(DR),"^",5):1,1:2),$P(GMRAL(DR),"^",7),$P(GMRAL(DR),"^",2))=""
 S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)="Allergies "
 S:$O(^TMP($J,"AL",1,1,""))]"" IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)="    Verified: "
 S (DR,TY)="" F I=0:0 S TY=$O(^TMP($J,"AL",1,1,TY)) Q:TY=""  F D=0:0 S DR=$O(^TMP($J,"AL",1,1,TY,DR)) Q:DR=""  D
 .S:$L(^TMP("PSOPI",$J,IEN,0)_DR_", ")>80 IEN=IEN+1,$P(^TMP("PSOPI",$J,IEN,0)," ",14)=" " S ^TMP("PSOPI",$J,IEN,0)=$G(^TMP("PSOPI",$J,IEN,0))_DR_", "
 S:$O(^TMP($J,"AL",2,1,""))]"" IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)="Non-Verified: "
 S (DR,TY)="" F I=0:0 S TY=$O(^TMP($J,"AL",2,1,TY)) Q:TY=""  F D=0:0 S DR=$O(^TMP($J,"AL",2,1,TY,DR)) Q:DR=""  D
 .S:$L(^TMP("PSOPI",$J,IEN,0)_DR_", ")>80 IEN=IEN+1,$P(^TMP("PSOPI",$J,IEN,0)," ",14)=" " S ^TMP("PSOPI",$J,IEN,0)=$G(^TMP("PSOPI",$J,IEN,0))_DR_", "
 D REMOTE^PSOORUT2
 S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)=" "
 S IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)="Adverse Reactions "
 S:$O(^TMP($J,"AL",1,2,""))]"" IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)="    Verified: "
 S (DR,TY)="" F I=0:0 S TY=$O(^TMP($J,"AL",1,2,TY)) Q:TY=""  F D=0:0 S DR=$O(^TMP($J,"AL",1,2,TY,DR)) Q:DR=""  D
 .S:$L(^TMP("PSOPI",$J,IEN,0)_DR_", ")>80 IEN=IEN+1,$P(^TMP("PSOPI",$J,IEN,0)," ",14)=" " S ^TMP("PSOPI",$J,IEN,0)=$G(^TMP("PSOPI",$J,IEN,0))_DR_", "
 S:$O(^TMP($J,"AL",2,2,""))]"" IEN=IEN+1,^TMP("PSOPI",$J,IEN,0)="Non-Verified: "
 S (DR,TY)="" F I=0:0 S TY=$O(^TMP($J,"AL",2,2,TY)) Q:TY=""  F D=0:0 S DR=$O(^TMP($J,"AL",2,2,TY,DR)) Q:DR=""  D
 .S:$L(^TMP("PSOPI",$J,IEN,0)_DR_", ")>80 IEN=IEN+1,$P(^TMP("PSOPI",$J,IEN,0)," ",15)=" " S ^TMP("PSOPI",$J,IEN,0)=$G(^TMP("PSOPI",$J,IEN,0))_DR_", "
 K TY,D,I,GMRA,GMRAL,DR,AD,ADL,^TMP($J,"AL")
 Q
PRONTE ;entry point to enter a progress note DBIA 220
 I $T(MAIN^TIUEDIT)]"" D FULL^VALM1,MAIN^TIUEDIT(3,.TIUDA,PSODFN,"","","","",1) Q
 S VALMSG="Progress Notes NOT Available.",VALMBCK=""
 Q
DPLYOR ;displays status of patient's orders
 S PSOHA=1,(EXT,DTME,RX,OLDT)="",(CNT,CNT1,RXNYM)=0
 S X=PSODFN,DIC=2,DIC(0)="ZN" D ^DIC K DIC S NAM=Y(0,0),NNUM=PSODFN
 D BING^PSOBGMG3 S VALMBCK="R" K PSOHA
 W ! S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR
 K DIR,DIRUT,DTOUT,DUOUT
 Q
A ;resizes list area
 S PSOBM=$S(VALMMENU:19,1:21) I VALM("BM")'=PSOBM S VALMBCK="R" D
 .S VALM("BM")=PSOBM,VALM("LINES")=(PSOBM-VALM("TM"))+1 I +$G(VALMCC) D RESET^VALM4
 Q
