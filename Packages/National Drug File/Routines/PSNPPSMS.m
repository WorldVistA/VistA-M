PSNPPSMS ;HP/LE-PPSN update NDFK ; 05 Mar 2014  1:20 PM
 ;;4.0;NATIONAL DRUG FILE;**513**; 30 Oct 98;Build 53
 ;Reference to ^%ZISH supported by DBIA #2320
 ;
56(FILE,DIA,NEW,PSNTMPN) ;Drug Interaction file (#56) changes into 5000.561
 ;5000.561 = inactivated drug interactions
 ;5000.56 = added and edited drug interactions
 ;
 N DIC,DIE,DD,DO,DINUM,DA,FDA,NDFIEN,FLD1,TYPE,PSNPS,STAT
 S PSNPS=$P($G(^PS(59.7,1,10)),"^",12) Q:PSNPS'="N"
 S FLD1=$P(DIA,"^",3),NDFIEN=+DIA
 S STAT="",STAT=$S((FLD1=7&(NEW'="")):"I",PSNTMPN="DATAN":"A",PSNTMPN="DATAO":"E",1:"")
 I '$D(^NDFK(5000.56,$P(DIA,"^"))) D
 .S DIC="^NDFK(5000.56,",DIC(0)="Z",(X,DINUM)=$P(DIA,"^") D FILE^DICN
 .S DIE=DIC,DA=+Y K DIC
 .S DA=+$P(DIA,"^"),DIE="^NDFK(5000.56,",DR="1///"_STAT D ^DIE
 I $D(^NDFK(5000.56,$P(DIA,"^"))) D
 .S DIC="^NDFK(5000.56,",DA=+$P(DIA,"^"),DIE="^NDFK(5000.56,",DR="1///"_STAT D ^DIE
 Q
 ;
IGU ;For National VistA Test SQA use only
 ;When a PPS-N Update file cannot be installed in the National VistA Test SQA account, use this option to reject the file.
 ;Local VA production sites or product test accounts should NEVER use this option.  If you do, your NDF files
 ;will be out of sync and may cause irreparable damage.  This is for SQA to reject corrupted files before they are nationally released.
 N COMM,FILE,ANS,PARAM,ENTER,II,FLG,ACT,TYPE,PSNLEGF,ZTQUEUED,ZTREQ,IOBOFF,IOBON
 S (ACT,TYPE,PARAM)="",PARAM=$$GET1^DIQ(59.7,1,17,"I")
 ;
IGU2 ;
 S PSNLEGF="",PSNLEGF=$$LEGACY^PSNPPSDL() I PSNLEGF Q
 S TYPE=$S("^P^T^S^"[("^"_PARAM_"^"):"C",1:"CR")
 W !!
 I TYPE="C" W "Note: Local sites may send completion messages for PPSN Update files, but may" D  ;only show for local sites, product support, local site test accounts
 .W !,"not utilize the Reject Update File functionality as it is for National QA only.",!!
 K DIR S DIR(0)="F^17:40^I X'?1""PPS_""1.12N1""PRV_""1.12N1""NEW.DAT"" K X"
 S DIR("A")="Enter the PPS-N data file name to be "_$S(TYPE="CR":"Updated",1:"Completed")
 S DIR("?",1)="  Enter the PPS-N Update file name that cannot be installed."
 S DIR("?")="  The file format should be PPS_nnPRV_nnNEW.DAT." D ^DIR K DIR S FILE=Y
 I (FILE="")!$D(DTOUT)!$D(DUOUT) Q
 S (II,FLG)=0 F  S II=$O(^PS(57.23,1,4,"B",FILE,II)) Q:'II  I $P($G(^PS(57.23,1,4,II,0)),"^",4)]"" S FLG=1
 I FLG=0 W !!!,$G(IOBON),"WARNING:",$G(IOBOFF)," The selected file hasn't been downloaded in VistA. It must be ",!,?9,"downloaded before you can be take action.",$C(7) Q
 I +$P(FILE,"_",2)'=($$GET1^DIQ(57.23,1,8)-1) W !!!,$G(IOBON),"WARNING:",$G(IOBOFF)," Reject isn't allowed for Update files older than the current",!,?9,"downloaded version",$C(7) R !!,"Enter to continue... ",ENTER:60 Q
 ;
 I TYPE="CR" D ACTION I ACT="^" W !!,"No action taken." Q
 S ACT=$S(TYPE="C":"C",1:ACT)
 I ACT="C" D  D CONT Q
 .S COMM="",COMM=$$SEND^PSNPPSNC("COMPLETED",$P(FILE,";"),"") H 1 W !! D
 ..I COMM=1 W !,"Complete message was sent to PPS-N. File should be approved/rejected ",!,"in PPS-N side.",!
 ..;E  W !,"There was a problem and the data file was not completed in PPS-N side."
 ..I 'COMM D RETRY
 ;
RJ ; execute file rejection
 N NFF S NFF=$$ASK(FILE) I $O(^PS(57.23,1,"B",$P(FILE,";")_";"_$P(NFF,"^",2),""),-1),PARAM'="Q" W !!,"No action taken." Q
 W ! K DIR S DIR("A")="Are you sure you want to reject file '"_FILE_"'",DIR("B")="NO",DIR(0)="Y" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) Q
 S ANS=Y I 'ANS W !!,"No action taken." Q
 W !
 ; send message to PPS-N - REJECTED processing
 S COMM="",COMM=$$SEND^PSNPPSNC("ERROR",$P(FILE,";"),"Automatically Rejected: Unable to Install Update File in the Test Account") H 1
 I 'COMM D  G IGU2
 .W !?11,"*** ERROR: "_$P(COMM,"^",2)
 .W !!?11,"PPS-N did not accept the REJECT transmission for "
 .W !?11,FILE_"."
 .W !!?11,"Contact your IRM and ask them to validate that the UPDATE_STATUS"
 .W !?11,"web service manager is defined under the Web Server Name PPSN"
 .W !?11,"and that it is active.  Also verify that the Pharmacy Product"
 .W !?11,"System-National (PPS-N) is on-line.",!!
 I COMM W !!,FILE," has been automatically rejected in PPS-N.",! S $P(^PS(57.23,1,0),"^",7)=+$P(FILE,"_",2) D
 .I $P(NFF,"^",2) D REJUPD(FILE_";"_$P(NFF,"^",2))
 ;
CONT ;
 K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to Continue" D ^DIR
 Q
ACTION ; prompt user for action type (complete/reject)
 I $$ASK1(FILE) S ACT="C" Q
 W ! K DIR,ACT S DIR("A")="Action",DIR(0)="S^C:Complete data file;R:Reject data file",DIR("B")="C"
 S DIR("?")="Enter 'R' to reject the data file in PPS-N and retain the data for next update file version.  Enter 'C' to changes the status in PPS-N which allows the user to notify PPS-N that the installation completed."
 D ^DIR S ACT=$G(Y)
 Q
 ;
RETRY ; try to resend of complete message to PPS-N within one hour
 W !,"There was a problem and the data file was not completed in PPS-N side."
 W !,"The completion message will be automatically resent to PPS-N until the message  is successfully transmitted or one hour has elapsed.",!
 N ZTRTN,ZTIO,ZTDESC,ZTDTH,ZTSK
 S ZTIO="",ZTRTN="NEWTRY^PSNPPSMS",ZTDESC="Automatic Resend of Complete message to PPS-N"
 S ZTDTH=$H,ZTSAVE("FILE")="",ZTSAVE("DUZ")="" D ^%ZTLOAD I $D(ZTSK) W !!,"Queued as task #"_ZTSK K ZTSK
 W !! K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to Continue" D ^DIR
 Q
NEWTRY ; send of complete message to PPS-N
 N PSNTXT,SDTM,ELAPS,DAY,XX,COMM,EDTM S SDTM=$H,(ELAPS,DAY,XX)=0
 S:$D(ZTQUEUED) ZTREQ="@"
N1 S COMM=0 S COMM=$$SEND^PSNPPSNC("COMPLETED",$P(FILE,";"),"")
 S EDTM=$H,DAY=+EDTM-(+SDTM)*86400 S XX=DAY+$P(EDTM,",",2)-$P(SDTM,",",2) I (XX\3600) S ELAPS=1
 I (COMM+ELAPS)=0 G N1
 ; send mail message notification
 S XMY(DUZ)="",XMSUB="PPS-N/NDF file ["_FILE_"] - COMPLETE message status"
 S PSNTXT(1)=""
 S PSNTXT(2)=$S(COMM=0:"There was a problem and the data file was not completed in PPS-N side.",COMM=1:"Complete message was sent to PPS-N. File should be approved/rejected.",1:"")
 S XMDUZ=.5,XMTEXT="PSNTXT("
 D ^XMD
 Q
CTRLFILE(FILE) ;PROCESS CONTROL FILE, FILE NUMBER
 K FDA
 S FDA(57.231,CTRLXIEN_","_CTRLIEN_",",3)=FILE
 D UPDATE^DIE("","FDA","CTRLIEN")
 K FDA
 Q
 ;
CTRLIEN(IENS) ;PROCESS CONTROL FILE, IENS
 K FDA
 S FDA(57.231,CTRLXIEN_","_CTRLIEN_",",4)=IENS
 D UPDATE^DIE("","FDA","CTRLIEN")
 K FDA
 Q
 ;
CTRLSS(SS) ;PROCESS CONTROL FILE, SUBSCRIPT
 K FDA
 S FDA(57.231,CTRLXIEN_","_CTRLIEN_",",5)=$TR($TR(SS,""""),")")
 D UPDATE^DIE("","FDA","CTRLIEN")
 K FDA
 Q
 ;
CTRKDL(DSPLY) ;PROCESS CONTROLL FILE, DISPLAYED LAST
 K FDA
 S FDA(57.231,CTRLXIEN_","_CTRLIEN_",",7)=DSPLY
 D UPDATE^DIE("","FDA","CTRLIEN")
 K FDA
 ;
RESOP ;Restarting option and protocol which were paused during install
 Q:'$D(^TMP("PSNCON",$J))
 N FL,IEN,DIE,DA,DR
 S FL=0
 F  S FL=$O(^TMP("PSNCON",$J,FL)) Q:FL=""  D
 .S IEN=0
 .F  S IEN=$O(^TMP("PSNCON",$J,FL,IEN)) Q:IEN=""  D
 ..S DIE=FL,DA=IEN,DR="2///@"
 ..D ^DIE
 Q
 ;
LOAD1 ;BUILD THE MESSAGE
 N PSNFIRST,PSNWP,DIWL,DIWR,J,NA
 S FDA(57.231,CTRLXIEN_","_CTRLIEN_",",6)="TEXT"
 D UPDATE^DIE("","FDA","CTRLIEN")
 K FDA
 S DIWL=1,DIWR=78 K ^UTILITY($J,"W")
 S ^TMP("PSN",$J,LINE,0)=" ",LINE=LINE+1
 S X="The following "_$S(INDX="A":"active",INDX="X":"investigational",1:"inactive")_" entries in your DRUG file (#50) have been" D ^DIWP
 S J=0 F  S J=$O(^TMP("PSN PPSN PARSED",$J,"TEXT",J)) Q:'J  S X=^TMP("PSN PPSN PARSED",$J,"TEXT",J) D ^DIWP
 S J=0 F  S J=$O(^UTILITY($J,"W",DIWL,J)) Q:J=""  S ^TMP("PSN",$J,LINE,0)=^UTILITY($J,"W",DIWL,J,0),LINE=LINE+1
 K ^UTILITY($J,"W")
 S ^TMP("PSN",$J,LINE,0)=" ",LINE=LINE+1
 S NA="" I $O(^TMP($J,INDX,NA))="" S ^TMP("PSN",$J,LINE,0)="  NONE",LINE=LINE+1 Q
 S PSNFIRST=0,NA=""
 F  S NA=$O(^TMP($J,INDX,NA)) Q:NA=""  D
 .I 'PSNFIRST D
 ..S ^TMP("PSN",$J,LINE,0)="DRUG                                                  IEN    INACTIVATION",LINE=LINE+1
 ..S ^TMP("PSN",$J,LINE,0)="                                                             DATE",LINE=LINE+1
 ..S PSNFIRST=1
 .S X=^TMP($J,INDX,NA,1),^TMP("PSN",$J,LINE,0)=$P(NA,"^") S $E(^TMP("PSN",$J,LINE,0),55)=$P(NA,"^",2)
 .S:INDX="I" $E(^(0),62)=$$FMTE^XLFDT($P(NA,"^",3),5) S LINE=LINE+1,^TMP("PSN",$J,LINE,0)=$P(X,"^"),LINE=LINE+1
 .S J=1 F  S J=$O(^TMP($J,INDX,NA,J)) Q:'J  S ^TMP("PSN",$J,LINE,0)=^(J),LINE=LINE+1
 Q
 ;
HAZWASTE ;AFTER POPULATION OF HAZ WASTE FIELDS - CREATE DELIMITED FILE
 N PSWRKDIR,POP,IEN,HAZTODIS,PRIMESC,WASTE,DOTSC,X,NAME,HAZTOHAN,DATA,PSCOMFIL,PSRC,PSVUID
 S PSWRKDIR="",PSWRKDIR=$$GETD^PSNFTP()
 S PSCOMFIL="PSNHAZW.TXT"
 DO OPEN^%ZISH("FILE1",PSWRKDIR,PSCOMFIL,"W")
 IF POP DO  QUIT
 . SET PSRC="0^failed to open ftp .com file"
 ;
 S (POP,IEN,HAZTODIS,PRIMESC,WASTE,DOTSC,X,NAME,HAZTOHAN,PSVUID)=""
 DO USE^%ZISUTL("FILE1")
 W "VA PRODUCT IEN^NAME^HAZARDOUS TO HANDLE^HAZARDOUS TO DISPOSE^PRIMARY EPA CODE^WASTE SORT CODE^DOT SHIPPING CODE^VUID",!
 F  S IEN=$O(^PSNDF(50.68,IEN)) Q:'IEN&(IEN'?1N.N)  D
 .S X="",X=$G(^PSNDF(50.68,IEN,"HAZTODIS"))
 .;Q:$P(X,"^")'="Y"
 .S (DOTSC,NAME)="",NAME=$$GET1^DIQ(50.68,IEN,.01,"E"),PSVUID=$$GET1^DIQ(50.68,IEN,99.99)
 .S HAZTODIS=$$GET1^DIQ(50.68,IEN,102),PRIMESC=$P(X,"^",2),WASTE=$P(X,"^",3),HAZTOHAN=$$GET1^DIQ(50.68,IEN,101)
 .I $D(^PSNDF(50.68,IEN,"HAZTODIS2",1,0)) S DOTSC=^PSNDF(50.68,IEN,"HAZTODIS2",1,0)
 .S DATA=IEN_"^"_NAME_"^"_HAZTOHAN_"^"_HAZTODIS_"^"_PRIMESC_"^"_WASTE_"^"_DOTSC_"^"_PSVUID
 .W DATA,!
 DO CLOSE^%ZISH("FILE1")
 Q
 ;
QUEST ;
 N XX,X2,X22,QUEST,PSLAST,FIRST,PSNEW,PSFLG,PSFILES,PSFILE,PSNEXT,QCNT,DIRUT,DUOUT,DTOUT
 S PSFLG="",PSLAST=$$GET1^DIQ(57.23,1,2)
 S PSNEW=PSLAST+1,QCNT=0
 S PSFILE="PPS_"_PSLAST_"PRV_"_PSNEW_"NEW.DAT"
 S PSNEXT="PPS_"_PSNEW_"PRV_"_(PSNEW+1)_"NEW.DAT"
 S (XX,X2,X22,QUEST)=""
 F  S X2=$O(B1(X2)) Q:X2=""  S X22=$G(B1(X2)) D
 .I '$G(QCNT) W !!,"The following PPS-N/NDF Update file(s) are available for install: ",! S QCNT=1
 .I ($P($P(X22,"PRV"),"_",2))<PSLAST K B1(X2) Q
 .S XX=XX+1 W !?5,XX_")",?12,$P(X22,";") S PSFILES(99999999+(+$P(X22,"_",2)))=X22
 W !
 I '$G(XX) W !,?5,"There are no files to install.",! R !!,"Enter to continue... ",ENTER:60 S QUIT2=1 Q
 I XX>1 D QUESTA
 Q
 ;
QUESTA ;
 W !,"The files must be installed in sequential order and take around"
 W !,"30 minutes each to install. Pharmacy will be down for that period"
 W !,"of time.  Do you want to install just the first one or all of them?"
QUESTB ;
 R !!,"(F)irst file only or (A)ll files: ",QUEST:120
 I QUEST["^"!($G(DIRUT))!($G(DUOUT)) W !!,"No action taken.",! S QUIT2=1 Q
 I QUEST["?"!("FAfa"'[QUEST) W !!,"Enter F to install only the first file or A to install all files." G QUESTB
QUESTC ;
 F  S X2=$O(B1(X2)) Q:X2=""  S X22=$G(B1(X2)) I '$D(PSFILES(X2)) K B1(X2)
 I "Ff"[QUEST D
 .S (X2,FIRST)="",FIRST=$O(PSFILES(FIRST))
 .F  S X2=$O(B1(X2)) Q:X2=""  S X22=$G(B1(X2)) I X22'=$G(PSFILES(FIRST)) K B1(X2)
 .W !!,"Only the first entry will be installed.",! S QUIT2=""
 Q
 ;
DISMNU ;disable menu options
 N PSREASON,Y,SEQ,NAM
 W:'$G(PSNSCJOB) !,"Disabling mandatory options... " D NOW^%DTC S Y=% X ^DD("DD") W Y,!
 S PSREASON="",PSREASON="PPS-N/NDF Update installation"
 D OUT^XPDMENU("PSO LM BACKDOOR ORDERS",PSREASON)
 D OUT^XPDMENU("PSO RELEASE",PSREASON)
 D OUT^XPDMENU("PSO RXRPT",PSREASON)
 D OUT^XPDMENU("PSNPMIS PRINT",PSREASON)
 W:'$G(PSNSCJOB) !!,"Disabling user defined Scheduled Options... "
 S (SEQ,IEN)="0"
 F  S SEQ=$O(^PS(57.23,1,3,"B",SEQ)) Q:SEQ=""  S NAM=$$GET1^DIQ(19.2,SEQ,.01,"E") W !?5,NAM D DISOUT(NAM,PSREASON)
 W:'$G(PSNSCJOB) !!,"Disabling user defined Menu Options... "
 F  S SEQ=$O(^PS(57.23,1,3.1,"B",SEQ)) Q:SEQ=""  S NAM=$$GET1^DIQ(19,SEQ,.01,"E") W !?5,NAM D DISOUT(NAM,PSREASON)
 W:'$G(PSNSCJOB) !!,"Disabling user defined Protocols... " ;D NOW^%DTC S Y=% X ^DD("DD") W Y,!
 F  S SEQ=$O(^PS(57.23,1,3.2,"B",SEQ)) Q:SEQ=""  S NAM=$$GET1^DIQ(101,SEQ,.01,"E") W !?5,NAM D
 .S $P(^ORD(101,SEQ,0),U,3)=PSREASON  ;ZQOO1
 Q
 ;
DISOUT(NAM,PSREASON) ;
 D OUT^XPDMENU(NAM,PSREASON)
 Q
ENABLE ;enable menu options
 N Y,PSREASON
 S PSREASON=""
 W:'$G(PSNSCJOB) !,"Enabling options..."
 D OUT^XPDMENU("PSO LM BACKDOOR ORDERS","")
 D OUT^XPDMENU("PSO RELEASE","")
 D OUT^XPDMENU("PSO RXRPT","")
 D OUT^XPDMENU("PSNPMIS PRINT","")
 D NOW^%DTC S Y=% X ^DD("DD") W:'$G(PSNSCJOB) Y,!
 W:'$G(PSNSCJOB) !!,"Enabling user defined Scheduled Options... "
 S (SEQ,IEN)=""
 F  S SEQ=$O(^PS(57.23,1,3,"B",SEQ)) Q:SEQ=""  S NAM=$$GET1^DIQ(19.2,SEQ,.01,"E") W !?5,NAM D DISOUT(NAM,PSREASON)
 W:'$G(PSNSCJOB) !!,"Enabling user defined Menu Options... "
 F  S SEQ=$O(^PS(57.23,1,3.1,"B",SEQ)) Q:SEQ=""  S NAM=$$GET1^DIQ(19,SEQ,.01,"E") W !?5,NAM D DISOUT(NAM,PSREASON)
 W:'$G(PSNSCJOB) !!,"Enabling user defined Protocols... "
 F  S SEQ=$O(^PS(57.23,1,3.2,"B",SEQ)) Q:SEQ=""  S NAM=$$GET1^DIQ(101,SEQ,.01,"E") W !?5,NAM D
 .S $P(^ORD(101,SEQ,0),U,3)=""
 W !,"Options and protocols enabled: " D NOW^%DTC S Y=% X ^DD("DD") W Y,!
 Q
ENABLE2(NAM,PSREASON) ;
 D OUT^XPDMENU(NAM,PSREASON)
 Q
 ;
ERRORMS ;FILE ERRORS ENCOUNTERED
 N PSNEFIL,PSNEIEN,PSNEEN,PSNEUFS,PSNEFLD,PSNESEQ,PSNESEQ2,PSMSGTXT,PSNEX,PSNECNT,PSNECNT2
 D NOW^%DTC
 S (PSNEUFS,PSNEFIL,PSNEIEN,PSNEFLD,PSNESEQ,PSNECNT,PSNECNT2,PSNEX)=""
 I $D(^TMP("PSN PPSN ERR",$J))&($D(^PS(57.23,1))) F  S PSNEUFS=$O(^TMP("PSN PPSN ERR",$J,PSNEUFS)) Q:PSNEUFS=""  D
 .F  S PSNEFIL=$O(^TMP("PSN PPSN ERR",$J,PSNEUFS,PSNEFIL)) Q:PSNEFIL=""  D
 ..F  S PSNEIEN=$O(^TMP("PSN PPSN ERR",$J,PSNEUFS,PSNEFIL,PSNEIEN)) Q:PSNEIEN=""  D
 ...F  S PSNEFLD=$O(^TMP("PSN PPSN ERR",$J,PSNEUFS,PSNEFIL,PSNEIEN,PSNEFLD)) Q:PSNEFLD=""  D
 ....F  S PSNESEQ=$O(^TMP("PSN PPSN ERR",$J,PSNEUFS,PSNEFIL,PSNEIEN,PSNEFLD,PSNESEQ)) Q:PSNESEQ=""  D
 .....S PSNEX=^TMP("PSN PPSN ERR",$J,PSNEUFS,PSNEFIL,PSNEIEN,PSNEFLD,PSNESEQ)
 .....S PSNECNT=99999999999,PSNECNT=$O(^PS(57.23,1,5,PSNECNT),-1)
 .....I '$D(PSNECNT) S ^PS(57.23,1,5,PSNECNT,2,0)="^57.23D^1^1"
 .....S PSNECNT2=99999999999,PSNECNT2=$O(^PS(57.23,1,5,PSNECNT,2,PSNECNT2),-1)
 .....S PSNECNT2=PSNECNT2+1
 .....S ^PS(57.23,1,5,PSNECNT,2,PSNECNT2,0)=%_"^"_PSNEFIL_"^"_PSNEIEN_"^"_PSNEUFS_"^"_PSNEX
 Q
 ;
ASK(FILE) ; check if the file has been finalized
 ;LSTD - Last Download version
 ;
 N NFILE,LSTD,PSI
 S PSI=0
 S PSI=$O(^PS(57.23,1,4,"G",$P(FILE,";"),""),-1) I 'PSI Q "0^0"
 I PSI S LSTD=$G(^PS(57.23,1,4,"G",$P(FILE,";"),PSI)),NFILE=FILE_";"_LSTD
 I $D(^PS(57.23,1,6,"B",NFILE)) W !!,"WARNING: File has been rejected and finalized. It's not recommended to",!,?9,"reject it again."
 Q PSI_"^"_LSTD
 ;
ASK1(FILE) ; check if the file has been previously installed
 N NFILE,LSTD,LSTI,PSI
 S (PSI,LSTD,LSTI)=0
 S PSI=$O(^PS(57.23,1,4,"G",$P(FILE,";"),""),-1) I 'PSI Q 0
 S LSTD=$G(^PS(57.23,1,4,"G",$P(FILE,";"),PSI)),NFILE=FILE_";"_LSTD
 S LSTI=$O(^PS(57.23,1,5,"B",NFILE,0))
 Q LSTI
 ;
REJUPD(FILE) ; update reject history node
 K FDA
 N PSI,LSTD S LSTD=1
 S FDA(57.236,"+2,"_1_",",.01)=FILE D UPDATE^DIE("","FDA")
 K IEN6,%,FDA
 S IEN6=$O(^PS(57.23,1,6,"B",FILE,""),-1)
 D NOW^%DTC
 S FDA(57.236,IEN6_","_1_",",1)=%,FDA(57.236,IEN6_","_1_",",2)=DUZ D UPDATE^DIE("","FDA")
 Q
