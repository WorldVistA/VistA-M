DIU2 ;SFISC/XAK/GFT-EDIT FILE ;18SEP2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**82,1039,1040**
 ;
 ;
 ;from DIU0
N S X=$P(^DIC(DA,0),U,1),D=@(DIU_"0)"),^(0)=X_U_$P(D,U,2,9) K ^DD(+$P(D,U,2),0,"NM") S ^("NM",X)="" Q:$D(Y)
 I DUZ(0)]"" F DR=1:1:6 S D=$P("DD^RD^WR^DEL^LAYGO^AUDIT",U,DR),Y=$S($D(^DIC(DA,0,D)):^(D),1:"") D RW G Q:X=U
 S X=$G(^("AUDIT"))
 I X]"",DUZ(0)'="@" G OK:$TR(X,DUZ(0))=X
DDA K DIR ;S DIR("A")="DD AUDIT",DIR(0)="YO"
 ;S:$D(^DD(DA,0,"DDA")) DIR("B")=$S(^("DDA")["Y":"YES",1:"NO")
 ;S DIR("??")="^W !!?5,""Enter 'Y' (YES) if you want to audit the Data Dictionary changes"",!?5,""for this file."""
 ;D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  S ^DD(DA,0,"DDA")=$S(Y=1:"Y",1:"N")
OK S DIU(0)=$P(@(DIU_"0)"),U,2) K DIR
 S %=DIU(0)'["O"+1
 W !,"ASK 'OK' WHEN LOOKING UP AN ENTRY" D YN^DICN
 I %>0 S $P(@(DIU_"0)"),U,2)=$P(DIU(0),"O")_$E("O",%)_$P(DIU(0),"O",2)
 I '% W !?5,"Answer YES to cause a lookup into this file to verify the",!?5,"selection by prompting with '...OK? YES//'." G OK
 I DUZ(0)="@",%'<0 D ^DIU21
Q K DIR,DIRUT,DTOUT,DUOUT,DIROUT Q
 ;
CHECKPT ;CALLED BY ^DD(1,.01,"DEL",.5,0)
 N M,S,P D POINT^DIDH S M=0,P="PT"
CM S M=$O(^DD(DA,0,P,M)) I M>0 Q:M<DA  G CM:M=DA S S=M F  S S=$G(^DD(M,0,"UP")) Q:'S  G CM:S=DA ;SET $T=0 SWITCH TO SAY THERE'S NO POINTER FILE TO THIS ONE
 Q:P="PTC"!$T  S P="PTC" G CM ;LOOK AT COMPUTED POINTERS AS WELL AS POINTERS
 ;
 ;
K ; CALLED BY ^DD(1,.01,"DEL",1,0)
 N DIKREF,DG,DIR
 S DIKREF=$$CREF^DILF(DIU),DG=@DIKREF@(0)
 I $P($G(^DD(+$P(DG,U,2),0,"DI")),U,2)["Y" W $C(7)," CANNOT DELETE A RESTRICTED"_$S($P($G(^("DI")),U)["Y":" (ARCHIVE)",1:"")_" FILE!" Q
 G G:'$O(@DIKREF@(0))
H W $C(7),!,"DO YOU WANT JUST TO DELETE THE "
 I $P(DG,U,4)>1 W $P(DG,U,4)," FILE ENTRIES,"
 E  W "FILE CONTENTS,"
 S %=2 W !?9,"& KEEP THE FILE DEFINITION" D YN^DICN
 I %=0 W !,"Answer YES if you are just looking for a fast way to get rid of Entries",!! G H
 I %<2 D:%=1  Q  ;$T left TRUE, so FILE will not be deleted
 .N S
 .M S=@DIKREF@(0) K @DIKREF
 .M @DIKREF@(0)=S ;save back the stuff hanging from zero node
 .S $P(@DIKREF@(0),U,3,99)="",^DIC(DA,0,"GL")=DIU
G Q:$G(DIU(0))'["D"
 S %=1 I $O(@DIKREF@(0)) W !?3,"IS IT OK TO DELETE THE '"_DIKREF_"' GLOBAL" D YN^DICN
 I %=0 W !,"You can abort the deletion process at this point by typing '^'",!,"Answer NO if you want to save ",DIKREF," for redefinition at a later time.",!! G G
 S:%=1 DIKLGLBL=DIKREF
 I %<1 ;$T true means forget it!
SURE I $D(DDS),$D(DDACT) D
 . F  D  Q:%Y'["?"
 .. S %=2 W !,"SURE YOU WANT TO DELETE THE ENTIRE FILE" D YN^DICN
 .. I %Y["?" D
 ... W !,"We are going to ",$S($D(DIKLGLBL):"Delete data associated with File #"_DA,1:"Leave the data associated with File #"_DA)
 ... W !,"Answer YES if want to continue with the DELETION of the DD, Templates, Forms,"
 ...  W !,"etc. for File #"_DA
 I %-1
 Q
 ;
RW W !,$P("DATA DICTIONARY^READ^WRITE^DELETE^LAYGO^AUDIT",U,DR)," ACCESS: " G R:Y="" W Y I DUZ(0)'="@" F X=1:1:$L(Y) Q:DUZ(0)[$E(Y,X)  G Q:X=$L(Y)
 W "// "
R R X:DTIME S:'$T X=U,DTOUT=1 Q:X=""
 I X["@" G V:Y="" W $C(7),"   PROTECTION ERASED!" K ^(D) Q
 Q:X[U
 I X["?" W !,"ENTER CODE(S) TO RESTRICT USER'S ACCESS TO THIS FILE" G RW
V I DUZ(0)'="@" F Z=1:1:$L(X) I DUZ(0)'[$E(X,Z) W $C(7),"??" G RW
 S ^(D)=X Q
EN ;
 Q:'$D(DIU)  G EN^DIU0
