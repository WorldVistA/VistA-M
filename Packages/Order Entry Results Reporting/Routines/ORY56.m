ORY56 ; SLC/MKB - Postinit for patch OR*3*56 ;5/20/99  15:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**56**;Dec 17, 1997
 ;
POST ; -- Update Nature of Order file, Task job to move OC Messages
 ;
 N DA,DIE,DR,DIK,X,Y,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,MSG
 S DA=$O(^ORD(100.02,"C","E",0)) I $E($G(^ORD(100.02,DA,0)))="P" D
 . S DIE="^ORD(100.02,",DR=".01///ELECTRONICALLY ENTERED" D ^DIE
 . S DA=$O(^ORD(100.02,"C","X",0)) S:DA $P(^ORD(100.02,DA,0),U,3)=1
 Q:'$$EXISTS(100.09,.03)  ;OC fields already converted
 S DIK="^DD(100.09,",DA=.03,DA(1)=100.09 D ^DIK ;remove old field
 S ZTRTN="OCMSG^ORY56",ZTDTH=$H,ZTIO=""
 S ZTDESC="Move Order Checking Messages to new node"
 D ^%ZTLOAD S MSG="Task "_$S($G(ZTSK):"#"_ZTSK,1:"not")_" started."
 D MES^XPDUTL(MSG)
 Q
 ;
EXISTS(FILE,FLD) ; -- Returns 1 or 0, if FLD exists in FILE
 I '$G(FILE)!('$G(FLD)) Q 0
 N ORY,ORZ D FIELD^DID(FILE,FLD,,"LABEL","ORY")
 S ORZ=$L($G(ORY("LABEL")))
 Q ORZ
 ;
OCMSG ; -- Move OC messages to new ^(1) node
 ;
 N ORIFN,ORCK,ORMSG S ORIFN=0
 F  S ORIFN=$O(^OR(100,ORIFN)) Q:ORIFN'>0  I $D(^(ORIFN,9)) S ORCK=0 D
 . F  S ORCK=$O(^OR(100,ORIFN,9,ORCK)) Q:ORCK'>0  S ORMSG=$P($G(^(ORCK,0)),U,3) S:$L(ORMSG) $P(^(0),U,3)="",^(1)=ORMSG
 Q
