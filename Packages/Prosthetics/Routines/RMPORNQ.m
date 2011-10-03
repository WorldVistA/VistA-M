RMPORNQ ;(VA-EDS)PAK/HINES CIOFO/HNC - NEW PATIENT REPORT ;7/24/98
 ;;3.0;PROSTHETICS;**29,77**;Feb 09, 1996
 ;
 ;RVD patch #77 - insure that a dangling 'AC' x-ref will not cause
 ;                an undefined error.
 ;
START ;
 ;Set up site variables.
 D HOSITE^RMPOUTL0 I '$D(RMPOXITE) Q
 ;
 ;Ask starting date
 S %DT="AEX",%DT("A")="Enter the start date: "
 S %DT(0)=-DT
 S %DT("B")=$E(DT,4,5)_"/01"_"/"_$E(DT,2,3)
 D ^%DT Q:'Y!$D(DTOUT)
 S FRMDT=$P(Y,".")  ; extract ONLY date
 ;
 ;List the sought patient.
 S DIC="^RMPR(665,",L=0
 S DIS(0)="I $P($G(^RMPR(665,D0,""RMPOA"")),U,7)=RMPOXITE"
 S BY=".01,19.2",FR(1)="",FR(2)=FRMDT,TO(1)="",TO(2)=""
 S (RMEND,RMPORPT,PAGE)=0
 S SPACE="",$P(SPACE," ",80)="",COUNT=0,DASH="",$P(DASH,"-",79)=""
 D NOW^%DTC S Y=% X ^DD("DD") S RPTDT=$P(Y,"@",1)_"  "_$P($P(Y,"@",2),":",1,2)
 S DHD="W ?0 D RPTHDR^RMPORNQ"
 S FLDS=".01;C1;L22;""PATIENT"",W $$SSN^RMPORPR;C25;R4;""SSN"",W $$PRI^RMPORNQ;31;L32;""PRIMARY ITEM"",19.2;C65;L10;""START"""
 S DIOEND="I $G(Y)'[U S COUNT=$E(""      "",1,(6-$L(COUNT)))_COUNT W !!,?50,""TOTAL PATIENTS: "",COUNT S RMEND=1 S:IOST[""P-"" RMPORPT=1"
 D EN1^DIP
 I RMPORPT=0,$G(RMEND) K DIR S DIR(0)="E" D ^DIR
EXIT ;
 ;
 N RMPR,RMPRSITE D KILL^XUSCLEAN
 Q
SDT ;Activation date.
 S X=$P($G(^RMPR(665,D0,"RMPOA")),U,2)
 I X S X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_($E(X,1,3)+1700)
 Q
 ;
PRI() ;Get primary item.
 N ITMN
 ;
 S RMPOITM=$O(^RMPR(665,"AC","Y",D0,"")) Q:RMPOITM="" ""
 ; get item name from ITEM MASTER file as pointer field is DINUMed
 I '$D(^RMPR(665,D0,"RMPOC",RMPOITM,0)) Q ""
 S ITMN=$P(^RMPR(665,D0,"RMPOC",RMPOITM,0),U)
 S ITMN=$P(^RMPR(661,ITMN,0),U)
 S ITMN=$P(^PRC(441,ITMN,0),U,2)
 Q $E(ITMN,1,32)
 ;
RPTHDR ;Report header
 N RA S RA=RMPO("NAME"),PAGE=PAGE+1
 W RPTDT,?(40-($L(RA)/2)),RA,?65,"Page: "_PAGE
 W !?24,"New Patient Report",!
 W !,?4,"Patient",?24,"SSN",?39,"Primary Item",?64,"Activation Date"
 W !,"=====================",?24,"====",?30,"================================"
 W ?64,"===============",!
 Q
