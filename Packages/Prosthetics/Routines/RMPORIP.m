RMPORIP ;(NG)/DG/CAP/HINES CIOFO/HNC -INACTIVE HOME OXYGEN PATIENTS ; 5/18/00 9:35am
 ;;3.0;PROSTHETICS;**29,49,179**;Feb 09, 1996;Build 7
 ;
 ;RMPR*3.0*178 Check for deceased patients. Add to report by
 ;             displaying asterisk (*) if patient deceased.
 ;
SITE ;   Initialize site variables
 D HOSITE^RMPOUTL0  Q:'$D(RMPOXITE)
 S RMPODCNT=0
 ;
FROM ;   Ask starting date/oldest inactive date
 K DIR  S DIR(0)="D^^^P"
 S DIR("A")="Start at INACTIVATION DATE"
 S DIR("B")="T-180"
 S DIR("?")="Enter the earliest INACTIVATION DATE to report on."
 D ^DIR  G:$D(DTOUT)!$D(DUOUT) EXIT
 W "  ("_Y(0)_")"
 S FRMDT=Y,FDT=Y(0)
 ;
TO ;   Ask ending/newest inactivation date
 K DIR  S DIR(0)="D^^^P"
 S DIR("A")="Ending INACTIVATION DATE"
 S DIR("B")="T"
 S DIR("?")="Enter the latest INACTIVATION DATE to report on."
 D ^DIR  G EXIT:$D(DTOUT),FROM:$D(DUOUT)
 W "  ("_Y(0)_")",!
 ;
 I Y<FRMDT  D  G TO
 . W !,"Ending date must NOT be earlier than "_FDT_".",!
 S TODT=Y,TDT=Y(0)
 ;
LI ;   List the sought patients
 K DA,DASH  S (COUNT,PAGE,RMEND,RMPORPT,L)=0
 S $P(DASH,"-",79)=""
 D NOW^%DTC  S Y=%  X ^DD("DD")
 S RPTDT=$P(Y,"@",1)_"  "_$P($P(Y,"@",2),":",1,2)
 ;
 S DIC="^RMPR(665,",BY="[RMPO-RPT-HOINACTIVE]"
 S FR=","_$$DATE(FRMDT),TO=","_$$DATE(TODT)
 S DIS(0)="I $P($G(^RMPR(665,D0,""RMPOA"")),U,7)=RMPOXITE"
 S DHD="W ?0 D RPTHDR^RMPORIP"
 S DIOEND="I $G(Y)'[U D DIOEND^RMPORIP S RMEND=1 S:IOST[""P-"" RMPORPT=1"
 S FLDS=".01;C1;L19;""PATIENT"",D SSN^RMPORIP W X;C21;R5;""SSN"",D SDT^RMPORIP W X;C28;L10;""START"""
 S FLDS(2)="D EDT^RMPORIP W X;C40;L10;""INACTIVE"",D IREA^RMPORIP W X;C52;L29;""REASON"""
 D EN1^DIP
 I RMPORPT=0,$G(RMEND)  K DIR  S DIR(0)="E"  D ^DIR
 ;
EXIT K ^TMP($J)  N RMPR,RMPRSITE  D KILL^XUSCLEAN
 Q
 ;
 ;*** CONVERT DATE FROM FILEMAN FORMAT TO MM/DD/YYYY
DATE(FMD) ;
 Q $E(FMD,4,5)_"/"_$E(FMD,6,7)_"/"_($E(FMD,1,3)+1700)
 ;
EDT ;*** INACTIVATION DATE
 S X=$P($G(^RMPR(665,D0,"RMPOA")),U,3)  S:X X=$$DATE(X)
 Q
 ;
IREA ;*** INACTIVE REASON
 I $D(^RMPR(665,D0,"RMPOA"))  D
 . N RMMSG  S X=$P(^RMPR(665,D0,"RMPOA"),U,4)
 . S X=$$EXTERNAL^DILFD(665,19.6,"",X,"RMMSG")
 E  S X=""
 Q
 ;
RPTHDR ;*** REPORT HEADER
 N RA S RA=RMPO("NAME"),PAGE=PAGE+1
 W RPTDT,?(40-($L(RA)/2)),RA,?68,"Page: "_PAGE
 W !?5,"Inactive Home Oxygen Patients",?50,"'*' denotes deceased patient",!   ;RMPR*3.0*179
 W !?13,"Date Range: ",FDT," to ",TDT,!
 W !,"Patient",?21,"SSN",?28,"Active",?40,"Inactive",?51,"Inactive Reason"
 W !,"===================",?21,"====",?27,"==========",?39,"==========  ========================",!
 Q
 ;
SDT ;*** GET START DATE (USE INITIAL OXYGEN RX DATE)
 S X=$P($G(^RMPR(665,D0,"RMPOA")),U,2)  S:X X=$$DATE(X)
 Q
 ;
SSN ;*** GET SSN
 K VA,VADM S RMPOEXP=" ",RMPODCNT=0 I +$G(^DPT(D0,.35)) S RMPOEXP="*"   ;RMPR*3.0*179 Flag a deceased patient by attaching an '*' to SSN. ^DPT(D0,.35) direct read supported by ICR #10035
 S DFN=D0  D ^VADPT
 S X=$P(VA("PID"),"-",3)
 I X'="" S COUNT=COUNT+1,X=RMPOEXP_X S:RMPOEXP'=" " RMPODCNT=RMPODCNT+1   ;RMPR*3.0*179
 Q
DIOEND ;TOTAL PRINT
 S COUNT=$E("      ",1,(6-$L(COUNT)))_COUNT
 W !!,?47,"Total Patients: ",COUNT
 S RMPODCNT=$E("      ",1,(6-$L(RMPODCNT)))_RMPODCNT         ;RMPR*3.0*179
 W !,?38,"Total Deceased Patients: ",RMPODCNT               ;RMPR*3.0*179
 Q
