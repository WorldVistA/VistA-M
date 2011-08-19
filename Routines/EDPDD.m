EDPDD ;SLC/KCM - Test Update ED Log - Update
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
ISGONE(STS) ;
 Q STS=$O(^EDPB(233.1,"B","edp.status.gone",0))
 ;
LFS ; Local form set logic from code field
 N LST,X0,NM,ABB
 S LST=$P(^EDPB(233.2,DA(1),0),U)
 S X0=$G(^EDPB(233.2,DA(1),1,DA,0))
 S NM=$P(X0,U,4),ABB=$P(X0,U,5)
 Q:LST=""  Q:X=""
 S ^EDPB(233.2,"AS",LST,X,DA)=ABB_U_NM
 Q
LFK ; Local form kill logic from code field
 N LST
 S LST=$P(^EDPB(233.2,DA(1),0),U)
 S CODE=$P(^EDPB(233.2,DA(1),1,DA,0),U,2)
 Q:LST=""  Q:X=""
 K ^EDPB(233.2,"AS",LST,X,DA)
 Q
LFS1 ; Local form set logic from name, abbreviation
 N X0,LST,CODE,NM,ABB
 S LST=$P(^EDPB(233.2,DA(1),0),U)
 S X0=$G(^EDPB(233.2,DA(1),1,DA,0))
 S CODE=$P(X0,U,2),NM=$P(X0,U,4),ABB=$P(X0,U,5)
 Q:LST=""  Q:CODE=""
 S ^EDPB(233.2,"AS",LST,CODE,DA)=ABB_U_NM
 Q
LFK1 ; Local form kill logic name, abbreviation
 N LST,CODE
 S LST=$P(^EDPB(233.2,DA(1),0),U)
 S CODE=$P($G(^EDPB(233.2,DA(1),1,DA,0)),U,2)
 Q:LST=""  Q:CODE=""
 K ^EDPB(233.2,"AS",LST,CODE,DA)
 Q
