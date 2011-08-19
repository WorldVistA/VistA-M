KMPDECH ; OAK/RAK - CM Tools Echo ;4/6/06  08:40
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**5**;Mar 22, 2002
 ;
ECHO ;-entry point
 ;
 N DATA,I,ID,SITE,SITENM,TEXT,TRANSTO,XMDUZ,XMSUB,XMTEXT,XMY
 ;
 ; get id from subject
 S ID=$P($G(XQSUB),"~",2)
 ; scheduled downtime start and stop times
 S DATA=$P($G(^KMPD(8973,1,5)),U,1,2)
 ; site info
 S SITE=$$SITE^VASITE Q:SITE=""
 S SITENM=$P(SITE,U,2)
 S XMDUZ="ECHO BACK FROM "_SITENM
 S XMSUB="CP ECHO~"_ID_"~"_$P(SITE,U,2)_" ("_$P(SITE,U,3)_")~"
 D TRANSTO^KMPDUTL7(1,5,.TRANSTO) Q:'$D(TRANSTO)
 S I=""
 F  S I=$O(TRANSTO(I)) Q:I=""  S XMY(I)=""
 S TEXT(1)="START="_$P(DATA,U)
 S TEXT(2)="STOP="_$P(DATA,U,2)
 S XMTEXT="TEXT("
 D ^XMD
 Q
