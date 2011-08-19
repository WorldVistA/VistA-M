PRCBRBR ;WISC@ALTOONA/CTB/SAW-RUNNING BALANCE FOR FISCAL ;4/11/93  1:56 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S %A="For ALL Control Points",%B="A 'YES' will print/display balances for all control points for the Station",%B(1)="Number, Fiscal Year and Quarter selected.  A 'NO' will allow you to"
 S %B(2)="print or display a Running Balance or Summary report for an individual",%B(3)="Control Point.  Enter an '^' to QUIT.",%=2 D ^PRCFYN Q:%<0  G:%=1 QALL^PRCBCPR
CPB ;CONTROL POINT BALANCE
 D EN1^PRCBSUT G:Y<0 EXIT1 S ZX=Z K C1
CPB1 S %A="Summary Balances Report Only",%B="",%=1 D ^PRCFYN
 G EXIT1:%<0 I %=1 S C1=1,ZTRTN="QUE^PRCSP1A"
 E  S ZTRTN="QUE^PRCSP1A"
 S (Z,PRCFZ,PRCSZ)=ZX,PRCFC=C K ZX S ZTDESC="FISCAL RUNNING BALANCE REPORT",ZTSAVE("PRC*")="",ZTSAVE("C*")="",ZTSAVE("Z*")="",ZTSAVE("PRCFZ")="",ZTSAVE("PRCSZ")="",ZTSAVE("PRCFC")="" D ^PRCFQ,EXIT1 G CPB
EXIT1 K %,%IS,%DT,BY,C0,C1,C2,C3,D,D0,DA,DHD,DIC,DIE,P,PRCF,PRCFZ,PRCSZ,PRCFC,PRCS,PRCSDEQ,FLDS,FR,I,IOP,L,N,T,TO,X,X1,Y,Z,Z1 Q
