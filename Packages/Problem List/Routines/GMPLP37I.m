GMPLP37I ; SLC/MKB/KER -- Save Problem List data ; 10/01/2008
 ;;2.0;Problem List;**37**;Aug 25, 1994;Build 1
 ;
 ; External References
 ;
FIND(ACTION) ;
 N ARRAY,CNT,DAT,IEN,PL,PRI,PT,STAT
 S CNT=0
 S PT=0 F  S PT=$O(^PXRMINDX(9000011,"PSPI",PT)) Q:PT'>0  D
 .S STAT=""
 .F  S STAT=$O(^PXRMINDX(9000011,"PSPI",PT,STAT)) Q:STAT=""  D
 ..I '$D(^PXRMINDX(9000011,"PSPI",PT,STAT,0)) Q
 ..S PL=0
 ..F  S PL=$O(^PXRMINDX(9000011,"PSPI",PT,STAT,0,PL)) Q:PL'>0  D
 ...S DAT=0
 ...F  S DAT=$O(^PXRMINDX(9000011,"PSPI",PT,STAT,0,PL,DAT)) Q:DAT'>0  D
 ....S IEN=0
 ....F  S IEN=$O(^PXRMINDX(9000011,"PSPI",PT,STAT,0,PL,DAT,IEN)) Q:IEN'>0  D
 .....S CNT=CNT+1
 .....I ACTION=1 S ARRAY(CNT)=IEN
 I ACTION=1 D UPD(.ARRAY)
 Q CNT
 ;
POST ;
 N ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTIO,TEXT,ZTSK
 S ZTDESC="Correction to the Priority field in the PROBLEM file"
 S TEXT=ZTDESC_" has been queued, task number "
 S ZTRTN="QUEUED^GMPLP37I"
 S ZTIO=""
 S ZTDTH=$$NOW^XLFDT
 S ZTREQ="@"
 D ^%ZTLOAD
 I $D(ZTSK) S TEXT=TEXT_ZTSK D MES^XPDUTL(.TEXT)
 Q
QUEUED ;
 N ARRAY,AFTER,BEFORE,CHANGE,CNT
 S CNT=0
 S BEFORE=$$FIND(0)
 I BEFORE=0 D  G SEND
 .S CNT=CNT+1,ARRAY(CNT,0)="No invalid entries found in the PROBLEM file."
 S CNT=CNT+1,ARRAY(CNT,0)="Initial count of invalid entries in the PROBLEM file."
 S CNT=CNT+1,ARRAY(CNT,0)="   "_BEFORE_" Invalid entries in the PROBLEM file."
 S CNT=CNT+1,ARRAY(CNT,0)=" "
 S CHANGE=$$FIND(1)
 S CNT=CNT+1,ARRAY(CNT,0)="Number of entries that were change."
 S CNT=CNT+1,ARRAY(CNT,0)="  "_CHANGE_" entries in the PROBLEM file corrected."
 S CNT=CNT+1,ARRAY(CNT,0)=" "
 S AFTER=$$FIND(0)
 S CNT=CNT+1,ARRAY(CNT,0)="Count of entries that are still invalid."
 S CNT=CNT+1,ARRAY(CNT,0)="  "_AFTER_" Invalid entries in the PROBLEM file."
 ;
SEND ;mailman
 N NL,XMDUZ,XMY,XMZ
 S XMSUB="Correction of invalid entries in the PROBLEM file"
 S XMDUZ=0.5
 ;
RETRY ;Get the message number.
 D XMZ^XMA2
 I XMZ<1 G RETRY
 ;
 ;Load the message
 M ^XMB(3.9,XMZ,2)=ARRAY
 S NL=$O(^XMB(3.9,XMZ,2,""),-1)
 S ^XMB(3.9,XMZ,2,0)="^3.92^"_+NL_U_+NL_U_DT
 ;
 ;Send message to USER
 S XMY(DUZ)="" D ENT1^XMD Q
 Q
 ;
UPD(ARRAY) ;
 N CNT,DA,DIE,DR
 S DIE="^AUPNPROB(",DR="1.14///@"
 S CNT=0 F  S CNT=$O(ARRAY(CNT)) Q:CNT'>0  D
 .S DA=ARRAY(CNT)
 .D ^DIE
 Q
