IBCEPTM ;ALB/TMK - FILE EDI CLAIMS TEST MESSAGES ;01/27/05
 ;;2.0;INTEGRATED BILLING;**296**;21-MAR-94
 Q
 ;
UPDTEST(IBTDA) ; Store test claim status message in file 361.4
 ; IBTDA = ien of the message entry for the status message in 364.2
 N IBT,IBZ,IBZ0,IBZ1,IBE,IBY,IB0,IBMNUM,IBBDA,IBBILL,IB3614,DIC,X,Y,Z,DLAYGO,DO,DD,DA
 ;
 I '$$LOCK^IBCEM(IBTDA) G UPDQ ;Lock message in file 364.2
 ;
 D UPDMSG^IBCESRV2(IBTDA,"U",0)
 ;
 S IB0=$G(^IBA(364.2,IBTDA,0)),IBBDA=$P(IB0,U,4),IBBILL=$P(IB0,U,5)
 S IBMNUM=$P(IB0,U) ; Message number
 ;
 ; esg - 5/12/05 - Update the 364.1 batch status and some other fields even though this is for a test batch
 ;
 I IBBDA,$P($G(^IBA(364.1,+IBBDA,0)),U,2)'="A0" D
 . N DA,DIE,DR
 . S DA=IBBDA,DIE="^IBA(364.1,"
 . S DR=".02////A0;1.06///NOW"
 . I $P(IB0,U,10) S DR=DR_";1.05////"_$P(IB0,U,10)
 . D ^DIE
 . Q
 ;
 ; If a status message references a batch, update the message for all bills in the batch
 I 'IBBDA S IBBILL(+$G(^IBA(364,+IBBILL,0)))=""
 I IBBDA S IBBILL="" F  S IBBILL=$O(^IBM(361.4,"C",+IBBDA,IBBILL)) Q:'IBBILL  S IBBILL(IBBILL)=""
 S IBBILL=0 F  S IBBILL=$O(IBBILL(IBBILL)) Q:'IBBILL  D
 . ;
 . S IB3614=IBBILL
 . ; Create new entry and stuff fields
 . I $D(^IBM(361.4,IB3614,2,"AC",(IBMNUM\1))) Q  ; Msg already there
 . S DIC(0)="L",DLAYGO=361.42,DIC("DR")=".02////"_$S($P($G(^IBE(364.3,+$P(IB0,U,2),0)),U)["REJ":"R",1:"I")_";.03////"_(IBMNUM\1),X=$$NOW^XLFDT()
 . S DA(1)=IB3614,DIC="^IBM(361.4,"_DA(1)_",2,"
 . K DO,DD D FILE^DICN K DIC,DO,DD,DLAYGO
 . I Y'>0 Q
 . S IBY=+Y
 . K IBE("DIERR"),IBT
 . S (IBZ,IBZ0)=0
 . F  S IBZ=$O(^IBA(364.2,IBTDA,2,IBZ)) Q:'IBZ  S IBZ1=$G(^(IBZ,0)) Q:$E(IBZ1,1,2)="##"  S IBZ0=IBZ0+1,IBT(IBZ0)=IBZ1
 . D MSGLNSZ^IBCEST(.IBT)
 . F Z=1:1:20 D WP^DIE(361.42,+IBY_","_+IB3614_",",1,"AK","IBT","IBE") Q:$S('$D(IBE("DIERR")):1,+IBE("DIERR")=1:$G(IBE("DIERR",1))'=110,1:1)  K IBE("DIERR") ; On lock error (110), retry up to 20 times
 ;
 D DELMSG^IBCESRV2(IBTDA)
 ;
UPDQ S ZTREQ="@"
 Q
 ;
ADDTXM(IBBILL,IBBATCH,IBDATE) ;  Add an entry to the transmission multiple for
 ; the claim.  Add the claim record, if needed.
 ; IBBILL = array subscripted by iens of file 399
 N DIC,DINUM,DLAYGO,DO,DD,DA,X,Y,IB3614,IBDA
 Q:'IBBATCH!'IBDATE
 S IBDA=0 F  S IBDA=$O(IBBILL(IBDA)) Q:'IBDA  D
 . ;
 . S IB3614=+$G(^IBA(364,IBDA,0))
 . I '$D(^IBM(361.4,IB3614)) D  ; Add the record for the claim
 .. K DO,DD
 .. S DIC(0)="L",DLAYGO=361.4,DIC="^IBM(361.4,",X=IB3614,DINUM=X
 .. D FILE^DICN K DO,DD,DIC,DLAYGO,DINUM
 .. Q:Y>0
 .. S IB3614=0
 . Q:'IB3614
 . ;
 . S DA(1)=IB3614,DIC="^IBM(361.4,"_DA(1)_",1,",X=IBDATE
 . S DIC(0)="L",DLAYGO=361.41,DIC("DR")=".02////"_IBBATCH_";.03////"_DUZ_";.04////"_+$$COBN^IBCEF(IB3614)
 . D FILE^DICN K DO,DD,DIC,DLAYGO
 Q
 ;
