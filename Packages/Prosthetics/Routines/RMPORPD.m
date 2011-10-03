RMPORPD ;(NG)/DG/CAP/HINES CIOFO/HNC -PRESCRIPTION EXPIRE DATE ACTIVE PATIENTS ; 5/19/00 9:12am
 ;;3.0;PROSTHETICS;**29,46,49**;Feb 09, 1996
 ;
SITE ;   Set up the site variables.
 D HOSITE^RMPOUTL0  Q:'$D(RMPOXITE)
 ;
LI ;   List the sought patient.
 N WHO S WHO=0
 S (RMEND,RMPORPT,PAGE,COUNT)=0
 D NOW^%DTC  S Y=%  X ^DD("DD")
 S RPTDT=$P(Y,"@",1)_"  "_$P($P(Y,"@",2),":",1,2)
 ;
 S DIC="^RMPR(665,"
 S BY(0)="^TMP(""RMPO"",$J,",L(0)=3,L=0,FR=""
 S DIS(0)="I $P($G(^RMPR(665,D0,""RMPOA"")),U,7)=RMPOXITE,$P($G(^RMPR(665,D0,""RMPOA"")),U,2)'="""",$P($G(^RMPR(665,D0,""RMPOA"")),U,3)="""""
 S DHIT="D CNT^RMPORPD"
 S DHD="W ?0 D RPTHDR^RMPORPD"
 S DIOEND="I $G(Y)'[U W !!,?50,""Total Patients: "",$J(COUNT,6) S RMEND=1 S:IOST[""P-"" RMPORPT=1"
 S FLDS="W $$RXDT^RMPORPD();C1;L10"
 S FLDS(1)=".01;C12;L22"
 S FLDS(2)="W $$SSN^RMPORPD();C36;L4"
 S FLDS(3)="W $$PITEM^RMPORPD();C41;L30"
 S FLDS(4)="W $$ACTDT^RMPORPD();C73;L8"
 D PRESORT,EN1^DIP
 I RMPORPT=0,$G(RMEND)  K DIR  S DIR(0)="E"  D ^DIR
 ;
EXIT ;
 K ^TMP("RMPO",$J)  N RMPRSITE,RMPR  D KILL^XUSCLEAN
 Q
 ;
ACTDT() ;*** ACTIVATION DATE
 S X=$P($G(^RMPR(665,D0,"RMPOA")),U,2)
 S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q X
 ;
CNT ;*** COUNT NAMES
 I WHO'=D0 S COUNT=COUNT+1
 S WHO=D0
 Q
 ;
 ;*** CONVERT DATE FROM FILEMAN FORMAT TO MM/DD/YYYY
DATE(FMD) ;
 Q $E(FMD,4,5)_"/"_$E(FMD,6,7)_"/"_($E(FMD,1,3)+1700)
 ;
PITEM() ;*** GET PRIMARY ITEM AND ACTIVATION DATE
 N PITM,E
 S (E,PITM)=0,X=""
 F  S PITM=$O(^RMPR(665,D0,"RMPOC",PITM)) Q:'PITM  D  Q:E
 . S PDT=^RMPR(665,D0,"RMPOC",PITM,0)
 . Q:$P(PDT,U,11)'="Y"
 . S X=$P(PDT,U),X=$P(^RMPR(661,X,0),U)
 . S X=$P($G(^PRC(441,X,0)),U,2)
 . S X=$E(X,1,30),E=1
 Q X
 ;
PRESORT ;*** SORT BY EXPIRATION DATE
 N D0,D2,DFN
 K ^TMP("RMPO",$J)
 S D2=0
 F  S D2=$O(^RMPR(665,"AHO",D2))  Q:'D2  S D0=""  D
 . F  S D0=$O(^RMPR(665,"AHO",D2,D0))  Q:D0=""  D
 . . K VAPA,VADM  S DFN=D0  D ^VADPT
 . . S ^TMP("RMPO",$J,$$RXDT(1),VADM(1),D0)=""
 Q
 ;
RPTHDR ;*** REPORT HEADER
 N RA S RA=RMPO("NAME"),PAGE=PAGE+1
 W RPTDT,?(40-($L(RA)/2)),RA,?68,"Page: "_PAGE
 W !?20,"Prescription Expiration Date",!,"Date Current",!,"Prescription"
 W !?1,"Expires",?11,"Name",?35,"SSN",?41,"Primary Item",?73,"Active"
 W !,"==========",?11,"=======================",?35,"====",?41,"==============================",?72,"========",!
 Q
 ;
 ;*** EXPIRATION DATE OF CURRENT RX
 ; MODE      Date format: 0 - MM/DD/YYYY or "N/A" (default)
 ;                        1 - YYYMMDD or "N/A"
RXDT(MODE) ;
 N J,D,Y,RA  S (D,RA,Y)=""
 F  S D=$O(^RMPR(665,D0,"RMPOB","B",D))  Q:D=""  D
 . S J=$O(^RMPR(665,D0,"RMPOB","B",D,""),-1)  Q:J=""  S:J>RA RA=J
 S:RA'="" Y=$P($G(^RMPR(665,D0,"RMPOB",RA,0)),U,3)
 S X=$S('Y:"N/A",'$G(MODE):$$DATE(Y),1:Y)
 Q X
 ;
SSN() ;*** SOCIAL SECURITY NUMBER
 K VA,VADM
 S DFN=D0  D ^VADPT
 S X=$P(VA("PID"),"-",3)
 Q X
