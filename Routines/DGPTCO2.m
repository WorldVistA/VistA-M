DGPTCO2 ;ALB/MJK - Census Status Report ; 15 APR 90
 ;;5.3;Registration;;Aug 13, 1993
 ;
DIV ; -- ask for div to print
 K DGCHOICE("DIV")
 I $D(^DG(43,1,"GL")),'$P(^("GL"),U,2) S DGCHOICE("DIV")=1 G DIVQ
 S DIC="^DG(40.8,",VAUTNI=2,VAUTSTR="division",VAUTVB="DGCHOICE(""DIV"")"
 D FIRST^VAUTOMA,CHK:Y=-1
DIVQ Q
 ;
CHK ; -- ask how far to ^ out
 I DGCHOICE("DIV")=0,'$O(DGCHOICE("DIV",0)) G CHK1
ASK W !!,"Continue using your selection(s)" S %=2 D YN^DICN G CHKQ:%=1
 I '% W !?5,"Answer 'YES' to use selections you made or 'NO' to stop process." G ASK
CHK1 K DGCHOICE("DIV")
CHKQ Q
 ;
STATUS ; -- ask for status to print
 K DGCHOICE("STATUS")
 S DIR(0)="SA^0:Open;1:Closed;2:Released;3:Transmitted;9:All",DIR("A")="Census Status: ",DIR("B")="All"
 S DIR("?",1)="Select one of the following:"
 S DIR("?",2)="      0 - for only 'Open'        records"
 S DIR("?",3)="      1 - for only 'Closed'      records"
 S DIR("?",4)="      2 - for only 'Released'    records"
 S DIR("?",5)="      3 - for only 'Transmitted' records"
 S DIR("?")="  OR  9 - to select ALL statuses"
 W ! D ^DIR G STATUSQ:$D(DTOUT)!$D(DUOUT)
 S DGCHOICE("STATUS")=$P($P(DIR(0),Y_":",2),";")
STATUSQ K DIR Q
 ;
