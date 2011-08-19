IBCEMRAA ;ALB/DSM - MEDICARE REMITTANCE ADVICE DETAIL-PART A ; 12/29/05 9:57am
 ;;2.0;INTEGRATED BILLING;**155,323,349,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q  ; must call an entry point
 ;
 ;  This routine prints MRA Report for UB-04 (Part A) Form Type
 ;
MRA(IBIFN) ;;Module - Entry point to print ALL MRA reports, for a given IBIFN.
 ; This entry point doesn't ask for a Bill Number, it must pass IBIFN as Input.
 ; It will prompt the user for a device.
 ;
 ; Input   IBIFN  = ien of Bill Number (required)
 ;
 N IBQUIT,IBPGN S IBQUIT=0
 D ENT1
 Q  ;MRA
 ;
ENT ; Menu Option Entry Point
 N IBQUIT,IBEOB,IBIFN,FRMTYP,IBPGN
 S IBQUIT=0
 D GETBIL I IBQUIT Q   ;ENT
 ;
ENT1 ; Prompt for a print device and print MRA Reports
 D DEV^IBCEMRAX(IBIFN) I IBQUIT Q    ; device handling  ENT1
 ;
PROC ; This section must have IBIFN defined
 ; This section is called as both a foreground and a background process,
 ; so all write stmts need to consider printing in both cases.
 N FRMTYP,IEN,IBZDATA,INPAT
 S IBQUIT=$G(IBQUIT)
 S FRMTYP=$$FT^IBCEF(IBIFN)    ;Form Type
 S INPAT=$$INPAT^IBCEF(IBIFN)  ;Inpatient Flag
 ;
 ; Get Service Line Level Data from 837 Extract - Make the appropriate call
 ; based on the Bill's Form Type 3=UB-04  ; 2=CMS-1500
 D  ;
 . I FRMTYP=2 D F^IBCEF("N-HCFA 1500 SERVICE LINE (EDI)","IBZDATA",,IBIFN) Q
 . D F^IBCEF("N-UB-04 SERVICE LINE (EDI)","IBZDATA",,IBIFN)
 ;
 ; For a given IBIFN, print all MRA's on file for that Bill
 S IEN=0
 F  S IEN=$O(^IBM(361.1,"B",IBIFN,IEN)) Q:'IEN  D  I IBQUIT Q
 . I $P($G(^IBM(361.1,IEN,0)),U,4)'=1 Q  ;not an MRA
 . D PRNTMRA  ; print an MRA
 ;
 ; Force a form feed at end of a printer report
 I $E(IOST,1,2)'["C-" W @IOF
 ; Pause on screen before exiting
 I 'IBQUIT,$E(IOST,1,2)["C-" W ! S DIR("A")="Press RETURN to continue: ",DIR(0)="EA" D ^DIR K DIR
 ;
 ; Quit if called from a background process (ZTQUEUED defined)
 I $D(ZTQUEUED) S ZTREQ="@" Q  ;PROC
 D ^%ZISC     ; handle device closing before exiting
 Q   ;PROC
 ;
PRNTMRA ; Print a single MRA
 ; Input IEN - the ien# of EOB file (361.1); Required
 S IBPGN=0
 ; Print Part B - CMS-1500
 I FRMTYP=2 D PRNT^IBCEMRAB Q  ;PRNTMRA
 ;
 ; Print Part A - Institutional next
 ; Claim Level
 N RSNCD,NCVRCHRG,IBILL,IBILLU,IBCOINS,IBCTADJ,IBEOB,RMKS,IBFD,IBTD,IBDED,CLMADJ
 I IBPGN>1 D PAUSE^IBCEMRAX I IBQUIT Q  ;pause between EOB reports
 D CLMDATA,CLMHDR I IBQUIT Q
 D CLMPRNT
 ;
 ; Print Service Line Level Adjustments - check if exist
 I $D(^IBM(361.1,IEN,15)) D  I IBQUIT Q
 . I ($Y+4)>IOSL D PAUSE^IBCEMRAX Q:IBQUIT  W @IOF D CLMHDR
 . D SRVHDR^IBCEMRAX,SRVDATA^IBCEMRAX
 ;
 ; Print Disclaimer
 D DSCLMR^IBCEMRAX
 Q  ;PRTMRA
 ;
GETBIL ; Prompt the user for a Bill#. Get INIFN and IBEOB.
 ;
 N DIC,Y W !
 ; Access Explanation Of Benefits File #361.1
 ; Screen: only allow access to EOB's of Type = 1 (Medicare MRA)
 S DIC="^IBM(361.1,",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,4)=1"
 S DIC("W")="D EOBLST^IBCEMU1(Y)"   ; modify generic lister
 D ^DIC
 I Y<1!$D(DTOUT)!$D(DUOUT) S IBQUIT=1 Q  ; GETBIL
 S IBIFN=+$P(Y,U,2)   ; get index to Bill file (#399)
 Q  ;GETBIL
 ;
CLMDATA ; Get MRA Claim Level data of EOB file (#361.1)
 N I,RCNT,GRPCD,GLVL,GLVLD,RLVL,RLVLD,RCDED,RCOINS,RCTADJ,RCNCVR,RCLMADJ,CLMLVL
 F I=1:1:5 S @($P($T(TABLE+I),";",3))=$P($T(TABLE+I),";",4)
 ;
 ; Get Top Levels of EOB file (#361.1)
 F I=0,1,3:1:6 S IBEOB(I)=$G(^IBM(361.1,IEN,I))
 ;
 ; Get Claim Level Remarks Code from appropriate levels of 361.1 based on
 ; whether Bill is Outpatient or Inpatient.
 D  ;
 . I INPAT S RMKS=IBEOB(5) Q   ; Inpatient remarks code
 . S RMKS=$P(IBEOB(3),U,3,7)   ; Outpatient remarks code
 ;
 ; Get Group Level Data
 ; RLVLD=reason_code^amount^quantity^reason text
 ; CLMLVL=Claim Level Flag indicating where the displayed data is coming from
 ; 1=Claim Level; 0=Line Level
 ;
 S (GLVL,RLVL,RCNT,NCVRCHRG,IBDED,IBCOINS,IBCTADJ,CLMADJ,CLMLVL)=0
 F  S GLVL=$O(^IBM(361.1,IEN,10,GLVL)) Q:'GLVL  S GLVLD=^(GLVL,0) D  ;
 . S GRPCD=$P(GLVLD,U),RLVL=0
 . F  S RLVL=$O(^IBM(361.1,IEN,10,GLVL,1,RLVL)) Q:'RLVL  S RLVLD=^(RLVL,0) D  ;
 . . S RSNCD=$P(RLVLD,U)
 . . I GRPCD="PR",RSNCD="AAA" Q   ;exception
 . . I GRPCD="OA",RSNCD="AB3" Q   ;exception
 . . I GRPCD="LQ" Q               ;exception
 . . S RCNT=RCNT+1,RSNCD(RCNT)=RSNCD ;display
 . . I RCLMADJ[(","_RSNCD_",") S CLMADJ=CLMADJ+$P(RLVLD,U,2),CLMLVL=1 ;Claim Adjustment
 . . ; Get data from Claim Level: calculate Coinsurance, Contractual Adjustment,
 . . ; Noncovered Charges and Deductible amounts
 . . I GRPCD="PR",RCOINS[(","_RSNCD_",") S IBCOINS=$P(RLVLD,U,2),CLMLVL=1 Q
 . . I GRPCD="PR",RCDED[(","_RSNCD_",") S IBDED=IBDED+$P(RLVLD,U,2),CLMLVL=1 Q
 . . I GRPCD="CO" D  ;
 . . . I RCTADJ[(","_RSNCD_",") S IBCTADJ=IBCTADJ+$P(RLVLD,U,2),CLMLVL=1
 . . . I RCNCVR'[(","_RSNCD_",") S NCVRCHRG=NCVRCHRG+$P(RLVLD,U,2),CLMLVL=1
 ;
 ; If no data was found at Claim Level, get data from Line Level
 I 'CLMLVL D LINELVL^IBCEMRAX
 S IBILL=$G(^DGCR(399,$P(IBEOB(0),U),0)),IBILLU=$G(^DGCR(399,$P(IBEOB(0),U),"U"))
 S IBFD=$$FMTE^XLFDT($P(IBILLU,U),5),IBTD=$$FMTE^XLFDT($P(IBILLU,U,2),5)
 ;
 Q  ;CLMDATA
 ;
CLMHDR ; Print Claim Level Header
 S IBPGN=IBPGN+1
 I IBPGN=1,$E(IOST,1,2)["C-" W @IOF  ; refresh terminal screen on 1st hdr
 ;
 ; Rows 1 to 3
 W !,?108,"Medicare-equivalent",!?110,"Remittance Advice",!
 N PRVDR
 ;
 ; gather the pay-to provider information - IB*2*400
 S PRVDR=$$PRVDATA^IBJPS3($P(IBEOB(0),U,1))
 ;
 ; Row 4 to 15
 W !!!,"DEPT OF VETERANS AFFAIRS"
 W !,$P(PRVDR,U,5),?103,"PROVIDER #:",?117,$P($G(^IBE(350.9,1,1)),U,5) ;Tax ID
 W !,$P(PRVDR,U,6),?103,"PAGE #:",?117,$J(IBPGN,3)
 W !,$P(PRVDR,U,7),", ",$P(PRVDR,U,8)," ",$P(PRVDR,U,9),?103,"DATE: ",?117,$$FMTE^XLFDT($P(IBEOB(0),U,6),5)
 W !!,"PATIENT NAME",?24,"PATIENT CNTRL NUMBER",?48,"RC",?52,"REM",?58,"DRG#",?72,"DRG OUT AMT"
 W ?86,"COINSURANCE",?100,"PAT REFUND",?115,"CONTRACT ADJ"
 W !,"HIC NUMBER",?24,"ICN NUMBER",?48,"RC",?52,"REM",?58,"OUTCD CAPCD",?72,"DRG CAP AMT"
 W ?86,"COVD CHGS",?100,"ESRD NET ADJ",?115,"PER DIEM RTE"
 W !,"FROM DT    THRU DT",?24,"NACHG  HICHG  TOB",?48,"RC",?52,"REM",?58,"PROF COMP",?72,"MSP PAYMT"
 W ?86,"NCOVD CHGS",?100,"INTEREST",?115,"PROC CD AMT"
 W !,"CLM STATUS",?24,"COST  COVDY  NCOVDY",?48,"RC",?52,"REM",?58,"DRG AMT",?72,"DEDUCTIBLES"
 W ?86,"DENIED CHGS",?100,"CLAIM ADJ",?115,"NET REIMB",!
 Q  ;CLMHDR
 ;
CLMPRNT ; - Print Claim Level part of the Report
 N PTNM,PTLEN,HIC
 ; ROW 16
 ; format and standardize patient name for display
 S PTNM("FILE")=2,PTNM("IENS")=$P(IBILL,U,2),PTNM("FIELD")=.01,PTLEN=23
 S PTNM=$$BLDNAME^XLFNAME(.PTNM,PTLEN)
 I $P(IBEOB(6),U,1)'="" S PTNM=$E($P(IBEOB(6),U,1),1,PTLEN)
 W !,PTNM
 ; Account # (Bill #)
 W ?24,$P($$SITE^VASITE,U,3),"-",$P(IBILL,U)
 ; Reason Code,Remarks Code 1
 W ?48,$G(RSNCD(1)),?52,$P(RMKS,U,1)
 ; DRG Code Used
 W ?58,$P(IBEOB(0),U,10)
 ; Coinsurance, Contract Adjustment
 W ?86,$J($G(IBCOINS),11,2),?115,$J($G(IBCTADJ),11,2)
 ; ROW 17
 ; HIC & ICN
 S HIC=$S($P(IBEOB(6),U,2)'="":$P(IBEOB(6),U,2),$$WNRBILL^IBEFUNC(IBIFN,1):$P($G(^DGCR(399,$P(IBEOB(0),U),"I1")),U,2),1:$P($G(^DGCR(399,$P(IBEOB(0),U),"I2")),U,2))
 W !,HIC,?24,$P(IBEOB(0),U,14)
 ; Reason Code, Remarks Code 2
 W ?48,$G(RSNCD(2)),?52,$P(RMKS,U,2)
 ; covered charges
 W ?86,$J($P(IBEOB(1),U,3),11,2)
 ; Outpatient Reimbursement Rate
 I 'INPAT W ?115,$J($P(IBEOB(3),U,1),11,2)
 ; ROW 18
 W !,IBFD,?12,IBTD
 ; Type of Bill (=Location of Care_Bill Clasification_Frequency)
 W ?38,$P(IBILL,U,24)_$P($G(^DGCR(399.1,$P(IBILL,U,25),0)),U,2)_$P(IBILL,U,26)
 ; Reason Code,Remarks Code 3
 W ?48,$G(RSNCD(3)),?52,$P(RMKS,U,3)
 ; non-covered amount (Pt Responsibility)
 W ?86,$J(NCVRCHRG,11,2)
 ; Interest Amount
 I $P(IBEOB(1),U,7) W ?100,$J($P(IBEOB(1),U,7),11,2)
 ; Procedure code amount
 W ?115,$J($P(IBEOB(3),U,2),11,2)
 ; ROW 19
 ; claim status
 W !?6,$E($P(IBEOB(0),U,21),1,2)
 ; M-Care Inp Cost Report Day Ct
 W ?24,$P(IBEOB(4),U,14)
 ; M-Care Inp Cov. Days/Visit Ct
 W ?30,$P(IBEOB(4),U,1)
 ; Medicare Non-Covered Days
 W ?38,$P(IBEOB(4),U,19)
 ; Reason Code,Remarks Code 4
 W ?48,$G(RSNCD(4)),?52,$P(RMKS,U,4)
 ; M-Care Inp Claim Drg Amt
 W ?58,$J($P(IBEOB(4),U,3),11,2)
 ; if Group Code is PR, print the sum of Reason Codes 1 and 66
 W ?72,$J($G(IBDED),11,2)
 ; Claim Adjustments
 W ?100,$J($G(CLMADJ),10,2)
 ; net reimburse
 W ?115,$J($P(IBEOB(1),U,1),11,2)
 ; Row 20
 ; Reason Code,Remarks Code 5
 W !?48,$G(RSNCD(5)),?52,$P(RMKS,U,5)
 ;
 Q  ; CLMPRNT
TABLE ;;variable;list of Reason Codes w/leading & trailing commas; description;
 ;;RCDED;,1,66,;reason code to calc deductible amount;
 ;;RCOINS;,2,;reason code to calc coinsurance amount;
 ;;RCTADJ;,A2,;reason codes to calc contract adjustment amount;
 ;;RCNCVR;,1,2,23,42,45,66,70,71,89,94,97,118,A1,A2,B3,B6,;reason codes excluded from calc of noncovered charges amount;
 ;;RCLMADJ;,42,45,70,94,97,122,A1,;reason codes to calc claim adj
 ;
