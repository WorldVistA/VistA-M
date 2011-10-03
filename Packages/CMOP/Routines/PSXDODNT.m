PSXDODNT ;CMC/WPB Utility to watch DoD directories ;04/01/02 16:52:42
 ;;2.0;CMOP;**38,45**;11 Apr 97
 ;this routine will watch the incoming directories for files from DoD
 ;facilities and direct processing to the appropriate routine.
 ;
 ;create an option to call the routine, then schedule the option to run
 ;every 15 minutes using the TaskMan scheduler
 ;
 ;files extensions:
 ;  .trn - transmission of dispense request from Outside Agency to VistA
 ;  .ack - acknowledgement of dispense requests from VistA to Outside Agency
 ;  .qry - prescription fulfillment data from VistA to Outside Agency
 ;  .qac - acknowledgement of receipt of fulfillment data from Outside Agency to VistA 
 ;  .sit - activation/deactivation from Outside Agency to VistA
 ;  .sac - acknowledgement of activation/deactivation message from VistA to Outside Agency
 ;  .sch - auto transmission schedule/unscheduled message from Outside Agency to VistA
 ;  .hac - acknowledgement of auto transmission schedule/unscheduled message from VistA to Outside Agency
 ;
 ;the path must be setup before this routine can run:
 ;    path = \\SERVERNAME\CMOP\INBOX
 ;for testing the servername = vhacmcdhc3
 ;
 ;          VARIABLES
 ;   FILELIST        the type of files to look for. this is set to all files in the directory
 ;   FILE            stores the list of files
 ;   PATH            the path to the directory where the files are stored
 ;
EN ;reads the directory for files
 K FILELIST,FILE,PSXERCNT
 ; test if previous job still running
 S PREVJOB=$O(^XTMP("PSXDODNT")),PSXJOB="PSXDODNT-"_$J
 I PREVJOB'="",PREVJOB["PSXDODNT-",PREVJOB'=PSXJOB D  I PSXQUIT W !,"STOPPING" Q
 . S PSXQUIT=1
 . D NOW^%DTC S X1=%,X2=^XTMP(PREVJOB,1) S DIF=$$FMDIFF^XLFDT(X1,X2,2)
 . I DIF<1200 Q  ; if less than 20 minutes quit
 . ;if > 20 minutes, store off previous trail and start new
 . D NOW^%DTC
 . M ^XTMP("PSXDODERR",%,PREVJOB)=^XTMP(PREVJOB) K ^XTMP(PREVJOB)
 . S X=$$FMADD^XLFDT(DT,3) S ^XTMP("PSXDODERR",0)=X_U_DT_U_"DOD CMOP PROCESS ERROR CAPTURE"
 . K ^XTMP(PREVJOB) S PSXQUIT=0
 . D NOW^%DTC S XX=$$FMTE^XLFDT(%)
 . S XMSUB="DOD CMOP INTERFACE STOPPED IRREGULARLY "_XX,XMTEXT="TXT("
 . K TXT
 . S TXT(1,0)="The DOD CMOP Interface has been idle more than 20 minutes "_XX
 . S TXT(2,0)="The XTMP audit trail has been stored in ^XTMP(""PSXDODERR"","_%
 . S TXT(3,0)="If this message is appearing frequently contact your CMOP IRM support"
 . D ^XMD
 ; proceeding to process files
 D RESEND
 S X1=DT,X2=1 D C^%DTC S PSXDT=X
 D NOW^%DTC
 K ^XTMP(PSXJOB)
 S ^XTMP(PSXJOB,0)=PSXDT_U_%_U_"DOD PSXDODNT LOGGER"
 S ^XTMP(PSXJOB,1)=%
 ;S FILELIST("*.*")=""
 F EXT="*.trn","*.sit","*.sch","*.qac" S FILELIST(EXT)="" ;****testing
 ; SET PATH=INBOX DIRECTORY PATH
 S PATH=$$GET1^DIQ(554,1,20),FILE=""
 S Y=$$LIST^%ZISH(PATH,"FILELIST","FILE")
 I Y'=1 D  Q  ;if Y doesn't equal 1 there weren't any files to get, the routine will stop until called by TaskMan
 . D KVAR
 . K ^XTMP(PSXJOB) ;****TESTING
 ;
DIRECT ;reads the FILE variable to see what types files are available for processing and then sends process to the appropriate routine
 I $E(IOST)="C" W !,"Processing Files:" S FILENM="" F  S FILENM=$O(FILE(FILENM)) Q:FILENM=""  W !,?5,FILENM
 S FILENM=""
 ; re-entry for next file if error encountered
 ;W !,"nxtfile3"
 ;F  W !,"Nxtfile3a ",FILENM S FILENM=$O(FILE(FILENM)) W !,"nxtfile3b ",FILENM Q:FILENM=""  D
 F  S FILENM=$O(FILE(FILENM)) Q:FILENM=""  D
 . I '$G(^XTMP("PSXNTSTOP-1",0)) N $ETRAP,$ESTACK S $ETRAP="D ZTER^PSXDODNT"
 . S EXT=$$UP^XLFSTR($P(FILENM,".",2))
 . ; the following line to be used with Vitria BusinessWare
 . S ROU=$S(EXT["SIT":"ACT^PSXDODAC(PATH,FILENM)",EXT["SCH":"EN^PSXDODAT(PATH,FILENM)",EXT["TRN":"EN^PSXDODB(PATH,FILENM)",EXT["QAC":"EN^PSXDODAK(PATH,FILENM)",1:"")
 . ;the following line to be used when Vitrai BusinessWare is not being used
 . ;S ROU=$S(EXT["SIT":"ACT^PSXDODAC(PATH,FILENM)",EXT["SCH":"EN^PSXDODAT(PATH,FILENM)",EXT["TRN":"EN^PSXDODH(PATH,FILENM)",EXT["QAC":"EN^PSXDODAK(PATH,FILENM)",1:"")
 . H 2 D NOW^%DTC S ^XTMP(PSXJOB,%)=FILENM,^XTMP(PSXJOB,1)=%,JOBBEG=% ;I $E(IOST)="C" W !,JOBBEG,?20,^XTMP(PSXJOB,JOBBEG)
 . D ROU
 . D FINISH
 . H 2 D NOW^%DTC S $P(^XTMP(PSXJOB,JOBBEG),U,3)=%,^XTMP(PSXJOB,1)=% ;I $E(IOST)="C" W !,%,?20,^XTMP(PSXJOB,JOBBEG)
 K I,INC,Y,ROU
 D KVAR
 G EN ;loop to see if any other files came in to pickup
 ;
FINISH ;
 I $E(IOST)="C" W !,"nxtfile4 Finish of ",FILENM
 K ^TMP($J,"PSXDODNT")
PULL S PATH=$$GET1^DIQ(554,1,20) S Y=$$FTG^%ZISH(PATH,FILENM,$NA(^TMP($J,"PSXDODNT",1)),3)
ARCHIVE ;
 S FILENMAR=FILENM
 I FILENM[".TRN" S FILENMAR=FILENM_".BW"
 S PATH=$$GET1^DIQ(554,1,22) F XX=1:1:5 S Y=$$GTF^%ZISH($NA(^TMP($J,"PSXDODNT",1)),3,PATH,FILENMAR) Q:Y=1  H 4
 I Y'=1 S GBL=$NA(^TMP($J,"PSXDODNT")) D FALERT(FILENMAR,PATH,GBL)
REMOVE I $L($G(FILENM)) K PSXL S PSXL(FILENM)="",PATH=$$GET1^DIQ(554,1,20),Y=$$DEL^%ZISH(PATH,"PSXL")
 Q
KVAR ;K FILELIST,FILE,Y,PATH,BADFILE
 Q
ROU ; nest the new command so variables will be protected
 N FILE,JOBBEG,JOBEND,PSXJOB
 I $E(IOST)="C" W !,FILENM," ",ROU
 D @ROU
 Q
ZTER ;Friendly RE-cycle error and move to next file
 S XXERR=$$EC^%ZOSV
 S XMSUB="DOD CMOP Error on  File "_FILENM
 S BADFILE=FILENM
 S XMTEXT="TEXT("
 S TEXT(1,0)="DOD CMOP encountered the following error. Please investigate"
 S TEXT(2,0)="File:  "_FILENM
 S TEXT(3,0)="Error: "_XXERR
 S TEXT(4,0)="The file has been moved into the Hold directory "_$$GET1^DIQ(554,1,23)
 D GRP1^PSXNOTE
 D ^%ZTER ;log error into Kernel K8SYS pg 183
 D ^XMD
 I $E(IOST)="C" W !,"zter2:Error Finish & Removal of ",FILENM
 K ^TMP($J,"PSXDODNT"),TEXT
PULL2 S PATH=$$GET1^DIQ(554,1,20),Y=$$FTG^%ZISH(PATH,FILENM,$NA(^TMP($J,"PSXDODNT",1)),3)
HOLD S PATH=$$GET1^DIQ(554,1,23) F XX=1:1:5 S Y=$$GTF^%ZISH($NA(^TMP($J,"PSXDODNT",1)),3,PATH,FILENM) Q:Y=1  H 4
 I Y'=1 S GBL=$NA(^TMP($J,"PSXDODNT")) D FALERT(FILENM,PATH,GBL)
ARCHIVE2 S PATH=$$GET1^DIQ(554,1,22) F XX=1:1:5 S Y=$$GTF^%ZISH($NA(^TMP($J,"PSXDODNT",1)),3,PATH,FILENM) Q:Y=1  H 4
 I Y'=1 S GBL=$NA(^TMP($J,"PSXDODNT")) D FALERT(FILENM,PATH,GBL)
REMOVE2 K PSXL S PSXL(FILENM)="",PATH=$$GET1^DIQ(554,1,20),Y=$$DEL^%ZISH(PATH,"PSXL")
 D NOW^%DTC S Y=% X ^DD("DD")
 S XQAMSG="PLEASE INVESTIGATE - CMOP/DOD error "_XXERR_" "_Y,XQAID="PSXDODNT"
 D GRP1^PSXNOTE M XQA=XMY D SETUP^XQALERT
 H 10
 G UNWIND^%ZTER ; return to code 1 level above where $ETRAP set ie the F Loop
 Q
FALERT(FILE,PATH,GBL) ;fail to pass file into target directory, send alert, store for later
 D NOW^%DTC S Y=% X ^DD("DD")
 S XQAMSG="DOD: "_FILE_" failed placement into: "_PATH_" "_Y,XQAID="PSXDODNT"
 D GRP1^PSXNOTE M XQA=XMY ;****TESTING
 ;S XQA(DUZ)="" ;****TESTING
 D SETUP^XQALERT
STORE ; store file intO XTMP if GBL PROVIDED
 Q:$G(GBL)=""
 D NOW^%DTC S NMSPACE="PSXFILE"_"-"_%
 S DTPRG=$$FMADD^XLFDT(DT,7) ; save for 7 days
 K ^XTMP(NMSPACE)
 S ^XTMP(NMSPACE,0)=DTPRG_U_DT_U_"DOD FILE TO SEND"
 S ^XTMP(NMSPACE,1)=FILE,^XTMP(NMSPACE,2)=PATH
 M ^XTMP(NMSPACE,"T")=@GBL ; GBL IN FORM OF S GBL=$NA(^TMP($J,"PSXDODNT"))
 Q
RESEND ; SCAN XTMP and if entries put the files into the boxes
 S NMSPACE="PSXFILE"
 F  S NMSPACE=$O(^XTMP(NMSPACE)) Q:$E(NMSPACE,1,7)'="PSXFILE"  D
 .S FILE=^XTMP(NMSPACE,1),PATH=^XTMP(NMSPACE,2)
 .;W !,FILE,"  ",PATH
 .S Y=$$GTF^%ZISH($NA(^XTMP(NMSPACE,"T",1)),3,PATH,FILE)
 .I Y'=1 D FALERT("Resending DOD files ",PATH) S NMSPACE="XX" Q
 .K ^XTMP(NMSPACE)
 .D NOW^%DTC S Y=% X ^DD("DD")
 .S XQAMSG="DOD: "_FILE_" DID PLACE into: "_PATH_" "_Y,XQAID="PSXDODNT"
 .;W !,XQAMSG
 .D GRP1^PSXNOTE M XQA=XMY ;****TESTING
 .;S XQA(DUZ)="" ;****TESTING
 .D SETUP^XQALERT
 .Q
CLEAR ; CLEAR PREVIOUS NODES history nodes
 S X="PSXDODNT" F  S X=$O(^XTMP(X)) Q:X'["PSXDODNT"  W !,X K ^XTMP(X)
 Q
KILLERR ; kill the error LOG ^XTMP("PSXDODERR", )
 K ^XTMP("PSXDODERR")
 Q
START ;enable/start auto error trapping
 K ^XTMP("PSXNTSTOP-1")
 Q
STOP ;disable auto error trapping
 S ^XTMP("PSXNTSTOP-1",0)=DT_U_DT_U_"disable PSXDODNT auto error trapping"
 Q
EDIT ; edit the PSX DODNT option K8 SYS pg 342
 D EDIT^XUTMOPT("PSX DOD CMOP INTERFACE")
 Q
DISP ; display schedule
 D DISP^XUTMOPT("PSX DOD CMOP INTERFACE")
 Q
CLEARALL ; clear boxes out, archive, hold of all files
 F XX=21,22,23 D CLEARFLS^PSXDODH(XX,"*.*")
 Q
