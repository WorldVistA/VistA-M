ENFAR5A ;WIRMFO/SAB-FIXED ASSET RPT, VOUCHER SUMMARY (CONT); 8/1/96
 ;;7.0;ENGINEERING;**29,33**;Aug 17, 1993
GETDATA ; collect/sort data
 ; load table for converting FA Type to SGL
 K ENFAPTY S ENDA=0 F   S ENDA=$O(^ENG(6914.3,ENDA)) Q:'ENDA  D
 . S ENY0=$G(^ENG(6914.3,ENDA,0))
 . I $P(ENY0,U,3)]"" S ENFAPTY($P(ENY0,U,3))=$P(ENY0,U)
 ; loop thru FAP document file transactions within selected date range
 K ^TMP($J) F ENFILE="6915.2","6915.3","6915.4","6915.5","6915.6" D
 . S ENDT=ENDTS
 . F  S ENDT=$O(^ENG(ENFILE,"D",ENDT)) Q:ENDT=""!($P(ENDT,".")>ENDTE)  D
 . . S ENDA("F?")=0
 . . F  S ENDA("F?")=$O(^ENG(ENFILE,"D",ENDT,ENDA("F?"))) Q:'ENDA("F?")  D
 . . . S ENDA("FA")=$$AFA(ENFILE,ENDA("F?")) ; associated FA
 . . . S ENFAY3=$G(^ENG(6915.2,ENDA("FA"),3))
 . . . S ENX=$TR($E($P(ENFAY3,U,5),1,5)," ","")
 . . . Q:ENSNR'=ENX  ; not station
 . . . S:ENFILE=6915.2 ENFUND=$P(ENFAY3,U,10)
 . . . S:ENFILE'=6915.2 ENFUND=$$FUND(ENFILE,ENDA("F?"),ENDA("FA"))
 . . . S ENSGL=$S($P(ENFAY3,U,6)]"":$G(ENFAPTY($P(ENFAY3,U,6))),1:"")
 . . . Q:ENFUND=""!(ENSGL="")
 . . . I ENFILE=6915.2 S ENAMT=$P($G(^ENG(ENFILE,ENDA("F?"),3)),U,27)
 . . . I ENFILE=6915.3 S ENAMT=$P($G(^ENG(ENFILE,ENDA("F?"),4)),U,4)
 . . . I ENFILE=6915.4 S ENX=$P($G(^ENG(ENFILE,ENDA("F?"),4)),U,6),ENAMT=$S(ENX="":0,1:ENX-$P($G(^ENG(ENFILE,ENDA("F?"),100)),U,4))
 . . . I ENFILE=6915.5 S ENAMT="-"_$P($G(^ENG(ENFILE,ENDA("F?"),100)),U,2)
 . . . I ENFILE=6915.6 S ENAMT=$P($G(^ENG(ENFILE,ENDA("F?"),100)),U,8)
 . . . Q:+ENAMT=0  ; don't include transactions for $0
 . . . I ENFILE'=6915.6 D  ; process non-FR doc
 . . . . S ^TMP($J,ENFUND,ENSGL,ENDT,ENFILE_";"_ENDA("F?"))=ENAMT
 . . . I ENFILE=6915.6 D  ; process FR doc
 . . . . S ENFUNDNW=$P($G(^ENG(ENFILE,ENDA("F?"),3)),U,9)
 . . . . Q:ENFUND=ENFUNDNW  ; don't include if fund unchanged by FR
 . . . . S ^TMP($J,ENFUNDNW,ENSGL,ENDT,ENFILE_";"_ENDA("F?"))=ENAMT
 . . . . S ^TMP($J,ENFUND,ENSGL,ENDT,ENFILE_";"_ENDA("F?"))="-"_ENAMT
 K ENFAPTY
 Q
AFA(ENFILE,ENIEN) ; Associated FA Document Extrinsic Function
 ; Input Variables
 ;   ENFILE - FAP document file of the input document
 ;   ENIEN  - IEN of the input document in ENFILE
 ; Returns
 ;   IEN of the FA document which is associated with the input document
 ;   0 if no associated FA document could be found
 N ENDA,ENDTC,ENY0
 Q:ENFILE="6915.2" ENIEN ; FA document associated with itself
 S ENY0=$G(^ENG(ENFILE,ENIEN,0))
 S ENDA=$P(ENY0,U) ; equip id
 S ENDTC("F?")=$P(ENY0,U,2) ; date/time of non-FA document
 S ENDA("LFA")=0,ENDTC("LFA")="" ; initialize latest FA ien and date/time
 ; loop thru FA's for equip to determine latest FA before the input doc
 S ENDA("FA")=0
 F  S ENDA("FA")=$O(^ENG(6915.2,"B",ENDA,ENDA("FA"))) Q:'ENDA("FA")  D
 . S ENDTC("FA")=$P($G(^ENG(6915.2,ENDA("FA"),0)),U,2)
 . I ENDTC("FA")<ENDTC("F?"),ENDTC("FA")>ENDTC("LFA") S ENDA("LFA")=ENDA("FA"),ENDTC("LFA")=ENDTC("FA")
 Q ENDA("LFA")
 ;
FUND(ENFILE,ENIEN,ENFAIEN) ; Determine FUND at time of non-FA transaction
 ; Input Variables
 ;   ENFILE  - FAP document file for the input document
 ;   ENIEN   - IEN of the input document in ENFILE
 ;   ENFAIEN - IEN of the assoicated FA document
 ; Returns
 ;   Fund of equipment just before input document was processed
 N ENDA,ENDTC,ENFUND,ENY0
 S ENFUND=$P($G(^ENG(6915.2,ENFAIEN,3)),U,10) ; initial fund from FA
 S ENDTC("FA")=$P($G(^ENG(6915.2,ENFAIEN,0)),U,2) ; date/time of FA
 S ENY0=$G(^ENG(ENFILE,ENIEN,0))
 S ENDA=$P(ENY0,U) ; equip id
 S ENDTC("F?")=$P(ENY0,U,2) ; date/time of input doc
 ; Retrieve fund values from any FR's between FA and input document
 ;   by looping thru FR's for equip id
 S ENDA("FR")=0
 F  S ENDA("FR")=$O(^ENG(6915.6,"B",ENDA,ENDA("FR"))) Q:'ENDA("FR")  D
 . S ENDTC("FR")=$P($G(^ENG(6915.6,ENDA("FR"),0)),U,2)
 . I ENDTC("FR")>ENDTC("FA"),ENDTC("FR")<ENDTC("F?") S ENFUND(ENDTC("FR"))=$P($G(^ENG(6915.6,ENDA("FR"),3)),U,9)
 ; update initial fund from FA with any subsequent values from FR docs
 S ENDTC="" F  S ENDTC=$O(ENFUND(ENDTC)) Q:ENDTC=""  I ENFUND(ENDTC)]"" S ENFUND=ENFUND(ENDTC)
 Q ENFUND
 ;ENFAR5A
