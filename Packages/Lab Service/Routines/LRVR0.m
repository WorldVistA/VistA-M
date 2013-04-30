LRVR0 ;DALOI/STAFF - LEDI MI/AP Data Verification ;03/24/11  15:17
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ; LEDI MI/AP Auto-instrument verification
 ; Called from LRVR
 Q
 ;
 ;
EN ;
 N EAMODE,LA7X,LRANYAA,LRAO,LRBG0,LRCFL,LRCMNT,LRDINST,LREND,LRFIFO,LRFLAG,LRINTYPE,LRLEDI,LRLLT,LRMIDEF,LRMIOTH
 N LRNOP,LRONESPC,LRONETST,LRPG,LRPTP,LRSAME,LRSB,LRSS,LRTM60,LRTX,LRUID,LRWRDVEW,LRX,X,Y
 ;
 S LRSS=$P($G(^LRO(68,+$G(LRAA),0)),U,2) Q:LRSS=""
 I LRSS'?1(1"MI",1"SP",1"CY",1"EM") Q
 ;
 S LRDINST=+$$KSP^XUPARAM("INST")
 S LRLEDI=1,LRCFL="",EAMODE=1,LRWRDVEW=1
 S LRX=$S(+$P($G(^LAB(69.9,1,0)),U,7):+$P(^(0),U,7),1:1)
 S LRANYAA=+$P($G(^LRO(68.2,LRLL,10,LRPROF,0)),"^",3)
 I $G(LRVBY)=1 D ACC
 I $G(LRVBY)=2 S LRUID="" D UID
 D CLEAN
 Q
 ;
 ;
UID ;UID driven look-up
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 F  D  Q:$G(LREND)
 . I $G(IOF)'="" W @IOF
 . K C5,DIC,DIR,DIRUT,DTOUT,DUOUT,LRAB,LRDEL,LRDL,LRFP,LRLDT,LRNG,LRNM,LRNOP,LRSET,LRTEST,LRVER,T,X,Y,Z
 . S X=DUZ D DUZ^LRX S LRTEC=LRUSI
 . D WLN^LRVRA I $G(LRNOP) D NEXT^LRVRA Q
 . S LRISQN=$O(^LAH(LRLL,1,"U",LRUID,0))
 . I 'LRISQN D NEXT^LRVRA Q
 . I '($D(^LAH(LRLL,1,LRISQN,0))#2) D ERR1,NEXT^LRVRA Q
 . S LRX=$G(^LAH(LRLL,1,LRISQN,0))
 . W !,?2,"Seq #: ",LRISQN,?13," Accession: ",$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2)),"^")
 . I $P(LRX,"^",10) W ?40," Results received: ",$$FMTE^XLFDT($P(LRX,"^",10),"1M")
 . W !,?20,"UID: ",$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3),"UNKNOWN"),"^")
 . I $P(LRX,"^",11) W ?44," Last updated: ",$$FMTE^XLFDT($P(LRX,"^",11),"1M")
 . D ACCSET
 . I $G(LRNOP) D UNLOCK Q
 . I "SPCYEM"[LRSS D ^LRVRAP4
 . I LRSS="MI" D PROC,ACCEPT
 . D UNLOCK,NEXT^LRVRA
 D CLEAN
 Q
 ;
 ;
ERR1 ;Look-up Error
 W !,"No data for "_LRUID_" in file"
 Q
 ;
 ;
CLEAN ;
 ;
 ; Task of background jobs for workload and HL7 message processing
 D ^LRCAPV2
 ;
 K ^TMP("LRMI",$J)
 K AGE,DFN,I,LRACC,LRCDT,DIRUT
 K LRCEN,LRDFN,LRDPF,LRNOP,LRLOCK,LRPUID,LRISQN,LRODT,LROU3,LRPROF
 K LRSN,LRSTATUS,LRTEC,LRUSI,LRVBY,PNM,SSN,X,Y
 K ZTRTN,ZTIO,ZTDTH,ZTDESC
 D ^LRVRKIL
 Q
 ;
 ;
ACC ; Accession number look-up
 D ADATE^LRWU
 I LRAD<1 S LRNOP=1 Q
 S LRAN=0
 F  D  Q:$G(LRDBUG,$G(LREND))
 . I $G(IOF)'="" W @IOF
 . K DIR,DIC,Y,LRNOP
 . S LRAN=$O(^LAH(LRLL,1,"C",LRAN)) I 'LRAN D ACCMSG Q
 . S Y=LRAN
 . S LRISQN=$O(^LAH(LRLL,1,"C",LRAN,0)) I 'LRISQN D ACCMSG Q
 . I '$O(^LAH(LRLL,1,LRISQN,0)) D ACCMSG Q
 . S DIR(0)="FO^1:10",DIR("A")="Enter Accession number part",DIR("?")="^D LW^LRVR"
 . S DIR("S")="I $O(^LAH(LRLL,1,""C"","_Y_",0)"
 . I $G(LRAN) S DIR("B")=LRAN
 . D ^DIR
 . I $D(DIRUT) D STOP^LRVR S LRNOP=1 Q
 . S LRAN=+Y I Y<1 D ACCMSG Q
 . D ISQN I $G(LRNOP) Q
 . D ACCSET
 . S LRTM60=$$LRTM60^LRVR(LRCDT)
 . I $G(LRNOP) D UNLOCK Q
 . I "SPCYEM"[LRSS D ^LRVRAP4
 . I LRSS="MI" D PROC,ACCEPT
 . D UNLOCK
 ;
 D CLEAN
 Q
 ;
 ;
ACCMSG ;
 W !,"  No accession available for this Load/Worklist",!
 D STOP^LRVR S LRNOP=1
 Q
 ;
 ;
PROC ;Process the entry from LAH(LRLL
 Q:$$LEDIERR^LRVRMI0(LRLL,LRISQN,0,1)
 ;
 ; Set MI specific variables
 S LRBG0=^LR(LRDFN,"MI",LRIDT,0),LRSSC=$P(LRBG0,U,5)_U_$P(LRBG0,U,11),LRFIFO=1
 ;
 D EN^LRVRMI1
 Q
 ;
 ;
ACCSET ;Set up accession variables
 N DA,DIC,DIR,DIRUT,DTOUT,DUOUT,LRCNT,LRLAHD,LRI,LRNODE
 K LRERR
 S (LRLOCK,LRNOP)=0,LRLAHD=$G(^LAH(LRLL,1,LRISQN,0))
 I LRLAHD="" D  Q
 . W !,"^LAH("_LRLL_",1,"_LRISQN_",0)  Global is corrupt"
 . D ZAP S LRNOP=1
 ;
 S LRAA=$P(LRLAHD,U,3)
 I $P(^LRO(68,LRAA,0),U,2)'=LRSS  W !,"Not a "_LRSS_" Area - Abort",! S LRNOP=1 Q
 S LRAN=$P(LRLAHD,U,5),LRAD=$P(LRLAHD,U,4)
 ;
 I LRAA=""!(LRAD="")!(LRAN="") D  Q
 . W !,"^LAH("_LRLL_",1,"_LRISQN_",0)  Global is corrupt"
 . D ZAP S LRNOP=1
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) D  Q
 . W !,"Accession does not exist in ACCESSION file (#68)"
 . D ZAP S LRNOP=1
 ;
 S LRDFN=+^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRCEN=$S($D(^(.1)):^(.1),1:0)
 S LRACC=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2)),LRCDT=$P($G(^(3)),U)
 S LRODT=$S($P(^(0),U,4):$P(^(0),U,4),1:$P(^(0),U,3)),LRSN=$P(^(0),U,5)
 S LRORU3=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),LRIDT=$P(^(3),U,5)
 S LRUID=$P(LRORU3,U),LRTS=""
 ;
 S LRI=0
 F  S LRI=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI)) Q:LRI<1!$G(LRTS)  S LRNODE=^(LRI,0) I $P(LRNODE,U,2)<50 S LRTS=+LRNODE
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 D PT^LRX
 ;
 ; Patient info displayed during UID lookup - display here when lookup by accession number
 I $G(LRVBY)'=2 D
 . W !,PNM,?30,SSN,"  Age: ",AGE(2)
 . W !,"ORDER #: ",LRCEN,"    ",LRACC,"    ["_LRUID,"]"
 ;
 I $$GET^XPAR("USR^DIV^PKG","LR MI VERIFY DISPLAY PROVIDER",1,"Q") D PROV^LRMIEDZ2
 ;
 S DIR(0)="E"
 D ^DIR
 I $D(DIRUT) S LRNOP=1 Q
 ;
 K LRERR
 S X=$$GETLOCK^LRUTIL("^LR(LRDFN,LRSS,LRIDT)",10,1)
 I 'X S LRERR=1 D NOLOCK Q
 S X=$$GETLOCK^LRUTIL("^LRO(68,LRAA,1,LRAD,1,LRAN)",10,1)
 I 'X S LRERR=2 D NOLOCK Q
 ;
 S LRLOCK=1
 I '$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),"^",3) D
 . N LRAA,LRAD,LRAN
 . S LRSTATUS="C" D P15^LROE1
 . I LRCDT<1 S LRNOP=1
 ;
 I '$G(LRNOP),$P($G(^LRO(69,LRODT,1,LRSN,1)),U,4)'="C" D
 . W !,"You cannot verify an accession which has not been collected.",$C(7)
 . S LRNOP=1
 ;
 ; Determine if one or more tests on accession.
 S (LRI,LRCNT,LRPTP)=0
 F  S LRI=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI)) Q:'LRI  D
 . I $P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI,0),"^",2)<50 S LRCNT=LRCNT+1,LRPTP=LRI
 ;
 ; If more than one test on accession then select the test to work with (URGENCY<50 - non-workload tests).
 I LRCNT>1 D
 . K DA,DIC
 . S DIC="^LRO(68,LRAA,1,LRAD,1,LRAN,4,",DIC(0)="AEMOQ",DIC("A")="Select TEST/PROCEDURE: ",DIC("S")="I $P(^(0),U,2)<50"
 . S DA(2)=LRAA,DA(1)=LRAD,DA=LRAN,LRPTP=0
 . D ^DIC
 . I Y<1 S LRNOP=1 Q
 . S LRPTP=+Y
 ;
 I $G(LRNOP) Q
 ;
 S LRMIDEF=$P(^LAB(69.9,1,1),U,10),LRMIOTH=$P(^(1),U,11)
 ;
 ; Set interface type
 S LRINTYPE=$P(^LAH(LRLL,1,LRISQN,0),"^",12)
 ;
 Q
 ;
 ;
NOLOCK ; Not able to lock message
 W !!,$S($G(LRERR)=1:" **Accession** ",$G(LRERR)=2:"**Patient's ^LR( file**",1:"Record")_" is locked by another user. " H 5
 S LRNOP=1
 Q
 ;
 ;
UNLOCK ; Unlock accession and ^LR( global
 Q:'$G(LRLOCK)
 L -^LRO(68,$G(LRAA),1,$G(LRAD),1,$G(LRAN))
 L -^LR($G(LRDFN),$G(LRSS),$G(LRIDT))
 Q
 ;
 ;
ACCEPT ;Display results and accept data
 N LRBATCH,LRMODE,LRNPTP
 I $G(LREND) S LREND=0 Q
 ;
 S LRMODE="LDSI",LRBATCH=1
 D DQ^LRMIPSZ1
 ;
 D EC^LRMIEDZ4
 S LRTS=LRTS(LRI)
 ;
 K DIR
 S DIR(0)="Y",DIR("A")="Do you want to APPROVE these results",DIR("B")="NO"
 S DIR("?")="Enter Y if you want to approve these results"
 S DIR("?",1)="Entering Y will store the results in the Lab System"
 D ^DIR
 I $D(DIRUT) S LRNOP=1 Q
 I Y=0 D PURG Q
 I Y<1 S LRNOP=1 Q
 ;
 D EN^LRVRMI4
 ;
 ; Store performing lab info
 I $D(^TMP("LRPL",$J)) D ROLLUPPL^LRRPLUA(LRDFN,LRSS,LRIDT)
 ;
 ; Ask for performing laboratory assignment
 W !! D EDIT^LRRPLU(LRDFN,"MI",LRIDT)
 ;
 ; Store reporting lab
 D SETRL^LRVERA(LRDFN,LRSS,LRIDT,DUZ(2))
 ;
 ; Update clinical reminders
 D UPDATE^LRPXRM(LRDFN,"MI",LRIDT)
 ;
 ; Ask to send CPRS alert
 D ASKXQA^LRMIEDZ2
 ;
 ; Update accession and order
 D EC3^LRMIEDZ2
 ;
 ; Queue results if LEDI and cleanup
 D LEDI,ZAP
 K ^TMP("LRMI",$J)
 ;
 Q
 ;
 ;
PURG ; Ask if the entry should be purged from ^LAH(
 W !
 N DIR
 S DIR(0)="Y",DIR("A")="Do you want to PURGE these results",DIR("B")="NO"
 S DIR("?",1)="Enter NO if you want to process these results at a later time"
 S DIR("?")="Enter YES to remove these results from the list"
 D ^DIR
 I $D(DIRUT) S LRNOP=1 Q
 I Y=1 D ZAP S LRNOP=1
 Q
 ;
 ;
ZAP ; Remove entry from ^LAH( global
 N REC
 S REC=$S($G(ISQN):ISQN,1:$G(LRISQN))
 I LRLL,REC D ZAPALL^LRVR3(LRLL,REC)
 Q
 ;
 ;
SETACC ;
 N LRFILE,LRIENS,LRFDA,LRERR
 S LRFILE=68.04,LRERR=""
 S LRIENS=LRTS_","_LRAN_","_LRAD_","_LRAA_","
 S LRFDA(1,LRFILE,LRIENS,3)=DUZ
 S LRFDA(1,LRFILE,LRIENS,4)=$$NOW^XLFDT
 S LRFDA(1,LRFILE,LRIENS,8)=$G(LRCDEF)
 D FILE^DIE("KS","LRFDA(1)","LRERR")
 Q
 ;
 ;
LEDI ; If LEDI put results in queue to return to collecting lab
 ; Called from above, LRMIEDZ2, LRMISTF1 and LRVRAP4.
 N IEN,LRCDEFX,LRERR,LRIDT,LRORDT,LRORU3,LRSS,LRTSDEF
 Q:'$D(^LRO(68,+$G(LRAA),1,+$G(LRAD),1,+$G(LRAN),0))
 ;
 S LRORU3=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3))
 Q:'$P(LRORU3,U,3)
 ;
 S LRODT=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,4)
 S LRSS=$P(^LRO(68,LRAA,0),U,2)
 S LRIDT=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U,5)
 I '$$OK2SEND^LA7SRR D LEDINO Q
 ;
 I '$G(LRCDEF) N LRCDEF I "SPEMCY"[LRSS S LRCDEF=3241,LRCDEFX=1
 I '$G(LRTS) N LRTS D
 . S IEN=0
 . F  S IEN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,IEN)) Q:IEN<1  D  Q:$G(LRTS)
 . . I $P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,IEN,0)),U,2)<50 S LRTS=IEN,LRTSDEF=1
 I $G(LRTS) D SETACC
 ;
 ; Comment out the following line after testing is complete
 W !!,$$CJ^XLFSTR("Sending report to LEDI collecting site",IOM)
 D MIAP^LA7VMSG(LRAA,LRAD,LRAN,+$G(LRTS),LRDFN,LRSS,LRIDT,LRODT)
 Q
 ;
 ;
LEDINO ; LEDI HL7 message sending error message
 W !!,$$CJ^XLFSTR("Unable to sent report to LEDI collecting site - no date report approved",IOM)
 Q
 ;
 ;
ISQN ; Find the entry associated with this accession area and accession number
 N LRI,LRN,LRSQ
 S (LRI,LRN)=0
 F  S LRI=$O(^LAH(LRLL,1,"C",LRAN,LRI)) Q:LRI<1  D
 . N LRX
 . S LRX=$G(^LAH(LRLL,1,LRI,0))
 . ; Quit if different accession area.
 . I $P(LRX,"^",3),$P(LRX,"^",3)'=LRAA Q
 . ; Quit if different accession date and not a rollover accession (same original accession date).
 . I $P(LRX,"^",4),$P(LRX,"^",4)'=LRAD,$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,0)),"^",3)'=$P($G(^LRO(68,LRAA,1,$P(LRX,"^",4),1,LRAN,0)),"^",3) Q
 . I LRN W !
 . S LRN=LRN+1,LRSQ(LRN)=LRI
 . W !,?2,"Seq #: ",LRI,?13," Accession: ",$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2)),"^")
 . I $P(LRX,"^",10) W ?40," Results received: ",$$FMTE^XLFDT($P(LRX,"^",10),"1M")
 . W !,?20,"UID: ",$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3),"UNKNOWN"),"^")
 . I $P(LRX,"^",11) W ?44," Last updated: ",$$FMTE^XLFDT($P(LRX,"^",11),"1M")
 ;
 I LRN=0 W !,"No data for that accession" S LRNOP=1 Q
 I LRN=1 S (ISQN,LRISQN)=LRSQ(LRN) Q
 ;
 ; If multiple entries (sequence - overlay data=no) then ask user which one to use.
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT
 S DIR(0)=""
 F I=1:1:LRN S DIR(0)=DIR(0)_$S(I=1:"",1:";")_I_":Seq #"_LRSQ(I)
 S DIR(0)="SO^"_DIR(0),DIR("A")="Choose sequence number"
 D ^DIR
 I $D(DIRUT) S LRNOP=1 Q
 S (ISQN,LRISQN)=+Y Q
 Q
