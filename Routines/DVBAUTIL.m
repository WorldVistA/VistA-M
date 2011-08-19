DVBAUTIL ;ALB ISC/THM,SBW-AMIE UTILITIES ; 3/MAY/2011
 ;;2.7;AMIE;**17,32,168**;Apr 10, 1995;Build 3
 ;
SORT W !!,"Sort by Regional Office number" S %=1 D YN^DICN I $D(DTOUT)!(%<0) K DTOUT S Y=-1 Q
 I $D(%Y) I %Y["?" W !!,*7,"Enter Y to sort by the Regional Office number you",!,"select or enter N to get ALL Regional Offices reported." G SORT
 I %'=1 S RO="N",RONUM=0 Q
 I %=1 S RO="Y" G RONUM
 W !,*7,"Invalid response.",!! G SORT
 ;
RONUM W !,"Regional Office number: " R RONUM:DTIME G:RONUM["^" SORT I '$T!(RONUM="") W *7 S Y=-1 Q
 I RONUM'?3N.4AN W *7,"     Must be 3 numbers plus optional 1 to 4 alphanumeric modifier",!! G RONUM
 Q
 ;
KILL ;kill all variables and exit selected program
 D ^%ZISC
KILL1 K %DT,%ZIS,ANS,BDATE,CNUM,EDATE,L,MA,DA,NODTA,PNAM,Q,QQ,RDATE,SSN,XY,VER,J,LN,POP,FINALDTE,ADMDT,BEDSEC,CFLOC,DIAG,DCHGDT,HEAD,HEAD1,MB,RCVAA,RCVPEN,A,TYPE,C,ADMNUM,DIPGM,DIS,HNAME,DVBAQUIT,DSRP
 K WARD,NOASK,^TMP($J),DTOUT,ZTSK,IO("C"),I,RO,RONUM,LADM,K,RADM,%X,%Y,%XX,%YY,X,Y,ICDAT2,ICDAT,LOS,TDIS,DIC,POP,DVBATYPS,TO,NUMSEL,REP,DVBAFIND,DVBATP,DVBAPRNT,SITE,LINE,OPER,PG,HD,HD1,HEAD2,DVBADD
 K ZTIO,ZTDESC,ZTRTN,DATA,SC,LDCH,FDT(0),NAME,DIE,DR,ZX,ZI,XDA,XADMDT,DLAYGO,HD,D,DIC,Y,Z,ZTYPE,D0,D1,DI,DQ,CNM,CFLC,XDTA,MC,MD,PROCDT,ADMDATE,EDAYS,CNT,XLOC,TEMP,TEMPDA,%ZIS,%IS,DIVHD,XDIV,DVBADIV,ADIV,BDT,EDT
 K ZTYPE,DO,DTAR,X,Y,HEAD,HEAD1,ADTYPE,NDCH,DOCTYPE,ELIG,INCMP,LG,OUT,LADMDT,NONE,BDATE1,XDA2,ADM,DFN,DISCH,XCN,LCN,HOSP,NODE,T,TRN,ZTSAVE,ZDT,ZDT1,ZDA,IO("Q"),IOP,BDIV,EDIV,BDT1,EDT1,NEWREQ,BED,STAT,DVBADIC,ADMNUM
 K X2,DHD,DIWF,DIWL,DIWR,DVBASC,DVBAELIG,FNLDT,CFLC,HIST,DVBAELST,OLDY,PDATE,ZTDTH,DTA,VAINDT,VAIN,WWHO,SDATE,%,DVBAQUIT,NODE,NOFINAL,^TMP("ADMIT",$J),LOC,AA,DVBASTAT,OLDY,ADMDT,ANS1,CURADMDT,DVBADT,DVBAH,DVBAQ
 K DVBAI,DVBAT,HEADDT,HOSPDAYS,LBEDSEC,LDCHGDT,LDIAG,LLADM,LTDIS,MSG,MSG1,VX,VY,X1,XLINE,ZJ,ZY,ZZ,LOC,QUIT,QUIT1,^UTILITY($J),^TMP("DVBA",$J),^TMP("DVBA","PEN"),^TMP("DVBA","A&A"),DVBACEPT,DCHPTR,DVBA
 Q
 ;
LOS ;compute length of stay for discharge report
 S %DT="T" S X=ADMDT D ^%DT S X2=Y
 S X=DCHGDT D ^%DT S X1=Y K Y
 D ^%DTC S LOS=X I LOS=0 S LOS=""
 Q
DATE W !,?5,"The entry of future dates is NOT allowed.",!
 S %DT(0)=-DT
 S %DT("A")="BEGINNING date: ",%DT="AET" D ^%DT W:X="^"!(Y=-1) !! Q:X=""!(Y=-1)  S BDATE=Y
 S %DT("A")="   ENDING date: ",%DT="AET" D ^%DT S EDATE=Y Q:X="^"
 I EDATE<BDATE W !!,*7,"Invalid date sequence.  Beginning date must be before the ending date.",!! H 2 G DATE
 S BDATE=BDATE-.5,EDATE=EDATE+.5
 D SORT K %DT(0) Q
 ;
DICW S DVBADIC(0,"W")="S ZX=$P(^DVB(396,+Y,0),U,4) W:$X>40 ! W ""  Admission date: "",$$FMTE^XLFDT(ZX,""5DZ"") W ""  "",$S($P(^(1),U,12)'="""":""Finalized"",1:""Open"")"
 ;
DICW1 S DVBADIC(1,"W")="S ZX=$P(^DVB(396,+Y,0),U,4) W:$X>40 ! W ""  Activity date: "",$$FMTE^XLFDT(ZX,""5DZ"") W ""  "",$S($P(^(1),U,12)'="""":""Finalized"",1:""Open"")"
 ;
DICW2 S DIC("W")="S ZTYPE=$S($D(^DVB(396,+Y,2)):$P(^(2),U,10),1:""A"") X $S(ZTYPE=""L"":DVBADIC(1,""W""),1:DVBADIC(0,""W""))"
 Q
 ;
FINAL ;
 S $P(^DVB(396.1,1,0),"^",X)=DT ;x is the corresponding date field
 G KILL1
 ;
DUZ2 K DVBAQUIT
 I $G(DUZ(2))="" W *7,!!,"You have no division code.  Please contact the site manager.",!! H 3 S DVBAQUIT=1 Q
 S DVBAD2=$S($D(^DIC(4,+DUZ(2),99)):$P(^(99),U,1),1:0)
 I DVBAD2=0 W *7,!!,"Your division code is invalid.",!! H 3 S DVBAQUIT=1
 ; Flag if the division has no station # in the INSITUTION file.
 I $G(DVBAD2)="" W *7,!!,"Your division has no station number defined in the INSTITUTION file.",!,"Please consult IRM to request a unique station number for your division.",!! H 3 S DVBAQUIT=1
 Q
S ;
 ;this code is currently not available but will be in future version
 ;of AMIE.
 Q
S1 ;
 ;this code is currently not available but will be in future version
 ;of AMIE.
 Q
K ;
 ;this code is currently not available but will be in future version
 ;of AMIE.
 Q
K1 ;
 ;this code is currently not available but will be in future version
 ;of AMIE.
 Q
 ;
EXIT ;called from the DVBAREG1 routine, kills off variables at end.
 S VAR(1,0)="0,0,0,0:2,1^"
 D WR^DVBAUTL4("VAR")
 K VAR,ADM,ADMDT,ANS,CNUM,DA,DFN,DIC,DIE,DR,PNAM,SSN,ZA,OPER,X,Y,POP,LOC,%,ZI,ONFILE,REOPEN,DVBADIV,STAT,ZX,HD,I,NAME,HNAME,DTAR,DTOUT,%Y,DOCTYPE,%Y1,DQ,DVBADIC,OUT,ZTYPE,A,ADMNUM,ANS1,OLDY,DVBASTAT,DVBAENTR,DVBAEDT
 K DVBAD2,DVBAX,DVBCSSNO,AROWOUT,DVBADM,DVBANL,DVBAPT,DVBAQUIT,DVBBDT,DVBCHK,DVBDISP,DVBEDT,DVBSPCOD,DVBVAR,DVBCNT,DVBAY,DVBDOC,DVBAIFN,DVBANS
 K ^TMP("DVBA",$J),^UTILITY("DIQ1",$J)
 Q
 ;
