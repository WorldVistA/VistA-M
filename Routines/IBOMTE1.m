IBOMTE1 ;ALB/CPM-ESTIMATE MEANS TEST CHARGES (PRINT);17-DEC-91
 ;;2.0;INTEGRATED BILLING;**153,183**;21-MAR-94
 ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOMTE1-2" D T0^%ZOSV ;start rt clock
 ; Set up report header.
 S IBLINE="",$P(IBLINE,"-",IOM+1)="",(IBPAG,IBQUIT)=0
 S DFN=IBDFN,IBPT=$$PT^IBEFUNC(DFN) D HDR
 ;
 ; Check to see if patient will be Means Test billable upon admission.
 S IBLASTC=$$BILST^DGMTUB(DFN)
 I IBBDT>DT&(IBLASTC<DT)!(IBBDT'>DT&(IBLASTC<IBBDT)) D
 . I 'IBLASTC W "** Please note that this patient has never been Means Test billable. **",! Q
 . W "Please note that this patient ",$S(IBBDT'<DT:"will not be",1:"was not")," MT billable on the admission date."
 . W !,"Last date as MT billable: ",$$DAT1^IBOUTL(IBLASTC),!
 ;
 ; Check to see if the patient has an active billing clock
 ; from which to base the charges.  Print active clock data.
 D CLOCK^IBAUTL3
 I IBCLDA D
 . S X1=IBBDT,X2=IBCLDT D ^%DTC S IBCLCT=X I X>365 S IBCLDA=0 Q
 . W "** THIS PATIENT HAS AN ACTIVE BILLING CLOCK **",!?6,"Clock date: ",$$DAT1^IBOUTL(IBCLDT),"   Days of inpatient care within clock: ",$J(+IBCLDAY,2)
 . W !?6,"Copayments made for current 90 days of inpatient care: ",$J("$"_$J(IBCLDOL,0,2),7),!
 I 'IBCLDA S IBCLDT=IBBDT,(IBCLCT,IBCLDAY,IBCLDOL)=0 D DED^IBAUTL3
 I IBGMT S IBMED=$$REDUCE^IBAGMT(IBMED) ;GMT Deductible adjustment
 ;
 ; Build necessary processing variables.
 S (IBCHGT,IBTOT)=0 K IBA
 S X1=IBEDT,X2=IBBDT D ^%DTC S IBLOS=$S(IBEDT=IBBDT&('IBEVDA):1,1:X)
 S X=IBBDT D H^%DTC S IBBDH=%H,IBFCTR=IBBDH-1
 S X=IBEDT D H^%DTC S IBEDH=%H-1
 S IBNH=$P($G(^DGCR(399.1,IBBS,0)),"^")["NURSING"
 ;
 ; If continuous patient, just calculate the per diem.
 I $$CONT^IBAUTL5(DFN)>IBEDT D COHDR^IBOMTE2,NOCOP W ?3,"(PATIENT IS CONTINUOUS SINCE 7/1/86)",! G PER
 ;
 ; Process each day in the admission for co-payments.
 D ^IBOMTE2 G:IBQUIT END
 ;
PER ; Calculate the total per diem charge and print total.
 I $Y>(IOSL-7) D PAUSE^IBOUTL G:IBQUIT END D HDR
 W !,"PER DIEM CHARGES for ",$S(IBNH:"NURSING HOME",1:"HOSPITAL")," CARE",!,IBLINE
 S IBDIEM=$$DIEM^IBAUTL5,X=IBEDT I IBBDT'=IBEDT S %H=IBEDH D YMD^%DTC S IBEDT=X
 I IBEDT<IBDIEM D NOPD G TOT
 I IBDIEM>IBBDT S X1=IBEDT,(X2,IBBDT)=IBDIEM D ^%DTC S IBLOS=X+1
 I IBLOS<1 D NOPD G TOT
 S IBRATE=$S(IBNH:5,1:10)
 I IBGMT>0 S IBRATE=$$REDUCE^IBAGMT(IBRATE) ;GMT Adjustment of Rate
 S IBCHG=IBLOS*IBRATE
 S IBTOT=IBTOT+IBCHG
 W !,$$DAT1^IBOUTL(IBBDT),?12,$$DAT1^IBOUTL(IBEDT),?26,IBLOS," day",$E("s",IBLOS>1),"  @ $",$J(IBRATE,"",2),"/day" W:IBGMT " (GMT rate)"
 S X=IBCHG,X2="2$",X3=12 D COMMA^%DTC W ?61,X
 ;
TOT W !?62,"----------",!
 W ?$S(IBGMT>1:23,1:35),"Total Estimated Charges" W:IBGMT>1 " (GMT Rates)" W ":" S X=IBTOT,X2="2$",X3=12 D COMMA^%DTC W ?61,X
 D PAUSE^IBOUTL
 ;
END ; Close device and quit
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOMTE1" D T1^%ZOSV ;stop rt clock
 Q:$D(ZTQUEUED)
 K %H,IBJ,IBDIEM,IBCLDOL,IBTOT,IBH,IBLOS,IBNH,IBFCTR,IBBDH,IBEDH,IBLASTC,IBMED,IBCLDA,IBCLDT,IBCLCT,IBCLDAY,IBQUIT,IBCHG,IBCHGT,IBPAG,IBLINE,IBMAX,IBDT,IBATYP,IBDESC,IBI,IBCHARG,IBPT,IBGMT,IBRATE
 D ^%ZISC Q
 ;
 ;
HDR ; Print header.
 S IBPAG=IBPAG+1,IBH="Estimated "_$S(IBGMT:"GMT",1:"Means Test")_" Inpatient Charges for "_$P(IBPT,"^")_"  "_$P(IBPT,"^",3)_$S(IBPAG>1:"  (Con't.)",1:"")
 I $E(IOST,1,2)["C-"!(IBPAG>1) W @IOF
 W !?IOM-$L(IBH)\2,IBH,!!
 I IBEVDA W "Please note that this patient is a current inpatient.",!
 I IBGMT W "The patient has GMT Copayment Status.",!
 W "Charges will be estimated from ",$$DAT1^IBOUTL(IBBDT)," through ",$$DAT1^IBOUTL(IBEDT),"."
 I IBBDT=IBEDT,'IBEVDA W "  (ONE-DAY ADMISSION)"
 W ! Q
 ;
NOCOP ; Print 'No Copay' message.
 W !,"** NO COPAYMENT CHARGES WILL BE APPLIED **",?67,"$0.00",! Q
 ;
NOPD ; Print 'No Per Diem' message.
 W !,"** NO PER DIEM CHARGES WILL BE APPLIED **",?67,"$0.00" Q
