RMPORAP ;(NG)/DG/CAP - ACTIVE HOME OXY PTS IN ZIP CODE ORDER ;7/24/98
 ;;3.0;PROSTHETICS;**29**;Feb 09, 1996
 ;
SITE ;Initialize site variables.
 D HOSITE^RMPOUTL0 I '$D(RMPOXITE) Q
 ;
LI ;List sought patients.
 N WHO S (WHO,COUNT,RMEND,RMPOPRT)=0
 S DIC="^RMPR(665,"
 S DIS(0)="I $P($G(^RMPR(665,D0,""RMPOA"")),U,7)=RMPOXITE,$P($G(^RMPR(665,D0,""RMPOA"")),U,3)="""""
 S BY="[RMPO-RPT-HOACTZIPLIST]"
 S FR="",PAGE=0
 S FLDS="[RMPO-RPT-PRINT-HOACTZIPLIST]"
 S DHD="W ?0 D RPTHDR^RMPORAP"
 S DHIT="D CNT^RMPORAP"
 S DIOEND="I $G(Y)'[U S COUNT=$E(""      "",1,(6-$L(COUNT)))_COUNT W !!,?50,""Total Patients: "",COUNT S RMEND=1 S:IOST[""P-"" RMPOPRT=1"
 D EN1^DIP
 I RMPOPRT=0,$G(RMEND) K DIR S DIR(0)="E" D ^DIR
 D EXIT
 Q
 ;
EXIT ;
 N RMPRSITE,RMPR D KILL^XUSCLEAN
 Q
 ;
RPTHDR ; Report header
 N Y S Y=""
 D NOW^%DTC S Y=% X ^DD("DD")
 S RPTDT=$P(Y,"@",1)_"  "_$P($P(Y,"@",2),":",1,2)
 N RA S RA=RMPO("NAME"),PAGE=PAGE+1
 W RPTDT,?(40-($L(RA)/2)),RA,?68,"Page: "_PAGE
 W !?20,"Active Home Oxygen Patients by Zip Code",!
 W !,"Zip Code",?12,"Name/Phone Number",?36,"SSN",?43,"Address"
 W !,"==========",?12,"=====================",?36,"====",?43,"===================================",!
 Q
CNT ;Count the total of patients printed.
 I WHO'=D0 S COUNT=COUNT+1,WHO=D0
 Q
 ;
