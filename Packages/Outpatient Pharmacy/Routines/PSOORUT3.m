PSOORUT3 ;ISC-BHAM/SAB-build listman screen continued ;12/07/95 18:12
 ;;7.0;OUTPATIENT PHARMACY;**5,25,243,700,770**;DEC 1997;Build 145
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
 S X=PSODFN,DIC=2,DIC(0)="ZN" D ^DIC K DIC S NAM=$G(Y(0,0)),NNUM=PSODFN
 D BING^PSOBGMG3 S VALMBCK="R" K PSOHA
 W ! S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR
 K DIR,DIRUT,DTOUT,DUOUT
 Q
A ;resizes list area (Called from PSO PENDING ORDER MENU - HEADER field)
 I $D(^XUSEC("PSO ERX WORKLOAD RPH",DUZ)),$P(XQY0,"^")="PSO LMOE FINISH",$G(NAME)="PSO LM ACTIVE ORDERS" S XQORM("B")="NP"
 S PSOBM=$S(VALMMENU:20,1:21) D RES
 Q
B ;resizes list area (Called from PSO LM ACCEPT MENU - HEADER field)
 S PSOBM=21 D RES
 Q
RES ; Resize
 ; Some users use 48-line on their Terminal Emulator to strech Listman body
 I $D(^%ZOSF("ZVX")) Q
 ;
 I VALM("BM")'=PSOBM S VALMBCK="R" D
 . S VALM("BM")=PSOBM,VALM("LINES")=(PSOBM-VALM("TM"))+1 I +$G(VALMCC) D RESET^VALM4
 Q
 ;
HASACTPO(PATIEN) ; Checks whether the Patient has Active Pending Orders (skips Orders flagged by the current user)
 ; Input: PATIEN   - Pointer to the PATIENT file (#2)
 ;Output: HASACTPO - 1:Patient has active PO(s) | 0:No active/not flagged PO(s)
 ;
 N HASACTPO,ORD
 I '$D(^PS(52.41,"P",+$G(PATIEN))) Q 0
 S HASACTPO=0
 S ORD=0 F  S ORD=$O(^PS(52.41,"P",PATIEN,ORD)) Q:'ORD  D  I HASACTPO Q
 . I ",NW,RNW,"'[(","_$$GET1^DIQ(52.41,ORD,2,"I")_",") Q
 . I $$GET1^DIQ(52.41,ORD,34,"I")=DUZ Q  ; Order is flagged by the current user
 . S HASACTPO=1
 Q HASACTPO
 ;
CHECKCLN(CLN) ; WP Clinic DIC Selection Screen
 ; Input: CLN      - Pointer to CLINIC file (#44)
 ;Output: CHECKCLN - 1: Include Clinic | 0: Screen Clinic out
 N PSONPTRX,PSOINPTR
 I '$G(CLN)!'$G(PSOPINST) Q 0
 I $P($G(^SC(CLN,0)),"^",4),$P($G(^(0)),"^",4)'=$G(PSOPINST) Q 0
 I $P($G(^SC(CLN,0)),"^",4) Q 1
 S PSONPTRX=$P($G(^SC(CLN,0)),"^",15)
 I '$G(PSONPTRX) S PSONPTRX=+$O(^DG(40.8,0))
 S PSOINPTR=+$$SITE^VASITE(DT,PSONPTRX) I PSOINPTR'=$G(PSOPINST) Q 0
 Q 1
