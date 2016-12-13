PSOSPMUT ;BIRM/MFR - State Prescription Monitoring Program Utilities ;10/07/12
 ;;7.0;OUTPATIENT PHARMACY;**408,451**;DEC 1997;Build 114
 ;
EXPORT(BATCHIEN,MODE,BCKGRND,DEBUG) ; Export a SPMP Batch
 ;Input: BATCHIEN - Pointer to #58.41
 ;       MODE     - "VIEW" or "EXPORT"
 ;       BCKGRND  - Background? (1:YES / 0:NO)
 ;       DEBUG    - Debug Mode? (1:YES / 0:NO)
 N X,RX,STATEIEN,PSOASVER,TRXTYPE,PSOTTCNT,PSOTPCNT,SITEIEN,RXIEN,FILLNUM,FILLIEN,PATIEN,DFN,VADM
 N RTSDATA,DATETIME,VAPA,XX,ASAP,LOCDIR,EXPFILE,EXPFILE2,FTPFILE,INPTFILE,DIE,DR,DA,PSOFTPOK,FILES
 N PSODELOK,PSOOS,RTSONLY,PSOSTIP,PSOSTUSR,PSONAME,PSOPORT,PSOAUTO,PSOSTDIR,PSOFLEXT,RENAME,DRUGIEN
 N PREIEN,RPHIEN,RTSREC,RXNODE
 S BCKGRND=+$G(BCKGRND),DEBUG=+$G(DEBUG) K ^TMP("PSOSPMEX",$J)
 ;
 I +$$SPOK($$GET1^DIQ(58.42,BATCHIEN,1,"I"))=-1 D  Q
 . D LOGERROR(BATCHIEN,0,$P($$SPOK($$GET1^DIQ(58.42,BATCHIEN,1,"I")),"^",2),BCKGRND)
 ;
 ; The LOCK below prevents two concurrent transmission processes from getting the same filename
 F  S DATETIME=$P($$FMTHL7^XLFDT($$HTFM^XLFDT($H)),"-") L +@("PMP"_DATETIME):0 Q:$T  H 2
 ;
 S STATEIEN=$$GET1^DIQ(58.42,BATCHIEN,1,"I")
 S PSOASVER=$$GET1^DIQ(58.41,STATEIEN,1,"I")
 S PSOFLEXT=$$GET1^DIQ(58.41,STATEIEN,6)
 S RENAME=$$GET1^DIQ(58.41,STATEIEN,17,"I")
 S PSOSTIP=$$GET1^DIQ(58.41,STATEIEN,7)
 S PSOPORT=$$GET1^DIQ(58.41,STATEIEN,9)
 ; The commands below will first 'flush' and then add the IP Address to the known_hosts file
 I MODE="EXPORT",$$OS^%ZOSV()="UNIX",$$UP^XLFSTR($$VERSION^%ZOSV(1))["CACHE" D
 . X "S PV=$ZF(-1,""ssh -oBatchMode=yes -oStrictHostKeyChecking=no -oLogLevel=quiet"_$S(PSOPORT:" -oPort="_PSOPORT,1:"")_" "_PSOSTIP_""")"
 ;
 S PSOSTUSR=$$GET1^DIQ(58.41,STATEIEN,8)
 S PSOSTDIR=$$GET1^DIQ(58.41,STATEIEN,10)
 S PSOAUTO=$S($$GET1^DIQ(58.41,STATEIEN,13,"I")="A":1,1:0)
 S PSOOS=$$OS^%ZOSV()
 ;
 I MODE="EXPORT",'$G(BCKGRND) W !!,"Exporting Batch #",BATCHIEN,":",!
 ;
 S RX=0
 F  S RX=$O(^PS(58.42,BATCHIEN,"RX",RX)) Q:'RX  D
 . S RXNODE=^PS(58.42,BATCHIEN,"RX",RX,0)
 . S RXIEN=+RXNODE,FILLNUM=$P(RXNODE,"^",2),PATIEN=$$GET1^DIQ(52,RXIEN,2,"I")
 . I MODE="EXPORT",$P(RXNODE,"^",3)'="V",'$$RXRLDT^PSOBPSUT(RXIEN,FILLNUM) Q
 . I MODE="EXPORT",$P(RXNODE,"^",3)="V",$$RXRLDT^PSOBPSUT(RXIEN,FILLNUM) Q
 . ; Always the Pharmacy Division for the Original Fill
 . S SITEIEN=$$RXSITE^PSOBPSUT(RXIEN,0)
 . S ^TMP("PSOSPMEX",$J,SITEIEN,PATIEN,RXIEN,FILLNUM)=$P(RXNODE,"^",3)
 I '$D(^TMP("PSOSPMEX",$J)) D  L -@("PMP"_DATETIME) Q
 . D LOGERROR(BATCHIEN,0,"There were no eligible prescriptions in the batch #"_BATCHIEN,BCKGRND)
 ;
 I MODE="VIEW",PSOASVER'="1995" S XX="",$P(XX,"-",80)="" W !,XX,!
 I MODE="EXPORT" D  I $P(FILES,"^",1)=-1 L -@("PMP"_DATETIME) Q
 . S RTSONLY=0 I $$GET1^DIQ(58.42,BATCHIEN,2,"I")="VD" S RTSONLY=1
 . I PSOOS["VMS" S LOCDIR=$$GET1^DIQ(58.41,STATEIEN,4)
 . I PSOOS["UNIX" D
 . . S LOCDIR=$$GET1^DIQ(58.41,STATEIEN,15)
 . . I '$$DIREXIST^PSOSPMU1(LOCDIR) D MAKEDIR^PSOSPMU1(LOCDIR)
 . S FILES=$$PREPFILE^PSOSPMU1(STATEIEN,DATETIME,RTSONLY,DEBUG)
 . I $P(FILES,"^",1)=-1 D LOGERROR(BATCHIEN,0,$P(FILES,"^",2),BCKGRND) Q
 . S EXPFILE=$P(FILES,"^",2)
 . S FTPFILE=$P(FILES,"^",3)
 . S INPTFILE=$P(FILES,"^",4)
 . S LOGFILE=$P(FILES,"^",5)
 . S EXPFILE2=$P(FILES,"^",6)
 . I 'BCKGRND W !,$S('PSOAUTO:"Step 1: ",1:""),"Writing to file ",LOCDIR_EXPFILE,"..."
 . D OPEN^%ZISH("EXPFILE",LOCDIR,EXPFILE,"W")
 . I POP D LOGERROR(BATCHIEN,0,"Export File <"_LOCDIR_EXPFILE_"> could not be created.",BCKGRND) S FILES=-1 Q
 . D USE^%ZISUTL("EXPFILE")
 ;----------------------------- ASAP Data Output (1995) -------------------------------
 I PSOASVER="1995" D
 . S (SITEIEN,PATIEN,RXIEN)=0
 . F  S SITEIEN=$O(^TMP("PSOSPMEX",$J,SITEIEN)) Q:'SITEIEN  D
 . . F  S PATIEN=$O(^TMP("PSOSPMEX",$J,SITEIEN,PATIEN)) Q:'PATIEN  D
 . . . K VADM,VAPA,PSONAME S DFN=PATIEN D DEM^VADPT,ADD^VADPT,SETNAME(PATIEN)
 . . . F  S RXIEN=$O(^TMP("PSOSPMEX",$J,SITEIEN,PATIEN,RXIEN)) Q:'RXIEN  D
 . . . . S FILLNUM=""
 . . . . F  S FILLNUM=$O(^TMP("PSOSPMEX",$J,SITEIEN,PATIEN,RXIEN,FILLNUM)) Q:FILLNUM=""  D
 . . . . . S RECTYPE=^TMP("PSOSPMEX",$J,SITEIEN,PATIEN,RXIEN,FILLNUM)
 . . . . . K RTSDATA I RECTYPE="V" D LOADRTS^PSOSPMU1(RXIEN,FILLNUM,.RTSDATA)
 . . . . . W $$ASAP95^PSOASAP0(RXIEN,+FILLNUM),!
 ;------------------------- ASAP Data Output (3.0 and above) --------------------------
 I PSOASVER'="1995" D
 . S TRXTYPE="S",PSOTTCNT=0
 . D LOADASAP^PSOSPMU0(PSOASVER,"B",.ASAP)
 . S (SITEIEN,PATIEN,RXIEN)=0
 . ;Writing Level 1: Transaction Header, Information Source
 . D WRITELEV(1,"ASAP")
 . F  S SITEIEN=$O(^TMP("PSOSPMEX",$J,SITEIEN)) Q:'SITEIEN  D
 . . S PSOTPCNT=0
 . . ;Writing Level 2: Pharmacy Header
 . . D WRITELEV(2,"ASAP")
 . . F  S PATIEN=$O(^TMP("PSOSPMEX",$J,SITEIEN,PATIEN)) Q:'PATIEN  D
 . . . K VADM,VAPA,PSONAME S DFN=PATIEN D DEM^VADPT,ADD^VADPT,SETNAME(PATIEN)
 . . . S (DRUGIEN,FILLNUM,FILLIEN,PREIEN,RPHIEN,RTSREC)=0
 . . . ;Writing Level 3: Patient Detail
 . . . D WRITELEV(3,"ASAP")
 . . . F  S RXIEN=$O(^TMP("PSOSPMEX",$J,SITEIEN,PATIEN,RXIEN)) Q:'RXIEN  D
 . . . . S FILLNUM="",DRUGIEN=$$GET1^DIQ(52,RXIEN,6,"I")
 . . . . F  S FILLNUM=$O(^TMP("PSOSPMEX",$J,SITEIEN,PATIEN,RXIEN,FILLNUM)) Q:FILLNUM=""  D
 . . . . . S FILLIEN=$S(FILLNUM["P":+$P(FILLNUM,"P",2),1:+FILLNUM)
 . . . . . S RECTYPE=^TMP("PSOSPMEX",$J,SITEIEN,PATIEN,RXIEN,FILLNUM)
 . . . . . S PREIEN=$$PREIEN(RECTYPE,RXIEN,FILLNUM)
 . . . . . S RPHIEN=$$RPHIEN(RECTYPE,RXIEN,FILLNUM)
 . . . . . S RTSREC=0 K RTSDATA I RECTYPE="V" S RTSREC=1 D LOADRTS^PSOSPMU1(RXIEN,FILLNUM,.RTSDATA)
 . . . . . ;Writing Level 4: Prescription Detail
 . . . . . D WRITELEV(4,"ASAP")
 . . ;Writing Level 5: Pharmacy Trailer
 . . D WRITELEV(5,"ASAP")
 . ;Writing Level 6: Transaction Trailer
 . D WRITELEV(6,"ASAP")
   ; Close the file
 I MODE="EXPORT" D CLOSE^%ZISH("EXPFILE") I 'BCKGRND W "Done."
 ;------------------------- sFTP Transmission to the State -----------------------------
 I MODE="VIEW",PSOASVER'="1995" S XX="",$P(XX,"-",80)="" W !,XX
 S (PSOFTPOK,PSODELOK)=""
 I MODE="EXPORT" D
 . ; Automated Transmission (RSA keys)
 . I PSOAUTO D
 . . I 'BCKGRND W !!,"Transmitting file to the State (",$$GET1^DIQ(58.41,STATEIEN,7),")...",!
 . . S PSOFTPOK=$$FTPFILE^PSOSPMU1(PSOSTIP,PSOSTUSR,LOCDIR,FTPFILE,EXPFILE,INPTFILE,LOGFILE,PSOPORT,DEBUG)
 . ; Manual Transmission (Password)
 . K DTOUT,DUOUT
 . I 'PSOAUTO D
 . . W !!,"Step 2: Copy the "_$S(PSOSTDIR'="":"four",1:"three")_" lines of text below into the clipboard (highlight the"
 . . W !?8,"lines then right-click the  mouse and select 'Copy').",!
 . . W:$G(PSOSTDIR)'="" !,"cd "_PSOSTDIR
 . . W !,"put "_$S(PSOOS["VMS":$$XVMSDIR^PSOSPMU1(LOCDIR),1:LOCDIR)_EXPFILE
 . . W:$G(RENAME) !,"rename "_EXPFILE_" "_$P(EXPFILE,".up",1)_PSOFLEXT
 . . W !,"exit",!
 . . K DIR,DTOUT,DUOUT S DIR(0)="E",DIR("A")="Then press <RETURN> to go to the next step." D ^DIR I $G(DTOUT)!$G(DUOUT) Q
 . . W !!,"Step 3: Enter the sFTP password and press <RETURN>"
 . . W !!,"Step 4: Once you get the 'sftp>' prompt, paste the text copied on step 2"
 . . W !?8,"(right-click the mouse and select 'Paste').",!!
 . . N XPV1,PV S XPV1="S PV=$ZF(-1,""sftp"_$S(PSOPORT:" -oPort="_PSOPORT,1:"")_" -oUser="_$TR(PSOSTUSR,"""","")_" "_PSOSTIP_""")"
 . . X XPV1
 . I $P(PSOFTPOK,"^",1)=-1 D LOGERROR(BATCHIEN,0,$P(PSOFTPOK,"^",2),BCKGRND,$G(LOGFILE))
 . ;Deleting files
 . D DELFILES^PSOSPMU1($G(LOCDIR),$G(EXPFILE),$G(INPTFILE),$G(FTPFILE),$G(LOGFILE))
 . I $P(PSOFTPOK,"^",1)=-1 Q
 . I 'PSOAUTO,$G(DTOUT)!$G(DUOUT) Q
 . I 'BCKGRND,PSOAUTO H 1 W !!,"File Successfully Transmitted.",!
 . I 'PSOAUTO D  I $G(DTOUT)!$G(DUOUT)!'Y Q
 . . K DIR S DIR("A")="Was the file transmitted successfully",DIR(0)="Y",DIR("B")="N"
 . . D ^DIR
 . S DIE="^PS(58.42,",DA=BATCHIEN,DR="6///"_EXPFILE2_";7////"_DUZ_";9///"_$$NOW^XLFDT() D ^DIE
 W ! L -@("PMP"_DATETIME)
 Q
 ;
WRITELEV(LEVEL,ARRAY) ; Write the ASAP Segments for each Level
 ;Input: LEVEL - ASAP level to print (1:Header, 2:Pharmacy, ...)
 ;       ARRAY - Name of the Array containing the ASAP Data Definition (e.g., "ASAP")
 N NODE,SEGID,SEG0
 S NODE=ARRAY
 F  S NODE=$Q(@NODE)  Q:NODE=""!($E(NODE,$F(NODE,"("))'?1N)  D
 . S SEGID=@NODE I SEGID="" Q
 . S SEG0=$G(@(ARRAY_"("""_SEGID_""")"))
 . ; Segment not in the Level
 . I $P(SEG0,"^",6)'=LEVEL Q
 . ; Segment Marked NOT USED
 . I $P(SEG0,"^",4)="N" Q
 . D WRITESEG(SEGID,LEVEL,ARRAY)
 Q
 ;
WRITESEG(SEGID,LEVEL,ARRAY) ; Write the ASAP segment to the file
 ;Input: SEGID - ASAP Segment ID (e.g., "TH", "PAT", "DSP", ...)
 ;       LEVEL - ASAP level to print (1:Header, 2:Pharmacy, ...)
 ;       ARRAY - Name of the Array containing the ASAP Data Definition (e.g., "ASAP")
 N ELMPOS,LASTELEM
 I '$D(@ARRAY@(SEGID)) Q
 I $G(MODE)="VIEW",$P(@ARRAY,"^",4)'="" W ?$S(LEVEL<5:((LEVEL-1)*3),LEVEL=5:3,1:0)
 S LASTELEM=+$O(@ARRAY@(SEGID,""),-1)
 W SEGID D SEGCOUNT(LEVEL)
 F ELMPOS=1:1:LASTELEM D
 . ;Skipping Last Element if marked NOT USED (to solve issue with TH09 for 4.0 and TH13 for 3.0)
 . I ELMPOS=LASTELEM,$P(@ARRAY@(SEGID,ELMPOS),"^",6)="N" Q
 . ;Data Element Delimiter Char
 . W $P(@ARRAY,"^",2)
 . ; ASAP Data Element Marked NOT USED
 . I $P(@ARRAY@(SEGID,ELMPOS),"^",6)="N" Q
 . ; Writing Data Element Content to the file
 . D WRITEELM(SEGID,ELMPOS,ARRAY)
 ; Segment Terminator Character
 W $P(@ARRAY,"^",3)
 ; End of Segment Control Char(s) (e.g., Line-Feed ($C(10)), Carriage-Return ($C(13)),etc.)
 W:$P(@ARRAY,"^",4)'="" @($P(@ARRAY,"^",4))
 Q
 ;
WRITEELM(SEGID,ELMPOS,ARRAY) ; Write the ASAP Data Element to file
 ;Input: SEGID  - ASAP Segment ID (e.g., "TH", "PAT", "DSP", ...)
 ;       ELMPOS - ASAP Data Element Position (1, 2, 3, ...)
 ;       ARRAY  - Name of the Array containing the ASAP Data Definition (e.g., "ASAP")
 N MEXPR,GETVALUE,VALUE,MAXLEN
 S MEXPR=$G(@ARRAY@(SEGID,ELMPOS,"VAL",1))
 ; Rechecking the M Expression value for Security purposes
 I '$$VALID^PSOSPMU3($P(@ARRAY,"^"),MEXPR) W "?" Q
 ; Retrieving and executing the M code for retrieving the ASAP Data Element value
 D
 . N $ETRAP,$ESTACK S $ETRAP="D ERROR^PSOSPMUT"
 . S GETVALUE="S VALUE="_MEXPR X GETVALUE
 ; Removing Control Characters from the Data Element Value
 S VALUE=$$ESC(VALUE)
 ; Triming Value according to the Data Element Maximum Length
 S MAXLEN=$P($G(@ARRAY@(SEGID,ELMPOS)),"^",4) S:MAXLEN>0 VALUE=$E(VALUE,1,MAXLEN)
 ; Replacing characters that match Segment Delimiter chars with "?"
 I MAXLEN>1,VALUE'=$P(@ARRAY,"^",3) S VALUE=$TR(VALUE,$P(@ARRAY,"^",3),"?")
 ; Replacing characters that match Data Element Delimiter chars with "?"
 I MAXLEN>1,VALUE'=$P(@ARRAY,"^",2) S VALUE=$TR(VALUE,$P(@ARRAY,"^",2),"?")
 ; Writing the Data Element Value
 W VALUE
 Q
 ;
SEGCOUNT(LEVEL) ; Keeps track of Segment Count for TP and TT info
 ;Input: LEVEL - Level of the Segment where the Data Element is located
 ; TT Segment Count
 S PSOTTCNT=$G(PSOTTCNT)+1
 ; TP Segment Count
 I LEVEL'=1,LEVEL'=6 S PSOTPCNT=$G(PSOTPCNT)+1
 Q
 ;
ERROR ; Error Trap Handling to catch errors on user-entered M SET expressions
 N ERROR
 D CLOSE^%ZISH("EXPFILE")
 S ERROR="ASAP Data Element: "_$G(SEGID)_$E(100+$G(ELMPOS),2,3)_"  M Expression: "_$G(MEXPR)_"  Error: "_$$EC^%ZOSV
 D LOGERROR($G(BATCHIEN),0,ERROR,$G(BCKGRND))
 D DELFILES^PSOSPMU1($G(LOCDIR),$G(EXPFILE),$G(INPTFILE),$G(FTPFILE))
 Q
 ;
SCREEN(RXIEN,FILLNUM) ; Screens Rx's from being sent to the State
 ; Input: RXIEN   - PRESCRIPTION file (#52) IEN
 ;        FILLNUM - Fill Number
 ;Output: $$SCREEN  - 1:YES/0:NO^Error/Warning Message^E:Error/W:Warning
 ;
 ; Not a Controlled Substance
 I '$$CSRX(RXIEN) Q "1^"_$$GET1^DIQ(52,RXIEN,6)_" is not a Controlled Substance Drug.^E"
 ;
 ; Fills Administered in Clinic exclusion
 I $$ADMCLN(RXIEN,FILLNUM) Q "1^Prescription fill was administered in clinic.^E"
 ;
 ; Released prior to Transmission Authorization Date (02/11/2013)
 I $$RXRLDT^PSOBPSUT(RXIEN,FILLNUM),$$RXRLDT^PSOBPSUT(RXIEN,FILLNUM)<3130211 Q "1^Prescription fill released before 02/11/2013.^E"
 ;
 ; Non-Veteran Patient Exclusion (Based on parameter)
 N STATE,DFN,VAEL
 S STATE=$$RXSTATE^PSOBPSUT(RXIEN,0)
 I '$$GET1^DIQ(58.41,STATE,2,"I") D  I '$G(VAEL(4)) Q "1^Patient "_$$GET1^DIQ(52,RXIEN,2)_" is not a Veteran.^E"
 . S DFN=$$GET1^DIQ(52,RXIEN,2,"I") D ELIG^VADPT
 ;
 Q 0
 ;
CSRX(RXIEN) ; Controlled Substance Rx?
 ; Input: RXIEN - PRESCRIPTION file (#52) pointer
 ;Output: $$CS  - 1:YES / 0:NO
 N DRGIEN,DEA
 S DRGIEN=$$GET1^DIQ(52,RXIEN,6,"I") I 'DRGIEN Q 0
 S DEA=$$GET1^DIQ(50,DRGIEN,3)
 I (DEA'["0"),(DEA'["M"),(DEA["2")!(DEA["3")!(DEA["4")!(DEA["5") Q 1
 Q 0
 ;
ADMCLN(RXIEN,FILL) ; Returns whether the fill was administered in clinic or not
 ; Input:  (r) RXIEN - Rx IEN (#52) 
 ;         (o) FILL  - Refill # 
 ; Output: 1 - Yes (Administered in Clinic) / 0 - No
 N ADMCLN
 I '$G(RXIEN) Q 0
 I 'FILL S ADMCLN=+$$GET1^DIQ(52,RXIEN,14,"I")
 I FILL S ADMCLN=+$$GET1^DIQ(52.1,FILL_","_RXIEN,23,"I")
 Q ADMCLN
 ;
SPOK(STATE) ; State Parameters OK?
 ; Input: STATE - STATE file (#5) pointer
 N ZNODE,FNODE,F1NODE,X,STATENAM
 S STATENAM=$$GET1^DIQ(5,+$G(STATE),.01)
 I '$D(^PS(58.41,+$G(STATE),0)) Q "-1^PMP parameters missing for "_STATENAM
 S ZNODE=$G(^PS(58.41,STATE,0))
 I $P(ZNODE,"^",2)="" Q "-1^ASAP Version missing for "_STATENAM
 I $P(ZNODE,"^",4)="" Q "-1^Reporting Frequency missing for "_STATENAM
 S FNODE=$G(^PS(58.41,STATE,"FILE"))
 S F1NODE=$G(^PS(58.41,STATE,"FILE1"))
 I $$OS^%ZOSV()["VMS",$P(FNODE,"^",1)="" Q "-1^Local VMS Directory missing for "_STATENAM
 I $$OS^%ZOSV()["UNIX",$P(F1NODE,"^",1)="" Q "-1^Local Unix/Linux Directory missing for "_STATENAM
 I $P(FNODE,"^",4)="" Q "-1^State FTP Server IP Address missing for "_STATENAM
 I $P(FNODE,"^",5)="" Q "-1^State FTP Server username missing for "_STATENAM
 I $P(ZNODE,"^",6)="A",'$O(^PS(58.41,STATE,"PRVKEY",0)) Q "-1^SSH Keys missing for "_STATENAM
 Q 1
 ;
SETNAME(DFN) ; Set array variable PSONAME with Patient name
 N NCIEN K PSONAME
 S NCIEN=$$GET1^DIQ(2,DFN,1.01,"I")
 I NCIEN,$$GET1^DIQ(20,NCIEN,1)'="",$$GET1^DIQ(20,NCIEN,2)'="" D  Q
 . S PSONAME("LAST")=$$GET1^DIQ(20,NCIEN,1)
 . S PSONAME("FIRST")=$$GET1^DIQ(20,NCIEN,2)
 . S PSONAME("MIDDLE")=$$GET1^DIQ(20,NCIEN,3)
 . S PSONAME("SUFFIX")=$$GET1^DIQ(20,NCIEN,4)
 . S PSONAME("PREFIX")=$$GET1^DIQ(20,NCIEN,5)
 ;
 S PSONAME("LAST")=$P($G(VADM(1)),",",1)
 S PSONAME("FIRST")=$P($P($G(VADM(1)),",",2)," ",1)
 S PSONAME("MIDDLE")=$P($P($G(VADM(1)),",",2)," ",2)
 S PSONAME("SUFFIX")=""
 S PSONAME("PREFIX")=""
 Q
 ;
LOGERROR(BATCHIEN,STATEIEN,ERROR,BCKGRND,LOGFILE) ; Log/Display an error in the transmission
 ;Input: (r) BATCHIEN - Pointer to the SPMP EXPORT BATCH file (#58.42)
 ;       (r) STATEIEN - Pointer ot the STATE file (#5)
 ;       (r) ERROR    - Error Text
 ;       (r) BCKGRND  - Background execution (1: Yes / 0: No)
 ;       (o) LOGFILE  - Filename of the file containing the sFTP Log (VMS only)
 I '$G(BCKGRND) W !!,ERROR,!,$C(7) Q
 ;
 ;Builds mail message and sends it to users of PSO SPMP NOTIFICATIONS mail group
 N XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ,PSOMSG,USR,STANAME,LINE
 ;
 S STANAME=$S($G(BATCHIEN):$$GET1^DIQ(58.42,BATCHIEN,1),1:$$GET1^DIQ(5,STATEIEN,.01))
 S XMSUB=STANAME_" Prescription Monitoring Program Transmission Failed"
 S XMDUZ="SPMP TRANSMISSION"
 S PSOMSG(1)="There was a problem with the transmission of information about Controlled"
 S PSOMSG(2)="Substance prescriptions to the "_STANAME_" State Prescription Monitoring"
 s PSOMSG(3)="Program (SPMP)."
 S PSOMSG(4)="",LINE=5
 I $G(BATCHIEN) D
 . S PSOMSG(LINE)="Batch #: "_BATCHIEN,LINE=LINE+1
 . I $$GET1^DIQ(58.42,BATCHIEN,4,"I") D
 . . S PSOMSG(LINE)="Period : "_$$FMTE^XLFDT($$GET1^DIQ(58.42,BATCHIEN,4,"I")\1,"2Z")
 . . S PSOMSG(LINE)=PSOMSG(LINE)_" thru "_$$FMTE^XLFDT($$GET1^DIQ(58.42,BATCHIEN,5,"I")\1,"2Z"),LINE=LINE+1
 . S PSOMSG(LINE)="Error  : "_ERROR,LINE=LINE+1
 . S PSOMSG(LINE)="",LINE=LINE+1
 . S PSOMSG(LINE)="Please, use the option Export Batch Processing [PSO SPMP BATCH PROCESSING] to",LINE=LINE+1
 . S PSOMSG(LINE)="manually transmit this batch to the state.",LINE=LINE+1
 E  S PSOMSG(LINE)="Error  : "_ERROR,LINE=LINE+1
 S XMTEXT="PSOMSG("
 ;
 ; Loading the VMS Log into the Mailman Message
 I $G(LOGFILE)'="" D
 . N LOCDIR,FILEARR,LOG,XLOG
 . S LOCDIR=$$GET1^DIQ(58.41,+$$GET1^DIQ(58.42,BATCHIEN,1,"I"),$S($$OS^%ZOSV()["VMS":4,1:15)) I LOCDIR="" Q
 . I '$$FEXIST(LOCDIR,LOGFILE) Q
 . S PSOMSG(LINE)="",LINE=LINE+1
 . S PSOMSG(LINE)="sFTP Log:",LINE=LINE+1
 . S PSOMSG(LINE)="========",LINE=LINE+1
 . K ^TMP("PSOFTPLG",$J)
 . S XLOG=$$FTG^%ZISH(LOCDIR,LOGFILE,$NAME(^TMP("PSOFTPLG",$J,1)),3)
 . S LOG=0 F  S LOG=$O(^TMP("PSOFTPLG",$J,LOG)) Q:LOG=""  D
 . . S PSOMSG(LINE)=$G(^TMP("PSOFTPLG",$J,LOG)),LINE=LINE+1
 ;
 ; If there are no active members in the mailgroup sends message to PSDMGR key holders
 I $$GOTLOCAL^XMXAPIG("PSO SPMP NOTIFICATIONS") D
 . S XMY("G.PSO SPMP NOTIFICATIONS")=""
 E  D
 . S USR=0 F  S USR=$O(^XUSEC("PSDMGR",USR)) Q:'USR  S XMY(USR)=""
 D ^XMD
 Q
 ;
PREIEN(RECTYPE,RXIEN,FILLNUM) ; Returns the Provider IEN
 ;Input: RECTYPE  - Record Type ('S': SEND, 'R': REVIEW, 'V': VOID)
 ;       RXIEN   - PRESCRIPTION file (#52) IEN
 ;       FILLNUM - Fill Number
 Q +$S(RECTYPE="V"&($G(RTSDATA("PRVIEN"))):RTSDATA("PRVIEN"),1:$$RXPRV^PSOBPSUT(RXIEN,FILLNUM))
 ;
RPHIEN(RECTYPE,RXIEN,FILLNUM) ; Returns the Pharmacist IEN
 ;Input: RECTYPE  - Record Type ('S': SEND, 'R': REVIEW, 'V': VOID)
 ;       RXIEN   - PRESCRIPTION file (#52) IEN
 ;       FILLNUM - Fill Number
 Q +$S(RECTYPE="V"&($G(RTSDATA("RPHIEN"))):RTSDATA("RPHIEN"),1:$$RXRPH^PSOBPSUT(RXIEN,FILLNUM))
 ;
FEXIST(DIR,FILE) ; Check if a File exists
 ; Input:  DIR  - Name of the directory where the file is located
 ;         FILE - Name of the file to be checked
 ;Output: $$FEXIST - 1 - File Exists / 0 - File Not Found
 N RETURN,FILEARR
 S FILEARR(FILE)=""
 Q +$$LIST^%ZISH(DIR,"FILEARR","RETURN")
 ;
ESC(VALUE) ; Removes Control Characters from the Data Element Value
 N ESCVALUE,I
 S ESCVALUE=""
 F I=1:1:$L(VALUE) I $A(VALUE,I)>31,$A(VALUE,I)<127 S ESCVALUE=ESCVALUE_$E(VALUE,I)
 Q ESCVALUE
