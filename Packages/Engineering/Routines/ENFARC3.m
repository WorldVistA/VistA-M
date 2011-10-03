ENFARC3 ;WIRMFO/SAB-FIXED ASSET RPT, TRANSACTION REGISTER (CONT); 12/16/1998
 ;;7.0;ENGINEERING;**39,60**;Aug 17, 1993
 Q
 ;
FCPVAL(ENFILE,ENIEN,ENFAIEN) ; Determine prior values at time of FC
 ; Input Variables
 ;   ENFILE  - FAP document file for the input document
 ;   ENIEN   - IEN of the input document in ENFILE
 ;   ENFAIEN - IEN of the assoicated FA document
 ; Returns
 ;   EN(30)  - previous DESCRIPTION
 ;   EN(34)  - previous ACQ METHOD CODE
 ;   EN(105) - previous ACQ DATE (FileMan format)
 ;   also when betterment = 00
 ;   EN(29)  - previous LOCATION (NATIONAL EIL)
 ;   EN(37)  - previous USEFUL LIFE
 ;   EN(106) - previous REPL DATE (FileMan format)
 Q:ENFILE'=6915.4  ; must be FC Document
 N ENDA,ENDOC,ENDTC,ENFC,ENY
 ; get initial values (from FA or FB)
 S (EN(30),EN(34),EN(105),EN(29),EN(37),EN(106))=""
 S ENFC("BETR")=$P($G(^ENG(ENFILE,ENIEN,3)),U,8)
 I ENFC("BETR")="00" D
 . S ENDTC("I")=$P($G(^ENG(6915.2,ENFAIEN,0)),U,2) ; date/time of FA
 . S ENY(3)=$G(^ENG(6915.2,ENFAIEN,3))
 . S EN(30)=$P(ENY(3),U,15)
 . S EN(34)=$P(ENY(3),U,19)
 . I $P(ENY(3),U,16)]"" D
 . . S EN(105)=$P(ENY(3),U,16)-1700
 . . S EN(105)=EN(105)_$E("00",1,2-$L($P(ENY(3),U,17)))_$P(ENY(3),U,17)
 . . S EN(105)=EN(105)_$E("00",1,2-$L($P(ENY(3),U,18)))_$P(ENY(3),U,18)
 . S EN(29)=$P(ENY(3),U,8)
 . S EN(37)=$P(ENY(3),U,24)
 . I $P(ENY(3),U,21)]"" D
 . . S EN(106)=$P(ENY(3),U,21)-1700
 . . S EN(106)=EN(106)_$E("00",1,2-$L($P(ENY(3),U,22)))_$P(ENY(3),U,22)
 . . S EN(106)=EN(106)_$E("00",1,2-$L($P(ENY(3),U,23)))_$P(ENY(3),U,23)
 I ENFC("BETR")'="00" D
 . S ENFC("FB")=$P($G(^ENG(6915.4,ENIEN,100)),U,5) ; betterment pointer
 . S ENDTC("I")=$P($G(^ENG(6915.3,ENFC("FB"),0)),U,2) ; date/time of FB
 . S ENY(3)=$S(ENFC("FB"):$G(^ENG(6915.3,ENFC("FB"),3)),1:"")
 . S EN(30)=$P(ENY(3),U,8)
 . S EN(34)=$P(ENY(3),U,12)
 . I $P(ENY(3),U,9)]"" D
 . . S EN(105)=$P(ENY(3),U,9)-1700
 . . S EN(105)=EN(105)_$E("00",1,2-$L($P(ENY(3),U,10)))_$P(ENY(3),U,10)
 . . S EN(105)=EN(105)_$E("00",1,2-$L($P(ENY(3),U,11)))_$P(ENY(3),U,11)
 ; Construct chrono list of FC and FR in time frame for Equipment
 S ENY(0)=$G(^ENG(ENFILE,ENIEN,0))
 S ENDA("EQ")=$P(ENY(0),U) ; equip id
 S ENDTC("F?")=$P(ENY(0),U,2) ; date/time of input doc
 ;   add FC documents to list
 S ENDA("FC")=0
 F  S ENDA("FC")=$O(^ENG(6915.4,"B",ENDA("EQ"),ENDA("FC"))) Q:'ENDA("FC")  D
 . S ENDTC("FC")=$P($G(^ENG(6915.4,ENDA("FC"),0)),U,2)
 . I ENDTC("FC")>ENDTC("I"),ENDTC("FC")<ENDTC("F?") D
 . . Q:ENFC("BETR")'=$P($G(^ENG(ENFILE,ENDA("FC"),3)),U,8)  ; diff betr
 . . S ENDOC(ENDTC("FC"),"6915.4;"_ENDA("FC"))=""
 ;   add FR documents to list
 S ENDA("FR")=0
 F  S ENDA("FR")=$O(^ENG(6915.6,"B",ENDA("EQ"),ENDA("FR"))) Q:'ENDA("FR")  D
 . S ENDTC("FR")=$P($G(^ENG(6915.6,ENDA("FR"),0)),U,2)
 . I ENDTC("FR")>ENDTC("I"),ENDTC("FR")<ENDTC("F?") D
 . . S ENDOC(ENDTC("FR"),"6915.6;"_ENDA("FR"))=""
 ; Loop thru chrono list and update initial values as appropriate
 S ENDTC="" F  S ENDTC=$O(ENDOC(ENDTC)) Q:ENDTC=""  D
 . S ENY="" F  S ENY=$O(ENDOC(ENDTC,ENY)) Q:ENY=""  D
 . . S ENFILE=$P(ENY,";"),ENDA=$P(ENY,";",2)
 . . I ENFILE=6915.4 D  ; FC Document
 . . . S ENY(3)=$G(^ENG(6915.4,ENDA,3))
 . . . S ENY(4)=$G(^ENG(6915.4,ENDA,4))
 . . . S ENY(100)=$G(^ENG(6915.4,ENDA,100))
 . . . S:$P(ENY(3),U,11)]"" EN(30)=$P(ENY(3),U,11)
 . . . S:$P(ENY(3),U,15)]"" EN(34)=$P(ENY(3),U,15)
 . . . S:$P(ENY(100),U,6)]"" EN(105)=$P(ENY(100),U,6)
 . . . S:$P(ENY(3),U,10)]"" EN(29)=$P(ENY(3),U,10)
 . . . S:$P(ENY(4),U,3)]"" EN(37)=$P(ENY(4),U,3)
 . . . S:$P(ENY(100),U,7)]"" EN(106)=$P(ENY(100),U,Y)
 . . I ENFILE=6915.6 D  ; FR Document
 . . . S ENY(3)=$G(^ENG(6915.6,ENDA,3))
 . . . S:$P(ENY(3),U,14)]"" EN(29)=$P(ENY(3),U,14)
 Q
FRPVAL(ENFILE,ENIEN,ENFAIEN) ; Determine prior values at time of FR
 ; Input Variables
 ;   ENFILE  - FAP document file for the input document
 ;   ENIEN   - IEN of the input document in ENFILE
 ;   ENFAIEN - IEN of the assoicated FA document
 ; Returns
 ;   EN(28)  - previous FUND
 ;   EN(29)  - previous A/O
 ;   EN(32)  - previous BOC
 ;   EN(33)  - previous LOCATION (NATIONAL EIL)
 ;   EN(34)  - previous COST CENTER
 ;   EN(37)  - previous XAREA (CMR)
 Q:ENFILE'=6915.6  ; must be FR Document
 N ENDA,ENDOC,ENDTC,ENFC,ENY
 ; get initial values (from FA)
 S (EN(28),EN(29),EN(32),EN(33),EN(34))=""
 S ENDTC("I")=$P($G(^ENG(6915.2,ENFAIEN,0)),U,2) ; date/time of FA
 S ENY(3)=$G(^ENG(6915.2,ENFAIEN,3))
 S EN(28)=$P(ENY(3),U,10)
 S EN(29)=$P(ENY(3),U,11)
 S EN(32)=$P(ENY(3),U,14)
 S EN(33)=$P(ENY(3),U,8)
 S EN(34)=$P(ENY(3),U,28)
 S EN(37)=$P(ENY(3),U,31)
 ; Construct chrono list of FC and FR in time frame for Equipment
 S ENY(0)=$G(^ENG(ENFILE,ENIEN,0))
 S ENDA("EQ")=$P(ENY(0),U) ; equip id
 S ENDTC("F?")=$P(ENY(0),U,2) ; date/time of input doc
 ;   add FC documents to list
 S ENDA("FC")=0
 F  S ENDA("FC")=$O(^ENG(6915.4,"B",ENDA("EQ"),ENDA("FC"))) Q:'ENDA("FC")  D
 . S ENDTC("FC")=$P($G(^ENG(6915.4,ENDA("FC"),0)),U,2)
 . I ENDTC("FC")>ENDTC("I"),ENDTC("FC")<ENDTC("F?") D
 . . Q:$P($G(^ENG(ENFILE,ENDA("FC"),3)),U,8)'="00"  ; not FC to FA
 . . S ENDOC(ENDTC("FC"),"6915.4;"_ENDA("FC"))=""
 ;   add FR documents to list
 S ENDA("FR")=0
 F  S ENDA("FR")=$O(^ENG(6915.6,"B",ENDA("EQ"),ENDA("FR"))) Q:'ENDA("FR")  D
 . S ENDTC("FR")=$P($G(^ENG(6915.6,ENDA("FR"),0)),U,2)
 . I ENDTC("FR")>ENDTC("I"),ENDTC("FR")<ENDTC("F?") D
 . . S ENDOC(ENDTC("FR"),"6915.6;"_ENDA("FR"))=""
 ; Loop thru chrono list and update initial values as appropriate
 S ENDTC="" F  S ENDTC=$O(ENDOC(ENDTC)) Q:ENDTC=""  D
 . S ENY="" F  S ENY=$O(ENDOC(ENDTC,ENY)) Q:ENY=""  D
 . . S ENFILE=$P(ENY,";"),ENDA=$P(ENY,";",2)
 . . I ENFILE=6915.4 D  ; FC Document
 . . . S ENY(3)=$G(^ENG(6915.4,ENDA,3))
 . . . S:$P(ENY(3),U,10)]"" EN(33)=$P(ENY(3),U,10) ; location
 . . I ENFILE=6915.6 D  ; FR Document
 . . . S ENY(3)=$G(^ENG(6915.6,ENDA,3))
 . . . S:$P(ENY(3),U,9)]"" EN(28)=$P(ENY(3),U,9) ; fund
 . . . S:$P(ENY(3),U,10)]"" EN(29)=$P(ENY(3),U,10) ; a/o
 . . . S:$P(ENY(3),U,13)]"" EN(32)=$P(ENY(3),U,13) ; boc
 . . . S:$P(ENY(3),U,14)]"" EN(33)=$P(ENY(3),U,14) ; location
 . . . S:$P(ENY(3),U,15)]"" EN(34)=$P(ENY(3),U,15) ; cost ctr
 . . . S:$P(ENY(3),U,18)]"" EN(37)=$P(ENY(3),U,18) ; xarea
 Q
 ;ENFARC3
