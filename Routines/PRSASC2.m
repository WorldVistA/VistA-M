PRSASC2 ; HISC/REL-Post Environmental Diff. ;1/20/95  12:43
 ;;4.0;PAID;;Sep 21, 1995
 S Z=^PRST(458.3,DA,0),TYP=$P(Z,"^",7),D1=$P(Z,"^",3)
 S Y=$G(^PRST(458,"AD",+D1)),PPI=$P(Y,"^",1),DAY=$P(Y,"^",2)
 S STAT=$P($G(^PRST(458,PPI,"E",DFN,0)),"^",2) I STAT'="","X"[STAT G PRP
 D POST Q
POST S X=$P(Z,"^",4)_"^"_$P(Z,"^",6) D CNV^PRSATIM S TIM=$P(Y,"^",2)-$P(Y,"^",1)-$P(Z,"^",5)/60 Q:TIM'>0
 K AUR S (Z,AUR(1))=$G(^PRST(458,PPI,"E",DFN,4)),L1=$S(DAY<8:1,1:7)
 F L2=L1:2:L1+4 Q:$P(Z,"^",L2)=""  I $P(Z,"^",L2)=TYP Q
 S:'$P(Z,"^",L2) $P(Z,"^",L2)=TYP S TIM=TIM+$P(Z,"^",L2+1),$P(Z,"^",L2+1)=TIM
 S ^PRST(458,PPI,"E",DFN,4)=Z I STAT="P" K ^(5) D ONE^PRS8 S ^PRST(458,PPI,"E",DFN,5)=VAL
 Q
PRP ; Prior Pay Period
 D POST I AUR(1)'=$G(^PRST(458,PPI,"E",DFN,4)) S AUT="H",AUS="S" D ^PRSAUD ; Notify Payroll
 Q
