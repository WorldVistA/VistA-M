LA7SM2 ;DALOI/JMC - Shipping Manifest Options ;Oct 30, 2008
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,74**;Sep 27, 1994;Build 229
 ;
REQINFO ; Enter required information prior to shipping.
 D INIT^LA7SM
 I LA7QUIT D CLEANUP^LA7SM Q
 S LA7SM=$$SELSM^LA7SMU(+LA7SCFG,"0,1,3")
 I LA7SM<0 D  Q
 . D EN^DDIOL($P(LA7SM,"^",2),"","!?5")
 . D CLEANUP^LA7SM
 D LOCKSM^LA7SM
 I LA7QUIT D  Q
 . D EN^DDIOL($P(LA7QUIT,"^",2),"","!?5")
 . D UNLOCKSM^LA7SM,CLEANUP^LA7SM
 S LA7SM(0)=$G(^LAHM(62.8,+LA7SM,0))
 F  D INFOEE^LA7SM2A Q:LA7QUIT
 D UNLOCKSM^LA7SM
 I LA7QUIT,$P(LA7QUIT,"^",2)'="" D EN^DDIOL($P(LA7QUIT,"^",2),"","!?5")
 E  D ASK^LA7SMP(LA7SM)
 D CLEANUP^LA7SM
 Q
 ;
 ;
CHKREQI(LA7628,LA762801) ; Check for required info/incomplete setup
 ; Call with LA7628 = ien of entry in file #62.8
 ;         LA762801 = ien of entry in file #62.8, TEST subfile
 ;
 ; If errors sets LA7ERR array with error messages and TMP(LA7ERR",$J)
 ;    with specific tests.
 ;
 N LA7ERMSG,LA7FILE,LA7FLD,LA7SCFG,LA7I,LA7J,LA7X,LA7Y,LRSS
 ;
 S LA7ERR=$G(LA7ERR,0),LA7ERMSG=""
 S LA7628(0)=$G(^LAHM(62.8,LA7628,0))
 S LA7SCFG=$P(LA7628(0),"^",2)
 S LA7SCFG(0)=$G(^LAHM(62.9,LA7SCFG,0))
 ;
 F LA7J=0,1,2,5 S LA7I(LA7J)=$G(^LAHM(62.8,LA7628,10,LA762801,LA7J))
 ;
 S LA7FILE=62.801
 ;
 I $P(LA7I(1),"^") D
 . F LA7J=2,3,7 I $P(LA7I(1),"^",LA7J)="" S LA7FLD=$S(LA7J=2:1.11,LA7J=3:1.13,1:1.14) D SETERR
 ;
 I $P(LA7I(1),"^",4) D
 . F LA7J=5,6,8 I $P(LA7I(1),"^",LA7J)="" S LA7FLD=$S(LA7J=5:1.21,LA7J=6:1.23,1:1.24) D SETERR
 ;
 I $P(LA7I(2),"^") D
 . F LA7J=2,3,11 I $P(LA7I(2),"^",LA7J)="" S LA7FLD=$S(LA7J=2:2.11,LA7J=3:2.13,1:2.14) D SETERR
 ;
 I $P(LA7I(2),"^",4) D
 . F LA7J=5,6,7,12 I $P(LA7I(2),"^",LA7J)="" S LA7FLD=$S(LA7J=5:2.21,LA7J=6:2.22,LA7J=7:2.23,1:2.24) D SETERR
 ;
 I $P(LA7I(2),"^",8) D
 . F LA7J=9,10,13 I $P(LA7I(2),"^",LA7J)="" S LA7FLD=$S(LA7J=9:2.31,LA7J=10:2.33,1:2.34) D SETERR
 ;
 ; Check if using non-VA codes
 I $P(LA7628(0),"^",5) D
 . F LA7J=1,2 I $P(LA7I(5),"^",LA7J)="" S LA7FLD=$S(LA7J=1:5.1,1:5.2) D SETERR
 I '$$GET1^DIQ(60,+$P(LA7I(0),"^",2)_",",64,"I") S LA7FILE=60,LA7FLD=64 D SETERR
 I 'LA7ERR,$O(LA7ERR(""))'="" S LA7ERR=1
 ;
 ; Check if accession for "CH" or "MI" subscript test has specimen
 ; Check if AP accessions have specimens specified in file #63
 S LRSS=$P($G(^LAB(60,$P(LA7I(0),"^",2),0)),"^",4)
 I LRSS?1(1"CH",1"MI"),'$P(LA7I(0),"^",3) S LA7FILE=62.801,LA7FLD=.03,LA7ERMSG="No specimen specified for accession" D SETERR
 I LRSS?1(1"SP",1"CY",1"EM") D CHKAP
 ;
 ; Check specimen has SNOMED CT ID, HL7 code or non-HL7 specimen code.
 I $P(LA7I(0),"^",3) D
 . N LA761
 . S LA761=$P(LA7I(0),"^",3)
 . I $P($G(^LAB(61,LA761,"SCT")),"^")'="" Q
 . I $P(LA7I(5),"^",3)'="" Q
 . I $P($G(^LAB(61,LA761,0)),"^",9) Q
 . S LA761(0)=$$GET1^DIQ(61,LA761,.01),LA7FILE=61
 . I LRSS="CH",'$P($G(^LAB(61,LA761,0)),"^",9)  D
 . . S LA7FLD=.09,LA7ERMSG="No LEDI HL7 code (field #.09) specified in TOPOGRAPHY file (#61) for entry "_LA761(0)_" (#"_LA761_")"
 . . D SETERR
 . S LA7FLD=20,LA7ERMSG="No SNOMED CT ID (field #20) specified in TOPOGRAPHY file (#61) for entry "_LA761(0)_" (#"_LA761_")"
 . D SETERR
 ;
 Q
 ;
 ;
SETERR ; Set error log for entries missing values in 62.8
 ; Called from above.
 ;
 S LA7ERR(LA7FILE_":"_LA7FLD)="Missing Required Info - "_$$GET1^DID(LA7FILE,LA7FLD,"","LABEL")
 I $G(LA7ERMSG)'="" S LA7ERR(LA7FILE_":"_LA7FLD,.1)=LA7ERMSG
 S ^TMP("LA7ERR",$J,LA7FILE_":"_LA7FLD,LA7628,$P(LA7I(0),"^",5),$P(LA7I(0),"^",2))=""
 S LA7ERMSG=""
 Q
 ;
 ;
CHKAP ; Check AP subscripts for specimen and associated topographies
 N LA7ERMSG,LA7FILE,LA7FLD,LA7J,LA7OK,LRAA,LRAD,LRAN,LRDFN,LRIDT,LRUID,X
 ;
 S LRDFN=+LA7I(0),LRUID=$P(LA7I(0),"^",5),LA7OK=1
 S X=$Q(^LRO(68,"C",LRUID)) Q:X=""
 I LRUID'=$QS(X,3) Q  ; Skip - UID missing.
 S LRAA=+$QS(X,4),LRAD=+$QS(X,5),LRAN=+$QS(X,6),LRIDT=+$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),"^",5)
 S LA7FILE=$S(LRSS="SP":63.812,LRSS="CY":63.902,LRSS="EM":63.202,1:0)
 ;
 ; Check for missing specimen node (.1) 
 I '$O(^LR(LRDFN,LRSS,LRIDT,.1,0)) D  Q
 . S LA7OK=0,LA7FLD=.01,LA7ERMSG="No specimen entered for accession."  D SETERR
 ;
 ; Check for pointer to file #61 for each free text specimen.
 S LA7J=0
 F  S LA7J=$O(^LR(LRDFN,LRSS,LRIDT,.1,LA7J)) Q:'LA7J  I '$P(^(LA7J,0),"^",6) D
 . S LA7OK=0,LA7FLD=.06,LA7ERMSG="No topography specified for specimen on accession." D SETERR
 ;
 Q
 ;
 ;
BUILDRI ; Build global with required info to print on manifest.
 ; Called from LA7SMP
 ;
 N LA7I,LA7X
 ;
 ; No required info
 I $G(LA762801(1))="",$G(LA762801(2))="" Q
 ;
 F LA7I=1,2 S LA7X(LA7I)=$G(^TMP("LA7SMRI",$J,+$P(LA762801(0),"^",7),+$P(LA762801(0),"^",9),$P(LA762801(0),"^",5),LA7I))
 ;
 ; Check for patient required info.
 F LA7I=1,4 I $P($G(LA762801(1)),"^",LA7I) D
 . S $P(LA7X(1),"^",LA7I)=$P(LA762801(1),"^",LA7I)
 . I LA7I=1 S $P(LA7X(1),"^",2,3)=$P(LA762801(1),"^",2,3) Q
 . I LA7I=4 S $P(LA7X(1),"^",5,6)=$P(LA762801(1),"^",5,6) Q
 ;
 ; Check for specimen required info.
 F LA7I=1,4,8 I $P($G(LA762801(2)),"^",LA7I) D
 . S $P(LA7X(2),"^",LA7I)=$P(LA762801(2),"^",LA7I)
 . I LA7I=1 S $P(LA7X(2),"^",2,3)=$P(LA762801(2),"^",2,3) Q
 . I LA7I=4 S $P(LA7X(2),"^",5,7)=$P(LA762801(2),"^",5,7) Q
 . I LA7I=8 S $P(LA7X(2),"^",9,10)=$P(LA762801(2),"^",9,10) Q
 ;
 ; Store required info for printing
 F LA7I=1,2 I $G(LA7X(LA7I))'="" S ^TMP("LA7SMRI",$J,+$P(LA762801(0),"^",7),+$P(LA762801(0),"^",9),$P(LA762801(0),"^",5),LA7I)=LA7X(LA7I)
 ;
 Q
 ;
 ;
RCI ; Enter/edit relevant clinical information
 N DA,FDA,LA7628,LA762801,LA7DIR,LA7QUIT,LA7TCNT,LA7Y
 D INIT^LA7SM
 I LA7QUIT D CLEANUP^LA7SM Q
 S LA7SM=$$SELSM^LA7SMU(+LA7SCFG,"0,1,3")
 I LA7SM<0 D  Q
 . D EN^DDIOL($P(LA7SM,"^",2),"","!?5")
 . D CLEANUP^LA7SM
 D LOCKSM^LA7SM
 I LA7QUIT D  Q
 . D EN^DDIOL($P(LA7QUIT,"^",2),"","!?5")
 . D UNLOCKSM^LA7SM,CLEANUP^LA7SM
 S LA7SM(0)=$G(^LAHM(62.8,+LA7SM,0))
 D SEL^LA7SM
 I LA7QUIT D UNLOCKSM^LA7SM,CLEANUP^LA7SM Q
 S (LA7I,LA7TCNT)=0
 F  S LA7I=$O(^LAHM(62.8,+LA7SM,10,"UID",LA7UID,LA7I)) Q:'LA7I  D
 . S LA7I(0)=$G(^LAHM(62.8,+LA7SM,10,LA7I,0))
 . I $P(LA7I(0),"^",8)=0 Q  ; Previously "removed".
 . I $P(LA7I(0),"^",8),$P(LA7I(0),"^",8)'=1 S LA7QUIT="1^Accession not pending shipment" Q
 . S LA7TCNT=LA7TCNT+1,LA760(LA7TCNT)=LA7I_"^"_LA7I(0)
 I 'LA7TCNT,'LA7QUIT S LA7QUIT="1^Accession is not on this shipping manifest"
 I LA7QUIT D UNLOCKSM^LA7SM,CLEANUP^LA7SM Q
 S LA7I=0
 F  S LA7I=$O(LA760(LA7I)) Q:'LA7I  D EN^DDIOL(LA7I_" "_$P($G(^LAB(60,+$P(LA760(LA7I),"^",3),0)),"^"),"","!?5")
 S DIR(0)="LO^1:"_LA7TCNT,DIR("A")="Select test(s) to edit clinical info"
 D ^DIR
 I $D(DIRUT) S LA7QUIT=1 D UNLOCKSM^LA7SM,CLEANUP^LA7SM Q
 M LA7YARRY=Y
 K DIR
 D FIELD^DID(62.801,.1,,"DESCRIPTION;FIELD LENGTH;HELP-PROMPT","LA7DIR")
 S LA7X=$P($G(^LAHM(62.9,+$P(LA7SM(0),"^",2),0)),"^",3)
 I $$NVAF^LA7VHLU2(LA7X)=1 D
 . S LA7DIR("FIELD LENGTH")=78
 . S LA7DIR("HELP-PROMPT")="Answer must be 1-78 characters in length."
 S DIR(0)="FAO^1:"_LA7DIR("FIELD LENGTH"),DIR("A")="Relevant clinical information: "
 M DIR("?")=LA7DIR("DESCRIPTION"),DIR("?")=LA7DIR("HELP-PROMPT")
 S LA7Y="",LA7628=+LA7SM,LA7QUIT=0
 F  S LA7Y=$O(LA7YARRY(LA7Y)) Q:LA7Y=""  D  Q:LA7QUIT
 . F LA7I=1:1 Q:'$P(LA7YARRY(LA7Y),",",LA7I)  D  Q:LA7QUIT
 . . K DA,DIRUT,DUOUT,DTOUT,FDA,LA7DIE
 . . S LA7X=$P(LA7YARRY(LA7Y),",",LA7I),DA=+LA760(LA7X)
 . . S LA762801=DA_","_LA7628_","
 . . W !,"For test: ",$$GET1^DIQ(62.801,LA762801,.02)
 . . S DIR("B")=$$GET1^DIQ(62.801,LA762801,.1)
 . . I DIR("B")="" K DIR("B")
 . . D ^DIR
 . . I $D(DIRUT),X'="@" S LA7QUIT=1 Q
 . . I Y="",X="@" S Y="@"
 . . S FDA(62.8,62.801,LA762801,.1)=Y
 . . D FILE^DIE("","FDA(62.8)","LA7DIE(1)")
 ;
 D UNLOCKSM^LA7SM,CLEANUP^LA7SM
 Q
