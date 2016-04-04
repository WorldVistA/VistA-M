DIKCU ;SFISC/MKO-LIBRARY OF GENERIC MODULES ;9:29 AM  22 Oct 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;===============
 ; PUSHDA(.DA,N)
 ;===============
 ;Push down the DA array, N times
 ;
PUSHDA(DA,N) ;
 N I
 S:'$G(N) N=1
 F I=+$O(DA(""),-1):-1:1 S DA(I+N)=$G(DA(I))
 S DA(N)=$G(DA)
 S DA=0 F I=N-1:-1:1 S DA(I)=0
 Q
 ;
 ;==============
 ; POPDA(.DA,N)
 ;==============
 ;Pop the DA array
 ;
POPDA(DA,N) ;
 N I,L
 S:'$G(N) N=1
 S L=+$O(DA(""),-1)
 S DA=$G(DA(N))
 F I=N+1:1:L S DA(I-N)=$G(DA(I))
 F I=L-N+1:1:L K DA(I)
 Q
 ;
 ;=================
 ; $$IENS(File,DA)
 ;=================
 ;Return IENS given file# and DA array
 ;In:
 ; FIL = File or subfile #
 ; DA  = DA array (any unneeded elements in the DA array are ignored)
 ;
IENS(FIL,DA) ;
 N LEV,I,IENS,ERR
 Q:$G(FIL)="" ""
 S LEV=$$FLEV(FIL) Q:LEV="" ""
 ;
 ;Build IENS
 S IENS=$G(DA)_","
 F I=1:1:LEV S IENS=IENS_$G(DA(I))_","
 Q IENS
 ;
 ;=========================
 ; $$FNUM(Root,Flag)
 ;=========================
 ;Given file root, return File # from 2nd piece of header node.
 ;Also check that that file has a DD entry and a non-wp .01 field.
 ;Return null if error.
 ;In:
 ;  ROOT = file root
 ;  F    [ D : generate dialog
 ;
FNUM(ROOT,F) ;
 Q:$G(ROOT)="" ""
 N FIL
 S ROOT=$$CREF(ROOT)
 I $D(@ROOT@(0))[0 D:$G(F)["D" ERR^DIKCU2(404,"","","",ROOT) Q ""
 S FIL=+$P(@ROOT@(0),U,2)
 I '$$VFNUM^DIKCU1(FIL,$G(F)) Q ""
 Q FIL
 ;
 ;===============================
 ; $$FROOTDA(File,Flag,.L,.TRoot
 ;===============================
 ;Return global root of File; may include DA(1), DA(2), ... for subfiles
 ;Examples: ^DIZ(9999) and ^DIZ(9999,DA(1),"MULT1")
 ;In:
 ;  FIL  = file #
 ;  FLAG [ O : return open root
 ;       [ D : generate dialog
 ;       starts with number : indicates offset to use for DA array
 ;Out:
 ; .L     = level of file
 ; .TROOT = top level root
 ;
FROOTDA(FIL,F,L,TROOT) ;
 I $G(FIL)="" S (L,TROOT)="" Q ""
 S F=$G(F)
 ;
 ;If top level, return "GL"
 I $D(^DIC(FIL,0,"GL"))#2 D  Q TROOT
 . S L=0,TROOT=$S(F["O":^("GL"),1:$$CREF(^("GL")))
 ;
 ;Must be a subfile level, get mult nodes, and level
 N ERR,I,MFLD,ND,PAR,ROOT,SUB
 S SUB=FIL
 F L=0:1 S PAR=$G(^DD(SUB,0,"UP")) Q:'PAR  D  Q:$G(ERR)
 . S MFLD=$O(^DD(PAR,"SB",SUB,""))
 . S ND=$P($P($G(^DD(PAR,MFLD,0)),U,4),";")
 . I ND?." " S ERR=1 D:F["D" ERR^DIKCU2(502,PAR,"",MFLD) Q
 . S:ND'=+$P(ND,"E") ND=""""_ND_""""
 . S ND(L+1)=ND
 . S SUB=PAR
 I $G(ERR) S (L,TROOT)="" Q ""
 ;
 ;Build global root for subfile
 S (ROOT,TROOT)=$G(^DIC(SUB,0,"GL"))
 I ROOT="" D:F["D" ERR^DIKCU2(402,SUB) S L="" Q ""
 ;
 F I=L:-1:1 S ROOT=ROOT_"DA("_(I+F)_"),"_ND(I)_","
 S:F'["O" TROOT=$$CREF(TROOT)
 Q $S(F["O":ROOT,1:$$CREF(ROOT))
 ;
CREF(X) ;Return closed root of X
 N F,L
 S L=$E(X,$L(X)),F=$E(X,1,$L(X)-1)
 Q $S(L="(":F,L=",":F_")",1:X)
 ;
 ;================
 ; $$FLEV(File,F)
 ;================
 ;Return the level of File
 ;In:
 ; FIL = file#
 ; F   [ "D" : generate Dialog
 ;
FLEV(FIL,F) ;
 Q:$G(FIL)="" ""
 ;
 N LEV
 F LEV=0:1 Q:$G(^DD(FIL,0,"UP"))=""  S FIL=^("UP")
 I '$D(^DD(FIL)) D:$G(F)["D" ERR^DIKCU2(402,FIL) Q ""
 Q LEV
 ;
 ;=========================
 ; $$FLEVDIFF(File1,File2)
 ;=========================
 ;Find the difference in levels between File1 and File2.
 ;File1 is an ancestor of File2.
 ;In:
 ; FIL1 = File or subfile # of ancestor
 ; FIL2 = File or subfile #
 ;Returns: level difference; null if invalid input
 ;
FLEVDIFF(FIL1,FIL2) ;
 Q:$G(FIL1)=""!($G(FIL2)="") ""
 ;
 N DIFF,FIL
 S FIL=FIL2
 F DIFF=0:1 Q:FIL=FIL1  S FIL=$G(^DD(FIL,0,"UP")) Q:FIL=""
 Q $S(FIL=FIL1:DIFF,1:"")
 ;
 ;===============================================
 ; SUBFILES(File,.Subfile#Array,.NodeArray,Flag)
 ;===============================================
 ;Build list of subfiles
 ;In:
 ;  FIL = file #
 ;  FLG = 1 (if wp subfiles should be returned)
 ;Out:
 ; .SB(subfile#)           = parentFile#
 ; .MF(file#,multField#)   = node
 ; .MF(file#,multField#,0) = subfile#
 ;
SUBFILES(FIL,SB,MF,FLG) ;
 Q:$G(FIL)=""
 N SUB,MUL,ND
 ;
 ;Loop through "SB" nodes
 S SUB="" F  S SUB=$O(^DD(FIL,"SB",SUB)) Q:'SUB  D
 . S MUL=$O(^DD(FIL,"SB",SUB,0)) Q:'MUL
 . Q:$D(^DD(SUB,.01,0))[0  Q:$P(^(0),U,2)["W"&'$G(FLG)
 . ;
 . S ND=$P($P(^DD(FIL,MUL,0),U,4),";") Q:ND=""
 . S SB(SUB)=FIL,MF(FIL,MUL)=ND,MF(FIL,MUL,0)=SUB
 . ;
 . ;Make a recursive call to get all subfiles under file SUB
 . D SUBFILES(SUB,.SB,.MF,$G(FLG))
 Q
 ;
 ;============================
 ; SBINFO(Subfile,.NodeArray)
 ;============================
 ;Get info for Subfile
 ;In:
 ;  SUB = subfile #
 ;Out:
 ; .MF(file#,multField#)   = node
 ; .MF(file#,multField#,0) = subfile#
 ;
SBINFO(SUB,MF) ;
 N ERR,MUL,ND,PAR
 F  S PAR=$G(^DD(SUB,0,"UP")) Q:'PAR  D  Q:$G(ERR)
 . S MUL=$O(^DD(PAR,"SB",SUB,0)) I 'MUL S ERR=1 Q
 . S ND=$P($P(^DD(PAR,MUL,0),U,4),";") I ND="" S ERR=1 Q
 . S MF(PAR,MUL)=ND,MF(PAR,MUL,0)=SUB,SUB=PAR
 Q
 ;
 ;============================
 ; SELFILE(Root,TopFile,File)
 ;============================
 ;Prompt for file/subfile
 ;Out:
 ; .ROOT = open root of top level file
 ; .TOP  = top level file #
 ; .FILE = (sub)file #
 ;
SELFILE(ROOT,TOP,FILE) ;
 N %,C,D,DA,DDA,DI,DIAC,DIC,DICS,DIFILE,X,Y
 S (ROOT,TOP,FILE)=""
 D D^DICRW Q:Y<0
 ;
 ;Check if this is a new file
 I '$D(DIC) D  Q:'$D(DIC)
 . N DG,DIE,DIK,DLAYGO,F,Z
 . D DIE^DIB
 . S:$D(DG) DIC=DG
 ;
 ;Check that file exists
 S DI=+$P($G(@(DIC_"0)")),U,2)
 I 'DI W $C(7),!,$$EZBLD^DIALOG(410,DIC_"0)"),! Q
 ;
 ;Get subfile, root, and top
 S FILE=$$SUB^DIKCU(DI) Q:FILE=""
 S ROOT=DIC,TOP=DI
 Q
 ;
 ;==============
 ; $$SUB(File#)
 ;==============
 ;Prompt for subfiles under file
 ;Returns: file or subfile #
 ;         null : if user ^-out
 ;
SUB(FIL) ;
 N D,DIC,DTOUT,DUOUT,QUIT,X,Y
 ;
 S DIC(0)="QEAI"
 S DIC("A")="Select Subfile: "
 S DIC("S")="N % S %=+$P(^(0),U,2) I %,$P($G(^DD(%,.01,0)),U,2)'[""W"""
 ;
 F  Q:$O(^DD(+$G(FIL),"SB",0))'>0!$D(QUIT)  D
 . S DIC="^DD("_FIL_","
 . D ^DIC
 . I X="" S QUIT=1 Q
 . I Y=-1 S QUIT=1 S FIL="" Q
 . S FIL=+$P(^DD(FIL,+Y,0),U,2)
 . W "  (Subfile #"_FIL_")"
 Q FIL
 ;
 ;#401  File #|FILE| does not exist.
 ;#402  The global root of file #|FILE| is missing or not valid.
 ;#404  The File Header node of the file stored at |1| lacks a file number.
 ;#410  Missing or incomplete global node |1|.
 ;#502  Field# |FIELD| in file# |FILE| has a corrupted definition.
