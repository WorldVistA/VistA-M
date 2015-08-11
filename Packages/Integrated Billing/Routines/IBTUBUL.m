IBTUBUL ;ALB/AAS - UNBILLED AMOUNTS ;29-SEP-94
 ;;2.0;INTEGRATED BILLING;**19,123,159,217,155,356,516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IB*2.0*516 - Added sort by Division.  Because some of the totals
 ; can be done by Division and some cannot, portions of the report
 ; were reorganized.
 ;
TEST ; - Create and send test bulletin.
 N IBBDT,IBEDT,IBSEL,IBTEST
 S IBBDT=DT,IBEDT=DT,IBSEL="1,2,3",IBTEST=1
 D TESTV
 ;
BULL ; - Create and send bulletin.
 ;
 I '$O(IBUNB(0)) Q  ; Quit out if no data.
 ;
 N I,IBDIV,IBGRP,IBT,IBTOTAL,IBX,IDX,X,XMDUZ,XMN,XMSUB,XMTEXT,XMY,XMZ
 S XMSUB="UNBILLED AMOUNTS SUMMARY REPORT"_$S($G(IBTEST):" (TEST)",1:"")
 ;
 D BULL1
 ;
 S IBDIV=0
 F  S IBDIV=$O(IBUNB(IBDIV)) Q:'IBDIV  D BULL2
 ;
 D BULL3,SEND
 ;
 Q
 ;
BULL1 ; Header for entire report.
 ;
 S IDX=1
 S IBX=$P($$SITE^VASITE,U,2,3)
 S IBT(IDX)="SUMMARY UNBILLED AMOUNTS FOR "_$P(IBX,U)_" ("_$P(IBX,U,2)_").",IDX=IDX+1
 S IBT(IDX)="PERIOD: FROM "_$$DAT1^IBOUTL(IBBDT)_" TO "_$$DAT1^IBOUTL(IBEDT),IDX=IDX+1
 ;
 I $G(IBDET) S IBT(IDX)="DETAILED REPORT PRINTED TO '"_IO_"'",IDX=IDX+1
 I $G(IBCOMP) S IBT(IDX)="UNBILLED AMOUNTS FIGURES STORED FOR "_$$DAT2^IBOUTL(IBTIMON),IDX=IDX+1
 ;
 Q
 ;
BULL2 ; Totals for one Division.
 ;
 I IBDIV=999999 S IBDIVHDR="UNKNOWN"
 E  S IBDIVHDR=$$GET1^DIQ(40.8,IBDIV_",",.01)_" ("_$$GET1^DIQ(40.8,IBDIV_",",1)_")"
 S IBT(IDX)="",IDX=IDX+1
 S IBT(IDX)="  DIVISION: "_IBDIVHDR,IDX=IDX+1
 S IBT(IDX)="",IDX=IDX+1
 ;
 I $G(IBTEST) S IBT(IDX)="  *** TEST DATA, TEST DATA ***",IDX=IDX+1
 ;
 I IBSEL[1 D
 . S X=$$INPAVG^IBTUBOU(IBTIMON)
 . S IBT(IDX+1)="    Inpatient Care:"
 . S IBT(IDX+2)="      Number of Unbilled Inpatient Admissions : "_$J(+$G(IBUNB(IBDIV,"EPISM-A")),11)
 . S IBT(IDX+3)="      Number of MRA Unbilled Inpt Admissions  : "_$J(+$G(IBUNB(IBDIV,"EPISM-A-MRA")),11)
 . S IBT(IDX+4)="      Number of Inpt. Institutional Cases     : "_$J(+$G(IBUNB(IBDIV,"EPISM-I")),11)
 . S IBT(IDX+5)="      Average Inpt. Institutional Bill Amount : "_$J($P(X,"^"),11,2)
 . S IBT(IDX+6)="      Number of Inpt. Professional Cases      : "_$J(+$G(IBUNB(IBDIV,"EPISM-P")),11)
 . S IBT(IDX+7)="      Average Inpt. Professional Bill Amount  : "_$J($P(X,"^",2),11,2)
 . S IBT(IDX+8)="      Total Unbilled Inpatient Care           : "_$J($G(IBUNB(IBDIV,"UNBILIP")),11,2)
 . S IBT(IDX+9)="      Total MRA Unbilled Inpatient Care       : "_$J($G(IBUNB(IBDIV,"UNBILIP-MRA")),11,2)
 . S IBT(IDX+10)="",IDX=IDX+10
 . Q
 ;
 I IBSEL[2 D
 . S IBT(IDX+1)="    Outpatient Care:"
 . S IBT(IDX+2)="      Number of Unbilled Outpatient Cases     : "_$J(+$G(IBUNB(IBDIV,"ENCNTRS")),11)
 . S IBT(IDX+3)="      Number of Unbilled CPT Codes            : "_$J(+$G(IBUNB(IBDIV,"CPTMS-I"))+$G(IBUNB(IBDIV,"CPTMS-P")),11)
 . S IBT(IDX+4)="      Number of MRA Unbilled CPT Codes        : "_$J(+$G(IBUNB(IBDIV,"CPTMS-I-MRA"))+$G(IBUNB(IBDIV,"CPTMS-P-MRA")),11)
 . S IBT(IDX+5)="      Total Unbilled Outpatient Care          : "_$J($G(IBUNB(IBDIV,"UNBILOP")),11,2)
 . S IBT(IDX+6)="      Total MRA Unbilled Outpatient Care      : "_$J($G(IBUNB(IBDIV,"UNBILOP-MRA")),11,2)
 . S IBT(IDX+7)="",IDX=IDX+7
 . Q
 ;
 I IBSEL[3 D
 . S IBT(IDX+1)="    Prescriptions:"
 . S IBT(IDX+2)="      Number of Unbilled Prescriptions        : "_$J(+$G(IBUNB(IBDIV,"PRESCRP")),11)
 . S IBT(IDX+3)="      Number of MRA Unbilled Prescriptions    : "_$J(+$G(IBUNB(IBDIV,"PRESCRP-MRA")),11)
 . S IBT(IDX+4)="      Total Unbilled Prescriptions            : "_$J($G(IBUNB(IBDIV,"UNBILRX")),11,2)
 . S IBT(IDX+5)="      Total MRA Unbilled Prescriptions        : "_$J($G(IBUNB(IBDIV,"UNBILRX-MRA")),11,2)
 . S IBT(IDX+6)="",IDX=IDX+6
 . Q
 ;
 ; Accumulate grand totals.
 ;
 S IBTOTAL("EPISM-A")=$G(IBTOTAL("EPISM-A"))+$G(IBUNB(IBDIV,"EPISM-A"))
 S IBTOTAL("EPISM-A-MRA")=$G(IBTOTAL("EPISM-A-MRA"))+$G(IBUNB(IBDIV,"EPISM-A-MRA"))
 S IBTOTAL("EPISM-I")=$G(IBTOTAL("EPISM-I"))+$G(IBUNB(IBDIV,"EPISM-I"))
 S IBTOTAL("EPISM-P")=$G(IBTOTAL("EPISM-P"))+$G(IBUNB(IBDIV,"EPISM-P"))
 S IBTOTAL("UNBILIP")=$G(IBTOTAL("UNBILIP"))+$G(IBUNB(IBDIV,"UNBILIP"))
 S IBTOTAL("UNBILIP-MRA")=$G(IBTOTAL("UNBILIP-MRA"))+$G(IBUNB(IBDIV,"UNBILIP-MRA"))
 S IBTOTAL("ENCNTRS")=$G(IBTOTAL("ENCNTRS"))+$G(IBUNB(IBDIV,"ENCNTRS"))
 ;
 S IBTOTAL("CPTMS")=$G(IBTOTAL("CPTMS"))+$G(IBUNB(IBDIV,"CPTMS-I"))+$G(IBUNB(IBDIV,"CPTMS-P"))
 S IBTOTAL("CPTMS-MRA")=$G(IBTOTAL("CPTMS-MRA"))+$G(IBUNB(IBDIV,"CPTMS-I-MRA"))+$G(IBUNB(IBDIV,"CPTMS-P-MRA"))
 ;
 S IBTOTAL("UNBILOP")=$G(IBTOTAL("UNBILOP"))+$G(IBUNB(IBDIV,"UNBILOP"))
 S IBTOTAL("UNBILOP-MRA")=$G(IBTOTAL("UNBILOP-MRA"))+$G(IBUNB(IBDIV,"UNBILOP-MRA"))
 S IBTOTAL("PRESCRP")=$G(IBTOTAL("PRESCRP"))+$G(IBUNB(IBDIV,"PRESCRP"))
 S IBTOTAL("PRESCRP-MRA")=$G(IBTOTAL("PRESCRP-MRA"))+$G(IBUNB(IBDIV,"PRESCRP-MRA"))
 S IBTOTAL("UNBILRX")=$G(IBTOTAL("UNBILRX"))+$G(IBUNB(IBDIV,"UNBILRX"))
 S IBTOTAL("UNBILRX-MRA")=$G(IBTOTAL("UNBILRX-MRA"))+$G(IBUNB(IBDIV,"UNBILRX-MRA"))
 ;
 Q
 ;
BULL3 ; Grand totals across all Divisions and concluding notes.
 ;
 S IBT(IDX)="",IDX=IDX+1
 S IBT(IDX)="  GRAND TOTALS",IDX=IDX+1
 S IBT(IDX)="",IDX=IDX+1
 ;
 I IBSEL[1 D
 . S X=$$INPAVG^IBTUBOU(IBTIMON)
 . S IBT(IDX+1)="    Inpatient Care:"
 . S IBT(IDX+2)="      Number of Unbilled Inpatient Admissions : "_$J(+$G(IBTOTAL("EPISM-A")),11)
 . S IBT(IDX+3)="      Number of MRA Unbilled Inpt Admissions  : "_$J(+$G(IBTOTAL("EPISM-A-MRA")),11)
 . S IBT(IDX+4)="      Number of Inpt. Institutional Cases     : "_$J(+$G(IBTOTAL("EPISM-I")),11)
 . S IBT(IDX+5)="      Average Inpt. Institutional Bill Amount : "_$J($P(X,"^"),11,2)
 . S IBT(IDX+6)="      Number of Inpt. Professional Cases      : "_$J(+$G(IBTOTAL("EPISM-P")),11)
 . S IBT(IDX+7)="      Average Inpt. Professional Bill Amount  : "_$J($P(X,"^",2),11,2)
 . S IBT(IDX+8)="      Total Unbilled Inpatient Care           : "_$J($G(IBTOTAL("UNBILIP")),11,2)
 . S IBT(IDX+9)="      Total MRA Unbilled Inpatient Care       : "_$J($G(IBTOTAL("UNBILIP-MRA")),11,2)
 . S IBT(IDX+10)="",IDX=IDX+10
 . Q
 ;
 I IBSEL[2 D
 . S IBT(IDX+1)="    Outpatient Care:"
 . S IBT(IDX+2)="      Number of Unbilled Outpatient Cases     : "_$J(+$G(IBTOTAL("ENCNTRS")),11)
 . S IBT(IDX+3)="      Number of Unbilled CPT Codes            : "_$J(+$G(IBTOTAL("CPTMS")),11)
 . S IBT(IDX+4)="      Number of MRA Unbilled CPT Codes        : "_$J(+$G(IBTOTAL("CPTMS-MRA")),11)
 . S IBT(IDX+5)="      Total Unbilled Outpatient Care          : "_$J($G(IBTOTAL("UNBILOP")),11,2)
 . S IBT(IDX+6)="      Total MRA Unbilled Outpatient Care      : "_$J($G(IBTOTAL("UNBILOP-MRA")),11,2)
 . S IBT(IDX+7)="",IDX=IDX+7
 . Q
 ;
 I IBSEL[3 D
 . S IBT(IDX+1)="    Prescriptions:"
 . S IBT(IDX+2)="      Number of Unbilled Prescriptions        : "_$J(+$G(IBTOTAL("PRESCRP")),11)
 . S IBT(IDX+3)="      Number of MRA Unbilled Prescriptions    : "_$J(+$G(IBTOTAL("PRESCRP-MRA")),11)
 . S IBT(IDX+4)="      Total Unbilled Prescriptions            : "_$J($G(IBTOTAL("UNBILRX")),11,2)
 . S IBT(IDX+5)="      Total MRA Unbilled Prescriptions        : "_$J($G(IBTOTAL("UNBILRX-MRA")),11,2)
 . S IBT(IDX+6)="",IDX=IDX+6
 . Q
 ;
 I IBSEL="1,2,3" D
 . S IBT(IDX+1)="    Total Unbilled Amount (all care)          : "_$J($G(IBUNB("UNBILTL")),11,2)
 . S IBT(IDX+2)="    Total MRA Unbilled Amount (all care)      : "_$J($G(IBUNB("UNBILTL-MRA")),11,2)
 . S IDX(IDX+3)="",IDX=IDX+3
 . Q
 ;
 S IBT(IDX+1)="",IDX=IDX+1
 ;
 I IBSEL[1 D
 . S IBT(IDX+1)="Note:  Average bill Amount is based on Bills Authorized during the 12"
 . S IBT(IDX+2)="       months preceding the month of this report."
 . S IDX=IDX+2
 . Q
 ;
 S IBT(IDX+1)="Note:  Number of cases is insured cases in Claims Tracking that are"
 S IBT(IDX+2)="       not billed (or bill not authorized/req MRA) but appear to be billable."
 ;
 Q
 ;
SEND ; - Send bulletin.
 K XMY
 S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="IBT("
 S XMN=0,IBGRP=$P($G(^XMB(3.8,+$P($G(^IBE(350.9,1,6)),"^",25),0)),"^")
 I $G(IBCOMP),IBGRP]"" S XMY("G."_IBGRP_"@"_^XMB("NETNAME"))=""
 I '$G(IBCOMP) S XMY(DUZ)=""
 D ^XMD
 Q
 ;
TESTV ; - Set up test variables.
 S IBTIMON=9999999
 S IBUNB(999999,"CPTMS-I")=11111
 S IBUNB(999999,"CPTMS-I-MRA")=22222
 S IBUNB(999999,"CPTMS-P")=0
 S IBUNB(999999,"CPTMS-P-MRA")=0
 S IBUNB(999999,"ENCNTRS")=11111
 S IBUNB(999999,"EPISM-A")=11111
 S IBUNB(999999,"EPISM-A-MRA")=22222
 S IBUNB(999999,"EPISM-I")=11111
 S IBUNB(999999,"EPISM-P")=0
 S IBUNB(999999,"PRESCRP")=11111
 S IBUNB(999999,"PRESCRP-MRA")=22222
 S IBUNB(999999,"UNBILIP")=99999.99
 S IBUNB(999999,"UNBILIP-MRA")=77777.77
 S IBUNB(999999,"UNBILOP")=99999.99
 S IBUNB(999999,"UNBILOP-MRA")=77777.77
 S IBUNB(999999,"UNBILRX")=11111
 S IBUNB(999999,"UNBILRX-MRA")=22222
 ;
 S IBUNB("UNBILTL")=99999.99
 S IBUNB("UNBILTL-MRA")=77777.77
 Q
