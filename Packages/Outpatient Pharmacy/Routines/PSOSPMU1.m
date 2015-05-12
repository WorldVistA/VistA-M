PSOSPMU1 ;BIRM/MFR - State Prescription Monitoring Program Utilities ;10/07/12
 ;;7.0;OUTPATIENT PHARMACY;**408,437**;DEC 1997;Build 3
 ; 
SETLN(NSPC,TEXT,REV,UND,HIG) ; Sets a line to be displayed in the Body section
 N X
 S:$G(TEXT)="" $E(TEXT,80)=""
 S:$L(TEXT)>80 TEXT=$E(TEXT,1,80)
 S LINE=LINE+1,^TMP(NSPC,$J,LINE,0)=$G(TEXT)
 ;
 I LINE>$G(PSOLSTLN) D SAVE^VALM10(LINE) S PSOLSTLN=LINE
 ;
 I $G(REV) D  Q
 . D CNTRL^VALM10(LINE,1,$L(TEXT),IORVON,IOINORM)
 . I $G(UND) D CNTRL^VALM10(LINE,$L(TEXT)+1,80,IOUON,IOINORM)
 I $G(UND) D CNTRL^VALM10(LINE,1,80,IOUON,IOINORM)
 I $G(HIG) D
 . D CNTRL^VALM10(LINE,HIG,80,IOINHI_$S($G(UND):IOUON,1:""),IOINORM)
 Q
 ;
RXFILL(RXIEN) ; Select Prescription Fill #
 N RXFILL,DIR,I,Y,DIRUT,DTOUT,FILLARR,RTSFILL,RTSFLDT
 S RXFILL=0,FILLARR(0)=""
 K DIR S DIR("A")=" Fill",DIR("B")=0
 S DIR(0)="S^0:Original  ("_$$FMTE^XLFDT($$RXFLDT^PSOBPSUT(RXIEN,0),2)_")  "_$$MWA(RXIEN,0)
 F I=1:1 Q:'$D(^PSRX(RXIEN,1,I))  D
 . S DIR(0)=DIR(0)_";"_I_":Refill "_I_"  ("_$$FMTE^XLFDT($$RXFLDT^PSOBPSUT(RXIEN,I),2)_")  "_$$MWA(RXIEN,I),FILLARR(I)=""
 F I=1:1 Q:'$D(^PSRX(RXIEN,"P",I))  D
 . S DIR(0)=DIR(0)_";P"_I_":Partial "_I_" ("_$$FMTE^XLFDT($$RXFLDT^PSOBPSUT(RXIEN,"P"_I),2)_")  "_$$MWA(RXIEN,"P"_I),FILLARR("P"_I)=""
 F I=1:1 Q:'$D(^PSRX(RXIEN,"RTS",I))  D
 . S RTSFILL=$P(^PSRX(RXIEN,"RTS",I,0),"^",2) I $D(FILLARR(RTSFILL)) Q
 . S RTSFLDT=$P(^PSRX(RXIEN,"RTS",I,0),"^",3)
 . S FILLARR(RTSFILL)=""
 . S DIR(0)=DIR(0)_";"_RTSFILL_":"_$S(RTSFILL["P":"Partial "_$E(RTSFILL,2,9),1:"Refill "_RTSFILL)_"  ("_$$FMTE^XLFDT(RTSFLDT,2)_") "_$$MWA(RXIEN,RTSFILL)
 D ^DIR I $D(DIRUT)!$D(DTOUT) Q "^"
 S RXFILL=$G(Y)
 Q RXFILL
 ;
MWA(RXIEN,FILL) ; Returns the Rx delivering (WINDOW/MAIL/ADMIN IN CLINIC)
 I FILL["P" Q $$GET1^DIQ(52.2,$E(FILL,2,3)_","_RXIEN,.02)
 I FILL Q:$$GET1^DIQ(52.1,FILL_","_RXIEN,23,"I") "ADMIN IN CLINIC" Q $$GET1^DIQ(52.1,FILL_","_RXIEN,2)
 Q:$$GET1^DIQ(52,RXIEN,14,"I") "ADMIN IN CLINIC"
 Q $$GET1^DIQ(52,RXIEN,11)
 ;
GATHER(STATE,BEGDTTM,ENDDTTM,RECTYPE,RTSONLY) ; Gathers all CS prescriptions for Data Range
 ;Input: STATE   - Pointer to the STATE file (#5)
 ;       BEGDTTM - Date Range Begin Date/Time
 ;       ENDDTTM - Date Range End Date/Time
 ;       RECTYPE - Record Type for Released Rx's only (N: New / R: Revise)
 ;       RTSONLY - Return To Stock Fills Only (1: YES / 0: NO)
 ;Output: $$GATHER - Number of Rx's found
 ;        ^TMP("PSOSPMRX",$J,STATE,RX,FILL)=Record Type (N/R/V) - List of Rx's gathered
 N GATHER,XREF,RXRLDT,RXIEN,RXFILL,FILL,RTSDT,ENDRTSDT
 ;
 S GATHER=0 K ^TMP("PSOSPMRX",$J)
 ; - Gathering Released Original Fills/Refills/Partials
 I '$G(RTSONLY) D
 . F XREF="AL","AM" D
 . . S RXRLDT=BEGDTTM,ENDRLDT=ENDDTTM S:'$P(ENDRLDT,".",2) ENDRLDT=ENDRLDT+.25
 . . F  S RXRLDT=$O(^PSRX(XREF,RXRLDT)) Q:'RXRLDT!(RXRLDT>ENDRLDT)  D
 . . . S RXIEN=0 F  S RXIEN=$O(^PSRX(XREF,RXRLDT,RXIEN)) Q:'RXIEN  D
 . . . . S RXFILL="" F  S RXFILL=$O(^PSRX(XREF,RXRLDT,RXIEN,RXFILL)) Q:RXFILL=""  D
 . . . . . S FILL=$S(XREF="AL":RXFILL,1:"P"_RXFILL)
 . . . . . I '$$RXRLDT^PSOBPSUT(RXIEN,FILL) Q
 . . . . . I $$SCREEN^PSOSPMUT(RXIEN,FILL) Q
 . . . . . I $$RXSTATE^PSOBPSUT(RXIEN,0)'=STATE Q
 . . . . . S ^TMP("PSOSPMRX",$J,STATE,RXIEN,FILL)=RECTYPE
 . . . . . S GATHER=GATHER+1
 ;
 ; ASAP 1995 does not support transmissions of Return To Stock fills in the same file
 I $$GET1^DIQ(58.41,STATE,1,"I")="1995",'$G(RTSONLY) Q GATHER
 ;
 ; - Gathering Fills Returned To Stock
 S RTSDT=BEGDTTM-.0000001,ENDRTSDT=ENDDTTM S:'$P(ENDRTSDT,".",2) ENDRTSDT=ENDRTSDT+.25
 F  S RTSDT=$O(^PSRX("ARTS",RTSDT)) Q:'RTSDT!(RTSDT>ENDRTSDT)  D
 . S RXIEN=0 F  S RXIEN=$O(^PSRX("ARTS",RTSDT,RXIEN)) Q:'RXIEN  D
 . . S RTSIEN=0 F  S RTSIEN=$O(^PSRX("ARTS",RTSDT,RXIEN,RTSIEN)) Q:'RTSIEN  D
 . . . S FILL=$$GET1^DIQ(52.07,RTSIEN_","_RXIEN,1,"I")
 . . . I '$D(^PS(58.42,"ARX",RXIEN,FILL)) Q
 . . . I $$RXRLDT^PSOBPSUT(RXIEN,FILL) Q
 . . . I $$SCREEN^PSOSPMUT(RXIEN,FILL) Q
 . . . I $D(^TMP("PSOSPMRX",$J,STATE,RXIEN,FILL)) Q
 . . . I $$RXSTATE^PSOBPSUT(RXIEN,0)'=STATE Q
 . . . S ^TMP("PSOSPMRX",$J,STATE,RXIEN,FILL)="V"
 . . . S GATHER=GATHER+1
 Q GATHER
 ;
BLDBAT(EXPTYPE,BEGRLDT,ENDRLDT) ; Given a list of Rx's builds a new Export Batch
 ; Input: (r) EXPTYPE - Export Type ((MA)naul/(SC)heduled/(RX) Single Rx)/(VD) Void Only
 ;        (o) BEGRLDT  - Begin Release Date (FM Format) (Required for M and S batches)
 ;        (o) ENDRLDT - End Release Date (FM Format) (Required for M and S batches)
 ;        (r) List of Rx's: ^TMP("PSOSPMRX",$J,STATE,RXIEN,RXFILL)=Record Type ((N)ew/(R)evise/(V)oid)
 ;                          Note: This ^TMP global will be cleaned up at the end
 ;Output: BATCHIEN - New Batch IEN (Pointer to #58.42) OR "01^Error Message"
 ;
 N STATE,SPOK,RX,FILL,BATCHIEN,%,DIC,DR,DA,X,XX,DINUM,DLAYGO,DD,DO
 I '$O(^TMP("PSOSPMRX",$J,0)) Q "-1^No prescription data"
 ;
 S (STATE,RX)=0,FILL=""
 F  S STATE=$O(^TMP("PSOSPMRX",$J,STATE)) Q:'STATE  D  I $P(BATCHIEN,"^")=-1 Q
 . S XX=$$SPOK^PSOSPMUT(STATE) I $P(XX,"^",1)=-1 S BATCHIEN=XX Q
 . F  L +^PS(58.42,0):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) Q:$T  H 3
 . S (DINUM,BATCHIEN)=$O(^PS(58.42,999999999999),-1)+1
 . I EXPTYPE'="VD" W !!,"Creating Batch #",DINUM," for ",$$GET1^DIQ(58.41,STATE,.01),"..."
 . S DIC="^PS(58.42,",X=DINUM,DIC(0)="",DIC("DR")="1////"_STATE_";2///"_EXPTYPE_";8///"_$$NOW^XLFDT()
 . I $G(BEGRLDT) D
 . . S DIC("DR")=DIC("DR")_";4///"_BEGRLDT_";5///"_$G(ENDRLDT)
 . S DLAYGO=58.42 K DD,DO D FILE^DICN K DD,DO
 . L -^PS(58.42,0)
 . I Y=-1 S BATCHIEN="-1^Export Batch could not be created" Q
 . F  S RX=$O(^TMP("PSOSPMRX",$J,STATE,RX)) Q:'RX  D
 . . F  S FILL=$O(^TMP("PSOSPMRX",$J,STATE,RX,FILL)) Q:FILL=""  D
 . . . K DIC,DINUM,DA S DIC="^PS(58.42,"_BATCHIEN_",""RX"",",DIC(0)="",DA(1)=BATCHIEN
 . . . S X=RX,DIC("DR")="1///"_FILL_";2///"_^TMP("PSOSPMRX",$J,STATE,RX,FILL)
 . .  .S DLAYGO=58.42001 K DD,DO D FILE^DICN K DD,DO
 . I EXPTYPE'="VD" W "Done."
 K ^TMP("PSOSPMRX",$J)
 Q BATCHIEN
 ;
LOADRTS(RXIEN,FILL,ARRAY) ; Load ARRAY with Return To Stock Information
 ;Input: Rx IEN - Pointer to PRESCRIPTION file (#52)
 ;       Fill # - "0":Original / "1"..:Refill #1... / "P1"..:Partial 1...
 ;       ARRAY  - Return Array (most recent Return To Stock data for the fill)
 N RTSIEN,NODE0,NODE1
 K ARRAY S RTSIEN=0
 F  S RTSIEN=$O(^PSRX(RXIEN,"RTS",RTSIEN)) Q:'RTSIEN  D
 . S NODE0=$G(^PSRX(RXIEN,"RTS",RTSIEN,0))
 . S NODE1=$G(^PSRX(RXIEN,"RTS",RTSIEN,1))
 . I $P(NODE0,"^",2)'=FILL Q
 . S ARRAY("DIVISION")=$P(NODE0,"^",13) ; Division
 . S ARRAY("RELDTTM")=$P(NODE1,"^",2)   ; Release Date/Time
 . S ARRAY("NDC")=$P(NODE0,"^",15)      ; NDC
 . S ARRAY("QTY")=$P(NODE0,"^",4)       ; Quantity
 . S ARRAY("DAYSUP")=$P(NODE0,"^",5)    ; Days Supply
 . S ARRAY("RPHIEN")=$P(NODE0,"^",9)    ; Pharmacist IEN
 . S ARRAY("PRVIEN")=$P(NODE1,"^",1)    ; Provider IEN
 Q
 ;
PREPFILE(STATE,DATETIME,RTSONLY) ; Prepare Files (FTP Script and Output Data files)
 ;Input: STATE - Pointer to STATE file (#5)
 ;       DATETIME - Date/Time for the file names (format: YYYYMMDDHHMMSS)
 ;       RTSONLY  - Return To Stock Only Batch? (1: YES)
 N PSOOS,LOCDIR,PREFIX,FILEXT,FTPIP,FTPUSR,FTPPORT,FTPDIR,FTPFILE,INPTFILE,LOGFILE,EXPFILE
 ; - Operating System
 S PSOOS=$$OS^%ZOSV()
 ;
 I +$$SPOK^PSOSPMUT(STATE)=-1 Q $$SPOK^PSOSPMUT(STATE)
 ;
 ; - Retrieving the Local Directory for the corresponding OS
 I PSOOS["VMS" S LOCDIR=$$GET1^DIQ(58.41,STATE,4)
 I PSOOS["UNIX" S LOCDIR=$$GET1^DIQ(58.41,STATE,15)
 I PSOOS["NT" S LOCDIR=$$GET1^DIQ(58.41,STATE,16)
 ;
 S PREFIX=$$GET1^DIQ(58.41,STATE,5)
 S FILEXT=$$GET1^DIQ(58.41,STATE,6)
 S FTPIP=$$GET1^DIQ(58.41,STATE,7)
 S FTPUSR=$$GET1^DIQ(58.41,STATE,8)
 S FTPPORT=$$GET1^DIQ(58.41,STATE,9)
 S FTPDIR=$$GET1^DIQ(58.41,STATE,10)
 ;
 S INPTFILE="SPMP_FTP_"_DATETIME_".DAT"
 I PSOOS["VMS"!(PSOOS["NT") S FTPFILE="SPMP_FTP_"_DATETIME_".COM"
 S LOGFILE="SPMP_FTP_"_DATETIME_".LOG"
 S EXPFILE=PREFIX_DATETIME_".up"
 I $G(RTSONLY) S EXPFILE="BACK_"_EXPFILE
 ;
 D OPEN^%ZISH("INPTFILE",LOCDIR,INPTFILE,"W")  I POP Q "-1^FTP Script file <"_LOCDIR_INPTFILE_">  could not be created."
 D USE^%ZISUTL("INPTFILE")
 W:FTPDIR'="" "cd "_FTPDIR,!
 W "put "_$S(PSOOS["UNIX":LOCDIR,1:"")_EXPFILE,!
 W "rename "_EXPFILE_" "_$P(EXPFILE,".up",1)_FILEXT,!
 W "exit",!
 D CLOSE^%ZISH("INPTFILE")
 I POP Q "-1^FTP Input file <"_INPTFILE_"> cannot be created."
 ;
 ; This sFTP command file is not needed for Linux/Unix
 I PSOOS["VMS"!(PSOOS["NT") D  I POP Q "-1^FTP Script file <"_LOCDIR_FTPFILE_"> could not be created."
 . D OPEN^%ZISH("FTPFILE",LOCDIR,FTPFILE,"W")
 . D USE^%ZISUTL("FTPFILE")
 . ; VMS Secure FTP
 . I PSOOS["VMS" D
 . . W "$ SET VERIFY=(PROCEDURE,IMAGE)",!
 . . I LOCDIR'="" W "$ SET DEFAULT "_LOCDIR,!
 . . W "$ sftp"_$S(FTPPORT:" -oPort="_FTPPORT,1:"")_" -oidentityfile="""_$$XVMSDIR(LOCDIR)_"VMSSSHID."" -""B"" "_INPTFILE_" "_FTPUSR_"@"_FTPIP,!
 . . W "$ exit",!
 . ; Windows/Open NT Secure FTP
 . I PSOOS["NT" D
 . . I LOCDIR'="" W "cd ",LOCDIR,!
 . . W "sftp"_$S(FTPPORT:" -oPort="_FTPPORT,1:"")_" -oidentityfile="""_LOCDIR_"VMSSSHKEY"" -B "_LOCDIR_INPTFILE_" "_FTPUSR_"@"_FTPIP,!
 . . W "exit 0",!
 . D CLOSE^%ZISH("FTPFILE")
 ;
 I PSOOS["VMS" D  I POP Q "-1^FTP Script file <"_LOCDIR_"VMSSSHID.> could not be created."
 . D OPEN^%ZISH("VMSSSHID",LOCDIR,"VMSSSHID.","W")
 . D USE^%ZISUTL("VMSSSHID")
 . W "IDKEY "_$$XVMSDIR(LOCDIR)_"VMSSSHKEY"
 . D CLOSE^%ZISH("FTPFILE")
 ;
 D SAVEKEYS(STATE,LOCDIR)
 ;
 Q (LOCDIR_"^"_EXPFILE_"^"_$G(FTPFILE)_"^"_$G(INPTFILE)_"^"_LOGFILE_"^"_$P(EXPFILE,".up")_FILEXT)
 ;
FTPFILE(STATEIP,STATEUSR,LOCDIR,FTPFILE,LOGFILE,INPTFILE,FTPPORT) ; Issue the Secure FTP command
 N PSOOS,PV,XPV1
 S PSOOS=$$OS^%ZOSV()
 I PSOOS["VMS" S XPV1="S PV=$ZF(-1,""@"_LOCDIR_FTPFILE_"/OUTPUT="_LOCDIR_LOGFILE_""")"
 I PSOOS["UNIX" S XPV1="S PV=$ZF(-1,""sftp"_$S(FTPPORT:" -oPort="_FTPPORT,1:"")_" -oidentityfile="""""_LOCDIR_"linuxsshkey"""" -b "_LOCDIR_INPTFILE_" "_$TR(STATEUSR,"""","")_"@"_STATEIP_" > "_LOCDIR_LOGFILE_""")"
 I PSOOS["NT" S XPV1="S PV=$ZF(-1,"""_LOCDIR_FTPFILE_">"_LOCDIR_LOGFILE_""")"
 ;
 X XPV1  ; Execute the FTP command
 ;
 ; Error flag logic
 I PV=-1 Q "-1^Secure FTP Transmission failed"
 ;
 Q ""
 ;
DELFILE(FILE) ; Deletes file
 N PV
 I $$OS^%ZOSV()["VMS"  D DELVMS(FILE)
 I $$OS^%ZOSV()["UNIX" D DELUNIX(FILE)
 I $$OS^%ZOSV()["NT" D DELWIN(FILE)
 I PV=-1 Q "-1^There was an error deleting the file locally."
 Q ""
 ;
DELVMS(FILE) ; Delete VMS files
 N XPV
 S XPV="S PV=$ZF(-1,""DEL "_FILE_";*"")"
 X XPV
 Q
DELWIN(FILE) ; Delete windows files
 N XPV
 S XPV="S PV=$ZF(-1,""DEL "_FILE_""")"
 X XPV
 Q
DELUNIX(FILE) ; Delete Unix files
 N XPV
 S XPV="S PV=$ZF(-1,""rm -f "_FILE_""")"
 X XPV
 Q
 ;
PAUSE ; Pauses screen until user hits Return
 W ! K DIR S DIR("A")="Press Return to continue",DIR(0)="E" D ^DIR
 Q
 ;
XVMSDIR(VMSDIR) ; Converts a VMS directory from "USER$:[SPMP]" to "/USER$/SPMP/" format
 Q "/"_$TR(VMSDIR,".[]:","///") ;*437
 ;
SAVEKEYS(STATE,LOCDIR) ; Saves Key
 N WLINE
 D OPEN^%ZISH("VMSSSHKEY",LOCDIR,"VMSSSHKEY","W")
 D USE^%ZISUTL("VMSSSHKEY")
 F WLINE=1:1 Q:'$D(^PS(58.41,STATE,"PRVKEY",WLINE))  D
 . W $$DECRYP^XUSRB1(^PS(58.41,STATE,"PRVKEY",WLINE,0)),!
 D CLOSE^%ZISH("VMSSSHKEY")
 ;
 I $$OS^%ZOSV()["UNIX" D  Q
 . N XPV
 . S XPV="S PV=$ZF(-1,""ssh-keygen -i -f "_LOCDIR_"VMSSSHKEY > "_LOCDIR_"linuxsshkey"")"
 . X XPV
 . S XPV="S PV=$ZF(-1,""chmod 600 "_LOCDIR_"linuxsshkey"")"
 . X XPV
 ;
 D OPEN^%ZISH("VMSSSHKEY",LOCDIR,"VMSSSHKEY.PUB","W")
 D USE^%ZISUTL("VMSSSHKEY")
 F WLINE=1:1 Q:'$D(^PS(58.41,STATE,"PUBKEY",WLINE))  D
 . W $$DECRYP^XUSRB1(^PS(58.41,STATE,"PUBKEY",WLINE,0)),!
 D CLOSE^%ZISH("VMSSSHKEY")
 Q
 ;
LINUXDIR() ; Returns the Linux Directory for SPMP sFTP
 N CURDIR
 I $$OS^%ZOSV()'="UNIX" Q ""
 I $$UP^XLFSTR($$VERSION^%ZOSV(1))'["CACHE" Q ""
 ; Retrieving the current directory
 X "S CURDIR=$ZU(12)"
 Q $P(CURDIR,"/",1,4)_"/user/sftp/spmp/"
 ;
DIREXIST(DIR) ; Returns whether the Linux Directory for SPMP sFTP already exists
 N DIREXIST
 I DIR="" Q 0
 I $$OS^%ZOSV()'="UNIX" Q 0
 I $$UP^XLFSTR($$VERSION^%ZOSV(1))'["CACHE" Q 0
 I $E(DIR,$L(DIR))="/" S $E(DIR,$L(DIR))=""
 X "S DIREXIST=$ZSEARCH(DIR)"
 Q $S(DIREXIST="":0,1:1)
 ;
MAKEDIR(DIR) ; Create a new directory
 N MKDIR
 I $$OS^%ZOSV()'="UNIX" Q
 I $$UP^XLFSTR($$VERSION^%ZOSV(1))'["CACHE" Q
 I $$DIREXIST(DIR) Q
 X "S MKDIR=$ZF(-1,""mkdir ""_DIR)"
 I 'MKDIR X "S MKDIR=$ZF(-1,""chmod 777 ""_DIR)"
 Q
