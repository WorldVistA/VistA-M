XQKEY ;Seattle/Luke - Key and lock utilities ;9/14/94  10:49
 ;;8.0;KERNEL;;Jul 10, 1995
ADD(XQKUS,XQKEY,XQKF) ;Give a user a key      
 ;XQKDA = the user's duz, XQKEY = the name or IEN of the key,
 ;XQKF = the success flag: 0:not awarded, 1:successfully
 ;given to the user.
 S XQKF=1
 ;
 I XQKEY'=+XQKEY D
 .S XQKEYT=XQKEY
 .I $O(^DIC(19.1,"B",XQKEYT,0))'>0 S XQKF=0 Q
 .S XQKEY=$O(^DIC(19.1,"B",XQKEYT,0)) I XQKEY'>0 S XQKF=0 Q
 .K XQKEYT
 .Q
 I '$D(^DIC(19.1,XQKEY,0)) S XQKF=0
 ;
 S %=XQKF
 I '% Q %
 ;
 I $D(^VA(200,XQKUS,51,XQKEY)) Q % ;Already has it
 ;
 S XQFDA(200.051,"+1,"_XQKUS_",",.01)=XQKEY
 S XQFDA(200.051,"+1,"_XQKUS_",",1)=DUZ
 S XQFDA(200.051,"+1,"_XQKUS_",",2)=DT
 S XQIEN(1)=XQKEY
 ;
 D UPDATE^DIE("","XQFDA","XQIEN")
 ;
 S %=XQKF
 Q %
 ;
DEL(XQKUS,XQKEY,XQKF) ;Remove a key from a user
 ;Remove a key (XQKEY) from a user (XQKUS) unless it's the
 ;PROVIDER key which is never removed
 ;
 S XQKF=1
 ;
 I XQKEY'=+XQKEY D
 .S XQKEYT=XQKEY
 .I $O(^DIC(19.1,"B",XQKEYT,0))'>0 S XQKF=0 Q
 .S XQKEY=$O(^DIC(19.1,"B",XQKEYT,0)) I XQKEY'>0 S XQKF=0 Q
 .K XQKEYT
 .Q
 I '$D(^DIC(19.1,XQKEY,0)) S XQKF=0
 ;
 S %=XQKF
 I '% Q %
 ;
PROV ;Check for PROVIDER key
 I '$D(^DIC(19.1,"B","PROVIDER")) S XQPROV=0
 E  S XQPROV=$O(^DIC(19.1,"B","PROVIDER",0))
 I XQKEY=XQPROV S %=0 Q %
 ;
 I '$D(^VA(200,XQKUS,51,XQKEY)) Q %  ;Doesn't have it
 ;
 N DA,DIK
 S DA(1)=XQKUS,DA=XQKEY,DIK="^VA(200,"_DA(1)_",51,"
 D ^DIK
 ;
 S %=XQKF
 Q %
