IB20P402 ;ALB/CXW - SPECIALTY CODE IN FILE #399;09-SEP-08
 ;;2.0;INTEGRATED BILLING;**402**;21-MAR-94;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
POST ;
START N U S U="^"
 D BMES^XPDUTL("Add the specialty code to file (#399), Post-Install Starting")
ADD ;
 ;add the specialty to Field ID .08/subfile 399.0222
 ;the bill status is 1 - entered/not reviewed
 N DA,DA2,BILL,NUM,PRV,REC,SPEC,IBDT
 S DA=0,NUM=0
 F  S DA=$O(^DGCR(399,DA)) Q:'DA  I $P($G(^DGCR(399,DA,0)),U,13)=1 D
 . S DA2=0,BILL=$P($G(^DGCR(399,DA,0)),U)
 . F  S DA2=$O(^DGCR(399,DA,"PRV",DA2)) Q:'DA2  D
 .. L +^DGCR(399,DA):1 I '$T D MES^XPDUTL("*7 ANOTHER USER IS EDITING BILL# "_BILL) Q
 .. S REC=$G(^DGCR(399,DA,"PRV",DA2,0))
 .. S PRV=$P(REC,U,2),IBDT=$P($G(^DGCR(399,DA,"U")),U)
 .. S SPEC=$$SPEC^IBCEU(PRV,IBDT)
 .. I $P(REC,U,8)="",SPEC'="" D
 ... S $P(^DGCR(399,DA,"PRV",DA2,0),U,8)=SPEC
 ... I PRV'["IBA(355.93" S PRV=$P($G(^VA(200,+PRV,0)),U)
 ... I PRV["IBA(355.93" S PRV=$P($G(^IBA(355.93,+PRV,0)),U)
 ... D MES^XPDUTL("Specialty Code "_SPEC_" for provider "_PRV_" added to bill# "_BILL)
 ... S NUM=NUM+1
 .. L -^DGCR(399,DA)
 D BMES^XPDUTL("Total "_NUM_$S(NUM=1:"bill has",1:" bills have")_" been updated")
 ;
FINISH ;
 D BMES^XPDUTL("Add the specialty code to file (#399), Post-Install Complete")
 Q
 ;
