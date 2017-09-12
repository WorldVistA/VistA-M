IBYOPOST ;ALB/TMP - IB*2*51 POST-INSTALL ;22-JAN-96
 ;;2.0;INTEGRATED BILLING;**51**;21-MAR-94
 ;
POST ;Set up check points for post-init
 S %=$$NEWCP^XPDUTL("UPDXREF","XREF^IBYOPOST")
 S %=$$NEWCP^XPDUTL("FIXTOS","FIXTOS^IBYOPOST")
 S %=$$NEWCP^XPDUTL("MOVEMOD","MOVEMOD^IBYOPOST")
 S %=$$NEWCP^XPDUTL("ADDFORMS","ADDFORMS^IBYOPOS1")
 K ^XTMP("IB20_51")
 K PROD
 Q
 ;
FIXTOS ; Fix 2 entries in type of service file
 D BMES^XPDUTL("Fixing entries in Type of Service file")
 N DA,DR,DIE,X,Y
 S DA=$O(^IBE(353.2,"B","B",0)) ;Change 'B' type of service to 'F'
 I DA S DR=".01///F",DIE="^IBE(353.2," D ^DIE
 S DA=$O(^IBE(353.2,"B","L",0)) ;Change 'L' desc from rental to renal
 I DA S DR=".02////RENAL SUPPLIES IN THE HOME;.03////^S X=""RENAL SUPPLIES/HOME""",DIE="^IBE(353.2," D ^DIE
 D COMPLETE
 Q
 ;
XREF ; Update files by running the new cross references
 ;
 D BMES^XPDUTL("Running new 'D' cross reference on FORM,PAGE,LINE,COLUMN in file 364.6.")
 S DIK="^IBA(364.6,",DIK(1)=".04^D" D ENALL^DIK
 ;
 ; Run trigger for field .01 that sets the ASSOCIATED FORM
 ; DEFINITION field for SCREEN forms
 D BMES^XPDUTL("Running trigger of ASSOCIATED FORM DEFINITION in file 364.6.")
 S DIK="^IBA(364.6,",DIK(1)=".01^4" D ENALL^DIK
 ;
 ;Run the "ALL" xref for field .02, file 364.7
 ;  This sets the "ALL" xref based on local overrides and no ins or
 ;   bill type restrictions
 ;
 D BMES^XPDUTL("Setting new 'ALL' xref in file 364.7.")
 S DIK="^IBA(364.7,",DIK(1)=".02" D ENALL^DIK
 ;
 ;Run the trigger cross reference on field of file 353
 ;  This sets the local screen 9's associated form
 ;
 D BMES^XPDUTL("Populate all SCREEN FORM PARENT FORMS field.")
 S DIK="^IBE(353,",DIK(1)="2.02^1" D ENALL^DIK
 ;
 D COMPLETE
 Q
 ;
MOVEMOD N IBCT,IBX,IBCP,IBMOD,IBFSPEC,DLAYGO,D0,DD,DA,DIC,DIE,DR,X,Y
 ;
 D BMES^XPDUTL("Moving single modifiers to multiple field, correcting mailing address zip code, adding facility name for billing")
 ;
 S IBFSPEC=$$GETSPEC^IBEFUNC(399.0304,16)
 S IBCT=0
 S IBX=+$$PARCP^XPDUTL("MOVEMOD") ;Get last bill ien processed
 ;
 F  S IBX=$O(^DGCR(399,IBX)) Q:'IBX  D
 . N Z,IBZZ,IBZ1,IBZ,IBY,DIC,DIE,X,Y,DLAYGO,DD,DO,DR,DA
 . I $P($G(^DGCR(399,IBX,"M")),U,9)["-" S X=$TR($P(^("M"),U,9),"-"),$P(^("M"),U,9)=X ; Corrects bad data in mailing address zip code field
 . S IBCP=0 F  S IBCP=$O(^DGCR(399,IBX,"CP",IBCP)) Q:'IBCP  S IBMOD=+$P($G(^(IBCP,0)),U,15) D
 .. I $O(^DGCR(399,IBX,"CP",IBCP,"MOD",0)) D  ; alpha sites only - add 'C' xref
 ... N Z,Z0
 ... S Z=0 F  S Z=$O(^DGCR(399,IBX,"CP",IBCP,"MOD",Z)) Q:'Z  I $P($G(^DGCR(399,IBX,"CP",IBCP,"MOD",Z,0)),U,2)'="" S Z0=$P(^(0),U,2),^DGCR(399,IBX,"CP",IBCP,"MOD","C",Z0,Z)=""
 .. S IBCT=IBCT+1
 .. S:'(IBCT#200) %=$$UPCP^XPDUTL("MOVEMOD",IBCT)
 .. I 'IBMOD!$D(^DGCR(399,IBX,"CP",IBCP,"MOD","C",IBMOD)) Q
 .. ;
 .. ;Add the modifier to the multiple, if not already there
 .. K DO,DD
 .. S X=1,DIC("P")=IBFSPEC,DLAYGO=399.30416,DA(2)=IBX,DA(1)=IBCP
 .. S DIC="^DGCR(399,"_IBX_",""CP"","_IBCP_",""MOD"",",DIC(0)="L"
 .. S DIC("DR")=".02////"_IBMOD
 .. D FILE^DICN K DO,DD,DA
 .. I Y>0 S DA(1)=IBX,DA=IBCP,DR="14///@",DIE="^DGCR(399,"_DA(1)_",""CP""," D ^DIE ;Remove data from upper level if successfully added in multiple
 . I $P($G(^DGCR(399,IBX,"TX")),U,2)'="" S Z=+$P(^("TX"),U,2),^DGCR(399,"ALEX",Z,IBX)=""
 I $P($G(^XTMP("IB20_51","IBFAC")),U)'="" S DIE="^IBE(350.9,",DA=1,DR="2.1////"_$P(^XTMP("IB20_51","IBFAC"),U) D ^DIE
 I $P($G(^XTMP("IB20_51","IBFAC")),U,2)'="" S DIE="^IBE(350.9,",DA=1,DR="2.02////"_$P(^XTMP("IB20_51","IBFAC"),U,2) D ^DIE
 ;
 D COMPLETE
 Q
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
ENT5 ; Changed and new entries from 364.5 that should be in the build
 ;
 ;;^LIVE^34^35^44^45^46^48^49^55^56^60^69^81^82^84^92^97^98^102^114^116^118^117^119^123^126^128^129^135^137^138^142^145^146^147^150^151^153^154^155^156^158^165^166^167^168^169^170^171^172^174^175^176^177^179^180^183^184^185^191^193^194^195^196^
 ;
 ;;^LIVE^197^198^199^200^201^202^204^216^220^221^231^239^241^242^243^244^245^246^247^248^249^250^251^252^255^280^258^259^260^261^263^264^265^266^267^268^269^270^271^273^274^275^276^277^278^279^281^282^285^286^287^288^289^291^293^294^295^348^
 ;
 ;;^LIVE^8^59^108^125^134^178^222^223^233^238^284^
 ;
COMPLETE ;
 D BMES^XPDUTL("Step complete.")
 Q
 ;
DD3645(Y) ;INCLUDE IN PATCH 51 BUILD
 ;Y=ien of entry in file 364.5
 N Z,Z0,OK
 S (OK,Z)=0 F  S Z=$O(^IBA(364.7,"C",+Y,Z)) Q:'Z  S Z0=$G(^IBA(364.7,Z,0)) I $P(Z0,U,2)="N",+$G(^IBA(364.6,+Z0,0))'=8 S OK=1 Q
 I $P($T(ENT5+2),";;",2)[(U_+Y_U)!($P($T(ENT5+4),";;",2)[(U_+Y_U)!($P($T(ENT5+6),";;",2)[(U_+Y_U))) S OK=1
 S Z=$G(^IBA(364.5,+Y,0)) ;Reset the naked reference
 Q OK
 ;
