IBCEMRAX ;ALB/DSM - MEDICARE REMITTANCE ADVICE DETAIL-PART A Cont'd ;25-APR-2003
 ;;2.0;INTEGRATED BILLING;**155**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
DEV(IBIFN) ; Prompt the user for a device
 ; Input: IBIFN= ien# of Claim file
 ;
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC,POP,MRACNT
 I '$G(IBIFN) Q  ;DEV
 W !!,"This report displays Medicare-equivalent Remittance Advice Detail."
 S MRACNT=$$MRACNT^IBCEMU1(IBIFN)
 I MRACNT>1 W !,"*** Multiple MRAs on File for this claim.  ",MRACNT," MRAs will be printed. ***"
 W !,"You will need a 132 column printer for this report",!
 ;
 S %ZIS="QM" D ^%ZIS I POP S IBQUIT=1 Q
 ; handle queuing report next
 I $D(IO("Q")) D  S IBQUIT=1 Q
 . S ZTRTN="PROC^IBCEMRAA"   ; background re-entry point
 . S ZTDESC="Medicare-equivalent Remittance Advice Detail Print"
 . S ZTSAVE("IB*")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK,IO("Q") D HOME^%ZIS
 U IO    ; Output device
 Q  ;DEV
 ;
SRVHDR ; Print Srvice Level Header
 ; ROW 23 -
 ; Service (Line) Level Adjustments Data
 W !!! I '$G(INPAT) W "SERV DATE"  ;print only on outpatient claims
 W ?12,"PT",?15,"PROC",?21,"MODS",?30,"REV",?35,"APC",?43,"UNITS",?50,"TOT CHARGES"
 W ?67,"DEDUCT",?80,"COINS",?90,"ALLOWED",?102,"PAYMENT",?111,"GRP-RC",?123,"ADJ AMT"
 Q  ;SRVHDR
 ;
SRVDATA ; Get Service Level Data of EOB file (#361.1 Level 15)
 ; 
 N LNLVL,RLVL,GLVL,RLVLD,GLVLD,SRVDED,GRPCD,RSNCD,SRVCOIN,I,MOD,SRMKS,LNLVLD
 N PRCD,REVCD,UNIT,SRVDT,PRCTYP,ALWD,PAID,SRVDED,GLVL,RCNT,OPRCD,TOTL,LNORD,LNCNT
 ; Use array LNORD to sort Service Lines in order of Referenced Line #
 S LNLVL=0,LNCNT=1000
 F  S LNLVL=$O(^IBM(361.1,IEN,15,LNLVL)) Q:'LNLVL  S LNORD=$P(^(LNLVL,0),U,12) D  ;
 . I LNORD S LNORD(LNORD)=LNLVL Q
 . S LNORD(LNCNT)=LNLVL,LNCNT=LNCNT+1
 ;
 S LNORD=0
 F  S LNORD=$O(LNORD(LNORD)) Q:'LNORD  S LNLVL=LNORD(LNORD) D  I IBQUIT Q
 . S LNLVLD=$G(^IBM(361.1,IEN,15,LNLVL,0)) I LNLVLD="" Q
 . I ($Y+4)>IOSL D  I IBQUIT Q
 . . D PAUSE I IBQUIT Q
 . . W @IOF D CLMHDR^IBCEMRAA
 . . D SRVHDR
 . ;
 . K MOD,RCNT,TOTL S RCNT=0
 . ; Procedure Code, Revenue Code, Units, From Service Date, Procedure Type
 . S PRCD=$P(LNLVLD,U,4),REVCD=$P(LNLVLD,U,10),UNIT=$P(LNLVLD,U,11),SRVDT=$P(LNLVLD,U,16)
 . S PRCTYP=$P(LNLVLD,U,18) I PRCTYP="NU" S PRCTYP="" ;don't display NU for Proc Type
 . ; Resolve Revenue Code Pointer
 . I REVCD'="" S REVCD=$P($G(^DGCR(399.2,REVCD,0)),U)
 . ; Allowed, Payment, Original Procedure Code
 . S ALWD=$P(LNLVLD,U,13),PAID=$P(LNLVLD,U,3),OPRCD=$P(LNLVLD,U,15)
 . ; Handle Multiple Paid Modifiers from the Service Line Level (may have 4 mod's, could only fit 3)
 . M MOD=^IBM(361.1,IEN,15,LNLVL,2) S MOD="" F I=1:1:3 Q:'$D(MOD(I))  S MOD=MOD_$S(MOD="":"",1:",")_MOD(I,0)
 . ; Get Total Charge by matching 837 Extract Records with Bill's Original Line# on the current Service Line (LNLVLD)
 . S TOTL=$P($G(IBZDATA($P(LNLVLD,U,12))),U,5)
 . ; Service Line Level Remarks Codes
 . S SRMKS=$G(^IBM(361.1,IEN,15,LNLVL,3))
 . ; Row 24  - print Service date only on Outpatient claims (skip on Inpatients)
 . W ! I '$G(INPAT) W $$FMTE^XLFDT(SRVDT,5)
 . W ?12,PRCTYP,?15,PRCD,?21,MOD,?30,REVCD,?41,$J(UNIT,7),?49,$J($G(TOTL),12,2)
 . ;
 . ; Get Service Level Group Code/Reason Code Data
 . ; RLVLD=reason_code^amount^quantity^reason text
 . S (SRVDED,GLVL,RCNT,SRVCOIN)=0 K RSNCD
 . F  S GLVL=$O(^IBM(361.1,IEN,15,LNLVL,1,GLVL)) Q:'GLVL  S GLVLD=^(GLVL,0) D  ;
 . . S GRPCD=$P(GLVLD,U),RLVL=0
 . . F  S RLVL=$O(^IBM(361.1,IEN,15,LNLVL,1,GLVL,1,RLVL)) Q:'RLVL  S RLVLD=^(RLVL,0),RSNCD=$P(RLVLD,U) D  ;
 . . . I GRPCD="PR",RSNCD="AAA" Q   ;exception
 . . . I GRPCD="OA",RSNCD="AB3" Q   ;exception
 . . . I GRPCD="LQ" Q               ;exception
 . . . I GRPCD="PR",RSNCD=1!(RSNCD=66) S SRVDED=SRVDED+$P(RLVLD,U,2) Q  ;deductible
 . . . I GRPCD="PR",RSNCD=2 S SRVCOIN=$P(RLVLD,U,2) Q  ;coinsurance
 . . . S RCNT=RCNT+1,RSNCD(RCNT)=GRPCD_"-"_RSNCD_U_$P(RLVLD,U,2)
 . ; Print Service Level Group Code/Reason Code Data
 . ; Service Level deductible, Coinsurance, Allowed, Paid Amount
 . W ?62,$J(SRVDED,11,2),?74,$J(SRVCOIN,11,2),?86,$J(ALWD,11,2),?98,$J(PAID,11,2)
 . ; Print Group Code-Reason Code, Adjustment Amount
 . F I=1:1:RCNT W:I>1 ! W ?111,$P(RSNCD(I),U),?118,$J($P(RSNCD(I),U,2),12,2)
 . ; Row 25
 . I OPRCD="",(SRMKS="") Q
 . W ! I OPRCD'="" W ?15,"(",$E(OPRCD,1,4),")"
 . I SRMKS'="" W ?26,"REM:",?30,$P(SRMKS,U)
 ;
 Q  ;SRVDATA
 ;
PAUSE ; Pause at the bottom of screen. This section is called
 ; from different points of the MRA report.
 ;
 I $E(IOST,1,2)'["C-" Q  ;if not terminal, don't pause
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" D ^DIR
 I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 Q
 Q  ;PAUSE
 ;
DSCLMR ;
 N LINE
 S $P(LINE,"-",122)=""
 W !!,LINE
 W !,"This is a printed representation of a remittance advice, developed through a joint effort between the Centers for Medicare and"
 W !,"Medicaid Services and the Department of Veterans Affairs, for a claim for services or supplies furnished to a Medicare-eligible"
 W !,"veteran through a facility of the Department of Veterans Affairs.  The remittance advice shows the amount that Medicare would have"
 W !,"paid had the claim been payable by Medicare, as well as the coinsurance and deductible amounts that would have applied."
 W !,"The claim is not payable under the Medicare program, and no Medicare payment was issued."
 W !
 Q  ;DSCLMR
 ;
LINELVL ; This section is called when printing Institutional Reports
 ; The values of Coinsurance, Contractual Adjustment, Noncovered Charges
 ; and Deductible are calculated from the Service Line level and not
 ; from the Claim level.
 ;
 ; RLVLD=reason_code^amount^quantity^reason text
 ; IBCOINS,IBCTADJ,NCVRCHRG,CLMADJ are set to zero in the calling section CLMDATA
 ;
 N LNLVL,LNLVLD,GLVL,GLVLD,RLVL,RLVLD,GRPCD,RSNCD
 S LNLVL=0
 F  S LNLVL=$O(^IBM(361.1,IEN,15,LNLVL)) Q:'LNLVL  S LNLVLD=^(LNLVL,0) D  ;
 . S GLVL=0 F  S GLVL=$O(^IBM(361.1,IEN,15,LNLVL,1,GLVL)) Q:'GLVL  S GLVLD=^(GLVL,0) D  ;
 . . S GRPCD=$P(GLVLD,U),RLVL=0
 . . F  S RLVL=$O(^IBM(361.1,IEN,15,LNLVL,1,GLVL,1,RLVL)) Q:'RLVL  S RLVLD=^(RLVL,0),RSNCD=$P(RLVLD,U) D  ;
 . . . I GRPCD="PR",RSNCD="AAA" Q   ;exception
 . . . I GRPCD="OA",RSNCD="AB3" Q   ;exception
 . . . I GRPCD="LQ" Q               ;exception
 . . . ; set Claim Adjustment only if none were found at the claim level (don't check for group code)
 . . . I RCLMADJ[(","_RSNCD_",") S CLMADJ=CLMADJ+$P(RLVLD,U,2)
 . . . ; Coinsurance
 . . . I GRPCD="PR",RCOINS[(","_RSNCD_",") S IBCOINS=IBCOINS+$P(RLVLD,U,2) Q
 . . . ; Deductible
 . . . I GRPCD="PR" I RCDED[(","_RSNCD_",") S IBDED=IBDED+$P(RLVLD,U,2) Q
 . . . I GRPCD="CO" D  ;
 . . . . ; Contractual Adjustment
 . . . . I RCTADJ[(","_RSNCD_",") S IBCTADJ=IBCTADJ+$P(RLVLD,U,2)
 . . . . ; Noncovered Charges
 . . . . I RCNCVR'[(","_RSNCD_",") S NCVRCHRG=NCVRCHRG+$P(RLVLD,U,2)
 Q  ;LINELVL
 ;
