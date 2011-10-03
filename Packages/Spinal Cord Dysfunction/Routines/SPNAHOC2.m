SPNAHOC2 ;HISC/DAD-AD HOC REPORTS: SORT FROM/TO SELECTION ;9/9/96  14:01
 ;;2.0;Spinal Cord Dysfunction;**15**;01/02/1997
 ;
BEGIN ; *** Prompt user for the beginning sort value
 K DIR S DIR(0)=SPNDIR(0),DIR("A")="     Sort from: BEGINNING// "
 I $G(SPNDIR("S"))]"" S DIR("S")=SPNDIR("S")
 S DIR("?")="^D EN^SPNAHOCH(""H3"")"
 W ! D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT)!(X[U) S (SPNNEXT,SPNQUIT)=1 Q
 I "PD"[$E(DIR(0)),X]"",X'="@",Y=-1 G BEGIN
 S SPNBEGIN=$S(X="":"",X="@":"@",1:$E(Y,1,60))
 I ((Y?4N)&(Y>1900))!($E(Y,3)="/") D 
 .I $L(SPNBEGIN)=4 S SPNBEGIN="01/01/"_SPNBEGIN
 .I $L(SPNBEGIN)<10 S SPNBEGIN=$P(SPNBEGIN,"/",1)_"/"_$P(SPNBEGIN,"/",2)
 .I $E(SPNBEGIN,4,5)="01" S $P(SPNBEGIN,"/",2)=""
 I SPNBEGIN="" S SPNEND="" G FROMTO
END ; *** Prompt user for the ending sort value
 K DIR S DIR(0)=SPNDIR(0),DIR("A")="     Sort to:   ENDING// "
 I $G(SPNDIR("S"))]"" S DIR("S")=SPNDIR("S")
 S DIR("?")="^D EN^SPNAHOCH(""H4"")"
 W ! D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT)!(X[U) S (SPNNEXT,SPNQUIT)=1 Q
 I "PD"[$E(DIR(0)),X]"",X'="@",Y=-1 G END
 S SPNEND=$S(X="":"",X="@":"@",1:$E(Y,1,60))
 I ((Y?4N)&(Y>1900))!($E(Y,3)="/") D 
 .I $L(SPNEND)=4 S SPNEND="12/31/"_SPNEND
 .I $L(SPNEND)<10 S SPNENDZ=SPNEND,SPNENDM=+$E(SPNEND,1,2),SPNENDM=$S("^01^03^05^07^08^10^12^"[(U_SPNENDM_U):31,SPNENDM'=02:30,$E(SPNENDZ,4,7)#4:28,1:29)
 .I $L(SPNEND)<10 S SPNEND=$P(SPNEND,"/",1)_"/"_SPNENDM_"/"_$P(SPNEND,"/",2)
 I SPNEND]"",SPNBEGIN'=SPNEND D  G:SP BEGIN
 . S (X,Y)=SPNBEGIN,%DT="TS" D:$E(DIR(0))="D" ^%DT S SPNBEGIN(0)=Y
 . S (X,Y)=SPNEND,%DT="TS" D:$E(DIR(0))="D" ^%DT S SPNEND(0)=Y
 . I SPNEND(0)']SPNBEGIN(0) D
 .. S SP=1 W " ??",$C(7)
 .. W !!?7,"The ENDING value must follow the BEGINNING value !!"
 .. Q
 . E  S SP=0
 . Q
FROMTO ; *** Set the FR and TO sort strings
 S FR(SPNSEQ)=SPNBEGIN,TO(SPNSEQ)=SPNEND
 Q
DIR ; *** DIR begining/ending sort input transforms
DATE I Y S:Y#1 Y=$J(Y,0,6) S Y=$S($E(Y,4,5):$E(Y,4,5)_"/",1:"")_$S($E(Y,6,7):$E(Y,6,7)_"/",1:"")_(1700+$E(Y,1,3))_$S(Y#1:"@"_$E(Y,9,10)_":"_$E(Y,11,12)_":"_$E(Y,13,14),1:"")
 Q
POINTER I $D(Y(0,0))#2 S Y=Y(0,0)
 Q
SET ;I $D(Y(0))#2 S Y=$P(Y(0),U)
 Q
FIX ; *** Process the sort/print suffixes and prefixes
SUFFIX S SPNSUFFX=$P(SPNSELOP,";",2,99),SPNPREFX=""
 I SPNSUFFX="" G:SPNSELOP'[";" PREFIX S SPNSELOP="" Q
 F SP="L","R","C","Y","D","S","W","N","T","X","""" D  Q:SPNSELOP=""
 . I $L(";"_SPNSUFFX,";"_SP)>2 S SPNSELOP=""
 . Q
 Q:SPNSELOP=""
 F SPI=1:1:$L(SPNSUFFX,";") D  Q:'SPNOK
 . S X=$P(SPNSUFFX,";",SPI),SPNOK=0
 . F SP="S","L","C" S Y="1"""_SP_"""1.N" I X?@Y S SPNOK=1 Q
 . S:X="S" SPNOK=1 I X?1"""".ANP1"""",$L(X,"""")#2 S SPNOK=1
 . I SPNTYPE="S" S:X="TXT" SPNOK=1 Q
 . F SP="R","Y","D","W","C-","Y-" S Y="1"""_SP_"""1.N" I X?@Y S SPNOK=1 Q
 . F SP="N","T","W","X" I X=SP S SPNOK=1 Q
 . Q
 I 'SPNOK S SPNSELOP="" Q
 I SPNSUFFX["""" D
 . S SPNSUFFX(1)=$P($S($E(SPNSUFFX)="""":";",1:"")_SPNSUFFX,";""")
 . S SPNSUFFX(2)=$P($S($E(SPNSUFFX)="""":";",1:"")_SPNSUFFX,";""",2,99)
 . S SPNSUFFX(3)=$P(SPNSUFFX(2),";")
 . S SPNSUFFX(2)=$P(SPNSUFFX(2),";",2,99)
 . S SPNSUFFX=SPNSUFFX(1)_$S(SPNSUFFX(2)]"":";"_SPNSUFFX(2),1:"")_";"""_SPNSUFFX(3)
 . Q
 S:$E(SPNSUFFX)'=";" SPNSUFFX=";"_SPNSUFFX
PREFIX S SPNSELOP=$P(SPNSELOP,";")
 S SPNPREFX=$TR(SPNSELOP,$TR(SPNSELOP,SPNPREFX(0)))
 I SPNPREFX]"" F SP=1:1:$L(SPNPREFX(0)) D  Q:SPNSELOP=""
 . I $L(SPNPREFX,$E(SPNPREFX(0),SP))>2 S SPNSELOP=""
 . Q
 S SPNSELOP=$E(SPNSELOP,$F(SPNSELOP_U,$E($TR(SPNSELOP,SPNPREFX(0))_U))-1,$L(SPNSELOP))
 Q
