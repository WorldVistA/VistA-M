IB20P109 ; ALB/TMP - IB*2*109 POST-INSTALL ; 03-NOV-98
 ;;2.0;INTEGRATED BILLING;**109**;21-MAR-94
 ;
POST ;Set up check points for post-init
 N %
 S %=$$NEWCP^XPDUTL("UPDFLD","UPDFLD^IB20P109")
 S %=$$NEWCP^XPDUTL("ADD3991","ADD3991^IB20P109")
 S %=$$NEWCP^XPDUTL("UPD399","UPD399^IB20P109")
 Q
 ;
UPDFLD N IBDATAEL,IBSKELTN,IBDATA,IBX,DA,DIE,DR
 ;
 D BMES^XPDUTL("Updating 3 data elements for 'bill type' on UB92 output form")
 ;
 F IBX="N-UB92 LOCATION OF CARE^78","N-UB92 BILL CLASSIFICATION^79","N-UB92 TIMEFRAME OF BILL^80" S IBDATAEL=$O(^IBA(364.5,"B",$P(IBX,U),0)) I IBDATAEL D
 . S IBSKELTN=$O(^IBA(364.6,"ASEQ",3,1,3,$P(IBX,U,2),0)) Q:'IBSKELTN
 . S IBDATA=$O(^IBA(364.7,"B",IBSKELTN,0)) Q:'IBDATA
 . I $D(^IBA(364.7,IBDATA,0)),$P(^(0),U,3)'=IBDATAEL S DR=".03////"_IBDATAEL,DIE="^IBA(364.7,",DA=IBDATA D ^DIE
 ;
 D BMES^XPDUTL("Step Complete.")
 ;
 Q
 ;
ADD3991 ; Must be completed before UPD399 step
 N IBCL,IBZ,DIC,DA,X,Y,IB3991,DO,DD,DLAYGO
 D BMES^XPDUTL("Adding new entries to the MCCR UTILITY file for UB92 BILL CLASSIFICATION")
 ;
 S IBCL(1)="SWINGBED;8;1;1^RURAL HEALTH CLINIC;1;1;7^HOSP BASED/INDEP RENL DIALYSIS;2;1;7^FREE STANDING CLINIC;3;1;7^OTHER;9;1;7,8^NON-HOSP BASED HOSPICE;1;1;8^HOSP BASED HOSPICE;2;1;8^AMB SURGERY CENTER;3;1;8"
 S IBCL(2)="INPATIENT (MEDICARE-A);1;1;1,2^HUMANIT. EMERG (INPT/MCARE-B);2;1;1,2,3^OUTPATIENT;3;1;1,2,3^HUMANIT. EMERG (OPT/ESRD);4;1;1,3"
 ;
 F IBCL=1,2 F IBZ=1:1:$L(IBCL(IBCL),U) S IB3991=$P(IBCL(IBCL),U,IBZ) I IB3991'="",'$D(^DGCR(399.1,"B",$P(IB3991,";"))) D
 . S DIC="^DGCR(399.1,",DLAYGO=399.1,DIC(0)="L",X=$P(IB3991,";")
 . S DIC("DR")=".02////"_$P(IB3991,";",2)_";.23////"_$P(IB3991,";",3)_";.24////"_$P(IB3991,";",4)
 . D FILE^DICN K DO,DD
 ;
 D BMES^XPDUTL("Step Complete.")
 Q
 ;
UPD399 ;
 N DONE,Q,Q1,S1,Z,Z0,Z1,CL,CT,%
 ;
 D BMES^XPDUTL("Updating Bill/Claims file")
 ;
 S (CT,Z)=0
 ; Extract the codes for bill classification from file 399.1
 F  S Z=$O(^DGCR(399.1,Z)) Q:'Z  S Z1=$G(^(Z,0)) I $P(Z1,U,23) S CL(+$P(Z1,U,2),","_$P(Z1,U,24)_",")=Z
 ;
 S S1=+$$PARCP^XPDUTL("U399") ;Get last bill ien processed
 ;
 F  S S1=$O(^DGCR(399,S1)) Q:'S1  S Z=$G(^DGCR(399,S1,0)) I Z'="" D
 . N DAT
 . S CT=CT+1
 . ;
 . ; Force location of care and timeframe of bill into corresponding
 . ;  new UB92 fields if new fields are null
 . F Z1=24,26 S Q=$P(Z,U,Z1) I Q="" S Q1=$P(Z,U,Z1-20) S:(Q1=0)&(Z1=26) Q1="" I Q1'="" D
 .. S DAT=$P(Z,U,Z1-20)
 .. I Z1=26,DAT="0" S DAT="O",$P(Z,U,6)="O" ;Change '0' to 'O' if found
 .. S $P(Z,U,Z1)=DAT
 . ;
 . S Q=","_$P(Z,U,4)_",",Q1=$P(Z,U,5)
 . I Q1'="",$P(Z,U,25)="" S Z0="" F  S Z0=$O(CL(Q1,Z0)) Q:Z0=""  I Z0[Q S $P(Z,U,25)=CL(Q1,Z0) Q
 . ;
 . ; Force bill classification into corresponding new UB92 field if new
 . ;  field is null
 . S ^DGCR(399,S1,0)=Z
 . S:'(CT#200) %=$$UPCP^XPDUTL("UPD399",S1)
 ;
 D BMES^XPDUTL("Step Complete.")
 ;
 Q
