DVBA215P ;ALB/JDG - DVBA C PURGE OFF;6/20/2019
 ;;2.7;AMIE;**215**;Oct 20, 2000;Build 4
 ;
 ; Call to RTN^%ZTLOAD supported by ICR #10063
 ; Call to DQ^%ZTLOAD supported by ICR #10063
 ; Call to KILL^%ZTLOAD supported by ICR #10063
 ; Call to OWNSKEY^XUSRB supported by ICR #3277
 ; Call to BMES^XPDUTL supported by ICR #10141
 ;
 Q
 ;
EN ; entry point for post install routine
 D TASKOFF
 D BADXRFDL
 Q
 ;
TASKOFF ;unschedules and deletes DVBA C PURGE 2507 tasks 
 N DVBOPTN,DVBLIST,DVBKEY,DVBRET,ZTSK
 S DVBKEY="ZTMQ" D OWNSKEY^XUSRB(.DVBRET,DVBKEY) I '$G(DVBRET(0)) D BMES^XPDUTL("The Installer MUST be assigned Security Key 'ZTMQ'.") D  Q
 .D BMES^XPDUTL("Please add the key to yourself using Allocation of Security Keys [ORLEASE] menu option.")
 .D BMES^XPDUTL("Then, either re-install this patch, or re-run this post install routine from the command prompt.")
 S DVBOPTN="DVBA C PURGE 2507",DVBLIST="^TMP(""DVBLIST"",$J)"
 D OPTION^%ZTLOAD(DVBOPTN,DVBLIST)
 I '$O(^TMP("DVBLIST",$J,0)) D BMES^XPDUTL("No DVBA C PURGE 2507 tasks found.") Q
 S ZTSK=0 F  S ZTSK=$O(^TMP("DVBLIST",$J,ZTSK)) Q:'ZTSK  D
 .D DQ^%ZTLOAD I $G(ZTSK(0)) D BMES^XPDUTL("Task number "_ZTSK_" has been successfully un-scheduled.")
 .I '$G(ZTSK(0)) D BMES^XPDUTL("Task number "_ZTSK_" could not be un-scheduled. Please use Taskman Management [XUTM MGR] to un-schedule the task.")
 .D KILL^%ZTLOAD I $G(ZTSK(0)) D BMES^XPDUTL("Task number "_ZTSK_" has been successfully deleted.")
 .I '$G(ZTSK(0)) D BMES^XPDUTL("Task number "_ZTSK_" could not be deleted. Please use Taskman Management [XUTM MGR] to delete the task.")
 Q
 ;
BADXRFDL ;removal of bad AH x-ref
 N DVBCNT,DVBDTE,DVBIEN
 D BMES^XPDUTL("Searching for corrupt entries within the DATE STATUS LAST CHANGED (AH)")
 D BMES^XPDUTL("cross-reference of the 2507 REQUEST (#396.3) file...")
 S DVBCNT=0
 S DVBDTE=0 F  S DVBDTE=$O(^DVB(396.3,"AH",DVBDTE)) Q:'DVBDTE  D
 .S DVBIEN=0 F  S DVBIEN=$O(^DVB(396.3,"AH",DVBDTE,DVBIEN)) Q:'DVBIEN  D
 ..I '$D(^DVB(396.3,DVBIEN,0)) S DVBCNT=DVBCNT+1 K ^DVB(396.3,"AH",DVBDTE,DVBIEN)
 I DVBCNT=0 D BMES^XPDUTL("There were no corrupt entries found in the 2507 REQUEST (#396.3) file.") Q
 D BMES^XPDUTL(DVBCNT_" corrupt entries have been removed from the 2507 REQUEST (#396.3) file.")
 Q
