QAMUTL1 ;HISC/DAD-MONITORING TOOL UTILITIES ;6/8/93  12:24
 ;;1.0;Clinical Monitoring System;;09/13/1993
EN1 ; *** DISPLAY HELP SCREEN OF CONDITIONS
 ; *** USED BEFORE EDIT OF CONDITION FOR DATE OF EVENT (743,64)
 Q:$D(^QA(743,DA,"COND",0))[0  Q:$P(^(0),"^",4)'>0
 W !!?3,"NUMBER",?15,"CONDITION",!?2,"--------",?14,"-----------"
 F QAMD1=0:0 S QAMD1=$O(^QA(743,DA,"COND",QAMD1)) Q:QAMD1'>0  S QAM=$S($D(^QA(743,DA,"COND",QAMD1,0))#2:+^(0),1:0),QAM=$S($D(^QA(743.3,QAM,0))#2:$P(^(0),"^"),1:"") W !?3,$J(QAMD1,4,0),?15,QAM
 W !
 Q
EN2 ; *** EDIT A PARAMETER (SCREENED LOOK UP)
 K DIRUT I '$$EXIST(DIC) D  G 2
 . W !!?5,"*** File not found !! ***",*7,!
 . S X="^"
 . Q
 S:DIC(0)["A" DIC(0)=$E(DIC(0),1,$F(DIC(0),"A")-2)_$E(DIC(0),$F(DIC(0),"A"),999) W !,DIC("A"),$S($D(DIC("B"))#2:" "_DIC("B")_"//",1:"")," "
 R X:DTIME S:(X="")&($D(DIC("B"))#2) X=DIC("B")
2 I ('$T)!($E(X)="^") S Y="",DIRUT=1,X=$S($E(X)="^":$E(X),1:"") G EXIT2
 I X="@" D DEL2 K:%=1 DIRUT S:%=1 X="@",Y="" G EN2:%=2,EXIT2:%=1
 D:X?1."?" HELP2 I $D(DIRUT)[0 D ^DIC I Y'>0 G:(X]"")&($E(X)'="^") EN2 S (X,Y)="" G EXIT2
EXIT2 K DIC,DIR Q
DEL2 I $D(^QA(743,QAMD0,"COND",QAMD1,QAMPARAM))[0 W " ??",*7 S %=2 Q
 S %=2 W !?5,*7,"SURE YOU WANT TO DELETE" D YN^DICN W "   ",$S(%=1:"<DELETED>",%=2:"<NOTHING DELETED>",1:"") I '% W !!?10,"Please answer Y(es) or N(o)",! G DEL2
 I %=1 K ^QA(743,QAMD0,"COND",QAMD1,QAMPARAM)
 Q
HELP2 S QA=X N X S X=QA I X?2."?",$D(DIR("??"))#2 S XQH=$P(DIR("??"),"^") D:XQH]"" EN1^XQH K XQH S QAM=$P(DIR("??"),"^",2,999) X:QAM]"" QAM Q
 Q:$D(DIR("?"))[0  I $E(DIR("?"))="^",$P(DIR("?"),"^",2)]"" X $P(DIR("?"),"^",2,999) Q
 I $D(DIR("?"))=11 F QAM=0:0 S QAM=$O(DIR("?",QAM)) Q:QAM'>0  W !?5,DIR("?",QAM)
 S QAMWID=$S($D(IOM)#2:IOM-5,1:75),QAMDIR=DIR("?")
H2 S QA=$L($E(QAMDIR,1,QAMWID+1)," ") W !?5,$P(QAMDIR," ",1,QA) S QAMDIR=$P(QAMDIR," ",QA+1,999) G:QAMDIR]"" H2
 K QAMDIR,QAMWID
 Q
EN3 ; *** EDIT A PARAMETER
 I $E(DIR(0))="P",'$$EXIST(+$P(DIR(0),"^",2)) D  G 3
 . W !!?5,"*** File not found !! ***",*7,!
 . S X="^",DIRUT=1 K DTOUT
 . Q
 K DIRUT D ^DIR S:(Y'>0)&($P(DIR(0),"^")["P") DIRUT=1
3 I $D(DIRUT),'$D(DTOUT) S Y="" K:X="" DIRUT G EXIT3:($E(X)="^")!(X=""),EN3:(X]"")&(X'="@") I X="@" D DEL3 K:%=1 DIRUT G EN3:%=2,EXIT3:%=1
EXIT3 K DIR Q
DEL3 I $D(^QA(743,QAMD0,"COND",QAMD1,QAMPARAM))[0 W " ??",*7 S %=2 Q
 S %=2 W !?5,*7,"SURE YOU WANT TO DELETE" D YN^DICN W "   ",$S(%=1:"<DELETED>",%=2:"<NOTHING DELETED>",1:"") I '% W !!?10,"Please answer Y(es) or N(o)",! G DEL3
 I %=1 K ^QA(743,QAMD0,"COND",QAMD1,QAMPARAM)
 Q
EN4 ; *** DISPLAY CONDITION DESCRIPTION (?CONDITION)
 Q:'$D(X)  Q:(X'?1."?"1.ANP)&(X'?1."?"1."*".E)  D HOME^%ZIS W !
 S QAMLINE=$Y,(QAMCND,QAMCND(0))=$P(X,"?",$L(X,"?")),(QAMFOUND,QAMQUIT)=0
 I $E(QAMCND)'="*" S QAMCND=$E(QAMCND,1,$L(QAMCND)-1)_$C($A(QAMCND,$L(QAMCND))-1)_"~"
 E  S (QAMCND,QAMCND(0))=""
 F QAMCND(1)=0:0 S QAMCND=$O(^QA(743.3,"B",QAMCND)) Q:(QAMCND="")!($P(QAMCND,QAMCND(0))]"")!QAMQUIT  F QAMIFN0=0:0 S QAMIFN0=$O(^QA(743.3,"B",QAMCND,QAMIFN0)) Q:QAMIFN0'>0!QAMQUIT  D 4
 W:'QAMFOUND " ??",*7 W !
 K QAMLINE,QAMCND,QAMFOUND,QAMQUIT,QAMINF0,QAMINF1,CND,DIWL,DIWR,DIWF,^UTILITY($J,"W")
 Q
4 S CND=$S($D(^QA(743.3,QAMIFN0,0))#2:$P(^(0),"^"),1:"") Q:CND=""  S QAMFOUND=1 W !,CND,!,$E("------------------------------",1,$L(CND)) D 41
 K ^UTILITY($J,"W") S DIWL=2,DIWR=78,DIWF="W"
 I $D(^QA(743.3,QAMIFN0,"DESC",0))[0 W !?DIWL-1,"Sorry, no description found for this condition.",! D 41 Q
 F QAMIFN1=0:0 S QAMIFN1=$O(^QA(743.3,QAMIFN0,"DESC",QAMIFN1)) Q:QAMIFN1'>0!QAMQUIT  S X=^QA(743.3,QAMIFN0,"DESC",QAMIFN1,0) D ^DIWP,41
 D:'QAMQUIT ^DIWW D 41
 Q
41 Q:$Y'>(IOSL-3+QAMLINE)  K DIR S DIR(0)="E" D ^DIR S QAMQUIT=$S(Y'>0:1,1:0),QAMLINE=$Y
 Q
EN5 ; *** XECUTABLE HELP FOR 743.42,.02 - DISPLAYS SELECTABLE FIELDS
 S QAM=+^QA(743.4,D0,"DD",D1,0),QA(0)=0,QA("$Y")=$Y,QA("IOSL")=$S($D(IOSL)[0:24,IOSL'>0:24,1:IOSL) F QA=0:0 S QA=$O(^DD(QAM,QA)) Q:QA'>0!QA(0)  W !?5,QA,?15,$P(^DD(QAM,QA,0),"^") D:$Y>(QA("IOSL")+QA("$Y")-2) 1
 K QA,QAM Q
1 S QA("$Y")=$Y R !,"Press RETURN to continue or '^' to exit: ",QA(0):DTIME S QA(0)=$S('$T:1,$E(QA(0))="^":1,1:0) Q
EXIST(DIC) ; *** DOES THE FILE SPECIFIED BY DIC EXIST $S(YES:1,1:0)
 S:DIC DIC=$G(^DIC(DIC,0,"GL"))
 Q $S(DIC="":0,$D(@(DIC_"0)"))#2:1,1:0)
