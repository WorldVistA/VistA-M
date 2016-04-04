DIKCU2 ;SFISC/MKO-ARRAY COMPARE, TEXT MANIPULATION ;2:40 PM  28 Jan 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;===============================
 ; $$GCMP(ArrayName1,ArrayName2)
 ;===============================
 ;Compare the contents of two arrays
 ;In:
 ; DIKCU2A0 = Name of array 1
 ; DIKCU2B0 = Name of array 2
 ;Returns: 1 if equal, 0 if unequal
 ;
GCMP(DIKCU2A0,DIKCU2B0) ;
 N DIKCU2A,DIKCU2B,DIKCU2DA,DIKCU2DB,DIKCU2E
 S DIKCU2A=$G(DIKCU2A0),DIKCU2B=$G(DIKCU2B0)
 Q:DIKCU2A=""!(DIKCU2B="") 0
 ;
 S DIKCU2DA=$D(@DIKCU2A),DIKCU2DB=$D(@DIKCU2B)
 Q:DIKCU2DA'=DIKCU2DB 0
 I DIKCU2DA=0,DIKCU2DB=0 Q 1
 I DIKCU2DA#2,DIKCU2DB#2,@DIKCU2A'=@DIKCU2B Q 0
 ;
 S DIKCU2E=1
 S DIKCU2A0=$$OREF^DILF(DIKCU2A0),DIKCU2B0=$$OREF^DILF(DIKCU2B0)
 F  S DIKCU2A=$Q(@DIKCU2A),DIKCU2B=$Q(@DIKCU2B) D  Q:'DIKCU2E!(DIKCU2A="")!(DIKCU2B="")
 . I DIKCU2A=""!($P(DIKCU2A,DIKCU2A0)]""),DIKCU2B=""!($P(DIKCU2B,DIKCU2B0)]"") Q
 . I DIKCU2A=""!(DIKCU2B="") S DIKCU2E=0 Q
 . I $P(DIKCU2A,DIKCU2A0,2,999)'=$P(DIKCU2B,DIKCU2B0,2,999) S DIKCU2E=0 Q
 . I @DIKCU2A'=@DIKCU2B S DIKCU2E=0 Q
 Q DIKCU2E
 ;
 ;==================================================
 ; XRINFO(Xref#,.UIR,.LDif,.MaxL,.RFile,.IRoot,.SS)
 ;==================================================
 ;Get info about an index
 ;In:
 ;  XR         = ien of entry in Index file
 ;Out:
 ; .UIR        = Closed root of index w/ X(n)
 ; .LDIF       = Level difference between file and root file
 ; .MAXL(ord#) = maximum length of subscript with this order #
 ; .IROOT      = Closed root of index (up to name)
 ; .RFILE      = Root file #
 ; .SS         = # of field-type subscripts
 ; .SS(ss#)    = file#^field#^maxLen
 ;Example: a whole file xref defined 3 levels down; the xref resides
 ;         on the subfile 2 levels down.
 ;  UIR    = ^DIZ(1000,DA(3),10,DA(2),20,"WF",$E(X(1),1,30),X(2))
 ;  RFILE  = 1000.03
 ;  IROOT  = ^DIZ(1000,DA(3),10,DA(2),20,"WF")
 ;
XRINFO(XR,UIR,LDIF,MAXL,RFILE,IROOT,SS) ;
 K UIR,LDIF,MAXL,SS
 Q:$D(^DD("IX",XR,0))[0
 N CRV,FIL,FILE,FLD,ML,NAME,ORD,TYPE,S
 ;
 S FILE=$P(^DD("IX",XR,0),U),NAME=$P(^(0),U,2),TYPE=$P(^(0),U,8),RFILE=$P(^(0),U,9)
 Q:NAME=""!'FILE!'RFILE
 ;
 I FILE'=RFILE D
 . S LDIF=$$FLEVDIFF^DIKCU(FILE,RFILE) Q:LDIF=""
 . S UIR=$$FROOTDA^DIKCU(FILE,LDIF_"O") Q:UIR=""
 E  D
 . S LDIF=0
 . S UIR=$$FROOTDA^DIKCU(FILE,"O") Q:UIR=""
 Q:$G(UIR)=""
 S UIR=UIR_""""_NAME_"""",IROOT=UIR_")"
 ;
 S S=0 F  S S=$O(^DD("IX",XR,11.1,"AC",S)) Q:'S  S CRV=$O(^(S,0)) D:CRV
 . Q:$D(^DD("IX",XR,11.1,CRV,0))[0  S ORD=$P(^(0),U),FIL=$P(^(0),U,3),FLD=$P(^(0),U,4),ML=$P(^(0),U,5)
 . Q:'ORD
 . I ML S UIR=UIR_",$E(X("_ORD_"),1,"_ML_")",MAXL(ORD)=ML
 . E  S UIR=UIR_",X("_ORD_")"
 . I FIL,FLD S SS=$G(SS)+1,SS(S)=FIL_U_FLD_$S(ML:U_ML,1:"")
 ;
 S UIR=UIR_")"
 Q
 ;
 ;===============================
 ; WRAP(.Text,Width,Width1,Code)
 ;===============================
 ;Wrap the lines in array T
 ;In:
 ; .T    = array of text; 1st line can be in T or T(0)
 ;           subsequent lines are in T(1),...,T(n)
 ;  WID  = maximum length of each line (default = IOM[or 80]-1)
 ;         if < 0 : IOM-1+WID
 ;  WID1 = maximum length of line 1 (optional)
 ;         if ""  : WID
 ;         if < 0 : IOM-1+WID1
 ;  COD  = 1, if lines should NOT wrap on word boundaries
 ;
WRAP(T,WID,WID1,COD) ;Wrap the lines in the T array
 Q:'$D(T)
 N E,J,P,T0,W
 ;
 S WID=$G(WID)\1
 S:WID<1 WID=$G(IOM,80)-1+WID
 S:WID<1 WID=79
 ;
 S W=$S($G(WID1):WID1\1,$G(WID1)=0:$G(IOM,80)-1,1:WID)
 S:W<1 W=$G(IOM,80)-1+W
 S:W<1 W=79
 ;
 I $D(T(0))[0 S T0=1,T(0)=T
 ;
 ;Wrap at word boundaries
 I '$G(COD) F J=0:1 Q:'$D(T(J))  D
 . S:J=1 W=WID
 . S:J T(J)=$$LD(T(J))
 . ;
 . ;Line must be split
 . I $L(T(J))>W D
 .. D DOWNT
 .. F P=$L(T(J)," "):-1:0 Q:$L($P(T(J)," ",1,P))'>W
 .. I 'P S T(J+1)=$E(T(J),W+1,999),T(J)=$E(T(J),1,W)
 .. E  S T(J+1)=$$LD($P(T(J)," ",P+1,999)),T(J)=$$TR($P(T(J)," ",1,P))
 . ;
 . ;Or line must be joined with next
 . E  I $L(T(J))<W D
 .. Q:'$D(T(J+1))
 .. I T(J)]"",T(J)'?.E1" " S T(J)=T(J)_" "
 .. S T(J+1)=$$LD(T(J+1))
 .. ;
 .. F P=1:1:$L(T(J+1)," ")+1 Q:$L(T(J))+$L($P(T(J+1)," ",1,P))>W
 .. S T(J)=$$TR(T(J)_$P(T(J+1)," ",1,P-1))
 .. S T(J+1)=$$LD($P(T(J+1)," ",P,999))
 .. I T(J+1)="" D UPT S J=J-1
 ;
 ;Or wrap to width
 E  F J=0:1 Q:'$D(T(J))  D
 . S:J=1 W=WID
 . ;
 . ;Line must be split
 . I $L(T(J))>W D
 .. D DOWNT
 .. S T(J+1)=$E(T(J),W+1,999)
 .. S T(J)=$E(T(J),1,W)
 . ;
 . ;Or joined with next
 . E  I $L(T(J))<W D
 .. Q:'$D(T(J+1))
 .. S E=W-$L(T(J))
 .. S T(J)=T(J)_$E(T(J+1),1,E)
 .. S T(J+1)=$E(T(J+1),E+1,999)
 .. I T(J+1)="" D UPT S J=J-1
 ;
 I $G(T0) S T=T(0) K T(0)
 Q
 ;
DOWNT ;Push the T array from element J+1 down
 N K
 F K=$O(T(""),-1):-1:J+1 S T(K+1)=T(K)
 S T(J+1)=""
 Q
 ;
UPT ;Pop the T array from element J+1 down
 N K
 F K=J+1:1:$O(T(""),-1)-1 S T(K)=T(K+1)
 K T($O(T(""),-1))
 Q
 ;
TR(X) ;Strip trailing spaces
 Q:$G(X)="" X
 N I
 F I=$L(X):-1:0 Q:$E(X,I)'=" "
 Q $E(X,1,I)
 ;
LD(X) ;Strip leading spaces
 Q:$G(X)="" X
 N I
 F I=1:1:$L(X)+1 Q:$E(X,I)'=" "
 Q $E(X,I,999)
 ;
ERR(ERR,DIFILE,DIIENS,DIFIELD,DI1,DI2,DI3) ;Build an error message
 N P,I,V
 F I="FILE","IENS","FIELD",1,2,3 S V=$G(@("DI"_I)) S:V]"" P(I)=V
 D BLD^DIALOG(ERR,.P,.P)
 Q
