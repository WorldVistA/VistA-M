IBCBULL ;ALB/MJB - MCCR MAILMAN BULLETINS  ;14 JUN 88 15:33
 ;;2.0;INTEGRATED BILLING;**124,155**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRBULL
 ; both bulletins are sent to: billing supervisor, person cancelling/disapproving, and respective mail group, if defined
 ; disapproval bulletin is also sent to person who entered the bill
 ;
BULL S IBFTN=$P($G(^DGCR(399,+$G(IBIFN),0)),U,19),IBFTN=$$FTN^IBCU3(IBFTN)
 K XMY S XMSUB=$S($D(IBCAN):"MAS "_IBFTN_" BILL CANCELLATION BULLETIN",1:"MAS "_IBFTN_" BILL DISAPPROVAL BULLETIN"),XMDUZ=DUZ
 S IBEPAR(1)=$G(^IBE(350.9,1,1)),IB(0)=$S($D(^DGCR(399,IBIFN,0)):^(0),1:"")
 S IB("S")=$G(^DGCR(399,IBIFN,"S"))
 S DFN=$P(IB(0),U,2) D PID^VADPT6 S IBBNO=$P(IB(0),U,1),IBNAME=$P(^DPT(DFN,0),U),Y=$P(IB(0),U,3) X ^DD("DD") S IBDT=Y
 S IBTEXT(1,0)="The following "_IBFTN_" bill has been "_$S($D(IBCAN):"cancelled: ",1:"disapproved: "),IBTEXT(2,0)="",IBTEXT(3,0)="Bill Number: "_IBBNO,IBTEXT(4,0)=""
 S IBTEXT(5,0)="Patient Name: "_IBNAME_"         PT ID: "_VA("PID"),IBTEXT(6,0)="",IBTEXT(7,0)="Event Date: "_IBDT
 S:$D(IBCAN) IBTEXT(8,0)="",IBTEXT(9,0)="Reason for cancellation: "_$P(^DGCR(399,IBIFN,"S"),"^",19)
 S:$D(IBCAN) IBTEXT(10,0)="",IBTEXT(11,0)="Status when cancelled: "_$S('$D(IBSTAT):"",1:$P($P($P(^DD(399,.13,0),"^",3),IBSTAT_":",2),";",1))
 S:$D(IBTEXT(11,0)) Y=$P(IB("S"),"^",10),IBTEXT(11,0)=IBTEXT(11,0)_"  -  "_$S('Y:"Not passed to AR",1:"Passed to AR on ") I Y D D^DIQ S IBTEXT(11,0)=IBTEXT(11,0)_Y
 S:'$D(IBCAN) IBTEXT(8,0)="" F I=1:1 Q:'$D(IBD(I))  S J=8+I Q:J'<14  S IBTEXT(J,0)="Reason for disapproval: "_IBD(I)
 I '$D(IBCAN),$D(J)#2,J'<14 S IBTEXT(J,0)="",IBTEXT((J+1),0)="Other reasons too numerous to mention..."
 ;
 S XMTEXT="IBTEXT(",XMY(DUZ)="",XMY($P(IBEPAR(1),"^",8))="" S:'$D(IBCAN) XMY($P(^DGCR(399,IBIFN,"S"),"^",2))=""
 ;
 ;I $D(IBCAN),IBEPAR(1)]"",$P(IBEPAR(1),U,7)]"" S IBM="" F I=1:1 S IBM=$O(^XMB(3.8,$P(IBEPAR(1),U,7),1,"B",IBM)) Q:IBM=""  S:'$D(XMY(IBM)) XMY(IBM)=""
 I $D(IBCAN) S IBGRP=$P($G(^XMB(3.8,+$P($G(IBEPAR(1)),"^",7),0)),"^") I IBGRP]"" S XMY("G."_IBGRP_"@"_^XMB("NETNAME"))=""
 ;
 ;I '$D(IBCAN),IBEPAR(1)]"",$P(IBEPAR(1),U,9)]"" S IBM="" F I=1:1 S IBM=$O(^XMB(3.8,$P(IBEPAR(1),U,9),1,"B",IBM)) Q:IBM=""  S:'$D(XMY(IBM)) XMY(IBM)=""
 I '$D(IBCAN) S IBGRP=$P($G(^XMB(3.8,+$P($G(IBEPAR(1)),"^",9),0)),"^") I IBGRP]"" S XMY("G."_IBGRP_"@"_^XMB("NETNAME"))=""
 ;
 D ^XMD K XMSUB,XMY,XMDUZ,XMTEXT,IB,IBTEXT,IBNAME,IBGRP,IBBNO,IBD,IBDT,IBM,IBFTN,VA("BID"),VA("PID"),I,Y,DIC Q
 Q
DISAP Q:$P(^DGCR(399,IBIFN,"S"),"^",6)!('$D(IBX3))  S X3=IBX3
 I X3=3 S IBD=0 F I=1:1 S IBD=$O(^DGCR(399,IBIFN,"D1",IBD)) Q:IBD'?1N.N  S IBD(I)=^DGCR(399,IBIFN,"D1",IBD,0),IBD(I)=$S($D(^DGCR(399.4,IBD(I),0)):$P(^(0),"^",1),1:"")
 I X3=6 S IBD=0 F I=1:1 S IBD=$O(^DGCR(399,IBIFN,"D2",IBD)) Q:IBD'?1N.N  S IBD(I)=^DGCR(399,IBIFN,"D2",IBD,0),IBD(I)=$S($D(^DGCR(399.4,IBD(I),0)):$P(^(0),"^",1),1:"")
 D BULL K IBD,IBX3,X3,I Q
 Q
SET S X1=$S($D(^DGCR(399,+IBIFN,"S")):^("S"),1:""),IB("U1")=$S($D(^DGCR(399,IBIFN,"U1")):^("U1"),1:"") Q:X1']""
 ;IBCBULL
