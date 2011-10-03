LA7SMU1 ;DALOI/JMC - Shipping Manifest Utility (Cont'd);5/5/97 14:44
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,46,65,64**;Sep 27, 1994
 ;
 Q
 ;
SMW(LA7SM) ; "Write" additional information on DIC lookup of #62.48.
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
 N DIR,DIRUT,DTOUT,LRAA,X,Y
 ;
 S DIR(0)="YO",DIR("A")="Use default accession dates",DIR("B")="YES"
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
ASKPREV() ; Ask if build should exclude tests from building that have previously
 ; been removed from a manifest. Allows user to control if tests rebuild
 ; onto the same or different manifest.
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DIR(0)="YO"
 S DIR("A")="Exclude previously removed tests from building"
 S DIR("B")="YES"
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
 I '$L($G(LA7UID))!'(+$G(LA760)) Q LA7FLAG
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
DOT(LA7CODE,LA7NCS,LA7UID,LA7628) ; Determine ordered tests
 ; 
 ; Call with LA7CODE = Test code to look up
 ;            LA7NCS = name of coding system
 ;            LA7UID = accession's UID
 ;            LA7628 = ien of shipping manifest in #62.8
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
 ; Quit if no code, UID or configuration passed.
 I $G(LA7CODE)=""!($G(LA7UID)="")!($G(LA7628)="") Q LA760
 ;
 ; Using NLT codes
 I $G(LA7NCS)="99VA64" S LA764=+$O(^LAM("E",LA7CODE,0))
 ;
 ; Try NLT in case other system is returning NLT codes but not saying so
 I 'LA764,$D(^LAM("E",LA7CODE)) S LA764=+$O(^LAM("E",LA7CODE,0))
 ;
 S LA7I=0
 F  S LA7I=$O(^LAHM(62.8,LA7628,10,"UID",LA7UID,LA7I)) Q:'LA7I  D  Q:LA760
 . S LA7X=$G(^LAHM(62.8,LA7628,10,LA7I,0))
 . S LA7Y=$P(LA7X,"^",2)
 . ; Found match on NLT code
 . I LA7Y,+$P(^LAB(60,LA7Y,64),"^")=LA764 S LA760=LA7Y Q
 . ; Found match on non-VA code
 . I LA7CODE=$P($G(^LAHM(62.8,LA7628,10,LA7I,5)),"^") S LA760=LA7Y
 ;
 Q LA760
