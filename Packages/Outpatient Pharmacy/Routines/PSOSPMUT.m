PSOSPMUT ;BIRM/MFR - State Prescription Monitoring Program Utilities ;10/07/12
 ;;7.0;OUTPATIENT PHARMACY;**408**;DEC 1997;Build 100
 ;
LOADASAP(VERSION,ASAP) ; Loads the ASAP definition array for the specific Version
 ; Input: (r) VERSION - ASAP Version (4.0, 4.1, 4.2)
 ;Output: ASAP - Array containing the ASAP Hierarchical Segment Structure/ASAP Elements Definition
 ; 
 N FILEIEN,VER,VERIEN,SEGIEN,SEG0,PARSEG,SEGPOS,SEGIDX,ELMIEN,ELM0,ELMPOS,ARXREF,STAIEN,STA0,ARREF,I
 S FILEIEN=$O(^PS(58.4,999),-1)
 K ASAP I $G(VERSION)="" S VERSION="4.2"
 F VER="ALL",VERSION D
 . S VERIEN=$O(^PS(58.4,FILEIEN,"VER","B",VER,0)) I 'VERIEN Q
 . S SEGIEN=0
 . F  S SEGIEN=$O(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN)) Q:'SEGIEN  D
 . . S SEG0=$G(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN,0))
 . . S PARSEG=$P(SEG0,"^",3),SEGPOS=+$P(SEG0,"^",5)
 . . ; - Retrieving Segment Definition
 . . I PARSEG="" D
 . . . S ASAP(SEGPOS)=$P(SEG0,"^"),ASAP($P(SEG0,"^"))=SEG0,ARXREF($P(SEG0,"^",1))="ASAP("_SEGPOS_")"
 . . I PARSEG'="" D
 . . . S ARREF=ARXREF(PARSEG),ASAP($P(SEG0,"^"))=SEG0
 . . . S SEGIDX=SEGPOS I $D(@ARREF@(SEGPOS)),$G(@ARREF@(SEGPOS))'=$P(SEG0,"^") S SEGIDX=$O(@ARREF@(""),-1)+1
 . . . S @ARREF@(SEGIDX)=$P(SEG0,"^")
 . . . S ARXREF($P(SEG0,"^",1))=$E(ARREF,1,$L(ARREF)-1)_","_SEGIDX_")"
 . . ; - Segment Not used by this Version
 . . I $P(SEG0,"^",4)="N" D  Q
 . . . K @ARXREF($P(SEG0,"^",1)),ASAP($P(SEG0,"^",1))
 . . ; - Loading Data Elements
 . . S ELMIEN=0
 . . F  S ELMIEN=$O(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN,"DAT",ELMIEN)) Q:'ELMIEN  D
 . . . S ELM0=$G(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN,"DAT",ELMIEN,0))
 . . . S ELMPOS=$P(ELM0,"^",5)
 . . . ; - Element Not Used by this Version
 . . . I +ELMPOS'=1,$P(ELM0,"^",6)="N" K ASAP($P(SEG0,"^",1),ELMPOS) Q
 . . . ; - Retrieving Element Definition
 . . . S ASAP($P(SEG0,"^",1),ELMPOS)=ELM0
 . . . ; - Element Description
 . . . K ASAP($P(SEG0,"^",1),ELMPOS,"DES")
 . . . F I=1:1 Q:'$D(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN,"DAT",ELMIEN,"DES",I))  D
 . . . . S ASAP($P(SEG0,"^",1),ELMPOS,"DES",I)=$G(^PS(58.4,FILEIEN,"VER",VERIEN,"SEG",SEGIEN,"DAT",ELMIEN,"DES",I,0))
 Q
 ;
EXPORT(BATCHIEN,MODE,BCKGRND) ; Export a SPMP Batch
 ;Input: BATCHIEN - Pointer to #58.41
 ;       MODE     - "VIEW" or "EXPORT"
 ;       BCKGRND  - Background? (1:YES / 0:NO)
 ;
 N X,RX,PSOSTATE,PSOASVER,SCHR,TRXTYPE,PSOTTCNT,PSOTPCNT,RXSITE,RXIEN,RXFILL,DFN,VADM,RXNODE,RTSDATA
 N DATETIME,VAPA,XX,ASAP,LOCDIR,EXPFILE,EXPFILE2,FTPFILE,INPTFILE,LOGFILE,DIE,DR,DA,PSOFTPOK,FILES
 N PSODELOK,PSOOS,RTSONLY,PSOSTIP,PSOSTUSR,PSONAME,PSOPORT,PSOAUTO,PSOSTDIR,PSOFLEXT
 K ^TMP("PSOSPMEX",$J)
 ;
 I +$$SPOK($$GET1^DIQ(58.42,BATCHIEN,1,"I"))=-1 D  Q
 . D LOGERROR(BATCHIEN,0,$P($$SPOK($$GET1^DIQ(58.42,BATCHIEN,1,"I")),"^",2),$G(BCKGRND))
 ;
 F  S DATETIME=$P($$FMTHL7^XLFDT($$HTFM^XLFDT($H)),"-") L +@("PMP"_DATETIME):0 Q:$T  H 2
 ;
 S PSOSTATE=$$GET1^DIQ(58.42,BATCHIEN,1,"I")
 S PSOASVER=$$GET1^DIQ(58.41,PSOSTATE,1,"I")
 S PSOFLEXT=$$GET1^DIQ(58.41,PSOSTATE,6)
 S PSOSTIP=$$GET1^DIQ(58.41,PSOSTATE,7)
 ; The command below will add the IP Address to the list of known hosts (if not already there)
 I $$OS^%ZOSV()="UNIX",$$UP^XLFSTR($$VERSION^%ZOSV(1))["CACHE" D
 . X "S PV=$ZF(-1,""ssh -o BatchMode=yes -o StrictHostKeyChecking=no -o LogLevel=quiet "_PSOSTIP_""")"
 ;
 S PSOPORT=$$GET1^DIQ(58.41,PSOSTATE,9)
 S PSOSTUSR=$$GET1^DIQ(58.41,PSOSTATE,8)
 S PSOSTDIR=$$GET1^DIQ(58.41,PSOSTATE,10)
 S PSOAUTO=$S($$GET1^DIQ(58.41,PSOSTATE,13,"I")="A":1,1:0)
 S PSOOS=$$OS^%ZOSV()
 ;
 I MODE="EXPORT",'$G(BCKGRND) W !!,"Exporting Batch #",BATCHIEN,":",! H 1
 ;
 S RX=0
 F  S RX=$O(^PS(58.42,BATCHIEN,"RX",RX)) Q:'RX  D
 . S RXNODE=^PS(58.42,BATCHIEN,"RX",RX,0)
 . S RXIEN=+RXNODE,RXFILL=$P(RXNODE,"^",2),DFN=$$GET1^DIQ(52,RXIEN,2,"I")
 . I MODE="EXPORT",$P(RXNODE,"^",3)'="V",'$$RXRLDT^PSOBPSUT(RXIEN,RXFILL) Q
 . I MODE="EXPORT",$P(RXNODE,"^",3)="V",$$RXRLDT^PSOBPSUT(RXIEN,RXFILL) Q
 . ; Always the Pharmacy Division for the Original Fill
 . S RXSITE=$$RXSITE^PSOBPSUT(RXIEN,0)
 . S ^TMP("PSOSPMEX",$J,RXSITE,DFN,RXIEN,RXFILL)=$P(RXNODE,"^",3)
 I '$D(^TMP("PSOSPMEX",$J)) D  L -@("PMP"_DATETIME) Q
 . D LOGERROR(BATCHIEN,0,"There were no eligible prescriptions in the batch #"_BATCHIEN,$G(BCKGRND))
 ;
 I MODE="VIEW",PSOASVER'="1995" S XX="",$P(XX,"-",80)="" W !,XX,!
 I MODE="EXPORT" D  I $P(FILES,"^",1)=-1 L -@("PMP"_DATETIME) Q
 . S RTSONLY=0 I $$GET1^DIQ(58.42,BATCHIEN,2,"I")="VD" S RTSONLY=1
 . S FILES=$$PREPFILE^PSOSPMU1(PSOSTATE,DATETIME,RTSONLY)
 . I $P(FILES,"^",1)=-1 D LOGERROR(BATCHIEN,0,$P(FILES,"^",2),$G(BCKGRND)) Q
 . I PSOOS["VMS" S LOCDIR=$$GET1^DIQ(58.41,PSOSTATE,4)
 . I PSOOS["UNIX" D
 . . S LOCDIR=$$GET1^DIQ(58.41,PSOSTATE,15)
 . . I '$$DIREXIST^PSOSPMU1(LOCDIR) D MAKEDIR^PSOSPMU1(PSOUNXLD)
 . I PSOOS["NT" S LOCDIR=$$GET1^DIQ(58.41,PSOSTATE,16)
 . S EXPFILE=$P(FILES,"^",2)
 . S FTPFILE=$P(FILES,"^",3)
 . S INPTFILE=$P(FILES,"^",4)
 . S LOGFILE=$P(FILES,"^",5)
 . S EXPFILE2=$P(FILES,"^",6)
 . I '$G(BCKGRND) W !,$S('PSOAUTO:"Step 1: ",1:""),"Writing to file ",LOCDIR_EXPFILE,"..."
 . D OPEN^%ZISH("EXPFILE",LOCDIR,EXPFILE,"W")
 . I POP D LOGERROR(BATCHIEN,0,"Export File <"_LOCDIR_EXPFILE_"> could not be created.",$G(BCKGRND)) S FILES=-1 Q
 . D USE^%ZISUTL("EXPFILE")
 ;----------------------------- ASAP Data Output (1995) -------------------------------
 I PSOASVER="1995" D
 . S (RXSITE,DFN,RXIEN)=0
 . F  S RXSITE=$O(^TMP("PSOSPMEX",$J,RXSITE)) Q:'RXSITE  D
 . . F  S DFN=$O(^TMP("PSOSPMEX",$J,RXSITE,DFN)) Q:'DFN  D
 . . . K VADM,VAPA,PSONAME D DEM^VADPT,ADD^VADPT,SETNAME(DFN)
 . . . F  S RXIEN=$O(^TMP("PSOSPMEX",$J,RXSITE,DFN,RXIEN)) Q:'RXIEN  D
 . . . . S RXFILL=""
 . . . . F  S RXFILL=$O(^TMP("PSOSPMEX",$J,RXSITE,DFN,RXIEN,RXFILL)) Q:RXFILL=""  D
 . . . . . S RECTYPE=^TMP("PSOSPMEX",$J,RXSITE,DFN,RXIEN,RXFILL)
 . . . . . K RTSDATA I RECTYPE="V" D LOADRTS^PSOSPMU1(RXIEN,RXFILL,.RTSDATA)
 . . . . . W $$ASAP95^PSOASAP0(RXIEN,+RXFILL),!
 ;------------------------- ASAP Data Output (3.0 and above) --------------------------
 I PSOASVER'="1995" D
 . S SCHR="*",TRXTYPE="S",(PSOTTCNT,PSOTPCNT)=0
 . D LOADASAP(PSOASVER,.ASAP)
 . D WRITESEG("TH")
 . D WRITESEG("IS")
 . D WRITESEG("IR")
 . S (RXSITE,DFN,RXIEN)=0
 . F  S RXSITE=$O(^TMP("PSOSPMEX",$J,RXSITE)) Q:'RXSITE  D
 . . S PSOTPCNT=0
 . . D WRITESEG("PHA")
 . . F  S DFN=$O(^TMP("PSOSPMEX",$J,RXSITE,DFN)) Q:'DFN  D
 . . . K VADM,VAPA,PSONAME D DEM^VADPT,ADD^VADPT,SETNAME(DFN)
 . . . D WRITESEG("PAT")
 . . . F  S RXIEN=$O(^TMP("PSOSPMEX",$J,RXSITE,DFN,RXIEN)) Q:'RXIEN  D
 . . . . S RXFILL=""
 . . . . F  S RXFILL=$O(^TMP("PSOSPMEX",$J,RXSITE,DFN,RXIEN,RXFILL)) Q:RXFILL=""  D
 . . . . . S RECTYPE=^TMP("PSOSPMEX",$J,RXSITE,DFN,RXIEN,RXFILL)
 . . . . . K RTSDATA I RECTYPE="V" D LOADRTS^PSOSPMU1(RXIEN,RXFILL,.RTSDATA)
 . . . . . D WRITESEG("RX")
 . . . . . D WRITESEG("DSP")
 . . . . . D WRITESEG("PRE")
 . . . . . D WRITESEG("RPH")
 . . . . . D WRITESEG("PLN")
 . . D WRITESEG("TP")
 . D WRITESEG("TT")
   ; Close the file
 I MODE="EXPORT" D CLOSE^%ZISH("EXPFILE") I '$G(BCKGRND) W "Done."
 ;--------------------------------------------------------------------------------------
 I MODE="VIEW",PSOASVER'="1995" S XX="",$P(XX,"-",80)="" W !,XX
 S (PSOFTPOK,PSODELOK)=""
 I MODE="EXPORT" D
 . ; Automated Transmission (RSA keys)
 . I PSOAUTO D
 . . I '$G(BCKGRND) W !,"Transmitting file to the State (",$$GET1^DIQ(58.41,PSOSTATE,7),")...",!
 . . S PSOFTPOK=$$FTPFILE^PSOSPMU1(PSOSTIP,PSOSTUSR,LOCDIR,FTPFILE,LOGFILE,INPTFILE,PSOPORT)
 . . ;Retrieving Log File content into ^TMP("PSOFTPLG",$J) temporary global
 . . I +(PSOFTPOK)'=-1 D
 . . . K ^TMP("PSOFTPLG",$J)
 . . . S XLOG=$$FTG^%ZISH(LOCDIR,LOGFILE,$NAME(^TMP("PSOFTPLG",$J,1)),3)
 . . . N LOG,LINE,UPLINE
 . . . S (LOG,LINE)=0,PSOFTPOK=""
 . . . F  S LOG=$O(^TMP("PSOFTPLG",$J,LOG)) Q:LOG=""  D  I $P(PSOFTPOK,"^")="-1" Q
 . . . . S LINE=$G(^TMP("PSOFTPLG",$J,LOG)),UPLINE=$$UP^XLFSTR(LINE)
 . . . . I (UPLINE["LOGIN REQUEST REJECTED")!(UPLINE["FATAL:")!(UPLINE["ERROR") S PSOFTPOK=-1
 . . . . I (UPLINE["VERIFICATION FAILED")!(UPLINE["NO SUCH FILE OR DIRECTORY") S PSOFTPOK=-1
 . . . . I (UPLINE["COMMAND CANNOT BE FOUND")!(UPLINE["COMMAND NOT FOUND") S PSOFTPOK=-1
 . . . . I (UPLINE["COULDN'T READ PACKET")!(UPLINE["INVALID DIRECTORY") S PSOFTPOK=-1
 . . . . I +PSOFTPOK=-1 S $P(PSOFTPOK,"^",2)="Error transmitting the file: "_LINE
 . ; Manual Transmission (Password)
 . K DTOUT,DUOUT I 'PSOAUTO D
 . . W !!,"Step 2: Copy the "_$S(PSOSTDIR'="":"four",1:"three")_" lines of text below into the clipboard (highlight the"
 . . W !?8,"lines then right-click the  mouse and select 'Copy').",!
 . . W:$G(PSOSTDIR)'="" !,"cd "_PSOSTDIR
 . . W !,"put "_$S(PSOOS["VMS":$$XVMSDIR^PSOSPMU1(LOCDIR),1:LOCDIR)_EXPFILE
 . . W !,"rename "_EXPFILE_" "_$P(EXPFILE,".up",1)_PSOFLEXT
 . . W !,"exit",!
 . . K DIR,DTOUT,DUOUT S DIR(0)="E",DIR("A")="Then press <RETURN> to go to the next step." D ^DIR I $G(DTOUT)!$G(DUOUT) Q
 . . W !!,"Step 3: Enter the sFTP password and press <RETURN>"
 . . W !!,"Step 4: Once you get the 'sftp>' prompt, paste the text copied on step 2"
 . . W !?8,"(right-click the mouse and select 'Paste').",!!
 . . N XPV1,PV S XPV1="S PV=$ZF(-1,""sftp"_$S(PSOPORT:" -oPort="_PSOPORT,1:"")_" "_$TR(PSOSTUSR,"""","")_"@"_PSOSTIP_""")"
 . . X XPV1
 . ;Deleting files
 . S PSODELOK=$$DELFILE^PSOSPMU1(LOCDIR_EXPFILE)
 . I $G(INPTFILE)'="" D DELFILE^PSOSPMU1(LOCDIR_INPTFILE)
 . I PSOAUTO S PSODELOK=$$DELFILE^PSOSPMU1(LOCDIR_LOGFILE)
 . I PSOOS["VMS" D
 . . S PSODELOK=$$DELFILE^PSOSPMU1(LOCDIR_FTPFILE)
 . . S PSODELOK=$$DELFILE^PSOSPMU1(LOCDIR_"VMSSSHID.")
 . . S PSODELOK=$$DELFILE^PSOSPMU1(LOCDIR_"VMSSSHKEY.")
 . . S PSODELOK=$$DELFILE^PSOSPMU1(LOCDIR_"VMSSSHKEY.PUB")
 . I PSOOS["UNIX" D
 . . S PSODELOK=$$DELFILE^PSOSPMU1(LOCDIR_"VMSSSHKEY")
 . . S PSODELOK=$$DELFILE^PSOSPMU1(LOCDIR_"linuxsshkey")
 . I PSOOS["NT" D
 . . S PSODELOK=$$DELFILE^PSOSPMU1(LOCDIR_FTPFILE)
 . . S PSODELOK=$$DELFILE^PSOSPMU1(LOCDIR_"VMSSSHKEY")
 . . S PSODELOK=$$DELFILE^PSOSPMU1(LOCDIR_"VMSSSHKEY.PUB")
 . I 'PSOAUTO,$G(DTOUT)!$G(DUOUT) Q
 . I $P(PSOFTPOK,"^",1)=-1 D LOGERROR(BATCHIEN,0,$P(PSOFTPOK,"^",2),$G(BCKGRND)) Q
 . I $P(PSODELOK,"^",1)=-1 D LOGERROR(BATCHIEN,0,$P(PSODELOK,"^",2),$G(BCKGRND)) Q
 . I '$G(BCKGRND),PSOAUTO H 1 W !!,"File Successfully Transmitted.",!
 . I 'PSOAUTO D  I $G(DTOUT)!$G(DUOUT)!'Y Q
 . . K DIR S DIR("A")="Was the file transmitted successfully",DIR(0)="Y",DIR("B")="N"
 . . D ^DIR
 . S DIE="^PS(58.42,",DA=BATCHIEN,DR="6///"_EXPFILE2_";7////"_DUZ_";9///"_$$NOW^XLFDT() D ^DIE
 W ! L -@("PMP"_DATETIME)
 Q
 ;
WRITESEG(SEGID) ; Write the ASAP segment to the file
 N ASFLDNUM,LASTELEM
 I '$D(ASAP(SEGID)) Q
 I $G(MODE)="VIEW" W ?$S(SEGID="PHA":3,SEGID="PAT":7,$F("DSP RX",SEGID):11,$F("PRE RPH PLN",SEGID):15,SEGID="TP":3,1:0)
 S LASTELEM=+$O(ASAP(SEGID,""),-1)
 W SEGID
 F ASFLDNUM=1:1:LASTELEM D
 . W SCHR I '$D(ASAP(SEGID,ASFLDNUM)) Q  ; Field Not Used
 . X "W $$"_$P(ASAP(SEGID,ASFLDNUM),"^")_"^PSOASAP0()"
 I PSOASVER="3.0" W $$TH13^PSOASAP0(),!
 I PSOASVER'="3.0" W $$TH09^PSOASAP0(),!
 Q
 ;
SCREEN(RXIEN,RXFILL) ; Screens Rx's from being sent to the State
 ; Input: RXIEN - PRESCRIPTION file (#52) IEN
 ;        RXFILL - Fill Number
 ;Output: $$SCREEN  - 1:YES/0:NO^Error/Warning Message^E:Error/W:Warning
 ;
 ; Not a Controlled Substance
 I '$$CSRX(RXIEN) Q "1^"_$$GET1^DIQ(52,RXIEN,6)_" is not a Controlled Substance Drug.^E"
 ;
 ; Fills Administered in Clinic exclusion
 I $$ADMCLN(RXIEN,RXFILL) Q "1^Prescription fill was administered in clinic.^E"
 ;
 ; Released prior to Transmission Authorization Date (02/11/2013)
 I $$RXRLDT^PSOBPSUT(RXIEN,RXFILL),$$RXRLDT^PSOBPSUT(RXIEN,RXFILL)<3130211 Q "1^Prescription fill released before 02/11/2013.^E"
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
 I $$OS^%ZOSV()["NT",$P(F1NODE,"^",2)="" Q "-1^Local Windows/NT Directory missing for "_STATENAM
 I $P(FNODE,"^",4)="" Q "-1^State FTP Server IP Address missing for "_STATENAM
 I $P(FNODE,"^",5)="" Q "-1^State FTP Server username missing for "_STATENAM
 I $P(ZNODE,"^",6)="A",'$O(^PS(58.41,STATE,"PRVKEY",0)) Q "-1^Secure FTP Private Key Text missing for "_STATENAM
 I $P(ZNODE,"^",6)="A",'$O(^PS(58.41,STATE,"PUBKEY",0)) Q "-1^Secure FTP Public Key Text missing for "_STATENAM
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
LOGERROR(BATCHIEN,STATEIEN,ERROR,BCKGRND) ;
 I '$G(BCKGRND) W !!,ERROR,!,$C(7) Q
 ;
 ;Builds mail message and sends it to users of PSO SPMP NOTIFICATIONS mail group
 N XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ,PSOMSG,USR,STANAME,LINE
 ;
 S STANAME=$S($G(BATCHIEN):$$GET1^DIQ(58.42,BATCHIEN,1),1:$$GET1^DIQ(5,STATEIEN,.01))
 S XMSUB=STANAME_" Prescription Monitoring Program Transmission Failed"
 S XMDUZ="SPMP Scheduled Transmission"
 S PSOMSG(1)="There was a problem with the transmission of information about Controlled"
 S PSOMSG(2)="Substance prescriptions to the "_STANAME_" State Prescription Monitoring"
 s PSOMSG(3)="Program (SPMP)."
 S PSOMSG(4)="",LINE=5
 I $G(BATCHIEN) D
 . S PSOMSG(LINE)="Batch #: "_BATCHIEN,LINE=LINE+1
 . S PSOMSG(LINE)="Period : "_$$FMTE^XLFDT($$GET1^DIQ(58.42,BATCHIEN,4,"I")\1,"2Z")_" thru "_$$FMTE^XLFDT($$GET1^DIQ(58.42,BATCHIEN,5,"I")\1,"2Z"),LINE=LINE+1
 . S PSOMSG(LINE)="Error  : "_ERROR,LINE=LINE+1
 . S PSOMSG(LINE)="",LINE=LINE+1
 . S PSOMSG(LINE)="Please, use the option Export Batch Processing [PSO SPMP BATCH PROCESSING] to",LINE=LINE+1
 . S PSOMSG(LINE)="manually transmit this batch to the state.",LINE=LINE+1
 E  S PSOMSG(LINE)="Error  : "_ERROR,LINE=LINE+1
 S XMTEXT="PSOMSG("
 ;
 ; If there are no active members in the mailgroup sends message to PSDMGR key holders
 I $$GOTLOCAL^XMXAPIG("PSO SPMP NOTIFICATIONS") D
 . S XMY("G.PSO SPMP NOTIFICATIONS")=""
 E  D
 . S USR=0 F  S USR=$O(^XUSEC("PSDMGR",USR)) Q:'USR  S XMY(USR)=""
 ;
 D ^XMD
 Q
