IBNCPEV1 ;DALOI/SS - NCPDP BILLING EVENTS REPORT ;21-MAR-2006
 ;;2.0;INTEGRATED BILLING;**342,339,363,411**;21-MAR-94;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;IA# 10155 is used to read ^DD(file,field,0) node
 Q
 ;
SETVARS ;
 ;newed in IBNCPEV
 S (IBECME,IBPAT,IBRX,IBQ,IBSCR,IBPAGE,IBDTL,IBDIVS)=0
 ;date
 F  D DATE^IBNCPDPE Q:IBQ  Q:$$TESTDATA^IBNCPDPE
 Q:IBQ
 N IBMLTDV S IBMLTDV=$$MULTPHRM^BPSUTIL()
 I +IBMLTDV=1 S IBDIVS=+$$MULTIDIV(.IBDIVS) S:IBDIVS=0 IBDIVS(0)="0^ALL" I IBDIVS=-1 S IBQ=1 Q
 I +IBMLTDV=0 S IBDIVS=0,IBDIVS(0)="0^"_$P(IBMLTDV,U,2)
 D MODE^IBNCPDPE Q:IBQ
 D DEVICE^IBNCPDPE Q:IBQ
 Q
 ;
 ;/**
 ; input - 
 ;   IBECMENO = ECME #
 ;   IBST = start date (FM format)
 ;   IBEND = end date (FM format)
 ; output - returns internal entry number of file #52 for the earliest date within the date range
GETRX(IBECMENO,IBST,IBEND) ; get ien of file 52 from #366.14
 ; array from where the ECME BILLING EVENTS report gets its data
 ;  This subroutine is called when the user enters an ECME# as
 ;  part of the search criteria
 N IBDATE,IBNO,IBIEN
 S IBDATE=+$O(^IBCNR(366.14,"E",IBECMENO,IBST-1))
 I IBDATE=0 Q 0
 I IBDATE>IBEND Q 0
 S IBNO=+$O(^IBCNR(366.14,"E",IBECMENO,IBDATE,0))
 I IBNO=0 Q 0
 S IBIEN=$O(^IBCNR(366.14,"B",IBDATE,0))
 Q +$P($G(^IBCNR(366.14,IBIEN,1,IBNO,2)),U)
 ;
 ;/**
 ;finish
 ;input:
 ;IBD2 - node ^IBCNR(366.14,D0,1,D1,2)
 ;IBD3 - node ^IBCNR(366.14,D0,1,D1,3)
 ;IBD4 - node ^IBCNR(366.14,D0,1,D1,4)
 ;IBINS - multiple of ^IBCNR(366.14,D0,1,D1,5)
 ;IBD7 - node ^IBCNR(366.14,D0,1,D1,7)
DSTAT(IBD2,IBD3,IBD4,IBINS,IBD7) ;
 N IBX,IBT,IBSC,IB1ST,IBNXT,IBEXMPV
 S IB1ST=1
 D CHKP^IBNCPEV Q:IBQ
 W !?10,"ELIGIBILITY: "
 F IBX=2:1 S IBT=$P($T(EXEMPT+IBX^IBNCPDP1),";",3),IBSC=$P(IBT,U,2) Q:IBSC=""  S IBEXMPV=$$EXMPFLDS(IBSC,IBD4) D:IBEXMPV]""  Q:IBQ!(IBEXMPV=3)
 . I IBEXMPV=3 W "overridden by the user" Q
 . I 'IB1ST W "," I $X>70 D CHKP^IBNCPEV Q:IBQ  W !?10 S IB1ST=1
 . W " ",IBSC,":",$S(IBEXMPV=1:"Yes",IBEXMPV=0:"No",IBEXMPV=2:"No Answer",1:"?") S IB1ST=0
 Q:IBQ
 I $P(IBD2,U,4) D CHKP^IBNCPEV Q:IBQ  W !?10,"DRUG:",$$DRUGNAM(+$P(IBD2,U,4))
 D CHKP^IBNCPEV Q:IBQ  W !?10
 W "NDC:",$S($P(IBD2,U,5):$P(IBD2,U,5),1:"No"),", BILLED QTY:",$S($P(IBD2,U,8):$P(IBD2,U,8),1:"No"),", COST:",$S($P(IBD3,U,4):$P(IBD3,U,4),1:"No")
 I $P(IBD2,U,10)]"" W ", DEA:",$P(IBD2,U,10)
 S IBX=0,IBNXT=0 F  S IBX=$O(IBINS(IBX)) Q:'IBX  D  Q:IBQ  S IBNXT=1
 .N Y S Y=$P(IBINS(IBX,0),U,2,8) W:'Y "@@@@" Q:'Y
 .I IBNXT D CHKP^IBNCPEV Q:IBQ  W !?10,"-----------"
 .D CHKP^IBNCPEV Q:IBQ  W !?10
 .W "PLAN:",$P($G(^IBA(355.3,+Y,0)),U,3),"  "
 .W "INSURANCE: ",$P($G(^DIC(36,+$G(^IBA(355.3,+Y,0)),0)),U)
 .I +IBD7>0 W " COB: ",$S(+IBD7=2:"S",1:"P")
 .D CHKP^IBNCPEV Q:IBQ  W !?10 S IB1ST=1
 .I $P(Y,U,2)]"" W "BIN:",$P(Y,U,2) S IB1ST=0
 .I $P(Y,U,3)]"" W:'IB1ST ", " W "PCN:",$P(Y,U,3) S IB1ST=0
 .I $P(Y,U,4)]"" W:'IB1ST ", " W "PAYER SHEET B1:",$P(Y,U,4) S IB1ST=0
 .D CHKP^IBNCPEV Q:IBQ  W !?10 S IB1ST=1
 .S Y=IBINS(IBX,1)
 .I $P(Y,U,4)]"" W "PAYER SHEET B2:",$P(Y,U,4) S IB1ST=0
 .I $P(Y,U,5)]"" W:'IB1ST ", " W "PAYER SHEET B3:",$P(Y,U,5)
 .;S Y=$G(Z1("INS",IBX,2)) Q:Y=""
 .S Y=IBINS(IBX,2) Q:Y=""
 .D CHKP^IBNCPEV Q:IBQ  W !?10 S IB1ST=1
 .I $P(Y,U)]"" W "DISPENSING FEE:",$P(Y,U) S IB1ST=0
 .I $P(Y,U,2)]"" W:'IB1ST ", " W "BASIS OF COST DETERM:",$$BOCD^IBNCPEV($P(Y,U,2)) S IB1ST=0
 .D CHKP^IBNCPEV Q:IBQ  W !?10 S IB1ST=1
 .I $P(Y,U,3)]"" W "COST:",$J($P(Y,U,3),0,2) S IB1ST=0
 .I $P(Y,U,4)]"" W:'IB1ST ", " W "GROSS AMT DUE:",$J($P(Y,U,4),0,2) S IB1ST=0
 .I $P(Y,U,5)]"" W:'IB1ST ", " W "ADMIN FEE:",$J($P(Y,U,5),0,2)
 Q:IBQ
 ;
 D CHKP^IBNCPEV Q:IBQ
 W !?10,"USER:",$$USR^IBNCPEV(+$P(IBD3,U,10))
 Q
 ;
 ;get Exemption status by name
 ;IBEXMP - exemption (like "AO","EC", etc)
 ;IBNODE - node ^IBCNR(366.14,D0,1,D1,4)
EXMPFLDS(IBEXMP,IBNODE) ;
 Q:IBEXMP="AO" $P(IBNODE,U,1)
 Q:IBEXMP="CV" $P(IBNODE,U,2)
 Q:IBEXMP="SWA" $P(IBNODE,U,3)
 Q:IBEXMP="IR" $P(IBNODE,U,4)
 Q:IBEXMP="MST" $P(IBNODE,U,5)
 Q:IBEXMP="HNC" $P(IBNODE,U,6)
 Q:IBEXMP="SC" $P(IBNODE,U,7)
 Q:IBEXMP="SHAD" $P(IBNODE,U,8)
 Q ""
 ;returns DFN from file #366.14 by prescription ien of file #50
GETDFN(IBRX) ;
 N IB1,IB2
 S IB1=+$O(^IBCNR(366.14,"I",IBRX,0))
 I IB1=0 Q 0
 S IB2=+$O(^IBCNR(366.14,"I",IBRX,IB1,0))
 I IB2=0 Q 0
 Q +$P($G(^IBCNR(366.14,IB1,1,IB2,0)),U,3)
 ;
 ;return DRUG name (#50,.01)
 ;IBX1 - ien in file #50
DRUGNAM(IBX1) ;
 ;Q $P($G(^PSDRUG(IBX1,0)),U)
 N X
 K ^TMP($J,"IBNCPDP50")
 D DATA^PSS50(IBX1,"","","","","IBNCPDP50")
 S X=$G(^TMP($J,"IBNCPDP50",IBX1,.01))
 K ^TMP($J,"IBNCPDP50")
 Q X
 ;
DRUGAPI(DRUGIEN,FLDNUM) ;
 ;return a DRUG's field value
 ;input:
 ; DRUGIEN - ien #50
 ; FLDNUM - field number (like .01)
 ;output:
 ; returned value that contains the external value of the specified field
 N IBARR,DIQ,DIC
 S DIQ="IBARR",DIQ(0)="E",DIC=50
 D EN^PSSDI(50,"IB",DIC,.FLDNUM,.DRUGIEN,.DIQ)
 Q $G(IBARR(50,DRUGIEN,FLDNUM,"E"))
 ;
 ;reopen
REOPEN ;
 D CHKP^IBNCPEV Q:IBQ
 D SUBHDR^IBNCPEV
 I +$P(IBD3,U,3) D CHKP^IBNCPEV Q:IBQ  W !?10,"PLAN:",$P($G(^IBA(355.3,+$P(IBD3,U,3),0)),U,3),", INSURANCE: ",$P($G(^DIC(36,+$G(^IBA(355.3,+$P(IBD3,U,3),0)),0)),U)
 I $L($P(IBD3,U,6))>2 D CHKP^IBNCPEV Q:IBQ  W !?10,"REOPEN COMMENTS:",$P(IBD3,U,6)
 D CHKP^IBNCPEV Q:IBQ
 D DISPUSR^IBNCPEV
 Q
 ;
 ;Prompts user to select multiple divisions (BPS PHARMACIES)
 ; in order to filter the report by division(s) or for ALL divisions
 ; 
 ;returns composite value:
 ;1st piece
 ; 1 - divisions were selected 
 ; 0 - divisions were NOT selected 
 ; -1 if up arrow entered or timeout
 ;2nd piece
 ; A-all or D - division(s) in the BPS PHARMACIES file #9002313.56)
 ;
 ;and by reference:
 ;IBPSPHAR (only if the user selects "D") - a local array with iens and names 
 ;  of BPS PHARMACIES (file #9002313.56) selected by the user
 ;  IBPSPHAR(ien of file #9002313.56) = ien of file #9002313.56 ^ name of the BPS PHARMACY
 ;
MULTIDIV(IBPSPHAR) ;
 N IBDIVCNT,IBANSW,IBRETV
 S IBRETV=$$SELPHARM^BPSUTIL(.IBPSPHAR)
 I IBRETV="^" Q -1  ;exit
 I IBRETV="A" Q "0^A"
 Q "1^D"
 ;
 ;check if ePharmacy division in IB36614 in among those selected by the user
 ;IBDIVS - a local array (by reference) with divisions selected by the user
 ;returns 0 - not among selected divisions, 1 - among them
CHECKDIV(IB36614,IBDIVS) ;
 I $D(IBDIVS(IB36614)) Q 1
 Q 0
 ;
 ;Compile the string for divisions
 ;input:
 ;IBDVS - division local array by reference
 ;output: 
 ; return value with the resulting string
DISPLDIV(IBDVS) ;
 I ('$D(IBDVS))!($G(IBDVS)="") Q ""  ;invalid parameters
 I IBDVS=0 Q ""  ;if "all" or single division
 N IBZ,IBCNT,IBDIVSTR
 S IBDIVSTR=""
 S IBZ=0,IBCNT=0
 F  S IBZ=$O(IBDVS(IBZ)) Q:+IBZ=0  D
 . I IBCNT>0 S IBDIVSTR=IBDIVSTR_", "
 . S IBCNT=IBCNT+1
 . S IBDIVSTR=IBDIVSTR_$P(IBDVS(IBZ),U,2)
 I $L(IBDIVSTR)'<80 S IBDIVSTR=$E(IBDIVSTR,1,75)_"..."
 Q $$CENTERIT(IBDIVSTR,80)
 ;
 ;Compile the string for title
 ;input:
 ;IBBDT - begin date
 ;IBEDT - end date
 ;IBDTL - summary/detail mode
 ;IBDIVS - division local array by reference
 ;output: 
 ; return value with the resulting string
DISPTITL(IBBDT,IBEDT,IBDTL,IBDIVS) ;
 I ('$D(IBDIVS))!($G(IBDIVS)="")!($G(IBBDT)="")!($G(IBEDT)="")!($G(IBDTL)="") Q ""  ;invalid parameters
 N IBTITL
 S IBTITL="BILLING ECME EVENTS ON "_$$DAT^IBNCPEV(IBBDT)
 I IBBDT'=IBEDT S IBTITL=IBTITL_" TO "_$$DAT^IBNCPEV(IBEDT)
 S IBTITL=IBTITL_" ("_$S(IBDTL:"DETAILED",1:"SUMMARY")_") for "
 I IBDIVS'=0 S IBTITL=IBTITL_"SELECTED DIVISIONS:"
 I IBDIVS=0 S IBTITL=IBTITL_$P(IBDIVS(0),U,2)_" DIVISION" I $P(IBDIVS(0),U,2)="ALL" S IBTITL=IBTITL_"S"
 Q $$CENTERIT(IBTITL,80)
 ;
 ;Center the string (add left pads to center the string)
 ;input:
 ;IBSTR - input string
 ;IBMAXLEN - max len
 ;output: 
 ; return value with the resulting string
CENTERIT(IBSTR,IBMAXLEN) ;
 I ($G(IBSTR)="")!(+$G(IBMAXLEN)=0) Q ""
 N IBLEFT,IBSP
 S IBSTR=$E(IBSTR,1,IBMAXLEN)
 S IBLEFT=((IBMAXLEN-$L(IBSTR))/2)\1
 S IBSP=""
 S $P(IBSP," ",IBLEFT+1)=""
 Q IBSP_IBSTR
 ;Get list of indicators that were not answered
GETNOANS(IBD4) ;
 N IBX,IBT,IBSC,IBEXMPV,IBQ,IBRET
 S IBQ=0,IBRET=""
 F IBX=2:1 S IBT=$P($T(EXEMPT+IBX^IBNCPDP1),";",3),IBSC=$P(IBT,U,2) Q:IBSC=""  S IBEXMPV=$$EXMPFLDS^IBNCPEV1(IBSC,IBD4) D:IBEXMPV]""
 . I IBEXMPV=2 S IBRET=IBRET_","_IBSC
 Q $S(IBRET="":"SC",1:$E(IBRET,2,99))
 ;IBNCPEV1
