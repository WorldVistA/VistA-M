IBCE837A ;ALB/TMP - OUTPUT FOR 837 TRANSMISSION - CONTINUED ;8/6/03 10:50am
 ;;2.0;INTEGRATED BILLING;**137,191,211,232,296,377,592,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
UPD(MSGNUM,BATCH,CNT,BILLS,DESC,IBBTYP,IBINS) ; Upd current batch + bills w/new status
 ;MSGNUM = mail msg # for batch
 ;BATCH = batch #
 ;CNT = # of bills in batch
 ;BILLS = array BILLS(bill ien in 364) in batch
 ;DESC = 1-80 character description of batch
 ;IBBTYP = X-Y where X = P for professional, I for institution, or D for Dental  ;JWS;IB*2.0*592;US131
 ;                   Y = 1 for test or 0 for live transmission
 ;                         or 2 for live claim resubmitted as test
 ;IBINS = ien of single insurance company for the batch (optional)
 ;
 N DIC,DIE,DR,DA,IBBATCH,IBIFN,IBIEN,IBYY,IBTXTEST,IBMRA
 S IBBATCH=$O(^IBA(364.1,"B",+BATCH,"")) Q:'IBBATCH
 S IBTXTEST=+$P(IBBTYP,"-",2)
 I '$P($G(^IBE(350.9,1,8)),U,7) S IBINS=""
 ;
 S DIE="^IBA(364.1,",DA=IBBATCH,DR=".02////P;.03///"_CNT_";.04///"_MSGNUM_";.05///0;.07////1;.08///^S X="""_DESC_""""_$S($G(IBINS):";.12////"_IBINS,1:"")
 ;
 I '$P($G(^TMP("IBRESUBMIT",$J)),U,3) S DR=DR_";1.01///NOW;1.02///.5"
 I $P($G(^TMP("IBRESUBMIT",$J)),U,2) S DR=DR_";.15////"_$P(^($J),U,2)
 ;JWS;IB*2.0*592;US131
 S DR=DR_";.14////"_$S('IBTXTEST:0,1:1)_";.06////"_$S($E(IBBTYP)="P":2,$E(IBBTYP)="D":7,1:3) D ^DIE ; Update batch
 ;
 I IBTXTEST=2 D ADDTXM^IBCEPTM(.BILLS,IBBATCH,$$NOW^XLFDT()) Q
 I IBTXTEST'=2 S IBIEN=0 F  S IBIEN=$O(BILLS(IBIEN)) Q:'IBIEN  D  ;Update each bill
 . ;JWS;IB*2.0*623;update field .09 837 FHIR ReQUEST if using 837 FHIR trans method
 . S DA=IBIEN,DIE="^IBA(364,",DR=".02////"_IBBATCH_";.03///P;.04///NOW"
 . I $D(^IBA(364,"AC",1,DA)) S DR=DR_";.09////2"
 . D ^DIE
 . S IBIFN=+$G(^IBA(364,IBIEN,0))
 . ; If this claim has just been retransmitted, set the .06 field for the previous transmission entry
 . N PRVTXI,PRVTXD
 . S PRVTXI=$O(^IBA(364,"B",IBIFN,IBIEN),-1)      ; previous transmission for this claim
 . I PRVTXI D
 .. S PRVTXD=$G(^IBA(364,PRVTXI,0))
 .. I '$F(".R.E.","."_$P(PRVTXD,U,3)_".") Q                 ; prev trans must have status of "R" or "E"
 .. I $P(PRVTXD,U,7,8)'=$P($G(^IBA(364,IBIEN,0)),U,7,8) Q   ; test bill and COB must be the same
 .. S DA=PRVTXI,DIE=364,DR=".06///"_IBBATCH D ^DIE          ; update the resubmit batch number
 .. Q
 . ;
 .Q:$D(^TMP("IBRESUBMIT",$J))!($P($G(^DGCR(399,IBIFN,0)),U,13)=4)!(+$$TXMT^IBCEF4(IBIEN)=2)
 .S IBMRA=$$NEEDMRA^IBEFUNC(IBIFN)
 .I IBMRA="C",$P($G(^DGCR(399,IBIFN,0)),U,13)=2 S IBMRA=1
 .I IBIFN D
 ..S (DIC,DIE)="^DGCR(399,",DA=$P($G(^IBA(364,IBIEN,0)),U),DR="[IB STATUS]",IBYY=$S('IBMRA:"@91",1:"@911") D:DA ^DIE
 ..D BSTAT^IBCDC(IBIFN) ; remove from AB list
 Q
 ;
PRE ; Run before processing a bill entry
 K IBXSAVE,IBXERR,^UTILITY("VAPA",$J),^TMP("IBXSAVE",$J),^TMP($J),^TMP("DIERR",$J)
 Q
 ;
POST ; Run after processing a bill entry for cleanup
 N Q
 I $G(IBXERR)'="" D
 .S ^TMP("IBXERR",$J,IBXIEN)=IBXERR K ^TMP("IBXDATA",$J)
 .K ^TMP("IBHDR1",$J)
 .I $D(^TMP("IBRESUBMIT",$J)),'$G(^TMP("IBEDI_TEST_BATCH",$J)) D  ;Set not resub flag for non-test bill
 ..N Z,Z0
 ..S Z0=$P($G(^TMP("IBRESUBMIT",$J)),U) Q:Z0=""
 ..S Z=$O(^IBA(364,"ABABI",+$O(^IBA(364.1,"B",Z0,"")),IBXIEN,""))
 ..I Z S ^TMP("IBNOT",$J,Z)=IBXIEN
 K IBXSAVE,IBXNOREQ,^TMP("IBXSAVE",$J),^TMP($J)
 S Q="VA" F  S Q=$O(^UTILITY(Q)) Q:$E(Q,1,2)'="VA"  I $D(^(Q,$J)) K ^UTILITY(Q,$J)
 D CLEAN^DILF
 Q
 ;
MAILIT(IBQUEUE,IBBILL,IBCTM,IBDUZ,IBDESC,IBBTYP,IBINS) ; Send mail msg, update bills
 ;IBQUEUE = mail queue name to send 837 transactions to
 ;IBBILL = array of ien's in file 364 of bills in batch - IBBILL(IEN)=""
 ;IBCTM = # of bills in batch, returned reset to 0
 ;IBDUZ = ien of user 'running' extract (if any)
 ;IBDESC = description of batch
 ;IBBTYP = X-Y where X = P for professional, I for institution, or D for Dental ;JWS;IB*2.0*592;US131
 ;                   Y = 1 or 2 for test or 0 for live transmission
 ;IBINS = ien of insurance company if only one/batch option (optional)
 ;
 N DIK,DA,XMTO,XMZ,XMBODY,XMDUZ,XMSUBJ,IBBDA,IBBNO
 ;
 S IBBNO=+$P($G(^TMP("IBHDR",$J)),U),IBBDA=$O(^IBA(364.1,"B",IBBNO,""))
 I '$P($G(^IBE(350.9,1,8)),U,7) S IBINS=""
 ;
 I IBCTM D
 . ;JWS;IB*2.0*623
 . I $$GET1^DIQ(350.9,"1,",8.21,"I") Q  ;G MAILQ
 . I +$G(^TMP("IBEDI_TEST_BATCH",$J)) S IBQUEUE="MCT"
 . I IBQUEUE'="",IBQUEUE'["@" S XMTO("XXX@Q-"_IBQUEUE_".DOMAIN.EXT")=""
 . ;
 . ; ******Note to self - remove when going to sites although it shouldn't hurt if you forget - WCJ **********
 . I '$$PROD^XUPROD(1) S XMTO("G.CLAIMS4US")=""
 . ;
 . I IBQUEUE["@" S XMTO(IBQUEUE)=""
 . S XMDUZ=$G(IBDUZ),XMBODY="^TMP(""IBXMSG"","_$J_")",XMSUBJ=$S($P(IBBTYP,U,2):"** TEST"_$S($P(IBBTYP,U,2)=2:"/RESUB OF LIVE",1:""),1:"")_" CLAIM BATCH: "_$S(IBQUEUE'["@":IBQUEUE,1:$P(IBQUEUE,"@"))_"/"_IBBNO
 . K XMZ
 . D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 . I $G(XMZ) D
 .. D UPD(XMZ,$P($G(^TMP("IBHDR",$J)),U),IBCTM,.IBBILL,IBDESC,IBBTYP,IBINS) ;Update batch/bills
 .. S ^TMP("IBCE-BATCH",$J,IBBNO)=IBBDA_U_IBCTM_U_$P($G(^TMP("IBRESUBMIT",$J)),U)
MAILQ ;
 S IBCTM=0
 ;JWS;IB*2.0*623;do not do for FHIR transmissions
 I '$$GET1^DIQ(350.9,"1,",8.21,"I") D CHKBTCH(+$G(^TMP("IBHDR",$J)))
 K ^TMP("IBHDR",$J),^TMP("IBHDR1",$J),^TMP("IBXMSG",$J),IBBILL
 Q
 ;
CHKNEW(IBQ,IBBILL,IBCTM,IBDESC,IBBTYP,IBINS,IBSITE,IBSIZE) ;
 ;  Determine if ok to send msg
 ;  Check for one insurance per batch if IBINS defined
 ; Returns IBSIZE, IBCTM, IBBILL (pass by reference)
 ;
 ; IBQ = data queue name
 ; IBBILL = the 'list' of bill #'s in the batch
 ; IBCTM = the # of claims output so far to the batch
 ; IBDESC = the batch description text
 ; IBBTYP = X-Y where X = P for professional, I for institution, or D for Dental
 ;                    Y = 1 for test or 0 for live transmission
 ; IBINS = the ien of the single insurance co. for the batch (optional)
 ; IBSITE = the '8' node of file 350.9 (IB PARAMETERS)
 ; IBSIZE = the 'running' size of the output message
 ;
 Q:$S($G(IBINS)="":0,1:'$P(IBSITE,U,7))
 ;
 ; New batch needed
 I IBCTM D MAILIT(IBQ,.IBBILL,.IBCTM,"",IBDESC,IBBTYP,IBINS) S IBSIZE=0
 Q
 ;
ERRMSG(XMBODY) ; Send bulletin for error message
 N XMTO,XMSUBJ
 S XMTO("I:G.IB EDI")="",XMSUBJ="EDI 837 TRANSMISSION ERRORS"
 ;
 D SENDMSG^XMXAPI(,XMSUBJ,XMBODY,.XMTO)
 D ALERT("One or more EDI bills were not transmitted.  Check your mail for details","G.IB EDI")
 Q
 ;
CLEANUP ; Cleans up bill transmission environment
 ;
 N IBTEST
 S IBTEST=+$G(^TMP("IBEDI_TEST_BATCH",$J))
 L -^IBA(364,0)
 I $D(^TMP("IBRESUBMIT",$J,"IBXERR"))!$D(^TMP("IBONE",$J,"IBXERR"))!$D(^TMP("IBSELX",$J,"IBXERR")) D  ;Error message to mail group
 . N XMTO,XMBODY,XMDUZ,XMSUBJ,XMZ,IBFUNC
 . S IBFUNC=$S($D(^TMP("IBRESUBMIT",$J,"IBXERR")):$S('IBTEST:1,1:4),$D(^TMP("IBONE",$J,"IBXERR")):2,1:3)
 . Q:'IBFUNC
 . S XMTO("I:G.IB EDI")="",XMDUZ="",XMBODY="^TMP("""_$S(IBFUNC=1!(IBFUNC=4):"IBRESUBMIT",1:"IBONE")_""","_$J_",""IBXERR"")"
 . S XMSUBJ="EDI 837 B"_$P("ATCH^ILL^ILL(s)^ILL(s)",U,IBFUNC)_" NOT "_$S($G(^TMP("IBONE",$J)):"RE",1:"")_"SUBMITTED"_$S('IBTEST:"",1:" AS TEST CLAIMS")
 . D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 . K ^TMP("IBRESUBMIT",$J),^TMP("IBONE",$J)
 ;
 I $D(^TMP("IBRESUBMIT",$J)),'IBTEST D RESUBUP^IBCEM02 ;Upd resubmtd batch bills
 I '$D(^TMP("IBSELX",$J)) K ^TMP("IBCE-BATCH",$J)
 K ^TMP("IBXERR",$J),IBXERR
 I 'IBTEST D CHKBTCH(+$G(^TMP("IBHDR",$J)))
CLEANP ;  Entrypoint for extract data disply
 K ^TMP("IBTXMT",$J),^TMP("IBXINS",$J)
 K ^TMP("IBRESUBMIT",$J),^TMP("IBRESUB",$J),^TMP("IBNOT",$J),^TMP("IBONE",$J),^TMP("IBHDR",$J),^TMP("IBTX",$J),^TMP("IBEDI_TEST_BATCH",$J)
 K ^UTILITY("VADM",$J)
 D CLEAN^DILF
 K ZTREQ S ZTREQ="@"
 Q
 ;
ALERT(XQAMSG,IBGRP) ; Send alert message
 N XQA
 S XQA(IBGRP)=""
 D SETUP^XQALERT
 Q
CHKBTCH(IBBNO) ; Delete batch whose batch # is IBBNO if no entries in file 364
 ; and not a resubmitted batch
 N IBZ,DA,DIK
 S IBZ=+$O(^IBA(364.1,"B",+IBBNO,""))
 I IBZ,'$O(^IBA(364,"C",IBZ,0)),'$P($G(^IBA(364.1,IBZ,0)),U,14) S DA=IBZ,DIK="^IBA(364.1," D ^DIK
 Q
 ;
TESTLIM(IBINS) ; Check for test bill limit per day has been reached
 N IB3,DA,DIK
 S IB3=$G(^DIC(36,IBINS,3))
 I $P(IB3,U,5)'=DT S $P(IB3,U,7)=0
 ;JWS;IB*2.0*623v24;for test env don't skip
 I '$$PROD^XUPROD(1) G 1
 I ($P(IB3,U,7)+$G(^TMP("IBICT",$J,IBINS))+1)>$P(IB3,U,6) D  Q
 . S IBINS="" ;max # hit
 . S DA=IBX,DIK="^IBA(364," D ^DIK
1 S ^TMP("IBICT",$J,IBINS)=$G(^TMP("IBICT",$J,IBINS))+1
 Q
 ;
SETVAR(IBXIEN,IBINS,IB0,IBSEC,IBNID,IB837R,IBDIV) ;
 ; Set up variables needed for subscripts in sort global
 ; ejk added IBSEC logic for patch 296
 ; IBSEC=1 if primary bill, 2 if 2nd/non-MRA, 3 if 2nd/MRA
 S IBSEC=$S($$COBN^IBCEF(IBXIEN)=1:1,'$$MRASEC^IBCEF4(IBXIEN):2,1:3)
 S IBNID=$$PAYERID^IBCEF2(IBXIEN)
 S IB837R=$$RECVR^IBCEF2(IBXIEN)
 S IBDIV=$P($S($P(IB0,U,22):$$SITE^VASITE(DT,$P(IB0,U,22)),1:$$SITE^VASITE()),U,3)
 I IBNID'="","RPIHS"[$E(IBNID),$E(IBNID,2,$L(IBNID))="PRNT" S IBNID=IBNID_"*"_IBINS
 I IBNID="" S IBNID="*"_IBINS
 S $P(IBNID,"*",3)=$S($P(IB0,U,22):$P(IB0,U,22),1:"")
 Q
 ;
