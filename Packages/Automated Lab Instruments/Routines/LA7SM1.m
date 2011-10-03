LA7SM1 ;DALOI/JMC - Shipping Manifest Options ;5/5/97  14:39
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,46,61**;Sep 27, 1994
 ;
RETRANS ; Retransmit a shipping manifest.
 ;
 D INIT^LA7SM
 I LA7QUIT D CLEANUP^LA7SM Q
 ;
 I '$P($G(^LAHM(62.9,+LA7SCFG,0)),"^",7) D  Q
 . N MSG
 . S MSG="This shipping configuration "_$P(LA7SCFG,"^",2)_" is not setup for electronic transmission."
 . D EN^DDIOL(MSG,"","!?5")
 . D CLEANUP^LA7SM
 ;
 S LA7SM=$$SELSM^LA7SMU(+LA7SCFG,"4")
 I LA7SM<0 D  Q
 . D EN^DDIOL($P(LA7SM,"^",2),"","!?5")
 . D CLEANUP^LA7SM
 ;
 I LA7QUIT D  Q
 . D EN^DDIOL($P(LA7QUIT,"^",2),"","!?5")
 . D CLEANUP^LA7SM
 ;
 S LA7SM(0)=$G(^LAHM(62.8,+LA7SM,0))
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DIR(0)="YO"
 S DIR("A")="Sure you want to retransmit this manifest",DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) D CLEANUP^LA7SM Q
 ;
 ; Do tasking of transmission
 I Y D TASKSM
 D CLEANUP^LA7SM
 ;
 Q
 ;
 ;
SHIP ; Ship a manifest
 ; Used to flag shipping manifest for shipping
 ; If electronically connected -> transmit shipping manifest in HL7 message.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,I,LA7I,LA7TCNT,X,Y
 ;
 S (LA7I,LA7TCNT)=0
 F  S LA7I=$O(^LAHM(62.8,+LA7SM,10,LA7I)) Q:'LA7I  D
 . I $$CHKTST^LA7SMU(+LA7SM,LA7I) Q
 . I $P($G(^LAHM(62.8,+LA7SM,10,LA7I,0)),"^",8)'=1 Q
 . S LA7TCNT=LA7TCNT+1 ; Test ready to ship.
 . D CHKREQI^LA7SM2(+LA7SM,LA7I)
 ;
 I 'LA7TCNT D  Q
 . S LA7QUIT=1
 . D EN^DDIOL("No tests on shipping manifest - Shipping Aborted","","!?5")
 ;
 I $G(LA7ERR) D  Q
 . S LA7QUIT=1
 . D EN^DDIOL("Print shipping manifest for complete listing of errors","","!!?5")
 . D EN^DDIOL("The following errors were found - Shipping Aborted","","!?5")
 . S LA7X=""
 . F  S LA7X=$O(LA7ERR(LA7X)) Q:LA7X=""  D EN^DDIOL(LA7ERR(LA7X),"","!?5")
 . D EN^DDIOL("","","!")
 ;
 S DIR(0)="D^::EFRX",DIR("A")="Enter Manifest Shipping Date",DIR("B")="NOW"
 D ^DIR
 I $D(DIRUT) S LA7QUIT=1 Q
 S LA7SDT=Y
 D SMSUP^LA7SMU(LA7SM,4,"SM05^"_LA7SDT)
 ;
 K LA7I
 S LA7I=0
 F  S LA7I=$O(^LAHM(62.8,+LA7SM,10,LA7I)) Q:'LA7I  D
 . S LA7I(0)=$G(^LAHM(62.8,+LA7SM,10,LA7I,0))
 . I $P(LA7I(0),"^",8)'=1 Q  ; Not "pending shipment".
 . ; Change status to "shipped".
 . S LA762801=LA7I_","_+LA7SM_","
 . S FDA(62.8,62.801,LA762801,.08)=2
 . D FILE^DIE("","FDA(62.8)","LA7DIE(2)")
 . ; Update event file
 . S LA7DATA="SM53^"_$$NOW^XLFDT_"^"_$P(LA7I(0),"^",2)_"^"_$P(LA7SM,"^",2)
 . D SEUP^LA7SMU($P(LA7I(0),"^",5),2,LA7DATA)
 ;
 ; Do tasking of transmission
 I $P($G(^LAHM(62.9,+LA7SCFG,0)),"^",7) D TASKSM
 ;
 Q
 ;
 ;
SCBLD(LA7SCFG) ; Build test profile for a configuration
 ; Call with LA7SCFG = ien of shipping configuration in file #62.9
 N I,X
 ;
 K ^TMP("LA7SMB",$J)
 ;
 S X=0
 F  S X=$O(^LAHM(62.9,LA7SCFG,60,X)) Q:'X  D
 . F I=0,1,2,5 S X(I)=$G(^LAHM(62.9,LA7SCFG,60,X,I))
 . ; No accession area - skip
 . I '$P(X(0),"^",2) Q
 . ; TMP("LA7SMB",$J,accession area,file 60 test,entry #,specimen,urgency,division, node)
 . ; specimen=0 if any specimen, urgency=0 if any urgency, division=0 if any division
 . F I=0,1,2,5 S ^TMP("LA7SMB",$J,$P(X(0),"^",2),+X(0),X,+$P(X(0),"^",3),+$P(X(0),"^",4),+$P(X(0),"^",10),I)=X(I)
 Q
 ;
 ;
SCHK ; Check shipping configuration for test eligible to add.
 ; Called by LA7SM, LA7SMB
 ;
 N LA7I,LA7J,LA7K,LA7L,LA7M
 ;
 K LA7X
 ;
 ; Flag to determine if accession/test should be added to manifest.
 S LA7FLAG=0
 ;
 ; Quit if this asscession area/test not defined for configuration.
 I '$D(^TMP("LA7SMB",$J,LA7AA,LA760)) Q
 ;
 S LA7I=0
 F  S LA7I=$O(^TMP("LA7SMB",$J,LA7AA,LA760,LA7I)) Q:'LA7I  D
 . S LA7FLAG=0
 . D CHKMASK Q:'LA7FLAG
 . F LA7J=0,1,2,5 S LA7X(LA7I,LA7J)=$G(^TMP("LA7SMB",$J,LA7AA,LA760,LA7I,LA7K,LA7L,LA7M,LA7J))
 ;
 I $D(LA7X) S LA7FLAG=1
 ;
 Q
 ;
 ;
CHKMASK ; Check pattern mask for tests that match on specimen, urgency and division.
 ;
 ; Specimen, urgency, and division match
 I $D(^TMP("LA7SMB",$J,LA7AA,LA760,LA7I,LA76805,LA76205,LA7DIV)) S LA7FLAG=1,LA7K=LA76805,LA7L=LA76205,LA7M=LA7DIV Q
 ;
 ; Specimen and urgency match; any division
 I $D(^TMP("LA7SMB",$J,LA7AA,LA760,LA7I,LA76805,LA76205,0)) S LA7FLAG=1,LA7K=LA76805,LA7L=LA76205,LA7M=0 Q
 ;
 ; Specimen and division match; any urgency
 I $D(^TMP("LA7SMB",$J,LA7AA,LA760,LA7I,LA76805,0,LA7DIV)) S LA7FLAG=1,LA7K=LA76805,LA7L=0,LA7M=LA7DIV Q
 ;
 ; Specimen match; any urgency/division
 I $D(^TMP("LA7SMB",$J,LA7AA,LA760,LA7I,LA76805,0,0)) S LA7FLAG=1,LA7K=LA76805,LA7L=0,LA7M=0 Q
 ;
 ; Any specimen; urgency and division match
 I $D(^TMP("LA7SMB",$J,LA7AA,LA760,LA7I,0,LA76205,LA7DIV)) S LA7FLAG=1,LA7K=0,LA7L=LA76205,LA7M=LA7DIV Q
 ;
 ; Any specimen and division; urgency match
 I $D(^TMP("LA7SMB",$J,LA7AA,LA760,LA7I,0,LA76205,0)) S LA7FLAG=1,LA7K=0,LA7L=LA76205,LA7M=0 Q
 ;
 ; Any specimen and urgency; division match
 I $D(^TMP("LA7SMB",$J,LA7AA,LA760,LA7I,0,0,LA7DIV)) S LA7FLAG=1,(LA7K,LA7L)=0,LA7M=LA7DIV Q
 ;
 ; Any specimen, urgency or division
 I $D(^TMP("LA7SMB",$J,LA7AA,LA760,LA7I,0,0,0)) S LA7FLAG=1,(LA7K,LA7L,LA7M)=0 Q
 ;
 Q
 ;
 ;
TASKSM ; Task electronic transmission of manifest
 ;
 N MSG,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 ;
 S ZTRTN="BUILD^LA7VORM1("""_+$P(LA7SM,"^")_""")",ZTDESC="E-Transmission of Lab Shipping Manifest"
 S ZTSAVE("LA7SM")="",ZTIO="",ZTDTH=$$NOW^XLFDT
 D ^%ZTLOAD
 ;
 S MSG="Electronic Transmission of Shipping Manifest "_$S($G(ZTSK):"queued as task# "_ZTSK,1:"NOT queued!")
 D EN^DDIOL(MSG,"","!?5")
 ;
 Q
