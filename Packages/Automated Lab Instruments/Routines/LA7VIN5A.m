LA7VIN5A ;DALOI/JMC - Process Incoming UI Msgs, continued ;APRIL 4, 2016@16:27
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,67,72,66,74,88,99**;Sep 27, 1994;Build 3
 ;
 ; This routine is a continuation of LA7VIN5.
 ; It performs processing of fields in OBX segments.
 Q
 ;
 ;
XFORM ; Transform the result based on fields 12,13,14,16,17 in the Chem Test
 ; multiple in the Auto Instrument file (62.4), or set on the fly from PARAM 1
 ;
 N LA7I
 S LA7XFORM=LA76241(2)
 ;
 ; get PARAM 1 overrides
 I $D(LA7XFORM(1)),LA7XFORM(1)?1.N S $P(LA7XFORM,"^")=LA7XFORM(1)
 F LA7I=2,3,5,6 I $D(LA7XFORM(LA7I)) S $P(LA7XFORM,"^",LA7I)=LA7XFORM(LA7I)
 ; set up defaults if field was not answered
 ; accept results,yes
 I $P(LA7XFORM,"^",3)="" S $P(LA7XFORM,"^",3)=1
 ; strip spaces,no
 I $P(LA7XFORM,"^",6)="" S $P(LA7XFORM,"^",6)=0
 ; now transform
 ;
 ; Don't accept results
 I '$P(LA7XFORM,"^",3) S LA7VAL="" Q
 ;
 ; Only accept "FINAL" type results
 I $P(LA7XFORM,"^",3)=2,"CFUX"'[LA7ORS S LA7VAL="" Q
 ;
 ; Accept ordered tests only
 ; If LEDI interface (10) and message indicates a reflex ("G") or add-on test ("A")
 ;  then process anyway in case it has not been added to accession.
 I $P(LA7XFORM,"^",5) D
 . I LA7INTYP=10,LA7SAC?1(1"A",1"G") Q
 . S LA7LIMIT=1
 ; Check if Lab UI and auto release then always set ordered tests only.
 I LA7INTYP=1,LA7AUTORELEASE S LA7LIMIT=1
 ;
 ; Decimal places if number of places defined
 I $P(LA7XFORM,"^")?1.N D JUSTDEC
 ;
 ; Strip spaces
 I $P(LA7XFORM,"^",6) S LA7VAL=$TR(LA7VAL," ","")
 ;
 ; Make result a comment
 ; Set value to null after making into remark, don't store twice.
 I $P(LA7XFORM,"^",2) D
 . N LA7Y
 . ; Store comment in ^LAH global
 . S LA7Y=$P(LA7RMK(0,+LA76241(0)),"^",2)
 . D RMKSET^LASET(LA7LWL,LA7ISQN,LA7VAL,LA7Y)
 . S LA7VAL=""
 Q
 ;
 ;
CHKDIE ; Check if value to be stored passes input transform of field in DD
 N LA7ERR,LA7Y
 ;
 ; If result is on a LEDI interface (type=10) then don't check result against FileMan input transform.
 ; VistA sends "canc" as test result when test is cancelled.
 ; DoD sends "PL Canceled" --> change to "canc" for VistA storage.
 I LA7INTYP=10 D  Q
 . I LA7VAL="PL Cancelled" S LA7VAL="canc" Q
 . I LA7VAL="PL Canceled" S LA7VAL="canc" Q
 . I LA7VAL="PLCanceled" S LA7VAL="canc" Q
 ;
 ; If canc or comment value received then pass as these are valid results on VistA.
 I LA7VAL="canc"!(LA7VAL="comment") Q
 ;
 ; If value fails data checker then log error and suppress result.
 D CHK^DIE(LA7SUBFL,LA76304,"H",LA7VAL,.LA7Y,"LA7ERR")
 I LA7Y="^" D
 . N LA7X
 . S LA7X=$G(LA7ERR("DIERR",1,"TEXT",1))
 . S LA7ERR=37,LA7AERR=$$CREATE^LA7LOG(LA7ERR,1)
 . S LA7VAL=""
 Q
 ;
 ;
JUSTDEC ; Justify to number of places specified
 ;
 N LA7DDTYP,LA7FMT,LA7I,LA7PRFIX,LA7X
 ;
 ; If LEDI interface (type=10) then skip decimal adjustment
 I LA7INTYP=10 Q
 ;
 ; Get data name field type from DD
 ; Only justify if Vista field is numeric or free text.
 S LA7DDTYP=$$GET1^DID(LA7SUBFL,LA76304,"","TYPE")
 I "NUMERIC^FREE TEXT"'[LA7DDTYP D  Q
 . N LA7FLDNM
 . S LA7FLDNM=$$GET1^DID(63.04,LA76304,"","LABEL")
 . S LA7ERR=38,LA7AERR=$$CREATE^LA7LOG(LA7ERR,1)
 ;
 S LA7X=LA7VAL,(LA7FMT,LA7PRFIX)=""
 ;
 ; If comma formatted, strip comma and set flag to add back in.
 S LA7X=$TR(LA7X,",","")
 I LA7X'=LA7VAL S LA7FMT="P"
 ;
 ; If "<>=" formatted, strip and save to add back in.
 F LA7I=1:1:$L(LA7X) Q:$E(LA7X,LA7I)'?1(1"<",1">",1"=")
 I LA7I>1 D
 . S LA7PRFIX=$E(LA7X,1,LA7I-1)
 . S LA7X=$E(LA7X,LA7I,$L(LA7X))
 ;
 ; Format if starts with number or decimal point, skip other results.
 I LA7X?1(1.N,.N1"."1.N) D
 . S LA7X=$FN(LA7X,LA7FMT,+LA7XFORM)
 . S LA7VAL=LA7PRFIX_LA7X
 Q
 ;
 ;
PRDID(LA7PRDID,LA7SFAC,LA7CS) ; Process/Store Producer's ID
 ; Store where test was performed.
 ; Call with LA7PRDID = Producer's ID field
 ;            LA7SFAC = sending facility
 ;              LA7CS = component encoding character
 ;
 ; Remove units/reference ranges when Lab UI interface so file #60 settings always used
 I $G(LA7INTYP)=1 S $P(^LAH(LA7LWL,1,LA7ISQN,LA76304),"^",5)="" Q
 ;
 N LA74,LA7I,LA7X,LA7Y
 ;
 ; Store producer's id in LAH global with results.
 ; LA7PRODID set with pointer to file #4 to be used by segments (NTE) that follow OBX's.
 S (LA74,LA7PRODID)=$$RESFID^LA7VHLU2(LA7PRDID,LA7SFAC,LA7CS)
 I LA74 S $P(^LAH(LA7LWL,1,LA7ISQN,LA76304),"^",9)=LA74 Q
 ;
 ; Don't store producer's id as comment.
 I '$P(LA76241(2),"^",9) Q
 ;
 ; If unable to identify producer in file #4 then store as comment if field STORE PRODUCER'S ID (#20) enabled.
 S LA7X=$P(LA7PRDID,LA7CS,2)
 I LA7X="" Q
 S LA7Y=$P(LA7RMK(0,+LA76241(0)),"^",2)
 S LA7X=$S(LA7Y="":"P",1:"p")_"erformed by "_LA7X
 D RMKSET^LASET(LA7LWL,LA7ISQN,LA7X,LA7Y)
 ;
 Q
 ;
 ;
REFRNG(LA7X) ; Process/Store References Range.
 ; Call with LA7X = reference range to store.
 ;
 N LA7Y,X,Y
 ;
 ; Check if Lab UI and not auto release then quit otherwise store ranges.
 I LA7INTYP=1,'LA7AUTORELEASE Q
 ;
 ; Check if site does not want to store reference ranges on POC test.
 I LA7INTYP>19,LA7INTYP<30,+$P(LA76241(2),"^",10)=0 Q
 ;
 ; Remove leading and trailing quotes from reference range.
 S LA7X=$$TRIM^XLFSTR($G(LA7X),"RL","""")
 I LA7X="" Q
 ;
 S X=$P($G(^LAH(LA7LWL,1,LA7ISQN,LA76304)),"^",5)
 ;
 ; Replace "TO" with "-" (Labcorp special)
 I LA7X["TO" S LA7X=$P(LA7X,"TO",1)_"-"_$P(LA7X,"TO",2)
 ;
 ; A single value with minus sign = upper limit
 I $E(LA7X)="-",$L(LA7X,"-")=2 S LA7X="<"_$E(LA7X,2,$L(LA7X))
 ;
 ; >lower limit (no upper limit e.g. >10) - store as low value
 I LA7X?1">".N.1".".N S $P(X,"!",2)=$TR(LA7X,">",""),LA7X=""
 ;
 ; <upper limit (no lower limit e.g. <15) - store as high value
 I LA7X?1"<".N.1".".N S $P(X,"!",3)=$TR(LA7X,"<",""),LA7X=""
 ;
 ; Alphabetic reference with hyphen
 I LA7X?1.A1"-"1.A S $P(X,"!",2)=$C(34)_LA7X_$C(34),LA7X=""
 ;
 S LADASH=0 S:LA7X["-" LADASH=$L(LA7X,"-")
 ; Lower limit value
 S Y=$S(LADASH:$P(LA7X,"-",1,LADASH-1),1:$P(LA7X,"-"))
 I Y'="" D
 . I Y?.N.1".".N S $P(X,"!",2)=Y
 . E  S $P(X,"!",2)=$C(34)_$$UNESC^LA7VHLU3(Y,LA7FS_LA7ECH)_$C(34)
 ;
 ; Upper limit value
 I LADASH<4 S Y=$S(LADASH:$P(LA7X,"-",LADASH),1:$P(LA7X,"-",2))
 I LADASH=4 S Y=$P(LA7X,"-",LADASH-1,LADASH)
 I Y'="" D
 . I Y?.N.1".".N S $P(X,"!",3)=Y
 . E  S $P(X,"!",3)=$C(34)_$$UNESC^LA7VHLU3(Y,LA7FS_LA7ECH)_$C(34)
 K LADASH
 ;
 ; Store reference range in LAH global with results.
 S $P(^LAH(LA7LWL,1,LA7ISQN,LA76304),"^",5)=X
 ;
 Q
 ;
 ;
ABFLAG(LA7X) ; Process/Store Abnormal Flags.
 ; Call with LA7X = abnormal flags to store.
 ; Converts flag to interpretation based on HL7 Table 0078.
 ; If no match store code instead of interpretation
 ;
 N I,LA7I,LA7Y,X
 ;
 ; Check if Lab UI and not auto release then quit otherwise store abnormal flags.
 I LA7INTYP=1,'LA7AUTORELEASE Q
 ;
 ; Store abnormal flags in LAH global with results.
 ; Currently only storing high/low and critical flags
 S LA7Y=$S(LA7X="L":"L",LA7X="H":"H",LA7X="LL":"L*",LA7X="HH":"H*",1:"")
 S $P(^LAH(LA7LWL,1,LA7ISQN,LA76304),"^",2)=LA7Y
 ;
 ; Critical or designated abnormal tests generate bulletin/alert on LEDI (type=10) interfaces.
 I LA7INTYP=10,LA7Y'="" D
 . I $E(LA7Y,2)'="*",'$P(LA76241(2),"^",11) Q
 . S LA7I=$O(^TMP("LA7 ABNORMAL RESULTS",$J,""),-1),LA7I=LA7I+1
 . S X=LA7LWL_"^"_LA7ISQN_"^"_LA76304_"^"_LA76248_"^"_LA76249_"^"_LA7ORS_"^"_LA7TEST_"^"_$S(LA7TEST(0)'="":LA7TEST(0),1:LA7TEST(2,0))_"^"_$$P^LA7VHLU(.LA7SEG,9,LA7FS)
 . S ^TMP("LA7 ABNORMAL RESULTS",$J,LA7I)=X
 ;
 ; If LEDI/POC interface and abnormal flag is not handled by VistA above then store as comment.
 I LA7INTYP>9,LA7INTYP<30,LA7Y="",LA7X'="",LA7X'="N" D
 . S X=" L^ H^LL^HH^ <^ >^ N^ A^AA^ U^ D^ B^ W^ S^ R^ I^MS^VS"
 . S I=$F(X,LA7X)\3
 . S LA7Y="normalcy status - "_$P($T(ABFLAGS+I^LA7VHLU1),";;",2)
 . D RMKSET^LASET(LA7LWL,LA7ISQN,LA7Y,$P(LA7RMK(0,+LA76241(0)),"^",2))
 ;
 Q
 ;
 ;
EII ; Store equipment instance identifier in LAH global with results.
 ;
 N I,LA7X,X
 ;
 S LA7X=""
 F I=1:1:4 D
 . S X=$P(LA7EII,LA7CS,I)
 . I X="" Q
 . S $P(LA7X,"!",I)=$TR(X,"!","~")
 I LA7X'="" S $P(^LAH(LA7LWL,1,LA7ISQN,LA76304),"^",11)=LA7X
 Q
