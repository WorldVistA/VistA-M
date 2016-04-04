DITM1 ;SFISC/JCM(OHPRD)-ASKS SUBFILE FOR COMPARE AND MERGE ;2/24/93  14:00
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ; When subfiles work will need to delete SUB+0 and uncomment SUB+1
 ;--------------------------------------------------------------------
START ;
SUB S L=L+1,DFL(L)=$O(^DD(+Y,0,"NM","")),(DFF,DFF(L))=+Y
 ;S %=$P(Y,U,2),Y=+Y D SUB^DICRW K DIA S:Y>0 DITM("SUBFILE")=+Y
ENTR I $D(DTOUT)!(X["^") S DITM("QFLG")="" G END
 K DIC S DIC(0)="AEQMZ",DIC=DSUB(0),DFL=1,DIT=DIT+1,DIT(DIT)="" W:DIT=1 !
E1 S DIC("A")=$E("        ",1,DFL-1*3)_$S(DIT=2:"   WITH ",1:"COMPARE ")_DFL(DFL)_": " I (DIT=2),(DFL=L),($P(DIT(1),",",1,L-1)=$P(DIT(2),",",1,L-1)) S DIC("S")="I Y-"_$P(DIT(1),",",L)
 D ^DIC K DIC("S"),DIC("A") I Y>0,$D(DSUB(DFL)),$D(DFL(DFL+1)) S DIC=DIC_+Y_","_DSUB(DFL),DIT(DIT)=DIT(DIT)_+Y_",",DFL=DFL+1 S %=$O(@(DIC_""""")")) G:%'=""&'% E1 S:%>0 ^(0)=U_DFF_U I %="" W !,"NO "_DFL(DFL) S (%,Y)=-1
 S:X=U DITM("QFLG")="" G:X=U!(Y=-1) END S DTO(DIT)=DIC_+Y_",",DTO(DIT,"X")=Y(0,0),DIT(DIT)=DIT(DIT)_+Y G:DIT=1 ENTR S DDSP=1
 S DITM("DFF")=DFF,DITM("DIT(1)")=DIT(1),DITM("DIT(2)")=DIT(2)
 S DITM("DIC")=DSUB(0)
 I $D(DITM("SUB FILE")),$D(DSUB(1)) S DITM("DSUB1")=$P(DSUB(1),",",1)
END ;
 Q
