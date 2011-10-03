LR7OV3 ;slc/dcm - Update file 60 with Blood Component Request (66.9) ;8/11/97
 ;;5.2;LAB SERVICE;**121**;Sep 27, 1994
 ;
EN ;Start here to load Blood Product Requests from file 66.9
 N IFN,IFN1,IFN2,X,X1,Y,SPEC,CTR,LAST,DIK,DA,EDIT,RCOM
 I $O(^LAB(60,"B","TRANSFUSION REQUEST",0)) S X=$O(^(0)),SPEC=$P(^LAB(60,X,0),"^",9)
 I '$G(SPEC) S SPEC=$O(^LAB(62,"B","BLOOD",0))
 S EDIT=$O(^LAB(62.07,"B","LRBLSCREEN",0)),RCOM=$O(^LAB(62.07,"B","TRANSFUSION",0))
LOCK L +^LAB(60):360 G:'$T LOCK
 S IFN=0,LAST=$P(^LAB(60,0),"^",3,4) F  S IFN=$O(^LAB(66.9,IFN)) Q:IFN<1  S X=^(IFN,0) I '$D(^LAB(60,"B",$P(X,"^"))) D
 . S IFN1=$S(+$P(^LAB(60,0),"^",3)<1100:+$P(^(0),"^",3),1:1100) F  Q:'$D(^LAB(60,IFN1))  S IFN1=IFN1+1
 . S LAST=(+IFN1)_"^"_($P(LAST,"^",2)+1)
 . S ^LAB(60,IFN1,0)=$P(X,"^")_"^^I^BB^^^^1^"_SPEC_"^^^^^"_EDIT_"^^1^0^9^"_RCOM,^(.1)="BP-"_$E($P(X,"^"),1,4),^(12)=IFN I SPEC S ^(3,0)="^60.03PAI^1^1",^(1,0)=SPEC_"^^^10",^LAB(60,IFN1,3,"AB",SPEC,1)="",^LAB(60,IFN1,3,"B",SPEC,1)=""
 . I $G(DUZ(2)) S ^LAB(60,IFN1,8,0)="^60.11PA^"_DUZ(2)_"^1",^LAB(60,IFN1,8,DUZ(2),0)=DUZ(2)_"^"_$O(^LRO(68,"B","BLOOD BANK",0))
 . S DA=IFN1,DIK="^LAB(60," D IX^DIK
 S $P(^LAB(60,0),"^",3,4)=LAST L -^LAB(60)
 Q
DEL ;Delete components out of file 60 (for testing only)
 N IFN,X,DA,DIK
 S IFN=0 F  S IFN=$O(^LAB(60,IFN)) Q:IFN<1  I $D(^(IFN,12)),+^(12) S DA=IFN,DIK="^LAB(60," D ^DIK W "."
 Q
POS ;Post init for future blood bank patch, when/if ordering components
 N LRCHK
 S LRCHK=$$NEWCP^XPDUTL("P1","P1^LR7OV3")
 Q
P1 ;Post init entry point
 D BMES^XPDUTL("Now adding Blood Component Requests to Lab Test file...")
 D EN
 D MES^XPDUTL("Done adding Blood Component Requests")
 Q
