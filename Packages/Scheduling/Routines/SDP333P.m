SDP333P ;bpiofo/swo sd*5.3*333 post init
 ;;5.3;Scheduling;**333**;July 23, 2003
 ;PAIT Clean-UP remove all entries from file 409.6
 I $P($G(^SDWL(409.6,0)),"^",4)=0 D  Q
 . W !,"File 409.6 has no entries - nothing to clean up."
 N DIR
 W !,"SD*5.3*333 POST INIT"
 S DIR(0)="YA^^",DIR("A")="Clean-Up file 409.6? ",DIR("B")="NO"
 S DIR("?")="If this is the first installation of the patch answer 'YES'"
 S DIR("?",1)="ATTENTION:  Answering 'YES' will delete all entries from file 409.6"
 S DIR("?",2)="(Patient Appointment Information Transmission).  This is CORRECT"
 S DIR("?",3)="for a first installation of the patch.  If you are re-installing the"
 S DIR("?",4)="patch and want to keep the entries in 409.6 answer 'NO'"
 D ^DIR Q:'Y
 S ZTDTH=$H,ZTRTN="START^SDP333P",ZTIO=""
 S ZTDESC="PAIT Clean-Up"
 K ZTSK D ^%ZTLOAD I '$D(ZTSK) D  Q
 . W !,"Failed to create Task!"
 W !,"PAIT Clean-UP Task Submitted.  Task number: "_$G(ZTSK)
 W !,"Members of the SD-PAIT mail group will receive a notification message"
 W !,"when the clean-up job has completed."
 Q
START ;tasked entry point
 N DA,DIK,SDV1
 S DIK="^SDWL(409.6,"
 S SDV1=0 F  S SDV1=$O(^SDWL(409.6,SDV1)) Q:'SDV1  D
 . S DA=SDV1 D ^DIK
 K DIK
MSG ;
 N SDAMX,XMSUB,XMY,XMTEXT,XMDUZ
 S XMSUB=$P($$SITE^VASITE(),"^",3)_" PAIT Clean-Up"
 S XMY("G.SD-PAIT")=""
 S XMY("S.SD-PAIT-SERVER@FORUM.VA.GOV")=""
 S XMTEXT="SDAMX("
 S XMDUZ="POSTMASTER"
 S SDAMX(1)=""
 S SDAMX(2)="The PAIT Clean-Up, task #"_$G(ZTSK)_", from the post installation"
 S SDAMX(3)="of SD*5.3*333 has completed.  You may resume post installation activities."
 D ^XMD
