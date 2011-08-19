SDAM10 ;MJK/ALB - Appt Mgt (Patient cont.); 3/18/05 3:51pm  ; Compiled March 31, 2008 16:38:47
 ;;5.3;Scheduling;**189,258,403,478,491**;Aug 13, 1993;Build 53
 ;
HDR ; -- list screen header
 ;   input:       SDFN := ifn of pat
 ;  output:  VALMHDR() := hdr array
 ;
 N VAERR,VA,X
 S DFN=SDFN D PID^VADPT
 S VALMHDR(1)=$E($P("Patient: "_$G(^DPT(SDFN,0)),U),1,46)_" ("_VA("BID")_")"  ;for proper display of patient name for SD*5.3*189
 S X=$P($$FMT^SDUTL2(SDFN),U,2),X=$S(X["GMT":X,X]"":"MT: "_X,1:"")
 S VALMHDR(1)=$$SETSTR^VALM1(X,VALMHDR(1),47,15)  ;repositioned header to display clinic or patient name properly for SD*5.3*189
 S X=$S($D(^DPT(SDFN,.1)):"Ward: "_^(.1),1:"Outpatient")
 S VALMHDR(1)=$$SETSTR^VALM1(X,VALMHDR(1),81-$L(X),$L(X))
 Q
 ;
PAT ; -- change pat
 K TMP ;SD/478
 D FULL^VALM1 S VALMBCK="R"
 K X I $D(XQORNOD(0)) S X=$P($P(XQORNOD(0),U,4),"=",2)
 I $D(X),X="" R !!,"Select Patient: ",X:DTIME
 D RT^SDAMEX S DIC="^DPT(",DIC(0)="EMQ" D ^DIC K DIC G PAT:X["?"
PAT1 S %=1 I Y>0 W !,"   ...OK" D YN^DICN I %=0 W "   Answer with 'Yes' or 'No'" G PAT1
 I %'=1 S Y=-1
 I Y<0 D  G PATQ
 .I $G(DFN)>0,SDAMTYP="P" S VALMSG=$C(7)_"Patient has not been changed."
 .I $G(DFN)'>0,SDAMTYP="P" S VALMSG=$C(7)_"Patient has not been selected."
 .I SDAMTYP="C" S VALMSG=$C(7)_"View of clinic remains in affect."
 .W !!,$G(VALMSG) H 1
 I SDAMTYP'="P" D CHGCAP^VALM("NAME","Clinic") S SDAMTYP="P"
 S (DFN,SDFN)=+Y K SDCLN,VADM D DEM^VADPT D BLD^SDAM1 ;SD/491
PATQ Q
 ;
INIT ; -- init bld vars
 K VALMHDR,SDDA,^TMP("SDAMIDX",$J)
 D CLEAN^VALM10
 S VALMBG=1,(VALMCNT,SDACNT)=0,BL="",$P(BL," ",30)="",SDMAX=100
 S SDAMDD=$P(^DD(2.98,3,0),U,3)
 ; -- format vars     |- column -| |- width -|
 S X=VALMDDF("APPT#"),AC=$P(X,U,2),AW=$P(X,U,3) ; A for appt
 S X=VALMDDF("DATE"),XC=$P(X,U,2),XW=$P(X,U,3) ;  X for date
 S X=VALMDDF("NAME"),NC=$P(X,U,2),NW=$P(X,U,3) ;  N for name
 S X=VALMDDF("STAT"),SC=$P(X,U,2),SW=$P(X,U,3) ;  S for status
 S X=VALMDDF("TIME"),TC=$P(X,U,2),TW=$P(X,U,3) ;  T for time
 S (CC,CW)="",X=$G(VALMDDF("CONSULT")) I X'="" S CC=$P(X,U,2),CW=$P(X,U,3) ;  C for Consult ;SD/478
 Q
 ;
LARGE ; -- too large note
 W !!?5,*7,"Note: Ending Date was changed to '",$$FDATE^VALM1(SDEND),"' because"
 W !?11,"too many appointments met date range criteria." D PAUSE^VALM1
 Q
 ;
NUL ; -- set nul message
 I '$O(^TMP("SDAM",$J,0)) D SET^SDAM1(" "),SET^SDAM1("    No appointments meet criteria.")
 Q
 ;
