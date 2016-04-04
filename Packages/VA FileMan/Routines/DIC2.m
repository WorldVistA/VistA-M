DIC2 ;SF/XAK/TKW-LOOKUP (CONT) ;06:31 PM  7 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,17,20,31,40**
 ;
WO ; Display .01 field, Primary KEY values and Identifiers for an entry.
 I '$D(DST) N DST
 S DST=$G(DST)_"  " D WR
 I $D(DIC("W")),$D(@(DIC_"Y,0)")) D:$D(DDS)&'$D(DDH("ID")) ID^DICQ1 I '$D(DDS) D
 . I $G(DST)]"" W DST,"  "
 . N DISAVEX M DISAVEX=Y N Y M Y=DISAVEX S DISAVEX=X N X S X=DISAVEX K DISAVEX
 . I $D(@(DIC_"Y,0)")) X DIC("W")
 . K DST Q
 Q
WR ; Put .01 field into DST for display
 D:'$D(DO) GETFA^DIC1(.DIC,.DO) I '$D(DST) N DST
 I (DIC(0)["S"!(DIC(0)["s")),DIVAL(1)'=" " Q:"  "[$G(DST)&('$D(DIX("K")))  D S Q
 S DST=$G(DST)
 I DO(2)["V",DIY?1.N1";"1.E S DST=DST_$$EXT(+DO(2),.01,DIY) D S Q
 I DIY?.N.1".".N,(DO(2)["P"!(DO(2)["D")),DIY D  D S Q
 . I DO(2)["P" S DST=DST_$$EXT(+DO(2),.01,DIY) Q
 . N % S %=DIY D DT^DIC1 Q
W1 I '$G(DIYX),DIY]"",((DST'[DIY)!($P(DST,DIY)]"")) S DST=DST_DIY
S ; Put Primary KEY values into DST, display DST if not in ScreenMan
 I $D(DIX("K")),DIC(0)'["S" N I,F,% F I=0:0 S I=$O(DIX("K",I)) Q:'I  F F=0:0 S F=$O(DIX("K",I,F)) Q:'F  D
 . I DIY]"",F=.01 Q
 . I $G(DIX("F"))[("^"_F_"^") Q
 . S %=DIX("K",I,F) Q:%=""  I $L(%)+$L(DST)>240 Q
 . S DST=DST_$P("  ^",U,DST]"")_% Q
 N A1 S A1=Y I '$D(DDS) W DST K DST Q
H ; Display .01 and Primary KEY values if in ScreenMan
 I '$D(A1) N A1 S A1="T"
 S DDH=$G(DDH)+1,DDH(DDH,A1)=DST K DST Q
 ;
EXT(DIFILE,DIFIELD,DIVAL,DIF) ; Return external value of field
 N DIERR,DISAV S DISAV=$G(DIVAL) I DISAV="" Q DISAV
 S DIF=$G(DIF) S:DIF="" DIF="F"
 S DIVAL=$$EXTERNAL^DIDU(DIFILE,DIFIELD,DIF,DIVAL,"DIERR")
 I $D(DIERR) S DIVAL=DISAV
 Q DIVAL
 ;
PGM(DIC,DF,DIFILE) ; Return special lookup program name
 I DIC(0)["I"!($G(DF)]"") Q ""
 N DIPGM S DIPGM=$G(^DD(DIFILE,0,"DIC")) Q:DIPGM=""!(DIPGM?1"DI".E) ""
 Q U_DIPGM
 ;
GOT I DIC(0)["E" D
 . N:'$D(DST) DST N DDH D WO
 . I $D(DDS),$D(DDH)>10 D LIST^DDSU K DDH("ID")
 . Q
 S Y=Y_"^"_$S(DIY="":X,$G(DIYX):X_DIY,1:DIY)
 I DIC(0)["E" D  Q:Y<0
 . I DO(2)["O"!($G(DIASKOK)) D OK^DIC1 Q
 . Q:DIC(0)'["T"
 . I $G(DICR) Q:'$G(DICRS)!(DICR'=1)  D OK^DIC1 Q
 . D OK^DIC1 Q
R D:'$G(DICR)  I Y<0 D A^DIC S DS(0)="1^" Q
 . D ACT^DICM1 Q:Y<0
 . Q:DINDEX("#")'>1!(DINDEX("START")'=DINDEX)
 . N I F I=1:1:DINDEX("#") I $D(DIX(I))#2 S X(I)=DIX(I)
 . Q
 I DIC(0)["Z" S Y(0)=@(DIC_"+Y,0)"),Y(0,0)=$$EXT(DIFILEI,.01,$P(Y(0),U))
ACT I DIC(0)'["F",$D(DUZ)#2 S ^DISV(DUZ,$E(DIC,1,28))=$E(DIC,29,999)_+Y
 I $D(@(DIC_"+Y,0)")) D:DIC(0)'["T" Q Q
 S Y=-1 D Q S DS(0)="1^" Q
 ;
Q K DIDA,DID,DISMN,DINUM,DS,DF,DD,DIX,DIY,DIYX,DZ,DO,D,DIAC,DIFILE
 I '$G(DICR) K DIC("W"),DIROUT I DIC(0)["T" K ^TMP($J,"DICSEEN")
 Q
 ;
G ; Display index values for a single looked-up entry
 I $D(DS(0,"DICRS")),'$D(DICRS) N DICRS S DICRS=1
 I $D(DS(0,"DIDA")),'$G(DIDA) N DIDA S DIDA=1
 I $D(DIDA),$P(DS(1),U,2,99)]"" N:'$G(DIASKOK) DIASKOK S DIASKOK=1
 I DIC(0)["T",DIC(0)["E",'$D(DDS) D DSPH^DIC0 W !
 S DIY=1,DIX=X I DIC(0)["E",DIC(0)'["U" D
 . I DIC(0)["D" Q:$P(DS(1,"F"),U,2)=.01  N DIENTIRE S DIENTIRE=1
 . N D,% S (D,%)=""
 . I $G(DIDA),$P(DS(1),U,2,99)]"" S %="  partial match to:"
 . I $O(DS(1,0)) D
 . . I DINDEX("#")=1,'$G(DIDA) S D=%_$$BLDDSP^DIC1(.DS,1,1,.DIYX,.DIY,$G(DICRS)) Q
 . . S D=%_$$BLDDSP^DIC1(.DS,1,"","","",$G(DICRS)) Q
 . E  I $G(DITRANX) D
 . . S D=X_$P(DS(1),U,2,99)_$S($G(DIYX(1)):$G(DIY(1)),1:"")
 . . I $G(DINDEX(1,"TRANOUT"))]"" N X S X=D X DINDEX(1,"TRANOUT") S D=$G(X)
 . . S:D]"" D="  "_D  I $G(DIFINDER)["p",'$D(DDS) W !
 . . Q
 . E  I '$D(DICRS) D
 . . I $G(DIDA) S D=$P(DS(1),U,2,99) I D]"" S D=%_"  "_$$DATE^DIUTL(X_D) W:'$D(DDS) ! Q  ;**CCO/NI
 . . S D=$P(DS(1),U,2,99)_$S($G(DIYX(1)):$G(DIY(1)),1:"")
 . . I $G(DIFINDER)["p" S D=X_D W:'$D(DDS)&(DIC(0)'["T") ! Q
 . . I DIC(0)["T"!($G(DIENTIRE)) S D=X_D
 . . Q
 . S DST=$P("  ^",U,$D(DST)#2)_D
 . I '$D(DDS) W DST S DST=""
 . Q
C S Y=$G(DIX) M DIX=DS(DIY) S DIX=Y
 I $O(DS(1)) K DIX("F")
 S Y=+DS(DIY),X=X_$P(DS(DIY),"^",2),DIYX=$G(DIYX(DIY)),DIY=DIY(DIY)
 D GOT Q
 ;
 ;
