DIQGU ;SFISC/DCL-DATA RETRIEVAL INTERNAL FUNCTIONS ;8FEB2011
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**163,1041**
 ;
DT(H) Q $$HTFM^DILIBF(H,1)
 ;
ROOT(DIC,DA,CP,ERR) ;
ENROOT S ERR=$G(ERR)=1
 N DIQGUFN,DIQGUIEN
 S DIQGUFN=$G(DIC),DIQGUIEN=$G(DA)
 I DIC="" D:ERR BLD^DIALOG(200) Q ""
 N RQ
 S RQ=$G(CP)'["Q"
 S CP=$G(CP)'[1
 G:$L($G(DA),",,")>1 ERR
 D:$G(DA)["," DAIEN(DA,.DA)
 I $G(^DIC(DIC,0,"GL"))]"" N DIQGUX S DIQGUX=^("GL") D:ERR  Q:CP DIQGUX Q $$CREF(DIQGUX)
 .Q:$G(DIQGUIEN)'[","
 .N X S X=$$IENCHK^DIT3(DIQGUFN,DIQGUIEN)
 .Q:X
 .S (CP,DIQGUX)=""
 .Q
 N A,A2
 I $D(DA)>9,$G(^DIC(+$$UP(DIC,.A),0,"GL"))]"" S DIC=^("GL"),A=$P($O(A("")),"-",2) I A>0,$D(DA(A))=1,'$O(DA(A)) D  Q:CP DIC Q $$CREF(DIC)
 .S A="" F  S A=$O(A(A)) Q:A'<0  D
 ..I RQ S A2=$P(A(A),"^",2),DIC=DIC_DA($P(A,"-",2))_","_$$Q(A2)_"," Q
 ..S A2=$P(A(A),"^",2),DIC=DIC_DA($P(A,"-",2))_","""_A2_"""," Q
ERR Q:'ERR ""
 S DIQGUIEN=$$IENS^DILF(.DA)
 S A=$$IENCHK^DIT3(DIQGUFN,DIQGUIEN) Q:'A ""
 D BLD^DIALOG(200) Q ""
 ;
N9(FN,DA) Q:$G(DA)="" 0 N N9 S N9=$$ROOT($$UP(FN),"",1) Q:N9="" 0 Q:$D(@N9@($$DA(.DA),-9)) 1 Q 0
 ;
DA(Y) Q:$D(Y)=1 Y Q Y($O(Y(""),-1))
 ;
UP(Y,A) N D,N,X
 S A(0)=Y F D=0:-1 Q:'$D(^DD(+A(D),0,"UP"))  D  Q:D=666
 .S X=^("UP"),N=$G(^DD($P(X,"^"),+$O(^DD($P(X,"^"),"SB",+A(D),"")),0)) I N="" S D=666 Q  ;"UP" NODE MAY BE BOGUS!
 .S A(D-1)=$P(X,"^")_"^"_$P($P(N,"^",4),";")
 I D=666 Q Y
 Q $P(A($O(A(""))),"^")
 ;
CREF(X) ;
ENCREF N L,X1,X2,X3 S X1=$P(X,"("),X2=$P(X,"(",2,99),L=$L(X2),X3=$TR($E(X2,L),",)"),X2=$E(X2,1,(L-1))_X3 Q X1_$S(X2]"":"("_X2_")",1:"")
OREF(X) ;
ENOREF N X1,X2 S X1=$P(X,"(")_"(",X2=$$OR2($P(X,"(",2,999)) Q:X2="" X1 Q X1_X2_","
 ;
OR2(%) Q:%=")"!(%=",") "" Q:$L(%)=1 %  S:"),"[$E(%,$L(%)) %=$E(%,1,$L(%)-1) Q %
 ;
RCP(%DIQGRCP) Q $$CREF($$R^DIQGU0(%DIQGRCP))
 ;
Q(%Z) S %Z(%Z)="",%Z=$Q(%Z("")) Q $E(%Z,4,$L(%Z)-1)
 ;
DY(Y) X ^DD("DD") Q Y ;*CCO/NI   DATE FORMAT
 ;
DAIEN(IEN,DA) ;
 K DA
 S DA=$P(IEN,",")
 N I F I=2:1 Q:$P(IEN,",",I)=""  S DA(I-1)=$P(IEN,",",I)
 Q
 ;
EXTERNAL(DIFILE,DIFIELD,DIFLAGS,DINTERNL,DIOUTPUT) ;SEA/TOAD
 G XTRNLX^DIDU
 ;
