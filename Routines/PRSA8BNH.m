PRSA8BNH ;WOIFO/JAH - Tour Hours vs 8B Norm Hrs Report ;12/28/07
 ;;4.0;PAID;**116,110**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; Search for 8b normal hours that don't match tours
 ; look in timecard 8B node for normal hours otherwise use 450
 ;
PAYROLL ;prompt for T&L's--set's up payroll all T&L's
 N PRSTLV,FORWHO
 S PRSTLV=7
 S FORWHO="for Payroll"
 D MAIN
 Q
 ;
TIMEKEEP ; entry point sets up timekeeper T&L variable for PRSAUTL call
 N PRSTLV,FORWHO S PRSTLV=2,FORWHO="for Timekeeper"
 D MAIN
 Q
 ;
SUPERV ; sets up supervisor for T&L lookup
 N PRSTLV,FORWHO S PRSTLV=3,FORWHO="for T&A Supervisor"
 D MAIN
 Q
 ;
MAIN ;
 N DIR,DIRUT,TLS,Y,PPI,PPE,NOTOUR,NOTCARD,PPRANGE,DAILYHRS,EP,SP,SDT,EDT
 S TLS=1
 S DIR(0)="Y"
 S DIR("B")="Y"
 S DIR("A")="All T&L's"
 D ^DIR
 Q:$D(DIRUT)
 I +Y=1 S TLS="ALL"
 I TLS=1 D
 .  D ^PRSAUTL
 Q:TLS=1&($G(TLI)="")
 ;
 S PPI=$$GETPP^PRSA8BNI()
 Q:PPI'>0
 S PPE=$P($G(^PRST(458,PPI,0)),U)
 S SDT=$P($G(^PRST(458,PPI,2)),U)
 S EDT=$P($G(^PRST(458,PPI,2)),U,14)
 S SP=$L(SDT," ")
 S EP=$L(EDT," ")
 S PPRANGE=$P(SDT," ",SP)_" thru "_$P(EDT," ",EP)
 ;
 ; ask user to include employees with no timecard at all.
 S NOTCARD=$$NOTCARD^PRSA8BNI()
 Q:NOTCARD<0
 ;
 ; ask user to include employees with no tour of duty entered
 S NOTOUR=$$NOTOURS^PRSA8BNI()
 Q:NOTOUR<0
 ;
 ; ask user to include employees daily tour hours
 S DAILYHRS=$$DAILYHRS^PRSA8BNI()
 Q:DAILYHRS<0
 ;
 ;
 N %ZIS,POP,IOP
 S %ZIS="MQ"
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D
 .  K IO("Q")
 .  N ZTDESC,ZTRTN,ZTSAVE
 .  S ZTDESC="PAID REPORT: TOUR HOURS DON'T MATCH 8B NORMAL"
 .  S ZTRTN="TOUR8B^PRSA8BNH"
 .  S ZTSAVE("PRSTLV")=""
 .  S ZTSAVE("TLE")=""
 .  S ZTSAVE("PPI")=""
 .  S ZTSAVE("PPE")=""
 .  S ZTSAVE("TLS")=""
 .  S ZTSAVE("NOTOUR")=""
 .  S ZTSAVE("NOTCARD")=""
 .  S ZTSAVE("DAILYHRS")=""
 .  S ZTSAVE("PPRANGE")=""
 .  S ZTSAVE("FORWHO")=""
 .  D ^%ZTLOAD
 .  I $D(ZTSK) S ZTREQ="@"
 E  D
 .  D TOUR8B
 K PRSTLV
 D ^%ZISC K %ZIS,IOP
 Q
 ;
TOUR8B ;
 U IO
 N OUT,TLECNT,TSTAMP,Y,%,%I,GRANDTOT,PG,ATL
 D NOW^%DTC S Y=% D DD^%DT S TSTAMP=$P(Y,":",1,2)
 S (TLECNT,OUT,GRANDTOT,PG)=0
 I TLS="ALL" D
 .  N TLI,TLE
 .  S ATL="ATL"
 .  F  S ATL=$O(^PRSPC(ATL)) Q:ATL>"ATLVCS"!OUT  D
 ..    S TLE=$E(ATL,4,6)
 ..    Q:TLE=""
 ..    S TLI=$O(^PRST(455.5,"B",TLE,0))
 ..    Q:TLI'>0
 ..; skip T&L's supervisors and timekeepers don't have access too
 ..    Q:(PRSTLV=2)&('$D(^PRST(455.5,"AT",DUZ,TLI)))
 ..    Q:(PRSTLV=3)&('$D(^PRST(455.5,"AS",DUZ,TLI)))
 ..     I TLECNT=0 D HDR^PRSA8BNI(.PG,TSTAMP,0,FORWHO,PPE,PPRANGE)
 ..     D LOOPTL(.OUT,.GRANDTOT,TLE,PPI,TSTAMP)
 ..     S TLECNT=TLECNT+1
 E  D
 .   D HDR^PRSA8BNI(.PG,TSTAMP,0,FORWHO,PPE,PPRANGE)
 .   D LOOPTL(.OUT,.GRANDTOT,TLE,PPI,TSTAMP)
 .   S TLECNT=TLECNT+1
 D REPDONE^PRSA8BNI(OUT,TLECNT,TSTAMP,DAILYHRS,GRANDTOT)
 Q
 ;
LOOPTL(OUT,TOT,TLE,PPI,TSTAMP) ; LOOP THROUGH T&L
 N COUNT,NN,PRSIEN,EMPNODE,PRSENAME,HRS,EMPND1,SEPIND,WEEKHRS,PRSD,PRSSN
 K ERRORS
 S (COUNT,OUT)=0
 S NN=""
 F  S NN=$O(^PRSPC("ATL"_TLE,NN)) Q:NN=""  D
 .  F PRSIEN=0:0 S PRSIEN=$O(^PRSPC("ATL"_TLE,NN,PRSIEN)) Q:PRSIEN<1!(OUT)  D
 ..;  skip Extended LWOP or anyone without a timecard
 ..    Q:'NOTCARD&($G(^PRST(458,PPI,"E",PRSIEN,0))="")
 ..    Q:'NOTOUR&($P($G(^PRST(458,PPI,"E",PRSIEN,"D",1,0)),U,2)="")
 ..    S EMPNODE=$G(^PRSPC(PRSIEN,0))
 ..    S EMPND1=$G(^PRSPC(PRSIEN,1))
 ..    S SEPIND=$P(EMPND1,U,33)
 ..    Q:EMPNODE=""!(SEPIND="Y")
 ..    I '$$HRSMATCH^PRSATPE(PPI,PRSIEN) D
 ...     S COUNT=COUNT+1
 ...     S GRANDTOT=GRANDTOT+1
 ...     S ERRORS(PRSIEN)=""
 I COUNT>0 D
 .  I DAILYHRS,$Y>(IOSL-12) S OUT=$$RET^PRSA8BNI(TSTAMP) Q:OUT
 .  I 'DAILYHRS,$Y>(IOSL-7) S OUT=$$RET^PRSA8BNI(TSTAMP) Q:OUT
 .  W !!,?12,"T & L UNIT: "_TLE,"   ",COUNT," mismatches found."
 .  S PRSIEN=""
 .  F  S PRSIEN=$O(ERRORS(PRSIEN)) Q:PRSIEN'>0!OUT  D
 ..   S WEEKHRS=$$GETHOURS^PRSA8BNI(PPI,PRSIEN)
 ..   S PRSENAME=$P($G(^PRSPC(PRSIEN,0)),U)
 ..   S PRSSN=$P($G(^PRSPC(PRSIEN,0)),U,9)
 ..   S PRSSN=$S(PRSTLV=7:$E(PRSSN,1,3)_"-"_$E(PRSSN,4,5),PRSTLV'<2:$E(PRSSN,1)_"XX-XX",1:"XXX-XX")_"-"_$E(PRSSN,6,9)
 ..   I DAILYHRS,$Y>(IOSL-10) S OUT=$$RET^PRSA8BNI(TSTAMP) Q:OUT
 ..   I 'DAILYHRS,$Y>(IOSL-5) S OUT=$$RET^PRSA8BNI(TSTAMP) Q:OUT
 ..   D EMPINFO^PRSA8BNI(PRSENAME,PRSSN,WEEKHRS)
 ..;  show the actual tour hours for each day
 ..   I DAILYHRS D
 ...    N HRS,I
 ...    D TOURHRS^PRSARC07(.HRS,PPI,PRSIEN)
 ...    I $Y>(IOSL-8) S OUT=$$RET^PRSA8BNI(TSTAMP) Q:OUT  D EMPINFO^PRSA8BNI(PRSENAME,PRSSN,WEEKHRS)
 ...    D TRHDR^PRSA8BNI
 ...    F PRSD=1:1:7 D  Q:OUT
 ....     I $Y>(IOSL-4) S OUT=$$RET^PRSA8BNI(TSTAMP) Q:OUT  D EMPINFO^PRSA8BNI(PRSENAME,PRSSN,WEEKHRS),TRHDR^PRSA8BNI
 ....     Q:OUT
 ....     D TOURDISP(PPI,PRSIEN,PRSD,.HRS)
 ..   Q:OUT
 ..   I $Y>(IOSL-5) S OUT=$$RET^PRSA8BNI(TSTAMP) Q:OUT
 Q
TOURDISP(PPI,PRSIEN,PRSD,HRS) ;
 N Y1,Y2,Y4,Y5,DTE,TD1C1,TD1C2,L2,L3,TD2C1,TD2C2
 S TD1C1=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)),"^",2),Y1=$G(^(1)),Y4=$G(^(4))
 S TD2C1=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)),"^",13)
 I Y1="" S Y1=$S(TD1C1=1:"Day Off",TD1C1=2:"Day Tour",TD1C1=3!(TD1C1=4):"Intermittent",1:"")
 S TD1C2=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD+7,0)),"^",2),Y2=$G(^(1)),Y5=$G(^(4))
 S TD2C2=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD+7,0)),"^",13)
 I Y2="" S Y2=$S(TD1C2=1:"Day Off",TD1C2=2:"Day Tour",TD1C2=3!(TD1C2=4):"Intermittent",1:"")
 S DTE=$P("Sun Mon Tue Wed Thu Fri Sat"," ",PRSD)
 W !?7,DTE S (L2,L3)=0
 I Y1="",Y2="" Q
 ;
S0 ; Set Schedule Array
 N A1,L1,B
 F L1=1:3:19 D
 .  S A1=$P(Y1,"^",L1) Q:A1=""
 .  S L2=L2+1,Y1(L2)=A1
 .  S:$P(Y1,"^",L1+1)'="" Y1(L2)=Y1(L2)_"-"_$P(Y1,"^",L1+1)
 .  I L1=1 D
 ..   N DAYHRS S DAYHRS=$J($P(HRS(PRSD),U,2),5,2)
 ..   S B=$E("               ",1,20-$L(DAYHRS)-$L(Y1(L2)))
 ..   S Y1(L2)=$J(TD1C1,5,0)_"  "_Y1(L2)_B_DAYHRS
 .  E  D
 ..   S Y1(L2)="       "_Y1(L2)
 .  I $P(Y1,"^",L1+2)'="" D
 ..   S L2=L2+1
 ..   S Y1(L2)="        "_$P($G(^PRST(457.2,+$P(Y1,"^",L1+2),0)),"^",1)
 G:Y4="" S1
 F L1=1:3:19 D
 .  S A1=$P(Y4,"^",L1) Q:A1=""
 .  S L2=L2+1
 .  S Y1(L2)=A1
 .  S:$P(Y4,"^",L1+1)'="" Y1(L2)=Y1(L2)_"-"_$P(Y4,"^",L1+1)
 .  I L1=1 D
 ..   S Y1(L2)=$J(TD2C1,5,0)_"  "_Y1(L2)
 .  E  D
 ..   S Y1(L2)="       "_Y1(L2)
 .  I $P(Y4,"^",L1+2)'="" D
 ..   S L2=L2+1
 ..   S Y1(L2)="        "_$P($G(^PRST(457.2,+$P(Y4,"^",L1+2),0)),"^",1)
 ;
S1 ; Set Schedule Array
 F L1=1:3:19 D
 .  S A1=$P(Y2,"^",L1) Q:A1=""
 .  S L3=L3+1
 .  S Y2(L3)=A1
 .  S:$P(Y2,"^",L1+1)'="" Y2(L3)=Y2(L3)_"-"_$P(Y2,"^",L1+1)
 .  I L1=1 D
 ..   N DAYHRS S DAYHRS=$J($P(HRS(PRSD+7),U,2),5,2)
 ..   S B=$E("               ",1,20-$L(DAYHRS)-$L(Y2(L3)))
 ..   S Y2(L3)=$J(TD1C2,5,0)_"  "_Y2(L3)_B_DAYHRS
 .  E  D
 ..   S Y2(L3)="       "_Y2(L3)
 .   I $P(Y2,"^",L1+2)'="" D
 ..    S L3=L3+1
 ..    S Y2(L3)="        "_$P($G(^PRST(457.2,+$P(Y2,"^",L1+2),0)),"^",1)
 ;
 G:Y5="" S2
 ;
 F L1=1:3:19 D
 .  S A1=$P(Y5,"^",L1) Q:A1=""
 .  S L3=L3+1,Y2(L3)=A1
 .  S:$P(Y5,"^",L1+1)'="" Y2(L3)=Y2(L3)_"-"_$P(Y5,"^",L1+1)
 .  I L1=1 D
 ..   S Y2(L3)=$J(TD2C2,5,0)_"  "_Y2(L3)
 .  E  D
 ..   S Y2(L3)="       "_Y2(L3)
 .  I $P(Y5,"^",L1+2)'="" D
 ..   S L3=L3+1
 ..   S Y2(L3)="        "_$P($G(^PRST(457.2,+$P(Y5,"^",L1+2),0)),"^",1)
 ;
S2 ;
 N K
 F K=1:1 Q:'$D(Y1(K))&'$D(Y2(K))  D
 .  W:K>1 ! W:$D(Y1(K)) ?12,Y1(K) W:$D(Y2(K)) ?47,Y2(K)
 Q
