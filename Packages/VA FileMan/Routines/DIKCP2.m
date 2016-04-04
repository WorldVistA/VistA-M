DIKCP2 ;SFISC/MKO-PRINT INDEX(ES) ;9:39 AM  5 Aug 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
LFILE ;Format list of indexes and print; Come here from LFILE^DIKCP
 N LN,NAM,NO,TXT,XR,XRL
 S TXT=0,TXT(0)=""
 ;
 I $G(FLD)="" S NAM="" F  S NAM=$O(^DD("IX","BB",FIL,NAM)) Q:NAM=""  D
 . S XR=0
 . F  S XR=$O(^DD("IX","BB",FIL,NAM,XR)) Q:'XR  D ADDXR(XR,.TXT,FLAG)
 E  D
 . S XR=0
 . F  S XR=$O(^DD("IX","F",FIL,FLD,XR)) Q:'XR  D
 .. Q:$G(^DD("IX",XR,0))?."^"  S NAM=$P(^(0),U,2)
 .. S:NAM="" NAM=" <no name"_$G(NO)_">",NO=$G(NO)+1
 .. S XRL(NAM,XR)=""
 . S NAM="" F  S NAM=$O(XRL(NAM)) Q:NAM=""  D
 .. S XR=0 F  S XR=$O(XRL(NAM,XR)) Q:'XR  D ADDXR(XR,.TXT,FLAG)
 Q:TXT(0)=""
 ;
 D WRAP^DIKCU2(.TXT,WID)
 D WRLN($G(LAB)_TXT(0),LM,.PAGE) Q:PAGE(U)
 F LN=1:1 Q:'$D(TXT(LN))  D WRLN(TXT(LN),LM+$L(LAB),.PAGE) Q:PAGE(U)
 Q
 ;
ADDXR(XR,TXT,FLAG) ;Add field list and xref name to TXT array
 N CRV,FIL,FLD,FLDNAM,FND,NAM,RTYP,STR,XR0
 S XR0=$G(^DD("IX",XR,0))
 Q:XR0?."^"  Q:FLAG'[$P(XR0,U,6)
 ;
 S:$G(TXT(TXT))]"" TXT(TXT)=TXT(TXT)_", "
 S NAM=$P(XR0,U,2)
 ;
 I TYP=1 D
 . S STR=NAM_$C(0)_"(#"_XR_")"
 . S RTYP=$P(XR0,U,8)
 . I "I"'[RTYP D
 .. S STR=STR_" ("_$TR($$EXTERNAL^DILFD(.11,.5,"",RTYP)," ",$C(0))
 .. S STR=STR_" #"_$P(XR0,U)_")"
 ;
 E  D
 . S CRV=0 F  S CRV=$O(^DD("IX",XR,11.1,CRV)) Q:'CRV  D
 .. Q:$P($G(^DD("IX",XR,11.1,CRV,0)),U,2)'="F"
 .. S FIL=$P(^DD("IX",XR,11.1,CRV,0),U,3),FLD=$P(^(0),U,4)
 .. Q:'FIL  Q:'FLD
 .. S FLDNAM=$P($G(^DD(FIL,FLD,0)),U)  Q:FLDNAM=""
 .. D:$G(FND) ADDSTR("& ",.TXT) D ADDSTR(FLDNAM_" ",.TXT)
 .. S FND=1
 . S STR="("_NAM_")"
 . ;
 D ADDSTR(STR,.TXT)
 Q
 ;
ADDSTR(X,TXT) ;Add string X to the TXT array
 I $L(TXT(TXT))+$L(X)>250 S TXT=TXT+1,TXT(TXT)=""
 S TXT(TXT)=TXT(TXT)_X
 Q
 ;
WRLN(TXT,TAB,PAGE,KWN) ;Write a line of text
 ;See ^DIKCP for documentation
 N X
 S PAGE(U)=""
 ;
 ;Do paging, if necessary
 I $D(PAGE("H"))#2,$G(IOSL,24)-2-$G(PAGE("B"))-$G(KWN)'>$Y D  Q:PAGE(U)
 . I PAGE("H")?1"W ".E X PAGE("H") Q
 . I $E($G(IOST,"C"))="C" D  Q:PAGE(U)
 .. W $C(7) R X:$G(DTIME,300) I X=U!'$T S PAGE(U)=1
 . W @$G(IOF,"#"),PAGE("H")
 ;
 ;Write text
 W !?$G(TAB),$TR($G(TXT),$C(0)," ")
 Q
