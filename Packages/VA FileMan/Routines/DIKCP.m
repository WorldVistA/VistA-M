DIKCP ;SFISC/MKO-PRINT INDEX(ES) ;11:33 AM  1 Nov 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**11**
 ;
 ;==============================
 ; PRINT(File,Field,Flag,.Page)
 ;==============================
 ;In:
 ; FIL   = File #
 ; FLD   = Field # (optional) (ignored if FLAG [ M)
 ; FLAG    [ Cn : column tab stop from left margin (def=18)
 ;         [ F  : print field-level indexes
 ;         [ Ln : left margin (def=0)
 ;         [ M  : include subfiles (multiples) under File
 ;         [ N  : don't print any mumps code
 ;         [ O  : print traditional 1-node cross references
 ;         [ R  : print record-level indexes
 ;         [ S  : single space (no blank lines)
 ;         [ Tn : type (style) of 1st lines of each xref
 ; PAGE("H") = header text or M code that begins with a write statement
 ;             If text   : eop read issued; and @IOF, PAGE("H")
 ;                         is written automatically
 ;             If M code : code must issue eop read, write @IOF, and
 ;                         write the header.
 ;             undefined : no paging
 ;
 ; PAGE("B") = bottom margin
 ;Out:
 ; PAGE(U)   = returns as 1, if timeout or ^ at eop
 ;Notes:
 ; Type 0 : Used for the listings at the beg and end of report.
 ;          First line looks like:
 ;           AC (#30)    REGULAR    FIELD    IR    SORTING ONLY
 ;
 ; Type 1 : Used for the listing with each field.
 ;          First line looks like:
 ;           FIELD INDEX:     AC (#30)    REGULAR    IR    SORTING ONLY
 ;
PRINT(FIL,FLD,FLAG,PAGE) ;Print all indexes on one file(/field)
 Q:'$G(FIL)
 N HSTR,LM,SB,TOP,TS,TYP,WID
 ;
 ;Initialize variables
 D INIT
 ;
 ;M flag, print file and subfile indexes
 I FLAG["M" D
 . D SUBFILES^DIKCU(FIL,.SB)
 . S TOP=1 F  D  Q:PAGE(U)  S FIL=$O(SB(FIL)) Q:'FIL
 .. I FLAG["R"!(FLAG["F"),$D(^DD("IX","AC",FIL)) D
 ... D PRFILE(FIL,"",FLAG,.PAGE)
 .. E  I FLAG["O",$D(^DD(FIL,"IX")) D
 ... D PRFILE(FIL,"",FLAG,.PAGE)
 .. I $G(TOP) S FIL=0 K TOP
 ;
 E  D PRFILE(FIL,$G(FLD),FLAG,.PAGE)
 Q
 ;
PRFILE(FIL,FLD,FLAG,PAGE) ;Print indexes for 1 file
 Q:'$G(FIL)
 N FHDR,HDR,NAM,NO,XR,XRL
 I $G(FLAG)'["i" N LM,TS,TYP,WID D INIT
 ;
 ;Print traditional xrefs
 I FLAG["O" D PRFILE^DIKCP3(FIL,$G(FLD),FLAG,.PAGE,.FHDR) Q:PAGE(U)
 I FLAG'["F",FLAG'["R" Q
 ;
 ;Print indexes
 I $G(FLD)="" D
 . ;Build list of xrefs sorted by name
 . S XR=0 F  S XR=$O(^DD("IX","AC",FIL,XR)) Q:'XR  D
 .. Q:$G(^DD("IX",XR,0))?."^"  Q:FLAG'[$P(^(0),U,6)  S NAM=$P(^(0),U,2)
 .. S:NAM="" NAM=" <no name"_$G(NO)_">",NO=$G(NO)+1
 .. S XRL(NAM,XR)=""
 . ;
 . ;Loop through sorted list
 . S NAM="" F  S NAM=$O(XRL(NAM)) Q:NAM=""  D  Q:PAGE(U)
 .. S XR=0 F  S XR=$O(XRL(NAM,XR)) Q:'XR  D  Q:PAGE(U)
 ... I '$G(FHDR) D FHDR(FIL,FLAG,.PAGE,.FHDR) Q:PAGE(U)
 ... I '$G(HDR) D HDR(FIL,FLAG,LM,.PAGE,.HDR) Q:PAGE(U)
 ... D PRINDEX(XR,FLAG,.PAGE) Q:PAGE(U)
 ... D WRLN("",0,.PAGE) Q:PAGE(U)
 ... I FLAG'["S" D WRLN("",0,.PAGE)
 ;
 E  S XR=0 F  S XR=$O(^DD("IX","F",FIL,FLD,XR)) Q:'XR  D  Q:PAGE(U)
 . Q:$D(^DD("IX",XR,0))?."^"  Q:FLAG'[$P(^(0),U,6)
 . I '$G(FHDR) D FHDR(FIL,FLAG,.PAGE,.FHDR) Q:PAGE(U)
 . I '$G(HDR) D HDR(FIL,FLAG,LM,.PAGE,.HDR) Q:PAGE(U)
 . D PRINDEX(XR,FLAG,.PAGE) Q:PAGE(U)
 . D WRLN("",0,.PAGE) Q:PAGE(U)
 . I FLAG'["S" D WRLN("",0,.PAGE)
 Q
 ;
PRINDEX(XR,FLAG,PAGE) ;Print one index
 G PRINDEX^DIKCP1
 ;
HDR(FIL,FLAG,LM,PAGE,HDR) ;Print header for indexes
 S HDR=1
 I FLAG'["M",FLAG'["O" Q
 D WRLN($S(FLAG["R"&(FLAG["F"):"New-Style",FLAG["R":"Record",1:"Field")_" Indexes:",LM,.PAGE,2) Q:PAGE(U)
 D WRLN("",0,.PAGE)
 Q
 ;
FHDR(FIL,FLAG,PAGE,FHDR) ;Print header for file
 S FHDR=1
 Q:FLAG'["M"
 D WRLN($P("F^Subf",U,$D(^DD(FIL,0,"UP"))#2+1)_"ile #"_FIL,0,.PAGE,2) Q:PAGE(U)
 D WRLN("",0,.PAGE)
 Q
 ;
 ;=============================
 ; LIST(File,Field,Flag,.Page)
 ;=============================
 ;List Indexes that reside on a given file.
 ;In:
 ; Same as PRINT above (except that N and O flag don't apply)
 ;Out:
 ; PAGE(U)   = Returns as 1, if timeout or ^ at eop
 ;Notes:
 ; Type 0 : Used for the listing of Indexes on a file or subfile
 ;           INDEXED BY:    ANOTHER FIELD (AC), SET & FREE (C),
 ;                          ANOTHER FIELD & EXTRACT (D)
 ;
 ; Type 1 : Used for the listing of Record Indexes with each field.
 ;           RECORD INDEXES:  WF (#22) [WHOLE FILE on #9999)],
 ;                            WF (#24), AC (#52)
 ;
LIST(FIL,FLD,FLAG,PAGE) ;
 Q:'$G(FIL)
 N LAB,LM,SB,SUB,TS,TYP,WID
 ;
 ;Initialize variables
 D INIT
 ;
 ;Set label
 I TYP=1 D
 . I FLAG["R",FLAG["F" S LAB="INDEXES: "
 . E  I FLAG["R" S LAB="RECORD INDEXES: "
 . E  S LAB="FIELD INDEXES: "
 E  S LAB="INDEXED BY: "
 S LAB=LAB_$J("",TS-$L(LAB))
 ;
 ;M flag, get and list for file and subfiles
 I FLAG["M" D
 . D SUBFILES^DIKCU(FIL,.SB)
 . S SUB=""
 . F  D  Q:PAGE(U)  S:SUB="" SUB="SUB",FIL=0 S FIL=$O(SB(FIL)) Q:'FIL
 .. Q:'$D(^DD("IX","B",FIL))
 .. I SUB]""!(FLAG'["S") D WRLN("",0,.PAGE) Q:PAGE(U)
 .. D WRLN(SUB_"FILE #"_FIL,LM,.PAGE,1) Q:PAGE(U)
 .. D LFILE(FIL,"",FLAG,LAB,.PAGE) Q:PAGE(U)
 ;
 ;Otherwise, just list for one file
 E  D
 . I FLAG'["S" D WRLN("",0,.PAGE) Q:PAGE(U)
 . D LFILE(FIL,$G(FLD),FLAG,LAB,.PAGE)
 Q
 ;
LFILE(FIL,FLD,FLAG,LAB,PAGE) ;Format list of indexes and print
 G LFILE^DIKCP2
 ;
INIT ;Initialize module-wide variables
 Q:$G(FLAG)["i"
 S FLAG=$G(FLAG)_"i"
 I FLAG'["F",FLAG'["R",FLAG'["O" S FLAG="OFR"_FLAG
 S LM=+$P(FLAG,"L",2)\1
 S TS=+$P(FLAG,"C",2) S:'TS TS=18
 S TYP=+$P(FLAG,"T",2)\1
 S WID=$G(IOM,80)-1-LM-TS S:WID<1 WID=1
 S PAGE(U)=""
 Q
 ;
 ;===================================
 ; WRLN(Text,Tab,.Page,KeepWithNext)
 ;===================================
 ;Write a single line of text, precede with a !, do paging if necessary
 ;In:
 ; TXT       = Text to write; $C(0) replaced with spaces.
 ; TAB       = ?Tab before writing text (def=0)
 ; PAGE("H") = Header text or M code that begins with a write statement
 ;             If not passed in, no paging.
 ; PAGE("B") = Bottom margin
 ; KWN       = Additional padding on bottom margin ("keep with next")
 ;Out:
 ; PAGE(U)   = Returns as 1, if timeout or ^ at eop
 ;
WRLN(TXT,TAB,PAGE,KWN) ;Write a line of text
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
