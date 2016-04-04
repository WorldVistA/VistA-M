DICQ ;SFISC/XAK,TKW-HELP FOR LOOKUPS ;26DEC2005
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,3,57,999,1003,1022**
 ;
 S DZ=X D:DIC(0)]"" DQ
 I '$D(DDS),$G(DDH) D ^DDSU
 S:$D(DZ) X=DZ K DZ,DDH,DIZ,DDD I $D(DTOUT) S Y=-1 D Q^DIC2 Q
 D A^DIC Q
 ;
DQ ; Main entry point for displaying online ^DIC help (list of current
 ; entries in a file.
 N %,%Y,X,Y,DD,DDC,DDD,DS,DID01,DICNT,DIDONE,DIFROM,DIPART,DIW,DIX,DIY,DIZ,DIUPRITE,DST,DIBEGSUB,DIBEGIX
 I $D(DZ)[0 N DZ S DZ=""
 S DDC=$S($D(DDS):7,1:$G(IOSL,24)-9) ;USE SCREEN LENGTH
 N:'$D(DDH) DDH S DDH=+$G(DDH)
 S DIBEGIX=D
 I $D(DIRECUR)[0 N DIRECUR S DIRECUR=0
 I '$D(DO(2)) N DO D GETFA^DIC1(.DIC,.DO)
 I DO="0^-1" K DO S DST="  Pointed-to File does not exist!" D % Q
 S DICNT=$P(DO,U,4),DIY=DO D DIY
NUMEGP S X=$S($D(^DD(+DO(2),.001,0)):$$LABEL^DIALOGZ(+DO(2),.001),DIC(0)["N":$$EZBLD^DIALOG(7099),1:""),DIUPRITE=X]"" ;**CCO/NI "NUMBER"
 S DIW=^DD(+DO(2),.01,0),DIW=$P(DIW,U,2,3)
 G:$D(^DD(+DO(2),0,"QUES")) @^("QUES")
 I DIUPRITE S DS=.001 D DS
DQ1 I $G(DIFILEI),$G(DINDEX)]"" M DIX=DINDEX
 E  N DIFILEI,DIENS K % M %=DA N DA M DA=% K % D
 . D GETFILE^DIC0(.DIC,.DIFILEI,.DIENS)
 . S DIX=$G(D),DIX("WAY")=1 D INDEX^DICUIX(.DIFILEI,"hl",.DIX)
 . Q
 S DIBEGSUB=DIX("#")
 I DIFILEI="" D % Q
 I $D(DIC("?N",DIFILEI)) S DDC=DIC("?N",DIFILEI)
 S DIFROM=""
 N DISAVIX M DISAVIX=DIX
 D IX K DISAVIX
 I 'DICNT D 0 Q
 S DIDONE=0 I DZ'="??" D  I DIDONE D 0 Q
 . D DSPFLD Q:DICNT<11
 . N DIOUT S DIOUT=0 F  D ASKCUR Q:DIOUT
 . Q
 D EN^DICQ1
 Q
 ;
IX N DD,DIF,DIFIL,DIFLD,DIFORCE,DIEND,DITMP,I,P,F,X,%
 S (DD,%)="",DID01=0,DIF="h"_$P("M^",U,DIC(0)["M")
 S DIFORCE=$S($D(DID):1,1:0),DIFORCE(0)=$S($D(DID):DID,1:"*"),DIFORCE(1)=1
 F  D  Q:DIX=""!(DIC(0)'["M")
 . S DIEND=$S(DIX=DIBEGIX:DIX("#"),1:1)
 . S (P,DS)="" F I=1:1:DIEND D
 . . S DIFIL=$G(DIX(I,"FILE")),DIFLD=$G(DIX(I,"FIELD"))
 . . I DIFIL,DIFLD Q:$D(DITMP(DIFIL,DIFLD))  S DITMP(DIFIL,DIFLD)=""
 . . I DIX=DIBEGIX D
 . . . I DIFIL=DIFILEI,DIFLD=.01,DIX("FLISTD")[("^"_.01_"^") S DID01=1
 . . . S DS=.002 Q
 . . E  S X=DIFLD S:DIFILEI'=DIFIL X=DIFIL_" "_DIFLD S:DS]"" DS=DS_"^" S DS=DS_X
 . . S X=$G(DIX(I,"PROMPT"))
FIELDNM . . I $D(^DD(+DIFIL,+DIFLD,0))#2 S X=$$LABEL^DIALOGZ(+DIFIL,+DIFLD) ;**CCO/NI  NAME OF LOOKUP FIELD
 . . I I=1 S %=DIX(1,"TYPE")
 . . Q:X=""  I DIX("#")=1,X=$G(DS(.002)) Q
 . . I $L(X)+$L(P)'>70 S P=P_$P(" & ^",U,P]"")_X Q
 . . S:P'["..." P=P_"..." Q
 . I P]"",DS]"" S X=P D DS
 . I @("$D("_DIC_"DIX))>9!$D(DF)"),DD="" S DD=DIX,DIW=% S:'DICNT DICNT=2 S:'$D(^(DD)) DICNT=0,DIUPRITE=0
 . I DIC(0)'["M" S DIX="" Q
 . D NXTINDX^DICF2(.DIX,.DIFORCE,.DIFILEI,DIF,"","*") Q:DIX=""
 . D INDEX^DICUIX(.DIFILEI,"hql",.DIX) Q
 K DIX
 I DIBEGIX=DD M DIX=DISAVIX
 E  S (DIBEGIX,DIX)=DD I DIX]"" S DIX("WAY")=1 D INDEX^DICUIX(.DIFILEI,"hl",.DIX)
 I DD="" S DIUPRITE=1 I $O(^DD(DIFILEI,0,"IX","AZ"))]""!($O(^DD("IX","BB",DIFILEI,"AZ"))]"") S DICNT=0
 S:DZ["BAD" DICNT=0
 Q
 ;
DSPFLD ; Display list of lookup fields
 N X S DST=$$EZBLD^DIALOG(8063,$P(DO,U)),DS=0
 F X=1:1 S DS=$O(DS(DS)) Q:DS=""  D
 . S:X>1!$G(DS(0)) DST=DST_$$EZBLD^DIALOG(8067)
 . D:$L(DST)+$L(DS(DS))>70 N S DST=DST_" "_DS(DS) Q
 K DS S DST=DST_$E(":",DICNT) D %
 Q
 ;
ASKCUR ; Ask if user wants to see existing entries
 N A1 S DDH=DDH+1,A1=0_U_$$EZBLD^DIALOG(8064)
 I DO(2)'["s",'$D(DIC("S")),'$D(DIC("V")),'$D(DF),'$D(DIC("?PARAM",DIFILEI)) S A1=A1_$$EZBLD^DIALOG(8065,DICNT)
 S DDH(DDH,"Q")=A1_$$EZBLD^DIALOG(8066,$P(DO,U))
 S:$D(DDS) DDD=1 D ^DDSU
 I '$D(DDS),$D(DTOUT) S (DIOUT,DIDONE)=1 Q
 I $D(DDS) S %=1 I $D(DDSQ) S (DIOUT,DIDONE)=1 Q
 ; Process answer to question about seeing existing entries.
 S A1="T",DDH=+$G(DDH)
 S:%=1 %Y=1
 I %Y'="??" D
 . N F S F=$E(%Y,2,99) I $E(%Y)="^",F]"" S DIFROM=F
 . S %Y=F Q
 S:%=2&(DIC(0)["L") DZ=""
 I (%#2)=0!(%<0&(%Y="")) S (DIOUT,DIDONE)=1 Q
 I DIFROM="" S DIOUT=1 Q
 S DIUPRITE=$S(+$P(DIFROM,"E")=DIFROM:1,DIBEGIX]"":0,1:DIUPRITE)
 I +$P(DIFROM,"E")=DIFROM S DIOUT=1 Q
 Q:DIBEGIX=""  I $P(DIW,U,1)'["D" S DIOUT=1 Q
 N %DT,Y S X=DIFROM,%DT="T" D ^%DT S DIFROM=Y,DIUPRITE=0
 I DIFROM<0 S DST=$C(7) D % Q
 S DIOUT=1 Q
 ;
DSPHLP(DIC,DIFILE,DINDEX,DZ,DINOKILL) ; Display online help for lookups (^DIC)
 N D S D=DINDEX
 I $D(DIBTDH) K DIBTDH Q
 S:$D(DDSXEC) DIBTDH=1 ; Set only if there is eXecutable Help to prevent repeated '??' display from AST^DIEQ
 I DIC(0)]"" D DQ Q:$G(DINOKILL)
 I '$D(DDS),$G(DDH) D ^DDSU
 I $D(DTOUT) S Y=-1 D Q^DIC2 Q
 D A^DIC Q
 ;
N D % S DST="    " Q
 ;
% ;CALLED FROM ^DICQ1
 S DDH=$G(DDH)+1,DDH(DDH,"T")=DST K DST Q
 ;
0 Q:$D(DTOUT)!(DIC(0)'["L")  K DIW,DIUPRITE S:$D(DDS) DDD=1 D 0^DICQ1 Q
 ;
DIY S DIY=$P(^DD(+$P(DIY,U,2),.01,0),"$L(X)>",2),DIY=$S(DIY:DIY,1:30)+7 Q
 ;
SOUNDEX G DQ1
 ;
DS S:DO'[X DS(DS)=X I DO[X,$G(DZ)'["??" S DS(0)=1
 Q
 ;
 ;
 ;
 ;#8063  Answer with |Filename|
 ;#8064  Do you want the entire
 ;#8065  |Number of entries| Entry
 ;#8066  |Filename| List
 ;#8067  , or
 ;#8068  Choose from ; couldn't find a reference SO 8/11/00
