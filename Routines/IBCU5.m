IBCU5 ;ALB/AAS - MCCR MAILING ADDRESS UTILITY ROUTINE ;26-FEB-90
 ;;2.0;INTEGRATED BILLING;**8,52,80,117,51,206**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRU5
 ;
EN ;Entry from X-REF from who's responsible
 ;doesn't set primary insurance field, must be second trigger.
 S X=$P(^DGCR(399,DA,0),"^",11)
 I X="p" D MAILP G ENQ
 I X="o" S DGTAG=$S('$D(^DGCR(399,DA,"M")):"MAILP",'$P(^("M"),"^",11):"MAILP",'$D(^DIC(4,$P(^("M"),"^",11),0)):"MAILP",1:"MAILIN") D @DGTAG G ENQ
 I X="i",+$G(^DGCR(399,DA,"MP")) D MAILA G ENQ
ENQ K DGTAG Q
 ;
EN1 ;Now Trigger of primary insurance policy from who's responsible
 ;if only one active policy
 ;; old Trigger of primary insurer from who's responsible
 ;Only should be called if primary insurer is null (condition of trigger)
 ;return ifn of insurer in X
 ;
 S X=""
 I $S('$D(IBAC):1,IBAC=6:1,1:0) Q
 ;
 S IBINDT=$S($G(IBIDS(151)):IBIDS(151),$P($G(^DGCR(399,DA,"U")),"^"):$P($G(^DGCR(399,DA,"U")),"^"),1:DT)
 D ALL^IBCNS1(DFN,"IBDD",2,IBINDT)
 I $G(IBDD(0))=1 S X=+$O(IBDD(0)) G EN1Q
 ;
 ;S IBOUTP=1,IBINDT=$S($G(IBIDS(151)):IBIDS(151),$P($G(^DGCR(399,DA,"U")),"^"):$P($G(^DGCR(399,DA,"U")),"^"),1:DT)
 ;D ^IBCNS I IBINS S X=IBDD($O(IBDD(0))) S:$O(IBDD(+X)) X="" S X=$S($D(^DIC(36,+X,0)):+X,1:"") G EN1Q
 S X=""
EN1Q K IBDD,IBINS,IBIN Q
 ;
MAILA ;Store Mailing Address for Bill Payer Carrier (and if not copying  bill or bill not authorized,
 ; insert Attending Physican Id [36,.1] into Form Locator 92 [399,213]
 ;
 S DA=$S('$D(DA):IBIFN,DA']"":IBIFN,1:DA)
 G MAILQ:$P(^DGCR(399,DA,0),U,11)="p" ; Patient is responsible for bill
 G MAILQ:$P(^DGCR(399,DA,0),U,11)="o" ; Other party is responsible for bill
 ;
 S IB01=+$G(^DGCR(399,DA,"MP"))
 G MAILQ:'$D(^DIC(36,+IB01,0)) ; Bad insurance data
 ;
 S IB02=$$ADD^IBCNADD(DA)
 ;
 D UPDMA(DA,IB01,IB02)
 ;
 I '$D(IBCAN)!($G(IBAC)<3) S $P(^DGCR(399,DA,"U1"),U,13)=$P($G(^DIC(36,+IB01,0)),U,10)
 ;
MAILQ K IB01,IB02,IB03 Q
 ;
UPDMA(DA,IB01,IB02) ; Update insurance company mailing address in file 399
 ; DA = bill ifn
 ;IB02 = string returned from call to ADD^IBCNADD
 ;IB01 = insurance company ifn
 S $P(^DGCR(399,DA,"M"),"^",4,9)=$E($P($G(^DIC(36,+IB01,0)),"^",1),1,30)_"^"_$P(IB02,"^",1)_"^"_$P(IB02,"^",2)_"^"_$P(IB02,"^",4)_"^"_$P(IB02,"^",5)_"^"_$P(IB02,"^",6)
 ;
 ; -- if send bill to employer, piece 7 = name
 I $P(IB02,"^",8)'="",+$P(IB02,"^",8)'=$P(IB02,"^",8) S $P(^DGCR(399,DA,"M"),"^",4)=$P(IB02,"^",8)
 ;
 S $P(^DGCR(399,DA,"M1"),U,1)=$P(IB02,U,3)
 Q
 ;
MAILIN ;Store Mailing Address for Institution
 S DA=$S('$D(DA):IBIFN,DA']"":IBIFN,1:DA),X=$P(^DGCR(399,DA,"M"),"^",11) G:X']"" MAILINQ G:'$D(^DIC(4,X,0)) MAILINQ
 S IB01=^DIC(4,X,0),IB02=$S($D(^(1)):^(1),1:"")
 S $P(^DGCR(399,IBIFN,"M"),"^",4,9)=$P(IB01,U,1)_"^"_$P(IB02,U,1)_"^"_$P(IB02,U,2)_"^"_$P(IB02,U,3)_"^"_$P(IB01,U,2)_"^"_$TR($P(IB02,U,4),"-")
 S $P(^DGCR(399,IBIFN,"M1"),"^",1)=""
MAILINQ K IB01,IB02,IB03 Q
 ;
MAILP ;Store Patient Mailing address
 N DFN,VAPA,DGNAM,IBCONF
 S DA=$S('$D(DA):IBIFN,DA']"":IBIFN,1:DA)
 S DFN=$P(^DGCR(399,DA,0),"^",2),VAPA("P")="" D DEM^VADPT,ADD^VADPT
 S IBCONF=$S('$G(VAPA(12)):0,$P($G(VAPA(22,3)),U,3)'="Y":0,1:1) ; Confidential Address
 S DGNAM=$P(VADM(1),",",2)_" "_$P(VADM(1),",",1)
 S DGNAM=$S($E(VADM(5))'="F":"MR.",'$D(^DIC(11,+$P(^DPT(DFN,0),"^",5),0)):"MS.","DMW"[$E(^DIC(11,$P(^DPT(DFN,0),"^",5),0)):"MRS.",1:"MS.")_DGNAM
 S $P(^DGCR(399,DA,"M"),"^",4)=DGNAM
 I IBCONF D  ; use conf. address for mailing
 . S $P(^DGCR(399,DA,"M"),"^",5,9)=VAPA(13)_"^"_VAPA(14)_"^"_VAPA(16)_"^"_+VAPA(17)_"^"_$P(VAPA(18),U,1)
 . S $P(^DGCR(399,DA,"M1"),"^",1)=VAPA(15)
 I 'IBCONF D
 . S $P(^DGCR(399,DA,"M"),"^",5,9)=VAPA(1)_"^"_VAPA(2)_"^"_VAPA(4)_"^"_+VAPA(5)_"^"_$P(VAPA(11),U,1)
 . S $P(^DGCR(399,DA,"M1"),"^",1)=VAPA(3)
MAILPQ Q
 ;
INSUR ;
 Q
DEL S $P(^DGCR(399,DA,"M"),"^",4,9)="^^^^^",$P(^("M1"),"^",1)=""
 Q
