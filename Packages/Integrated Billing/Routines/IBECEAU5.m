IBECEAU5 ;ALB/BGA - Cancel/Edit/Add CALC Observation COPAY ; 17-MAY-2000
 ;;2.0;INTEGRATED BILLING;**132,153,156,167,247**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Find the IB action type and outpatient copay rate for an inpatient Observation
 ;
OBS ; Called from EN^IBAMTD when adding an Inpatient Observation Copay
 ; 
 ; Check to see if you have a clock
 I '$G(IBCLDA) S IBCLDT=$P(IBADMDT,".") D CLADD^IBAUTL3 G:IBY<1 END
 ; Calculate Outpatient COPAY Charge return IBATYP,IBCHG,IBDESC,IBRTED
 ; setting IBTYPE=2 to designate all observation is specialty care
 S (IBDT,IBADMDT)=$P(IBADMDT,"."),IBX="O",IBTYPE=2 D CHRG G:IBY<1 END
 ; Set the SOFTLINK field = Admission Movment:405
 S IBSL="405:"_IBA,IBUNIT=1,(IBFR,IBEVDT)=IBADMDT,IBTO=$P(IBDISDT,"."),IBEVDA="*"
 ; Add the charge to ^IB set IBN= new charge's IEN
 D ADD^IBECEAU3 G:IBY<1 END
 ; Pass the charge to AR set IBTRAN and IBIL
 S IBDUZ=DUZ D IBFLR^IBAMTS1
END K IBFR,IBTO,IBTYPE
 Q
 ;
CHRG ; Called from OPT^IBECEA33 when adding a obs copay from CANCEL/EDIT/ADD
 ;
 ;     Input: Optional if no IBDT than default to DT
 ;     Output:  IBATYP, IBCHG, IBDESC, IBRTED
 ;
 I '$D(IBDT) S IBDT=DT
 D TYPE^IBAUTL2 ; Sets IBCHRG=Outpat Copay $ and IBRTED=effective DT of rate
 Q:'IBCHG  ; Error occurred sets IBY in TYPE^IBAUTL2 
 S IBBS=$$MCCRUTL^IBCRU1("OBSERVATION CARE",5)
 S IBATYP=$P($G(^DGCR(399.1,+IBBS,0)),"^",7) I 'IBATYP S IBY="-1^IB008" Q
 I $D(^IBE(350.1,+IBATYP,20)) X ^(20) ; sets IBDESC
 Q
 ;
CLSF(DGMVP) ;
 ; This Subroutine evaluates an Inpatient Admission for an Observation Speciality
 ; where the patient has claimed exposure. The Special Inpatient Billing
 ; case record is evaluated to detemine the status of the disposition
 ; the results are than displayed on the Outpatient Events Reports
 ;
 N DGIEN,DG0,IBDISP,IBOUT,IBREAS,IBTYP
 Q:'DGMVP!('$D(^IBE(351.2,"AC",DGMVP)))  ; no special case record on file
 S DGIEN=0,DGIEN=$O(^IBE(351.2,"AC",DGMVP,DGIEN)) Q:'DGIEN
 S DG0=$G(^IBE(351.2,DGIEN,0)) ; Special Inpatient Billing Case Record
 Q:$P(DG0,U,8)&('$P(DG0,U,7))  ; Case disposed care not related to Condition
 S IBTYP=$P(DG0,U,3)
 S IBTYP=$$UCCL^IBAMTI(IBTYP) S:IBTYP="SPECIAL" IBTYP="SPECIAL CASE"
 S IBOUT="* Patient Claims EPISODE OF CARE related to: "_IBTYP
 I '$P(DG0,U,8) S IBDISP="** STATUS - Case has not been DISPOSITIONED" D PRINT Q
 I $P(DG0,U,8),$P(DG0,U,7) D
 . S IBDISP="** Case has been DIPOSITIONED and Care is NOT BILLABLE"
 . S IBREAS=$G(^IBE(351.2,DGIEN,1,0))
 . D PRINT
 Q
 ;
PRINT ;
 I IBLINE>55 D HDR^IBOVOP2 W !,IBFLD1,!?5,IBFLD2
 I $Y>(IOSL-5) D PAUSE^IBOUTL Q:IBQUIT  D HDR^IBOVOP2 W !,IBFLD1,!?5,IBFLD2
 W !!,?5,IBOUT
 W:$G(IBDISP)]"" !,?5,IBDISP ; Writes the status of the disposition
 I $G(IBREAS)]"" D
 . W !,?5,"Reason Not Billable: ",$E(IBREAS,1,55) ; Writes Reason Not Billed
 Q
 ;
FEE ; This Subroutine permits a Clerk to add a DG FEE SERVICE (OPT)
 ; when the value of the fee for service is less than the normal
 ; Outpatient Copayment.
 ;
 Q:'$G(IBAFEE)!('$G(IBCHG))
 ; Reset ibdesc="DG FEE SERVICE (OPT) NEW", ibatyp=57
 ;  before adding entry from ADD^IBECEAU3 to ^IB
 S IBATYP=IBAFEE I $D(^IBE(350.1,+IBATYP,20)) X ^(20)
 N DIR,X,Y,DIRUT
 S DIR(0)="350,.07",DIR("A")="Fee Amount"
 S DIR("B")=$S(IBCHG?1N.N1"."1N:IBCHG_0,1:IBCHG)
 S DIR("T")=180,DIR("?")=" "
 S DIR("?",1)="     *** The Fee for Service can not be LESS than $1.00 or"
 S DIR("?",2)="     *** GREATER than $"_$S(IBCHG?1N.N1"."1N:IBCHG_0,1:IBCHG)_"."
 D ^DIR I $G(DIRUT) S IBY=-1 Q
 I $G(Y)>50.8!($G(Y)<1) D  G FEE
 . W !,?10,"*** The Fee for Service can not be GREATER than $"_$S(IBCHG?1N.N1"."1N:IBCHG_0,1:IBCHG)
 . W !,?10,"*** AND must be GREATER than $.99==> Please try Again"
 S:$G(Y) IBCHG=Y
 Q
 ;
IBOVOP(IBDATE) ;
 ; This Subroutine expands the functions of the Outpatient Events Report
 ; by adding Inpatient Observation Admissions/Discharges to the the report.
 ; Find Admissions or Discharges Associated with Inpatient Observation
 ; Specialities and Load them into ^TMP("IBOVOP",$J) to be printed
 ; by ^IBOVOP the Outpatient Events Report.
 ;
 Q:'$G(IBDATE)
 N DGPM0,DGMVP,IBDATE1,IBDFN,IBI,IBENDDT,IBSPEC
 N IBFLD1,IBFLD2,IBFLD3,IBFLD4,IBFLD5,IBSUB3,IBSUB4,IBSUB5,IBSUB6
 S IBDATE1=$P(IBDATE,"."),IBI=($P(IBDATE,".")-1)+.99999
 S IBENDDT=IBDATE1+.9999
 F  S IBI=$O(^DGPM("B",IBI)) Q:'IBI!(IBI>IBENDDT)  D
 . S DGMVP=0 F  S DGMVP=$O(^DGPM("B",IBI,DGMVP)) Q:'DGMVP  D
 . . S DGPM0=$G(^DGPM(DGMVP,0)) Q:$P(DGPM0,U,2)'=1
 . . S IBTYP=$P(DGPM0,U,2) ; 1=Admission
 . . S IBSPEC=$$MVT^DGPMOBS(DGMVP) Q:+IBSPEC<1  ; quite not OBS
 . . S IBDFN=$P(DGPM0,U,3) Q:'IBDFN
 . . Q:$$BILST^DGMTUB(IBDFN)<($P(+DGPM0,"."))  ; quite not MT billable
 . . S IBSUB3=$$FLD1^IBOVOP1(IBDFN) Q:IBSUB3=""  ; subscript 3 PT name
 . . S IBSUB4="OBS ADMIS"
 . . S IBSUB5=$$FLD3^IBOVOP1(+DGPM0) Q:IBSUB5=""
 . . S IBSUB6=0
 . . S IBFLD1=$E($P(IBSPEC,U,3),U,30) ; Treating Speciality
 . . S IBFLD2=""
 . . S IBFLD3=$S($P(DGPM0,U,17):"DISCHARGED",1:"ADMISSION")
 . . S IBFLD4=IBDFN,IBFLD5="",IBFLD6=DGMVP
 . . ; Set the Global for the Outpatient Event Report
 . . S ^TMP("IBOVOP",$J,IBSUB3,IBSUB4,IBSUB5,IBSUB6)=IBFLD1_U_IBFLD2_U_IBFLD3_U_IBFLD4_U_IBFLD5_U_IBFLD6
 Q
