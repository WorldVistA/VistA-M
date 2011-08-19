QACUTIL ;HISC/DAD-Utilities ;1/31/95  09:51
 ;;2.0;Patient Representative;**3**;07/25/1995
EN1(Y) ;This utility returns the Code, Text and Quality Aspect
 ;for entry Y.
 N QAC,C
 S QAC=$G(^QA(745.2,+Y,0))
 I QAC]"" D
 . S QAC(1)=$P(QAC,"^"),QAC(3)=$P(QAC,"^",3),QAC(4)=+$P(QAC,"^",4)
 . S QAC(4)=$P($G(^QA(745.3,QAC(4),0)),"^",4)
 . S Y=QAC(4),C=$P(^DD(745.3,.04,0),"^",2),QAC(4)=""
 . I Y]"" D Y^DIQ S QAC(4)=Y
 . S QAC=QAC(1)_"   "_QAC(3)_"   "_QAC(4)
 Q QAC
EN2 ;Utility to display Issue Code description (?Code)
 Q:'$D(X)  Q:(X'?1."?"1.2A2.3N)  D HOME^%ZIS W !
 N QACLINE,QACCODE,QACFOUND,QACQUIT,QACIFN0,QACIFN1,CODE
 ;Get the code that follows '?'.
 S QACLINE=$Y,(QACCODE,QACCODE(0))=$$UP^XLFSTR($P(X,"?",$L(X,"?")))
 S (QACFOUND,QACQUIT,QACIFN0)=0
 F  S QACIFN0=$O(^QA(745.2,"B",QACCODE,QACIFN0)) Q:QACIFN0'>0!QACQUIT  D
 . ;Get code, name and description and display
 . D EN^DDIOL($P(^QA(745.2,QACIFN0,0),U)_"  "_$P(^(0),U,3))
 . D EN^DDIOL(" ")
 . D EN^DDIOL(" ")
 . D EN^DDIOL("","^QA(745.2,QACIFN0,1)")
 . S QACFOUND=1
 I 'QACFOUND  D EN^DDIOL("Code not found. Try again")
 Q
EN3 ;This utility returns a definition for the fields, Date Sent
 ;and Date Closed.
 Q:$D(DA)[0  N Y
 S Y=$P(^QA(745.1,DA,0),"^",2)\1 X ^DD("DD")
 D EN^DDIOL("  ")
 D EN^DDIOL("     Must be on or after the contact date: "_Y)
 S Y=DT X ^DD("DD") D EN^DDIOL("     and not later than: "_Y)
 D EN^DDIOL("  ")
 D EN^DDIOL("  ")
 Q
EN4(QACSIEN) ;This utility returns the Parent Service from file #49.
 N QAC,QACSERV S QACSERV="UNKNOWN",QAC=$G(^DIC(49,+QACSIEN,0))
 I QAC]"" D
 . S QACSERV=$P($G(^DIC(49,+$P(QAC,U,4),0)),U,1)
 . I QACSERV="" S QACSERV=$P(QAC,U,1)
 Q QACSERV
EN5(QACCIEN) ;This utility returns the Issue Code and the Issue Code Name
 N QAC,QACCNM,QACCSS S QACCNM="UNKNOWN",QAC=$G(^QA(745.2,+QACCIEN,0))
 I QAC]"" D
 . S QAC(1)=$P(QAC,"^"),QAC(3)=$P(QAC,U,3)
 . S QACCNM=QAC(1)_"  "_$E(QAC(3),1,50)
 . S QACCSS=$P($G(^QA(745.2,QACCIEN,0)),U,7)
 . I QACCSS]"" S QACCNM=QACCNM_"(*"_$P($G(^QA(745.6,QACCSS,0)),U,2)_")"
 Q QACCNM
EN6(QACHDIEN) ;This utility returns the Header Issue Code and its name
 N QAC,QACHDNM S QACHDNM="UNKNOWN",QAC=$G(^QA(745.2,+QACHDIEN,0))
 I QAC]"" D
 . S QAC(1)=$P(QAC,"^"),QAC(3)=$P(QAC,U,3)
 . S QACHDNM=QAC(1)_"   "_QAC(3)
 Q QACHDNM
EN7(QACDIEN) ;This utility returns the discipline involved
 N QAC,QACDISC S QACDISC="UNKNOWN",QAC=$G(^QA(745.5,+QACDIEN,0))
 I QAC]"" S QACDISC=$P($G(QAC),U,2)
 Q QACDISC
EN8(QACDIEN) ;This utility returns the service/section involved
 N QAC,QACDISC S QACDISC="UNKNOWN",QAC=$G(^QA(745.55,+QACDIEN,0))
 I QAC]"" S QACDISC=$P($G(QAC),U)
 Q QACDISC
