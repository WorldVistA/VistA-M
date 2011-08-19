DVBAYAPE ;ALB/MLI - Clean-up stray APE cross-references ; 2/15/96@1pm
 ;;2.7;AMIE;**4**;Apr 10, 1995
 ;
 ; this routine will queue a process to run which will cleanup
 ; any errant APE cross-references
 ;
EN ; begin processing
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTRTN="DQ^DVBAYAPE",ZTDESC="DVBA*2.7*4 - APE x-ref cleanup process"
 S ZTDTH=XPDQUES("POS001"),ZTIO="",ZTSAVE("DVBAKILL")=""
 D ^%ZTLOAD
 I $D(ZTSK) D BMES^XPDUTL(" APE x-ref cleanup queued...task="_ZTSK)
 Q
 ;
 ;
DQ ; dequeue task (or call in direct mode)
 D CLEAN
 D MAIL
 Q
 ;
 ;
CLEAN ; cleanup data
 S DVBACT=3 ; counter for bad x-refs...start after first 3 lines
 K ^TMP("DVBA*2.7*4",$J)
 D LINE(1,"Start Time of process:  "_$$NOW^XLFDT())
 D LINE(2," ")
 D LINE(3,"Results of search in DA^DFN^Request Date^Exam Type format")
 S DIK="^DVB(396.4,"
 F DFN=0:0 S DFN=$O(^DVB(396.4,"APE",DFN)) Q:'DFN  D
 . S DVBAET=0 ; loop variable for exam type
 . F  S DVBAET=$O(^DVB(396.4,"APE",DFN,DVBAET)) Q:DVBAET=""  D
 . . S DVBARD=0 ; loop variable for request date
 . . F  S DVBARD=$O(^DVB(396.4,"APE",DFN,DVBAET,DVBARD)) Q:'DVBARD  D
 . . . S DA=$O(^DVB(396.4,"APE",DFN,DVBAET,DVBARD,0))
 . . . S DVBA0ND=$G(^DVB(396.4,+DA,0)),DVBAD=0
 . . . I $G(^DVB(396.6,+$O(^DVB(396.6,"B",$E(DVBAET,1,30),0)),0))']"" S DVBAD=1
 . . . I DVBA0ND']""!DVBAD D  ; exam doesn't exist or event type name is bad
 . . . . S DVBACT=DVBACT+1
 . . . . D LINE(DVBACT,DA_"^"_DFN_"^"_DVBARD_"^"_DVBAET)
 . . . . I $G(DVBAKILL)="NO" Q  ; don't cleanup
 . . . . K ^DVB(396.4,"APE",DFN,DVBAET,DVBARD,DA)
 . . . . I DVBA0ND]"" D IX1^DIK ; reindex entry (sets only)
 I DVBACT=3 S DVBACT=DVBACT+1 D LINE(DVBACT,"No bad APE x-refs found!")
 D LINE(DVBACT+1,"End Time:  "_$$NOW^XLFDT())
 I $G(DVBAKILL)="NO" D LINE(DVBACT+2,"NOTHING WAS KILLED!!  D EN^DVBAYAPE TO HAVE KILLS EXECUTED")
 K DA,DFN,DIK,DVBA0ND,DVBACT,DVBAD,DVBAET,DVBARD
 Q
 ;
 ;
LINE(NUMBER,TEXT) ; set data into TMP global for e-mail message
 S ^TMP("DVBA*2.7*4",$J,NUMBER)=TEXT
 Q
 ;
 ;
MAIL ; mail message of results
 N DIFROM
 S XMSUB="DVBA*2.7*4 "_$S($G(DVBAKILL)'="NO":"Cleanup",1:"Diagnostic")_" has run"
 S XMTEXT="^TMP(""DVBA*2.7*4"",$J,"
 S XMY(DUZ)="",XMDUZ=.5
 D ^XMD
 K XMDUZ,XMSUB,XMTEXT,XMY
 Q
 ;
 ;
NOKILL ; don't kill anything
 S DVBAKILL="NO"
 D EN
 K DVBAKILL
 Q
