IBAECU3 ;WOIFO/SS-LTC PHASE 2 UTILITIES ; 20-FEB-02
 ;;2.0;INTEGRATED BILLING;**176**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;****** Outpatient LTC related utilities *********
 ;/*--
 ;Returns info about all visits via ^TMP($J,IBLB,IBDFN) global
 ;
 ;Input:
 ;
 ;IBFRBEG- first date (in FM format),must be a valid,
 ;  (wrong date like 3000231 will cause mistakes)
 ;IBFREND- last date (in FM format),must be a valid date
 ;  if any of dates above > yesterday it will be set to yesterday 
 ;
 ;IBDFN  - patient's ien in file (#2)
 ;IBLB  - any string to identify results in ^TMP($J,IBLB
 ;Output:
 ;
 ;temp global array with inpatient info:
 ;  ^TMP($J,IBLB,IBDFN,date,"M"/"L",IEN40968)=L/M^stopcode^
 ;
 ;  where pieces:
 ;  #1 - "L" for LTC, "M" for MeansTest
 ;  #2 - stopcode
 ;  #3 - empty
 ;  #4 - pointer to #350.1 IB action type
 ;Returns:
 ;  0 - none
 ;  1 - if any leave or stay days in the period
OUTPINFO(IBFRBEG,IBFREND,IBDFN,IBLB) ;
 N IBVAL,IBCBK,IBFILTER,IBRES
 S IBVAL("DFN")=IBDFN,IBVAL("BDT")=IBFRBEG-.1,IBVAL("EDT")=+(IBFREND_".9999999")
 S IBFILTER=""
 ; we look only for STATUS=CHECKED OUT i.e. $P(Y0,U,12)=2 in IBCBK
 ;  consider only parent encounters, appts checked out
 S IBCBK="I '$P(Y0,U,6),$P(Y0,U,12)=2 S IBRES=$$STOPINFO^IBAECU3($P(Y0,U,3),0),^TMP($J,IBLB,IBDFN,+Y0\1,Y)=IBRES"
 D SCAN^IBSDU("PATIENT/DATE",.IBVAL,IBFILTER,IBCBK,1) K ^TMP("DIERR",$J)
 Q +$O(^TMP($J,IBLB,IBDFN,0))>0
 ;/**
 ;get stop-code related info
 ;IB407 pointer to file #40.7
 ;IBDT - date to get rate, if 0 then will not return a rate in 3rd piece
 ;returns 
 ;IBTYPE_"^"_IBCODE_"^"_IBRATE_"^"_IBATYP
 ;IBCARE - "M" for means test, "L" for LTC
 ;IBCODE - AMIS REPORTING STOP CODE
 ;IBRATE - rate for LTC, 0 for Means test
 ;IBATYP - ien of 350.1
STOPINFO(IB407,IBDT) ;
 N Y,X
 N IBI,IBCR,IBCODE,IBATYP,IBCHG
 N IBSCDATA,IBNAME
 D DIQ407^IBEMTSCU(IB407,1)
 S IBCODE=$G(IBSCDATA(40.7,IB407,1,"E"))
 Q:+IBCODE=0 ""
 S IBNAME=$P($$LTCSTOP^IBAECU(IB407),"^",2)
 Q:IBNAME="" "M^"_IBCODE_"^^"
 S IBATYP=$O(^IBE(350.1,"B",IBNAME,0))
 Q:+IBATYP=0 ""
 S IBCHG=""
 I +$G(IBDT)>0 D
 . S IBCHG=0
 . D COST^IBAUTL2
 Q "L^"_IBCODE_"^"_IBCHG_"^"_IBATYP
 ;
 ;returns rate for different LTC services
 ;INPUT:
 ;IBCARE=1 - outpatient(clinic stopcode),IBTYPE=2 - inpatient(treating specialty)
 ;IBCODE - treating specialty(outpatient) or clinic stopcode (inpatient)
 ;IBDT - date of care
 ;if not found - returns 0
GETRATE(IBCARE,IBCODE,IBDT) ;
 N IBCHG,IBATYP,IBTAG
 N IBI,IBCR,IBNAME
 S:'$D(U) U="^"
 S (IBCHG,IBATYP)=0
 S:IBCARE=1 IBTAG="C"_IBCODE,IBNAME=$P($T(@IBTAG^IBAECU1),";",3)
 S:IBCARE=2 IBTAG="T"_IBCODE,IBNAME=$P($T(@IBTAG^IBAECU1),";",3)
 Q:IBNAME="" IBCHG
 S IBATYP=$O(^IBE(350.1,"B",IBNAME,0))
 Q:+IBATYP=0 IBCHG
 D COST^IBAUTL2
 Q IBCHG_"^"_IBATYP
 ;/**
 ;is there any outp episode with that day
 ;Input:
 ;IBDFN - dfn of the patient
 ;IBDT1 - date
 ;IBTMPLB - ^TMP global subscript like IBADM in $$INPINFO
 ;Output:
 ;Returns "a^b" where :
 ;a - number of LTC admissions on this date
 ;b - number of Means Test admissions on this date
 ;if "" - nothing
 ; means test:
 ;.IBVIS("M",#)=treating specialty^
 ; LTC:  
 ;.IBVIS("L",#)=treating specialty^ien of 350.1I action type
ISOUTP(IBDFN,IBDT1,IBTMPLB,IBVIS) ;*/
 N IB40968,IBRETV,IBD,IB1
 S IB40968=0,IBRETV=""
 F  S IB40968=$O(^TMP($J,IBTMPLB,IBDFN,IBDT1,IB40968)) Q:+IB40968=0  D
 . S IBD=$G(^TMP($J,IBTMPLB,IBDFN,IBDT1,IB40968))
 . S IB1=$P(IBD,"^",1)
 . I IB1="L" S $P(IBRETV,"^",1)=$P($G(IBRETV),"^",1)+1
 . I IB1="M" S $P(IBRETV,"^",2)=$P($G(IBRETV),"^",2)+1
 . S IBVIS(IB1,IB40968)=$P(IBD,"^",2)_"^"_$P(IBD,"^",4)
 Q IBRETV
 ;
 ;checks if there is Means test outpatient visits this date and
 ;cancels them if there is a charge 
CHKMTOUT(IBDFN,IBDT,IBTMPLB) ;
 N IBV1
 N RETIENS S RETIENS=0
 S IBV1=$$ISOUTP(IBDFN,IBDT,IBTMPLB,.RETIENS) Q:+$P(IBV1,"^",2)=0
 S IBV1=0
 F  S IBV1=$O(RETIENS("M",IBV1)) Q:+IBV1=0  D
 . D CANCVIS^IBAECU5(IBDFN,IBDT)
 Q
 ;
 ;
 ;return IB action type based on treating specialty (42.4)
 ;or clinic stop code
 ;IBCARE=1 - outpatient(clinic stopcode),IBTYPE=2 - inpatient(treating specialty)
 ;IBCODE - treating specialty(outpatient) or clinic stopcode (inpatient)
GET3501(IBCARE,IBCODE) ;
 N IBATYP,IBNAME
 S:IBCARE=1 IBTAG="C"_IBCODE,IBNAME=$P($T(@IBTAG^IBAECU1),";",3)
 S:IBCARE=2 IBTAG="T"_IBCODE,IBNAME=$P($T(@IBTAG^IBAECU1),";",3)
 Q:IBNAME="" 0
 S IBATYP=$O(^IBE(350.1,"B",IBNAME,0))
 Q +IBATYP
 ;
