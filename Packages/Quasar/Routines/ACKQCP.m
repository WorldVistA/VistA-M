ACKQCP ;AUG/JLTP BIR/PTD HCIOFO/BH-QUASAR/C&P Interface ; 06/06/99 11:51
 ;;3.0;QUASAR;**1,2**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;;DBIA 1473 EN1^DVBCTRN & EN2^DVBCTRN
 ;
ADEQ ;  Adequate a C&P Exam
 N ACKDUZ
 S ACKDUZ=$$PROVCHK^ACKQASU4(DUZ) S:ACKDUZ="" ACKDUZ=" "
 I $O(^ACK(509850.3,ACKDUZ,""))="" W !,"You are not listed in the A&SP STAFF file (#509850.3).",!,"Access denied." G ADEX
 S X=$$STACT^ACKQUTL(ACKDUZ) I (X=-2)!(X=-6) W !,"Only clinicians may adequate C&P exams!" G ADEX
 I X W !,"The A&SP STAFF file (#509850.3) indicates that you have been inactivated.",!,"Access denied." G ADEX
 ;
OPTN ;  Introduce option.
 W @IOF
 W !,"This option allows you to adequate C&P exams which currently have open"
 W !,"requests in the AMIE software. An exam must be completed and signed off prior"
 W !,"to adequation. You can use the Edit an Existing Visit option to review or edit"
 W !,"an exam before adequating.",!
 ;
 D ^ACKQCPL G:$D(DIRUT) PRINT
 D PULL^ACKQCP1,SHOW
 ;
 F I=1:1 S ACKTX=$P($T(ADEQWN+I),";;",2) Q:ACKTX=""  W !,ACKTX
 ;
 S ACKMODE=2 D SIG^ACKQCP I '$D(ACKSIG) D UNLOCK G ADEX
 ;
 N ACKQVD,ACKQQPV,ACKQQPV1 S ACKQQPV1=""
 I $$EN1^DVBCTRN(DFN,"AUDIO",ACKSFT)>0 D
 . S DIE="^ACK(509850.6,",DA=ACKD0
 . S DR="4.19////"_ACKSIG_";4.2////"_DT_";4.25////"_ACKTITL
 . D ^DIE K ACKC D PULL^ACKQCP1
 ;
 S ACKQVD=$$GET1^DIQ(509850.6,ACKD0_",",.01,"I")
 S ACKQQPV=$$GET1^DIQ(509850.6,ACKD0,6,"I")
 I ACKQQPV'="" S ACKQQPV1=$$CONVERT1^ACKQUTL4(ACKQQPV)
 I ACKQQPV1'="" S ACKST=$$EN2^DVBCTRN("ACKC","ACKQ",ACKSFT,ACKQQPV1,ACKQVD)
 ;
 I ACKQQPV1="" S ACKST=$$EN2^DVBCTRN("ACKC","ACKQ",ACKSFT,"",ACKQVD)
 ;
 I ACKST>0 D
 . N ACKQARR
 . S ACKQARR(509850.6,ACKD0_",",.09)="3" D FILE^DIE("","ACKQARR","")
 . I $D(^ACK(509850.6,"AWAIT",2,ACKD0)) K ^ACK(509850.6,"AWAIT",2,ACKD0)
 . K ACKQARR
 ;
 I ACKST<0 W !!,$C(7),$P(ACKST,U,2),!,"Results NOT transferred!!" S DIE="^ACK(509850.6,",DA=ACKD0,DR="4.19///@;4.2///@;4.25///@" D ^DIE K DIE D UNLOCK G ADEX
 ;
 W !!,"Final results transferred to AMIE C&P package." D UNLOCK
 ;
PRINT I $D(ACKD0) S DIR(0)="Y",DIR("A")="Print a file copy NOW",DIR("B")="YES",DIR("?")="Answer YES to print this C&P report or answer NO to exit." W ! D ^DIR K DIR G:Y'=1 ADEX I Y=1 D DEV G ADEX
 I '$D(ACKD0) D
 .W !!,"You can print any C&P report at this time.  Reports can be printed",!,"for exams requested through the AMIE software.  Reports can also be"
 .W !,"printed for exams NOT requested by AMIE (e.g., the C&P fields were",!,"""forced"" by entering ""^C AND P"" during data input)."
 I '$D(ACKD0) S DIR(0)="Y",DIR("A")="Print a selected C&P report NOW",DIR("B")="NO",DIR("?")="Answer YES to print any C&P report or answer NO to exit." W ! D ^DIR K DIR I Y=1 D CP^ACKQCP1 I $D(ACKD0) D PULL^ACKQCP1,DEV
 ;
ADEX ;
 K ACK0,ACK2,ACKC,ACKCNT,ACKD0,ACKFLD,ACKI,ACKQHLP,ACKPG,ACKQRAW,ACKST,ACKSFT,ACKSIG,ACKSUPER,ACKTITL,ACKTX,DA,DFN,DIC,DIE,DIRUT,DR,DTOUT,DUOUT,I,VA,VADM,VAERR,X,X1,Y
 Q
 ;
SIG ;  Get Electronic Signature
 ;  Enter with ACKMODE=1 to sign off or 2 to adequate an exam.
 ;
 N ACKTT
 S ACKMODE(1)="sign off",ACKMODE(2)="adequate"
 S (ACKSIG,ACKTITL)="",ACK20=$S($D(^VA(200,DUZ,20)):^(20),1:""),ACK20(2)=$P(ACK20,U,2),ACK20(3)=$P(ACK20,U,3),ACK20(4)=$P(ACK20,U,4)
 I ACK20(4)="" W !,$C(7),"YOU DON'T HAVE AN ELECTRONIC SIGNATURE CODE!" G NOSIG
 W !!,"Are you ready to "_ACKMODE(ACKMODE)_" this exam" S %=2 D YN^DICN I '% S ACKQHLP=6 D ^ACKQHLP G SIG
 G:%'=1 NOSIG S ACKI=0 D GETCODE Q
 ;
GETCODE X ^%ZOSF("EOFF") R !,"SIGNATURE CODE: ",X:DTIME  S:'$T X=U X ^%ZOSF("EON") I U[X G NOSIG
 D HASH^XUSHSHP I X'=ACK20(4) W $C(7) S ACKI=ACKI+1 G:ACKI<3 GETCODE W !,"TOO MANY TRIES!" G NOSIG
 ;
 ;  If they get past here it's good
 ;
 W !,"Ok..." S ACKSIG=ACK20(2),ACKTITL=ACK20(3) G SIGEX
NOSIG K ACKSIG,ACKTITL
SIGEX K %,%Y,ACK20,ACKI,ACKMODE,Y Q
 ;
ADEQWN ;;
 ;; 
 ;;     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
 ;;     *                      WARNING!                     *
 ;;     * Entering your electronic signature to adequate    *
 ;;     * this exam will cause all exam results to be       *
 ;;     * transferred to the AMIE C&P package and the exam  *
 ;;     * will be tagged CLOSED.  The results will then     *
 ;;     * be available to the regional office.              *
 ;;     * Do not proceed unless the exam is complete and    *
 ;;     * you are satisfied with the accuracy of the        *
 ;;     * information!                                      *
 ;;     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
 ;; 
 ;;
SHOW ;
 D HOME^%ZIS,SHO1
 W !! S DIR(0)="SBM^P:Print;C:Continue",DIR("?")="Enter P to print the C&P exam or C to continue with adequation." D ^DIR K DIR Q:Y'="P"
DEV W !!,"The right margin for this report is 80.",!,"You can queue it to run at a later time.",!
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED." Q
 I $D(IO("Q")) K IO("Q") S ZTRTN="SHO1^ACKQCP",ZTDESC="QUASAR - PRINT C&P EXAM",ZTSAVE("ACK*")="",ZTSAVE("DFN")="",ZTSAVE("VADM(2)")="" D ^%ZTLOAD,^%ZISC Q
 ;
SHO1 U IO S ACKPG=0
 D HDR I '$O(ACKC(0)) W !,"No C&P exam data found." Q
 S ACKC=0 F  S ACKC=$O(ACKC(ACKC)) Q:'ACKC!($D(DUOUT))!($D(DTOUT))  D
 .I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DTOUT)!($D(DUOUT))  D HDR
 .W !,ACKC(ACKC)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
HDR ;  Print report heading.
 S ACKPG=ACKPG+1
 W @IOF,"Printed: "_$$NUMDT^ACKQUTL(DT),?(IOM-8),"Page: ",ACKPG
 F X="Audiology & Speech Pathology","C&P Exam for "_$P(^DPT(DFN,0),U)_" ("_$P(VADM(2),"^",2)_")" W ! D CNTR^ACKQUTL(X)
 S X="",$P(X,"-",IOM)="-" W !,X
 Q
 ;
UNLOCK ;  Unlocks locked visit record
 L -^ACK(509850.6,ACKD0)
 Q
 ;
