PRCSEZZ ;SF-ISC/LJP-NEW PRCSES - UPDATE SCP BALANCES ;4-3-94/15:55
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
TRANK Q:X']""  S Z(X)=-X G A
TRANS Q:X']""  S Z(X)=X
A D EN Q:'$D(Z)  G:Z("TT")="" EX
 I Z("TT")="A" S Z(X)=-Z(X)
 I Z("TT")="O" S $P(Z("SCPB"),U,Z("SPC"))=$P(Z("SCPB"),U,Z("SPC"))-Z(X),$P(Z("SAMT"),U,Z("SPC"))=$P(Z("SAMT"),U,Z("SPC"))-Z(X) G ST
 I Z("TT")'="O" S $P(Z("SCPB"),U,Z("SPC"))=$P(Z("SCPB"),U,Z("SPC"))+Z(X),$P(Z("SAMT"),U,Z("SPC"))=$P(Z("SAMT"),U,Z("SPC"))+Z(X) G ST
 ;
 Q
EN G:'$D(DA(1)) EX G:'$D(^PRCS(410,DA(1),0)) EX S Z=^(0) G:'+Z EX G:'$D(^(7)) EX S Z(7)=^(7),Z("SER")=$P(Z(7),U,6)
 G:'$D(^PRCS(410,DA(1),12,0)) EX G:'$D(^PRCS(410,DA(1),12,DA,0)) EX S Z("SCP")=+^(0) G:'$D(^PRCS(410.4,Z("SCP"),0)) EX
 S Z("QT")=$P(Z,"-",3) S:$D(CURQTR) Z("QT")=CURQTR
 S Z("ST")=+Z,Z("CP")=+$P(Z,"-",4),Z("FY")=$P(Z,"-",2),Z("AMT")=X,Z("TT")=$P(Z,U,2),Z("SPC")=Z("QT")+1
 ;
 S:'$D(^PRC(420,Z("ST"),1,Z("CP"),4,0)) ^(0)="^420.06A^^"
 I '$D(^PRC(420,Z("ST"),1,Z("CP"),4,Z("FY"),0)) S ^(0)=Z("FY")_"^0^0^0^0^0^0^0^0",$P(^(0),U,3,4)=Z("FY")_U_($P(^PRC(420,Z("ST"),1,Z("CP"),4,0),U,4)+1),^PRC(420,Z("ST"),1,Z("CP"),4,"B",Z("FY"),Z("FY"))=""
 S Z("CPB")=^PRC(420,Z("ST"),1,Z("CP"),4,Z("FY"),0)
 S:'$D(^PRC(420,Z("ST"),1,Z("CP"),4,Z("FY"),1)) ^(1)="^0^0^0^0" S Z("SCPB")=^(1)
 S:'$D(^PRCS(410.4,Z("SCP"),1,0)) ^(0)="^410.42A^^" I '$D(^PRCS(410.4,Z("SCP"),1,Z("FY"),0)) S ^(0)=Z("FY")_"^0^0^0^0",$P(^(0),U,3,4)=Z("FY")_U_($P(^PRC(420,Z("ST"),1,Z("CP"),4,0),U,4)+1)
 S Z("SAMT")=^PRCS(410.4,Z("SCP"),1,Z("FY"),0)
 Q
ST S ^PRC(420,Z("ST"),1,Z("CP"),4,Z("FY"),0)=Z("CPB"),^PRC(420,Z("ST"),1,Z("CP"),4,Z("FY"),1)=Z("SCPB"),^PRCS(410.4,Z("SCP"),1,Z("FY"),0)=Z("SAMT")
EX K Z Q
SCP Q:'$D(^PRCS(410,N1,12,0))  S N2="",X2=0
 F PRCSJ=1:1 S N2=$O(^PRCS(410,N1,12,N2)) Q:N2'>0  Q:'$D(^(N2,0))  S X2=$P(^(0),U,2),PRC("SCP")=+^(0) D 1
EX1 K N2,X2,PRCSJ,PRC("SCP"),PRC("BSCPB"),PRC("SCPB") Q
1 S:'$D(^PRCS(410.4,PRC("SCP"),1,0)) ^(0)="^410.42A^^" S:'$D(^PRCS(410.4,PRC("SCP"),1,PRC("FY"),0)) ^(0)=PRC("FY")_"^0^0^0^0"
 I T="A" S X=-X,Z=-Z
 I T="O" S $P(PRC("SCPB"),U,PRC("SPC"))=$P(PRC("SCPB"),U,PRC("SPC"))-X2,$P(PRC("BSCPB"),U,Z("SPC"))=$P(PRC("BSCPB"),U,Z("SPC"))-X2
 I T'="O" S $P(PRC("SCPB"),U,PRC("SPC"))=$P(PRC("SCPB"),U,PRC("SPC"))+X2,$P(PRC("BSCPB"),U,Z("SPC"))=$P(PRC("BSCPB"),U,Z("SPC"))+X2
 S ^PRCS(410.4,PRC("SCP"),1,PRC("FY"),0)=PRC("SCPB"),^PRC(420,PRC("SITE"),1,+PRC("CP"),4,PRC("FY"),1)=PRC("BSCPB") Q
