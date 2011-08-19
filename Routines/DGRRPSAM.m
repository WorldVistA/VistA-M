DGRRPSAM ; ALB/SGG - rtnDGRR PatientServices Address Main ; 09/30/03  ; Compiled October 2, 2003 16:00:54
 ;;5.3;Registration;**557**;Aug 13, 1993
 ;
DOC ;<DataSet Name='MainAddress'
 ;.111      STREET ADDRESS [LINE 1] (Fa), [.11;1]
 ;.112      STREET ADDRESS [LINE 2] (Fa), [.11;2]
 ;.113      STREET ADDRESS [LINE 3] (Fa), [.11;3]
 ;.114      CITY (Fa), [.11;4]
 ;.115      STATE (P5'a), [.11;5]
 ;.116      ZIP CODE (F), [.11;6]
 ;     .1112     ZIP+4 (FXOa), [.11;12]
 ;.117      COUNTY (NJ3,0XOa), [.11;7]
 ;.121      BAD ADDRESS INDICATOR (S), [.11;16]
 ;           '1' FOR UNDELIVERABLE;
 ;           '2' FOR HOMELESS; 
 ;           '3' FOR OTHER;
 ;.14105    CONFIDENTIAL ADDRESS ACTIVE? (RSX), [.141;9]
 ;.131      PHONE NUMBER [RESIDENCE] (Fa), [.13;1]
 ;.132      PHONE NUMBER [WORK] (Fa), [.13;2]
 ;
GETPSARY(PSARRAY) ;
 NEW CNT
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="<DataSet Name='MainAddress'"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Street1^"_$$AMSTRE1()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Street2^"_$$AMSTRE2()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Street3^"_$$AMSTRE3()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^City^"_$$AMCITY()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^State^"_$$AMSTATE()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Zip^"_$$AMZIP()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^County^"_$$AMCOUNTY()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^StartDate^"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^EndDate^"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^BadAddressIndicator^"_$$AMBADIND()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^ConfidentialAddressActive^"_$$AMCNFAC()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^PhoneNumber^"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^HomePhoneNumber^"_$$AMPHNHM()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^WorkPhoneNumber^"_$$AMPHNWK()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="></DataSet>"_"^^^1"
 QUIT
 ;
AMSTRE1() ;
 QUIT $P(GLOB(.11),"^",1)
 ;
AMSTRE2() ;
 QUIT $P(GLOB(.11),"^",2)
 ;
AMSTRE3() ;
 QUIT $P(GLOB(.11),"^",3)
 ;
AMCITY() ;
 QUIT $P(GLOB(.11),"^",4)
 ;
AMSTATE() ;
 NEW DATA
 SET DATA=$P(GLOB(.11),"^",5)
 IF DATA'="" SET DATA=$P($G(^DIC(5,DATA,0)),"^",2)
 QUIT DATA
 ;
AMZIP() ;
 NEW DATA
 SET DATA=$P(GLOB(.11),"^",12)
 IF DATA="" SET DATA=$P(GLOB(.11),"^",6)
 QUIT DATA
 ;
AMCOUNTY() ;
 NEW DATA,STATE
 SET STATE=$P(GLOB(.11),"^",5)
 SET DATA=$P(GLOB(.11),"^",7)
 IF DATA'="",STATE'="" SET DATA=$P($G(^DIC(5,STATE,1,DATA,0)),"^",1)
 QUIT DATA
 ;
AMBADIND() ;
 NEW DATA
 SET DATA=$P(GLOB(.11),"^",16)
 SET DATA=$S(DATA=1:"UNDELIVERABLE",DATA=2:"HOMELESS",DATA=3:"OTHER",1:"")
 QUIT DATA
 ;
AMCNFAC() ;
 NEW DATA
 SET DATA=$P(GLOB(.141),"^",9)
 SET DATA=$S(DATA="Y":"YES",1:"NO")
 QUIT DATA
 ;
AMPHNHM() ;
 QUIT $P(GLOB(.13),"^",1)
 ;
AMPHNWK() ;
 QUIT $P(GLOB(.13),"^",2)
