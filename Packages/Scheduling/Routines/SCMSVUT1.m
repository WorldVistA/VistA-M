SCMSVUT1 ;ALB/JLU;validation utility routine;06/19/99 ; 4/30/03 11:58am
 ;;5.3;Scheduling;**66,143,180,239,247,258,296,295,321,341,387,459,394,442**;AUG 13,1993
 ;06/19/99 ACS - Added CPT Modifier API calls to PROCCOD(DATA)
 ;
SEGERR(DATA,HLFS) ;
 ;INPUT DATA - This is a check for the segment errors of null
 ;      HLFS - The string separator character
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I $L(DATA,HLFS)'>2 Q 0
 Q 1
 ;
DODA(DATA) ;
 ;INPUT   DATA - The FM date of death.
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 1
 N %DT,X,Y
 S %DT="T",%DT(0)="-NOW",X=DATA
 D ^%DT
 Q $S(Y=-1:0,1:1)
 ;
DODB(DATA,ENCDT) ;
 ;INPUT   DATA - The FM date of death
 ;       ENCDT - The FM date of encounter
 I '$D(DATA) Q 0
 I DATA="" Q 1
 N %DT,X,Y
 S %DT="T",%DT(0)=ENCDT,X=DATA
 D ^%DT
 Q $S(Y=-1:0,1:1)
 ;
DODL(DATA,ENCDT) ;
 ;INPUT  DATA - The FM date of death
 ;      ENCDT - The FM date of the encounter
 I '$D(DATA) Q 0
 I '$D(ENCDT) Q 0
 I DATA="" Q 1
 I ENCDT<DATA Q 1
 I ENCDT=DATA Q 1
 N X1,X2,X
 S X1=ENCDT,X2=DATA
 D ^%DTC
 I X>14 Q 0
 Q 1
 ;
HOME(DATA) ;
 ;INPUT   DATA - THe homeless indicator to be validated.
 ;
 I '$D(DATA) Q 0
 I DATA'=1,DATA'=0 Q 0
 Q 1
 ;
POW(DATA) ;
 ;INPUT  DATA - The POW indicatort to be validated.
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 1
 I DATA'="N",DATA'="U",DATA'="Y" Q 0
 Q 1
 ;
TYPINS(DATA) ;
 ;INPUT  DATA - Type if insurance indicator to be validated.
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 1
 I DATA?.A Q 0
 I DATA>-1,(DATA<13) Q 1
 Q 0
 ;
PATCLSS(DATA) ;
 ;INPUT  DATA - the patient's class
 ;
 I '$D(DATA) Q 0
 I ("^O^I^")'[("^"_DATA_"^") Q 0
 Q 1
 ;
POV(DATA) ;
 ;
 ;INPUT DATA - the purpose of visit.
 ;SD*5.3*394 - Correction for addition POV.
 ;
 N VAR
 I '$D(DATA) Q 0
 I $L(DATA)'=4 Q 0
 I DATA?.A Q 0
 S VAR=$E(DATA,1,2)
 I VAR<1!(VAR>4) Q 0
 S VAR=$E(DATA,3,4)
 I VAR<1!(VAR=10) Q 0
 Q 1
 ;
COMPGEN(DATA) ;
 ;INPUT DATA - checking computer generated.
 ;
 N VAR
 S VAR=$E(DATA,3,4)
 I VAR=10 Q 0
 Q 1
 ;
LOCVIS(DATA) ;
 ;INPUT DATA - Location of visit
 ;
 I DATA'=1,DATA'=6 Q 0
 Q 1
 ;
FACNMBR(DATA) ;
 ;INPUT DATA - The facility number
 ;
 I '$D(DATA) Q 0
 I DATA'?3N.AN Q 0
 I '$D(^DIC(4,"D",DATA)) Q 0
 Q 1
 ;
FACACT(DATA,ENCDT,DIV) ;
 ;INPUT DATA - The active flag of the facility number.
 ;
 I '$D(DATA) Q 0
 I '$D(ENCDT) Q 0
 I '$D(DIV) Q 0
 I DATA="" Q 0
 N SITE
 I DIV]"" S SITE=$$SITE^VASITE(ENCDT,DIV)
 I DIV']"" S SITE=$$SITE^VASITE(ENCDT)
 I DATA'=$P(SITE,U,3) Q 0
 Q 1
 ;
ENCDT(DATA,XMTFLG) ;
 ;INPUT DATA - The date/time of the encounter
 ;    XMTFLG - Flag to check $$OKTOXMIT^SCDXFU04(DATA)
 ;
 I '$D(DATA) Q 0
 S XMTFLG=$G(XMTFLG,0)
 N %DT,X,Y
 S %DT="T"
 S X=DATA
 D ^%DT
 I Y=-1 Q 0
 I XMTFLG Q 1
 N VAR
 S VAR=$$OKTOXMIT^SCDXFU04(DATA)
 I +VAR<4&(VAR'<0) Q 1  ;SD*5.3*247
 Q 0
 ;
UNIQNMBR(DATA) ;
 ;INPUT DATA - The unique number from PCE for the encounter
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I DATA=-1 Q 0
 I DATA=0 Q 0
 Q 1
 ;
SEGCHK(DATA,HLFS) ;
 ;INPUT DATA - The segment to be checked.
 ;      HLFS - The HL7 field separator
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I $L(DATA,HLFS)'>2 Q 0
 Q 1
 ;
SEQNBR(DATA,SEQNBR) ;
 ;INPUT DATA - The sequence number to be checked.
 ;     SEQNBR - This is the previous seq number to compare to
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I +DATA'=+SEQNBR Q 0
 S SEQNBR=SEQNBR+1
 Q 1
 ;
DCODMTHD(DATA) ;
 ;INPUT DATA - This is the coding method to be checked.
 ;
 I '$D(DATA) Q 0
 I DATA'="I9" Q 0
 Q 1
 ;
DIAGCOD(DATA,ENCDT) ;
 ;INPUT DATA - This is the diagnosis code
 ;     ENCDT - This is the encounter date
 ;
 N VAR
 I '$D(DATA) Q 0
 I DATA="" Q 0
 ;
 Q $P($$ICDDX^ICDCODE(DATA,ENCDT),"^",10)
 ;
PRIOR(DATA) ;
 ;INPUT DATA - The priority of the diagnosis found
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 1
 I DATA=1 Q 1
 Q 0
 ;
ELIGCODM(DATA) ;
 ;INPUT DATA - The eligibility code
 ;A CHECK FOR MISSING
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I '$D(^DIC(8.1,DATA,0)) Q 0
 Q 1
 ;
ELIGINCV(DATA) ;
 ;INPUT DATA - Contains the eligibility code in the first piece and
 ;the veteran status in the second.
 ;
 ;the following quit is to stop this edit check.
 ;Per Austin 9/97 this is not needed.
 Q 1
 N VET,ELIG
 S VET=$P(DATA,U,2)
 S ELIG=$P(DATA,U,1)
 I VET=1&((ELIG<1)!(ELIG>18)) Q 0
 I VET=1,ELIG>5,ELIG<15 Q 0
 I VET=0,ELIG<6 Q 0
 I VET=0,ELIG=11 Q 0
 I VET=0,ELIG>14,ELIG'=19 Q 0
 Q 1
 ;
ELIGINCS(DATA) ;
 ;INPUT DATA - Eligibility code
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I '$D(^DIC(8.1,DATA,0)) Q 0
 I +$P(^DIC(8.1,DATA,0),U,7) Q 0
 Q 1
 ;
VETSTAT(DATA) ;
 ;INPUT DATA - The veteran status indicator
 ;
 I '$D(DATA) Q 0
 I DATA'=0,DATA'=1 Q 0
 Q 1
 ;
VETPOW(DATA,DFN) ;
 ;INPUT DATA - veteran status to check with POW status.
 ;       DFN - The DFN of the patient.
 ;
 N VAR,POW
 I DATA=0 Q 1
 S VAR=$G(^DPT(DFN,.52))
 S POW=$S(VAR]"":$P(VAR,U,5),1:VAR)
 I POW="" Q 1
 I POW="Y"!(POW="N")!(POW="U") Q 1
 Q 0
 ;
NMBRDEP(DATA) ;
 ;INPUT DATA - the number of dependents
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I DATA="XX" Q 1
 I DATA'?1.2N Q 0
 I +DATA>99!(+DATA<0) Q 0
 Q 1
 ;
PATINC(DATA) ;
 ;INPUT DATA - The patient's income
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I DATA<0 Q 0
 I DATA'?.N.1".".N Q 0
 Q 1
 ;
MEANSTST(DATA) ;
 ;INPUT DATA - The means test indicator
 ;
 I '$D(DATA) Q 0
 S DATA=","_DATA_","
 ; ** SD*296, added 'U' means test indicator to allowed list.
 I ",AS,AN,N,X,C,G,U,"'[DATA Q 0
 Q 1
 ;
DEPMEANS(DATA) ;
 ;INPUT DATA - This variable contains the number of dependents in the
 ;             first peice and the means test indicator in the second.
 ;
 N MT,DEP
 I '$D(DATA) Q 0
 S DEP=$P(DATA,U,1)
 S MT=","_$P(DATA,U,2)_","
 I DEP="XX",(",AS,N,X,U,"'[MT) Q 0
 Q 1
 ;
CLASSQUE(DATA) ;
 ;INPUT DATA - Classification question value.
 ;
 I '$D(DATA) Q 0
 I DATA'=1,DATA'=0,DATA'="" Q 0
 Q 1
 ;
CLAQUETY(DATA) ;
 ;INPUT DATA - Outpatient classification type to be checked.
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I '$D(^SD(409.41,DATA,0)) Q 0
 Q 1
 ;
CLAVET(DATA,DFN,TYPE,ENCPTR) ; SD*5.3*341 added parameter ENCPTR
 ;INPUT DATA - Classification question information to compare to VET
 ;             status
 ;       DFN - The patient to compare this info to.
 ;      TYPE - The classification type.
 ;    ENCPTR - Pointer to Outpatient Encounter
 ;
 I '$D(DATA) Q 0
 I '$D(DFN) Q 0
 I '$D(TYPE) Q 0  ; SD*5.3*341
 N VET,SDELG0,SDDT  ; SD*5.3*341
 S ENCPTR=$G(ENCPTR)  ; SD*5.3*341 added this plus next 3 lines
 S SDDT=+$G(^SCE(ENCPTR,0)) S:'SDDT SDDT=$$DT^XLFDT()
 S SDELG0=$$EL^SDCO22(DFN,ENCPTR)
 S VET=$P(SDELG0,U,5)
 I VET="Y",DATA'=1,DATA'=0,DATA'="" Q 0
 ;This edit check is per a mail message from austin
 I TYPE=4,VET'="Y",DATA'="","^A^B^C^D^"'[("^"_($P($G(^DIC(21,+$P($G(^DPT(DFN,.32)),"^",3),0)),"^",3))_"^") Q 0
 I VET'="Y",DATA'="" Q $$SCR^SDCO21(TYPE,DFN,SDDT,ENCPTR)  ; SD*5.3*341
 Q 1
 ;
STPCOD(DATA) ;
 ;INPUT DATA - stop code data to be checked
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I '$D(^DIC(40.7,"C",DATA)) Q 0
 Q 1
 ;
ACTSTP(DATA,ENCDT) ;
 ;INPUT  DATA - IEN of the stop code to be checked.
 ;      ENCDT - the encounter date in question
 ;
 N STPCOD,%DT,X,Y
 I '$D(DATA) Q 0
 I DATA="" Q 0
 S STPCOD=$G(^DIC(40.7,DATA,0))
 I STPCOD="" Q 0
 I '$P(STPCOD,U,3) Q 1
 S %DT(0)="-"_$P(STPCOD,U,3),%DT="T",X=ENCDT
 D ^%DT
 Q $S(Y=-1:0,1:1)
 ;
SERCON(DATA) ;
 ;INPUT DATA - Service connection to be checked, missing or invalid
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I DATA'=1,DATA'=0 Q 0
 Q 1
 ;
SCPER(DATA) ;
 ;INPUT DATA - Service connected % to be tested
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 1
 I DATA'?.N.1".".N Q 0
 Q 1
 ;
PRDSER(DATA) ;
 ;INPUT DATA - period of service to be tested.
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I '$D(^DIC(21,"D",DATA)) Q 0
 Q 1
 ;
VIETSER1(DATA) ;
 ;INPUT DATA - Vietnam service to be checked
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 1
 I DATA'="Y",DATA'="N",DATA'="U" Q 0
 Q 1
 ;
VIETSER2(DATA,DFN) ;
 ;INPUT DATA - Vietnam service to be checked against vet status
 ;
 I '$D(DATA) Q 0
 N VAR
 S VAR=$G(^DPT(DFN,"VET"))
 I DATA="",VAR'="Y" Q 1
 I (DATA="Y"!(DATA="N")!(DATA="U")),VAR="Y" Q 1
 Q 0
 ;
ACTPRD(DATA) ;
 ;INPUT DATA - period of serivce indicator to be check to ensure active
 ;
 N VAR
 I '$D(DATA) Q 0
 I DATA="" Q 0
 S VAR=+$O(^DIC(21,"D",DATA,0))
 S VAR=$P($G(^DIC(21,VAR,0)),U,8)
 I VAR Q 0
 Q 1
 ;
PCODMTHD(DATA) ;
 ;INPUT DATA - The coding method to be checked.
 ;
 I '$D(DATA) Q 0
 I DATA'="C4" Q 0
 Q 1
 ;
PROCCOD(DATA,ENCDT) ;
 ;INPUT DATA - The procedure code to be checked.
 ;This call makes the assumption that leading zeros are intact in the 
 ;input.
 ;
 N VAR
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I $$CPT^ICPTCOD(DATA,ENCDT,1)'>0 Q 0
 Q 1
 ;
PROVCLS(DATA) ;
 ;INPUT DATA - The practitioner class to be checked.
 ;
 N INACT S INACT=""
 I '$D(DATA) Q 0
 I DATA="" Q 0
 I $$CODE2TXT^XUA4A72(DATA)']"" Q 0
 S INACT=$P($$IEN2DATA^XUA4A72($$VCLK^XUA4A72(DATA)),U,5)  ;SD*5.3*442
 I INACT'="" I ENCDT>INACT Q 0  ;SD*5.3*442
 Q 1
 ;
ERI(DATA) ;
 ;INPUT  DATA - The Emergency Response indicator to be validated.
 ;
 I '$D(DATA) Q 0
 I DATA="" Q 1
 I DATA'="K" Q 0
 Q 1
 ;
