DITP ;SFISC/GFT-TRANSFER POINTERS ;17MAY2005
 ;;22.2;VA FileMan;**10**;Jan 05, 2016;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
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
 S %=2 D YN^DICN Q:%
 W !?4,"ANSWER 'YES' IF YOU THINK THAT THE ENTRY WHICH YOU HAVE JUST "_$P("MOVED^DELETED",U,DH+1),!?4,"MAY BE 'POINTED TO' BY SOME POINTER-TYPE FIELD VALUE SOMEWHERE",!
 G Q
 ;
 ;
 ;
 ;
EN(DIFILE,DILIST) ;IF THERE ARE POINTERS TO FILE 'DIFILE', GO THRU THE DILIST AND CHANGE THE POINTERS
 K ^UTILITY("DIT",$J)
 N Y,DIA,DTO,DL
 S (DIA("P"),Y)=DIFILE,(DIA,DTO)=$G(^DIC(+DIFILE,0,"GL")) I DTO="" W "ERROR in specification" Q  ;,DIA(1)=FROM
 D PTS^DIT
 S X=0 F Y=0:0 S Y=$O(DILIST(Y)) Q:'Y  S %=$P(DILIST(Y),U,2) D  I '$D(X) W "ERROR in specification" G END
 .I '%,"@"'[% K X Q
 .I %,'$D(@(DTO_"%)")) K X Q
 .S X=X+1,^UTILITY("DIT",$J,+DILIST(Y))=%_";"_$E(DTO,2,99)
 I X D P
END K ^UTILITY("DIT",$J)
 Q
 ;
PTS ;
 D WAIT^DICD K IOP
 ;At this point, e.g.^UTILITY("DIT",$J,0,1)=801.41^15^V
 ;and ^UTILITY("DIT",$J,38)="103;AUTTIMM("  meaning that pointers to entry 38 in ^AUTTIMM are being moved to 103
P F  S X=$O(^UTILITY("DIT",$J,0,0)) Q:X=""  S Y=^UTILITY("DIT",$J,0,X),L=$P(Y,U,2) K ^(X) D 1(+Y,L,.DTO) ;KILL NODES AS WE PROCESS THEM
 K ^UTILITY("DIT",$J) Q
 ;
1(DIPFILE,DIPFIELD,DTO) ;CALL DIP PRINT MODULE ONCE TO GO THRU CHANGING ONE FIELD'S VALUE.  'DTO' IS ROOT OF FILE BEING POINTED TO.
 N DIPVP,DL,L,DHD,DIA,BY,DITPY,DR,D,X,FLDS,DIOBEG,FR,TO,DISTOP,DIOBEG
 S (BY,FR,TO)="",DIPVP=$P(^DD(DIPFILE,DIPFIELD,0),U,2)["V" Q:$P(^(0),U,2)  ;A MULTIPLE CAN'T POINT
 S DL=1,DL(1)=DIPFIELD_"////^D STUFF^DITP("_(DIPVP)_")"
 ;S X=$S($D(DE(DQ))[0:"""",$D(^UTILITY(""DIT"",$J,DE(DQ)))-1:"""",^(DE(DQ)):"_$S($P(Y,U,3)'["V":"+",1:"")_"^(DE(DQ)),1:""@"") I X]"""",$G(DIFIXPT)=1 D PTRPT^DITP" K ^(X)
 S L=$P(^DD(DIPFILE,DIPFIELD,0),U,4),%=$P(L,";",2),L=""""_$P(L,";",1)_"""",DHD=$P(^(0),U) I % S %="$P(^("_L_"),U,"_%_")"
 E  S %="$E(^("_L_"),"_+$E(%,2,9)_","_$P(%,",",2)_")"
 S L=L_")):"""","_%_"?."" "":"""","
 I DIPVP,DTO]"" S L=L_"$P("_%_","";"",2)'="""_$E(DTO,2,99)_""":"""","
 S L=L_"'$D(^UTILITY(""DIT"",$J,+"_%_")):"""","
UP S (D(DL),%)=+Y I $D(^DD(%,0,"UP")) S DL=DL+1,Y=^("UP"),(DL(DL),%)=$O(^DD(Y,"SB",%,0))_"///",X(DL)=""""_$P($P(^DD(Y,+%,0),U,4),";")_"""",BY=+%_","_BY G UP
 S DHD=$O(^("NM",0))_" entries whose '"_DHD_"' pointers have been changed"
 Q:'$D(^DIC(%,0,"GL"))  S DIC=^("GL"),DITPY="S X=$S('$D("_DIC_"D0,"
 F X=0:1:DL-1 S DR(X+1,D(DL-X))=DL(DL-X) S:X DITPY=DITPY_X(DL+1-X)_",D"_X_","
 S DIA("P")=%,%=$L(BY,",") I %>2 S BY=$P(BY,",",%-2)_",.01,"_BY
 S DITPY=DITPY_L_"1:D"_X_")",BY=BY_"X DITPY;@"
 ;Now DITPY=e.g. S X=$S('$D(^AUPNVIMM(D0,"0")):"",$P(^("0"),U,1)?." ":"",'$D(^UTILITY("DIT",$J,+$P(^("0"),U,1))):"",1:D0)
 S L=0,FLDS="",DISTOP=0,DHIT="N DIFIXPT G LOOP^DIA2",%ZIS="",DIOBEG="W !!" ;It will happen in DIA2
 I $G(DIQUIET) K DIOBEG S DIFIXPT=1 ;DHD="@@"
 D EN1^DIP
IOP S IOP=$S($G(IOS):"`"_IOS,1:$G(IO)) Q  ;KEEP THE SAME OUTPUT DEVICE AS WE GO THRU DIFFERENT 'PRINTINGS'
 ;
STUFF(VP) ;VP=BOOLEAN
 S X="" Q:$G(DE(DQ))=""
 N % S %=DE(DQ) Q:'%!'$D(^UTILITY("DIT",$J,+%))  ;^UTILITY("DIT",$J,38)="103;AUTTIMM(" means 'CHANGE OLD 38 TO 103' if we have a variable-pointer to ^AUTTIMM
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
