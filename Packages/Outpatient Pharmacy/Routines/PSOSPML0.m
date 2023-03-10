PSOSPML0 ;BIRM/MFR - Scheduled Batch Export ;1/6/21  12:58
 ;;7.0;OUTPATIENT PHARMACY;**408,451,625,630**;DEC 1997;Build 26
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
 D CHK5841
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
 . ;Zero Report - Daily Separate File
 . N SITEIEN S SITEIEN=0
 . N DEANO S DEANO=""
 . K ^TMP("PSOSPZRP",$J),DEARX,DEANRX,SITES,ZDEA
 . F  S SITEIEN=$O(^PS(59,SITEIEN)) Q:'SITEIEN  D
 . . Q:$$GET1^DIQ(59,SITEIEN,.08,"I")'=STATE
 . . I $$GET1^DIQ(59,SITEIEN,2004,"I")'="",$$GET1^DIQ(59,SITEIEN,2004,"I")<DT Q
 . . S DEANO=$$PHA03^PSOASAP0() I DEANO="" Q
 . . S SITES(SITEIEN)=DEANO
 . . I $D(^TMP("PSOSPMST",$J,SITEIEN)),'$G(DEARX(DEANO)) S DEARX(DEANO)=SITEIEN
 . . E  S DEANRX(DEANO)=SITEIEN
 . N DEA,SITE
 . S (DEA,SITE)=""
 . F  S DEA=$O(DEANRX(DEA)) Q:DEA=""  D
 . . I '$G(DEARX(DEA)) S SITE=DEANRX(DEA) S ZDEA(DEA)=SITE S ^TMP("PSOSPZRP",$J,SITE)=DEA
 . I $D(^TMP("PSOSPZRP",$J)) D
 . . I $$GET1^DIQ(58.41,STATE,20)'="" D    ;Sites with no RX and Yes to send Zero Report
 . . . N %,DIC,DR,DA,X,Y,DINUM,DLAYGO,DD,DO,EXPTYPE
 . . . S EXPTYPE="ZR"
 . . . F  L +^PS(58.42,0):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) Q:$T  H 3
 . . . S (DINUM,BATIEN)=$O(^PS(58.42,999999999999),-1)+1
 . . . W !!,"Creating Batch #",DINUM," for ",$$GET1^DIQ(58.41,STATE,.01),"..."
 . . . S DIC="^PS(58.42,",X=DINUM,DIC(0)="",DIC("DR")="1////"_STATE_";2///"_EXPTYPE_";8///"_$$NOW^XLFDT()
 . . . S DIC("DR")=DIC("DR")_";4///"_$G(BEGEXPDT)_";5///"_$G(YESTERDY)
 . . . S DLAYGO=58.42 K DD,DO D FILE^DICN K DD,DO
 . . . L -^PS(58.42,0)
 . . . I Y=-1 S BATIEN="-1^Export Batch could not be created" Q
 . . . N SITE,DEAZ S SITE=""
 . . . F  S SITE=$O(SITES(SITE)) Q:SITE=""  D
 . . . . S DEAZ=$G(SITES(SITE)) I '$G(ZDEA(DEAZ)) Q
 . . . . K DIC,DINUM,DA S DIC="^PS(58.42,"_BATIEN_",""ZRS"",",DIC(0)="",DA(1)=BATIEN
 . . . . S X=SITE,DIC("DR")="1///"_DEAZ
 . . . . S DLAYGO=58.42201 K DD,DO D FILE^DICN K DD,DO
 . . . ; Automatic sFTP Transmission to the state
 . . . D EXPORT^PSOSPMUT(BATIEN,"EXPORT",1)
 . . . N SITE S SITE=0
 . . . N DEA S DEA=""
 . . . F  S SITE=$O(^TMP("PSOSPZRP",$J,SITE)) Q:'SITE  D
 . . . . S DEA=$G(^TMP("PSOSPZRP",$J,SITE))
 . . . . D SENDMAIL(BATIEN,"ZY",DEA)
 . . E  D SENDMAIL("","ZN")
 . K DIE,DR,DA S DR="11///"_YESTERDY S DIE="^PS(58.41,",DA=STATE D ^DIE
 . ;RX Not Transmitted Report - Daily Separate File
 . N BEGEXPDT,YESTERDY,BATIEN,RXCNT,LIST
 . K ^TMP("PSOSPMRX",$J)
 . S BEGEXPDT=$$FMADD^XLFDT(DT,-30)
 . S YESTERDY=$$FMADD^XLFDT(DT,-1)
 . S LIST="ARX"
 . S LIST("STATE")=STATE
 . ; Gathering the prescriptions to be transmitted in the ^TMP("PSOSPMRX",$J) global
 . S RXCNT=$$GATHER^PSOSPMU1(STATE,BEGEXPDT-.1,YESTERDY+.24,"N",0,.LIST)
 . I RXCNT>0 D
 . . S BATIEN=$$BLDBAT^PSOSPMU1("SC",BEGEXPDT,YESTERDY)
 . . I $P(BATIEN,"^")=-1 D LOGERROR^PSOSPMUT(0,STATE,$P(BATIEN,"^",2),1) Q
 . .; Automatic sFTP Transmission to the state
 . . I $$GET1^DIQ(58.41,STATE,13,"I")="A" D
 . . . D EXPORT^PSOSPMUT(BATIEN,"EXPORT",1)
 . .; Manual sFTP Transmission to the state
 . . I $$GET1^DIQ(58.41,STATE,13,"I")="M" D
 . . . D SENDMAIL^PSOSPML0(BATIEN,"S")
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
SENDMAIL(BATCHIEN,BATTYPE,DEA) ; ASAP 1995 Only - Mailman message about Return To Stock Records
 ;Input: BATCHIEN - Pointer to BATCH file (#58.42)
 ;       BATTYPE  - Batch Type: S: Scheduled / R: Return to Stock (ASAP 1995 only) / ZR: and ZY: Zero Report
 ;   (O) DEA      - DEA Numbers passed in for Zero Report
 N XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ,PSOMSG,USR,STANAME
 N RUNDT    ;Zero Reporting
 ;
 S STANAME=$$GET1^DIQ(58.42,BATCHIEN,1)
 I $G(STANAME)="" S STANAME=$$GET1^DIQ(58.41,STATE,.01)   ;Zero Report
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
 ;Zero Report Sent
 I (BATTYPE="ZY") D
 . S XMSUB=STANAME_" SPMP Controlled Substance Zero Report: "_$$FMTE^XLFDT($$GET1^DIQ(58.42,BATCHIEN,4,"I")\1,"5Z")
 . S PSOMSG(1)="No prescriptions met the submission criteria for Pharmacies using DEA#"_DEA
 . S PSOMSG(2)="A Zero Report has been transmitted to the state."
 ;
 ;Zero Report NOT Sent
 I (BATTYPE="ZN") D
 . N XDT S XDT=$$FMADD^XLFDT((DT\1),-1)
 . S XMSUB=STANAME_" SPMP Controlled Substance Zero Report: "_$$FMTE^XLFDT((XDT\1),"5Z")
 . S PSOMSG(1)="No prescriptions met the submission criteria. "
 . S PSOMSG(2)="Follow your state's guidance for manual upload of a Zero Report, if required."
 ;
GROUP ;
 S XMTEXT="PSOMSG("
 ; If there are no active members in the mailgroup sends message to PSDMGR key holders
 I $$GOTLOCAL^XMXAPIG("PSO SPMP NOTIFICATIONS") D
 . S XMY("G.PSO SPMP NOTIFICATIONS")=""
 E  D
 . S USR=0 F  S USR=$O(^XUSEC("PSDMGR",USR)) Q:'USR  S XMY(USR)=""
 ;
 D ^XMD
 Q
CHK5841 ; Check the SPMP STATE PARAMETERS file (#58.41) for presence of state transmission info
 N SITEIEN,SITE,STATEIEN,STATE,FOUND,XREF,RXDT,ENDDT,RXIEN,RXFILL,FILL
 K ^TMP("PSO5841",$J)
 S SITEIEN=0
 F  S SITEIEN=$O(^PS(59,SITEIEN)) Q:'SITEIEN  D
 . S STATEIEN=$$GET1^DIQ(59,SITEIEN,.08,"I")
 . I 'STATEIEN Q
 . I $P($$SPOK^PSOSPMUT(STATEIEN),"^")=-1 D
 .. S FOUND=0
 .. F XREF="AL","AM" D
 ... S RXDT=$$FMADD^XLFDT(DT,-365),RXDT=RXDT+.01,ENDDT=$$FMADD^XLFDT(DT,-1),ENDDT=ENDDT+.2359
 ... F  S RXDT=$O(^PSRX(XREF,RXDT)) Q:'RXDT!(RXDT>ENDDT)  D
 .... S RXIEN=0 F  S RXIEN=$O(^PSRX(XREF,RXDT,RXIEN)) Q:'RXIEN  Q:FOUND  D
 ..... S RXFILL="" F  S RXFILL=$O(^PSRX(XREF,RXDT,RXIEN,RXFILL)) Q:RXFILL=""  D
 ...... S FILL=$S(XREF="AL":RXFILL,1:"P"_RXFILL)
 ...... I $$RXSTATE^PSOBPSUT(RXIEN,0)'=STATEIEN Q
 ...... I $$SCREEN^PSOSPMUT(RXIEN,FILL) Q
 ...... S ^TMP("PSO5841",$J,SITEIEN)="Controlled Substance Rx found, but transmission info is missing for "_$$GET1^DIQ(59,SITEIEN,.08)_" in the SPMP STATE PARAMETERS file (#58.41)."
 ...... S FOUND=1
 I $D(^TMP("PSO5841",$J)) D
 . S SITEIEN=0
 . F  S SITEIEN=$O(^TMP("PSO5841",$J,SITEIEN)) Q:'SITEIEN  D
 .. S SITE=$$GET1^DIQ(59,SITEIEN,.01)
 .. S STATE=$$GET1^DIQ(59,SITEIEN,.08)
 .. S XMSUB=SITE_" Controlled Substances PMP State Parameters Missing"
 .. S PSOMSG(1)=SITE_" doesn't currently transmit controlled substance records"
 .. S PSOMSG(2)="because it is in a state ("_STATE_") that doesn't have SPMP"
 .. S PSOMSG(3)="state parameters defined in your VistA system. Please enter a helpdesk"
 .. S PSOMSG(4)="ticket if you need assistance setting up SPMP state parameters for"
 .. S PSOMSG(5)=STATE_"."
 .. D GROUP
 . K ^TMP("PSO5841",$J)
 Q
