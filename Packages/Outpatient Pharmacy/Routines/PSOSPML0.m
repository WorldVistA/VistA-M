PSOSPML0 ;BIRM/MFR - Scheduled Batch Export ;10/10/12
 ;;7.0;OUTPATIENT PHARMACY;**408,451**;DEC 1997;Build 114
 ;
AUTO ; SPMP Scheduled Background Job Edit
 N DIC,Y S DIC(0)="XZM",DIC="^DIC(19.2,",X="PSO SPMP SCHEDULED EXPORT" D ^DIC
 I +Y>0 S DA=Y D EDIT^XUTMOPT("PSO SPMP SCHEDULED EXPORT") Q
 D RESCH^XUTMOPT("PSO SPMP SCHEDULED EXPORT",$$FMADD^XLFDT(DT,1)+.0001,"","24H","L")
 D EDIT^XUTMOPT("PSO SPMP SCHEDULED EXPORT")
 Q
 ;
EXPORT ; SPMP Nightly Scheduled Export
 N STATE,NODE0,EXPNODE,BEGEXPDT,FREQCY,YESTERDY,BATIEN,RXCNT,RTSBGDT,RTSENDT
 ;
 S STATE=0
 F  S STATE=$O(^PS(58.41,STATE)) Q:'STATE  D
 . K ^TMP("PSOSPMRX",$J)
 . I $P($$SPOK^PSOSPMUT(STATE),"^")=-1 D  Q
 . . D LOGERROR^PSOSPMUT(0,STATE,$P($$SPOK^PSOSPMUT(STATE),"^",2),1)
 . S NODE0=$G(^PS(58.41,STATE,0)),EXPNODE=$G(^PS(58.41,STATE,"EXPORT"))
 . S FREQCY=$P(NODE0,"^",4),YESTERDY=$$FMADD^XLFDT(DT,-1)
 . S BEGEXPDT=$$FMADD^XLFDT(DT,-FREQCY)
 . I $P(EXPNODE,"^") S BEGEXPDT=$$FMADD^XLFDT($P(EXPNODE,"^"),+1)
 . ; Cannot run for current day because it will skip Rx's w/ RELEASE DATE/TIME w/out time
 . I BEGEXPDT>YESTERDY Q
 . ; Checking if it is time to transmit based on the TRANSMISSION FREQUENCY value
 . I $$FMADD^XLFDT(BEGEXPDT,FREQCY)>DT Q
 . ; Preventing a Scheduled Transmission Date Range of more than 30 days - Reset to Frequency
 . I $$FMDIFF^XLFDT(YESTERDY,BEGEXPDT)>30 S BEGEXPDT=$$FMADD^XLFDT(YESTERDY,-FREQCY)
 . ; The legislation allowing VA to report was published on 02/11/2013
 . I BEGEXPDT<3130211 S BEGEXPDT=3130211
 . ; Gathering the prescriptions to be transmitted in the ^TMP("PSOSPMRX",$J) global
 . S RXCNT=$$GATHER^PSOSPMU1(STATE,BEGEXPDT-.1,YESTERDY+.24,"N")
 . ; The ^TMP("PSOSPMRX",$J) returned will be used to build the batch 
 . I RXCNT>0 D
 . . S BATIEN=$$BLDBAT^PSOSPMU1("SC",BEGEXPDT,YESTERDY)
 . . I $P(BATIEN,"^")=-1 D LOGERROR^PSOSPMUT(0,STATE,$P(BATIEN,"^",2),1) Q
 . . ; Automatic sFTP Transmission to the state
 . . I $$GET1^DIQ(58.41,STATE,13,"I")="A" D
 . . . D EXPORT^PSOSPMUT(BATIEN,"EXPORT",1)
 . . ; Manual sFTP Transmission to the state
 . . I $$GET1^DIQ(58.41,STATE,13,"I")="M" D
 . . . D SENDMAIL(BATIEN,"S")
 . K DIE,DR,DA S DR="11///"_YESTERDY S DIE="^PS(58.41,",DA=STATE D ^DIE
 ;
 ; Return To Stock Batch for ASAP 1995 states only (Weekly) - Separate file
 I $$UP^XLFSTR($$DOW^XLFDT(DT))'="SUNDAY" Q
 S STATE=0 F  S STATE=$O(^PS(58.41,STATE)) Q:'STATE  D
 . ; State not using ASAP 1995
 . I $$GET1^DIQ(58.41,STATE,1,"I")'="1995" Q
 . ; State accepts Return to Stock transmissions
 . S RTSBGDT=$$FMADD^XLFDT(DT,-7),RTSENDT=$$FMADD^XLFDT(DT,-1)
 . S RXCNT=$$GATHER^PSOSPMU1(STATE,RTSBGDT-.1,RTSENDT+.24,"N",1) I RXCNT'>0 Q
 . S BATIEN=$$BLDBAT^PSOSPMU1("VD",RTSBGDT,RTSENDT)
 . I $$GET1^DIQ(58.41,STATE,12,"I") D
 . . D EXPORT^PSOSPMUT(BATIEN,"EXPORT",1)
 . E  D SENDMAIL(BATIEN,"R")
 Q
 ;
SENDMAIL(BATCHIEN,BATTYPE) ; ASAP 1995 Only - Mailman message about Return To Stock Records
 ;Input: BATCHIEN - Pointer to BATCH file (#58.42)
 ;       BATTYPE  - Batch Type: S: Scheduled / R: Return to Stock (ASAP 1995 only) 
 N XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ,PSOMSG,USR,STANAME
 ;
 S STANAME=$$GET1^DIQ(58.42,BATCHIEN,1)
 ; - Scheduled Batch Notification
 I (BATTYPE="S") D
 . S XMSUB=STANAME_" CS PMP Batch Ready"
 . S XMSUB=XMSUB_" ("_$$FMTE^XLFDT($$GET1^DIQ(58.42,BATCHIEN,4,"I")\1,"2Z")
 . S XMSUB=XMSUB_"-"_$$FMTE^XLFDT($$GET1^DIQ(58.42,BATCHIEN,5,"I")\1,"2Z")_")"
 . S PSOMSG(1)="Batch #: "_BATCHIEN_"      Period : "_$$FMTE^XLFDT($$GET1^DIQ(58.42,BATCHIEN,4,"I")\1,"2Z")_" thru "_$$FMTE^XLFDT($$GET1^DIQ(58.42,BATCHIEN,5,"I")\1,"2Z")
 . S PSOMSG(2)=""
 . S PSOMSG(3)="The scheduled batch #"_BATCHIEN_" containing Controlled Substance Prescription data"
 . S PSOMSG(4)="to be submitted to the Prescription Monitoring Program (PMP) for the state of "
 . S PSOMSG(5)=STANAME_" is ready."
 . S PSOMSG(6)=""
 . S PSOMSG(7)="Please use the option ""View/Export Batch"" [PSO SPMP BATCH VIEW/EXPORT], then"
 . S PSOMSG(8)="enter the batch #"_BATCHIEN_", choose the action 'EXP' and follow the instructions"
 . S PSOMSG(9)="to send the file to the state."
 ;
 ; - Return To Stock Batch Notification (ASAP 1995 only)
 I (BATTYPE="R") D
 . S XMSUB=STANAME_" - CS Rx Fills Returned To Stock"
 . S XMDUZ="SPMP Scheduled Transmission"
 . S PSOMSG(1)="There were Controlled Substance Rx fills that had been reported to the State"
 . S PSOMSG(2)="Prescription Monitoring Program (SPMP) and were later returned to stock:"
 . S PSOMSG(3)=""
 . S PSOMSG(4)="Batch #: "_BATCHIEN_"      Period : "_$$FMTE^XLFDT($$GET1^DIQ(58.42,BATCHIEN,4,"I")\1,"2Z")_" thru "_$$FMTE^XLFDT($$GET1^DIQ(58.42,BATCHIEN,5,"I")\1,"2Z")
 . S PSOMSG(6)=""
 . S PSOMSG(7)="Please, retrieve the batch above via the View/Export Batch [PSO SPMP BATCH"
 . S PSOMSG(8)="VIEW/EXPORT] option and manually capture/upload the data to the State"
 . S PSOMSG(9)="Prescription Monitoring Program (SPMP) website for "_STANAME_"."
 . S PSOMSG(10)=""
 . S PSOMSG(11)="***************************** IMPORTANT **********************************"
 . S PSOMSG(12)="When you upload this file to the state website, make sure to select the"
 . S PSOMSG(13)="correct import option, usually called ""Back Records Out of the System"", to"
 . S PSOMSG(14)="avoid reporting duplicate records for the patients."
 . S PSOMSG(15)="**************************************************************************"
 ;
 S XMTEXT="PSOMSG("
 ; If there are no active members in the mailgroup sends message to PSDMGR key holders
 I $$GOTLOCAL^XMXAPIG("PSO SPMP NOTIFICATIONS") D
 . S XMY("G.PSO SPMP NOTIFICATIONS")=""
 E  D
 . S USR=0 F  S USR=$O(^XUSEC("PSDMGR",USR)) Q:'USR  S XMY(USR)=""
 ;
 D ^XMD
 Q
