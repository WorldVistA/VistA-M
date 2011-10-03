IBAMTBU1 ;ALB/CPM - MEANS TEST BILLING BULLETINS (CON'T.) ; 09-APR-92
 ;;2.0;INTEGRATED BILLING;**153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
OE ; Send bulletin when a Means Test copay vet, admitted for Observation
 ; and Examination, is discharged, but has previously been billed
 ; copayment and per diem charges.
 ;   Input: DGPMA, DFN, DUZ
 ;
 K IBT
 S IBPT=$$PT^IBEFUNC(DFN)
 S XMSUB=$E($P(IBPT,"^"),1,14)_"  "_$P(IBPT,"^",3)_" - O&E DISCHARGE"
 S IBT(1)="The following patient, admitted for Observation & Examination,"
 S IBT(2)="has been discharged:"
 S IBT(3)=" ",IBC=3
 S IBDUZ=DUZ D PAT^IBAERR1
 S IBC=IBC+1,IBT(IBC)=" "
 S Y=$P(DGPMA,"^") D DD^%DT
 S IBC=IBC+1,IBT(IBC)="Disc Date: "_Y
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="This patient has already been charged Means Test copayment and per diem"
 S IBC=IBC+1,IBT(IBC)="charges. The Integrated Billing 'event' action has automatically been"
 S IBC=IBC+1,IBT(IBC)="closed. All Means Test charges for this admission must be manually"
 S IBC=IBC+1,IBT(IBC)="cancelled, and the patient's billing clock must be manually adjusted."
 G SEND^IBAMTBU ; deliver message and quit.
 ;
 ;
DISP ; Build before/after values, instructions for movement bulletins.
 I $D(IBVAL(1)) D
 .S IBC=IBC+1,IBT(IBC)="*** The Facility Treating Specialty was changed ***"
 .S IBC=IBC+1,IBT(IBC)=" Old Value: "_$S(IBVAL(1):$P($G(^DIC(45.7,+IBVAL(1),0)),"^"),1:" No value")
 .I $P(IBVAL(1),"^",2) S IBC=IBC+1,IBT(IBC)=$J("",12)_"(Billable Bedsection: "_$S($D(^DGCR(399.1,+$P(IBVAL(1),"^",2),0)):$P(^(0),"^"),1:"Unknown")_")"
 .S IBC=IBC+1,IBT(IBC)=" New Value: "_$S($P(IBVAL(1),"^",3):$P($G(^DIC(45.7,+$P(IBVAL(1),"^",3),0)),"^"),1:" No value")
 .I $P(IBVAL(1),"^",4) S IBC=IBC+1,IBT(IBC)=$J("",12)_"(Billable Bedsection: "_$S($D(^DGCR(399.1,+$P(IBVAL(1),"^",4),0)):$P(^(0),"^"),1:"Unknown")_")"
 .S IBC=IBC+1,IBT(IBC)=" "
 I $D(IBVAL(2)) D
 .S IBC=IBC+1,IBT(IBC)="*** The "_$S(IBMTYP=6:"Treating Specialty",1:"Movement")_" Date was changed ***"
 .S IBC=IBC+1,IBT(IBC)=" Old Value: "_$S(IBVAL(2):$$DAT2^IBOUTL(+IBVAL(2)),1:" No Value")
 .S IBC=IBC+1,IBT(IBC)=" New Value: "_$S($P(IBVAL(2),"^",2):$$DAT2^IBOUTL($P(IBVAL(2),"^",2)),1:" No Value")
 .S IBC=IBC+1,IBT(IBC)=" "
 ;
 ; - set up instructions
 S IBC=IBC+1,IBT(IBC)="Means Test charges have been billed for this episode of care."
 I IBMTYP=3,DGPMA="" S IBC=IBC+1,IBT(IBC)="Please review these charges and use the Cancel/Edit/Add Patient Charges option",IBC=IBC+1,IBT(IBC)="to re-open the event record, if necessary, so that billing may resume." Q
 S IBC=IBC+1,IBT(IBC)="Please review these charges and"_$S(IBMTYP=1&(DGPMA=""):"",1:" edit or")_" cancel any charges if necessary."
 Q
