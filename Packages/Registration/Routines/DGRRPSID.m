DGRRPSID ; ALB/SGG - rtnDGRR PatientServices Identifier ;09/30/03  ; Compiled October 2, 2003 12:41:01
 ;;5.3;Registration;**557**;Aug 13, 1993
 ;
DOC ;<Identifier>
 ;PatientICN - patient's ICN is set from initial PARAMS()
 ;PatientDFN - patient's DFN is set up as PTID from initial PARAMS()
 ;.01       NAME (RFXa), [0;1]
 ;.09       SOCIAL SECURITY NUMBER (RFXa), [0;9]
 ;.03       DATE OF BIRTH (RDXOa), [0;3]
 ;.363      PRIMARY LONG ID (F), [.36;3]
 ;.364      PRIMARY SHORT ID (F), [.36;4]
 ;
GETPSARY(PSARRAY) ;
 NEW CNT
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="<Identifier"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^ICN^"_$$PATICN()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^DFN^"_$$PATDFN()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^FullName^"_$$FULLNAME()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^SSN^"_$$PATSSN()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^DateOfBirth^"_$$PATDOB()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^PrimaryLongID^"_$$PRMLNID()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^PrimaryShortID^"_$$PRMSHID()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="></Identifier>"_"^^^1"
 QUIT
 ;
PATICN() ;
 QUIT $G(ICN)
 ;
PATDFN() ;
 QUIT $G(PTID)
 ;
FULLNAME() ;
 QUIT $P(GLOB(0),"^",1)
 ;
PATSSN() ;
 QUIT $P(GLOB(0),"^",9)
 ;
PATDOB() ;
 QUIT $P(GLOB(0),"^",3)
 ;
PRMLNID() ;
 QUIT $P(GLOB(.36),"^",3)
 ;
PRMSHID() ;
 QUIT $P(GLOB(.36),"^",4)
