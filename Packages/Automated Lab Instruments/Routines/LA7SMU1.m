LA7SMU1 ;DALOI/JMC - Shipping Manifest Utility (Cont'd) ;Jun 14, 2022@18:38
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,46,65,64,74,101,103**;Sep 27, 1994;Build 3
 ;
 Q
 ;
SMW(LA7SM) ; "Write" additional information on DIC lookup of #62.8.
 ; Called by DIC("W")
 ; Call with LA7SM = ien of entry in file #62.8
 ;
 N LA7X,LA7Y,LA7EVC
 ;
 S LA7SM(0)=$G(^LAHM(62.8,LA7SM,0))
 ; Shipping configuration
 S LA7X=" "_$P($G(^LAHM(62.9,$P(LA7SM(0),"^",2),0)),"^")
 S LA7X=LA7X_" Status: "_$$EXTERNAL^DILFD(62.8,.03,"",$P(LA7SM(0),"^",3))
 S LA7EVC="SM"_$S($P(LA7SM(0),"^",3)=0:"00",1:$P("02^03^04^05^07","^",+$P(LA7SM(0),"^",3)))
 S LA7Y=$$SMED^LA7SMU(LA7SM,LA7EVC)
 S LA7X=LA7X_" as of "_$P(LA7Y,"^",2)
 D EN^DDIOL(LA7X,"","?18")
 Q
 ;
 ;
ADATE ; Select accession dates if specified
 ;
 ;ZEXCEPT: LA7629,LA7AA,LA7QUIT,LA7SCFG
 ;
 N DIR,DIRUT,DTOUT,LRAA,X,Y
 ;
 S DIR(0)="YO",DIR("A")="Use default accession dates"
 ;
 S DIR("B")=""
 I +$G(LA7SCFG)>0 D
 . N X
 . S X=$$GET^XPAR("USR^PKG","LR MANIFEST DEFLT ACCESSION","`"_+LA7SCFG,"Q")
 . I X'="" S DIR("B")=$S(X=1:"YES",1:"NO")
 I DIR("B")="" S DIR("B")="YES"
 ;
 S DIR("?",1)="Enter ""YES"" to use the current accession date for each accession area utilized by this shipping configuration."
 S DIR("?",2)=" "
 S DIR("?")="If you select ""NO"" then you will be asked to specify a specific accession date and starting and ending accession numbers for each accession area."
 D ^DIR
 ; User aborted
 I $D(DIRUT) S LA7QUIT=1 Q
 ; Use default accession dates
 I Y=1 Q
 ;
 S X=0
 F  S X=$O(^LAHM(62.9,+LA7SCFG,60,X)) Q:'X  D
 . S X(0)=$G(^LAHM(62.9,+LA7SCFG,60,X,0))
 . I $P(X(0),"^",2),'$D(LA7AA($P(X(0),"^",2))) S LA7AA($P(X(0),"^",2))=""
 ;
 S LA7AA=0
 F  S LA7AA=$O(LA7AA(LA7AA)) Q:'LA7AA  D  Q:LA7QUIT
 . N %DT,DTOUT,LRAA,LRAD,LREND,LRFAN,LRLAN
 . D EN^DDIOL("For Accession Area: "_$P($G(^LRO(68,LA7AA,0)),"^"),"","!!?2")
 . S LRAA=LA7AA D ADATE^LRWU3
 . I Y<1!($G(DTOUT)) S LA7QUIT=1 Q
 . S LA7AA(LA7AA)=$G(LRAD)
 . D LRAN^LRWU3
 . I LREND S LA7QUIT=1 Q
 . S LA7AA(LA7AA)=$G(LRAD)_"^"_$G(LRFAN)_"^"_$G(LRLAN)
 Q
 ;
 ;
ASKPREV(LA7629) ; Ask if build should exclude tests from building that have previously
 ; been removed from a manifest. Allows user to control if tests rebuild
 ; onto the same or different manifest.
 ;
 ; Call with LA7629 = ien of shipping configuration in file #62.9
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DIR(0)="YO"
 S DIR("A")="Exclude previously removed tests from building"
 ;
 S DIR("B")=""
 I $G(LA7629)>0 D
 . N X
 . S X=$$GET^XPAR("USR^PKG","LR MANIFEST EXC PREV TEST","`"_LA7629,"Q")
 . I X'="" S DIR("B")=$S(X=1:"YES",1:"NO")
 I DIR("B")="" S DIR("B")="YES"
 ;
 S DIR("?",1)="Answer 'YES' if you do NOT want tests previously removed"
 S DIR("?",2)="from a manifest to be added to this manifest."
 S DIR("?",3)=" "
 S DIR("?",4)="Answer 'NO' if you WANT tests to be added to this manifest"
 S DIR("?",5)="that were previously removed from a manifest and are"
 S DIR("?")="otherwise eligible to be added."
 D ^DIR
 Q $S($D(DIRUT):-1,1:+Y)
 ;
 ;
PREV(LA7UID,LA760) ; Determine if test previously removed from a manifest.
 ; Checks all manifests for accession/test combination.
 ; Call with LA7UID = accession's uid
 ;            LA760 = file #60 test ien
 ;
 ; Returns 0 = not previously removed from a manifest
 ;         1 = previously removed from a manifest
 ;
 ; Called by LA7SMB
 ;
 N LA7628,LA762801,LA7FLAG,LA7ROOT,LA7X
 ;
 S LA7FLAG=0
 I ($G(LA7UID)="")!'($G(LA760)) Q LA7FLAG
 S LA7ROOT="^LAHM(62.8,""UID"",LA7UID)"
 F  S LA7ROOT=$Q(@LA7ROOT) Q:$QS(LA7ROOT,3)'=LA7UID  D  Q:LA7FLAG
 . ; Manifest and specimen ien
 . S LA7628=$QS(LA7ROOT,4),LA762801=$QS(LA7ROOT,5)
 . S LA7X=$G(^LAHM(62.8,LA7628,10,LA762801,0))
 . ; Found previous test removal
 . I $P(LA7X,"^",2)=LA760,$P(LA7X,"^",8)=0 S LA7FLAG=1
 Q LA7FLAG
 ;
 ;
SHIPCK(LA7UID,LA7AA,LA760,LA7628) ; Determine if test previously shipped and still eligible for shipping on another manifest
 ; Call with LA7UID = accession's UID
 ;            LA7AA = accession's accession area
 ;            LA760 = accession's file #60 test ien
 ;           LA7628 = ien of previously shipped manifest (optional)
 ;
 ; Returns 0 = not previously shipped or eligible for reshipping on this manifest
 ;         1 = previously shipped
 ;
 N LA7629,LA7FLAG,LA7I,LA7X
 S LA7FLAG=0,LA7628=+$G(LA7628)
 ; Test already on another manifest
 I LA7628 S LA7FLAG=1
 ; If test on another manifest then check if manifest and test received and test eligible for another shipping configuration's manifest
 ;  Test must also be associated with a manifest from the specified shipping configuration.
 I LA7628,LA7UID'="" D
 . S LA7629=+$P($G(^LAHM(62.8,LA7628,0)),"^",2)
 . I '$D(^TMP("LA7SMB-R",$J,LA7629,LA7AA,LA760)) Q
 . I $P($G(^LAHM(62.8,LA7628,0)),"^",3)'=5 Q
 . S LA7I=0
 . F  S LA7I=$O(^LAHM(62.8,LA7628,10,"UID",LA7UID,LA7I)) Q:'LA7I  D  Q:LA7FLAG=0
 . . S LA7X=$G(^LAHM(62.8,LA7628,10,LA7I,0))
 . . I $P(LA7X,"^",2)=LA760,$P(LA7X,"^",8)=3 S LA7FLAG=0
 Q LA7FLAG
 ;
 ;
DOT(LA7CODE,LA7NCS,LA7UID,LA7628,LA7629) ; Determine ordered tests
 ;
 ; Call with LA7CODE = Test code to look up
 ;            LA7NCS = name of coding system
 ;            LA7UID = accession's UID
 ;            LA7628 = ien of shipping manifest in #62.8
 ;            LA7629 = ien of shipping configuration in #62.9
 ;
 ; Returns     LA760 = ien of test entry in file #60 if found
 ;
 ; Given a test code, accession and a shipping manifest finds the
 ; file #60 test which is associated with the test code on the manifest.
 ;
 ; Called from LA7VIN4 to determine ordered test and update shipping event.
 N LA760,LA764,LA7I,LA7X,LA7Y
 ;
 S (LA760,LA764)=0
 ;LA*5.2*101: Delete requirement that LA7628 variable
 ;            be passed in.
 ; Quit if no code or UID passed.
 I $G(LA7CODE)=""!($G(LA7UID)="") Q LA760
 ;
 ; Using NLT codes
 I $G(LA7NCS)="99VA64" S LA764=+$O(^LAM("E",LA7CODE,0))
 ;
 ; Try NLT in case other system is returning NLT codes but not saying so
 I 'LA764,$D(^LAM("E",LA7CODE)) S LA764=+$O(^LAM("E",LA7CODE,0))
 ;
 S LA7I=0
 ;LA*5.2*101: Add check as to whether shipping manifest (LA7628) was passed.
 I LA7628]"" F  S LA7I=$O(^LAHM(62.8,LA7628,10,"UID",LA7UID,LA7I)) Q:'LA7I  Q:LA760  D
 . S LA7X=$G(^LAHM(62.8,LA7628,10,LA7I,0))
 . S LA7Y=$P(LA7X,"^",2)
 . ; Found match on NLT code
 . I LA7Y,+$P(^LAB(60,LA7Y,64),"^")=LA764 S LA760=LA7Y Q
 . ; Found match on non-VA code
 . I LA7CODE=$P($G(^LAHM(62.8,LA7628,10,LA7I,5)),"^") S LA760=LA7Y
 ;
 ;LA*5.2*101: If ordered test IEN has not yet been determined, try further.
 ;This section is necessary if no shipping manifest identifier was sent by
 ;the host site or there is no match for the tests on the shipping manifest
 ;identifier. This could occur for reflex scenarios or when the host site
 ;is not a VistA site.
 I 'LA760 D
 . N LA7STRX,LA7AAX,LA7ADX,LA7ANX,LA7TSTX,LA7629TX
 . S LA7STRX=$Q(^LRO(68,"C",LA7UID))
 . Q:$TR($P(LA7STRX,",",2),"""","")'="C"
 . Q:$TR($P(LA7STRX,",",3),"""","")'=LA7UID
 . ;LA7AAX = Accession area IEN
 . ;LA7ADX = Accession date
 . ;LA7ANX = Accession number
 . S LA7AAX=$P(LA7STRX,",",4),LA7ADX=$P(LA7STRX,",",5),LA7ANX=$TR($P(LA7STRX,",",6),")","")
 . ;Should not be null, but checking to be sure.
 . Q:LA7AAX=""!(LA7ADX="")!(LA7ANX="")
 . ;Check each test on the accession and see if there is a match for the
 . ;NATIONAL VA LAB CODE field (i.e. variable LA764).
 . S LA7TSTX=0
 . F  S LA7TSTX=$O(^LRO(68,LA7AAX,1,LA7ADX,1,LA7ANX,4,LA7TSTX)) Q:'LA7TSTX  Q:LA760  D
 . . ;If a profile was partially resulted at the host site, the panel breaks
 . . ;apart into the pending test components in the collecting site's file 68.
 . . ;The host site might be sending subsequent results for the panel under separate
 . . ;OBR segments for each remaining pending test component.
 . . I LA764,$P($G(^LAB(60,LA7TSTX,64)),"^")=LA764 S LA760=LA7TSTX Q
 . . ;Is the host site sending a "NON-NLT TEST ORDER CODE" which is a match.
 . . I LA7629]"" D
 . . . S LA7629TX=$O(^LAHM(62.9,LA7629,60,"B",LA7TSTX,"")) Q:LA7629TX=""
 . . . I LA7CODE=$P($G(^LAHM(62.9,LA7629,60,LA7629TX,5)),"^") S LA760=LA7TSTX
 . . Q:LA760
 . . ;Check profile components if no match found yet.
 . . ;In this scenario, the host site is sending individual HL7 OBR
 . . ;segments for each component test on the profile.
 . . N LA7PROF,LA7PRX
 . . S LA7PROF=0
 . . F  S LA7PROF=$O(^LAB(60,LA7TSTX,2,LA7PROF)) Q:'LA7PROF  D
 . . . S LA7PRX=$P($G(^LAB(60,LA7TSTX,2,LA7PROF,0)),"^")
 . . . ;Should not be null, but checking to be sure.
 . . . Q:LA7PRX=""
 . . . I LA764,$P($G(^LAB(60,LA7PRX,64)),"^")=LA764 S LA760=LA7PRX
 . . ;LA*5.2*103 begin:
 . . ;If a non-VistA (i.e. Quest) interface, shipping manifest has
 . . ;not been sent and National VA Lab code also not sent, check
 . . ;to see if vendor sent a defined Non-NLT Test Order Code.
 . . Q:LA7629
 . . N LA7628X
 . . S LA7628X=$P(^LRO(68,LA7AAX,1,LA7ADX,1,LA7ANX,4,LA7TSTX,0),"^",10)
 . . ;If this test was not sent on a shipping manifest identifier, cannot
 . . ;determine ordered test. Status will remain at "Test shipped" on the
 . . ;Incomplete Test Status Report.
 . . Q:LA7628X=""
 . . ;Adding $G just in case the manifest was deleted, which is unlikely.
 . . S LA7629=$P($G(^LAHM(62.8,LA7628X,0)),U,2)
 . . Q:LA7629=""
 . . S LA7629TX=$O(^LAHM(62.9,LA7629,60,"B",LA7TSTX,"")) Q:LA7629TX=""
 . . I LA7CODE=$P($G(^LAHM(62.9,LA7629,60,LA7629TX,5)),"^") S LA760=LA7TSTX
 . . ;If the vendor did not send a defined Non-NLT Test Order Code, the status
 . . ;on the Incomplete Test Status Report will remain at "Test shipped".
 . . ;LA*5.2*103 end.
 Q LA760
 ;
HLP62(LR62) ; Display help for collection sample/topography
 ;
 ; Call with LR62 = ien of collection sample
 ;
 ;ZEXCEPT: IOM
 ;
 I $G(LR62)<1 Q
 ;
 N DIWF,DIWL,DIWR,LR61,LRTXT,X
 ;
 S DIWF="",DIWL=5,DIWR=IOM
 K ^UTILITY($J,"W")
 S LR62(0)=$G(^LAB(62,LR62,0))
 I $P(LR62(0),"^",2) S LR61=$P(LR62(0),"^",2),LR61(0)=$G(^LAB(61,LR61,0))
 E  S (LR61,LR61(0))=""
 ;
 I LR61<1 D
 . S X="NOTE: The collection sample "_$P(LR62(0),"^")_" [IEN "_LR62_"] does NOT have a default specimen."
 . D ^DIWP
 . S X="Therefore at the SPECIMEN field prompt specify the specimen type to use to build pending orders from incoming order messages."
 . D ^DIWP
 ;
 I LR61>0 D
 . S X="NOTE: The collection sample "_$P(LR62(0),"^")_" [IEN "_LR62_"] has a default specimen of "_$P(LR61(0),"^")_" [IEN "_LR61_"]."
 . D ^DIWP
 . S X="If you want to use this specimen then leave the SPECIMEN field blank at the next prompt."
 . D ^DIWP
 . S X=" "
 . D ^DIWP
 . S X="If you want to use this collection sample with a different specimen type then at the SPECIMEN field prompt specify the specimen type to use"
 . D ^DIWP
 . S X="to build pending orders from incoming order messages."
 . D ^DIWP
 D ^DIWW
 K ^UTILITY($J,"W")
 Q
