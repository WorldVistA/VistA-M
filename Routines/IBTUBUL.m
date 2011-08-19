IBTUBUL ;ALB/AAS - UNBILLED AMOUNTS ;29-SEP-94
 ;;2.0;INTEGRATED BILLING;**19,123,159,217,155,356**;21-MAR-94
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
TEST ; - Create and send test bulletin.
 N IBBDT,IBEDT,IBSEL,IBTEST
 S IBBDT=DT,IBEDT=DT,IBSEL="1,2,3",IBTEST=1
 ;
BULL ; - Create and send bulletin.
 N IBGRP,IBT,IBX,XMDUZ,XMSUB,XMTEXT,XMN,XMY,XMZ,I,IDX,X,Y
 ;
 S XMSUB="UNBILLED AMOUNTS SUMMARY REPORT"_$S($G(IBTEST):" (TEST)",1:"")
 S IBX=$P($$SITE^VASITE,U,2,3)
 S IBT(1)="SUMMARY UNBILLED AMOUNTS FOR "_$P(IBX,U)_" ("_$P(IBX,U,2)_")."
 S IBT(2)="PERIOD: FROM "_$$DAT1^IBOUTL(IBBDT)_" TO "_$$DAT1^IBOUTL(IBEDT)
 S IDX=3
 I $G(IBDET) S IBT(3)="DETAILED REPORT PRINTED TO '"_IO_"'",IDX=4
 I $G(IBCOMP) D
 . S IBT(IDX)="UNBILLED AMOUNTS FIGURES STORED FOR "_$$DAT2^IBOUTL(IBTIMON)
 . S IDX=IDX+1
 ;
 S IBT(IDX)="",IDX=IDX+1
 I $G(IBTEST) D  G BULL1
 .S IBT(IDX)="*** TEST DATA, TEST DATA ***",IDX=IDX+1 D TESTV
 ;
BULL1 ; - Create bulletin.
 I IBSEL[1 D
 . S X=$$INPAVG^IBTUBOU(IBTIMON)
 . S IBT(IDX+1)="Inpatient Care:"
 . S IBT(IDX+2)="   Number of Unbilled Inpatient Admissions : "_$J(IBUNB("EPISM-A"),11)
 . S IBT(IDX+3)="   Number of MRA Unbilled Inpt Admissions  : "_$J(IBUNB("EPISM-A-MRA"),11)
 . S IBT(IDX+4)="   Number of Inpt. Institutional Cases     : "_$J(IBUNB("EPISM-I"),11)
 . S IBT(IDX+5)="   Average Inpt. Institutional Bill Amount : "_$J($P(X,"^"),11,2)
 . S IBT(IDX+6)="   Number of Inpt. Professional Cases      : "_$J(IBUNB("EPISM-P"),11)
 . S IBT(IDX+7)="   Average Inpt. Professional Bill Amount  : "_$J($P(X,"^",2),11,2)
 . S IBT(IDX+8)="   Total Unbilled Inpatient Care           : "_$J(IBUNB("UNBILIP"),11,2)
 . S IBT(IDX+9)="   Total MRA Unbilled Inpatient Care       : "_$J(IBUNB("UNBILIP-MRA"),11,2)
 . S IBT(IDX+10)="",IDX=IDX+10
 ;
 I IBSEL[2 D
 .S IBT(IDX+1)="Outpatient Care:"
 .S IBT(IDX+2)="   Number of Unbilled Outpatient Cases     : "_$J(IBUNB("ENCNTRS"),11)
 .S IBT(IDX+3)="   Number of Unbilled CPT Codes            : "_$J(IBUNB("CPTMS-I")+IBUNB("CPTMS-P"),11)
 .S IBT(IDX+4)="   Number of MRA Unbilled CPT Codes        : "_$J(IBUNB("CPTMS-I-MRA")+IBUNB("CPTMS-P-MRA"),11)
 .S IBT(IDX+5)="   Total Unbilled Outpatient Care          : "_$J(IBUNB("UNBILOP"),11,2)
 .S IBT(IDX+6)="   Total MRA Unbilled Outpatient Care      : "_$J(IBUNB("UNBILOP-MRA"),11,2)
 .S IBT(IDX+7)="",IDX=IDX+7
 ;
 I IBSEL[3 D
 .S IBT(IDX+1)="Prescriptions:"
 .S IBT(IDX+2)="   Number of Unbilled Prescriptions        : "_$J(IBUNB("PRESCRP"),11)
 .S IBT(IDX+3)="   Number of MRA Unbilled Prescriptions    : "_$J(IBUNB("PRESCRP-MRA"),11)
 .S IBT(IDX+4)="   Total Unbilled Prescriptions            : "_$J(IBUNB("UNBILRX"),11,2)
 .S IBT(IDX+5)="   Total MRA Unbilled Prescriptions        : "_$J(IBUNB("UNBILRX-MRA"),11,2)
 .S IBT(IDX+6)="",IDX=IDX+6
 ;
 I IBSEL="1,2,3" D
 .S IBT(IDX+1)="Total Unbilled Amount (all care)           : "_$J(IBUNB("UNBILTL"),11,2)
 .S IBT(IDX+2)="Total MRA Unbilled Amount (all care)       : "_$J(IBUNB("UNBILTL-MRA"),11,2)
 .S IDX(IDX+3)="",IDX=IDX+3
 ;
 S IBT(IDX+1)="",IDX=IDX+1
 I IBSEL[1 D
 . S IBT(IDX+1)="Note:  Average bill Amount is based on Bills Authorized during the 12"
 . S IBT(IDX+2)="       months preceding the month of this report."
 . S IDX=IDX+2
 ;
 S IBT(IDX+1)="Note:  Number of cases is insured cases in Claims Tracking that are"
 S IBT(IDX+2)="       not billed (or bill not authorized/req MRA) but appear to be billable."
 D SEND
 ;
BULLQ Q
 ;
SEND ; - Send bulletin.
 K XMY S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="IBT("
 S XMN=0,IBGRP=$P($G(^XMB(3.8,+$P($G(^IBE(350.9,1,6)),"^",25),0)),"^")
 I $G(IBCOMP),IBGRP]"" S XMY("G."_IBGRP_"@"_^XMB("NETNAME"))=""
 I '$G(IBCOMP) S XMY(DUZ)=""
 D ^XMD
 Q
 ;
TESTV ; - Set up test variables.
 S IBTIMON=9999999
 S IBUNB("EPISM-A")=11111
 S IBUNB("EPISM-A-MRA")=22222
 S IBUNB("EPISM-I")=11111
 S IBUNB("EPISM-P")=0
 S IBUNB("UNBILIP")=99999.99
 S IBUNB("UNBILIP-MRA")=77777.77
 S IBUNB("ENCNTRS")=11111
 S IBUNB("CPTMS-I")=11111
 S IBUNB("CPTMS-I-MRA")=22222
 S IBUNB("CPTMS-P")=0
 S IBUNB("CPTMS-P-MRA")=0
 S IBUNB("UNBILOP")=99999.99
 S IBUNB("UNBILOP-MRA")=77777.77
 S IBUNB("PRESCRP")=11111
 S IBUNB("PRESCRP-MRA")=22222
 S IBUNB("UNBILRX")=11111
 S IBUNB("UNBILRX-MRA")=22222
 S IBUNB("UNBILTL")=99999.99
 S IBUNB("UNBILTL-MRA")=77777.77
 Q
