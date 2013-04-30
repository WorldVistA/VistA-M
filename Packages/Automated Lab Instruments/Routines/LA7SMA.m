LA7SMA ;DALOI/JMC - Inter-divisional Shipping Manifest Receipt ;Feb 6, 2008
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
 ;
INTERDIV(LA7SITE) ; Process inter-divisional shipping manifest
 ; Call with LA7SITE array by reference - see SITE^LA7SBCR2
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LA7628,LA7ANS,LA7I,LA7QUIT,LA7SM,LA7TCNT,X,Y
 S LA7SM="",LA7QUIT=0
 I LA7SITE("SMID")'="" D
 . S X=$O(^LAHM(62.8,"B",LA7SITE("SMID"),0))
 . I X S LA7SM=X_"^"_LA7SITE("SMID")
 I LA7SITE("SMID")="" S LA7SM=$$SELSM^LA7SMU(+LA7SITE("SCFG"),"4,5")
 ;
 S LA7628=+LA7SM
 I 'LA7628 D EN^DDIOL("No manifest found - Shipping Acceptance Aborted.","","!?2") Q
 ;
 S (LA7I,LA7TCNT)=0
 F  S LA7I=$O(^LAHM(62.8,LA7628,10,LA7I)) Q:'LA7I  D  Q:LA7TCNT
 . I $P($G(^LAHM(62.8,LA7628,10,LA7I,0)),"^",8)'=2 Q
 . S LA7TCNT=LA7TCNT+1 ; Test ready to accept.
 ;
 I 'LA7TCNT D EN^DDIOL("No tests in 'shipped' status on manifest - Shipping Acceptance Aborted.","","!?2") Q
 ;
 S DIR(0)="SO^0:Abort Manifest Acceptance;1:Accept Manifest;2:Accept Manifest with Exceptions;3:Accept Selected Accessions;4:Reject Manifest"
 S DIR("A")="Manifest Acceptance Action"
 D ^DIR
 I $D(DIRUT) Q
 S LA7ANS=+Y
 ;
 I LA7ANS=0 Q
 ;
 ; Accept the complete manifest - at least those tests that were shipped.
 I LA7ANS=1 D ACCEPT(LA7SM) Q
 ;
 ; Accept manifest but handle exceptions first.
 I LA7ANS=2 D  Q
 . K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 . F  D EXCEPT(LA7SM,.LA7ANS) Q:LA7QUIT
 . S DIR(0)="Y",DIR("A")="Ready to accept the rest of the manifest",DIR("B")="NO"
 . D ^DIR
 . I Y=1 D ACCEPT(LA7SM)
 ;
 ; Accept selected accessions.
 I LA7ANS=3 D  Q
 . K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 . F  D EXCEPT(LA7SM,.LA7ANS) Q:(+LA7QUIT=1)
 . I $G(LA7ANS(1))<1 Q
 . D SMSUP^LA7SMU(LA7SM,5,"SM07^"_$$NOW^XLFDT)
 . D EN^DDIOL("Manifest "_$P(LA7SM,"^",2)_" status set to 'Manifest received by host facility'.","","!?2")
 ;
 ; Reject entire manifest
 I LA7ANS=4 D  Q
 . K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 . S DIR(0)="Y",DIR("A")="Confirm rejecting entire manifest",DIR("B")="NO"
 . D ^DIR
 . I Y=1 D REJECT(LA7SM)
 ;
 Q
 ;
 ;
ACCEPT(LA7SM) ; Accept an intra-divisional shipping manifest
 ; Used to update the manifest and accessions when shipping between facilities on same system.
 ; Accessions already exist on system.
 ;
 ; Call with LA7SM = file #62.8 ien^manifest id
 ;
 N I,LA7628,LA7ADT,LA7DATA,LA7I,X,Y
 ;
 S LA7628=+LA7SM
 ; Update manifest status to received.
 S LA7ADT=$$NOW^XLFDT
 D SMSUP^LA7SMU(LA7SM,5,"SM07^"_LA7ADT)
 D EN^DDIOL("Manifest "_$P(LA7SM,"^",2)_" status set to 'Manifest received by host facility'.","","!?2")
 ;
 ; Update individual test's status
 K LA7I
 S LA7I=0
 F  S LA7I=$O(^LAHM(62.8,LA7628,10,LA7I)) Q:'LA7I  D
 . S LA7I(0)=$G(^LAHM(62.8,LA7628,10,LA7I,0))
 . I $P(LA7I(0),"^",8)'=2 Q  ; Not shipped.
 . ; Change status to "received".
 . D STSUP^LA7SMU(LA7SM,LA7I,3)
 . ; Update event file
 . S LA7DATA="SM55^"_LA7ADT_"^"_$P(LA7I(0),"^",2)_"^"_$P(LA7SM,"^",2)
 . D SEUP^LA7SMU($P(LA7I(0),"^",5),2,LA7DATA)
 D EN^DDIOL("Test(s) on manifest "_$P(LA7SM,"^",2)_" set to 'Test received' status.","","!?2")
 Q
 ;
 ;
REJECT(LA7SM) ; Reject an intra-divisional shipping manifest
 ; Used to update the manifest and accessions when shipping between facilities on same system.
 ; Accessions already exist on system.
 ;
 ; Call with LA7SM = file #62.8 ien^manifest id
 ;
 N I,LA7628,LA7ADT,LA7DATA,LA7ENVC,LA7I,X,Y
 ;
 ; Get exception reason (event code).
 K DIC
 S DIC="^LAB(64.061,",DIC("A")="Select Exception Reason: ",DIC(0)="AEMQZ",DIC("S")="I $P(^(0),U,7)=""E"",""^SM52^SM54^SM57^SM58^SM59^SM60^SM61^""[(U_$P(^(0),U,4)_U)"
 D ^DIC
 I Y<1 S LA7QUIT=1 Q
 S LA7EVNC=$P(Y(0),"^",4),LA7ENVC(0)=Y(0),LA7ADT=$$NOW^XLFDT
 ;
 S LA7628=+LA7SM
 ; Update manifest status to received.
 S LA7ADT=$$NOW^XLFDT
 D SMSUP^LA7SMU(LA7SM,5,"SM08^"_LA7ADT)
 D EN^DDIOL("Manifest "_$P(LA7SM,"^",2)_" status set to 'Manifest rejected by host facility'.","","!?2")
 ;
 ; Update individual test's status
 K LA7I
 S LA7I=0
 F  S LA7I=$O(^LAHM(62.8,LA7628,10,LA7I)) Q:'LA7I  D
 . S LA7I(0)=$G(^LAHM(62.8,LA7628,10,LA7I,0))
 . I $P(LA7I(0),"^",8)'=2 Q  ; Not shipped.
 . ; Change status to "rejected".
 . D STSUP^LA7SMU(LA7SM,LA7I,6)
 . ; Update event file
 . S LA7DATA=LA7ENVC_"^"_LA7ADT_"^"_$P(LA7I(0),"^",2)_"^"_$P(LA7SM,"^",2)
 . D SEUP^LA7SMU($P(LA7I(0),"^",5),2,LA7DATA)
 D EN^DDIOL("Test(s) on manifest "_$P(LA7SM,"^",2)_" set to '"_$P(LA7ENVC(0),"^")_"' status.","","!?2")
 Q
 ;
 ;
EXCEPT(LA7SM,LA7ANS) ; Handle exceptions on manifest acceptance.
 ;
 ; Call with LA7SM = file #62.8 ien^manifest id
 ;           LA7ANS = function (2=reject accession, 3=accept accession
 ; 
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LA760,LA7ADT,LA7EVNC,LA7I,LA7TCNT,LA7UID,LA7Y,X,Y
 ;
 D SEL
 I LA7QUIT D  Q
 . I LA7QUIT>1 D EN^DDIOL($P(LA7QUIT,"^",2),"","!?2")
 ;
 I '$D(^LAHM(62.8,+LA7SM,10,"UID",LA7UID)) D  Q
 . S LA7QUIT="3^Accession is not on this shipping manifest"
 . D EN^DDIOL($P(LA7QUIT,"^",2),"","!?2")
 ;
 S (LA7I,LA7TCNT)=0
 F  S LA7I=$O(^LAHM(62.8,+LA7SM,10,"UID",LA7UID,LA7I)) Q:'LA7I  D
 . S LA7I(0)=$G(^LAHM(62.8,+LA7SM,10,LA7I,0))
 . I $P(LA7I(0),"^",8)'=2 Q  ; Not shipped
 . S LA7TCNT=LA7TCNT+1,LA760(LA7TCNT)=LA7I_"^"_LA7I(0)
 I 'LA7TCNT S LA7QUIT="4^No test is a 'shipped' status for this accession on this shipping manifest"
 I LA7QUIT D EN^DDIOL($P(LA7QUIT,"^",2),"","!?2") Q
 ;
 S LA7I=0
 F  S LA7I=$O(LA760(LA7I)) Q:'LA7I  D EN^DDIOL(LA7I_" "_$P($G(^LAB(60,+$P(LA760(LA7I),"^",3),0)),"^"),"","!?5")
 S DIR(0)="LO^1:"_LA7TCNT,DIR("A")="Select test(s) to "_$S(LA7ANS=2:"disposition",LA7ANS=3:"accept",1:"")
 D ^DIR
 I $D(DIRUT) S LA7QUIT=1 Q
 M LA7YARRY=Y
 ;
 ; Get exception reason (event code).
 I LA7ANS=2 D  Q:LA7QUIT
 . K DIC
 . S DIC="^LAB(64.061,",DIC("A")="Select Exception Reason: ",DIC(0)="AEMQZ",DIC("S")="I $P(^(0),U,7)=""E"",""^SM52^SM54^SM57^SM58^SM59^SM60^SM61^""[(U_$P(^(0),U,4)_U)"
 . D ^DIC
 . I Y<1 S LA7QUIT=1 Q
 . S LA7EVNC=$P(Y(0),"^",4)
 ;
 ; Change status to "received", update event file.
 I LA7ANS=3 S LA7EVNC="SM55"
 ;
 S LA7ADT=$$NOW^XLFDT
 D UPDTST
 ;
 I LA7ANS=3 D EN^DDIOL("Selected test(s) on manifest "_$P(LA7SM,"^",2)_" set to 'Test received' status.","","!?2")
 Q
 ;
 ;
UPDTST ; Update selected test
 S LA7Y=""
 F  S LA7Y=$O(LA7YARRY(LA7Y)) Q:LA7Y=""  D
 . F LA7I=1:1 Q:'$P(LA7YARRY(LA7Y),",",LA7I)  D
 . . S LA7X=$P(LA7YARRY(LA7Y),",",LA7I)
 . . ; Change status to "accepted/rejected".
 . . D STSUP^LA7SMU(LA7SM,$P(LA760(LA7X),"^"),$S(LA7ANS=2:6,LA7ANS=3:3,1:""))
 . . ; Update event file with reason
 . . S LA7DATA=LA7EVNC_"^"_LA7ADT_"^"_$P(LA760(LA7X),"^",3)_"^"_$P(LA7SM,"^",2)
 . . D SEUP^LA7SMU(LA7UID,2,LA7DATA)
 . . S LA7ANS(1)=$G(LA7ANS(1))+1
 Q
 ;
 ;
SEL ; Select accession
 ;
 N LRAA,LRACC,LRAD,LRAN,X
 ;
 ; Select by accession, ^LRWU4 needs variable LRACC.
 S (LRACC,LA7UID)="",LA7QUIT=0
 D ^LRWU4
 I $D(DUOUT) S LA7QUIT="1^User aborted" Q
 I $D(DTOUT) S LA7QUIT="1^User timeout" Q
 I (LRAA*LRAD*LRAN)<1 S LA7QUIT="1" Q
 ;
 S LA7AA=LRAA,LA7AD=LRAD,LA7AN=LRAN
 ;
 S LA7UID=$P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,.3)),"^")
 I LA7UID="" S LA7QUIT="2^Database error - accession missing UID" Q
 Q
