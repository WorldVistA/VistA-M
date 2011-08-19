LA7CHKF ;DALOI/JMC - Check Lab Messaging File Integrity ; 2/26/97 11:00
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,46**;Sep 27, 1994
 ;This routine checks file integrity for Lab Messaging.
EN ; Run an integrity check
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 N LA7FIX,LA7ION,LA7LOG,LA7QUIT
 ;
 S LA7LOG=1
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
DQ ; Entry point from taskman
 D IC
 Q
 ;
IC ; File 62.49 Integrity checker and fix-er-upper.
 ;
 ; Check that all the cross-references have entries
 ;
 N LA7CFG,LA7DA,LA7DAT,LA7ECNT,LA7IC,LA7INAME,LA7Q,LA7ROOT,X,Y
 S LA7FIX=$G(LA7FIX,0) ; Set flag to fix problems 1=yes, 0=just check (default)
 S LA7LOG=$G(LA7LOG,0) ; Set flag to report problems, 1=yes, 0=no (default)
 I LA7LOG D
 . F  S LA7IC="LA7IC^"_$$NOW^XLFDT L +^XTMP(LA7IC):9999 Q:'$D(^XTMP(LA7IC))  L -^XTMP(LA7IC) H 1
 . S DT=$$DT^XLFDT
 . S ^XTMP(LA7IC,0)=$$FMADD^XLFDT(DT,7)_"^"_DT_"^Lab Messaging Integrity Checker"_"^"_$$NOW^XLFDT
 S LA7ECNT=0 ; Count of number of errors
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
 . I LA7INAME'=$E($P($G(^LAHM(62.49,LA7DA,0)),"^",6),1,30) D
 . . I LA7FIX K @LA7ROOT
 . . I LA7LOG D LOG("Bad ""C"" cross-reference of "_LA7ROOT_" on entry "_LA7DA)
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
 . I $L(Y),'$D(^LAHM(62.49,"C",$E(Y,1,30),LA7DA)) D
 . . I LA7FIX S ^LAHM(62.49,"C",$E(Y,1,30),LA7DA)=""
 . . I LA7LOG D LOG("Entry "_LA7DA_" missing ""C"" cross-reference "_Y)
 . S Y=$P(X(0),"^",2)_$P(X(0),"^",3) ; concatentate configuration_status
 . I +X(.5),$L(Y),'$D(^LAHM(62.49,"Q",+X(.5),Y,LA7DA)) D
 . . I LA7FIX S ^LAHM(62.49,"Q",+X(.5),Y,LA7DA)=""
 . . I LA7LOG D LOG("Entry "_LA7DA_" missing ^LAHM(62.49,""Q"","_+X(.5)_","""_Y_""","_LA7DA_") cross-reference")
 . D UNLOCK(LA7DA)
 I LA7LOG D
 . S $P(^XTMP(LA7IC,0),"^",5)=$$NOW^XLFDT ; End date/time
 . S $P(^XTMP(LA7IC,0),"^",6,7)=LA7TCNT_"^"_LA7ECNT ; Total^Error count
 . L -^XTMP(LA7IC) ; Release lock
 I LA7ECNT D
 . N XQA,XQAID,XQADATA,XQAMSG,XQAOPT,XQAROU
 . S XQAMSG="Lab Messaging -Warning- "_LA7ECNT_" errors found in File #62.49, LA7 MESSAGE QUEUE."
 . I LA7LOG S XQADATA=LA7IC,XQAROU="DISIC^LA7UXQA"
 . S XQAID="LA7ERR-"_$TR(LA7IC,"^",":")
 . I $G(DUZ)>.9 S XQA(DUZ)=""
 . S XQA("G.LAB MESSAGING")=""
 . D SETUP^XQALERT
 I $L($G(LA7ION)) D  ; Task print of integrity report
 . N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 . S ZTRTN="DQ^LA7CHKFP",ZTDTH=$H,ZTSAVE("LA7IC")="",ZTIO=LA7ION
 . S ZTDESC="Print LA7 File Integrity Report"
 . D ^%ZTLOAD
 K LA7FIX,LA7ION,LA7LOG
 Q
 ;
LOG(X) ; Log error in XTMP global.
 ; Call with X = error message to store.
 S LA7ECNT=$G(LA7ECNT)+1
 S ^XTMP(LA7IC,LA7ECNT)=X
 Q
 ;
LOCK(LA7DA) ; Lock entry in #62.49
 ; Call with LA7DA = entry to lock
 ; Returns       0 = failure to obtain lock
 ;               1 = lock obtained
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
