IBEFUNC3 ;ALB/ARH - EXTRINSIC FUNCTIONS ;26-FEB-02
 ;;2.0;INTEGRATED BILLING;**174,363**;21-MAR-94;Build 35
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
BDSRC(IBVIFN) ; Check if billable Visit Data Source (9000010,81203)
 ; only 'PROSTHETICS DATA' is non-billable (patch IB*2*174) (these are item, not visits)
 ; Input:   IBVIFN pointer to Visit (9000010)
 ; Returns: true if Billable Data Source
 N IBDS,IBDSN,IBFLG S IBDSN="",IBFLG=1
 ;
 I +$G(IBVIFN) S IBDS=$P($G(^AUPNVSIT(+IBVIFN,812)),U,3) I +IBDS S IBDSN=$P($G(^PX(839.7,+IBDS,0)),U,1) D
 . I IBDSN="PROSTHETICS DATA" S IBFLG=0
 Q IBFLG
 ;
VALNDC(IBIFN,IBDFN,IBRXARY) ; NDC validation between file 362.4 and 52
 ; IB*2*363 - NDC from file 352.4 can become out-of-synch with the latest
 ; NDC# stored in the PRESCRIPTION file (#52) as the NDC can change after
 ; the bill has been entered.  This algorithm compares the NDC# between
 ; the 2 files and returns a value which represents whether the NDC# values
 ; are the same or not the same.
 ; input - IBIFN = internal entry number of BILL/CLAIMS file (#399)
 ;         IBDFN = internal entry number of PATIENT file (#2) associated with the billing record
 ; output - IBRXARY = array (passed in by reference) representing the collection of Rx records
 ;                    that have different NDC#S between IB and OP files.
 ; IBARRAY = array containing values returned from the entry in file 362.4
 ; IBDA = internal entry number of the entry in file 362.4
 ; IBRXDA = pointer to entry in the PRESCRIPTION file (#52) associated with billing record
 ; IBDATE = Fill/refill date taken from entry in 362.4
 ; IBNDC = National Drug Code (NDC) number taken from entry in 362.4
 ; IB52NDC = NDC number taken from entry in file 52 associated with the billing record 
 N IBARRAY,IBDA,IBRXDA,IBDATE,IBNDC,IB52DATE,IB52NDC,IBRFL
 K IBRXARY  ; remove any incoming values
 K ^TMP($J,"IBEFUNC3")
 S IBDA=0 F  S IBDA=$O(^IBA(362.4,"C",IBIFN,IBDA)) Q:'IBDA  D
 . D GETS^DIQ(362.4,IBDA_",",".02;.03;.05;.08","I","IBARRAY")
 . S IBRXDA=IBARRAY(362.4,IBDA_",",.05,"I"),IBDATE=IBARRAY(362.4,IBDA_",",.03,"I")
 . I 'IBRXDA Q  ;try next if no RX ien 
 . S IBNDC=IBARRAY(362.4,IBDA_",",.08,"I")
 . S IB52NDC=$$GETNDC(IBDFN,IBRXDA,IBDATE)
 . S:IB52NDC'=IBNDC IBRXARY(IBRXDA)=$$RXAPI1^IBNCPUT1(IBRXDA,.01,"E")
 Q
 ;
GETNDC(IBDFN,IBRXIEN,IBDT) ; get NDC# associated with fill/refill in file 52
 ; Approved usage of $$GETNDC^PSONDCUT function  (IA 4705)
 ; Input - IBDFN = internal entry number of PATIENT file (#2) associated with the billing record
 ;         IBRXIEN = internal entry number of PRESCRIPTION file (#50) associated with the 
 ;                   billing record
 ;         IBDT = Fill/refill date taken from entry in 362.4
 ; Output - IBRXNDC = NDC number taken from sub-entry of REFILL multiple of file 52 associated 
 ;                    with the billing record
 ; ; IB52DT = Fill/refill date taken from top entry or refill multiple of 52
 N IBRXNDC,IB52DT
 ;  RX^PSO52API returns data existing at the 0, 2, and refill multiple of file 52
 D RX^PSO52API(IBDFN,"IBEFUNC3",IBRXIEN,,"2,R")
 S IB52DT=$G(^TMP($J,"IBEFUNC3",IBDFN,IBRXIEN,22))  ; original fill date
 I +IB52DT=IBDT S IBRXNDC=$G(^TMP($J,"IBEFUNC3",IBDFN,IBRXIEN,27))  ;original fill NDC#
 E  D 
 .; data examination needed on the REFILL multiple of file 52
 .; IBSUBDA = REFILL multiple (52.1) IEN
 . N IBSUBDA,IBQUIT
 . S (IBQUIT,IBSUBDA,IBRXNDC)=0
 . F  S IBSUBDA=$O(^TMP($J,"IBEFUNC3",IBDFN,IBRXIEN,"RF",IBSUBDA)) Q:'IBSUBDA  Q:IBQUIT  D
 . . S IB52DT=$G(^TMP($J,"IBEFUNC3",IBDFN,IBRXIEN,"RF",IBSUBDA,.01))  ; refill date
 . . I +IB52DT=IBDT S IBRXNDC=$$GETNDC^PSONDCUT(IBRXIEN,IBSUBDA),IBQUIT=1  ; refill NDC#
 Q IBRXNDC
