DGRRPSIC ; ALB/SGG - rtnDGRR PatientServices Incompetent ;09/30/03  ; Compiled October 21, 2003 15:06:51
 ;;5.3;Registration;**557**;Aug 13, 1993
 ;
DOC ;<DataSet Name='Incompetent'
 ;
 ;.293      RATED INCOMPETENT? (S), [.29;12]
 ;          '0' FOR NO
 ;          '1' FOR YES
 ;
 ;.291      DATE RULED INCOMPETENT (VA) (D), [.29;1]
 ;.2911     INSTITUTION (VA) (P4'), [.29;3]
 ;.2912     GUARDIAN (VA) (F), [.29;4]
 ;.2913     RELATIONSHIP (VA) (F), [.29;5]
 ;.2914     STREET ADDRESS 1 (VA) (F), [.29;6]
 ;.2915     STREET ADDRESS 2 (VA) (F), [.29;7]
 ;.2916     CITY (VA) (F), [.29;8]
 ;.2917     STATE (VA) (P5'), [.29;9]
 ;.2918     ZIP (VA) (F), [.29;10]
 ;.29013    ZIP+4 (VA) (FOX), [.29;13]
 ;.2919     PHONE (VA) (F), [.29;11]
 ;
 ;.292      DATE RULED INCOMPETENT (CIVIL) (D), [.29;2]
 ;.2921     INSTITUTION (CIVIL) (F), [.291;3]
 ;.2922     GUARDIAN (CIVIL) (F), [.291;4]
 ;.2923     RELATIONSHIP (CIVIL) (F), [.291;5]
 ;.2924     STREET ADDRESS 1 (CIVIL) (F), [.291;6]
 ;.2925     STREET ADDRESS 2 (CIVIL) (F), [.291;7]
 ;.2926     CITY (CIVIL) (F), [.291;8]
 ;.2927     STATE (CIVIL) (P5'), [.291;9]
 ;.2928     ZIP (CIVIL) (F), [.291;10]
 ;.290012   ZIP+4 (CIVIL) (FOX), [.291;12]
 ;.2929     PHONE (CIVIL) (F), [.291;11]
 ;
GETPSARY(PSARRAY) ;
 NEW CNT
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="<DataSet Name='Incompetent'"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^RatedIncompetent^"_$$RATEDIC()
 DO INCOMP("VETERAN",GLOB(.29),1,13)  ;  VA
 DO INCOMP("CIVIL",GLOB(.291),2,12)  ; Civil
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="></DataSet>"_"^^^1"
 QUIT
 ;
INCOMP(ICTYPE,ADGLOB,DTPIECE,ZIP4) ;
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^DateRuledIncompetent"_$E(ICTYPE,1)_"^"_$P(GLOB(.29),"^",DTPIECE)
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Institution"_$E(ICTYPE,1)_"^"_$$ADINST()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Guardian"_$E(ICTYPE,1)_"^"_$P(ADGLOB,"^",4)
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^RelationshipToPatient"_$E(ICTYPE,1)_"^"_$P(ADGLOB,"^",5)
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Street1"_$E(ICTYPE,1)_"^"_$P(ADGLOB,"^",6)
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Street2"_$E(ICTYPE,1)_"^"_$P(ADGLOB,"^",7)
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^City"_$E(ICTYPE,1)_"^"_$P(ADGLOB,"^",8)
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^State"_$E(ICTYPE,1)_"^"_$$ADSTATE()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Zip"_$E(ICTYPE,1)_"^"_$$ADZIP()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^PhoneNumber"_$E(ICTYPE,1)_"^"_$P(ADGLOB,"^",11)
 QUIT
 ;
RATEDIC() ;
 NEW DATA
 SET DATA=$P(GLOB(.29),"^",12)
 SET DATA=$S(DATA=1:"YES",DATA=0:"NO",1:"")
 QUIT DATA
 ;
 ;
ADINST() ;
 NEW DATA
 SET DATA=$P(ADGLOB,"^",3)
 IF ICTYPE="VETERAN",DATA'="" SET DATA=$P($$NS^XUAF4(+DATA),"^",1)
 QUIT DATA
 ;
ADSTATE() ;
 NEW DATA
 SET DATA=$P(ADGLOB,"^",9)
 IF DATA'="" SET DATA=$P($G(^DIC(5,DATA,0)),"^",2)
 QUIT DATA
 ;
 Q
ADZIP() ;
 NEW DATA
 SET DATA=$P(ADGLOB,"^",ZIP4)
 IF DATA="" SET DATA=$P(ADGLOB,"^",10)
 QUIT DATA
 Q
