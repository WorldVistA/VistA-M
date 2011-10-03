IBAECU5 ;WOIFO/SS-LTC PHASE 2 UTILITIES ; 20-FEB-02
 ;;2.0;INTEGRATED BILLING;**171,176**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;check if there is LTC in ^TMP of INPINFO^IBAECU2
ISLTC(IBDFN,IBLBL) ;
 N IBFL5,IBVA,IBVT,IBVD
 S (IBFL5,IBVA)=0
 F  S IBVA=$O(^TMP($J,IBLBL,IBDFN,IBVA)) Q:IBVA=""!(IBFL5>0)  D
 . S IBVT=0
 . F  S IBVT=$O(^TMP($J,IBLBL,IBDFN,IBVA,IBVT)) Q:IBVT=""!(IBFL5>0)  D
 . . S IBVD=0
 . . F  S IBVD=$O(^TMP($J,IBLBL,IBDFN,IBVA,IBVT,IBVD)) Q:IBVD=""!(IBFL5>0)  D
 . . . S:$P($G(^TMP($J,IBLBL,IBDFN,IBVA,IBVT,IBVD)),"^",1)="L" IBFL5=IBVD
 Q IBFL5
 ;
 ;is C&P exam this date
 ;IBDFN1 - patient's ien #2
 ;IBDT1 -date
 ;returns
 ; 1 - YES, 0 -NO
ISCOMPEN(IBDFN1,IBDT1) ;
 Q $$CNP^IBECEAU(IBDFN1,IBDT1)
 ;
 ;checks if charge for outpatient visit and then cancels it
 ;IBDFN - Pointer to patient in file #2
 ;IBDATE  -  Date to check for OPT charges
CANCVIS(IBDFN,IBDATE) ;
 N IBN,IBCRES,IBDUZ
 S IBDUZ=+$G(DUZ)
 S IBN=$$BFO^IBECEAU(IBDFN,IBDATE)
 Q:'IBN
 S IBCRES=$O(^IBE(350.3,"B","BILLED LTC CHARGE",0))
 S:'IBCRES IBCRES=4 S IBWHER=""
 D CANCH^IBECEAU4(IBN,IBCRES,0)
 Q
 ;
 ;prepares error messages
 ;IBDFN - patient's ien
 ;IBIEN - ien of applicable file
 ;IBACT - action 
 ;IBMESS - error message
ERRLOG(IBDFN,IBIEN,IBACT,IBMESS) ;
 Q:+IBDFN=0!(+IBIEN=0)!(IBACT="")
 N VADM,VA,VAERR,DFN,IBCNT
 S DFN=IBDFN
 D DEM^VADPT
 S ^TMP($J,"IBMJERR")=$G(^TMP($J,"IBMJERR"))+1
 S IBCNT=$G(^TMP($J,"IBMJERR"))
 S ^TMP($J,"IBMJERR",IBCNT,1)=" "
 S ^TMP($J,"IBMJERR",IBCNT,2)="*********************************"
 S ^TMP($J,"IBMJERR",IBCNT,3)=" "_$G(IBMESS)
 S ^TMP($J,"IBMJERR",IBCNT,4)=" Action         : "_$G(IBACT)
 S ^TMP($J,"IBMJERR",IBCNT,5)=" Applicable IEN : "_$G(IBIEN)
 S ^TMP($J,"IBMJERR",IBCNT,6)=" Patient        : "_$G(VADM(1))
 S ^TMP($J,"IBMJERR",IBCNT,7)=" SSN            : "_$P($G(VADM(2)),"^",2)
 Q
 ;
 ;sends all errors in TMP($J,"IBMJERR" to IB ERROR mail group
SENDERR ;
 N XMSUB,XMTEXT,XMY,XMZ,XMMG,IBL,IBT,XMDUZ,IBV1,IBV2,IBV3
 N IBMAXLN S IBMAXLN=200
 N XMGROUP S XMGROUP=$$GET1^DIQ(350.9,"1,",.09)
 Q:XMGROUP=""
 S XMGROUP="G."_XMGROUP
 S XMSUB="LTC Monthly Job error report",XMY(XMGROUP)=""
 S XMTEXT="IBT(",XMDUZ="INTEGRATED BILLING PACKAGE"
 S IBV1=0,IBV3=1
 F  S IBV1=$O(^TMP($J,"IBMJERR",IBV1)) Q:+IBV1=0!(IBV3>IBMAXLN)  D
 . S IBV2=0
 . F  S IBV2=$O(^TMP($J,"IBMJERR",IBV1,IBV2)) Q:+IBV2=0  D
 . . S IBT(IBV3,0)=$G(^TMP($J,"IBMJERR",IBV1,IBV2)),IBV3=IBV3+1
 S:IBV3>IBMAXLN IBT(IBV3,0)="******* Too many errors! *******"
 D ^XMD
 Q
 ;
 ;sends message to user group if there is no 1010EC form forthe patient
MESS10EC(DFN,IBDT) ;
 D XMNOEC^IBAECU(DFN,IBDT)
 Q
 ;
 ;Creates charge, sends amount to AR
 ;IBPATDFN - patient DFN
 ;.IBAMOUNT - array with all amounts for each day
 ;array IBMNTH - month info
 ;.IBMNTH - number of days
 ;IBMNTH(0)- first day (in FM format)
 ;IBMNTH(1)- last day (in FM format)
 ;IBMNTH(2)- year_month (like 30201)
 ;IBMONCAP - maximum monthly copay (180 days stuff)
SEND2AR(IBPATDFN,IBAMOUNT,IBMNTH,IBMONCAP) ;
 ;arrays
 N IBPAYS,IBRCHRGS
 ;vars
 N IBADM,IB350P,IBDD,IBRES,IBTOT,IBV1,IBNOS,IBAMNT
 N IBDAY,IB350,IBRATE,IBTP,IBDT,IBSL,IBPRDAY,IBV1
 N IBINPDS,IBFDAY,IBLDAY,IBEPSSUM,IBFRD,IBTOD
 S IBDAY=0,IBPAYS=0,IBRCHRGS=0
 ;1.outpatient visit charges
 F  S IBDAY=$O(IBAMOUNT("A",IBDAY)) Q:+IBDAY=0  I +$G(IBAMOUNT("A",IBDAY,"T"))=1 D
 . S IBRATE=+$G(IBAMOUNT("A",IBDAY,"R"))
 . S IBTP=$P($G(IBAMOUNT("A",IBDAY,"R")),"^",2)
 . S IBDT=$$MKDATE^IBAECU4(IBMNTH(2),IBDAY)
 . S IBSL="409.68:"_$P($G(IBAMOUNT("A",IBDAY,"T")),"^",2)
 . S IBPAYS=$G(IBPAYS)+1,IBPAYS(IBDAY)=IBPATDFN_"^"_IBTP_"^1^"_IBRATE_"^"_IBDT_"^"_IBDT_"^"_IBSL_"^^*^"_IBDT
 ;2.inpatient stay charges
 S IBFDAY=0 ;first day of episode
 S IBLDAY=0 ;last day of episode
 S IBINPDS=0 ;length of each episode (Exmpl. Jan3-Jan5=2days, Jan21-Jan31=10 days)
 S IBEPSSUM=0 ;total for episode
 S IBDAY=0
 F  S IBDAY=$O(IBAMOUNT("A",IBDAY)) Q:+IBDAY=0  I +$G(IBAMOUNT("A",IBDAY,"T"))=2 D
 . S:IBFDAY=0 IBFDAY=IBDAY ;set first day
 . S IBINPDS=IBINPDS+1 ;count days
 . S IBRATE=+$G(IBAMOUNT("A",IBDAY,"R"))
 . S IBEPSSUM=IBEPSSUM+IBRATE ;total
 . S IBV1=+$O(IBAMOUNT("A",IBDAY)) ;check the next day
 . ;if next "is the end" OR "if AA/ASIH gap" OR "if another admission"
 . I (IBV1=0)!((IBV1-IBDAY)>1)!($P($G(IBAMOUNT("A",IBDAY,"T")),"^",2)'=$P($G(IBAMOUNT("A",IBV1,"T")),"^",2)) D
 . . S IBLDAY=IBDAY ; set last day
 . . S IBTP=$P($G(IBAMOUNT("A",IBDAY,"R")),"^",2) ;action type
 . . S IBFRD=$$MKDATE^IBAECU4(IBMNTH(2),IBFDAY) ;from 
 . . S IBTOD=$$MKDATE^IBAECU4(IBMNTH(2),IBLDAY) ;to
 . . S IBADM=$P($G(IBAMOUNT("A",IBDAY,"T")),"^",2) ;admission
 . . S IBDT=+$P($G(IBAMOUNT("A",IBDAY,"T")),"^",3) ;default is admission date
 . . I IBDT<IBMNTH(0) S IBDT=IBMNTH(0) ;if admission date < begining of month
 . . S IB350P=+$$FIND350^IBAECN1(IBPATDFN,IBFRD+0.9,IBADM,1) ;find INCOMLETE parent event
 . . I IB350P=0 D
 . . . N VAIP,IB350PCL,DFN
 . . . S DFN=IBPATDFN,VAIP("D")=IBFRD_.2359 D IN5^VADPT
 . . . I '$$ASIH^IBAUTL5($G(^DGPM(+VAIP(1),0))) D  Q
 . . . . ;find "completed" - ASIH could complete event entry
 . . . . S IB350PCL=+$$FIND350^IBAECN1(IBPATDFN,IBFRD+0.9,+IBADM,2)
 . . . . I IB350PCL>0 S IB350P=IB350PCL
 . . . S IB350P=+$$FIND350^IBAECN1(IBPATDFN,IBFRD+0.9,+VAIP(1),1)
 . . . S IBADM=+VAIP(1),IBDT=+$G(^DGPM(VAIP(1),0))\1
 . . ;if not found - create new one with LTC type
 . . I IB350P=0 S IB350P=$$CREV350^IBAECN1(IBPATDFN,+IBADM,IBDT,93)
 . . S IBSL="405:"_IBADM ;soft link
 . . S IBPAYS=$G(IBPAYS)+1
 . . I $D(IBPAYS(IBDAY)) D ERRLOG(+$G(IBPATDFN),+$G(IB350P),"SEND2AR: charges","Attempt to create more than one charge a day ")
 . . S IBPAYS(IBDAY)=IBPATDFN_"^"_IBTP_"^"_IBINPDS_"^"_IBEPSSUM_"^"_IBFRD_"^"_IBTOD_"^"_IBSL_"^^"_IB350P_"^"_IBDT
 . . S (IBFDAY,IBLDAY,IBINPDS,IBEPSSUM)=0
 ;3. make charges until it less than monthly cap
 ;
 S (IBTOT,IBFL,IBDD)=0
 F  S IBDD=$O(IBPAYS(IBDD)) Q:+IBDD=0!(IBFL=1)  D
 . S IBRES=$G(IBPAYS(IBDD))
 . S IBAMNT=0
 . I IBTOT'<IBMONCAP S IBFL=1 Q  ;don't charge anymore
 . I (IBTOT+$P(IBRES,"^",4))'>IBMONCAP D  ;charge whole amount
 . . S IBAMNT=$P(IBRES,"^",4)
 . E  S IBAMNT=IBMONCAP-IBTOT ;charge a rest
 . S IBTOT=IBTOT+IBAMNT
 . S IB350=$$CHARGE(IBPATDFN,$P(IBRES,"^",2),$P(IBRES,"^",3),IBAMNT,$P(IBRES,"^",5),$P(IBRES,"^",6),$P(IBRES,"^",7),$P(IBRES,"^",8),$P(IBRES,"^",9),$P(IBRES,"^",10))
 . I IB350>0 S IBRCHRGS=IBRCHRGS+1,IBRCHRGS(IBRCHRGS)=IB350
 . ;Edit parent event in #350 V 11F
 . I +$P(IBRES,"^",9)>0 D STAT350^IBAECN1(+$P(IBRES,"^",9),IBMNTH(1),+$P($P(IBRES,"^",7),":",2))
 ;4. Send to AR
 S IBV1=0,IBNOS=""
 F  S IBV1=$O(IBRCHRGS(IBV1)) Q:+IBV1=0  D
 . S:IBNOS'="" IBNOS=IBNOS_"^"_IBRCHRGS(IBV1)
 . S:IBNOS="" IBNOS=IBRCHRGS(IBV1)
 . I (IBV1#5)=0 S IBRES=$$TOAR(IBPATDFN,1,IBNOS,+$G(DUZ)),IBNOS=""
 I IBNOS'="" S IBRES=$$TOAR(IBPATDFN,1,IBNOS,+$G(DUZ)),IBNOS=""
 Q
 ;call ^IBR
TOAR(DFN,IBSEQNO,IBNOS,IBDUZ) ;
 ;
 N Y,IBERR,IBIL
 D ^IBR
 Q Y
 ;
 ;create outppatient charge
 ;  Input:
 ;  DFN  --  Pointer to patient in file #2
 ;  IBATYP  --  Pointer to Action Type in file #350.1
 ;  IBUNIT  --  Number of units of charge (1 day for outpatient, 1 or more for inpatients)
 ;  IBCHG  --  $$ amount of charge
 ;  IBFR  --  Bill From date
 ;   inpatient: first day of episode
 ;   outpatient: date of service
 ;  IBTO  --  Bill To date
 ;   inpatient: last day of episode
 ;   outpatient: date of service
 ;  IBSL  --  Softlink  405:IEN or 409.68:IEN
 ;  IBPAR  --  placeholder for IBPARNT (see below) 
 ;  IBEVDA  --  Pointer to parent event in #350 for inpatients, 
 ;   or "*" for outpatients to set ibevda=ibn
 ;  IBEVDT  --  for outpatient: Event Date  
 ;  for inpatient:admission date or begining of month if admission began 
 ;  before the begining of the month
CHARGE(DFN,IBATYP,IBUNIT,IBCHG,IBFR,IBTO,IBSL,IBPAR,IBEVDA,IBEVDT) ;
 ;
 N IBN,IBDESC,IBSITE,IBFAC,IBXA
 D SITE^IBAUTL
 S IBDESC=$P($G(^IBE(350.1,+$G(IBATYP),0)),"^",8)
 I IBDESC="" S IBDESC=$$ACTNM(+$G(IBATYP)) D ERRLOG(+$G(DFN),+$G(IBATYP),"CHARGE","No USER LOOKUP NAME in #350.1")
 S IBN=0
 ;IBPARNT  --  Pointer to parent entry in #350  [OPTIONAL], i.e. to previous record(s)
 ;   for the same charge, that were edited or cancelled
 ;   Here IBPARNT must be undefined, because we always create  "NEW" charges
 N IBPARNT ;undefined
 D ADD^IBECEAU3
 Q IBN
 ;
ACTNM(X) ;X -input pointer to action type file (350.1)
 S Y=$P($G(^IBE(350.1,+X,0)),"^",9) ;new action type
 Q $S($P($G(^IBE(350.1,+Y,0)),"^",8)]"":$P(^(0),"^",8),$P($G(^IBE(350.1,+X,0)),"^",8)]"":$P(^(0),"^",8),1:$P($G(^IBE(350.1,+X,0)),"^"))
 ;
