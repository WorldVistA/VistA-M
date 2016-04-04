DIDGFTPT ;GFT/GFT  -- GET ALL ENTRIES THAT POINT TO ENTRY GFTIEN IN FILE GFTFILE;14OCT2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 W !!,"THIS UTILITY TRIES TO FIND ALL ENTRIES IN ALL FILES POINTING TO A CERTAIN FILE",!
 D DT^DICRW
 N DIC,DIR,X,Y,GFTIEN,GFTANY,GFTFILE,GFTALL,DIRUT,DIBT,GFTIENLIST
 K ^TMP($J)
 S DIC=1,DIC(0)="AEQM" D ^DIC Q:Y<0  S GFTFILE=+Y,GFTANY=$P(^DIC(GFTFILE,0),U)
 S DIR(0)="S^1:One particular "_GFTANY_" Entry;2:All "_GFTANY_" Entries;3:Non-existent "_GFTANY_" Entries"
 S X="" F  S X=$O(^DIBT("F"_GFTFILE,X)) Q:X=""  F Y=0:0 S Y=$O(^DIBT("F"_GFTFILE,X,Y)) Q:'Y  I $D(^DIBT(Y,1))>1 S DIBT(Y)=""
 I $O(DIBT(0)) S DIR(0)=DIR(0)_";4:Entries from a "_GFTANY_" Search Template"
 S DIR("A")="Find pointers to"
 S DIR("B")=$P($P(DIR(0),";",2),":",2)
 D ^DIR K DIR Q:$G(DIRUT)
 I Y=4 S DIC=.401,DIC("S")="I $D(DIBT(+Y))",GFTANY=Y D ^DIC Q:Y'>0  K DIBT,DIC M GFTIENLIST=^DIBT(+Y,1) G ZIS
 S DIC=GFTFILE,DIC("A")="Find pointers to "_GFTANY_" Entry: ",GFTANY=Y,GFTIENLIST=0
 I Y=1 D ^DIC Q:Y<0  S GFTIENLIST=+Y
ZIS D ^%ZIS Q:$G(POP)  U IO
 W ! S $Y=0
START K DIC
 D DEPEND(GFTFILE,.GFTIENLIST,,"M"_GFTANY)
 ;NOW WE HAVE ALL INFO
 S GFTIEN="" F  S GFTIEN=$O(^TMP($J,GFTFILE,GFTIEN)) Q:GFTIEN=""  D  Q:'$D(GFTIEN)
 .S X=$$GET1^DIQ(GFTFILE,GFTIEN,.01) I X]"" Q:GFTANY=3
 .E  S X="NON-EXISTENT ENTRY # "_GFTIEN
 .W !!,"***",$P(^DIC(GFTFILE,0),U),": "  W X,"***"
 .F I=0:0 Q:'$D(GFTIEN)  S I=$O(^TMP($J,GFTFILE,GFTIEN,I)) Q:'I  W !,"FILE ",I," (",$P(^DIC(I,0),U),")" F J=0:0 S J=$O(^TMP($J,GFTFILE,GFTIEN,I,J)) Q:'J  D  Q:'$D(GFTIEN)
 ..S Y=$O(^(J,""))
 ..W !?9,"`",J,?22,$$GET1^DIQ(I,J,.01)
 ..F  Q:Y=""  W:$X>(IOM-30) ! W ?IOM-30,$P(@("^DD("_Y_",0)"),U) S Y=$O(^TMP($J,GFTFILE,GFTIEN,I,J,Y))
 ..I $E($G(IOST))="C",$G(IOSL,24)-3<$Y S DIR(0)="E" D ^DIR S $Y=0 I 'Y K GFTIEN
 K ^TMP($J)
 I '$G(GFTALL) W !!! D ^%ZISC
 Q
 ;
 ;
DEPEND(GFTFILE,IEN,GFTWHERE,GFTPARAM) ;
 I $G(GFTPARAM)["M" N GFTANY S GFTANY=+$P(GFTPARAM,"M",2)
 S:$G(GFTWHERE)="" GFTWHERE=$NA(^TMP($J))
    K @GFTWHERE ;output array
 I $D(IEN)<9 S GFTIEN(GFTFILE,+IEN)="" ;IEN can be either a scalar...
 E  M GFTIEN(GFTFILE)=IEN ;...or an array
 N A,B
 S A=0 F  S A=+$O(^DD(GFTFILE,0,"PT",A)) Q:'A  D
 . S B=0 F  S B=+$O(^DD(GFTFILE,0,"PT",A,B)) Q:'B  D
 . . D CHASE(A,B,.GFTRCR)
COMPUTED S A=0 F  S A=+$O(^DD(GFTFILE,0,"PTC",A)) Q:'A  D
 .S B=0 F  S B=+$O(^DD(GFTFILE,0,"PTC",A,B)) Q:'B  D
 ..D CHASE(A,B,.GFTRCR)
 Q
         ;
         ;
CHASE(FILE,FIELD,GFTRCR) ;BUILD AN 'XEC' THAT WILL GO THRU FILE REMEMBERING FIELD'S POINTERS
 I FILE=.6!(FILE=1.1) Q  ;NOT AUDIT FILES
 N GFTF,X,I,J,V,XEC,A,B,D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,DICMX,DIDGFTPT,GFTFISCR
 S GFTF=FILE,L=0,PUT="",DIDGFTPT=1 ;want this defined for special FILE SCREENS
UP F  S I=$G(^DD(GFTF,0,"UP")) Q:'I  S L=L+1,X=$O(^DD(I,"SB",GFTF,0)) Q:'X  S J=$P($G(^DD(I,X,0)),U,4) Q:J'[";0"  S GFTF=I,J(L)=$P(J,";")
 Q:'$D(^DIC(GFTF,0,"GL"))  S J=^("GL"),I=""
 I $G(^DD(GFTF,0,"SCR"))]"" S GFTFISCR=^("SCR")
 F A=L:-1:0 S X="D"_(L-A),PUT=PUT_"_D"_A_"_"",""",I=I_"F "_X_"=0:0 S "_X_"=$O("_J_X_")) Q:'"_X_"  I $D(^("_X_",0)) " I A S J=J_X_","""_J(A)_""","
 D  Q:'$D(XEC)  ;NOW WE HAVE 'L' AS LEVEL AND 'I' AS 'L' FOR LOOPS
 .S X=$P($G(^DD(FILE,FIELD,0)),U,4) Q:X=""  S A=$P(^(0),U,2),FIELD=FILE_","_FIELD,V=$P(X,";",2)
 .I 'V Q:A'["C"  Q:A'["p"  S DICMX=$P(^(0),U,5,99),XEC="X DICMX I X" I A["m" D  Q
 ..S XEC=I_"S DIDGFTPT=D0 "_DICMX,DICMX="D PUT^DIDGFTPT(+$G(D),DIDGFTPT,"""_FIELD_""")" ;m=MULTIPLE COMPUTED POINTER
 .I V S XEC="S X=$P($G(^("""_$P(X,";")_""")),""^"","_+V_") I X" D:A["V"
 ..S XEC=XEC_",$P(X,"";"",2)="""_$$CONVQQ^DILIBF($P(^DIC(GFTFILE,0,"GL"),U,2))_""""
 .S XEC=I_XEC_" D PUT(+X,D0,"""_FIELD_""")"
XEC X XEC
 Q
 ;
PUT(XVAL,Y,FIELD) I '$D(GFTIEN(GFTFILE,XVAL)) Q:$G(GFTANY)<2
 I $D(GFTFISCR) X GFTFISCR E  Q  ;FILE SCREEN!
 N IENS,L,S S IENS=D0_"," F L=1:1 S S=$G(@("D"_L)) Q:S=""  S IENS=S_","_$G(IENS)
 S @GFTWHERE@(GFTFILE,XVAL,GFTF,Y,FIELD,IENS)=""
 Q
 ;
 ;
ALL ;Do all files (SO)
 D ^%ZIS U IO
 N GFTFILE
 S GFTFILE=1.99999
 F  S GFTFILE=$O(^DIC(GFTFILE)) Q:'GFTFILE  D
 . I GFTFILE=80.2 Q
 . I GFTFILE=80.3 Q
 . N GFTIEN,GFTANY,GFTALL
 . S GFTIEN=0,GFTANY=3,GFTALL=1
 . D START
 .Q
 ;
 D ^%ZISC
 Q
