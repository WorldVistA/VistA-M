PX10P185 ;ALB/RLC - PX*1.0*185 POST INIT INSTALL
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**185**;Aug 12, 1996;Build 12
 ;
EN ;Update field .08 to "Y" for any records where the field is null
 S HFIEN=0
 F  S HFIEN=$O(^AUTTHF(HFIEN)) Q:'HFIEN  D
 .Q:'$D(^AUTTHF(HFIEN,0))  S NODE=^(0)
 .Q:$P(NODE,U,8)'=""
 .S DIE="^AUTTHF(",DA=HFIEN,DR=".08///Y" D ^DIE
 K HFIEN,NODE,DIE,DA,DR
 Q
