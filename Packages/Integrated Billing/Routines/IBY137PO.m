IBY137PO ;ALB/TMP - IB*2*137 POST-INSTALL ;23-AUG-2000
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ;
POST ;Set up check points for post-init
 S %=$$NEWCP^XPDUTL("U399","U399^IBY137PO")
 S %=$$NEWCP^XPDUTL("U3993","U3993^IBY137PO")
 S %=$$NEWCP^XPDUTL("U36","U36^IBY137PO")
 S %=$$NEWCP^XPDUTL("U3509","U3509^IBY137PO")
 S %=$$NEWCP^XPDUTL("UPDPID","PID^IBY137PO")
 S %=$$NEWCP^XPDUTL("UPDPTYP","PTYPE^IBY137PO")
 S %=$$NEWCP^XPDUTL("UPDNDC","NDCFMT^IBY137PO")
 S %=$$NEWCP^XPDUTL("END","END^IBY137PO") ; Leave as last update
 Q
 ;
U3993 N Z,DA,DIE,X,Y,DR
 D BMES^XPDUTL("Updating RATE TYPE file with electronic billable flag")
 F Z="SHARING AGREEMENT","REIMBURSABLE INS.","CHAMPVA","CHAMPVA REIMB. INS.","CHAMPUS","CHAMPUS REIMB. INS." S DA=$O(^DGCR(399.3,"B",Z,"")) I DA,'$P(^DGCR(399.3,DA,0),U,10) S DIE="^DGCR(399.3,",DR=".1////1" D ^DIE
 D COMPLETE
 Q
 ;
PID ; Use insurance co's TYPE OF COVERAGE field to default its perf prov
 ; id type ... Default TYPE OF COVERAGE, if none, is HEALTH INSURANCE
 D BMES^XPDUTL("Updating insurance co electronic ins type and default prov ID parameters")
 N IBUPIN,IBZ,IB3,IB4,IBZ0,IBZ02,IB,DR,DIE,DA,X,Y
 S IBZ=0 F  S IBZ=$O(^DIC(36,IBZ)) Q:'IBZ  S IBZ0=+$P($G(^(IBZ,0)),U,13) I '$P($G(^(0)),U,5) D
 . S IBZ02=$P($G(^IBE(355.2,IBZ0,0)),U,2),DR=""
 . I IBZ02="",'IBZ0 S IBZ02="HI"
 . Q:IBZ02=""
 . I "^DII^IN^TF^WC^MCL^"[(U_IBZ02_U) Q  ; No default
 . S IB3=$G(^DIC(36,IBZ,3)),IB4=$G(^(4))
 . ; Medicare
 . I IBZ02="MCR" D  Q:DR=""
 .. S DR=".04////VAD000",DIE="^IBE(355.97,",IBUPIN=$$UPIN^IBCEP() I IBUPIN,'$P($G(^IBE(355.97,IBUPIN,0)),U,4) S DA=IBUPIN D ^DIE
 .. S DR=$S('$P(IB3,U,9):"3.09////3",1:"")
 .. S DR=DR_$S($P(IB4,U)="":$S($G(IBUPIN):";4.01////"_IBUPIN_";4.02////2",1:""),1:"")
 . ; Medicaid
 . I IBZ02="MCD",$P(IB3,U,9)="" S DR="3.09////4"
 . ; ChampVA
 . I IBZ02="CHV",$P(IB3,U,9)="" S DR="3.09////9"
 . ; Blue Cross
 . I IBZ02="BC" S DR=$S($P(IB4,U)="":"4.01////1",1:"")_$S($P(IB4,U,2)="":";4.02////3",1:"")_$S($P(IB3,U,9)="":";3.09////9",1:"")
 . ; Blue Shield
 . I IBZ02="BS" S DR=$S($P(IB4,U)="":"4.01////2",1:"")_$S($P(IB4,U,2)="":";4.02////3",1:"")_$S($P(IB3,U,9)="":";3.09////9",1:"")
 . ; Champus
 . I IBZ02="CHS" S DR=$S($P(IB4,U)="":"4.01////3",1:"")_$S($P(IB3,U,9)="":";3.09////9",1:"")
 . ; Commercial/Group or HMO if not one of the above
 . I DR="" D
 .. S DR=$S($P(IB4,U)="":"4.01////6",1:"")_$S($P(IB4,U,2)="":";4.02////3",1:"")_$S($P(IB4,U,3)="":";4.03////2",1:"")_$S($P(IB4,U,10)="":";4.1////16",1:"")_$S($P(IB4,U,11)="":";4.11////2",1:"")
 .. S DR=DR_$S($P(IB3,U,9)="":";3.09///"_$S(IBZ02="HMO":1,1:5),1:"")
 . S:$E(DR)=";" DR=$E(DR,2,$L(DR))
 . I IBZ,DR'="" S DIE="^DIC(36,",DA=IBZ D ^DIE
 D COMPLETE
 Q
 ;
PTYPE ; Update the insurance co plans' electronic id type
 ;
 D BMES^XPDUTL("Adding ELECTRONIC PLAN TYPE for each plan") ; based on major category of plan
 ; If TYPE OF INSURANCE COVERAGE for the plan's insurance company
 ;   is BLUE CROSS or BLUE SHIELD, this is a BC/BS plan type if the
 ;   MAJOR CATEGORY of the plan is not one of the specific ones listed
 ;   below
 ;
 ;  MAJOR CATEGORY      ELECTRONIC PLAN TYPE  
 ; ----------------    ----------------------
 ;       HMO                   HMO
 ;       PPO                   PPO
 ;    MEDICAIDE              MEDICAID
 ;    MEDICARE            MEDICARE A OR B
 ;     CHAMPUS                CHAMPUS
 ;    INDEMNITY              INDEMNITY
 ;
 ;  NONE OF ABOVE/NOT BCBS   COMMERCIAL
 ;
 N IBINS,IBZ,IBZ0,DA,DIE,DR,X,Y
 S IBDA=0 F  S IBDA=$O(^IBA(355.3,IBDA)) Q:'IBDA  D
 . S IBZ0=$G(^IBE(355.1,+$P($G(^IBA(355.3,IBDA,0)),U,9),0))
 . S IBINS=+$P($G(^DIC(36,+$G(^IBA(355.3,IBDA,0)),0)),U,13),IBINS=$P($G(^IBE(355.2,IBINS,0)),U)
 . S IBZ=$P(IBZ0,U,3)
 . S IBZ=$S(IBZ=3:"HM",IBZ=4:12,IBZ=5:"MX",IBZ=6:"MC",IBZ=7:"CH",IBZ=9:15,IBINS="BLUE CROSS"!(IBINS="BLUE SHIELD"):"BL",1:"CI")
 . I $P($G(^IBA(355.3,IBDA,0)),U,15)="" S DIE="^IBA(355.3,",DR=".15////"_IBZ,DA=IBDA D ^DIE
 ;
 D COMPLETE
 Q
 ;
U399 ; Change free text pointer to variable pointer in file 399.0222 - add
 ;  entry in file 355.93 if needed
 ; Start on bills authorized 10-1-2000 or later
 N A,IBZ,IBZ0,DIC,DA,DR,DIE,DLAYGO,DD,DO,X,X0,Y,IBVAP,IBLAST,IBRESTRT,IBMATCH,IBA2,IBA
 D BMES^XPDUTL("Converting provider free text data to pointers in PROVIDER multiple of BILL/CLAIMS file")
 S IBLAST=$$PARCP^XPDUTL("U399") ;Restart parameter
 S:IBLAST="" IBLAST="3001001^0"
 S IBRESTRT=$P(IBLAST,U,2)
 S IBZ=IBLAST-.0000001
 S ^XTMP("IB20_P137_IBPRV",0)=$$FMADD^XLFDT(DT,10)_U_DT_U_"IB PATCH 137 NON-VA PROVIDER DATA"
 F  S IBZ=$O(^DGCR(399,"APD",IBZ)) Q:'IBZ  S IBZ0=IBRESTRT,IBRESTRT=0 F  S IBZ0=$O(^DGCR(399,"APD",IBZ,IBZ0)) Q:'IBZ0  I $D(^DGCR(399,IBZ0,0)) D
 . S IBZ1=0 F  S IBZ1=$O(^DGCR(399,IBZ0,"PRV",IBZ1)) Q:'IBZ1  S A=$G(^(IBZ1,0)) I $P(A,U,2)'="",$P(A,U,2)'[";VA(200",$P(A,U,2)'[";IBA(355.93" D
 .. S X=+$P($P(A,U,2),"(",2)
 .. S DA(1)=IBZ0,DA=IBZ1
 .. ; provider is non-VA (in file 355.93)
 .. I 'X D  Q
 ... S IBA=$$UP^XLFSTR($P(A,U,2))
 ... S IBMATCH=0,IBA2=$$NOPUNCT^IBCEF(IBA,1)
 ... ; Strip all punctuation and spaces and make all upper case
 ... S X0=0 F  S X0=$O(^XTMP("IB20_P137_IBPRV",IBA2,X0)) Q:'X0  D  Q:IBMATCH
 .... Q:'X0
 .... I $$UP^XLFSTR($P($G(^IBA(355.93,X0,0)),U,3))=$$UP^XLFSTR($P(A,U,3)) S IBMATCH=1
 ... I X0 S DR=".02////^S X=IBVAP",IBVAP=X0_";IBA(355.93,",DIE="^DGCR(399,"_DA(1)_",""PRV""," D ^DIE S %=$$UPCP^XPDUTL("U399",IBZ_U_IBZ0) Q
 ... K DO,DD
 ... S DIC="^IBA(355.93,",X=$E(IBA,1,30),DIC(0)="L",DIC("DR")=".02////2"_$S($P(A,U,3)'="":";.03////"_$P(A,U,3),1:""),DLAYGO=355.93 D FILE^DICN K DO,DD,DLAYGO
 ... I Y>0 S DA(1)=IBZ0,DA=IBZ1,^XTMP("IB20_P137_IBPRV",IBA2,+Y)="",DR=".02////^S X=IBVAP",IBVAP=+Y_";IBA(355.93,",DIE="^DGCR(399,"_DA(1)_",""PRV""," D ^DIE
 ... S %=$$UPCP^XPDUTL("U399",IBZ_U_IBZ0)
 .. ;
 .. ; provider is VA (in file 200)
 .. E  D
 ... S DR=".02////^S X=IBVAP",IBVAP=X_";VA(200,",DIE="^DGCR(399,"_DA(1)_",""PRV""," D ^DIE Q
 .. S %=$$UPCP^XPDUTL("U399",IBZ_U_IBZ0)
 K ^XTMP("IB20_P137_IBPRV"),^XTMP("IB20_P137")
 D COMPLETE
 Q
 ;
U36 N IBZ,IBACT,CT
 I $D(^IBE(350.9,1,8)) D BMES^XPDUTL("Update of INSURANCE CO with EDI inactive status done-not rerun"),COMPLETE Q
 D BMES^XPDUTL("Updating INSURANCE file with EDI inactive status")
 S CT=0
 S IBZ=+$$PARCP^XPDUTL("U36"),IBACT=0
 F  S IBZ=$O(^DIC(36,IBZ)) Q:'IBZ  S CT=CT+1 S:'(CT#50) %=$$UPCP^XPDUTL("U36",IBZ) I $D(^DIC(36,IBZ,0)),$P($G(^(3)),U)="" S DIE="^DIC(36,",DA=IBZ,DR="3.01////0" D ^DIE
 D COMPLETE
 Q
 ;
NDCFMT ;
 N Z,DA,DIK,CT
 D BMES^XPDUTL("Executing the new NDC format's cross reference - file 362.4")
 S CT=0
 S Z=+$$PARCP^XPDUTL("UPDNDC") F  S Z=$O(^IBA(362.4,Z)) Q:'Z  S CT=CT+1 S:'(CT#50) %=$$UPCP^XPDUTL("UPDNDC",Z) I $P($G(^IBA(362.4,Z,0)),U,8)'="",$P(^(0),U,9)="" S DA=Z,DIK="^IBA(362.4,",DIK(1)=".08" D EN1^DIK
 D COMPLETE
 Q
 ;
U3509 ; Update site parameters with EDI default data
 D BMES^XPDUTL("Adding QUEUE names and EDI default data to PARAMETERS FILE")
 I $D(^IBE(350.9,1)),$G(^(1,8))="" D
 . S DIE="^IBE(350.9,",DA=1,DR="8.01////MCR;8.09////MCT;8.07////0;8.1////0" D ^DIE
 D COMPLETE
 Q
 ;
 ;  The following code is used strictly for creating the build in the
 ; development account.  It has no value at an individual site.  Do not
 ; use this code to re-build the build at the site.
DDFOR837(Y) ; Code to execute to decide if the data element definition 
 ;  should be sent with this patch ... either it exists in the list at
 ;  line ENT5+2 or below or it is output only by the 837 output form (#8)
 N IBOUT,Z,Z0
 I Y>9999 S IBOUT=0 G Q1
 I ($P($T(ENT5+2),";;",2)[(U_+Y_U)!($P($T(ENT5+3),";;",2)[(U_+Y_U))) S IBOUT=1 G Q1
 I '$O(^IBA(364.7,"C",+Y,0)) S IBOUT=0 G Q1
 S IBOUT=1,Z=0 F  S Z=$O(^IBA(364.7,"C",+Y,Z)) Q:'Z  S Z0=+$G(^IBA(364.7,Z,0)) I +$G(^IBA(364.6,Z0,0))'=8 S IBOUT=0 Q
Q1 Q +$G(IBOUT)
 ;
ERRMSG(TEXT) ; Report errors in array TEXT(error #)=text
 Q:'$O(TEXT(0))
 N Z,Z0
 S Z0="",$P(Z0,"*",29)=""
 D BMES^XPDUTL(" ")
 D MES^XPDUTL(Z0_"ERROR"_Z0)
 S Z=0 F  S Z=$O(TEXT(Z)) Q:'Z  D MES^XPDUTL(TEXT(Z))
 D MES^XPDUTL(Z0_"*****"_Z0)
 D BMES^XPDUTL(" ")
 Q
 ;
ENT5 ; Changed and new entries from 364.5  (other than those only on the 837)
 ;   that should be in the build
 ;;^80^86^98^123^142^194^195^275^297^ ; changed, but not ref-ed by 837
 ;;
 ;;^218^224^225^226^227^228^234^236^249^256^265^290^292^297^ ; ref'd by 837
 Q
 ;
ENT7 ; Changed and new entries from 364.7  (other than those on the 837 form)
 ;   that should be in the build
 ;;^LIVE^251^259^275^276^292^293^317^505^623^630^634^635^724^736^737^799^
 Q
 ;
COMPLETE ;
 D BMES^XPDUTL("Step complete.")
 Q
 ;
END ;
 D BMES^XPDUTL("Post install complete.")
 Q
 ;
