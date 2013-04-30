LA7VHLU6 ;DALOI/JMC - HL7 Code Sets utility ;11/17/11  09:25
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; Utility to resolve SNOMED CT, LOINC and local codes.
 ;
 Q
 ;
IEN2SCT(FILE,IEN,DATE,LA7ALT) ; Return SCT code for a given file entry
 ; Call with FILE = file #
 ;            IEN = internal entry number in FILE
 ;           DATE = as of date
 ;         LA7ALT = SNOMED CT ID to use as alternate
 ;
 ; Returns   LA7Y = SNOMED CT code (Code^Code Text^Code System^Version^Error Code^Error Text)
 ;
 N LA7FIELD,LA7SCT,LA7X,LA7Y,LA7Z,X,Y
 S LA7Y="",FILE=+$G(FILE),IEN=+$G(IEN),LA7ALT=$G(LA7ALT)
 ;
 ; If entry mapped to SNOMED CT then retrieve code info from Lexicon.
 S LA7FIELD=$S(FILE=61:20,FILE=61.2:20,FILE=62:20,1:20)
 I LA7ALT'="" S LA7X=LA7ALT
 E  S LA7X=$$GET1^DIQ(FILE,IEN_",",LA7FIELD)
 I LA7X D
 . S LA7Z=$$CODE^LEXTRAN(LA7X,"SCT",DATE,"LA7SCT")
 . I LA7Z>0 S LA7Y=$P(LA7SCT(0),"^")_"^"_LA7SCT("F")_"^SCT^"_$P(LA7SCT(0),"^",3) Q
 . S $P(LA7Y,"^",5,6)=$P(LA7Z,"^",1,2) ; return error code/text in 5th/6th pieces
 . I $P(LA7Z,"^")=-1 Q
 . I $P(LA7Z,"^")=-2 Q
 . I $P(LA7Z,"^")=-4 D  Q
 . . S $P(LA7Y,"^",1,4)=$P(LA7SCT(0),"^")_"^"_$G(LA7SCT("F"))_"^SCT^"_$P(LA7SCT(0),"^",3)
 . . S X=$P(LA7Z,"not active for ",2)
 . . I X?1(7N,7N1"."1.N) S $P(LA7Y,"not active for ",2)=$$FMTE^XLFDT(X,"MZ")
 . I $P(LA7Z,"^")=-8 D  Q
 . . S X=+$P(LA7Z," ",2)
 . . I X?1(7N,7N1"."1.N) S $P(LA7Y," ",2)=$$FMTE^XLFDT(X,"MZ")
 . . I DATE=DT Q
 . . N LA7Z,LA7SCT
 . . S LA7Z=$$CODE^LEXTRAN(LA7X,"SCT",DT,"LA7SCT")
 . . I LA7Z>0 S $P(LA7Y,"^",1,4)=$P(LA7SCT(0),"^")_"^"_LA7SCT("F")_"^SCT^"_$P(LA7SCT(0),"^",3)
 ;
 Q LA7Y
 ;
 ;
SCT2IEN(CODE,TEXT,VERSION,FILE,LA76247,LA76248) ; Return file ien for a given SNOMED CT code
 ; Call with CODE = SNOMED CT code
 ;           TEXT = code text
 ;        VERSION = code system version
 ;           FILE = destination VistA file # (file where the SCT term resides)
 ;        LA76247 = ien of concept to screen on
 ;        LA76248 = related Lab Messaging configuration for non-standard code lookup (optional)
 ;                  used when code is only for a specific interface
 ;
 ; Returns LA7IEN = file internal entry number
 ;
 N LA7CNT,LA7IEN,LA7X,LA7Y
 S (LA7CNT,LA7X)=0,LA7IEN=""
 F  S LA7X=$O(^LAB(FILE,"F",CODE,LA7X)) Q:'LA7X  S LA7CNT=LA7CNT+1,LA7IEN=LA7X,LA7Y(LA7X)=^LAB(FILE,LA7X,"SCT")
 ;
 ; If multiple entries mapped then check for closest match
 ;  - try P if no P then try S or L for text match
 ;    - if none then select S
 ;      - if none then select L
 I LA7CNT>1 D
 . N LA7QUIT
 . S TEXT=$$UP^XLFSTR(TEXT)
 . S (LA7QUIT,LA7X)=0
 . F  S LA7X=$O(LA7Y(LA7X)) Q:'LA7X  D  Q:LA7QUIT
 . . S LA7IEN=LA7X
 . . I $P(LA7Y(LA7X),"^",2)="P" S LA7QUIT=1 Q
 . . I $P(LA7Y(LA7X),"^",2)?1(1"S",1"L"),TEXT=$$UP^XLFSTR($P(^LAB(FILE,LA7X,0),"^")) S LA7QUIT=1
 . I LA7QUIT Q
 . S (LA7IEN,LA7X)=0
 . F  S LA7X=$O(LA7Y(LA7X)) Q:'LA7X  D
 . . I $P(LA7Y(LA7X),"^",2)="S" S LA7IEN=LA7X
 . . I 'LA7IEN,$P(LA7Y(LA7X),"^",2)="L" S LA7IEN=LA7X
 ;
 ;
 Q LA7IEN
 ;
 ;
HL2LAH(CODE,TEXT,NCS,VERSION,LA76248,LA7SS) ; Determine storage location for a code system sent in OBX-3
 ; Call with CODE = code id
 ;           TEXT = code text
 ;            NCS = name of coding system (LOINC, NLT, SCT, 99xxx, L)
 ;        VERSION = code system version id
 ;        LA76248 = related Lab Messaging configuration for non-standard code lookup (optional)
 ;                  used when code is only for a specific interface
 ;          LA7SS = specific lab subscript to screen standard codes - used when same code used in multiple areas
 ;
 ; Returns   LA7Y = CONCEPT^SUBSCRIPT^FILE/SUBFILE^FIELD NUMBER^SCT HIERARCHY
 ;
 N DA,LA76247,LA764,LA764061,LA7ROOT,LA7X,LA7Y,LOCAL,X,Y
 S (DA,DA(1),LA7Y,LA76247)="",LA7SS=$G(LA7SS),LA764061=0
 S LOCAL=$S(NCS="99VA64":0,NCS="L":1,$E(NCS,1,2)="99":1,1:0)
 ;
 ; Check for subscript specific code first.
 ; If VA NLT suffixed code and not in x-ref then try non-suffixed version of code.
 I LA7SS'="" D
 . S LA7ROOT=$Q(^LAB(62.47,"AC2",LA7SS,NCS,CODE))
 . I LA7ROOT="",NCS="99VA64",CODE#1 S CODE=$P(CODE,".")_".0000",LA7ROOT=$Q(^LAB(62.47,"AC2",LA7SS,NCS,CODE))
 . I LA7ROOT'="",$QS(LA7ROOT,2)="AC2",$QS(LA7ROOT,3)=LA7SS,$QS(LA7ROOT,4)=NCS,$QS(LA7ROOT,5)=CODE D
 . . S LA764061=$QS(LA7ROOT,6),(DA(1),LA7Y)=$QS(LA7ROOT,7)
 . . I LA764061 S LA7Y=LA7Y_"^"_$P($G(^LAB(64.061,LA764061,63)),"^",1,4)
 . . S DA=$QS(LA7ROOT,8)
 . . I $P(^LAB(62.47,DA(1),1,DA,0),"^",4) D LAHOVR S $P(LA7Y,"^",6)=$QS(LA7ROOT,7)
 ;
 ; Check for non-subscript specific code
 ; If VA NLT suffixed code and not in x-ref then try non-suffixed version of code.
 I LA7Y="" D
 . S LA7ROOT=$Q(^LAB(62.47,"AC",NCS,CODE))
 . I LA7ROOT="",NCS="99VA64",CODE#1 S CODE=$P(CODE,".")_".0000",LA7ROOT=$Q(^LAB(62.47,"AC",NCS,CODE))
 . I LA7ROOT'="",$QS(LA7ROOT,2)="AC",$QS(LA7ROOT,3)=NCS,$QS(LA7ROOT,4)=CODE D
 . . S LA764061=$QS(LA7ROOT,5),(DA(1),LA7Y)=$QS(LA7ROOT,6)
 . . I LA764061 S LA7Y=LA7Y_"^"_$P($G(^LAB(64.061,LA764061,63)),"^",1,4)
 . . S DA=$QS(LA7ROOT,7)
 . . I $P(^LAB(62.47,DA(1),1,DA,0),"^",4) D LAHOVR S $P(LA7Y,"^",6)=$QS(LA7ROOT,6)
 ;
 ; If for a specific interface
 I LA76248 D
 . S LA7ROOT=$Q(^LAB(62.47,"AC1",LA76248,NCS,CODE))
 . I LA7ROOT'="",$QS(LA7ROOT,2)="AC1",$QS(LA7ROOT,3)=LA76248,$QS(LA7ROOT,4)=NCS,$QS(LA7ROOT,5)=CODE D
 . . S LA764061=$QS(LA7ROOT,6),(DA(1),LA7Y)=$QS(LA7ROOT,7)
 . . I LA764061 S LA7Y=LA7Y_"^"_$P($G(^LAB(64.061,LA764061,63)),"^",1,4)
 . . S DA=$QS(LA7ROOT,8)
 . . I $P(^LAB(62.47,DA(1),1,DA,0),"^",4) D LAHOVR S $P(LA7Y,"^",6)=$QS(LA7ROOT,7)
 ;
 ; Set bacterial/mycobacteria susceptibility field
 I LA764061=9332!(LA764061=9333) D
 . S LA7X=$G(^LAB(62.47,DA(1),1,DA,2))
 . I $P($P(LA7X,"^"),";",2)'="LAB(62.06," Q
 . S X=$G(^LAB(62.06,+LA7X,0))
 . I LA764061=9332,$P(X,"^",4) S $P(LA7Y,"^",4)=$P(X,"^",4) Q
 . I LA764061=9333,$P(X,"^",8) S $P(LA7Y,"^",4)=$P(X,"^",8)
 ;
 ; If code system is SNOMED CT
 ; Currently VistA should not receive a SNOMED CT code in an OBX-3 field.
 I NCS="SCT" D
 . Q
 ;
 Q LA7Y
 ;
 ;
LAHOVR ; Override HL2LAH concept code mapping.
 ;ZEXCEPT: DA,LA76247,LA764061,LA7Y
 ;
 S LA76247=$P(^LAB(62.47,DA(1),1,DA,0),"^",4)
 S LA764061=$P(^LAB(62.47,LA76247,0),"^",3)
 S LA7Y=LA76247_"^"_$G(^LAB(64.061,LA764061,63))
 Q
 ;
 ;
ALCONCPT(LA76247) ; Determine alternate concept for a concept
 ; Call with LA76247 = ien of concept
 ;
 ; Returns LACONPT =  alternate concept
 ;
 N LACONCPT
 S LACONCPT=""
 I $G(LA76247)>0 S LACONCPT=+$P($G(^LAB(62.47,LA76247,0)),"^",4)
 Q LACONCPT
 ;
 ;
PRID(CODE,NCS,LA764061) ; Determine if a code represents the presence/absence or the identity of a concept in OBX-5
 ; Used to determine if identity of organism or presence/absence
 ; Call with CODE = code id
 ;            NCS = name of coding system
 ;        LA64061 = related Lab database code
 ;
 ; Returns   LA7Y = hierarchy of the code ^ related VistA file
 ;
 N LA7Y,LA7X
 S LA7Y=""
 ;
 ; If code system is SNOMED CT
 I NCS="SCT" D
 . S LA7Y=$$GET1^DIQ(64.061,LA764061_",",63.3)
 . S LA7X=$$GET1^DIQ(64.061,LA764061_",",63.3,"I")
 . I LA7X S $P(LA7Y,"^",2)=$P($G(^LAB(64.061,LA7X,63)),"^",5)
 ;
 Q LA7Y
 ;
 ;
HL2VA(CODE,TEXT,NCS,VERSION,LA76247,LA76248) ; Resolve code to internal VA file entry, used to resolve value of OBX-5 coded entry
 ; Call with CODE = code id
 ;            NCS = name of coding system (SCT, 99xxx, L)
 ;           TEXT = code text
 ;        VERSION = code system version id
 ;        LA76247 = ien of concept to screen on
 ;        LA76248 = related Lab Messaging configuration for non-standard code lookup (optional)
 ;                  used when code is only for a specific interface
 ;
 ; Returns  LA7Y = variable pointer format^database storage location
 ;                 OR
 ;                 -1^^^^ien of override concept (if override concept)
 ;
 N DA,LA764061,LA7FILE,LA7HIER,LA7ROOT,LA7X,LA7Y,LOCAL,X,Y
 S LA76247=$G(LA76247)
 I 'LA76247 Q 0
 S LA7FILE=""
 S LOCAL=$S(NCS="L":1,$E(NCS,1,2)="99":1,1:0)
 S LA764061=$P($G(^LAB(62.47,LA76247,0)),"^",3),LA7Y="^"_$P($G(^LAB(64.061,LA764061,63)),"^",1,3)
 ;
 ; If code system is SNOMED CT
 I NCS="SCT" D
 . S LA7ROOT=$Q(^LAB(62.47,"AD",LA76247,NCS,CODE))
 . I LA7ROOT'="",$QS(LA7ROOT,2)="AD",$QS(LA7ROOT,3)=LA76247,$QS(LA7ROOT,4)=NCS,$QS(LA7ROOT,5)=CODE D  Q
 . . S X=$QS(LA7ROOT,6)
 . . I X S LA7Y="-1^^^^"_X
 . I $S(LA76247=7:1,LA76247=21:1,1:0) S LA7Y=$$SCT2KB(CODE,TEXT,NCS,VERSION) Q
 . S LA7HIER=$$PRID(CODE,NCS,LA764061)
 . S LA7FILE=$P(LA7HIER,"^",2)
 . I LA7FILE S LA7Y=$$SCT2IEN(CODE,TEXT,VERSION,LA7FILE,LA76247,LA76248)_";"_$P($$ROOT^DILFD(LA7FILE),"^",2)_LA7Y
 ;
 ; If code system is LOCAL (HL7 "L" OR "99XXX") and for a specific interface
 I LOCAL,LA76248 D
 . S LA7ROOT=$Q(^LAB(62.47,"AD1",LA76247,LA76248,NCS,CODE)),LA764061=0
 . I LA7ROOT="" Q
 . I $QS(LA7ROOT,2)="AD1",$QS(LA7ROOT,3)=LA76247,$QS(LA7ROOT,4)=LA76248,$QS(LA7ROOT,5)=NCS,$QS(LA7ROOT,6)=CODE D
 . . S LA764061=$QS(LA7ROOT,7),DA=$QS(LA7ROOT,8)
 . . S X=$P(^LAB(62.47,LA76247,1,DA,0),"^",4)
 . . I X S LA7Y="-1^^^^"_X Q
 . . S LA7FILE=$P($G(^LAB(62.47,LA76247,1,DA,2)),"^")
 . . I LA7FILE S LA7Y=LA7FILE
 . . I LA764061 S LA7Y=LA7Y_"^"_$P($G(^LAB(64.061,LA764061,63)),"^",1,3)
 ;
 Q LA7Y
 ;
 ;
SCT2KB(CODE,TEXT,NCS,VERSION) ; Convert Susceptibility codes to local codes.
 ; Call with  CODE = susceptibility code
 ;            TEXT = code text
 ;             NCS = name of coding system (SCT, 99xxx, L)
 ;         VERSION = code system version id
 ;
 ; Returns    LA7Y = local susceptibility code
 ;
 N LA7Y
 S LA7Y=""
 I NCS="SCT" S LA7Y=$S(CODE=131196009:"S",CODE=260357007:"MS",CODE=30714006:"R",CODE=264841006:"I",1:"")
 Q LA7Y
 ;
 ;
SCT2PSTG(CODE,TEXT,NCS,VERSION) ; Convert Parasite Stage codes to local codes.
 ; Call with  CODE = parasite stage code
 ;            TEXT = code text
 ;             NCS = name of coding system (SCT, 99xxx, L)
 ;         VERSION = code system version id
 ;
 ; Returns    LA7Y = local parasite stage code
 ;
 N LA7Y
 S LA7Y=""
 I NCS="SCT" S LA7Y=$S(CODE=103551003:"T",CODE=103552005:"C",CODE=116990009:"E",CODE=48458007:"L",CODE=284701003:"S",CODE=103537003:"G",CODE=2105009:"M",CODE=103568004:"R",CODE=2105009:"F",1:"")
 Q LA7Y
 ;
 ;
SCT2PN(CODE,TEXT,NCS,VERSION) ; Convert Positive/Negative to local codes.
 ; Call with  CODE = positive/negative
 ;            TEXT = code text
 ;             NCS = name of coding system (SCT, 99xxx, L)
 ;         VERSION = code system version id
 ;
 ; Returns    LA7Y = local positive/negative code
 ;
 N LA7Y
 S LA7Y=""
 I NCS="SCT" S LA7Y=$S(CODE=10828004:"P",CODE=260385009:"N",1:"")
 Q LA7Y
