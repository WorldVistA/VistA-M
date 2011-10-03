IBAECM3 ;WOIFO/SS-LTC PHASE 2 MONTHLY JOB PART 3 ; 20-FEB-02
 ;;2.0;INTEGRATED BILLING;**176**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
MJ1ST ;entry for the first Monthly Calculation Process
 N IBMDS1
 ;------ variables
 N IBMJ1ST S IBMJ1ST="MJ1ST" ;to identify 1st MJ in IBAECU4
 N IBPRMNTH S IBPRMNTH=$$PREVMNTH^IBAECM1() ;last day of previous month
 N IBCLKAD1 ; variable to return back from PROCPAT info for clock adjustment
 N IBDFN,IBMNS,IBVAR
 N IBCLKIE1
 N IBCLKDAT ;clock data
 N IBSTRTD ;EFFECTIVE DATE
 S (IBMNS,IBMDS1)=""
 S IBSTRTD=$$BILDATE^IBAECN1()
 K ^TMP($J,"IBMJERR")
 K ^TMP($J,"IBMJINP")
 K ^TMP($J,"IBMJOUT")
 ;prepare arrays for months since the effective date
 D PRMONTHS(.IBMNS,IBPRMNTH)
 ;go thru all patients in #351.81
 S IBDFN1=0
 ;for each patient in file 351.81
 F  S IBDFN1=$O(^IBA(351.81,"C",IBDFN1)) Q:+IBDFN1=0  D
 . S IBCLKIE1=0,IBERR=""
 . F  S IBCLKIE1=+$O(^IBA(351.81,"C",IBDFN1,IBCLKIE1)) Q:+IBCLKIE1=0  D
 . . S IBCLKDAT=^IBA(351.81,IBCLKIE1,0)
 . . ; quit if STATUS'=OPEN
 . . Q:$P(IBCLKDAT,"^",5)'=1
 . . ; quit if CURRENT EVENTS DATE="" i.e. no LTC events happend 
 . . ; this month for the patient
 . . Q:$P(IBCLKDAT,"^",7)=""
 . . ; quit if CURRENT EVENTS DATE>last day of "real-time" previous month -the veteran 
 . . ; has been processed for all months in the past
 . . Q:$P(IBCLKDAT,"^",7)>IBPRMNTH
 . . ; if error save it in ^TMP for further e-mail
 . . S IBCLKAD1=""
 . . ;process the patient
 . . S IBVAR=0
 . . F  S IBVAR=$O(IBMNS(IBVAR)) Q:+IBVAR=0  D
 . . . Q:$$CHKXTMP(IBDFN1,IBVAR)  ;check if it was a crush and the month has been already processed
 . . . M IBMDS1=IBMNS(IBVAR) ;set month to process
 . . . S IBMDS1=$E(IBMDS1(1),6,7)
 . . . D CHNGEVEN^IBAECU4(IBCLKIE1,IBDFN1,IBMDS1(0)) ;set CURRENT EVENT DATE to a date of the MONTH (say,1st day)
 . . . I $$PROCPAT^IBAECM2(.IBMDS1,IBDFN1,IBSTRTD,IBCLKIE1)=-1 D  ;perform calcualtion
 . . . . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBCLKIE1),"Charge","Error with LTC clock creation occured during calculation, no proper charges have been created") Q
 . . . D UPDXTMP(IBDFN1,IBVAR) ;mark the month as done
 . . D DELXTMP(IBDFN1)
 ;send all errors to user group
 D SENDERR^IBAECU5 ;send all errors
 ;if we reach this place that means that we processed everybody
 ;and we stamp the date into IB SITE PARAMETERS 
 S $P(^IBE(350.9,1,0),"^",16)=$$TODAY^IBAECN1()
 ;if Nightly Job founds that date $P(^IBE(350.9,1,0),"^",16)
 ;is less that begining of current month than NJ runs MJ again and MJ will 
 ;process a rest patients
 D KILLXTMP ;delete ^XTMP
 Q
 ;IBALLM - Array with month info
 ;  IBALLM (0)-first day of the month
 ;  IBALLM (1)-last day of the month
 ;  IBALLM (2)-yyymm in Fileman format (like 30201 - for Jan 2002)
 ;IBPRMNTH -Last day of the last mont
PRMONTHS(IBALLM,IBPRMNTH) ;prepare months
 S IBALLM=""
 N X,IB176YM,IB176TMP
 S IB176YM=$E($$BILDATE^IBAECN1(),1,5)
 F  Q:IB176YM>$E(IBPRMNTH,1,5)  D
 . S X=IB176YM_"01"
 . S IBALLM(IB176YM,1)=$$LASTDT^IBAECU(X)
 . S IBALLM(IB176YM,2)=$E(IBALLM(IB176YM,1),1,5)
 . S IBALLM(IB176YM,0)=IBALLM(IB176YM,2)_"01",IBALLM=$E(IBALLM(IB176YM,1),6,7)
 . I +$E(IB176YM,4,5)=12 S IB176YM=$E(IB176YM,1,3)+1,IB176YM=IB176YM_"01" Q
 . S IB176YM=IB176YM+1
 Q
 ;
KILLXTMP ;
 K ^XTMP("IBAEC-P176")
 Q
 ;
 ;IBDFN - ien of #2
 ;IBYM - year_month in yyymm format
CHKXTMP(IBDFN,IBYM) ;check if ^XTMP for the patient and month is exist
 Q $D(^XTMP("IBAEC-P176",IBDFN,IBYM))>0
 ;
 ;IBDFN - ien of #2
 ;IBYM - year_month in yyymm format
UPDXTMP(IBDFN,IBYM) ;update XTMP with new info
 N IBDT S IBDT=$$TODAY^IBAECN1()
 S ^XTMP("IBAEC-P176",0)=$$CHNGDATE^IBAECU4(IBDT,30)_"^"_IBDT_"^1st LTC copay calculation"
 S ^XTMP("IBAEC-P176",+IBDFN,IBYM)=""
 Q
 ;
 ;IBDFN - ien of #2
DELXTMP(IBDFN) ;Kills ^XTMP node for the patient.
 K ^XTMP("IBAEC-P176",+IBDFN)
 Q
 ;
