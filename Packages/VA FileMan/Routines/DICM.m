DICM ;SFISC/GFT,XAK,TKW-MULTIPLE LOOKUP FOR FLDS WHICH MUST BE TRANSFORMED ;27OCT2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,20,31,40,149,159,165,169**
 ;
 I '$D(DICR(1)),DIC(0)'["T" N DICR S DICR=0
 I $A(X)=34,X?.E1"""" G N
 I $G(^DD(+DO(2),0,"LOOK"))]"",^("LOOK")'="SOUNDEX" G @^("LOOK")
 I DIC(0)["U" S DD=0 G W
 I DIC(0)["T" G 2
R N DIFLAGS S DIFLAGS="4l"_$P("M^",U,DIC(0)["M")
 N DIFORCE D
 . S DIFORCE=0 I DIC(0)'["M"!($D(DID)) S DIFORCE=1
 . S DIFORCE(0)=$S(DIC(0)'["M":DINDEX,$D(DID):DID,1:"*"),DIFORCE(1)=1
 F  D 1 I DINDEX=""!(Y>0)!($G(DTOUT))!($G(DIROUT)) Q  ;LOOP THRU ALL THE INDEXES!
 G 2
 ;
1 N DS,%Y,DIV
 I $G(DINDEX("IXFILE")) S Y=DINDEX(1,"FILE"),%Y=DINDEX(1,"FIELD")
 E  S Y=$O(^DD(+DO(2),0,"IX",DINDEX,0)) S:Y="" Y=-1 S %Y=+$O(^(Y,0))
 I Y=-1,DINDEX="B" S Y=+DO(2),%Y=.01
 S:Y="" Y=-1 S:%Y="" %Y=-1
 I $D(DICR(U,Y,%Y,DINDEX)) S Y=-1 ;HAVE WE ALREADY TRIED THIS INDEX?
 E  I %Y=.01,DINDEX'="B",Y=+DO(2),$D(DICR(U,Y,%Y,"B")),$G(DINDEX(1,"TRANCODE"))="" S Y=-1 ;!
 I Y'<0 D
 . S DS=$G(^DD(Y,%Y,0)) I DS="" S Y=-1 Q
 . S %=DINDEX,DICR(U,Y,%Y,DINDEX)=0
 . I $D(^DD(Y,%Y,7)) D RS K DS X ^(7) Q
 . I $G(DINDEX("IXTYPE"))="S" D A,SOU^DICM1,D Q:Y>0  S Y=-1 Q
 . S DIX=Y,Y=$P(DS,U,2) I Y["P",DIC(0)'["L",$T(ORDERQ^DICUIX2)]"",$$ORDERQ^DICUIX2(+$P(Y,"P",2)) S Y="" ;TRICK TO SPEED LOOKUP OF ORDERS!
 . S Y=$S(Y["P":"P",Y["D":"D",Y["S":"S",Y["V":"V",1:"") ;TRANSFORMATION WILL BE NECESSARY IF X-REF'D FIELD IS DATE, POINTER, SET OR VARIABLE-POINTER
 . I Y]"" D A D:'Y ^DICM1,D Q:Y>0  S Y=-1 Q
 . I $G(DINDEX(1,"TRANCODE"))]"" S Y="T" D A,^DICM1 N DITRANX S DITRANX=1 D D
 . Q:Y>0  S Y=-1 Q
 Q:Y>0!(DIC(0)["T")  D
 . K DIV M DIV=X S DIV(1)=X N X,Y
 . D NXTINDX^DICF2(.DINDEX,.DIFORCE,.DIFILEI,DIFLAGS,.DIV,"*") Q
 Q
 ;
2 D D^DIC0 S %=D ;HERE'S WHERE WE TRY ALTERNATE LOOKUPS: UPPER CASE, COMMA-PIECING, TRUNCATE LONG INPUT
 G K:Y>0!($G(DIROUT))
 I X?.E1L.E,DIC(0)'["X" D  G K:$G(DIROUT) ;CONVERT TO UPPER-CASE
 . D % N DIFILEI,DINDEX
 . S DIC(0)=$TR(DIC(0),"L"),X=$$UP^DILIBF(X) S:$G(DILONGX) DICR(DILONGX,"ORG")=X
 . D DIC Q
 I Y'>0,X["," S DS="",DIX=$P(X,",") I DIC(0)'["X",$L(DIX)<31 D  G K:$G(DIROUT) ;COMMA-PIECING
 . F %=2:1 S DD=$P(X,",",%) I DD'["""" D  Q:DD=""
 . . F  Q:$A(DD)-32  S DD=$E(DD,2,999)
 . . F  Q:$A(DD,$L(DD))-32  S DD=$E(DD,1,$L(DD)-1)
 . . I $L(DD)*2+$L(DS)>200!(DD="") S DD="" Q
 . . S DS=DS_" I %?.E1P1"""_DD_""".E!(D'=""B""&(%?1"""_DD_""".E))" Q
 . Q:DS=""  S %=D
 . D % S X=DIX N DILONGX
 . S DS="S %=$P(^(0),U)"_DS,DIC(0)=DIC(0)_"D" D 7 Q
 I Y'>0,$L(X)>30 D  ;LONG DATA
 . N DILONGX
 . S %=D D % S DILONGX=DICR,Y="DICR("_DICR_")",DICR(DICR,"ORG")=X
 . S DS=$S(DIC(0)["X":"I DIVAL="_Y,1:"I '$L($P(DIVAL,"_Y_"))")
 . S:DIC(0)["O"&(DIC(0)'["E") DS=DS_",'$L($P(DIVAL,"_Y_",2))"
 . D 7 I Y>0!(X'?.E1L.E)!(DIC(0)["X") Q
 . S %=D D % S (X,DICR(DICR,"ORG"))=$$UP^DILIBF(X)
 . S Y="DICR("_DICR_",""ORG"")"
 . S DS="I '$L($P(DIVAL,"_Y_"))" S:DIC(0)["O"&(DIC(0)'["E") DS=DS_",'$L($P(DIVAL,"_Y_",2))"
 . D 7
 ;
K S DICR=+$G(DICR),DD=$D(DICR(DICR,6)) K:'DICR DICR
 I Y>0 K DIC("W") D R^DIC2 Q
 I $G(DTOUT)!($G(DIROUT)) Q
W I @("$O("_DIC_"""A[""))]""""") G NL:DIC(0)["N",DD
 I DO(2)'["Z" S Y=0 D  Q:Y>0!($G(DIROUT))
DINUM .I $G(DINDEX("1","FIELD"))=.01,X?1.15NP,$P($G(^DD(+DO(2),.01,0)),U,5,99)["DINUM=X",$P($G(@(DIC_"X,0)")),U)=X D  Q:Y>0
 ..S Y=X I 1 X:$D(DIC("S")) DIC("S") I  S DIY="",DS=1 N DZ,DD D ADDKEY^DIC3,GOT^DIC2 Q
 ..S Y=0
 .N DIOUT S DIOUT=0 F DS=1:1 S @("Y=$O("_DIC_"Y))") D  Q:DIOUT  ;GO THRU THE WHOLE FILE BECAUSE WE HAVE NO CROSS-REFERENCE!  (SEE ..DOTS.. BELOW)
 . . I 'Y S Y=-1,DIOUT=1 Q
 . . W:DIC(0)["E"&(DS#20=0) ".."
 . . I $D(@(DIC_Y_",0)")),$P(^(0),U)=X X:$D(DIC("S")) DIC("S") I  S DIOUT=1
 . . I DIOUT S DIY="",DS=1 N DZ,DD D ADDKEY^DIC3,GOT^DIC2
 . . Q
NL I '$G(DICR) D NQ I $T D  Q:Y>0!($G(DTOUT))!($G(DIROUT))
 . N:'$G(DIASKOK) DIASKOK S (DS,DIASKOK)=1 N DZ,DD
 . D ADDKEY^DIC3,GOT^DIC2 Q
DD S Y=-1 I DD D BAD^DIC1 Q
L I DIC(0)["L" K DD G ^DICN
B D BAD^DIC1 Q
 ;
N D RS S X=$E(X,2,$L(X)-1),%=D D
 . I DINDEX("#")>1 S %Y=+$G(DINDEX(1,"FIELD")),DS=$G(^DD(+$G(DINDEX(1,"FILE")),%Y,0)) Q:DS]""
 . S DS=^DD(+DO(2),.01,0),%Y=.01 Q
 F Y="P","D","S","V" I $P(DS,U,2)[Y K:Y="P" DO D ^DICM1 S:$D(X)#2 DS("INT")=X Q
 I $D(X),DINDEX("#")>1 S X(1)=X
 S Y=-1 D L:$D(X),E
 I Y'>0 K DUOUT D BAD^DIC1 Q
 G 2
 ;
A ; Set variables needed for transforming date/set/ptr/var.ptr
 S DICR(DICR+1,4)=%
 D % K DF,DID,DINUM Q
 ;
% ; Set variables up before doing lookup w/transformed value
 I DIC(0)'["L" S DICR(DICR+1,8)=1
 E  I '$$OKTOADD^DICM0(.DIFILEI,.DINDEX,.DIFINDER) S DICR(DICR+1,8)=1
 I $G(DINUM)]"" S DICR(DICR+1,10)=DINUM
 I $D(DF) S DICR(DICR+1,9)=DF S:$G(DID)]"" DICR(DICR+1,9.1)=$G(DID(1))_U_DID
RS S DICR=DICR+1,DICR(DICR)=X,DICR(DICR,0)=DIC(0),DIC(0)=$TR(DIC(0),"A"),DIC(0)=$TR(DIC(0),"Q") Q
 ;
D S:$G(DICR(DICR,10))]"" DINUM=DICR(DICR,10)
 S (D,DF)=DICR(DICR,4) D
 . N T S T=$P($G(DS),U,2)
 . S DIC(0)=$TR(DIC(0),"M","") I T["V" S DIC(0)=$TR(DIC(0),"A","")
 . I D="B",T'["D",'$G(DITRANX) S DIC(0)=DIC(0)_"s"
 . I T["P"!(T["V")!(T["S") S DIC(0)=DIC(0)_"X"
 . Q
 I DICR(DICR,4)=DINDEX N I M I=DINDEX N DINDEX M DINDEX=I K I S DINDEX("START")=DINDEX
 E  N DINDEX D
 . S (DINDEX,DINDEX("START"))=DICR(DICR,4),DINDEX("WAY")=1
 . D INDEX^DICUIX(.DIFILEI,DIFLAGS,.DINDEX,"",.DIVALUE) Q
 I DINDEX("#")>1 S (DINDEX(1),DINDEX(1,"FROM"),DINDEX(1,"PART"))=$G(X)
RCR S:'$D(DIDA) DICRS=1
DIC ;
 I $D(DICR(DICR,8)) S DIC(0)=$TR(DIC(0),"L")
 S Y=-1 I $D(X) D  ;**22*159  WAS: I $D(X),$L(X)<31 D
 . N DIVAL S (DIVAL,DIVAL(1))=X N X S (X,X(1))=DIVAL
 . D RENUM^DIC1 K DIDA Q
 I $G(DICR) S:DIC(0)["L" DICR(DICR-1,6)=1 K:$D(DICR(DICR,4)) DF ;**GFT 12/18/07
E S D="B" D:$G(DICR)  ;**GFT 1/3/06
 .S %=DICR,X=DICR(%),DIC(0)=DICR(%,0),DICR=%-1
 .S:$G(DICR(%,10))]"" DINUM=DICR(%,10)
 .S:$D(DICR(%,9)) (D,DF)=DICR(%,9) I $G(DICR(%,9.1))]"" S:$P(DICR(%,9.1),U)]"" DID(1)=$P(DICR(%,9.1),U) S DID=$P(DICR(%,9.1),U,2,999)
 .K DICRS,DICR(%)
 D DO^DIC1:'$D(DO(2)) Q
 ;
NQ I $L(X)<14,X?.NP,+X=X,@("$D("_DIC_"X,0))") S Y=X D S^DIC3
 Q
 ;
SOUNDEX I DIC(0)["E",'$D(DICRS) W "  " D RS,SOU S DIC(0)=$TR(DIC(0),"L") D RCR Q:Y>0
 G R
 ;
7 S Y=-1 N % S %=$S($D(DIC("S")):DIC("S"),1:1) ;RECURSIVE CALL TO ^DIC!
 I $D(DS),'$D(DIC("S1")) D
 . S DIC("S")=DS I '% S DIC("S")=DIC("S")_" X DIC(""S1"")",DIC("S1")=%
 . I X]"" D
 . . N DIVAL S (DIVAL,DIVAL(1))=X,DIVAL(0)=1 N X S (X,X(1))=DIVAL
 . . N DINDEX,DIFILEI
 . . S DIC(0)=$TR(DIC(0),"L") D F^DIC
 . K DIC("S") S:$D(DIC("S1")) DIC("S")=DIC("S1") K DIC("S1")
 D E Q
 ;
SOU D SOU^DICM1 Q
