SPNSERV ;SAN/WDE-Master server rtn for the spn* data;5/28/98
 ;;2.0;Spinal Cord Dysfunction;**6,8**;01/02/97
 ;
 ;
 ;    This rtn is called from the option file.
 ;    The option is SPNSERVER it's type is a server.
 ;    Lines in the message with text  
 ;    PERFORM TAG^ROUTINE will be save for processing.
 ;    needed variables can be included on the line.
UNPK ;
 ;From the server sftw
 ;      XMER=0 for a good read
 ;          -1 end of message
 ;      XMREC is an executed var that reads the message
 ;      XMGR is the line of text that is being readd
 ;Built here
 ;      SPNDATA(ARRAY will contain the programs to run
 ;      The text in the message MUST contain
 ;      PERFORM TAG^ROUTINE;DESCRIPTION;TIME TO RUN;
 ;      the 4rd piece if present it will be SPNSDATE ie 2980101.001
 ;      the 5th piece if present it will be the SPNEDATE ie 2980101.2359
 ;        piece 6-10 will be parms spnparm(5...10) for open use
 ;
 ;hold xmz in spnxmz so we can delete it when all done with the message
 S SPNXMZ=XMZ
 ;  read the message and test for programs save em if there
 ;
 F SPN=1:1 X XMREC Q:(XMER=-1)  D
 .I $P(XMRG,";",1)["^" I $P(XMRG,";",1)["PERFORM " I $P(XMRG,";",1)["^" S SPNDATA(SPN)=XMRG
 ;
 ;
 ;    read the spn array and task off the routines and send notices
 ;
 I $D(SPNDATA) S SPN=0 F A=1:1 S SPN=$O(SPNDATA(SPN)) Q:SPN=""  S XMRG=$G(SPNDATA(SPN)) I $L(XMRG) D TASK
EXIT ;
 I $G(SPNXMZ) S XMZ=SPNXMZ S XMSER="SPNSERVER" D REMSBMSG^XMA1C
 K SPNXMZ,XMSER,SPNPARM,SPNERR,X,A,SPNCNT,SPNDATA,SPNTXT,SPNDESC,SPNGRP
 K SPNSUB,ZTSAVE,ZTSK,ZTDESC,ZTIO,XMY
 Q
 ;---------------------------------------------------------------------
TASK ;
 ;      spnerr 0 is good 1 is an error
 ;      spnparm is an array that contains the data for the 
 ;              program that is going to be ran.
 ;      spnparm(DESCRIPTION) is the task description and message title
 ;      spnparm(ENDATE) is a place holder for report end date
 ;      spnparm(REQUEST STRING) = the xmrg value from the server sftw
 ;      spnparm(RUN ROUTINE) = the routine to run
 ;      spnparm(SITE) = the host site
 ;      spnparm(STARTDATE) = is a place holder for report start dates
 ;      spnparm(TASKTIME) = time that the job will be ran  
 ;      spnparm(SPNPAR /6-10/) can be used to pass other varibles needed
 ;      spntxt is the message required in ^spnmail  
 ;
 ;
 ;    Loop through the XMRG variable and set up the spnparm array
 ;
 S SPNCNT=1 F X="RUN ROUTINE","DESCRIPTION","TASKTIME","STARTDATE","ENDATE","SPNPAR6","SPNPAR7","SPNPAR8","SPNPAR9","SPNPAR10" S SPNPARM(X)=$P(XMRG,";",SPNCNT) S SPNCNT=SPNCNT+1
 S SPNPARM("SITE")=$G(^DD("SITE"))_"("_$G(^DD("SITE",1))_")"
 S SPNPARM("REQUEST STRING")=$G(XMRG)
 S SPNPARM("RUN ROUTINE")=$P(SPNPARM("RUN ROUTINE"),"PERFORM ",2)
 ;
 ;    Test the parms and if error send message and clean up and quit
 ;
 D TEST I SPNERR=1 D CLEAN Q 
 ;
 ;
 ;    The data ran through the screen without error & will be tasked off.
 ;
 S ZTDTH=$G(SPNPARM("TASKTIME")) S Y=ZTDTH X ^DD("DD") S $P(SPNPARM("TASKTIME"),U,2)=Y K Y
 S SPNERR=0
 S ZTRTN=$G(SPNPARM("RUN ROUTINE"))
 S ZTDESC=$G(SPNPARM("DESCRIPTION"))
 S ZTDTH=$P(SPNPARM("TASKTIME"),U,1)
 S ZTSAVE("SPNPARM(")=""
 S ZTIO=""
 D ^%ZTLOAD
 ;
 ;   test for task number if zip, send error message to group and quit
 ;
 I $D(ZTSK)=0 S ZTSK="No task number." D SENDERR D CLEAN Q
 ;         
 ;;   at this point the task was set and we want to know it
 ;
 S SPNTXT(1)=$G(SPNPARM("DESCRIPTION"))
 S SPNTXT(2)="Has been task to run at "_^DD("SITE")_"."
 S SPNTXT(3)="Routine : "_$G(SPNPARM("RUN ROUTINE"))
 S SPNTXT(4)="Time set to run: "_$P(SPNPARM("TASKTIME"),U,2)
 S SPNTXT(5)="If you are not happy with the run time you"
 S SPNTXT(6)="can reschedule it for another time."
 S SPNTXT(7)="The task number is "_ZTSK
 S XMY("G.SPNL SCD REGISTRY@SAN-DIEGO.VA.GOV")=""
 S XMY("G.SPNL SCD COORDINATOR")=""
 S SPNDESC=$G(SPNPARM("DESCRIPTION"))
 D ^SPNMAIL
CLEAN ;
 K SPNERR,SPNSUB,SPNDESC,SPNTXT,SPNPARM,SPNRTN,SPNTXT,SPNGRP
 Q
TEST ;--------------------------------------------------------------------
 ;   test the spnparm array for any missing elements
 ;   if ztrtn,ztdesc,tasktime are missing send us a
 ;   notice and go to next request.
 ;   If the routine is not on the disk send error message.
 S SPNERR=0
 I $G(SPNPARM("RUN ROUTINE"))="" S SPNERR=1
 S X=$G(SPNPARM("RUN ROUTINE")) S X=$P(X,"^",2) X ^%ZOSF("TEST") I $T=0 S SPNERR=1 S SPNTXT(5)="Routine not found on disk.."
 I $G(SPNPARM("DESCRIPTION"))="" S SPNERR=1
 I $G(SPNPARM("TASKTIME"))="" S SPNERR=1 S SPNTXT(5)="No task time"
 I SPNERR=0 Q
 ;
SENDERR ; this tag is called if the requested didn't get task.
 ;
 S SPNTXT(1)="The data extract at "_^DD("SITE")_" didn't arrive correct."
 S SPNTXT(2)="Resubmit it with the correct sting."
 S SPNTXT(3)="XMRG value was"
 S SPNTXT(4)=$G(SPNPARM("REQUEST STRING"))
 S SPNGRP="G.SPNL SCD REGISTRY@SAN-DIEGO.VA.GOV"
 S SPNDESC=$G(SPNPARM("DESCRIPTION"))
 D ^SPNMAIL
 Q
