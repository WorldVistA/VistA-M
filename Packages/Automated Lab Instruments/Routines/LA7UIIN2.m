LA7UIIN2 ;DALOI/JRR - Process Incoming UI Msgs, continued ; 12/3/1997
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**17,23,27,46**;Sep 27, 1994
 ;This routine is a continuation of LA7UIIN1 and is only called from there.
 ;It is called to begin processing the NTE & OBX segments.
 QUIT
 ;
NTE ; Process NTE segments that follow the OBR and OBX segments
 ; These NTE segments contain comments from instruments or other facilities.
 ; NTE segments following OBR's contain comments which refer to the entire test battery.
 ; NTE segments following OBX's contain comments which are test specific.
 ; Test specific comments can be prefaced with a site defined prefix -
 ;   see field REMARK PREFIX (#19) in CHEM TEST multiple of AUTOMATED INSTRUMENT (#62.4 file.
 ; NTE segments are not allowed anywhere except after the OBR or OBX segments.
 ; There can be more than one NTE, each will be stored as a comment in ^LAH.
 ;
 F LA762495=LA762495:0 S LA762495=$O(^LAHM(62.49,LA76249,150,LA762495)) Q:'LA762495  S LA7NTE=$G(^(LA762495,0)) Q:$E(LA7NTE,1,3)'="NTE"  D
 . N LA7,LA7I
 . S LA7RMK=$P(LA7NTE,LA7FS,4)
 . S LA7=$RE(LA7RMK)
 . F LA7I=1:1:$L(LA7)  Q:$E(LA7,LA7I)'=" "  ; Find start of trailing spaces.
 . S LA7RMK=$E(LA7RMK,1,($L(LA7RMK)-LA7I+1)) ; Truncate trailing spaces.
 . I LA7RMK=$TR($P($G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,3)),"^",6),"~") Q  ; Don't store remark if same as specimen comment (without "~").
 . I LA7RMK=$G(^LR(+$G(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,0)),.091)) Q  ; or patient info (#.091 in file 63) - info previously downloaded
 . I LA7RMK="" Q  ; No remark to store.
 . I $O(LA7RMK(0,0)) D  Q  ; If test specific, store test name with comments (see below)
 . . N LA7I
 . . S LA7I=0
 . . F  S LA7I=$O(LA7RMK(0,LA7I)) Q:'LA7I  I $P(LA7RMK(0,LA7I),"^") D RMKSET^LASET(LA7LWL,LA7ISQN,LA7RMK,$P(LA7RMK(0,LA7I),"^",2))
 . I $P(LA7INST,"^",17) D RMKSET^LASET(LA7LWL,LA7ISQN,LA7RMK,"") ;store comment in 1 node of ^LAH global
 K LA7RMK
 Q:LA762495=""  ;no more segments to process
 ;
OBX F LA762495=LA762495-1:0 S LA762495=$O(^LAHM(62.49,LA76249,150,LA762495)) Q:'LA762495  K LA7OBX S LA7OBX=^(LA762495,0) Q:$E(LA7OBX,1,3)'="OBX"  D
 . K LA7RMK
 . S LA7TEST=$P($P(LA7OBX,LA7FS,4),LA7CS,1)
 . I LA7TEST="" D  QUIT
 . . D CREATE^LA7LOG(15)
 . I '$D(^LAB(62.4,LA7624,3,"AC",LA7TEST)) D  QUIT  ;test code not found in auto inst file
 . . D CREATE^LA7LOG(16)
 . S LA76241=0 ; Process results for all tests which use this test code.
 . F  S LA76241=$O(^LAB(62.4,LA7624,3,"AC",LA7TEST,LA76241)) Q:'LA76241  D
 . . S LA7VAL=$P(LA7OBX,LA7FS,6)
 . . F LA7I=0,1,2 S LA76241(LA7I)=$G(^LAB(62.4,LA7624,3,LA76241,LA7I))
 . . I (LA76241(0)="")!(LA76241(1)="") D  QUIT  ;chem test fields incorrect
 . . . D CREATE^LA7LOG(18)
 . . ; Setup LA7RMK(0) variable in case comments (NTE) sent with test results.
 . . S LA7RMK(0,+LA76241(0))=+$P(LA76241(2),"^",7)_"^"_$P(LA76241(2),"^",8)
 . . K LA7XFORM ;this array can be set from inside PARAM 1
 . . X $P(LA76241(0),"^",2) ;execute PARAM 1
 . . I LA7VAL="" D  QUIT  ;no value
 . . . D CREATE^LA7LOG(17)
 . . D XFORM ;transform result based on fields in file 62.4
 . . Q:LA7VAL=""
 . . I $G(LA7LIMIT)=1 D  ;flag to not store if wasn't explicitly ordered
 . . . K LA7LIMIT,LA7TREEN,^TMP("LA7TREE",$J)
 . . . F LA76804=0:0 S LA76804=$O(^LRO(68,LA7AA,1,LA7AD,1,LA7AN,4,LA76804)) Q:'LA76804  D UNWIND^LA7UTIL(LA76804) ;store all tests accessioned in ^TMP
 . . . I '$D(^TMP("LA7TREE",$J,+LA76241(0))) S LA7LIMIT=1 ;wasn't ordered
 . . I $G(LA7LIMIT) D  QUIT  ;don't store
 . . . S $P(LA7RMK(0,+LA76241(0)),"^",1)=0 ; Set flag to not store comments if any.
 . . . K LA7LIMIT,^TMP("LA7TREE",$J)
 . . K ^TMP("LA7TREE",$J)
 . . S LA76304=+$P(LA76241(1),"(",2) ;lab data field
 . . I LA76304'>1 D  Q  ; No dataname for this result
 . . . D CREATE^LA7LOG(18)
 . . S ^LAH(LA7LWL,1,LA7ISQN,LA76304)=LA7VAL ;set data node=test value
 . . D REFRNG($P(LA7OBX,LA7FS,8)) ; Store reference ranges
 . . D ABFLAG($P(LA7OBX,LA7FS,9)) ; Store abnormal flags
 . . D PRDID($P(LA7OBX,LA7FS,16),LA7CS) ; Store where test was performed.
 I $E(LA7OBX,1,3)="NTE" S LA762495=LA762495-1 G NTE
 K LA7RMK
 Q
 ;
XFORM ; Transform the result based on fields 12,13,14,16,17 in the Chem Test
 ; multiple in the Auto Instrument file (62.4), or set on the fly
 ; from PARAM 1
 N LA7I
 S LA7XFORM=LA76241(2)
 ; get PARAM 1 overides
 I $D(LA7XFORM(1)),LA7XFORM(1)?1.N S $P(LA7XFORM,"^")=LA7XFORM(1)
 F LA7I=2,3,5,6 I $D(LA7XFORM(LA7I)) S $P(LA7XFORM,"^",LA7I)=LA7XFORM(LA7I)
 ; set up defaults if field was not answered
 ;
 ; accept results,yes
 I $P(LA7XFORM,"^",3)="" S $P(LA7XFORM,"^",3)=1
 ; strip spaces,yes
 I $P(LA7XFORM,"^",6)="" S $P(LA7XFORM,"^",6)=1
 ;
 ; now transform
 ; don't accept results
 I '$P(LA7XFORM,"^",3) S LA7VAL="" Q
 ; accept ordered tests only
 I $P(LA7XFORM,"^",5) S LA7LIMIT=1
 ; decimal places if result start with number or decimal point
 ; skip results i.e. ">100".
 I $P(LA7XFORM,"^")?1.N,LA7VAL?1(1N.E,1".".E) D
 . S LA7VAL=$FN(LA7VAL,"",+LA7XFORM)
 ; strip spaces
 I $P(LA7XFORM,"^",6) S LA7VAL=$TR(LA7VAL," ","")
 ; make result a comment, store comment in ^LAH global
 ; set value to null after making into remark, don't store twice.
 I $P(LA7XFORM,"^",2) D
 . D RMKSET^LASET(LA7LWL,LA7ISQN,LA7VAL,"")
 . S LA7VAL=""
 Q
 ;
 ;
PRDID(LA7PRDID,LA7CS) ; Process/Store Producer's ID
 ; Store where test was performed.
 ; Call with LA7PRDID = Producer's ID field
 ;              LA7CS = component encoding character
 N LA7X,LA7Y
 S LA7PRDID=$G(LA7PRDID),LA7CS=$G(LA7CS)
 ; Don't store producer's id.
 I LA7PRDID=""!('$P(LA76241(2),"^",9))!(LA7CS="") Q
 ;
 S LA7X=$P(LA7PRDID,LA7CS,2)
 I $L($P(LA7PRDID,LA7CS)) S LA7X=LA7X_$S($L(LA7X):" ",1:"")_"["_$P(LA7PRDID,LA7CS)_"]"
 I LA7X="" Q
 S LA7X="results from "_LA7X
 S LA7Y=$P(LA7RMK(0,+LA76241(0)),"^",2)
 ; If no prefix, use test name.
 I '$L(LA7Y) S LA7Y=$P($G(^LAB(60,+LA76241(0),0)),"^")_": "
 D RMKSET^LASET(LA7LWL,LA7ISQN,LA7X,LA7Y)
 Q
 ;
 ;
REFRNG(LA7X) ; Process/Store References Range.
 ; Call with LA7X = reference range to store.
 N LA7Y
 S LA7X=$G(LA7X)
 ; No ref range or don't store ref range.
 I LA7X=""!('$P(LA76241(2),"^",10)) Q
 S LA7X="ref range - "_LA7X
 S LA7Y=$P(LA7RMK(0,+LA76241(0)),"^",2)
 ; If no prefix, use test name.
 I '$L(LA7Y) S LA7Y=$P($G(^LAB(60,+LA76241(0),0)),"^")_": "
 D RMKSET^LASET(LA7LWL,LA7ISQN,LA7X,LA7Y)
 Q
 ;
 ;
ABFLAG(LA7X) ; Process/Store Abnormal Flags.
 ; Call with LA7X = abnormal flags to store.
 ; Converts flag to interpretation based on HL7 Table 0078.
 ; If no match store code instead of interpretation
 ;
 N I,LA7Y,LA7Z
 ;
 S LA7X=$G(LA7X)
 ; No flag or don't store abnormal flags.
 I LA7X=""!('$P(LA76241(2),"^",11)) Q
 F I=1:1:18 I LA7X=$P("L^H^LL^HH^<^>^N^A^AA^U^D^B^W^S^R^I^MS^VS","^",I) S LA7X=$P($T(ABFLAGS+I),";;",2) Q
 S LA7X="normalcy status - "_LA7X
 S LA7Y=$P(LA7RMK(0,+LA76241(0)),"^",2)
 ;
 ; If no prefix, use test name.
 I '$L(LA7Y) S LA7Y=$P($G(^LAB(60,+LA76241(0),0)),"^")_": "
 ;
 D RMKSET^LASET(LA7LWL,LA7ISQN,LA7X,LA7Y)
 Q
 ;
ABFLAGS ;; HL7 Table 0078 Abnormal flags
 ;;Below low normal;;
 ;;Above high normal;;
 ;;Below lower panic limits;;
 ;;Above upper panic limits;;
 ;;Below absolute low-off instrument scale;;
 ;;Above absolute high-off instrument scale;;
 ;;Normal;;
 ;;Abnormal;;
 ;;Very abnormal;;
 ;;Significant change up;;
 ;;Significant change down;;
 ;;Better;;
 ;;Worse;;
 ;;Susceptible;;
 ;;Resistant;;
 ;;Intermediate;;
 ;;Moderately susceptible;;
 ;;Very susceptible;;
