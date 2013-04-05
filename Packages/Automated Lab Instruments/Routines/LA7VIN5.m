LA7VIN5 ;DALOI/JMC - Process Incoming UI Msgs, continued ;11/17/11  16:03
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,68,74**;Sep 27, 1994;Build 229
 ;
 ; This routine is a continuation of LA7VIN1 and is only called from there.
 ; It is called to process OBX segments for "CH" subscript tests.
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 Q
 ;
OBX ;
 ;
 N LA76241,LA76304,LA7EII,LA7I,LA7J,LA7LIMIT,LA7OBM,LA7SUBFL,LA7TEST,LA7TREEN,LA7UNITS,LA7VAL,LA7VTYP,LA7X,LA7XFORM,LA7Y
 ;
 K LA7RMK,^TMP("LA7TREE",$J)
 ;
 S LA7SUBFL=63.04
 ;
 ; OBX Set ID
 S LA7SOBX=$$P^LA7VHLU(.LA7SEG,2,LA7FS)
 ;
 ; Value type - type of data from Table 0125
 S LA7VTYP=$P($$P^LA7VHLU(.LA7SEG,3,LA7FS),LA7CS)
 ;
 ; Determine test result codes - check for primary and alternate codes
 ; For DoD/CHCS interface - do NOT process test codes using 99LRT as coding system per DoD/July 2002.
 S LA7X=$$P^LA7VHLU(.LA7SEG,4,LA7FS),(LA7RNLT,LA7RLNC)=""
 S LA7TEST=$P(LA7X,LA7CS)
 S LA7TEST(0)=$$UNESC^LA7VHLU3($P(LA7X,LA7CS,2),LA7FS_LA7ECH)
 I LA7TEST(0)["^" S LA7TEST(0)=$TR(LA7TEST(0),"^","~")
 S LA7TEST(0,1)=$P(LA7X,LA7CS,3)
 S LA7TEST(2)=$P(LA7X,LA7CS,4)
 S LA7TEST(2,0)=$$UNESC^LA7VHLU3($P(LA7X,LA7CS,5),LA7FS_LA7ECH)
 I LA7TEST(2,0)["^" S LA7TEST(2,0)=$TR(LA7TEST(2,0),"^","~")
 S LA7TEST(2,1)=$P(LA7X,LA7CS,6)
 F I=3,6 D
 . S LA7Y=$P(LA7X,LA7CS,I-2)
 . I $P(LA7X,LA7CS,I)="LN" D  Q
 . . I $P($G(^LAB(95.3,+LA7Y,0)),"^")=LA7Y S LA7RLNC=+LA7Y Q
 . . I $P($G(^LAB(95.3,+LA7Y,0)),"^")=+LA7Y S LA7RLNC=+LA7Y Q
 . . S LA7J=$O(^LAB(95.3,"B",LA7Y,0))
 . . I LA7J S LA7RLNC=LA7J
 . I $P(LA7X,LA7CS,I)="99VA64" D  Q
 . . I $$FIND1^DIC(64,"","OMX",LA7Y) S LA7RNLT=LA7Y
 . I $P(LA7X,LA7CS,I)="99LRT" D  Q
 . . I LA7TEST(0)="",LA7TEST(2,0)'="" S LA7TEST(0)=LA7TEST(2,0)
 . . I LA7TEST(2,0)="",LA7TEST(0)'="" S LA7TEST(2,0)=LA7TEST(0)
 . . I I=3 S (LA7TEST,LA7TEST(0),LA7TEST(0,1))="" Q
 . . I I=6 S (LA7TEST(2),LA7TEST(2,0),LA7TEST(2,1))="" Q
 I LA7TEST="",LA7TEST(2)'="" D
 . S LA7TEST=LA7TEST(2),LA7TEST(0)=LA7TEST(2,0),LA7TEST(0,1)=LA7TEST(2,1)
 . S (LA7TEST(2),LA7TEST(2,0),LA7TEST(2,1))=""
 ;
 ; No test code in message
 I LA7TEST="",LA7TEST(2)="" D  Q
 . N LA7OBX
 . S LA7OBX=LA7SEG(0)
 . D CREATE^LA7LOG(15)
 ;
 ; Test code not found in auto inst file, also check alternate codes,
 ; and log error if none found.
 I LA7MTYP="ORU" D  Q:LA7TEST=""
 . I LA7TEST'="",$D(^LAB(62.4,LA7624,3,"AC",LA7TEST)) Q
 . I LA7TEST(2)'="",$D(^LAB(62.4,LA7624,3,"AC",LA7TEST(2))) D  Q
 . . S LA7TEST=LA7TEST(2),LA7TEST(0)=LA7TEST(2,0),LA7TEST(0,1)=LA7TEST(2,1)
 . D CREATE^LA7LOG(16) S LA7TEST=""
 ;
 ; Units - trim leading/trailing spaces
 S LA7X=$$P^LA7VHLU(.LA7SEG,7,LA7FS),LA7UNITS=""
 I LA7X'="" D
 . F I=1:1:6 S LA7UNITS(I)=$$UNESC^LA7VHLU3($P(LA7X,LA7CS,I),LA7FS_LA7ECH)
 . S LA7UNITS=$$TRIM^XLFSTR(LA7UNITS(1),"LR"," ")
 . I LA7UNITS["^" D
 . . N LA7STR S LA7STR("^")="~U~"
 . . S LA7UNITS=$$REPLACE^XLFSTR(LA7UNITS,.LA7STR)
 ;
 ; Observation result status - Table 0085
 S LA7ORS=$$P^LA7VHLU(.LA7SEG,12,LA7FS)
 ;
 ; Responsible observer
 S LA7RO=$$XCNTFM^LA7VHLU9($$P^LA7VHLU(.LA7SEG,17,LA7FS),LA7ECH)
 ;
 ; Observation method
 S LA7X=$$P^LA7VHLU(.LA7SEG,18,LA7FS),LA7OBM=""
 I $P(LA7X,LA7CS,3)="99VA64_2" S LA7OBM=$P($P(LA7X,LA7CS,1),".",2)
 ;
 ; Equipment instance identifier
 S LA7EII=$$P^LA7VHLU(.LA7SEG,19,LA7FS)
 I LA7EII'="" D
 . S LA7EII=$$UNESC^LA7VHLU3(LA7EII,LA7FS_LA7ECH)
 . S LA7EII=$TR(LA7EII,"^",";")
 ;
 ; Process ORU message results for all tests which use this test code.
 I LA7MTYP="ORU" D  Q
 . S LA76241=0
 . F  S LA76241=$O(^LAB(62.4,LA7624,3,"AC",LA7TEST,LA76241)) Q:'LA76241  D PROCESS
 ;
 I LA7MTYP="ORM",$G(LA7696)>0 D ORESULTS^LA7VIN5B
 ;
 Q
 ;
 ;
PROCESS ; Process results for a given test code
 F LA7I=0,1,2 S LA76241(LA7I)=$G(^LAB(62.4,LA7624,3,LA76241,LA7I))
 ;
 ; Chem test fields incorrect
 I LA76241(0)="" D CREATE^LA7LOG(18) Q
 ;
 ; No dataname associated with this test - skip
 S LA76304=$P($G(^LAB(60,+$P(LA76241(0),"^"),.2)),"^")
 I LA76304<1 Q
 ;
 S LA7VAL=$$P^LA7VHLU(.LA7SEG,6,LA7FS)
 I LA7VTYP="CE",$P(LA7VAL,LA7CS,2)'="" S LA7VAL=$P(LA7VAL,LA7CS,2)
 E  S LA7VAL=$P(LA7VAL,LA7CS)
 ;
 ; Setup LA7RMK(0) variable in case comments (NTE) sent with test results.
 S LA7RMK(0,+LA76241(0))=+$P(LA76241(2),"^",7)_"^"_$P(LA76241(2),"^",8)
 ;
 ; Set flag for new results alert
 I LA7ORS'?1(1"C",1"D",1"W") S ^TMP("LA7-ORU",$J,LA76248,LA76249,"CH")=""
 ;
 ; Set flag to send amended results bulletin
 I LA7INTYP=10,LA7ORS?1(1"C",1"D",1"W") D
 . S LA7I=$O(^TMP("LA7 AMENDED RESULTS",$J,""),-1),LA7I=LA7I+1
 . S X=LA7LWL_"^"_LA7ISQN_"^"_LA76304_"^"_LA76248_"^"_LA76249_"^"_LA7ORS_"^"_LA7TEST_"^"_$S(LA7TEST(0)'="":LA7TEST(0),1:LA7TEST(2,0))_"^"_$$P^LA7VHLU(.LA7SEG,9,LA7FS)
 . S ^TMP("LA7 AMENDED RESULTS",$J,LA7I)=X
 . I LA7UID'="" S ^LAH("LA7 AMENDED RESULTS",LA7UID,LA76304,LA7LWL,LA7ISQN)=X
 ;
 ; NOTE - this array can be set from inside PARAM 1
 K LA7XFORM
 ; execute PARAM 1 if not a LEDI interface
 I LA7INTYP'=10 X $P(LA76241(0),"^",2)
 I $P(LA76241(2),"^",3)=0 Q
 I $P(LA76241(2),"^",3)=2,LA7ORS'?1(1"C",1"F",1"U",1"X") Q
 ;
 ; If OBX indicates no result for this test then store VistA "canc" value.
 I LA7ORS="X",LA7VAL="" S LA7VAL="canc"
 ;
 ; No value found
 I LA7VAL="" D  Q
 . D CREATE^LA7LOG(17)
 ;
 ; Transform result based on fields in file 62.4
 D XFORM^LA7VIN5A
 Q:LA7VAL=""
 ;
 ; Check if result passes input transform on data name
 D CHKDIE^LA7VIN5A
 Q:LA7VAL=""
 ;
 ; Set flag to not store comments if it wasn't explicitly ordered.
 I $G(LA7LIMIT)=1 D
 . N LA76804
 . K LA7LIMIT,LA7TREEN,^TMP("LA7TREE",$J)
 . ; Store all tests accessioned in ^TMP
 . S LA76804=0
 . F  S LA76804=$O(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,4,LA76804)) Q:'LA76804  D UNWIND^LA7UTIL(LA76804)
 . I '$D(^TMP("LA7TREE",$J,+LA76241(0))) S LA7LIMIT=1 ;wasn't ordered
 I $G(LA7LIMIT) D  Q
 . S $P(LA7RMK(0,+LA76241(0)),"^",1)=0
 . K LA7LIMIT,^TMP("LA7TREE",$J)
 K ^TMP("LA7TREE",$J)
 ;
 ; Check point of care interface for matching specimen type  for this test in #62.4
 I LA7INTYP>19,LA7INTYP<30 D  Q:'LA761
 . N LA70070
 . S LA761="",LA7X=$P(LA76241(2),"^",13) Q:'LA7X
 . S LA70070=$$GET1^DIQ(61,LA7X_",","LEDI HL7:HL7 ABBR")
 . I LA70070=LA7SPEC S LA761=LA7X
 ;
 ; Set data node=test value
 S $P(^LAH(LA7LWL,1,LA7ISQN,LA76304),"^")=LA7VAL
 ;
 ; Store reference ranges except for UI (LA7INTYP=1) interfaces
 I LA7INTYP'=1 D REFRNG^LA7VIN5A($$P^LA7VHLU(.LA7SEG,8,LA7FS))
 ;
 ; Store order/result codes/observation method except for UI (LA7INTYP=1) interfaces
 I LA7INTYP'=1 D
 . S LA7X=$P(^LAH(LA7LWL,1,LA7ISQN,LA76304),"^",3)
 . I LA7ONLT S $P(LA7X,"!",1)=LA7ONLT
 . I LA7RNLT S $P(LA7X,"!",2)=LA7RNLT
 . I LA7RLNC S $P(LA7X,"!",3)=LA7RLNC
 . I LA7OBM S $P(LA7X,"!",4)=LA7OBM
 . S $P(^LAH(LA7LWL,1,LA7ISQN,LA76304),"^",3)=LA7X
 ;
 ; Store abnormal flags except for UI (LA7INTYP=1) interfaces.
 I LA7INTYP'=1 D ABFLAG^LA7VIN5A($$P^LA7VHLU(.LA7SEG,9,LA7FS))
 ;
 ; Store units except for UI (LA7INTYP=1) interfaces which pull values from file #60.
 I LA7INTYP'=1,LA7UNITS'="" D
 . S LA7X=$P($G(^LAH(LA7LWL,1,LA7ISQN,LA76304)),"^",5)
 . S $P(LA7X,"!",7)=LA7UNITS
 . S $P(^LAH(LA7LWL,1,LA7ISQN,LA76304),"^",5)=LA7X
 ;
 ; Store responsible observer on POC interfaces
 I LA7RO'="",LA7INTYP>19,LA7INTYP<30 D
 . I $P(LA7RO,"^",2) S $P(^LAH(LA7LWL,1,LA7ISQN,LA76304),"^",4)=$P(LA7RO,"^",2)
 ;
 ; Store specimen type except for UI (LA7INTYP=1) interfaces which pull values from the accession.
 I LA7INTYP'=1,$G(LA761) D
 . S X=$P(^LAH(LA7LWL,1,LA7ISQN,LA76304),"^",5)
 . S $P(X,"!")=LA761
 . S $P(^LAH(LA7LWL,1,LA7ISQN,LA76304),"^",5)=X
 ;
 ; Store where test was performed except for UI (LA7INTYP=1) interfaces
 ;  also store related filler order number
 I LA7INTYP'=1 D
 . N I,LA7X,LA74
 . S LA7X=$$P^LA7VHLU(.LA7SEG,24,LA7FS),LA74=""
 . I $P(LA7X,LA7CS,6)="CLIA" D
 . . S LA74=$$IDX^XUAF4("CLIA",$P(LA7X,LA7CS,10))
 . . I LA74 S $P(^LAH(LA7LWL,1,LA7ISQN,LA76304),"^",9)=LA74
 . . E  S LA74=""
 . I LA74="" D PRDID^LA7VIN5A($$P^LA7VHLU(.LA7SEG,16,LA7FS),LA7SFAC,LA7CS)
 . I LA7FID'="" D FID
 ;
 ; Store equipment instance identifier
 I LA7EII'="" D EII^LA7VIN5A
 ;
 ; If results for LEDI interface (LA7INTYP=10) and site keeps file #60
 ; in sync with reference lab then compare message's units and normals
 ; with site's to detect changes(LA7FLAG=1) and notify site.
 I LA7INTYP=10,$G(LA761),$G(^LAB(60,+$P(LA76241(0),"^"),1,LA761,.1)) D
 . N LA760,LA7FLAG,LA7I,LA7Y,LA7X
 . S LA760=+$P(LA76241(0),"^"),LA7Y=^LAB(60,LA760,1,LA761,0),LA7FLAG=0
 . S LA7X=$P(^LAH(LA7LWL,1,LA7ISQN,LA76304),"^",5)
 . I $P(LA7Y,"^",7)'=$P(LA7X,"!",7) S LA7FLAG=1
 . I 'LA7FLAG,$P(LA7Y,"^",2)=$P(LA7X,"!",2),$P(LA7Y,"^",3)=$P(LA7X,"!",3) Q
 . I 'LA7FLAG D
 . . N AGE,DOB,PNM,SEX
 . . N LRDPF,LRNG,LRNGS,LRNG2,LRNG3,LRNG4,LRNG5,LRTREA,LRWRD,LRX,LRY
 . . I $G(LRDFN) D DEM^LRX,KVAR^VADPT
 . . S LRNG=LA7Y D NORM^LRVER5
 . . S LA7Y=$TR(LRNG,$C(34),""),LA7X=$TR(LA7X,$C(34),"")
 . . I $P(LA7Y,"^",2)=$P(LA7X,"!",2),$P(LA7Y,"^",3)=$P(LA7X,"!",3) Q
 . . S LA7FLAG=1
 . I 'LA7FLAG Q
 . S LA7I=$O(^TMP("LA7 UNITS/NORMALS CHANGED",$J,""),-1),LA7I=LA7I+1
 . S X=LA7LWL_"^"_LA7ISQN_"^"_LA76304_"^"_LA76248_"^"_LA76249_"^"_LA7ORS_"^"_LA7TEST_"^"_$S(LA7TEST(0)'="":LA7TEST(0),1:LA7TEST(2,0))_"^"_$$P^LA7VHLU(.LA7SEG,9,LA7FS)_"^"_LA760
 . S ^TMP("LA7 UNITS/NORMALS CHANGED",$J,LA7I)=X
 ;
 ; If LEDI interface and order status change store which results
 ; associated with ordered test. Used to determine if order status
 ; changed bulletin needs to be generated.
 I LA7INTYP=10,LA7SAC?1(1"A",1"G") D
 . S LA7I=$G(LA7SAC(0)) Q:'LA7I
 . S ^TMP("LA7 ORDER STATUS",$J,LA7I,+LA76241(0))=""
 Q
 ;
 ;
FID ; Store filler id
 ;
 ;ZEXCEPT: LA7LWL,LA76304,LA7FID,LA7ISQN
 N LA7STR,LA7X,I
 ;
 S LA7STR("^")="~U~",LA7X=LA7FID
 ;
 I LA7X["^" S LA7X=$$REPLACE^XLFSTR(LA7X,.LA7STR)
 ;
 F I=2:1:4 D
 . I LA7FID(I)="" Q
 . I LA7FID(I)["^" S $P(LA7X,"^",I)=$$REPLACE^XLFSTR(LA7FID(I),.LA7STR) Q
 . S $P(LA7X,"^",I)=LA7FID(I)
 ;
 S ^LAH(LA7LWL,1,LA7ISQN,.1,"OBR","FID",LA76304)=LA7X
 ;
 Q
