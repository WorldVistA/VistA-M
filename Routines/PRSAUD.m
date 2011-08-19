PRSAUD ; HISC/REL-File Audit Record ;8/30/95  09:48
 ;;4.0;PAID;;Sep 21, 1995
 I AUT'="H" S DIR(0)="F^3:60",DIR("A")="Corrected Time Card Remarks" W ! D ^DIR S AUR(7)=Y I Y["^" W !!,"Abort.  Correction is not being filed." Q
 I '$D(^PRST(458,PPI,"E",DFN,"X")) S ^PRST(458,PPI,"E",DFN,"X",0)="^458.1101A^^"
 L +^PRST(458,PPI,"E",DFN,"X",0) S AUN=$P(^PRST(458,PPI,"E",DFN,"X",0),"^",3)+1,$P(^(0),"^",3,4)=AUN_"^"_AUN L -^PRST(458,PPI,"E",DFN,"X",0)
 S ^PRST(458,PPI,"E",DFN,"X",AUN,0)=AUN_"^"_NOW_"^"_DUZ_"^"_AUT_"^"_AUS
 F AUDN=1:1:7 I $D(AUR(AUDN)) S ^PRST(458,PPI,"E",DFN,"X",AUN,AUDN)=AUR(AUDN)
 S:"ARS"[AUS ^PRST(458,"AX"_AUS,DFN,PPI,AUN)="" D UPD^PRSASAL:AUS="R",APP^PRSASAL:AUS="S"
 K AUDN,AUN,AUT,AUR,AUS Q
