DICN1 ;SFISC/GFT,TKW,SEA/TOAD-PROCESS DIC("DR") ;8MAR2006
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,67,999,1022**
 ;
 K DIDA,DICRS,Y,%RCR
 F Y="DIADD","I","J","X","DO","DC","DA","DE","DG","DIE","DR","DIC","D","D0","D1","D2","D3","D4","D5","D6","DI","DH","DIA","DICR","DK","DIK","DL","DLAYGO","DM","DP","DQ","DU","DW","DIEL","DOV","DIOV","DIEC","DB","DV","DIFLD" S %RCR(Y)=""
 S DZ="W !?3,$S("""_$P(DO,U)_"""'=$P(DQ(DQ),U):"""_$P(DO,U)_""",1:"""")_"" ""_$P(DQ(DQ),U)_"": """
 S Y=DA N % S %=0 D  I '$D(%) D W,BAD Q
 . S DD="" N I,J,X,Y
 . I DINO01 D
 . . S DD=".01//"
 . . S I=$G(DISUBVAL(+DO(2),.01)) I I="" S DD=DD_";" Q
 . . S DD=DD_$S(DIC(0)'["E":"/",1:"")_"^S X=DISUBVAL("_+DO(2)_",.01);" Q
 . K DISUBVAL(+DO(2),.01)
 . F I=0:0 S I=$O(DISUBVAL(+DO(2),I)) Q:'I  D
 . . S DD=DD_I_"//"
 . . I $G(DISUBVAL(+DO(2),I,"INT"))]"" S DD=DD_"//^S X=DISUBVAL("_+DO(2)_","_I_",""INT"");" Q
 . . S:DIC(0)'["E" DD=DD_"/"
 . . S DD=DD_"^S X=DISUBVAL("_+DO(2)_","_I_");" Q
 . S DD=DD_$G(DIC("DR")) I DD]"",$E(DD,$L(DD))'=";" S DD=DD_";"
 . Q:DIC(0)'["E"
 . F I=0:0 S I=$O(^DD("KEY","B",+DO(2),I)) Q:'I!('$D(%))  F J=0:0 S J=$O(^DD("KEY",I,2,J)) Q:'J!('$D(%))  D
 . . S X=$G(^DD("KEY",I,2,J,0)) Q:$P(X,U,2)'=+DO(2)
 . . S Y=$P(X,U) Q:'Y  D CKID
 . . Q
 . Q:$D(DIC("DR"))!('$D(%))
 . S Y=0 F  S Y=$O(^DD(+DO(2),0,"ID",Y)) Q:'Y  D CKID Q:'$D(%)
 . Q
 I DD]"",$O(^DD("KEY","B",+DO(2),0)) D
 . N I S I=$S(DIC(0)["E":"M",1:"")
 . S DD=DD_"S DIEFIRE="""_I_"""" Q
 S %RCR="RCR^DICN1" D STORLIST^%RCR
 I $D(Y)<9 S Y=DA Q
 ;
BAD S:$D(D)#2 DA=D K Y I '$D(DO(1)) S Y=-1 D Q^DIC2 Q
 K DO D A^DIC S DS(0)="1^",Y=-1 Q
 ;
CKID I $G(DUZ(0))'="@",$G(^DD(+DO(2),Y,9))]"" D  Q:'$D(%)  Q:$L(^DD(+DO(2),Y,9))<%
 . F %=1:1 I DUZ(0)[$E(^DD(+DO(2),Y,9),%) Q:$L(^(9))'<%  K:$P(^(0),U,2)["R" % Q
 Q:Y=.01
 I $P(DD,"//")=Y!(DD[(";"_Y_"//"))!(DD[(";"_Y_";")) Q
 S DD=DD_Y_";"
Q Q
 ;
W S A1="T",DST="SORRY!  A VALUE FOR '"_$P(^(0),U,1)_"' MUST BE ENTERED," W:'$D(DDS) ! D H
 S A1="T",DST="BUT YOU DON'T HAVE 'WRITE ACCESS' FOR THIS FIELD" W:'$D(DDS) !,?6 D H D:$D(DDS) LIST^DDSU
 S %RCR="D^DICN1" D STORLIST^%RCR Q
 ;
H I $D(DDS) S DDH=$S($D(DDH):DDH+1,1:1),DDH(DDH,A1)=DST K A1,DST Q
 W:'$D(ZTQUEUED) DST K A1,DST Q
RCR ;
 K DR,DIADD,DQ,DG,DE,DO N DISAV0 S DIE=DIC,DR=DD,DIE("W")=DZ,DISAV0=DIC(0) K DIC
 I $D(DIE("NO^")) S %RCR("DIE(""NO^"")")=DIE("NO^")
 S DIE("NO^")="BACKOUTOK" N X
 D:$D(DDS) CLRMSG^DDS D:DR]""  K DIE("W"),DIE("NO^")
 . N DISAV0,DIFILEI,DINDEX,DIVAL,DIENS,DIOPER
 . S DIOPER="A" K % M %=DISUBVAL N DISUBVAL M DISUBVAL=% K %
 . D ^DIE Q
 D:$D(DDS)
 . I $Y<IOSL D CLRMSG^DDS Q
 . D REFRESH^DDSUTL
A I '$D(DA) S Y(0)=0 Q
 I '$$IHSGL($G(DIFILEI)) S:'$$INTEG^DIKK(DIE,DA_DIENS,"","","d") Y(0)=0,X="BADKEY" ;IHS
 Q:$D(Y)<9&'$D(DTOUT)&'$D(DIC("W"))&($G(X)'="BADKEY")
 I $G(X)="BADKEY",DISAV0["E" W !,"      ",$$EZBLD^DIALOG(741)
 S:'$G(DTOUT)&($D(Y)'<9) DUOUT=1
ZAP S DIK=DIE
 I DISAV0["E" S A1="T",DST=$C(7)_"   <'"_$P(@(DIK_"DA,0)"),U,1)_"' DELETED>" W:'$D(DDS)&'$D(ZTQUEUED) !?3 D H D:$D(DDS)&'$D(ZTQUEUED) LIST^DDSU
 D ^DIK S Y(0)=0 K DST Q
 ;
D N DISAV0 S DISAV0=DIC(0),DIE=DIC D ZAP Q
 ;
ASKP001 ; ask user to confirm new record's .001 field value
 ; NEW^DICN
 ;
 ; quit if there's no .001 or we can't ask
 ;
 I DIC(0)'["E" S Y=1 Q
 S Y=$P(DO,U,2)
 I '$D(^DD(+Y,.001,0)) S Y=1 Q
 ;
 ; if this is not a LAYGO lookup in which X looks like an IEN, and we're
 ; adding a new file, and we haven't tried this before, then offer a new
 ; .001 based on the user's or site's file range, whichever's handy.
 ; NEW^DICN will increment this .001 forward to find the first gap, then
 ; drop back through here to the paragraph below (because DO(3) will be
 ; defined next time) to offer it to the user
 ;
 I '$D(DIENTRY),DIC="^DIC(",'$D(DO(3)) D  S Y="TRY NEXT" Q
 . S DO(3)=1
 . I $S($D(^VA(200,DUZ,1))#2:1,1:$D(^DIC(3,DUZ,1))#2),$P(^(1),U) D  Q
 . . S DIY=.1,X=+$P(^(1),U) ; NAKED
 . I $D(^DD("SITE",1)),X\1000'=^(1) S X=^(1)*1000,%=0
 ;
 ; set up our prompt, if .001 looks valid use it as a default, otherwise
 ; count forward until we find a valid one to offer
 ;
 S DST="   "_$P(DO,U)_" "_$P(^DD(+Y,.001,0),U)_": "
 S %=$P(^DD(+Y,.001,0),U,2),X=$S(%'["N"!(%["O"):0,1:X),%Y=X
 I X F %=1:1 D N Q:$D(X)  S X=0 Q:%>999  S X=%Y+DIY,%Y=X
 I X S DST=DST_X_"// "
 ;
 ; prompt user for .001
 ;
 I '$D(DDS) D
 . W !,DST K DST R Y:$S($D(DTIME):DTIME,1:300) E  S DTOUT=1,Y=U W $C(7)
 E  D
 . S A1="Q",DST=3_U_DST N DIY D H,LIST^DDSU S Y=$S($D(DTOUT):U,1:%) K %
 ;
 ; sort through possible responses
 ;
 I Y[U S Y=U Q
 I Y="" S Y=1 Q
 I Y'="?" D  Q:Y
 . S X=Y D N S Y=$D(X)#2 D:Y  Q:Y
 . . I $D(@(DIC_X_")")) K X S Y=0
 . . Q
 . W $C(7)
 . W:'$D(DDS) "??"
 ;
 ; for bad response or help request, offer help and try new IEN
 ;
EGP S DST=$$HELP^DIALOGZ(+DO(2),.001) I $D(^DD(+DO(2),.001,0)),DST]"" S DST="     "_DST ;**CCO/NI HELP MESSAGE FOR .001 FIELD WHEN USER IS LAYGO-ING (NOTE NAKED REFERENCES IN FOLLOWING LINES)
 I '$D(DDS) D
 . W:DST]"" !?5,DST X:$D(^(4)) ^(4) K DST ; NAKED
 E  D
 . S A1=0 N DIY D H S:$D(^(4)) DDH("ID")=^(4) D LIST^DDSU ; NAKED
 S X=$P(DO,U,3) D INCR^DICN0
 S Y="TRY NEXT"
 Q
 ;
IHSGL(X) ;----- CHECK GL NODE OF TOP LEVEL FILE FOR DUZ(2)
 ;USED TO ALLOW USE OF "SOFT" GLOBAL REFERENCES, I.E., DUZ(2)
 ;
 ;      RETURNS:
 ;      0 IF THE TOP LEVEL FILE "GL" NODE DOES NOT CONTAIN DUZ(2)
 ;      1 IF IT DOES
 ;
 ;      INPUT:
 ;      X  =  FILE NUMBER
 ;
 N DITOP,Y
 S Y=0
 I X D
 . S DITOP=X
 . F  Q:'$D(^DD(DITOP,0,"UP"))  S DITOP=^("UP")
 . S Y=$G(^DIC(DITOP,0,"GL"))["DUZ(2)"
 Q Y
 ;
N ; test X as an IEN (apply input transform and numeric restrictions)
 ; USR^DICN, ASKP001
 ;
 I $D(^DD(+$P(DO,U,2),.001,0)),'$D(DINUM) X $P(^(0),U,5,99)
 I $D(X),$L(X)<15,+X=X,X>0,X>1!(DIC'="^DIC(") Q
 K X
 Q
 ;
 ; 741   Either key values are null, or creates a duplicate key.
 ;
