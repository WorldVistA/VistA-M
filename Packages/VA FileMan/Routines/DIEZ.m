DIEZ ;SFISC/GFT-COMPILE INPUT TEMPLATE ; 30NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1,11,159,163,1039**
 ;
 I $G(DUZ(0))'="@" W:$D(^DI(.84,0)) $C(7),$$EZBLD^DIALOG(101) G K
EN1 D:'$D(DISYS) OS^DII
 I '$D(^DD("OS",DISYS,"ZS")) W $$EZBLD^DIALOG(820),$C(7) G K
 S U="^" S:'$G(DTIME) DTIME=300 N L,DNM
 D SIZ^DIPZ0(8033) G:$D(DTOUT)!($D(DUOUT))!('X) K S DMAX=X Q:$D(DIX)
TEM K DIC S DIC="^DIE(",DIC(0)="AEQ",DIC("W")="W ?40,""FILE #"",$P(^(0),U,4) W:$D(^(""ROU"")) ?60,^(""ROU"")",DIC("S")="I Y'<1" D ^DIC G:'$D(^DIE(+Y,"DR")) K S DIPZ=+Y
 D RNM^DIPZ0(8033) G:$D(DTOUT)!($D(DUOUT))!(X="") K S DNM=X K DIC
 W ! S DIR(0)="Y",DIR("A")=$$EZBLD^DIALOG(8020) D ^DIR K DIR G:'Y!($D(DIRUT)) K
 S X=DNM,Y=DIPZ K DIPZ
EN ;
 W:'$G(DIEZS) ! K ^UTILITY($J),DRN N L,DIEZQ,DIR S DMAX=DMAX-2150,DNM=X,DIEZ=+Y,DRN="",DRD=0,DIEZQ=0 D DELETROU(X)
 S DP=$P(^DIE(DIEZ,0),U,4),DIE=^DIC(DP,0,"GL")
 I '$D(^DIE(DIEZ,"DR",1,DP)) S ^DIE(DIEZ,"DR",1,DP)=^DIE(DIEZ,"DR")
 D DT^DICRW S X=-1
 K T S T(1)=$P(^DIE(DIEZ,0),U),T(2)=$$EZBLD^DIALOG(8033),T(3)=DP D BLD^DIALOG(8024,.T,"","DIR") W:'$G(DIEZS) !,DIR K T
 D UNCAF(DIEZ)
 K DOV,^DIE(DIEZ,"RD"),DR S DR=^("DR",1,DP),(DIER,DL)=1,DIEZL=0,DIEZAB=U
 D NEWROU F %=0:0 S %=$O(^DIE(DIEZ,"DR",99,%)) Q:%=""  F %Y=0:0 S %Y=$O(^DIE(DIEZ,"DR",99,%,%Y)) Q:%Y=""  S F=0,Q=^DIE(DIEZ,"DR",99,%,%Y) D QFF^DIEZ2 S X=" S DR(99,"_%_","_%Y_")="_Q D L^DIEZ2
 S X=" N DIEZTMP,DIEZAR,DIEZRXR,DIIENS,DIXR K DIEFIRE,DIEBADK S DIEZTMP=$$GETTMP^DIKC1(""DIEZ"")" D L^DIEZ2
 S X=" M DIEZAR=^DIE("_DIEZ_",""AR"") S DICRREC=""TRIG^DIE17""" D L^DIEZ2
 N DIEZTMP S DIEZTMP=$$GETTMP^DIKC1("DIEZ")
 S X=" S:$D(DTIME)[0 DTIME=300 S D0=DA,DIIENS=DA_"","",DIEZ="_DIEZ_",U=""^""" G ^DIEZ0
 ;
NEWROU ;
 K ^UTILITY($J,0) S DQ=0,T=99,L=3
 S ^UTILITY($J,0,1)=DNM_DRN_" ; "_$P("GENERATED FROM '"_$P(^DIE(DIEZ,0),U,1)_"' INPUT TEMPLATE(#"_DIEZ_"), FILE "_DP,U,DRN="")_";"_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 S ^UTILITY($J,0,2)=" D DE G BEGIN"
 S ^UTILITY($J,0,3)="BEGIN S DNM="""_DNM_DRN_""",DQ=1"
 I '$D(DRN(+DRN)) S DRN(+DRN)=U
 Q
 ;
EN2(Y,DIEZFLGS,X,DMAX,DIEZRLA,DIEZZMSG) ;Silent or Talking with parameter passing
 ;and optionally return list of routines built and if successful
 ;IEN,FLAGS,ROUTINE,RTNMAXSIZE,RTNLISTARRAY,MSGARRAY
 ;Y=TEMPLATE IEN (required)
 ;FLAGS="T"alk  (optional)
 ;X=ROUTINE NAME (required)
 ;DMAX=ROUTINE SIZE (optional)
 ;DIEZRLA=ROUTINE LIST ARRAY, by value (optional)
 ;DIEZZMSG=MESSAGE ARRAY (optional) (default ^TMP)
 ;*
 ;DIEZS will be used to indicate "silent" if set to 1
 ;Write statements are made conditional, if not "silent"
 ;*
 N DIEZS,DNM,DIQUIET,DIEZRIEN,DIEZRLAZ,DIEZRLAF
 N DIK,DIC,%I,DICS
 S DIEZS=$G(DIEZFLGS)'["T"
 S:DIEZS DIQUIET=1
 I '$D(DIFM) N DIFM S DIFM=1 D
 .N Y,DIEZFLGS,X,DMAX,DIEZRLA,DIEZS
 .D INIZE^DIEFU
 I $G(Y)'>0 D BLD^DIALOG(1700,"IEN for Edit Template missing or invalid") G EN2E
 I '$D(^DIE(Y,0)) D BLD^DIALOG(1700,"No Edit Template on file with IEN="_Y) G EN2E
 I $G(X)']"" D BLD^DIALOG(1700,"Routine name missing this Edit Template, IEN="_Y) G EN2E
 I X'?1U.NU&(X'?1"%"1U.NU) D BLD^DIALOG(1700,"Routine name invalid") G EN2E
 I $L(X)>7 D BLD^DIALOG(1700,"Routine name too long") G EN2E
 S DIEZRLA=$G(DIEZRLA,"DIEZRLAZ"),DIEZRIEN=Y
 S:DIEZRLA="" DIEZRLA="DIEZRLAZ" S:$G(DMAX)<2500!($G(DMAX)>^DD("ROU")) DMAX=^DD("ROU")
 S DIEZRLAF=""
 K @DIEZRLA
 D EN
 G:'DIEZS!(DIEZRLAF) EN2E
 D BLD^DIALOG(1700,"Compiling Edit Template (IEN="_DIEZRIEN_")"_$S(DIEZRLAF=0:", routine name too long",1:""))
EN2E I 'DIEZS D MSG^DIALOG() Q
 I $G(DIEZZMSG)]"" D CALLOUT^DIEFU(DIEZZMSG)
 Q
 ;
RECOMP S DIX=1 D DIEZ Q:'$D(DIX)  N DIMAX S DIMAX=DMAX
 F DIX=0:0 S DIX=$O(^DIE(DIX)) Q:DIX'>0  I $D(^(DIX,0)),$D(^("ROU")) S %=$P(^(0),"^",1),X=$E(^("ROU"),2,99) I X]"" S Y=DIX,DMAX=DIMAX D EN
 ;
K K %,DDH,DIC,DIX,DIPZ,DMAX,DNM,DTOUT,DIRUT,DIROUT,DUOUT,X,Y Q
 ;DIALOG #101  'only those with programmer's access'
 ;       #820  'no way to save routines on the system'
 ;       #8020 'Should the compilation run now?'
 ;       #8024 'Compiling template name Input template of file n'
 ;       #8033 'Input template'
UNCAF(DIEZ) ;
 ; for one compiled input template (DIEZ), delete its "AF" entries
 N %,X S X=""
 F  S X=$O(^DIE("AF",X)) Q:X=""  K:'X ^(X,DIEZ) S %=0 F  S %=$O(^DIE("AF",X,%)) Q:%'>0  K:$D(^(%,DIEZ)) ^(DIEZ)
 Q
 ;
UNC(DIEZ,DIFLAGS) ;
 ; DBS: silent entry point to uncompile an input template
 ; DIEZ = IEN of input template to uncompile
 ; DIFLAGS = flags:
 ;     D = compiled routines are also deleted
 K ^DIE(DIEZ,"ROU")
 D UNCAF(DIEZ)
 I $G(DIFLAGS)["D" D
 . N DINAME S DINAME=$G(^DIE(DIEZ,"ROUOLD")) Q:DINAME=""
 . N DIROU,DISUF F DISUF="",1:1 D  Q:DIROU=""
 . . S DIROU=DINAME_DISUF I '$$ROUEXIST^DILIBF(DIROU) S DIROU="" Q
 . . N X S X=DIROU X $G(^DD("OS",DISYS,"DEL"))
 Q
 ;
 ;
DELETROU(DIEZNAME) ;DELETE THE ROUTINES NAMED 'DIEZNAME' CONCATENATED WITH NUMBER
 Q:DIEZNAME=""  Q:$L($T(+2^@DIEZNAME),";")>2  ;TRY TO KEEP FROM BLOWING AWAY A REAL ROUTINE!
 N DIEZ,DIEZDEL,X,DIEZEXST,C
 S C=0,DIEZEXST="I $L($T(^@X))",DIEZDEL=$G(^DD("OS",DISYS,"DEL")) Q:DIEZDEL=""
 F DIEZ=1:1:1000 D  Q:C>20  ;STOP IF THERE IS A GAP OF 20
 .S X=DIEZNAME_DIEZ X DIEZEXST I  X DIEZDEL S C=0 Q
 .S C=C+1
 S X=DIEZNAME X DIEZEXST I  X DIEZDEL
 Q
