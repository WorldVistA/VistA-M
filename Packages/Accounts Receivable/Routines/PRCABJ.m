PRCABJ ;WASH-ISC@ALTOONA,PA/LDB,TJK - NIGHTLY PROCESS FOR ACCOUNTS RECEIVABLE ;11/8/96  3:54 PM
 ;;4.5;Accounts Receivable;**11,34,101,114,155,153,141,165,167,173,201,237,304,301,378,400**;Mar 20, 1995;Build 13
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;This routine is called by the PRCA NIGHTLY PROCESS option which should be run nightly to call the following tasks
 ;1) Update of interest/admin charges on patients' accounts
 ;2) Update statement days
 ;3) Print of Patient Statements, Uniform Billing forms, and non-patient follow-up letters
 ;4) Purge of Receipts
 ;5) Creation of TOP (Treasury Offset Program) documents
 ;6) Creation of Cross-Servicing (Treasury Cross-Servicing Project) documents
 ;7) Print of the Follow-up list
 ;8) Purge AR Events
 ;9) Flag prepayments for refund review
 ;10) Print Comment List
 ;11) Starts the Repayment Plan Monitor
 ;12) Generates Diagnostic Measures Workload Reports
 ;13) Matches EFT with ERA
 ;14) Generates CBO Data Extract files for Boston ARC
 ;15) Auto-audit of Paper Bills
 ;16) Generate the AR Diagnostic Measures Statistical Reports (for a defined period)
 ;17) Auto Updates Repayment Plans
 ;18) Clean out older AR Metrics data.
 ;
 ;Process will first check and Validate AR pointer files 341.1,
 ;430.2, and 430.3.
 ;Process will terminate and send bulletin if files are not valid
 ;
EN ;Start of nightly process-check to see if process is already running
 L +^RC("PRCABJ"):5 Q:'$T
 NEW ERROR S ERROR=0
 D VERIFY I ERROR L -^RC("PRCABJ") Q
 ;
DRIVER ;All processes are called from this point
 N CHK,POP,% S CHK=0
 D CHK,RECALL,CHK,INT,CHK,RPP,CHK,EN^RCCPCBJ,CHK,STM,CHK,RECPT,CHK,TOP,CHK,TCSP,CHK,EVNT,CHK,BNUM  ; PRCA*4.5*400
 D CHK,ENUM,CHK,PURFMS,CHK,EN3^RCFMOBR,CHK,START^RCRJR,CHK,UB
 D CHK,STATMNT,CHK,UDLIST^PRCABJ1,CHK,LIST,CHK,COMMENT  ; PRCA*4.5*400 removed call to REPAY tag
 D CHK,WRKLD,CHK,EFT,CHK,CBO,CHK,ABAUDIT,CHK,ARDM,CHK,CLNMTR
 D NOW^%DTC S $P(^RC(342,1,0),"^",10)=%
 L -^RC("PRCABJ")
 K ^RC("PRCABJ")
 Q
 ;
CHK ;checkpoint of process
 S CHK=CHK+1 S ^RC("PRCABJ")=CHK
 Q
 ;
VERIFY ;Verifies Pointer Files--Will HALT Process if Pointer Files Invalid
 NEW A,B,FILE
 F FILE=341.1,430.2,430.3 D  Q:ERROR
    .S A=$S(FILE=341.1:"AC;0;2",FILE=430.2:"AC;0;7",1:"AC;0;3")
    .S B=$S(FILE=341.1:"",1:"C;0;2")
    .D EN1^PRCABJV(FILE,A,B,.ERROR)
    .Q:'ERROR
    .;SEND BULLETIN HERE IF FILE IN ERROR
    .NEW XMB,XMTEXT,XMDUZ
    .S XMDUZ="ACCOUNTS RECEIVABLE PACKAGE"
    .S XMB="PRCA NIGHTLY PROCESS ABORT"
    .S XMTEXT="ERROR("
    .D ^XMB
    .Q
 Q
 ;
INT ;  update interest and admin charges for non-benefit debts
 ;  example: vendor, employee, ex-employee
 D NONBENE^RCBECHGS
 Q
 ;
STM ;Update statement days for PERSONS, VENDORS, and Institutions
 D STM^PRCABJ1
 Q
 ;
STATMNT ;Print patient statements
 N IOP,ZTIO,ZTSAVE,ZTRTN,ZTDESC,ZTASK,%ZIS,ZTDTH,PRCADEV
 S (IOP,PRCADEV)=$P($G(^RC(342,1,0)),"^",8)
 I IOP]"" D
 .S ZTRTN="PRCAGS",ZTDTH=$H,ZTDESC="Print AR Statements/Letters"
 .S %ZIS="N0" D ^%ZIS Q:POP
 .S ZTSAVE("PRCADEV")="" D ^%ZTLOAD,^%ZISC
 Q
 ;
RECPT ;Manage Receipts and Deposits
 N IOP,ZTIO,ZTSAVE,ZTRTN,ZTDESC,ZTASK,%ZIS,ZTDTH
 S ZTIO="",ZTRTN="MAN^RCDPUT",ZTDTH=$H,ZTDESC="Manage Receipts and Deposits"
 D ^%ZTLOAD
 Q
 ;
TOP ;Transmit TOP documents
 Q:$$DOW^XLFDT(DT,1)'=1
 I DT'<$P($G(^RC(342,1,30)),"^",1)&(DT'>$P($G(^RC(342,1,30)),"^",2)) D ^RCEXINAD
 N RCM,RCDOC
 ;Run of TOP documents every Monday
 I +$E(DT,6,7)>7,$E(DT,6,7)<15 S RCM=1
 I '$D(^RCD(340,"TOP")),'$G(RCM) Q
 S RCDOC=$S($G(RCM):"M",1:"U")
 I $E(DT,4,5)=12,RCDOC="M" S RCDOC="Y"
TOPQUE N ZTDESC,ZTASK,ZTDTH,ZTIO,ZTRTN,ARDUZ,ZTSAVE
 S ZTIO="",ZTRTN="^RCTOPD",ZTSAVE("RCDOC")=""
 S ZTDESC="TOP REFERRAL DOCUMENTS",ZTDTH=$H
 D ^%ZTLOAD
 Q
 ;
TCSP ;Transmit Cross-Servicing (Treasury Cross-Servicing Project) documents
 Q:$$DOW^XLFDT(DT,1)'=2
 ;Run TCSP documents every Tuesday
TCSPQUE N ZTDESC,ZTASK,ZTDTH,ZTIO,ZTRTN
 S ZTIO="",ZTRTN="^RCTCSPD"
 S ZTDESC="CROSS-SERVICING REFERRAL DOCUMENTS",ZTDTH=$H
 D ^%ZTLOAD
 Q
 ;
UB ;Print Uniform Billing forms
 N IOP,ZTIO,ZTSAVE,ZTRTN,ZTDESC,ZTASK,%ZIS,ZTDTH
 S ZTIO="",ZTRTN="PRCALT2",ZTDTH=$H,ZTDESC="Print Reimbursable Health Insurance Uniform Billing forms"
 D ^%ZTLOAD,^%ZISC
 Q
 ;
LIST ;Print Follow-up List
 N IOP,ZTIO,ZTSAVE,ZTRTN,ZTDESC,ZTASK,%ZIS,ZTDTH,BEG,END,PRCADEV
 S IOP=$P($G(^RC(342,1,0)),"^",8)
 I IOP]"" D
 .S %ZIS="N0" D ^%ZIS Q:POP
 .S ZTRTN="DQ1^PRCACM",ZTDTH=$H,PRCADEV=ION_";"_IOST_";"_IOM_";"_IOSL_";"_$G(IO("DOC"))
 .S (ZTSAVE("BEG"),ZTSAVE("END"))=DT,ZTSAVE("PRCADEV")="",ZTDESC="Bill Comment Follow-Up List"
 .D ^%ZTLOAD,^%ZISC
 Q
 ;
COMMENT ;Print Comment List
 N IOP,ZTIO,ZTSAVE,ZTRTN,ZTDESC,ZTASK,%ZIS,ZTDTH,BEG,END,PRCADEV
 S IOP=$P($G(^RC(342,1,0)),"^",8)
 I IOP]"" D
 .S %ZIS="N0" D ^%ZIS Q:POP
 .S ZTRTN="DQ2^PRCACM",ZTDTH=$H,PRCADEV=ION_";"_IOST_";"_IOM_";"_IOSL_";"_$G(IO("DOC"))
 .S (ZTSAVE("BEG"),ZTSAVE("END"))=DT,ZTSAVE("PRCADEV")="",ZTDESC="Debtor Comment Follow-up List"
 .D ^%ZTLOAD,^%ZISC
 Q
 ;
WRKLD ; Generates Diagnostic Measures Workload Reports
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTIO="",ZTRTN="DQ^RCDMBWLR",ZTDTH=$H,ZTDESC="Diagnostic Measures Workload Reports"
 D ^%ZTLOAD
 Q
 ;
 ;PRCA*4.5*304 new tag ARDM
ARDM ; Generate AR Diagnostic Measures statistic reports weekly
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 ;
 ; run the report
 S ZTIO="",ZTRTN="AUTO^RCDPENRU",ZTDTH=$H,ZTDESC="AR Diagnostic Measures Statistical Reports"
 D ^%ZTLOAD
 Q
 ;
EVNT ;Purge AR Events
 N IOP,ZTIO,ZTDESC,ZTASK,ZTIO,ZTRTN,ZTSAVE,%ZIS
 S ZTIO="",ZTRTN="PUR^RCEVDRV1",ZTDTH=$H,ZTDESC="Purge AR Event Information" D ^%ZTLOAD
 Q
PURFMS ;Purge FMS documents
 NEW ZTRTN,ZTIO,ZTDTH,ZTSK,ZTDESC
 S ZTIO="",ZTRTN="EN^RCFMPUR",ZTDESC="AR/FMS DOC PURGE",ZTDTH=$H D ^%ZTLOAD
 Q
 ;
EFT ; Starts matching of EFTs to EOBs job
 NEW ZTRTN,ZTIO,ZTDTH,ZTSK,ZTDESC
 S ZTIO="",ZTRTN="EN^RCDPEM",ZTDESC="AR/EDI LOCKBOX MATCHING EFTs",ZTDTH=$H D ^%ZTLOAD
 Q
 ;
BNUM ;Check bill numbering series
 I $P(^RC(342,1,0),"^",3)="" S $P(^RC(342,1,0),"^",3)="K"_$E($$FY^RCFN01,2)_"00000"
 I $E($P(^RC(342,1,0),"^",3),2)'=$E($$FY^RCFN01,2) S $P(^RC(342,1,0),"^",3)="K"_$E($$FY^RCFN01,2)_"00000"
 Q
ENUM ;Check event numbering series
 I $P(^RC(342,1,0),"^",6)="" S $P(^RC(342,1,0),"^",6)="K"_$E($$FY^RCFN01,2)_"A0000"
 I $E($P(^RC(342,1,0),"^",6),2)'=$E($$FY^RCFN01,2) S $P(^RC(342,1,0),"^",6)="K"_$E($$FY^RCFN01,2)_"A0000"
 Q
 ;
CBO ; Create Extract Files for ARC
 NEW ZTRTN,ZTIO,ZTDTH,ZTSK,ZTDESC
 S ZTIO="",ZTRTN="EN^RCXVTSK",ZTDESC="CBO DATA EXTRACT",ZTDTH=$H
 D ^%ZTLOAD
 Q
 ;
ABAUDIT ;PRCA*4.5*304 - Auto-audit Paper bills
 ;
 N ZTRTN,ZTIO,ZTDTH,ZTSK,ZTDESC
 ;
 S ZTIO="",ZTRTN="ABAUDIT^PRCABJ2",ZTDESC="AR AUTO-AUDIT OF PAPER BILLS",ZTDTH=$H D ^%ZTLOAD
 Q
 ;
RPP ;PRCA*4.5*378 - Repayment Plan Nightly Process
 ;
 N ZTRTN,ZTIO,ZTDTH,ZTSK,ZTDESC
 ;
 S ZTIO="",ZTRTN="MAIN^RCRPNP",ZTDESC="AR REPAYMENT PLAN NIGHTLY PROCESS",ZTDTH=$H D ^%ZTLOAD
 Q
 ;
CLNMTR ;PRCA*4.5*378 - Remove AR Metrics file data older than the # days specified by the METRICS RETENTION DAYS parameter
 ;
 N ZTRTN,ZTIO,ZTDTH,ZTSK,ZTDESC
 ;
 S ZTIO="",ZTRTN="CLEANUP^RCSTATU",ZTDESC="AR METRICS File (#340.7) data cleanup",ZTDTH=$H D ^%ZTLOAD
 Q
 ;
RECALL ; if HRFS patient flag is set or date of death is set, then recall CS bills, stop TOP referrals, and remove debtors from DMC  PRCA*4.5*400
 N HRFSFLG,RCBILL,RCDB,RCDFN,Z
 ; CS bills
 S RCBILL=0 F  S RCBILL=$O(^PRCA(430,"TCSP",RCBILL)) Q:'RCBILL  D
 .S RCDB=$P($G(^PRCA(430,RCBILL,0)),U,9) Q:RCDB'>0
 .I +$P($G(^PRCA(430,RCBILL,15)),U,2) Q  ; recall has already been set for this bill
 .S Z=$P(^RCD(340,RCDB,0),U) I $P(Z,";",2)'="DPT(" Q
 .S RCDFN=$P(Z,";"),HRFSFLG=$$CHKHRFS^RCHRFSUT(RCDFN,DT)
 .I HRFSFLG=1 S Z=$$RECALL^RCTCSPU(RCBILL)
 .Q
 ; TOP referrals
 S RCDB=0 F  S RCDB=$O(^RCD(340,"TOP",RCDB)) Q:'RCDB  D
 .S Z=$P(^RCD(340,RCDB,0),U) I $P(Z,";",2)'="DPT(" Q
 .I +$P($G(^RCD(340,RCDB,6)),U,2) Q  ; stop TOP referral flag has been set already
 .S RCDFN=$P(Z,";"),HRFSFLG=$$CHKHRFS^RCHRFSUT(RCDFN,DT)
 .I HRFSFLG=1 S Z=$$STOPREF^RCTOPU(RCDB,"O","High Risk flag is set for this debtor",DT) D HRFSCMNT^RCEVGEN(RCDB)
 .Q
 ; cancel DMC
 S RCDB=0 F  S RCDB=$O(^RCD(340,"DMC",1,RCDB)) Q:'RCDB  D
 .S Z=$P(^RCD(340,RCDB,0),U) I $P(Z,";",2)'="DPT(" Q
 .I +$P($G(^RCD(340,RCDB,3)),U,10) Q  ; DMC deletion flag has been set already
 .S RCDFN=$P(Z,";"),HRFSFLG=$$CHKHRFS^RCHRFSUT(RCDFN,DT)
 .I HRFSFLG=1 S Z=$$CANCDMC^RCDMC90U(RCDB) D HRFSCMNT^RCEVGEN(RCDB)
 .Q
 Q
