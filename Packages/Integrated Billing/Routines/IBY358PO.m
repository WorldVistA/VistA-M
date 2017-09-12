IBY358PO ;ALB/WCJ - Post Install for IB patch 358 ;28-JUL-2005
 ;;2.0;INTEGRATED BILLING;**358**;21-MAR-94
 ;
EN ;
 N XPDIDTOT S XPDIDTOT=1
 D CLEAN         ; 1. Clean up IDs with qualifiers  TJ & 24
 ;
EX ;
 Q
CLEAN ; Clean up IDs with qualifiers TJ & 24
 D BMES^XPDUTL(" STEP 1 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Cleaning up IDs with Qualifiers 24, EI, TJ ....")
 ;
 ; this will loop through all qualifiers with internal values of
 ; 16 (X12 CODE 24) and 21 (X12 CODE TJ).  The X12 codes should be
 ; internal 32 (X12 CODE EI) for individuals and internal 21 (X12 CODE
 ; TJ) for labs/facilities.  IDs will be modified or deleted as
 ; necessary.
 ;
 N QUAL,PROV,IORF,PROVIEN,IDS,I,J,K,FLAG
 ;
 F QUAL=21,16 D
 . S PROV=""
 . F  S PROV=$O(^IBA(355.9,"AC",QUAL,"*ALL*",PROV)) Q:PROV=""  D
 .. Q:PROV'["IBA(355.93"   ; Only NonVA providers
 .. S PROVIEN=+PROV
 .. S IORF=$P($G(^IBA(355.93,PROVIEN,0)),U,2) ; (2)Individual OR (1)Facility
 .. ;
 .. K IDS
 .. D GETALL(PROV,.IDS)
 .. Q:'$D(IDS)  ; Nothing to convert (should not stop here)
 .. ;
 .. ; Individual already having EI, Delete 24s & TJs
 .. I IORF=2,$G(IDS(32)) D  Q
 ... F K=16,21 F I=0,1,2 F J=0:1:3 I $D(IDS(K,I,J)) D DELETE(IDS(K,I,J))
 .. ;
 .. ; Lab/Fac with TJs already, delete 24s
 .. I IORF=1,$G(IDS(21)) D  Q
 ... F I=0,1,2 F J=0:1:3 I $D(IDS(16,I,J)) D DELETE(IDS(16,I,J))
 .. ;
 .. ; Lab/Fac with 24s but no TJs, edit or delete 24s as appropriate
 .. I IORF=1,'$G(IDS(21)),$G(IDS(16)) D  Q
 ... S FLAG=0
 ... F I=0,1,2 F J=0:1:3 I $D(IDS(16,I,J)) D MODIFY(IDS(16,I,J),21):'FLAG,DELETE(IDS(16,I,J)):FLAG S FLAG=1
 .. ;
 .. ; Individual with TJs or 24s but no EIs, edit or delete as appropriate
 .. I IORF=2,'$G(IDS(32)) D  Q
 ... ;
 ... S FLAG=0
 ... F I=0,1,2 F J=0:1:3 F K=21,16 I $D(IDS(K,I,J)) D MODIFY(IDS(K,I,J),32):'FLAG,DELETE(IDS(K,I,J)):FLAG  S FLAG=1
CLEANX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(1)
 Q
 ;
 ; pass in PROV    IEN;IBA(355.93,
 ; return IDS array IDS(IEN35597,FORMTYPE,CARETYPE)=IEN3559
 ;                  IDS(IEN35597)=COUNTER
GETALL(PROV,IDS) ;
 N I,J,K
 F I=0,1,2 D
 . F J=0:1:3 D
 .. F K=16,21,32 D
 ... I $D(^IBA(355.9,"AUNIQ",PROV,"*ALL*","*N/A*",I,J,K)) D
 .... S IDS(K,I,J)=$O(^IBA(355.9,"AUNIQ",PROV,"*ALL*","*N/A*",I,J,K,0))
 .... S IDS(K)=$G(IDS(K))+1
 Q
 ;
DELETE(IEN) ;
 N DIK,DA
 S DIK="^IBA(355.9,",DA=+IEN D ^DIK
 Q
 ;
MODIFY(IEN,QUAL) ;
 N DIE,DA,DR
 S DIE="^IBA(355.9,",DA=+IEN,DR=".04////0;.05////0;.06////"_QUAL D ^DIE
 Q
 ;
