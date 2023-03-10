SDECRTCF2 ;ALB/LAB- Cleanup of orphaned children of MRTC ;Jun 04,2021@15:23
 ;;5.3;Scheduling;**788**;Aug 13, 1993;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
CLEANUP ;
 N INPID,POP,PIDDATE,DIR,CNT,UPDATE
 S POP=0
 D VERIFYRUN
 D:'POP PRINTORUPDATE
 D:'POP DEVICEPROMPT
 D:'POP LOOP
 D:'POP FIN
 Q
 ;
VERIFYRUN ;display what option does and verify user wants to run
 N DIRUT,DIR,X1,X2,X
 ;
 ;  Entry Point for clean-up with user specified dates
 ;
 S X1=DT,X2=-90 D C^%DTC
 S INPID=X
 S PIDDATE=$$FMTE^XLFDT($$FMADD^XLFDT(+DT,-90),5)
 W !!,"This OPTION will disposition those Return to Clinic Requests (RTC) that are "
 W !,"in a status of OPEN when the parent is in a status of closed"
 W !!,"Request that have a Patient Identified Date (PID) within the last 90 days "
 W !,"("_PIDDATE_") will NOT be selected for cleanup.",!
 ;
 ; verify they want to run clean-up
 ;
 W !!
 S DIR(0)="Y"
 S DIR("A")="Are you sure you would like to run the Stuck MRTC child cleanup tool"
 S DIR("?")="Enter 'Y'es or 'N'o."
 S DIR("B")="YES"
 D ^DIR
 G:$G(DIRUT)!(Y=0) EXIT
 W !!
DTPROMPT ;prompt for pid to search on
 N Y
 S DIR(0)="DAO^3170101:"_+INPID_":EX",DIR("A")="Enter a PID before or equal to "_PIDDATE_":  ",DIR("B")=PIDDATE ;
 S DIR("?",1)="Enter a Patient Identified Date (PID).  Requests will be selected that are less than or equal to the entered date.",DIR("?")="The date must be less than or equal to "_PIDDATE ;
 D ^DIR
 G:+Y<1 EXIT
 S INPID=Y
 Q
 ;
DEVICEPROMPT ;prompt for device
 D ^%ZIS Q:POP
 U IO
 W !,"Results from the Stuck MRTC child cleanup tool.",!!
 Q
 ;
PRINTORUPDATE ;does user want to print report only or udpate and print
 N Y
 W !!
 S DIR(0)="Y"
 S DIR("A")="Would you like to UPDATE the records?  Enter 'N'o to print only."
 S DIR("?")="Enter 'Y'es to UPDATE and PRINT the records or 'N'o to print records only."
 S DIR("B")="NO"
 D ^DIR
 G:$G(DIRUT) EXIT
 S UPDATE=Y
 W !!
 Q
 ;
LOOP ;loop through open requests and cleanup child's status
 N SDDT,SDIEN,SDPARENT,SDPARENTINFO,SDFND,RETN,SDPID,SDCHILDINFO
 S CNT=0
 S SDDT=""
 ;loop through all open request
 F  S SDDT=$O(^SDEC(409.85,"E","O",SDDT)) Q:SDDT=""  D
 . S SDIEN=""
 . F  S SDIEN=$O(^SDEC(409.85,"E","O",SDDT,SDIEN)) Q:SDIEN=""  D
 . . Q:$$GET1^DIQ(409.85,SDIEN,41,"E")'="YES"  ;Checking to see if this is an MRTC
 . . S SDPID=$$GET1^DIQ(409.85,SDIEN,22,"E")
 . . Q:$$GET1^DIQ(409.85,SDIEN,22,"I")>INPID  ;If PID is less than 90 days old, do not quit.
 . . S SDPARENT=$$GET1^DIQ(409.85,SDIEN,43.8,"I")
 . . Q:SDPARENT=""  ;must be parent quit out if not a child
 . . D GETS^DIQ(409.85,SDIEN,".01;21;22;23","IE","SDCHILDINFO")
 . . D GETS^DIQ(409.85,SDPARENT,"21;23","IE","SDPARENTINFO")
 . . ;if parent was closed by a dispositon other than MRTC PARENT CLOSED, 
 . . I SDPARENTINFO(409.85,SDPARENT_",",23,"E")="CLOSED" D
 . . . D WRITEBEFORE
 . . . ; call RPC ARCLOSE with Request IEN, Disposition,DUZ,today's date)
 . . . D:UPDATE ARCLOSE^SDEC(.RETN,SDIEN,SDPARENTINFO(409.85,SDPARENT_",",21,"I"),DUZ,$$FMTE^XLFDT(+DT,5))
 . . . D:UPDATE WRITEAFTER
 Q
WRITEBEFORE ;write information for child and parent that were selected for cleanup
 N LAST4,ORDID
 S CNT=CNT+1
 W !!,"PATIENT = ",SDCHILDINFO(409.85,SDIEN_",",.01,"E")
 S LAST4=$$GET1^DIQ(2,SDCHILDINFO(409.85,SDIEN_",",.01,"I"),.09,"E")
 W "  LAST4 = "_$E(LAST4,6,$L(LAST4))
 S ORDID=$$GET1^DIQ(409.85,SDIEN,46,"E")
 I ORDID>0 W !,"ORDER ID = "_ORDID_"      "_$$GET1^DIQ(100,ORDID,5,"E")
 W !,"MRTC PARENT = ",SDPARENT
 W !,"  PARENT STATUS = ",SDPARENTINFO(409.85,SDPARENT_",",23,"E")
 W !,"  PARENT DISPOSITION = ",SDPARENTINFO(409.85,SDPARENT_",",21,"E")
 W !,"MRTC CHILD = ",SDIEN
 W !,"PID = ",SDPID
 W !,"BEFORE:"
 W !,"  CHILD STATUS = ",SDCHILDINFO(409.85,SDIEN_",",23,"E")
 W !,"  CHILD DISPOSITION = ",SDCHILDINFO(409.85,SDIEN_",",21,"E")
 Q
WRITEAFTER ;write status and disposition after update
 N ORDID
 W !,"AFTER:"
 S ORDID=$$GET1^DIQ(409.85,SDIEN,46,"E")
 I ORDID>0 W !,"ORDER ID = "_ORDID_"      "_$$GET1^DIQ(100,ORDID,5,"E")
 D GETS^DIQ(409.85,SDIEN,"21;23","IE","SDCHILDINFO")
 W !,"  CHILD STATUS = ",SDCHILDINFO(409.85,SDIEN_",",23,"E")
 W !,"  CHILD DISPOSITION = ",SDCHILDINFO(409.85,SDIEN_",",21,"E"),!!
 Q
 ;
EXIT ;exit without running
 S POP=1
 W !,"Nothing done."
 Q
 ;
FIN ;Show final results
 ;
 D ^%ZISC
 I UPDATE W !!,"Search and clean-up is complete!!!!",!,CNT," requests were updated!"
 I 'UPDATE W !!,"Report finished.",!,CNT," requests were selected as needing updated."
 Q
 ;
