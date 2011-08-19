IBNCPEV ;DALOI/SS - NCPDP BILLING EVENTS REPORT ;5/22/08  14:27
 ;;2.0;INTEGRATED BILLING;**342,363,383,384,411**;21-MAR-94;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
RPT ;
 N IBBDT,IBDIVS,IBDTL,IBEDT,IBM1,IBM2,IBM3,IBPAGE,IBPAT,IBQ,IBRX,IBSCR,Y
 N IBECME
 D SETVARS^IBNCPEV1
 Q:IBQ
 D START
 D ^%ZISC
 I IBQ W !,"Cancelled"
 Q
 ;
START ;
 N IBFN,IBFROM,IBI,IBN,IBNB,IBNDX,IBNUM,IBRX1,IBSC,IBTO,IB1ST,REF,X,Z,Z1
 ;Constants
 S IBSC="STATUS CHECK",IBNB="Not ECME billable: ",IBNDX="IBNCPDP-"
 ;get the first date
 S IBFROM=$O(^IBCNR(366.14,"B",IBBDT-1)) Q:+IBFROM=0
 ;get the last date
 S IBTO=$O(^IBCNR(366.14,"B",IBEDT+1),-1) Q:+IBTO=0
 ;
 S REF=$NA(^TMP($J,"IBNCPDPE"))
 ;
 K @REF
 ;
 I +$G(IBECME) S IBRX=$$GETRX^IBNCPEV1(IBECME,IBFROM,IBTO) I 'IBRX  W !!,"No data found for the specified date range and ECME #" Q  ; no match with ECME #
 ;collect
 N IBDFN,IBDTIEN,IBEVNT,IBP4,IBRXIEN,IBZ0,IBZ1,IBZ2
 S IBI=IBFROM-1
 F  S IBI=$O(^IBCNR(366.14,"B",IBI)) Q:+IBI=0  Q:IBI>IBTO  D
 . S IBDTIEN=$O(^IBCNR(366.14,"B",IBI,0))
 . S IBN=0 F  S IBN=$O(^IBCNR(366.14,IBDTIEN,1,IBN)) Q:+IBN=0  D
 . . S IBZ0=$G(^IBCNR(366.14,IBDTIEN,1,IBN,0))
 . . ;if not "ALL" was selected IBDIVS>0 AND the division in #366.14 record is among those selected by the user
 . . I IBDIVS>0,$$CHECKDIV^IBNCPEV1(+$P(IBZ0,U,9),.IBDIVS)=0 Q
 . . S IBDFN=+$P(IBZ0,U,3)
 . . Q:IBDFN=0
 . . S IBEVNT=$$GET1^DIQ(366.141,IBN_","_IBDTIEN_",",.01)
 . . S IBZ2=$G(^IBCNR(366.14,IBDTIEN,1,IBN,2))
 . . S IBRXIEN=$P(IBZ2,U,12)
 . . I IBRXIEN="" S IBRXIEN=$P(IBZ2,U,1)
 . . I IBPAT,IBDFN'=IBPAT Q
 . . I IBM2="E",IBEVNT[IBSC,'$P(IBZ0,U,7) Q
 . . I IBM2="N",IBEVNT'[IBSC Q
 . . I IBM2="N",IBEVNT[IBSC,$P(IBZ0,U,7) Q
 . . ;if "No Rx IEN" case then create a unique artificial IBRXIEN to be able
 . . ;to create ^TMP entry and display available information in the report
 . . I +$G(IBRXIEN)=0 S IBRXIEN=+(IBDTIEN_"."_IBN) G SETTMP
 . . I IBRX,IBRXIEN'=IBRX Q
 . . I $$RXNUM(IBRXIEN)="" Q
 . . I IBM3'="A",IBM3'=$$RXWMC^IBNCPRR(+IBRXIEN) Q
SETTMP . . S @REF@(+IBRXIEN,+$P(IBZ2,U,3),IBDTIEN,IBN)=""
 ;
 I '$D(@REF) W !!,"No data found for the specified input criteria" Q
 ;print
 S IBNUM=0
 U IO D HDR
 S IBRX1="" F  S IBRX1=$O(@REF@(IBRX1)) Q:IBRX1=""  D  Q:IBQ
 .S IBFN="" F  S IBFN=$O(@REF@(IBRX1,IBFN)) Q:IBFN=""  D  Q:IBQ
 ..S IB1ST=1
 ..S IBI="" F  S IBI=$O(@REF@(IBRX1,IBFN,IBI)) Q:IBI=""  D  Q:IBQ
 ...S IBN="" F  S IBN=$O(@REF@(IBRX1,IBFN,IBI,IBN)) Q:IBN=""  D  Q:IBQ
 ....N IBZ,IBD1,IBD2,IBD3,IBD4,IBD7,IBINS,IBY
 ....;load main
 ....S IBZ=$G(^IBCNR(366.14,IBI,1,IBN,0))
 ....;load IBD array
 ....S IBD1=$G(^IBCNR(366.14,IBI,1,IBN,1))
 ....S IBD2=$G(^IBCNR(366.14,IBI,1,IBN,2))
 ....S IBD3=$G(^IBCNR(366.14,IBI,1,IBN,3))
 ....S IBD4=$G(^IBCNR(366.14,IBI,1,IBN,4))
 ....S IBD7=$G(^IBCNR(366.14,IBI,1,IBN,7))
 ....S IBY=0
 ....;load insurance multiple
 ....F  S IBY=$O(^IBCNR(366.14,IBI,1,IBN,5,IBY)) Q:+IBY=0  D
 .....S IBINS(IBY,0)=$G(^IBCNR(366.14,IBI,1,IBN,5,IBY,0))
 .....S IBINS(IBY,1)=$G(^IBCNR(366.14,IBI,1,IBN,5,IBY,1))
 .....S IBINS(IBY,2)=$G(^IBCNR(366.14,IBI,1,IBN,5,IBY,2))
 .....S IBINS(IBY,3)=$G(^IBCNR(366.14,IBI,1,IBN,5,IBY,3))
 ....;
 ....I IB1ST D  Q:IBQ
 .....S IBNUM=IBNUM+1 I IBNUM>1 D ULINE("-") Q:IBQ
 .....D CHKP Q:IBQ
 .....W !,IBNUM," ",?4,$$RXNUM(IBRX1)," ",?12,IBFN," ",?16,$$DAT(+$P(IBD2,U,6)) ;RX# Fill# Fill_date
 .....W " ",?28,$E($$PAT(+$P(IBZ,U,3)),1,21)," ",?50,$E($$DRUG(+$P(IBZ,U,3),IBRX1),1,30)
 .....S IB1ST=0
 ....N IND S IND=6
 ....D CHKP Q:IBQ
 ....S IBEVNT=$$GET1^DIQ(366.141,IBN_","_IBI_",",.01)
 ....W !,?IND,$$EVNT(IBEVNT)," ",?16,$$TIM($P(IBZ,U,5)),?31," Status:",$E($$STAT(IBEVNT,$P(IBZ,U,7)_U_$P(IBZ,U,8),$P(IBD3,U,7),$P(IBD3,U,1)),1,40)
 ....Q:'IBDTL  ; no details
 ....I IBEVNT="BILL" D DBILL Q
 ....I IBEVNT="REJECT" D DREJ Q
 ....I IBEVNT["REVERSE" D DREV Q
 ....I IBEVNT["SUBMIT" D DSUB Q
 ....I IBEVNT["CLOSE" D DCLO Q
 ....I IBEVNT["REOPEN" D REOPEN^IBNCPEV1 Q
 ....I IBEVNT["RELEASE" D DREL Q
 ....I IBEVNT[IBSC D DSTAT^IBNCPEV1(.IBD2,.IBD3,.IBD4,.IBINS,.IBD7) Q
 ....I IBEVNT["BILL CANCELLED" D BCANC Q
 I IBSCR,'IBQ W !,"End of report, press RETURN to continue." R X:DTIME
 K @REF
 Q
 ;
STAT(X,RES,CR,IBIFN) ;provides STATUS information
 N IBNL,IBSC
 S IBNL="Plan not linked to the Payer",IBSC="STATUS CHECK"
 I X[IBSC,RES[IBNB S RES="0^"_$P(RES,IBNB,2)
 I X[IBSC,RES[IBNL S RES="0^Plan not linked" ; shorten too long line
 I X[IBSC,'RES,RES["Non-Billable in CT" Q $P(RES,U,2)
 I X[IBSC Q $S(RES:"",1:"non-")_"ECME Billable"_$S(RES:"",$P(RES,U,2)="":"",$P(RES,U,2)="NEEDS SC DETERMINATION":" NEEDS "_$$GETNOANS^IBNCPEV1(IBD4)_" DETERMINATION",1:", "_$P(RES,U,2))
 I X="BILL",'RES,IBIFN Q "Bill "_$$BILL(IBIFN)_" created with ERRORs"
 I X="BILL",'RES Q "Error: "_$P(RES,U,2)
 I X="BILL",'IBIFN Q $P(RES,U,2)
 I X="BILL" Q "Bill# "_$$BILL(+IBIFN)_" created"
 I X["REVERSE",$G(CR)=7,RES=1 Q "set N/B Reason: Rx deleted, no Bill to cancel."
 I X["REVERSE" Q $S(RES=1:"success",RES>1:"Bill# "_$$BILL(+RES)_" cancelled",'RES:"ECME Claim reversed, no Bill to cancel",1:$P(RES,U,2))
 I 'RES Q $P(RES,U,2)
 Q "OK"
 ;
 ;BILL section
 ;input params IBD*, IBZ, IBINS*
DBILL ;
 I '$P(IBZ,U,7),$L($P(IBZ,U,8)),$P(IBD3,U,1) D CHKP Q:IBQ  W !?10,"ERROR DESCRIPTION: ",$P(IBZ,U,8)
 D CHKP Q:IBQ
 D SUBHDR
 I $P(IBD2,U,4) D CHKP Q:IBQ  W !?10,"DRUG:",$$DRUGAPI^IBNCPEV1(+$P(IBD2,U,4),.01)
 D CHKP Q:IBQ
 W !,?10,"NDC:",$S($P(IBD2,U,5):$P(IBD2,U,5),1:"No"),", BILLED QTY:",$S($P(IBD2,U,8):$P(IBD2,U,8),1:"No"),", DAYS SUPPLY:",$S($P(IBD2,U,9):$P(IBD2,U,9),1:"No")
 W !,?10,"BILLED:",$J($P(IBD3,U,2),0,2),", "
 W "PAID:",$J($P(IBD3,U,5),0,2)
 W:$P(IBD3,U,11) ", 3RD PARTY REPORTED COPAY:",$J($P(IBD3,U,11),0,2)
 D CHKP Q:IBQ
 W !?10,"PLAN:",$P($G(^IBA(355.3,+$P(IBD3,U,3),0)),U,3),", INSURANCE: ",$P($G(^DIC(36,+$G(^IBA(355.3,+$P(IBD3,U,3),0)),0)),U)
 D CHKP Q:IBQ
 D DISPUSR
 Q
 ;
 ;reject section
DREJ ;
 D CHKP Q:IBQ
 D SUBHDR
 I +$P(IBD3,U,3) D CHKP Q:IBQ  W !?10,"PLAN:",$P($G(^IBA(355.3,+$P(IBD3,U,3),0)),U,3),", INSURANCE: ",$P($G(^DIC(36,+$G(^IBA(355.3,+$P(IBD3,U,3),0)),0)),U)
 D CLRS Q:IBQ
 D CHKP Q:IBQ
 D DISPUSR
 Q
 ;close
DCLO ;
 D DREJ
 Q
 ;submit
DSUB ;
 D CHKP Q:IBQ
 D SUBHDR
 I $L($P(IBD1,U,6)) D CHKP W !?10,"PAYER RESPONSE: ",$P(IBD1,U,6)
 I $L($P(IBD3,U,3)) D CHKP Q:IBQ  W !?10,"PLAN:",$P($G(^IBA(355.3,+$P(IBD3,U,3),0)),U,3),", INSURANCE: ",$P($G(^DIC(36,+$G(^IBA(355.3,+$P(IBD3,U,3),0)),0)),U)
 D CHKP Q:IBQ
 D DISPUSR
 Q
 ;release
DREL ;
 D DREJ
 Q
 ;reverse
DREV ;
 D CHKP Q:IBQ
 D SUBHDR
 I $L($P(IBD1,U,6)),$E($P(IBD1,U,6),1)'="A"&($E($P(IBD1,U,6),1)'="R") S $P(IBD1,U,6)=""  ; only display accepted and rejected on REVERSALS
 I $L($P(IBD1,U,6)) D CHKP W !?10,"PAYER RESPONSE: ",$P(IBD1,U,6)
 I $L($P(IBD3,U,3)) D CHKP Q:IBQ  W !?10,"PLAN:",$P($G(^IBA(355.3,+$P(IBD3,U,3),0)),U,3),", INSURANCE: ",$P($G(^DIC(36,+$G(^IBA(355.3,+$P(IBD3,U,3),0)),0)),U)
 D CLRS Q:IBQ
 D CHKP Q:IBQ
 D DISPUSR
 W !?10,"REVERSAL REASON:",$P(IBD1,U,7)
 Q
 ;
BCANC ; bill cancellation generated by auto-reversal (duplicate bill)
 D CHKP Q:IBQ
 W !?10,"SYSTEM FOUND DUPLICATE BILL WHILE PROCESSING CLAIM"
 D CHKP Q:IBQ
 D DISPUSR
 Q
 ;
RELT(X) I X W ",",?45,"RELEASE DATE:",$$TIM(X)
 Q
CLRS ;
 N TX,PP,RC
 S TX="CLOSE REASON"
 S PP="DROP TO PAPER"
 S RC="RELEASE COPAY"
 I $P(IBD3,U,7)'="" D CHKP Q:IBQ  W !?10,TX,":",$$REASON^IBNCPDPU($P(IBD3,U,7)) W:$P(IBD3,U,8) ", ",PP W:$P(IBD3,U,9) ", ",RC
 S TX="CLOSE COMMENT"
 I $L($P(IBD3,U,6))>2 D CHKP Q:IBQ  W !?10,"COMMENT:",$P(IBD3,U,6)
 Q
 ;
HDR ;header
 W @IOF S IBPAGE=IBPAGE+1 W ?72,"PAGE ",IBPAGE
 W !,$$DISPTITL^IBNCPEV1(IBBDT,IBEDT,IBDTL,.IBDIVS)
 W:IBDIVS'=0 !,$$DISPLDIV^IBNCPEV1(.IBDIVS)
 W !?15
 I IBM1="R" W "SINGLE PRESCRIPTION - ",$$RXNUM(IBRX),"  "
 I IBM1="P" W "SINGLE PATIENT - ",$P($G(^DPT(IBPAT,0)),U),"  "
 I IBM1="E" W "SINGLE ECME # - ",IBECME
 I IBM2="E" W "ECME BILLABLE RX  "
 I IBM2="N" W "NON ECME BILLABLE RX  "
 I IBM3'="A",IBM1'="R" W $S(IBM3="M":"MAIL",IBM3="C":"CMOP",1:"WINDOW")_" PRESCRIPTIONS ONLY"
 W !,?4," RX#   FILL  DATE       PATIENT NAME",?55,"DRUG"
 N I W ! F I=1:1:80 W "="
 Q
 ;
ULINE(X) ;line
 D CHKP Q:IBQ
 N I W ! F I=1:1:80 W $G(X,"-")
 Q
CHKP ;Check for EOP
 N Y
 I $Y>(IOSL-4) D:IBSCR PAUSE Q:IBQ  D HDR
 Q
DAT(X,Y) Q $$DAT1^IBOUTL(X,.Y)
TIM(X) N IBT ;time
 S IBT=$$DAT1^IBOUTL(X,1) I $L(IBT," ")<3 Q IBT
 I $P(IBT," ",3)="pm" S IBT=$P(IBT," ",1,2)_"p" Q IBT
 I $P(IBT," ",3)="am" S IBT=$P(IBT," ",1,2)_"a" Q IBT
 Q IBT
 ;
USR(X) ;
 I $D(^VA(200,+X,0)) Q $P(^(0),U)
 Q X
 ;
PAT(DFN) ;
 Q $P($G(^DPT(DFN,0),"?"),"^")
BILL(BN) ;
 Q $P($G(^DGCR(399,BN,0),"?"),"^")
ARBILL(BN) ;
 Q $P($G(^PRCA(430,BN,0),"?"),"^")
 ;
 ;Returns DRUG name (#50,.01)
 ;IBDFN = IEN in PATIENT file #2
 ;IBRX = IEN in PRESCRIPTION file #52
DRUG(IBDFN,IBRX) ;
 I +$G(IBDFN)=0 Q ""
 N X1
 K ^TMP($J,"IBNCPDP52")
 D RX^PSO52API(IBDFN,"IBNCPDP52",IBRX,"",0)
 S X1=+$G(^TMP($J,"IBNCPDP52",IBDFN,IBRX,6))
 K ^TMP($J,"IBNCPDP52")
 I X1=0 Q ""
 Q $$DRUGNAM^IBNCPEV1(X1)
 ;
EVNT(X) ;Translate codes
 I X="BILL" Q "BILLING"
 I X="REVERSE" Q "REVERSAL"
 I X="AUTO REVERSE" Q "REVERSAL(A)"
 I X["RELEASE" Q "RELEASE"
 I X["SUBMIT" Q "SUBMIT"
 I X["CLOSE" Q "CLOSE"
 I X[IBSC Q "FINISH"  ;IBSC = "STATUS CHECK"
 Q X
 ;
BOCD(X) ;Basis of Cost Determination
 I +X=7 Q "USUAL & CUSTOMARY"
 I +X=1 Q "AWP"
 I +X=5 Q "COST CALCULATIONS"
 Q X
 ;
PAUSE ;
 N X U IO(0) W !,"Press RETURN to continue, '^' to exit:" R X:DTIME S:'$T X="^" S:X["^" IBQ=1
 U IO
 Q
 ;
SUBHDR ;
 W !?10,"ECME# ",$P(IBD1,U,3),",",?25,"FILL DATE:",$$DAT($P(IBD2,U,6))
 D RELT($P(IBD2,U,7))
 Q
DISPUSR ;
 W !?10,"USER:",$$USR(+$P(IBD3,U,10))
 Q
 ;
 ;Returns RX number (external value: #52,.01)
 ;IBRX = IEN in PRESCRIPTION file #52
RXNUM(IBRX) ;
 Q $$RXAPI1^IBNCPUT1(IBRX,.01,"E")
 ;
