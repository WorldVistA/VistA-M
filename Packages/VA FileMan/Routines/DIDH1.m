DIDH1 ; SFISC/ALL - HDR FOR DD LISTS; 16NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**76,105,999,1003,1020,1024,1025**
 ;
 N DIDHI,DIDHJ,DIC,W,M1 D
 .N I,J D IJ^DIUTL(DFF) M DIDHJ=J,DIDHI=I S DIDHJ=$O(J(""),-1)
 S M=1 I DC=1 S (F(1),DA)=DFF,Z=1
 E  I $Y,IOST?1"C".E W $C(7) R M:DTIME I M=U!'$T K DIOEND S M=U,DN=0 Q
 S M1=$S($G(^DD(F(1),0,"VR"))]"":" (VERSION "_$P(^("VR"),U)_")   ",1:"") I IOST?1"C".E S DIFF=1
 W:$D(DIFF)&($Y) @IOF S DIFF=1 W $S(DHIT["DIDX":"BRIEF",DHIT["DIDG":"GLOBAL MAP",$D(DINM):"MODIFIED",1:"STANDARD")
 W " DATA DICTIONARY #"_DFF_" -- "_$O(^DD(DFF,0,"NM",0))_" "_$S(DIDHJ:"SUB-",1:"")_"FILE   "
 S DIC=^DIC(DUB,0,"GL") D
 .N X,Y
TODAY .S W=$$OUT^DIALOGU(DT,"FMTE","2D")_"    "_$$EZBLD^DIALOG(7095,DC) W ?(IOM-$L(W)-1),W ;**CCO/NI  TODAY'S DATE, 'PAGE'
 S M=IOM\2,S=" ",W="" I $D(^DD("SITE")) S W="SITE: "_^("SITE")_"   "
 I $D(^%ZOSF("UCI"))#2 X ^("UCI") S W=W_"UCI: "_Y
 W ! I DHIT["DIDX" W W,?(IOM-$L(M1)-1),M1 S W="",$P(W,"-",IOM)="" W !,W S W="" G Q^DIDH
 W "STORED IN ",DIC F I=1:1 Q:'$D(DIDHI(I))  W "D",I-1,",",DIDHI(I),","
 I 'DIDHJ D
 .I $O(@(DIC_"0)"))'>0 W "  *** NO DATA STORED YET ***" Q
 .S I=$P(^(0),U,4) W:I "  ("_I_" ENTR"_$S(I=1:"Y)",1:"IES)")
 W "   ",W,?(IOM-$L(M1)-1),M1 D:DHIT'["DIDG"
 .W !!,"DATA",?14,"NAME",?36,"GLOBAL",?50,"DATA",!,"ELEMENT",?14,"TITLE",?36,"LOCATION",?50,"TYPE"
G W ! F I=1:1:IOM-1 W "-"
 S W="" Q:DC>1!$G(DIDRANGE)
FIRST F DG=0:0 S DG=$O(^DIC(DA,"ALANG",DG)) Q:'DG  I $D(^(DG,0)) S DIWR=$P(^(0),U) I $D(^DI(.85,DG,0)) W !,$P(^(0),U)," FILE NAME: ",DIWR ;**SHOW FOREIGN FILE NAMES
PAGE1 I 'DIDHJ,'$$WP^DIUTL($NA(^DIC(DA,"%D"))) S M="^" Q
 I DIDHJ D  I M=U Q
 .S W=DIDHJ(DIDHJ-1),W=$NA(^DD(W,+$O(^DD(W,"SB",DFF,"")))) I '$$WP^DIUTL($NA(@W@(21))) S M=U Q
 .I $D(@W@(23)) W !,"TECHNICAL DESCRIPTION:",! I '$$WP^DIUTL($NA(@W@(23))) S M=U
 .F I=8,9 I $D(@W@(I)) W !,?15,$P("READ^WRITE",U,I-7)," ACCESS: ",^(I)
 I DHIT["DIDG" D  Q
 . D XR^DIDH Q:M=U
 . N DIDPG S DIDPG("H")="W """" D H^DIDH S:M=U PAGE(U)=1"
 . D LIST^DIKCP(DA,"","C15",.DIDPG) Q:M=U
 . D WRLN^DIKCP1("",0,.DIDPG)
 Q:DHIT["DIDX"!(M=U)  W !
 F %=1:1:4 S X=$P("SCR^DIC^ACT^DIK",U,%) I $G(^DD(DA,0,X))]"" W !,$P("FILE SCREEN (SCR-node) ^SPECIAL LOOKUP ROUTINE ^POST-SELECTION ACTION  ^COMPILED CROSS-REFERENCE ROUTINE",U,%)_": " S W=^(X) D W^DIDH G Q:M=U
 W:$P($G(^DD(DA,0,"DI")),U)["Y" !,"THIS IS AN ARCHIVE FILE."
 W:$P($G(^DD(DA,0,"DI")),U,2)["Y" !,"EDITING OF FILE IS NOT ALLOWED."
 F N="DD","RD","WR","DEL","LAYGO","AUDIT" I $D(^DIC(DA,0,N)) W !?(Z+Z+14-$L(N)),N," ACCESS: ",^(N)
AFOF I $D(^VA(200,"AFOF",DA)) W !!?8,"(NOTE: Kernel's File Access Security applies to this File.)",!
 I $O(^DD(DA,0,"ID",""))]"" W !,"IDENTIFIED BY: "
 S X=0 F  S X=$O(^DD(DA,0,"ID",X)) Q:X=""  Q:'$D(^DD(DA,X,0))  S I1=$P(^(0),U)_" (#"_X_")"_$S($P(^(0),U,2)["R":"[R]",1:"") W:($L(I1)+$X)+1>IOM ! W ?15,I1 I $O(^DD(DA,0,"ID",X)) W ", "
 S:X="" X=-1
 ;
 ;Print "WRITE" identifiers
 I '$D(DINM) S X=" " F  S X=$O(^DD(DA,0,"ID",X)) Q:X=""  D  Q:M=U
 . N DIDLN,DIDPG
 . S DIDLN(1)=$G(^DD(DA,0,"ID",X)) Q:DIDLN(1)?."^"
 . S DIDLN(0)=""""_X_""": "
 . S DIDLN(0)=$J("",15-$L(DIDLN(0)))_DIDLN(0)
 . S DIDPG("H")="W """" D H^DIDH S:M=U PAGE(U)=1"
 . D WRPHI^DIKCP1(.DIDLN,IOM-16,0,15,1,.DIDPG)
 Q:M=U
 ;
 I $D(^DD("KEY","B",DA)) D
 . N DIDPG
 . S DIDPG("H")="W """" D H^DIDH S:M=U PAGE(U)=1"
 . D PRINT^DIKKP(DA,"","C20",.DIDPG)
 D POINT^DIDH Q:M=U  D TRIG^DIDH,XR^DIDH Q:M=U
 I $D(^DD("IX","B",DA)) D  Q:M=U  W !
 . N DIDPG
 . S DIDPG("H")="W """" D H^DIDH S:M=U PAGE(U)=1"
 . D LIST^DIKCP(DA,"","C15",.DIDPG)
CREATED W !! S N=$G(^DIC(DA,"%A")),Y=$P(N,U,2) I Y X ^DD("DD") W ?3,"CREATED ON: "_Y I $S($D(^VA(200,0)):1,1:$D(^DIC(3,0))),^(0)["NEW PERSON"!(^(0)["USER")!(^(0)["EMPLOY"),$D(^(+N,0)) W " by "_$P(^(0),U)
 S Y=+$G(^DIC(DA,"%MSC")) I Y X ^DD("DD") W "    LAST MODIFIED: "_Y
Q Q
W W:$X+$L(W)+3>IOM !,?$S(IOM-$L(W)-5<M:IOM-5-$L(W),1:M),S S %Y=$E(W,IOM-$X,999) W $E(W,1,IOM-$X-1),S Q:%Y=""  S W=%Y G W
 Q
WR ;
 S W="TRIGGERED by the "_$P(^(0),U)_" field"
UP1 S W=W_" of the "_$O(^DD(%,0,"NM",0))
 I $D(^DD(%,0,"UP")) S %=^("UP") S W=W_" sub-field" G UP1
 S W=W_" File"
W1 S DDV1="" W ?DDL2 F K=1:1 S DDV=$P(W," ",K)_" ",DDV1=DDV1_DDV W:$L(DDV)+$X>IOM !?DDL2 W DDV Q:$L(DDV1)>$L(W)
 I $Y+6>IOSL S DC=DC+1 D DIDH1
 K DDV,DDV1 Q
DE ;
 W !?DDL1,$P("DESCRIPTION:^TECHNICAL DESCR:",U,%Y=23+1)
 I '$$WP^DIUTL($NA(^DD(F(Z),DJ(Z),%Y)),DDL2+1) S M="^"
 Q
