PRSAPEM ; HISC/REL-Post Miscellaneous ;3/10/93  12:50
 ;;4.0;PAID;;Sep 21, 1995
 K DIC S DIC="^PRST(458,",DIC(0)="AEQM",DIC("A")="Select PAY PERIOD: " W ! D ^DIC K DIC G:Y<1 EX
 S PPI=+Y,PPE=$P($G(^PRST(458,PPI,0)),"^",1)
NME K DIC S DIC("A")="Select EMPLOYEE: ",DIC("S")="I $D(^PRST(458,PPI,""E"",+Y))",DIC(0)="AEQM",DIC="^PRSPC(" W ! D ^DIC S DFN=+Y K DIC
 I DFN<1 G EX
 I $P($G(^PRST(458,PPI,"E",DFN,0)),"^",2)="X" W *7,!!,"This Employee has already been transmitted by Payroll." G NME
P3 K DDSFILE,DA,DR S DDSFILE=458,DDSFILE(1)=458.01,DA(1)=PPI,DA=DFN
 S DR="[PRSA PM POST]" D ^DDS K DS
 I $P($G(^PRST(458,PPI,"E",DFN,0)),"^",2)="P" K ^(5) D ONE^PRS8 S ^PRST(458,PPI,"E",DFN,5)=VAL
EX G KILL^XUSCLEAN
