QANPEDT ;HISC/GJC-EDIT OF A PATIENT ON THE NQADB ;7/12/93  09:42
 ;;2.0;Incident Reporting;**20**;08/07/1992
 ;
 ;*** Required Variables ***
 ;QA1 --------> New patient name
 ;QAHDNM -----> Old patient name
 ;QAHDSSN ----> Old patient SSN
 ;QANIEN -----> IEN of file 742.4
 ;QANSSN -----> New patient SSN
 ;*** Required Variables ***
 N QANCASE,QANINCD,QANDATE,QAN7424 K ^UTILITY($J,"QAN MAIL")
 ; Set up string of data
 S QAN7424=$G(^QA(742.4,QANIEN,0)),QANZER0=$G(^QA(740,1,0))
 S QANSERV=$P(QANZER0,U,4),QANDOM=$P(QANZER0,U,5)
 S QANCASE=$P(QAN7424,U),QANINCD=$P(QAN7424,U,2),QANDATE=$P(QAN7424,U,3)
 S QANINCD=$P($G(^QA(742.1,QANINCD,0)),U)
 S QANINCD=$TR(QANINCD,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S ^UTILITY($J,"QAN MAIL",1)="^^PEDIT^"_$G(QANCASE)_"^"_$G(QANINCD)_"^"_$G(QANDATE)_"^"_$G(QAHDNM)_"^"_$G(QAHDSSN)_"^"_$G(QA1)_"^"_$G(QANSSN)_"^"_$G(QANADMDT)_"^"_$G(QANDOB)_"^"
 D BULL^QANFULL0 ;Fire off the message.
EXIT ;
 K QANDOM,QANZER0,QANSERV
 Q
