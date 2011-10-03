IBTOAT ;ALB/AAS - CLAIMS TRACKING ADMISSION SHEET PRINT ; 18-JUN-93
 ;;2.0; INTEGRATED BILLING ;**1,199**; 21-MAR-94
 ;
% I '$D(DT) D DT^DICRW
 ;
PAT ; -- Select patient
 S IBTOAT=1
 S DIC="^DPT(",DIC(0)="AEQM" ;,DIC("S")="I $D(^IBT(356,""APTA"",+Y))"
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 D ^DIC K DIC I +Y<1 G END
 S DFN=+Y
 ;
EN1 ;
 ; -- entry point to call from event driver or registration
 N VAIN,VAERR,VA,VAINDT,IBQUIT,DIR,I,J
 W !
 S IBQUIT=0
 Q:'$D(DFN)
 I '$G(IBTOAT) Q:'$P($G(^IBE(350.9,1,6)),"^",5)
 S VA200="" D INP^VADPT
 ;Q:'VAIN(1)
 S IBTRN=$O(^IBT(356,"AD",+$G(VAIN(1)),0))
 I IBTRN D  I IBQUIT G END
 .N DIR
 .S DIR(0)="Y",DIR("A")="Print Admission Sheet for Current Adm. ("_$P(VAIN(7),"^",2)_")"
 .S DIR("B")="YES"
 .S DIR("?")="Answer 'YES' if you want to print an admission sheet for the current admission, or 'NO' if you wish to select another admission date."
 .D ^DIR K DIR I $D(DIRUT) S IBQUIT=1
 .S IBTCUR=Y
 .Q
 ;
 I '$G(IBTCUR)!('$G(IBTRN))!($P($G(^IBT(356,+$G(IBTRN),0)),"^",2)'=DFN) D TRAC
 I '$G(IBTRN) G END
 ;
DEV ; -- select device, run option
 W !
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="ONE^IBTOAT1",ZTSAVE("IB*")="",ZTSAVE("DFN")="",ZTDESC="IB - Print single admission sheet" D ^%ZTLOAD K IO("Q"),ZTSK D HOME^%ZIS G %
 U IO D ONE^IBTOAT1,END W !! G %
 Q
 ;
END ; -- Clean up
 W !
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K X,Y,DFN,IBTRN,%ZIS,IBTOAT,VA200,IBTCUR,MAX,POP,TAB,TAB2,IBTITLE,IBDT
 Q
 ;
TRAC ; -- Select tracking module internal entry number
 W !
 S DIC="^IBT(356,",DIC(0)="AEQ",DIC("A")="Select Visit: "
 S D="ADFN"_DFN
 S DIC("S")="I $P(^(0),U,2)=DFN,$P(^(0),U,5)"
 D IX^DIC K DIC I +Y<1 G END
 S IBTRN=+Y
 Q
 ;
REG(DGPM) ; -- can be called from registration to print an admission sheet
 ; -- input  DGPM = admission movement
 N IBTRKR,IBTRN,IBTRND,X,Y,I,J,DIR,DIRUT,DUOUT,DTOUT,IBQUIT,DFN
 S IBTRKR=$G(^IBE(350.9,1,6))
 Q:'$P(IBTRKR,"^",6)  ; quit if use admission sheets = no
 Q:'$G(DGPM)
 S DFN=$P($G(^DGPM(DGPM,0)),"^",2) Q:'DFN
 S IBTRN=$O(^IBT(356,"AD",DGPM,0))
 I 'IBTRN D ADM^IBTUTL(DGPM)
 S DIR(0)="Y",DIR("A")="PRINT ADMISSION SHEET",DIR("B")="YES"
 S DIR("?")="Answer YES if you wish to print an admission sheet which could be place on the top of the inpatient chart.  Answer NO if you do not want to print one."
 D ^DIR K DIR I Y D
 .S ZTRTN="ONE^IBTOAT1",ZTSAVE("IB*")="",ZTSAVE("DFN")="",ZTDESC="IB - Print single admission sheet" D ^%ZTLOAD K ZTSK
 .;D ONE^IBTOAT1
 Q
