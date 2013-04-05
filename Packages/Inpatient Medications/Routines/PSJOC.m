PSJOC ;BIR/MV - NEW ORDER CHECKS DRIVER ;6 Jun 07 / 3:37 PM
 ;;5.0;INPATIENT MEDICATIONS ;**181,260**;16 DEC 97;Build 94
 ;
 ; Reference to ^PSODDPR4 is supported by DBIA# 5366.
 ; Reference to ^PSSHRQ2 is supported by DBIA# 5369.
 ;
OC(PSPDRG,PSJPTYP) ;
 ;PSPDRG - Drug array in format of PDRG(n)=IEN (#50) ^ Drug Name
 ;Where n is a sequential number.  The Drug Name can be OI, Generic name form #50, or Add/Sol name
 ;PSJPTYP - P1 ; P2
 ; Where P1 is "I" for Inpatient, "O" for Outpatient
 ;       P2 is the Inpatient Order Number (for PSJ use only)
 ;PSJOCERR(DRUG NAME)="Reason text". Where Drug Name can be either OI name or AD/SOL name.
 NEW PSJOCERR
 ;Quit OC if FDB link is down.  PSGORQF is defined if user wish to stop the order process
 I $$SYS^PSJOCERR() Q
 ;
 I $D(PSJDGCK) W !!,"Building MEDS profile please wait...",!
 D BLD^PSODDPR4(DFN,"PSJPRE",.PSPDRG,PSJPTYP)
 D DISPLAY
 K ^TMP($J,"PSJPRE")
 Q
DISPLAY ;
 NEW PSJPAUSE,PSJOLDSV,PSJDNM,PSJMON,PSJOC,PSJOCDT,PSJOCDTL,PSJOCLST,PSJP,PSJS,PSJPON,PSJDN,PSJSEV,PSJECNT
 D GMRAOC
 Q:'$$DSPSERR()
 D FULL^VALM1
 W @IOF,"Now Processing Enhanced Order Checks!  Please wait...",!
 ; If there are no OC or errors to display, this var will trigger a pause before continue /w the order
 S PSJPAUSE=1
 D DRUGERR
 I $D(PSJDGCK) W:'$D(^TMP($J,"PSJPRE","OUT","DRUGDRUG"))&'$D(^TMP($J,"PSJPRE","OUT","THERAPY",1)) !,"No Order Check Warnings Found",!
 ;Process drug interaction & drug interception
 D DI^PSJOCDI
 Q:$G(PSGORQF)
 D DSPERR^PSJOCERR("DRUGDRUG")
 ;Process duplicate therapy order checks
 D:'$D(PSJDGCK) DT^PSJOCDT
 I $D(PSJDGCK) D:$D(^TMP($J,"PSJPRE","OUT","THERAPY")) DTDGCK^PSJOCDT
 D:'$G(PSGORQF) DSPERR^PSJOCERR("THERAPY")
 I $D(PSJDGCK),'$D(^TMP($J,"PSJPRE","OUT","THERAPY")) D PAUSE^PSJLMUT1 Q  ;DX action
 Q:$G(PSGORQF)
 D:$G(PSJPAUSE) PAUSE^PSJLMUT1
 Q
 ;
GMRAOC ;Display allergy & CPRS OC regardless if FDB is connected
 D ALLERGY
 D CPRS^PSJOCOR(.PSPDRG)
 Q
ALLERGY ;Do allergy order check
 ;The allergy check will be processed for each of the dispense drug stores in the PSJALLGY array
 ;PSJALLGY(X)="" Where X is the disp drug IEN.  PSJALLGY array store all dispense drugs use in an order
 ;
 I '$D(PSJDGCK) D
 .NEW PSJDD
 .F PSJDD=0:0 S PSJDD=$O(PSJALLGY(PSJDD)) Q:'PSJDD  D EN^PSJGMRA(DFN,PSJDD)
 I $D(PSJDGCK) D
 .S PSJXX="" S PSJYY=1
 .F  S PSJXX=$O(^TMP($J,"PSJPRE","IN","PROSPECTIVE",PSJXX)) Q:PSJXX=""  D
 ..S PSJALLGY(PSJYY,$P(^TMP($J,"PSJPRE","IN","PROSPECTIVE",PSJXX),U,3))=""
 ..S PSJYY=PSJYY+1
 .F PSJDD=0:0 S PSJDD=$O(PSJALLGY(PSJDD)) Q:'PSJDD  F PSJCC=0:0 S PSJCC=$O(PSJALLGY(PSJDD,PSJCC)) Q:'PSJCC  D EN^PSJGMRA(DFN,PSJCC)
 K PSJXX,PSJYY,PSJDD,PSJCC,PSJALLGY
 Q
DSPORD(ON,PSJNLST,PSJCLINF) ;Display the order data
 ;ON - ON_U/V/P ex: 21V
 ;PSJNLST - It's number list and also use to trigger pg break, line break
 NEW PSJCOL,PSJX,PSJOC,PSJLINE,X
 Q:ON=""
 S:'$D(PSJCLINF) PSJCLINF=";0"
 S PSJLINE=1,PSJCOL=1
 I $P(PSJCLINF,";",2) D CLNDISP^PSJCLNOC(.PSJCLINF) D  Q
 .I $G(PSJNLST)="",(($Y+6)>IOSL) D PAUSE^PSJLMUT1 W @IOF
 I ON'["V" D DSPLORDU^PSJLMUT1(DFN,ON)
 I ON["V" D DSPLORDV^PSJLMUT1(DFN,ON)
 F PSJX=0:0 S PSJX=$O(PSJOC(ON,PSJX)) Q:'PSJX  D
 . I $G(PSJNLST)="",(($Y+6)>IOSL) D PAUSE^PSJLMUT1 W @IOF
 . W !
 . I $G(PSJNLST) W:(PSJX=1) PSJNLST W:(PSJX>1) ?$L(PSJNLST)
 . S X=PSJOC(ON,PSJX)
 . W $E(X,9,$L(X))
 W !
 Q
 ;
DRUGERR ;Display drug level errors
 NEW PSJPON,PSJN,PSJNV,PSJDSPFG,PSJPERR,PSJX
 ;Only display the exceptions once per patient.
 ;PSJEXCPT(PSJDNM_REASON) - Array for invalid drugs that already display to once within a pt selection
 S PSJDSPFG=0
 S PSJPERR=$$PROSPERR()
 S PSJPON="" F  S PSJPON=$O(^TMP($J,"PSJPRE","OUT","EXCEPTIONS",PSJPON)) Q:PSJPON=""  D
 . F PSJN=0:0 S PSJN=$O(^TMP($J,"PSJPRE","OUT","EXCEPTIONS",PSJPON,PSJN)) Q:'PSJN  D
 .. S PSJNV=$G(^TMP($J,"PSJPRE","OUT","EXCEPTIONS",PSJPON,PSJN))
 .. I ($P(PSJPON,";",3)="PROSPECTIVE") S PSJX='$$ERRCHK("PROSPECTIVE",$P(PSJNV,U,3)_$P(PSJNV,U,10))
 .. I PSJPERR,($P(PSJPON,";",3)="PROFILE") Q
 .. I ($P(PSJPON,";",3)="PROFILE"),'$$ERRCHK("PROFILE",$P(PSJNV,U,3)_$P(PSJNV,U,10)) Q
 .. D DSPDRGER()
 I PSJDSPFG D PAUSE^PSJLMUT1 W @IOF
 Q
DSPDRGER(PSJDSFLG) ;
 NEW PSJTXT
 S PSJTXT=$P(PSJNV,U,7)
 S X="Enhanced Order Checks cannot "
 I $G(PSJDSFLG),(PSJTXT[X) S PSJTXT="Dosing Checks could not "_$P(PSJTXT,X,2)
 S PSJDSPFG=1
 K PSJPAUSE
 I ($Y+6)>IOSL D PAUSE^PSJLMUT1 W @IOF
 W !
 D WRITE^PSJMISC(PSJTXT,,79)
 D:$P(PSJNV,U,10)]"" WRITE^PSJMISC("Reason: "_$P(PSJNV,U,10),3,79)
 W !
 Q
ERRCHK(PSJTYPE,PSJX) ;
 ;PSJTYPE - Either "PROFILE" or "PROSPECTIVE"
 ;PSJX - Drug name_Error reason
 ;Return 1 if this error drug has not displayed to the user.
 I $G(PSJX)="" Q 0
 I $G(PSJTYPE)="" Q 0
 I PSJTYPE="PROFILE",'$D(PSJEXCPT(PSJTYPE,PSJX)) S PSJEXCPT(PSJTYPE,PSJX)="" Q 1
 I PSJTYPE="PROSPECTIVE",'$D(PSJEXCPT(PSJTYPE,PSJX)) S PSJEXCPT(PSJTYPE,PSJX)="" Q 1
 Q 0
PING(PSJMSG) ;Check if FDB is down.  Return 0 if it is
 ;pass in a message to customize the display
 S ^TMP($J,"PSJPRE","IN","PING")=""
 D IN^PSSHRQ2("PSJPRE")
 Q $$DSPSERR($G(PSJMSG))
DSPSERR(PSJMSG) ;Display system errors
 NEW X
 S X=$G(^TMP($J,"PSJPRE","OUT",0))
 I $P(X,U)=-1 D NOFDB($P(X,U,2),$G(PSJMSG))
 Q $S($P(X,U)=-1:0,1:1)
NOFDB(PSJX,PSJMSG) ;Display connection down message
 Q:$G(PSJX)=""
 I $G(PSJMSG)]"" W !!,"No dosing checks can be performed"
 I $G(PSJMSG)="" W !!,"No Enhanced Order Checks can be performed."
 W !,"   Reason: ",PSJX,!!
 K PSJX
 Q
PROSPERR() ;Return 1 if only prospective exception should be displayed.
 NEW PSJPERR,PSJPON
 S PSJPERR=1
 ;If all prospectives are caught in the exception then display them only and omit the profile drugs
 S PSJPON="" F  S PSJPON=$O(^TMP($J,"PSJPRE","IN","PROSPECTIVE",PSJPON)) Q:PSJPON=""  Q:'PSJPERR  D
 . I $D(^TMP($J,"PSJPRE","OUT","EXCEPTIONS",PSJPON)) Q
 . S PSJPERR=0
 Q PSJPERR
