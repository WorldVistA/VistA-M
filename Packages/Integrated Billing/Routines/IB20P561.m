IB20P561 ;ALB/CXW - IB*2.0*561 POST INIT: REVENUE CODE FOR MS-DRGS; 03-03-2016
 ;;2.0;INTEGRATED BILLING;**561**;21-MAR-94;Build 36
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ;
 N IBA,IBDT317,IBDT318 S U="^"
 D MSG("    Revenue Code 124 for Mental Health Diagnosis Post-Install .....")
 ; effective date of RC v3.17 or RC v3.18
 S IBDT317=3151001,IBDT318=3160101
 D RVDRG(IBDT317,IBDT318)
 D MSG("    Revenue Code 124 for Mental Health Diagnosis Post-Install Complete")
 Q
 ;
 ;
RVDRG(IBDT317,IBDT318) ; default rvc to 124 for DRGs in Reasonable Charges (#363.2)
 ;
 N IB561,IBCNT,IBCNO,IBRVC,IBCS,IBCS0,IBBR0,IBDRGC,IBDRGF,IBXRF,IBITM,IBNEF,IBCI,IBCI0,IBCIA
 N DA,DIE,DR,DT,X,X1,X2,Y
 S (IBCNO,IBCNT)=0,IB561="IB20P561"
 ;
 ; charge items for drgs store in xtmp for 30 days for tracking purpose 
 ; xtmp(name,0)=purge dt_U_today dt_U_patch#_U_total update_U_total rec.
 ; xtmp(name,charge set ien,charge item ien)=charge item before update 
 K ^XTMP(IB561)
 S DT=$$DT^XLFDT,X1=DT,X2=30 D C^%DTC
 S ^XTMP(IB561,0)=X_U_DT_U_"IB*2.0*561 POST-INIT"
 ;
 D MSG("")
 D MSG(" >> Adding 124 for MH DRGs on 1-OCT-15 or 1-JAN-16: 881, 882, 883, 885 & 886...")
 S IBRVC=$O(^DGCR(399.2,"B",124,0))
 I 'IBRVC D MSG("    ** Error: Revenue Code 124 undefined, not added") G RVDRGQ
 ;
 S IBCS=0 F  S IBCS=$O(^IBE(363.1,IBCS)) Q:'IBCS  D
 . S IBCS0=$G(^IBE(363.1,IBCS,0)) Q:IBCS0=""
 . S IBBR0=$G(^IBE(363.3,+$P(IBCS0,U,2),0)) I IBBR0'["RC INPATIENT" Q
 . ;
 . S IBXRF="AIVDTS"_IBCS
 . S IBITM=0 F  S IBITM=$O(^IBA(363.2,IBXRF,IBITM)) Q:'IBITM  D
 .. S IBNEF="" F  S IBNEF=$O(^IBA(363.2,IBXRF,IBITM,IBNEF)) Q:IBNEF=""  I (IBNEF=-IBDT317)!(IBNEF=-IBDT318) D 
 ... S IBCI=0 F  S IBCI=$O(^IBA(363.2,IBXRF,IBITM,IBNEF,IBCI)) Q:'IBCI  D
 .... S IBCIA=$G(^IBA(363.2,IBCI,0)) Q:IBCIA=""
 .... S IBCI0=$P(IBCIA,U,1)
 .... S IBDRGC=$P(IBCI0,";",1)
 .... S IBDRGF=$P(IBCI0,";",2) Q:IBDRGF'="ICD("
 .... I '$F("^881^882^883^885^886^",(U_IBDRGC_U)) Q
 .... S ^XTMP(IB561,IBCS,+IBCI)=IBCIA
 .... S IBCNO=IBCNO+1
 .... I $P(IBCIA,U,6)=IBRVC Q
 .... ;
 .... S DIE="^IBA(363.2,",DA=+IBCI
 .... S DR=".06///"_IBRVC D ^DIE K DIE,DA,DR,X,Y
 .... S IBCNT=IBCNT+1
 ;
RVDRGQ S $P(^XTMP(IB561,0),U,4)=IBCNT_U_IBCNO
 D MSG("    Done.  "_IBCNT_" existing inpatient charge items updated (#363.2)")
 D MSG("")
 Q
 ;
 ;
MSG(IBA) ;
 D MES^XPDUTL(IBA)
 Q
