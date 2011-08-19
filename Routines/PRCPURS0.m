PRCPURS0 ;WISC/RFJ-ask sort, select acct, select nsn, select item   ;17 May 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SORTBY() ;  select type of sort
 N DIR,X,Y
 S DIR(0)="S^1:ACCOUNT CODE;2:NSN",DIR("A")="Sort BY",DIR("B")="ACCOUNT CODE" D ^DIR K DIR I Y'=1,Y'=2 Q 0
 Q +Y
 ;
 ;
SUMMARY() ;  print summary only
 N %,X
 K X S X(1)="Display Summary or ALL Data." D DISPLAY^PRCPUX2(2,40,.X)
 S XP="Do you want to print a summary only",XH="Enter 'YES' to print a summary, 'NO' to print entire report, '^' to exit."
 S %=$$YN^PRCPUYN(1)
 Q $S(%=1:1,%=2:0,1:-1)
 ;
 ;
ACCTSEL ;  pick account codes or all
 ;  returns array of accounts selected
 N %,A,DIR,DIRUT,DTOUT,DUOUT,PRCPEXIT,PRCPFLAG,PRCPLINE,X,Y
 S PRCPLINE="",$P(PRCPLINE,"-",78)=""
 K ACCOUNT
 F %=1,2,3,6,8 S ACCOUNT("NO",%)=""
 F  D  I $G(PRCPFLAG) Q
 .   W !
 .   I $O(ACCOUNT("YES",0)) D
 .   .   W !?2,PRCPLINE,!?2,"| Currently selected account codes   :  "
 .   .   S A=0 F  S A=$O(ACCOUNT("YES",A)) Q:'A  W A W:$O(ACCOUNT("YES",A)) ",  "
 .   .   W ?78,"|",!?2,"| You can DE-select one of the above account codes by reselecting it.",?78,"|"
 .   I $O(ACCOUNT("NO",0)) D
 .   .   W !?2,PRCPLINE,!?2,"| Currently DE-selected account codes:  "
 .   .   S A=0 F  S A=$O(ACCOUNT("NO",A)) Q:'A  W A W:$O(ACCOUNT("NO",A)) ",  "
 .   .   W ?78,"|",!?2,"| You can RE-select one of the above account codes by reselecting it.",?78,"|"
 .   W !?2,PRCPLINE
 .   S DIR(0)="SBO^1:Account Code 1;2:Account Code 2;3:Account Code 3;6:Account Code 6;8:Account Code 8;",DIR("A")="Select ACCOUNT Code" D ^DIR I $D(DTOUT)!($D(DUOUT)) S (PRCPFLAG,PRCPEXIT)=1 Q
 .   S Y=+Y
 .   I Y=0,'$O(ACCOUNT("YES",0)) D  I %=0 S (PRCPFLAG,PRCPEXIT)=1 Q
 .   .   S %=$$ALLACCT I %=0 Q
 .   .   I %=1 K ACCOUNT("NO") F %=1,2,3,6,8 S ACCOUNT("YES",%)=""
 .   I Y=0 S PRCPFLAG=1 Q
 .   I $D(ACCOUNT("YES",Y)) K ACCOUNT("YES",Y) S ACCOUNT("NO",Y)="" W !?10,"DE-selected !" Q
 .   I $D(ACCOUNT("NO",Y)) K ACCOUNT("NO",Y) S ACCOUNT("YES",Y)="" W !?10,"RE-selected !" Q
 .   S ACCOUNT("YES",Y)="" W !?10,"selected !"
 I $G(PRCPEXIT) K ACCOUNT
 K ACCOUNT("NO")
 W !!,"*** Selected Account Codes:  " I '$O(ACCOUNT("YES",0)) W "<<NONE>>" Q
 S A=0 F  S A=$O(ACCOUNT("YES",A)) Q:'A  W A W:$O(ACCOUNT("YES",A)) ",  " S ACCOUNT(A)=""
 K ACCOUNT("YES")
 Q
 ;
ALLACCT() ;  select all account codes
 ;  returns 1 for yes, 2 for no, 0 for ^
 S XP="Do you want to select ALL account codes",XH="Enter 'YES' to select all account codes, 'NO' to not select all account codes."
 W !
 Q $$YN^PRCPUYN(1)
 ;
 ;
NSNSEL ;  start with and end with nsn
 ;  returns prcpstrt and prcpend
 N PRCPFLAG,X
 K PRCPSTRT,PRCPEND
 F  D  Q:$G(PRCPFLAG)
 .   W !,"START with NSN: FIRST// " R X:DTIME I '$T!(X["^") S PRCPFLAG=1 Q
 .   I X["?" W !?2,"Select the starting NSN value.  If you select the default FIRST entry, NULL",!?2,"NSN entries will be selected.  If you select 6505, all NSNs starting with",!?2,"6505 will be selected." Q
 .   I X'="",'$$NSNCHECK(X) W !?5,"Invalid NSN format.  Format should be in the form 6505-22-333-4444." Q
 .   S PRCPSTRT=X,PRCPFLAG=1
 I '$D(PRCPSTRT) Q
 K PRCPFLAG
 F  D  Q:$G(PRCPFLAG)
 .   W !,"  END with NSN: LAST// " R X:DTIME I '$T!(X["^") S PRCPFLAG=1 Q
 .   I X=" " S X=PRCPSTRT W "  ",X
 .   I X["?" D  Q
 .   .   W !?2,"Select the ending NSN value."
 .   .   I PRCPSTRT="" Q
 .   .   W "  If you start with ",PRCPSTRT," and end with ",PRCPSTRT,",",!?2,"you will only select NSNs which begin with ",PRCPSTRT,"."
 .   .   W !,"  Also, enter the <space bar> to set the ending NSN equal to the starting NSN."
 .   I X'="",'$$NSNCHECK(X) W !?5,"Invalid NSN format.  Format should be in the form 6505-22-333-4444." Q
 .   I X="" S X="z"
 .   I PRCPSTRT]X W !?4,"Ending NSN must follow starting NSN." Q
 .   S PRCPEND=X,PRCPFLAG=1
 I '$D(PRCPEND) K PRCPSTRT Q
 Q
 ;
NSNCHECK(V1) ;  nsn format check
 I V1?4N Q 1
 I V1?4N1"-"2UN Q 1
 I V1?4N1"-"2UN1"-"3N Q 1
 I V1?4N1"-"2UN1"-"3N1"-"4N.A Q 1
 Q 0
