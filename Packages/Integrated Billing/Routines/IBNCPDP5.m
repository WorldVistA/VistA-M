IBNCPDP5 ;ALB/BDB - PROCESSING FOR ECME RESP FOR SECONDARY ;11/15/07 09:43
 ;;2.0;INTEGRATED BILLING;**411,452**;21-MAR-94;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
BILLSEC(DFN,IBD) ; Create secondary bill
 ;
 N IBBCB,IBBCF,IBBCT,IBCAN,IBCCR,IBCDFN,IBCNFN,IBCOB,IBCTCOPY,IBDBC
 N IBIFN,IBINS,IBINSN,IBOFFSET,IBPLAN,IBY,IBAMT,IBRES,IBDUP
 ;
 ;if the primary claim was rejected and we don't have any primary bill for the RX/refill (see IBSEND^BPSECMP2 for additional information)
 I $G(IBD("PRIMREJ"))=1 D
 . N IBRX,IBRFL,IBREJ,IBDPR,IBRESUL,IBZARR,IBAR433,IBREJINF,DA,DR,DIE,IBRJ,IBRJCODE
 . S IBRX=+$G(IBD("PRESCRIPTION"))
 . S IBRFL=+$G(IBD("FILL NUMBER"))
 . ;check the case when we are resubmitting the secondary claims that was submitted for rejected primary claim - 
 . ;then we have already created a "dummy" primary bill and don't want to do this again
 . I +$$RXBILL^IBNCPUT3(IBRX,IBRFL,"P",,.IBZARR)>0 S IBD("PRIOR PAYMENT")=0,IBD("PRIMARY BILL")=+$O(IBZARR(0)) Q  ;quit if any primary bills exist, set IBD("PRIMARY BILL") to the first existing bill ien
 . ; create a "dummy" primary bill for the primary claim as it would be a payable primary claim with 0$ amount: 
 . S IBDPR("PAID")=IBD("PAID")
 . S IBDPR("PLAN")=IBD("PLAN")
 . S IBDPR("RTYPE")=IBD("RTYPE")
 . S IBD("PAID")=0
 . S IBD("PLAN")=IBD("PRIMPLAN")
 . S IBD("RTYPE")=""
 . S IBD("RXCOB")=1
 . S IBRESUL=$$BILL^IBNCPDP2(DFN,.IBD)
 . ; the previous step should do contractual adjustment, if not - then we need to do something else here to adjust this amount and close the primary bill
 . S IBD("PAID")=IBDPR("PAID")
 . S IBD("PLAN")=IBDPR("PLAN")
 . S IBD("RTYPE")=IBDPR("RTYPE")
 . S IBD("RXCOB")=2
 . S IBD("PRIMARY BILL")=$S(+IBRESUL>1:+IBRESUL,1:"")
 . S IBD("PRIOR PAYMENT")=0
 . Q:+IBD("PRIMARY BILL")=0
 . ; get a reject information from IBD("REJ CODES") (see IBSEND^BPSECMP2) REJS(1,"REJ CODES",1,"08")
 . S IBREJINF="Auto Dec.: ECME Primary claim rejected - "_$E($$REJINF(.IBD),1,30)
 . ; put a note with the reject code/reason to AR file #433
 . S IBAR433=$O(^PRCA(433,"C",+IBD("PRIMARY BILL"),0)) ; ICR# 3336
 . S DA=IBAR433,DIE="^PRCA(433,",DR="41///"_IBREJINF D ^DIE ; ICR# 3336
 . ; now quit to continue to create a secondary bill - i.e. allow the rest of the code to do its job
 . Q
 ;
 ; IB*2*452 - esg - check for duplicate response first thing
 S IBDUP=$$DUP^IBNCPDP2(.IBD) I IBDUP S IBY="0^Sec. Bill# "_$P(IBDUP,U,2)_" exists (Dup)" G BILLQ
 ;
 ; bill TRICARE copay if applicable
 I $G(IBD("COPAY")) D BILL^IBNCPDP6($G(IBD("PRESCRIPTION"))_";"_$G(IBD("FILL NUMBER")),IBD("COPAY"),$G(IBD("RTYPE")))
 ;
 S IBCAN=2,IBDBC=DT,IBBCB=DUZ,IBCTCOPY=1,IBY=1
 S IBIFN=$G(IBD("PRIMARY BILL")) I IBIFN="" S IBY="0^Missing the primary bill." G BILLQ
 S IBPLAN=$G(IBD("PLAN")) I IBPLAN="" S IBY="0^The Secondary Payer is not a valid Insurance Co." G BILLQ
 S IBCDFN=$$PLANN^IBNCPDPU(DFN,IBD("PLAN"),IBD("DOS"))
 I 'IBCDFN S IBY="-1^Plan not found in Patient's Profile." G BILLQ
 S IBCNFN=$P(IBCDFN,"^",2)
 S IBINSN=+^IBA(355.3,IBPLAN,0) ;insurance company
 S IBINS=$G(^DIC(36,+IBINSN,0)) I IBINS="" S IBY="0^The Secondary Payer is not a valid Insurance Co." G BILLQ
 S DIE="^DGCR(399,",DA=IBIFN,DR="102////"_IBINSN_";113////"_IBCNFN D ^DIE K DA,DR,DIE
 S IBCOB("0",15)="" ;.15 BILL COPIED FROM 
 S IBCOB("0",21)=$S($G(IBD("RXCOB"))=1:"P",$G(IBD("RXCOB"))=2:"S",1:"P") ;.21 CURRENT BILL PAYER SEQUENCE
 S IBCOB("M1",5)=IBD("PRIMARY BILL") ;125 PRIMARY BILL # [5P:399]
 S IBCOB("U2",4)=IBD("PRIOR PAYMENT") ;218 PRIMARY PRIOR PAYMENT [4N]
 ;
 S IBBCF=IBIFN ;this is the claim we are copying FROM
 S IBIDS(.15)=IBIFN K IBIFN
STEP2 ;
 S IBND0=^DGCR(399,IBIDS(.15),0) I $D(^("U")) S IBNDU=^("U")
 ;
 ; *** Note - all these fields should also be included in WHERE^IBCCC1
 ;            ECME claims should NOT define the 399,.27 - BILL CHARGE TYPE - leave it blank for RX COST Charge Set
 ;
 F I=2:1:12 S:$P(IBND0,"^",I)]"" IBIDS(I/100)=$P(IBND0,"^",I)
 F I=16:1:19,21:1:26 S:$P(IBND0,"^",I)]"" IBIDS(I/100)=$P(IBND0,"^",I)
 F I=151,152,155 S IBIDS(I)=$P(IBNDU,"^",(I-150))
 S IBIDS(159.5)=$P(IBNDU,U,20)
 S DFN=IBIDS(.02) D DEM^VADPT
 ;set rate type
 I $G(IBD("RXCOB"))=2,$G(IBD("RTYPE")) S IBIDS(.07)=IBD("RTYPE")
 S PRCASV("SER")=$P($G(^IBE(350.9,1,1)),"^",14)
 S PRCASV("SITE")=$P($$SITE^VASITE,"^",3),IBNWBL=""
 D SETUP^PRCASVC3
 I $S($P(PRCASV("ARREC"),"^")=-1:1,$P(PRCASV("ARBIL"),"^")=-1:1,1:0) S IBY="0^No Billing Record Set up for: "_$P(PRCASV("ARREC"),"^",2)_" "_$P(PRCASV("ARBIL"),"^",2) G BILLQ
 S IBIDS(.01)=$P(PRCASV("ARBIL"),"-",2)
 S IBIDS(.17)=$S($D(IBIDS(.17)):IBIDS(.17),1:PRCASV("ARREC"))
 S IBIDS(.02)=DFN,IBHV("IBIFN")=$S($G(IBIFN):IBIFN,1:$G(IBIDS(.15)))
 S X=$P($T(WHERE),";;",2) F I=0:0 S I=$O(IBIDS(I)) Q:'I  S X1=$P($E(X,$F(X,I)+1,999),";",1),$P(IBDR($P(X1,"^",1)),"^",$P(X1,"^",2))=IBIDS(I)
 S IBIFN=PRCASV("ARREC") F I=0,"C","M","M1","S","U","U1" I $D(IBDR(I)) S ^DGCR(399,IBIFN,I)=IBDR(I)
 D  ; Protect variables;index entry;replace FT if copy/clone and it changes
 . N IBHOLD,DIE,DR,DA,X,Y
 . S IBHOLD("FT")=$P($G(^DGCR(399,IBIFN,0)),U,19)
 . S $P(^DGCR(399,0),"^",3)=IBIFN,$P(^(0),"^",4)=$P(^(0),"^",4)+1 D INDEX^IBCCC2
 . I IBHOLD("FT"),IBHOLD("FT")'=$P($G(^DGCR(399,IBIFN,0)),U,19) S DA=IBIFN,DIE="^DGCR(399,",DR=".19////"_IBHOLD("FT") D ^DIE
 S IBYN=1
 S IBBCT=IBIFN ; bill that the old claim was cloned TO.
 K %,%DT,I,IB,IBA,IBBT,IBIDS,IBNWBL,J,VADM,X,X1,X2,X3,X4,Y
 ;
 S IBIFN1=$P(^DGCR(399,IBIFN,0),"^",15) G END:$S(IBIFN1="":1,'$D(^DGCR(399,IBIFN1,0)):1,1:0)
 ;
 ;move pure data nodes
 F I="I1","I2","I3","M1" I $D(^DGCR(399,IBIFN1,I)) S ^DGCR(399,IBIFN,I)=^DGCR(399,IBIFN1,I)
 ;
 ;move top level data node. ;Do not move 'TX' node
 F I="U","U1","U2","U3","UF2","UF3","UF31","C","M" I $D(^DGCR(399,IBIFN1,I)) S IBND(I)=^(I) D @(I_"^IBCCC2")
 ;
 ;move multiple level data
 F I="CC","OC","OP","OT","RC","CP","CV","PRV" I $D(^DGCR(399,IBIFN1,I,0)) D @(I_"^IBCCC2")
 ;
 D FTPRV^IBCEU5(IBIFN) ; Ask change prov type if form type not the same
 D COBCHG^IBCCC2(IBIFN,,.IBCOB)
 ;
 D ^IBCCC3 ; copy table files (362.3)
 ;
 S I=$G(^DGCR(399,IBIFN1,0)) I $P(I,U,13)=7,$P(I,U,20)=1 D COPYB^IBCDC(IBIFN1,IBIFN) ; update auto bill files
 D PRIOR^IBCCC2(IBIFN) ; add new bill to previous bills in series, primary/secondary
 I +$G(IBCTCOPY) N IBAUTO S IBAUTO=1 D PROC^IBCU7A(IBIFN),BILL^IBCRBC(IBIFN),CPTMOD26^IBCU73(IBIFN) D RECALL^DILFD(399,IBIFN_",",DUZ)
 ;
END ;
 K %,%DT,D,DDH,DIC,DGACTDT,DGAMNT,DGBR,DGBRN,DGBSI,DGBSLOS,DGFUNC,DGIFN
 K DGPCM,DGREV,DGREV00,DGREVHDR,DGRVRCAL,DGXRF1,DFN
 K I,IB,IBA,IBA1,IBA2,IBAC,IBAD,IBADD1,IBARST,IBBNO,IBBS,IBBT,IBCAN
 K IBCBCOPY,IBCCC,IBCH,IBCHK,IBCNCOPY,IBCOB,IBDA,IBDD,IBDD1,IBDPT,IBDR
 K IBDT,IBI,IBI1,IBIDS,IBIFN,IBIFN1,IBIN,IBINS,IBIP,IBLS,IBN,IBND,IBND0
 K IBNDS,IBNDU,IBO,IBOA,IBOD,IBPROC,IBPTF,IBQUIT,IBREV,IBST,IBU,IBUC
 K IBUN,IBV,IBV1,IBW,IBWW,IBX,IBYN,IBZZ,J,K
 K PRCASV,PRCAERCD,PRCAERR,PRCASVC,PRCAT,VA,VADM,VAEL,VAERR,X,X1,X2,X3,X4,Y
 ;
 N DA,IBADT,IBDIV,IBDUZ,IBPAID,IBTRIC,X
 S IBIFN=IBBCT,IBADT=IBD("DOS"),IBDIV=+$G(IBD("DIVISION")),IBDUZ=$S($G(IBD("USER")):IBD("USER"),1:DUZ)
 ;
 S DIE="^DGCR(399,",DA=IBIFN
 ; update the primary bill,ECME fields (make sure .27 field is blank)
 S DR=".17////"_$G(IBD("PRIMARY BILL"))_";.27////@;460////^S X=IBD(""BCID"")" S:$L($G(IBD("AUTH #"))) DR=DR_";461////^S X=IBD(""AUTH #"")"
 D ^DIE K DA,DR,DIE
 ;
 ; if the primary ECME claim was rejected, then do some Claims Tracking updates
 ; since this secondary claim is payable  - esg 7/8/10
 I $G(IBD("PRIMREJ"))=1 D
 . N IBRXN,IBFIL,IBTRKRN,X,Y,D0,DA,DI,DIC,DICR,DIE,DIG,DIH,DIU,DIV,DIW,DQ,DR
 . S IBRXN=+$G(IBD("PRESCRIPTION"))
 . S IBFIL=+$G(IBD("FILL NUMBER"))
 . D SETCT^IBNCPDP2    ; CT updates saying bill has been billed
 . I '$G(IBTRKRN) Q
 . S DIE="^IBT(356,",DA=IBTRKRN
 . S DR=".19///@"                   ; reason not billable - delete it
 . S DR=DR_";1.03///"_$$NOW^XLFDT   ; CT date last edited
 . S DR=DR_";1.04///"_IBDUZ         ; CT last edited by
 . S DR=DR_";1.11///0"              ; ECME Reject flag is 0 - NO
 . D ^DIE
 . Q
 ;
 ; need to make sure we have computed charges
 S IBTRIC=$$TRICARE^IBNCPDP6($G(IBD("PRESCRIPTION"))_";"_$G(IBD("FILL NUMBER")))
 D CHARGES^IBNCPDP2(IBIFN)
 I $P($G(^DGCR(399,IBIFN,"U1")),U,1)'>0 S IBY="-1^Total Charges for Sec. Bill must be greater than $0." G BILLQ
 ;
 ; update the authorize/print fields
 S DIE="^DGCR(399,",DA=IBIFN
 S DR="9////1;12////"_DT D ^DIE
 ;
 ; pass the claim to AR
 D GVAR^IBCBB,ARRAY^IBCBB1 S PRCASV("APR")=IBDUZ D ^PRCASVC6    ; perform AR checks
 I 'PRCASV("OKAY") S IBY="-1^"_$$ARERR^IBNCPDP2($G(PRCAERR),2) G BILLQ
 D REL^PRCASVC     ; accept bill into AR
 ;
 ; update the AR status to Active
 S PRCASV("STATUS")=16
 D STATUS^PRCASVC1
 ;
 ; decrease adjust bill
 ; Auto decrease from service Bill#,Tran amt,person,reason,Tran date
 S IBAMT=$G(^DGCR(399,IBIFN,"U1")),IBOFFSET=$P($G(^DGCR(399,IBIFN,"U1")),U,2)
 S IBPAID=$G(IBD("PAID"))
 I IBAMT-IBPAID>.01 D
 . N IBREAS
 . S IBREAS="Adjust based on secondary ECME amount paid."
 . I IBTRIC S IBREAS="Due to TRICARE Patient Responsibility (sec)."
 . D DEC^PRCASER1(PRCASV("ARREC"),IBAMT-IBOFFSET-IBPAID,IBDUZ,IBREAS,IBADT)
 . I 'IBPAID S PRCASV("STATUS")=22 D STATUS^PRCASVC1 ; collected/closed
 ;
 D  ; set the user in 399
 . N IBI,IBT F IBI=2,5,11,13,15 S IBT(399,IBIFN_",",IBI)=IBDUZ
 . D FILE^DIE("","IBT")
 ;
 ;
BILLQ ;
 S IBRES=$S(IBY<0:"0^"_$S($L($P(IBY,"^",2)):$P(IBY,"^",2),1:$P(IBY,"^",3)),$G(IBBCT):+IBBCT,1:IBY)
 I $G(IBBCT) S IBD("BILL")=IBBCT
 D LOG^IBNCPDP2("BILL",IBRES)
 I IBY<0 D BULL^IBNCPEB($G(DFN),.IBD,IBRES,$G(IBBCT))
 Q IBRES
 ;
REJINF(IBREJARR) ;
 N IBREJINF,IBRJ,IBRJCODE,IBCNT
 S IBREJINF="",IBCNT=0
 S IBRJ=0 F  S IBRJ=$O(IBREJARR("REJ CODES",IBRJ)) Q:+IBRJ=0  D
 . S IBRJCODE="" F  S IBRJCODE=$O(IBREJARR("REJ CODES",IBRJ,IBRJCODE)) Q:IBRJCODE=""  D
 . . I IBCNT>0 S IBREJINF=IBREJINF_", "
 . . S IBREJINF=IBREJINF_IBRJCODE_":"_$G(IBREJARR("REJ CODES",IBRJ,IBRJCODE))
 . . S IBCNT=IBCNT+1
 Q IBREJINF
 ;
WHERE ;;.01^0^1;.02^0^2;.03^0^3;.04^0^4;.05^0^5;.06^0^6;.07^0^7;.08^0^8;.09^0^9;.11^0^11;.12^0^12;.17^0^17;.18^0^18;.19^0^19;.15^0^15;.16^0^16;.21^0^21;.22^0^22;.23^0^23;.24^0^24;.25^0^25;.26^0^26;151^U^1;152^U^2;155^U^5;159.5^U^20;
 ;
