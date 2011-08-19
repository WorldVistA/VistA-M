IBAERR1 ;ALB/CPM - INTEGRATED BILLING ERROR PROCESSING ROUTINE (CON'T) ; 03-JAN-92
 ;;2.0;INTEGRATED BILLING;**15,133,153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine will be used to send mail messages when errors
 ; have occurred during the processing of Means Test charges.
 ;  Input:  IBJOB = 1  Nightly Compilation job
 ;                  2  Discharge job
 ;                  4  Add/Edit/Cancel Charges
 ;                  5  Appointment Event Driver
 ;                  7  Means Test Event Driver
 ;                  8  OPT Billing Update
 ;                  9  IVM Back-Billing job
 ;          DFN {opt}, IBDUZ, IBY, IBWHER
 ;
 N IBSTART K IBT
 I $D(DFN)#2 S IBPT=$$PT^IBEFUNC(DFN)
 I '$G(IBJOB) S IBJOB=5 ; if MT charge entered thru Appt Event Driver uses filer so IBJOB not set,see EN2^IBAMTS2
 S XMSUB=$S($D(IBPT)#2:$E($P(IBPT,"^"),1,14)_"  "_$P(IBPT,"^",3)_" -",1:"MEANS TEST BILLING")_" ERROR ENCOUNTERED"
 S IBT(1)="An error has been encountered while processing Means Test charges"
 S IBT(2)="during the "_$P($T(JOB+IBJOB),";;",2,99)_" for the following patient:"
 S IBT(3)=" ",IBC=3
 D PAT
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="The Means Test billing history for this patient must be reviewed."
 S IBC=IBC+1,IBT(IBC)="The following error was encountered:"
 S IBC=IBC+1,IBT(IBC)=" "
 S:IBJOB=4 IBSTART=IBC D ERR
 S IBC=IBC+1,IBT(IBC)=" "
 S IBM=$P($T(TEXT+IBWHER^IBAMTEL),";;",2,99),IBC=IBC+1
 S:$L(IBM)<80 IBT(IBC)=IBM
 I $L(IBM)>79 S IBB=$E(IBM,1,79),IBT(IBC)=$P(IBB," ",1,$L(IBB," ")-1),IBC=IBC+1,IBT(IBC)=$P(IBM," ",$L(IBB," "),999)
 I IBJOB=4 F IBI=IBSTART:1:IBC W !,IBT(IBI)
 D MAIL K IBT,IBM,IBB,IBC,IBPT,XMSUB,XMY,XMTEXT,XMDUZ
 Q
 ;
PAT ; Set up patient demographic and user data for message.
 S IBC=IBC+1,IBT(IBC)="  Patient: "_$S($D(IBPT)#2:$P(IBPT,"^")_"          Pt. ID: "_$P(IBPT,"^",2),1:"Not Defined")
 S IBC=IBC+1,IBT(IBC)="     User: "_$P($G(^VA(200,+IBDUZ,0)),"^")
 Q
 ;
ERR ; Set up error message text.
 S X2=$P(IBY,"^",2) F K=1:1 S X=$P(X2,";",K) Q:X=""  D
 . S X1=$O(^IBE(350.8,"AC",X,0)),IBC=IBC+1
 . S IBT(IBC)=" "_$S($D(^IBE(350.8,+X1,0)):$P(^(0),"^",2),X]"":X,1:"Unknown Error")
 I $P(IBY,"^",3)]"" S IBC=IBC+1,IBT(IBC)=" "_$P(IBY,"^",3)
 K X,X1,X2 Q
 ;
MAIL ; Transmit.
 N IBI,IBGRP S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="IBT("
 K XMY
 ;S IBGRP=$P($G(^IBE(350.9,1,0)),"^",11)
 ;F IBI=0:0 S IBI=$O(^XMB(3.8,+IBGRP,1,"B",IBI)) Q:'IBI  S XMY(IBI)=""
 S IBGRP=$P($G(^XMB(3.8,+$P($G(^IBE(350.9,1,0)),"^",11),0)),"^")
 I IBGRP]"" S XMY("G."_IBGRP_"@"_^XMB("NETNAME"))=""
 D ^XMD
 Q
 ;
JOB ; Job Descriptions
 ;;Nightly Compilation job
 ;;Discharge job
 ;;<Undefined job #3>
 ;;Cancel/Edit/Add Option
 ;;Check Out job
 ;;<Undefined job #6>
 ;;Means Testing
 ;;OPT Billing Update
 ;;IVM Back-Billing job
