DIOS ;SFISC/GFT,TKW-BUILD SORT LOGIC ;4SEP2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**6,1003**
 ;
 D INIT S ^UTILITY($J,"DX")=DX,^("F")="^UTILITY($J,0,"_DCC_U_(DPP+1)
 F X=-1:0 S X=$O(DX(X)) Q:X=""  S ^UTILITY($J,"DX",X)=DX(X)
C K DX F DL=1:1:DPP S DX=+DPP(DL),V(DX,2)=DL,X=DP,(DPQ,DJ)=0,Z(DL)="" D A S X=999-$P($G(DPP(DL,"SER")),U,2),Y(DPQ,DX,X,$E($P(DPP(DL),U,2,3),1,30))=DL
 F DL=1:1:DPP D  I D5,DE>0,$D(DE(DL))=1 S DE(DL)=DE(DL)-(DE\D5) S:DE(DL)<4 DE(DL)=4
 .K % S Z=Z(DL)
U .F %=1:1 S D="",Y=$P(Z,",",%) Q:Y=""  D
 ..S %(%)="D"_V(Y) I $D(V(Y,9)) F I=1:1:%-1 S DIOS=$P(Z,",",I),%(I)="$$SUB^DIOS("_DIOS_")"
 ..F I=1:1:% S D=D_","_%(I) I I=1 S D=D_","_DL
 ..S DX(Y,U)=D_"))"
 K DIOS S I=DP G GO
 ;
SUB(F) ;
 N S,L
 S L="",S=-1
 F  S L=$O(J(L)) Q:L=""  I J(L)=F,$D(I(L,0)) S S=I(L,0) Q
 Q S
 ;
A S W=$D(DPP(DL,X)),V(X)=DJ,Z(DL)=Z(DL)_X_"," G ^DIOS1:'W
 I W=1 S Z=X,V=DPP(DL,X),DJ=DJ+1,DPQ=DPQ+1,X=$O(DPP(DL,X)) S:X="" X=-1 S:+V'=V V=Q_V_Q S:$S($D(^DD(X,0,"UP")):^("UP")-Z,1:1) X=DX K J(DJ,X) S:J'<DJ&$D(J(DJ)) J=DJ-1 S J(DJ,X)=DL,V(X,1)=V,V(X,0)=Z,I(Z,X)=DL G A
 S W=-1
O S W=$O(DPP(DL,X,W)) I W="" S X=+V G A
 S V=DPP(DL,X,W),DJ=W#100,V(+V,9,DL)=W,V(+V,8)=U_$P(V,U,2),DPQ=DPQ+1+DJ,I(X,+V)=DL,J=-1,J(DJ,X)=DL G O
 ;
GO K DISETP,DISAVX S X=I,I="" I $D(V(X,2)) S I=" X P("_X_")" I $D(DIBTPGM) S I=" D P"_DICP,DISETP=1
 I V(X) S W="D"_V(X),I="F "_W_"="_W_":0"_I
 S DX(X)=I,DPQ=X
 S DX=X,I=$O(I(X,X)),F=-1 I I="" D  I I="" G DIO1
 . I $D(I)<9 Q:'$D(DIBTPGM)  Q:$D(DISAVX(X))  S %=DX(X),%(1)=X,%(2)="DX" D SETU Q
 . S I=$O(I(X,-1)) Q:I]""
 . S I=$O(I(DP,-1)) I I]"" S DX=DP Q
 . S DX=+$O(I(-1)),I=+$O(I(DX,-1))
 . Q
 S P=I(DX,I) K I(DX,I) G COLON:$D(V(I,9)) D MULPATH
 S F="",(DX,%(0))=I,W="D"_V(I),%=DCC S:$D(DXIX(I)) F=DXIX(I) D:F="" GREF^DIOU(.V,.%,.F)
 S DX(X)=DX(X)_" S "_D2_W_"=$O("_$E(F,1,$L(F)-2)_"0))"_DN_$P(")",U,'$D(DIBTPGM))_D1
 I $D(DIBTPGM) S %=DX(X),%(1)=X,%(2)="DX" D SETU
 G GO
COLON S F=$O(V(I,9,F)) I F="" G GO
 D MULPATH S DX(X)=DX(X)_$E(" S "_D2,1,$S(D2]"":$L(D2)+2,1:0))_DN I '$D(DIBTPGM) S DX(X)=DX(X)_","_F_")"
 S DX(X)=DX(X)_D1
 I $D(DIBTPGM) S %=DX(X),%(1)=X,%(2)="DX" D SETU
 S DN=DPP(F,DX,V(I,9,F)),V=$P(DN,U,4,99)
 I $P(DN,U,3) S V="S DIXX="_I_" "_V
 E  S V=V_" S D0=D(0) " D
 .I '$D(DIBTPGM) S V=V_"X DX("_I_")" Q
 .S V=V_"D DX"_DICDX
 .Q
 S DX(I,F)=V I $D(DIBTPGM) S %=V,%(1)=I_","_F,%(2)="DX" D SETU
 G COLON
 ;
MULPATH S DN=" "_$E("XD",$D(DIBTPGM)+1)_$P(":$T",1,$D(V(X,2)))_" DX" D
 .I $D(DIBTPGM) S DN=DN_DICDX Q
 .S DN=DN_"("_I Q
 S (D1,D2)="" F Z=J+1:1:V(X) S W="D"_Z,D(X)="("_X_","_P_")",%=W_D(X),D2=%_"="_W_","_D2,D1=$S(D1]"":D1_",",1:" S ")_W_"="_%
 F V=0:1 S Y=$S($D(J(V,X)):X,$O(J(V,-1)):$O(J(V,-1)),1:-1) D:$D(D(Y))  Q:V'<V(X)
 . I V<V(X) S DN=" S D"_V_"=D"_V_D(Y)_DN
 . Q:'$D(V(X,9))
 . S:V=0 DN=" N I,DIXX"_DN
 . Q:V<V(X)
 . I $D(V(X,2)) S DN=" S D"_V_"=D"_V_D(Y)_DN
 . Q
 Q
 ;
SETU ;FILE A LINE TO ^TMP FOR LATER INCLUSION IN ROUTINE
 Q:%=""  N A
 I %(2)="DX" S A=$S(DICDX=1:"O",1:"DX"_(DICDX-1)),DISAVX(X)=""
 I %(2)'="DX" S A=%(2)_DICOV,DICOV=DICOV+1
 S %=A_$E(" ",$E(%)'=" ")_%
 S ^TMP("DIBTC",$J,%(1),DICNT)=%,^((DICNT+.001))=" Q"
 S A="DIC"_%(2) S @(A)=@(A)+1,DICNT=DICNT+1
 I %(2)="DX",$D(DISETP) S DICP(X)=DICP,DICP=DICP+1 K DISETP
 Q
 ;
INIT S:'$D(L) L=1 I $G(IO)=IO(0),L'=0,($G(IOST)=""!($G(IOST)?1"C".E)) D WAIT^DICD
 S I=^DD("OS",DISYS,0),J=$P(I,U,7),DIOS=$S(J:J,1:63),J=$P(I,U,3),DE=$S(J:J,$G(^DD("SUB")):^("SUB"),1:255)
 K I,J,Z S J=99,Q="""",DE=DPP*8-DE+23,D5=0
 Q
 ;
DIO1 K %,I,J,P G ^DIO1
