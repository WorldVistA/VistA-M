SD53674P ;ALB/BJR - Un-schedule and Delete CLW and CLU Transmissions ;9/16/2017 2:06 pm
 ;;5.3;Scheduling;**674**;Aug 13, 1993;Build 18
 ; Call to RTN^%ZTLOAD supported by ICR #10063
 ; Call to DQ^%ZTLOAD supported by ICR #10063
 ; Call to KILL^%ZTLOAD supported by ICR #10063
 ; Call to OWNSKEY^XUSRB supported by ICR #3277
 ; Call to BMES^XPDUTL supported by ICR #10141
 Q
EN ;Entry Point for SD*5.3*674 post install routine
 N SDRTN,SDRTN1,SDRTN2,SDLIST,ZTSK,SDKEY,SDRET
 S SDKEY="ZTMQ" D OWNSKEY^XUSRB(.SDRET,SDKEY) I '$G(SDRET(0)) D BMES^XPDUTL("The Installer MUST be assigned Security Key 'ZTMQ'.") D  Q
 .D BMES^XPDUTL("Please add the key to yourself using Allocation of Security Keys [ORLEASE] menu option.")
 .D BMES^XPDUTL("Then, either re-install the patch, or re-run post install routine EN^SS53674P from the command prompt.")
 S SDRTN="RUN^SCRPW74(1)",SDRTN1="RUN^SCRPW74(0)",SDRTN2="RUN^SCRPW74"
 S SDLIST="^TMP(""SDLIST"",$J)"
 D RTN^%ZTLOAD(SDRTN,SDLIST),RTN^%ZTLOAD(SDRTN1,SDLIST),RTN^%ZTLOAD(SDRTN2,SDLIST)
 I '$O(^TMP("SDLIST",$J,0)) D BMES^XPDUTL("No Clinic Utilization (CLU) or Clinic Wait Time (CLW) tasks found.") Q
 S ZTSK=0 F  S ZTSK=$O(^TMP("SDLIST",$J,ZTSK)) Q:'ZTSK  D
 .D DQ^%ZTLOAD I $G(ZTSK(0)) D BMES^XPDUTL("Task number "_ZTSK_" has been successfully un-scheduled.")
 .I '$G(ZTSK(0)) D BMES^XPDUTL("Task number "_ZTSK_" could not be un-scheduled. Please use Taskman Management [XUTM MGR] to un-schedule the task.")
 .D KILL^%ZTLOAD I $G(ZTSK(0)) D BMES^XPDUTL("Task number "_ZTSK_" has been successfully deleted.")
 .I '$G(ZTSK(0)) D BMES^XPDUTL("Task number "_ZTSK_" could not be deleted. Please use Taskman Management [XUTM MGR] to delete the task.")
 K ^XTMP("SD53P192","EXTRACT") D BMES^XPDUTL("The global ^XTMP(""SD53P192"",""EXTRACT"") has been deleted.")
 Q
