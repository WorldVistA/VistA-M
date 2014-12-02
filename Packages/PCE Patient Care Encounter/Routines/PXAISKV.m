PXAISKV ;ISL/PKR - VALIDATE SKIN TEST DATA ;24 May 2013  7:39 AM
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**199**;Aug 12, 1996;Build 51
 ;
VAL ;Make sure the required field is present.
 I '$D(PXAA("TEST")) D  Q:$G(STOP)=1
 . S STOP=1
 . S PXAERRF=1
 . S PXADI("DIALOG")=8390001.001
 . S PXAERR(9)="SKIN TEST"
 . S PXAERR(10)="AFTER"
 . S PXAERR(11)=$G(PXAA("SKIN TEST"))
 . S PXAERR(12)="You are missing the name of the skin test"
 Q:$G(PXAA("DELETE"))=1  ; don't bother checking diagnoses if this is a deletion
 ; confirm valid diagnosis pointers
 N DIAGSTR,DIAGNUM,ICDDATA,PXDXDATE
 S PXDXDATE=$$CSDATE^PXDXUTL(PXAVISIT)
 F DIAGNUM=1:1:8 D  Q:$G(STOP)=1
 . S DIAGSTR="DIAGNOSIS"_$S(DIAGNUM>1:" "_DIAGNUM,1:"")
 . I $G(PXAA(DIAGSTR))]"" D
 .. S ICDDATA=$$ICDDATA^ICDXCODE("DIAG",$G(PXAA(DIAGSTR)),PXDXDATE,"I")
 .. I $P(ICDDATA,"^",1)'>0 D  Q:$G(STOP)
 ... S STOP=1
 ... S PXAERRF=1
 ... S PXADI("DIALOG")=8390001.001
 ... S PXAERR(9)="SKIN TEST"
 ... S PXAERR(10)="AFTER"
 ... S PXAERR(11)=$G(PXAA(DIAGSTR))
 ... S PXAERR(12)="SKIN TEST DIAGNOSIS #"_DIAGNUM_" ("_PXAERR(11)_") is NOT a valid pointer value to the ICD DIAGNOSIS FILE #80"
 .. I $P(ICDDATA,"^",10)'=1 D  Q:$G(STOP)
 ... S STOP=1
 ... S PXAERRF=1
 ... S PXADI("DIALOG")=8390001.001
 ... S PXAERR(9)="SKIN TEST"
 ... S PXAERR(10)="AFTER"
 ... S PXAERR(11)=$G(PXAA(DIAGSTR))
 ... S PXAERR(12)="SKIN TEST DIAGNOSIS #"_DIAGNUM_" ("_PXAERR(11)_") is NOT an Active ICD code"
 ;
 Q
