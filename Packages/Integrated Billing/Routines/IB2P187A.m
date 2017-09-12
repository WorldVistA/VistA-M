IB2P187A ;WOIFO/SS-VISIT COPAY PHASE 2 IB*2.0*187 POST INIT ;19-AUG-02
 ;;2.0;INTEGRATED BILLING;**187**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
POST ;
 N X,Y
 F X="START","F6DIG","FADD","FUPD","FNON","FSPEC","FBASIC","ED36321","FINISH" S Y=$$NEWCP^XPDUTL(X,X_"^IB2P187A")
 ;
 ; F6DIG - add 6 digits codes to file 352.5
 ; FADD - add additional 3 digit codes to file 352.5
 ; FUPD - add updates for 3 digit codes to file 352.5
 ; FNON - NON BILLABLE entries for override table in 352.5
 ; FSPEC - SPECIALTY entries for override table in 352.5
 ; FBASIC - BASIC entries for override table in 352.5
 ; ED36321 - change PRIMARY to BASIC in 363.21
 ;
 Q
START ;
 N IBA
 S IBA(1)=""
 S IBA(2)="  Visit Copay Phase II, Post-Install Starting",IBA(3)=""
 S IBA(7)=""
 D MES^XPDUTL(.IBA)
 Q
 ;
FINISH ;
 N IBA
 S IBA(1)=""
 S IBA(2)="  Visit Copay Phase II, Post-Install Complete"
 D MES^XPDUTL(.IBA)
 Q
 ;
 ;
F6DIG ; add entries in file 352.5 (if not there)
 ;
 D FILEIT("F6DIG")
 Q
 ;
FADD ; add entries in file 352.5 (if not there)
 ;
 D FILEIT("FADD")
 Q
 ;
FUPD ; add entries in file 352.5 (if not there)
 ;
 D FILEIT("FUPD")
 Q
FNON ; add entries in file 352.5 (if not there) from NON-BILLABLE override table
 ;
 D FILEIT("FNON")
 Q
 ;
FSPEC ; add entries in file 352.5 (if not there) from SPECIALTY override table
 ;
 D FILEIT("FSPEC")
 Q
 ;
FBASIC ; add entries in file 352.5 (if not there) from BASIC override table
 ;
 D FILEIT("FBASIC")
 Q
 ;
FILEIT(IBOPER) ;
 ;
 N DIC,X,Y,IBC,IBX,DO,IBT,DA,IBA,DIK,IBS,IB3501,IBP,IBY
 S:IBOPER="F6DIG" IBA(2)="  Now adding the 6 digit override codes to file 352.5"
 S:IBOPER="FADD" IBA(2)="  Now adding additional 3 digit codes to file 352.5"
 S:IBOPER="FUPD" IBA(2)="  Now adding updates for 3 digit codes to file 352.5"
 S:IBOPER="FNON" IBA(2)="  Now adding entries of NON-BILLABLE override table to file 352.5"
 S:IBOPER="FSPEC" IBA(2)="  Now adding entries of SPECIALTY override table to file 352.5"
 S:IBOPER="FBASIC" IBA(2)="  Now adding entries of BASIC override table to file 352.5"
 S (IBA(1),IBA(3))="" D MES^XPDUTL(.IBA) K IBA
 I $$PATCH^XPDUTL("IB*2.0*187") D BMES^XPDUTL("  Skipping since the patch was previously installed.") Q
 S IBC=0
 I IBOPER="F6DIG" F IBX=1:1 S IBT=$P($T(D6DIG+IBX^IB2P187B),";",3) Q:'$L(IBT)  S Y=+$$INS3525(IBT,3021001,1) S:Y>0 IBC=IBC+1
 I IBOPER="FADD" F IBX=1:1 S IBT=$P($T(DADD+IBX^IB2P187B),";",3) Q:'$L(IBT)  S Y=+$$INS3525(IBT,3021001,0) S:Y>0 IBC=IBC+1
 I IBOPER="FUPD" F IBX=1:1 S IBT=$P($T(DUPD+IBX^IB2P187B),";",3) Q:'$L(IBT)  S Y=+$$INS3525(IBT,3021001,0) S:Y>0 IBC=IBC+1
 I IBOPER="FNON" F IBX=1:1 S IBT=$P($T(DNON+IBX^IB2P187B),";",3) Q:'$L(IBT)  S Y=+$$INS3525(IBT,3021001,1) S:Y>0 IBC=IBC+1
 I IBOPER="FSPEC" F IBX=1:1 S IBT=$P($T(DSPEC+IBX^IB2P187B),";",3) Q:'$L(IBT)  S Y=+$$INS3525(IBT,3021001,1) S:Y>0 IBC=IBC+1
 I IBOPER="FBASIC" F IBX=1:1 S IBT=$P($T(DBASIC+IBX^IB2P187B),";",3) Q:'$L(IBT)  S Y=+$$INS3525(IBT,3021001,1) S:Y>0 IBC=IBC+1
 S IBA(2)="     "_IBC_" entries added to 352.5"
 S (IBA(1),IBA(3))="",IBC=0
 D MES^XPDUTL(.IBA) K IBA
 Q
 ;
 ;IBDATA: data for #352.5 entries
 ;IBEFFDT: effective date
 ;IBOVER: 1 if we are adding code from override table, otherwise - 0
INS3525(IBDATA,IBEFFDT,IBOVER) ;
 N IBIENS,IBFDA,IBER,IBRET,IBSEEKDT,IBLSTDT,IBOFL,IB1
 S IBSEEKDT=IBEFFDT+0.0001
 S IBRET=""
 N IBTYPE S IBTYPE=$P(IBDATA,"^",3),IBTYPE=$P(IBTYPE," ") ;bill type
 S IBTYPE=$S(IBTYPE="S":2,IBTYPE="B":1,1:0)
 S IBLSTDT=-$O(^IBE(352.5,"AEFFDT",+$P(IBDATA,"^",1),-IBSEEKDT))
 I IBOVER=0 I IBLSTDT=IBEFFDT D BMES^XPDUTL(" Duplication of non-override code "_$P(IBDATA,"^",1)) Q 0
 I IBOVER=1 I IBLSTDT=IBEFFDT D  I IBOFL=1 Q 0
 . S IBOFL=0
 . S IB1=+$O(^IBE(352.5,"AEFFDT",+$P(IBDATA,"^",1),-IBEFFDT,0))
 . Q:IB1=0  ;error - need to add a new entry
 . S IBOFL=+$P($G(^IBE(352.5,IB1,0)),"^",5)
 . I IBOFL=1 D BMES^XPDUTL(" Duplication of override code "_$P(IBDATA,"^",1)) Q
 . S IBIENS=IB1_","
 . S IBFDA(352.5,IBIENS,.03)=IBTYPE
 . S IBFDA(352.5,IBIENS,.04)=$P(IBDATA,"^",2)
 . S IBFDA(352.5,IBIENS,.05)=1
 . D FILE^DIE("","IBFDA","IBERR")
 . S IBOFL=1 D BMES^XPDUTL(" Update of override code "_$P(IBDATA,"^",1))
 ;
 S IBIENS="+1,"
 S IBFDA(352.5,IBIENS,.01)=$P(IBDATA,"^",1)
 S IBFDA(352.5,IBIENS,.02)=IBEFFDT
 S IBFDA(352.5,IBIENS,.03)=IBTYPE
 S IBFDA(352.5,IBIENS,.04)=$P(IBDATA,"^",2)
 I IBOVER=1 S IBFDA(352.5,IBIENS,.05)=1
 D UPDATE^DIE("","IBFDA","IBRET","IBER")
 I $D(IBER) D BMES^XPDUTL(IBER("DIERR",1,"TEXT",1))
 Q $G(IBRET(1))
 ;
ED36321 ;change PRIMARY CARE to BASIC CARE
 N IBA
 S IBA(2)="  Now changing PRIMARY CARE to BASIC CARE in file #363.21"
 S (IBA(1),IBA(3))="" D MES^XPDUTL(.IBA)
 N IBIENCL
 S IBIENCL=$O(^IBA(363.21,"B","PRIMARY CARE",0))
 Q:+IBIENCL=0
 N IBIENS,IBFDA,IBERR
 S IBIENS=IBIENCL_"," ; "D0,"
 S IBFDA(363.21,IBIENS,.01)="BASIC CARE"
 D FILE^DIE("","IBFDA","IBERR")
 I $D(IBER) D BMES^XPDUTL(IBER("DIERR",1,"TEXT",1))
 Q
 ;
