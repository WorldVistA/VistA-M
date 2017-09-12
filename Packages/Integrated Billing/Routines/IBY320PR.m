IBY320PR ;ALB/ESG - Pre-Install for IB patch 320 ;05-JAN-2006
 ;;2.0;INTEGRATED BILLING;**320**;21-MAR-94
 ;
 D DELLOC      ; delete local output formatter overrides
 D DELOF       ; delete output formatter entries
 D DELLIST     ; delete modified list templates
 D DELXREFS    ; Delete XREFS added in ealier version of this patch
 D EMAIL       ; generate message with existing provider ID types
 ;
 Q
 ;
DELOF ; Delete included output formatter entries
 NEW FILE,DIK,LN,TAG,DATA,PCE,DA,Y
 F FILE=5,6,7 S DIK="^IBA(364."_FILE_"," F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA("364."_FILE,DA,0)) D ^DIK
 . Q
 ;
 ; Also delete output formatter entries which are not going to be
 ; re-added later.  These are erroneous entries in file 364.6.
 S DIK="^IBA(364.6,",TAG="DEL6+2",DATA=$P($T(@TAG),";;",2)
 I DATA'="" D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA(364.6,DA,0)) D ^DIK
 . Q
 ;
 ; Also delete output formatter entries which are not going to be
 ; re-added later.  These are erroneous entries in file 364.7.
 S DIK="^IBA(364.7,",TAG="DEL7+2",DATA=$P($T(@TAG),";;",2)
 I DATA'="" D
 . F PCE=2:1 S DA=$P(DATA,U,PCE) Q:'DA  I $D(^IBA(364.7,DA,0)) D ^DIK
 . Q
DELOFX ;
 Q
 ;
INCLUDE(FILE,Y) ; function to determine if output formatter entry should be
 ; included in the build
 ; FILE=5,6,7 indicating file 364.x
 ; Y=ien to file
 ;
 NEW OK,LN,TAG,DATA
 S OK=0
 F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,U_Y_U) S OK=1 Q
INCLUDEX ;
 Q OK
 ;
ENT5 ; output formatter entries in file 364.5 to be included
 ;
 ;;^111^112^113^
 ;;
 ;
ENT6 ; output formatter entries in file 364.6 to be included
 ;
 ;;^169^226^227^968^971^1015^1051^1065^1094^1095^1096^1097^
 ;;^1098^1099^1100^1101^1102^1103^1104^1190^1191^1192^1289^1316^1317^
 ;;
 ;
ENT7 ; output formatter entries in file 364.7 to be included
 ;
 ;;^12^156^157^159^160^188^196^203^204^208^209^211^225^226^227^256^
 ;;^375^376^377^378^379^380^381^382^383^384^
 ;;^385^387^388^389^390^392^393^395^396^397^398^399^400^401^402^
 ;;^403^405^406^407^408^409^410^411^412^413^552^553^554^555^556^557^558^
 ;;^559^576^577^578^579^580^581^582^583^584^585^586^587^588^589^590^591^
 ;;^646^900^947^948^954^1009^1015^1020^1022^1023^1031^1032^1033^
 ;;
 ;
DEL6 ; remove output formatter entries in file 364.6 (not re-added)
 ;
 ;;^1066^1067^1068^1069^1071^1013^1302^
 ;;
 ;
DEL7 ; remove output formatter entries in file 364.7 (not re-added)
 ;
 ;;^187^214^249^302^316^324^325^353^468^568^570^571^572^573^574^575^899^1014^1017^
 ;;
 ;
 Q
 ;
DELLOC ; This procedure removes certain local output formatter overrides
 ;
 NEW FORM,IBX2,NI6,NI7,LI6,LI7,DIK,DA,DIE,DR,IBY,XMDUZ,XMSUBJ,XMBODY,XMTO
 ;
 S DIE=353,DA=8,DR="2.08///@;2.05///@" D ^DIE   ; to make sure EDI uses #8
 ;
 S IBY="P320-LOFO"   ; patch 320 local output formatter override
 KILL ^TMP($J,IBY)
 S ^TMP($J,IBY)=0
 ;
 S FORM=8   ; start here to skip over the normal national form types
 F  S FORM=$O(^IBE(353,FORM)) Q:'FORM  D
 . S IBX2=$G(^IBE(353,FORM,2))
 . I $P(IBX2,U,2)'="T" Q      ; only deal with transmitted forms
 . I $P(IBX2,U,4) Q           ; don't mess with national form types
 . I '$P(IBX2,U,5) D DELFRM(FORM) Q    ; no parent form type
 . ;
 . ; Check local overrides one by one
 . S NI6=0 F  S NI6=$O(^IBA(364.6,"APAR",FORM,NI6)) Q:'NI6  D
 .. S NI7=$O(^IBA(364.7,"B",NI6,0)) Q:'NI7
 .. I '$$INCLUDE(6,NI6),'$$INCLUDE(7,NI7) Q    ; not included with patch
 .. S LI6=0 F  S LI6=$O(^IBA(364.6,"APAR",FORM,NI6,LI6)) Q:'LI6  D
 ... S LI7=0 F  S LI7=$O(^IBA(364.7,"B",LI6,LI7)) Q:'LI7  D
 .... D DISP(LI6,LI7)    ; display data before deletion
 .... S DIK="^IBA(364.7,",DA=LI7 D ^DIK
 .... Q
 ... S DIK="^IBA(364.6,",DA=LI6 D ^DIK
 ... Q
 .. Q
 . ;
 . ; delete the local form if there are no more overrides
 . I '$D(^IBA(364.6,"APAR",FORM)) S DIK="^IBE(353,",DA=FORM D ^DIK
 . Q
 ;
 I '$G(^TMP($J,IBY)) G DELLOCX    ; no message data to send
 ;
 ; send message
 S XMDUZ=DUZ
 S XMSUBJ="Removal of local output formatter overrides (IB*2*320)"
 S XMBODY="^TMP($J,"""_IBY_""")"
 S XMTO(DUZ)=""
 S XMTO("G.IB EDI SUPERVISOR")=""
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO)
 KILL ^TMP($J,IBY)
DELLOCX ;
 Q
 ;
DISP(LI6,LI7) ; Display output formatter data on screen and in install file
 ; LI6 - local ien to file 364.6
 ; LI7 - local ien to file 364.7
 NEW LD6,NI6,ND6,LD70,LD71,INS,LDC,MSG,Q,ZLN,FIEN,FL,GG
 S LD6=$G(^IBA(364.6,LI6,0)),NI6=+$P(LD6,U,3),ND6=$G(^IBA(364.6,NI6,0))
 S LD70=$G(^IBA(364.7,LI7,0)),LD71=$G(^IBA(364.7,LI7,1))
 S INS=$$INSCO^IBCNSC02(+$P(LD70,U,5)),FIEN=+$P(LD6,U,1)
 M LDC=^IBA(364.7,LI7,3)
 S MSG(1)="Removing local output formatter field:  Sequence# "
 S MSG(1)=MSG(1)_$P(ND6,U,4)_", Piece# "_$P(ND6,U,8)
 S MSG(2)=$$FO^IBCNEUT1("  Local 364.6 ien="_LI6,25)
 S MSG(2)=MSG(2)_"- "_$P(LD6,U,10)
 S MSG(3)=$$FO^IBCNEUT1("  Nat'l 364.6 ien="_NI6,25)
 S MSG(3)=MSG(3)_"- "_$P(ND6,U,10)
 S MSG(4)="  Local 364.7 ien="_LI7
 S MSG(5)="          Form:  "_$$EXTERNAL^DILFD(364.6,.01,,$P(LD6,U,1))_"  ("_$P(LD6,U,1)_")"
 S MSG(6)="  Data Element:  "_$$EXTERNAL^DILFD(364.7,.03,,$P(LD70,U,3))
 S MSG(7)="  Ins. Company:  "_$E(INS,1,53)
 S MSG(8)=$J("",44)_$E(INS,54,99)
 S MSG(9)="     Bill Type:  "_$$EXTERNAL^DILFD(364.7,.06,,$P(LD70,U,6))
 S MSG(10)="   Format Code:  "_LD71
 S MSG(11)="   Description:  "_$G(LDC(1,0))
 S Q=1,ZLN=11 F  S Q=$O(LDC(Q)) Q:'Q  S ZLN=ZLN+1,MSG(ZLN)="                 "_$G(LDC(Q,0))
 S ZLN=ZLN+1,MSG(ZLN)="--------------------------------------------------------------------------"
 S ZLN=ZLN+1,MSG(ZLN)=""
 ;
 ; update mailman message array
 S GG=+$G(^TMP($J,IBY))
 F FL=1:1:ZLN S GG=GG+1,^TMP($J,IBY,GG)=$G(MSG(FL)),^TMP($J,IBY)=GG
 ;
 D MES^XPDUTL(.MSG)
DISPX ;
 Q
 ;
DELFRM(FORM) ; Delete the local form and all entries in files 364.6 & 364.7
 NEW I6,I7,DIK,DA
 I '$G(FORM) G DELFRMX
 S I6=0 F  S I6=$O(^IBA(364.6,"B",FORM,I6)) Q:'I6  D
 . S I7=0 F  S I7=$O(^IBA(364.7,"B",I6,I7)) Q:'I7  D
 .. D DISP(I6,I7)   ; display data before deletion
 .. S DIK="^IBA(364.7,",DA=I7 D ^DIK
 .. Q
 . S DIK="^IBA(364.6,",DA=I6 D ^DIK
 . Q
 S DIK="^IBE(353,",DA=FORM D ^DIK
DELFRMX ;
 Q
 ;
DELLIST ; delete existing list templates which are included in the build
 NEW LST,DIK,DA
 S DIK="^SD(409.61,"
 S LST="IBCE PRVFAC MAINT",DA=$O(^SD(409.61,"B",LST,0)) I DA D ^DIK
 S LST="IBCE PRVMAINT",DA=$O(^SD(409.61,"B",LST,0)) I DA D ^DIK
 S LST="IBCE PRVNVA MAINT",DA=$O(^SD(409.61,"B",LST,0)) I DA D ^DIK
 S LST="IBCE PRVPRV MAINT",DA=$O(^SD(409.61,"B",LST,0)) I DA D ^DIK
 S LST="IBCE VIEW PREV TRANS1",DA=$O(^SD(409.61,"B",LST,0)) I DA D ^DIK
 S LST="IBCE VIEW PREV TRANS2",DA=$O(^SD(409.61,"B",LST,0)) I DA D ^DIK
 S LST="IBCEM CSA LIST",DA=$O(^SD(409.61,"B",LST,0)) I DA D ^DIK
 S LST="IBCEM CSA MSG",DA=$O(^SD(409.61,"B",LST,0)) I DA D ^DIK
DELLISTX ;
 Q
 ;
EMAIL ; This procedure generates and sends a message about the pre-patch 320
 ; entries in file 355.97 - provider ID types
 NEW IEN,DATA,Z1,Z2,Z4,IBX,ZLN,MSG,XMDUZ,XMSUBJ,XMBODY,XMTO,BFLG,IBZ
 S IEN=0,BFLG=0
 F  S IEN=$O(^IBE(355.97,IEN)) Q:'IEN  D
 . S DATA=$G(^IBE(355.97,IEN,0))
 . I $P($G(^IBE(355.97,IEN,1)),U,4) S $P(DATA,U,4)=$P($G(^IBE(350.9,1,1)),U,5)    ; federal tax id#
 . S Z2=$S($P(DATA,U,2)=0:0,$P(DATA,U,2)=2:2,1:"OTHER")
 . S Z1=$P(DATA,U,1) I Z1="" S Z1="~Unknown"
 . S Z4=" "_$P(DATA,U,4)
 . S IBX(Z2,Z1,Z4)=""
 . I $O(^IBE(355.97,"B",Z1,""))'=$O(^IBE(355.97,"B",Z1,""),-1) S BFLG=1
 . Q
 ;
 S MSG(1)="This message is generated by the pre-install routine for IB patch 320 which"
 S MSG(2)="is eClaims Plus Iteration 2."
 S MSG(3)=""
 S MSG(4)="This patch removes the ability to view or edit the IDs that were previously"
 S MSG(5)="defined in Set #14 of the IB Site Parameters and also in the Provider ID"
 S MSG(6)="Maintenance option, Selection #3."
 S MSG(7)=""
 S MSG(8)="This message is being generated to capture a snapshot of what this data"
 S MSG(9)="looked like prior to the installation of IB patch 320."
 S MSG(10)=""
 S MSG(11)="If any of these IDs are still needed, then they may be defined by using the"
 S MSG(12)="Additional IDs screen in the Insurance Company Editor --> Provider IDs/ID"
 S MSG(13)="Parameters.   The correct Medicare numbers will be automatically populated"
 S MSG(14)="by the software.  The default UPIN for Medicare can be defined in the"
 S MSG(15)="Provider ID Maintenance option, Selection #2 as the insurance company"
 S MSG(16)="default if it is not already there."
 S MSG(17)=""
 S MSG(18)="Provider ID Type                Provider ID"
 S MSG(19)="----------------------------------------------------------------"
 ;
 S ZLN=19
 F Z2=2,0,"OTHER" S Z1="" F  S Z1=$O(IBX(Z2,Z1)) Q:Z1=""  S Z4="" F  S Z4=$O(IBX(Z2,Z1,Z4)) Q:Z4=""  D
 . S ZLN=ZLN+1,MSG(ZLN)=$$FO^IBCNEUT1(Z1,30)_":"_Z4
 . Q
 ;
 ; send message
 S XMDUZ=DUZ
 S XMSUBJ="Legacy Billing Provider Secondary IDs and ID Types (IB*2*320)"
 S XMBODY="MSG"
 S XMTO(DUZ)=""
 S XMTO("G.IB EDI SUPERVISOR")=""
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO)
 ;
 ; send another msg if duplicate data found
 I 'BFLG G EMAILX
 ;
 K MSG,XMTO S MSG(1)="Site Identification:  "_$$SITE^VASITE(),MSG(2)=""
 ;
 S IBZ="^IBE(355.97)",ZLN=2
 F  S IBZ=$Q(@IBZ) Q:IBZ'[355.97  D
 . I $P(IBZ,",",3)="1)" Q
 . S ZLN=ZLN+1
 . S MSG(ZLN)=IBZ_" = "_$G(@IBZ)
 . Q
 ;
 ; send message
 S XMDUZ=DUZ
 S XMSUBJ="Duplicate Data found in file 355.97 (IB*2*320)"
 S XMBODY="MSG"
 S XMTO("Bill.Jutzi@domain.ext")=""
 S XMTO("Eric.Gustafson@domain.ext")=""
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO)
 ;
EMAILX ;
 Q
 ;
DELXREFS ;
 D BMES^XPDUTL("Removing triggers")
 D DELIX^DDMOD(399.0222,.05,2)
 N III F III=.06,.07,.12,.13,.14 D DELIX^DDMOD(399.0222,III,1)
 D MES^XPDUTL("Done")
 ;
