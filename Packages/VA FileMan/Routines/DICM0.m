DICM0 ;SF/XAK,TKW - LOOKUP WHEN INPUT MUST BE TRANSFORMED ;2/15/00  14:40
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**16,4,20,31**
 ;
P ;Pointers, called by ^DICM1
 S D="" N DICODE,DIASKOK,DIPTRIX
 S DICR(DICR,1)=DIC,DIC=U_$P(DS,U,3),Y=DIC(0),DIC(0)=$TR(Y,"L","")
 S DICR(DICR,2)=$S($$OKTOADD(.DIFILEI,.DINDEX,.DIFINDER):Y,1:DIC(0))
 S DICR(DICR,2.1)=$S($P(DS,U,2)["'":DIC(0),1:Y)
 N:'$D(DIVPSEL) DIVPSEL S DIVPSEL(DICR)=0
 I DIC(0)["B" S DIC(0)=$TR(DIC(0),"M",""),DICR(DICR,2.1)=$TR(DICR(DICR,2.1),"M","")
 S DIC(0)=$TR(DIC(0),"NV","")
 F Y="DR","S","P","W" I $D(DIC(Y)) M DICR(DICR,Y)=DIC(Y) K DIC(Y)
 S DIPTRIX=$G(DIC("PTRIX",DIFILEI,+DINDEX(1,"FIELD"),+$P($P(DS,U,2),"P",2)))
AST ; Process screens on pointers.
 I $P(DS,U,2)["*",DICR(DICR,2)["L" N DID,DF D
 . F DICODE=" D ^DIC"," D IX^DIC"," D MIX^DIC1" D
 . . S Y=$F(DS,DICODE) Q:'Y
 . . N I S I=$P($E(DS,1,Y-$L(DICODE)-1),U,5,99)
 . . D SETSCR(I,.DICR,.DIC,.D,DICODE,.DID,.DF,+$P($P(DS,U,2),"P",2)) Q
 . Q
P1 ; Build screen to make sure selected entry is pointed-to.
 S Y="("_DICR(DICR,1) G L1:'$D(DO) K DO I @("$O"_Y_"0))'>0") G L1
 S I="DIC"_DICR,DICODE="X ""I 0"" N "_I D
 . I DINDEX("#")=1,$D(DICR(DICR,"S")) S DICODE=DICODE_",%Y"_DICR
 . S DICODE=DICODE_" F "_I_"=0:0 S "_I_"=$O"_Y,%=""""_%_""""
 D  G:DICODE="" L1
 . I $G(DINDEX("#"))>1 D BLDC(Y,%,DINDEX("#"),DIFILEI,"",.DICODE,.DICR) Q
 . I @("$O"_Y_%_",0))>0") S DICODE=DICODE_%_",Y,"_I_")) Q:"_I_"'>0  I $D"_Y_I_",0))"_$$CHKTMP(.DIC,DICR,DIFILEI,I) Q
 . I DS["DINUM=X" S DICODE="I $D"_Y_"Y,0))"_$$CHKTMP(.DIC,DICR,DIFILEI,"Y")_" S "_I_"=Y" Q
 . I $P(DS,U,4)="0;1" S DICODE=DICODE_I_")) Q:"_I_"'>0  I $P(^("_I_",0),U)=Y"_$$CHKTMP(.DIC,DICR,DIFILEI,I) Q
 . S DICODE="" Q
 I DINDEX("#")=1,$D(DICR(DICR,"S")) S DICODE=DICODE_" S %Y"_DICR_"=Y,Y="_I_" X DICR("_DICR_",""S"") S Y=%Y"_DICR_" I "
 S DIC("S")=DICODE_" Q"
 ; If user passed list of indexes for lookup on pointed-to file, set-up.
 I DIPTRIX]"" S D=DIPTRIX D SETIX(.D,.DIC,.DID,.DF,.DICR,+$P($P(DS,U,2),"P",2))
 S:$G(D)="" D="B" S Y=0
 N DS,DINDEX,DIFILEI D X^DIC
L1 K DIC("S"),@("DIC"_DICR)
 I Y'>0 I $G(DTOUT)!($G(DIROUT)) G R
 I Y'>0,'$D(DICR(DICR,8)) D  G RETRY
 . I $G(DICR(DICR,31.2)) S DIC("S")="I Y-"_DICR(DICR,31.2)
 . Q:'$D(DICR(DICR,31))
 . S DIC("S")=$S($D(DIC("S")):DIC("S")_" ",1:"")_DICR(DICR,31) Q
 I DICR(DICR,2)["L",DICR(DICR,2)["E",@("$P("_DIC_"0),U,2)'[""O"""),$P(@(DICR(DICR,1)_"0)"),U,2)'["O",'DIVPSEL(DICR) D  G:%-1 L2
 . N I F I=(DICR-1):-1 Q:'$D(DIVPSEL(I))  S DIVPSEL(I)=1
 . S DST="         ...OK",%=1 D Y^DICN W:'$D(DDS) ! Q
R K DICS,DICW,DO,DIC("W"),DIC("S")
 S DIC=DICR(DICR,1),%=DICR(DICR,2),DIC(0)=$P(%,"M")_$P(%,"M",2)
 F X="DR","S","P","W" I $D(DICR(DICR,X)) M DIC(X)=DICR(DICR,X)
 I $D(DIC("P")),+DIC("P")=.12 S DIC(0)=DIC(0)_"X"
 D DO^DIC1 S X=+Y K:X'>0 X Q
 ;
L2 G NO:%-2 S DIC("S")="I Y-"_+Y_$S($D(DICR(DICR,31)):" "_DICR(DICR,31),1:""),X=DICR(DICR) W:'$D(DDS) "     "_X I $D(DDS),$G(DDH) D LIST^DDSU
 K DST ;
RETRY D DO^DIC1 K DICR(U,+DO(2))
 S D=$G(DICR(DICR,2.2)) S:D]"" DF=D S:D="" D="B"
 S DIC(0)=DICR(DICR,2.1) S:"^"[X X=DICR(DICR)
 I $D(DIFILEI) N DS,DINDEX,DIFILEI
 I $D(DICR(DICR,31)),$G(DA(1)),'$G(DA) M DS=DA N DA M DA=DS S DA=DA(1) K DS
 I $D(DICR(DICR,31.1)) S DID=DICR(DICR,31.1),DID(1)=2,DF=D
 D X^DIC K DICR(DICR,6)
 G R
 ;
BLDC(DIGBL,DIXNAM,DIXNO,DIFILEI,DIPGBL,DICODE,DICR) ; Build screening logic to loop through compound index, making sure pointed-to file is pointed-to by entry in index
 N %,I,C,X,Y,DISB S Y="Y"
 I $G(DIPGBL)]"" S Y="(+Y_"";"_$E(DIPGBL,2,99)_""")"
 S %=DIGBL_DIXNAM_","_Y
 S DICODE="N DICROUT,DIC"_DICR D
 . I $D(DICR(DICR,"S")) S DICODE=DICODE_",%Y"_DICR
 . S DICODE=DICODE_" X ""I 0"" I $D"_%_")) S DICROUT=0 X DICR("_DICR_",""SUB"",2)" Q
 F I=2:1:DIXNO S C="N DISB"_I_" S DISB"_I_"="""" " D
 . S C=C_"F  S DISB"_I_"=$O"_%_",DISB"_I_")) Q:DISB"_I_"=""""  X DICR("_DICR_",""SUB"","_(I+1)_") Q:DICROUT"
 . S DICR(DICR,"SUB",I)=C
 . S %=%_",DISB"_I Q
 S I="DIC"_DICR
 S X="S "_I_"=0 F  S "_I_"=$O"_%_","_I_")) Q:'"_I_"  I $D"_DIGBL_I_",0))"_$$CHKTMP(.DIC,DICR,DIFILEI,I)
 I $D(DICR(DICR,"S")) S X=X_" S %Y"_DICR_"=Y,Y="_I_" X DICR("_DICR_",""S"") S Y=%Y"_DICR_" I"
 S DICR(DICR,"SUB",DIXNO+1)=X_"  S DICROUT=1 Q"
 Q
 ;
CHKTMP(DIC,DICR,DIFILEI,DIVAR) ; If DIC(0)["T", add check to make sure entry hasn't already been presented once before.
 I DIC(0)'["T"!(DICR'=1) Q ""
 Q ",'$D(^TMP($J,""DICSEEN"","_DIFILEI_","_DIVAR_"))"
 ;
SETSCR(DICODE,DICR,DIC,D,DICALL,DID,DF,DIFILEI) ; Execute screening logic for screened pointers and var.ptrs.
 N DISAV0 S DISAV0=DIC(0) D  S DIC(0)=DISAV0
 . N DISAV0 X DICODE Q
 S:DIC(0)["B" D="B"
 I $D(DIC("S")) S DICR(DICR,31)=DIC("S")
 Q:$G(D)=""
 I $P(D,U,2)="",DICALL["IX^DIC",DIC(0)["M" D SETIX(.D,.DIC,.DID,.DF,.DICR,DIFILEI) Q
 I $P(D,U,2)]"",DICALL["MIX^DIC1" D SETIX(.D,.DIC,.DID,.DF,.DICR,DIFILEI) Q
 S DICR(DICR,2.2)=D
 Q
 ;
SETIX(D,DIC,DID,DF,DICR,DIFILEI) ; If user passes list of indexes to use on pointed-to file, set up to use them.
 I '$G(DICR) N DICR S DICR=0
 I DICR D
 . N % S %=DICR(DICR,2.1)
 . I %["L",(U_D_U)'["^B^" N D S D=I_"^B"
 . I $P(D,U,2)="" D
 . . I %["M" S DICR(DICR,2.1)=$TR(%,"M")
 . . K DICR(DICR,31.1) Q
 . I $P(D,U,2)]"" D
 . . I %'["M" S DICR(DICR,2.1)=%_"M"
 . . S DICR(DICR,31.1)=D_"^-1" Q
 . S DICR(DICR,2.2)=$P(D,U) Q
 I DIC(0)["L",(U_D_U)'["^B^" S D=D_"^B"
 I $P(D,U,2)="" D
 . I DIC(0)["M" S DIC(0)=$TR(DIC(0),"M")
 . S (D,DF)=$P(D,U) K DID Q
 I $P(D,U,2)]"" D
 . S DID=D_"^-1",DID(1)=2,(D,DF)=$P(D,U)
 . S:DIC(0)'["M" DIC(0)=DIC(0)_"M" Q
 Q
 ;
NO S Y=-1 G R
 ;
OKTOADD(DIFILEI,DINDEX,DIFINDER) ; Return 1 if index is OK for LAYGO.
 Q:$G(DINDEX(1,"TRANCODE"))]"" 0
 Q:$G(DIFINDER)="p" 1
 Q:DINDEX="B" 1
 Q:DINDEX("#")=1 0
 Q:$D(DICR("^",DIFILEI,.01,"B")) 0
 Q:DINDEX(1,"FILE")'=DIFILEI 0
 Q:DINDEX(1,"FIELD")'=.01 0
 Q 1
 ;
