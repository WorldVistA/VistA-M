DGRRPSAC() ; ALB/SGG rtnDGRR PatientServices Address Confidential ; 09/30/03  ; Compiled October 2, 2003 12:40:53
 ;;5.3;Registration;**557**;Aug 13, 1993
 ;
DOC ;<DataSet Name='ConfidentialAddress'
 ;.1411     CONFIDENTIAL STREET [LINE 1] (FX),               [.141;1]
 ;.1412     CONFIDENTIAL STREET [LINE 2] (FX)                [.141;2]
 ;.1413     CONFIDENTIAL STREET [LINE 3] (FX)                [.141;3]
 ;.1414     CONFIDENTIAL ADDRESS CITY (FX)                   [.141;4]
 ;.1415     CONFIDENTIAL ADDRESS STATE (P5'X)                [.141;5]
 ;.1416     CONFIDENTIAL ADDRESS ZIP CODE (FXO)              [.141;6]
 ;.14111    CONFIDENTIAL ADDRESS COUNTY (NJ3,0OX)            [.141;11]
 ;.1417     CONFIDENTIAL START DATE (DX)                     [.141;7]
 ;.1418     CONFIDENTIAL END DATE (DX)                       [.141;8]
 ;.141      CONFIDENTIAL ADDRESS CATEGORY (Multiple-2.141)   [.14;0]
 ;     .01  CONFIDENTIAL ADDRESS CATEGORY (MS), [0;1]
 ;    1     CONFIDENTIAL CATEGORY ACTIVE (S), [0;2]
 ;          1    CONFIDENTIAL CATEGORY ACTIVE (S)            [0;2]
 ;               'Y' FOR YES; 
 ;               'N' FOR NO;
 ;          .01  CONFIDENTIAL ADDRESS CATEGORY (MS)          [0;1]
 ;               '1' FOR ELIGIBILITY/ENROLLMENT
 ;               '2' FOR APPOINTMENT/SCHEDULING
 ;               '3' FOR COPAYMENTS/VETERAN BILLING
 ;               '4' FOR MEDICAL RECORDS
 ;               '5' FOR ALL OTHERS
 ;
GETPSARY(PSARRAY) ;
 NEW CNT
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="<DataSet Name='ConfidentialAddress'"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Street1^"_$$ACSTRE1()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Street2^"_$$ACSTRE2()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Street3^"_$$ACSTRE3()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^City^"_$$ACCITY()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^State^"_$$ACSTATE()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Zip^"_$$ACZIP()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^County^"_$$ACCOUNTY()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^StartDate^"_$$ACSTDATE()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^EndDate^"_$$ACENDATE()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^BadAddressIndicator^"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^ConfidentialAddressActive^"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^PhoneNumber^"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^HomePhoneNumber^"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^WorkPhoneNumber^"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)=">"
 DO ACCAC
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="</DataSet>"_"^^^1"
 QUIT
 ;
ACSTRE1() ;
 QUIT $P(GLOB(.141),"^",1)
 ;
ACSTRE2() ;
 QUIT $P(GLOB(.141),"^",2)
 ;
ACSTRE3() ;
 QUIT $P(GLOB(.141),"^",3)
 ;
ACCITY() ;
 QUIT $P(GLOB(.141),"^",4)
 ;
ACSTATE() ;
 NEW DATA
 SET DATA=$P(GLOB(.141),"^",5)
 QUIT $S(DATA="":"",1:$P($G(^DIC(5,DATA,0)),"^",2))
 ;
ACZIP() ;
 QUIT $P(GLOB(.141),"^",6)
 ;
ACCOUNTY() ;
 N DATA,STATE
 SET STATE=$P(GLOB(.141),"^",5)
 SET DATA=$P(GLOB(.141),"^",11)
 IF DATA'="",STATE'="" SET DATA=$P($G(^DIC(5,STATE,1,DATA,0)),"^",1)
 QUIT DATA
 ;
ACSTDATE() ;
 QUIT $P(GLOB(.141),"^",7)
 ;
ACENDATE() ;
 QUIT $P(GLOB(.141),"^",8)
 ;
ACCAC ;
 NEW CACCNT,ROWCNT,CAC,CACACT,DATA
 SET CACCNT=0,ROWCNT=0
 FOR  SET CACCNT=$O(GLOB(.14,CACCNT)) QUIT:'+CACCNT  DO
 .SET DATA=$P($G(GLOB(.14,CACCNT,0)),"^",1)
 .SET CAC=$S(DATA=1:"ELIGIBILITY/ENROLLMENT",DATA=2:"APPOINTMENT/SCHEDULING",DATA=3:"COPAYMENTS/VETERAN BILLING",DATA=4:"MEDICAL RECORDS",DATA=5:"ALL OTHERS",1:"")
 .SET CACACT=$S($P($G(GLOB(.14,CACCNT,0)),"^",2)="Y":"TRUE",$P($G(GLOB(.14,CACCNT,0)),"^",2)="N":"FALSE",1:"")
 .SET ROWCNT=ROWCNT+1
 .SET CNT=$G(CNT)+1,PSARRAY(CNT)="<ConfidentialAddressCategory Row='"_ROWCNT_"'"
 .SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Category^"_CAC
 .SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Active^"_CACACT
 .SET CNT=$G(CNT)+1,PSARRAY(CNT)="></ConfidentialAddressCategory>"
 IF ROWCNT=0 DO
 .SET CNT=$G(CNT)+1,PSARRAY(CNT)="<ConfidentialAddressCategory Row='1' Category='' Active=''></ConfidentialAddressCategory>"
 QUIT
