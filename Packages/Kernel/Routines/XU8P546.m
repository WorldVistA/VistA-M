XU8P546 ;ISF/RWF - Patch XU-546 Pre/Post init ;10/06/10  16:07
 ;;8.0;KERNEL;**546**;;Build 9
 ;Fall into
ENV ;Environment Check
 N HG,DA,IX,ZTSK,ZTDTH,FIRST,X,Y
 S IX=0,U="^"
 F  S IX=$O(^%ZIS(1,"AHG",IX)),DA=0 Q:'IX  F  S DA=$O(^%ZIS(1,"AHG",IX,DA)) Q:'DA  S HG(DA)=0
 Q:'$D(HG)
 W !,"The following Devices have entries in the HUNT GROUP Multiple (that is"
 W !,"to be deleted) and will need to addressed before installing the patch.",!
 S DA=0
 F  S DA=$O(HG(DA)) Q:'DA  D SHOW1(DA)
 S ZTDTH=0,FIRST=1
 F  S ZTDTH=$O(^%ZTSCH(ZTDTH)),ZTSK=0 Q:'ZTDTH  D
 . F  S ZTSK=$O(^%ZTSCH(ZTDTH,ZTSK)),IX=0 Q:'ZTSK  S X=$P($P($G(^%ZTSK(ZTSK,.2)),U),";"),Y=$P($G(^(.26)),U) D
 . . F  S IX=$O(HG(IX)) Q:'IX  I X=HG(IX)!(Y=HG(IX)) D LABEL:FIRST,EN^XUTMTP(ZTSK) W !
 . . Q
 . Q
 S:$G(XPDENV)=1 XPDQUIT=2 ;Don't install, Leave global
 Q
 ;
LABEL ;Tasks Lable
 S FIRST=0 D ENV^XUTMUTL
 W !!,"The following tasks use a Hunt Group Device.",!
 Q
 ;
PRE ;
 Q
 ;
POST ;#29 old HG, #30 (3.53) HG Multiple
 N DA,DIK,HG,DIU
 D BMES^XPDUTL("Removing old Hunt Group field (#29).")
 S DA=29,DA(1)=3.5,DIK="^DD(3.5," ;D ^DIK
 D BMES^XPDUTL("Removing Hunt Group Multiple (#30).")
 S DIU=3.53,DIU(0)="SED" D EN^DIU2
 K ^%ZIS(1,"AHG") ;Remove the X-ref.
 D PATCH^ZTMGRSET(546)
 Q
 ;
SHOW1(DA) ;
 N X,X1,I
 S X=$G(^%ZIS(1,DA,0)),X1=$G(^("TYPE")),HG(DA)=$P(X,U)
 W !," Device: "_$P(X,U)_" is type "_X1_" and has the following members."
 S I=0
 F  S I=$O(^%ZIS(1,DA,"HG",I)) Q:'I  S X1=^%ZIS(1,DA,"HG",I,0),X=$G(^%ZIS(1,X1,0)) W !,?5,$P(X,U)
 Q
 ;
