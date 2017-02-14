LRVR0 ;DALOI/STAFF - LEDI MI/AP Data Verification ;12/20/16  09:51
 ;;5.2;LAB SERVICE;**350,427,474**;Sep 27, 1994;Build 14
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
 ;
 F  D  Q:$G(LREND)
 . N LRMULTSQ
 . I $G(IOF)'="" W @IOF
 . K C5,DIC,DIR,DIRUT,DTOUT,DUOUT,LRAB,LRDEL,LRDL,LRFP,LRLDT,LRNG,LRNM,LRNOP,LRSET,LRTEST,LRVER,T,X,Y,Z
 . S X=DUZ D DUZ^LRX S LRTEC=LRUSI
 . D WLN^LRVRA I $G(LRNOP) D NEXT^LRVRA Q
 . ;
 . F  Q:$G(LRNOP)  D
 . . N LRSEQCNT
 . . D ISQN
 . . I $G(LRSEQCNT)>1 S LRMULTSQ=1
 . . I $G(LRNOP) Q
 . . D ACCSET
 . . I $G(LRNOP) Q
 . . I "SPCYEM"[LRSS D ^LRVRAP4
 . . I LRSS="MI" D PROC,ACCEPT
 . . I $G(LRNOP) Q
 . . I $G(LRSEQCNT)<2 S LRNOP=1 Q
 . . I $G(IOF)'="" W @IOF
 . . W !,PNM,?30,SSN,"  Age: ",AGE(2)
 . . W !,"ORDER #: ",LRCEN,"    ",LRACC,"    ["_LRUID,"]"
 . . W !
 . . S (ISQN,LRISQN)=0
 . ;
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
 . N LRMULTSQ
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
 . ;
 . F  Q:$G(LRNOP)  D
 . . N LRSEQCNT
 . . D ISQN
 . . I $G(LRSEQCNT)>1 S LRMULTSQ=1
 . . I $G(LRNOP) Q
 . . D ACCSET
 . . S LRTM60=$$LRTM60^LRVR(LRCDT)
 . . I $G(LRNOP) Q
 . . I "SPCYEM"[LRSS D ^LRVRAP4
 . . I LRSS="MI" D PROC,ACCEPT
 . . I $G(LRNOP) Q
 . . I $G(LRSEQCNT)<2 S LRNOP=1 Q
 . . I $G(IOF)'="" W @IOF
 . . S (ISQN,LRISQN)=0
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
 N LRBATCH,LREDITTYPE,LRMODE,LRNPTP
 I $G(LREND) S LREND=0 Q
 ;
 S LRMODE="LDSI",LRBATCH=1,LREDITTYPE=1
 D DQ^LRMIPSZ1
 ;
 ;
 N DIR,DIROUT,DIRUT,DUOUT
 I LRINTYPE=1 D
 . S DIR(0)="SAO^0:Quit;1:Release;2:Comments/Release;3:Edit (full)"
 . S DIR("A")="Select RELEASE action: "
 . S DIR("B")=$$GET^XPAR("USR^PKG","LR MI UI RELEASE DEFAULT","`"_+LRLL,"E")
 . I DIR("B")="" S DIR("B")="Edit (full)"
 . S DIR("?")="Selections 1-3 will allow editing of status and approved date/time."
 . S DIR("?",1)="Entering 0 will abort review/release."
 . S DIR("?",2)="Entering 1 will allow release 'as is' with no editing."
 . S DIR("?",3)="Entering 2 will allow you to enter/edit comments then release."
 . S DIR("?",4)="Entering 3 will allow you to enter full edit, similar to 'Results entry' option."
 ;
 E  D
 . S DIR(0)="Y"
 . S DIR("A")="Do you want to APPROVE these results",DIR("B")="NO"
 . S DIR("?")="Enter Y if you want to approve these results"
 . S DIR("?",1)="Entering Y will store the results in the Lab System"
 ;
 D ^DIR
 S LREDITTYPE=+Y
 I $D(DIRUT) S LRNOP=1 Q
 I Y=0 D PURG Q
 I Y<1 S LRNOP=1 Q
 ;
 ; If user just accepting or doing comments then ask for tests.
 I LREDITTYPE<3 D
 . D EC^LRMIEDZ4
 . S LRTS=LRTS(LRI)
 ;
 D EN^LRVRMI4
 ;
 ; If Lab UI interface then allow editing remarks (#13), status (#11.5) and approved date/time (#11)
 I LRINTYPE=1,LREDITTYPE<3 D
 . N DA,DIE,DR
 . S DA=LRIDT,DA(1)=LRDFN,DIE="^LR(LRDFN,""MI"","
 . S DR=$S(LREDITTYPE=2:"13;",1:"")_"11.5;11"
 . D ^DIE
 ;
 ; If Lab UI interface and user wants to do full editing
 I LRINTYPE=1,LREDITTYPE=3 D
 . N LRANOK,LRLEDI,LRCAPO,LRUNDO
 . S (LRCAPOK,LRANOK)=1,LRUNDO=0
 . D AUDRTN^LRMIEDZ2
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
 N DIR,DIROUT,DIRUT,DUOUT
 S DIR(0)="Y",DIR("A")="Do you want to PURGE these results",DIR("B")="NO"
 S DIR("?",1)="Enter NO if you want to process these results at a later time"
 S DIR("?")="Enter YES to remove these results from the list"
 D ^DIR
 I $D(DIRUT) S LRNOP=1 Q
 I Y=1 D ZAP
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
 N LRI,LRSQ
 S (LRI,LRSEQCNT)=0
 F  S LRI=$O(^LAH(LRLL,1,"C",LRAN,LRI)) Q:LRI<1  D
 . N LRX
 . S LRX=$G(^LAH(LRLL,1,LRI,0))
 . ; Quit if different accession area.
 . I $P(LRX,"^",3),$P(LRX,"^",3)'=LRAA Q
 . ; Quit if different accession date and not a rollover accession (same original accession date).
 . I $P(LRX,"^",4),$P(LRX,"^",4)'=LRAD,$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,0)),"^",3)'=$P($G(^LRO(68,LRAA,1,$P(LRX,"^",4),1,LRAN,0)),"^",3) Q
 . I LRSEQCNT W !
 . S LRSEQCNT=LRSEQCNT+1,LRSQ=LRI,LRSQ(LRI)=""
 . W !,?2,"Seq #: ",LRI,?13," Accession: ",$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2)),"^")
 . I $P(LRX,"^",10) W ?40," Results received: ",$$FMTE^XLFDT($P(LRX,"^",10),"1M")
 . W !,?20,"UID: ",$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3),"UNKNOWN"),"^")
 . I $P(LRX,"^",11) W ?44," Last updated: ",$$FMTE^XLFDT($P(LRX,"^",11),"1M")
 . I $G(^LAH(LRLL,1,LRI,.1,"OBR","ORDNLT"))'="" D
 . . N LR64,LRNLT,LRNLTN,LRPIECE
 . . W !,?13," Order NLT: "
 . . F LRPIECE=1:1 S LRNLT=$P($G(^LAH(LRLL,1,LRI,.1,"OBR","ORDNLT")),"^",LRPIECE) Q:LRNLT=""  D
 . . . S LR64=+$O(^LAM("E",LRNLT,0))
 . . . S LRNLTN=$$GET1^DIQ(64,LR64_",",.01)
 . . . W ?25,$S(LRNLTN'="":LRNLTN,1:LRNLT),!
 ;
 I LRSEQCNT=0 W !,"No data for that accession" S LRNOP=1 Q
 I LRSEQCNT=1,'$G(LRMULTSQ) S (ISQN,LRISQN)=LRSQ Q
 ;
 ; If multiple entries (sequence - overlay data=no) then ask user which one to use.
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT
 S DIR(0)=""
 S I=0 F  S I=$O(LRSQ(I)) Q:'I  S DIR(0)=DIR(0)_$S(I=1:"",1:";")_I_":Seq #"_I
 S DIR(0)="SO^"_DIR(0),DIR("A")="Choose sequence number"
 I LRSEQCNT=1,$G(LRMULTSQ) S DIR("B")=LRSQ
 D ^DIR
 I $D(DIRUT)!(Y<1) S LRNOP=1 Q
 S (ISQN,LRISQN)=+Y Q
 Q
