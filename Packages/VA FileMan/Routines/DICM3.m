DICM3 ;SFISC/XAK,TKW-PROCESS INDIVIDUAL FILE FOR VAR PTR ;07:39 PM  8 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**16,4,20,999**
 ;
DIC ; Does recursive ^DIC call to single pointed-to file.
 Q:$D(DIVP(+DIVPDIC))
 I $D(DIV("V")) N % D  X % I '$T K Y S Y=-1 D DQ Q
 . S Y=DIVP,Y(0)=DIVPDIC
 . S %=$S($G(DIV("V"))]"":DIV("V"),1:$G(DIV("V",1))) Q
 I '$D(^DIC(+DIVPDIC,0,"GL")) S Y=-1 D DQ Q
 S (Y,DIC)=^("GL"),%="DIC"_DICR
 N:'$D(DIVPSEL) DIVPSEL S DIVPSEL(DICR)=0
 S D=$G(DICR(DICR,4)) S:D="" D="B"
 I DIC["""" S Y="" F A1=1:1:$L(DIC,",")-1 S A0=$P(DIC,",",A1) S:A0["""" A0=$P(A0,"""")_""""""_$P(A0,"""",2)_""""""_$P(A0,"""",3) S Y=Y_A0_","
 ;
 ; Build screen to select only pointed-to entries.
 K DIC("S") N DICODE S DICODE=""
 I DIC(0)'["L"!'$D(DICR(DICR,"V")) D
 . N DIX S DIX=""""_D_"""" D
 . . I $G(DINDEX("#"))>1 D BLDC^DICM0("("_DIVDIC,DIX,DINDEX("#"),DIFILEI,Y,.DICODE,.DICR) Q
 . . S DICODE="X ""I 0"" N "_%_$S($D(DICR(DICR,"S")):",%Y"_DICR,1:"")_" "
 . . S DICODE=DICODE_"F "_%_"=0:0 S "_%_"=$O("_DIVDIC_DIX_",(+Y_"";"_$E(Y,2,99)_"""),"_%_")) Q:"_%_"'>0  I $D("_DIVDIC_%_",0))"
 . . I DIC(0)["T",DICR=1 S DICODE=DICODE_$$CHKTMP^DICM0(.DIC,DICR,DIFILEI,%)
 . . I $D(DICR(DICR,"S")) S DICODE=DICODE_" S %Y"_DICR_"=Y,Y="_%_" X DICR("_DICR_",""S"") S Y=%Y"_DICR_" I "
 . . S DICODE=DICODE_" Q" Q
 . S:DICODE]"" DIC("S")=DICODE Q
 ;
 ; Set DIC(0)
 S %=DIC(0),DIC(0)="D"_$E("M",%'["B") D
 . N I F I="E","O","B","T","V" I %[I S DIC(0)=DIC(0)_I
 . Q
 I %["L",$D(DICR(DICR,"V")),$$OKTOADD^DICM0(DIVDO,.DINDEX,.DIFINDER) D
 . I $P(DIVPDIC,U,6)="y" S DIC(0)=DIC(0)_"L"
 . ; Execute screen code for screened pointer (should set DIC("S")).
 . K D Q:$P(DIVPDIC,U,5)'="y"
 . N DICODE S DICODE=$G(^DD(DIVDO,DIVY,"V",DIVP,1)) Q:DICODE=""
 . N DICSSAV S DICSSAV=$G(DIC("S"))
 . X DICODE
 . S DIC("S")=$G(DIC("S"))_$S(DICSSAV]"":" "_DICSSAV,1:"")
 . Q
 E  K D
 ; If user passed list of indexes to use on pointed-to file, setup.
 S %=$G(DIC("PTRIX",DIFILEI,DINDEX(1,"FIELD"),+DIVPDIC))
 I %]"" N DF,DID S D=% D SETIX^DICM0(.D,.DIC,.DID,.DF)
 S:$G(D)="" D="B" N DISAVED S DISAVED=D
 ;
 ; Write prompt
 I DIC(0)["E" D
 . I $G(DICODE)="" D H1^DIE3 W:'$D(DDS) ! Q
 . D H1 Q
 ;
 ; Set up rest of variables needed for DQ^DICQ or ^DIC call.
 D DO^DIC1
 N DS,DINDEX,DIFILEI
 S D=DISAVED K DISAVED
 ; Handle ? help
 I X?."?" D  D DQ Q
 . S DZ=X_$E("?",'$D(DICR(DICR,"V")))
 . D DQ^DICQ S X=$S($D(DZ):DZ,1:"?"),Y=-1 Q
 ; Do ^DIC call.
 D X^DIC I $D(DUOUT) D DQ Q
 ;
 ; Process output from ^DIC call.
 S X=+Y_";"_$E(DIC,2,99),%=1 K:Y<0 X
 I Y<0,DIC(0)["E",$D(DIVP1),$D(DICR(DICR,"V")) W !
 I '$D(DICR(DICR,"V"))!(DICR>1) K DICR("^",+DIVPDIC) S DIVP(+DIVPDIC)=0
 I Y>0,'DIVPSEL(DICR),DIC(0)["E",'$P(Y,U,3),$P(@(DIC_"0)"),U,2)'["O" D
 . N I F I=(DICR-1):-1 Q:'$D(DIVPSEL(I))  S DIVPSEL(I)=1
 . D S1^DIE3 I $G(%Y)?1"^^".E S (DIROUT,DUOUT)=1
 . Q
DQ I $D(DIC("PTRIX")) M DIV("PTRIX")=DIC("PTRIX")
 K A0,A1,DIC,DO S DIC=DIVDIC,D=$S($D(DICR(DICR,4)):DICR(DICR,4),1:"B")
 S DIC(0)=DICR(DICR,0)
 F %="V","PTRIX" I $D(DIV(%)) M DIC(%)=DIV(%)
 Q
 ;
H1 W:'$D(DDS) !
 N A1,DST,DIPAR S A1="T"
EGP S DIPAR(1)=$$FILENAME^DIALOGZ(+DIVPDIC),DIPAR(2)=$$LABEL^DIALOGZ(DIVDO,DIVY) ;**CCO/NI NAME OF FILE, AND VARIABLE-POINTER FIELD THAT POINTS TO IT
 S DST=$$EZBLD^DIALOG(8097,.DIPAR)
 D S^DIE3 W:'$D(DDS) ! Q
 ;
 ;8070 Searching for a |1|
 ;8097 Searching for a |1|, (pointed-to by |2|)
 ;
