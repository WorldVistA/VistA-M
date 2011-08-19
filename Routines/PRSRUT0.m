PRSRUT0 ;HISC/JH,JAH-UTILITY ROUTINE FOR PAID ADDIM. REPORTS ;6/24/94
 ;;4.0;PAID;**2,17,114**;Sep 21, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
QUE ;QUEUE FOR PAID REPORTS
 S IOP="Q",%ZIS="Q" D ^%ZIS K %ZIS K:POP IO("Q") I POP S ZTSTOP=1 Q
 I $D(IO("Q")) K IO("Q"),IO("C") S ZTIO=ION_";"_IOST_";"_IOM_";"_IOSL,ZTSAVE("IOM")="" D ^%ZTLOAD S:'$D(ZTSK) (ZTSTOP,POP)=1
 Q
QUE1 ;QUEUE FOR PAID REPORTS
 S %ZIS="Q" D ^%ZIS K %ZIS K:POP IO("Q") S:POP ZTSTOP=0 Q:POP
 I $D(IO("Q")) K IO("Q"),IO("C") S ZTIO=ION_";"_IOST_";"_IOM_";"_IOSL D ^%ZTLOAD S:'$D(ZTSK) POP=1
 Q
Q ;TERMINAL RESET FROM 132 TO 80 CHARS.
 I $E(IOST)="C",IOM=132 S X="IORESET" D ENDR^%ZISS W @X D HOME^%ZIS K %,%T,%XX,%YY,IOHG,IOPAR,IORESET,IOUPAR
 Q
FOOT ;CODE = 3 Char code for type of report, NUM = Report Number,
 ;FOOT = Type of system this report is for,
 ;TYP = Type of report (T&L,T&A,BUDGET,MANPOWER,COST,...),
 ;TLUNIT = (T&L Unit,T&A Unit,Pay Period,FY,...),
 F I=1:1 W ! Q:$Y=(IOSL-3)
FOOT1 W !,"DHCP PAID REPORT ",CODE,?(IOM-$L(FOOT))/2,FOOT
 Q
FOOT2 W !,"DHCP PAID REPORT ",CODE,?40,FOOT
 Q
CKTOUR(CK) N LL,M,K,KK S M=CK,CK="",KK=1 F K=1:4 S LL=$P(M,"^",K+2) Q:LL=""  S %=$F(LVT,";"_LL_":") S:% $P(CK,"^",KK,KK+3)=$P(M,"^",K,K+3) S KK=$S(%:KK+4,1:KK)
 Q
TYPSTF S DFN=$O(^PRSPC("SSN",PRSRSSN,0)) N PP D ^PRSAENT S SW(2)=$S($E(ENT,1,2)["D":77,1:73)
 Q
TLESEL ;user select T&L units
 ; set up array:
 ;   TLE(n)="T&L number ^ unit name"
 ;   TLE(n,m) = "ien ^ member name"
 ;   TLE= approving T&L unit
 ;
 N A,B,C,D,E,F,X
 ; get duz of current user
 S USR="",TLE="" D DUZ^PRSRUTL Q:SSN=""
TL ; Select T&L from those allowed
 S:SSN'="" USR=$O(^PRSPC("SSN",SSN,0))
 K DIC
 ;
 ;Z1 for T&L unit file x-ref lookup: T=TimeKeeper, S=Supervisor
 S Z1=$S(PRSTLV=2:"T",PRSTLV="3":"S",PRSTLV=7:"S",1:"*")
 I PRSR=1 S TLI=$O(^PRST(455.5,"A"_Z1,DUZ,0)) I TLI<1 W !!,*7,"No T&L Units have been assigned to you!" Q
 Q:PRSR=3
SEL W ! S DIC="^PRST(455.5,"
 S DIC(0)="AEMQ",DIC("A")="Select T&L: "
 ;screen checks:
 ; if payroll then all T&L's available OR
 ; if T&A supervisor then only T&L's that are assigned
 S DIC("S")="I PRSR=2!(PRSR=1&($D(^PRST(455.5,Y,Z1,DUZ,0))))"
 D ^DIC Q:$D(DTOUT)!$D(DUOUT)!(Y=-1)  K DIC S X=$P(Y,"^",2)
 D VALSEL I TLE="" W ?($X+2),$C(7),"??" G SEL
P1 ;S TLI=$P($G(^PRSPC(PRSRDUZ,0)),U,8)
 Q
P2 S TLE=1,TLE(I)=$P($G(^PRST(455.5,TLI,0)),"^",1,2)
 S TLI=$P($G(^PRSPC(PRSRDUZ,0)),U,8)
 Q
VALSEL ; Validate input in form 001 or 211,234,333 or 221,2233,345-367,400
 S C=0,D=1 F A=1:1 Q:$P(X,",",A)=""  D
 .  I $P(X,",",A)'["-" S I=$P(X,",",A) S TLE(D)=I,D=D+1
 .  E  S B=$P($P(X,",",A),"-"),C=$P($P(X,",",A),"-",2) F I=B:1:C S TLE(D)=I,D=D+1
 .  Q
CHKSEL ; Check selection array eliminating T&L units not assigned, if not Fiscal.
 S TLE=D-1 S I=0 F II=1:1 S I=$O(TLE(I)) Q:I'>0  D
 .  I $L(TLE(I))<1!'($O(^PRST(455.5,"B",TLE(I),0))) D KILL Q
 .  S F=$O(^PRST(455.5,"B",TLE(I),0)) I PRSR=1,'$D(^PRST(455.5,F,Z1,DUZ,0)) D KILL
 .  E  S $P(TLE(I),U,2)=$P(^PRST(455.5,F,0),U,2) D GET
 .  Q
 S:D=1 TLE=D Q
KILL K TLE(D) S TLE=TLE-1 Q
ALL S DA=0 F I=1:1 S DA=$O(^PRST(455.5,"A"_Z1,DUZ,DA)) Q:DA'>0  D
 .  S TLE(I)=$P($G(^PRST(455.5,DA,0)),U,1,2) D GET
 .  Q
 Q
GET S DA(1)="" F II=1:1 S DA(1)=$O(^PRSPC("ATL"_$P(TLE(I),U),DA(1))) Q:DA(1)=""  D
 .  S TLE(I,II)=$O(^PRSPC("ATL"_$P(TLE(I),U),DA(1),0))_"^"_DA(1)
 .  Q
 S TLE=$S(PRSRDUZ:$P($G(^PRSPC(PRSRDUZ,0)),U,8),1:"000"),SW=1 Q
MSG W !!,$C(7),"ENTER CODE(s), ONE OR MORE, SEPERATED BY COMMA(S) ( , ) or ( ALL ) .",! G SEL
