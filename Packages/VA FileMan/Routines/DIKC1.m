DIKC1 ;SFISC/MKO-LOAD XREF INFO ;19DEC2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**11,167**
 ;
 ;============================================
 ; LOADALL(File,Log,Activ,ValRt,Tmp,Flag,.MF)
 ;============================================
 ;Load all xrefs for a file. Uses the "AC" index on Root File.
 ;In:
 ; RFIL  = Root File #
 ; LOG   [ K : load kill logic
 ;       [ S : load set logic
 ; ACT   = Codes: IR
 ;          If ACT '= null, a xref is picked up only if ACT
 ;          and the Activity field (#.41) have codes in common.
 ; VALRT = Array Ref where old/new values are located
 ; TMP   = Root to store xref info
 ; FLAG  [ s : don't include subfiles under file
 ;       [ i : don't load index-type xrefs (only load whole file xrefs)
 ;       [ f : don't load field-type xrefs
 ;       [ r : don't load record-type xrefs
 ;       [ x : don't load "NOREINDEX" xrefs
 ;
 ;Out:
 ; MF(file#,mField#)   = multiple node
 ; MF(file#,mField#,0) = subfile#
 ;   Set only for those files/multiples that have xrefs
 ;   and only if FLAG '[ "s"
 ;
LOADALL(RFIL,LOG,ACT,VALRT,TMP,FLAG,MF) ;
 N XR
 ;
 ;Loop through "AC" index
 S XR=0 F  S XR=$O(^DD("IX","AC",RFIL,XR)) Q:'XR  D
 . ;Skip if no .01, wrong Activity, wrong Type, or wrong Execution
 . I $P($G(^DD("IX",XR,0)),U)="" K ^DD("IX","AC",RFIL,XR) Q
 . I $G(ACT)]"",$TR(ACT,$P(^DD("IX",XR,0),U,7),$TR($J("",$L($P(^(0),U,7)))," ","*"))'["*" Q
 . I $G(FLAG)["i",$P(^DD("IX",XR,0),U,8)="I" Q
 . I $G(FLAG)["f",$P(^DD("IX",XR,0),U,6)="F" Q
 . I $G(FLAG)["r",$P(^DD("IX",XR,0),U,6)="R" Q
NOREIN .I $G(FLAG)["x",$G(^DD("IX",XR,"NOREINDEX")) Q  ;PATCH 167
 . ;
 . ;Load xref
 . D CRV^DIKC2(XR,$G(VALRT),TMP)
 . D:$G(LOG)]"" LOG^DIKC2(XR,LOG,TMP)
 . D:$G(LOG)["K" KW^DIKC2(XR,TMP)
 Q:$G(FLAG)["s"
 ;
 ;Build info for all subfiles under FILE into arrays SB and MF
 N CHK,FIL,MFLD,PAR,SB
 D SUBFILES^DIKCU(RFIL,.SB,.MF)
 ;
 ;Load xref for each subfile
 S:$G(FLAG)'["s" FLAG=$G(FLAG)_"s"
 S SB=0 F  S SB=$O(SB(SB)) Q:'SB  D
 . D LOADALL(SB,$G(LOG),$G(ACT),$G(VALRT),TMP,FLAG)
 . Q:'$D(@TMP@(SB))
 . ;
 . ;Set CHK(f)="" flag for subfile and its antecedents
 . S PAR=SB F  Q:$D(CHK(PAR))  S CHK(PAR)=1,PAR=$G(SB(PAR)) Q:PAR=""
 ;
 ;Use the CHK array to get rid of unneeded elements in MF
 S FIL=0 F  S FIL=$O(MF(FIL)) Q:'FIL  D
 . S MFLD=0 F  S MFLD=$O(MF(FIL,MFLD)) Q:'MFLD  D
 .. K:'$D(CHK(MF(FIL,MFLD,0))) MF(FIL,MFLD)
 Q
 ;
 ;========================================
 ; LOADXREF(File,Fld,Log,.XRef,ValRt,Tmp)
 ;========================================
 ;Load specified xrefs. Uses the "AC" index on Root file if Index
 ;Names are passed in. Also, uses the "F" index, if Field is passed in.
 ;In:
 ;  RFIL  = if FLD is not passed in : Root File or subfile#
 ;                                    (required if XREF contains names)
 ;          if FLD is passed in : The file of the field
 ;                                (defaults to Root file of XREF)
 ;  FLD   = Field # (optional) (if passed in, a specified index is
 ;          loaded only if FLD is one of the cross-reference values.
 ;  LOG   [ K : load kill logic (incl. whole kill)
 ;        [ S : load set logic
 ; .XREF  = ^-delimited list of xref names or numbers;
 ;          (overflow in XREF(n) where n=1,2,...)
 ;  VALRT = Array Ref where old/new values are located
 ;  TMP   = Root to store info
 ;
LOADXREF(RFIL,FLD,LOG,XREF,VALRT,TMP) ;
 N I,N,PC,RF,XR,XRLIST
 ;
 ;Loop through XREF array
 S N=0,XRLIST=$G(XREF) F  Q:XRLIST=""  D
 . ;
 . ;Loop through each xref in XRLIST
 . F PC=1:1:$L(XRLIST,U) K XR S XR=$P(XRLIST,U,PC) D:XR]""
 .. ;
 .. ;Convert xref name to number, if necessary
 .. I XR'=+$P(XR,"E") D  Q:$D(XR)<2
 ... S I=0 F  S I=$O(^DD("IX","AC",RFIL,I)) Q:'I  D
 .... S:$P($G(^DD("IX",I,0)),U,2)=XR XR(I)=""
 .. E  Q:$P($G(^DD("IX",XR,0)),U)=""  S XR(XR)=""
 .. ;
 .. ;Load code from Cross-Reference Values multiple
 .. S XR=0 F  S XR=$O(XR(XR)) Q:'XR  D
 ... S RF=$P(^DD("IX",XR,0),U,9)
 ... I $G(FLD) Q:'$D(^DD("IX","F",$S($G(RFIL):RFIL,1:RF),FLD,XR))
 ... E  I $G(RFIL) Q:RFIL'=RF
 ... D CRV^DIKC2(XR,$G(VALRT),TMP)
 ... D:$G(LOG)]"" LOG^DIKC2(XR,LOG,TMP)
 ... D:$G(LOG)["K" KW^DIKC2(XR,TMP)
 . ;
 . ;Process next overflow
 . S N=$O(XREF(N)),XRLIST=$S(N:$G(XREF(N)),1:"")
 Q
 ;
 ;================================================================
 ; LOADFLD(File,Field,Log,Activ,ValRt,TmpF,TmpR,FList,RList,Flag)
 ;================================================================
 ;Get all xrefs for a field. Uses the "F" index on file/field.
 ;In:
 ; FIL   = File #
 ; FLD   = Field #
 ; LOG   [ K : load kill logic
 ;       [ S : load set logic
 ;       [ W : load entire kill logic (if LOG also [ "K")
 ; ACT   = codes: IR
 ;          If ACT is not null, a xref is picked up only if ACT
 ;          and the Activity field (#.41) have codes in common.
 ; VALRT = Array Ref where old/new values are located
 ; TMPF  = Root to store field-level xref info
 ; TMPR  = Root to store record-level xref info
 ; FLAG  [ i : don't load index-type xrefs (only load whole file xrefs)
 ;       [ f : don't load field-type xrefs
 ;       [ r : don't load record-type xrefs
 ;Out:
 ; .FLIST = ^-delimited list of field xrefs (overflow in FLIST(n))
 ; .RLIST = ^-delimited list of record xrefs (overflow in RLIST(n))
 ;
LOADFLD(FIL,FLD,LOG,ACT,VALRT,TMPF,TMPR,FLIST,RLIST,FLAG) ;
 N EXECFLD,TMP,XR
 K FLIST,RLIST S (FLIST,RLIST)=0,(FLIST(0),RLIST(0))=""
 S:$G(TMPR)="" TMPR=TMPF
 ;
 ;Loop through "F" index and pick up xrefs
 S XR=0 F  S XR=$O(^DD("IX","F",FIL,FLD,XR)) Q:'XR  D
 . I $P($G(^DD("IX",XR,0)),U)="" K ^DD("IX","F",FIL,FLD,XR) Q
 . S EXECFLD=$P(^DD("IX",XR,0),U,6)
 . I $G(ACT)]"",$TR(ACT,$P(^DD("IX",XR,0),U,7),$TR($J("",$L($P(^(0),U,7)))," ","*"))'["*" Q
 . I $G(FLAG)["i",$P(^DD("IX",XR,0),U,8)="I" Q
 . I $G(FLAG)["f",$P(^DD("IX",XR,0),U,6)="F" Q
 . I $G(FLAG)["r",$P(^DD("IX",XR,0),U,6)="R" Q
 . I $G(FLAG)["x",$G(^DD("IX",XR,"NOREINDEX")) Q
 . ;
 . ;Set TMP, RLIST, and FLIST
 . K TMP
 . I EXECFLD="R" D
 .. S TMP=$G(TMPR)
 .. I $L(RLIST(RLIST))+$L(XR)+1>255 S RLIST=RLIST+1,RLIST(RLIST)=""
 .. S RLIST(RLIST)=RLIST(RLIST)_$E(U,RLIST(RLIST)]"")_XR
 . E  D
 .. S TMP=$G(TMPF)
 .. I $L(FLIST(FLIST))+$L(XR)+1>255 S FLIST=FLIST+1,FLIST(FLIST)=""
 .. S FLIST(FLIST)=FLIST(FLIST)_$E(U,FLIST(FLIST)]"")_XR
 . ;
 . ;Load xref
 . Q:$G(TMP)=""  Q:$D(@TMP@(FIL,XR))
 . D CRV^DIKC2(XR,$G(VALRT),TMP)
 . D:$G(LOG)]"" LOG^DIKC2(XR,LOG,TMP)
 . I $G(LOG)["K",$G(LOG)["W" D KW^DIKC2(XR,TMP)
 ;
 I FLIST(0)]"" S FLIST=FLIST(0) K FLIST(0)
 E  K FLIST S FLIST=""
 I RLIST(0)]"" S RLIST=RLIST(0) K RLIST(0)
 E  K RLIST S RLIST=""
 Q
 ;
GETTMP(DIKC) ;Find next available root in ^TMP(DIKC)
 ;Time stamp ^TMP(DIKC,J)
 ;Out:
 ; Name of available ^TMP root; e.g. ^TMP("DIKC",$J+.01)
 ;
 N DAY,FREE,J
 S FREE=0 F J=$J:.01 D  Q:FREE
 . S DAY=$G(^TMP(DIKC,J))
 . I DAY<($H-1) K ^TMP(DIKC,J) S ^TMP(DIKC,J)=$H,FREE=1
 Q $NA(^TMP(DIKC,J))
