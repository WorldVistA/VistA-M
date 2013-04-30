LA7VOBX2 ;DALOI/JMC - LAB OBX Segment message builder (AP subscripts) cont'd ;10/20/10  10:21
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,68,74**;Sep 27, 1994;Build 229
 ;
AP ; Build OBX segments for results that are anatomic/surgical pathology subscripts
 ; Called by LA7VOBX
 ;
 ;ZEXCEPT: LA,LA76248,LA7ARRAY,LA7ECH,LA7FS,LA7INTYP,LA7NVAF,LA7OBX,LA7OBXSN,LRDFN,LRIDT,LRSB,LRSS
 ;
 N I,LA7953,LA7ACODE,LA7CODE,LA7DIV,LA7IENS,LA7OBX5,LA7OBX5M,LA7NLT,LA7SUB,LA7SUBFL,LA7VP,LA7WP,LA7X,LA7Y
 ;
 S (LA7953,LA7DIV,LA7VP)=""
 ;
 ; Surgical pathology subscript
 I LRSS="SP" S LA7SUBFL=63.08
 ;
 ; Cytology subscript
 I LRSS="CY" S LA7SUBFL=63.09
 ;
 ; Electron microscopy subscript
 I LRSS="EM" S LA7SUBFL=63.02
 ;
 S LA7IENS=""
 F I=3:-1:1 I $P(LRIDT,",",I) S LRIDT(I)=$P(LRIDT,",",I),LA7IENS=LA7IENS_LRIDT(I)_","
 S LA7IENS=LA7IENS_LRDFN_","
 S LRIDT=$P(LRIDT,",")
 S LA7SUB(0)=$G(^LR(LRDFN,LRSS,LRIDT,0))
 ;
 ; Get default codes
 S LA7NLT=$G(LA("NLT")),LA7CODE=LA7NLT_"!"
 S LA7CODE=$$DEFCODE^LA7VHLU5(LRSS,LRSB,LA7CODE,"")
 ;
 ; Initialize OBX segment
 S LA7OBX(0)="OBX"
 ;
 ; Value type
 S LA7X=LA7SUBFL,LA7Y=LRSB
 I LRSB=1.2 S LA7X=$S(LRSS="SP":63.817,LRSS="CY":63.907,LRSS="EM":63.207,1:""),LA7Y=1
 I LRSB="10,1.5" S LA7X=$S(LRSS="SP":63.82,LRSS="CY":63.982,LRSS="EM":63.282,1:""),LA7Y=.01
 I LRSB="10,2",LRSS="SP" S LA7X=63.12,LA7Y=2
 I LRSB="10,5" S LA7X=$S(LRSS="SP":63.819,LRSS="CY":63.919,LRSS="EM":63.219,1:""),LA7Y=1
 S LA7OBX(2)=$$OBX2^LA7VOBX(LA7X,LA7Y)
 ;
 ; Observation identifier
 S LA7OBX(3)=$$OBX3^LA7VOBX($P(LA7CODE,"!",2),$P(LA7CODE,"!",3),"",LA7FS,LA7ECH,$G(LA7INTYP))
 ;
 ; Observation sub-ID - create sub-ID for specimens, supplementary reports and special studies
 D SUBID
 ;
 ; Build result field
 ;  Check for substitute SNOMED CT on topography
 I $P(LRSB,",")=.012 D
 . N LA761,LA7J,LA7X,LA7Y,LA7Z,X
 . S LA7J=1,LA7X=$G(^LR(LRDFN,LRSS,LRIDT,.1,LRIDT(2),0)),LA7Y=""
 . S LA7Z=$O(^LAHM(62.48,LA76248,"SCT","AC",$P(LA7X,"^",6)_";LAB(61,",""))
 . S LA761=+$P(LA7X,"^",6)
 . I LA761 S LA761(0)=$P($G(^LAB(61,LA761,0)),"^")
 . I $P(LRSB,",",2)="",LA761 D
 . . S X=$$IEN2SCT^LA7VHLU6(61,LA761,DT,LA7Z)
 . . I X>0 S $P(LA7Y,"^",LA7J,LA7J+2)=$P(X,"^",1,3),$P(LA7Y,"^",$S(LA7J=1:7,1:8))=$P(X,"^",4),LA7J=4
 . . S $P(LA7Y,"^",LA7J)=LA761,$P(LA7Y,"^",LA7J+1)=LA761(0),$P(LA7Y,"^",LA7J+2)="99VA61",$P(LA7Y,"^",$S(LA7J=1:7,1:8))="5.2"
 . . S $P(LA7Y,"^",9)=$P(LA7X,"^")
 . . S LA7OBX(2)="CWE"
 . I $P(LRSB,",",2)=.01 S LA7Y=$P(LA7X,"^"),LA7OBX(2)="ST"
 . I $P(LRSB,",",2)=.06,LA761 D
 . . S X=$$IEN2SCT^LA7VHLU6(61,LA761,DT,LA7Z)
 . . I X>0 S $P(LA7Y,"^",LA7J,LA7J+2)=$P(X,"^",1,3),$P(LA7Y,"^",$S(LA7J=1:7,1:8))=$P(X,"^",4),LA7J=4
 . . S $P(LA7Y,"^",LA7J)=LA761,$P(LA7Y,"^",LA7J+1)=LA761(0),$P(LA7Y,"^",LA7J+2)="99VA61",$P(LA7Y,"^",$S(LA7J=1:7,1:8))="5.2"
 . . S $P(LA7Y,"^",9)=$P(LA7X,"^")
 . . S LA7OBX(2)="CWE"
 . I LA7Y'="" S LA7OBX(5)=$$OBX5^LA7VOBX(LA7Y,LA7OBX(2),LA7FS,LA7ECH)
 ;
 I $P(LRSB,",")'=.012 D
 . I $P(LRSB,",")=10,LRSB'="10,5" Q
 . I LA7NVAF=1 D DOD Q
 . I LRSB=1.2 N LRSB S LA7SUBFL=$S(LRSS="SP":63.817,LRSS="CY":63.907,LRSS="EM":63.207,1:""),LRSB=1
 . I LRSB="10,5" N LRSB S LA7SUBFL=$S(LRSS="SP":63.819,LRSS="CY":63.919,LRSS="EM":63.219,1:""),LRSB=1
 . D OBX5M^LA7VOBX(LA7SUBFL,LA7IENS,LRSB,.LA7WP,LA7FS,LA7ECH)
 . D BUILDSEG^LA7VHLU(.LA7WP,.LA7OBX5M,"")
 . M LA7OBX(5)=LA7OBX5M
 ;
 I $P(LRSB,",")=10,LRSB'="10,5" D
 . N LA7VAL,LA7SUBFL,LA7X,X
 . I LRSS="SP",LRSB="10,2" D  Q
 . . S LA7VAL=$$GET1^DIQ(63.12,LA7IENS,2)
 . . S LA7OBX(5)=$$OBX5^LA7VOBX(LA7VAL,LA7OBX(2),LA7FS,LA7ECH)
 . . S LA7OBX(6)=$$OBX6^LA7VOBX("g","",LA7FS,LA7ECH,$G(LA7INTYP))
 . I LRSB=10 S LA7SUBFL=$S(LRSS="SP":63.12,LRSS="CY":63.912,LRSS="EM":63.212,1:"")
 . I LRSB="10,1.5" S LA7SUBFL=$S(LRSS="SP":63.82,LRSS="CY":63.982,LRSS="EM":63.282,1:"")
 . S LA7VAL=$$GET1^DIQ(LA7SUBFL,LA7IENS,.01)
 . S LA7X=$$GET1^DIQ(LA7SUBFL,LA7IENS,".01","I")
 . I LA7X'="" D
 . . S X=$$IEN2SCT^LA7VHLU6(61,LA7X,DT,"")
 . . I X>0 S LA7VAL=$P(X,"^",1,3),$P(LA7VAL,"^",7)=$P(X,"^",4),LA7OBX(2)="CWE"
 . S LA7OBX(5)=$$OBX5^LA7VOBX(LA7VAL,LA7OBX(2),LA7FS,LA7ECH)
 ;
 ; Don't build this segment if no results/value to send
 I $G(LA7OBX(5,0))="",$G(LA7OBX(5))="" Q
 ;
 ; Build sequence id
 S LA7OBX(1)=$$OBX1^LA7VOBX(.LA7OBXSN)
 ;
 ; "P"artial, "F"inal , "A"mended results
 ; If not release date then pending
 I '$P(LA7SUB(0),"^",11) D
 . I LA7NVAF=1 S LA7OBX(11)="I" Q
 . S LA7OBX(11)="P"
 ;
 ; If release date then check for changes
 I $P(LA7SUB(0),"^",11) D
 . I $P(LA7SUB(0),"^",15) S LA7OBX(11)="C"
 . E  S LA7OBX(11)="F"
 ;
 ; Observation date/time - collection date/time per HL7 standard
 I $P(LA7SUB(0),"^") S LA7OBX(14)=$$OBX14^LA7VOBX($P(LA7SUB(0),"^"))
 ;
 S LA7DIV=$P($G(^LR(LRDFN,LRSS,LRIDT,"RF")),"^")
 I $P(LA7SUB(0),"^",13),$$DIV4^XUSER(.LA7DIV,$P(LA7SUB(0),"^",2)) S LA7DIV=$O(LA7DIV(0))
 ;
 ; Facility that performed the testing
 S LA7OBX(15)=$$OBX15^LA7VOBX(LA7DIV,LA7FS,LA7ECH)
 ;
 ; Person that verified the test
 S LA7VP=$P(LA7SUB(0),"^",13)
 I LA7VP S LA7OBX(16)=$$OBX16^LA7VOBX(LA7VP,LA7DIV,LA7FS,LA7ECH)
 ;
 ; Performing organization name/address
 I LA7DIV'="" D
 . N LA7DT
 . S LA7OBX(23)=$$OBX23^LA7VOBX(4,LA7DIV,LA7FS,LA7ECH)
 . S LA7DT=$S($P(LA7SUB(0),"^",11):$P(LA7SUB(0),"^",11),1:$$NOW^XLFDT)
 . S LA7OBX(24)=$$OBX24^LA7VOBX(4,LA7DIV,LA7DT,LA7FS,LA7ECH)
 ;
 D BUILDSEG^LA7VHLU(.LA7OBX,.LA7ARRAY,LA7FS)
 ;
 Q
 ;
 ;
SUBID ; Build sub-id for "SP" subscript
 ; Used to identify supplementary reports, specimens and related special studies performed on those specimens.
 ;
 ;ZEXCEPT: LA7ECH,LA7FS,LA7IENS,LA7NVAF,LA7OBX,LRDFN,LRIDT,LRSB,LRSS
 ;
 N LA7SUBID
 ;
 S LA7SUBID=""
 ;
 ; Sub-id's for specimen multiple
 ; For DoD/CHCS convert internal entry number to alphabetic character (ASCII 64 + #)
 ;  Create based on relative ien, not absolute. If first entry is ien 2 then sub-id is "A", 2nd entry is "B"
 I $P(LRSB,",")=.012 D
 . N I,J
 . I LA7NVAF'=1 S LA7SUBID="SPEC-"_$P(LA7IENS,",") Q
 . S I=0,J=1
 . F  S I=$O(^LR(LRDFN,LRSS,LRIDT,.1,I)) Q:'I!(I=$P(LA7IENS,","))  S J=J+1
 . S LA7SUBID=$C(64+J)
 ;
 ; Sub-id's for supplementary reports
 I LRSB=1.2 D
 . I LA7NVAF=1 S LA7SUBID="1-"_$P(LA7IENS,",",2) Q
 . S LA7SUBID="1-"_$P(LA7IENS,",")
 ;
 ; Sub-id's for specimens and special studies
 I LRSB=10!(LRSB="10,2") S LA7SUBID="10-"_$P(LA7IENS,",")
 I LRSB="10,1.5"!(LRSB="10,5") S LA7SUBID="10-"_$P(LA7IENS,",",2)_"."_$P(LA7IENS,",")
 ;
 I LA7SUBID'="" S LA7OBX(4)=$$OBX4^LA7VOBX(LA7SUBID,LA7FS,LA7ECH)
 ;
 Q
 ;
 ;
DOD ; Build OBX segment's to special DoD specifications.
 ; Send word-processing fields as series of OBX's for DoD.
 ; DoD cannot handle formatted text (FT) data type.
 ;
 ;ZEXCEPT: LA7ECH,LA7FS,LA7OBX,LA7VAL,LRDFN,LRIDT,LRSB,LRSS
 ;
 N LA7SB
 S LA7OBX(2)="ST",LA7SB=$S(LRSB=.013:.2,LRSB=.014:.3,LRSB=.015:.4,LRSB=.016:.5,1:LRSB)
 I LA7SB'=1.2 S LA7VAL=$G(^LR(LRDFN,LRSS,LRIDT(1),LA7SB,LRIDT(2),0))
 E  S LA7VAL=$G(^LR(LRDFN,LRSS,LRIDT(1),LA7SB,LRIDT(2),1,LRIDT(3),0))
 I LA7VAL="" S LA7VAL=" "
 S LA7OBX(5)=$$OBX5^LA7VOBX(LA7VAL,LA7OBX(2),LA7FS,LA7ECH)
 Q
