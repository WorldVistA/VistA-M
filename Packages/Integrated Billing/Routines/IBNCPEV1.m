IBNCPEV1 ;DALOI/SS - NCPDP BILLING EVENTS REPORT ;21-MAR-2006
 ;;2.0;INTEGRATED BILLING;**342,339,363,411,435,452**;21-MAR-94;Build 26
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
GETRX(IBECMENO,IBST,IBEND,IBECME) ; get ien of file 52 from #366.14
 ; input - 
 ;   IBECMENO = ECME # input from the user (with or without leading zeros)
 ;   IBST = start date (FM format)
 ;   IBEND = end date (FM format)
 ; output - function value: returns internal entry number of file #52 for the earliest date within the date range
 ;   IBECME - output variable pass by reference. Returns the external version of the ECME# with leading zeros
 ;
 ;  This subroutine is called when the user enters an ECME# as part of the search criteria
 ;
 N IBDATE,IBNO,IBIEN,IBFOUND,IBRXIEN,ECMELEN,IBRXIEN
 S (IBFOUND,IBRXIEN)=0
 F ECMELEN=12,7 D  Q:IBFOUND
 . I $L(+IBECMENO)>ECMELEN Q
 . S IBECMENO=$$RJ^XLFSTR(+IBECMENO,ECMELEN,0)   ; build ECME# with leading zeros to proper length
 . S IBDATE=+$O(^IBCNR(366.14,"E",IBECMENO,IBST-1)) Q:'IBDATE
 . I IBDATE>IBEND Q
 . S IBNO=+$O(^IBCNR(366.14,"E",IBECMENO,IBDATE,0)) Q:'IBNO
 . S IBIEN=+$O(^IBCNR(366.14,"B",IBDATE,0)) Q:'IBIEN
 . S IBRXIEN=+$P($G(^IBCNR(366.14,IBIEN,1,IBNO,2)),U,1)
 . I IBRXIEN S IBFOUND=1,IBECME=IBECMENO Q
 . Q
 Q IBRXIEN
 ;
DSTAT(IBD2,IBD3,IBD4,IBINS,IBD7) ; finish event
 ;input:
 ;IBD2 - node ^IBCNR(366.14,D0,1,D1,2)
 ;IBD3 - node ^IBCNR(366.14,D0,1,D1,3)
 ;IBD4 - node ^IBCNR(366.14,D0,1,D1,4)
 ;IBINS - multiple of ^IBCNR(366.14,D0,1,D1,5)
 ;IBD7 - node ^IBCNR(366.14,D0,1,D1,7)
 ;
 N IBX,IBT,IBSC,IB1ST,IBNXT,IBEXMPV
 S IB1ST=1
 D CHKP^IBNCPEV Q:IBQ
 ;
 W !?10,"ELIGIBILITY: "
 W $$EXTERNAL^DILFD(366.141,7.05,,$P(IBD7,U,5))    ; esg - 5/1/11 - IB*2*452
 ;
 W !?10,"EI/SC INDICATORS: "
 F IBX=2:1 S IBT=$P($T(EXEMPT+IBX^IBNCPDP1),";",3),IBSC=$P(IBT,U,2) Q:IBSC=""  S IBEXMPV=$$EXMPFLDS(IBSC,IBD4) D:IBEXMPV]""  Q:IBQ!(IBEXMPV=3)
 . I IBEXMPV=3 W "overridden by the user" Q
 . I 'IB1ST W "," I $X>70 D CHKP^IBNCPEV Q:IBQ  W !?10 S IB1ST=1
 . W " ",IBSC,":",$S(IBEXMPV=1:"Yes",IBEXMPV=0:"No",IBEXMPV=2:"No Answer",1:"?") S IB1ST=0
 Q:IBQ
 ;
 I $P(IBD2,U,4) D CHKP^IBNCPEV Q:IBQ  W !?10,"DRUG:",$$DRUGNAM(+$P(IBD2,U,4))
 D CHKP^IBNCPEV Q:IBQ  W !?10
 W "NDC:",$S($P(IBD2,U,5):$P(IBD2,U,5),1:"No")
 W ", NCPDP QTY:",$S($P(IBD2,U,14):$P(IBD2,U,14),1:"No")
 W $$UNITDISP($P(IBD2,U,14),$P(IBD2,U,15))   ; display NCPDP unit type
 ;
 D CHKP^IBNCPEV Q:IBQ  W !?10
 W "BILLED QTY:",$S($P(IBD2,U,8):$P(IBD2,U,8),1:"No")
 W $$UNITDISP($P(IBD2,U,8),$P(IBD2,U,13))    ; display billing unit type
 W ", UNIT COST:",$S($P(IBD3,U,4):$P(IBD3,U,4),1:"No")
 I $P(IBD2,U,10)]"" W ", DEA:",$P(IBD2,U,10)
 ;
 ; display insurance subfile data
 S IBX=0,IBNXT=0 F  S IBX=$O(IBINS(IBX)) Q:'IBX  D  Q:IBQ  S IBNXT=1
 . N Y,Y3,PLANIEN
 . S Y=$G(IBINS(IBX,0))
 . S PLANIEN=+$P(Y,U,2) I 'PLANIEN W "@@@@" Q
 . I IBNXT D CHKP^IBNCPEV Q:IBQ  W !?10,"-----------"
 . D CHKP^IBNCPEV Q:IBQ  W !?10
 . ;
 . W "PLAN:",$P($G(^IBA(355.3,PLANIEN,0)),U,3)
 . W ", INSURANCE:",$P($G(^DIC(36,+$G(^IBA(355.3,PLANIEN,0)),0)),U,1)
 . I +IBD7>0 W ", COB:",$S(+IBD7=2:"S",1:"P")
 . ;
 . ; display pharmacy plan ID and name
 . D CHKP^IBNCPEV Q:IBQ
 . S Y3=$G(IBINS(IBX,3))
 . W !?10,"PHARMACY PLAN:",$S($L($P(Y3,U,3)):$$PLANID($P(Y3,U,3)),1:"N/A")
 . ;
 . D CHKP^IBNCPEV Q:IBQ  W !?10 S IB1ST=1
 . I $P(Y,U,3)]"" W "BIN:",$P(Y,U,3) S IB1ST=0
 . I $P(Y,U,4)]"" W:'IB1ST ", " W "PCN:",$P(Y,U,4) S IB1ST=0
 . I $P(Y,U,5)]"" W:'IB1ST ", " W "PAYER SHEET B1:",$P(Y,U,5) S IB1ST=0
 . ;
 . D CHKP^IBNCPEV Q:IBQ  W !?10 S IB1ST=1
 . S Y=$G(IBINS(IBX,1))
 . I $P(Y,U,4)]"" W "PAYER SHEET B2:",$P(Y,U,4) S IB1ST=0
 . I $P(Y,U,5)]"" W:'IB1ST ", " W "PAYER SHEET B3:",$P(Y,U,5)
 . ;
 . D CHKP^IBNCPEV Q:IBQ
 . S Y=$G(IBINS(IBX,2))
 . W !?10,"BASIS OF COST DETERM:",$S($L($P(Y,U,2)):$$BOCD^IBNCPEV($P(Y,U,2)),1:"N/A")
 . D CHKP^IBNCPEV Q:IBQ
 . W !?10,"DISPENSING FEE:",$S($L($P(Y,U,1)):$J($P(Y,U,1),0,2),1:"N/A")
 . W ", ADMIN FEE:",$S($L($P(Y,U,5)):$J($P(Y,U,5),0,2),1:"N/A")
 . D CHKP^IBNCPEV Q:IBQ
 . W !?10,"INGREDIENT COST:",$S($L($P(Y,U,6)):$J($P(Y,U,6),0,2),1:"N/A")
 . W ", U&C CHARGE:",$S($L($P(Y,U,7)):$J($P(Y,U,7),0,2),1:"N/A")
 . W ", GROSS AMT DUE:",$S($L($P(Y,U,4)):$J($P(Y,U,4),0,2),1:"N/A")
 . Q
 ;
 Q:IBQ
 ;
 D CHKP^IBNCPEV Q:IBQ
 W !?10,"USER:",$$USR^IBNCPEV(+$P(IBD3,U,10))
 Q
 ;
UNITDISP(QTY,TYP) ; display type of units
 I 'QTY,TYP="" Q ""       ; display nothing if no QTY or TYP
 I TYP="" S TYP="  "      ; default if ""
 Q " ("_TYP_")"
 ;
PLANID(PLID) ; display Pharmacy plan ID and the name
 ; Input:  PLID - the external plan ID as found in (366.03,.01). Stored for this report as (366.1412,.303).
 N PLNAME,PLANIEN
 S PLID=$G(PLID),PLNAME=""
 I PLID="" G PLANIDX
 S PLANIEN=+$O(^IBCNR(366.03,"B",PLID,""),-1)
 I 'PLANIEN G PLANIDX
 S PLNAME=$P($G(^IBCNR(366.03,PLANIEN,0)),U,2)
PLANIDX ;
 Q PLID_" ("_PLNAME_")"
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
