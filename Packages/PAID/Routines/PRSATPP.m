PRSATPP ;WCIOFO/PLT - Timekeeper Prior PP Post Time ;7/29/08  15:44
 ;;4.0;PAID;**117,124,132**;Sep 21, 1995;Build 13
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 S PRSTLV=2 D ^PRSAUTL G:TLI<1 EX
 S X=$P(^PRST(455.5,TLI,0),"^",3) D NOW^%DTC S NOW=%,DT=%\1
D1 ;
 S %DT="AEPX",%DT("A")="Posting Date: ",%DT(0)=-DT W ! D ^%DT
 G:Y<1 EX
 S D1=Y S Y=$G(^PRST(458,"AD",D1)),PPI=$P(Y,"^",1),DAY=$P(Y,"^",2)
 I PPI="" W !!,*7,"Pay Period is Not Open Yet!" G EX
 S PPE=$P($G(^PRST(458,PPI,0)),"^",1)
 S DTE=$P($G(^PRST(458,PPI,2)),"^",DAY)
 S DTI=$P($G(^(1)),"^",DAY)
NME ;
 K DIC S DIC("A")="Select EMPLOYEE: "
 S DIC("S")="I $P(^(0),""^"",8)=TLE,$D(^PRST(458,PPI,""E"",+Y))"
 S DIC(0)="AEQM",DIC="^PRSPC(",D="ATL"_TLE W ! D IX^DIC S DFN=+Y K DIC
 G:DFN<1 EX
 D ^PRSAENT
 I ENT="" W *7,!!,"Employee has no Pay Entitlement table entry." G EX
 S STAT=$P($G(^PRST(458,PPI,"E",DFN,0)),"^",2)
 I "T"[STAT W *7,!!,"Employee still open for regular posting." G NME
 I STAT'="X" W !!,*7,"Card in Payroll and not transmitted; request return of card." G NME
 ;
 ; loop thru and save this days timecard data nodes in AUR prior
 ; to correction.
 ; "D" (day subnodes)                           saved to Audit Nodes
 ; ==================                           ====================
 ;  0  timkeeper,supervisor,tour, length etc        1
 ;  1  tour 1 start and stop times                  2
 ;  2  exceptions start, stop and types and ind     3
 ;  10 posting status, type, timekeeper, date/time  4
 ;  3  timekeeper remarks                           5
 ;  4  tour 2 start and stop                        6
 ;  8  telework tour and posted hours               8
 ;
 K AUR S L2=0
 N L2I
 S L2I="1^2^3^4^5^6^8"
 F L1=0,1,2,10,3,4,8 D
 .  S Z=$G(^PRST(458,PPI,"E",DFN,"D",DAY,L1))
 .  S L2=L2+1
 .  S L2=$P(L2I,U,L2)
 .  S:Z'="" AUR(L2)=Z
 S STAT=$P($G(AUR(4)),"^",1) D POST
 ;
 ; if no changes to tour or timecard or telework or timekeeper aborted
 ; in the corrected timecard remarks then we restore the old timecard
 ;
 N I,L2
 S (Z,I)=0
 F L1=0,1,2,10,3,4,8 D
 .  S I=I+1
 .  S L2=$P(L2I,U,I)
 .  I $G(^PRST(458,PPI,"E",DFN,"D",DAY,L1))'=$G(AUR(L2)) S Z=1
 I Z D
 .  S AUT="T",AUS="R"
 .  D ^PRSAUD
 .  I $G(AUR(7))["^" D
 ..    S I=0
 ..    F L1=0,1,2,10,3,4,8 D
 ...     S I=I+1
 ...     S L2=$P(L2I,U,I)
 ...     K ^PRST(458,PPI,"E",DFN,"D",DAY,L1)
 ...     I $D(AUR(L2)) S ^(L1)=AUR(L2)
 G NME
 ;
POST ;
 ;start posting
 N DDSFILE,PRSDAY,PRSDN,PRSERR,SRT
 S SRT="X",PRSDN=DAY
 S TC=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),U,2),TC2=$P($G(^(0)),U,13)
 D ^PRSADP1,LP,^PRSATP2 G:'TC T1
T0 R !!,"Do you wish to change Scheduled Tour? N// ",X:DTIME Q:'$T!(X[U)  S:X="" X="N" S X=$TR(X,"yesno","YESNO")
 I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7," Answer YES or NO" G T0
 G:X?1"N".E T3
T1 ; Get new tour
 S TYP=1,WTL=TLI
 S DIC="^PRST(455.5,",DIC(0)="AEQM",DIC("A")="T&L on which Tour will be worked: ",DIC("B")=TLE W ! D ^DIC Q:Y<1  K DIC S WTL=+Y
 S DIC="^PRST(457.1,",DIC(0)="AEQMN"
 S DIC("S")="I "_$S($E(ENT,1)="D":"Y<3",$P(C0,U,10)=3:"Y>2!(Y=1)",1:"Y>5!(Y=1)")_",$P(^PRST(457.1,+Y,0),U,4)!($D(^PRST(457.1,+Y,""T"",""B"",WTL)))"
 S DIC("A")="Select TOUR OF DUTY: " W ! D ^DIC K DIC G:Y'>0 T2
 S TD=+Y
 ;tour overlap check
 K PRSDAY S PRSDAY(DAY)=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),U,1,4),$P(PRSDAY(DAY),U,2)=TD,$P(PRSDAY(DAY),U,6)=$P($G(^(0)),U,13),$P(PRSDAY(DAY),U,7,999)=$G(^(4))
 D PPTDOL^PRSATE5(SRT,PPI,DFN,DAY,.PRSDAY,3) I $G(PRSERR) K PRSERR G T1
 ;Prompt for update to Telework Tour
 S PRSTWB=$P($$TWE^PRSATE0(DFN,PPI),U,4)="Y"
 I PRSTWB,TD=2!(TD>4) S PRSTW(DAY)=$$GETSCHTW()
 S Y=$G(^PRST(457.1,TD,1)),TDH=$P(^(0),U,6)
 D SET^PRSATE,HOL^PRSATE S TC=TD
T2 ;ask secondary tour
 G:$E(ENT,1)="D" T21
 S X=$$ASK2NDTR^PRSATE() G:X'="Y" T21 D
 . N TD,TC,TC2
 . S TD=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),U,13)
 . I TD W !!,"Existing Second Tour ",$P($G(^PRST(457.1,TD,0)),U,1)," is being deleted." D DELSTD^PRSATE4(PPI,DFN,DAY)
 . QUIT
 I $P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),U,2)<6 W *7,!!,"A second Tour is not valid on this day." G T21
 K PRSDAY,PRSERR D
 . N DAY
 . S DAY=PRSDN D P^PRSATE4
 . QUIT
 ;
T21 S DAY=PRSDN,TC=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),U,2),TD=TC,TC2=$P($G(^(0)),U,13)
 D ^PRSADP1,LP,^PRSATP2
T3 ;
 G P1^PRSATP:TC=1,P3^PRSATP:TC=4,P0^PRSATP
 Q
 ;
LP W !!,"Enter '^' to bypass this employee." W ! Q
EX G KILL^XUSCLEAN
GETSCHTW() ;
 ;  Prompt for type of additional telework
 N X,Y,DIR,DEF
 S DIR("A")="Enter SCHEDULED telework for this day. "
 S DIR(0)="SAB^REG:REGULAR SCHEDULED TELEWORK;MED:MEDICAL SCHEDULED TELEWORK;N:NONE"
 S DIR("B")=$S($P($G(AUR(8)),U)]"":$P(AUR(8),U),1:"N")
 D ^DIR
 I $D(DIRUT) S Y=DIR("B")
 Q $S(Y="N":"",1:Y)
