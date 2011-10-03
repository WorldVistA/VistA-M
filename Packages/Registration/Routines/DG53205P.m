DG53205P ;ALB/JDS - Patch 205 postinit ; Nov 16 1998
 ;;5.3;Registration;**205**;Aug 13, 1993
 ;go through inconsistency file and redo ones with Income
 ;Inconsistency
 N DG205CNT,DFN,XPDIDTOT,DGPER D MES^XPDUTL("Reviewing Income Data Inconsistency Errors") S XPDIDTOT=$P($G(^DGIN(38.5,0)),U,4),DG205CNT=0,DGPER=XPDIDTOT\100+1
 F DFN=0:0 S DFN=$O(^DGIN(38.5,DFN)) Q:'DFN  S DG205CNT=DG205CNT+1 D:'(DG205CNT#DGPER) UPDATE^XPDID(DG205CNT) I $D(^DGIN(38.5,DFN,"I",55)) D ^DGRPC
