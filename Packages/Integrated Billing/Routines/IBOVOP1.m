IBOVOP1 ;ALB/RLW-Report of Visits for NSC Outpatients ;12-JUN-92
 ;;2.0;INTEGRATED BILLING;**52,91,99,132,156,176,234,249,339,372**;21-MAR-94;Build 12
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
MAIN(IBQUERY) ; perform report for day(s)
 ; IBQUERY = the query object to use to search for outpt encounters
 ;           if not a valid #, a new QUERY will be created
 D HDR^IBOVOP2
 I $$STOP^IBOUTL("Outpatient/Registration Events Report") S IBQUIT=1 G END
 ; scan visits for NSC patients
 N IBVAL,IBCBK,IBCK,IBFILTER,IBPB,IBOE,IBOE0,IBZ
 S IBVAL("BDT")=IBDATE,IBVAL("EDT")=IBDATE\1+.99
 S IBFILTER=""
 ; Look for hospital location is a clinic-type, valid Means-Test or LTC patient, and potentially billable events
 S IBCBK="I $D(^SC(""AC"",""C"",+$P(Y0,U,4))) D IBCBK^IBOVOP1(Y,Y0,.IBCK)" ; Action of scanning
 F IBZ=9,13.1 S IBCK(IBZ)=""
 D SCAN^IBSDU("DATE/TIME",.IBVAL,"",IBCBK,0,.IBQUERY) K ^TMP("DIERR",$J)
 ; Search for Inpatient Observations
 D IBOVOP^IBECEAU5(IBDATE)
 D PRINT^IBOVOP2
END K DFN,^TMP("IBOVOP",$J),IBAPPT,IBJ,IB
 Q
 ;
 ; To be executed only if the hospital location a clinic-type.
 ; Check the record, and add to the ^TMP if needed
 ; IBENC - encounter IEN
 ; IBENCZ - encounter zero-node
 ; IBCK - array of criteria flags for the $$BILLCK^IBAMTEDU() API call
IBCBK(IBENC,IBENCZ,IBCK) ;
 N IBPAT,IBDAT,Y,Y0,X
 ; Quit if not a billable event
 I '$$BILLCK^IBAMTEDU(IBENC,IBENCZ,.IBCK) Q
 S IBDAT=+IBENCZ ; Date of event
 S IBPAT=+$P(IBENCZ,U,2) Q:'IBPAT  ; Patient IEN
 ; Check for valid MT or LTC patient
 I '$$BIL^DGMTUB(IBPAT,IBDAT),+$$LTCST^IBAECU(IBPAT,IBDAT,1)'=2 Q
 D OPTENC(IBENC,IBENCZ) ; Extract Outpatient Encounter and add to the ^TMP global
 Q
 ;
 ;
OPTENC(IBOE,IBOE0) ; Extract outpatient encounter
 N IBCL,DFN,IBFLD4,IBJ,IBSEQ
 S DFN=+$P(IBOE0,U,2),IBJ=+IBOE0,IBCL=+$P(IBOE0,U,4),IBSEQ=0
 Q:'$$BIL^DGMTUB(DFN,IBJ)
 I $P(IBOE0,U,8)=1 D  ; - appt
 .;            field 4=clinic
 .;            field 5=appt type
 .;            field 6=status
 . S IBFLD4=$P($G(^SC(IBCL,0)),U)
 . I IBFLD4'="" S:+$G(^SC(IBCL,"AT"))=6 IBFLD4=$E(IBFLD4,1,13)_" [R]"
 . S ^TMP("IBOVOP",$J,$$FLD1(DFN),"CLINIC APPT",$$FLD3(IBJ,1),0)=$E(IBFLD4,1,17)_U_$$FLD5($P(IBOE0,U,10))_U_$E($$EXTERNAL^DILFD(409.68,.12,"",$P(IBOE0,"^",12)),1,17)_U_DFN_U_IBOE Q
 ;
 I $P(IBOE0,U,8)=2 D  ; - add/edit stop code
 .;           field 5=appt type
 . S ^TMP("IBOVOP",$J,$$FLD1(DFN),"STOP CODE",$$FLD3(IBJ,1),IBSEQ)=$E($P($G(^DIC(40.7,$P(IBOE0,U,3),0)),U),1,16)_U_$$FLD5($P(IBOE0,U,10))_"^^"_DFN_U_IBOE,IBSEQ=IBSEQ+1
 ;
 I $P(IBOE0,U,8)=3 D  ; - registration
 . Q:'$$DISCT^IBEFUNC(IBOE,IBOE0)
 . S IBDATA=$$DISND^IBSDU(IBOE,IBOE0)
 . S IBFLD4=$E($$EXTERNAL^DILFD(2.101,2,"",$P(IBDATA,U,3)),1,16)
 . S Y=$E($$EXTERNAL^DILFD(2.101,6,"",$P(IBDATA,U,7)),1,30)
 . S ^TMP("IBOVOP",$J,$$FLD1(DFN),"REGISTRATION",$$FLD3(IBJ,1),0)=IBFLD4_U_Y_"^^"_DFN_U_IBOE
 ;
 K IBB,IBE,IBX,IBY,IBCLN,IBXP,IBDFN,IBAPDT,IBAPTYP,X,Y
 Q
CKENC(IBOE,IBOE0,IBSEQ) ;
 S DFN=$P(IBOE0,U,2),IBJ=+IBOE0
 Q
 ;
FLD1(DFN) ; get patient name, l-4 ssn id, classification, insured?
 I '$G(DFN) Q ""
 N IBX,IBY,IBZ S IBX=$$PT^IBEFUNC(DFN),IBZ=""
 D CL^IBACV(DFN,IBDATE,"",.IBY)
 I $D(IBY(1)) S IBZ="AO"
 I $D(IBY(2)) S IBZ=IBZ_$S(IBZ]"":"/",1:"")_"IR"
 I $D(IBY(3)) S IBZ=IBZ_$S(IBZ]"":"/",1:"")_"SC"
 I $D(IBY(4)) S IBZ=IBZ_$S(IBZ]"":"/",1:"")_"SWA"
 I $D(IBY(5)) S IBZ=IBZ_$S(IBZ]"":"/",1:"")_"MST"
 I $D(IBY(6)) S IBZ=IBZ_$S(IBZ]"":"/",1:"")_"HNC"
 I $D(IBY(7)) S IBZ=IBZ_$S(IBZ]"":"/",1:"")_"CV"
 I $D(IBY(8)) S IBZ=IBZ_$S(IBZ]"":"/",1:"")_"SHAD"
 Q $E($P(IBX,U),1,20)_" "_$E(IBX)_$P(IBX,U,3)_$S(IBZ]"":"    ["_IBZ_"]",1:"")_$S($$INSURED^IBCNS1(DFN,IBDATE):"    **Insured**",1:"")
 ;
FLD3(Y,IBMID) ; time - convert date/time to time only, no seconds
 I +$G(IBMID) Q:$G(Y)'["." "00.00"
 I '$G(Y) Q ""
 X ^DD("DD") Q $P($P(Y,"@",2),":",1,2)
 ;
FLD5(I) ; get appointment type name
 Q $E($P($G(^SD(409.1,+$G(I),0)),U,1),1,17)
