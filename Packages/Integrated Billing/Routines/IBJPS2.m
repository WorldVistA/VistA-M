IBJPS2 ;ALB/MAF,ARH - IBSP IB SITE PARAMETER BUILD (cont) ;22-DEC-1995
 ;;2.0;INTEGRATED BILLING;**39,52,115,143,51,137,161,155,320,348,349,377,384,400,432,494,461,516,547,592,608,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
BLD2 ; - continue build screen array for IB parameters
 ;
 N Z,Z0,PTPSTR,BPZZ
 D RIGHT(1,1,1) ; - facility/med center  (new line for each)
 S IBLN=$$SET("Medical Center",$$EXSET^IBJU1($P(IBPD0,U,2),350.9,.02),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("MAS Service",$$EXSET^IBJU1($P(IBPD1,U,14),350.9,1.14),IBLN,IBLR,IBSEL)
 ;
 D LEFT(2)
 S IBLN=$$SET("Default Division",$$EXSET^IBJU1($P(IBPD1,U,25),350.9,1.25),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("Billing Supervisor",$$EXSET^IBJU1($P(IBPD1,U,8),350.9,1.08),IBLN,IBLR,IBSEL)
 ;
 D RIGHT(1,1,1)
 S IBLN=$$SET("Initiator Authorize",$$YN(+$P(IBPD1,U,23)),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("Ask HINQ in MCCR",$$YN(+$P(IBPD1,U,16)),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("Multiple Form Types",$$YN(+$P(IBPD1,U,22)),IBLN,IBLR,IBSEL)
 ;
 D LEFT(2)
 S IBLN=$$SET("Xfer Proc to Sched",$$YN(+$P(IBPD1,U,19)),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("Use Non-PTF Codes",$$YN(+$P(IBPD1,U,15)),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("Use OP CPT screen",$$YN(+$P(IBPD1,U,17)),IBLN,IBLR,IBSEL)
 ;
 ; IB patch 349 for UB-04 claim form and parameters
 D RIGHT(1,1,1)
 S IBLN=$$SET("UB-04 Print IDs",$$EXSET^IBJU1($P(IBPD1,U,33),350.9,1.33),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("CMS-1500 Print IDs",$$EXSET^IBJU1($P(IBPD1,U,32),350.9,1.32),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("CMS-1500 Auto Prter",$$EXSET^IBJU1($P(IBPD8,U,14),350.9,8.14),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("EOB Auto Prter",$$EXSET^IBJU1($P(IBPD8,U,16),350.9,8.16),IBLN,IBLR,IBSEL)
 ;
 D LEFT(2)
 S IBLN=$$SET("UB-04 Address Col",$P(IBPD1,U,31),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("CMS-1500 Addr Col",$P(IBPD1,U,27),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("UB-04 Auto Prter",$$EXSET^IBJU1($P(IBPD8,U,15),350.9,8.15),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("MRA Auto Prter",$$EXSET^IBJU1($P(IBPD8,U,19),350.9,8.19),IBLN,IBLR,IBSEL)
 ;
 ; VAD - IB*2.0*547 - inserted a new section 8.  Only count activated codes
 D RIGHT(3,1,1)
 S (Z,Z0)=0 F  S Z=$O(^IBE(350.9,1,15,"B",Z)) Q:'Z  I $P($G(^DGCR(399.2,Z,0)),U,3)=1 S Z0=Z0+1
 S PTPSTR=Z0_" Activated Codes Defined"
 S IBLN=$$SET("Printed Claims Rev Code Excl",PTPSTR,IBLN,IBLR,IBSEL)
 ;
 D RIGHT(1,1,1)
 S Z=$$ICD9SYS^IBACSV(DT)
 I Z=1 S IBLN=$$SET("Default RX DX Cd",$$EXSET^IBJU1($P(IBPD1,U,29),350.9,1.29)_" (ICD-9)",IBLN,IBLR,IBSEL)
 I Z'=1 S IBLN=$$SET("Default RX DX Cd",$$EXSET^IBJU1($P(IBPD7,U,5),350.9,7.05)_" (ICD-10)",IBLN,IBLR,IBSEL)
 S IBLN=$$SET("Default RX CPT Cd",$$EXSET^IBJU1($P(IBPD1,U,30),350.9,1.30),IBLN,IBLR,IBSEL)
 ;
 D LEFT(2)
 S IBLN=$$SET("Default ASC Rev Cd",$$EXSET^IBJU1($P(IBPD1,U,18),350.9,1.18),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("Default RX Rev Cd",$$EXSET^IBJU1($P(IBPD1,U,28),350.9,1.28),IBLN,IBLR,IBSEL)
 ;
 D RIGHT(1,1,1)
 S IBLN=$$SET("Bill Signer Name","<No longer used>",IBLN,IBLR,IBSEL)
 S IBLN=$$SET("Bill Signer Title","<No longer used>",IBLN,IBLR,IBSEL)
 ;
 D LEFT(2)
 S IBLN=$$SET("Federal Tax #",$P(IBPD1,U,5),IBLN,IBLR,IBSEL)
 ;
 D RIGHT(3,1,1) ; - Pay-To Providers - section 11
 S (Z,Z0)=0 F  S Z=$O(^IBE(350.9,1,19,Z)) Q:'Z  S:$P($G(^IBE(350.9,1,19,Z,0)),U,5)="" Z0=Z0+1
 S Z=+$P($G(^IBE(350.9,1,11)),U,3),PTPSTR=Z0_" defined"_$S(Z>0:", default - "_$P($$PTG^IBJPS3(Z,0),U),1:"")
 S IBLN=$$SET("Pay-To Providers",PTPSTR,IBLN,IBLR,IBSEL)
 ;
 ; MRD;IB*2.0*516 - Added TRICARE Pay-To Providers.
 D RIGHT(3,1,1) ; - TRICARE Pay-To Providers - section 12
 S (Z,Z0)=0 F  S Z=$O(^IBE(350.9,1,29,Z)) Q:'Z  S:$P($G(^IBE(350.9,1,29,Z,0)),U,5)="" Z0=Z0+1
 S Z=+$P($G(^IBE(350.9,1,11)),U,4),PTPSTR=Z0_" defined"_$S(Z>0:", default - "_$P($$PTG^IBJPS3(Z,1),U),1:"")
 S IBLN=$$SET("Non-MCCF Pay-To Providers",PTPSTR,IBLN,IBLR,IBSEL)  ; IB*2*608 (vd) - Changed "TRICARE..." to "Non-MCCF..."
 ;
 D RIGHT(3,1,1)
 S IBLN=$$SET("Inpt Health Summary",$$EXSET^IBJU1($P(IBPD2,U,8),350.9,2.08),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("Opt Health Summary",$$EXSET^IBJU1($P(IBPD2,U,9),350.9,2.09),IBLN,IBLR,IBSEL)
 ;
 ; ePharmacy parameters
 D RIGHT(7,1,1)
 S IBLN=$$SET("HIPPA NCPDP Active Flag",$S($P(IBPD11,U)=1:"Active",1:"Not Active"),IBLN,IBLR,IBSEL)
 ;
 ; transfer pricing
 D RIGHT(1,1,1)
 S IBLN=$$SET("Inpatient TP Active ",$$YN(+$P(IBPD10,U,2)),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("Outpatient TP Active",$$YN(+$P(IBPD10,U,3)),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("Pharmacy TP Active  ",$$YN(+$P(IBPD10,U,4)),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("Prosthetic TP Active",$$YN(+$P(IBPD10,U,5)),IBLN,IBLR,IBSEL)
 ;
 ; EDI/MRA parameters
 D RIGHT(7,1,1)
 N IBZ S IBZ=$P(IBPD8,U,3)
 S IBLN=$$SET(" EDI/MRA Activated",$$EXSET^IBJU1(+$P(IBPD8,U,10),350.9,8.1),IBLN,IBLR,IBSEL)
 S IBLN=$$SET(" EDI Contact Phone",$P(IBPD2,U,11),IBLN,IBLR,IBSEL)
 S IBLN=$$SET(" EDI 837 Live Transmit Queue",$P(IBPD8,U),IBLN,IBLR,IBSEL)
 S IBLN=$$SET(" EDI 837 Test Transmit Queue",$P(IBPD8,U,9),IBLN,IBLR,IBSEL)
 S IBLN=$$SET(" Auto-Txmt Bill Frequency",$S(IBZ:"Every"_$S(IBZ>1:" "_$P(IBPD8,U,3),1:""),1:"")_$S(IBZ:" Day"_$S(IBZ=1:"",1:"s"),1:"Never Run"),IBLN,IBLR,IBSEL)
 S IBLN=$$SET(" Hours To Auto-Transmit",$P(IBPD8,U,6),IBLN,IBLR,IBSEL)
 S IBLN=$$SET(" Max # Bills Per Batch",$P(IBPD8,U,4),IBLN,IBLR,IBSEL)
 S IBLN=$$SET(" Only Allow 1 Ins Co/Claim Batch?",$$EXPAND^IBTRE(350.9,8.07,+$P(IBPD8,U,7)),IBLN,IBLR,IBSEL)
 S IBLN=$$SET(" Last Auto-Txmt Run Date",$$DATE^IBJU1($P(IBPD8,U,5)),IBLN,IBLR,IBSEL)
 S IBLN=$$SET(" Days To Wait To Purge Msgs",$P(IBPD8,U,2),IBLN,IBLR,IBSEL)
 S IBLN=$$SET(" Allow MRA Processing?",$$YN(+$P(IBPD8,U,12)),IBLN,IBLR,IBSEL)
 S IBLN=$$SET(" Enable Automatic MRA Processing?",$$YN(+$P(IBPD8,U,11)),IBLN,IBLR,IBSEL)
 S IBLN=$$SET(" Enable Auto Reg EOB Processing?",$$YN(+$P(IBPD8,U,17)),IBLN,IBLR,IBSEL)
 ;JWS;IB*2.0*592;add on/off for Dental
 I $P(IBPD8,U,20)="" S $P(IBPD8,U,20)=1  ;default to yes
 S IBLN=$$SET(" Allow Dental Claim Processing?",$$YN(+$P(IBPD8,U,20)),IBLN,IBLR,IBSEL)
 ;JWS;IB*2.0*623; add on/off for 837 FHIR transaction
 I $P(IBPD8,U,21)="" S $P(IBPD8,U,21)=0 D  ;default to no
 . N DIE,DA,DR
 . S DIE="^IBE(350.9,",DA=1,DR="8.21////0" D ^DIE
 S IBLN=$$SET(" Allow 837 FHIR Trans processing?",$$YN(+$P(IBPD8,U,21)),IBLN,IBLR,IBSEL)
 ;
 ; WCJ;IB*2.0*547;administrative contractors medicare
 D RIGHT(3,1,1)
 S Z=+$P($G(^IBE(350.9,1,81,0)),U,4)_" defined"
 S IBLN=$$SET("Alt Prim Payer ID Typ-Medicare",Z,IBLN,IBLR,IBSEL)
 ;
 ; WCJ;IB*2.0*547;administrative contractors commercial
 D RIGHT(3,1,1)
 S Z=+$P($G(^IBE(350.9,1,82,0)),U,4)_" defined"
 S IBLN=$$SET("Alt Prim Payer ID Typ-Commercial",Z,IBLN,IBLR,IBSEL)
 ;
 ; Ingenix ClaimsManager Information
 D RIGHT(9,1,1)
 S IBLN=$$SET("Are we using ClaimsManager?",$$YN(+$P(IBPD50,U,1)),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("Is ClaimsManager working OK?",$$YN(+$P(IBPD50,U,2)),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("ClaimsManager TCP/IP Address",$P(IBPD50,U,5),IBLN,IBLR,IBSEL)
 S IBCISOCK=$O(^IBE(350.9,1,50.06,"B",""))
 S IBLN=$$SET("ClaimsManager TCP/IP Ports",IBCISOCK,IBLN,IBLR,IBSEL)
 F  S IBCISOCK=$O(^IBE(350.9,1,50.06,"B",IBCISOCK)) Q:IBCISOCK=""  D
 . S IBLN=$$SET("",IBCISOCK,IBLN,IBLR,IBSEL)
 . Q
 S IBLN=$$SET("General Error MailGroup",$$EXSET^IBJU1($P(IBPD50,U,3),350.9,50.03),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("Communication Error MailGroup",$$EXSET^IBJU1($P(IBPD50,U,4),350.9,50.04),IBLN,IBLR,IBSEL)
 S IBCIMFLG=$$EXTERNAL^DILFD(350.9,50.07,"",$P(IBPD50,U,7))
 I IBCIMFLG="" S IBCIMFLG="PRIORITY"
 S IBLN=$$SET("MailMan Messages",IBCIMFLG,IBLN,IBLR,IBSEL)
 ;
 ; Request For Additional Info patch 547
 D RIGHT(9,1,1)
 S Z=$G(^IBE(350.9,1,52)) S:$P(Z,U)="" $P(Z,U)="No Purge"
 S IBLN=$$SET("Days to store 277RFAI Transactions",$P(Z,U),IBLN,IBLR,IBSEL)
 S IBLN=$$SET("Days to wait to purge entry on RFAI Management Worklist",$P(Z,U,2),IBLN,IBLR,IBSEL)
 ;
 ; WCJ - IB*2.0*608;US3 - inserted a new section 20.
 D RIGHT(3,1,1)
 S Z="",Z0=0 F  S Z=$O(^IBE(350.9,1,16,"B",Z)) Q:'Z  S Z0=Z0+1
 S PTPSTR=Z0_" CMN CPT Codes Included"
 S IBLN=$$SET("CMN CPT Code Inclusion",PTPSTR,IBLN,IBLR,IBSEL)
 Q
 ;
SET(TTL,DATA,LN,LR,SEL,HDR) ;
 N IBY,IBX,IBC S IBC=": " I TTL="" S IBC="  "
 S IBY=TTL_$J("",(IBTW(LR)-$L(TTL)-2))_$S('$G(HDR):IBC_DATA,1:""),IBX=$G(^TMP("IBJPS",$J,LN,0))
 S IBX=$$SETSTR^VALM1(IBY,IBX,IBTC(LR),(IBTW(LR)+IBSW(LR)))
 D SET1(IBX,LN,SEL)
 S LN=LN+1
 Q LN
 ;
SET1(STR,LN,SEL,HI) ; set up TMP array with screen data
 S ^TMP("IBJPS",$J,LN,0)=STR
 S ^TMP("IBJPS",$J,"IDX",LN,SEL)=""
 S ^TMP("IBJPSAX",$J,SEL)=SEL
 I $G(HI)'="" D CNTRL^VALM10(LN,1,4,IOINHI,IOINORM)
 ;I $G(RV) D CNTRL^VALM10(LN,6,19,IOUON,IOUOFF)
 Q
 ;
YN(X) Q $S(+X:"YES",1:"NO")
 ;
RIGHT(LR,SEL,BL) ; - reset control variables for right side of screen
 S IBLN=$S(IBLN>IBGRPE:IBLN,1:IBGRPE) I $G(BL) S IBLN=$$SET("","",IBLN,IBLR,IBSEL)
 S IBLR=$G(LR),IBGRPB=IBLN I +$G(SEL) S IBSEL=IBSEL+1 D SET1("["_IBSEL_"]",IBLN,IBSEL,1)
 Q
 ;
LEFT(LR) ; - reset control variables for left side of screen
 S IBLR=$G(LR),IBGRPE=IBLN,IBLN=IBGRPB
 Q
