LRSRVR8 ; DALOI/JMC - LAB DATA SERVER - Utilities ;03/22/11  15:23
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
LOAD ; Load mapping file into VistA as file server for distribution to other sites.
 ;
 N LRFILE,LRRECORDFORMAT,LRMAILGROUP,LRMAILGROUPXQA,LRMAPPINGFILE,LRTYPE,PWD
 K ^TMP($J)
 ;
 D TYPE(1)
 I LRTYPE<1 Q
 ;
 ; Select/get mapping file
 D GETFILE
 I LRFILE="" Q
 ;
 ; Load file into TMP global
 D LOADFILE
 ;
 ; Process file from TMP global into file #95.4
 I $D(^TMP($J,"LRMAP")) D IMPORT(LRTYPE)
 Q
 ;
 ;
LOADSCT ; Load SCT mapping file into VistA and apply mapping.
 ; Called by option LA7S LOAD MAPPING SCT to load and apply mapping directly at the site.
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,LRACTION,LRFILE,LRMAILGROUP,LRMAPPINGFILE,LRRECORDFORMAT,LRTYPE,PWD,X,Y
 K ^TMP($J)
 S LRTYPE=2,LRTYPE(0)="SCT",LRACTION=1
 ;
 ; Ask if just processing exiting entries and/or load a file.
 I $D(^LAHM(95.4,"AF","SCT")) D
 . K DIR,DIRUT,DIROUT,DTOUT,DUOUT
 . S DIR(0)="SO^1:Load file;2:Process previous loaded file",DIR("B")="2"
 . D ^DIR
 . I Y<1 S LRACTION=0 Q
 . S LRACTION=+Y
 ;
 I LRACTION<1 Q
 ;
 I LRACTION=1 D
 . D GETFILE ; Select/get mapping file
 . I LRFILE="" Q
 . ;
 . D LOADFILE ; Load file into TMP global
 . I '$D(^TMP($J,"LRMAP")) Q
 . ;
 . D IMPORT(LRTYPE) ; Process file from TMP global into file #95.4
 ;
 ; Process entries in file #95.4 and apply to target files.
 I '$D(^LAHM(95.4,"AF","SCT")) D  Q
 . K DIR,DIRUT,DIROUT,DTOUT,DUOUT
 . S DIR(0)="E",DIR("A",1)="No SNOMED CT codes loaded in LAB MAPPING file",DIR("A")="Press any key to continue"
 . D ^DIR
 ;
 K DIR,DIRUT,DIROUT,DTOUT,DUOUT
 S DIR(0)="SO^0:Quit - no action;1:Process SNOMED CT mappings directly;2:Task processing SNOMED CT mappings"
 S DIR("A")="Processing Action",DIR("B")="0"
 D ^DIR
 I Y<1 Q
 ;
 ; Check that mail group has members
 S LRMAILGROUP="LAB MAPPING"
 I '$$GOTLOCAL^XMXAPIG(LRMAILGROUP) D  Q
 . N XQAID,XQAMSG,XQAROU,XQADATA,XQA
 . S LRMAILGROUP="LMI"
 . S XQAMSG="Lab "_LRTYPE(0)_" mapping process: No local members in mail group LAB MAPPING"
 . S XQA("G."_LRMAILGROUP)="",XQAID="LRSRVR-"_$S(LRTYPE=1:"LOINC",LRTYPE=2:"SNOMED CT",1:"UNKNOWN")_"-"_$H
 . D SETUP^XQALERT
 . K DIR,DIRUT,DIROUT,DTOUT,DUOUT
 . S DIR(0)="E"
 . S DIR("A",1)="No local active members in mail group LAB MAPPING."
 . S DIR("A",2)="Loading will be aborted until mail group corrected."
 . S DIR("A")="Press any key to continue"
 . D ^DIR
 ;
 ; Task loading of SCT mapping on lab files
 I Y=2 D  Q
 . N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 . S ZTRTN="TASKSCT^LRSRVR8",ZTDESC="Tasked Loading of SNOMED CT codes mappings on Lab files"
 . S ZTSAVE("LRTYPE*")="",ZTSAVE("LRMAILGROUP")=""
 . S ZTIO=""
 . D ^%ZTLOAD,^%ZISC
 . W !,"Request "_$S($G(ZTSK):"queued - Task #"_ZTSK,1:"NOT queued")
 ;
 ; Load SCT mappings interactively.
 D TASKSCT
 ;
 Q
 ;
 ;
TASKSCT ; Processing applying SCT mappings to local site.
 ;
 ; Load SNOMED CT codes into lab files
 D TASKMAP^LRSRVR5
 ;
 Q
 ;
 ;
SEND ; Send file to LRLABSERVER at specified site.
 N DIC,DIR,DIRUT,DTOUT,DUOUT,LRASKDOM,LRCNT,LRFILE,LRI,LRPURGE,LRSITE,LRTYPE,X,Y
 ;
 D TYPE(2)
 I LRTYPE<1 Q
 ;
 K DIC,LRSITE
 S DIC="^DIC(4,",DIC(0)="EMOQ",DIC("S")="I $D(^LAHM(95.4,""AC"",+Y))"
 S X=$$SELECT^LRUTIL(.DIC,.LRSITE,"Institution",10,0,0,0)
 I X=0 Q
 I X="*" S LRSITE=1
 ;
 K DIR
 S DIR(0)="Y",DIR("A")="Purge mapping for site after transmitting",DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) Q
 S LRPURGE=+Y
 ;
 S X=$$GET^XPAR("USR^PKG^SYS","LR MAPPING ASK DOMAIN",1,"Q")
 W !
 K DIR
 S DIR(0)="YO",DIR("B")=$S(X=1:"YES",1:"NO")
 S DIR("A",1)="Answer 'YES' if sending to a test system or a different domain"
 S DIR("A",2)="and specify that system's mail domain when prompted."
 S DIR("A")="Prompt/confirm MailMan Domain for each site"
 D ^DIR
 I $D(DIRUT) Q
 S LRASKDOM=Y
 ;
 K DIR
 S DIR(0)="YO",DIR("A")="Ready to send mappings to site(s)",DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) Q
 I Y'=1 Q
 ;
 S LRFILE=95.4
 ; Do all sites in file
 I LRSITE=1 D  Q
 . S LRSITE=0
 . F  S LRSITE=$O(^LAHM(LRFILE,"AC",LRSITE)) Q:'LRSITE  D
 . . S LRSITE(LRSITE)=$$NAME^XUAF4(LRSITE)
 . . D BLDMSG
 ;
 ; Do selected sites
 S LRSITE=0
 F  S LRSITE=$O(LRSITE(LRSITE)) Q:'LRSITE  D BLDMSG
 Q
 ;
 ;
IMPORT(LRTYPE) ;
 ; Call with LRTYPE = type of data (1=LOINC, 2=SNOMED, 3=LOINC Database)
 ;
 N LRFILE,LRMAP
 ;
 ;ZEXCEPT: ZTQUEUED
 ;
 ; Check if file exists.
 S LRFILE=95.4
 I '$$VFILE^DILFD(LRFILE) D  Q
 . I '$D(ZTQUEUED) D EN^DDIOL("Lab Mapping Transport File (#"_LRFILE_") does NOT exist","","!") Q
 ;
 S LRTYPE(0)=$S(LRTYPE=1:"LN",LRTYPE=2:"SCT",LRTYPE=3:"LNDB",1:"UNK")
 I '$D(ZTQUEUED) W !,"Processing file data and storing in file #",LRFILE D WAIT^DICD
 D BUILD
 ;
 K ^TMP($J,"LRMAP")
 Q
 ;
 ;
BUILD ; Load Records into file
 ;
 N LRCNT,LREND,LRFLD,LRI,LRID,LRLNDBSTART,LRLOINCVERSION,LRNOW,LRQUIT,LRSITE,LRX
 ;
 ;ZEXCEPT: LRTYPE,ZTQUEUED
 ;
 ;
 I '$D(ZTQUEUED) W !
 S LRNOW=$$HTFM^XLFDT($H)
 ; Read and check headers
 S (LRCNT,LREND,LRI,LRQUIT)=0
 I LRTYPE(0)="LNDB" S LRLNDBSTART=0,LRLOINCVERSION=""
 F  S LRI=$O(^TMP($J,"LRMAP",LRI)) Q:LRI<1  D  Q:LREND
 . I '$D(ZTQUEUED),'(LRI#100) W:$X>(IOM-1) ! W "."
 . K LRFLD,LRX
 . S LRX=^TMP($J,"LRMAP",LRI,0)
 . I LRTYPE(0)="LN" D  Q
 . . I LRI=1 D  Q
 . . . I LRX'="Station #-File #-IEN|Entry Name" S LREND=1
 . . D PARSELN,FILE
 . I LRTYPE(0)="SCT" D  Q
 . . I LRI=1 D  Q
 . . . D CKSCTHDR Q:LREND
 . . . D BUILDMAP
 . . D PARSESCT,FILE
 . I LRTYPE(0)="LNDB" D  Q
 . . M LRX=^TMP($J,"LRMAP",LRI,"OVF")
 . . I 'LRLNDBSTART D  Q
 . . . D CKLNDBHR
 . . . I LRLNDBSTART D BUILDMLN
 . . D PARSELND,FILE
 ;
 I '$D(ZTQUEUED) W !,"Records added: ",LRCNT
 ;
 Q
 ;
 ;
PARSELN ; Parse record from TMP global for LOINC mapping
 Q
 ;
 ;
PARSELND ; Parse record from TMP global for LOINC Databsae loading
 ;
 ;ZEXCEPT: LRFLD,LRID,LRMAP,LRMAPPINGFILE,LRLOINCVERSION,LRSITE,LRX
 ;
 N LRI,LRLAST
 ;
 S LRI=0
 F  S LRI=$O(LRX(LRI)) Q:'LRI  S LRX=LRX_LRX(LRI)
 S LRX=$TR(LRX,$C(34),"")
 S LRID=$P(LRX,$C(9)),LRSITE=""
 ;
 S LRLAST=$L(LRX,$C(9))
 I $P(LRX,$C(9),LRLAST)="" S LRLAST=LRLAST-1
 F LRI=2:1:LRLAST I $P(LRX,$C(9),LRI)'="" S LRFLD(LRI,0)=LRMAP(LRI),LRFLD(LRI,100,1,0)=$P(LRX,$C(9),LRI)
 ;
 ; Also store name of source file used for these entries.
 S LRFLD(10000,0)=LRMAP(10000),LRFLD(10000,100,1,0)=$G(LRMAPPINGFILE)
 S LRFLD(10001,0)=LRMAP(10001),LRFLD(10001,100,1,0)=$G(LRLOINCVERSION)
 ;
 Q
 ;
 ;
PARSESCT ; Parse record from TMP global for SCT mapping
 ;
 N LRI
 ;
 ;ZEXCEPT: LRFLD,LRID,LRMAP,LRMAPPINGFILE,LRSITE,LRX
 ;
 S LRID=$P(LRX,"|")
 S LRSITE=$$IEN^XUAF4($P(LRID,"-"))
 F LRI=2:1:7 I $P(LRX,"|",LRI)'="" S LRFLD(LRI,0)=LRMAP(LRI),LRFLD(LRI,100,1,0)=$P(LRX,"|",LRI)
 ;
 ; Also store name of source file used to map these entries.
 S LRFLD(10000,0)=LRMAP(10000),LRFLD(10000,100,1,0)=$G(LRMAPPINGFILE)
 ;
 Q
 ;
 ;
FILE ; File the data in file
 ;
 N LRFDA,LRI,LRIEN,LRERR,LRY
 ;
 ;ZEXCEPT: LRCNT,LRFILE,LRFLD,LRID,LRNOW,LRSITE,LRTYPE,ZTQUEUED
 ;
 ; Get and lock file while processing.
 F  L +^LAHM(95.4,0):999 Q:$T
 ;
 ; Build FDA array and merge in data.
 S LRFDA(1,LRFILE,"?+1,",.01)=LRID
 S LRFDA(1,LRFILE,"?+1,",2)=LRSITE
 S LRFDA(1,LRFILE,"?+1,",3)=LRTYPE(0)
 S LRFDA(1,LRFILE,"?+1,",4)=0
 S LRFDA(1,LRFILE,"?+1,",6)=LRNOW
 D UPDATE^DIE("","LRFDA(1)","LRIEN","LRERR")
 I $D(LRERR) D  Q
 . I $D(ZTQUEUED) Q
 . K LRY
 . S LRY(1)="WARNING: Update failed for ID# "_LRID
 . S LRY(2)=$G(LRERR("DIERR","1","TEXT",1))
 . D EN^DDIOL(.LRY,"","!!?2")
 S LRCNT=LRCNT+1
 ;
 ; Store data
 S LRI=0
 F  S LRI=$O(LRFLD(LRI)) Q:'LRI  D
 . S ^LAHM(LRFILE,LRIEN(1),100,LRI,0)=LRFLD(LRI,0)
 . S ^LAHM(LRFILE,LRIEN(1),100,LRI,100,0)="^94.5011^^"
 . M ^LAHM(LRFILE,LRIEN(1),100,LRI,100)=LRFLD(LRI,100)
 ;
 ; Unlock transport global.
 L -^LAHM(95.4,0)
 ;
 Q
 ;
 ;
BLDMSG ; Build and send message for a specific site.
 ;
 N LRDOMAIN,LRENDMSG,LRHDL,LRMAXREC,LRMSG,LRXMZ
 ;
 ;ZEXCEPT: LRASKDOM,LRCNT,LRFILE,LRI,LRPURGE,LRSITE,LRTYPE,ZTQUEUED
 ;
 ;
 S LRDOMAIN=$$WHAT^XUAF4(LRSITE,60)
 I LRASKDOM D
 . N DIC,X,Y
 . W !!,"For ",LRSITE(LRSITE)
 . I LRDOMAIN'="" S DIC("B")=LRDOMAIN
 . S DIC=4.2,DIC(0)="AEMQ",DIC("A")="Send to MailMan DOMAIN: " D ^DIC
 . I Y<1 S LRDOMAIN="" Q
 . S LRDOMAIN=$P(Y,"^",2)
 I LRDOMAIN="" D  Q
 . I '$D(ZTQUEUED) D EN^DDIOL("No MailMan DOMAIN specified for this facility","","!?2") Q
 ;
 K ^TMP($J,"LRMAP"),^TMP($J,"LRMSG"),^TMP($J,"LRMAP-HDL")
 ;
 ; Move entries related to this institution to TMP global.
 ; Clear file #4 pointer in 2nd piece, resolve institution at target site based on .01 field
 I '$D(ZTQUEUED) D
 . D WAIT^DICD
 . W !,"Processing facility ",LRSITE(LRSITE),!,"Collecting records to build into mail message "
 S (LRCNT,LRI,LRMSG)=0
 S LRMAXREC=$$GET^XPAR("USR^PKG^SYS","LR MAPPING MESSAGE MAX RECORDS",1,"Q")
 I LRMAXREC<1 S LRMAXREC=3000
 F  S LRI=$O(^LAHM(LRFILE,"AC",LRSITE,LRI)) Q:'LRI  D
 . I $P(^LAHM(LRFILE,LRI,0),"^",3)'=LRTYPE(0) Q
 . S LRCNT=LRCNT+1
 . I '(LRCNT#100) W:$X>(IOM-1) ! W "."
 . I LRCNT#LRMAXREC=1 S LRMSG=LRMSG+1
 . M ^TMP($J,"LRMSG",LRMSG,LRI)=^LAHM(LRFILE,LRI)
 . S $P(^TMP($J,"LRMSG",LRMSG,LRI,0),"^",2)=""
 ;
 I '$D(^TMP($J,"LRMSG")) D  Q
 . I '$D(ZTQUEUED) D EN^DDIOL("NO data to transport","","!?2") Q
 ;
 I '$D(ZTQUEUED) W !,"Building records into mail message"
 S (LRI,LRENDMSG)=0
 F  S LRI=$O(^TMP($J,"LRMSG",LRI)) Q:'LRI  D
 . K ^TMP($J,"LRMAP")
 . M ^TMP($J,"LRMAP")=^TMP($J,"LRMSG",LRI)
 . I LRI=LRMSG S LRENDMSG=1
 . S X=$$HANDLE^XUSRB4("LR-MAP-"_LRTYPE(0)_"-",0)
 . S LRHDL=X,^TMP($J,"LRMAP-HDL",LRI,0)=X
 . D BUILDMSG
 ;
 I '$D(ZTQUEUED) D
 . W !,"Number of records transported: "_LRCNT
 . W !,"MailMan Message ID's: "
 . S LRI=""
 . F  S LRI=$O(LRXMZ(LRI)) Q:LRI=""  W ?23,LRI,!
 ;
 K ^TMP($J,"LRMAP"),^TMP($J,"LRMSG")
 ;
 I LRPURGE D PURGE
 ;
 Q
 ;
 ;
PURGE ; Purge related entries from file #95.4 for this site.
 N DIK,LRCNT,LRI
 ;
 ;ZEXCEPT: DA,LRFILE,LRSITE,ZTQUEUED
 ;
 W !,"Purging related entries from file #",LRFILE
 I '$D(ZTQUEUED) D WAIT^DICD
 ;
 S (LRCNT,LRI)=0,DIK="^LAHM(LRFILE,"
 F  S LRI=$O(^LAHM(LRFILE,"AC",LRSITE,LRI)) Q:'LRI  D
 . S LRCNT=LRCNT+1,DA=LRI D ^DIK
 . I '$D(ZTQUEUED),'(LRCNT#100) W:$X>(IOM-1) ! W "."
 Q
 ;
 ;
GETFILE ; Select the file to process
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILE,FILESPEC,LRFSPEC,LRHELP,LRNUM,X,Y
 ;
 ;ZEXCEPT: LRFILE,LRMAPPINGFILE,PWD
 ;
 K ^TMP($J),LRFILE
 S PWD=$$PWD^%ZISH()
 S X=$$GET^XPAR("USR^PKG^SYS","LR MAPPING DEFAULT DIRECTORY",1,"Q")
 I X'="" S PWD=X
 S LRFILE=""
 ;
 S DIR(0)="FO^1:245",DIR("A")="Host File Directory",DIR("B")=PWD
 F  D  Q:$D(DIRUT)!(PWD'="")
 . D ^DIR
 . I $D(DIRUT) Q
 . S PWD=$$DEFDIR^%ZISH(Y)
 . I PWD="" W !,"Invalid directory syntax",!
 I $D(DIRUT) Q
 D EN^XPAR("USR","LR MAPPING DEFAULT DIRECTORY",1,PWD)
 ;
 S LRFSPEC=$$GET^XPAR("USR^PKG^SYS","LR MAPPING DEFAULT FILESPEC",1,"Q")
 I LRFSPEC'="" S FILESPEC(LRFSPEC)="" W !,"Using filespec ",LRFSPEC
 S Y=$$LIST^%ZISH(PWD,"FILESPEC","LRFILE")
 I $O(LRFILE(""))="" W !,"No "_$S(LRFSPEC="":"",1:LRFSPEC_" ")_"files found in directory ",PWD,! Q
 ;
 S LRNUM=0,FILE=""
 F  S FILE=$O(LRFILE(FILE)) Q:FILE=""  S LRNUM=LRNUM+1,LRNUM(LRNUM)=FILE,LRHELP(LRNUM)=LRNUM_"  "_FILE
 K DIR
 S DIR(0)="NAO^1:"_LRNUM,DIR("A")="Select FILE: ",DIR("B")=$O(LRNUM(0))
 S DIR("?")="Select a file by number from the list" M DIR("?")=LRHELP
 D ^DIR
 I $D(DIRUT) Q
 S (LRFILE,LRMAPPINGFILE)=LRNUM(Y)
 Q
 ;
 ;
LOADFILE ; Load selected file into TMP global.
 ;
 N LRBACKUPDIR
 ;
 ;ZEXCEPT: LRFILE,LRMAILGROUPXQA,PWD,XQA,XQAMSG,Y,ZTQUEUED
 ;
 I '$D(ZTQUEUED) D
 . W !,"Directory: "_PWD
 . W !,"File.....: "_LRFILE
 . W !,"Loading file into TMP global"
 . D WAIT^DICD
 ;
 S Y=$$FTG^%ZISH(PWD,LRFILE,$NA(^TMP($J,"LRMAP",1,0)),3,"OVF")
 I Y<1 D
 . I '$D(ZTQUEUED) W !!,*7,"File failed to load into TMP global",!! Q
 . S XQAMSG="Lab Mapping: Unable to load "_LRFILE_" into TMP global"
 . S XQA(LRMAILGROUPXQA)=""
 . S XQA(DUZ)=""
 . D SETUP^XQALERT
 ;
 ;
 ; If processed directory specified then move file to that directory
 S LRBACKUPDIR=$$GET^XPAR("USR^PKG^SYS","LR MAPPING PROCESSED DIRECTORY",1,"Q")
 I LRBACKUPDIR="" Q
 S Y=$$MV^%ZISH(PWD,LRFILE,LRBACKUPDIR,LRFILE)
 I Y<1 D
 . I '$D(ZTQUEUED) W !!,*7,"Failed to move file from directory "_PWD_" to directory "_LRBACKUPDIR,!! Q
 . S XQAMSG="Lab Mapping: Unable to move "_LRFILE_" to "_LRBACKUPDIR
 . S XQA(LRMAILGROUPXQA)=""
 . S XQA(DUZ)=""
 . D SETUP^XQALERT
 ;
 Q
 ;
 ;
BUILDMAP ; Build map of field names related to field # in record
 N I,LRLAST,LRY
 ;
 ;ZEXCEPT: LRMAP,LRX
 ;
 K LRMAP
 ;
 ; SNOMED CT format 1:  Station #-File #-IEN|Entry Name|SNOMED I|STS_FURTHER_ACTION|STS_SCT_ID|STS_TYPE_OF_MATCH|
 ; SNOMED CT format 2:  Station #-File #-IEN|Entry Name|SNOMED I|SNOMED CT|STS_EXCEPTION|STS_EXCEPTION_REASON|TRANSACTION NUMBER|
 ; SNOMED CT format 2:  Station #-File #-IEN|Entry Name|SNOMED I|SNOMED CT|STS_EXCEPTION|STS_EXCEPTION_REASON|
 ;
 ;       LOINC format: TBD
 ;
 ; Handle if last character a delimiter or part of field name
 S LRLAST=$L(LRX,"|")
 I $P(LRX,"|",LRLAST)="" S LRLAST=LRLAST-1
 F I=1:1:LRLAST S LRY=$S($P(LRX,"|",I)'="":$P(LRX,"|",I),1:"BLANK"),LRMAP(I)=I_":"_LRY
 ;
 S LRMAP(10000)="10000:MAPPING SOURCE FILE"
 ;
 Q
 ;
 ;
BUILDMLN ; Build map of field names related to field # in record for LOINC database file
 N I,LRLAST,LRY
 ;
 ;ZEXCEPT: LRMAP,LRX
 ;
 K LRMAP
 ;
 ;       LOINC format: TBD
 ;
 ; Handle if last character a delimiter or part of field name
 S I=0
 F  S I=$O(LRX(I)) Q:'I  S LRX=LRX_LRX(I)
 S LRX=$TR(LRX,$C(34),"")
 ;
 S LRLAST=$L(LRX,$C(9))
 I $P(LRX,$C(9),LRLAST)="" S LRLAST=LRLAST-1
 F I=1:1:LRLAST S LRY=$S($P(LRX,$C(9),I)'="":$P(LRX,$C(9),I),1:"BLANK-"_I),LRMAP(I)=I_":"_LRY
 ;
 S LRMAP(10000)="10000:MAPPING SOURCE FILE"
 S LRMAP(10001)="10001:LOINC VERSION"
 ;
 Q
 ;
 ;
TYPE(LRFUNC) ; Ask what code set
 ; Call with function to perform: 1-load mapping file, 2-transport mapping to site
 ;
 N DIC,DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ;ZEXCEPT: LRTYPE
 ;
 ;
 S DIR(0)="SO^1:LOINC;2:SNOMED CT;3:LOINC Database",DIR("A")="Type of mapping to "_$S(LRFUNC=1:"load",LRFUNC=2:"transport",1:"")
 D ^DIR
 I $D(DIRUT) S LRTYPE=0 Q
 S LRTYPE=Y,LRTYPE(0)=$S(Y=1:"LN",Y=2:"SCT",Y=3:"LNDB",1:"")
 Q
 ;
 ;
BUILDMSG ; Build the MailMan PackMan message
 ;
 N LRI,MSG,XMDUN,XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ,X,Y
 ;
 ;ZEXCEPT: LRDOMAIN,LRENDMSG,LRHDL,LRTYPE,LRXMZ
 ;
 K ^TMP("XMP",$J)
 S ^TMP("XMP",$J,1,0)=LRHDL
 ;
 S XMSUB=$S(LRTYPE=1:"RELMA",LRTYPE=2:"SNOMED",1:"")_" MAPPING",XMY("S.LRLABSERVER@"_LRDOMAIN)="",XMTEXT="^TMP($J,""LRMAP"",;"
 I LRENDMSG S XMTEXT=XMTEXT_"^TMP($J,""LRMAP-HDL"",;"
 S XMDUN="Lab Server",XMDUZ=".5"
 D ENT^XMPG
 ;
 ; Inform sender of action status
 S MSG=""
 I $G(XMZ)>0 D
 . S LRXMZ(XMZ)=""
 . S MSG(1)="MailMan message #"_XMZ_" queued for transmission to:",MSG(1,"F")="!!"
 . S MSG(2)="S.LRLABSERVER@"_LRDOMAIN,MSG(2,"F")="!?3"
 E  S MSG(1)="MailMan message generation failed with error: ",MSG(1,"F")="!!",MSG(2)=XMMG,MSG(2,"F")="!?3"
 D EN^DDIOL(.MSG,"","")
 Q
 ;
 ;
INIT ; Initialize variables used by process.
 ;
 ;ZEXCEPT: LRMAILGROUP,LRMAILGROUPXQA
 ;
 S (LRMAILGROUP,LRMAILGROUPXQA)="G.LAB MAPPING"
 ; If no local members then use LMI group
 I '$$GOTLOCAL^XMXAPIG("LAB MAPPING") S (LRMAILGROUP,LRMAILGROUPXQA)="G.LMI"
 ;
 Q
 ;
 ;
CKSCTHDR ; Check the header of the file to determine if it's
 ;  - the right type of file
 ;  - the record format
 ;
 ;ZEXCEPT: LREND,LRQUIT,LRRECORDFORMAT,LRX
 ;
 N LRY
 ;
 S (LRQUIT,LREND)=1,LRRECORDFORMAT=0
 ;
 S LRY="STATION #-FILE #-IEN|ENTRY NAME|SNOMED I|STS_FURTHER_ACTION|STS_SCT_ID|STS_TYPE_OF_MATCH|"
 I $$UP^XLFSTR(LRX)=LRY S (LRQUIT,LREND)=0,LRRECORDFORMAT=1 Q
 ;
 S LRY="STATION #-FILE #-IEN|ENTRY NAME|SNOMED I|SNOMED CT|STS_EXCEPTION|STS_EXCEPTION_REASON|TRANSACTION NUMBER|"
 I $$UP^XLFSTR(LRX)=LRY S (LRQUIT,LREND)=0,LRRECORDFORMAT=2 Q
 ;
 S LRY="STATION #-FILE #-IEN|ENTRY NAME|SNOMED I|SNOMED CT|STS_EXCEPTION|STS_EXCEPTION_REASON|"
 I $$UP^XLFSTR(LRX)=LRY S (LRQUIT,LREND)=0,LRRECORDFORMAT=2 Q
 ;
 Q
 ;
 ;
CKLNDBHR ; Check the header of the file to determine if it's
 ;  - the right type of file
 ;  - the record format
 ;
 ;ZEXCEPT: LREND,LRQUIT,LRLNDBSTART,LRLOINCVERSION,LRX
 ;
 N LRY
 ;
 S LRX=$TR(LRX,$C(34),"")
 ;
 S LRY="LOINC(R) Database Version"
 I $E(LRX,1,$L(LRY))=LRY S LRLOINCVERSION=$$TRIM^XLFSTR($E(LRX,$L(LRY)+1,$L(LRX)),"LR"," ") Q
 ;
 S LRY="LOINC_NUM"
 I $$UP^XLFSTR($E(LRX,1,$L(LRY)))=LRY S (LRQUIT,LREND)=0,LRLNDBSTART=1
 ;
 Q
