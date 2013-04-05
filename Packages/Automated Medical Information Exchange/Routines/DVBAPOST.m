DVBAPOST ;ALBANY-ISC/GTS-AMIE 2.6 POST-INIT RTN ;1/15/93
 ;;2.7;AMIE;;Apr 10, 1995
 ;
EN D SET1^DVBAUTL1
 K ^TMP("DVBA",$J)
 W !,"Setting up List Manager Templates",!
 D ^DVBAL ;set up templates used by List Manager screens
 D ^DVBAONIT ;calls the onits to set up the List Manager screens/actions
 D REINDAC^DVBAPST1
 D REINDAF^DVBAPST1
 D REINDAE^DVBAPST1
EN12 D ^DVBAPOPU ;populates various global information
EN14 D ^DVBAPOP2 ;populates the pointer field of 396.6
EN11 D EN^DVBAPADD ;adds new disability conditions
EN10 D ^DVBAORPH ;adds orphan exams.
EN1 K STOP
 D CHECK ; checks if pre init ran ok.
 I $D(STOP) D SE G MAIL ;stops if pre init did not run ok.
EN2 D EN^DVBAPLNG ;updates the long description of file 31.
EN3 K STOP
 D EN^DVBAPLL ;updates the local lookup file with file 31.
 I $D(STOP) D SE1 G MAIL ;stops if problems adding to Local Lookup file.
 D ORPHAN^DVBAPCXR
EN4 ;;;D EN^DVBAPSHT ;enters the short cuts into the MTLU files. (DVBAPH1-99)
EN5 D EN^DVBAPKY ;enters the keywords into the MTLU files. (DVBAPK1-99)
EN13 D EN^DVBAPOKY ;enters the orphan keywords into the MTLU files. (DVBAPOK1)
EN6 D EN^DVBAPSYN ;enters the synonyms into the MTLU files. (DVBAPS1-99)
EN7 D EN^DVBAPBDY ;enters the disability codes into the body system file. (DVBAPB1-99)
EN8 D EN^DVBAPWKS ;enters the disability codes into the AMIE worksheets. (DVBAPW1-99)
 D FINISHED ;prints out a completed message
MAIL S V3=$$MAL($J) ;builds and sends the mail message from the post init running
 D EXIT^DVBAUTL1
 Q
 ;
FINISHED ;
 N VAR
 S VAR="The Post-Init has completed."
 W *7,!!!,VAR
 D BUMP(VAR)
 Q
 ;
CHECK ;checks for the 'post' node to see if the pre init ran ok.
 I '$D(^DVB(396.1,1,"POST")) S STOP=1 Q
 I ^DVB(396.1,1,"POST")']"" S STOP=1 Q
 Q
MAL(V2) ;builds a mail message and sends to the DUZ defined.  v2 must be the
 ;$J from the job of the post init.
 ;
 N LNE,LNCNT
 S XMDUZ="AMIE POST INIT"
 S XMSUB="AMIE v2.7 install results"
 D XMZ^XMA2 ;** Get message number
 I XMZ'>0 DO
 .W !!,"Mail Message containing Error Log has failed!",!
 .W "Errors contained in ^TMP(""DVBA"","_V2_") global.",!
 .W "Investigate this global to determine any existing problems."
 .W !!
 I XMZ>0 DO
 .F LNE=0:0 S LNE=$O(^TMP("DVBA",V2,LNE)) Q:'LNE  DO
 ..S ^XMB(3.9,XMZ,2,LNE,0)=(^TMP("DVBA",V2,LNE)),LNCNT=LNE
 .S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LNCNT_"^"_LNCNT_"^"_DT
 .K XMDUN
 .S (XMY(DUZ),XMY(.5))=""
 .D ENT1^XMD
 .W !!,"Mail message containing Error Log has been sent.",!
 .W "Check your mail to see this log.",!!
 .K ^TMP("DVBA",V2)
 Q 1
 ;
SET ;set necessary local variables
 S CNT=1
 Q
 ;
SE S VAR="The pre-init found a problem in the version of MTLU and KERNEL."
 W !!,VAR D BUMPBLK,BUMP(VAR)
 S VAR="Please review and correct.  See install guide for further details."
 W !,VAR D BUMP(VAR)
 S VAR="No updates have occurred to the following files:"
 W !,VAR D BUMP(VAR)
 S VAR="      Local Lookup"
 W !,VAR D BUMP(VAR)
 S VAR="      Local keyword"
 W !,VAR D BUMP(VAR)
 S VAR="      Local Synonym"
 W !,VAR D BUMP(VAR)
 ;;;S VAR="      Local Shortcut"
 ;;;W !,VAR D BUMP(VAR)
 S VAR="      2507 Body System"
 W !,VAR D BUMP(VAR)
 S VAR="      AMIE Exam file."
 W !,VAR D BUMP(VAR)
 S VAR="      Long Descriptions of the Disability Condition file."
 W !,VAR D BUMP(VAR)
 Q
 ;
SE1 ;
 S VAR="The post init could not add to the Local Lookup file."
 W !!,VAR D BUMPBLK,BUMP(VAR)
 S VAR="No updates have occurred to the following files:"
 W !,VAR D BUMP(VAR)
 S VAR="      Local keyword"
 W !,VAR D BUMP(VAR)
 S VAR="      Local Synonym"
 W !,VAR D BUMP(VAR)
 S VAR="      Local Shortcut"
 W !,VAR D BUMP(VAR)
 S VAR="      2507 Body System"
 W !,VAR D BUMP(VAR)
 S VAR="      AMIE Exam file."
 W !,VAR D BUMP(VAR)
 Q
 ;
BUMP(V1) ;adds the entry and bumps the general counter.
 S ^TMP("DVBA",$J,CNT)=V1
 S CNT=CNT+1
 Q
 ;
BUMPBLK ;adds a blank line to the array
 S ^TMP("DVBA",$J,CNT)=""
 S CNT=CNT+1
 Q
 ;
OPEN F LP3=1:1 S LP4=$T(OPT+LP3) Q:LP4'[";;"  S LP4=$P(LP4,";;",2) DO
 .S DIC="^DIC(19,",DIC(0)="MZ",X=LP4
 .D ^DIC
 .K DIC
 .I Y<0 D ERR Q
 .I Y>0 DO
 ..S DIE="^DIC(19,",DIC(0)="MZ",DA=+Y,DR="2///@"
 ..D ^DIE
 ..W !,LP4," Now in order!"
 ..K DIE,DIC,VAR,DR
 ..Q
 .K Y
 .Q
 K DIC,DIE,X,Y,DA,DR
 S DIC="^ORD(101,",DIC(0)="MZ",X="DVBA C&P SCHD EVENT"
 D ^DIC
 K DIC
 I Y<0 D ERR
 I Y>0 DO
 .S DIE="^ORD(101,",DIC(0)="MZ",DA=+Y,DR="2///@"
 .D ^DIE
 .W !,"DVBA C&P SCHD EVENT Now in order!"
 K DIC,DIE,X,Y,LP3,LP4,DA,DR
 Q
 ;
ERR ;
 W "Could not find menu option ",X," NOT opened!"
 Q
 ;
OPT ;
 ;;DVBA MEDICAL ADM 7131 MENU
 ;;DVBA REGIONAL OFFICE MENU
 ;;DVBA C PROCESS MAIL MESSAGE
 ;;DVBA C PHYSICIANS GUIDE
 ;
