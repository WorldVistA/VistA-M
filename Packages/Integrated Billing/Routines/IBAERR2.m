IBAERR2 ;ALB/AAS - RX COPAY EXEMPTION ERROR PROCESSOR ; 15-JAN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**26,34**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ; -- medication copayment exemtpion errors
 Q:'$G(IBEXERR)!('$G(IBWHER))!('$G(IBJOB))
 ;
 N IBP,IBALERT
 S IBP=$$PT^IBEFUNC(DFN)
 I $$ALERT^IBAUTL7 S IBALERT=IBEXERR+10 D SEND^IBAERR3 G BQ
 D BULL
BQ Q
 ;
BULL ; -- send bulletin
 ;
 S XMSUB="Medication Copayment Exemption Error"
 S IBT(1)="The following Medication Copayment Exemption error occured"
 S IBT(2)="during the "_$P($T(JOB+(IBJOB-10)),";;",2)
 S IBT(3)=$P($T(WHERE+(IBWHER-10)),";;",2)
 S IBT(4)=""
 ;
 S IBT(5)="       Patient: "_$E($P(IBP,"^")_"               ",1,25)_"  PT. ID: "_$P(IBP,"^",2)
 I '$D(IBEVTP) N IBEVTP S IBEVTP=$$LST^IBARXEU0(DFN,DT)
 S IBT(6)="Current Status: "_$E($$TEXT^IBARXEU0($P(IBEVTP,"^",4))_"    ",1,10)_" - "_$P($G(^IBE(354.2,+$P(IBEVTP,"^",5),0)),"^")
 S IBT(7)=""
 S IBT(8)="    by: "_$P($G(^VA(200,DUZ,0)),"^")
 S Y=DT D D^DIQ S IBT(9)="    on: "_$P(Y,"@")
 S IBT(10)=""
 S IBT(11)="The following error occured:"
 S IBT(12)=$P($T(ERR+IBEXERR),";;",2)
 I IBEXERR=3 S IBT(12)=IBT(12)_"  (actual format was "_$S($G(IBDT)="":"<null>",1:IBDT)_")"
 S IBT(13)=""
 S IBT(14)="Use option Manually Change Copay Exemption (Hardships)"
 S IBT(15)="to verify exemption status."
 D SEND
BULLQ Q
 ;
SEND S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="IBT("
 K XMY S XMN=0
 S XMY(DUZ)=""
 S IBGRP=$P(^IBE(350.9,1,0),"^",9)
 F IBI=0:0 S IBI=$O(^XMB(3.8,+IBGRP,1,"B",IBI)) Q:'IBI  S XMY(IBI)=""
 D ^XMD
 K X,Y,IBI,IBT,IBGRP,XMDUZ,XMTEXT,XMY,XMSUB,XMZ
 Q
 ;
JOB ;;
 ;;Medication Copayment Installation/Conversion Process
 ;;Automated Exemption Link to Income Tests
 ;;Manual Update/Hardship exemption option
 ;;Automated Exemption Creation during Copay Billing
 ;;Print/Verify Medication Copayment Exemption Option
 ;;Automated Exemption Link to Patient Eligibility data
 ;;Update of Exemptions based on Prior Year Income
 ;;
WHERE ;;
 ;;while attempting to add a patient to the Billing Patient File.
 ;;while attempting to add a Billing Exemption.
 ;;from the automated exemption link to the Income tests.
 ;;while updating the current exemption status.
 ;;while inactivating an exemption record.
 ;;while looping thorough entries.
 ;;while processing in Accounts Receivable.
 ;;
ERR ;;
 ;;Entry locked by another user.
 ;;Failed to add patient to Billing Patient file.
 ;;Date in incorrect format.
 ;;Failed to add exemption record to Billing Exemptions file.
 ;;Failed while updating exemption record.
 ;;Failed while updating current exemption status
 ;;Failed while inactivating old exemption status
 ;;Failed to add exemption.  User not defined
 ;;Failed to add Patient to Billing Patient file, entry locked.
 ;;Failed during processing of decrease adjustment or refund.
