IB20P139 ;ALB/ARH - IB*2*139 POST INIT: ADD OPT COPAY ; 25-OCT-2000
 ;;2.0;INTEGRATED BILLING;**139**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
COPAY ; Add OPT COPAY for 10/1/2000: $50.8
 N IBA,IBX
 S IBA(1)="",IBA(2)="  IB*2*139 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 S IBX=$$SETC
 I +IBX<0 S IBA(1)="    Error: "_$P(IBX,U,2),IBA(2)="",IBA(3)="    Opt Copay Rate Not Updated!",IBA(4)="",IBA(5)="    Contact Support for assistance."
 I +IBX=1 S IBA(1)="   "_$P(IBX,U,2),IBA(2)="",IBA(3)="   Run Option IB MT REL HELD (RATE) CHARGES to release charges."
 I (+IBX=0)!(+IBX=2) S IBA(1)="   "_$P(IBX,U,2),IBA(2)="",IBA(3)="   No further action required."
 ;
 D MES^XPDUTL(.IBA)
 ;
CIQ K IBA S IBA(1)="",IBA(2)="  IB*2*139 Post-Install Complete.",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
SETC() ; set Opt Copay 
 N IBFN,IBCS,IBBS,IBEFDT,IBCHG,DD,DO,DLAYGO,DIC,DIE,DR,DA,X,Y,ZTDTH,ZTRTN,ZTDESC,ZTIO,ZTSK,IBX,IBMSG
 S IBMSG="-1^Unknown error!"
 ;
 S IBCS="TL-CAT C OPT COPAY",IBCS=+$O(^IBE(363.1,"B",IBCS,0)) I 'IBCS S IBMSG="-1^TL-CAT C OPT COPAY Charge Set not found!" G SETCQ
 S IBBS=+$$MCCRUTL("OUTPATIENT VISIT",5) I 'IBBS S IBMSG="-1^OUTPATIENT VISIT Bedsection not found!" G SETCQ
 S IBEFDT=3001001
 S IBCHG=50.8
 ;
 S IBX=$O(^IBA(363.2,"AIVDTS"_IBCS,IBBS,-IBEFDT,""))
 I +IBX,$P($G(^IBA(363.2,IBX,0)),U,5)'=IBCHG S IBMSG="-1^Opt Copay Charge found with incorrect rate!" G SETCQ
 I +IBX S IBMSG="0^Opt Copay Charge already exists on your system." G SETCQ
 ;
 K DD,DO S DLAYGO=363.2,DIC="^IBA(363.2,",DIC(0)="L",X=IBBS_";DGCR(399.1," D FILE^DICN K DIC
 I Y<1 K X,Y S IBMSG="-1^Unable to Add Opt Copay to Charge Master!" G SETCQ
 S IBFN=+Y
 ;
 S DR=".02////"_IBCS_";.03////"_IBEFDT_";.05////"_IBCHG S DIE="^IBA(363.2,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 S IBMSG="1^Opt Copay updated.  "
 ;
 I +$G(XPDQUES("POS QUEUE")) D
 . S ZTDTH=$G(XPDQUES("POS QUEUE1")) Q:'ZTDTH
 . S ZTRTN="DQ^IBEMTO",ZTDESC="BILLING OF MT OPT CHARGES AWAITING NEW COPAY RATE",ZTIO=""
 . D ^%ZTLOAD
 . I $D(ZTSK) S IBMSG="2^"_$P(IBMSG,U,2)_"BILLING OF MT OPT CHARGES AWAITING NEW COPAY RATE queued."
 . I '$D(ZTSK) S IBMSG=IBMSG_"Unable to queue Release of Charges on Hold task!"
 ;
SETCQ Q IBMSG
 ;
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
