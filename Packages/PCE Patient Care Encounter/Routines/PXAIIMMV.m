PXAIIMMV ;ISL/PKR - VALIDATE IMMUNIZATION DATA ;05/20/15  16:21
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**199,209**;Aug 12, 1996;Build 4
 ;
VAL ;Make sure the required field is present.
 I '$D(PXAA("IMMUN")) D  Q:$G(STOP)=1
 . S STOP=1
 . S PXAERRF=1
 . S PXADI("DIALOG")=8390001.001
 . S PXAERR(9)="IMMUNIZATION"
 . S PXAERR(10)="AFTER"
 . S PXAERR(11)=$G(PXAA("IMMUNIZATION"))
 . S PXAERR(12)="You are missing the name of the immunization"
 Q:$G(PXAA("DELETE"))=1  ; don't bother checking diagnoses if this is a deletion
 ; confirm valid diagnosis pointers
 N DIAGNUM,DIAGSTR,ICDDATA,PXDXDATE
 S PXDXDATE=$$CSDATE^PXDXUTL(PXAVISIT)
 F DIAGNUM=1:1:8 D  Q:$G(STOP)=1
 . S DIAGSTR="DIAGNOSIS"_$S(DIAGNUM>1:" "_DIAGNUM,1:"")
 . I $G(PXAA(DIAGSTR))]"" D
 .. S ICDDATA=$$ICDDATA^ICDXCODE("DIAG",$G(PXAA(DIAGSTR)),PXDXDATE,"I")
 .. I $P(ICDDATA,"^",1)'>0 D  Q:$G(STOP)=1
 ... S STOP=1
 ... S PXAERRF=1
 ... S PXADI("DIALOG")=8390001.001
 ... S PXAERR(9)="IMMUNIZATION"
 ... S PXAERR(10)="AFTER"
 ... S PXAERR(11)=$G(PXAA(DIAGSTR))
 ... S PXAERR(12)="IMMUNIZATION DIAGNOSIS #"_DIAGNUM_" ("_PXAERR(11)_") is NOT a valid pointer value to the ICD DIAGNOSIS FILE #80"
 .. I $P(ICDDATA,"^",10)'=1 D  Q:$G(STOP)=1
 ... S STOP=1
 ... S PXAERRF=1
 ... S PXADI("DIALOG")=8390001.001
 ... S PXAERR(9)="IMMUNIZATION"
 ... S PXAERR(10)="AFTER"
 ... S PXAERR(11)=$G(PXAA(DIAGSTR))
 ... S PXAERR(12)="IMMUNIZATION DIAGNOSIS #"_DIAGNUM_" ("_PXAERR(11)_") is NOT an Active ICD code"
 ;
 ; Validate VIMM 2.0 fields
 N PXFLD,PXFLDNAME,PXFLDNUM,PXVAL,PXFILE,PXOK,PXNEWVAL
 ;
 F PXFLD="SERIES^.04","LOT NUM^1207","INFO SOURCE^1301","ADMIN ROUTE^1302","ANATOMIC LOC^1303" D
 . ;
 . S PXFLDNAME=$P(PXFLD,"^",1)
 . S PXFLDNUM=$P(PXFLD,"^",2)
 . ;
 . S PXVAL=$G(PXAA(PXFLDNAME))
 . I PXVAL="" Q
 . ;
 . S PXFILE=9000010.11
 . S PXOK=$$VALFLD(PXFILE,PXFLDNUM,PXVAL)
 . I PXOK D
 . . S PXNEWVAL=$P(PXOK,"^",2)
 . . I PXNEWVAL'="" S PXAA(PXFLDNAME)=PXNEWVAL
 . I 'PXOK D
 . . D ERRMSG(8390001.002,0,PXVAL,PXFLDNAME)
 . . K PXAA(PXFLDNAME) ; Don't file this field, as it's invalid
 ;
 Q
 ;
VALFLD(PXFILE,PXFLDNUM,PXVAL) ;
 ;
 ; Validate field and return:
 ;
 ;    1   - Field is valid
 ;    1^X - Field is valid, but was external value.
 ;          The function will return the internal
 ;          value in the 2nd piece (X).
 ;    0   - Field is invalid
 ;
 N PXOK,PXEXT,PXCODES,PXI,PXX,PXCODE,PXCODEVAL,PXTEMP
 ;
 S PXOK=1
 ;
 I PXVAL="@" Q PXOK
 ;
 S PXEXT=$$EXTERNAL^DILFD(PXFILE,PXFLDNUM,,PXVAL,"PXERR")
 S PXOK=(PXEXT'="")
 ;
 ; If value is not valid, and field is set-of-codes,
 ; check to see if external value was passed in.
 ; If that was the case, set PXOK to 1,
 ; and return internal value in 2nd piece of PXOK
 I 'PXOK,($$GET1^DID(PXFILE,PXFLDNUM,,"TYPE",,"PXERR")="SET") D
 . S PXCODES=$$GET1^DID(PXFILE,PXFLDNUM,,"POINTER",,"PXERR")
 . F PXI=1:1:$L(PXCODES,";") D
 . . S PXX=$P(PXCODES,";",PXI)
 . . S PXCODE=$P(PXX,":",1)
 . . S PXCODEVAL=$P(PXX,":",2)
 . . I PXCODE=""!(PXCODEVAL="") Q
 . . S PXTEMP(PXCODEVAL)=PXCODE
 . S PXCODE=$G(PXTEMP(PXVAL))
 . I PXCODE'="" S PXOK="1^"_PXCODE
 ;
 Q PXOK
 ;
ERRMSG(PXDLG,PXSTOP,PXVAL,PXFLDNAME) ;
 ;
 S STOP=$G(PXSTOP,0)
 S PXAERRF=1
 S PXADI("DIALOG")=$G(PXDLG,"8390001.002")
 I $G(PXAERR(9))'="" D
 . S PXAERR(9)=PXAERR(9)_", "
 . S PXAERR(11)=PXAERR(11)_", "
 . S PXAERR(12)=PXAERR(12)_" "
 S PXAERR(9)=$G(PXAERR(9))_PXFLDNAME
 S PXAERR(11)=$G(PXAERR(11))_PXVAL
 S PXAERR(12)=$G(PXAERR(12))_"'"_PXVAL_"' is not a valid value for field "_PXFLDNAME_"."
 ;
 Q
