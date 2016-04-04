DIEZ4 ;SFISC/MKO-COMPILE INPUT TEMPLATE, RECORD-LEVEL INDEXES ;2:15 PM  14 Jul 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**11**
 ;
 ;Variables passed in through symbol table:
 ;  DNM  = Name of routine
 ;  DRN(routine#) = "" : array of routine numbers
 ;  DMAX = Maximum routine size
 ;  DIEZTMP = Root of global that contains record-level index info
 ;
 ;Routine-wide variables
 ;  T   = Total byte count of current routine
 ;  L   = Last line number in current routine
 ;  DP  = file #
 ;  DRN = routine #
 ;  DIEZCNT = Count of xrefs processed in current routine (used as
 ;            a line tag)
 ;  DIEZAR(file#,xref#) = linetag^routine (returned)
 ;  DIEZKEYR(file#,key#,uniqxref#) = Xn^routine
 ;
RECXR(DIEZAR) ;Build routines for record-level indexes
 Q:'$D(@DIEZTMP@("R"))
 N DIEZCNT,DIEZXR,DP
 ;
 S DRN=$O(DRN(""),-1)+1
 D NEWROU
 ;
 S DP=0 F  S DP=$O(@DIEZTMP@("R",DP)) Q:'DP  D  Q:$G(DIEZQ)
 . S DIEZXR=0
 . F  S DIEZXR=$O(@DIEZTMP@("R",DP,DIEZXR)) Q:'DIEZXR  D  Q:$G(DIEZQ)
 .. D GETXR(DIEZXR) Q:$G(DIEZQ)
 Q:$G(DIEZQ)
 D SAVE
 Q
 ;
GETXR(DIEZXR) ;Get code for one index DIEZXR
 N DIEZCOD,DIEZF,DIEZKLOG,DIEZNSS,DIEZO,DIEZSLOG
 I T>DMAX D SAVE Q:$G(DIEZQ)  D NEWROU
 ;
 S DIEZCNT=$G(DIEZCNT)+1
 S DIEZAR(DP,DIEZXR)=DIEZCNT_U_DNM_DRN
 ;
 ;Build code to call subroutine to set X array
 D L(DIEZCNT_" N X,X1,X2 S DIXR="_DIEZXR_" D X"_DIEZCNT_"(U) K X2 M X2=X D X"_DIEZCNT_"(""F"") K X1 M X1=X")
 ;
 ;Build code to check for null subscripts
 S DIEZNSS="",DIEZO=0
 F  S DIEZO=$O(@DIEZTMP@("R",DP,DIEZXR,DIEZO)) Q:'DIEZO  D
 . Q:'$G(@DIEZTMP@("R",DP,DIEZXR,DIEZO,"SS"))
 . I DIEZNSS="" S DIEZNSS="$G(X("_DIEZO_"))]"""""
 . E  S DIEZNSS=DIEZNSS_",$G(X("_DIEZO_"))]"""""
 I DIEZNSS]"" S DIEZNSS=" I "_DIEZNSS_" D"
 E  S DIEZNSS=" D"
 ;
 ;Store kill logic and condition
 S DIEZKLOG=$G(@DIEZTMP@("R",DP,DIEZXR,"K"))
 I DIEZKLOG'?."^" D
 . D L(DIEZNSS)
 . ;Build kill condition code
 . S DIEZCOD=$G(@DIEZTMP@("R",DP,DIEZXR,"KC"))
 . I DIEZCOD'?."^" D
 .. D L(" . N DIEZCOND,DIEXARR M DIEXARR=X S DIEZCOND=1")
 .. D L(" . "_DIEZCOD)
 .. D L(" . S DIEZCOND=$G(X) K X M X=DIEXARR Q:'DIEZCOND")
 . ;Store kill logic
 . D L(" . "_DIEZKLOG)
 ;
 ;Store set logic and condition
 S DIEZSLOG=$G(@DIEZTMP@("R",DP,DIEZXR,"S"))
 I DIEZSLOG'?."^" D
 . D L(" K X M X=X2"_DIEZNSS)
 . ;Build set condition code
 . S DIEZCOD=$G(@DIEZTMP@("R",DP,DIEZXR,"SC"))
 . I DIEZCOD'?."^" D
 .. D L(" . N DIEZCOND,DIEXARR M DIEXARR=X S DIEZCOND=1")
 .. D L(" . "_DIEZCOD)
 .. D L(" . S DIEZCOND=$G(X) K X M X=DIEXARR Q:'DIEZCOND")
 . ;Store set logic
 . D L(" . "_DIEZSLOG)
 ;
 ;Build code to check record level keys
 D:$D(^DD("KEY","AU",DIEZXR)) BLDKCHK(DIEZXR)
 D L(" Q")
 ;
 ;Build code to set X array
 S DIEZF=$O(@DIEZTMP@("R",DP,DIEZXR,0))
 D L("X"_DIEZCNT_"(DION) K X")
 ;
 S DIEZO=0
 F  S DIEZO=$O(@DIEZTMP@("R",DP,DIEZXR,DIEZO)) Q:'DIEZO  D BLDDEC(DIEZXR,DIEZO)
 D L(" S X=$G(X("_DIEZF_"))")
 D L(" Q")
 Q
 ;
BLDDEC(DIEZXR,DIEZO) ;Build data extraction code
 N CODE,NODE,TRANS
 ;
 S CODE=$G(@DIEZTMP@("R",DP,DIEZXR,DIEZO)) Q:CODE?."^"
 S TRANS=$G(@DIEZTMP@("R",DP,DIEZXR,DIEZO,"T"))
 I TRANS'?."^" D
 . D L(" "_CODE)
 . D DOTLINE(" I $D(X)#2 "_TRANS)
 . D L(" S:$D(X)#2 X("_DIEZO_")=X")
 E  I $D(@DIEZTMP@("R",DP,DIEZXR,DIEZO,"F"))#2,CODE?1"S X=".E D
 . D L(" S X("_DIEZO_")"_$E(CODE,4,999))
 E  D
 . D L(" "_CODE)
 . D L(" S:$D(X)#2 X("_DIEZO_")=X")
 Q
 ;
BLDKCHK(DIEZUI) ;Build code to check key for xref
 N DIEZKLST,DIEZMAXL,DIEZUIR,I
 ;
 D XRINFO^DIKCU2(DIEZUI,.DIEZUIR,"",.DIEZMAXL)
 ;
 ;Get list of keys with this uniqueness index
 S DIEZKLST="",I=0
 S I=0 F  S I=$O(^DD("KEY","AU",DIEZUI,I)) Q:'I  S DIEZKLST=I_","
 Q:DIEZKLST=""
 S DIEZKLST=$E(DIEZKLST,1,$L(DIEZKLST)-1)
 ;
 D L(" . I $G(DIEXEC)[""K"" D")
 D L(" .. N DIMAXL,DIUIR")
 D L(" .. S DIUIR=$NA("_DIEZUIR_") Q:'$D(@DIUIR)")
 ;
 ;Build code to set DIMAXL(order#)=maxLength
 I $D(DIEZMAXL) D
 . N ORD,X
 . S X="S ",ORD=0
 . F  S ORD=$O(DIEZMAXL(ORD)) Q:'ORD  D
 .. S X=X_"DIMAXL("_ORD_")="_DIEZMAXL(ORD)_","
 . I X?.E1"," D L(" .. "_$E(X,1,$L(X)-1))
 ;
 D L(" .. I '$$UNIQUE^DIE17(.X,.DA,DIUIR,""X"_DIEZCNT_U_DNM_DRN_""""_$S($D(DIEZMAXL):",.DIMAXL",1:"")_") N I F I="_DIEZKLST_" S DIKEY("_DP_",I,DIIENS)=""""")
 Q
 ;
L(X) ;Add CODE to ^UTILITY
 S L=L+1,^UTILITY($J,0,L)=X,T=T+$L(X)+2
 Q
 ;
DOTLINE(X) ;
 I X[" Q"!(X[" Q:") D
 . D L(" D"),L(" ."_X)
 E  D L(X)
 Q
 ;
NEWROU ;Start a new routine
 K ^UTILITY($J,0)
 S ^UTILITY($J,0,1)=DNM_DRN_" ; ;"_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),T=$L(^(1))
 S ^UTILITY($J,0,2)=" ;;",T=T+$L(^(2))
 S L=2,DIEZCNT=0
 Q
 ;
SAVE ;Get the next available routine number
 N DQ
 F DQ=DRN+1:1 Q:'$D(DRN(DQ))
 ;
 ;Save current routine
 D SAVE^DIEZ1 Q:$G(DIEZQ)
 K ^UTILITY($J,0)
 Q
