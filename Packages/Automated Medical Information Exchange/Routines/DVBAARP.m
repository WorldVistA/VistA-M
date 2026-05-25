DVBAARP ;ALB/SJA - CAPRI Routines to update AMIE function Options; 11/22/2024 ; 9/22/25 12:54pm
 ;;2.7;AMIE;**255**;Oct 20, 2000;Build 21
 ; Per VHA Directive 6402 this routine should not be modified
 ; Reference to OUT^XPDMENU ICR #1157
 ; Reference to %ZTLOAD ICR #10063
 ; Reference to OPTSTAT^XUTMOPT ICR #1472
 ; Reference to OWNSKEY^XUSRB ICR #3277
 ; Reference to XLFDT ICR #10103
UOTASKS(DVBRESULTS,DVBMSG,DVBOPLIST) ;
 ;RPC: DVBA CAPRI ARP OPTSET
 ; CAPRI-12935 SJA 11/22/24
 ;
 I DVBMSG="" S DVBRESULTS(1)="ERROR:Missing Message" Q 
 I DVBOPLIST="" S DVBRESULTS(1)="ERROR:Missing Option List" Q
 ;
 N DVBRET,DVBI,DVBOPTN,DVBLIST,DVBJ,DVBSCH,DVBSUBLIST,DVBDQ,DVBTSKIEN,DVBCURRENTMSG
 S (DVBRET,DVBLIST)=""
 F DVBI=1:1:$L(DVBOPLIST,"^") D
 . S DVBOPTN=$P(DVBOPLIST,"^",DVBI),DVBOPTIEN=""
 . S DVBOPTIEN=$O(^DIC(19,"B",DVBOPTN,DVBOPTIEN))
 . I DVBOPTIEN="" S DVBRESULTS(DVBI)=DVBOPTN_U_"Option not found" Q
 . S DVBCURRENTMSG=$P($G(^DIC(19,DVBOPTIEN,0)),U,3)
 . I DVBCURRENTMSG=DVBMSG S DVBRESULTS(DVBI)=DVBOPTN_"^already disabled" Q
 . D OUT^XPDMENU(DVBOPTN,DVBMSG)
 . I $P($G(^DIC(19,DVBOPTIEN,0)),U,3)'=DVBMSG S DVBRESULTS(DVBI)=DVBOPTN_U_"MESSAGE NOT SET" Q
 . D OPTSTAT^XUTMOPT(DVBOPTN,.DVBLIST)
 . I DVBLIST=0 S DVBRESULTS(DVBI)=DVBOPTN_U_"No tasks number" Q
 . F DVBJ=1:1:$G(DVBLIST) D
 . . S DVBSUBLIST=""
 . . S ZTSK=$P($G(DVBLIST(DVBJ)),U,1)
 . . S DVBRUNTIME=$P($G(DVBLIST(DVBJ)),U,2)
 . . D ISQED^%ZTLOAD ;;Checking for Scheduling
 . . S DVBSCH=$G(ZTSK(0))
 . . I DVBSCH'=1 S $P(DVBSUBLIST,U,DVBJ)=$G(ZTSK)_":-1",DVBRESULTS(DVBI)=DVBOPTN_U_DVBSUBLIST Q
 . . I DVBSCH=1 D
 . . . D DQ^%ZTLOAD
 . . . S DVBDQ=$G(ZTSK(0))
 . . . I DVBDQ=0 D DQ^%ZTLOAD
 . . . S DVBDQ=$G(ZTSK(0))
 . . . S DVBOPT=$P(DVBOPLIST,U,DVBI)
 . . . S $P(DVBSUBLIST,U,DVBJ)=$G(ZTSK)_":"_DVBRUNTIME_":"_DVBDQ,DVBRESULTS(DVBI)=DVBOPTN_U_DVBSUBLIST
 . . . Q
 . . I DVBDQ=1 D  ;;If task was DQ then delete from scheduling File 19.2
 . . . S DVBTSKIEN=""
 . . . S DVBTSKIEN=$O(^DIC(19.2,"B",DVBOPTIEN,DVBTSKIEN))
 . . . I $G(^DIC(19.2,DVBTSKIEN,1))=ZTSK D
 . . . . K DIE,DA,DR,X,Y
 . . . . S DA=DVBTSKIEN,DIE="^DIC(19.2,",DR="2///@;12///@"
 . . . . D ^DIE
 . . . . Q
 . . . K DIE,DA,DR,X,Y
 . . . Q
 . .Q
 . K DVBSUBLIST
 . Q
 K DVBRET,DVBI,DVBOPTN,DVBLIST,DVBJ,DVBSCH,DVBSUBLIST,DVBDQ,DVBTSKIEN,DVBKEY,DVBOPTIEN,DVBSUBLIST,DVBRUNTIME,ZTSK
 Q
LOOKUP(DVBRTN,DVBOPTLIST) ;
 ;CAPRI-14987 SJA 01/16/25
 ;RPC: DVBA CAPRI LOOKUP OPTSET
 N DVBI,DVBOPT,DVBOPTIEN,DVBIEN2,DVBSCHED,DVBTASKID,DVBTYPE,DVBFLAG,DVBQUE
 S DVBRTN=""
 F DVBI=1:1:$L(DVBOPTLIST,"^") D
 . S (DVBTYPE,DVBFLAG,DVBQUE)=""
 . S DVBOPT=$P(DVBOPTLIST,U,DVBI)
 . S (DVBOPTIEN,DVBIEN2)="",DVBSCHED="NONE",DVBTASKID="NONE"
 . S DVBOPTIEN=$O(^DIC(19,"B",DVBOPT,DVBOPTIEN))
 . ; Check if the option exists
 . I 'DVBOPTIEN S DVBRTN(DVBI)=DVBOPT_":0^" Q
 . S DVBTYPE=$P($G(^DIC(19,DVBOPTIEN,0)),"^",4)
 . S DVBFLAG=$P($G(^DIC(19,DVBOPTIEN,200.9)),"^",1)
 . S DVBQUE=$G(^DIC(19,DVBOPTIEN,200))
 . S DVBIEN2=$O(^DIC(19.2,"B",DVBOPTIEN,DVBIEN2))
 . I DVBIEN2'="" S DVBSCHED=$G(^DIC(19.2,DVBIEN2,0)),DVBTASKID=$G(^DIC(19.2,DVBIEN2,1))
 . S DVBMSG=$P($G(^DIC(19,DVBOPTIEN,0)),U,3)
 . I DVBMSG="" S DVBRTN(DVBI)=DVBOPT_":1^^SCHEDULE:"_DVBSCHED_"^TASKID:"_DVBTASKID
 . I DVBMSG'="" S DVBRTN(DVBI)=DVBOPT_":1^"_DVBMSG_"^SCHEDULE:"_DVBSCHED_"^TASKID:"_DVBTASKID
 . Q
 Q
COMBINE(DVBRESULTS,DVBAOPTIONS,DVBDATA) ; Combined RPC to clear option statuses and reschedule tasks
 ;CAPRI-15907 SJA 02/13/25
 ;DVBA CAPRI ARP RSKDT
 ; INPUT:
 ; DVBAOPTIONS - Option List (Options to clear or check the status)
 ; DVBOPTION   - A string of IENs of the options to be updated
 ; DVBRUNTIME  - A string of runtime for options to be scheduled
 ; OUTPUT:
 ; DVBRESULTS - Status for each option processing (both clearing status and rescheduling)
 N DVBCOUNT,DVBOPTN,DVBMSG,DVBIEN,DVBCURRENTMSG,DVBSCHIEN,DVBOPTIEN,DVBJ,DVBCRNTMSG,DVBCOUNT2
 ; Initialize variables
 S DVBCOUNT=""
 ; Step 1: Process options to clear or check the status
 F DVBCOUNT=1:1:$L(DVBAOPTIONS,"^") D
 . S DVBIEN=""
 . S DVBOPTN=$P(DVBAOPTIONS,"^",DVBCOUNT),DVBOPTIEN="" ; Get each option from the list
 . S DVBOPTIEN=$O(^DIC(19,"B",DVBOPTN,DVBOPTIEN))
 . S DVBCRNTMSG=$P($G(^DIC(19,DVBOPTIEN,0)),U,3)
 . I DVBCRNTMSG="" S DVBRESULTS(DVBCOUNT)=DVBOPTN_"^already enabled" Q
 . S DVBMSG=""
 . D OUT^XPDMENU(DVBOPTN,DVBMSG)  ; Process the option
 . ; Check if the option exists in the DIC(19) file
 . S DVBIEN=$O(^DIC(19,"B",DVBOPTN,DVBIEN))
 . I DVBIEN'="" D
 . . S DVBCURRENTMSG=$P($G(^DIC(19,DVBIEN,0)),"^",3)  ; Check the current message for the option
 . . ; If no message exists, mark as processed (1)
 . . I DVBCURRENTMSG="" S DVBRESULTS(DVBCOUNT)=DVBOPTN_"^1" Q
 . . ; If a message exists, mark as not processed (0)
 . . I DVBCURRENTMSG'="" S DVBRESULTS(DVBCOUNT)=DVBOPTN_":0"
 . . Q
 . I DVBIEN="" S DVBRESULTS(DVBCOUNT)=DVBOPTN_"^0" ;IF IEN IS "" RETURN
 . Q
 I ($G(DVBDATA(1))="")!($G(DVBDATA(2))="") Q
 ; Step 2: Reschedule tasks for the provided options and runtimes
 S DVBJ=0
 S DVBOPTIONS=$G(DVBDATA(1))
 S DVBRUNTIMES=$G(DVBDATA(2))
 S DVBCOUNT2=""
 S DT=$$NOW^XLFDT
 S UPDATEDT=$$FMADD^XLFDT(DT,0,0,20,0)
 F DVBCOUNT2=1:1:$L(DVBOPTIONS,"^") D
 . S DVBCOUNT=DVBCOUNT+1
 . S (DVBOPTIEN,DVBSCHIEN)=""
 . S DVBOPTION=$P(DVBOPTIONS,"^",DVBCOUNT2)  ; Get the current DVBOPTION
 . ; Check if the corresponding runtime exists
 . ; If no runtime exists for this option, skip rescheduling for it
 . ; If there is a runtime for the option, get the corresponding DVBRUNTIME
 . S DVBRUNTIME=$P(DVBRUNTIMES,"^",DVBCOUNT2)
 . ; Check if the option has an OOO message and return an error if true
 . ; Try to find the Schedule IEN (SCHIEN) for the provided OPTION
 . S DVBOPTIEN=$O(^DIC(19,"B",DVBOPTION,DVBOPTIEN))  ; Get the option IEN
 . S DVBSCHIEN=$O(^DIC(19.2,"B",DVBOPTIEN,DVBSCHIEN))  ; Get the schedule IEN
 . I $P($G(^DIC(19,DVBOPTIEN,0)),U,3)'="" S DVBRESULTS(DVBCOUNT)="ERROR: Option Out of Order "_DVBOPTION Q
 . ; If no SCH_IEN found, return message saying no tasks to reschedule
 . I DVBSCHIEN="" S DVBRESULTS(DVBCOUNT)="No Option to reschedule for "_DVBOPTION Q
 . ; If task is already scheduled, no update required
 . I $P($G(^DIC(19.2,DVBSCHIEN,0)),U,2)'="" S DVBRESULTS(DVBCOUNT)=DVBOPTION_"^already scheduled" Q  ; No update needed
 . ; If schedule entry is found, check if the task is already scheduled
 . I $P($G(^DIC(19.2,DVBSCHIEN,0)),U,2)="" D
 . .; If no date/time is set, update the schedule with the new runtime
 . . K DIE,DA,DR,X,Y
 . . S DA=DVBSCHIEN,DIE="^DIC(19.2,",DR="2///"_UPDATEDT
 . . D ^DIE
 . . K DIE,DA,DR,X,Y
 . . Q
 . I $P($G(^DIC(19.2,DVBSCHIEN,0)),U,2)=UPDATEDT S DVBRESULTS(DVBCOUNT)=DVBOPTION_"^"_UPDATEDT_"^1" ; Success: Option rescheduled
 . ; Final result: Return all the status of the options
 . Q
 K DVBRUNTIME,DVBOPTIONS,DVBRUNTIMES,DVBCRNTMSG,DVBOPTION,UPDATEDT
 Q
