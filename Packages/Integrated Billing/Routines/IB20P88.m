IB20P88 ; ALB/TMP,RB - IB*2*88 POST-INIT ; 22-DEC-97
 ;;2.0; INTEGRATED BILLING ;**88**; 21-MAR-94
 ;
POST ;
 N CT,DA,DIE,DR,NODE,Z,Z0,Z1
 D BMES^XPDUTL("Restoring PRINTED IB bills to ENTERED/NOT REVIEWED")
 S (CT,DA)=0
 F  S DA=$O(^PRCA(430,"AC",27,DA)) Q:+DA=0  I $P($G(^DGCR(399,DA,0)),U,13)=4 S DIE=399,DR=".13////1" D ^DIE S CT=CT+1
 D BMES^XPDUTL(CT_" IB bill(s) changed from PRINTED status to ENTERED/NOT REVIEWED")
 D BMES^XPDUTL(" ")
 S (CT,Z)=0
 D BMES^XPDUTL("Correcting Bill Type cross reference")
 F  S Z=$O(^IBA(364.7,"ATYPE",Z)) Q:'Z  S Z0="" D
 .F  S Z0=$O(^IBA(364.7,"ATYPE",Z,Z0)) Q:Z0=""  S Z1=0 F  S Z1=$O(^IBA(364.7,"ATYPE",Z,Z0,Z1)) Q:'Z1  S NODE=$G(^IBA(364.7,Z1,0)) D
 ..I $P(NODE,U,6)'=Z0!($P(NODE,U,5)'="") K ^IBA(364.7,"ATYPE",Z,Z0,Z1) S CT=CT+1
 D BMES^XPDUTL(CT_" Erroneous entries deleted")
 D BMES^XPDUTL(" ")
 S (CT,Z)=0
 D BMES^XPDUTL("Correcting Insurance cross reference")
 F  S Z=$O(^IBA(364.7,"AINS",Z)) Q:'Z  S Z0="" D
 .F  S Z0=$O(^IBA(364.7,"AINS",Z,Z0)) Q:Z0=""  S Z1=0 F  S Z1=$O(^IBA(364.7,"AINS",Z,Z0,Z1)) Q:'Z1  S NODE=$G(^IBA(364.7,Z1,0)) D
 ..I $P(NODE,U,5)'=Z0!($P(NODE,U,6)'="") K ^IBA(364.7,"AINS",Z,Z0,Z1) S CT=CT+1
 D BMES^XPDUTL(CT_" Erroneous entries deleted")
 D BMES^XPDUTL(" ")
 D BMES^XPDUTL("Post install steps are complete")
 ;
 Q
