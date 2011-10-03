PSUPR0 ;BIR/PDW -  PROCUREMENT EXTRACT ENTRY ROUTINE ;25 AUG 1998
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;DBIA's
 ; Reference to file 4.3 supported by DBIA 10091
 ; Reference to file 4   supported by DBIA 10090
 ;
EN ;EP from PSUCP
 ;
 ; pull variables from ^XTMP
 ; PSUJOB must exist and must be the job number used to store the data desired for this session.
 I '$D(PSUJOB) S PSUJOB=$J
 S PSUVARS="PSUSDT,PSUEDT,PSUMON,PSUDUZ,PSUMASF,PSUPBMG,PSUSMRY,ZTIO,PSUSNDR,PSUOPTS"
 F I=1:1:$L(PSUVARS,",") S @$P(PSUVARS,",",I)=$P(^XTMP("PSU_"_PSUJOB,1),U,I)
PULLQ ;Q
 S PSUPRJOB=PSUJOB
 S PSUPRSUB="PSUPR_"_PSUPRJOB
 ;     Setup ^XTMP
 S X1=DT,X2=6 D C^%DTC
 K ^XTMP(PSUPRSUB)
 S ^XTMP(PSUPRSUB,0)=X_U_DT_"^  PBM Extract - Procurement Module "
 ;
 ;     Store Important variables
 K X
 S X="PSUSDT,PSUEDT,PSUMON,PSUDUZ,PSUMASF,PSUPBMG,PSUSMRY,PSUSNDR,PSUPRSUB,PSUJOB,PSURTN,PSUOPTN"
 F I=1:1 S Y=$P(X,",",I) Q:Y=""  I $D(@Y) S X(Y)=@Y
 M ^XTMP(PSUPRSUB,"SAVE")=X
 K X
 ;    Process the Procurement Files
 ; Code for CoreFLS  *  NOTE: This will be commented out as of 7/1/04
 ;until such time as CoreFLS code is released.
 ;S X="PSAFLS" X ^%ZOSF("TEST")
 ;I $T D
 ;.S PSUPRSUB="PSUPR_"_$J
 ;.S PSUFLSFG=""    ;FLAG TO SIGNAL COREFLS IN EFFECT
 ;.D EN^PSUPR2
 ;.D EN^PSUPR3
 ;.K PSUFLSFG
 ;I '$T D          ;CoreFLS code. Commented out. When CoreFLS code is
 ;released put the next 3 lines inside a dot structure.
 D EN^PSUPR1 ; file 442
 D EN^PSUPR2 ; file 58.811
 D EN^PSUPR3 ; file 58.81
 K PSUMSG
 D EN^PSUPR4(.PSUMSG) ; detailed mail message to Hines
 D EN^PSUPR5    ;Summary Mail Routines
 ;
 ;   return counters to master routine
 S PSUSUB="PSU_"_PSUJOB
 I $D(^XTMP(PSUSUB)),PSUDUZ,PSUPBMG M ^XTMP(PSUSUB,"CONFIRM")=PSUMSG
 ;D EN^PSUPR5 ;  Summary Mail Routines
 Q
PRINT ;EP Tasking Entry Point for PRINT REPORT
 D EN^PSUPR6
 Q
EXIT ;EP Tasking Entry Point for Cleaning out XTMP  and Variables
 ;    Restore Important Variables
 K X
 M X=^XTMP(PSUPRSUB,"SAVE")
 K ^XTMP(PSUPRSUB)
 D VARKILL^PSUTL
 ;     Restore Important Variables CONTINUED
 S Y="" F  S Y=$O(X(Y)) Q:Y=""  S @Y=X(Y)
 K X
 Q
 ;
CLEAR ;EP clear ^XTMP of PSUPR nodes
 S X="PSUPR"
 F  S X=$O(^XTMP(X)) Q:X=""  Q:$E(X,1,5)'="PSUPR"  W !,X K ^XTMP(X)
 Q
MANUAL ;EP   Manual entry point for Running Procurement Module to
 ; exercise detailed message, summary messages, & Reports
 ; Some startup code borrowed from PSUCP for dates
 W !,"Mail messages are sent to the user only at this time",!
 S PSUMON=$E(DT,1,5),(PSUSMRY,PSUMASF,PSUPBMG)=1,PSUDUZ=DUZ
 S X=$P($G(^XMB(1,1,"XUS")),U,17),PSUSNDR=+$P(^DIC(4,X,99),U)
 K %DT
 S %DT="AEX",%DT(0)="-NOW",%DT("A")="STARTING Procurement Extract Date or ""^"" to quit : " D ^%DT
 I X["^" Q
 I 'Y Q
 S PSUSDT=+Y
 K %DT W !
 S %DT="AEX",%DT(0)=PSUSDT,%DT("A")="ENDING Procurement Extract Date or ""^"" to restart: " D ^%DT
 I X["^" G MANUAL
 I 'Y G MANUAL
 S PSUEDT=+Y
 W !
 S Y=PSUSDT D DD^%DT W !,"Starting Procurement Date",?30,Y
 S Y=PSUEDT D DD^%DT W !,"Ending Procurement Date:",?30,Y
 K DIR W !
 S DIR(0)="Y",DIR("A")="Correct ? ",DIR("B")="YES" D ^DIR
 I 'Y G MANUAL
 K DIR W !
 W !,"You can not queue to your terminal",!
 W !,"You can queue to a host file",!
 S DIR(0)="Y",DIR("A")="Do yo want reports printed ? ",DIR("B")="YES" D ^DIR
 K DIR W !
 S PSURP=+Y
 S PSURC="COMPUTE^PSUPR0"
 I PSURP S PSURP="PRINT^PSUPR0" K PSUIOP
 E  K PSURP S PSUIOP="" ; MAIL MESSAGES ONLY
 S PSURX="EXIT^PSUPR0"
 S PSUNS="PSUPR*,PSUSDT,PSUEDT,PSU*"
 D EN^PSUDBQUE
 Q
