XUP468 ;OIFO-OAKLAND/RM - REPORT OF BACKUP ALERT REVIEWERS ;08/14/2007
 ;;8.0;KERNEL;**468**;Jul 10, 1995;Build 4
 ;This routines is in support of p468.
 Q
RPT1 ;This report will generate a list of active users/providers that hold
 ;the ORES key and backup reviewers for ALERTS.
 N IEN S IEN=0
 F  S IEN=$O(^VA(200,IEN)) Q:'IEN  D
 .I ('$D(^VA(200,IEN,0)))#2 Q  ;Check of zero node
 .Q:'$$ACTIVE^XUSER(IEN)
 .I $D(^XUSEC("ORES",IEN)) D
 ..S ^TMP("XQAL NO BKRV",$J,$P(^VA(200,IEN,0),U),IEN)=""
 ;WRITE REPORT
 N DIC,L,FLDS,BY
 S DIC="^VA(200,",L=0,FLDS="[XQAL NO BKUP REVIEWER]"
 S L(0)=2,BY(0)="^TMP(""XQAL NO BKRV"",$J,"
 D EN1^DIP
 Q
BKRV(IEN) ;WRITE BACKUP REVEIWER
 ;This entry is called from the print template XQAL NO BKUP REVIEWER
 ;and will retieve all backup reveiwer for a provider.  It will also
 ;check to see if the backup reviewer is an active user.
 N XQAA,BKIEN,BKNAME,I
 S BKNAME="",I=0
 D GETBKUP^XQALDEL(.XQAA,IEN)
 I $D(XQAA) S BKIEN=0 F  S BKIEN=$O(XQAA(BKIEN)) Q:'BKIEN  D
 .S I=I+1
 .I ('$D(^VA(200,BKIEN,0)))#2 Q  ;Check of zero node
 .S BKNAME=$P(^VA(200,BKIEN,0),U)
 .I '$$ACTIVE^XUSER(BKIEN) S BKNAME="*"_BKNAME ;for an inactive user
 .W:I>1 !
 .W ?63,BKNAME ;print to report
 Q
