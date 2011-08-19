SDAMEP ;ALB/CAW - Extended Display ; 16 May 2001  1:46 PM
 ;;5.3;Scheduling;**241,334,480**;Aug 13, 1993
 ;
EN ; Selection of appointment
 K ^TMP("SDAMEP",$J)
 S VALMBCK=""
 D SEL G ENQ:'$D(SDW)!(SDERR)
 N SDWIDTH,SDPT,SDSC,SDPTI,SDAMEP
 W ! D WAIT^DICD
 S DFN=$P(^TMP("SDAMIDX",$J,SDW),U,2)
 D FULL^VALM1 S DIC=2,DIC(0)="EM",X="`"_DFN  ;,SDAMEP=1
 D ^DIC I Y<0 S VALMBCK="R" Q
 D EN^VALM("SDAM APPT PROFILE")
 S VALMBCK="R"
ENQ Q
 ;
HDR ; Header
 N VA,VAERR
 D PID^VADPT
 S VALMHDR(1)=$E($P("Patient: "_$G(^DPT(DFN,0)),"^",1),1,30)_" ("_VA("BID")_")"
 S X=$S($D(^DPT(DFN,.1)):"Ward: "_^(.1),1:"Outpatient")
 S VALMHDR(1)=$$SETSTR^VALM1(X,VALMHDR(1),81-$L(X),$L(X))
 S X="Clinic: "_$P(^SC(SDCL,0),U)
 S VALMHDR(2)=$$SETSTR^VALM1(X,"Appointment #: "_SDW,81-$L(X),$L(X))
 Q
 ;
INIT ;
 N VA,VAERR,SDFSTCOL,SDSECCOL
 D PID^VADPT
 S SDT=$P(^TMP("SDAMIDX",$J,SDW),U,3),DFN=$P(^(SDW),U,2),SDCL=$P(^(SDW),U,4),SDDA=$P(^(SDW),U,5),SDLN=0  ;added DFN SD*5.3*480
 D INIT^SDAMEP1
 D APDATA^SDAMEP1 ;        Appointment Data
 D APLOG^SDAMEP3 ;         Appointment Event Log
 D PDATA^SDAMEP2 ;         Patient Data
 D APCO^SDAMEP4 ;          Appointment Check Out Data
 S VALMCNT=SDLN
 Q
 ;
FNL ;
 K SD,SDOE,SDSC,SDPT,SDLN,VALMCNT,SDEIC,SDI,SDX,SDW,SDEN,SDSTATE,SDERR,SDFLG,SDMT,SDT,DGPMVI,SDDISCH,SDPV,SDPOV,SDST,SDSTA
 D CLEAN^VALM10
 Q
 ;
SEL ; -- select processing
 N BG,LST,Y
 S BG=+$O(@VALMAR@("IDX",VALMBG,0))
 S LST=+$O(@VALMAR@("IDX",VALMLST,0))
 I 'BG W !!,*7,"There are no '",VALM("ENTITY"),"s' to select.",! S DIR(0)="E" D ^DIR K DIR D OUT G SELQ
 S Y=+$P($P(XQORNOD(0),U,4),"=",2)
 I 'Y S DIR(0)="N^"_BG_":"_LST,DIR("A")="Select "_VALM("ENTITY")_"(s)" D ^DIR K DIR I $D(DIRUT) D OUT G SELQ
 ;
 ; -- check was valid entries
 S SDERR=0,SDW=Y
 I SDW<BG!(SDW>LST) D
 .W !,*7,"Selection '",SDW,"' is not a valid choice."
 .D OUT,PAUSE^VALM1
 ;
SELQ K DIRUT,DTOUT,DUOUT,DIROUT Q
 ;
OUT ; 
 S SDERR=1
 Q
