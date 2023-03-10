IBEFSMUT ;SLC/RM - OTH FSM and PP BILLING STATUS UTILITY ; Sep 29, 2020@3:51 pm
 ;;2.0;INTEGRATED BILLING;**688,697**;March 21, 1994;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Global References      Supported by ICR#   Type
 ;-----------------      -----------------   ----------
 ; ^TMP($J               SACC 2.3.2.5.1
 ; ^TMP("IBECEA"         SACC 2.3.2.5.1
 ; ^TMP("IBRBT"          SACC 2.3.2.5.1
 ;
 ;External References
 ;-------------------
 ; $$GET1^DIQ            2056                Supported
 ; GETS^DIQ              2056                Supported
 ; Y^DIQ                 2056                Supported
 ; RX^PSO52API           4820                Supported
 ;
 Q   ;No direct access
 ;
EN(DFN,BEGDT,ENDDT,LIST) ;retrieve the IB STATUS from either File #399 and #350
 ;Input   :
 ; DFN    : Internal entry number from the PATIENT file (#2) [required]
 ; BEGDT  : Date of Service [required]
 ; ENDDT  : Date of Service [required]
 ; LIST   : Subscript name used in ^TMP global [REQUIRED]
 ;Output  :
 ; Return the requested data elements from either File #399 and #350
 ;
 N IBABEG,IBAEND,IBCNT,IBOTHSTAT
 S IBCNT=0
 K ^TMP("IBECEA",$J) ;contain all date of service for the Visit/Encounter and Rx copayments
 S IBOTHSTAT="^TMP($J,"""_LIST_""")" ;contain some IB data elements based on the user specified date range
 S IBABEG=BEGDT,IBAEND=ENDDT
 ;check file #350 first if patient has a record
 ;if patient exist, collect all data and store it temporarily in ^TMP("IBECEA",$J)
 I $D(@IBOTHSTAT@(350,DFN,0)) S IBCNT=@IBOTHSTAT@(350,DFN,0)
 I $D(^IB("C",DFN)) D
 . D APTDT^IBECEA0 ;Rx charges
 . I $D(^IB("AFDT",DFN)) D APDT^IBECEA0 ;Means Test and CHAMPVA charges
 . I $D(^TMP("IBECEA",$J)) D IB350
 S @IBOTHSTAT@(350,DFN,0)=$S(IBCNT>0:IBCNT,1:"-1^NO DATA FOUND")
 ;
 ;check file #399 if patient also has a record
 ;if patient exist, collect all data and store it temporarily in ^TMP("IBECEA",$J)
 N SUB1,SUB2,IBDTFRM,IBDTTO,IBTYP399,IBN,IBD,RXRF399,IBNARR399
 S (IBCNT,RXRF399,IBTYP399)=0
 I $D(@IBOTHSTAT@(399,DFN,0)) S IBCNT=@IBOTHSTAT@(399,DFN,0)
 I $D(^DGCR(399,"C",DFN)) D
 . K ^TMP("IBRBT",$J),IBNARR399
 . D IB399 ;collects all related bill for a patient in file #399
 . ;after collecting all the bills for this patient, 
 . ;determine whether bill is inpatient,outpatient, or rx refill
 . ;1 - inpatient (as per business owner, no rx since it is a combined bill)
 . ;0 - outpatient
 . S SUB1="" F  S SUB1=$O(^TMP("IBRBT",$J,SUB1)) Q:SUB1=""  D
 . . S SUB2="" F  S SUB2=$O(^TMP("IBRBT",$J,SUB1,SUB2)) Q:SUB2=""  D
 . . . ;quit if this IBN already been evaluated
 . . . Q:$D(IBNARR399(SUB2))
 . . . S (RXRF399,IBTYP399,IBN,IBD)=0
 . . . S IBDTFRM=$P(^TMP("IBRBT",$J,SUB1,SUB2),U) ;date billed from (event date or the admission date)
 . . . S IBDTTO=$P(^TMP("IBRBT",$J,SUB1,SUB2),U,2) ;date billed to (discharge date for inpatient)
 . . . S IBTYP399=$$INPAT^IBCEF(SUB2,1) ;determine if bill is inpatient,outpatient, or rx refill
 . . . ;check if the records we are looking is in the date range
 . . . I +IBTYP399>0,'$$CHKDATE(IBDTFRM) Q  ;IBDTFRM<IBABEG!(IBDTTO>IBAEND) Q  ;inpatient date range check
 . . . I +IBTYP399<1,'$$CHKDATE(IBDTFRM) Q  ;outpatient date range check
 . . . I +IBTYP399<1 S:$D(^IBA(362.4,"C",SUB2)) RXRF399=3 ;check if there any Rx refill included for this bill
 . . . ;extract other data for this patient's bill to be displayed in the report
 . . . S IBN=SUB2,IBD=IBDTFRM D DATA399
 . . . S IBNARR399(SUB2)=""
 S @IBOTHSTAT@(399,DFN,0)=$S(IBCNT>0:IBCNT,1:"-1^NO DATA FOUND")
 K ^TMP("IBRBT",$J),^TMP("IBECEA",$J),IBNARR399
 Q
 ;
DATA399 ;IB Status in File #399
 N I,IBBILLNO,IBRTYPNME,IBRTYPIEN,IBSTAT,IBBLCLS,IBRTYPNME,IBRTYPIEN
 N IBSTAT,IBRSLTFRM,IBCHG,IBNDU1,IBLSTUSR,IBDIV,IBND0,IBNDU,IBOEIEN
 K IBARR,IBERR
 D GETS^DIQ(399,IBN_",",".01;.02;.05;.07;.11;.13;.22;2;42*","IE","IBARR","IBERR")
 Q:$D(IBERR)
 Q:'$D(IBARR)
 S (IBBILLNO,IBRTYPNME,IBRTYPIEN,IBSTAT)=""
 S IBBILLNO=IBARR(399,IBN_",",.01,"I") ;bill no
 S IBBLCLS=IBARR(399,IBN_",",.05,"I") ;bill classification
 S IBRTYPNME=IBARR(399,IBN_",",.07,"E") ;rate type name
 S IBRTYPIEN=IBARR(399,IBN_",",.07,"I") ;rate type ien
 S IBSTAT=IBARR(399,IBN_",",.13,"E") ;bill status
 S IBDIV=$$DIV^IBJDF2(IBN)
 S IBOEIEN=$$OE(IBN,IBD)
 S IBLSTUSR=IBARR(399,IBN_",",2,"E") ;user entered/edited the bill
 F I=0,"U","U1" S @("IBND"_I)=$G(^DGCR(399,IBN,I))
 ;if inpatient, disregard whatever in the REVENUE CODE multiple 399,42
 ;as per business owner, it is a combined bill
 I +IBTYP399>0 D  Q
 . S IBCNT=IBCNT+1
 . S IBRSLTFRM=+IBTYP399_":"_IBARR(399,IBN_",",.05,"E")
 . S IBCHG=$P(IBNDU1,"^",1)
 . S IBOEIEN=$P(^DGCR(399,IBN,0),U,8)
 . S @IBOTHSTAT@(399,IBD,DFN,IBCNT)=IBBLCLS_U_IBRTYPNME_U_IBN_U_IBBILLNO_U_IBRSLTFRM_U_IBCHG_U_IBSTAT_U_IBDIV_U_IBLSTUSR_U_IBOEIEN
 ;otherwise, the bill is outpatient and may have RX refill
 D RCODE399
 K IBARR,IBERR
 Q
 ;
OE(IBN,EVNTDT) ;extract the Outpatient Encounter ien in file #409.68
 ;Note: A single EVENT DATE can have one or more procedure charges but belongs to only ONE IEN in file #409.68
 ;If TMPOEIEN remains equal to 0, that means the outpatient charges is not related to any outpatient encounter in file #409.68
 N PRD399,PRDCNTR,TMPOEIEN
 S TMPOEIEN=0
 I $D(^DGCR(399,"ASD",-EVNTDT)) D
 . S PRD399="" F  S PRD399=$O(^DGCR(399,"ASD",-EVNTDT,PRD399)) Q:PRD399=""!(TMPOEIEN>0)  D
 . . S PRDCNTR="" F  S PRDCNTR=$O(^DGCR(399,"ASD",-EVNTDT,PRD399,IBN,PRDCNTR)) Q:PRDCNTR=""!(TMPOEIEN>0)  D
 . . . S TMPOEIEN=$P(^DGCR(399,IBN,"CP",PRDCNTR,0),U,20) ; extract the IEN for FILE #409.68
 Q TMPOEIEN
 ;
RCODE399 ;traverse the RC multiple to determine charges  for this event date
 N IBRVCD,IBRCCNT,IBCHG,IBBEDSEC,IBAIEN,IBRSLTFRM,IBRCTYP,RXSTATUS,IBARELDT,IBARXNUM,IBARFLDT
 N IBARFNUM,IBARXIEN,RXRCCNT,OLDBD,TYP399,RCCHRG
 S (RXRCCNT,OLDBD)=0
 S IBRVCD=0 F  S IBRVCD=$O(^DGCR(399,IBN,"RC","B",IBRVCD)) Q:'IBRVCD  D
 . S IBRCCNT=0 F  S IBRCCNT=$O(^DGCR(399,IBN,"RC","B",IBRVCD,IBRCCNT)) Q:'IBRCCNT  D
 . . ;check if this is the charge we are looking for this bill
 . . S IBCHG=$P(^DGCR(399,IBN,"RC",IBRCCNT,0),U,4) ;total charge for this RC 399.042,.04
 . . S IBRCTYP=$P(^DGCR(399,IBN,"RC",IBRCCNT,0),U,10) ;type 399.042, .1 (this could be opt,inpt, etc.)
 . . S IBBEDSEC=$P(^DGCR(399,IBN,"RC",IBRCCNT,0),U,5) ;bedsection 399.042,.05
 . . S IBBEDSEC=$$GET1^DIQ(399.1,IBBEDSEC_",",.01,"E")
 . . I IBBEDSEC["PRESCRIPTION" D  Q
 . . . Q:RXRCCNT
 . . . D IBARX362 S RXRCCNT=1 ;process all RX at once
 . . ;otherwise, extract the NON-PRESCRIPTION data
 . . ;group together ALL NON-PRESCRIPTION charges regardless of TYPE and BEDSECTION into an array
 . . I OLDBD'=IBBEDSEC S RCCHRG=0
 . . S RCCHRG=$G(RCCHRG)+IBCHG
 . . S OLDBD=IBBEDSEC
 . I IBBEDSEC'["PRESCRIPTION" D
 . . S IBRSLTFRM=$S(IBBEDSEC'["PRESCRIPTION":2,1:IBRCTYP)_":"_IBBEDSEC_":"_+IBTYP399
 . . S TYP399("NONRX")=IBRSLTFRM_U_RCCHRG
 I $D(TYP399) D
 . Q:$P($P(TYP399("NONRX"),U),":",2)["PRESCRIPTION"
 . S IBCNT=IBCNT+1
 . S IBRSLTFRM=$P(TYP399("NONRX"),U)
 . S IBCHG=$P(TYP399("NONRX"),U,2)
 . S @IBOTHSTAT@(399,IBD\1,DFN,IBCNT)=IBBLCLS_U_IBRTYPNME_U_IBN_U_IBBILLNO_U_IBRSLTFRM_U_IBCHG_U_IBSTAT_U_IBDIV_U_IBLSTUSR_U_IBOEIEN
 ;some of the RX is not captured in file #399 however it is captured in file#362.4,extract this information as well
 I RXRF399=3,'RXRCCNT D
 . S IBCHG=0,IBBEDSEC="PRESCRIPTION"
 . D IBARX362 S RXRCCNT=1
 ;some bill number does not have RC record
 I '$D(^DGCR(399,IBN,"RC","B")) D
 . F I=0,"U","U1" S @("IBND"_I)=$G(^DGCR(399,IBN,I))
 . S IBCNT=IBCNT+1,IBCHG=+$P(IBNDU1,"^",1)
 . S IBRSLTFRM=$S(IBBLCLS=3:2,IBBLCLS=4:2,1:+IBTYP399)_":"_IBARR(399,IBN_",",.05,"E")
 . S @IBOTHSTAT@(399,IBD\1,DFN,IBCNT)=IBBLCLS_U_IBRTYPNME_U_IBN_U_IBBILLNO_U_IBRSLTFRM_U_IBCHG_U_IBSTAT_U_IBDIV_U_IBLSTUSR_U_IBOEIEN
 K TYP399
 Q
 ;
IBARX362 ;determine what Rx is charged for
 N FLDT52,IBARXSUPLY,IBRXPRTLTOT,JJJ,PSO52DYSUP,PRTLRFNUM
 S IBARXNUM="" F  S IBARXNUM=$O(^IBA(362.4,"AIFN"_IBN,IBARXNUM)) Q:IBARXNUM=""  D
 . S IBAIEN="" F  S IBAIEN=$O(^IBA(362.4,"AIFN"_IBN,IBARXNUM,IBAIEN)) Q:IBAIEN=""  D
 . . S IBARFLDT=$P(^IBA(362.4,IBAIEN,0),U,3) ;this is the released date, a charge is created when rx is released
 . . S IBARFNUM=$P(^IBA(362.4,IBAIEN,0),U,10) ;fill number
 . . S IBARXIEN=$P(^IBA(362.4,IBAIEN,0),U,5) ;rxien in file #52
 . . S IBARXSUPLY=$P(^IBA(362.4,IBAIEN,0),U,6) ;rx days supply
 . . S (IBARELDT,FLDT52,IBRXPRTLTOT,PSO52DYSUP,PRTLRFNUM)=0
 . . K ^TMP($J,"IBRX339") D RX^PSO52API(DFN,"IBRX339",,IBARXNUM,"2,R,P",IBABEG,$$FMADD^XLFDT(IBAEND,366))
 . . I +^TMP($J,"IBRX339",DFN,0)<1 D RXPSO52 ;invoking this API twice since this API sometimes work, sometimes doesn't.
 . . I +^TMP($J,"IBRX339",DFN,0)<1,+IBARXIEN>0 D
 . . . K ^TMP($J,"IBRX339") D RX^PSO52API(DFN,"IBRX339",IBARXIEN,,"2,R,P",IBABEG,$$FMADD^XLFDT(IBAEND,366))
 . . . I +^TMP($J,"IBRX339",DFN,0)<1 D RXPSO52
 . . I +^TMP($J,"IBRX339",DFN,0)>0 D
 . . . I +IBARXIEN<1 S IBARXIEN=$O(^TMP($J,"IBRX339","B",IBARXNUM,""))
 . . . S RXSTATUS=$P(^TMP($J,"IBRX339",DFN,IBARXIEN,100),U) ;the current status of the RX
 . . . I IBARFNUM="" D  Q  ;check if this CHARGE is for original or partial fill
 . . . . D RXORGNAL
 . . . . I +^TMP($J,"IBRX339",DFN,IBARXIEN,"P",0)>0 D  ;check if there are any Rx partial fill for the same date OR if the rx charge is for Partial fill
 . . . . S IBRXPRTLTOT=+^TMP($J,"IBRX339",DFN,IBARXIEN,"P",0)
 . . . . F JJJ=1:1:IBRXPRTLTOT D
 . . . . . S FLDT52=$P(^TMP($J,"IBRX339",DFN,IBARXIEN,"P",JJJ,.01),U) ;rx partill fill date
 . . . . . S IBARELDT=$P(^TMP($J,"IBRX339",DFN,IBARXIEN,"P",JJJ,8),U) ;rx partial released date
 . . . . . S PSO52DYSUP=$P(^TMP($J,"IBRX339",DFN,IBARXIEN,"P",JJJ,.041),U) ;file #52 days supply
 . . . . . I (+IBARFLDT\1)=(+IBARELDT\1)!((+IBARFLDT\1)=+FLDT52\1) D
 . . . . . . I IBARXSUPLY=PSO52DYSUP,$$CHKDATE(+IBARELDT\1) D
 . . . . . . . S PRTLRFNUM=JJJ_"P" ;concatenating "P" with the partial fill number in order to distinguished from original, refill and partial fill
 . . . . . . . D IBARXREC
 . . . I IBARFNUM=0 D RXORGNAL ;this charge is for the rx original fill
 . . . I +IBARFNUM>0,+$P(^TMP($J,"IBRX339",DFN,IBARXIEN,"RF",0),U)>0  D  ;this charge if for rx refill 
 . . . . S FLDT52=$P(^TMP($J,"IBRX339",DFN,IBARXIEN,"RF",IBARFNUM,.01),U) ;rx refill fill date
 . . . . S IBARELDT=$P(^TMP($J,"IBRX339",DFN,IBARXIEN,"RF",IBARFNUM,17),U) ;rx refill released date
 . . . . I (+IBARFLDT\1)=(+IBARELDT\1),$$CHKDATE(+IBARELDT\1) D IBARXREC
 . . E  I +IBARFLDT,'+FLDT52 D  ;this is where the RX # is in text format and does not exist in file #52. Rx status will not be checked since we will not know if it is active or not
 . . . Q:'$$CHKDATE(+IBARFLDT\1)  ;check if the rx fill date is within the date range
 . . . S IBARXSUPLY=$P(^IBA(362.4,IBAIEN,0),U,6)
 . . . S IBRSLTFRM=RXRF399_":"_IBBEDSEC_":"_+IBARXIEN_":"_IBARXNUM_"-"_IBARXSUPLY_":"_+IBARFNUM_":"_$S($G(RXSTATUS)'="":RXSTATUS,1:"")
 . . . S IBCNT=IBCNT+1
 . . . S @IBOTHSTAT@(399,IBARFLDT\1,DFN,IBCNT)=IBBLCLS_U_IBRTYPNME_U_IBN_U_IBBILLNO_U_IBRSLTFRM_U_IBCHG_U_IBSTAT_U_IBDIV_U_IBLSTUSR
 . . K ^TMP($J,"IBRX339")
 Q
 ;
RXPSO52 ;
 K ^TMP($J,"IBRX339")
 D RX^PSO52API(DFN,"IBRX339",,IBARXNUM,"2,R,P",IBABEG,$$FMADD^XLFDT(IBAEND,366))
 Q
 ;
RXORGNAL ;
 S FLDT52=$P(^TMP($J,"IBRX339",DFN,IBARXIEN,22),U) ;rx original fill date
 S IBARELDT=$P(^TMP($J,"IBRX339",DFN,IBARXIEN,31),U) ;rx original fill released date
 S PSO52DYSUP=$P(^TMP($J,"IBRX339",DFN,IBARXIEN,8),U) ;file #52 days supply
 I (+IBARFLDT\1)=(+IBARELDT\1)!((+IBARFLDT\1)=+FLDT52\1) D
 . I IBARXSUPLY=PSO52DYSUP,$$CHKDATE(+IBARELDT\1) S IBARFNUM=0 D IBARXREC ;this is the original fill rx charge
 Q
 ;
IBARXREC ;capture Rx data
 S IBRSLTFRM=RXRF399_":"_IBBEDSEC_":"_IBARXIEN_":"_IBARXNUM_":"_$S(+PRTLRFNUM>0:PRTLRFNUM,1:IBARFNUM)_":"_$S($G(RXSTATUS)'="":RXSTATUS,1:"")
 S IBCNT=IBCNT+1
 S @IBOTHSTAT@(399,IBARELDT\1,DFN,IBCNT)=IBBLCLS_U_IBRTYPNME_U_IBN_U_IBBILLNO_U_IBRSLTFRM_U_IBCHG_U_IBSTAT_U_IBDIV_U_IBLSTUSR
 Q
 ;
IB350 ;extract IB status found in File #350
 N IBD,IBN,IBND,IBSTAT,IBATYP,IBCHG,IBRSLTFRM,IBBILLNO,BILGROUP,CNT
 S IBD="" F  S IBD=$O(^TMP("IBECEA",$J,IBD)) Q:'IBD  D
 . S IBN="" F  S IBN=$O(^TMP("IBECEA",$J,IBD,IBN)) Q:'IBN  D
 . . D IBSTA350
 Q
 ;
IBSTA350 ;IB status found in File #350
 N Y,C,IBDTBILLFR,IBCPTIER,IBDIV,IBSTPCODE,IBLSTUSR,IBCDENME
 S IBND=^IB(IBN,0) ;Q:$P(IBND,"^",7)=""
 S IBCNT=IBCNT+1,Y=$P(IBND,"^",5),C=$P(^DD(350,.05,0),"^",2) D Y^DIQ S IBSTAT=Y
 S IBATYP=$P($G(^IBE(350.1,+$P(IBND,"^",3),0)),"^") S:$E(IBATYP,1,2)="DG" IBATYP=$E(IBATYP,4,99)
 S (IBSTPCODE,IBCDENME)=""
 ;if outpatient charge and clinic stop, extract it
 I $E(IBATYP,1,3)="OPT",$P(IBND,"^",20) D
 . S IBSTPCODE=$P($G(^IBE(352.5,+$P(IBND,"^",20),0)),"^") ;stop code number
 . I $D(^IBE(352.5,"B",+IBSTPCODE)) S IBCDENME=$O(^IBE(352.5,"B",+IBSTPCODE,"")),IBCDENME=$P(^IBE(352.5,IBCDENME,0),U,4)
 . S IBSTPCODE=IBSTPCODE_"-"_IBCDENME
 S IBCHG=$S(IBATYP["CANCEL":"(",1:"")_"$"_$S($P(IBND,"^",7)'="":$P(IBND,"^",7),1:0)_$S(IBATYP["CANCEL":")",1:"")
 S IBRSLTFRM=$P(IBND,U,4)
 S IBBILLNO=$P(IBND,U,11)
 S IBCPTIER=$P(IBND,U,22)
 S BILGROUP=$$GET1^DIQ(350.1,+$P(IBND,"^",3)_",",.11,"I")
 S IBDIV=$P(IBND,U,13)_"-"_$$GET1^DIQ(350,IBN_",",.13,"E")
 S IBLSTUSR=$$GET1^DIQ(350,IBN_",",13,"E")
 I $P(IBRSLTFRM,":")=350 D
 . S IBDTBILLFR=$P(IBND,U,14),IBRSLTFRM=IBRSLTFRM_";"_IBDTBILLFR_":"_IBCPTIER
 S @IBOTHSTAT@(350,IBD,DFN,IBCNT)=IBATYP_U_BILGROUP_U_IBN_U_IBBILLNO_U_IBRSLTFRM_U_IBCHG_U_IBSTAT_U_IBDIV_U_IBSTPCODE_U_IBLSTUSR
 Q
 ;
IB399 ;collects all related bill for a patient in file #399
 N IBIFN,IBEVDT,IB0,IBPTF,IBADM,IBDIS,IBOPV,IBPTF1,IBXRF,IBRXN,IBRXDT,IBX
 S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"C",DFN,IBIFN)) Q:'IBIFN  D
 . S IB0=$G(^DGCR(399,+IBIFN,0)) Q:IB0=""  S IBEVDT=$P(IB0,U,3),IBPTF=$P(IB0,U,8)
 . ;check if the event date is within the date range (the time patient become OTH until PE has been VERIFIED to another PE)
 . I IBEVDT\1<IBABEG!(IBEVDT\1>IBAEND) Q
 . ;otherwise, find all bills with the Event Date (399,.03)
 . I +IBEVDT D TPEVDT^IBEFURT(DFN,IBEVDT,IBIFN)
 . ;find all bill with PTF number (399,.08)
 . ;find any bills with Outpatient Visit Dates within the date range of the admission (PTF)
 . ;find all bills that have one or more of the same Opt Visit Dates (399,43)
 . ;find any bills for inpatient admissions whose date range includes one or more of the Opt Visit Dates
 . ;find all bills that have one or more of the same Prescription: same Rx number and fill date (362.4,.01,.03)
 . D IT^IBEFUR
 Q
 ;
CHKDATE(DATE) ;
 ;check if dates fall within the Begin and End dates
 Q (IBABEG<=DATE)&(IBAEND>=DATE)
 ;
