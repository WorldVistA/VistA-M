QACI2C ; OAKOIFO/TKW - DATA MIGRATION - BUILD LEGACY DATA TO BE MIGRATED (CONT.) ;5/1/06  12:09
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
TXTERR(FLD,LEN,REMOVEUP,NOTNULL) ; Check field for length, check for control characters
 ; FLD=Field to be checked, LEN=optional max length
 ; REMOVEUP=optional flag set to 1 to remove up-arrows from the text.
 ; NOTNULL=optional flag set to 1 if field cannot be null.
 ; Return 1 if any errors are encountered.
 N L,I,X,Y,ERR S REMOVEUP=$G(REMOVEUP)
 S L=$L(FLD),ERR=0
 I $G(LEN),L>LEN Q 1
 F I=1:1:L S X=$E(FLD,I,I) Q:ERR!(X="")  D
 . I REMOVEUP,X="^" S FLD=$E(FLD,1,I-1)_$E(FLD,I+1,L),I=I-1 Q
 . S Y=$A(X)
 . I Y>31,Y<127 Q
 . S ERR=1 Q
 I $G(NOTNULL),FLD="" Q 1
 Q ERR
 ;
CONVROC(OLDROC) ; Convert roc number to new format
 I OLDROC'?3N.AN1"."6N Q ""
 N NEWROC,X
 ; Make sure the first part of the ROC number is a valid station number
 S X=$P(OLDROC,".") Q:X="" ""
 I '$$LKUP^XUAF4(X) Q ""
 ; Convert the fiscal year part of the ROC number to 4 digits
 S X=$E($P(OLDROC,".",2),1,2)
 S X=$S(+X>9:"19"_X,1:"20"_X)
 ; Build the new ROC number, adding one more digit to the sequential counter part of the ROC number.
 S NEWROC=$P(OLDROC,".")_"."_X_"0"_$E($P(OLDROC,".",2),3,6)
 Q NEWROC
 ;
ENDELALL(PATSBY) ; Wipe out list of previously migrated reference table data
 F TYPE="ROC","HL","USER","PT","CC","EMPINV","FSOS" K ^XTMP("QACMIGR",TYPE,"D")
 S PATSBY=1
 Q
 ;
BLDTXT(ROCNO,ROCIEN,QACI0,ROCCNT,RESERR,EDITITXT,EDITRTXT) ; Build issue and resolution text into output global
 ; Issue Text
 N I,X,ITXTCNT,ITXTLN,ITXTLONG,OLDROC,RESERR1,RESERR2
 I QACI0 N ROCCNT
 S ROCCNT=1,(ITXTCNT,ITXTLN,ITXTLONG)=0
 S OLDROC=$P(^QA(745.1,ROCIEN,0),"^")
 F I=0:0 S I=$O(^QA(745.1,ROCIEN,4,I)) Q:'I!(ITXTLONG)  S X=$G(^(I,0)) D 
 . I $E(X,$L(X))'=" " S X=X_" "
 . I $$TXTERR(.X,256,1) D ERROC^QACI2A(OLDROC,"Issue Text node "_I_" too long or contains invalid characters") Q
 . I (ITXTCNT+$L(X))>3950 D  Q
 .. S ITXTCNT=ITXTCNT+43,ITXTLONG=1
 .. Q:QACI0
 .. S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+1)=ROCNO_"^ITXT^ ",^(ROCCNT+2)=ROCNO_"^ITXT^ "
 .. S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+3)=ROCNO_"^ITXT^  ****  Continued in Resolution Text  ****"
 .. S ROCCNT=ROCCNT+3
 .. Q
 . S ITXTCNT=ITXTCNT+$L(X)
 . S ITXTLN=I
 . ; If called from ^QACI0, we just need to check the text, not save it.
 . Q:QACI0
 . S ROCCNT=ROCCNT+1
 . S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT)=ROCNO_"^ITXT^"_X
 . Q
 ;If there was no issue text, set one line of text for migration.
 I ROCCNT=1,'QACI0 D
 . S ROCCNT=2,EDITITXT=1
 . S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",2)=ROCNO_"^ITXT^No data present in this field during migration from Patient Rep. Text required for closed ROCs in PATS."
 . Q
 ;
 ; Resolution Text
 S RESERR1="Resolution Text",RESERR2=" char.(8000 maximum)"
 S RESERR="0^"_RESERR1
 N RTXTCNT S RTXTCNT=0
 F I=0:0 S I=$O(^QA(745.1,ROCIEN,6,I)) Q:'I  S X=$G(^(I,0)) D
 . I $E(X,$L(X))'=" " S X=X_" "
 . S RTXTCNT=RTXTCNT+$L(X)
 . I $$TXTERR(.X,256,1) D ERROC^QACI2A(OLDROC,"Resolution Text Node "_I_" too long or contains invalid characters") Q
 . ; If resolution text is too long, quit, but keep track of total length.
 . Q:RTXTCNT>8000
 . ; If called from ^QACI0, just check for errors, don't save text.
 . Q:QACI0
 . S ROCCNT=ROCCNT+1
 . S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT)=ROCNO_"^RTXT^"_X
 . Q
 S RESERR=RTXTCNT_"^"_RESERR1
 I RTXTCNT>8000 D ERROC^QACI2A(OLDROC,RESERR1_"="_RTXTCNT_RESERR2)
 ;
 ; If issue text was too long, store it in the resolution text for migration
 I ITXTLONG D
 . S RESERR1="Resolution + overflow issue text"
 . S RTXTCNT=RTXTCNT+76
 . I 'QACI0,RTXTCNT'>8000 D
 .. S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+1)=ROCNO_"^RTXT^ ",^(ROCCNT+2)=ROCNO_"^RTXT^ "
 .. S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+3)=ROCNO_"^RTXT^  ****  (continued) Issue Text transferred during Data Migration  ****"
 .. S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+4)=ROCNO_"^RTXT^ "
 .. S ROCCNT=ROCCNT+4,EDITRTXT=1
 .. Q
 . ; Read through remaining issue text and append it to resolution text.
 . F I=ITXTLN:0 S I=$O(^QA(745.1,ROCIEN,4,I)) Q:'I  S X=$G(^(I,0)) D
 .. I $E(X,$L(X))'=" " S X=X_" "
 .. S RTXTCNT=RTXTCNT+$L(X)
 .. I $$TXTERR(.X,256,1) D ERROC^QACI2A(OLDROC,"Issue Text Node "_I_" too long or contains invalid characters") Q
 .. I QACI0!(RTXTCNT>8000) Q
 .. S ROCCNT=ROCCNT+1
 .. S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT)=ROCNO_"^RTXT^"_X
 .. Q
 . S RTXTCNT=RTXTCNT+42
 . S RESERR=RTXTCNT_"^"_RESERR1
 . I RTXTCNT>8000 D ERROC^QACI2A(OLDROC,RESERR1_"="_RTXTCNT_RESERR2) Q
 . Q:QACI0
 . S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+1)=ROCNO_"^RTXT^ ",^(ROCCNT+2)=ROCNO_"^RTXT^ "
 . S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+3)=ROCNO_"^RTXT^  ****  End of overflow Issue Text  ****"
 . S ROCCNT=ROCCNT+3
 . Q
 ; Store REFER CONTACT TO list in resolution text.
 Q:'$O(^QA(745.1,ROCIEN,11,0))
 S RESERR1=RESERR1_" + Refer To"
 S RTXTCNT=RTXTCNT+24
 I 'QACI0 D
 . S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+1)=ROCNO_"^RTXT^ ",^(ROCCNT+2)=ROCNO_"^RTXT^ "
 . S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+3)=ROCNO_"^RTXT^** REFER CONTACT TO **"
 . S ROCCNT=ROCCNT+3
 . Q
 F I=0:0 S I=$O(^QA(745.1,ROCIEN,11,I)) Q:'I  S X=+$G(^(I,0)) D
 . S X=$P($G(^VA(200,X,0)),"^")
 . S RTXTCNT=RTXTCNT+$L(X)+2
 . Q:QACI0!(RTXTCNT>8000)
 . S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+1)=ROCNO_"^RTXT^ "
 . S ^XTMP("QACMIGR","ROC","U",ROCNO_" ",ROCCNT+2)=ROCNO_"^RTXT^ "_X
 . S ROCCNT=ROCCNT+2
 . Q
 S RESERR=RTXTCNT_"^"_RESERR1
 I RTXTCNT>8000 D ERROC^QACI2A(OLDROC,RESERR1_"="_RTXTCNT_RESERR2)
 Q
 ;
ERREF(TYPE,IEN,MSG) ; Record an error on Reference Table Data
 N ERRCNT S ERRCNT=$O(^XTMP("QACMIGR",TYPE,"E",IEN,"A"),-1)+1
 S ^XTMP("QACMIGR",TYPE,"E",IEN,ERRCNT)=MSG Q
 ;
 ;
 ;
