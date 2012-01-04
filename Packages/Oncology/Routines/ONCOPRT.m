ONCOPRT ;Hines OIFO/GWB - OncoTrax reports ;03/07/11
 ;;2.11;ONCOLOGY;**24,25,26,27,36,50,51,52,53**;Mar 07, 1995;Build 31
 ;
 ;This routine invokes Integration Agreement #3151
 ;
SUS ;[SP Print Suspense List by Suspense Date (132c)]
 S BY="@75,INTERNAL(#3),@75,.01,75,2;C2"
 S (FR,TO)=DUZ(2)_",?"
 S FLDS="[ONCO SUSPENSE]"
 G PRT60
 ;
DI ;[DI Disease Index]
 ;Supported by IA #3151
 S (COUNT,SUSCOUNT)=0
 S OSPIEN=$O(^ONCO(160.1,"C",DUZ(2),0))
 S AFLDIV=""
 I $O(^ONCO(160.1,OSPIEN,6,0)) D
 .S ADIEN=0 F  S ADIEN=$O(^ONCO(160.1,OSPIEN,6,ADIEN)) Q:ADIEN'>0  S AFLDIV=AFLDIV_^ONCO(160.1,OSPIEN,6,ADIEN,0)_U
 W !
 K DIR
 S DIR(0)="SAO^1:Casefinding;2:Customized search"
 S DIR("A")=" Select DISEASE INDEX report: "
 S DIR("?",1)=" Select 'Casefinding' if you want to find and add to SUSPENSE"
 S DIR("?",2)=" cases with reportable tumors for the selected date range."
 S DIR("?",3)=""
 S DIR("?",4)=" Select 'Customized search' if you want to search for an"
 S DIR("?",5)=" individual ICD-9-CM code or range of codes."
 S DIR("?")=" "
 D ^DIR
 I $D(DIRUT) K DIRUT Q
 I Y<1 Q
 I +Y=1 S (SORT,BY)="[ONC DISEASE INDEX CASEFINDING]"
 I +Y=2 S (SORT,BY)="[ONC DISEASE INDEX]"
 S DIC="^AUPNVPOV(",L=0
 S FLDS="[ONC DISEASE INDEX]"
 S DIS(0)="I $$DIDIV^ONCFUNC(D0)=""Y"""
 I SORT="[ONC DISEASE INDEX CASEFINDING]" D
 .S DIS(1)="S CODE=$P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1) I (CODE>139.99)&(CODE<208.93)"
 .S DIS(2)="S CODE=$P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1) I (CODE>208.99)&(CODE<209.30)"
 .S DIS(3)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=209.30"
 .S DIS(4)="S CODE=$P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1) I (CODE>209.30)&(CODE<209.37)"
 .S DIS(5)="S CODE=$P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1) I (CODE>209.69)&(CODE<209.80)"
 .S DIS(6)="S CODE=$P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1) I (CODE>224.99)&(CODE<226)"
 .S DIS(7)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=227.3"
 .S DIS(8)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=227.4"
 .S DIS(9)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=227.9"
 .S DIS(10)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=228.02"
 .S DIS(11)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=228.1"
 .S DIS(12)="S CODE=$P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1) I (CODE>229.99)&(CODE<235)"
 .S DIS(13)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""236.0"""
 .S DIS(14)="S CODE=$P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1) I (CODE>236.99)&(CODE<238)"
 .S DIS(15)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=238.4"
 .S DIS(16)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=238.6"
 .S DIS(17)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=238.7"
 .S DIS(18)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=238.71"
 .S DIS(19)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=238.72"
 .S DIS(20)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=238.73"
 .S DIS(21)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=238.74"
 .S DIS(22)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=238.75"
 .S DIS(23)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=238.76"
 .S DIS(24)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=238.77"
 .S DIS(25)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=238.79"
 .S DIS(26)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=239.6"
 .S DIS(27)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=239.7"
 .S DIS(28)="S CODE=$P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1) I (CODE>239.80)&(CODE<239.90)"
 .S DIS(29)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=273.2"
 .S DIS(30)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=273.3"
 .S DIS(31)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=288.3"
 .S DIS(32)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=795.06"
 .S DIS(33)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=795.16"
 .S DIS(34)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=795.76"
 .S DIS(35)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)[""V10"""
 .S DIS(36)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V12.41"""
 .S DIS(37)="S CODE=$P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1) I (CODE>258.01)&(CODE<258.04)"
 .S DIS(38)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=338.3"
 .S DIS(39)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=511.81"
 .S DIS(40)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=789.51"
 .S DIS(41)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""042."""
 .S DIS(42)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""079.4"""
 .S DIS(43)="S CODE=+$P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1) I (CODE>79.49)&(CODE<79.60)"
 .S DIS(44)="S CODE=$P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1) I (CODE>209.9)&(CODE<230)"
 .S DIS(45)="S CODE=$P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1) I (CODE>234.9)&(CODE<236.7)"
 .S DIS(46)="S CODE=$P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1) I (CODE>237.9)&(CODE<240)"
 .S DIS(47)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=253.6"
 .S DIS(48)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=259.2"
 .S DIS(49)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""273.0"""
 .S DIS(50)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=273.1"
 .S DIS(51)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=273.9"
 .S DIS(52)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=275.42"
 .S DIS(53)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=277.88"
 .S DIS(54)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""279.00"""
 .S DIS(55)="S CODE=$P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1) I (CODE>279.01)&(CODE<279.07)"
 .S DIS(56)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""279.10"""
 .S DIS(57)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=279.12"
 .S DIS(58)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=279.13"
 .S DIS(59)="S CODE=$P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1) I (CODE>279.1)&(CODE<280)"
 .S DIS(60)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=284.81"
 .S DIS(61)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=284.89"
 .S DIS(62)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=285.22"
 .S DIS(63)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=285.3"
 .S DIS(64)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=288.03"
 .S DIS(65)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=289.83"
 .S DIS(66)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=323.81"
 .S DIS(67)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=379.59"
 .S DIS(68)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=528.01"
 .S DIS(69)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=686.01"
 .S DIS(70)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=695.89"
 .S DIS(71)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=701.2"
 .S DIS(72)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=710.3"
 .S DIS(73)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=710.4"
 .S DIS(74)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=785.6"
 .S DIS(75)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=790.93"
 .S DIS(76)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=795.8"
 .S DIS(77)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=795.81"
 .S DIS(78)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=795.82"
 .S DIS(79)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=795.89"
 .S DIS(80)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=999.31"
 .S DIS(81)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=999.81"
 .S DIS(82)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""E879.2"""
 .S DIS(83)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""E930.7"""
 .S DIS(84)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""E933.1"""
 .S DIS(85)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V07.3"""
 .S DIS(86)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V07.8"""
 .S DIS(87)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V12.72"""
 .S DIS(88)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V15.3"""
 .S DIS(89)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V42.81"""
 .S DIS(90)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V42.82"""
 .S DIS(91)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V51.0"""
 .S DIS(92)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V52.4"""
 .S DIS(93)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V54.2"""
 .S DIS(94)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V58.0"""
 .S DIS(95)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V58.1"""
 .S DIS(96)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V58.11"""
 .S DIS(97)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V58.12"""
 .S DIS(98)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V58.42"""
 .S DIS(99)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V66.1"""
 .S DIS(100)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V66.2"""
 .S DIS(101)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V67.1"""
 .S DIS(102)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V67.2"""
 .S DIS(103)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)[""V76"""
 .S DIS(104)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)[""V78"""
 .S DIS(105)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V82.71"""
 .S DIS(106)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V82.79"""
 .S DIS(107)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V82.89"""
 .S DIS(108)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V82.9"""
 .S DIS(109)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V84.01"""
 .S DIS(110)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V84.02"""
 .S DIS(111)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V84.03"""
 .S DIS(112)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V84.04"""
 .S DIS(113)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V84.09"""
 .S DIS(114)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V84.81"""
 .S DIS(115)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V86.0"""
 .S DIS(116)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V86.1"""
 .S DIS(117)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=""V87.41"""
 .S DIS(118)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=259.8"
 .S DIS(119)="I $P($G(^ICD9($P($G(^AUPNVPOV(D0,0)),U,1),0)),U,1)=624.01"
 S DHIT="S SAVED0=D0 D DISUS^ONCOPRT S D0=SAVED0"
 I SORT="[ONC DISEASE INDEX CASEFINDING]" S DIOEND="W !?6,""-----"",!,""COUNT "",COUNT,!,""Added to SUSPENSE "",SUSCOUNT"
 E  S DIOEND="W !?6,""-----"",!,""COUNT "",COUNT"
 D EN1^DIP
 K AFLDIV,ADIEN,COUNT,D0,DHIT,DIOEND,DIR,DR,ONCSUB,OSPIEN,POV,SAVED0,SORT,SUSCOUNT
 G EX
 ;
DISUS ;Add DISEASE INDEX case to suspense
 N DA,DC,DIC,DPTIEN,ICD,ONCS,ONCDIV,ONCIEN,ONCPAT,X
 S ICD=$P(^AUPNVPOV(D0,0),U,1)
 S DPTIEN=$P(^AUPNVPOV(D0,0),U,2)
 I '$D(POV(DPTIEN)) S COUNT=COUNT+1,POV(DPTIEN)=""
 Q:SORT="[ONC DISEASE INDEX]"
 S ONCPAT=DPTIEN_";DPT("
 S ONCIEN=$O(^ONCO(160,"B",ONCPAT,0))
 I ONCIEN'>0 D
 .K DO
 .S DIC="^ONCO(160,",DIC(0)="Z"
 .S X=ONCPAT
 .D FILE^DICN
 .K DO
 .S ONCIEN=+Y
 S ONCDIV="",ONCS=""
 F  S ONCS=$O(^ONCO(160,ONCIEN,"SUS","C",ONCS)) Q:ONCS'>0  S ONCDIV=ONCDIV_U_ONCS
 I ONCDIV[DUZ(2) Q
 S DA(1)=ONCIEN
 S DIC="^ONCO(160,"_DA(1)_",""SUS"","
 K DO
 S DIC(0)="L"
 S DIC("P")=$P(^DD(160,75,0),U,2)
 S X=$$GET1^DIQ(9000010,$$GET1^DIQ(9000010.07,D0,.03,"I"),.01,"I")
 S X=$P(X,".",1)
 D FILE^DICN
 K DO,DIE
 S DA(1)=ONCIEN
 S DIE="^ONCO(160,"_DA(1)_",""SUS"","
 S (ONCSUB,DA)=+Y
 S DR="1///^S X=DT;2///^S X=""DI"";3////^S X=DUZ(2);8////^S X=ICD"
 D ^DIE
 S SUSCOUNT=SUSCOUNT+1
 Q
 ;
DNP ;[NP Oncology Patient List-NO Primaries/Suspense]
 S BY="@75,INTERNAL(#3),@NO PRIMARY;L1,NAME"
 S (FR,TO)=DUZ(2)
 S FLDS="[ONCO PATIENT ONLY]"
 G PRT60
 ;
ABI ;[NC Print Abstract NOT Complete List]
 W !
 N BY,FLDS,FR,DIR,DIS,TO,Y
 K DIR
 S DIR(0)="SAO^1:Date Dx;2:Date of First Contact"
 S DIR("A")=" Select date field to be used for sorting: "
 S DIR("?")="Select the date field you wish to use for sorting this report."
 D ^DIR
 I $D(DIRUT) K DIRUT Q
 I Y<1 S OUT=1 Q
 I +Y=1 S BY="#+91,@INTERNAL(#3)"
 I +Y=2 S BY="#+91,@INTERNAL(#155)"
 S FR=",@"
 S TO=""
 S FLDS="[ONCO ABSTRACT NOT-COMPLETE]"
 S DIS(0)="I $P($G(^ONCO(165.5,D0,7)),U,2)'=3"
 G PRT655
 ;
PFH ;[FH Patient Follow-up History]
 D PAT I Y'<0 D  G EX
 .S BY="@NUMBER"
 .S (FR,TO)=+Y
 .S FLDS="[ONCO FOLLOWUP HISTORY]"
 .D PRT60
 Q
 ;
DUF ;[DF Print Due Follow-up List by Month Due]
 W !
 N BY,FLDS,DIR,DIS,Y
 D DIR
 I $D(DIRUT) K DIRUT Q
 I Y<1 Q
 I +Y=1 S (BY,FLDS)="[ONCO DUE FOLLOWUP]"
 I +Y=2 S BY="[ONCO DUE FOLLOWUP]",FLDS="[ONCO DUE FOLLOWUP2]"
 S DIS(0)="I $$PFTD^ONCFUNC(D0)=""Y"""
 G PRT60
 ;
DEL ;[LF Print Delinquent (LTF) List]
 N BY,FLDS,DIR,DIS,Y
 W !!?5,"FOLLOW-UP STATUS will be changed from ""Active"" to ""LTF""."
 W !?5,"After 15 months the patient is considered LOST TO FOLLOW-UP."
 W !
 D DIR
 I $D(DIRUT) K DIRUT Q
 I Y<1 Q
 I +Y=1 S (BY,FLDS)="[ONCO DELINQUENT(LTF) LIST]"
 I +Y=2 S BY="[ONCO DELINQUENT(LTF) LIST]",FLDS="[ONCO DELINQUENT(LTF) LIST2]"
 S DIS(0)="I $$PFTD^ONCFUNC(D0)=""Y"""
 G PRT60
 ;
DIR ;DIR
 K DIR
 S DIR(0)="SAO^1:Standard format;2:Remote employees format"
 S DIR("A")=" Select report format: "
 S DIR("?")="Select the report format you wish to use for this report."
 D ^DIR
 Q
 ;
FST ;[SR Follow-up Status Report by Patient (132c)]
 W ! S (BY,FLDS)="[ONCO FOLLOWUP STATUS RPT]"
 S DIS(0)="I $$PFTD^ONCFUNC(D0)=""Y"""
 G PRT60
 ;
PFR ;[FR Individual Follow-up Report]
 D PAT I Y'<0 D  G EX
 .S BY="@NUMBER"
 .S (FR,TO)=+Y
 .S FLDS="[ONCO FOLLOWUP PATIENT RPT]"
 .D PRT60
 Q
 ;
ACOS80 ;[AA Accession Register-ACOS (80c)]
 S (BY,FLDS)="[ONCO ACCREG-ACOS80]" D HA G PRT655
 ;
AC80ST ;[AS Accession Register-Site (80c)]
 S (BY,FLDS)="[ONCO ACCREG-SITE/GP80]" D HA G PRT655
 ;
EOAC ;[AE Accession Register-EOVA (132c)]
 S (BY,FLDS)="[ONCO ACCREG-EOVA132]" D HA G PRT655
 ;
HA ;Help for Accession Registers
 W !!?3,"For a complete register:"
 W !?5,"START WITH ACC/SEQ NUMBER: FIRST// <Enter>"
 W !!?3,"For a single accession year (e.g. 1999):"
 W !,?5,"START WITH ACC/SEQ NUMBER: FIRST// 1999-00000"
 W !,?5,"GO TO ACC/SEQ NUMBER: LAST// 1999-99999"
 W !!?3,"For a single patient (e.g. 1999-00001):"
 W !,?5,"START WITH ACC/SEQ NUMBER: FIRST// 1999-00001/00"
 W !,?5,"GO TO ACC/SEQ NUMBER: LAST// 1999-00001/99"
 W !
 Q
 ;
ACOSPT ;[PA Patient Index-ACOS (132c)]
 S BY="NAME",(FR,TO)=""
 S FLDS="[ONCO PATIENT INDX-ACOS]"
 S DIS(0)="I $$PFTD^ONCFUNC(D0)=""Y"""
 G PRT60
 ;
PAT80 ;[PS Patient Index-Site (80c)]
 S BY="NAME"
 S (FR,TO)=""
 S FLDS="[ONCO PATIENT INDX80]"
 S DIS(0)="I $$PFTD^ONCFUNC(D0)=""Y"""
 G PRT60
 ;
EOVA ;[PE Patient Index-EOVA (132c)]
 S BY="NAME"
 S (FR,TO)=""
 S FLDS="[ONCO PATIENT INDX-EOVA132]"
 S DIS(0)="I $$PFTD^ONCFUNC(D0)=""Y"""
 G PRT60
 ;
ICD80 ;[IN Primary ICDO Listing (80c)]
 S (BY,FLDS)="[ONCO ICDO-SITE80]"
 G PRT655
 ;
SIT80 ;[SG Primary Site/GP Listing (80c)]
 S (BY,FLDS)="[ONCO SITE/GP80]"
 G PRT655
 ;
ICD132 ;[IW Primary ICDO Listing (132c)]
 S (BY,FLDS)="[ONCO ICDO-SITE132]"
 G PRT655
 ;
PAT ;ONCOLOGY PATIENT (160) lookup
 W !
 S DIC="^ONCO(160,",DIC(0)="AEQM",DIC("A")=" Select Patient Name: "
 D ^DIC K DIC W !
 Q
 ;
PRT60 ;Print ONCOLOGY PATIENT (160) file
 S DIC="^ONCO(160,",L=0 D EN1^DIP G EX
 ;
PRT655 ;Print ONCOLOGY PRIMARY (165.5) file
 S DIC="^ONCO(165.5,",L=0 D EN1^DIP G EX
 ;
EX ;Exit
 K BY,DIC,DHD,DIS,FLDS,FR,L,TO,Y
 Q
 ;
CLEANUP ;Cleanup
 K OUT
