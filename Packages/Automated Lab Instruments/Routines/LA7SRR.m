LA7SRR ;DALOI/JMC - Select Accessions for Resending LEDI Results ;11/20/09  14:09
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,74**;Sep 27, 1994;Build 229
 ;
EN ; Select Accessions to resend.
 ;
 ; Housekeeping before we start.
 D EXIT
 ;
 S (LA7CNT,LA7QUIT)=0
 ;
 S DIR(0)="SO^1:Range of Accessions;2:Selected Accessions"
 S DIR("A")="Selection Method",DIR("B")=1
 D ^DIR
 I $D(DIRUT) D EXIT Q
 S LA7TYPE=+Y
 ;
 ; Get list of accession numbers, set flags used by LRWU4.
 S LRACC=1,LREXMPT=1
 I LA7TYPE=1 D
 . D ^LRWU4
 . I LRAN<1 S LA7QUIT=1 Q
 . S FIRST=LRAN,X=$O(^LRO(68,LRAA,1,LRAD,1,":"),-1)
 . S DIR(0)="NO^"_LRAN_":"_X_":0",DIR("B")=LRAN
 . S DIR("A",1)="",DIR("A")="Retransmit from "_LRAN_" to"
 . D ^DIR K DIR
 . I $D(DIRUT) S LA7QUIT=1 Q
 . S LRAN=FIRST-1,LAST=Y
 . F  S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) Q:'LRAN!(LRAN>LAST)  D SETTMP
 I LA7TYPE=2 F  D  Q:LA7QUIT!(LRAN<1)
 . D ^LRWU4
 . I $D(DTOUT)!($D(DUOUT)) S LA7QUIT=1 Q
 . I LRAN<1 S:'$D(^TMP("LA7S-RTM",$J)) LA7QUIT=1 Q
 . D SETTMP
 I LA7QUIT D EXIT Q
 ;
 I '$D(^TMP("LA7S-RTM",$J)) D  Q
 . S DIR("A",1)="No accessions found to retransmit."
 . S DIR("A")="Enter RETURN to continue or '^' to exit"
 . S DIR(0)="E"
 . D ^DIR,EXIT
 ;
 S DIR("A")="Ready to retransmit"
 S DIR("A",1)="Found "_LA7CNT_" accessions that can be retransmitted."
 S DIR(0)="YO",DIR("B")="NO"
 D ^DIR K DIR
 I Y'=1 D EXIT Q
 D EN^DDIOL("Working","","!")
 S LA7CNT=0,LA7UID=""
 F  S LA7UID=$O(^TMP("LA7S-RTM",$J,LA7UID)) Q:LA7UID=""  D
 . K LA7X
 . S LA7X=^TMP("LA7S-RTM",$J,LA7UID)
 . S LA7NLT="",LA7CNT=LA7CNT+1
 . F  S LA7NLT=$O(^TMP("LA7S-RTM",$J,LA7UID,LA7NLT)) Q:LA7NLT=""  D
 . . S LA764=$$FIND1^DIC(64,"","MX",LA7NLT,"C")
 . . I 'LA764 Q
 . . S LA7NLTN=$$GET1^DIQ(64,LA764_",",.01)
 . . K LA7Y
 . . M LA7Y=^TMP("LA7S-RTM",$J,LA7UID,LA7NLT)
 . . D SET^LA7VMSG($P(LA7X,"^"),$P(LA7X,"^",2),$P(LA7X,"^",3),$P(LA7X,"^",4),LA7NLTN,LA7NLT,$P(LA7X,"^",5),$P(LA7X,"^",6),$P(LA7X,"^",7),$P(LA7X,"^",8),.LA7Y,"ORU")
 ;
 ; Task background job to create messages
 S ZTIO="",ZTRTN="ORU^LA7VMSG",ZTDTH=$H,ZTDESC="Resend Lab LEDI HL7 Result Message"
 D ^%ZTLOAD
 ;
 K LA7X
 S LA7X(1)="...Done",LA7X(1,"F")=""
 I $G(ZTSK) D
 . S LA7X(2)=LA7CNT_" accession"_$S(LA7CNT>1:"s",1:"")_" scheduled for retransmitting of results!"
 . S LA7X(3)="Task# "_ZTSK_" queued for processing"
 E  S LA7X(2)="*** Tasking of retransmission failed ***"
 D EN^DDIOL(.LA7X),EXIT
 ;
 Q
 ;
 ;
SETTMP ; Setup TMP global with accession to resend.
 ;
 N LA763,LA768,LA7ERR,LA7I,LA7VDB,LA7X,LA7Y,LR60,LR61,LRDFN,LRIDT,LRODT,LRSB,LRSS
 ;
 S LRSS=$P(^LRO(68,LRAA,0),"^",2)
 F LA7I=0,.2,.3,3 S LA768(LA7I)=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,LA7I))
 S LA7UID=$P(LA768(.3),"^")
 ;
 ; Not a LEDI specimen
 I '$P(LA768(.3),"^",2),'$P(LA768(.3),"^",3) D  Q
 . N LA7X
 . S LA7X="Not a LEDI specimen - Accession "_$P(LA768(.2),"^")_" ("_LA7UID_") skipped"
 . D EN^DDIOL(LA7X,"","!")
 ;
 I LRSS'?1(1"CH",1"MI",1"SP",1"CY",1"EM") D  Q
 . N LA7X
 . S LA7X(1)=$$GET1^DIQ(68,LRAA_",",.02)_" subscript NOT supported at this time"
 . S LA7X(2)="Accession "_$P(LA768(.2),"^")_" ("_LA7UID_") skipped"
 . D EN^DDIOL(.LA7X)
 ;
 ; Check file #63 for order codes and results
 ; If no order NLT code found then use default NLT
 ; Check if test has been added to order then report results using NLT code of the added test.
 S LRDFN=$P(LA768(0),"^"),LRODT=$P(LA768(0),"^",4),LRIDT=$P(LA768(3),"^",5)
 ; Check for date report completed.
 I '$$OK2SEND D  Q
 . N LA7X
 . S LA7X="No date report completed - Accession "_$P(LA768(.2),"^")_" ("_LA7UID_") skipped"
 . D EN^DDIOL(LA7X,"","!")
 ;
 I LRSS="CH" D
 . S LRSB=1
 . F  S LRSB=$O(^LR(LRDFN,LRSS,LRIDT,LRSB)) Q:'LRSB  D
 . . S X=^LR(LRDFN,LRSS,LRIDT,LRSB)
 . . S LA7NLT=$P($P(X,"^",3),"!")
 . . I LA7NLT'="" S LA7Y(LA7NLT,LRSB)="" Q
 . . S LR61=+$P(^LR(LRDFN,LRSS,LRIDT,0),"^",5)
 . . S LA7NLT=$P($$DEFCODE^LA7VHLU5(LRSS,LRSB,$P(X,"^",3),LR61),"!")
 . . I LA7NLT'="" S LA7Y(LA7NLT,LRSB)=""
 ;
 I LRSS="MI" D
 . S LR60=0
 . F  S LR60=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LR60)) Q:'LR60  D
 . . S LA764=$P($G(^LAB(60,LR60,64)),"^")
 . . S LA7NLT=$$GET1^DIQ(64,LA764_",",1)
 . . S LA7VDB=$$GET1^DIQ(64,LA764_",",63,"I")
 . . I LA7VDB'="" S LA7Y(LA7NLT,LA7VDB)=""
 . I $D(LA7Y) Q
 . N LA7X
 . S LA7X(1)="No test on accession has an associated NLT database code"
 . S LA7X(2)="Accession "_$P(LA768(.2),"^")_" ("_LA7UID_") skipped"
 . D EN^DDIOL(.LA7X)
 ;
 ; Check ordered test multiple for dispositioned tests
 ; Check AP type test for database codes
 K LA7I
 S LA7I=0
 F  S LA7I=$O(^LR(LRDFN,LRSS,LRIDT,"ORUT",LA7I)) Q:'LA7I  D
 . S LA7I(0)=^LR(LRDFN,LRSS,LRIDT,"ORUT",LA7I,0)
 . S LA7NLT=$P(LA7I(0),"^"),LA764=$$FIND1^DIC(64,"","X",LA7NLT,"E","","LA7ERR")
 . I LRSS?1(1"SP",1"CY",1"EM") D
 . . S LA7Y(LA7NLT)=""
 . . S LA7VDB=$$GET1^DIQ(64,LA764_",",63,"I")
 . . I LA7VDB'="" S LA7Y(LA7NLT,LA7VDB)=""
 . I $P(LA7I(0),"^",10),'$D(LA7Y(LA7NLT)) S LA7Y(LA7NLT)=""
 ;
 I LRSS?1(1"SP",1"CY",1"EM"),'$D(LA7Y) D
 . I LRSS="SP" S LA7Y("88515.0000")="" Q
 . I LRSS="CY" S LA7Y("88593.0000")="" Q
 . I LRSS="EM" S LA7Y("88597.0000")="" Q
 ;
 I LRSS="AU" S LA7Y("88533.0000")=""
 ;
 I LA7UID'="",$D(LA7Y) D
 . S LA7CNT=LA7CNT+1
 . S X=$P(LA768(.3),"^",1)_"^"_$P(LA768(.3),"^",2)_"^"_$P(LA768(.3),"^",5)_"^"_$P(LA768(.3),"^",3)_"^"_LRIDT_"^"_LRSS_"^"_LRDFN_"^"_LRODT
 . S ^TMP("LA7S-RTM",$J,LA7UID)=X
 . S LA7I=""
 . F  S LA7I=$O(LA7Y(LA7I)) Q:LA7I=""  M ^TMP("LA7S-RTM",$J,LA7UID,LA7I)=LA7Y(LA7I)
 Q
 ;
 ;
OK2SEND() ; Check is this accession is OK to send, i.e. approved, released (preliminary/final/corrected)
 ; Returns OK = 1 (true)  - report can be sent
 ;              0 (false) - report not in a status to be sent.
 ;
 ; Called from above, LRVR0 and LA7VORU
 ;
 N LA7X,OK
 S OK=0
 ; Check 0th node for complete date
 I $P(^LR(LRDFN,LRSS,LRIDT,0),"^",3) S OK=1
 ;
 ; If complete and AP subscript then check RELEASE DATE/TIME
 I OK,LRSS?1(1"SP",1"CY",1"EM"),$P($G(^LR(LRDFN,LRSS,LRIDT,0)),"^",11)="" S OK=0
 ;
 ; If not complete and "CH" subscript then check for NP status
 I 'OK,LRSS="CH",'$O(^LR(LRDFN,"CH",LRIDT,1)) S OK=1
 ;
 ; If not complete and "MI" subscript then check each section of report
 I 'OK,LRSS="MI" F LA7X=1,5,8,11,16 I $P($G(^LR(LRDFN,LRSS,LRIDT,LA7X)),"^") S OK=1 Q
 ;
 ; Also check for test that has NP status
 I 'OK D NPSTATUS
 Q OK
 ;
 ;
NPSTATUS ; Check ORUT node for test with NP status
 ;
 N LA7DISPO,LA7I
 S LA7DISPO=$$FIND1^DIC(64.061,"","OQX","X","D","I $P(^(0),U,5)=""0123""")
 S LA7I=0
 F  S LA7I=$O(^LR(LRDFN,LRSS,LRIDT,"ORUT",LA7I)) Q:'LA7I  I $P(^(LA7I,0),"^",10)=LA7DISPO S OK=1 Q
 Q
 ;
 ;
EXIT ; Housekeeping - clean up.
 K ^TMP("LA7S-RTM",$J)
 K LA764,LA7CNT,LA7NLT,LA7NLTN,LA7QUIT,LA7TYPE,LA7UID,LA7X,LA7Y
 K LRAA,LRACC,LRAD,LRAN,LREXMPT,LRIDIV,LRSS,LRX
 K %DT,DA,DIC,DIR,DIRUT,DTOUT,DUOUT,FIRST,LAST,X,Y
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
