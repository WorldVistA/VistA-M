LA7SMU ;DALOI/JMC - Shipping Manifest Utility ;5/5/97 14:44;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,46,64**;Sep 27, 1994
 Q
 ;
CHKSM(X) ; Shipping manifest status check
 ; Call with X = ien of file #62.9 LAB SHIPPING CONFIGURATION
 ; Returns -1 = error^reason
 ;          0 = no active shipping manifest exists
 ;         >0 = ien of active shipping manifest in file #62.8, LAB SHIPPING MANIFEST
 ;
 ; No value passed
 I '$G(X) Q "-1^No configuration passed"
 ; Bad pointer passed
 I '$D(^LAHM(62.9,X,0)) Q "-1^Bad configuration pointer"
 ; Get ien of active shipping manifest.
 S Y=+$O(^LAHM(62.8,"AC1",X,0))
 I Y S Y=Y_"^"_$P(^LAHM(62.8,Y,0),"^")
 Q Y
 ;
 ;
CSM(LA7SCFG) ; Creates a new shipping manifest
 ; Call with X = ien of file #62.9 LAB SHIPPING CONFIGURATION
 ; Returns -1 = error^reason
 ;          0 = no active shipping manifest exists
 ;         >0 = ien of active shipping manifest in file #62.8, LAB SHIPPING MANIFEST
 ;
 N DATA,FDA,I,LA7CF,LA7DIE,LA7DT,LA7IEN,LA7SM,X,X4
 ;
 ; No value passed
 I '$G(LA7SCFG) Q "-1^No configuration passed"
 ;
 ; Bad pointer passed
 I '$D(^LAHM(62.9,LA7SCFG,0)) Q "-1^Bad configuration pointer"
 ;
 S LA7SCFG(0)=$G(^LAHM(62.9,LA7SCFG,0))
 ; ien of collecting facility
 S LA7CF=$P(LA7SCFG(0),"^",2)
 ; file #4 INSTITUTION information
 F I=.01,.05,99 S X4(I)=$$GET1^DIQ(4,LA7CF_",",I)
 ;
 ; Get station number else use short name
 S LA7SM=""
 I $L(X4(99)) S LA7SM=X4(99)
 E  S LA7SM=X4(.05)
 ; Failsafe value
 I LA7SM="" S LA7SM="INST:"_LA7CF
 S DT=$$DT^XLFDT,LA7DT=$E($$FMTHL7^XLFDT(DT),1,8)
 S LA7SM=LA7SM_"-"_LA7DT_"-"
 ;
 L +^LAHM(62.8,0):5 ; Set lock
 I '$T Q "-1^Unable to obtain lock on file LAB SHIPPING MANIFEST #62.8"
 S X=0
 F  S X=X+1 Q:'$D(^LAHM(62.8,"B",LA7SM_X))
 S LA7SM=LA7SM_X
 ;
 S FDA(1,62.8,"+1,",.01)=LA7SM
 S FDA(1,62.8,"+1,",.02)=LA7SCFG
 S FDA(1,62.8,"+1,",.03)=1
 I $P(LA7SCFG(0),"^",8) S FDA(1,62.8,"+1,",.04)=$P(LA7SCFG(0),"^",8)
 S FDA(1,62.8,"+1,",.05)=+$P(LA7SCFG(0),"^",15)
 S FDA(1,62.8,"+1,",.06)=+$P(LA7SCFG(0),"^",16)
 D UPDATE^DIE("","FDA(1)","LA7IEN","LA7DIE(1)")
 D RECALL^DILFD(62.8,LA7IEN(1)_",",DUZ)
 ;
 S DATA="SM01^"_$$NOW^XLFDT
 D SEUP(LA7SM,1,DATA)
 ;
 S DATA="SM02^"_$$NOW^XLFDT
 D SEUP(LA7SM,1,DATA)
 ;
 ; Release lock
 L -^LAHM(62.8,0)
 Q LA7IEN(1)_"^"_LA7SM
 ;
 ;
SMSUP(LA7SM,LA7ST,LA7EVNC) ; Shipping manifest status update.
 ; Call with LA7SM = ien of entry in file #62.8 LAB SHIPPING MAINFEST^.01 field
 ;           LA7ST = status to update
 ;         LA7EVNC = event code^event date/time (default=NOW)
 ;
 N DATA,FDA,LA7IEN
 ;
 S LA7IEN(1)=+LA7SM
 S FDA(2,62.8,+LA7SM_",",.03)=LA7ST
 D UPDATE^DIE("","FDA(2)","LA7IEN","LA7DIE(2)")
 S DATA=$P(LA7EVNC,"^")_"^"_$S($P(LA7EVNC,"^",2):$P(LA7EVNC,"^",2),1:$$NOW^XLFDT)
 D SEUP($P(LA7SM,"^",2),1,DATA)
 Q
 ;
 ;
STSUP(LA7SM,LA762801,LA7DATA) ; Shipping test status update
 ; Call with    LA7SM = ien of shipping manifest (#62.8)
 ;           LA762801 = ien of test entry on shipping manifest
 ;            LA7DATA = data to be filed
 N FDA
 S LA762801=LA762801_","_+LA7SM_","
 S FDA(62.8,62.801,LA762801,.08)=LA7DATA
 D FILE^DIE("","FDA(62.8)","LA7DIE(2)")
 Q
 ;
 ;
SEUP(LA7ID,LA7EVN,LA7DATA) ; Shipping event update
 ; Call with LA7ID = shipping identifier (manifest invoice # or UID)
 ;           LA7EVN = event type (1=shipping manifest/2=test)
 ;           LA7DATA = data to be filed
 N FDA,I,LA7IEN,X
 L +^LAHM(62.85,0) ; Set lock
 S FDA(3,62.85,"+1,",.01)=LA7ID
 S FDA(3,62.85,"+1,",.02)=$S($G(DUZ)>0:DUZ,1:.5)
 S FDA(3,62.85,"+1,",.03)=$$NOW^XLFDT
 S FDA(3,62.85,"+1,",.04)=LA7EVN
 I $L($P(LA7DATA,"^")) D
 . S X=$$EVNC($P(LA7DATA,"^"))
 . I X S FDA(3,62.85,"+1,",.05)=+X
 F I=2:1:4 I $L($P(LA7DATA,"^",I)) S FDA(3,62.85,"+1,",$P("^.07^.08^.09","^",I))=$P(LA7DATA,"^",I)
 ;
 ; Add event to lab shipping event.
 D UPDATE^DIE("","FDA(3)","LA7IEN","LA7DIE(3)")
 ; Release lock
 L -^LAHM(62.85,0)
 ;
 Q
 ;
 ;
ACCSUP(LA7UID,LA760,LA7DATA) ; Accession status update
 ; Call with LA7UID = UID of accession to update
 ;          LA7DATA = value to update (pointer to file #62.8, LAB SHIPPING MANIFEST or "@" to delete
 ;
 N FDA,LA7AA,LA7AD,LA7AN,LA7CAD,LA768,X
 S X=$Q(^LRO(68,"C",LA7UID))
 S LA7AA=$QS(X,4),LA7AD=$QS(X,5),LA7AN=$QS(X,6)
 S LA7CAD=$$AD^LA7SUTL(LA7AA) ; Get current accession date for this accession area.
 S LA7AD=LA7AD-.000000001
 F  S LA7AD=$O(^LRO(68,LA7AA,1,LA7AD)) Q:'LA7AD!(LA7AD>LA7CAD)  D
 . I '$D(^LRO(68,LA7AA,1,LA7AD,1,LA7AN)) Q
 . I $P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,.3)),"^")'=LA7UID Q
 . I '$D(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,4,LA760)) Q  ; Test not on accession.
 . S LA768=LA760_","_LA7AN_","_LA7AD_","_LA7AA_","
 . S FDA(68,68.04,LA768,9)=LA7DATA
 . D FILE^DIE("","FDA(68)","LA7DIE(68)")
 Q
 ;
 ;
SELSM(LA7SCFG,LA7SCR) ; Select shipping manifest
 ; Call with LA7SCFG = ien of file #62.9 LAB SHIPPING CONFIGURATION
 ;            LA7SCR = comma delimited list of status screen - only allow selection of manifests with matching status
 ;      Returns LA7Y = pointer to shipping manifest or error
 N D,DIC,DTOUT,DUOUT,LA7Y,X,Y
 S DIC="^LAHM(62.8,",DIC(0)="AEQ",DIC("A")="Select Shipping Manifest: "
 S DIC("S")="I $P(^LAHM(62.8,Y,0),U,2)=LA7SCFG"
 S DIC("W")="D SMW^LA7SMU1(Y)"
 I $G(LA7SCR)'="" S DIC("S")=DIC("S")_","""_LA7SCR_"""[$P(^LAHM(62.8,Y,0),U,3)"
 S D="C"
 D MIX^DIC1
 I Y<1 S LA7Y="-1^"
 E  S LA7Y=Y
 Q LA7Y
 ;
 ;
SMED(LA7SM,LA7EVC) ; Determine shipping manifest's event date
 ; Call with LA7SM = ien of entry in file #62.8 LAB SHIPPING MANIFEST
 ;          LA7EVC = event type code
 ;   Returns LA7Y = internal event date^external event date
 N LA7I,LA7X,LA7Y
 I '$G(LA7SM) Q "-1^No shipping manifest passed"
 S LA7SM(0)=$G(^LAHM(62.8,+LA7SM,0))
 S LA7EV=+$$EVNC(LA7EVC)
 I LA7EVC="SM05",$P(LA7SM(0),"^",3)'>2 Q "0^Shipping manifest has not been shipped"
 S LA7I=0,LA7Y=""
 F  S LA7I=$O(^LAHM(62.85,"B",$P(LA7SM(0),"^"),LA7I)) Q:'LA7I  D  Q:$L(LA7Y)
 . I $P($G(^LAHM(62.85,LA7I,0)),"^",5)'=LA7EV Q
 . S LA7Y=$P(^LAHM(62.85,LA7I,0),"^",7)_"^"_$$FMTE^XLFDT($P(^LAHM(62.85,LA7I,0),"^",7),"M") ; Event date/time
 I $G(LA7Y)="" S LA7Y="-2^No event date found"
 Q LA7Y
 ;
 ;
EVNC(LA7EVC) ; Resolve an event code to it's pointer/text(.01) value
 ; Call with LA7EVC = Code to lookup, i.e. SM01, SM50
 ;        Returns Y = ien of code in file #64.061, LAB ELECTRONIC CODES.
 N X,Y
 S (X,Y)=0
 F  S X=$O(^LAB(64.061,"F",LA7EVC,X)) Q:'X  D  Q:Y
 . S X(0)=$G(^LAB(64.061,X,0))
 . I $P(X(0),"^",7)="E" S Y=X_"^"_$P(X(0),"^")
 I 'Y S Y="0^Code not on file"
 Q Y
 ;
 ;
CHKTST(LA7SM,LA762801) ; Check and update if test is still valid.
 ; Call with LA7SM = ien of shipping manifest in file #62.8
 ;        LA762801 = ien of entry on test multiple in file #62.8
 ;
 ; Returns LA7SKIP = 0 (Test still on accession).
 ;                   1 (Test not on accession).
 ;                   2 (Accession deleted/purged).
 ;                   3 (Test not on accession - already shipped)
 ;                   4 (Accession deleted/purged - already shipped)
 ;
 N LA7AA,LA7AD,LA7AN,LA7DATA,LA7SKIP,LA7UID,X,Y
 S LA7SKIP=0
 S LA7SM(0)=$G(^LAHM(62.8,+LA7SM,0))
 S LA762801(0)=$G(^LAHM(62.8,+LA7SM,10,+LA762801,0))
 S LA7UID=$P(LA762801(0),"^",5)
 S X=$Q(^LRO(68,"C",LA7UID))
 S LA7AA=+$QS(X,4),LA7AD=+$QS(X,5),LA7AN=+$QS(X,6)
 ;
 ; Test found.
 I $D(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,4,+$P(LA762801(0),"^",2),0)) Q LA7SKIP
 ; Accession missing.
 I '$D(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,0)) D
 . ; Already shipped
 . I $P(LA7SM(0),"^",3)>4 S LA7SKIP=4 Q
 . S LA7SKIP=2,LA7DATA="SM62"
 ;
 ; Test missing.
 I 'LA7SKIP,'$D(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,4,+$P(LA762801(0),"^",2),0)) D
 . ; Already shipped
 . I $P(LA7SM(0),"^",3)>4 S LA7SKIP=3 Q
 . S LA7SKIP=1,LA7DATA="SM61"
 ;
 ; Update manifest/event file if test has not shipped.
 I LA7SKIP,LA7SKIP<3 D
 . ; Update test on manifest
 . D STSUP^LA7SMU(+LA7SM,LA762801,0)
 . ; Update event file
 . S LA7DATA=LA7DATA_"^"_$$NOW^XLFDT_"^"_$P(LA762801(0),"^",2)_"^"_$P(LA7SM(0),"^")
 . D SEUP^LA7SMU(LA7UID,2,LA7DATA)
 Q LA7SKIP
