IBDY325 ;ALB/AAS - POST INSTALL FOR PATCH IBD*3*25 ; 23-JUN-97
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**25**;APR 24, 1997
 ;
 D SET,Y2K,DEL
 D UNCOMP,RECOMP
 Q
 ;
 ;
SET ; -- set default values in new encounter form parameters
 N X
 S X=$P($G(^IBD(357.09,1,0)),"^",12,14)
 I X=""!(X="^^") D  ;only update once
 .D MES^XPDUTL(">>> Now setting the default value in new Encounter Form Parameters.")
 .S $P(^IBD(357.09,1,0),"^",12)=5
 .S $P(^IBD(357.09,1,0),"^",13)=12
 .S $P(^IBD(357.09,1,0),"^",14)=25
 Q
 ;
Y2K ; -- update the Checkout date/time AICS DATA ELEMENT entry for Y2K
 N IEN
 S IEN=$O(^IBE(359.1,"B","CHECKOUT DATE@TIME",0)) Q:'IEN
 S $P(^IBE(359.1,IEN,0),"^",5)="______@____"
 S $P(^IBE(359.1,IEN,10),"^",2)="NNNNNNPNNNN"
 S $P(^IBE(359.1,IEN,10),"^",4)="NNNNNNPNNNN"
 Q
 ;
UNCOMP ; -- uncompile all forms --
 N ZTQUEUED
 D MES^XPDUTL(">>> Now uncompiling all Encounter Forms.")
 S ZTQUEUED=1
 D RECMPALL^IBDF19
 D MES^XPDUTL("    Okay, forms will be recompiled as they are printed.")
 Q
 ;
RECOMP ; Recompile all forms in file 359.2
 N C,X,COUNT,CNT,COLWIDTH,IBDFSA,IBFORMID,IBBDT,IBEDT,IBDAY,LBEGIN,LEND,NODE10,POP,PRIORPG,QUIT
 ;
 S IBBDT=$H
 S COUNT=$P(^IBD(359.2,0),"^",4)
 ;
 D MES^XPDUTL(">>> I am going to recompile all "_COUNT_" entries in your FORM SPECS file (359.2)")
 D MES^XPDUTL(">>> Recompilation Started at "_$$HTE^XLFDT(IBBDT))
 D MES^XPDUTL(">>> This may take awhile... (about 5 seconds per entry on an unloaded system)")
 ;
 S CNT=0
 S IBFORMID=0 F  S IBFORMID=$O(^IBD(359.2,IBFORMID)) Q:'IBFORMID  D
 .D SCAN^IBDFBKS(IBFORMID)
 .S CNT=CNT+1
 .I '$D(ZTQUEUED),'(CNT#10) D MES^XPDUTL("    "_CNT_" done, "_(COUNT-CNT)_" to go.")
 ;
 S IBEDT=$H
 D MES^XPDUTL("")
 D MES^XPDUTL(">>> Recompilation Complete at "_$$HTE^XLFDT(IBEDT))
 I $D(IBBDT) D
 .S IBDAY=+IBEDT-(+IBBDT)*86400 ;additional seconds of over midnight
 .S X=IBDAY+$P(IBEDT,",",2)-$P(IBBDT,",",2)
 .D MES^XPDUTL(">>> Elapse time for recompilation was: "_(X\3600)_" Hours,  "_(X\60-(X\3600*60))_" Minutes,  "_(X#60)_" Seconds")
 .S X=(X/COUNT)
 .D MES^XPDUTL(">>> Average Time per Entry was: "_(X\60-(X\3600*60))_" Minutes,  "_(X#60)_" Seconds")
 Q
 ;
DEL ; -- delete unused field
 N DIK,DA,CNT
 S DIK="^DD(357.613,",DA(1)=357.613
 I $D(^DD(357.613,.02)) D
 . S DA=.02,CNT=$G(CNT)+1
 . D ^DIK
 I $D(^DD(357.613,.06)) D
 . S CNT=$G(CNT)+1
 . S DA=.06
 . D ^DIK
 ;
 K DIK,DA
 D:$G(CNT) MES^XPDUTL(">>> Deleted "_$G(CNT)_" unused field"_$S($G(CNT)=1:"",1:"s")_" in the Package Interface File")
 Q
