DII ;SFISC/GFT,XAK,TKW-OPTION RDR, INQUIRY ;5:21 AM  15 Mar 2005
V ;;22.0;VA FileMan;**64,81,143**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 W !!,"VA FileMan "_$P($T(V),";",3),!
 ;
 ;If not Stand Alone make sure DUZ is defined ;22*143
 I '+$G(DUZ),$D(^VA(200,0))#2 D  I '+$G(DUZ) W $C(7),!,$$EZBLD^DIALOG(7005),! Q
 . ;If ASKDUZ^XUP available, use it first
 . I $L($T(ASKDUZ^XUP)) N DIR,DIRUT,DUOUT,DTOUT D  Q:($D(DUOUT)!$D(DTOUT))
 .. N XUEOFF,XUEON,DIDUZ
 .. I '$D(^%ZOSF("EOFF")) Q
 .. I '$D(^%ZOSF("EON")) Q
 .. W !,"Your Identity(DUZ) is 0(zero).",!,"Please identify yourself.",!
 .. S:$G(DUZ(0))]"" DIDUZ=DUZ(0)
 .. S XUEOFF=^%ZOSF("EOFF"),XUEON=^%ZOSF("EON")
 .. D ASKDUZ^XUP ;IA #4596
 .. S:$G(DIDUZ)]"" DUZ(0)=DIDUZ
 .. Q
 . ;If DUZ is still undefined as last resort call DIC
 . I '+$G(DUZ) D  Q
 .. N DIC,DTOUT,DUOUT,DIDUZ
 .. S:$G(DUZ(0))]"" DIDUZ=DUZ(0)
 .. W $C(7),!,"Your Identity(DUZ) is still 0(zero).",!,"You need to identify yourself!",!
 .. S DUZ=0,DIC=200,DIC(0)="AEFNQZ",DIC("A")="New Person?: "
 .. ;Can't be POSTMASTER or SHARED MAIL and have an ACCESS CODE
 .. S DIC("S")="I ((+Y'<1)&($P(^(0),""^"",3)]""""))"
 .. D ^DIC
 .. I +Y'>1 Q
 .. S DUZ=+Y
 .. S DUZ(0)=$P(^VA(200,DUZ,0),U,4)
 .. S:$G(DIDUZ)]"" DUZ(0)=DIDUZ
 .. Q
 . Q
 ;
NOKL D DT^DICRW,OS S DIK="^DOPT(""DII""," G F:$D(^DOPT("DII",9)) S ^(0)="OPTION^1.01^" F I=1:1 S X=$E($T(F+I),4,99) Q:X=""  S ^DOPT("DII",I,0)=X
 D IXALL^DIK
F S DIC=DIK,DIC(0)="AEQZ" D ^DIC K DIC,DIK G Q:Y<0 S X=$P(Y(0),U,2,99) K Y D @X W !!! D Q G NOKL
 ;;ENTER OR EDIT FILE ENTRIES^^DIB
 ;;PRINT FILE ENTRIES^^DIP
 ;;SEARCH FILE ENTRIES^^DIS
 ;;MODIFY FILE ATTRIBUTES^^DICATT
 ;;INQUIRE TO FILE ENTRIES^INQ^DII
 ;;UTILITY FUNCTIONS^^DIU
 ;;OTHER OPTIONS^^DII1
 ;;DATA DICTIONARY UTILITIES^^DDU
 ;;TRANSFER ENTRIES^^DIT
 ;
Q D Q^DIB,Q^DICATT2,Q^DIARB
 K DRK,DIL,DIS,DK,DIACD,DIQ,DX,DQI,DISYS,DHIT,%X,%Y,%,DXS,Q,DIAR
 K A0,D9,DNP,DCC,DIJ,DP,DM,DQ,DICATT,DIFLD,D0,DIEL,DL,DC,DU,DIP
 K DH,DIYS,DINS,DIPT,DHD,DCL,DPP,DPQ,DALL,DIRUT,DIROUT,DUOUT,DTOUT
 Q
INQ ;
 W !! D ^DICRW Q:'$D(DIC)  S DI=DIC,DPP(1)=+Y_"^^^@",DK=+Y I $D(DICS) S DICSS=DICS
B K ^UTILITY($J),^(U,$J),DIC,DIQ,DISV,DIBT,DICS S DIC=DI,DIC(0)="AEQM",DIK=0
R D ^DIC I Y>0 S DIK=DIK+1,^UTILITY(U,$J,DIK,+Y)="",DIC("A")="ANOTHER ONE: " G R
S G Q^DIP:'DIK!(X=U) G:DIK'>3 O
 D  K DIRUT,DIROUT
 . N DIK,DI,DICSS,DX D S2^DIBT1 Q
 G:$D(DTOUT)!($D(DUOUT)) Q^DIP G:X="" O G:Y<0 S
 F X=1:1:DIK S ^DIBT(+Y,1,+$O(^UTILITY(U,$J,X,0)))=""
 S ^DIBT(+Y,"QR")=DT_U_DIK
O K DIC G Q^DIP:$D(DTOUT) S DIC=DI,%=1
 W !,"STANDARD CAPTIONED OUTPUT" D YN^DICN G Q^DIP:%<0
 I '% W !?5,"Answer 'N' to create a formatted display as in the Print Option." G O
 I %=2 S L=1,Q="""",DPP=1,DPP(1,"IX")="^UTILITY(U,$J,"_DI_"^2" S:$D(DICSS) DICS=DICSS G N^DIP1
 D C G:$D(DIRUT) Q
 S IOP="HOME" D ^%ZIS I $D(DICSS) S DICS=DICSS
DIQ N S S S=1 F DIK=1:1:DIK S DA=+$O(^UTILITY(U,$J,DIK,0)) W ! D:DIK>1 LF^DIQ Q:'S  D CAPTION^DIQ(DK,DA,DIQ(0)) G:'S Q  S S=S+2
 W !! Q:$D(DTOUT)  G B
 ;
P G Q^DI
 ;
OS I $D(^%ZOSF("OS"))#2 S DISYS=+$P(^("OS"),"^",2) Q:DISYS>0
 S DISYS=$S($D(^DD("OS"))#2:^("OS"),1:100)
 Q
AUD S DIACD=DIQ(0),DIQ(0)="C",DIQ=DA
 F DA=0:0 S DA=$O(^DIA(DK,"B",DIQ,DA)) Q:DA'>0  S DIC="^DIA("_DK_",",E="N<0",N=-1,DD=1.1,DIA=DK D GUY^DIQ Q:'S  W !
 S DIQ(0)=DIACD Q
 ;
C ;called from ^DIP21
 N DIR,I,L,Y,X,DITXT
 D BLD^DIALOG(7004,"","","DIR") S DITXT="" D  S DITXT=DITXT_DIR
 . F I=1:1 Q:$G(DIR(I))=""  S DITXT=DITXT_DIR(I)
 . Q
 K DIR S DIR(0)="SMB^"_DITXT,DIR("B")=$P($P(DITXT,":",2)," ",1),DIR("A")=$$EZBLD^DIALOG(8002)
 D ^DIR Q:$D(DIRUT)
 F I=1:1 S X=$P($P(DITXT,";",I),":") Q:X=""  I X=Y S DIQ(0)=$S(I=2:"C",I=3:"R",I=4:"CR",1:"") Q
 I X'=Y S DIRUT=1 Q
 I $D(^DIA(DK)) S DIR(0)="Y",DIR("A")="DISPLAY AUDIT TRAIL",DIR("B")="No",DIR("?")="Answer 'Y' to display the audit trail for each Entry." D ^DIR Q:$D(DIRUT)  S:Y=1 DIQ(0)=DIQ(0)_"A"
 Q
 ;7004  N:No;Y:Yes;R:Record Number;B:Both Computed and Number
 ;7005  You must have a valid DUZ! ;22*143
 ;8002  Include COMPUTED fields
