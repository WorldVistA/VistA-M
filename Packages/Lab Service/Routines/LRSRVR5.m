LRSRVR5 ;DALOI/JMC - LAB DATA SERVER - Load standardized code mappings ;01/13/11  09:16
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 Q
 ;
 ;
RMAP ; Load RELMA mapping into site's system
 ;
 ;ZEXCEPT: XMZ
 ;
 N LRNAME,LRNODE,LRTYPE
 S LRNODE="LRSRVR-RELMA-"_XMZ,LRNAME="Lab RELMA Mapping Update"
 S LRTYPE=1,LRTYPE(0)="LN"
 D PROCESS
 Q
 ;
 ;
CTMAP ; Load SNOMED CT mapping into site's system
 ;
 ;
 ;ZEXCEPT: XMZ
 ;
 N LRNAME,LRNODE,LRTYPE
 S LRNODE="LRSRVR-SNOMED CT-"_XMZ,LRNAME="Lab SNOMED CT Mapping Update"
 S LRTYPE=2,LRTYPE(0)="SCT"
 D PROCESS
 Q
 ;
 ;
PROCESS ; Process the message and load file
 ;
 N DIC,DINUM,DO,LRCNT,LRDT,LRFILE,LRI,LRIEN,LRMAILGROUP,LRNOW,LRST,LRSTN,LRVAL,X
 ;
 ;ZEXCEPT: LRHDL,LRNAME,LRTYPE,XMZ
 ;
 S X=$$HTFM^XLFDT($H),LRDT=X\1,LRNOW=X
 S LRFILE=95.4,LRVAL=$$SITE^VASITE,LRST=$P(LRVAL,"^",3),LRSTN=$P(LRVAL,"^",2)
 S $P(LRVAL,"^",4)=$P($$NNT^XUAF4($P(LRVAL,"^")),"^",3)
 ;
 ; Check that mail group has members
 S LRMAILGROUP="LAB MAPPING"
 I '$$GOTLOCAL^XMXAPIG(LRMAILGROUP) D
 . N XQAID,XQAMSG,XQAROU,XQADATA,XQA
 . S LRMAILGROUP="LMI"
 . S XQAMSG="Lab "_LRTYPE(0)_" mapping process: No local members in mail group LAB MAPPING"
 . S XQA("G."_LRMAILGROUP)="",XQAID="LRSRVR-"_$S(LRTYPE=1:"LOINC",LRTYPE=2:"SNOMED CT",1:"UNKNOWN")_"-"_$H
 . D SETUP^XQALERT
 ;
 ; Set lock so only one process runs at a time.
 ; If unable to obtain lock send Kernel alert to notify site that mapping processing unable to start.
 F LRI=1:1:10 L +^XTMP("LABSERVER LOADING"):999 Q:$T
 I '$T D  Q
 . N XQAID,XQAMSG,XQAROU,XQADATA,XQA
 . S XQAMSG="Unable to obtain lock to process "_$S(LRTYPE=1:"LOINC",LRTYPE=2:"SNOMED CT",1:"UNKNOWN")_" mapping from STS"
 . S XQA("G."_LRMAILGROUP)="",XQAID="LRSRVR-"_$S(LRTYPE=1:"LOINC",LRTYPE=2:"SNOMED CT",1:"UNKNOWN")_"-"_XMZ
 . D SETUP^XQALERT
 ;
 D EXTRACT
 ;
 ; Set lock so only one process updates file #95.4 at a time.
 ; If unable to obtain lock send Kernel alert to notify site that mapping processing unable to start.
 F LRI=1:1:10 L +^LAHM(LRFILE,0):999 Q:$T
 I '$T D  Q
 . N XQAID,XQAMSG,XQAROU,XQADATA,XQA
 . S XQAMSG="Unable to obtain lock on file #"_LRFILE_" to process "_$S(LRTYPE=1:"LOINC",LRTYPE=2:"SNOMED CT",1:"UNKNOWN")_" mapping from STS"
 . S XQA("G."_LRMAILGROUP)="",XQAID="LRSRVR-"_$S(LRTYPE=1:"LOINC",LRTYPE=2:"SNOMED CT",1:"UNKNOWN")_"-"_XMZ
 . D SETUP^XQALERT
 ;
 S (LRCNT,LRI)=0
 F  S LRI=$O(^TMP($J,"LRMAP",LRI)) Q:'LRI  D
 . S LRCNT=LRCNT+1
 . I '(LRCNT#100) H 1 ; take a "rest" - allow OS to swap out process
 . D LDFILE
 ;
 ; Release lock
 L -^LAHM(LRFILE,0)
 ;
 ; Save master list of message handles when it arrives in 'last' message
 I $D(^TMP($J,"LRMAP-HDL")) D
 . S ^XTMP("LRMAP-HDL-"_LRTYPE(0),0)=$$HTFM^XLFDT($H+1,1)_"^"_LRDT_"^"_LRNAME
 . M ^XTMP("LRMAP-HDL-"_LRTYPE(0),1)=^TMP($J,"LRMAP-HDL")
 ;
 ; Save this message's handle
 I LRHDL'="" D
 . S ^XTMP("LRMAP-HDL-"_LRTYPE(0),0)=$$HTFM^XLFDT($H+1,1)_"^"_LRDT_"^"_LRNAME
 . S ^XTMP("LRMAP-HDL-"_LRTYPE(0),2,LRHDL)=XMZ
 ;
 ; Check to see if all the messages have arrived and start loading mapping
 I $D(^XTMP("LRMAP-HDL-"_LRTYPE(0),1)),$D(^XTMP("LRMAP-HDL-"_LRTYPE(0),2)) D
 . N I,LROK
 . S I=0,LROK=1
 . F  S I=$O(^XTMP("LRMAP-HDL-"_LRTYPE(0),1,I)) Q:I=""  S I(0)=^XTMP("LRMAP-HDL-"_LRTYPE(0),1,I,0) I '$D(^XTMP("LRMAP-HDL-"_LRTYPE(0),2,I(0))) S LROK=0
 . I LROK D TASKMAP
 ;
 ; Release lock
 L -^XTMP("LABSERVER LOADING")
 ;
 ; Cleanup mail message after serving
 D CLEAN^LRSRVR
 ;
 Q
 ;
 ;
EXTRACT ; Extract data from PackMan global format in MailMan message.
 ;
 N LRDATA,LRGLO,LRSTART,LRTEXT
 ;
 ;ZEXCEPT: LRDT,LRHDL,LRNAME,LRNODE,LRST,XMFROM,XMREC,XMRG,XMZ
 ;
 ; Check if PackMan message.
 I '$$PAKMAN^XMXSEC1(XMZ,"") Q
 ;
 I $D(^XTMP(LRNODE)) K ^XTMP(LRNODE)
 ;
 S ^XTMP(LRNODE,0)=$$HTFM^XLFDT($H+90,1)_"^"_LRDT_"^"_LRNAME
 S ^XTMP(LRNODE,0,1)="Lab Server triggered at "_LRST_" by "_XMFROM_" on "_$$HTE^XLFDT($H)
 ;
 ; Process message looking for global nodes to load.
 S (LRSTART,LRTEXT)=0,LRHDL=""
 F  X XMREC Q:XMER<0  D
 . I $E(XMRG,1,4)="$TXT" S LRTEXT=1 Q
 . I $E(XMRG,1,8)="END $TXT" S LRTEXT=0 Q
 . I $E(XMRG,1,4)="$GLO" S (LRSTART,LRDATA)=1,LRTEXT=0 Q
 . I $E(XMRG,1,8)="END $GLO" S LRSTART=0 Q
 . I LRTEXT D  Q
 . . I $E(XMRG,1,7)="LR-MAP-" S LRHDL=XMRG Q
 . I 'LRSTART Q
 . I LRDATA S LRDATA=0,LRGLO=XMRG Q
 . S LRDATA=1,@LRGLO=XMRG
 ;
 I LRHDL'="" S ^XTMP(LRNODE,0,2)=LRHDL
 ;
 Q
 ;
 ;
LDFILE ; Load/store entries in mapping transport file.
 ;
 ;ZEXCEPT: DA,DIC,DIK,DINUM,DO,LR4,LRFILE,LRI,LRIEN,LRNOW,LRVAL,LRX,X,Y
 ;
 K DIC,DINUM,DO,LRIEN
 S LRI(0)=^TMP($J,"LRMAP",LRI,0)
 S LRX=$P(LRI(0),"^")
 S LR4=$$IEN^XUAF4($P(LRX,"-"))
 I $P(LRVAL,"^",4)="VAMC",LR4'=$P(LRVAL,"^") Q
 ;
 S X=LRX,DIC="^LAHM(LRFILE,",DIC(0)="F"
 D FILE^DICN
 I Y<1 Q
 S LRIEN=+Y
 ;
 ; Merge rest of entry from TMP global
 M ^LAHM(LRFILE,LRIEN,100)=^TMP($J,"LRMAP",LRI,100)
 ;
 S $P(^LAHM(LRFILE,LRIEN,0),"^",2)=LR4
 S $P(^LAHM(LRFILE,LRIEN,0),"^",3)=$P(LRI(0),"^",3)
 S $P(^LAHM(LRFILE,LRIEN,0),"^",4)=0
 S $P(^LAHM(LRFILE,LRIEN,0),"^",6)=LRNOW
 ;
 ; Index entry
 K DA,DIK
 S DIK="^LAHM(LRFILE,",DA=LRIEN
 D IX1^DIK
 ;
 Q
 ;
 ;
TASKMAP ; Task/run applying the mapping to site's lab files
 ;
 N XQAID,XQAMSG,XQAROU,XQADATA,XQA
 ;
 ;ZEXCEPT: LRABORT,LRMAILGROUP,LRTYPE,XMZ
 ;
 ;
 ; Send Kernel alert to notify site that mapping has been triggered.
 S XQAMSG=$S(LRTYPE=1:"LOINC",LRTYPE=2:"SNOMED CT",1:"UNKNOWN")_" mapping has been triggered from STS on "_$$HTE^XLFDT($H,"1M")
 S XQA("G."_LRMAILGROUP)="",XQAID="LRSRVR-"_$S(LRTYPE=1:"LOINC",LRTYPE=2:"SNOMED CT",1:"UNKNOWN")_"-"_+$G(XMZ)
 D SETUP^XQALERT
 ;
 I LRTYPE=1 Q
 ;
 ; Load SNOMED CT codes into lab files
 I LRTYPE=2 D
 . D LD^LRSCTF(+$$SITE^VASITE,0)
 . K ^XTMP("LRMAP-HDL-SCT")
 ;
 ; Send Kernel alert to notify site that mapping has ended.
 K XQAID,XQAMSG,XQAROU,XQADATA,XQA
 S XQAMSG=$S(LRTYPE=1:"LOINC",LRTYPE=2:"SNOMED CT",1:"UNKNOWN")_" mapping has "_$S($G(LRABORT):"ABORTED",1:"completed")_" on "_$$HTE^XLFDT($H,"1M")
 S XQA("G."_LRMAILGROUP)="",XQAID="LRSRVR-"_$S(LRTYPE=1:"LOINC",LRTYPE=2:"SNOMED CT",1:"UNKNOWN")_"-"_+$G(XMZ)
 D SETUP^XQALERT
 ;
 Q
 ;
 ;
PURGE(LRSTAT,LRDATE) ; Purge entries matching status selected.
 ; Call with:
 ;   LRSTAT = record status to purge
 ;   LRDATE = (optional) only purge records with a Status Date <= LRDATE
 ;
 N DA,DIK,LRQUIT,LRROOT,LRSTATDT
 S LRQUIT=0,LRROOT="^LAHM(95.4,""AE"",LRSTAT)",DIK="^LAHM(95.4,"
 F  S LRROOT=$Q(@LRROOT) D  Q:LRQUIT
 . I LRROOT="" S LRQUIT=1 Q
 . I $QS(LRROOT,2)'="AE" S LRQUIT=1 Q
 . I $QS(LRROOT,3)'=LRSTAT S LRQUIT=1 Q
 . S DA=$QS(LRROOT,4)
 . S LRSTATDT=$P($G(^LAHM(95.4,+DA,0)),U,6)
 . I $G(LRDATE),LRSTATDT>$G(LRDATE) Q
 . D ^DIK
 Q
 ;
 ;
PRGNIGHT ; Called from LRNIGHT to purge eligible entries in file 95.4
 ;
 N LRDAYS,LRDATE,LRSTAT
 ;
 S LRDAYS=$$GET^XPAR("SYS^PKG","LR MAPPING PURGE DAYS",1,"Q")
 S LRDATE=$$FMADD^XLFDT(DT,-LRDAYS,0,0,0)
 F LRSTAT=0,.5,.7,1,2 D PURGE(LRSTAT,LRDATE)
 ;
 Q
