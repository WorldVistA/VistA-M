IBAECN1 ;WOIFO/SS-LTC PHASE 2 NIGHTLY JOB ; 20-FEB-02
 ;;2.0;INTEGRATED BILLING;**176,188**;21-MAR-94
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BILDATE() ;billing start date for Long Term Care Billing
 ; Means Test for LTC care billing stopped on JUNE 17,2002 /see 
 ; STDATE^IBAECU1()/ . LTC billing for LTC care must start on 
 ; JULY 26,2002. There is no billing for LTC care in period 
 ; between JUNE 17,2002 and JULY 26,2002. That means LTC clock
 ; will start on JULY 5,2002 (because of 21 "free" days)
 Q 3020705  ;
 ;
NJ ;LTC Nightly job
 N X I $D(^%ZOSF("TRAP")) S X="ERR^IBAECN1",@^("TRAP")
 N IBPRMNTH S IBPRMNTH=$$PREVMNTH^IBAECM1() ;last day of previous month
 Q:$$BILDATE()>IBPRMNTH
 ;
 N IBLSTMJ S IBLSTMJ=$$LASTMJ^IBAECU()
 ;run code for the 1st monthly job
 I IBLSTMJ=0 D MJ1ST^IBAECM3 Q
 ;if was run & successfully completed this month- quit
 Q:IBLSTMJ'<($E($$TODAY(),1,5)_"01")
 ;------- local arrays
 ;IBMDS1(0)-1st,IBMDS1(1) last day in the month,
 ;IBMDS1(2)-year_month, IBMDS1 - number of days
 N IBMDS1 S IBMDS1=""
 ;dates,days for processing month which is normally
 ; previous month because MJ runs 1stday of the month
 S IBMDS1(1)=IBPRMNTH,IBMDS1(2)=$E(IBMDS1(1),1,5)
 S IBMDS1(0)=IBMDS1(2)_"01",IBMDS1=$E(IBMDS1(1),6,7)
 D MJT^IBAECM1
 D RESET
 Q
 ;
ERR ;Error trap for NJ
 N XMSUB,XMTEXT,XMY,XMZ,XMMG,IBL,IBT,XMDUZ,IBPAT,IBTODAY
 N XMGROUP S XMGROUP=$$GET1^DIQ(350.9,"1,",.09)
 Q:XMGROUP=""
 S XMGROUP="G."_XMGROUP
 S IBPAT="Unknown",IBTODAY=""
 N Y D NOW^%DTC S Y=% X ^DD("DD") S IBTODAY=Y
 I +$G(DFN)>0 D
 . N VADM,VA,VAERR
 . D DEM^VADPT
 . S IBPAT=$G(VADM(1))_", SSN: "_$P($G(VADM(2)),"^",2)
 S:IBPAT=", SSN: " IBPAT="Unknown"
 S XMSUB="LTC Monthly Job Failure",XMY(XMGROUP)=""
 S XMTEXT="IBT(",XMDUZ="INTEGRATED BILLING PACKAGE"
 S IBT(1,0)="**********************************************"
 S IBT(2,0)="LTC Monthly Job crashed on "_IBTODAY
 S IBT(3,0)="when the system was processing the following patient : "
 S IBT(4,0)="  "_IBPAT
 S IBT(5,0)="Please verify data for the patient, fix findings"
 S IBT(6,0)="and then:"
 S IBT(7,0)="- if today is the last day of the month then you"
 S IBT(8,0)="  need to run NJ^IBAECN1 today manually from"
 S IBT(9,0)="  programmer mode."
 S IBT(10,0)="- otherwise let the system run the NJ^IBAECN1"
 S IBT(11,0)="  automatically after midnight."
 S IBT(12,0)=""
 S IBT(13,0)="In both cases, please, check patient's charges and"
 S IBT(14,0)="your e-mail again."
 D ^XMD
 Q
 ;
 ;checks if the most recent treating specialty of the admission 
 ;is related to LTC?
 ;invoked from PROC^IBAMTC Exmpl: 
 ;   I $$ISLTCADM(DFN,IBA)
 ;to create entries in 351.81 if necessary
 ;Input:
 ;IBDFN - patient's ien in file (#2)
 ;IB405 - ien of admission (#405)
 ;Output:
 ;returns 0 if the specialty for non-LTC care
 ;otherwise - returns 1
 ;
ISLTCADM(IBDFN,IB405) ;
 ;1) treat all LTC as Means Test if the legislation is not effective yet
 I $$YESTRDAY()<$$BILDATE() Q 0
 N IBSPEC,IBTS
 S IBTS="M"
 ;2) determine treating specialty (TS)
 S IBSPEC=$$LASTTS(IBDFN,IB405) ;most recent TS (pointer #42.4)
 I IBSPEC>0 S IBTS=$P($$TREATSP^IBAECU2(IBSPEC),"^",1) ;is it LTC or not?
 I IBSPEC'>0 S IBTS="M" ;treat unknown as Means Test
 I IBTS="L" D  Q 1  ;if TS is LTC
 . I $$CLOCK^IBAECU(IBDFN,$$YESTRDAY())
 Q 0
 ;finds the most recent parent entry in #350 related to admission
 ;Input:
 ;IBDFN - patient's dfn
 ;IBDT - the date to seek from (today)
 ;IBADM - admission we are seeking for
 ;IBSTAT = status we are seeking for
 ;output:
 ;returns ien_of_350^IB_action_type
 ;or "0^" if not found
FIND350(IBDFN,IBDATE,IBADM,IBSTAT) ;
 N IB350,IBDT,IBINF,IBFL
 S IBFL=0,IBINF=""
 S IBDT=-IBDATE F  S IBDT=$O(^IB("AFDT",IBDFN,IBDT)) Q:IBFL!(+IBDT=0)  D
 . S IB350=0 F  S IB350=$O(^IB("AFDT",IBDFN,IBDT,IB350)) Q:+IB350=0  D
 . . Q:'$D(^IB("AC",IBSTAT,IB350))
 . . S IBINF=$G(^IB(IB350,0))
 . . Q:IB350'=$P(IBINF,"^",16)  ;non parent
 . . Q:$P($P(IBINF,"^",4),":",1)'="405"  ;non inpatient
 . . S:$P($P(IBINF,"^",4),":",2)=IBADM IBFL=IB350
 Q IBFL_"^"_$P($G(IBINF),"^",3)
 ;
 ;edit  #350 event entry
 ;IBIENCL - ien of #350
 ;IBLSTDT = DATE LAST BILLED
 ;IBADM - ien in #405
STAT350(IBIENCL,IBLSTDT,IBADM) ;
 N IBIENS,IBFDA,IBERR,IBDFN1
 S IBDFN1=$P($G(^IB(IBIENCL,0)),"^",2)
 Q:+IBDFN1=0
 S IBIENS=IBIENCL_"," ; "D0,"
 S IBFDA(350,IBIENS,13)=+$G(DUZ)
 S:'$P($G(^IB(IBIENCL,0)),"^",17) IBFDA(350,IBIENS,.17)=(+$G(^DGPM(IBADM,0)))\1
 S IBFDA(350,IBIENS,.18)=(+$G(IBLSTDT))\1
 D NOW^%DTC S IBD=%
 S IBFDA(350,IBIENS,14)=IBD
 D FILE^DIE("","IBFDA","IBERR")
 I $D(IBERR) D
 . D ERRLOG^IBAECU5(+$G(IBDFN1),+$G(IBIENCL),"BILLING ACTION:","closing parent entry"_$G(IBERR("DIERR",1,"TEXT",1)))
 Q
 ;------
 ;create a new inpatient parent event entry in #350
 ;Input:
 ;DFN - patient's ien #2
 ;IBADMIEN - admission ien #405
 ;IBEVDT - event date (piece 17) for parent entry must be an admission date,
 ;IBNH:
 ;   1 - for 56 (#350.1) NHCU ADMISSION
 ;   93 - for 93 (#350.1) LTC ADMISSION
 ;   0 - all other events
 ;Returns:
 ;New ien of #350 Or 0 if not created
CREV350(DFN,IBADMIEN,IBEVDT,IBNH) ;
 Q:IBEVDT=0 0
 N IBEVDA,IBSL,IBSERV
 S IBEVDA=0
 D SERV^IBAUTL2
 I '$D(IBSITE)!('$D(IBFAC)) D SITE^IBAUTL
 S IBSL="405:"_IBADMIEN
 ;if LTC ADMISSION set IBNHLTC
 I IBNH=93 N IBNHLTC S IBNHLTC=93
 D EVADD^IBAUTL3
 Q IBEVDA
 ;
 ;Find original admission ien, considering ASIH movements
 ;Input:  ien of 405 that can be "child", for example
 ;  we have ien of Nursing Home admission
 ;  then patient moved to ASIH to hospital
 ;  if IBA is ASIH hospital admission ien then call will return 
 ;  "original" Nursing Home admission's ien
 ;Output:  ien of 405 of "original" admission
ORIGADM(IBA) ;
 N X,Y,Z S Z=IBA
 F  S X=$G(^DGPM(Z,0)),Y=$P(X,"^",21) Q:Y=""  S Z=+$P($G(^DGPM(Y,0)),"^",14)
 Q +Z
 ;
 ;most recent treating specialty
 ;input:
 ;IBDFN - patient ien
 ;IB405ADM - admission's #405 ien
 ;output:
 ;returns ien of SPECIALTY FILE (#42.4)
LASTTS(IBDFN,IB405ADM) ;
 N IBDT6,IBSPEC
 S IBDT6=0
 S IBDT6=+$O(^DGPM("ATS",IBDFN,IB405ADM,IBDT6))
 Q:+IBDT6=0 -1  ;error
 S IBSPEC=$O(^DGPM("ATS",IBDFN,IB405ADM,IBDT6,0))
 Q:+IBSPEC=0 -1  ;error
 ;convert fac spec (45.7) -> treat spec (#42.4)
 S IBSPEC=+$P($G(^DIC(45.7,IBSPEC,0)),"^",2)
 Q:+IBSPEC=0 -1
 Q IBSPEC
 ;returns today date
TODAY() ;
 N X
 D NOW^%DTC
 Q X
 ;returns yesterday  date
YESTRDAY() ;
 N X1,X2,X
 S X1=$$TODAY()
 S X2=-1
 D C^%DTC
 Q X
 ;returns 1 if the most recent treating specialty for this billable
 ;event and for this date was LTC
 ;DFN -patient ien
 ;IBEVDA - ien of event in #350
 ;IBDT - date
ASIHORG(DFN,IBEVDA,IBDT) ;
 N IB405 S IB405=+$P($P($G(^IB(+IBEVDA,0)),"^",4),":",2)
 Q:IB405=0 0
 Q $$ISLTC4DT(DFN,IB405,IBDT_.2359)
 ;
 ;returns 1 if the most recent treating specialty for the admission 
 ;and the date was LTC specialty
 ;otherwise returns 0 or -1
 ;DFN -patient ien
 ;IB405ADM - ien of #405
 ;IBDT - date
ISLTC4DT(IBDFN,IB405ADM,IBDT) ;
 N IBDT6,IBSPEC,IBTS
 S IBDT6=9999999.9999999-IBDT
 S IBDT6=+$O(^DGPM("ATS",IBDFN,IB405ADM,IBDT6))
 Q:+IBDT6=0 -1  ;error
 S IBSPEC=$O(^DGPM("ATS",IBDFN,IB405ADM,IBDT6,0))
 Q:+IBSPEC=0 -1  ;error
 ;convert fac spec (45.7) -> treat spec (#42.4)
 S IBSPEC=+$P($G(^DIC(45.7,IBSPEC,0)),"^",2)
 I IBSPEC>0 S IBTS=$P($$TREATSP^IBAECU2(IBSPEC),"^",1) ;is it LTC or not?
 I IBSPEC'>0 S IBTS="M" ;unknown as Means Test
 I IBTS="L" Q 1  ;if TS is LTC
 Q 0
 ;
RESET ; this will reset the ^xtmp global
 K ^XTMP("IB1010EC")
 S ^XTMP("IB1010EC",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^LIST OF PATIENTS ALREADY REPORTED AS MISSING 1010EC INFO"
 Q
 ;
