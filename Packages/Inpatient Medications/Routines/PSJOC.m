PSJOC ;BIR/MV - NEW ORDER CHECKS DRIVER ; 9/10/14 10:53pm
 ;;5.0;INPATIENT MEDICATIONS;**181,260,252,257,281,256,364,426**;16 DEC 97;Build 4
 ;
 ; Reference to ^PSODDPR4 is supported by DBIA# 5366.
 ; Reference to ^PSSHRQ2 is supported by DBIA# 5369.
 ;
 ;*364 - add Hazardous Handle & Dispose flags alert message.
 ;
OC(PSPDRG,PSJPTYP) ;
 ;PSPDRG - Drug array in format of PDRG(n)=IEN (#50) ^ Drug Name
 ;Where n is a sequential number.  The Drug Name can be OI, Generic name from #50, or Add/Sol name
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
 N CROCLN,CROCLN2,PSJTOFFL,PSJCROCF,PSJDRGIF,PSJDERF2,PSJDUPTF
 D FULL^VALM1 W @IOF
 D GMRAOC Q:$G(PSGORQF)
 S $P(CROCLN,"=",75)="=",$P(CROCLN2,"-",75)="-",CROCNR=1
 I '$D(PSJDGCKX) D
 .I '$D(TMPDRG1("AD",0))&('$D(TMPDRG1("SOL",0)))&($G(PSPDRG(1))) D CK^PSJCROC($P(PSPDRG(1),"^")) I $G(PSGORQF) Q
 .I $G(TMPDRG1("AD",0))>0!$G(TMPDRG1("SOL",0))>0 W "Now processing Clinical Reminder Order Checks. Please wait ..."
 .I $G(TMPDRG1("AD",0))>0 F CRIV=0:0 S CRIV=$O(TMPDRG1("AD",CRIV)) Q:'CRIV  D CKIV^PSJCROC($P(TMPDRG1("AD",CRIV),"^",1),"A")
 .I $G(TMPDRG1("SOL",0))>0 F CRIV=0:0 S CRIV=$O(TMPDRG1("SOL",CRIV)) Q:'CRIV  D CKIV^PSJCROC($P(TMPDRG1("SOL",CRIV),"^",1),"S")
 .I $G(TMPDRG1("AD",0))>0!$G(TMPDRG1("SOL",0))>0 D CKIVD^PSJCROC I $G(PSGORQF) S VALMBCK="R" Q
 K CRIV,CROCPFLG,CROCNR,PSJDGCKX
 I $G(PSGORQF) Q
 Q:'$$DSPSERR()
 W !!,"Now Processing Enhanced Order Checks! Please wait...",! S PSJTOFFL=1
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
 I '$G(PSJTOFFL) W !!,"Now Processing Enhanced Order Checks! Please wait...",! I $G(PSIVCOPY)&('$D(PSJDGCK)) D PAUSE^PSJLMUT1
 I $D(PSJDGCK),'$D(^TMP($J,"PSJPRE","OUT","THERAPY")) D PAUSE^PSJLMUT1 Q  ;DX action
 Q:$G(PSGORQF)
 I '$G(PSJDERF2)&('$G(PSJDRGIF))&('$G(PSJDUPTF)) K PSJPAUSE H 2
 I $G(PSJDERF2)&('$G(PSJDRGIF))&('$G(PSJDUPTF))&(($Y+3)<IOSL) S PSJPAUSE=1 ;error but no drug interaction or dup therapy
 I '$D(PSJDGCK) D:$G(PSJPAUSE) PAUSE^PSJLMUT1
 Q
 ;
GMRAOC ;Display allergy & CPRS OC regardless if FDB is connected
 D HAZCHK                ;Add Hazardous to Handle/Dispose warning messages       *364
 D ALLERGY Q:$G(PSGORQF)
 D CPRS^PSJOCOR(.PSPDRG)
 Q
ALLERGY ;Do allergy order check
 ;The allergy check will be processed for each of the dispense drug stores in the PSJALLGY array
 ;PSJALLGY(X)="" Where X is the disp drug IEN.  PSJALLGY array store all dispense drugs use in an order
 ;
 D FULL^VALM1
 I $G(PSIALLFL) K PSIALLFL Q
 W !!,"Now doing allergy checks.  Please wait..."
 N PSJAOC,DACNT,PSJDGFLG,PSJDGDRG S PSJAOC=1
 I '$D(PSJDGCK) D   ;sort by generic dispensed drug name
 .NEW PSJDD,PSJGDDN,PSJALGCT,PSJALLGS S PSJDD=""
 .F  S PSJDD=$O(PSJALLGY(PSJDD)) Q:'PSJDD!(PSJDD'?1N.N)  S PSJGDDN="",PSJGDDN=$$GET1^DIQ(50,PSJDD,.01) D
 ..I PSJGDDN="" S PSJALLGY("AA",PSJDD_"Z",PSJDD)="" Q
 ..S PSJALLGY("AA",PSJGDDN,PSJDD)=""
 .S (PSJDD,PSJGGDN)=""
 .F  S PSJGGDN=$O(PSJALLGY("AA",PSJGGDN)) Q:PSJGGDN=""!($G(PSGORQF))  F  S PSJDD=$O(PSJALLGY("AA",PSJGGDN,PSJDD)) Q:PSJDD=""!($G(PSGORQF))  D
 ..S PSJALGCT=$G(PSJALGCT)+1 D EN^PSJGMRA(DFN,PSJDD)
 K PSJALLGY("AA")
 I $D(PSJDGCK) D  ;CK ACTION
 .S PSJXX="" F  S PSJXX=$O(PSJALLGY(PSJXX)) Q:PSJXX=""!(PSJXX'?1N.N)  D
 ..S PSJGDDN="",PSJGDDN=$$GET1^DIQ(50,PSJXX,.01)
 ..I PSJGDDN="" S PSJALLGY($S(PSJALLGY(PSJXX)="P":"A",1:"Z"),PSJDD_"Z",PSJGDDN,PSJXX)="" Q
 ..S PSJALLGY($S(PSJALLGY(PSJXX)="P":"A",1:"Z"),PSJGDDN,PSJXX)=""
 .S (PSJALLGS,PSJXX,PSJGDDN)="",(PSJDGFLG,PSJYY)=1
 .F  S PSJXX=$O(^TMP($J,"PSJPRE","IN","PROSPECTIVE",PSJXX)) Q:PSJXX=""  D
 ..S PSJCKDRG=$P(^TMP($J,"PSJPRE","IN","PROSPECTIVE",PSJXX),U,3)
 ..S PSJGDDN=$$GET1^DIQ(50,PSJCKDRG,.01)
 ..S PSJALLGY($S($G(PSJALLGY(PSJCKDRG))="P":"A",1:"Z"),PSJGDDN_"Z",PSJCKDRG)=""
 ..I $G(PSJALLGY(PSJCKDRG))="P",$D(PSJALLGY("A",PSJGDDN,PSJCKDRG)) K PSJALLGY("A",PSJGDDN,PSJCKDRG)
 ..I $D(PSJALLGY(PSJCKDRG)) K PSJALLGY(PSJCKDRG)
 .S (PSJCC,PSJDD)=""
 .;CK action - If the manually entered drug is same as a profile drug, display as a profile drug.
 .F  S PSJDD=$O(PSJALLGY("A",PSJDD)) Q:PSJDD=""  F  S PSJCC=$O(PSJALLGY("A",PSJDD,PSJCC)) Q:PSJCC=""  D
 ..I $D(PSJALLGY("Z",PSJDD,PSJCC)) K PSJALLGY("A",PSJDD,PSJCC)
 .S (PSJALLGS,PSJDD,PSJCC)=""
 .F  S PSJALLGS=$O(PSJALLGY(PSJALLGS)) Q:PSJALLGS=""  F  S PSJCC=$O(PSJALLGY(PSJALLGS,PSJCC)) Q:PSJCC=""!($G(PSGORQF))  D
 ..F  S PSJDD=$O(PSJALLGY(PSJALLGS,PSJCC,PSJDD)) Q:PSJDD=""!($G(PSGORQF))  S:PSJALLGS="A" PSJDGFLG=0 D EN^PSJGMRA(DFN,PSJDD) S PSJDGFLG=1
 K PSJXX,PSJYY,PSJDD,PSJCC,PSJALLGY,DACNT,PSJGGDN
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
 NEW PSJPON,PSJN,PSJNV,PSJDSPFG,PSJPERR,PSJX,PSJLINEF
 ;Only display the exceptions once per patient. Use the exception from prospective drug if exception(s) existed for the 
 ; same drug on the profile.
 ;PSJEXCPT(PSJDNM_REASON) - Array for invalid drugs that already display to once within a pt selection
 S PSJDSPFG=0
 S PSJPERR=$$PROSPERR()
 I PSJPERR D  Q
 . I PSJDSPFG D PAUSE^PSJLMUT1
 I $D(PSJEXCPT("PROFILE")),'$G(PSJDGCK) Q
 S PSJPON="" F  S PSJPON=$O(^TMP($J,"PSJPRE","OUT","EXCEPTIONS",PSJPON)) Q:PSJPON=""  D
 . F PSJN=0:0 S PSJN=$O(^TMP($J,"PSJPRE","OUT","EXCEPTIONS",PSJPON,PSJN)) Q:'PSJN  D
 .. I '$G(PSJLINEF) W ! S PSJLINEF=1
 .. S PSJNV=$G(^TMP($J,"PSJPRE","OUT","EXCEPTIONS",PSJPON,PSJN))
 .. ;I ($P(PSJPON,";",3)="PROSPECTIVE") S PSJX='$$ERRCHK("PROSPECTIVE",$P(PSJNV,U,3)_$P(PSJNV,U,10))
 .. I ($P(PSJPON,";",3)'="PROFILE") Q
 .. I '$$ERRCHK("PROFILE",$P(PSJNV,U,3)_$P(PSJNV,U,10)) Q
 .. D DSPDRGER()
 I PSJDSPFG D PAUSE^PSJLMUT1 S PSJDERR2=1
 Q
DSPDRGER(PSJDSFLG) ;
 NEW PSJTXT
 S PSJTXT=$P(PSJNV,U,7)
 ;W:$G(PSGCOPY)!($G(PSIVCOPY)) !
 S X="Enhanced Order Checks cannot "
 I $G(PSJDSFLG),(PSJTXT[X) S PSJTXT="Dosing Checks could not "_$P(PSJTXT,X,2)
 S PSJDSPFG=1
 K PSJPAUSE
 I ($Y+6)>IOSL D PAUSE^PSJLMUT1 W @IOF
 W !
 D WRITE^PSJMISC(PSJTXT,,79)
 I $P(PSJNV,U,10)]"" D WRITE^PSJMISC("Reason(s): "_$P(PSJNV,U,10),3,79) S PSJDERF2=1
 ;W !
 Q
ERRCHK(PSJTYPE,PSJX) ;
 ;PSJTYPE - Either "PROFILE" or "PROSPECTIVE"
 ;PSJX - Drug name_Error reason
 ;Return 1 if this error drug has not displayed to the user.
 I $G(PSJX)="" Q 0
 I $G(PSJTYPE)="" Q 0
 ;I PSJTYPE="PROFILE",'$D(PSJEXCPT(PSJTYPE,PSJX)) S PSJEXCPT(PSJTYPE,PSJX)="" Q 1
 I PSJTYPE="PROFILE" S PSJEXCPT(PSJTYPE,PSJX)="" Q 1
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
 NEW X
 Q:$G(PSJX)=""
 I $G(PSJMSG)]"" W !!,PSJMSG
 I $G(PSJMSG)="" W !!,"No Enhanced Order Checks can be performed."
 W !,"   Reason(s): ",PSJX,!!
 K PSJX
 D:$G(PSJMSG)]"" PAUSE^PSJLMUT1
 Q
PROSPERR() ;Display exceptions for prospective drug
 NEW PSJPON,PSJN,PSJNV,PSJPERR
 ;If all prospectives are caught in the exception then display them only and omit the profile drugs
 S PSJPON="" F  S PSJPON=$O(^TMP($J,"PSJPRE","OUT","EXCEPTIONS",PSJPON)) Q:PSJPON=""  D
 . F PSJN=0:0 S PSJN=$O(^TMP($J,"PSJPRE","OUT","EXCEPTIONS",PSJPON,PSJN)) Q:'PSJN  D
 .. S PSJNV=$G(^TMP($J,"PSJPRE","OUT","EXCEPTIONS",PSJPON,PSJN))
 .. I $P(PSJPON,";",3)="PROFILE" Q 
 .. I ($P(PSJPON,";",3)="PROSPECTIVE") S PSJX='$$ERRCHK("PROSPECTIVE",$P(PSJNV,U,3)_$P(PSJNV,U,10))
 .. D DSPDRGER() S PSJDSPFG=1
 ;If the prospective drug(s) is caught in the exception, the exception for profile drug(s) is not display.
 ;  The exception for the prospective is the only one need to display.
 S PSJPERR=1
 S PSJPON="" F  S PSJPON=$O(^TMP($J,"PSJPRE","IN","PROSPECTIVE",PSJPON)) Q:PSJPON=""  D
 . I $D(^TMP($J,"PSJPRE","OUT","EXCEPTIONS",PSJPON)) Q
 . S (PSJDSPFG,PSJPERR)=0
 Q PSJPERR
 ;
HAZCHK ;Check for a hazardous drug component and display soft error type warning roll and scroll alert     *364
 N PSORDN,HDG,HAZ,HAZH,HAZD,HZAR,HTXT,LL,DRGIEN,TOP
 S (HAZH,HAZD)=0
 I $G(ON),'$G(PSGDRG),(($G(NAME)["PSJ LM UD")!($G(NAME)["PSJU LM")!($G(NAME)["PSJ LM PENDING")) D  ;Unit Dose
 . I $G(PSGORD)["P" S PSORDN="^PS(53.1,"_+PSGORD_","
 . I '$G(PSGORD),ON["P" S PSORDN="^PS(53.1,"_+ON_","
 . I $G(PSGORD),ON["U" S PSORDN="^PS(55,"_DFN_",5,"_+ON_","
 . Q:'$D(PSORDN)
 . D HAZDRUG(PSORDN,.HZAR)
 I '$D(PSJALLGY),$G(PSGDRG),$G(NAME)'["PSJ LM IV" D                                                              ;IV new dispense only
 . S HZAR(PSGDRG)=$$HAZ^PSSUTIL(PSGDRG)
 I '$D(PSJALLGY),$G(PSJORD),$G(NAME)["PSJ LM IV" D                                                               ;IV pending or edit
 . S:PSJORD["P" PSORDN="^PS(53.1,"_+PSJORD_","
 . S:PSJORD["V" PSORDN="^PS(55,"_DFN_",""IV"","_+PSJORD_","
 . Q:'$D(PSORDN)
 . D HAZDRUG(PSORDN,.HZAR)
 I $D(PSJALLGY) F DRGIEN=0:0 S DRGIEN=$O(PSJALLGY(DRGIEN)) Q:'DRGIEN  D    ;IV new order add mix 
 . S HZAR(DRGIEN)=$$HAZ^PSSUTIL(DRGIEN)
 ;display warning text(s)
 S HAZ=0,HDG=1,$P(LL,"-",80)="-"
 F DRGIEN=0:0 S DRGIEN=$O(HZAR(DRGIEN)) Q:'DRGIEN  D
 . S HAZH=$P(HZAR(DRGIEN),U),HAZD=$P(HZAR(DRGIEN),U,2)
 . Q:'(HAZH!HAZD)!('$D(DRGIEN))
 . D HAZWARNG^PSSUTIL(DRGIEN,"I",HAZH,HAZD,.HTXT) S HAZ=1
 . I HDG W #,$C(7),LL,!,$J("***** WARNING *****",47) S HDG=0   ;header
 . D WRAPTEXT(HTXT,65,5) W !                                   ;body
 D:HAZ                                                         ;footer
 . W LL,!
 . K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR
 Q
 ;
HAZDRUG(FILE,AR) ;Get Hazardous to Handle and Hazardous to Dispose fields per component and return Haz array by DRUG IEN     *364
 ; FILE = file root + Order Num from inpatient variables during workflow;  Example VAR contains: "^PS(55,DFN,5,ON," or "(PS(53.1,ON," or "^PS(55,DFN,"IV",ON,"
 ;         (build ROOT to the multiple level to find all Disp Drugs or Additives or Solution and get HAZ flags)
 ; AR   = array of component's IEN and their Haz flag settings
 N QQ,ROOT,NXTROOT,NXT,IFN,GL
 ;check IF Unit Dose Disp Drug exists for this order, then get IEN(s) and Haz flags
 I FILE[",5," F QQ=0:0 S ROOT=FILE_"1,"_QQ_")" S QQ=$O(@ROOT) Q:'QQ  D
 . S NXTROOT=FILE_"1,"_QQ_")" S NXT=$O(@NXTROOT) S GL=$E(NXTROOT,1,$L(ROOT)-1),IFN=+@(GL_",0)")
 . S AR(IFN)=$$HAZ^PSSUTIL(IFN)
 . ;check IF IV additives exist for this order, then get IEN(s) and Haz flags
 I FILE[",""IV""," F QQ=0:0 S ROOT=FILE_"""AD"","_QQ_")" S QQ=$O(@ROOT) Q:'QQ  D
 . S NXTROOT=FILE_"""AD"","_QQ_")" S NXT=$O(@NXTROOT) S GL=$E(NXTROOT,1,$L(ROOT)-1),IFN=+@(GL_",0)")
 . I IFN S IFN=+$P($G(^PS(52.6,IFN,0)),U,2),AR(IFN)=$$HAZ^PSSUTIL(IFN)
 . ;check IF IV solutions exist for this order, then get IEN(s) and Haz flags
 I FILE[",""IV""," F QQ=0:0 S ROOT=FILE_"""SOL"","_QQ_")" S QQ=$O(@ROOT) Q:'QQ  D
 . S NXTROOT=FILE_"""SOL"","_QQ_")" S NXT=$O(@NXTROOT) S GL=$E(NXTROOT,1,$L(ROOT)-1),IFN=+@(GL_",0)")
 . I IFN S IFN=+$P($G(^PS(52.7,IFN,0)),U,2),AR(IFN)=$$HAZ^PSSUTIL(IFN)
 Q
 ;
WRAPTEXT(TEXT,LIMIT,CSPACES) ;Wrap text util copied in from a PSO routine originally                  *364
 ;;FUNCTION TO DISPLAY (WRITE) TEXT WRAPPED TO A CERTAIN COLUMN LENGTH
 ;;DEFAULT=74 CHARACTERS WITH NO SPACES IN FRONT
 N WORDS,COUNT,LINE,NEXTWORD
 Q:$G(TEXT)']"" ""
 S LIMIT=$G(LIMIT,74)
 S CSPACES=$S($G(CSPACES):CSPACES,1:0)
 S WORDS=$L(TEXT," ")
 W !,$$REPEAT^XLFSTR(" ",CSPACES)
 F COUNT=1:1:WORDS D
 . S NEXTWORD=$P(TEXT," ",COUNT)
 . Q:NEXTWORD=""  ;TO REMOVE LEADING OR DOUBLE SPACES
 . S LINE=$G(LINE)_NEXTWORD_" "
 . I $L($G(LINE))>LIMIT W !,$$REPEAT^XLFSTR(" ",CSPACES) K LINE
 . W NEXTWORD_" "
 Q
