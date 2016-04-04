DITP ;SFISC/GFT-TRANSFER POINTERS ;17MAY2005
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**50,1014**
 ;
 D ASK Q:%-1  G PTS
 ;
ASK ;
 I '$D(^UTILITY("DIT",$J,0,1)) S %=2 Q
 S %=$O(^(1)),%Y=+^(1) S:%="" %=-1
U I $D(^DD(%Y,0,"UP")) S %Y=^("UP") G U
 W !,"SINCE THE "_$P("TRANSFERRED^DELETED",U,DH+1)_" ENTRY MAY HAVE BEEN 'POINTED TO'"
 W !,"BY ENTRIES IN THE '"_$P(^DIC(+%Y,0),U,1)_"' FILE," W:%>1 " ETC.,"
Q W !,"DO YOU WANT THOSE POINTERS UPDATED (WHICH COULD TAKE QUITE A WHILE)"
 S %=2 D YN^DICN Q:%  W !?4,"ANSWER 'YES' IF YOU THINK THAT THE ENTRY WHICH YOU HAVE JUST "_$P("MOVED^DELETED",U,DH+1),!?4,"MAY BE 'POINTED TO' BY SOME POINTER-TYPE FIELD VALUE SOMEWHERE",! G Q
 ;
PTS ;
 D WAIT^DICD K IOP
P K DR,D,DL,X S (BY,FR,TO)="",X=$O(^UTILITY("DIT",$J,0,0))
 I X="" K ^UTILITY("DIT",$J),DIA,DHD,DR,DISTOP,BY,TO,FR,FLDS,L,DIOBEG Q
 S Y=^UTILITY("DIT",$J,0,X),L=$P(Y,U,2),DL=1 K ^(X)
 S DL(1)=L_"////^D STUFF^DITP("_($P(Y,U,3)["V")_")" ;S X=$S($D(DE(DQ))[0:"""",$D(^UTILITY(""DIT"",$J,DE(DQ)))-1:"""",^(DE(DQ)):"_$S($P(Y,U,3)'["V":"+",1:"")_"^(DE(DQ)),1:""@"") I X]"""",$G(DIFIXPT)=1 D PTRPT^DITP" K ^(X)
 S L=$P(^DD(+Y,L,0),U,4),%=$P(L,";",2),L=""""_$P(L,";",1)_"""",DHD=$P(^(0),U) I % S %="$P(^("_L_"),U,"_%
 E  S %="$E(^("_L_"),"_+$E(%,2,9)_","_$P(%,",",2)
 S L=L_")):"""","_%_")?."" "":"""",1:D"
UP S (D(DL),%)=+Y I $D(^DD(%,0,"UP")) S DL=DL+1,Y=^("UP"),(DL(DL),%)=$O(^DD(Y,"SB",%,0))_"///",X(DL)=""""_$P($P(^DD(Y,+%,0),U,4),";")_"""",BY=+%_","_BY G UP
 S DHD=$O(^("NM",0))_" entries whose '"_DHD_"' pointers have been changed" G P:'$D(^DIC(%,0,"GL")) S DIC=^("GL"),Y="S X=$S('$D("_DIC_"D0,"
 F X=0:1:DL-1 S DR(X+1,D(DL-X))=DL(DL-X) S:X Y=Y_X(DL+1-X)_",D"_X_","
 S DIA("P")=%,%=$L(BY,",") I %>2 S BY=$P(BY,",",%-2)_",.01,"_BY
 S BY=BY_Y_L_X_")",L=0,FLDS="",DISTOP=0,DHIT="G LOOP^DIA2",%ZIS="",DIOBEG="W !!!!" ;It will happen in DIA2
 D EN1^DIP
IOP S IOP=$S($G(IOS):"`"_IOS,1:$G(IO)) G P
 ;
STUFF(VP) ;VP=BOOLEAN
 S X="" Q:$G(DE(DQ))=""
 N % S %=DE(DQ) Q:'$D(^UTILITY("DIT",$J,+%))
 S X=^(+%) I 'VP S X=+X
 E  S X=$S($P(X,";",2)'=$P(%,";",2):"",'X:"@",1:X) W:X="" "    (no change)" Q
 S:'X X="@"
 Q
 ;
PTRPT Q:'$G(DIFIXPTC)  N I,J,X
 F I=1:1:DL S J="" F  S J=$O(DR(I,J)) Q:J=""  I DR(I,J)["///" S X=$P($G(DR(I,J)),"///",1) I X]"" D
 . S ^TMP("DIFIXPT",$J,DIFIXPTC)=^TMP("DIFIXPT",$J,DIFIXPTC)_$S(I>1:" entry:"_$S(I=DL:$G(DA),1:$G(DA(DL-I))),1:"")_$S(I=DL:"   field:",1:"   mult.fld:")_X
 . Q
 Q
