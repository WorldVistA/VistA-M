SDECPAT ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ; This routine sets standard patient variables
START(SDDFN,DFN,SSN,AGE,DOB,SEX) ;
 S:$D(X) AUPNPATX=X
 S AUPNPAT=+SDDFN
 S AUPNSEX=$P(^DPT(AUPNPAT,0),U,2),AUPNDOB=$P(^(0),U,3),AUPNDOD="" S:$D(^(.35)) AUPNDOD=$P(^(.35),U,1)
 S X2=AUPNDOB,X1=$S('AUPNDOD:DT,AUPNDOD:AUPNDOD,1:DT)
 D ^%DTC
 S AUPNDAYS=X
 ;S X="BEHOPTCX" X ^%ZOSF("TEST") I $T D SETCTX^BEHOPTCX(+AUPNPAT)
 K X,X1,X2
 S:$D(AUPNPATX) X=AUPNPATX
 K %T,%Y,AUPNPATX
 S DFN=AUPNPAT
 S SSN=$$SSN(AUPNPAT)
 S AGE=$$AGE(AUPNPAT)
 S DOB=$$DOB(AUPNPAT)
 S SEX=$$SEX(AUPNPAT)
 Q
 ;
KILL ;PEP - KILL VARIABLES SET BY THIS ROUTINE
 K AUPNPAT,AUPNSEX,AUPNDOB,AUPNDOD,AUPNDAYS
 K AGE,DFN,DOB,SEX,SSN
 Q
 ;
 ;  NOTE TO PROGRAMMERS:
 ;   All parameters are required, except the Format parameter ("F").
 ;   The default for the Format parameter is the internal format of
 ;   the returned value.
 ;
AGE(DFN,D,F) ;PEP - Given DFN, return Age.
 ;return age on date d in format f (defaults to DT and age in years)
 Q $$AGE^SDECPAT3(DFN,$G(D),$G(F))
 ;
CDEATH(DFN,F) ;PEP - returns Cause of Death in F format
 Q $$CDEATH^SDECPAT3(DFN,$G(F))
 ;
DEC(PID) ;PEP - RETURN DECRYPTED PATIENT IDENTIFIER
 Q:$$DEC^SDECPAT4(PID)
 ;----------
ENC(DFN) ;PEP
 Q $$ENC^SDECPAT4(DFN)
 ;----------
DOB(DFN,F) ;PEP - Given DFN, return Date of Birth according to F.
 Q $$DOB^SDECPAT3(DFN,$G(F))
 ;
DOD(DFN,F) ;PEP - Given DFN, return Date of Death in FM format.
 Q $$DOD^SDECPAT3(DFN,$G(F))
 ;
ELIGSTAT(DFN,F) ;PEP - returns eligibility status in F format
 Q $$ELIGSTAT^SDECPAT3(DFN,$G(F))
 ;
HRN(DFN,L,F) ;PEP
 ;f patch 4 05/08/96
 Q $$HRN^SDECPAT3(DFN,L,$G(F))
 ;
MCD(P,D) ;PEP - Is patient P medicaid eligible on date D?
 Q $$MCD^SDECPAT2(P,D)
 ;
MCDPN(P,D,F) ;PEP - return medicaid plan name for patient P on date D in form F.
 Q $$MCDPN^SDECPAT2(P,D,$G(F))
 ;
MCR(P,D) ;PEP - Is patient P medicare eligible on date D?
 Q $$MCR^SDECPAT2(P,D)
 ;
PI(P,D) ;PEP - Is patient P private insurance eligible on date D?
 Q $$PI^SDECPAT2(P,D)
 ;
PIN(P,D,F) ;PEP - return private insurer name for patient P on date D in form F.
 Q $$PIN^SDECPAT2(P,D,$G(F))
 ;
SEX(DFN) ;PEP - Given DFN, return Sex.
 Q $$SEX^SDECPAT3(DFN)
 ;
SSN(DFN) ;PEP - Given DFN, return SSN.
 Q $$SSN^SDECPAT3(DFN)
 ;
RR(P,D) ;PEP -  Is patient P railroad eligible on date D?
 Q $$RRE^SDECPAT2(P,D)
