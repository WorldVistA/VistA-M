DIKCU1 ;SFISC/MKO-FILE/RECORD INFO ;11:21 AM  20 Aug 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**12**
 ;
 ;===================
 ; $$VDA([.]DA,Flag)
 ;===================
 ;Make sure elements DA array are positive canonic numbers.
 ;In:
 ; [.]DA = DA array
 ; F   [ R : DA can't be 0 or null
 ;     [ D : generate Dialog
 ;Returns: 1 if valid; 0 if invalid
 ;
VDA(DA,F) ;
 N I,ERR
 Q:$D(DA)[0 0
 I $G(F)["R" D:0[DA
 . S ERR=1 D:$G(F)["D" ERR^DIKCU2(202,"","","","RECORD")
 I DA]"",DA<0!(DA'=+$P(DA,"E")) D
 . S ERR=1 D:$G(F)["D" ERR^DIKCU2(202,"","","","RECORD")
 E  F I=1:1 Q:'$D(DA(I))  I DA(I)'>0!(DA(I)'=+$P(DA(I),"E")) D  Q
 . S ERR=1 D:$G(F)["D" ERR^DIKCU2(202,"","","","RECORD")
 Q '$G(ERR)
 ;
 ;====================================
 ; $$VFLAG(InputFlags,GoodFlags,Flag)
 ;====================================
 ;Makes sure Flags contain only Good Flags.
 ;In:
 ; FLAG   = flags
 ; GDFLAG = good flags
 ; F      [ D : generate Dialog
 ;Returns: 1 if valid; 0 if invalid
 ;
VFLAG(FLAG,GDFLAG,F) ;
 S FLAG=$G(FLAG)
 I $TR($G(FLAG),$G(GDFLAG),"")'?.NP D  Q 0
 . D:$G(F)["D" ERR^DIKCU2(301,"","","",FLAG)
 Q 1
 ;
 ;=====================
 ; $$VFNUM(File#,Flag)
 ;=====================
 ;Check that File# exists and has a non-wp .01 field
 ;In:
 ; FIL = File or subfile #
 ; F   [ D : generate Dialog
 ;Returns: 1 if valid; 0 if invalid
 ;
VFNUM(FIL,F) ;
 Q:$G(FIL)="" 0
 I '$D(^DD(FIL)) D:$G(F)["D" ERR^DIKCU2(401,FIL) Q 0
 I $P($G(^DD(FIL,.01,0)),U,2)="" D:$G(F)["D" ERR^DIKCU2(406,FIL) Q 0
 I $P(^DD(FIL,.01,0),U,2)["W" D:$G(F)["D" ERR^DIKCU2(407,FIL) Q 0
 Q 1
 ;
 ;===========================
 ; $$VFLD(File#,Field#,Flag)
 ;===========================
 ;Check that the Fil/Fld exists in the ^DD
 ;In:
 ; FIL = File or subfile #
 ; FLD = Field #
 ; F   [ D : generate Dialog
 ;Returns: 1 if valid; 0 if invalid
 ;
VFLD(FIL,FLD,F) ;
 Q:$G(FIL)="" 0  Q:$G(FLD)="" 0
 I '$D(^DD(FIL,FLD)) D:$G(F)["D" ERR^DIKCU2(501,FIL,"",FLD,FLD) Q 0
 Q 1
 ;
 ;================================================
 ; FRNAME(File#,[.]Rec,FileText,RecordTxt,.Level)
 ;================================================
 ;Return string that identifies (sub)file and (sub)record.
 ;In:
 ;  FIL  = File or subfile #
 ; .REC  = DA array
 ;Out:
 ; .FTXT = Text that identifies file
 ; .RTXT = Text that identifies record
 ; .LEV  = Level
 ;
FRNAME(FIL,REC,FTXT,RTXT,LEV) ;
 K FTXT,RTXT,LEV
 Q:'$G(FIL)  Q:'$D(REC)
 N FINFO
 D FINFO(FIL,.FINFO) Q:'$D(FINFO)
 D FILENAME("",.FTXT,.FINFO)
 D RECNAME("",REC,.RTXT,.FINFO)
 S LEV=FINFO
 Q
 ;
 ;=================================
 ; FILENAME(File#,.NameArr,.FINFO)
 ;=================================
 ;Get text that identifies the (sub)file
 ;In:
 ;  FIL   = File or subfile #
 ;In/Out:
 ; .FINFO = File info array (optional) (see FINFO below)
 ;Out:
 ;  N     = Text (undefined if error)
 ;  N(n)  = Overflow text
 ;
FILENAME(FIL,N,FINFO) ;
 K N
 I '$D(FINFO) Q:'$G(FIL)  D FINFO(FIL,.FINFO) Q:'$D(FINFO)
 N I,L,T
 ;
 S L=FINFO,N=0,N(0)=""
 F I=L:-1:0 D
 . I I S T=$P(FINFO(I),U,3)_" (#"_$P(FINFO(I),U)_"), subfield #"_$P(FINFO(I),U,2)_" of "
 . E  S T=$S(L:"the ",1:"")_$P(FINFO(I),U,3)_" File (#"_$P(FINFO(I),U)_")"
 . I $L(N(N))+$L(T)>240 S N=N+1,N(N)=""
 . S N(N)=N(N)_T
 S N=N(0) K N(0)
 Q
 ;
 ;========================================
 ; RECNAME(File#,.Record,.NameArr,.FINFO)
 ;========================================
 ;Get text that identifies the (sub)recird
 ;In:
 ;    FIL = File or subfile #
 ; [.]REC = DA array or IENS
 ;In/Out:
 ; .FINFO = File info array (optional) (see FINFO below)
 ;Out:
 ;  NA    = Text (undefined if error)
 ;  NA(n) = Overflow text
 ;
RECNAME(FIL,REC,NA,FINFO) ;Return string that identifies the (sub)record
 K NA
 Q:'$G(REC)
 I '$D(FINFO) Q:'$G(FIL)  D FINFO(FIL,.FINFO) Q:'$D(FINFO)
 ;
 N DA,DIERR,ERR,J,LV,LVI,MSG,NDA,ROOT,TX,V01
 ;
 ;Set DA array
 I REC'["," M DA=REC
 E  D DA^DILF(REC,.DA)
 ;
 S LV=FINFO,NA=0,NA(0)=""
 F LVI=LV:-1:0 D  Q:$G(ERR)
 . I LVI,$G(DA(LVI))'>0 S ERR=1 Q
 . I 'LVI,$G(DA)'>0 S ERR=1 Q
 . ;
 . I '$D(DDS) D  Q:$G(ERR)
 .. S ROOT=$P(FINFO(LVI),U,4,999)
 .. S V01=$P($G(@ROOT@(0)),U) I V01="" S ERR=1 Q
 .. S TX=$$EXTERNAL^DILFD($P(FINFO(LVI),U),.01,"",V01,"MSG")
 .. I $G(DIERR) S TX=V01 K MSG,DIERR
 . ;
 . E  D
 .. F J=LVI:-1:1 S NDA(J)=DA(J+LV-LVI)
 .. S NDA=$S(LVI=LV:DA,1:DA(LV-LVI))
 .. S TX=$$GET^DDSVAL($P(FINFO(LVI),U),.NDA,.01,"","E") K NDA
 . ;
 . I LV-LVI S TX="'"_TX_"' (#"_DA(LV-LVI)_")"
 . E  S TX="'"_TX_"' (#"_DA_")"
 . I LVI S TX=TX_" of "
 . I $L(NA(NA))+$L(TX)>240 S NA=NA+1,NA(NA)=""
 . S NA(NA)=NA(NA)_TX
 ;
 I $G(ERR) K NA Q
 S NA=NA(0) K NA(0)
 Q
 ;
 ;========================
 ; FINFO(File#,.FileInfo)
 ;========================
 ;Get (sub)file info
 ;In:
 ; FIL = File or subfile #
 ;Out:
 ; FINFO    = n (level)
 ; FINFO(0) = file#^^fileName^fileRootw/DA
 ; FINFO(n) = subfile#^mfield#^mfieldName^^subfileRootw/DA
 ;Example:
 ; FINFO    = 3
 ; FINFO(0) = 1000^^My File^^DIZ(1000,DA(3))
 ; FINFO(1) = 1000.01^100^Mult1^^DIZ(1000,DA(3),10,DA(2))
 ; FINFO(2) = 1000.02^200^Mult2^^DIZ(1000,DA(3),10,DA(2),20,DA(1))
 ; FINFO(3) = 1000.03^300^Mult3^^DIZ(1000,DA(3),10,DA(2),20,DA(1),30,DA)
 ;
FINFO(FIL,FINFO) ;
 Q:'$G(FIL)
 K FINFO
 ;
 ;If top level, set FINFO and quit
 I $D(^DIC(FIL,0,"GL"))#2 D  Q
 . S FINFO=0,FINFO(0)=FIL_U_U_$P(^DIC(FIL,0),U)_U_^DIC(FIL,0,"GL")_"DA)"
 ;
 ;Must be a subfile level, get mult nodes, and level
 N A,ERR,I,L,MFLD,ND,PAR,ROOT,SUB
 S SUB=FIL
 F L=0:1 S PAR=$G(^DD(SUB,0,"UP")) Q:'PAR  D  Q:$G(ERR)
 . S MFLD=$O(^DD(PAR,"SB",SUB,"")) I 'MFLD S ERR=1 Q
 . I $D(^DD(PAR,MFLD,0))[0 S ERR=1 Q
 . S FINFO(L)=SUB_U_MFLD_U_$P(^DD(PAR,MFLD,0),U)
 . ;
 . S ND=$P($P(^DD(PAR,MFLD,0),U,4),";")
 . S:ND'=+$P(ND,"E") ND=""""_ND_""""
 . S ND(L+1)=ND
 . S SUB=PAR
 I $G(ERR) K FINFO,L Q
 S FIL=SUB
 I $D(^DIC(FIL,0))[0 K FINFO,L Q
 S FINFO(L)=FIL_U_U_$P(^DIC(FIL,0),U)
 ;
 ;Build global roots
 S ROOT=$G(^DIC(FIL,0,"GL")) I ROOT="" K FINFO,L Q
 F I=L:-1:1 D
 . S ROOT=ROOT_"DA("_I_")"
 . S FINFO(I)=FINFO(I)_U_ROOT_")"
 . S ROOT=ROOT_","_ND(I)_","
 S FINFO(0)=FINFO(0)_U_ROOT_"DA)"
 S FINFO=L
 ;
 ;Invert the FINFO array
 K A M A=FINFO K FINFO S FINFO=A F A=0:1:FINFO S FINFO(A)=A(FINFO-A)
 Q
 ;
 ;#202  The input parameter that identifies the |1| is missing or invalid.
 ;#301  The passed flag(s) '|1|' are unknown or inconsistent.
 ;#401  File #|FILE| does not exist.
 ;#406  File #|FILE| has no .01 field definition.
 ;#407  A word-processing field is not a file.
 ;#501  File #|FILE| does not contain a field |1|.
