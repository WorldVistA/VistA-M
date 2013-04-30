LA7VOBX1 ;DALOI/JMC - LAB OBX Segment message builder (CH subscript) cont'd ;10/06/11  16:54
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,61,63,64,71,68,74**;Sep 27, 1994;Build 229
 ;
CH ; Observation/Result segment for "CH" subscript results.
 ; Called by LA7VOBX
 ;
 N LA760,LA76304,LA7ALT,LA7DDERR,LA7DIV,LA7I,LA7RS,LA7X,LA7Y,X
 ;
 ; "CH" subscript requires a dataname
 I '$G(LRSB) Q
 ;
 ; get result node from LR global.
 S LA76304(0)=$G(^LR(LRDFN,LRSS,LRIDT,0))
 S LA7RS=$P(LRSB,"^",2),LRSB=$P(LRSB,"^")
 S LA7VAL=$G(^LR(LRDFN,LRSS,LRIDT,LRSB))
 ; If previous results have been corrected then send corrected status
 I LA7RS="",$P(LA7VAL,"^",10)=2 S LA7RS="C"
 ;
 ; Check if test is OK to send - (O)utput or (B)oth
 S LA7X=$P(LA7VAL,"^",12)
 I LA7X]"","BO"'[LA7X Q
 I LA7X="",'$$OKTOSND^LA7VHLU1(LRSS,LRSB,+$P($P(LA7VAL,"^",3),"!",7)) Q
 ;
 ; If no result NLT or LOINC try to determine from file #60
 S LA7X=$P(LA7VAL,"^",3)
 I $P(LA7X,"!",2)=""!($P(LA7X,"!",3)="") S $P(LA7VAL,"^",3)=$$DEFCODE^LA7VHLU5(LRSS,LRSB,LA7X,$P(LA76304(0),"^",5))
 ; No result NLT code - log error
 I $P($P(LA7VAL,"^",3),"!",2)="" D
 . N LA7X
 . S LA7X="["_LRSB_"]"_$$GET1^DID(63.04,LRSB,"","LABEL")
 . D CREATE^LA7LOG(36)
 ;
 ; Send back an OBX if individual test from a panel was NP'ed - ccr_6164n
 I $P(LA7VAL,"^")="",$G(LA7VNP) S $P(LA7VAL,"^")="canc"
 ;
 ; something missing - No result.
 I $P(LA7VAL,"^")="" Q
 ;
 ; Check for missing units/reference ranges
 D CHECK
 ;
 ; Initialize OBX segment
 S LA7OBX(0)="OBX"
 S LA7OBX(1)=$$OBX1^LA7VOBX(.LA7OBXSN)
 ;
 ; Value type
 ; If result is "cancel", "comment" or "pending" then data type is ST - string data
 S LA7X=$S("canccommentpending"[$P(LA7VAL,"^"):1,1:0)
 I LA7X,LA7INTYP'=30 S LA7OBX(2)="ST"
 E  S LA7OBX(2)=$$OBX2^LA7VOBX(63.04,LRSB)
 I LA7OBX(2)'="NM",$P(LA7VAL,"^")?1(1.N,.N1"."1.N) S LA7OBX(2)="NM"
 ;
 ; Observation identifer
 ; build alternate code based on dataname from file #63 in case it's needed
 S LA7X=$P(LA7VAL,"^",3)
 S LA7ALT="CH"_LRSB_"^"_$$GET1^DID(63.04,LRSB,"","LABEL")_"^99VA63"
 I $P(LA7X,"!",7) S LA760=$P(LA7X,"!",7)
 E  S LA760=+$O(^LAB(60,"C","CH;"_LRSB_";1",0))
 I LA760 S $P(LA7ALT,"^",4,6)=LA760_"^"_$P(^LAB(60,LA760,0),"^")_"^99VA60"
 S LA7OBX(3)=$$OBX3^LA7VOBX($P(LA7X,"!",2),$P(LA7X,"!",3),LA7ALT,LA7FS,LA7ECH,$G(LA7INTYP))
 ;
 ; Build sub-id to aid in linking updates to previous transmissions.
 S LA7OBX(4)=$$OBX4^LA7VOBX("CH"_LRSB,LA7FS,LA7ECH)
 ;
 ; Test value
 ; If DoD and "canc" then report "PL Cancelled" per Lab Interop ICD.
 S LA7X=$P(LA7VAL,"^") K LA7DDERR
 I LA7X'="canc",$$GET1^DID(63.04,LRSB,"","TYPE","","LA7DDERR")="SET" D
 . S LA7X=$$EXTERNAL^DILFD(63.04,LRSB,"",LA7X)
 . I LA7X="" S LA7X=$P(LA7VAL,"^")
 I $G(LA7NVAF)=1,LA7X="canc" S LA7X="PL Cancelled"
 S LA7OBX(5)=$$OBX5^LA7VOBX(LA7X,LA7OBX(2),LA7FS,LA7ECH)
 ; Log exception when data dictionary appears corrupt.
 I $D(LA7DDERR) D CREATE^LA7LOG(121) K LA7DDERR
 ;
 ; Suppress "pending" results when sending to HDR
 I LA7INTYP=30,$P(LA7VAL,"^")="pending" S LA7OBX(2)="",LA7OBX(5)=""
 ;
 ; Units
 S LA7X=$P(LA7VAL,"^",5)
 S LA7OBX(6)=$$OBX6^LA7VOBX($P(LA7X,"!",7),"",LA7FS,LA7ECH,$G(LA7INTYP))
 ;
 ; Reference range - use therapeutic low/high if present.
 K LA7Y
 I $P(LA7X,"!",11)="",$P(LA7X,"!",12)="" D
 . S LA7Y("LOW")=$P(LA7X,"!",2)
 . S LA7Y("HIGH")=$P(LA7X,"!",3)
 E  D
 . S LA7Y("LOW")=$P(LA7X,"!",11)
 . S LA7Y("HIGH")=$P(LA7X,"!",12)
 ;
 S LA7OBX(7)=$$OBX7^LA7VOBX(LA7Y("LOW"),LA7Y("HIGH"),LA7FS,LA7ECH)
 K LA7Y
 ;
 ; Abnormal flags
 S LA7OBX(8)=$$OBX8^LA7VOBX($P(LA7VAL,"^",2))
 ;
 ; "P"artial or "F"inal results
 S LA7X=$S("canccommentpending"[$P(LA7VAL,"^"):$P(LA7VAL,"^"),1:"F")
 I LA7RS="C" D
 . S LA7X=LA7RS
 . I LA7INTYP=30,$P(LA7VAL,"^")="pending" S LA7X="W",LA7OBX(5)=""""""
 S LA7OBX(11)=$$OBX11^LA7VOBX(LA7X)
 I LA7INTYP=30,$P(LA7VAL,"^")="canc",LA7OBX(11)="X" S LA7OBX(2)="",LA7OBX(5)=""
 ;
 ; Observation date/time - collection date/time per HL7 standard
 S LA7X=$P(LA76304(0),"^") S:$P(LA76304(0),"^",2) LA7X=$P(LA7X,".")
 I LA7X S LA7OBX(14)=$$OBX14^LA7VOBX(LA7X)
 ;
 S LA7DIV=$P(LA7VAL,"^",9)
 I LA7DIV="" S LA7DIV=$P($G(^LR(LRDFN,LRSS,LRIDT,"RF")),"^")
 I LA7DIV="",$$DIV4^XUSER(.LA7DIV,$P(LA7VAL,"^",4)) S LA7DIV=$O(LA7DIV(0))
 ;
 ; Facility that performed the testing
 S LA7OBX(15)=$$OBX15^LA7VOBX(LA7DIV,LA7FS,LA7ECH)
 ;
 ; Person that verified the test
 S LA7OBX(16)=$$OBX16^LA7VOBX($P(LA7VAL,"^",4),LA7DIV,LA7FS,LA7ECH)
 ;
 ; Observation method - workkload suffix (LA7X) and result NLT code (LA7Y)
 S LA7X=$P($P(LA7VAL,"^",3),"!",4),LA7Y=$P($P(LA7VAL,"^",3),"!",2)
 I LA7X'=""!(LA7Y="") S LA7OBX(17)=$$OBX17^LA7VOBX(LA7X,LA7Y,LA7FS,LA7ECH)
 ;
 ; Equipment entity identifier
 I $P(LA7VAL,"^",11)'="" S LA7OBX(18)=$$OBX18^LA7VOBX($P(LA7VAL,"^",11),LA7FS,LA7ECH)
 ;
 ; Date/time of the analysis
 I $P(LA7VAL,"^",6)'="" S LA7OBX(19)=$$OBX19^LA7VOBX($P(LA7VAL,"^",6))
 ;
 ; Performing organization name/address
 I LA7DIV'="" D
 . N LA7DT
 . S LA7OBX(23)=$$OBX23^LA7VOBX(4,LA7DIV,LA7FS,LA7ECH)
 . S LA7DT=$S($P(LA7VAL,"^",6):$P(LA7VAL,"^",6),$P(LA76304(0),"^",3):$P(LA76304(0),"^",3),1:$$NOW^XLFDT)
 . S LA7OBX(24)=$$OBX24^LA7VOBX(4,LA7DIV,LA7DT,LA7FS,LA7ECH)
 ;
 D BUILDSEG^LA7VHLU(.LA7OBX,.LA7ARRAY,LA7FS)
 ;
 Q
 ;
 ;
CHECK ; Check for missing units/reference ranges
 ;
 N LA7I,LA7X,LA7FLAG
 S LA7X=$P(LA7VAL,"^",5)
 ;
 ; If flag (NPC>1) indicates units/ranges are stored but pieces 5-9 are null then use values from file #60
 ; - some class III software still does not store this info in file #63 when NPC>1
 S LA7FLAG=0
 I $G(^LR(LRDFN,LRSS,LRIDT,"NPC"))>1 D
 . F LA7I=5:1:9 I $P(LA7VAL,"^",LA7I)'="" S LA7FLAG=1 Q
 I 'LA7FLAG D BUNR
 ;
 ; Evaluate low/high reference ranges in case M code in these fields.
 S:$G(SEX)="" SEX="M" S:$G(AGE)="" AGE=99
 F LA7I=2,3,11,12 I $E($P(LA7X,"!",LA7I),1,3)="$S(" D
 . S @("X="_$P(LA7X,"!",LA7I))
 . S $P(LA7X,"!",LA7I)=X
 ;
 ; Put units/reference ranges back in variable LA7VAL
 S $P(LA7VAL,"^",5)=LA7X
 ;
 Q
 ;
 ;
BUNR ; Build units/normal ranges from file #60
 ;
 N LA7Y
 S LA7Y=$$REFUNIT^LA7VHLU1(LRSB,$P(LA76304(0),"^",5))
 ;
 ; Results missing units, use value from file #60
 I $P(LA7X,"!",7)="" S $P(LA7X,"!",7)=$P(LA7Y,"^",3)
 ;
 ; If results missing reference ranges, use values from file #60.
 I $P(LA7X,"!",2)="",$P(LA7X,"!",3)="",$P(LA7X,"!",11)="",$P(LA7X,"!",12)="" D
 . I $P(LA7X,"!",2)="",$P(LA7X,"!",3)="" D
 . . S $P(LA7X,"!",2)=$P(LA7Y,"^")
 . . S $P(LA7X,"!",3)=$P(LA7Y,"^",2)
 . I $P(LA7X,"!",11)="",$P(LA7X,"!",12)="" D
 . . S $P(LA7X,"!",11)=$P(LA7Y,"^",6)
 . . S $P(LA7X,"!",12)=$P(LA7Y,"^",7)
 Q
