DGRRPSD1 ; ALB/SGG - rtnDGRR PatientServices Demographics Primary ;09/30/03  ; Compiled February 3, 2004 17:14:03
 ;;5.3;Registration;**557**;Aug 13, 1993
 ;
DOC ;<DataSet Name='PrimaryDemographics'
 ;[2]     .02       SEX (RSa), [0;2]
 ;[2]     .05       MARITAL STATUS (RP11'a), [0;5]
 ;[2]     .351      DATE OF DEATH (DXa), [.35;1]
 ;[2]     .352      DEATH ENTERED BY (P200'), [.35;2]
 ;[38.1]  2         SECURITY LEVEL (RSX), [0;2]
 ;[2]     .08       RELIGIOUS PREFERENCE (P13'a), [0;8]
 ;[2]     .091      REMARKS (F), [0;10]
 ;
GETPSARY(PSARRAY) ;
 NEW CNT
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="<DataSet Name='PrimaryDemographics'"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Gender^"_$$GENDER()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^MaritalStatus^"_$$MARISTAT()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^DateOfDeath^"_$$PATDOD()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^DeathEnteredBy^"_$$DODENTBY()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^DeathEnteredByVPID^"_$$DODVPID()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^SecurityLevel^"_$$SECURLVL()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^ReligiousPreference^"_$$RELIPREF()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Remarks^"_$$REMARKS()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="></DataSet>"_"^^^1"
 QUIT
 ;
GENDER() ;
 NEW DATA
 SET DATA=$P(GLOB(0),"^",2)
 QUIT $S(DATA="M":"MALE",DATA="F":"FEMALE",1:"")
 ;
MARISTAT() ;
 NEW DATA
 SET DATA=$P(GLOB(0),"^",5)
 QUIT $S(DATA="":"",1:$P($G(^DIC(11,DATA,0)),"^",1))
 ;
PATDOD() ;
 QUIT $P(GLOB(.35),"^",1)
 ;
DODENTBY() ;
 NEW DATA
 SET DATA=$P(GLOB(.35),"^",2)
 IF DATA'="" SET DATA=$P($G(^VA(200,DATA,0)),"^",1)
 QUIT DATA
 ;
DODVPID() ;
 QUIT $$VPID^XUPS($P(GLOB(.35),"^",2))
 ;
SECURLVL() ;
 QUIT $S($P($G(^DGSL(38.1,PTID,0)),"^",2)=1:"SENSITIVE",1:"NON-SENSITIVE")
 ;
RELIPREF() ;
 NEW DATA
 SET DATA=$P(GLOB(0),"^",8)
 QUIT $S(DATA="":"",1:$P($G(^DIC(13,DATA,0)),"^",1))
 ;
REMARKS() ;
 QUIT $P(GLOB(0),"^",10)
