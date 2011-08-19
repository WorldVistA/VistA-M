IBNCPDP2 ;OAK/ELZ - PROCESSING FOR ECME RESP ;11/15/07  09:43
 ;;2.0;INTEGRATED BILLING;**223,276,342,347,363,383,405,384,411**;21-MAR-94;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 D LOG("UNKNOWN")
 Q "0^Cannot determine ECME event status"
 ;
MATCH(BCID,IBS) ;  right bill, right COB payer
 N IBX,IBHAVE,IBPS
 S IBPS=$S(IBS=1:"P",IBS=2:"S",IBS=3:"T",1:"P")
 S IBX=0,IBHAVE=0
 F  S IBX=$O(^DGCR(399,"AG",BCID,IBX)) Q:'IBX  S IBHAVE=1 I '$P($G(^DGCR(399,IBX,"S")),U,16),(IBPS=$P($G(^DGCR(399,IBX,0)),U,21)) Q
 I 'IBX,IBHAVE Q ""
 Q +IBX
 ;
BILL(DFN,IBD) ; create bills
 N IBDIV,IBAMT,IBY,IBSERV,IBFAC,IBSITE,IBDRX,IB,IBCDFN,IBINS,IBIDS,IBIFN,IBDFN,PRCASV,IBTRIC,IBLGL,IBLDT2
 N PRCAERR,IBADT,IBRXN,IBFIL,IBTRKRN,DIE,DA,DR,IBRES,IBLOCK,IBLDT,IBNOW,IBDUZ,RCDUZ,IBPREV,IBQUERY,IBPAID,IBACT,%,DGRVRCAL
 ;
 S IBDUZ=.5 ;POSTMASTER
 ;I $G(IBD("FILLED BY")),$D(^VA(200,+IBD("FILLED BY"))) S IBDUZ=+IBD("FILLED BY")
 S RCDUZ=IBDUZ
 ;
 S IBY=1,IBLOCK=0
 I 'DFN S IBY="0^Missing DFN" G BILLQ
 S IBAMT=+$G(IBD("BILLED")) ;FI portion of charge
 I 'IBAMT S IBY="-1^Zero amount billed" G BILLQ
 S IBADT=+$G(IBD("FILL DATE"),DT)
 S IBRXN=+$G(IBD("PRESCRIPTION")) I 'IBRXN S IBY="0^Missing Rx IEN" G BILLQ
 S IBFIL=+$G(IBD("FILL NUMBER"),-1) I IBFIL<0 S IBY="0^No fill number" G BILLQ
 S IBDIV=+$G(IBD("DIVISION"))
 I '$L($G(IBD("CLAIMID"))) S IBY="-1^Missing ECME Number" G BILLQ
 S IBD("BCID")=$$BCID^IBNCPDP4(IBD("CLAIMID"),IBADT)
 L +^DGCR(399,"AG",IBD("BCID")):15 E  S IBY="0^Cannot lock ECME number." G BILLQ
 ;
 S IBTRIC=$$TRICARE^IBNCPDP6(IBRXN_";"_IBFIL)
 ; do patient copay first (only applicable if Tricare)
 I $G(IBD("COPAY")),IBTRIC D BILL^IBNCPDP6(IBRXN_";"_IBFIL,IBD("COPAY"),$G(IBD("RTYPE")))
 I IBTRIC,'$G(IBD("PAID")) S IBY="1^Nothing paid in Tricare claim." G BILLQ
 ;
 S IBLOCK=1,IBLDT2=""
 S IBLDT=$$FMADD^XLFDT(DT,1) F  S IBLGL=$O(^XTMP("IBNCPLDT"_IBLDT),-1),IBLDT=$E(IBLGL,9,15) Q:IBLDT<$$FMADD^XLFDT(DT,-3)!(IBLGL'["IBNCPLDT")  I $D(^XTMP(IBLGL,IBD("BCID"))) S IBLDT2=^(IBD("BCID")) Q  ;Last time called
 D NOW^%DTC S IBNOW=%
 ; 2 calls in 45 sec
 I IBLDT2,$$FMDIFF^XLFDT(IBNOW,IBLDT2,2)<45 S IBY="0^Duplicate billing call" G BILLQ
 ;
 I $$MATCH(IBD("BCID"),IBD("RXCOB")) D   ;cancel the previous bill
 . N IBARR M IBARR=IBD I $$REVERSE^IBNCPDP3(DFN,.IBARR,2)
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
 ; .03 EVT DATE (FILL DATE)
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
 ; set 362.4 node to rx#^p50^days sup^fill date^qty^ndc
 S IB(362.4,IBRXN,IBFIL)=IBD("RX NO")_"^"_IBD("DRUG")_"^"_IBD("DAYS SUPPLY")_"^"_IBD("FILL DATE")_"^"_IBD("QTY")_"^"_IBD("NDC")
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
 ; need to make sure we have computed charges.
 Q:'$$CHARGES(IBIFN,IBINS,+IB(.07),$G(IBD("PAID")),IBDIV,IBTRIC,.IBY)
 ;
 ; update the authorize/print fields
 S DIE="^DGCR(399,",DA=IBIFN
 S DR="9////1;12////"_DT D ^DIE
 ;
 ; pass the claim to AR
 D GVAR^IBCBB,ARRAY^IBCBB1 S PRCASV("APR")=IBDUZ D ^PRCASVC6
 I 'PRCASV("OKAY") S IBY="-1^Cannot establish receivable in AR." G BILLQ
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
 I IBAMT-IBPAID>.01,'IBTRIC D
 . D DEC^PRCASER1(PRCASV("ARREC"),IBAMT-IBPAID,IBDUZ,"Adjust based on ECME amount paid.",IBADT)
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
 S IBTRKRN=+$O(^IBT(356,"ARXFL",IBRXN,IBFIL,0))
 I IBTRKRN S DIE="^IBT(356,",DA=IBTRKRN,DR=".11////^S X=IBIFN;.17///@" D ^DIE
 I IBTRKRN,(+$G(IBD("FILL DATE"))'=$P(^IBT(356,IBTRKRN,0),U,6)) S DIE="^IBT(356,",DA=IBTRKRN,DR=".06////"_IBD("FILL DATE") D ^DIE ; Check Fill Date
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
CHARGES(IBIFN,IBINS,IBRT,IBAMT,IBDIV,IBTRIC,IBY) ;
 ; will add charges onto bill based on rate type
 ;
 ; Input:  IBIFN = Bill (399) ien
 ;         IBINS = Insurance Co (36) ien
 ;         IBRT = Rate Type (399.3) ien
 ; Output: 1 = Ok all done
 ;         0 = not ok, bill doesn't have charges
 ;
 N IBCSZ,IBRVCD,IBBS,IBUNITS,IBCPT,IBAA,IBTYPE,IBITEM,X
 ;
 I 'IBTRIC D BILL^IBCRBC(IBIFN) Q 1
 ;
 ; - manually add charge to the claim (based on cost for Tricare)
 S IBRVCD=$P($G(^DIC(36,IBINS,0)),"^",15) ;                   rx refill rev code
 S IBCSZ=$G(^IBE(363.1,+$O(^IBE(363.1,"B","RX COST",0)),0)) ; using cost CS
 I IBRVCD="" S IBRVCD=$P(IBCSZ,U,5) ;                         CS def rev code
 I IBRVCD="" S X=250 ;                                        gen'l rx rev code
 ;
 S IBBS=$P(IBCSZ,U,6) ;                                       CS def bedsection
 S IBUNITS=1 ;                                                one unit
 S IBCPT=$P($G(^IBE(350.9,1,1)),"^",30) ;                     def rx refill cpt
 S IBAA=0 ;                                                   not auto calc charges
 S IBTYPE=3 ;                                                 rx type
 S IBITEM="" ;                                                charge item link
 ;
 S X=$$ADDRC^IBCRBF(IBIFN,IBRVCD,IBBS,IBAMT,IBUNITS,IBCPT,IBDIV,IBAA,IBTYPE,IBITEM)
 I X<0 S IBY="-1^^Unable to add Revenue Code charge to claim." Q 0
 Q 1
 ;
