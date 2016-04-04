DICQ1 ;SFISC/GFT,TKW-HELP FOR LOOKUPS ;3JUN2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,3,54,999,1004**
 ;
EN ; Set up parameters for lister call, then display current entries.
 I 'DIRECUR,'$D(DDS) D Z^DDSU
 I DICNT>1,$D(DZ)#2 S DST=" " D:DZ["??"&'$D(DDS) %^DICQ S DST=$$EZBLD^DIALOG(8068) D %^DICQ
 N DISCR S:$G(DIC("S"))]"" DISCR("S")=DIC("S")
 I $D(DIC("V")) M DISCR("V")=DIC("V")
 S %=$G(DIC("?PARAM",DIFILEI,"INDEX")) I %]"" D
 . S (DIX,DIBEGIX)=%,DIX("WAY")=1 D INDEX^DICUIX(.DIFILEI,"hl",.DIX) Q
 I $O(DIC("?PARAM",DIFILEI,"PART",0)) S DIPART(1)="",%=0 D
 . F  S %=$O(DIC("?PARAM",DIFILEI,"PART",%)) Q:'%  I '(%#1) S DIPART(%)=DIC("?PARAM",DIFILEI,"PART",%)
 . S DIPART=DIPART(1) Q
 N DIFLAGS,DIFIELDS,DIIENS S DIFLAGS="MPh"
 I 'DIUPRITE,"PV"[$G(DIX(1,"TYPE")) D
 . N DIFRPRT S DIFRPRT=DIFROM_$G(DIC("?PARAM",DIFILEI,"FROM",1))_$G(DIPART)
 . Q:'$$CHKP^DICUIX1(.DIFILEI,.DIX,DDC,DIFRPRT,.DISCR,1)
 . S DIFLAGS="MPQh" K DIFROM S DIFROM="" Q
 I DIUPRITE S DID01=0,DIBEGIX="#"
 S DIIENS=$S(DIC(0)["p":",",1:DIENS)
W S DIFIELDS="@;IX" D
 .I 'DIUPRITE,DID01!(DIC(0)["S") K DID01 Q
 .N EXT S EXT="$$EXT^DIC2("_DIFILEI_",.01,$P("_DIC_"Y,0),U))"
 .I '$D(DDS)!'$D(DDSMOUSY) S DIC("DID01")="W ""   "","_EXT Q
 .S DIC("DID01")="W ""   "" D WRITMOUS^DDSU("_EXT_")"
E1 K DDD S DD="",DIY=99,DDD=$S($D(DDS):1,1:5),(DIZ,DILN)=21
 I $D(DDH)>10 D LIST^DDSU Q:$D(DDSQ)
 I DIFROM]"" D  S DIFROM(1)=DIFROM
 . I +$P(DIFROM,"E")=DIFROM S DIFROM=DIFROM-.00000001 Q
 . N M F %=$L(DIFROM):-1:1 S M=$A(DIFROM,%) I M>32 S DIFROM=$E(DIFROM,1,%-1)_$C(M-1)_$C(122) Q
 . Q
 I DIFLAGS'["Q" S %=$G(DIC("?PARAM",DIFILEI,"FROM",1)) I %]"" D
 . S:DIFROM="" (DIFROM,DIFROM(1))=% S %=1
 . F  S %=$O(DIC("?PARAM",DIFILEI,"FROM",%)) Q:'%  I '(%#1) S DIFROM(%)=DIC("?PARAM",DIFILEI,"FROM",%)
 . Q
 ;
L ; List current entries in the file.
 N DICQ
 D LIST^DICL(.DIFILEI,DIIENS,DIFIELDS,DIFLAGS,DDC,.DIFROM,.DIPART,DIBEGIX,.DISCR,"","DICQ","",.DIC)
 K DIC("DID01"),DICQ
 D BK^DIEQ S:'$D(DDS) DDD=3 ;D LIST^DDSU ***
 K DDH Q:$D(DDSQ)!($G(DTOUT))
 D 0 Q
 ;
DSP(DINDEX,DICQ,DIC,DIFILE) ; Display entries from DICQ array
 ; note: this routine is called from the lister, DICLIX & DICL1.
 N I,J,F,X,Y,DD,DDD,DIY,DILN,DIZ,DIMAP,DDH,DID01,DIQUIET,DIPGM,DST,DISPACE,DIERR,DP
 S DIMAP=$G(DICQ(0,"MAP")),DDH=0,DST="",DIPGM="DICQ1",$P(DISPACE," ",10)=""
 S:$G(DIC("DID01"))]"" DID01=DIC("DID01")
 N DIKEYL,DIKEY I $O(DIFILE(DIFILE,"KEY",DIFILE,0)),DIC(0)'["S" M DIKEYL=DIFILE(DIFILE,"KEY",DIFILE)
 I $D(DIC("W"))!($D(DID01))!($D(DIKEYL)) D ID
 F I=0:0 S I=$O(DICQ(I)) Q:'I  S X=$G(DICQ(I,0)) I X]"" D
 . S DST=""
 . I DINDEX="#" S DST=$P(X,U)_"  " S:$L(DST)<7 DST=DST_$E(DISPACE,($L(DST)+1),7)
 . I $D(DIKEYL) S DIKEY(+X)="" F J=0:0 S J=$O(DIKEYL(J)) Q:'J!$G(DIERR)  F F=0:0 S F=$O(DIKEYL(J,F)) Q:'F!$G(DIERR)  D
 . . I (F=.01&($D(DID01))!(DINDEX("FLISTD")[("^"_F_"^"))) D  Q
 . . . S:DIKEY(+X)="" DIKEY(+X)=" " Q
 . . S Y=$$GET1^DIQ(DIFILE,+X_DIFILE(DIFILE,"KEY","IEN"),F,"","","DIERR") Q:$G(DIERR)
 . . I ($L(DIKEY(+X)))+($L(Y))+2>240 S DIERR=1 Q
 . . S DIKEY(+X)=DIKEY(+X)_$P("  ^",U,DIKEY(+X)]"")_Y Q
 . F J=2:1 Q:$P(DIMAP,U,J)=""  S Y=$P(X,U,J) D:$P(DIMAP,U,J+1)]""  S:$L(DST_Y)<240 DST=DST_Y
 . . S Y=Y_"   "
 . . I J=(DINDEX("#")+1) S Y=Y_"   "
 . . Q
 . I DST]"" S Y=+X,DDH=DDH+1,DDH(DDH,Y)=DST_"   "
 . Q
 S DD="",DIY=99,DDD=5,DP=DIFILE
 I '$G(DIC("?N",DIFILE)) S (DIZ,DILN)=21
 E  S (DIZ,DILN)=999
 D LIST^DDSU K DICQ
 K DIERR,^TMP("DIERR",$J)
 Q
 ;
ID ; Put code to display .01 field and Identifiers into DDH array.
 S DIY="I $D("_DIC_"Y,0))" I $D(DID01) S DIY=DIY_" "_DID01_" "_DIY
 I $D(DIKEYL) S:$D(DID01) DIY=DIY_" W ""  """ S DIY=DIY_" W DIKEY(Y)"
 I '$D(DIC("W")) S DDH("ID")=DIY Q
 S DIY=DIY_" "
 I $L(DIC("W"))+$L(DIY)<240 S DDH("ID")=DIY_DIC("W") Q
 S DDH("ID")=DIY_"X DDH(""ID"",1)" S DDH("ID",1)=DIC("W") Q
 ;
WOV N DIC,Y,DI1X,DIY,DIYX,%,C,DINAME S DIC=DIGBL,Y=DIEN,DI1X=0
W1 F  S DI1X=$O(^DD(DIFILEI,0,"ID",DI1X)) Q:DI1X=""  S %=^(DI1X) D
 . X "W ""  "",$E("_DIGBL_DIEN_",0),0)",%
 Q
 ;
0 ; If LAYGO allowed, display additional help.
 K DDC,DIEQ,DIW,DS I DIC(0)'["L" D QQ Q
 I $D(%Y)#2 S:%Y="??" DZ=%Y S:%Y?1P DZ="?"
 S DDH=+$G(DDH) N A1,DIACCESS S DIACCESS=1
 I $S($D(DLAYGO):DIFILEI-DLAYGO\1,1:1),DUZ(0)'="@",'$D(^DD(DIFILEI,0,"UP")) D CHKACC
 I '$G(DIACCESS) D RCR Q
10 ; Tell user that they may enter new entries to the file
 I DZ?1."?" S DST=" " D DS^DIEQ S DST=$$EZBLD^DIALOG(8069,$P(DO,U)) D DS^DIEQ D:DZ="?" HP
 D H
 I DO(2)["S" S DST=$$EZBLD^DIALOG(8068)_" " D %^DICQ D
 . N X,Y,A2,DST,DISETOC,DIMAXL S DIMAXL=0,DISETOC=$P(^DD(+DO(2),.01,0),U,3)
 . F X=1:1 S Y=$P($P(DISETOC,";",X),":") Q:Y=""  S:$L(Y)>DIMAXL DIMAXL=$L(Y)
 . S DIMAXL=DIMAXL+4
 . F X=1:1 S Y=$P(DISETOC,";",X) Q:Y=""  S A2="",$P(A2," ",DIMAXL-$L($P(Y,":")))=" ",DST="  "_$P(Y,":")_A2_$P(Y,":",2) D DS^DIEQ
 . Q
 I DO(2)["V" D
 . N DG,DU,D
 . S DU=+DO(2),D=.01 D V^DIEQ Q
 ;
RCR ; Recursive call to display entries on pointed-to file.
 I DO(2)'["P"!($G(DZ(1))=0) D QQ Q
 N %,D,DS,DIPTRIX S D=""
 S DS=^DD(+DO(2),.01,0)
 S DIPTRIX=$G(DIC("PTRIX",+DO(2),.01,+$P($P(DS,U,2),"P",2)))
 M %=DIC("PTRIX"),%(1)=DIC("?N"),%(2)=DIC("?PARAM")
 N DIC M DIC("PTRIX")=%,DIC("?N")=%(1),DIC("?PARAM")=%(2) K %
 S DIC=U_$P(DS,U,3),DIC(0)=$E("L",$P(DS,U,2)'["'")
 I $P(DS,U,2)["*" D
 . N DILCV,DICP,DIPTRIX,DISAV0 S DISAV0=DIC(0)
 . F DILCV=" D ^DIC"," D IX^DIC"," D MIX^DIC1" S DICP=$F(DS,DILCV) I DICP D  S DIC(0)=DISAV0
 . . X $P($E(DS,1,DICP-$L(DILCV)-1),U,5,99) Q
 . S D=$P($G(D),U) Q
 S:DIPTRIX]"" D=$P(DIPTRIX,U) K DIPTRIX,DS
 N DO,DIFILEI,DINDEX I D="" S D="B"
 S DIRECUR=DIRECUR+1
 D DQ^DICQ
QQ Q:$D(DDH)'>10
 K DDD S DD="",DIY=99,DDD=$S($D(DDS):1,1:5),(DIZ,DILN)=21
 S:$D(DDS) DDC=-1 D LIST^DDSU K DDC Q
 ;
HP N DG,X,%,DST
EGP S X=$$HELP^DIALOGZ(+DO(2),.01) D  S X=$G(^DD(+DO(2),.01,12)) D  ;**CCO/NI PLUS NEXT LINE   WRITE HELP MESSAGE FOR .01 FIELD
 .I X]"" F %=$L(X," "):-1:1 I $L($P(X," ",1,%))<70 S DST=$P(X," ",1,%) D DS^DIEQ,P1 Q
 Q
 ;
P1 I %'=$L(X," ") S DST=$P(X," ",%+1,99) D DS^DIEQ
 Q
 ;
H ; Display eXecutable help and long description for .01 field.
 N %,X,DIPGM S %=DIC,X=DZ,DIPGM="DICQ1" D
 . N DIC,D,DP,DIFILEI,DINDEX,DZ S DZ=X
 . S DIC=%,D=.01,DP=+DO(2) D H^DIEQ Q
 Q
 ;
CHKACC ;Check file access
 N A1,DIFILE,DIAC,% S DIFILE=+DO(2),DIAC="LAYGO",%=0 D ^DIAC
 S:% DIACCESS=1 Q
 ;
 ;#8069  You may enter a new |filename|, if you wish
 ;#8068  Choose from
