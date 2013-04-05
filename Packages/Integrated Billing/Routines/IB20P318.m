IB20P318 ;ALB/ARH - IB*2.0*318 POST INIT: ADD BILLABLE APPT TYPE ; 23-JUN-2005
 ;;2.0;INTEGRATED BILLING;**318**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 Q
 ;
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*318 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 D ATADD ; Add New Billable Appointment Type
 ;
 S IBA(1)="",IBA(2)="    IB*2*318 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 ;
 Q
 ;
 ;
 ;
ATADD ; New Billable Appointment Type (352.1) to correspond to the New 'SERVICE CONNECTED' Appointment Type (409.1)
 N DD,DO,DLAYGO,DINUM,DIC,DIE,DA,DR,X,Y,IBA,IBFOUND,IBATFN,IBNUM,IBAT,IBFN
 ;
 S IBA(1)="      >> Adding 'Service Connected' Billable Appointment Type (#352.1)"
 ;
 S (IBATFN,IBNUM)=11,IBAT="SERVICE CONNECTED"
 ;
 S IBFOUND=$G(^IBE(352.1,IBATFN,0))
 ;
 I $P(IBFOUND,U,1,3)="11^11^2880101" D MSG("         Done.  Billable Appointment Type Already Exists") G ATADDQ
 I IBFOUND'="" D MSG(" "),MSG("     *** ERROR: Entry already Exists, could not add") G ATADDQ
 I +$O(^IBE(352.1,"B",IBNUM,0)) D MSG(" "),MSG("     *** ERROR: Number already Exists, could not add") G ATADDQ
 ; 
 K DD,DO S DINUM=IBATFN,DLAYGO=352.1,DIC="^IBE(352.1,",DIC(0)="L",X=IBATFN D FILE^DICN K DIC S IBFN=+Y
 I Y<1 K X,Y D MSG(" "),MSG("     *** ERROR: New Entry could not be added") G ATADDQ
 ;
 S DR=".02///"_IBAT_";.03////2880101;.04///NO;.05///YES;.06///YES"
 S DIE="^IBE(352.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
 D MSG("         Done. Service Connected Billable Appointment Type Added")
 ;
ATADDQ D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;
MSG(X) ;
 N IBX S IBX=$O(IBA(999999),-1) S:'IBX IBX=1 S IBX=IBX+1
 S IBA(IBX)=$G(X)
 Q
