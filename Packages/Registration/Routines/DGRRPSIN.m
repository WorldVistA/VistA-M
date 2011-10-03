DGRRPSIN ;ALB/SGG - rtnDGRR PatientServices DataSet=Institution ;09/30/03  ; Compiled October 2, 2003 12:40:56
 ;;5.3;Registration;**557**;Aug 13, 1993
 ;
DOC ;
 ;
GETPSARY(PSARRAY) ;
 NEW CNT
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="<Institution"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Name^"_$$INSTNAM()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Number^"_$$INSTNUM()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^IsProductionDatabase^"_$$ISPRODDB()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="></Institution>"_"^^^1"
 QUIT
 ;
INSTNAM() ;
 QUIT $$SITENAM^DGRR557U()
INSTNUM() ;
 QUIT $$SITENO^DGRR557U()
ISPRODDB() ;
 QUIT $$PRODST1^DGRR557U()+$$PRODST2^DGRR557U()
