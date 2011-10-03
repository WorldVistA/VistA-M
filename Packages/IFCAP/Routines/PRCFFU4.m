PRCFFU4 ;WISC/SJG-FMS DOCUMENT GENERATION CONT ;6/30/93  10:34
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT
 ; No Top Level Entry
FISC ; Post to Fiscal Status of Funds Tracker;
 W ! S %A(1)="Do you wish to post this information to the Fiscal Status of Funds",%A(2)="Tracker",%B="If you answer 'YES', you will be asked the information necessary to post"
 S %B(1)="the code sheet to the Fiscal Status of Funds.  A 'NO' or an '^' will",%B(2)="skip the bypass the posting.",%=2
 D ^PRCFYN G:%'=1 OUT D EN5^PRCFFU41 W ! G OUT
 Q
 ;
OUT K A,B,D,D0,D1,DG,DIC,DIE,DIG,DIH,DIU,DIV,DIW,DLAYGO,DR,I,J,K,N,O,PRCFA("ARCS"),Q,Q1,S,X,X1,XL1,Y,DI,DQ,PRCFCS Q
 Q
SIG ; E-sig asker for Obligation Processing
 I '$D(PRC("PER")) D DUZ^PRCFSITE Q:'%
 I $D(PRCFA("PODA")),+PRCFA("PODA")>0 S POESIG=1
 N MESSAGE S MESSAGE=""
 D ESIG^PRCUESIG(DUZ,.MESSAGE)
 S ESIGMSG=MESSAGE
 G:(MESSAGE=0)!(MESSAGE=-3) FAIL
 I (MESSAGE=-1)!(MESSAGE=-2) S PRCFA("SIGFAIL")="" Q
 Q
FAIL W !!,$C(7),"SIGNATURE CODE FAILURE " S PRCFA("SIGFAIL")="" Q
 Q
