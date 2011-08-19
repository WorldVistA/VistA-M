IBAERR ;ALB/AAS - INTEGRATED BILLING ERROR PROCESSING ROUTINE ; 14-FEB-91
 ;;2.0; INTEGRATED BILLING ;**7,70,347**; 21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
% ;  -error processor
 ;
 ; Quit if the Means Test Nightly Compilation or Discharge job called
 ; routine IBR directly.
 Q:$G(IBJOB)=1!($G(IBJOB)=2)
 ;
 ; If Means Test charge, divert control to routine IBAERR1.
 I $D(IBNOS),$P($G(^IB(+IBNOS,0)),"^",16) S IBY=Y G ^IBAERR1
 ;
 ; -- If copay exemption divert control to routine IBAERR2
 I $D(IBEXERR) G ^IBAERR2
 ;
 I $D(ZTQUEUED) D BULL G END
 G:+Y>0 END
 S X2=$P(Y,"^",2) F K=1:1 S X=$P(X2,";",K) Q:X=""  S X1=$O(^IBE(350.8,"AC",X,0)) I $D(^IBE(350.8,+X1,0)) S X3="E"_$P(^(0),"^",5) D @X3
 I $P(Y,"^",3)]"" W !,$P(Y,"^",3)
END K VA,VADM,VAERR
 Q
 ;
E1 W !,$P(^IBE(350.8,+X1,0),"^",2)
 Q
 ;
E2 ;
 Q
E3 ; -- Send no service bulletin
 K XMY,IBTXT
 S XMSUB="INTEGRATED BILLING BACKGROUND ERROR",XMDUZ="INTEGRATED BILLING PACKAGE"
 S IBTXT(1)="Processing of Pharmacy co-pay entries in Integrated Billing has"
 S IBTXT(2)="Stopped.",IBTXT(3)=" "
 S IBTXT(4)="The Pharmacy Service Pointer does not match any entries in the "
 S IBTXT(5)="IB ACTION TYPE file."
 S IBTXT(6)=" "
 S IBTXT(7)="Immediate action required."
 S IBTXT(8)="Check the IB SERVICE/SECTION in File #59."
 S IBTXT(9)="It must match the SERVICE field for pharmacy action types in the "
 S IBTXT(10)="IB ACTION TYPE file.  (internal entry number 1 is checked)"
 D SEND
 Q
 ;
E4 ; -- send missing number of days charges held bulletin
 K XMY,IBTXT
 S XMSUB="INTEGRATED BILLING BACKGROUND ERROR",XMDUZ="INTEGRATED BILLING PACKAGE"
 S IBTXT(1)="The nightly job to auto-release patient charges on hold did not run."
 S IBTXT(2)="The NUMBER OF DAYS PT CHARGES HELD field of the IB SITE PARAMETERS"
 S IBTXT(3)="file is blank."
 S IBTXT(4)=" "
 S IBTXT(5)="Immediate action required.  Select the option 'MCCR Site Parameter"
 S IBTXT(6)="Display/Edit' to enter the required information."
 D SEND
 Q
 ;
BULL ;  -send error bulletin to group when error occurs in background
 ;
 K XMY,IBTXT
 S XMSUB="INTEGRATED BILLING BACKGROUND ERROR",XMDUZ="INTEGRATED BILLING PACKAGE"
 S IBTXT(1)="Processing of entries in Integrated Billing has"
 S IBTXT(2)="been suspended "_$S('$D(IBTAG):"while passing to AR the following",IBTAG=2:"while processing new/renew Rxs: ",IBTAG=3:"while canceling: ",1:"while updating:"),IBTXT(3)=" ",IBC=3
 I $D(IBSAVX)!($D(IBSAVXU)),'$D(IBNOS) D SAVX
 I $D(IBNOS) F IBI=1:1 S IBNOS1=$P(IBNOS,"^",IBI) Q:'IBNOS1  I $D(^IB(IBNOS1,0)) S IBNOD=^(0) D BD
 S IBC=IBC+1,IBTXT(IBC)=""
 S IBC=IBC+1,IBTXT(IBC)="You should determine if these co-payments have been passed to"
 S IBC=IBC+1,IBTXT(IBC)="Accounts Receivable."
 S IBC=IBC+1,IBTXT(IBC)="The following error(s) was encountered:",IBC=IBC+1,IBTXT(IBC)=""
 D ERRTXT
 S IBC=IBC+1,IBTXT(IBC)=""
 I $D(IBWHER) S IBC=IBC+1,IBTXT(IBC)=$P($T(IBWHER+IBWHER),";;",2,99)
 ;
SEND S XMTEXT="IBTXT(",XMY(DUZ)=""
 ;
 S IBGRP=$S($D(^IBE(350.9,1,0)):$P(^(0),"^",9),1:"") F IBI=0:0 S IBI=$O(^XMB(3.8,+IBGRP,1,"B",IBI)) Q:'IBI  S XMY(IBI)=""
 D ^XMD K XMSUB,XMY,XMDUZ,XMTEXT,IBTXT,IBC,IBNOD,IBNOS1,IBI
 Q
 ;
ERRTXT S X2=$P(Y,"^",2) F K=1:1 S X=$P(X2,";",K) Q:X=""  S X1=$O(^IBE(350.8,"AC",X,0)),IBC=IBC+1,IBTXT(IBC)="    "_$S($D(^IBE(350.8,+X1,0)):$P(^(0),"^",2),1:"Unknown Error")
 I $P(Y,"^",3)]"" S IBC=IBC+1,IBTXT(IBC)="    "_$P(Y,"^",3)
 Q
 ;
BD I IBI=1 S DFN=$P(IBNOD,"^",2),IBATYPN=$S($D(^IBE(350.1,$P(IBNOD,"^",3),0)):$P(^(0),"^"),1:"") D DEM
 S IBC=IBC+1,IBTXT(IBC)="   "_$E($P(IBNOD,"^")_"           ",1,14)_$E($P(IBNOD,"^",8)_"                      ",1,24)_$E($P(IBNOD,"^",11)_"            ",1,12)_"  $"_$P(IBNOD,"^",7)
 Q
DEM N X,Y D DEM^VADPT
 S IBC=IBC+1,IBTXT(IBC)=" Patient: "_VADM(1)_"   Pt. Id: "_VA("PID")_"  Type: "_IBATYPN
 Q
 ;
SAVX S IBAX=$S($D(IBSAVXU):IBSAVXU,$D(IBSAVX):IBSAVX,1:"") Q:IBAX=""
 S IBATYPN=$S('$P(IBAX,"^",3):"",$D(^IBE(350.1,$P(IBAX,"^",3),0)):$P(^(0),"^",1),1:""),DFN=$P(IBAX,"^",2) D DEM
 S IBC=IBC+1,IBTXT(IBC)=" Service: "_$S($D(^DIC(49,+IBAX,0)):$P(^(0),"^"),1:"")
 S IBC=IBC+1,IBTXT(IBC)="    User: "_$S($D(^VA(200,+$P(IBAX,"^",4),0)):$P(^(0),"^"),$D(^VA(200,+DUZ,0)):$P(^(0),"^"),1:"")
 S IB="" F  S IB=$O(IBSAVX(IB)) Q:IB=""  D
 .K IBARXN I +$P(IBSAVX(IB),"^",1)=52 S IBARXN="Rx# "_$$FILE^IBRXUTL(+$P($P(IBSAVX(IB),"^"),":",2),.01) I $P($P(IBSAVX(IB),"^"),";",2)'="" S IBARXN=IBARXN_"/Refill# "_$P($P($P(IBSAVX(IB),"^"),";",2),":",2)
 .S IBC=IBC+1,IBTXT(IBC)="   Entry: "_$S($D(IBARXN):IBARXN,1:$P(IBSAVX(IB),"^",1)) K IBARXN
 S IB="" F  S IB=$O(IBSAVXU(IB)) Q:IB=""  S IBC=IBC+1,IBTXT(IBC)="  Ref No: "_$S($D(^IB(+IB,0)):$P(^(0),"^"),1:"")
 Q
 ;
1 S Y="-1^IB001" Q  ;patient eligibility data not calculated
 Q
IBWHER ;
 ;;Error occurred before Integrated Billing entry created, Reprint labels or       recancel after correcting error.
 ;;Error occurred after Integrated Billing entry created but Accounts Receivable   not updated.
 ;;Error occurred during posting to Accounts Receivable.  Check to see if amount  passed!
 ;;Error occurred after successful passing of charges to AR, IB entry may not be   properly updated.
 ;;Error occurred during eligibility determination for Co-pay.
