LA7VOBX2 ;DALOI/JMC - LAB OBX Segment message builder (AP subscripts) cont'd ;May 15,2007
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,68**;Sep 27, 1994;Build 56
 ;
AP ; Build OBX segments for resultss that are anatomic/surgical pathology subscripts
 ; Called by LA7VOBX
 ;
 N LA7953,LA7ACODE,LA7CODE,LA7DIV,LA7IENS,LA7OBX5,LA7OBX5M,LA7SUB,LA7SUBFL,LA7VP,LA7WP,LA7X,LA7Y
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
 S LA7CODE=$$DEFCODE^LA7VHLU5(LRSS,LRSB,"","")
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
 ; Observation sub-ID
 ; Create sub-ID for supplementary reports and special studies
 D SUBID
 ;
 ; Build result field
 I LRSB=.012 D
 . N LA7I,LA7X,LA7Y
 . S LA7I=0
 . F  S LA7I=$O(^LR(LRDFN,LRSS,LRIDT,.1,LA7I)) Q:'LA7I  D
 . . S LA7X=$G(^LR(LRDFN,LRSS,LRIDT,.1,LA7I,0))
 . . S LA7Y(LA7I)=$P(LA7X,"^")
 . . S LA7OBX(2)="CE" ; Override DD to conform to HL7 standard
 . S LA7OBX(5)=$$OBX5R^LA7VOBX(.LA7Y,LA7OBX(2),LA7FS,LA7ECH)
 ;
 I LRSB'=.012 D
 . I $P(LRSB,",")=10,LRSB'="10,5" Q
 . I LA7NVAF=1 D DOD Q
 . I LRSB=1.2 N LRSB S LA7SUBFL=$S(LRSS="SP":63.817,LRSS="CY":63.907,LRSS="EM":63.207,1:""),LRSB=1
 . I LRSB="10,5" N LRSB S LA7SUBFL=$S(LRSS="SP":63.819,LRSS="CY":63.919,LRSS="EM":63.219,1:""),LRSB=1
 . D OBX5M^LA7VOBX(LA7SUBFL,LA7IENS,LRSB,.LA7WP,LA7FS,LA7ECH)
 . D BUILDSEG^LA7VHLU(.LA7WP,.LA7OBX5M,"")
 . M LA7OBX(5)=LA7OBX5M
 ;
 I $P(LRSB,",")=10,LRSB'="10,5" D
 . N LA7VAL,LA7SUBFL,X
 . I LRSS="SP",LRSB="10,2" D  Q
 . . S LA7VAL=$$GET1^DIQ(63.12,LA7IENS,2)
 . . S LA7OBX(5)=$$OBX5^LA7VOBX(LA7VAL,LA7OBX(2),LA7FS,LA7ECH)
 . . S LA7OBX(6)=$$OBX6^LA7VOBX("g","",LA7FS,LA7ECH,$G(LA7INTYP))
 . I LRSB=10 S LA7SUBFL=$S(LRSS="SP":63.12,LRSS="CY":63.912,LRSS="EM":63.212,1:"")
 . I LRSB="10,1.5" S LA7SUBFL=$S(LRSS="SP":63.82,LRSS="CY":63.982,LRSS="EM":63.282,1:"")
 . S LA7VAL=$$GET1^DIQ(LA7SUBFL,LA7IENS,.01)
 . S X=$$GET1^DIQ(LA7SUBFL,LA7IENS,".01:2")
 . I X'="" S LA7VAL=$S($E(X,1,2)="T-":"",1:"T-")_X_"^"_LA7VAL_"^SNM",LA7OBX(2)="CE"
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
 I '$P(LA7SUB(0),"^",11) S LA7OBX(11)="P"
 ;
 ; If release date then check for changes
 I $P(LA7SUB(0),"^",11) D
 . I $P(LA7SUB(0),"^",15) S LA7OBX(11)="C"
 . E  S LA7OBX(11)="F"
 ;
 S LA7DIV=$P($G(^LR(LRDFN,LRSS,LRIDT,"RF")),"^")
 I LA7DIV="",$P(LA7SUB(0),"^",13),$$DIV4^XUSER(.LA7DIV,$P(LA7SUB(0),"^",2)) S LA7DIV=$O(LA7DIV(0))
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
 ; Used to identify supplementary reports, specimens and related special
 ; studies performed on thoese specimens.
 ;
 N LA7SUBID
 ;
 S LA7SUBID=""
 ;
 ; Sub-id's for supplementary reports
 I LRSB=1.2 S LA7SUBID="1."_$P(LA7IENS,",")
 ;
 ; Sub-id's for specimens and special studies
 I LRSB=10!(LRSB="10,2") S LA7SUBID="10."_$P(LA7IENS,",")
 I LRSB="10,1.5"!(LRSB="10,5") S LA7SUBID="10."_$P(LA7IENS,",",2)_"."_$P(LA7IENS,",")
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
 S LA7OBX(2)="ST"
 S LA7VAL=$G(^LR(LRDFN,LRSS,$P(LA7IDT,","),LA7SB,$P(LA7IDT,",",2),0))
 I LA7VAL="" S LA7VAL=" "
 S LA7OBX(5)=$$OBX5^LA7VOBX(LA7VAL,LA7OBX(2),LA7FS,LA7ECH)
 Q
