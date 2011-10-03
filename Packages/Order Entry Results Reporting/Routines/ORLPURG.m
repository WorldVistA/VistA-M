ORLPURG ; slc/dcm - Purge Patient Lists ;8/13/90  12:27
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
EN ;Purge lists for terminated users
 S ORPERS=0 F I=0:0 S ORPERS=$O(^OR(100.21,"C",ORPERS)) Q:ORPERS=""  D 3
 K ORPERS,ORLST,DA,DIK
 Q
3 Q:'$D(^VA(200,ORPERS))  Q:'$P(^(ORPERS,0),"^",11)  Q:$P($P(^(0),"^",11),".")'<DT
 S ORLST=0 F I=0:0 S ORLST=$O(^OR(100.21,"C",ORPERS,ORLST)) Q:ORLST=""  D 4
 Q
4 S DA(1)=ORLST,DA=ORPERS,DIE="^OR(100.21,"_DA(1)_",1,",DR=".01///@;1///@" D ^DIE
 I '$O(^OR(100.21,ORLST,1,0)) K DA S DA=ORLST,DIK="^OR(100.21," D ^DIK
 K DA S DIE="^VA(200,",DA=ORPERS,DR="100.14///@;100.15///@;100.16///@;100.17///@;100.18///@;100.19///@;100.21///@;100.22///@" D ^DIE
 Q
