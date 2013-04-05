LA7VOBX4 ;DALOI/JMC - LAB OBX Segment message builder (MI subscripts) cont'd ;11/18/11  14:48
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 ; Continuation of LA7VOBX3
 ;
 Q
 ;
 ;
GEN ; Fields common to all MI OBX segments.
 ;
 ;
 ; Initialize OBX segment
 S LA7OBX(0)="OBX"
 S LA7OBX(1)=$$OBX1^LA7VOBX(.LA7OBXSN)
 ;
 S LA7OBX(3)=$$OBX3^LA7VOBX($P(LA7CODE,"!",2),$P(LA7CODE,"!",3),LA7ALT,LA7FS,LA7ECH,$G(LA7INTYP))
 ;
 ; Test value
 S LA7OBX(5)=$$OBX5^LA7VOBX(LA7VAL,LA7OBX(2),LA7FS,LA7ECH)
 ;
 ; Set sub-id and save for constructing parents
 I LA7ISOID'="" D
 . S LA7OBX(4)=$$OBX4^LA7VOBX(LA7ISOID,LA7FS,LA7ECH)
 . I LA7SAVID D
 . . F I=1,2 S LA7ISOID(LA7ISOID,I)=LA7OBX(I+2)
 . . I $G(HL("VER"))="2.2" S LA7ISOID(LA7ISOID,3)=LA7OBX(5) Q
 . . F I=2,4 I $P(LA7OBX(5),$E(LA7ECH,1),I)'="" S LA7ISOID(LA7ISOID,3)=$P(LA7OBX(5),$E(LA7ECH,1),I) Q
 ;
 ; Order result status - "P"artial, "F"inal , "A"mended results
 ; If no status from individual components then use status from zeroth node.
 ; If no release date then pending else final
 ; If amended, overrides all other status
 ;
 S LA7OBX(11)=$$OBX11^LA7VOBX(LA7RS)
 ;
 ; Observation date/time - collection date/time per HL7 standard
 I $P(LA76305(0),"^") S LA7OBX(14)=$$OBX14^LA7VOBX($P(LA76305(0),"^"))
 ;
 S LA7DIV=""
 I LA7PLREF'="" S LA7DIV=$P($$RESPL^LA7VHLU2(LA7PLREF),"^")
 I 'LA7DIV S LA7DIV=$P($G(^LR(LRDFN,"MI",LRIDT,"RF")),"^")
 I 'LA7DIV,$$DIV4^XUSER(.LA7DIV,$P(LA76305(0),"^",4)) S LA7DIV=$O(LA7DIV(0))
 ;
 ; Facility that performed the testing
 S LA7OBX(15)=$$OBX15^LA7VOBX(LA7DIV,LA7FS,LA7ECH)
 ;
 ; Person that verified the test
 I $P(LA76305(0),"^",4) S LA7VERP=$P(LA76305(0),"^",4)
 I LA7VERP S LA7OBX(16)=$$OBX16^LA7VOBX(LA7VERP,LA7DIV,LA7FS,LA7ECH)
  ;
 ; Performing organization name/address
 I LA7DIV'="" D
 . N LA7DT
 . S LA7OBX(23)=$$OBX23^LA7VOBX(4,LA7DIV,LA7FS,LA7ECH)
 . S LA7DT=$S($P(LA76305(0),"^",3):$P(LA76305(0),"^",3),1:$$NOW^XLFDT)
 . S LA7OBX(24)=$$OBX24^LA7VOBX(4,LA7DIV,LA7DT,LA7FS,LA7ECH)
 ;
 D BUILDSEG^LA7VHLU(.LA7OBX,.LA7ARRAY,LA7FS)
 ;
 Q
 ;
 ;
CC ; Organism's Colony count
 ; If "CFU/ml" found then move units to OBX-6 (Units).
 N LA7X
 ;
 S LA7IENS=LRIDT(2)_","_LRIDT_","_LRDFN_","
 S LA7OBX(2)=$$OBX2^LA7VOBX(LA7SUBFL,1)
 ;
 ; Isolate ID as sub-id
 S LA7ISOID=$$GETISO^LA7VHLU1(LA7SUBFL,LA7IENS)
 ;
 S LA7VAL=$$GET1^DIQ(LA7SUBFL,LA7IENS,1)
 S LA7X=$$UP^XLFSTR(LA7VAL)
 I LA7X["CFU/ML" D
 . S LA7OBX(6)=$$OBX6^LA7VOBX("CFU/ml","",LA7FS,LA7ECH,$G(LA7INTYP))
 . S LA7X("CFU/ml")="",LA7X("CFU/ML")=""
 . S LA7VAL=$$REPLACE^XLFSTR(LA7VAL,.LA7X)
 ;
 S LA7Y="MI-"_$P(LRSB,",")_"-1^"_$$GET1^DID(LA7SUBFL,1,"","LABEL")_"^99VA63"
 S LA7ALT=LA7Y_"^"_LA7Y
 S LA7PLREF=LRDFN_",MI,"_LRIDT_",3,"_LRIDT(2)
 ;
 Q
 ;
 ;
ORG ; Organism
 ;
 N LA7X,LA7Y
 ;
 S LA7OBX(2)=$$OBX2^LA7VOBX(LA7SUBFL,.01)
 S LA7IENS=LRIDT(2)_","_LRIDT_","_LRDFN_","
 S LA7VAL=""
 ;
 ; Isolate ID as sub-id
 S LA7ISOID=$$GETISO^LA7VHLU1(LA7SUBFL,LA7IENS)
 ;
 I $G(LA7NVAF)=1 S LA7OBX(2)="CE"
 S LA7X=$$GET1^DIQ(LA7SUBFL,LA7IENS,.01,"I"),LA7X(.01)=$$GET1^DIQ(LA7SUBFL,LA7IENS,.01)
 ; Check for SNOMED coding/local coding as alternate
 S LA7Y=$$IEN2SCT^LA7VHLU6(61.2,LA7X,DT)
 I LA7Y D
 . S LA7VAL=$P(LA7Y,"^",1,3),$P(LA7VAL,"^",4,6)=LA7X_"^"_LA7X(.01)_"^99VA61.2"
 . I $G(LA7NVAF)'=1 S LA7OBX(2)="CWE",$P(LA7VAL,"^",7,8)=$P(LA7Y,"^",4)_"^5.2",$P(LA7VAL,"^",9)=LA7X(.01)
 ; If no SNOMED then use local coding as primary
 I LA7VAL="" D
 . S LA7VAL=LA7X_"^"_LA7X(.01)_"^99VA61.2"
 . I $G(LA7NVAF)'=1 S LA7OBX(2)="CWE",$P(LA7VAL,"^",7)="5.2",$P(LA7VAL,"^",9)=LA7X(.01)
 ;
 S LA7Y="MI-"_$P(LRSB,",")_"-.01^"_$$GET1^DID(LA7SUBFL,.01,"","LABEL")_"^99VA63"
 S LA7ALT=LA7Y_"^"_LA7Y
 ;
 S LA7OBX(8)=$$OBX8^LA7VOBX("A")
 ;
 S LA7PLREF=LRDFN_",MI,"_LRIDT_","_$P(LRSB,",")_","_LRIDT(2)_",0"
 ;
 ; Set flag to save sub-id for parent-child relationship
 S LA7SAVID=1
 Q
 ;
 ;
MIC ; Organism's susceptibilities
 ;
 N LA7IENS,LA7SCT,LA7SUB,LA7X,LA7Y
 ;
 ; Bact or TB organism
 S LA7SUB=$S($P(LRSB,",")=12:3,1:12)
 ;
 S LA7OBX(2)=$$OBX2^LA7VOBX(62.06,.01)
 ;
 ; Determine local code for antibiotic if not mapped to NLT or in file #62.06
 ;  - Use file #62.06 entry if available otherwise generate from drug node field in file #63
 ;    also used to convey local display name in 9th component
 S (LA7ALT,LA7X,LA7Y)=""
 I $P(LRSB,",")=12 S LA7X=$O(^LAB(62.06,"AD",$P(LRSB,",",2),0))
 I $P(LRSB,",")=26 S LA7X=$O(^LAB(62.06,"AD1",$P(LRSB,",",2),0))
 I LA7X S LA7Y=LA7X_"^"_$$GET1^DIQ(62.06,LA7X_",",.01)_"^99VA62.06"
 I LA7Y="" D
 . S LA7X=$P(LRSB,",",2),LA7Y=$O(^DD(LA7SUBFL,"GL",LA7X,1,0))
 . I LA7Y<1 Q
 . S LA7Y="MIAB"_$P(LRSB,",")_"-"_$P(LRSB,",",2)_"^"_$$GET1^DID(LA7SUBFL,LA7Y,"","LABEL")_"^99VA63"
 I $P(LA7CODE,"!",2)=""!($P(LA7CODE,"!",3)="") S LA7ALT=LA7Y
 S $P(LA7ALT,"^",4,6)=LA7Y
 ;
 S LA7X=$G(^LR(LRDFN,"MI",LRIDT,LA7SUB,LRIDT(2),LRIDT(3)))
 I $P(LA7X,"^",2)'="" S $P(LA7X,"^",2)=$$TRIM^XLFSTR($P(LA7X,"^",2),"RL"," ")
 S LA7VAL=$$TRIM^XLFSTR($P(LA7X,"^"),"RL"," ")
 I LA7VAL'="" D
 . I "MSIR"[$E(LA7VAL),$G(LA7NVAF)'=1 D
 . . S LA7Y=$S(LA7VAL="S":131196009,LA7VAL="MS":260357007,LA7VAL="R":30714006,LA7VAL="I":264841006,1:"")
 . . I LA7Y D MTSCT
 . I $E($P(LA7X,"^",2))?1(1"S",1"I",1"R") S LA7OBX(8)=$$OBX8^LA7VOBX($E($P(LA7X,"^",2))) Q
 . I $E($P(LA7X,"^",2),1,2)?1(1"MS",1"VS") S LA7OBX(8)=$$OBX8^LA7VOBX($E($P(LA7X,"^",2),1,2))
 ;
 ; Determine access screen for this susceptibility
 I $P(LA7X,"^",3)="" S $P(LA7X,"^",3)="A"
 S LA7OBX(13)=$$OBX13^LA7VOBX($P(LA7X,"^",3),$S($G(LA7INTYP)=30:"MIS-HDR",1:"MIS"),LA7FS,LA7ECH)
 ;
 S LA7PLREF=LRDFN_",MI,"_LRIDT_","_LA7SUB_","_LRIDT(2)_","_LRIDT(3)
 ;
 Q
 ;
 ;
MICA ; Bacteria organism's susceptibilities - free text
 ;
 N LA7SUB,LA7X
 S LA7OBX(2)="NM"
 ;
 ; Bact organism
 S LA7SUB=3
 ;
 ; Determine local code for free text antibiotic also used to convey local display name in 9th component
 S LA7X=$G(^LR(LRDFN,"MI",LRIDT,LA7SUB,LRIDT(2),3,LRIDT(3),0))
 S LA7ALT="MIAB"_$P(LRSB,",")_"-"_$P(LRSB,",",2)_"-"_$P(LRSB,",",3)_"^"_$P(LA7X,"^")_$S($P(LRSB,",",3)=1:" MIC",1:" MBC")_"^99VA63"
 S LA7ALT=LA7ALT_"^"_LA7ALT
 S $P(LA7CODE,"!",2)="87565.0000"
 S $P(LA7CODE,"!",3)=$S($P(LRSB,",",3)=1:21070,1:23658)
 ;
 S LA7VAL=$P(LA7X,"^",$S($P(LRSB,",",3)=1:2,1:3))
 ;
 S LA7OBX(6)="UG/ML"
 S LA7OBX(8)=""
 ;
 Q
 ;
 ;
PSTAGE ; Parasite's stage
 ;
 N LA7IENS,LA7SUB,LA7X,LA7Y
 ;
 S LA7SUB=6,LA7VAL=""
 S LA7OBX(2)=$$OBX2^LA7VOBX(63.35,.01)
 ;
 ; Isolate ID as sub-id
 S LA7ISOID=$$GETISO^LA7VHLU1(63.34,LRIDT(2)_","_LRIDT_","_LRDFN_",")
 ;
 S LA7IENS=LRIDT(3)_","_LRIDT(2)_","_LRIDT_","_LRDFN_","
 S LA7VAL=$$GET1^DIQ(LA7SUBFL,LA7IENS,.01,"E")
 S LA7X=$P($G(^LR(LRDFN,"MI",LRIDT,LA7SUB,LRIDT(2),1,LRIDT(3),0)),"^")
 S LA7Y=$S(LA7X="T":103551003,LA7X="C":103552005,LA7X="E":116990009,LA7X="L":48458007,LA7X="S":284701003,LA7X="G":103537003,LA7X="M":2105009,LA7X="R":103568004,LA7X="F":2105009,1:"")
 I LA7Y S LA7X=LA7VAL D MTSCT
 ;
 S LA7Y="MI-"_$P(LRSB,",")_"-.01^"_$$GET1^DID(63.35,.01,"","LABEL")_"^99VA63"
 S LA7ALT=LA7Y_"^"_LA7Y
 ;
 I LA7VAL'="" S LA7OBX(8)=$$OBX8^LA7VOBX("A")
 ;
 S LA7PLREF=LRDFN_",MI,"_LRIDT_",6,"_LRIDT(2)_",1,"_LRIDT(3)
 ;
 Q
 ;
 ;
PQTY ; Parasite's stage quantity
 ;
 N LA7IENS,LA7SUB
 ;
 S LA7SUB=6,LA7VAL=""
 S LA7OBX(2)=$$OBX2^LA7VOBX(63.35,1)
 ;
 ; Isolate ID as sub-id
 S LA7ISOID=$$GETISO^LA7VHLU1(63.34,LRIDT(2)_","_LRIDT_","_LRDFN_",")
 ;
 S LA7X=$G(^LR(LRDFN,"MI",LRIDT,LA7SUB,LRIDT(2),1,LRIDT(3),0))
 S LA7VAL=$P(LA7X,"^",2)
 ;
 S LA7Y="MI-"_$P(LRSB,",")_"-1^"_$$GET1^DID(63.35,1,"","LABEL")_"^99VA63"
 S LA7ALT=LA7Y_"^"_LA7Y
 ;
 I LA7VAL'="" S LA7OBX(8)=$$OBX8^LA7VOBX("A")
 ;
 S LA7PLREF=LRDFN_",MI,"_LRIDT_",6,"_LRIDT(2)_",1,"_LRIDT(3)
 ;
 Q
 ;
 ;
MTSCT ; Map specific values to SNOMED CT
 ; Required variables
 ;     LA7X = local reportable result - Will be inserted in 9th component as local term
 ;     LA7Y = SCT code to lookup
 ;   LA7VAL = encoded SCT term with local term
 ;
 N LA7SCT
 I $$CODE^LEXTRAN(LA7Y,"SCT",DT,"LA7SCT")>0 D
 . S LA7VAL=$P(LA7SCT(0),"^")_"^"_LA7SCT("P")_"^SCT"
 . I $G(LA7NVAF)'=1 S LA7OBX(2)="CWE",$P(LA7VAL,"^",7)=$P(LA7SCT(0),"^",3),$P(LA7VAL,"^",9)=$P(LA7X,"^")
 . E  S LA7OBX(2)="CE"
 Q
