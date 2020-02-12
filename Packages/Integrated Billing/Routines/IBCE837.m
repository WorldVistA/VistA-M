IBCE837 ;ALB/TMP - OUTPUT FOR 837 TRANSMISSION ;8/6/03 10:48am
 ;;2.0;INTEGRATED BILLING;**137,191,197,232,296,349,547,592,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Auto-txmt
 N IBSITE8,IBRUN,X,X1,X2,DA,DIE,DR
 K ^TMP("IBRESUBMIT",$J),^TMP("IBONE",$J)
 S IBSITE8=$G(^IBE(350.9,1,8)),IBRUN=1
 Q:'$P(IBSITE8,U,3)!'$P(IBSITE8,U,10)
 I '$$MGCHK^IBCE(0) Q
 I $P(IBSITE8,U,5) D  Q:'IBRUN
 . S X2=+$P(IBSITE8,U,3),X1=$P(IBSITE8,U,5) D C^%DTC
 . I X>DT S IBRUN=0 Q
 D QTXMT^IBCE837B(IBSITE8)
 I $P(IBSITE8,U,5)'=DT S DIE="^IBE(350.9,",DR="8.05////"_DT,DA=1 D ^DIE
 Q
 ;
SETUP(IBEXTRP) ; Txmn set up
 ; IBEXTRP=1 prnt 837 data
 N IB
 K ^TMP("IBXMSG",$J),^TMP("IBTXMT",$J),^TMP("IBHDR",$J),^TMP("IBHDR1",$J),^TMP("IBXERR",$J),IBXERR,^TMP("IBXINS",$J),^TMP("IBTX",$J),^TMP("IBEDI_TEST_BATCH",$J)
 ; Chk extract running
 Q:$G(IBEXTRP)
 ; Chk resubmit tst
 I $P($G(^TMP("IBRESUBMIT",$J)),U,4) S ^TMP("IBEDI_TEST_BATCH",$J)=1 Q
 I '$D(^TMP("IBRESUBMIT",$J)),'$D(^TMP("IBONE",$J)) D  Q:$D(IBXERR)
 . L +^IBA(364,0):5
 . I '$T D  Q
 .. S IBXERR=1,^TMP("IBXERR",$J,1)="A PREVIOUS EDI EXTRACT IS RUNNING - ANOTHER CANNOT BE STARTED "_$$FMTE^XLFDT($$NOW^XLFDT(),2)
 ;
 I $D(^TMP("IBRESUBMIT",$J)) D  Q:$D(IBXERR)
 .N Z,Z0
 .S Z0=$P($G(^TMP("IBRESUBMIT",$J)),U,2),Z=$$LOCK^IBCEM02(364.1,Z0)
 .I 'Z D
 ..S IBXERR=1
 ..S ^TMP("IBRESUBMIT",$J,"IBXERR",1)="Another user is currently processing batch "_Z0_".  Batch NOT resubmitted."
 .I 'Z D
 ..S IBXERR=1
 ..S ^TMP("IBRESUBMIT",$J,"IBXERR",1)="Another user is currently processing batch "_Z0_".  Batch NOT resubmitted."
 ..S ^TMP("IBRESUBMIT",$J,"IBXERR",2)="Resubmit was attempted by: "_$P($G(^VA(200,DUZ,0)),U)_" ("_DUZ_")"
 I $D(^TMP("IBONE",$J)) S IB=$G(^($J))+1 D  Q:$D(IBXERR)
 .N Z,Z0
 .S Z0=$O(^TMP("IBONE",$J,"")),Z=$$LOCK^IBCEM02(364,Z0)
 .I 'Z D
 ..S IBXERR=1
 ..S ^TMP("IBONE",$J,"IBXERR",1)="Another user is currently processing bill "_$P($G(^DGCR(399,+$G(^IBA(364,Z0,0)),0)),U)_".  Bill NOT "_$P("^re",U,IB)_"submitted."
 ..S ^TMP("IBONE",$J,"IBXERR",2)=$P("S^Res",U,IB)_"ubmit was attempted by: "_$P($G(^VA(200,DUZ,0)),U)_" ("_DUZ_")"
 Q
 ;
FIND ; Find/sort by CMS-1500/UB-04, test/live, ins ID # & div
 ;
 N IBX,IB0,IBCBH,IBINS,IBXIEN,IBNID,IBGBL,IBTXTEST,IBBTYP,IB837R,IBDIV,IBNOTX,IBTXST,IBTEST,IBSEC,IBNF
 K ^TMP($J,"BILL"),^TMP("IBICT",$J)
 ;
 S IBGBL=$S($D(^TMP("IBONE",$J)):"^TMP(""IBONE"","_$J_")",$D(^TMP("IBSELX",$J)):"^TMP(""IBSELX"","_$J_")",'$D(^TMP("IBRESUBMIT",$J)):"^IBA(364,""ASTAT"",""X"")",1:"^TMP(""IBRESUBMIT"","_$J_")")
 S IBTEST=+$G(^TMP("IBEDI_TEST_BATCH",$J))
 ;
 S IBX="" F  S IBX=$O(@IBGBL@(IBX)) Q:'IBX  D
 .;IB 547, If resubmitting a locally printed claim to test via RCB, there is no entry in 364 yet, so pass the NEW flag
 .;S IBXIEN=+$G(^IBA(364,IBX,0)),IB0=$G(^DGCR(399,IBXIEN,0))
 .;S IBTXST=$$TXMT^IBCEF4(IBXIEN,.IBNOTX)
 .S IBXIEN=+$G(^IBA(364,IBX,0)),IBNF=""
 .I $G(IBLOC)=1,$G(IBTYPPTC)="TEST" S IBXIEN=IBX,IBNF=1
 .S IB0=$G(^DGCR(399,IBXIEN,0))
 .S IBTXST=$$TXMT^IBCEF4(IBXIEN,.IBNOTX,IBNF)
 .Q:IBTXST=""  ; no txmt
 .Q:$S(IB0="":1,$P(IB0,U,13)>4&'IBTEST:1,1:$D(^TMP($J,"BILL",$P(IB0,U))))
 .S IBCBH=$P(IB0,U,21) S:"PST"'[IBCBH!(IBCBH="") IBCBH="P"
 .S IBINS=$P($G(^DGCR(399,IBXIEN,"I"_($F("PST",IBCBH)-1))),U)
 .S IBTXTEST=$S(IBTEST:2,1:+$$TEST^IBCEF4(IBXIEN))
 .;JWS:IB*2.0*592:US131 - EDI Dental Claim
 .S IBBTYP=$P("P^I^D",U,$S($$FT^IBCEF(IBXIEN)=7:3,1:($$FT^IBCEF(IBXIEN)=3)+1))_"-"_IBTXTEST
 .Q:$$TESTPT^IBCEU($P(IB0,U,2))&'IBTXTEST  ;Test pt
 .;
 .I IBTXTEST=1 D TESTLIM^IBCE837A(.IBINS)
 .;
 .I IBINS,$P(IB0,U,2) D
 .. D SETVAR^IBCE837A(IBXIEN,IBINS,IB0,.IBSEC,.IBNID,.IB837R,.IBDIV)
 ..S:'$D(^TMP("IBXINS",$J,IBDIV_U_IBBTYP,IBNID)) ^(IBNID)=IBINS S ^TMP("IBTXMT",$J,IBDIV_U_IBBTYP,IB837R_U_IBSEC,IBNID,$P(IB0,U,2),IBXIEN_U_IBX)=IBX
 .;
 .S ^TMP($J,"BILL",$P(IB0,U))=""
 ;
 I $D(^TMP("IBTXMT",$J)) S ^TMP("IBXDATA",$J)=IBNID
 K ^TMP($J,"BILL")
 Q
 ;
OUTPUT ; 837
 ;
 N IB837,IBSITE,IBMAX,IBQUEUE,IBTQUEUE,IBNID,IBCT,IBCTM,IBSIZE,IBBILL,IBLCNT,IBDFN,IBREF,IBSIZEM,IBPARMS,IBD,IBDESC,IBINS,IBQ,IB3,IBBTYP,IBTXTEST,IBDEFPRT,IB837R,IBBTYPX
 ;
 K ^TMP("IBCE-BATCH",$J)
 S IBSITE=$G(^IBE(350.9,1,8)),IBMAX=$P(IBSITE,U,4),IB837=+$O(^IBE(353,"B","IB 837 TRANSMISSION",0)),IB837=$S($P($G(^IBE(353,+IB837,2)),U,8):$P(^(2),U,8),1:IB837) S:'IBMAX IBMAX=999
 ;
 I 'IB837 D  Q
 . N IBZ,XMBODY
 . S XMBODY="IBZ"
 . S IBZ(1)="The transmission form for sending electronic claims is not in your form file",IBZ(2)="NO CLAIMS WERE OUTPUT - FORM = IB 837 TRANSMISSION"
 . D ERRMSG^IBCE837A(XMBODY)
 ;
 S (IBCT,IBCTM,IBSIZE)=0,IBQUEUE=$P(IBSITE,U),IBTQUEUE=$P(IBSITE,U,9),IBDESC=""
 ;
 Q:IBQUEUE=""&(IBTQUEUE="")
 ;
 S IBQ="",IBBTYPX=""
 ; Sort: div_^_bill type_-_test stat,ins co transmission destination^sec status,dfn,claim #
 F  S IBBTYPX=$O(^TMP("IBTXMT",$J,IBBTYPX)),IBBTYP=$P(IBBTYPX,U,2) D:IBCTM CHKNEW^IBCE837A(IBQ,.IBBILL,.IBCTM,IBDESC,IBBTYP,"",IBSITE,.IBSIZE) Q:IBBTYPX=""  D
 . S IBDEFPRT=$S($E(IBBTYP)="P":"SPRINT",1:"SPRINT")
 . S IBTXTEST=+$P(IBBTYP,"-",2),IBQ=$S('IBTXTEST:IBQUEUE,IBTXTEST=2:"MCT",1:IBTQUEUE)
 . Q:IBQ=""  ; Queue
 . ;
 . ;JWS:IB*2.0*592:US131 - EDI Dental Claim
 . S IBD=$S($E(IBBTYP)="P":"PROF",$E(IBBTYP)="D":"DENT",1:"INST")_" CLAIMS-"_$$HTE^XLFDT($H,2)_"  "
 . S IBDESC=$S('$P(IBSITE,U,7):$S('IBTXTEST:"",1:"TEST ")_IBD,1:"")
 . ;
 . S IB837R=""
 . F  S IB837R=$O(^TMP("IBTXMT",$J,IBBTYPX,IB837R)) D:IBCTM CHKNEW^IBCE837A(IBQ,.IBBILL,.IBCTM,IBDESC,IBBTYP,"",IBSITE,.IBSIZE) Q:IB837R=""  D
 .. S (IBINS,IBNID)="",IBLCNT=0
 .. F  S IBNID=$O(^TMP("IBTXMT",$J,IBBTYPX,IB837R,IBNID)) K ^TMP("IBHDR1",$J) D:IBCTM CHKNEW^IBCE837A(IBQ,.IBBILL,.IBCTM,IBDESC,IBBTYP,IBINS,IBSITE,.IBSIZE) Q:IBNID=""  D
 ...;
 ...S IBDFN=0,IBINS=+$G(^TMP("IBXINS",$J,IBBTYPX,IBNID))
 ... ;
 ...I $P(IBSITE,U,7) D  ; 1 ins/batch
 .... S IBLCNT=0
 .... S IBDESC=$E($S('IBTXTEST:"",1:"TEST ")_IBD_$P($G(^DIC(36,IBINS,0)),U),1,80)
 ... ;
 ... F  S IBDFN=$O(^TMP("IBTXMT",$J,IBBTYPX,IB837R,IBNID,IBDFN)) Q:'IBDFN  S IBREF="" F  S IBREF=$O(^TMP("IBTXMT",$J,IBBTYPX,IB837R,IBNID,IBDFN,IBREF)) Q:'IBREF  D
 .... I '(IBCTM#IBMAX),IBCTM D MAILIT^IBCE837A(IBQ,.IBBILL,.IBCTM,"",IBDESC,IBBTYP,IBINS) S IBSIZE=0 ;exceeds max #
 .... ;JWS;IB*2.0*623;begin;if 837 FHIR is on, just set flag to begin transmit
 .... I $$GET1^DIQ(350.9,"1,",8.21,"I") D  Q
 ..... ;JWS;IB*2.0*623v24;added resubmit flag parameter to SETCLM^IBCE837I call
 ..... D SETCLM^IBCE837I($P(IBREF,U,2),IBQ,$S($D(^TMP("IBRESUBMIT",$J,$P(IBREF,U,2))):1,1:0))
 ..... S IBCT=IBCT+1,IBCTM=IBCTM+1
 ..... Q
 .... ;IB*2.0*623;end
 .... D BILLPARM^IBCEFG0(+IBREF,.IBPARMS)
 .... S IBSIZEM=$$EXTRACT^IBCEFG(IB837,+IBREF,1,.IBPARMS)
 .... I (IBSIZEM+IBSIZE)>30000,IBSIZE D  ; exceeds max size
 ..... D MAILIT^IBCE837A(IBQ,.IBBILL,.IBCTM,"",IBDESC,IBBTYP,IBINS) S IBSIZE=0 K ^TMP("IBXDATA",$J) S IBSIZEM=$$EXTRACT^IBCEFG(IB837,+IBREF,1,.IBPARMS)
 .... I 'IBSIZEM D:'IBCTM  Q
 ..... D CHKBTCH^IBCE837A(+$G(^TMP("IBHDR",$J))) K ^TMP("IBHDR",$J)
 .... S IBCT=IBCT+1,IBCTM=IBCTM+1
 .... D:$D(^TMP("IBXDATA",$J)) MESSAGE(.IBLCNT,$P(IBREF,U,2),.IBBILL,.IBCTM,.IBSIZE,IBSIZEM,"",IBBTYP,IBINS)
 ..;
 .. I $G(IBTXTEST)=1 S IBINS=0 F  S IBINS=$O(^TMP("IBICT",$J,IBINS)) Q:'IBINS  S IB3=$G(^DIC(36,IBINS,3)) D
 ... N DIE,DA,DR
 ... S DIE="^DIC(36,",DA=IBINS,DR="3.05////"_DT_";3.07////"_($S($P(IB3,U,5)'=DT:0,1:$P(IB3,U,7))+^TMP("IBICT",$J,IBINS)) D ^DIE
 ;
 I $O(^TMP("IBXERR",$J,"")) D  ;Error to mail grp
 .N XMTO,XMBODY,XMDUZ,XMSUBJ,IBCT,IBERR
 .K ^TMP("IBXMSG",$J)
 .S ^TMP("IBXMSG",$J,1)="The following authorized bill(s) were not transmitted due to errors indicated.",^(2)="Once the errors are corrected, the bill(s) will be included in the next run.",^(3)=" "
 .;
 .S IBERR=0,IBCT=3
 .F  S IBERR=$O(^TMP("IBXERR",$J,IBERR)) Q:'IBERR  S IBCT=IBCT+1,^TMP("IBXMSG",$J,IBCT)="Bill #: "_$P($G(^DGCR(399,IBERR,0)),U),IBCT=IBCT+1,^TMP("IBXMSG",$J,IBCT)=$J("",5)_^TMP("IBXERR",$J,IBERR)
 .S XMBODY="^TMP(""IBXMSG"","_$J_")" D ERRMSG^IBCE837A(XMBODY)
 .;
 .K ^TMP("IBXMSG",$J),^TMP("IBICT",$J)
 ;
 I $O(^TMP("IBCE-BATCH",$J,"")) D
 .N IB,IB0,IBL,IBT,IBX,XMTO,XMDUZ,XMSUBJ,IBRESUB,IBTESTB,XMZ
 .S IBRESUB=$D(^TMP("IBRESUBMIT",$J))
 .;
 .S IBT(1)="The following batches were "_$S('IBRESUB:"",1:"re-")_"submitted to Austin "_$S(IBTXTEST'=2:"",1:"as TEST ")_$$HTE^XLFDT($H,"2D")_":"
 .S IBT(2)=$S('IBRESUB:" ",1:"   [Resubmitted by: "_$P($G(^VA(200,+DUZ,0)),U)_" (#"_DUZ_")]") S:IBRESUB IBT(3)=" "
 .;
 .S IBL=$S('IBRESUB:2,1:3),IB=""
 .F  S IB=$O(^TMP("IBCE-BATCH",$J,IB)) Q:IB=""  S IBL=IBL+1,IB0=$G(^(IB)) D
 .. S IBX=IB
 .. I $P(IB0,U,3)'="",IBTXTEST=2 S IBX=$P(IB0,U,3)_" (AS BATCH "_IB_")"
 ..S IBT(IBL)=" "_IBX_" "_$P($G(^IBA(364.1,+IB0,0)),U,8),IBL=IBL+1,IBT(IBL)="    ("_+$P(IB0,U,2)_" bills)"
 .;
 .S XMTO("I:G.IB EDI")="",XMDUZ="",XMBODY="IBT",XMSUBJ="EDI 837 "_$S('IBRESUB:"",1:"RE-")_"SUBMISSION BATCH LIST"_$S(IBTXTEST'=2:"",1:" FOR TEST")
 .D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 .;
 .S:IBRESUB ^TMP("IBRESUBMIT",$J,0)=1
 Q
 ;
CLEANUP ; moved
 D CLEANUP^IBCE837A
 Q
 ;
MESSAGE(IBLCNT,IBIEN,IBBILL,IBCTM,IBSIZE,IBSIZEM,IBDUZ,IBBTYP,IBINS) ; Create msg in ^TMP("IBXMSG",$J)
 ;IBLCNT = last msg line extracted
 ;IBIEN = ien file 364 bill entry
 ;IBBILL = array file 364 ien's of bills being sent
 ; IBBILL(IEN)=""
 ;IBSIZE = # bytes in msg
 ;IBSIZEM = # bytes in record to be added to msg
 ;IBCTM = # bills in batch
 ;IBDUZ = user ien running extract (Postmaster if auto)
 ;IBBTYP = x-y where x = P for prof, I for inst, D for dental  ;JWS:IB*2.0*592:US131 - EDI Dental Claim
 ;         y = 1 for test, 0 for live txmt
 ;IBINS = ien of 1 ins co for batch
 ;
 N IB,IBL,IB1,IB2,IB3,IBQ,IBREC,IBDEL
 S IBDEL=$O(^IBA(364.5,"B","N-SEGMENT DELIMITER","")),IBDEL=$P($G(^IBA(364.5,+IBDEL,0)),U,8) S:IBDEL="" IBDEL="~"
 S IBSIZE=IBSIZE+IBSIZEM,IB1="",IBREC=""
 F  S IB1=$O(^TMP("IBXDATA",$J,1,IB1)) Q:IB1=""  D
 .S (IBREC,IB2)=""
 .F  S IB2=$O(^TMP("IBXDATA",$J,1,IB1,IB2)) Q:$S(IB2="":1,IB1=1:"",1:'$O(^(IB2,1)))  D
 ..S IB3="",IBREC=""
 ..F  S IB3=$O(^TMP("IBXDATA",$J,1,IB1,IB2,IB3)) D:IB3=""&($L(IBREC)) SETG Q:IB3=""  S:$S(IB3=1:1,1:$P(IBREC,U)'="") $P(IBREC,U,IB3)=$$UP^XLFSTR(^TMP("IBXDATA",$J,1,IB1,IB2,IB3))
 S IBBILL(IBIEN)=""
 K ^TMP("IBXDATA",$J)
 Q
 ;
SETHDR ; hdr for curr batch
 S ^TMP("IBHDR",$J)=$G(^TMP("IBXDATA",$J,1,5,1,2))
 Q
 ;
SETHDR1 ; hdr node for curr ins
 S ^TMP("IBHDR1",$J)=$G(^TMP("IBXDATA",$J,1,20,1,8))
 Q
 ;
SETG ; msg global for each segment
 S IBREC=$TR(IBREC,IBDEL)
 S IBREC=IBREC_IBDEL,IBSIZE=IBSIZE+$L(IBDEL)
 S IBLCNT=IBLCNT+1,^TMP("IBXMSG",$J,IBLCNT)=IBREC
 Q
 ;
ONE ; Txmt 1 or more bills for test or in 'X' status for live
 Q:'$$MGCHK^IBCE(0)
 D SETUP(0)
 I '$D(IBXERR) D FIND,OUTPUT
 D CLEANUP^IBCE837A
 Q
 ;
