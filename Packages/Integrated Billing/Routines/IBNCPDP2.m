IBNCPDP2 ;OAK/ELZ - PROCESSING FOR ECME RESP ;11/15/07  09:43
 ;;2.0;INTEGRATED BILLING;**223,276,342,347,363,383,405,384,411,435,452**;21-MAR-94;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference to DEC^PRCASER1 supported by IA# 593
 ; Reference to REL^PRCASVC supported by IA# 385
 ; Reference to STATUS^PRCASVC1 supported by IA# 387
 ; Reference to ^PRCASVC6 supported by IA# 384
 ; Reference to $$RXSITE^PSOBPSUT supported by IA# 4701
 ; Reference to $$GETPHARM^BPSUTIL supported by IA# 4146
 ;
ECME(DFN,IBD) ; function called by STORESP^IBNCPDP
 ; input - DFN - patient IEN for the prescription
 ;         IBD array passed in by reference
 ;      The IBD array is passed to various subroutines depending
 ;      on the ePharmacy event as evaluated by IBD("STATUS")
 I $G(IBD("EPHARM"))="" S IBD("EPHARM")=$$EPHARM(+$G(IBD("PRESCRIPTION")),+$G(IBD("FILL NUMBER")))
 I IBD("STATUS")="PAID",$G(IBD("RXCOB"))=2 Q $$BILLSEC^IBNCPDP5(DFN,.IBD)
 I IBD("STATUS")="PAID" Q $$BILL(DFN,.IBD)
 I IBD("STATUS")="REVERSED" Q $$REVERSE^IBNCPDP3(DFN,.IBD)
 I IBD("STATUS")="CLOSED" Q $$CLOSE^IBNCPDP4(DFN,.IBD)
 I IBD("STATUS")="RELEASED" Q $$RELEASE^IBNCPDP4(DFN,.IBD)
 I IBD("STATUS")="SUBMITTED" Q $$SUBMIT^IBNCPDP4(DFN,.IBD)
 I IBD("STATUS")="REOPEN" Q $$REOPEN^IBNCPDP4(DFN,.IBD)
 I IBD("STATUS")="ELIG" Q $$ELIG^IBNCPDP3(DFN,.IBD)
 D LOG("UNKNOWN")
 Q "0^Cannot determine ECME event status"
 ;
MATCH(BCID,IBS) ;  right bill, right COB payer
 N IBX,IBPS,IBFOUND,ECMELEN,BCID1
 S IBPS=$S(IBS=1:"P",IBS=2:"S",IBS=3:"T",1:"P")
 S IBFOUND=0
 ;
 ; need to check for ECME# lengths of both 7 digits and 12 digits to be sure
 F ECMELEN=12,7 D  Q:IBFOUND
 . I $L(+BCID)>ECMELEN Q     ; quit if too large
 . S BCID1=BCID
 . S $P(BCID1,";",1)=$$RJ^XLFSTR(+BCID,ECMELEN,0)
 . S IBX=0     ; quit when we have found a non-cancelled claim with a payer sequence match
 . F  S IBX=$O(^DGCR(399,"AG",BCID1,IBX)) Q:'IBX!IBFOUND  I '$P($G(^DGCR(399,IBX,"S")),U,16),(IBPS=$P($G(^DGCR(399,IBX,0)),U,21)) S IBFOUND=IBX Q
 . Q
 ;
 Q IBFOUND
 ;
BILL(DFN,IBD) ; create bills
 N IBDIV,IBAMT,IBY,IBSERV,IBFAC,IBSITE,IBDRX,IB,IBCDFN,IBINS,IBIDS,IBIFN,IBDFN,PRCASV,IBTRIC,IBLGL,IBLDT2,IBDUP,CHKBL
 N PRCAERR,IBADT,IBRXN,IBFIL,IBTRKRN,DIE,DA,DR,IBRES,IBLOCK,IBLDT,IBNOW,IBDUZ,RCDUZ,IBPREV,IBQUERY,IBPAID,IBACT,%,DGRVRCAL
 ;
 S IBDUZ=.5 ;POSTMASTER
 S RCDUZ=IBDUZ
 ;
 S IBY=1,IBLOCK=0
 I 'DFN S IBY="0^Missing DFN" G BILLQ
 S IBAMT=+$G(IBD("BILLED")) ;FI portion of charge
 I 'IBAMT S IBY="-1^Zero amount billed" G BILLQ
 S IBADT=+$G(IBD("DOS"),DT)
 S IBRXN=+$G(IBD("PRESCRIPTION")) I 'IBRXN S IBY="0^Missing Rx IEN" G BILLQ
 S IBFIL=+$G(IBD("FILL NUMBER"),-1) I IBFIL<0 S IBY="0^No fill number" G BILLQ
 ;
 ; IB*2*452 - esg - check for duplicate response
 S IBDUP=$$DUP(.IBD) I IBDUP S IBY="0^Bill# "_$P(IBDUP,U,2)_" exists (Duplicate)" G BILLQ
 ;
 S IBDIV=+$G(IBD("DIVISION"))
 I '$L($G(IBD("CLAIMID"))) S IBY="-1^Missing ECME Number" G BILLQ
 S IBD("BCID")=$$BCID^IBNCPDP4(IBD("CLAIMID"),IBADT)
 L +^DGCR(399,"AG",IBD("BCID")):15 E  S IBY="0^Cannot lock ECME number." G BILLQ
 ;
 S IBTRIC=$$TRICARE^IBNCPDP6(IBRXN_";"_IBFIL)
 ; do patient copay first (only applicable if TRICARE)
 I $G(IBD("COPAY")),IBTRIC D BILL^IBNCPDP6(IBRXN_";"_IBFIL,IBD("COPAY"),$G(IBD("RTYPE")))  ; create TRICARE Rx copay charge
 ;
 S IBLOCK=1,IBLDT2=""
 S IBLDT=$$FMADD^XLFDT(DT,1) F  S IBLGL=$O(^XTMP("IBNCPLDT"_IBLDT),-1),IBLDT=$E(IBLGL,9,15) Q:IBLDT<$$FMADD^XLFDT(DT,-3)!(IBLGL'["IBNCPLDT")  I $D(^XTMP(IBLGL,IBD("BCID"))) S IBLDT2=^(IBD("BCID")) Q  ;Last time called
 D NOW^%DTC S IBNOW=%
 ; 2 calls in 45 sec
 I IBLDT2,$$FMDIFF^XLFDT(IBNOW,IBLDT2,2)<45 S IBY="0^Duplicate billing call" G BILLQ
 ;
 ; check to see if a non-cancelled bill (same ECME#, same DOS, same payer sequence) already exists
 ; if it does, then cancel this previous bill using the REVERSE action
 S CHKBL=$$MATCH(IBD("BCID"),IBD("RXCOB"))
 I CHKBL D
 . N IBARR
 . M IBARR=IBD
 . S IBARR("REVERSAL REASON")="Cancel the existing bill ("_$P($G(^DGCR(399,CHKBL,0)),U,1)_")"
 . I $$REVERSE^IBNCPDP3(DFN,.IBARR)
 . Q
 ;
 ; derive minimal variables
 I '$$CHECK^IBECEAU(0) S IBY="-1^IB SITE" G BILLQ
 S IBSERV=$P($G(^IBE(350.1,1,0)),"^",4)
 I '$$SERV^IBARX1(IBSERV) S IBY="-1^IB SERVICE" G BILLQ
 I 'IBDIV S IBDIV=$P($$MCDIV^IBNCPEB(IBRXN,IBFIL),U,2)
 I 'IBDIV S IBDIV=+$P($G(^SC(+$$FILE^IBRXUTL(IBRXN,5),0)),"^",15)
 I 'IBDIV S IBDIV=+$P($G(^IBE(350.9,1,1)),U,25) ;dflt
 I IBDIV S IBD("DIVISION")=IBDIV
 ; - establish a stub claim/receivable
 D SET^IBR I IBY<0 G BILLQ
 ;
 ; set up the following variables for claim establishment:
 ; .01 BILL #
 ; .17 ORIG CLAIM
 ; .2  AUTO?
 ; .02 DFN
 ; .06 TIMEFRAME
 ; .07 RATE TYPE
 ; .18 SC AT TIME?
 ; .04 LOCATION
 ; .22 DIVISION
 ; .05 BILL CLASSIF  (3)
 ; .03 EVT DATE (DATE OF SERVICE)
 ; 151 BILL FROM
 ; 152 BILL TO
 ; 155 SENSITIVE DX
 ; 157 ROI OBTAINED
 ; 101 PRIMARY INS CARRIER
 K IB
 S (IB(.02),IBDFN)=DFN
 S IB(.07)=$$RT^IBNCPDP6(IBRXN_";"_IBFIL) ; previously determined rate type
 I 'IB(.07) S IB(.07)=+$$RT^IBNCPDPU(DFN) ; cannot find previously, try to recompute
 I 'IB(.07) S IBY="-1^IB RATE TYPE" G BILLQ
 ;
 S IBIFN=PRCASV("ARREC")
 S IB(.01)=$P(PRCASV("ARBIL"),"-",2)
 S IB(.17)=""
 S IB(.2)=0
 S IB(.06)=1
 S IB(.18)=$$SC^IBCU3(DFN)
 S IB(.04)=$S(+$P($G(^DG(40.8,+IBDIV,0)),U,3):7,1:1)
 S:IBDIV IB(.22)=+IBDIV
 S IB(.05)=3
 S (IB(.03),IB(151),IB(152))=IBADT
 S IBINS=$P($G(^IBA(355.3,+$G(IBD("PLAN")),0)),"^") I IBINS S IB(101)=IBINS
 ;
 ; set 362.4 node to rx#^p50^days sup^date of service^qty^ndc
 S IB(362.4,IBRXN,IBFIL)=IBD("RX NO")_"^"_IBD("DRUG")_"^"_IBD("DAYS SUPPLY")_"^"_IBD("DOS")_"^"_IBD("QTY")_"^"_IBD("NDC")
 ;
 ; drug DEA ROI check.
 N IBDEA
 D ZERO^IBRXUTL(IBD("DRUG")) S IBDEA=^TMP($J,"IBDRUG",IBD("DRUG"),3)
 I IBDEA["U" S IB(155)=1,IB(157)=1 ; set sensitive dx and ROI obtained
 K ^TMP($J,"IBDRUG")
 ;
 ; call the autobiller module to create the claim with a default
 ; diagnosis and procedure for prescriptions
 D EN^IBCD3(.IBQUERY)
 D CLOSE^IBSDU(.IBQUERY)
 ;
 S:'$D(^XTMP("IBNCPLDT"_DT)) ^XTMP("IBNCPLDT"_DT,0)=$$FMADD^XLFDT(DT,2)_U_DT S ^XTMP("IBNCPLDT"_DT,IBD("BCID"))=IBNOW
 S DIE="^DGCR(399,",DA=IBIFN
 ; update the ECME fields
 S DR="460////^S X=IBD(""BCID"")" S:$L($G(IBD("AUTH #"))) DR=DR_";461////^S X=IBD(""AUTH #"")"
 D ^DIE K DA,DR,DIE
 D SETCT ; Set Claims Tracking record
 ;
 ; IEN to 2.3121
 S IBCDFN=$$PLANN^IBNCPDPU(DFN,IBD("PLAN"),IBADT)
 I 'IBCDFN S IBY="-1^Plan not found in Patient's Profile." G BILLQ
 ;
 ; add the payer (fiscal intermediary) to the claim
 S IBINS=+IBCDFN,IBCDFN=$P(IBCDFN,"^",2)
 S DIE="^DGCR(399,",DA=IBIFN,DR="112////"_IBCDFN
 D ^DIE K DA,DR,DIE,DGRVRCAL
 ;
 ; need to make sure we have computed charges
 D CHARGES(IBIFN)
 I $P($G(^DGCR(399,IBIFN,"U1")),U,1)'>0 S IBY="-1^Total Charges must be greater than $0." G BILLQ
 ;
 ; update the authorize/print fields
 S DIE="^DGCR(399,",DA=IBIFN
 S DR="9////1;12////"_DT D ^DIE
 ;
 ; pass the claim to AR
 D GVAR^IBCBB,ARRAY^IBCBB1 S PRCASV("APR")=IBDUZ D ^PRCASVC6
 I 'PRCASV("OKAY") S IBY="-1^"_$$ARERR($G(PRCAERR),1) G BILLQ
 D REL^PRCASVC
 ;
 ; update the AR status to Active
 ;  D AUDITX^PRCAUDT(PRCASV("ARREC"))
 S PRCASV("STATUS")=16
 D STATUS^PRCASVC1
 ;
 ; decrease adjust bill
 ; Auto decrease from service Bill#,Tran amt,person,reason,Tran date
 S IBAMT=$G(^DGCR(399,IBIFN,"U1"))
 S IBPAID=$G(IBD("PAID"))
 I IBAMT-IBPAID>.01 D
 . N IBREAS
 . S IBREAS="Adjust based on ECME amount paid."
 . I IBTRIC S IBREAS="Due to TRICARE Patient Responsibility."
 . D DEC^PRCASER1(PRCASV("ARREC"),IBAMT-IBPAID,IBDUZ,IBREAS,IBADT)
 . I 'IBPAID S PRCASV("STATUS")=22 D STATUS^PRCASVC1 ; collected/closed
 ;
 D  ; set the user in 399
 . N IBI,IBT F IBI=2,5,11,13,15 S IBT(399,IBIFN_",",IBI)=IBDUZ
 . D FILE^DIE("","IBT")
 ;
BILLQ S IBRES=$S(IBY<0:"0^"_$S($L($P(IBY,"^",2)):$P(IBY,"^",2),1:$P(IBY,"^",3)),$G(IBIFN):+IBIFN,1:IBY)
 I $G(IBIFN) S IBD("BILL")=IBIFN
 D LOG("BILL",IBRES)
 I IBY<0 D BULL^IBNCPEB($G(DFN),.IBD,IBRES,$G(IBIFN))
 I IBLOCK L -^DGCR(399,"AG",IBD("BCID"))
 Q IBRES
 ;
SETCT ; update claims tracking saying bill has been billed
 N X,Y,D0,DA,DI,DICR,DIE,DIG,DIH,DIU,DIV,DIW,DQ,DR
 S IBTRKRN=+$O(^IBT(356,"ARXFL",IBRXN,IBFIL,0))
 I IBTRKRN S DIE="^IBT(356,",DA=IBTRKRN,DR=".11////^S X=IBIFN;.17///@" D ^DIE
 I IBTRKRN,(+$G(IBD("DOS"))'=$P(^IBT(356,IBTRKRN,0),U,6)) S DIE="^IBT(356,",DA=IBTRKRN,DR=".06////"_IBD("DOS") D ^DIE ; Check Date of Service
 I IBTRKRN,IBIFN D CTB^IBCDC(IBTRKRN,IBIFN)
 Q
 ;
LOG(PROC,RESULT) ;Store the data
 ;Log values passed into IB by outside applications
 ;
 ;implicit input variables/arrays :
 ; IBD array with values sent to IB (see calling subroutines)
 ; DFN - patient's IEN (file #2)
 ; DUZ - user's IEN(file #200)
 ;explicit parameters:
 ; PROC - type of event as string, i.e. BILL, REJECT and so on
 ; RESULT - result of the event processing, format: return_code^message
 ;
 D LOG^IBNCPLOG(.IBD,DFN,PROC,RESULT,$J,$$NOW^XLFDT(),+DUZ)
 Q
 ;
EPHARM(IBRX,IBREFILL) ;
 ;returns ien of #9002313.56 BPS PHARMACIES associated
 ;with the prescription specified by:
 ; IBRX - IEN in file #52
 ; IBREFILL - zero(0) for the original prescription or the refill
 ;    number for a refill (IEN of REFILL multiple #52.1)
 I +$G(IBRX)=0 Q ""
 I $G(IBREFILL)="" Q ""
 N IBDIV59
 S IBDIV59=+$$RXSITE^PSOBPSUT(+IBRX,+IBREFILL)
 I IBDIV59>0 Q $$GETPHARM^BPSUTIL(IBDIV59)
 Q ""
 ;
CHARGES(IBIFN) ; set up charges on the bill
 ;
 ; Input:  IBIFN = Bill (399) ien
 N DGPTUPDT
 D BILL^IBCRBC(IBIFN)     ; generic bill charge calculator
 Q
 ;
DUP(IBD) ; Function to determine if processing a duplicate response
 ; and if a bill should be created
 ; Input
 ;    IBD array values
 ; Output
 ;    Function value:  [1] "1" if a duplicate response received and a non-cancelled bill already exists
 ;                     [2] non-cancelled external bill# if piece [1] =1
 ;          or
 ;                     [1] "0" if not a duplicate response OR no bill exists
 ;                     [2] ""
 ;
 N RET,RXIEN,RXFIL,COB,IBZ,IBARR,IBIFN,ARSTAT
 S RET=0
 I $G(IBD("RESPONSE"))'="DUPLICATE" G DUPX
 ;
 ; set up variables from array data and try to find bills
 S RXIEN=+$G(IBD("PRESCRIPTION"))
 S RXFIL=+$G(IBD("FILL NUMBER"))
 S COB=+$G(IBD("RXCOB")),COB=$S(COB=2:"S",COB=3:"T",1:"P")
 S IBZ=$$RXBILL^IBNCPUT3(RXIEN,RXFIL,COB,,.IBARR)
 ;
 ; if the function returned an active bill, then use it and get out
 I +$P(IBZ,U,2) S IBIFN=+$P(IBZ,U,2),RET=1_U_$P($G(^DGCR(399,IBIFN,0)),U,1) G DUPX
 ;
 ; if no bills found at all then get out
 I '$P(IBZ,U,1) G DUPX
 I '$D(IBARR) G DUPX
 ;
 ; loop thru the array looking for any non-cancelled bills
 S IBIFN="" F  S IBIFN=$O(IBARR(IBIFN),-1) Q:'IBIFN  D  Q:+RET
 . S ARSTAT=$P($G(IBARR(IBIFN)),U,2)
 . I ARSTAT'="CB",ARSTAT'="CN" S RET=1_U_$P($G(^DGCR(399,IBIFN,0)),U,1) Q
 . Q
DUPX ;
 Q RET
 ;
ARERR(CODE,COB) ; retrieve AR error text
 ; This function is called after calling AR routine PRCASVC6 and that routine indicates
 ; some AR error has been detected.  Variable PRCAERR is passed into this function as
 ; the CODE parameter.  The COB parameter indicates the COB payer sequence.
 ;
 ; Format of CODE:  -1^PRCA error code in file 350.8
 ;             or   -1^AR text error message
 ;             or   undefined
 ;
 N ERR,IBZ
 S ERR=""
 S CODE=$P($G(CODE),U,2)
 S COB=$G(COB,1)
 I CODE="" S ERR="Cannot establish receivable in AR" G ARERRX    ; generic error message
 ;
 S IBZ=+$O(^IBE(350.8,"C",CODE,0))
 I IBZ S ERR=$P($G(^IBE(350.8,IBZ,0)),U,2) G ARERRX   ; error message from IB file
 ;
 S ERR=CODE    ; error message text from routine PRCASVC6
 ;
ARERRX ;
 S ERR=$$TRIM^XLFSTR(ERR,"R",".")    ; remove ending period
 I COB>1 S ERR=ERR_" ("_$S(COB=2:"Sec",1:"Tert")_" Ins)"
 S ERR="AR Error: "_ERR
 Q ERR
 ;
