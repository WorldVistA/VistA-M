LA7CHKF ;DALOI/JMC - Check Lab Messaging File Integrity ;11/16/11  10:49
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,46,74**;Sep 27, 1994;Build 229
 ;
 ;This routine checks file integrity for Lab Messaging.
EN ; Run an integrity check
 ;
 ;ZEXCEPT: ION,POP
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 N LA7CHKBX,LA7FIX,LA7ION,LA7LOG,LA7QUIT
 ;
 S (LA7CHKBX,LA7LOG)=1
 S DIR(0)="SO^1:Check File Integrity;2:Fix File Entries"
 S DIR("A")="Select Option",DIR("B")=1
 D ^DIR
 I $D(DIRUT) Q
 I Y=1 S LA7FIX=0
 I Y=2 S LA7FIX=1
 ;
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("A")="Print Report",DIR("B")="YES",DIR("?")="Enter 'YES' to print the integrity report."
 D ^DIR
 I $D(DIRUT) Q
 I Y=1 D
 . N %ZIS
 . S %ZIS="NQ0",%ZIS("A")="Select Device: ",%ZIS("B")=""
 . D ^%ZIS
 . I POP S LA7QUIT=1
 . S LA7ION=ION
 I $G(LA7QUIT) D HOME^%ZIS Q
 ;
 S ZTRTN="DQ^LA7CHKF",ZTDESC="Lab Messaging File Integrity Checker"
 S ZTSAVE("LA7*")="",ZTIO=""
 D ^%ZTLOAD,HOME^%ZIS
 W !,"Request ",$S($G(ZTSK):"",1:"NOT "),"Queued"
 Q
 ;
 ;
DQ ; Entry point from taskman
 ;
 ;ZEXCEPT: LA7CHKBX,LA7FIX,LA7ION,LA7LOG,ZTQUEUED,ZTREQ
 ;
 N LA7ECNT,LA7IC,LA7XQA
 ;
 D INIT,IC,CHECKMG
 ;
 I LA7LOG D
 . S $P(^XTMP(LA7IC,0),"^",5)=$$NOW^XLFDT ; End date/time
 . L -^XTMP(LA7IC) ; Release lock
 ;
 I LA7ECNT D
 . N XQA,XQAID,XQADATA,XQAMSG,XQAOPT,XQAROU
 . S XQAMSG="Lab Messaging -Warning- "_LA7ECNT_" errors found in File #62.49, LA7 MESSAGE QUEUE."
 . I LA7LOG S XQADATA=LA7IC,XQAROU="DISIC^LA7UXQA"
 . S XQAID="LA7ERR-"_$TR(LA7IC,"^",":")
 . I $G(DUZ)>.9 S XQA(DUZ)=""
 . M XQA=LA7XQA
 . D SETUP^XQALERT
 ;
 ; Run check on certain files "B" index if first of the month or tasked by user.
 I $G(LA7CHKBX)="" S LA7CHKBX=$S($E(DT,6,7)="01":1,1:0)
 I LA7CHKBX D CHKBX
 K LA7CHKBX
 ;
 ; Task print of integrity report
 I $G(LA7ION)'="" D
 . N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 . S ZTRTN="DQ^LA7CHKFP",ZTDTH=$H,ZTSAVE("LA7IC")="",ZTIO=LA7ION
 . S ZTDESC="Print LA7 File Integrity Report"
 . D ^%ZTLOAD
 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
 ;
IC ; File 62.49 Integrity checker and fix-er-upper.
 ;
 ; Check that all the cross-references have entries
 ;
 ;ZEXCEPT: LA7ECNT,LA7FIX,LA7IC,LA7LOG,LA7TCNT
 ;
 N LA7CFG,LA7DA,LA7DAT,LA7INAME,LA7Q,LA7ROOT,X,Y
 ;
 ; Check the "AD" cross-reference
 S LA7ROOT="^LAHM(62.49,""AD"")"
 F  S LA7ROOT=$Q(LA7ROOT) Q:LA7ROOT=""  Q:$QS(LA7ROOT,1)'=62.49!($QS(LA7ROOT,2)'="AD")  D
 . S LA7DAT=$QS(LA7ROOT,3),LA7DA=$QS(LA7ROOT,4)
 . I '$$LOCK(LA7DA) Q
 . I LA7DAT'=$P($P($G(^LAHM(62.49,LA7DA,0)),"^",5),".") D
 . . I LA7FIX K @LA7ROOT
 . . I LA7LOG D LOG("Bad ""AD"" cross-reference of "_LA7ROOT_" for entry "_LA7DA)
 . D UNLOCK(LA7DA)
 ;
 ; Check the "B" cross-reference
 S LA7ROOT="^LAHM(62.49,""B"")"
 F  S LA7ROOT=$Q(@LA7ROOT) Q:LA7ROOT=""  Q:$QS(LA7ROOT,1)'=62.49!($QS(LA7ROOT,2)'="B")  D
 . S LA7DA=$QS(LA7ROOT,4)
 . I '$$LOCK(LA7DA) Q
 . I LA7DA'=$QS(LA7ROOT,3) D
 . . I LA7FIX K @LA7ROOT
 . . I LA7LOG D LOG("""B"" cross-reference "_LA7ROOT_" points to incorrect entry "_$QS(LA7ROOT,4))
 . I '$D(^LAHM(62.49,LA7DA,0)) D
 . . I LA7FIX K @LA7ROOT
 . . I LA7LOG D LOG("""B"" cross-reference "_LA7ROOT_" points to missing entry "_LA7DA)
 . D UNLOCK(LA7DA)
 ;
 ; Check the "C" cross-reference
 S LA7ROOT="^LAHM(62.49,""C"")"
 F  S LA7ROOT=$Q(@LA7ROOT) Q:LA7ROOT=""  Q:$QS(LA7ROOT,1)'=62.49!($QS(LA7ROOT,2)'="C")  D
 . S LA7INAME=$QS(LA7ROOT,3),LA7DA=$QS(LA7ROOT,4)
 . I '$$LOCK(LA7DA) Q
 . I LA7INAME=$P($G(^LAHM(62.49,LA7DA,0)),"^",6) D UNLOCK(LA7DA) Q
 . I LA7FIX K @LA7ROOT
 . I LA7LOG D LOG("Bad ""C"" cross-reference of "_LA7ROOT_" on entry "_LA7DA)
 . D UNLOCK(LA7DA)
 ;
 ; Check the "Q" cross-reference
 S LA7ROOT="^LAHM(62.49,""Q"")"
 F  S LA7ROOT=$Q(@LA7ROOT) Q:LA7ROOT=""  Q:$QS(LA7ROOT,1)'=62.49!($QS(LA7ROOT,2)'="Q")  D
 . S LA7CFG=$QS(LA7ROOT,3)
 . S LA7Q=$QS(LA7ROOT,4)
 . S LA7DA=$QS(LA7ROOT,5)
 . I '$$LOCK(LA7DA) Q
 . S X(0)=$G(^LAHM(62.49,LA7DA,0))
 . S X(.5)=$G(^LAHM(62.49,LA7DA,.5))
 . I LA7CFG'=$P(X(.5),"^")!(LA7Q'=($P(X(0),"^",2)_$P(X(0),"^",3))) D
 . . I LA7LOG D LOG("Bad ""Q"" cross-reference of "_LA7ROOT_" for entry: "_LA7DA)
 . . I LA7FIX K @LA7ROOT
 . D UNLOCK(LA7DA)
 ;
 ; Check that all entries have "AD" cross-reference set.
 ;                              "B" cross-reference set
 ;                              "C" cross-reference set
 ;                              "Q" cross-reference set
 S (LA7DA,LA7TCNT)=0
 F  S LA7DA=$O(^LAHM(62.49,LA7DA)) Q:'LA7DA  D
 . I '$$LOCK(LA7DA) Q
 . S LA7TCNT=LA7TCNT+1 ; Count of entries in file.
 . S X(0)=$G(^LAHM(62.49,LA7DA,0))
 . S X(.5)=$G(^LAHM(62.49,LA7DA,.5))
 . S Y=$P(X(0),"^") ; Message number (.01 field)
 . I 'Y D
 . . I LA7FIX K ^LAHM(62.49,LA7DA)
 . . I LA7LOG D LOG("Entry "_LA7DA_" missing .01 field")
 . S Y=$P(X(0),"^",5) ; date/time entered
 . I Y,'$D(^LAHM(62.49,"AD",$P(Y,"."),LA7DA)) D
 . . I LA7FIX S ^LAHM(62.49,"AD",$P(Y,"."),LA7DA)=""
 . . I LA7LOG D LOG("Entry "_LA7DA_" missing ""AD"" cross-reference "_$P(Y,"."))
 . S Y=$P(X(0),"^")
 . I Y,'$D(^LAHM(62.49,"B",Y,LA7DA)) D
 . . I LA7FIX S ^LAHM(62.49,"B",Y,LA7DA)=""
 . . I LA7LOG D LOG("Entry "_LA7DA_" missing ""B"" cross-reference")
 . S Y=$P(X(0),"^",6) ; instrument name
 . I Y'="",'$D(^LAHM(62.49,"C",$E(Y,1,45),LA7DA)) D
 . . I LA7FIX S ^LAHM(62.49,"C",$E(Y,1,45),LA7DA)=""
 . . I LA7LOG D LOG("Entry "_LA7DA_" missing ""C"" cross-reference "_Y)
 . S Y=$P(X(0),"^",2)_$P(X(0),"^",3) ; concatentate configuration_status
 . I +X(.5),Y'="",'$D(^LAHM(62.49,"Q",+X(.5),Y,LA7DA)) D
 . . I LA7FIX S ^LAHM(62.49,"Q",+X(.5),Y,LA7DA)=""
 . . I LA7LOG D LOG("Entry "_LA7DA_" missing ^LAHM(62.49,""Q"","_+X(.5)_","""_Y_""","_LA7DA_") cross-reference")
 . D UNLOCK(LA7DA)
 ;
 I LA7LOG D
 . S $P(^XTMP(LA7IC,0),"^",6,7)=LA7TCNT_"^"_LA7ECNT ; Total^Error count
 . S $P(^XTMP(LA7IC,0),"^",8)=LA7FIX
 ;
 Q
 ;
 ;
CHKBX ; Check "B" index on selected Lab files
 ;
 N LRFN,LRROOT
 F LRFN=61,61.1,61.2,61.3,61.4,61.5,61.6,62  D
 . S LRROOT="^LAB("_LRFN_",""B"")"
 . D FILE
 ;
 Q
 ;
 ;
FILE ; Check "B" index on this file
 ;
 ;ZEXCEPT: LRFN,LRROOT
 ;
 N DIK,LRIEN,LRNAME
 F  S LRROOT=$Q(@LRROOT) Q:LRROOT=""  Q:$QS(LRROOT,2)'="B"  D
 . S LRIEN=$QS(LRROOT,4)
 . I LRFN<62,$G(@LRROOT) S LRNAME=$P($G(^LAB(LRFN,LRIEN,0)),"^",$S(((LRFN>61)&(LRFN<61.4)):7,1:5))
 . E  S LRNAME=$P($G(^LAB(LRFN,LRIEN,0)),"^")
 . I $QS(LRROOT,3)'=$E(LRNAME,1,30) K @LRROOT
 ;
 ; Reindex the "B" x-index on this file for fields #.01 and #6 (abbreviation)
 S DIK="^LAB("_LRFN_",",DIK(1)=".01^B" D ENALL^DIK
 K DIK
 I LRFN<62 S DIK="^LAB("_LRFN_",",DIK(1)="6^B" D ENALL^DIK
 Q
 ;
 ;
LOG(X) ; Log error in XTMP global.
 ; Call with X = error message to store.
 ;
 ;ZEXCEPT: LA7ECNT,LA7FIX,LA7IC
 ;
 S LA7ECNT=$G(LA7ECNT)+1
 I LA7FIX S X=X_" **Fix attempted**"
 S ^XTMP(LA7IC,LA7ECNT)=X
 Q
 ;
 ;
LOCK(LA7DA) ; Lock entry in #62.49
 ; Call with LA7DA = entry to lock
 ; Returns       0 = failure to obtain lock
 ;               1 = lock obtained
 ;
 ;ZEXCEPT: LA7LOG
 ;
 N LA7Y
 S LA7Y=0,LA7DA=+$G(LA7DA)
 L +^LAHM(62.49,LA7DA):10
 I $T S LA7Y=1
 I 'LA7Y,$G(LA7LOG) D LOG("Unable to obtain lock on entry "_LA7DA_" in file #62.49")
 Q LA7Y
 ;
UNLOCK(LA7DA) ; Unlock entry in #62.49
 ; Call with LA7DA = entry to lock
 ;
 S LA7DA=+$G(LA7DA)
 L -^LAHM(62.49,LA7DA)
 Q
 ;
LACHK() ; Check ^LA("ADL","Q") for build up of entries.
 ; Send alert to mail group LAB MESSAGING warning about large # of entries.
 N LA7CNT,LA7DA,X,Y
 S LA7DA="",LA7CNT=0
 F  S LA7DA=$O(^LA("ADL","Q",LA7DA)) Q:LA7DA=""  S LA7CNT=LA7CNT+1
 I LA7CNT>500 D
 . N XQA,XQAID,XQADATA,XQAMSG,XQAOPT,XQAROU
 . S XQAMSG="Lab Messaging -Warning- "_LA7CNT_" entries in LA(""ADL"",""Q"") global - please check."
 . S XQAID="LA7ADL-"_$H
 . I $G(DUZ)>.9 S XQA(DUZ)=""
 . S XQA("G.LAB MESSAGING")=""
 . D SETUP^XQALERT
 Q LA7CNT
 ;
 ;
CHECKMG ; Check if LAB MESSAGING and LMI mail groups has active members.
 ; Check mail groups specified for alerts in file #62.48 are valid and have active members.
 ;
 ;ZEXCEPT: LA7ECNT,LA7IC,LA7LOG,LA7XQA
 ;
 N LA76248,LA7FIX,LA7I,LA7MGERRORS,LA7X,LA7Y,XMERR,XQA,XQAID,XQAMSG
 ;
 ; Set flag that we've check the membership today.
 S ^XTMP("LA7CHECKMG",0)=DT_"^"_DT_"^LAB HL7 CHECK LAB MESSAGING MAIL GROUP MEMBERS"
 ;
 K ^TMP("XMERR",$J)
 S XQAMSG="",LA7FIX=0,LA7MGERRORS=LA7ECNT
 ;
 ; Doucment error message returned by GOTLOCAL API when mail group does not exist.
 ;^TMP("XMERR",555809209,1)=39501
 ;^TMP("XMERR",555809209,1,"TEXT",1)=Mail group 'LMI' not found.
 ;^TMP("XMERR",555809209,"E",39501,1)=
 ;
 ; Mail group LAB MESSAGING has no active members
 I '$$GOTLOCAL^XMXAPIG("LAB MESSAGING") D
 . S LA7MGERRORS("LAB MESSAGING")=""
 . S XQAMSG="Lab Messaging - Mail group LAB MESSAGING has no active members"
 . I $D(^TMP("XMERR",$J,"E",39501)) S XQAMSG="Lab Messaging - Mail group LAB MESSAGING not found"
 . S LA7XQA("G.LMI")=""
 . I LA7LOG D
 . . I $D(^TMP("XMERR",$J,"E",39501)) D  Q
 . . . S XQAMSG="Lab Messaging - Mail group LAB MESSAGING not found"
 . . . D LOG("Mail group LAB MESSAGING not found")
 . . D LOG("Mail group LAB MESSAGING has no active members")
 . K ^TMP("XMERR",$J)
 E  S LA7XQA("G.LAB MESSAGING")=""
 ;
 ; Send alert to holders of mail group LMI
 I '$$GOTLOCAL^XMXAPIG("LMI") D
 . S LA7MGERRORS("LMI")=""
 . I XQAMSG="" S XQAMSG="Lab Messaging - Mail group LMI has no active members"
 . E  S XQAMSG="Lab Messaging - Mail groups LAB MESSAGING and LMI have no active members"
 . I LA7LOG D
 . . I $D(^TMP("XMERR",$J,"E",39501)) D LOG("Mail group LMI not found") Q
 . . D LOG("Mail group LMI has no active members")
 . K LA7XQA("G.LMI"),^TMP("XMERR",$J)
 E  S LA7XQA("G.LMI")=""
 ;
 ; Neither LAB MESSAGING or LMI mail groups have active members - send alert to holders of LRLIASON security key
 ; Delete previous alerts
 I XQAMSG'="" D
 . S XQAID="LA7-MESSAGE-CHECKMG"
 . D DEL^LA7UXQA(XQAID)
 . I $O(LA7XQA(""))="" M LA7XQA=^XUSEC("LRLIASON")
 . M XQA=LA7XQA
 . D SETUP^XQALERT
 ;
 S LA76248=0
 F  S LA76248=$O(^LAHM(62.48,LA76248)) Q:LA76248<1  D
 . S LA7I=0
 . F LA7I=$O(^LAHM(62.48,LA76248,20,LA7I)) Q:LA7I<1  D
 . . S LA7I(0)=$G(^LAHM(62.48,LA76248,0))
 . . S LA7Y=$G(^LAHM(62.48,LA76248,20,LA7I,0))
 . . I $P(LA7Y,"^",2)="" Q
 . . K ^TMP("XMERR",$J)
 . . I $$GOTLOCAL^XMXAPIG($P(LA7Y,"^",2)) Q
 . . I '$D(LA7MGERRORS($P(LA7Y,"^",2))) D
 . . . S XQAID="LA7-MESSAGE-CHECKMG-"_$P(LA7Y,"^",2)
 .. .  D DEL^LA7UXQA(XQAID)
 . . . S XQAMSG="Lab Messaging - Mail group "_$P(LA7Y,"^",2)_" has no active members"
 . . . I $D(^TMP("XMERR",$J,"E",39501)) S XQAMSG="Lab Messaging - Mail group "_$P(LA7Y,"^",2)_" not found"
 . . . K XQA
 . . . M XQA=LA7XQA
 . . . D SETUP^XQALERT
 . . . S LA7MGERRORS($P(LA7Y,"^",2))=""
 . . I LA7LOG D
 . . . I $D(^TMP("XMERR",$J,"E",39501)) D LOG("Configuration "_$P(LA7I(0),"^")_" alert mail group "_$P(LA7Y,"^",2)_" not found") Q
 . . . D LOG("Configuration "_$P(LA7I(0),"^")_" alert mail group "_$P(LA7Y,"^",2)_" has no active members")
 ;
 I LA7LOG D
 . S LA7MGERRORS=LA7ECNT-LA7MGERRORS
 . S $P(^XTMP(LA7IC,0),"^",9)=LA7MGERRORS ; Total error count
 ;
 K ^TMP("XMERR",$J)
 ;
 Q
 ;
 ;
INIT ; Initialize variables
 ;
 ;ZEXCEPT: LA7ECNT,LA7FIX,LA7IC,LA7LOG
 ;
 S LA7FIX=$G(LA7FIX,0) ; Set flag to fix problems 1=yes, 0=just check (default)
 S LA7LOG=$G(LA7LOG,0) ; Set flag to report problems, 1=yes, 0=no (default)
 I LA7LOG D
 . F  S LA7IC="LA7IC^"_$$NOW^XLFDT L +^XTMP(LA7IC):9999 Q:'$D(^XTMP(LA7IC))  L -^XTMP(LA7IC) H 1
 . S DT=$$DT^XLFDT
 . S ^XTMP(LA7IC,0)=$$FMADD^XLFDT(DT,7)_"^"_DT_"^Lab Messaging Integrity Checker"_"^"_$$NOW^XLFDT
 ;
 ; Count of number of errors
 S LA7ECNT=0
 ;
 Q
