PXRMMH ; SLC/PKR - Handle mental health findings. ;11/23/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
 ;=======================================================
EVALFI(DFN,DEFARR,ENODE,FIEVAL) ;Evaluate mental health findings.
 D EVALFI^PXRMINDX(DFN,.DEFARR,ENODE,.FIEVAL)
 Q
 ;
 ;=======================================================
EVALPL(FINDPA,ENODE,TERMARR,PLIST) ;Evaluate mental health term findings
 ;for patient lists.
 D EVALPL^PXRMINDL(.FINDPA,ENODE,.TERMARR,PLIST)
 Q
 ;
 ;=======================================================
EVALTERM(DFN,FINDPA,ENODE,TERMARR,TFIEVAL) ;Evaluate mental
 ;health instrument terms.
 D EVALTERM^PXRMINDX(DFN,.FINDPA,ENODE,.TERMARR,.TFIEVAL)
 Q
 ;
 ;=======================================================
GETDATA(DASP,FIEVT) ;Return the data for a MH Administrations entry.
 ;Some tests require the YSP key in order to get a score.
 N DAS,DATA,IND,SCALE
 S DAS=$P(DASP,"S",1)
 S SCALE=+$P(DASP,"S",2)
 ;DBIA #5043
 D ENDAS71^YTQPXRM6(.DATA,DAS)
 I $G(DATA(1))="[ERROR]" Q
 I SCALE=0 S SCALE=+$O(DATA("SI",""))
 S FIEVT("MH TEST")=$P(DATA(2),U,3)
 S IND=0
 F  S IND=$O(DATA("SI",IND)) Q:IND=""  S FIEVT("S",IND)=$P(DATA("SI",IND),U,3,4)
 S IND=0
 F  S IND=$O(DATA("R",IND)) Q:IND=""  S FIEVT("R",IND)=$P(DATA("R",IND),U,6)
 I $D(DATA("SI",SCALE)) S FIEVT("VALUE")=FIEVT("S",SCALE),FIEVT("SCALE NAME")=$P(DATA("SI",SCALE),U,2)
 Q
 ;
 ;=======================================================
MHVOUT(INDENT,IFIEVAL,NLINES,TEXT) ;Produce the MHV output.
 N DATE,IND,JND,MHTEST,NOUT,SCALE,SNAME,SCORE,TEXTOUT
 S MHTEST="Mental Health Test: "_IFIEVAL("MH TEST")_" = "
 S IND=0
 F  S IND=+$O(IFIEVAL(IND)) Q:IND=0  D
 . S DATE="("_$$EDATE^PXRMDATE(IFIEVAL(IND,"DATE"))_")"
 . S TEMP=MHTEST_DATE
 . S SNAME=$G(IFIEVAL(IND,"SCALE NAME"))
 . I SNAME'="" S TEMP=TEMP_" scale: "_SNAME_" -"
 . S SCORE=$G(IFIEVAL(IND,"VALUE"))
 . I SCORE'="" S TEMP=TEMP_"  raw score: "_$P(SCORE,U,1)_", transformed score: "_$P(SCORE,U,2)
 . D FORMATS^PXRMTEXT(INDENT+2,PXRMRM,TEMP,.NOUT,.TEXTOUT)
 . F JND=1:1:NOUT S NLINES=NLINES+1,TEXT(NLINES)=TEXTOUT(JND)
 S NLINES=NLINES+1,TEXT(NLINES)=""
 Q
 ;
 ;=======================================================
OUTPUT(INDENT,IFIEVAL,NLINES,TEXT) ;Produce the clinical
 ;maintenance output.
 N IND,JND,MHTEST,NOUT,SCALE,SNAME,SCORE,TEXTOUT
 S MHTEST=IFIEVAL("MH TEST")
 S NLINES=NLINES+1
 S TEXT(NLINES)=$$INSCHR^PXRMEXLC(INDENT," ")_"Mental Health Test: "_MHTEST
 S IND=0
 F  S IND=+$O(IFIEVAL(IND)) Q:IND=0  D
 . S TEMP=$$EDATE^PXRMDATE(IFIEVAL(IND,"DATE"))
 . S SNAME=$G(IFIEVAL(IND,"SCALE NAME"))
 . I SNAME'="" S TEMP=TEMP_" scale: "_SNAME_" -"
 . S SCORE=$G(IFIEVAL(IND,"VALUE"))
 . I SCORE'="" S TEMP=TEMP_"  raw score: "_$P(SCORE,U,1)_", transformed score: "_$P(SCORE,U,2)
 . D FORMATS^PXRMTEXT(INDENT+2,PXRMRM,TEMP,.NOUT,.TEXTOUT)
 . F JND=1:1:NOUT S NLINES=NLINES+1,TEXT(NLINES)=TEXTOUT(JND)
 S NLINES=NLINES+1,TEXT(NLINES)=""
 Q
 ;
 ;=======================================================
SCHELP(MHIEN) ;Xecutable help for MH SCALE
 N DATA,IND,JND,NUM,SCALE,SNUM
 I MHIEN=0 D  Q
 . S SCALE(1)="This is not a valid Mental Health finding, selecting an MH scale does"
 . S SCALE(2)="not make sense"
 . D EN^DDIOL(.SCALE)
 ;DBIA #5053
 D SCALES^YTQPXRM5(.DATA,MHIEN)
 I DATA(1)="ERROR" D  Q
 . S SCALE(1)="There are no scales for this test."
 . D EN^DDIOL(.SCALE)
 S SCALE(1)="Valid scales are:"
 S SCALE(2)="SCALE NUMBER  SCALE NAME"
 S SCALE(3)="------------------------"
 S IND=0,JND=3
 F  S IND=$O(DATA("S",IND)) Q:IND=""  D
 . S JND=JND+1
 . S NUM=6-$L(IND)
 . S SCALE(JND)=$$INSCHR^PXRMEXLC(NUM," ")_(IND)_"        "_$P(DATA("S",IND),U,1)
 D EN^DDIOL(.SCALE)
 Q
 ;
 ;=======================================================
SCHELPD(DA) ;Xecutable help for MH SCALE in Result Group file 801.41
 N MHIEN
 S MHIEN=+$P($G(^PXRMD(801.41,DA,50)),U)
 D SCHELP^PXRMMH(MHIEN)
 Q
 ;=======================================================
SCHELPF ;Xecutable help for MH SCALE in 811.9 findings.
 N FIND0,MHIEN
 S FIND0=^PXD(811.9,DA(1),20,DA,0)
 I FIND0["YTT(601.71" S MHIEN=$P(FIND0,";",1)
 E  S MHIEN=0
 D SCHELP(MHIEN)
 Q
 ;
 ;=======================================================
SCHELPT ;Xecutable help for MH SCALE in 811.5 findings.
 N MHIEN,TFIND0
 S TFIND0=^PXRMD(811.5,DA(1),20,DA,0)
 I TFIND0["YTT(601.71" S MHIEN=$P(TFIND0,";",1)
 E  S MHIEN=0
 D SCHELP(MHIEN)
 Q
 ;
 ;=======================================================
SCNAME(TEST,SCNUM) ;Given the test ien and scale number return the
 ;scale name.
 N DATA,SCNAME
 D SCALES^YTQPXRM5(.DATA,TEST)
 Q $G(DATA("S",SCNUM))
 ;
 ;=======================================================
SEVALFI(DFN,ITEM,NGET,SDIR,BDT,EDT,NFOUND,FLIST) ;
 N FIEV,FINDING,IND,YS,DATA
 S YS("CODE")=ITEM,YS("DFN")=DFN
 S YS("BEGIN")=BDT,YS("END")=EDT
 ;PTTEST^YTQPXRM2 does not understand "*" for a limit so use 99.
 I NGET="*" S NGET=99
 S YS("LIMIT")=$S(SDIR=-1:NGET,1:-NGET)
 ;DBIA #5035
 D PTTEST^YTQPXRM2(.DATA,.YS)
 S NFOUND=$P(DATA(1),U,2)
 I NFOUND=0 Q
 F IND=1:1:NFOUND S FLIST(IND)=DATA(IND+1)
 Q
 ;
 ;=======================================================
SEVALPL(ITEM,NOCC,BDT,EDT,PLIST) ;Use MH API to get patient list. Called
 ;from PXRMINDL.
 N YS
 ;YTAPI10A does not understand "*" for a limit so use 99.
 ;OCCUR^YTQPXRM1 does not understand "*" for a limit so use 99.
 I NOCC="*" S NOCC=99
 S YS("CODE")=ITEM,YS("BEGIN")=BDT,YS("END")=EDT,YS("LIMIT")=NOCC
 ;DBIA #5034
 D OCCUR^YTQPXRM1(PLIST,.YS)
 Q
 ;
 ;=======================================================
VSCALE(X,FIND0) ;Make sure that the mental health scale is valid.
 ;Either the scale number or the scale name can be used.
 N DATA,IND,MHIEN,MHTEST,SCALE,VALID
 S MHTEST=$P(FIND0,U,1)
 S MHIEN=$P(MHTEST,";",1)
 D SCALES^YTQPXRM5(.DATA,MHIEN)
 I +X>0 S VALID=$S($D(DATA("S",X)):1,1:0)
 E  D
 . S IND=1,VALID=0
 . F  S IND=$O(DATA("S",IND)) Q:(VALID)!(IND="")  D
 .. I X=$P(DATA("S",IND),U,1) S VALID=1 Q
 I 'VALID D EN^DDIOL(X_" is not a valid scale for this test!")
 I $O(DATA(""),-1)>20 H 1
 Q VALID
 ;
 ;=======================================================
VSCALED(X,DA) ;Make sure that the mental health scale is valid for a result
 ;group.
 I X="" Q 1
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 N MHTEST
 S MHTEST=$P($G(^PXRMD(801.41,DA,50)),U)
 Q $$VSCALE(X,MHTEST)
 ;
 ;=======================================================
VSCALEF(X) ;Make sure that the mental health scale is valid for a finding.
 I X="" Q 1
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 N FIND0
 S FIND0=^PXD(811.9,DA(1),20,DA,0)
 Q $$VSCALE(X,FIND0)
 ;
 ;=======================================================
VSCALET(X) ;Make sure that the mental health scale is valid for a 
 ;term finding.
 I X="" Q 1
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 N TFIND0
 S TFIND0=^PXRMD(811.5,DA(1),20,DA,0)
 Q $$VSCALE(X,TFIND0)
 ;
 ;=======================================================
WARN ;Warn the user that they must select a scale if they intend to use
 ;a condition.
 W !,"Remember that the score is returned as raw score^transformed score,"
 W !,"so if your Condition uses the raw score use +V or $P(V,U,1) and if"
 W !,"it uses the transformed score use $P(V,U,2)."
 Q
 ;
