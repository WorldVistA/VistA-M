IBTRE6 ;ALB/AAS - CLAIMS TRACKING OUTPUT CLIN DATA ;2-SEP-1993
 ;;2.0;INTEGRATED BILLING;**210**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ADMDIAG(IBTRN) ; -- output admitting diagnosis (inpatient)
 ;
 N IBRES,IBDX,X
 S IBRES=""
 I '$G(IBTRN) G ADMDQ
 S IBETYP=$$TRTP^IBTRE1(IBTRN) I IBETYP>1 G ADMDQ
 S IBDX=+$O(^IBT(356.9,"ADG",+$P(^IBT(356,+IBTRN,0),"^",5),0))
 I $D(VAIN(9)) S IBRES=VAIN(9) G ADMDQ
 N VAIN,VAINDT,VA200
 S VAINDT=$P($G(^IBT(356,+IBTRN,0)),U,6)
 S VA200="" D INP^VADPT
 S IBRES=VAIN(9)
ADMDQ Q IBRES
 ;
PDIAG(IBTRN) ; -- return primary diagnosis (inpatient)
 N IBRES,IBDX
 S IBRES=""
 I '$G(IBTRN) G PDIAGQ
 S IBDX=+$G(^IBT(356.9,+$O(^IBT(356.9,"ATP",+$P(^IBT(356,+IBTRN,0),"^",5),1,0)),0))
 S IBRES=$$DIAG(IBDX,1,$$TRNDATE^IBACSV(IBTRN))
PDIAGQ Q IBRES
 ;
SDIAG ; -- return secondary diagnosis (inpatient
 Q
 ;
ODIAG ; -- return outpatient diagnosis
 Q
 ;
DIAG(IBDX,IBTXT,IBDT) ; -- Expand diagnosis from pointer
 ; -- input IBDX  = pointer to diag
 ;          IBTXT = if want text added (zero = number only)
 N IBRES,IBZ
 I '$G(IBDX) Q ""
 S IBZ=$$ICD9^IBACSV(+IBDX,$G(IBDT)) I IBZ="" Q ""
 S IBRES=$P(IBZ,U)
 I $G(IBTXT) S IBRES=IBRES_" - "_$P(IBZ,U,3)
 Q IBRES
 ;
 ;
APROV(IBTRN) ; -- return  provider (inpatient)
 ;
 N X S X=""
 I '$G(IBTRN) G APROVQ
 S X=$O(^IBT(356.94,"ATP",+$P(^IBT(356,+IBTRN,0),"^",5),2,0)) I X S X=$P($G(^IBT(356.94,+X,0)),"^",3) G APROVQ
 S X=+$O(^IBT(356.94,"ATP",+$P(^IBT(356,+IBTRN,0),"^",5),1,0)) I X S X=$P($G(^IBT(356.94,+X,0)),"^",3) G APROVQ
 I $D(VAIN(2)) S X=VAIN(2) I 'X S X=$G(VAIN(11))
 I '$D(VAIN(2)) D
 .N VAIN,VAINDT
 .S VAINDT=$P(^IBT(356,IBTRN,0),U,6)
 .S VA200="" D INP^VADPT
 .S X=VAIN(2)
 .I 'X S X=VAIN(11)
APROVQ Q $P($G(^VA(200,+X,0)),"^")
 ;
ATTEND ; -- return attendings (inpatient)
 Q
 ;
PROV ; -- return providers (inpatient)
 Q
 ;
OPROV ; -- returns outpatient providers
 Q
 ;
PROC(IBPR,IBTXT) ; -- Expand procedure from pointer
 ; input IBPR=proc^^date (format of ^IBT(356.91,IEN,0))
 ;       IBTXT = if want text added (zero = number only)
 N IBRES,IBZ
 I '$G(Z) S Z=1 ; what is that?
 I '$G(IBPR) Q ""
 S IBZ=$$ICD0^IBACSV(+IBPR,$P(IBPR,U,3))
 S IBRES=$P(IBZ,U)
 I $G(IBTXT),IBZ'="" S IBRES=IBRES_" - "_$P(IBZ,U,4)
 Q IBRES
 ;
 ;
OPROC ; -- outpatient procedures
 Q
 ;
IPROC ; -- inpatient procedures
 Q
 ;
LISTP(IBTRN,IBXY) ; -- return last y  procedures for a tracking entry
 ; -- input  ibtrn = tracking file pointer
 ; -- output array of procedure by date - ibxy(date)=procedure node
 ;
 N IBDGPM,IBDT,IBDA,IBX,IBCNT
 S (IBX,IBDT)="",IBXY=0
 I '$G(IBTRN) G LISTPQ
 S IBDGPM=$P($G(^IBT(356,IBTRN,0)),"^",5)
 Q:'IBDGPM
 F  S IBDT=$O(^IBT(356.91,"APP",IBDGPM,IBDT)) Q:'IBDT  S IBDA="" F  S IBDA=$O(^IBT(356.91,"APP",IBDGPM,IBDT,IBDA)) Q:'IBDA  D
 .S IBX(-IBDT,IBDA)=$G(^IBT(356.91,IBDA,0))
 ;
 S IBDT="" F  S IBDT=$O(IBX(IBDT)) Q:'IBDT  S IBDA=0 F  S IBDA=$O(IBX(IBDT,IBDA)) Q:'IBDA  D
 .S IBXY=IBXY+1
 .S IBXY(IBXY)=IBX(IBDT,IBDA)
LISTPQ Q
 ;
LSTPDG(X,IBDT,Y) ; -- return current diagnosis for a tracking entry
 ; -- input      X = tracking file pointer
 ;            ibdt = date for current diagnosis (null = last)
 ;               y = 1= primary (default)
 ;                   2= secondary
 ;
 N IBY,IBX S (IBY,IBX)=""
 I '$G(X) G LSTPDQ
 S:'$G(IBDT) IBDT=DT S IBDT=-(IBDT+.9)
 S:'$G(Y) Y=1 I Y'=1,Y'=2 S Y=1
 F  S IBDT=$O(^IBT(356.9,"APD",X,IBDT)) Q:'IBDT!($G(IBY))  S IBDA="" F  S IBDA=$O(^IBT(356.9,"APD",X,IBDT,IBDA)) Q:'IBDA!($G(IBY))  D
 .I $P(^IBT(356.9,IBDA,0),U,4)=Y S IBY=+^(0)
LSTPDQ Q IBY
 ;
DTCHK(DA,X) ; -- input transform for 356.94;.01.  date not before admission or after discharge
 N IBTRN,IBOK,IBCDT
 S IBOK=1
 G:'DA!($G(X)<1) DTCHKQ
 S IBTRN=+$O(^IBT(356,"AD",+$P(^IBT(356.94,DA,0),"^",2),0))
 G:'IBTRN DTCHKQ
 S IBCDT=$$CDT^IBTODD1(IBTRN)
 I X<$P(+IBCDT,".") S IBOK=0 G DTCHKQ ;before adm
 I $P(IBCDT,"^",2),X>$P(IBCDT,"^",2) S IBOK=0 G DTCHKQ ; after disch
 I X>$$FMADD^XLFDT(DT,7) S IBOK=0 G DTCHKQ
 ;
DTCHKQ Q IBOK
