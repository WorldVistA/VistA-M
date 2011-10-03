QAQAHOC2 ;HISC/DAD-AD HOC REPORTS: SORT FROM/TO SELECTION ;2/8/93  13:10
 ;;1.7;QM Integration Module;**1**;07/25/1995
BEGIN ; *** Prompt user for the beginning sort value
 K DIR S DIR(0)=QAQDIR(0),DIR("A")="     Sort from: BEGINNING// ",DIR("?")="^D EN^QAQAHOCH(""H3"")"
 W ! D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT)!(X["^") S (QAQNEXT,QAQQUIT)=1 Q
 I "PD"[$E(DIR(0)),X]"",X'="@",Y=-1 G BEGIN
 S QAQBEGIN=$S(X="":"",X="@":"@",1:$E(Y,1,60))
 I QAQBEGIN="" S QAQEND="" G FROMTO
END ; *** Prompt user for the ending sort value
 K DIR S DIR(0)=QAQDIR(0),DIR("A")="     Sort to:   ENDING// ",DIR("?")="^D EN^QAQAHOCH(""H4"")"
 W ! D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT)!(X["^") S (QAQNEXT,QAQQUIT)=1 Q
 I "PD"[$E(DIR(0)),X]"",X'="@",Y=-1 G END
 S QAQEND=$S(X="":"",X="@":"@",1:$E(Y,1,60))
 I QAQEND]"",QAQBEGIN'=QAQEND D  G:QA BEGIN
 . S (X,Y)=QAQBEGIN,%DT="TS" D:$E(DIR(0))="D" ^%DT S QAQBEGIN(0)=Y
 . S (X,Y)=QAQEND,%DT="TS" D:$E(DIR(0))="D" ^%DT S QAQEND(0)=Y
 . I QAQEND(0)']QAQBEGIN(0) D
 .. W " ??",*7,!!?7,"The ENDING value must follow the BEGINNING value !!"
 .. S QA=1
 .. Q
 . E  S QA=0
 . Q
FROMTO ; *** Set the FR and TO sort strings
 S FR(QAQSEQ)=QAQBEGIN,TO(QAQSEQ)=QAQEND,QAQBEGIN(QAQSEQ)=QAQBEGIN,QAQEND(QAQSEQ)=QAQEND
 Q
DIR ; *** DIR begining/ending sort input transforms
DATE I Y S:Y#1 Y=$J(Y,0,6) S Y=$S($E(Y,4,5):$E(Y,4,5)_"/",1:"")_$S($E(Y,6,7):$E(Y,6,7)_"/",1:"")_(1700+$E(Y,1,3))_$S(Y#1:"@"_$E(Y,9,10)_":"_$E(Y,11,12)_":"_$E(Y,13,14),1:"")
 Q
POINTER I $D(Y(0,0))#2 S Y=Y(0,0)
 Q
SET ;I $D(Y(0))#2 S Y=$P(Y(0),"^")
 Q
FIX ; *** Process the sort/print suffixes and prefixes
SUFFIX S QAQSUFFX=$P(QAQSELOP,";",2,99),QAQPREFX=""
 I QAQSUFFX="" G:QAQSELOP'[";" PREFIX S QAQSELOP="" Q
 F QA="L","R","C","Y","D","S","W","N","T","X","""" I $L(";"_QAQSUFFX,";"_QA)>2 S QAQSELOP="" Q
 Q:QAQSELOP=""
 F QAI=1:1:$L(QAQSUFFX,";") D  Q:'QAQOK
 . S X=$P(QAQSUFFX,";",QAI),QAQOK=0
 . F QA="S","L","C" S Y="1"""_QA_"""1.N" I X?@Y S QAQOK=1 Q
 . S:X="S" QAQOK=1 I X?1"""".ANP1"""",$L(X,"""")#2 S QAQOK=1
 . Q:QAQTYPE="S"
 . F QA="R","Y","D","W","C-","Y-" S Y="1"""_QA_"""1.N" I X?@Y S QAQOK=1 Q
 . F QA="N","T","W","X" I X=QA S QAQOK=1 Q
 . Q
 I 'QAQOK S QAQSELOP="" Q
 I QAQSUFFX["""" D
 . S QAQSUFFX(1)=$P($S($E(QAQSUFFX)="""":";",1:"")_QAQSUFFX,";""")
 . S QAQSUFFX(2)=$P($S($E(QAQSUFFX)="""":";",1:"")_QAQSUFFX,";""",2,99)
 . S QAQSUFFX(3)=$P(QAQSUFFX(2),";")
 . S QAQSUFFX(2)=$P(QAQSUFFX(2),";",2,99)
 . S QAQSUFFX=QAQSUFFX(1)_$S(QAQSUFFX(2)]"":";"_QAQSUFFX(2),1:"")_";"""_QAQSUFFX(3)
 . Q
 S:$E(QAQSUFFX)'=";" QAQSUFFX=";"_QAQSUFFX
PREFIX S QAQSELOP=$P(QAQSELOP,";")
 S QAQPREFX=$TR(QAQSELOP,$TR(QAQSELOP,QAQPREFX(0)))
 I QAQPREFX]"" F QA=1:1:$L(QAQPREFX(0)) I $L(QAQPREFX,$E(QAQPREFX(0),QA))>2 S QAQSELOP="" Q
 S QAQSELOP=$E(QAQSELOP,$F(QAQSELOP_"^",$E($TR(QAQSELOP,QAQPREFX(0))_"^"))-1,999)
 Q
