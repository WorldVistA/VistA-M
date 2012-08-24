IB20P202 ;WOIFO/AAT-GMT IB PART 3 POST-INSTALL ;24-OCT-02
 ;;2.0;INTEGRATED BILLING;**202**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
POST ;Post-Install procedure
 ;
 K ^TMP($J,"IB20P202")
 D PRNMSG ; Print message to the user
 D RELALL ; Force conversion for all remaining patients
 ; Remove temporary global nodes
 K ^XTMP("IB GMT CONVERSION")
 K ^IB("AGMT")
 K ^IB("AGMTP")
 K ^TMP($J,"IB20P202")
 Q
 ;
 ; Add the patient to the log message
ADDPAT(DFN,IBRES,IBNUM) N IBPT,IBSTA
 S IBPT=$P($G(^DPT(DFN,0)),U) ;Patient's name
 S IBSTA=$P($$LST^DGMTU(DFN),"^",3) ;Patient's Copayment Status
 S IBSTA=$E(IBSTA,1,20),IBSTA=IBSTA_$J("",20-$L(IBSTA))
 D ADDLN($J(IBNUM,3)_" "_IBPT_$J("",30-$L(IBPT))_" "_IBSTA_" "_(+IBRES)_" Charge"_$S(IBRES=1:"",1:"s"))
 Q
 ;
 ;Add a line to the text array
ADDLN(IBTXT) N IBC
 D MES^XPDUTL("  "_$G(IBTXT))
 S IBC=$O(^TMP($J,"IB20P202",""),-1)+1
 S ^TMP($J,"IB20P202",IBC)=$G(IBTXT," ")
 Q
 ;
RELALL ;Release all remaining held charges off hold;
 N DFN,IBRES,IBNUM,XMSUB,XMY,XMDUZ,XMTEXT,XMGROUP,DIFROM
 D ADDLN("Geographic Means Test Clean-up, patch IB*2.0*202 post-install procedure.")
 D ADDLN("During the GMT IB Clean-up procedure all Inpatient Means Test charges, placed")
 D ADDLN("ON HOLD (RATE) since October 1, 2002, will be released and passed to the")
 D ADDLN("Accounts Receivable package.")
 D ADDLN("For patients with 'GMT COPAY REQUIRED' status charges will be recalculated.")
 D ADDLN("Process started on "_$$NOW())
 D ADDLN()
 D ADDLN("Searching and processing patients, who did not pass the GMT conversion...")
 D ADDLN()
 S IBNUM=0
 S DFN=0 F  S DFN=$O(^IB("AGMTP",DFN)) Q:'DFN  D
 . S IBRES=$$RELHOLD(DFN)
 . S IBNUM=IBNUM+1
 . D ADDPAT(DFN,IBRES,IBNUM)
 I IBNUM=0 D ADDLN("none found.")
 I $D(^IB("AC",20)) D FORCEREL ; Force releasing of hold charges on hold (rate)
 D ADDLN()
 D ADDLN("Process finished at "_$$NOW())
 D ADDLN()
 I $D(^IB("AC",20)) D
 . D ADDLN("Some charges still remain on hold (rate), they may be not related to GMT.")
 . D ADDLN("Use 'List Charges Awaiting New Copay Rate' menu option to make sure, that ")
 . D ADDLN("there is no GMT-related charges, placed on hold, because of unknown rate.")
 I IBNUM>0 D ADDLN(),ADDLN("Use the 'Means Test Single Patient Billing Profile' report to review charges.")
 ;
 ; Send log message to IB MEANS TEST mail group.
 S XMSUB="GEOGRAPHIC MEANS TEST CLEAN-UP PROCEDURE"
 S XMDUZ="PATCH IB*2.0*202 POST-INIT"
 S XMGROUP=$$GET1^DIQ(350.9,"1,",.11) ; Means Test billing Group
 S XMY(DUZ)="" ; Send the message to the user (at least)
 I XMGROUP'="" S XMY("G."_XMGROUP)=""
 S XMTEXT="^TMP($J,""IB20P202"","
 ;
 D ^XMD
 Q
 ;
FORCEREL ; Force releasing remaining charges on hold (rate)
 N IBACT,IBCNT
 S IBCNT=0
 S IBACT=0 F  S IBACT=$O(^IB("AC",20,IBACT)) Q:'IBACT  I $$RELCRG(IBACT) S IBCNT=IBCNT+1
 I IBCNT D ADDLN(IBCNT_" inpatient charges were released off hold additionally.")
 Q
 ;
 ;Perform "conversion" for the given patient 
RELHOLD(DFN) N IBACT,IBDT,X,IBLIMIT,IBCNT
 S DFN=+DFN
 S IBLIMIT=$$PLUS($$GMTEFD^IBAGMT(),-30)
 S IBCNT=0
 ;For each Patient's IB Action starting from the last, back to the GMT Effective Date:
 S IBDT="" F  S IBDT=$O(^IB("APTDT",DFN,IBDT),-1) Q:IBDT=""  Q:IBDT<IBLIMIT  D
 . S IBACT="" F  S IBACT=$O(^IB("APTDT",DFN,IBDT,IBACT),-1) Q:'IBACT  S IBCNT=IBCNT+$$RELCRG(IBACT)
 K ^IB("AGMTP",DFN) ; Remove the flag
 Q IBCNT
 ;
 ;
 ; Release/recalculate the single charge
 ; Also adjust MT Billing Clock Data, if this is a Copay charge.
 ; Input: IB ACTION IEN
 ; Output: 1 - Processed, 0 - Charge does not need to be processed (or error)
RELCRG(IBACT) N DFN,IBZ,IBSTA,IBDT,IBCRG,IBNOS,IBSEQNO,IBDUZ,IBFDA,IBGMT,Y,IBCLK,IB90D,IBCLKZ,IBAMT,IBATYP
 S IBZ=$G(^IB(IBACT,0)) Q:IBZ="" 0 ;Corrupted cross-reference
 S DFN=$P(IBZ,U,2)
 S IBSTA=$P(IBZ,U,5) I IBSTA'=20,IBSTA'=1 Q 0 ;Not a 'HOLD-RATE' and not an 'INCOMPLETE'
 S IBATYP=+$P(IBZ,U,3) ; IB Action Type
 S IBDT=$P(IBZ,U,14) ; Date Billed From
 I IBDT<$$GMTEFD^IBAGMT() Q 0 ;Never touch charges 'billed from' before the GMT Effective Date
 I '$$ISGMTTYP^IBAGMT(IBATYP) Q 0 ;Not a MT Inpatient charge
 S X="RCERR^IB20P202",@^%ZOSF("TRAP")
 S IBCRG=$P(IBZ,U,7) ;Charge Amount
 S IBGMT=$$ISGMTPT^IBAGMT(DFN,IBDT) ; GMT Status for the patient
 ;Recalculate the charge
 I IBGMT>0,'$P(^IB(IBACT,0),U,21) D  ;If the patient has GMT Copayment Status
 . S $P(^IB(IBACT,0),U,7)=$$REDUCE^IBAGMT(IBCRG) ;Reduce the amount to 20%
 . S $P(^IB(IBACT,0),U,21)=1 ;Mark the charge as GMT RELATED
 . Q:'$G(^IB("AGMT",IBACT))  ; Quit if that is not COPAY charge.
 . ; The temporary node "AGMT" exists only for Inpatient Copay Charges.
 . ; Adjusting MT Billing Clock Amount
 . S IBCLK=+$P(^IB("AGMT",IBACT),U),IB90D=+$P(^(IBACT),U,2) Q:IB90D<1  Q:IB90D>4
 . S IBCLKZ=$G(^IBE(351,IBCLK,0)) Q:IBCLKZ=""
 . S IBAMT=+$P(IBCLKZ,"^",4+IB90D) S IBAMT=IBAMT-IBCRG+$$REDUCE^IBAGMT(IBCRG) S:IBAMT<0 IBAMT=0
 . S $P(^IBE(351,IBCLK,0),U,4+IB90D)=IBAMT
 K ^IB("AGMT",IBACT) ; Remove temporary node
 ; Now pass the held charge to the AR package (Incomplete charges will not be released)
 I IBSTA'=1 S IBNOS=IBACT,IBSEQNO=$P($G(^IBE(350.1,IBATYP,0)),U,5) S:IBSEQNO="" IBSEQNO=1 S IBDUZ=DUZ D ^IBR I Y<0 D ERRMSG(IBACT,$P(Y,U,2,99))
 I IBGMT'>0,IBSTA=1 Q 0  ; Incomplete charges for non-GMT patients
 Q 1
 ;
RCERR N IBERR  ;Error trapping for RELCRG
 S IBERR=$$EC^%ZOSV
 D ^%ZTER
 D ERRMSG(IBACT,"Program Error "_IBERR)
 Q 0
 ;
PLUS(IBDT,IBDAYS) N X,X1,X2,%H
 S X1=IBDT,X2=IBDAYS
 D C^%DTC
 Q X
 ;
 ; Send error message to IB MEANS TEST group.
 ; "Please review the IB ACTION"
ERRMSG(IBACT,IBERR) N IBTXT,XMSUB,XMY,XMDUZ,XMTEXT,XMGROUP,DIFROM,IBGRP,IBI,DFN,IBPT,IBZ,IBC,IBDT,IBATYP
 S XMSUB="IB GMT CLEAN-UP ERROR"
 S XMDUZ="PATCH IB*2.0*202 POST-INIT"
 S XMGROUP=$$GET1^DIQ(350.9,"1,",.11) ; Means Test billing Group
 I XMGROUP="" S XMGROUP=DUZ ; No billing groups defined - send to the user
 E  S XMGROUP="G."_XMGROUP
 S XMTEXT="IBTXT(",XMY(XMGROUP)=""
 ;
 S IBZ=$G(^IB(IBACT,0))
 S DFN=$P(IBZ,U,2),IBPT=$P($G(^DPT(DFN,0)),U)
 S IBDT=$P(IBZ,U,14),IBATYP=+$P(IBZ,U,3)
 S IBC=0
 S IBC=IBC+1,IBTXT(IBC)="The Geographic Means Test software failed to process the Inpatient Means Test"
 S IBC=IBC+1,IBTXT(IBC)="charge IEN "_IBACT_", placed on HOLD - RATE (or Incomplete) after the GMT Effective Date."
 S IBC=IBC+1,IBTXT(IBC)=" "
 S IBC=IBC+1,IBTXT(IBC)="The error occurred when trying to pass the charge to Accounts Receivable."
 S IBC=IBC+1,IBTXT(IBC)="Please review the IB ACTION IEN "_IBACT_"."
 S IBC=IBC+1,IBTXT(IBC)=" "
 I $G(IBERR)'="" D
 . S IBC=IBC+1,IBTXT(IBC)="Error code: "_IBERR
 . S IBC=IBC+1,IBTXT(IBC)=" "
 S IBC=IBC+1,IBTXT(IBC)="DIAGNOSTIC INFORMATION:"
 S IBC=IBC+1,IBTXT(IBC)="Patient: "_IBPT
 S IBC=IBC+1,IBTXT(IBC)="IB Action IEN: "_IBACT_", Date billed from: "_$$DAT($P(IBZ,"^",14))_", Date billed to: "_$$DAT($P(IBZ,"^",15))
 S IBC=IBC+1,IBTXT(IBC)="IB Action Type: "_$E($$ACTNM^IBOUTL(IBATYP),1,30)
 S IBC=IBC+1,IBTXT(IBC)="Total Charge Amount: "_$J($P(IBZ,U,7),"",2)_", The charge is "_$S($P(IBZ,U,21):"",1:"not ")_"marked as GMT Related."
 I '$P(IBZ,U,21),IBDT'<$$GMTEFD^IBAGMT(),$$ISGMTTYP^IBAGMT(IBATYP),$$ISGMTPT^IBAGMT(DFN,IBDT)>0 D
 . S IBC=IBC+1,IBTXT(IBC)="The amount must be decreased to 20% of initial value (GMT rate)."
 . I '$P(IBZ,U,21) S IBC=IBC+1,IBTXT(IBC)="The charge is supposed to be GMT Related."
 ;
 D ^XMD
 Q
 ;
 ;
DAT(IBDT) ; Convert FM date to (mm/dd/yy) format.
 I 'IBDT Q ""
 Q $$FMTE^XLFDT(IBDT,"2MZ")
 ;
NOW() N %,%H,%I,X,Y
 D NOW^%DTC S Y=%
 D DD^%DT
 S Y=$P(Y,"@")_" at "_$P(Y,"@",2)
 Q Y
 ;
PRNMSG ;
 N IBTXT
 S IBTXT(1)=""
 S IBTXT(2)="  Geographic Means Test, IB Part 3, Post-Install Starting"
 S IBTXT(3)=""
 S IBTXT(4)="  The procedure will find, adjust and bill all remaining"
 S IBTXT(5)="  GMT-related IB charges, placed on hold since 10/1/2002,"
 S IBTXT(6)="  because of unknown rate."
 S IBTXT(7)=""
 S IBTXT(8)="  The process will take some time ..."
 S IBTXT(9)=""
 D MES^XPDUTL(.IBTXT)
 Q
