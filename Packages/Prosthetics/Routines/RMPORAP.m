RMPORAP ;(NG)/DG/CAP - ACTIVE HOME OXY PTS IN ZIP CODE ORDER ;7/24/98
 ;;3.0;PROSTHETICS;**29,179**;Feb 09, 1996;Build 7
 ;
 ;RMPR*3.0*179 Flag a deceased patient by adding an '*'
 ;             in front of SSN. 
 ;
SITE ;Initialize site variables.
 D HOSITE^RMPOUTL0 I '$D(RMPOXITE) Q
 ;
LI ;List sought patients.
 N WHO S (WHO,COUNT,RMEND,RMPOPRT,RMPODCNT)=0     ;RMPR*3.0*179
 S DIC="^RMPR(665,"
 S DIS(0)="I $P($G(^RMPR(665,D0,""RMPOA"")),U,7)=RMPOXITE,$P($G(^RMPR(665,D0,""RMPOA"")),U,3)="""""
 S BY="[RMPO-RPT-HOACTZIPLIST]"
 S FR="",PAGE=0
 S FLDS="[RMPO-RPT-HOACTZIPLIST]"
 S DHD="W ?0 D RPTHDR^RMPORAP"
 S DHIT="D CNT^RMPORAP"
 S DIOEND="I $G(Y)'[U D DIOEND^RMPORAP S RMEND=1 S:IOST[""P-"" RMPOPRT=1"    ;RMPR*3.0*179
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
 W !,"Active Home Oxygen Patients by Zip Code",?50,"'*' denotes deceased patient",!
 W !,"Zip Code",?12,"Name/Phone Number",?36,"SSN",?43,"Address"
 W !,"==========",?12,"=====================",?36,"====",?43,"===================================",!
 Q
CNT ;Count the total of patients printed.
 I WHO'=D0 S COUNT=COUNT+1,WHO=D0 S:+$G(^DPT(D0,.35)) RMPODCNT=RMPODCNT+1
 Q
 ;
DIOEND ;TOTAL PRINT     RMPR*3.0*179
 S COUNT=$E("      ",1,(6-$L(COUNT)))_COUNT
 W !!,?47,"Total Patients: ",COUNT
 S RMPOCNT=$E("      ",1,(6-$L(RMPODCNT)))_RMPODCNT
 W !,?38,"Total Deceased Patients: ",RMPODCNT
 Q
SSN ;GET SSN    ;RMPR*3.0*179
 N RMPOEXP
 S X="",RMPOEXP=" "    ;RMPR*3.0*179 Flag a deceased patient by attaching an '*' to SSN. ^DPT(D0,.35) direct read supported by ICR #10035
 I +$G(^DPT(D0,.35)) S RMPOEXP="*",RMPODCNT=RMPODCNT+1
 S RMPOSSN=$E($P($G(^DPT(D0,0)),"^",9),6,9)
 S RMPOSSN=RMPOEXP_RMPOSSN
 D CNT
 Q
