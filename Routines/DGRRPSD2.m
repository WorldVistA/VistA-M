DGRRPSD2 ; ALB/SGG - rtnDGRR PatientServices Demographics Secondary ;09/30/03  ; Compiled December 9, 2003 15:23:28
 ;;5.3;Registration;**557**;Aug 13, 1993
 ;
DOC ;<DataSet Name='SecondaryDemographics'
 ;
 ;FROM: ^DGSL(38.1,
 ;3         SECURITY ASSIGNED BY (RP200'), [0;3]
 ;4         DATE/TIME SECURITY ASSIGNED (RD), [0;4]
 ;5         SECURITY SOURCE (F), [0;5]
 ;
 ;FROM: ^DPT(PTID
 ;          RACE INFORMATION (Multiple-2.02), [.02;0]
 ;          .01  RACE INFORMATION (M*P10'X), [0;1]
 ;          .02  METHOD OF COLLECTION (RP10.3'), [0;2]
 ;
 ;.352      DEATH ENTERED BY (P200'), [.35;2]
 ;
 ;6         ETHNICITY INFORMATION (Multiple-2.06), [.06;0]
 ;          .01  ETHNICITY INFORMATION (*P10.2'X), [0;1]
 ;          .02  METHOD OF COLLECTION (RP10.3'), [0;2]
 ;          
 ;Primary Care Provider - Use $$NMPCPR^SCAPMCU2(PTID,DT,1) API to
 ;          retrieve Primary Care Provider.  Call VPID^XUPS API to
 ;          convert DUZ to VPID.                    
 ;
GETPSARY(PSARRAY) ;
 NEW CNT
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="<DataSet Name='SecondaryDemographics'"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^SecurityAssignedBy^"_$$SECASGBY()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^DateTimeSecurityAssigned^"_$$DTSECASG()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^SecuritySource^"_$$SECSOURC()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^PrimaryCareProvider^"_$$PCP()
 DO ETHNINFO
 DO RACEINFO
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="</DataSet>"_"^^^1"
 QUIT
 ;
SECASGBY() ;
 NEW DATA
 SET DATA=$P(GLOB(38.1),"^",3)
 IF DATA'="" S DATA=$P($G(^VA(200,DATA,0)),"^",1)
 QUIT DATA
 ;
DTSECASG() ;
 QUIT $P(GLOB(38.1),"^",4)
 ;
SECSOURC() ;
 QUIT $P(GLOB(38.1),"^",5)
 ;
DODENTBY() ;
 NEW DATA
 SET DATA=$P(GLOB(.35),"^",2)
 IF DATA'="" SET DATA=$P($G(^VA(200,DATA,0)),"^",1)
 QUIT DATA
 ;
DODVPID() ;
 ;QUIT "200#ROOT"_$P(GLOB(.35),"^",2)
 QUIT $$VPID^XUPS($P(GLOB(.35),"^",2))
 ;
PCP() ;Primary Care Provider
 ; get the PCP's IEN and convert to VPID (primary care physician)
 ; 
 N PATSPCP,PCPIEN,PCPVPID
 SET PATSPCP=$$NMPCPR^SCAPMCU2(PTID,DT,1)
 SET PCPIEN=$P(PATSPCP,"^",1)
 SET PCPVPID=$$VPID^XUPS(+PCPIEN)
 QUIT PCPVPID
 ;
ETHNINFO ;
 NEW ETHCNT,ROWCNT,ETHNIC,METHOD
 SET ETHCNT=0,ROWCNT=0
 FOR  SET ETHCNT=$O(^DPT(PTID,.06,ETHCNT)) QUIT:(ETHCNT<1)  DO
 .SET ETHNIC=$P($G(^DPT(PTID,.06,ETHCNT,0)),"^",1)
 .SET METHOD=$P($G(^DPT(PTID,.06,ETHCNT,0)),"^",2)
 .IF ETHNIC'="" DO
 ..SET ROWCNT=ROWCNT+1
 ..SET ETHNIC=$P($G(^DIC(10.2,ETHNIC,0)),"^",1)
 ..IF METHOD'="" SET METHOD=$P(^DIC(10.3,METHOD,0),"^",1)
 ..SET CNT=$G(CNT)+1,PSARRAY(CNT)="><Ethnicity Row='"_ROWCNT_"'"
 ..SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Ethnicity^"_ETHNIC_"^^ETHNIC^"_ROWCNT
 ..SET CNT=$G(CNT)+1,PSARRAY(CNT)="^MethodOfCollection^"_METHOD_"^^ETHNIC^"_ROWCNT
 ..SET CNT=$G(CNT)+1,PSARRAY(CNT)="></Ethnicity>"
 IF ROWCNT=0 DO
 .SET CNT=$G(CNT)+1,PSARRAY(CNT)="><Ethnicity Row='1' Ethnicity='' MethodOfCollection=''></Ethnicity>"
 QUIT
 ;
RACEINFO ;
 NEW RACECNT,ROWCNT,RACE,METHOD
 SET RACECNT=0,ROWCNT=0
 FOR  SET RACECNT=$O(^DPT(PTID,.02,RACECNT)) QUIT:(RACECNT<1)  DO
 .SET RACE=$P($G(^DPT(PTID,.02,RACECNT,0)),"^",1)
 .SET METHOD=$P($G(^DPT(PTID,.02,RACECNT,0)),"^",2)
 .IF RACE'="" DO
 ..SET ROWCNT=ROWCNT+1
 ..SET RACE=$P($G(^DIC(10,RACE,0)),"^",1)
 ..IF METHOD'="" SET METHOD=$P(^DIC(10.3,METHOD,0),"^",1)
 ..SET CNT=$G(CNT)+1,PSARRAY(CNT)="<Race Row='"_ROWCNT_"'"
 ..SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Race^"_RACE_"^^RACE^"_ROWCNT
 ..SET CNT=$G(CNT)+1,PSARRAY(CNT)="^MethodOfCollection^"_METHOD_"^^RACE^"_ROWCNT
 ..SET CNT=$G(CNT)+1,PSARRAY(CNT)="></Race>"
 IF ROWCNT=0 DO
 .SET CNT=$G(CNT)+1,PSARRAY(CNT)="<Race Row='1' Race='' MethodOfCollection=''></Race>"
 QUIT
