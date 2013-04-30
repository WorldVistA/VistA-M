XUINPCH4 ;ISF/RWF - Post INIT for strong passwords ;03/30/2001  10:41
 ;;8.0;KERNEL;**180**;Jul 10, 1995
 ;;
 Q
POST180 ;Patch XU*8*180 post init
 D KSP,DD,VC
 Q
KSP ;Check site params and reset if needed.
 D GETS^DIQ(8989.3,"1,","202;203;214","","XUIN")
 ;# of Attempts
 S V=5 I $G(XUIN(8989.3,"1,",202))>V S XUIN(8989.3,"1,",202)=V
 ;Lockout time
 S V=10*60 I $G(XUIN(8989.3,"1,",203))<V S XUIN(8989.3,"1,",203)=V
 ;Verify code lifetime
 S V=90 I $G(XUIN(8989.3,"1,",214))>V S XUIN(8989.3,"1,",214)=V
 D UPDATE^DIE("E","XUIN")
 Q
DD ;Remove field 20.5 and 9.23 from file 200
 F DA=9.23,20.5 S DIK="^DD(200,",DA(1)=200 D ^DIK
 ;Now remove any data for field 20.5
 S DA=0
 F  S DA=$O(^VA(200,DA)) Q:DA'>0  I $D(^VA(200,DA,20))#2 S $P(^VA(200,DA,20),U,5)=""
 Q
VC ;See the vcne is empty
 N DA
 S DA=0
 F  S DA=$O(^VA(200,DA)) Q:DA'>0  S $P(^VA(200,DA,0),"^",8)=""
 Q
