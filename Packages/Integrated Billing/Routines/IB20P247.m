IB20P247 ;WOIFO/SS - POST INIT ROUTINE FOR IB*2*247 ;6-OCT-03
 ;;2.0;INTEGRATED BILLING;**247**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
POST ; adding charge removal reason entries if not there
 N IBX,IBT,IBY,X,Y,DIC,DO
 D ADDCRR
 D ADDNBR
 Q
 ;
ADDCRR ; need to add charge removal reasons
 N IBX,IBT,IBY,DIC,Y,X
 F IBX=1:1 S IBY=$P($T(CRR+IBX),";",3,99) Q:IBY=""  S IBT=$P(IBY,";") I '$O(^IBE(350.3,"B",IBT,0)) K DO D
 . S DIC="^IBE(350.3,",DIC(0)="",X=IBT,DIC("DR")=$P(IBY,";",2,3)
 . D FILE^DICN I Y>0 D BMES^XPDUTL("  --> Added Charge Removal Reasons: "_IBT)
 Q
 ;
ADDNBR ; need to add non billable reasons
 F IBX=1:1 S IBT=$P($T(NBR+IBX),";",3) Q:IBT=""  I '$O(^IBE(356.8,"B",IBT,0)) K DO D
 . S DIC="^IBE(356.8,",DIC(0)="",X=IBT
 . D FILE^DICN I Y>0 D BMES^XPDUTL("  --> Added Reason Not Billable: "_IBT)
 Q
 ;
CRR ; charge removal reasons to add in #350.3
 ;;COMBAT VETERAN;.02///CV;.03///GENERIC
 ;;
NBR ; non-billable reasons to add in #356.8 if not there
 ;;HEAD/NECK CANCER
 ;;COMBAT VETERAN
 ;;
 ;
 ;-------- report for CV expiration date problem
RPT ;
 I '$$PATCH^XPDUTL("DG*5.3*576") W !,"The patch DG*5.3*576 needs to be installed to run the report." Q
 K ^TMP("DGCVEX",$J),^TMP("IBCVEX",$J)
 D EN^DGCVEXP
 N IBDFN,IBDT,IBNNN
 S IBNNN=0
 S IBDFN=0 F  S IBDFN=$O(^TMP("DGCVEX",$J,IBDFN)) Q:+IBDFN=0  D
 . S IBDT=0 F  S IBDT=$O(^TMP("DGCVEX",$J,IBDFN,IBDT)) Q:+IBDT=0  D COUNTIN(IBDFN,IBDT,.IBNNN)
 D PRINTREP(IBNNN)
 K ^TMP("DGCVEX",$J),^TMP("IBCVEX",$J)
 Q
 ;--------
 ;IBDF - patient's DFN
 ;IBD - the last date of CV
COUNTIN(IBDF,IBD,IBNN) ;
 ;3rd party claims
 N IBIEN,IBRVDT,IB1,IBTO,IBFR,IBI,IBK
 S IBIEN=0 F  S IBIEN=$O(^DGCR(399,"C",IBDF,IBIEN)) Q:+IBIEN=0  D
 . S IB1=$G(^DGCR(399,IBIEN,0))
 . Q:+$P(IB1,"^",5)=0  ;no care type
 . S IBTO=+$P($G(^DGCR(399,IBIEN,"U")),"^",2),IBFR=+$G(^DGCR(399,IBIEN,"U"))
 . ;outpatients
 . I $P(IB1,"^",5)>2 D:IBD=IBFR SETTMP(IBDF,IBD,IBIEN,1,.IBNN) Q
 . ;inpatients
 . I (IBD'<IBFR) I IBTO=0!(IBD'>IBTO) D SETTMP(IBDF,IBD,IBIEN,2,.IBNN)
 ;1st party copays
 S IBIEN=0 F  S IBIEN=$O(^IB("C",IBDF,IBIEN)) Q:+IBIEN=0  D
 . S IB1=$G(^IB(IBIEN,0)),IBFR=+$P(IB1,"^",14),IBTO=+$P(IB1,"^",15)
 . I (IBD'<IBFR),(IBD'>IBTO) D SETTMP(IBDF,IBD,IBIEN,3,.IBNN)
 Q
 ;--------
 ; print report
PRINTREP(IBNN) ;
 N IBDFN,IBDT,IB1,IBN
 D HEADER
 S IBDFN=0 F  S IBDFN=$O(^TMP("IBCVEX",$J,IBDFN)) Q:+IBDFN=0  D
 . S IBDT=0 F  S IBDT=$O(^TMP("IBCVEX",$J,IBDFN,IBDT)) Q:+IBDT=0  D
 .. S IBN=0 F  S IBN=$O(^TMP("IBCVEX",$J,IBDFN,IBDT,IBN)) Q:+IBN=0  D OUTP(IBDFN,IBDT,$G(^TMP("IBCVEX",$J,IBDFN,IBDT,IBN)))
 D FOOTER(IBNN)
 Q
 ;--------
 ;set ^TMP
SETTMP(IBDFN,IBDT,IBIEN1,IBTYP,IBNUM) ;
 S IBNUM=IBNUM+1,^TMP("IBCVEX",$J,IBDFN,IBDT,IBNUM)=IBTYP_"^"_IBIEN1
 Q
OUTP(IBDFN,IBDT,IBDATA) ;
 Q:$G(IBDATA)=""
 N Y S Y=$$PATINFO(IBDFN)
 W !,$P(Y,"^"),?30,$P(Y,"^",2),?43,$$STRDATE(IBDT),?55,$E($$BILLINFO(IBDATA),1,18)
 Q
 ;--------
 ;billing info
BILLINFO(IBDATA) ;
 I +IBDATA=3 Q $P($P($G(^IB(+$P(IBDATA,"^",2),0)),"^",11),"-",2)_" PATIENT"
 Q $P($G(^DGCR(399,+$P(IBDATA,"^",2),0)),"^")_" INSURANCE"
 ;--------
 ;Fileman date to String format
 ;Y - fileman date
STRDATE(Y) ;
 I Y>0 X ^DD("DD") Q Y
 Q ""
 ;--------
 ;patient info
PATINFO(DFN) ;
 I +$G(DFN)=0 Q "??"
 N VADM,VA,VAERR
 D DEM^VADPT
 Q $E($G(VADM(1)),1,28)_"^"_$P($G(VADM(2)),"^",2)
 ;
 ;--------
HEADER ;header
 W !,"...Please wait..."
 W !,?15,">> CV Billing Verification Report <<"
 D LINE
 W !,"Name",?30,"SSN",?43,"Date",?55,"Bill #"
 D LINE
 Q
 ;--------
FOOTER(IBNNN) ;footer
 D LINE
 W !,"Total: "_IBNNN_" bills/copays"
 Q
 ;--------
LINE ;line
 W !,"-----------------------------",?30,"------------",?43,"-----------",?55,"------------------"
 Q
 ;
