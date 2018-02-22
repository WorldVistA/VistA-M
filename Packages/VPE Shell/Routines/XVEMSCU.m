XVEMSCU ;DJB/VSHL**Command Line History Utility [11/06/94];2017-08-15  4:46 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
QWIK(CLHCODE) ;Make a QWIK using CODE from Command Line History
 Q:$G(CLHCODE)']""
 NEW BOX,BX,FLAGJMP,FLAGQ,NAM,PROMPT,TXT
 S (FLAGJMP,FLAGQ)=0
 D GETQWIK Q:FLAGQ  S ^XVEMS("QU",XVV("ID"),NAM)=CLHCODE
 I $G(^XVEMS("QU",XVV("ID"),NAM))']"" Q
 D TEXT^XVEMSQE("DSC") Q:XVVSHC="<TAB>"!FLAGQ
 D TEXT^XVEMSQE("PARAM") Q:XVVSHC="<TAB>"!FLAGQ
 D BOX^XVEMSQE
 Q
GETQWIK ;
 D GETNAM^XVEMSQ(1) S:$G(NAM)']"" FLAGQ=1 Q:FLAGQ  D  S:'$$YN(PROMPT) FLAGQ=1
 . I $D(^XVEMS("QU",XVV("ID"),NAM)) S PROMPT="This QWIK already exists. Shall I overwrite? YES// " Q
 . S PROMPT="Do you want to add as a new QWIK? YES// "
 Q
YN(PROMPT) ;1=Ok to delete, 0=No delete
 NEW XX S PROMPT=$G(PROMPT)
YN1 ;
 W !?1,PROMPT R XX:500 S:'$T!(XX="^") XX="N" S:XX="" XX="Y" S XX=$E(XX)
 I "YyNn"'[XX W "   Y=YES  N=NO" G YN1
 I "Yy"'[XX Q 0
 Q 1
