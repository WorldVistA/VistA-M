ORY46 ;SLC/MKB-Preinit for patch OR*3*46;04:21 PM  12 Feb 1999
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**46**;Dec 17, 1997
 ;
PRE ; -- Reset $H in ^XUTL("XQORM","#;ORD(101.41,",0) to force rebuilding
 ;
 Q:$O(^ORD(101,"B","ORCM DISABLE",0))  ;quit if previously installed
 N ORM,ORH S ORH=$H
 S ORM="" F  S ORM=$O(^XUTL("XQORM",ORM)) Q:ORM=""  I ORM?1.N1";ORD(101.41," S ^(ORM,0)=ORH
 Q
 ;
POST ; -- Reset ID WRITE node for Items, repl - with AD on alert menu
 ;
 N DA,DR,DIE,X,Y,ORX
 S ^DD(101.412,0,"ID","WRITE")="N OR0,ORNM S OR0=^(0) I $P(OR0,U,2) S ORNM=$P($G(^ORD(101.41,+$P(OR0,U,2),0)),U) D:$L(ORNM) EN^DDIOL(ORNM,,""?10"")"
 S DA(1)=+$O(^ORD(101,"B","ORCB NOTIFICATIONS",0)),ORX=+$O(^ORD(101,"B","ORC PREVIOUS SCREEN",0)),DA=+$O(^ORD(101,DA(1),10,"B",ORX,0)) Q:'DA
 S ORX=+$O(^ORD(101,"B","ORC ADD ORDERS",0)) Q:'ORX
 S DIE="^ORD(101,"_DA(1)_",10,",DR=".01////"_ORX_";2///AD" D ^DIE
 Q
