SDAM3 ;MJK/ALB - Appt Mgt (Clinic) ; 4/21/05 12:23pm
 ;;5.3;Scheduling;**63,189,380,478,492**;Aug 13, 1993;Build 1
 ;
INIT ; -- get init clinic appt data
 ;  input:        SDCLN := ifn of pat
 ; output:  ^TMP("SDAM" := appt array
 S X=$P($G(^DG(43,1,"SCLR")),U,12),SDPRD=$S(X:X,1:2)
 S X1=DT,X2=-SDPRD D C^%DTC S VALMB=X D RANGE^VALM11
 I '$D(VALMBEG) S VALMQUIT="" G INITQ
 S SDBEG=VALMBEG,SDEND=VALMEND
 D CHGCAP^VALM("NAME","Patient")
 S X="NO ACTION TAKEN" D LIST^SDAM
INITQ K VALMB,VALMBEG,VALMEND Q
 ;
BLD ; -- scan apts
 N VA,SDAMDD,SDNAME,SDMAX,SDLARGE,DFN,SDCL,BL,XC,XW,AC,AW,TC,TW,NC,NW,SC,SW,SDT,SDDA ; done for speed see INIT^SDAM10
 D INIT^SDAM10
 F SDT=SDBEG:0 S SDT=$O(^SC(SDCLN,"S",SDT)) Q:'SDT!($P(SDT,".",1)>SDEND)  D
 .F SDDA=0:0 S SDDA=$O(^SC(SDCLN,"S",SDT,1,SDDA)) Q:'SDDA  S CNSTLNK=$P($G(^SC(SDCLN,"S",SDT,1,SDDA,"CONS")),U),CSTAT="" S:CNSTLNK'="" CSTAT=$P($G(^GMR(123,CNSTLNK,0)),U,12) D  ;SD/478
 ..I $D(^SC(SDCLN,"S",SDT,1,SDDA,0)) S DFN=+^(0) D             ;SD/492
 ...N NDX,DA,FND                                               ;SD/492
 ...S (FND,NDX)=""                                             ;SD/492
 ...F  S NDX=$O(^TMP("SDAMIDX",$J,NDX)) Q:NDX=""  D  Q:FND     ;SD/492
 ....S DA=^TMP("SDAMIDX",$J,NDX)                               ;SD/492
 ....I $P(DA,U,2)=DFN,$P(DA,U,3)=SDT,$P(DA,U,4)=SDCLN S FND=1  ;SD/492
 ...Q:FND                                                      ;SD/492
 ...D PID^VADPT I $D(^DPT(DFN,"S",SDT,0)),$$VALID^SDAM2(DFN,SDCLN,SDT,SDDA) S SDATA=^DPT(DFN,"S",SDT,0),SDCL=SDCLN,SDNAME=VA("BID")_" "_$P($G(^DPT(DFN,0)),U) D:SDCLN=+SDATA BLD1^SDAM1  ;SD/478,492
 D NUL^SDAM10,LARGE^SDAM10:$D(SDLARGE)
 S $P(^TMP("SDAM",$J,0),U,4)=VALMCNT
 Q
 ;
HDR ; -- list screen header
 ;   input:      SDCLN := ifn of pat
 ;  output:  VALMHDR() := hdr array
 ;
 S VALMHDR(1)=$E($P("Clinic: "_$G(^SC(SDCLN,0)),"^",1),1,45)  ;for proper display of clinic name for SD*5.3*189
 Q
 ;
CLN ; -- change clinic
 I $G(SDAMLIST)["CANCELLED" S VALMBCK="" W !!,*7,"You must be viewing a patient to list cancelled appointments." D PAUSE^VALM1 G CLNQ
 D FULL^VALM1 S VALMBCK="R"
 S X="" I $D(XQORNOD(0)) S X=$P($P(XQORNOD(0),U,4),"=",2)
 W ! S DIC="^SC(",DIC(0)=$S(X]"":"",1:"A")_"EMQ",DIC("A")="Select Clinic: ",DIC("S")="I $P(^(0),U,3)=""C"",'$G(^(""OOS""))"
 D ^DIC K DIC
 I Y<0 D  G CLNQ
 .I SDAMTYP="C" S VALMSG=$C(7)_"Clinic has not been changed."
 .I SDAMTYP="P" S VALMSG=$C(7)_"View of patient remains in affect."
 I SDAMTYP'="C" D CHGCAP^VALM("NAME","Patient") S SDAMTYP="C"
 N SDRES I SDAMTYP="C" S SDRES=$$CLNCK^SDUTL2(+Y,1) I 'SDRES D  G CLNQ
 .W !,?5,"Clinic MUST be corrected before continuing." D PAUSE^VALM1
 S SDCLN=+Y K SDFN D BLD
CLNQ Q
 ;
