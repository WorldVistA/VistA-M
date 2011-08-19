PRSATVC ; HISC/REL-VCS Commission Sales ;12/15/00
 ;;4.0;PAID;**64**;Sep 21, 1995
 S PRSTLV=2 D ^PRSAUTL G:TLI<1 EX
D1 S %DT="AEPX",%DT("A")="Posting Date: ",%DT("B")="T-1",%DT(0)=-DT W ! D ^%DT
 G:Y<1 EX S D1=Y S Y=$G(^PRST(458,"AD",D1)),PPI=$P(Y,"^",1)
 I PPI="" W !!,*7,"Pay Period is Not Open Yet!" G EX
N1 D NME G EX:DFN<0,N1:'DFN
 I "T"'[STAT W *7,!,"This Employee has already been released to Payroll!" G N1
 D POST G N1
NME K DIC S DIC("A")="Select EMPLOYEE: ",DIC("S")="I $P(^(0),""^"",8)=TLE,$D(^PRST(458,PPI,""E"",+Y))",DIC(0)="AEQM",DIC="^PRSPC(",D="ATL"_TLE W ! D IX^DIC S DFN=+Y K DIC
 Q:DFN<1  D ^PRSAENT I '$E(ENT,38) W !!?5,"VCS Commission Sales not Valid for this Employee." S DFN=0 Q
 S STAT=$P($G(^PRST(458,PPI,"E",DFN,0)),"^",2) Q
POST ; Post Sales for Pay Period
 S DTE=$P($G(^PRST(458,PPI,2)),"^",1)_" to "_$P($G(^(2)),"^",14)
 K AUR S AUR(1)=$G(^PRST(458,PPI,"E",DFN,2))
 S DDSFILE=458,DDSFILE(1)=458.01,DA(1)=PPI,DA=DFN
 S DR="[PRSA VC POST]" D ^DDS K DS Q:$G(^PRST(458,PPI,"E",DFN,2))=AUR(1)
 D NOW^%DTC S NOW=% S $P(^PRST(458,PPI,"E",DFN,2),"^",15,16)=DUZ_"^"_NOW Q
PRP ; Prior Pay Period Update
 S PRSTLV=2 D ^PRSAUTL G:TLI<1 EX D NOW^%DTC S DT=%\1,NOW=%
 S %DT="AEPX",%DT("A")="Posting Date: ",%DT(0)=-DT W ! D ^%DT
 G:Y<1 EX S D1=Y S Y=$G(^PRST(458,"AD",D1)),PPI=$P(Y,"^",1)
 I PPI="" W !!,*7,"Pay Period is Not Open Yet!" G EX
 D NME G:DFN<1 EX
 I "T"[STAT D POST G EX
 I STAT'="X" W !!,*7,"Card in Payroll and not transmitted; request return of card." Q
 S Z=$G(^PRST(458,PPI,"E",DFN,2))
 D POST I $G(^PRST(458,PPI,"E",DFN,2))'=AUR(1) D
 .S AUT="V",AUS="R" D ^PRSAUD ; Approve, Notify Payroll
 .I $G(AUR(7))["^" K ^PRST(458,PPI,"E",DFN,2) I $D(AUR(1)) D
 ..S ^PRST(458,PPI,"E",DFN,2)=AUR(1)
 G EX
EX G KILL^XUSCLEAN
