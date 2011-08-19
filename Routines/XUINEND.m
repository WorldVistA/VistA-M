XUINEND ;SF-ISC/STAFF - Post Install for KERNEL V8.0 ;04/24/95  10:36
 ;;8.0;KERNEL;;Jul 10, 1995
 ;setup checkpoints for KIDS
 N %
 S %=$$NEWCP^XPDUTL("POST1","SITE^XUINEND"),%=$$NEWCP^XPDUTL("POST2","ALERT^XUINEND")
 S %=$$NEWCP^XPDUTL("POST3","ALPHA^XUINEND"),%=$$NEWCP^XPDUTL("POST4","SCHED^XUINEND")
 S %=$$NEWCP^XPDUTL("POST5","XUF^XUINEND"),%=$$NEWCP^XPDUTL("POST6","PARAM^XUINEND")
 S %=$$NEWCP^XPDUTL("POST7","NPF^XUINEND"),%=$$NEWCP^XPDUTL("POST8","HELP^XUINEND")
 Q
SITE N %,DA,DIC,DIK,XUNEW
 ;See that postmaster has an entry in file 200.
 I '$D(^VA(200,.5,0)) D
 . S ^DIC(3,.5,0)="POSTMASTER^^^^^^^^^^^^^^^.5",^DIC(16,.5,0)="POSTMASTER",^("A3")=.5
 . S ^VA(200,.5,0)="POSTMASTER",DIK="^VA(200,",DA=.5
 . D IX1^DIK
 . Q
 D MES^XPDUTL(" Move KERNEL site parameters.")
 I $D(^XTV(8989.3,1,0)),$G(^XTV(8989.3,1,4,0))'[8989 K ^XTV(8989.3,1)
 Q:$D(^XTV(8989.3,1))
 ;S XUNEW="+?1," D TRNMRG^DIT("OX",4.3,8989.3,"1,",.XUNEW)
 ;Merge and set count
 M ^XTV(8989.3,1)=^XMB(1,1) S $P(^XTV(8989.3,0),U,3,4)="1^1"
 ;kill the Mailman Purge date information
 K ^XTV(8989.3,1,.1)
 S I=0 F  S I=$O(^XTV(8989.3,1,I)) Q:I=""  D:$D(^(I,0))
 .S J=+$O(^DD(8989.3,"GL",I,0,0))
 .Q:'$D(^DD(8989.3,J,0))  S K=$P(^(0),U,2)
 .I K,$D(^DD(+K,.01,0)),$P(^(0),U,2)'["W" S $P(^XTV(8989.3,1,I,0),U,2)=K
 S $P(%,U,17)=$P($G(^XMB(1,1,"XUS")),U,17),^XMB(1,1,"XUS")=% ;delete all but default inst.
 K ^XMB(1,1,"INTRO") ;Remove Intro text
 Q
 ;
ALERT N I,X,Y
 D MES^XPDUTL("  Moving ALERTS from file 200 to file 8992 ...")
 F I=0:0 S I=$O(^VA(200,I)) Q:I'>0  D
 . I $O(^VA(200,I,"XQA",0))>0 D
 . . I '$D(^XTV(8992,I)) S X="`"_I D
 . . . N I,DIC,DLAYGO
 . . . S DIC="^XTV(8992,",DIC(0)="L",DLAYGO=8992 D ^DIC
 . . M ^XTV(8992,I,"XQA")=^VA(200,I,"XQA")
 . K ^VA(200,I,"XQA")
 M ^XTV(8992,"AXQA")=^VA(200,"AXQA") K ^VA(200,"AXQA")
 M ^XTV(8992,"AXQAN")=^VA(200,"AXQAN") K ^VA(200,"AXQAN")
 S I="" F  S I=$O(^XTV(8992,"AXQA",I)) Q:I'>0  K ^(I,0,0)
 Q
 ;
ALPHA N DA,DIK
 D MES^XPDUTL(" Delete CPU field from alpha/beta test sites")
 I $P($G(^DD(3.5,1.92,0)),"^")="CPU" S DIK="^DD(3.5,",DA=1.92,DA(1)=3.5 D ^DIK ;Delete CPU field from alpha/beta test sites.
 Q
 ;
SCHED D MES^XPDUTL(" Option Scheduling conversion."),^XUINTSK
 Q
OPT N D0,DIK
 D MES^XPDUTL(" Reindex Entry/Exit Actions in Option file.")
 F D0=0:0 S D0=$O(^DIC(19,D0)) Q:D0'>0  I '$D(^(D0,0)) K ^DIC(19,D0)
 S DIK="^DIC(19,",DIK(1)="15^1" D ENALL^DIK
 K DIK S DIK="^DIC(19,",DIK(1)="20^1" D ENALL^DIK
 Q
 ;
XUF N DIU,DIK,XU1
 D MES^XPDUTL(" Check and clean out XUFILE if not running FOF.")
 I '$D(^VA(200,"AFOF")) D DISABLE^XUFILE3
 Q
 ;
PARAM N IX
 D MES^XPDUTL(" Load PARAM file")
 F IX="XUEDIT CHARACTERISTICS","XUNEW USER","XUSER COMPUTER ACCOUNT","XUREACT USER","XUEXISTING USER" I $$GET^XUPARAM(IX,"V")="" D SET^XUPARAM(IX,"")
MES D MES^XPDUTL($C(7)_"TO PROTECT THE SECURITY OF DHCP SYSTEMS, DISTRIBUTION OF THIS")
 D MES^XPDUTL("SOFTWARE FOR USE ON ANY OTHER COMPUTER SYSTEM IS PROHIBITED.")
 D MES^XPDUTL("ALL REQUESTS FOR COPIES OF THE KERNEL FOR NON-DHCP USE SHOULD")
 D MES^XPDUTL("BE REFERRED TO YOUR LOCAL ISC.")
 Q
 ;
NPF ;Re-build the Nickname D X-ref.
 N DA,DIK K ^VA(200,"D")
 S DIK="^VA(200,",DIK(1)="13^1" D ENALL^DIK
 Q
REMOXY ;Remove OLD XYCRT FIELD FROM TERMINAL TYPE FILE.
 N DA,DIK
 D MES^XPDUTL("Removing trigger from XY CRT field(#5.2) of the TERMINAL TYPE FILE(#3.2)"_$C(7,7))
 S DIK="^DD(3.2,5.2,1,",DA=1,DA(1)=5.2,DA(2)=3.2 D ^DIK
 K DA,DIK
 D MES^XPDUTL("Removing data from the *OLD XY CRT field(#5) of the TERMINAL TYPE file(#3.2)"_$C(7,7))
 F DA=0:0 S DA=$O(^%ZIS(2,DA)) Q:DA'>0  I $D(^(DA,1))#2 S $P(^(1),"^",5)=""
 K DA
 D MES^XPDUTL("Removing the *OLD XY CRT field(#5) from the TERMINAL TYPE file(#3.2)"_$C(7,7))
 S DIK="^DD(3.2,",DA=5,DA(1)=3.2 D ^DIK
 Q
HELP ;re-index help frame file
 N DA,DIK,XPDI S XPDI=0
 F  S XPDI=$O(^DIC(9.2,XPDI)) Q:'XPDI  D
 .S DA(1)=XPDI,DIK="^DIC(9.2,"_XPDI_",2,",DIK(1)="1^1"
 .D ENALL^DIK
 Q
 ;
A27 ;D MES^XPDUTL("At A27, Calling XUINEACH") D ^XUINEACH ;EACH CPU CODE.
 ;
 ;
A23 D MES^XPDUTL($C(7,7)_"Now to edit the Kernel Site Parameters."_$C(7))
 I '$D(^XTV(8989.3,1,1,0)) W !,"Please select a name for this site" S DIC="^XTV(8989.3,1,",DIC(0)="AEMQL" D ^DIC I Y<1 W *7,"YOU MUST SELECT ONE" G A23
 S DIE="^XTV(8989.3,1,",DA=1,DR="[XU KSP INIT]" D ^DIE
A25 W !,"Now to EDIT selectable terminal types for sign-on"
 F IX=0:0 S DIC="^%ZIS(2,",DIC(0)="AEMQ" D ^DIC Q:Y'>0  S DIE=DIC,DA=+Y,DR=.02 D ^DIE
 Q
