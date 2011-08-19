LA7SM ;DALOI/JMC - Shipping Manifest Options ;5/5/97  14:39
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,46**;Sep 27, 1994
 ;
CLSHIP ; Close/ship a shipping manifest
 D INIT
 I LA7QUIT D CLEANUP Q
 S LA7SM=$$SELSM^LA7SMU(+LA7SCFG,"1,3")
 I LA7SM<0 D  Q
 . D EN^DDIOL($P(LA7SM,"^",2),"","!?5")
 . D CLEANUP
 D LOCKSM
 I LA7QUIT D  Q
 . D EN^DDIOL($P(LA7QUIT,"^",2),"","!?5")
 . D UNLOCKSM,CLEANUP
 S LA7SM(0)=$G(^LAHM(62.8,+LA7SM,0))
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 I $P(LA7SM(0),"^",3)=1 D
 . S DIR(0)="SO^1:Close manifest;2:Ship manifest"
 . S DIR("A")="Select action to perform",DIR("B")=1
 I $P(LA7SM(0),"^",3)=3 D
 . S DIR(0)="YO"
 . S DIR("A")="Do you want to ship this manifest",DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) D UNLOCKSM,CLEANUP Q
 S LA7ST=+Y
 I $P(LA7SM(0),"^",3)=3,LA7ST S LA7ST=2
 I $P(LA7SM(0),"^",3)=1 D SMSUP^LA7SMU(LA7SM,3,"SM04") ; Close manifest
 I LA7ST=2 D SHIP^LA7SM1 ; Ask for shipping date/time
 I 'LA7QUIT!$D(LA7ERR) S LA7CHK=0 D ASK^LA7SMP(LA7SM) ; Ask if want to print manifest.
 D UNLOCKSM,CLEANUP
 Q
 ;
SMET ; Edit a test on a shipping manifest
 ; Used to add/remove a test.
 D INIT
 I LA7QUIT D CLEANUP Q
 S LA7SM=$$SELSM^LA7SMU(+LA7SCFG,"0,1,3")
 I LA7SM<0 D  Q
 . D EN^DDIOL($P(LA7SM,"^",2),"","!?5")
 . D CLEANUP
 D LOCKSM
 I LA7QUIT D  Q
 . D EN^DDIOL($P(LA7QUIT,"^",2),"","!?5")
 . D UNLOCKSM,CLEANUP
 S LA7SM(0)=$G(^LAHM(62.8,LA7SM,0))
 S DIR(0)="SO^1:Add test to manifest;2:Remove test from manifest"
 S DIR("A")="Select action to perform",DIR("B")=1
 D ^DIR
 I $D(DIRUT) D CLEANUP Q
 S LA7ACTON=+Y
 I LA7ACTON=1 F  D ADDTEST Q:LA7QUIT
 I LA7ACTON=2 F  D REMVTST Q:LA7QUIT
 I LA7QUIT,$L($P(LA7QUIT,"^",2)) D EN^DDIOL($P(LA7QUIT,"^",2),"","!?5")
 E  D ASK^LA7SMP(LA7SM)
 D CLEANUP
 Q
 ;
 ;
ADDTEST ; Add individual test to an existing manifest
 ;
 N LA760,LA7AA,LA7AD,LA7AN,LA7BY,LA7DIV,LA7I,LA7UID,LA7X
 ;
 D SEL
 I LA7QUIT Q
 ;
 S DIC="^LRO(68,LA7AA,1,LA7AD,1,LA7AN,4,",DIC(0)="AEMQ",DIC("A")="Select TEST to Add: "
 S DA=LA7AN,DA(1)=LA7AD,DA(2)=LA7AA
 D ^DIC
 I Y<1 D  Q
 . S LA7QUIT=1
 . I $D(DUOUT) S $P(LA7QUIT,"^",2)="User aborted"
 . I $D(DTOUT) S $P(LA7QUIT,"^",2)="User timeout"
 S LA760=+Y
 ;
 ; Test's zeroth node.
 S LA760(0)=$G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,4,LA760,0))
 ;
 ; Test completed - skip
 I $P(LA760(0),"^",5) S LA7QUIT="1^Test already completed" Q
 ;
 ; Test urgency
 S LA76205=+$P(LA760(0),"^",2)
 I LA76205>49 S LA76205=$S(LA76205=50:9,1:LA76205-50)
 ;
 ; Don't build controls
 I $P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,0)),"^",2)=62.3 S LA7QUIT="1^Cannot select controls" Q
 ;
 S LA7I=0
 F  S LA7I=$O(^LAHM(62.8,+LA7SM,10,"UID",LA7UID,LA7I)) Q:'LA7I  D  Q:LA7QUIT
 . N X
 . S X(0)=$G(^LAHM(62.8,+LA7SM,10,LA7I,0))
 . I $P(X(0),"^",2)=LA760,$P(X(0),"^",8)'=0 S LA7QUIT="1^Test already on shipping manifest"
 I LA7QUIT Q
 ;
 ; Build TMP global with test profile
 D SCBLD^LA7SM1(+LA7SCFG)
 ;
 ; Accession's division
 S LA7DIV=+$P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,.4)),"^")
 ;
 ; Check if test eligible for manifest
 D SCHK^LA7SM1
 I 'LA7FLAG S LA7QUIT="1^Test not selectable for this configuration" Q
 D LOCK68^LA7SMB
 S LA7I=0
 F  S LA7I=$O(LA7X(LA7I)) Q:'LA7I  D ADD^LA7SMB
 D UNLOCK68^LA7SMB
 Q
 ;
 ;
REMVTST ; Remove a test from manifest - actually flags test as "removed".
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LA7I,LA7TCNT,LA7Y,LA760,X,Y
 D SEL
 I LA7QUIT Q
 S (LA7I,LA7TCNT)=0
 F  S LA7I=$O(^LAHM(62.8,+LA7SM,10,"UID",LA7UID,LA7I)) Q:'LA7I  D
 . S LA7I(0)=$G(^LAHM(62.8,+LA7SM,10,LA7I,0))
 . I $P(LA7I(0),"^",8)=0 Q  ; Previously "removed".
 . I $P(LA7I(0),"^",8),$P(LA7I(0),"^",8)'=1 S LA7QUIT="1^Accession not pending shipment" Q
 . S LA7TCNT=LA7TCNT+1,LA760(LA7TCNT)=LA7I_"^"_LA7I(0)
 I 'LA7TCNT,'LA7QUIT S LA7QUIT="1^Accession is not on this shipping manifest"
 I LA7QUIT Q
 S LA7I=0
 F  S LA7I=$O(LA760(LA7I)) Q:'LA7I  D EN^DDIOL(LA7I_" "_$P($G(^LAB(60,+$P(LA760(LA7I),"^",3),0)),"^"),"","!?5")
 S DIR(0)="LO^1:"_LA7TCNT,DIR("A")="Select test(s) to remove"
 D ^DIR
 I $D(DIRUT) S LA7QUIT=1 Q
 M LA7YARRY=Y
 S LA7Y=""
 F  S LA7Y=$O(LA7YARRY(LA7Y)) Q:LA7Y=""  D
 . F LA7I=1:1 Q:'$P(LA7YARRY(LA7Y),",",LA7I)  D
 . . S LA7X=$P(LA7YARRY(LA7Y),",",LA7I)
 . . N FDA,LA7628,LA768,LA7DATA
 . . S LA762801=+(LA760(LA7X))_","_+LA7SM_","
 . . S FDA(62.8,62.801,LA762801,.08)=0
 . . D FILE^DIE("","FDA(62.8)","LA7DIE(2)") ; "Remove" test from shipping manifest
 . . ; Update event file
 . . S LA7DATA="SM51^"_$$NOW^XLFDT_"^"_$P(LA760(LA7X),"^",3)_"^"_$P(LA7SM,"^",2)
 . . D SEUP^LA7SMU(LA7UID,2,LA7DATA)
 . . ; Update accession
 . . D ACCSUP^LA7SMU(LA7UID,$P(LA760(LA7X),"^",3),"@")
 Q
 ;
 ;
CANC ; Cancel a shipping manifest
 D INIT
 I LA7QUIT D CLEANUP Q
 S LA7SM=$$SELSM^LA7SMU(+LA7SCFG,"1,3")
 I LA7SM<0 D  Q
 . D EN^DDIOL($P(LA7SM,"^",2),"","!?5")
 . D CLEANUP
 D LOCKSM
 I LA7QUIT D  Q
 . D EN^DDIOL($P(LA7QUIT,"^",2),"","!?5")
 . D UNLOCKSM,CLEANUP
 S LA7SM(0)=$G(^LAHM(62.8,LA7SM,0))
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YO"
 S DIR("A")="Do you want to cancel this manifest",DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) D UNLOCKSM,CLEANUP Q
 S LA7ST=+Y
 I LA7ST=1 D
 . S LA7I=0
 . F  S LA7I=$O(^LAHM(62.8,+LA7SM,10,LA7I)) Q:'LA7I  D
 . . S LA7I(0)=$G(^LAHM(62.8,+LA7SM,10,LA7I,0))
 . . I $P(LA7I(0),"^",8)=0 Q  ; Previously "removed".
 . . ; "Remove" test from shipping manifest
 . . S LA762801=LA7I_","_+LA7SM_","
 . . S FDA(62.8,62.801,LA762801,.08)=0
 . . D FILE^DIE("","FDA(62.8)","LA7DIE(2)")
 . . ; Update event file
 . . S LA7DATA="SM51^"_$$NOW^XLFDT_"^"_$P(LA7I(0),"^",2)_"^"_$P(LA7SM,"^",2)
 . . D SEUP^LA7SMU($P(LA7I(0),"^",5),2,LA7DATA)
 . . ; Update accession
 . . D ACCSUP^LA7SMU($P(LA7I(0),"^",5),$P(LA7I(0),"^",2),"@")
 . D SMSUP^LA7SMU(LA7SM,0,"SM00") ; Cancel manifest
 D UNLOCKSM,CLEANUP
 Q
 ;
 ;
SEL ; Select accession
 ;
 N LRAA,LRACC,LRAD,LRAN,X
 ;
 ; Select by accession, ^LRWU4 needs variable LRACC.
 S LRACC=""
 D ^LRWU4
 I $D(DUOUT) S LA7QUIT="1^User aborted" Q
 I $D(DTOUT) S LA7QUIT="1^User timeout" Q
 I (LRAA*LRAD*LRAN)<1 S LA7QUIT="1" Q
 ;
 S LA7AA=LRAA,LA7AD=LRAD,LA7AN=LRAN
 ;
 S LA7UID=$P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,.3)),"^")
 I LA7UID="" S LA7QUIT="2^Database error - accession missing UID" Q
 ;
 ; Specimen type
 S LA76805=0
 S X=+$O(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,5,0))
 I X S LA76805=+$G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,5,X,0))
 Q
 ;
 ;
INIT ; Initialize variables
 S DT=$$DT^XLFDT
 S LA7QUIT=0
 S LA7SCFG=$$SSCFG^LA7SUTL(1) ; Select shipping configuration
 I LA7SCFG<1 S LA7QUIT=1 Q
 S LA7SCFG(0)=$G(^LAHM(62.9,+LA7SCFG,0))
 K ^TMP("LA7ERR",$J)
 Q
 ;
 ;
LOCKSM ; Lock entry in file 62.8
 L +^LAHM(62.8,+LA7SM):1 ; Set lock.
 I '$T S LA7QUIT="1^Someone else is editing this shipping manifest"
 Q
 ;
 ;
UNLOCKSM ; Unlock entry in file 62.8
 L -^LAHM(62.8,+LA7SM) ; Release lock.
 Q
 ;
 ;
CLEANUP ; Cleanup variables
 I $D(ZTQUEUED) S ZTREQ="@"
 K DA,DIC,DIR,DIRUT,DTOUT,DUOUT,X,Y
 K LA7AA,LA7ACTON,LA7AD,LA7AN,LA7EV,LA7FLAG,LA7I,LA7QUIT,LA7SCFG,LA7SDT,LA7SM,LA7ST,LA7UID,LA7X,LA7YARRY
 K LA760,LA76205,LA762801,LA76805
 K ^TMP("LA7ERR",$J)
 Q
