GECSPOST ;WISC/RFJ-version 2 post-init                              ;28 Jun 94
 ;;2.0;GCS;;MAR 14, 1995
 N %,D,DA,DIK,X,Y
 ;  clean out data in file 2101.4 (template maps) which are not
 ;  used in version 2
 S X=^GECS(2101.4,0) K ^GECS(2101.4) S ^GECS(2101.4,0)=$P(X,"^",1,2)
 ;  clean out data in file 2101.6 (lock display)
 S X=^GECS(2101.6,0) K ^GECS(2101.6) S ^GECS(2101.6,0)=$P(X,"^",1,2)
 ;
 ;  remove 'gecs batch edit' input template which is no longer used
 S DA=+$O(^DIE("F2100","GECS BATCH EDIT",0)) I DA S DIK="^DIE(" D ^DIK
 ;
 ;  remove 2101.6, field 1 locked
 I $D(^DD(2101.6,1)) S DIK="^DD(2101.6,",DA(1)=2101.6,DA=1 D ^DIK
 ;
 ;  remove 2101.7, field 2 days to retain code sheets
 S %=0 F  S %=$O(^GECS(2101.7,%)) Q:'%  I $D(^(%,0)) S $P(^(0),"^",3)=""
 I $D(^DD(2101.7,2)) S DIK="^DD(2101.7,",DA(1)=2101.7,DA=2 D ^DIK
 ;
 ;  remove 2100, field .7 batch type
 I $D(^DD(2100,.7)) S DIK="^DD(2100,",DA(1)=2100,DA=.7 D ^DIK
 ;
 ;  change yes/no for consistency
 ;  file 2101.7, field 1 primary site
 S %=0 F  S %=$O(^GECS(2101.7,%)) Q:'%  S D=$P($G(^(%,0)),"^",2) I D'="" S $P(^(0),"^",2)=$S(D=1:"Y",1:"N")
 ;
 ;  repoint pointer fields for transported file entries
 S GECSFIX=1 D GO^GECSVFY0
 D PATCH^GECSPOS1
 Q
