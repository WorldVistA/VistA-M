XU8P481 ;OAK_BP/BEE - NPI EXTRACT REPORT INTERFACE ROUTINE ;01-OCT-06
 ;;8.0;KERNEL;**481**;Jul 10, 1995;Build 18
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; XUS*8.0*481 Post Processing Routine
 ; 
 ; This routine will loop through the list of scheduled tasks and delete
 ; any (TaskMan) scheduled runs of the XUS NPI CROSSWALK EXTRACT REPORT option.
 ; 
 ; Routine has been adapted from the Delete Task Routine XUTMD
 ;
 ; Process completion MailMan message will be sent to DUZ of user
 ; (or POSTMASTER if blank)
 ;
EN ; Entry Point - Called as a post processing routine from XU*8.0*481
 N MSG,TASK,XUTMT,XUTMUCI,Y
 ;
 ;Retrieve Task Information
 X ^%ZOSF("UCI") S XUTMUCI=Y
 ;
 ;Loop through list of tasks
 S TASK=0
 F  S TASK=$O(^%ZTSK(TASK)) Q:'TASK  D
 .;
 .;Get patch information
 .N ZTSK S XUTMT=TASK,XUTMT(0)="R3" D ^XUTMT
 .;
 .;Only review Extract Related Tasks
 .I $G(ZTSK(0))["XUS NPI EXTRACT" D
 ..;
 ..;Determine Task Status (Adapted from XUTMD)
 ..I $D(ZTSK(.11))#2,ZTSK(.11)="UNDEFINED",$O(ZTSK(.3))="" Q   ;Task is not defined
 ..I $D(ZTSK(.11))#2,ZTSK(.11)="UNDEFINED",$O(ZTSK(.3))="TASK",$O(ZTSK("TASK"))="" Q  ;Task is running and has no record
 ..I $D(ZTSK(.11))#2,ZTSK(.11)="UNDEFINED" Q  ;Task is scheduled but has no record
 ..I $D(ZTSK(.11))#2,$O(ZTSK(.3))="" Q  ;Task's record is incomplete
 ..I $D(ZTSK(.11))#2,$O(ZTSK(.3))="TASK",$O(ZTSK("TASK"))="" Q  ;Task is running and has an incomplete record
 ..I $D(ZTSK(.11))#2 Q  ;Task is scheduled, but has an incomplete record
 ..I $O(ZTSK(.3))="TASK",$O(ZTSK("TASK"))="" Q  ;Task is running
 ..;
 ..;Delete Task (Adapted from XUTMD)
 ..I $D(ZTSK(0))#2,ZTSK(0)["ZTSK^XQ1",$P(ZTSK(0),U,11)_","_$P(ZTSK(0),U,12)=XUTMUCI,$P(ZTSK(0),U,8)]"" D
 ...N TSK S TSK=0 F  S TSK=$O(^DIC(19.2,TSK)) Q:TSK'>0  I $G(^DIC(19.2,TSK,1))=TASK D
 ....N DA,DIE,DR S DA=TSK,DIE="^DIC(19.2,",DR=".01///@" D ^DIE
 ..;
 ..;Remove entry in %ZTSCH
 ..S XUTMT=TASK,XUTMT(0)="D" D ^XUTMT
 ..;
 ..;Log task number for MailMan message
 ..S MSG=$G(MSG)+1,MSG(MSG)=TASK
 ;
 ;Run the extract as part of the installation process
 D TASKMAN^XUSNPIX1
 ;
 ;Send completion message
 D MSG(.MSG)
 ;
 ; Exit the process
 ; 
EXIT K MSG,TASK,XUTMT,XUTMUCI,Y
 Q
 ;
 ;Send MailMan Status Message
 ;
MSG(MSG) N XMSUB,XMTEXT,XMY,XMDUZ,DIFROM,XMZ,XMMG
 ;
 ;Set subject and text
 S XMTEXT="MSG("
 S XMSUB="Patch XU*8.0*481 post processing completed successfully"
 S XMDUZ="KERNEL XU*8.0*481 PATCH INSTALLATION"
 ;
 ;Put subject in body as well so message will transmit
 I $O(MSG(""))="" S MSG(.0001)="No XUS NPI Crosswalk Extract scheduled tasks were deleted"
 E  S MSG(.0001)="The following scheduled XUS NPI Crosswalk Extract tasks were deleted: "
 ;
 ;Set recipient - Default to POSTMASTER if no DUZ
 I $G(DUZ)]"" S XMY(DUZ)=""
 E  S XMY(.5)=""
 ;
 ;Send
 D ^XMD
 ;
 Q
