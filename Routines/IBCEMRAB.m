IBCEMRAB ;ALB/DSM - MEDICARE REMITTANCE ADVICE DETAIL-PART B ; 12/29/05 9:58am
 ;;2.0;INTEGRATED BILLING;**155,323,349,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q  ; this routine must be called at an entry point
 ;
 ;  This routine prints MRA Report for CMS-1500 (Part B) Form Type
PRNT ;
 ; Claim Level Adjustments
 N DIC,Y,IBEOB,IBILL,IBILLU,IBTD,IBFD,TOT,PRFRMID
 D GDATA,HDR
 ;
 ; Initialize Totals
 S (TOT("ALWD"),TOT("SRVDED"),TOT("SRVCOIN"),TOT("SRVADJ"),TOT("PAID"))=0
 ;
 ; Service Line Level Adjustments
 I $D(^IBM(361.1,IEN,15)) D SRVPRNT I IBQUIT Q
 ;
 ; Print Totals Line
 D TOTAL
 ;
 ; Print Disclaimer
 D DSCLMR^IBCEMRAX
 ;
 Q  ;PRNT
 ;
GDATA ; Get MRA data
 ;
 N I
 F I=0,1,2,3,6 S IBEOB(I)=$G(^IBM(361.1,IEN,I))
 S IBILL=$G(^DGCR(399,$P(IBEOB(0),U),0)),IBILLU=$G(^DGCR(399,$P(IBEOB(0),U),"U"))
 S IBTD=$$FMTE^XLFDT($P(IBILLU,U),5),IBFD=$$FMTE^XLFDT($P(IBILLU,U,2),5)
 Q  ;GDATA
 ;
HDR ; Print Header
 I $E(IOST,1,2)["C-" W @IOF
 S IBPGN=IBPGN+1
 ;
 ; Row 1,2,3
 W !,?102,"Medicare-equivalent",!?104,"Remittance Advice",!
 ; Row 7
 W !!!!,"DEPT OF VETERANS AFFAIRS"
 ;
 N PRVDR,LINE,PTNM,PTLEN,RMKS,HIC
 ;
 ; gather the pay-to provider information - IB*2*400
 S PRVDR=$$PRVDATA^IBJPS3($P(IBEOB(0),U,1))
 ;
 ; Row 8
 W !,$P(PRVDR,U,5),?97,"PROVIDER #:",?111,"VA0"_$P($$SITE^VASITE,U,3)
 ; Row 9
 W !,$P(PRVDR,U,6),?97,"PAGE #:",?111,$J(IBPGN,3)
 ; Row 10
 W !,$P(PRVDR,U,7),", ",$P(PRVDR,U,8)," ",$P(PRVDR,U,9),?97,"DATE:",?111,$$FMTE^XLFDT($P(IBEOB(0),U,6),5)
 ; Row 14
 W !!!!,"PERF PROV",?12,"SERV DATE",?25,"POS",?29,"NOS",?34,"PROC",?40,"MODS",?53,"BILLED",?63,"ALLOWED",?75,"DEDUCT"
 W ?87,"COINS",?93,"GRP-RC",?107,"AMT",?114,"PROV PD"
 ; Row 15
 S $P(LINE,"-",122)="" W !,LINE
 ;
 ; format and standardize patient name for display
 S PTNM("FILE")=2,PTNM("IENS")=$P(IBILL,U,2),PTNM("FIELD")=.01,PTLEN=23
 S PTNM=$$BLDNAME^XLFNAME(.PTNM,PTLEN)
 I $P(IBEOB(6),U,1)'="" S PTNM=$E($P(IBEOB(6),U,1),1,PTLEN)
 ;
 S HIC=$S($P(IBEOB(6),U,2)'="":$P(IBEOB(6),U,2),$$WNRBILL^IBEFUNC(IBIFN,1):$P($G(^DGCR(399,$P(IBEOB(0),U),"I1")),U,2),1:$P($G(^DGCR(399,$P(IBEOB(0),U),"I2")),U,2))
 ; Row 17
 ; Patient Name, HIC, ACNT, ICN, ASG
 W !!,"NAME",?7,PTNM,?31,"HIC",?35,HIC
 W ?49,"ACNT",?54,$P($$SITE^VASITE,U,3),"-",$P(IBILL,U),?76,"ICN",?80,$P(IBEOB(0),U,14)
 W ?97,"ASG",?101,$S($P(IBILLU,U,6):"Y",1:"N")
 ;
 ; MOA: Medicare Outpatient Remarks Code
 S RMKS=$P(IBEOB(3),U,3,7) I RMKS="" S RMKS="^^^^"
 W ?104,"MOA   " I RMKS'?1."^" W $P(RMKS,U,1)," ",$P(RMKS,U,2)
 I $P(RMKS,U,3,5)'?1."^" S RMKS=$TR(RMKS,U," ") W !,RMKS
 ; Secondary Performing Provider ID
 ; On CMS-1500 Form Type reports, If Medicare WNR is Primary or Secondary, then set Performing Provider ID
 I $$WNRBILL^IBEFUNC(IBIFN,1)!$$WNRBILL^IBEFUNC(IBIFN,2) S PRFRMID="V"_$$MCRSPEC^IBCEU4(IBIFN,1)_$P($$SITE^VASITE,U,3)
 Q  ;HDR
 ;
SRVPRNT ; Print Service Level Data of EOB file (#361.1 Level 15)
 ;
 N LNLVL,RLVL,RLVLD,LNLVLD,SRVFDT,SRVTDT,UNIT,PRCD,MOD,I
 N ALWD,GLVL,GLVLD,GRPCD,OPRCD,PAID,RCNT,SRMKS,SRVCOIN
 N SRVDED,SRVADJ,SRVCHRG,SRVDT,CLMLN,Z
 ;
 ; RLVLD=reason_code^amount^quantity^reason text
 S LNLVL=0
 F  S LNLVL=$O(^IBM(361.1,IEN,15,LNLVL)) Q:'LNLVL  S LNLVLD=^(LNLVL,0) D  I IBQUIT Q
 . I ($Y+4)>IOSL D  I IBQUIT Q
 . . D PAUSE^IBCEMRAX I IBQUIT Q
 . . W @IOF D HDR
 . ; From Service Date, To Service Date
 . S SRVFDT=$P(LNLVLD,U,16),SRVTDT=$P(LNLVLD,U,17)
 . S SRVFDT=$$FMTE^XLFDT(SRVFDT,5),SRVTDT=$$FMTE^XLFDT(SRVTDT,5)
 . ; Get Units, Procedure Code, Original Procedure Code
 . S UNIT=$P(LNLVLD,U,11),PRCD=$P(LNLVLD,U,4),OPRCD=$P(LNLVLD,U,15)
 . S PAID=$P(LNLVLD,U,3),TOT("PAID")=TOT("PAID")+PAID    ; Provider Paid Amount
 . S ALWD=$P(LNLVLD,U,13),TOT("ALWD")=TOT("ALWD")+ALWD   ; Allowed Amount
 . ; Handle Multiple Paid Modifiers from the Service Line Level - string together
 . K MOD M MOD=^IBM(361.1,IEN,15,LNLVL,2) S MOD="" F I=1:1:4 Q:'$D(MOD(I))  S MOD=MOD_MOD(I,0)
 . ; Calculate Submitted Service Line Charge
 . S CLMLN=$P(LNLVLD,U,12)   ; use to match EOB line # to VistA Bill line#
 . S SRVCHRG=$P($G(IBZDATA(CLMLN)),U,8)*$P($G(IBZDATA(CLMLN)),U,9)
 . ; Service Line Level Remarks Codes
 . S Z=0 F  S Z=$O(^IBM(361.1,IEN,15,LNLVL,4,Z)) Q:'Z  I $G(^(Z,0))'="" S SRMKS(Z)=$P(^(0),U,2)
 . ; Get Service Level Group Code/Reason Code Data
 . S (SRVDED,GLVL,RCNT,SRVCOIN)=0 K RSNCD
 . F  S GLVL=$O(^IBM(361.1,IEN,15,LNLVL,1,GLVL)) Q:'GLVL  S GLVLD=^(GLVL,0) D  ;
 . . S GRPCD=$P(GLVLD,U),RLVL=0
 . . F  S RLVL=$O(^IBM(361.1,IEN,15,LNLVL,1,GLVL,1,RLVL)) Q:'RLVL  S RLVLD=^(RLVL,0),RSNCD=$P(RLVLD,U) D  ;
 . . . I GRPCD="PR",RSNCD="AAA" Q  ;exception
 . . . I GRPCD="OA",RSNCD="AB3" Q  ;exception
 . . . I GRPCD="LQ" Q              ;exception
 . . . I GRPCD="PR",RSNCD=1 S SRVDED=SRVDED+$P(RLVLD,U,2),TOT("SRVDED")=TOT("SRVDED")+SRVDED Q  ;deductible
 . . . I GRPCD="PR",RSNCD=2 S SRVCOIN=$P(RLVLD,U,2),TOT("SRVCOIN")=TOT("SRVCOIN")+SRVCOIN Q  ;coinsurance
 . . . S SRVADJ=$P(RLVLD,U,2),TOT("SRVADJ")=TOT("SRVADJ")+SRVADJ  ;adjustment
 . . . S RCNT=RCNT+1,RSNCD(RCNT)=GRPCD_"-"_RSNCD_U_SRVADJ
 . ; Performing Provider ID
 . W !,$G(PRFRMID)
 . ; From Date in MMDD (w/leading zero) format
 . I SRVFDT'="" S SRVDT=$E("00",1,2-$L(+SRVFDT))_+SRVFDT_$E("00",1,2-$L($P(SRVFDT,"/",2)))_$P(SRVFDT,"/",2) W ?12,SRVDT
 . ; To Date in MMDDYY (w/leading zero) format
 . I SRVTDT'="" W ?17,$E("00",1,2-$L(+SRVTDT)),+SRVTDT,$E("00",1,2-$L($P(SRVTDT,"/",2))),$P(SRVTDT,"/",2),$E($P(SRVTDT,"/",3),3,4)
 . ; If To Date is Null, Print From Date with year (if not Null)
 . I SRVTDT="",SRVFDT'="" W ?17,SRVDT,$E($P(SRVFDT,"/",3),3,4)
 . ; Place of Service - from 837 Extract from CMS-1500 Service Line Level
 . W ?25,$P($G(IBZDATA(CLMLN)),U,3)
 . ; Print Units, Procedure Code Paid, Modifiers, Submitted Line Charge, Allowed Amt, Deductable, Coinsurance
 . W ?28,UNIT,?34,PRCD,?40,MOD,?49,$J(SRVCHRG,10,2),?60,$J(ALWD,10,2),?71,$J(SRVDED,10,2),?82,$J(SRVCOIN,10,2)
 . ; Print 1st Line of Group Code-Reason Code, Adjustment Amount, Paid Amount
 . W ?93,$P($G(RSNCD(1)),U),?100,$J($P($G(RSNCD(1)),U,2),10,2),?111,$J(PAID,10,2)
 . ; print PRCD Submitted, Remarks if any
 . I OPRCD'=""!$O(SRMKS(0)) W ! D  ;
 . . I OPRCD'="" W ?33,"(",OPRCD,")"
 . . I $O(SRMKS(0)) W ?44,"REM: " S Z=0 F  S Z=$O(SRMKS(Z)) Q:'Z  W SRMKS(Z),$S($O(SRMKS(Z)):",",1:"")
 . ; Print the rest of Group Code-Reason Code, Reason Code Amount
 . F I=2:1:RCNT W !?93,$P(RSNCD(I),U),?100,$J($P(RSNCD(I),U,2),10,2)
 Q  ;SRVPRNT
 ;
TOTAL ; Print Totals
 W !!,"PT RESP ",$J($P($G(IBEOB(1)),U,2),10,2)  ;Patient Responsibility
 ; Billed Amount, Allowed Amount, Deductable Amount
 W ?35,"CLAIM TOTAL",?49,$J($P($G(IBEOB(2)),U,4),10,2),?60,$J(TOT("ALWD"),10,2),?71,$J(TOT("SRVDED"),10,2)
 ; Coinsurance Amount, Adjustment Amount, Paid Amount
 W ?82,$J(TOT("SRVCOIN"),10,2),?100,$J(TOT("SRVADJ"),10,2),?111,$J(TOT("PAID"),10,2)
 Q  ;TOTAL
 ;
