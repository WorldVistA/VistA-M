LA7VOBXA ;DALOI/JMC - LAB OBX Segment message builder (cont'd) ;04/14/11  10:56
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,70,64,68,74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
OBX2 ; Build OBX-2 sequence - Value type
 ;
 ; default value - string data
 S LA7VAL="ST"
 S LA7TYP="",LA7FILE=$G(LA7FILE),LA7FIELD=$G(LA7FIELD)
 ;
 I LA7FILE,LA7FIELD S LA7TYP=$$GET1^DID(LA7FILE,LA7FIELD,"","TYPE","","LA7ERR")
 ;
 I LA7TYP="DATE/TIME" S LA7VAL="TS"
 I LA7TYP="FREE TEXT" S LA7VAL="ST"
 I LA7TYP="WORD-PROCESSING" S LA7VAL="FT"
 I LA7TYP="NUMERIC" S LA7VAL="NM"
 I LA7TYP="SET" S LA7VAL="ST"
 I LA7TYP="POINTER" S LA7VAL="ST"
 ;
 Q
 ;
 ;
OBX3 ; Build OBX-3 sequence - Observation identifier field
 ;
 ; Initialize variables
 S LA7J=1,LA7Y="",LA7INTYP=$G(LA7INTYP)
 ;
 ; Build sequence using LOINC codes. LOINC code/code name/"LN"
 ; VA VUID in 2nd triplet when sending to VA HDR. Use VA Display name (field #82) for VUID test name
 I LA7953'="" D
 . N LA7IENS,LA7Z
 . I LA7953?1.N S LA7IENS=LA7953_","
 . E  S LA7IENS=$O(^LAB(95.3,"B",LA7953,0))_","
 . D GETS^DIQ(95.3,LA7IENS,".01;80;99.99","E","LA7X")
 . ; Invalid code???
 . I $G(LA7X(95.3,LA7IENS,.01,"E"))="" Q
 . S LA7Z=LA7X(95.3,LA7IENS,.01,"E")
 . S LA7Z=$$CHKDATA^LA7VHLU3(LA7Z,LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH,1),LA7J)=LA7Z
 . S LA7Z=$G(LA7X(95.3,LA7IENS,80,"E"))
 . S LA7Z=$$CHKDATA^LA7VHLU3(LA7Z,LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH,1),LA7J+1)=LA7Z
 . S $P(LA7Y,$E(LA7ECH,1),LA7J+2)="LN"
 . S LA7J=4
 . I LA7INTYP=30,$G(LA7X(95.3,LA7IENS,99.99,"E"))'="" D
 . . S $P(LA7Y,$E(LA7ECH,1),LA7J)=LA7X(95.3,LA7IENS,99.99,"E")
 . . I $$VFIELD^DILFD(95.3,82) D
 . . . S LA7Z=$$GET1^DIQ(95.3,LA7IENS,82)
 . . . I LA7Z'="" S $P(LA7Y,$E(LA7ECH,1),LA7J+1)=$$CHKDATA^LA7VHLU3(LA7Z,LA7FS_LA7ECH)
 . . S $P(LA7Y,$E(LA7ECH,1),LA7J+2)="99VA95.3"
 . . S LA7J=9
 . I $G(LA7LNCVR)="" S LA7LNCVR=$$GET1^DID(95.3,"","","PACKAGE REVISION DATA")
 . I LA7J>1 S $P(LA7Y,$E(LA7ECH,1),7)=LA7LNCVR
 . I LA7J=9 S $P(LA7Y,$E(LA7ECH,1),8)=LA7LNCVR
 ;
 ; Build sequence using NLT codes - file #64 NLT code/NLT code name/"99VA64"
 ; If LOINC is primary make NLT alternate, otherwise NLT primary.
 ; Only on non-HDR type interfaces.
 I LA7NLT'="",LA7INTYP'=30,LA7J<9 D
 . N LA7642,LA7Z
 . S LA764=$O(^LAM("E",LA7NLT,0)),LA7Z=""
 . I LA764 S LA7Z=$$GET1^DIQ(64,LA764_",",.01,"I")
 . I LA7Z="" D
 . . S LA764=$O(^LAM("E",$P(LA7NLT,".")_".0000",0))
 . . I LA764 S LA7Z=$$GET1^DIQ(64,LA764_",",.01,"I")
 . . S LA7642=$O(^LAB(64.2,"C","."_$P(LA7NLT,".",2),0))
 . . I LA764,LA7642 S LA7Z=LA7Z_"~"_$$GET1^DIQ(64.2,LA7642_",",.01,"I")
 . S LA7Z=$$CHKDATA^LA7VHLU3(LA7Z,LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH,1),LA7J)=LA7NLT
 . S $P(LA7Y,$E(LA7ECH,1),LA7J+1)=LA7Z
 . S $P(LA7Y,$E(LA7ECH,1),LA7J+2)="99VA64"
 . S LA7Z=$$GET1^DID(64,"","","PACKAGE REVISION DATA")
 . S $P(LA7Y,$E(LA7ECH,1),$S(LA7J=1:7,1:8))=LA7Z
 . S LA7J=LA7J+3
 ;
 ; Non-standard/non-VA code
 ; Local VA display name in 2nd triplet of LA7ALT
 ; If alternate is a non-VA code then use as alternate code.
 I LA7ALT="" Q
 I $P(LA7ALT,"^",1,3)'="^^" D
 . I LA7INTYP'=30,$P(LA7ALT,"^",3)'="99VA63",LA7J>4 S LA7J=4
 . I LA7J<7 D
 . . S $P(LA7Y,$E(LA7ECH,1),LA7J)=$$CHKDATA^LA7VHLU3($P(LA7ALT,"^"),LA7FS_LA7ECH)
 . . S $P(LA7Y,$E(LA7ECH,1),LA7J+1)=$$CHKDATA^LA7VHLU3($P(LA7ALT,"^",2),LA7FS_LA7ECH)
 . . S $P(LA7Y,$E(LA7ECH,1),LA7J+2)=$$CHKDATA^LA7VHLU3($P(LA7ALT,"^",3),LA7FS_LA7ECH)
 . . I $P(LA7ALT,"^",3)="99VA63" S $P(LA7Y,$E(LA7ECH,1),$S(LA7J=1:7,1:8))="5.2"
 ;
 ; Put local test name in local text (9th component)
 I $E($P(LA7ALT,"^",6),1,5)="99VA6",$P(LA7ALT,"^",6)'="99VA64" D
 . N I,LA7Z
 . S LA7Z=$$TRIM^XLFSTR($P(LA7ALT,"^",5),"LR"," ")
 . I LA7Z="" Q
 . S LA7Z=$$CHKDATA^LA7VHLU3(LA7Z,LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH,1),9)=LA7Z
 ;
 Q
 ;
 ;
OBX5 ; Build OBX-5 sequence - Observation value
 ; Removes trailing spaces on string and text results.
 ; Removes leading & trailing spaces on numeric results.
 ;
 S LA7Y=""
 ;
 I $G(LA7OBX2)="" S LA7OBX2="ST" ; default value type
 ;
 I LA7OBX2="ST"!(LA7OBX2="TX") D
 . S LA7VAL=$$TRIM^XLFSTR(LA7VAL,"R"," ")
 . S LA7Y=$$CHKDATA^LA7VHLU3(LA7VAL,LA7FS_LA7ECH)
 ;
 I LA7OBX2?1(1"NM",1"SN") S LA7Y=$$TRIM^XLFSTR(LA7VAL,"RL"," ")
 ;
 I LA7OBX2="TS" D
 . S LA7VAL=$$CHKDT^LA7VHLU1(LA7VAL)
 . S LA7Y=$$FMTHL7^XLFDT(LA7VAL)
 ;
 I LA7OBX2?1(1"CE",1"CNE",1"CWE") D
 . N LA7I,LA7J,X
 . S LA7J=$S(LA7OBX2="CE":6,1:9)
 . F LA7I=1:1:LA7J I $P(LA7VAL,"^",LA7I)'="" S $P(LA7Y,$E(LA7ECH),LA7I)=$$CHKDATA^LA7VHLU3($P(LA7VAL,"^",LA7I),LA7FS_LA7ECH)
 ;
 Q
 ;
 ;
OBX5M ; Build OBX-5 sequence - Observation value - multi-line textual result
 ;
 K LA7WP
 ;
 S LA7WP=""
 S LA7TYPE=$$GET1^DID(LA7FN,LA7FLD,"","TYPE","LA7ERR(1)")
 ;
 ; Process word-processing type field.
 ; Check and encode data
 I LA7TYPE="WORD-PROCESSING" D  Q
 . N DIWF,DIWL,DIWR,X
 . S LA7WP=$$GET1^DIQ(LA7FN,LA7IENS,LA7FLD,"","LA7WP","LA7ERR(2)")
 . K ^UTILITY($J,"W")
 . S DIWL=1,DIWR=245,DIWF="N",LA7I=0
 . F  S LA7I=$O(LA7WP(LA7I)) Q:'LA7I  S X=LA7WP(LA7I) D ^DIWP
 . K LA7WP
 . S LA7I=0
 . F  S LA7I=$O(^UTILITY($J,"W",DIWL,LA7I)) Q:'LA7I  D
 . . S LA7WP(LA7I)=$$CHKDATA^LA7VHLU3(^UTILITY($J,"W",DIWL,LA7I,0),LA7FS_LA7ECH)
 . . I LA7I>1 S LA7WP(LA7I)=$E(LA7ECH,3)_".br"_$E(LA7ECH,3)_LA7WP(LA7I)
 . K ^UTILITY($J,"W")
 ;
 ; Free text, assumes multiple valued
 I LA7TYPE="FREE TEXT" D
 . D GETS^DIQ(LA7FN,LA7IENS,LA7FLD_"*","","LA7WP","LA7ERR")
 ;
 Q
 ;
 ;
OBX5R ; Build OBX-5 sequence with repetition - Observation value
 ;
 S (LA7I,LA7Y)=""
 F  S LA7I=$O(LA7VAL(LA7I)) Q:'LA7I  D
 . S LA7Y=LA7Y_$$OBX5^LA7VOBX(LA7VAL(LA7I),LA7OBX2,LA7FS,LA7ECH)_$E(LA7ECH,2)
 ;
 Q
 ;
 ;
OBX6 ; Build OBX-6 sequence - Units
 ;
 S LA7ECH=$G(LA7ECH),LA7Y=""
 ;
 ; Units - remove leading and trailing spaces
 ; If HDR interface (LA7INTYP=30) then add coding system (L) to units.
 I $G(LA7VAL)'="" D
 . S LA7Y=$$TRIM^XLFSTR(LA7VAL,"LR"," ")
 . S LA7Y=$$CHKDATA^LA7VHLU3(LA7Y,LA7FS_LA7ECH)
 . I $G(LA7INTYP)=30 D
 . . S $P(LA7Y,$E(LA7ECH,1),2)=LA7Y
 . . S $P(LA7Y,$E(LA7ECH,1),3)="L"
 ;
 ; Build sequence using LOINC codes only
 ; LOINC code/code name/"LN"
 I $G(LA764061) D
 . N LA7IENS,LA7X,LA7Z
 . S LA7IENS=LA764061_","
 . D GETS^DIQ(64.061,LA7IENS,"1;8","E","LA7X")
 . ; LOINC code
 . S LA7Z=$G(LA7X(64.061,LA7IENS,1,"E"))
 . S LA7Z=$$CHKDATA^LA7VHLU3(LA7Z,LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH,1),1)=LA7Z
 . ; LOINC code name
 . S LA7Z=$G(LA7X(64.061,LA7IENS,8,"E"))
 . S LA7Z=$$CHKDATA^LA7VHLU3(LA7Z,LA7FS_LA7ECH)
 . S $P(LA7Y,$E(LA7ECH,1),2)=LA7Z
 . S $P(LA7Y,$E(LA7ECH,1),3)="LN"
 ;
 Q
 ;
 ;
OBX7 ; Build OBX-7 sequence - Reference range
 ; Removes leading and trailing quote marks ("").
 ;
 S LA7Y=""
 ;
 I $G(LA7LOW)'="" D
 . S LA7LOW=$$TRIM^XLFSTR(LA7LOW,"RL","""")
 . I LA7LOW?1A.E S LA7Y=LA7Y_LA7LOW Q  ; alphabetic value
 . I $G(LA7HIGH)="",$E(LA7LOW)'=">" S LA7Y=">"
 . S LA7Y=LA7Y_LA7LOW
 ;
 I $G(LA7HIGH)'="" D
 . S LA7HIGH=$$TRIM^XLFSTR(LA7HIGH,"RL","""")
 . I LA7HIGH?1A.E S LA7Y=LA7Y_LA7HIGH Q  ; alphabetic value
 . I $G(LA7LOW)="" D  Q
 . . I $E(LA7HIGH)'="<" S LA7Y="<"
 . . S LA7Y=LA7Y_LA7HIGH
 . S LA7Y=LA7Y_"-"_LA7HIGH
 ;
 S LA7Y=$$CHKDATA^LA7VHLU3(LA7Y,LA7FS_LA7ECH)
 ;
 Q
 ;
 ;
OBX17 ; Build OBX-17 sequence - Observation method field
 ;
 ; method suffix code maybe stored without leading decimal,
 ;  add "." back for lookup, also add trailing space for lookup in x-ref.
 I LA7VAL>1 S LA7VAL="."_LA7VAL
 S LA7X=$O(^LAB(64.2,"C",LA7VAL_" ",0)),LA7Y=""
 I LA7X D
 . S LA7X(.01)=$P($G(^LAB(64.2,LA7X,0)),"^")
 . S LA7X(.01)=$$CHKDATA^LA7VHLU3(LA7X(.01),LA7FS_LA7ECH)
 . S LA7Y=LA7VAL_$E(LA7ECH)_LA7X(.01)_$E(LA7ECH)_"99VA64.2"
 . ;S LA7X=$$GET1^DID(64.2,"","","PACKAGE REVISION DATA")
 . ;S $P(LA7Y,$E(LA7ECH,1),7)=LA7X
 ;
 ; Send NLT result code
 I LA7NLT'="" D
 . S LA764=$O(^LAM("E",LA7NLT,0)),LA7Z=""
 . I LA764 S LA7X=$P($G(^LAM(LA764,0)),"^")
 . S LA7X=$$CHKDATA^LA7VHLU3(LA7X,LA7FS_LA7ECH)
 . S $P(LA7Z,$E(LA7ECH,1),1)=LA7NLT
 . S $P(LA7Z,$E(LA7ECH,1),2)=LA7X
 . S $P(LA7Z,$E(LA7ECH,1),3)="99VA64"
 . ;S LA7X=$$GET1^DID(64,"","","PACKAGE REVISION DATA")
 . ;S $P(LA7Z,$E(LA7ECH,1),7)=LA7X
 . I LA7Y'="" S LA7Y=LA7Y_$E(LA7ECH,2)
 . S LA7Y=LA7Y_LA7Z
 ;
 Q
 ;
 ;
OBX18 ; Build OBX-18 sequence - Equipment entity identifier field
 ;
 S LA7X="",LA7J=$L(LA7VAL,"!")
 F LA7I=1:1:LA7J D
 . S LA7Y=$P(LA7VAL,"!",LA7I)
 . I LA7Y="" Q
 . S $P(LA7X,$E(LA7ECH,1),LA7I)=$$CHKDATA^LA7VHLU3(LA7Y,LA7FS_LA7ECH)
 ;
 Q
