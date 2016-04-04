DIC1 ;SFISC/GFT/TKW-READ X, SHOW CHOICES ;29DEC2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1,4,17,20,31,48,78,86,999,70,122,165,1003,1022,1046**
 ;
 K DUOUT,DTOUT N DD,DIY,DISUB,DIPRMT
 D GETFA(.DIC,.DO)
 N DIPRMT D GETPRMT^DIC11(.DIC,.DO,.DINDEX,.DIPRMT)
B I $D(DIC("B")) D
 . N B S B(1)=$G(DIC("B")) M B=DIC("B")
 . N DIGBL,DINONULL S DIGBL=DIC_""""_DINDEX_"""",DINONULL=1
 . F DISUB=1:1:DINDEX("#") D  S:B]"" DIY(DISUB)=B
 . . S B=$G(B(DISUB)) I B="" S DINONULL=0 Q
 . . S X="" S:DINONULL X=$O(@(DIGBL_",B)"))
 . . S B=$S($D(^(B)):B,$F(X,B)-1=$L(B):X,$D(@(DIC_"B,0)")):$P(^(0),U),1:B)
 . . N B1 S B1=B I "VPD"[DINDEX(DISUB,"TYPE") D
 . . . I B D  Q:$D(DIY(DISUB,"EXT"))
 . . . . N TYPE S TYPE=DINDEX(DISUB,"TYPE")
 . . . . I TYPE="D" Q:B'?7N.1".".N
 . . . . I TYPE="P" Q:B'?.N.1".".N
 . . . . I TYPE="V" Q:B'?1.N.1".".N1";".E
 . . . . S DIY(DISUB,"EXT")=$$EXT^DIC2(DINDEX(DISUB,"FILE"),DINDEX(DISUB,"FIELD"),B)
 . . . . S:TYPE="P" B=DIY(DISUB,"EXT") Q
 . . . D CHK^DIE(DINDEX(DISUB,"FILE"),DINDEX(DISUB,"FIELD"),"",B,.B1,"DIERROR") S:$G(DIERROR) B1=B
 . . . K DIERROR,DIERR Q
 . . S:DINONULL DIGBL=DIGBL_","_$S(+$P(B1,"E")=B1:B1,1:""""_B1_"""")
 . . Q
 . Q
PROMPT ; Prompt user for lookup values
 D PROMPT^DIC11
 Q
 ;
 ;
GETFA(DIC,DO) ; Get file attributes
 ; DIC is open global reference, output same as documented in DO^DIC1.
 D DO Q
 ;
DO ; GET FILE ATTR
 Q:$D(DO(2))  I $D(@(DIC_"0)")) S DO=^(0)
 E  S DO="0^-1" I $D(DIC("P")) S DO=U_DIC("P"),^(0)=DO
EGP I $P(DO,U,2)>1.9 S $P(DO,U)=$$FILENAME^DIALOGZ(+$P(DO,U,2)) ;**CCO/NI PROMPT FILE NAME and following line
DO2 S DO(2)=$P(DO,U,2) I DO?1"^".E S $P(DO,U)=$$FILENAME^DIALOGZ(+DO(2))
 I DO(2)["s",$D(^DD(+DO(2),0,"SCR")) S DO("SCR")=^("SCR")
 Q:$D(DIC("W"))  Q:DO(2)'["I"  Q:'$D(^DD(+DO(2),0,"ID"))
 S DIC("W")=""
P ; Add code to DIC("W") to display identifiers on pointed-to files
 I DO(2)["P" D WOV,PTRID^DIC5(.DO,.DIC) Q
 N % S %=0
 ;
W F  S %=$O(^DD(+DO(2),0,"ID",%)) D:%]""  Q:%=""
 . N X S X=^DD(+DO(2),0,"ID",%) Q:X="W """""
 . I $L(DIC("W"))+$L(X)>224 D WOV S %="" Q
 . I DIC("W")="" S DIC("W")="N C,DINAME"
 . S DIC("W")=DIC("W")_" W ""  "" "_X
 . Q
 Q
 ;
WOV S DIC("W")="N DIFILEI,DIEN,DIGBL S DIFILEI=+DO(2),DIEN=Y,DIGBL=DIC D WOV^DICQ1"
 Q
 ;
RENUM ;
 D GETFA(.DIC,.DO)
 I '$D(DF),X?.NP,^DD(+DO(2),.01,0)["DINUM",$D(@(DIC_"X)")) D  Q:Y>0
 . S Y=X D S^DIC3 I $T N DZ D ADDKEY^DIC3,GOT^DIC2 Q
 . S Y=-1 Q
 D F^DIC Q
 ;
DT S DST=DST_$$DATE^DIUTL(%) ;**CCO/NI DATE FORMAT
 I '$D(DDS) W DST S DST=""
 Q
 ;
Y ; Display a list of entries
 N DD,DDD,DDC,DDH,DIOUT S DIY="",DIOUT=0,DD=DS("DD")
 I DD=0,DIC(0)["T",DIC(0)["E" D DSPH^DIC0
 F  S DD=$O(DS(DD)) Q:'DD  D  Q:DIOUT
 . S DDH=DD-1,DIYX=0,DS("DD")=DD
 . I DIC(0)["E" W:'$D(DDS) !?5,DD,?9 D
 . . N Y S Y=+DS(DD)
 . . D E Q
 . I DIC(0)["Y" Q:DD<DS  D
 . . F Y=DS:-1 Q:'$G(DS(Y))  S Y(+DS(Y))=""
 . . Q
 . I DIC(0)'["E"!(DIC(0)["Y") S DS(0)="1^",DIOUT=1,DIY="" Q  ;IMPORTANT!  STOPS FURTHER LOOKUP
 . I DS>DD Q:DD#5
 . S DIOUT=1
 . I $D(DDS) S DDD=2,DDC=5 D LIST^DDSU K DDD,DDC
 . I '$D(DDS) D
 . . I DS>DD W !,$$EZBLD^DIALOG(8087,$S(DIC(0)["T":"'^^' to exit all lists,",1:"")) ;**PATCH 122
 . . N R S R(1)=$O(DS(0)),R(2)=DD W !,$$EZBLD^DIALOG(8088,.R) R DIY:$S($D(DTIME):DTIME,1:300) S:'$T DTOUT=1 Q  ;"CHOOSE 1-5" or whatever
 . I $G(DTOUT) W $C(7) S X="" Q
 . I DIY[U!($G(DUOUT)) S DUOUT=1,X=U D  Q
 . . I DIY?1"^^".E,DIC(0)["T" S DIROUT=1 Q
 . . I DIY?1"^".E,DIC(0)["E",DIC(0)'["T" S DIROUT=1 Q
 . Q
 I DIY?1.N.1".".N D  I DIY,DIY'>DD,$G(DS(DIY)) S Y=+DS(DIY) D GOT S DS(0)=1_"^"_+Y Q
 . S:($L($P(DIY,"."))>25!($L($P(DIY,".",2))>25)) DIY="-1" Q
 I $L(DIY)>25 S DIY=-1
 N I S I=$S($G(DUOUT):"1^U",$G(DTOUT):"1^T",DIY?1."?":"1^?",DIY:1,1:"")
 I 'I,DIY]"",+$P(DIY,"E")'=DIY,'$G(DICR),DINDEX("#")=1 S I="2^"_DIY
 Q:'I
 S DS(0)=I,Y=-1
 I DIY?1."?" D
 . I (DIC(0)_$G(DICR(1,0)))'["A",$D(DICRS) Q
 . N X,Y,DS D DSPHLP^DICQ(.DIC,.DIFILEI,.DINDEX,"?",1)
 K DIY,DIYX Q
 ;
E S DST="" D
 . I DIC(0)["U" ;Q    I DO NOT KNOW WHY THIS 'QUIT' WAS THERE  --GFT
 . I $O(DS(DD,0)) S DST=$$BLDDSP(.DS,DD) Q
 . S %=$S($G(DILONGX):DICR(DILONGX,"ORG"),$G(DINDEX("IXTYPE"))'="S":$P(X,U),1:"")
 . S %=%_$P(DS(DD),U,2,9)_$S($G(DIYX(DD)):DIY(DD),1:"")
 . I ($G(DITRANX)!($G(DICRS))),$G(DINDEX(1,"TRANOUT"))]"",%]"" D  Q
 . . N X S X=% X DINDEX(1,"TRANOUT") S DST=$G(X) Q
 . I +$P(%,"E")=%,$D(DIDA) D DT Q
 . I $G(DICRS),$G(DINDEX("IXTYPE"))="R" D
 . . N F1,F2 S F1=$G(DINDEX(1,"FILE")),F2=$G(DINDEX(1,"FIELD"))
 . . I F1,F2 S %=$$EXT^DIC2(F1,F2,%,"h")
 . . Q
 . S DST=% Q
 I DIC(0)["s" S DIC(0)=$TR(DIC(0),"s")
 I $D(DS(DD,"K")) S %=$G(DIX) M DIX=DS(DD) S DIX=%
 S DIY=$S($G(DIYX(DD)):"",1:DIY(DD)) D WO^DIC2 Q
 ;
BLDDSP(DS,DD,DINDXFL,DIYX,DIY,DICRS) ; Build display of index values
 N X,I S X=""
 F I=0:0 S I=$O(DS(DD,I)) Q:'I  D
 . I $L(X)+$L(DS(DD,I))>240 Q
 . I I=1,$G(DINDXFL) S X=$P(DS(1),U,2,99)_$S($G(DIYX(1)):$G(DIY(1)),1:"") Q
 . I I=1,$G(DICRS) Q
 . S X=X_$P("  ^",U,I>1)_DS(DD,I) Q
 Q X
 ;
GOT ; Set data for single entry selected by user.
 N I,J,K
 I DIY(DIY)="" S DIY(DIY)=$P($G(@(DIC_"Y,0)")),U)
 S:$D(DDS) DST=X_$P(DS(DIY),U,2,9)_$S($G(DIYX(DIY)):$G(DIY(DIY)),1:"")
 S K=$O(DIVPSEL("A"),-1) I K]"" S DIVPSEL(K)=Y
 I $G(DIFINDR) D  Q
 . S:$D(DDS) DS(0,"DST")=DST
 . S DS(0,"Y")=+DS(DIY),DS(0,"X")=X_$P(DS(DIY),"^",2),DS(0,"DIYX")=$G(DIYX(DIY)),DS(0,"DIY")=DIY(DIY)
 . M DS(0,1)=DS(DIY)
 . Q
 I $G(DIYX(DIY)) K DIYX S DIY(DIY)=$P($G(@(DIC_"Y,0)")),U)
 D C^DIC2 Q
 ;
OK ;
 S %=1 I $G(DS)=1 S DST="         ...OK" D Y^DICN W:'$D(DDS) !
 I %>0 Q:%=1  D  S X=$G(DIX),Y=-1 Q  ;%=1=Yes, %=2=No
 . I $G(DICR) S DICR(DICR,31.2)=+Y ;Preserve IEN for future reference
 . I +$G(DS) K DS S (DS,DS(0),DS("DD"))=0 ;ReInit Display array
 . Q
 I %=0 W !?4,$$EZBLD^DIALOG(8040),! G OK ;User asked for Help
 I %=-1,$D(DTOUT) S DIROUT=1 ;User TIMED Out; DTOUT set in DICN
 I %=-1,'$D(DTOUT) S (DUOUT,DIROUT)=1 ;User single up-arrowed out
BAD S Y=-1
 I $G(%Y)?1"^^".E S (DIROUT,DUOUT)=1
 S DS(0)=$S($G(DTOUT):"1^T",$G(DUOUT):"1^U",$G(%)=-1:"1^U",1:"1^") Q
MIX ;
 N DID S DID=D_"^-1",DID(1)=2
 N D S D=$P(DID,U)
 G IX^DIC
 ;
 ;#8042  Select |filename|:
 ;#8040   Answer with 'Yes' or 'No'
