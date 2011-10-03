QAQAHOC1 ;HISC/DAD-AD HOC REPORTS: SORT/PRINT SELECTION ;3/23/94  12:22
 ;;1.7;QM Integration Module;**1**;07/25/1995
ENASK ; *** Prompt user for sort/print fields
 S QAQNEXT=0 I QAQSEQ>QAQMAXOP(QAQTYPE) W !!?3,"Maximum of ",QAQMAXOP(QAQTYPE)," ",QAQTYPE(0)," fields reached. ",*7 R QA:QAQDTIME S QAQNEXT=1 Q
 S X=$S($G(QAQMHDR)]"":$E(QAQMHDR,1,45)_" ",1:"")_"Ad Hoc Report Generator"
 W @IOF I $G(QAQMHDR)'="@" S Y=$L(X),X(1)="",$P(X(1),"=",70-Y/2)=" ",X(2)=" ",$P(X(2),"=",70-Y/2)="" W "     ",X(1),X,X(2)
 D LIST W !!?3,QAQTYPE(1)," selection # ",QAQSEQ," : " R QAQSELOP:DTIME S:'$T QAQSELOP="^"
 I (QAQSEQ=1)&(QAQSELOP="") D  G:QAQNONE=2 ENASK Q:QAQNEXT
NOTHING . S QAQNONE=2
 . W *7,!!?3,"You have not selected any "
 . W $S(QAQNUMOP("S")'>0:"sort or ",1:""),"print categories !!"
 . W !?3,"Do you wish to exit the program"
 . S %=1 D YN^DICN S QAQNONE=% I '% W !!?5,QAQYESNO G NOTHING
 . Q:%=2
 . S (QAQNEXT,QAQQUIT)=1 W !!?3,"No report will be produced." Q:%=-1
MACOUT . Q:QAQMOUTP'>0
 . W !!?3,"You previously asked for macro output, do you still want it"
 . S %=2 D YN^DICN I '% W !!?5,QAQYESNO G MACOUT
 . D:%=1 EN2^QAQAHOC4
 . Q
 S:QAQSELOP="" QAQNEXT=1 S:$E(QAQSELOP)="^" (QAQNEXT,QAQQUIT)=1 Q:QAQNEXT!QAQQUIT
 I $E(QAQSELOP)="[" D ^QAQAHOC3,HELP:QAQSELOP=-1 Q:QAQNEXT  G:QAQMLOAD'>0 ENASK S QAQNEXT=1 Q
 I QAQSELOP["," D  S QAQNEXT='QAQAGIN Q:QAQNEXT  G ENASK
 . S QAQAGIN=0,QAQLIST=QAQSELOP
 . I QAQSEQ>1 D  S QAQAGIN=1 Q
 .. W !!?3,QAQTYPE(1)," lists may only be entered at the"
 .. W " first ",QAQTYPE(0)," selection prompt !! ",*7 R QA:QAQDTIME
 .. Q
 . I $L(QAQLIST,",")>QAQMAXOP(QAQTYPE) D  S QAQAGIN=1 Q
 .. W !!?3,"Too many ",QAQTYPE(0)," fields chosen !! ",*7 R QA:QAQDTIME
 .. Q
 . F QAQLST=1:1:$L(QAQSELOP,",") D  Q:QAQAGIN
 .. S QAQSELOP=$P(QAQLIST,",",QAQLST),QAQSEQ=QAQLST D CHECK
 .. Q
 . S QAQSEQ=QAQSEQ+1 Q:'QAQAGIN
 . I QAQTYPE="S" K QAQBEGIN,QAQEND
 . K QAQCHOSN,QAQOPTN(QAQTYPE) S QAQSEQ=1
 . Q
 S (QAQAGIN,QAQLST)=0 D CHECK G:QAQAGIN ENASK
 Q
CHECK ; *** Check user's input
 S QAQPREFX(0)=$S(QAQTYPE="S":"+-!#@'",1:"&!+#") D FIX^QAQAHOC2
 S QAQPREFX(QAQTYPE,QAQSEQ)=QAQPREFX,QAQSUFFX(QAQTYPE,QAQSEQ)=QAQSUFFX
 I QAQTYPE="P",$L(QAQPREFX)>1 S (QAQSELOP,QAQPREFX)=""
 I QAQLST'>0 W "   ",$P($G(QAQMENU(+QAQSELOP)),"^",2)
 E  W:QAQTYPE="S" !!?3,"Sort by: ",$P($G(QAQMENU(+QAQSELOP)),"^",2)
 I $S(QAQSELOP<1:1,QAQSELOP>QAQMMAX:1,QAQSELOP'?1.N:1,$D(QAQMENU(QAQSELOP))[0:1,1:0) D HELP S QAQAGIN=1 Q
 I $D(QAQCHOSN(QAQSELOP))#2 D  S QAQAGIN=1 Q
 . W *7,!!?3,"You have already chosen item ",QAQSELOP,", "
 . W $P(QAQMENU(QAQSELOP),"^",2),","
 . W !?3,"as a ",QAQTYPE(0)," field !!  Please re-enter your selection. "
 . R QA:QAQDTIME
 . Q
 I QAQTYPE="S",QAQMENU(QAQSELOP)'>0 W !!?3,"You are not allowed to sort by ",$P(QAQMENU(QAQSELOP),"^",2)," !! ",*7 R QA:QAQDTIME S QAQAGIN=1 Q
 I QAQTYPE="S" S QAQDIR(0)=$P(QAQMENU(QAQSELOP),"^",4,99) D ^QAQAHOC2 I QAQQUIT!QAQNEXT S (QAQQUIT,QAQNEXT)=0 S QAQAGIN=1 Q
 S X=$P(QAQMENU(QAQSELOP),"^",3),X=$P(X,"~")_QAQPREFX_$P(X,"~",2)
 S X(0)=$P(X,";"),X(1)=$P($P(X,";"""),";",2,99),X("T")=$P(X,";""",2)
 S QAQSUFFX(1)=$P(QAQSUFFX,";"""),QAQSUFFX("T")=$P(QAQSUFFX,";""",2)
 S QAQ=X(0)_$S(QAQSUFFX(1)]"":QAQSUFFX(1),X(1)]"":";"_X(1),1:"")
 S X=QAQ_$S(QAQSUFFX("T")]"":";"""_QAQSUFFX("T"),X("T")]"":";"""_X("T"),1:"")
 S QAQOPTN(QAQTYPE,QAQSEQ,QAQSELOP)=X,QAQCHOSN(QAQSELOP)=""
 Q
LIST ; *** Display the sort/print menus
 W ! S QAQ=$Y,QAQMMAX(0)=QAQMMAX#2+QAQMMAX\2
 F QA=1:1:QAQMMAX(0) S QAI=QA,QAQTAB=0 D  S QAI=QA+QAQMMAX(0),QAQTAB=40 D  I $Y>(IOSL+QAQ-4) S QAQ=$Y K DIR S DIR(0)="E" D ^DIR K DIR Q:Y'>0
 . Q:$D(QAQMENU(QAI))[0
 . W:QAQTAB=0 ! W ?QAQTAB,$S(QAQTYPE="P"!QAQMENU(QAI):$J(QAI,2),1:"  ")
 . W $S($D(QAQCHOSN(QAI)):" * ",1:"   "),$P(QAQMENU(QAI),"^",2)
 . Q
 Q
HELP ; *** Display the sort/print help screens
 I $E(QAQSELOP)'="?" W " ??",*7,!
 E  W @IOF
 W !,"Select the ",$S(QAQSEQ=1:$S(QAQTYPE="S":"major",1:"first"),1:"next")," data element to ",$S(QAQTYPE="S":"sort by",1:"print"),".  Maximum of ",QAQMAXOP(QAQTYPE)," ",QAQTYPE(0)," fields allowed."
 W !,QAQBLURB,$S(QAQSEQ>1:", * means already chosen",1:""),".",!
 D:$E(QAQSELOP)="?" EN^QAQAHOCH($S(QAQTYPE="S":"H1",1:"H2"))
 R QA:(2*QAQDTIME)
 Q
