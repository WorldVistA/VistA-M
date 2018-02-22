XVEMKTG ;DJB/KRN**Txt Scroll-Get array ;2017-08-15  1:12 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
GETG ;Get XVVT from a GLOBAL
 NEW CHK,LN,MAR,NUM,TMP
 S NUM=XVVT("BOT")
 S MAR=$G(XVV("IOM")) I MAR'>0 S MAR=80
 I $G(GLB)']"" S ^TMP("XVV","K",$J,NUM)=" <> <> <>" Q
 I $G(XVVMODE)="SC",'$D(^TMP("XVV","K",$J)),$D(@GLB)#2 G GETG1
 S GLB=$Q(@GLB)
 S CHK=0
 D  I CHK S ^TMP("XVV","K",$J,NUM)=" <> <> <>" Q
 . I GLB="" S CHK=1 Q
 . S TMP=GLB
 . I GLB?1"^[".E S TMP="^"_$P(GLB,"]",2)
 . I GLB?1"^|".E S TMP="^"_$P(GLB,"|",3)
 . I $E(TMP,1,$L(GLBHLD))'=GLBHLD S CHK=1 Q
 ;
 ;;I GLB["XVEMS" only display GLB value. It's VPE Help text.
GETG1 S @("LN="_GLB)
 I GLB'["XVEMS" S LN=GLB_" = "_LN
 F NUM=XVVT("BOT"):1 D  Q:LN']""
 . S ^TMP("XVV","K",$J,NUM)=$E(LN,1,MAR-2)
 . S LN=$E(LN,MAR-1,999) Q:LN']""
 . I $L(GLB)<40 S LN=$J("",$L(GLB))_" = "_LN Q
 . S LN="          = "_LN
 Q
 ;
GETH ;Get XVVT from a ROUTINE that's in Help text format
 NEW NUM,TXT
 S NUM=XVVT("BOT")
 X "S TXT=$T("_TAG_"+"_XVVT("LNCNT")_"^"_RTN_")"
 S XVVT("LNCNT")=XVVT("LNCNT")+1
 S:TXT']"" TXT=";;; <> <> <>"
 S ^TMP("XVV","K",$J,NUM)=$P(TXT,";;;",2,999)
 Q
 ;
GETI ;Get XVVT from IMPORT
 NEW LN,MAR,NUM
 S MAR=$G(XVV("IOM")) I MAR'>0 S MAR=80
 S LN=XVVT
 F NUM=XVVT("BOT"):1 D  Q:LN']""
 . S ^TMP("XVV","K",$J,NUM)=$E(LN,1,MAR-2)
 . S LN=$E(LN,MAR-1,9999)
 Q
 ;
GETL ;Get XVVT from a GLOBAL - Generic Lister
 NEW CHK,LN,NUM,TMP
 S NUM=XVVT("BOT")
 I $G(GLB)']"" S ^TMP("XVV","K",$J,NUM)=" <> <> <>" Q
 S GLB=$Q(@GLB)
 S CHK=0
 D  I CHK S ^TMP("XVV","K",$J,NUM)=" <> <> <>" Q
 . I GLB="" S CHK=1 Q
 . I GLB["]" D  S:$E(TMP,1,$L(GLBHLD))'=GLBHLD CHK=1 Q
 . . S TMP=$P(GLB,"[",1)_$P(GLB,"]",2)
 . I GLB["|" D  S:$E(TMP,1,$L(GLBHLD))'=GLBHLD CHK=1 Q
 . . S TMP=$P(GLB,"|",1)_$P(GLB,"|",3)
 . I $E(GLB,1,$L(GLBHLD))'=GLBHLD S CHK=1 Q
 S @("LN="_GLB),^TMP("XVV","K",$J,NUM)=LN
 Q
 ;
GETR ;Get XVVT from a ROUTINE
 NEW LN,MAR,NUM,TG,TXT
 S NUM=XVVT("BOT")
 S MAR=$G(XVV("IOM")) I MAR'>0 S MAR=80
 X "S TXT=$T("_TAG_"+"_XVVT("LNCNT")_"^"_RTN_")"
 I TXT']"" S ^TMP("XVV","K",$J,NUM)=" <> <> <>" Q
 S TG=$P(TXT," "),LN=$P(TXT," ",2,999)
 I TG]"" D  I 1
 . I $L(TG)>8 S LN=TG_LN Q
 . S LN=$J(TG,8)_" "_LN
 E  S LN=XVVT("LNCNT")_$E("         ",1,9-$L(XVVT("LNCNT")))_LN
 F NUM=XVVT("BOT"):1 D  Q:LN']""
 . S ^TMP("XVV","K",$J,NUM)=$E(LN,1,MAR-2)
 . S LN=$E(LN,MAR-1,9999) Q:LN']""
 . S LN="         "_LN
 S XVVT("LNCNT")=XVVT("LNCNT")+1
 Q
 ;
GETS ;Get XVVT from a GLOBAL - Generic Selector
 ;TOT is returned with count of entries
 NEW CHK,GLBN,LN,NUM,SUB,TMP
 S NUM=1,(SUB,TOT)=0
GETS1 S SUB=$O(@GLB@(SUB))
 S CHK=0
 D  I CHK S ^TMP("XVV","K",$J,NUM)=" <> <> <>" Q
 . I SUB'>0 S CHK=1 Q
 . S GLBN=GLBHLD_","_SUB_")"
 . I $O(@GLBN@(""))]"" S CHK=1 Q
 . I GLBN["]" D  S:$E(TMP,1,$L(GLBHLD))'=GLBHLD CHK=1 Q
 . . S TMP=$P(GLBN,"[",1)_$P(GLBN,"]",2)
 . I GLBN["|" D  S:$E(TMP,1,$L(GLBHLD))'=GLBHLD CHK=1 Q
 . . S TMP=$P(GLBN,"|",1)_$P(GLBN,"|",3)
 . I $E(GLBN,1,$L(GLBHLD))'=GLBHLD S CHK=1 Q
 S @("LN="_GLBN)
 S ^TMP("XVV","K",$J,NUM)=LN
 ;--> Set xref for FIND utility
 S ^TMP("XVV","K",$J,"B",$E($P(LN,$C(9),2),1,10),NUM)=""
 S TOT=NUM,NUM=NUM+1
 G GETS1
 ;
GETV ;Get XVVT from Routine Version file (19200.112).
 NEW LN,MAR,NUM,TG,TXT
 S NUM=XVVT("BOT")
 S MAR=$G(XVV("IOM")) I MAR'>0 S MAR=80
 ;
 I $G(GLB)']"" S ^TMP("XVV","K",$J,NUM)=" <> <> <>" Q
 S GLB=$Q(@GLB)
 I GLB="" S ^TMP("XVV","K",$J,NUM)=" <> <> <>" Q
 ;
 ;See if $QUERY has moved to a new IEN
 I $P(GLB,",",2)'=IEN S ^TMP("XVV","K",$J,NUM)=" <> <> <>" Q
 ;
 S @("TXT="_GLB)
 I TXT']"" S ^TMP("XVV","K",$J,NUM)=" <> <> <>" Q
 ;
 S TG=$P(TXT," "),LN=$P(TXT," ",2,999)
 I TG]"" D  I 1
 . I $L(TG)>8 S LN=TG_LN Q
 . S LN=$J(TG,8)_" "_LN
 E  S LN=XVVT("LNCNT")_$E("         ",1,9-$L(XVVT("LNCNT")))_LN
 F NUM=XVVT("BOT"):1 D  Q:LN']""
 . S ^TMP("XVV","K",$J,NUM)=$E(LN,1,MAR-2)
 . S LN=$E(LN,MAR-1,9999) Q:LN']""
 . S LN="         "_LN
 S XVVT("LNCNT")=XVVT("LNCNT")+1
 Q
