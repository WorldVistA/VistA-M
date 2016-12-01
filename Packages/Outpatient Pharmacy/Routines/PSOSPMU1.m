PSOSPMU1 ;BIRM/MFR - State Prescription Monitoring Program Utilities ;10/07/12
 ;;7.0;OUTPATIENT PHARMACY;**408,437,451**;DEC 1997;Build 114
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
 S RTSDT=BEGDTTM-.0000001,ENDRTSDT=ENDDTTM
 S:'$P(ENDRTSDT,".",2) ENDRTSDT=ENDRTSDT+.25
 F  S RTSDT=$O(^PSRX("ARTS",RTSDT)) Q:'RTSDT!(RTSDT>ENDRTSDT)  D
 . S RXIEN=0 F  S RXIEN=$O(^PSRX("ARTS",RTSDT,RXIEN)) Q:'RXIEN  D
 . . S RTSIEN=0 F  S RTSIEN=$O(^PSRX("ARTS",RTSDT,RXIEN,RTSIEN)) Q:'RTSIEN  D
 . . . S FILL=$$GET1^DIQ(52.07,RTSIEN_","_RXIEN,1,"I")
 . . . ; Rx Fill was never sent to SPMP so no need to VOID it
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
 N STATE,SPOK,RX,FILL,BATCHIEN,DRUGIEN,%,DIC,DR,DA,X,Y,XX,DINUM,DLAYGO,DD,DO,NDC,RECTYPE
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
 . . S DRUGIEN=$$GET1^DIQ(52,RX,6,"I")
 . . F  S FILL=$O(^TMP("PSOSPMRX",$J,STATE,RX,FILL)) Q:FILL=""  D
 . . . K DIC,DINUM,DA S DIC="^PS(58.42,"_BATCHIEN_",""RX"",",DIC(0)="",DA(1)=BATCHIEN
 . . . S RECTYPE=^TMP("PSOSPMRX",$J,STATE,RX,FILL)
 . . . I RECTYPE="V" D
 . . . . S NDC=$$GETNDC(RX,FILL)
 . . . E  D
 . . . . I $L($$NUMERIC^PSOASAP0($$GET1^DIQ(50,DRUGIEN,31)))=11 D
 . . . . . S NDC=$$GET1^DIQ(50,DRUGIEN,31)
 . . . . E  S NDC=$$GETNDC^PSONDCUT(RX,+FILL)
 . . . S X=RX,DIC("DR")="1///"_FILL_";2///"_RECTYPE_";3///"_NDC
 . . . S DLAYGO=58.42001 K DD,DO D FILE^DICN K DD,DO
 . I EXPTYPE'="VD" W "Done."
 K ^TMP("PSOSPMRX",$J)
 Q BATCHIEN
 ;
LOADRTS(RXIEN,FILL,ARRAY) ; Load ARRAY with Return To Stock Information
 ;Input: RXIEN - Pointer to PRESCRIPTION file (#52)
 ;       FILL  - Fill # - "0":Original / "1"..:Refill #1... / "P1"..:Partial 1...
 ;Output:ARRAY - Return Array (most recent Return To Stock data for the fill)
 N RTSIEN,NODE0,NODE1,NDC
 K ARRAY S RTSIEN=0
 F  S RTSIEN=$O(^PSRX(RXIEN,"RTS",RTSIEN)) Q:'RTSIEN  D
 . S NODE0=$G(^PSRX(RXIEN,"RTS",RTSIEN,0))
 . I $P(NODE0,"^",2)'=FILL Q
 . S NODE1=$G(^PSRX(RXIEN,"RTS",RTSIEN,1))
 . S NDC=$$GETNDC(RXIEN,FILL) I NDC="" S NDC=$P(NODE0,"^",15)
 . S ARRAY("DIVISION")=$P(NODE0,"^",13) ; Division
 . S ARRAY("RELDTTM")=$P(NODE1,"^",2)   ; Release Date/Time
 . S ARRAY("NDC")=NDC                   ; NDC
 . S ARRAY("QTY")=$P(NODE0,"^",4)       ; Quantity
 . S ARRAY("DAYSUP")=$P(NODE0,"^",5)    ; Days Supply
 . S ARRAY("RPHIEN")=$P(NODE0,"^",9)    ; Pharmacist IEN
 . S ARRAY("PRVIEN")=$P(NODE1,"^",1)    ; Provider IEN
 Q
 ;
GETNDC(RXIEN,FILL) ; Get the SENT NDC for the Return To Stock (VOID) record
 ;Input: RXIEN - Pointer to PRESCRIPTION file (#52)
 ;       FILL  - Fill # - "0":Original / "1"..:Refill #1... / "P1"..:Partial 1...
 ;Output: $$GETNDC - Return To Stock NDC
 N GETRSNDC,BATCH,RXREC,RXREC0
 I '$G(RXIEN)!$G(FILL)="" Q ""
 S GETRSNDC=""
 S BATCH="" F  S BATCH=$O(^PS(58.42,"ARX",RXIEN,FILL,BATCH),-1) Q:'BATCH  D  I GETRSNDC'="" Q
 . S RXREC="" F  S RXREC=$O(^PS(58.42,"ARX",RXIEN,FILL,BATCH,RXREC),-1) Q:'RXREC  D  I GETRSNDC'="" Q
 . . S RXREC0=$G(^PS(58.42,BATCH,"RX",RXREC,0)) I $P(RXREC0,"^",3)="V" Q
 . . S GETRSNDC=$P(RXREC0,"^",4)
 Q GETRSNDC
 ;
PREPFILE(STATE,DATETIME,RTSONLY,DEBUG) ; Prepare Files (FTP Script and Output Data files)
 ;Input: STATE - Pointer to STATE file (#5)
 ;       DATETIME - Date/Time for the file names (format: YYYYMMDDHHMMSS)
 ;       RTSONLY  - Return To Stock Only Batch? (1: YES)
 ;       DEBUG    - Debug Mode? (1:YES / 0:NO)
 N PSOOS,LOCDIR,PREFIX,FILEXT,RENAME,FTPIP,FTPUSR,FTPPORT,FTPDIR,FTPFILE,INPTFILE,EXPFILE,LOGFILE
 ; - Operating System
 S PSOOS=$$OS^%ZOSV()
 ;
 I +$$SPOK^PSOSPMUT(STATE)=-1 Q $$SPOK^PSOSPMUT(STATE)
 ;
 ; - Retrieving the Local Directory for the corresponding OS
 I PSOOS["VMS" S LOCDIR=$$GET1^DIQ(58.41,STATE,4)
 I PSOOS["UNIX" S LOCDIR=$$GET1^DIQ(58.41,STATE,15)
 ;
 S PREFIX=$$GET1^DIQ(58.41,STATE,5)
 S FILEXT=$$GET1^DIQ(58.41,STATE,6)
 S RENAME=$$GET1^DIQ(58.41,STATE,17,"I")
 S FTPIP=$$GET1^DIQ(58.41,STATE,7)
 S FTPUSR=$$GET1^DIQ(58.41,STATE,8)
 S FTPPORT=$$GET1^DIQ(58.41,STATE,9)
 S FTPDIR=$$GET1^DIQ(58.41,STATE,10)
 ;
 S INPTFILE="SPMP_FTP_"_DATETIME_".INP"
 I PSOOS["VMS" S FTPFILE="SPMP_FTP_"_DATETIME_".COM"
 S LOGFILE="SPMP_FTP_"_DATETIME_".LOG"
 S EXPFILE=PREFIX_DATETIME_$S(RENAME:".UP",1:FILEXT)
 I $G(RTSONLY) S EXPFILE="BACK_"_EXPFILE
 ;
 D OPEN^%ZISH("INPTFILE",LOCDIR,INPTFILE,"W")  I POP Q "-1^FTP Script file <"_LOCDIR_INPTFILE_">  could not be created."
 D USE^%ZISUTL("INPTFILE")
 W:FTPDIR'="" "cd "_FTPDIR,!
 W "put "_$S(PSOOS["UNIX":LOCDIR,1:"")_EXPFILE,!
 W:PSOOS["UNIX" "lcd "_LOCDIR,!
 W:RENAME "rename "_EXPFILE_" "_$P(EXPFILE,".UP")_FILEXT,!
 W:PSOOS["VMS" "lrm "_EXPFILE,!
 ; W:PSOOS["UNIX" "!rm -f "_LOCDIR_EXPFILE,!
 W "exit",!
 D CLOSE^%ZISH("INPTFILE")
 I POP Q "-1^FTP Input file <"_INPTFILE_"> cannot be created."
 ;
 ; This sFTP command file is not needed for Linux/Unix
 I PSOOS["VMS" D  I POP Q "-1^FTP Script file <"_LOCDIR_FTPFILE_"> could not be created."
 . D OPEN^%ZISH("FTPFILE",LOCDIR,FTPFILE,"W")
 . D USE^%ZISUTL("FTPFILE")
 . ; VMS Secure FTP
 . I PSOOS["VMS" D
 . . W "$ SET VERIFY=(PROCEDURE,IMAGE)",!
 . . I LOCDIR'="" W "$ SET DEFAULT "_LOCDIR,!
 . . W "$ sftp"_$S($G(DEBUG):" -""D3""",1:"")_$S(FTPPORT:" -oPort="_FTPPORT,1:"")_" -oIdentityFile="""_$$XVMSDIR(LOCDIR)_"VMSSSHID."" -""B"" "_INPTFILE_" -oUser="_FTPUSR_" "_FTPIP,!
 . . W "$ exit",!
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
 Q (LOCDIR_"^"_EXPFILE_"^"_$G(FTPFILE)_"^"_$G(INPTFILE)_"^"_$G(LOGFILE)_"^"_PREFIX_DATETIME_FILEXT)
 ;
FTPFILE(STATEIP,STATEUSR,LOCDIR,FTPFILE,EXPFILE,INPTFILE,LOGFILE,FTPPORT,DEBUG) ; Issue the Secure FTP command
 ;Input: STATEIP  - State Server IP Address
 ;       STATEUSR - Username at the State Server
 ;       LOCDIR   - Local Directory
 ;       FTPFILE  - sFTP executable batch file (VMS and NT only)
 ;       EXPFILE  - Data Export File
 ;       INPTFILE - sFTP input file
 ;       LOGFILE  - sFTP Capture Log File (VMS only)
 ;       FTPPORT  - State Server Port #
 ;       DEBUG    - Debug Mode? (1:YES / 0:NO)
 N PSOOS,PV,XPV1
 S PSOOS=$$OS^%ZOSV()
 I PSOOS["VMS" S XPV1="S PV=$ZF(-1,""@"_LOCDIR_FTPFILE_"/OUTPUT="_LOCDIR_LOGFILE_""")"
 I PSOOS["UNIX" D
 . S XPV1="S PV=$ZF(-1,""sftp"_$S($G(DEBUG):" -oLogLevel=DEBUG1",1:"")_$S(FTPPORT:" -oPort="_FTPPORT,1:"")_" -oIdentityFile="""""_LOCDIR_"linuxsshkey"""" -b "_LOCDIR_INPTFILE
 . S XPV1=XPV1_" -oStrictHostKeyChecking=no -oUser="_$TR(STATEUSR,"""","")_" "_STATEIP_" >> "_LOCDIR_LOGFILE_""")"
 ;
 X XPV1  ; Execute the FTP command
 ;
 ; Error flag logic
 I PV=-1 Q "-1^Secure FTP Transmission failed"
 ;
 ; If Export File exists locally it means the sFTP did not finish because it removes the local file
 N FILEARR,ERROR
 ;I PSOOS["VMS" S FILEARR(EXPFILE)="" I $$FEXIST^%ZISH(LOCDIR,"FILEARR") S ERROR=1
 I PSOOS["VMS" I $$FEXIST^PSOSPMUT(LOCDIR,EXPFILE) S ERROR=1
 I PSOOS["UNIX" D
 . N XLOG,LOG,LINE
 . S ERROR=1 K ^TMP("PSOFTPLG",$J)
 . S XLOG=$$FTG^%ZISH(LOCDIR,LOGFILE,$NAME(^TMP("PSOFTPLG",$J,1)),3)
 . S (LOG,LINE)=0
 . F  S LOG=$O(^TMP("PSOFTPLG",$J,LOG)) Q:LOG=""  D  I 'ERROR Q
 . . S LINE=$G(^TMP("PSOFTPLG",$J,LOG)) I $$UP^XLFSTR(LINE)["SFTP> EXIT" S ERROR=0
 ;
 I $G(ERROR) Q "-1^Secure FTP Transmission failed."
 ;
 Q ""
 ;
DELFILES(LOCDIR,EXPFILE,INPTFILE,FTPFILE,LOGFILE) ; Delete Files
 ;Input: LOCDIR   - Local Directory
 ;       EXPFILE  - Data Export File
 ;       INPTFILE - sFTP input file
 ;       FTPFILE  - sFTP executable batch file (VMS and NT only)
 ;       LOGFILE  - sFTP Log Capture batch file (VMS and NT only)
 N FILE2DEL,PSOOS ;,FILEARR
 I $G(LOCDIR)="" Q
 S PSOOS=$$OS^%ZOSV()
 I $G(EXPFILE)'="",$$FEXIST^PSOSPMUT(LOCDIR,EXPFILE) S FILE2DEL(EXPFILE)=""
 S:$G(INPTFILE)'="" FILE2DEL(INPTFILE)=""
 S:$G(LOGFILE)'="" FILE2DEL(LOGFILE)=""
 I PSOOS["VMS" D
 . S:$G(FTPFILE)'="" FILE2DEL(FTPFILE)=""
 . S FILE2DEL("VMSSSHID.")=""
 . S FILE2DEL("VMSSSHKEY.")=""
 . S FILE2DEL("VMSSSHKEY.PUB")=""
 I PSOOS["UNIX" D
 . S FILE2DEL("VMSSSHKEY")=""
 . S FILE2DEL("linuxsshkey")=""
 D DEL^%ZISH(LOCDIR,"FILE2DEL")
 Q
 ;
PAUSE ; Pauses screen until user hits Return
 W ! K DIR S DIR("A")="Press Return to continue",DIR(0)="E" D ^DIR
 Q
 ;
XVMSDIR(VMSDIR) ; Converts a VMS directory
 ; Input: VMSDIR    - OpenVMS directory name (e.g., "USER$:[SPMP]")
 ;Output: $$XVMSDIR - Converted VMS directory (e.g., "/USER$/SPMP/")
 Q "/"_$TR(VMSDIR,".[]:","///")
 ;
SAVEKEYS(STATE,LOCDIR) ; Saves Key, converts SSH2 to OpenSSH when running on Linux
 ;Input: STATE  - State to retrieve the keys from
 ;       LOCDIR - Local directory where the keys should be saved to
 N WLINE,XPV
 I $$GET1^DIQ(58.41,STATE,18,"I")="SSH2" D
 . ;Saving the Private SSH Key
 . D OPEN^%ZISH("VMSSSHKEY",LOCDIR,"VMSSSHKEY","W")
 . D USE^%ZISUTL("VMSSSHKEY")
 . F WLINE=1:1 Q:'$D(^PS(58.41,STATE,"PRVKEY",WLINE))  D
 . . W $$DECRYP^XUSRB1(^PS(58.41,STATE,"PRVKEY",WLINE,0)),!
 . D CLOSE^%ZISH("VMSSSHKEY")
 ;
 I $$OS^%ZOSV()["VMS" D  Q
 . ;Saving the Public SSH Key (Assuming SSH2 format) - VMS Only
 . D OPEN^%ZISH("VMSSSHKEY",LOCDIR,"VMSSSHKEY.PUB","W")
 . D USE^%ZISUTL("VMSSSHKEY")
 . F WLINE=1:1 Q:'$D(^PS(58.41,STATE,"PUBKEY",WLINE))  D
 . . W $$DECRYP^XUSRB1(^PS(58.41,STATE,"PUBKEY",WLINE,0)),!
 . D CLOSE^%ZISH("VMSSSHKEY")
 ;
 I $$OS^%ZOSV()["UNIX" D  Q
 . ;If Key format is SSH2, convert VMSSSHKEY to OpenSSH format; Otherwise write directly from VistA
 . I $$GET1^DIQ(58.41,STATE,18,"I")="SSH2" D
 . . S XPV="S PV=$ZF(-1,""ssh-keygen -i -f "_LOCDIR_"VMSSSHKEY > "_LOCDIR_"linuxsshkey"")"
 . . X XPV
 . E  D
 . . ;Saving the Private SSH Key (OpenSSH Format)
 . . D OPEN^%ZISH("linuxsshkey",LOCDIR,"linuxsshkey","W")
 . . D USE^%ZISUTL("linuxsshkey")
 . . F WLINE=1:1 Q:'$D(^PS(58.41,STATE,"PRVKEY",WLINE))  D
 . . . W $$DECRYP^XUSRB1(^PS(58.41,STATE,"PRVKEY",WLINE,0)),!
 . . D CLOSE^%ZISH("linuxsshkey")
 . S XPV="S PV=$ZF(-1,""chmod 600 "_LOCDIR_"linuxsshkey"")"
 . X XPV
 ;
 Q
 ;
LINUXDIR() ; Returns the Linux Directory for SPMP sFTP
 N CURDIR,ROOTDIR
 I $$OS^%ZOSV()'="UNIX" Q ""
 I $$UP^XLFSTR($$VERSION^%ZOSV(1))'["CACHE" Q ""
 ; Retrieving the current directory
 X "S CURDIR=$ZU(12)" S ROOTDIR=$P(CURDIR,"/",1,4)
 I $E(ROOTDIR,$L(ROOTDIR))="/" S $E(ROOTDIR,$L(ROOTDIR))=""
 Q ROOTDIR_"/user/sftp/spmp/"
 ;
DIREXIST(DIR) ; Returns whether the Linux Directory for SPMP sFTP already exists
 ;Input: DIR - Linux Directory name to be checked
 N DIREXIST
 I DIR="" Q 0
 I $$OS^%ZOSV()'="UNIX" Q 0
 I $$UP^XLFSTR($$VERSION^%ZOSV(1))'["CACHE" Q 0
 I $E(DIR,$L(DIR))="/" S $E(DIR,$L(DIR))=""
 X "S DIREXIST=$ZSEARCH(DIR)"
 Q $S(DIREXIST="":0,1:1)
 ;
MAKEDIR(DIR) ; Create a new directory
 ;Input: DIR - Linux Directory name to be created
 N MKDIR
 I $$OS^%ZOSV()'="UNIX" Q
 I $$UP^XLFSTR($$VERSION^%ZOSV(1))'["CACHE" Q
 I $$DIREXIST(DIR) Q
 X "S MKDIR=$ZF(-1,""mkdir ""_DIR)"
 I 'MKDIR X "S MKDIR=$ZF(-1,""chmod 777 ""_DIR)"
 Q
 ;
SETLN(NSPC,TEXT,REV,UND,HIG) ; Sets a line to be displayed in the Body section
 ;Input: NSPC - Namespace of the ^TMP global
 ;       TEXT - Line of text to be added to Listman
 ;       REV  - Reverse video (1: YES / 0:NO)
 ;       UND  - Underlined (1: YES / 0: NO)
 ;       HIG  - Highlighted (1: YES / 0: NO)
 N X
 S:$G(TEXT)="" $E(TEXT,80)=""
 S:$L(TEXT)>80 TEXT=$E(TEXT,1,80)
 S LINE=LINE+1,^TMP(NSPC,$J,LINE,0)=$G(TEXT)
 ;
 I LINE>$G(PSOLSTLN) D SAVE^VALM10(LINE) S PSOLSTLN=LINE
 ;
 I $G(REV) D  Q
 . D CNTRL^VALM10(LINE,1,$L(TEXT),IORVON,IORVOFF_IOINORM)
 . I $G(UND) D CNTRL^VALM10(LINE,$L(TEXT)+1,80,IOUON,IOINORM)
 I $G(UND) D CNTRL^VALM10(LINE,1,80,IOUON,IOINORM)
 I $G(HIG) D
 . D CNTRL^VALM10(LINE,HIG,80,IOINHI_$S($G(UND):IOUON,1:""),IOINORM)
 Q
