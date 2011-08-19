IBACVA2 ;ALB/CPM - BULLETINS FOR CHAMPVA BILLING ; 29-JUL-93
 ;;2.0;INTEGRATED BILLING;**27,52,240**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ERRMSG(IBIND,IBMSG) ; Process CHAMPVA/TRICARE Error Messages.
 ;  Input:    IBIND  --  1=>billing 0=>canceling
 ;            IBMSG  --  1=>CHAMPVA msg 2=> TRICARE msg
 K IBT S IBPT=$$PT^IBEFUNC(DFN)
 S IBMSGT=$S($G(IBMSG)=1:"CHAMPVA inpatient subsistence",1:"TRICARE Pharmacy copayment")
 S XMSUB=$E($P(IBPT,"^"),1,14)_"  "_$P(IBPT,"^",3)_" - ERROR ENCOUNTERED"
 S IBT(1)="An error occurred while "_$S($G(IBIND):"billing",1:"cancelling")_" the "_IBMSGT_" charge"
 S IBT(2)=$S($G(IBIND):"to",1:"for")_" the following patient:"
 S IBT(3)=" " S IBC=3
 S IBDUZ=DUZ D PAT^IBAERR1
 ;S Y=+DGPMA D DD^%DT
 ;S IBC=IBC+1,IBT(IBC)="Disc Date: "_Y
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="The following error was encountered:"
 S IBC=IBC+1,IBT(IBC)=" "
 D ERR^IBAERR1
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="Please review the circumstances surrounding this error and use the"
 S IBC=IBC+1,IBT(IBC)="Cancel/Edit/Add Patient Charges' option to bill or cancel any necessary"
 S IBC=IBC+1,IBT(IBC)="charges."
 D SEND
 Q
 ;
ADM ; Send a bulletin when CHAMPVA patients are admitted.
 K IBT S IBPT=$$PT^IBEFUNC(DFN)
 S XMSUB=$E($P(IBPT,"^"),1,14)_"  "_$P(IBPT,"^",3)_" - CHAMPVA PATIENT"
 S IBT(1)="The following CHAMPVA patient has been admitted:"
 S IBT(2)=" ",IBC=2
 S IBDUZ=DUZ D PAT^IBAERR1
 S Y=+DGPMA D DD^%DT
 S IBC=IBC+1,IBT(IBC)=" Adm Date: "_Y
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="This patient will be automatically billed the CHAMPVA inpatient"
 S IBC=IBC+1,IBT(IBC)="subsistence charge when discharged."
 D SEND
 Q
 ;
WARN(IBB,IBE) ; Send bulletins when discharges are edited or deleted.
 ;  Input:    IBB  --  Discharge date before edit
 ;            IBE  --  Discharge date after edit
 K IBT S IBPT=$$PT^IBEFUNC(DFN)
 S XMSUB=$E($P(IBPT,"^"),1,14)_"  "_$P(IBPT,"^",3)_" - DISCHARGE CHANGED"
 S IBT(1)="A discharge was "_$S($G(IBE):"edited",1:"deleted")_" for the following CHAMPVA patient:"
 S IBT(2)=" " S IBC=2
 S IBDUZ=DUZ D PAT^IBAERR1
 S IBC=IBC+1,IBT(IBC)=" "
 I $G(IBE) D
 .S Y=IBB D DD^%DT S IBC=IBC+1,IBT(IBC)="Prev Discharge Date: "_Y
 .S Y=IBE D DD^%DT S IBC=IBC+1,IBT(IBC)=" New Discharge Date: "_Y
 .S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="Please review the circumstances surrounding these movement changes,"
 S IBC=IBC+1,IBT(IBC)="and use the 'Cancel/Edit/Add Patient Charges' option to bill or cancel"
 S IBC=IBC+1,IBT(IBC)="any necessary charges."
 D SEND
 Q
 ;
DEL(DFN,IBN,IBADM) ; Send bulletins when billed admissions are deleted.
 ;  Input:    DFN  --  Pointer to the patient in file #2
 ;            IBN  --  Pointer to the cancelled charge in file #350
 ;          IBADM  --  Admission date/time
 K IBT S IBPT=$$PT^IBEFUNC(DFN)
 S XMSUB=$E($P(IBPT,"^"),1,14)_"  "_$P(IBPT,"^",3)_" - ADMISSION DELETED"
 S IBT(1)="A billed admission for the following CHAMPVA patient was deleted:"
 S IBT(2)=" " S IBC=2
 S IBDUZ=DUZ D PAT^IBAERR1
 S IBC=IBC+1,IBT(IBC)=" "
 S Y=+IBADM D DD^%DT
 S IBC=IBC+1,IBT(IBC)=" Adm Date: "_Y
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="The inpatient subsistence charge for this admission has been cancelled"
 S IBC=IBC+1,IBT(IBC)="in Billing only.  You MUST decrease the receivable "_$P($G(^IB(IBN,0)),"^",11)_" down to $0"
 S IBC=IBC+1,IBT(IBC)="in the Accounts Receivable module!!"
 D SEND
 Q
 ;
SEND ; Send bulletin to recipients of the Means Test billing mailgroup.
 D MAIL^IBAERR1
 K IBC,IBT,IBPT,XMSUB,XMY,XMTEXT,XMDUZ,IBMSGT
 Q
 ;
ON() ; Is the CHAMPVA billing module fully installed?
 N X S X=+$O(^IBE(350.1,"E","CHAMPVA SUBSISTENCE",0))
 Q +$P($G(^IBE(350.1,X,0)),"^",3)
