WVGETALL ;HCIOFO/FT,JR-AUTOLOAD FEMALE PATIENTS ;4/7/00  15:59
 ;;1.0;WOMEN'S HEALTH;**3,7,10**;Sep 30, 1998
 ;;  Original routine created by IHS/ANMC/MWR
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  AUTOMATICALLY LOADS WOMENS PATIENTS FROM THE MAIN PATIENT FILE,
 ;;  LIMITED BY AGE AND CURRENT COMMUNITY.
 ;
EN ;
 N WVPARM,WVEC
 S WVPARM=$G(^WV(790.02,+$G(DUZ(2)),0)),WVEC=""
 I WVPARM="" D CHECK^WVLOGO Q  ;no site parameter entry
 ; Stop if no default case manager
 I '$P(WVPARM,U,2) D NODCM^WVUTL9 Q
 D SETVARS^WVUTL5
 D INTRO  G:WVPOP EXIT
 D SELECT G:WVPOP EXIT
 D EC^WVGETAL1 G:WVPOP EXIT
 D DEVICE G:WVPOP EXIT
 D LOAD
 ;
EXIT ;EP
 D KILLALL^WVUTL8 K WVJSDT,WVJEDT,WVN,WVST
 Q
 ;
 ;
INTRO ;EP
 ;---> INTRODUCTORY SCREENS.
 S WVTITLE="AUTOLOAD PATIENTS"
 D TITLE^WVUTL5(WVTITLE)
 D TEXT1,DIRZ^WVUTL3
 Q:WVPOP
 D TITLE^WVUTL5(WVTITLE)
 D TEXT2,DIRZ^WVUTL3
 Q
 ;
SELECT ;EP
 ;---> SELECT AGE.
 D TITLE^WVUTL5(WVTITLE)
 ;---> SELECT AGE.
 K DIR
 W !?5,"Select the age below which patients should NOT be added:"
 S DIR("A")="     Enter AGE: ",DIR("B")=19
 S DIR(0)="NOA^10:99" D HELP1
 D ^DIR K DIR
 I Y=-1!($D(DIRUT)) S WVPOP=1 Q
 S WVAGE=+Y
 W !!?5,"Define Active Patient for Patient file download."
 W !?5,"If the patient has had no activity (visits or admissions) between"
 W !?5,"the start and end dates you enter here, she will not be included"
 W !?5,"in this Patient file download.",!
STD S DIR(0)="DAO^::E",DIR("A")="     Start Date of Patient Activity to Include: "
 S Y=DT-30000,Y=$$DATECHK^WVEXPTRA(Y)
 D DD^%DT S DIR("B")=Y
 S DIR("?",1)="     If the patient has not had a Visit or Admission after this start date,"
 S DIR("?",2)="     they will not be included in the auto-load."
 S DIR("?")="     This date can be up to 3 years prior to todays date."
 D ^DIR K DIR I Y'>0  W !!!! K WVJRDT S WVPOP=1 Q
 S WVJSDT=Y
K S DIR(0)="DAO^::E",DIR("A")="     End Date of Patient Activity to Include: "
 S DIR("?")="   "
 S DIR("?",1)="     If the patient has not had a Visit or Admission before this date,"
 S DIR("?",2)="     they will not be included in the auto-load."
 S DIR("?",3)="     This date may be up to 3 years prior to todays date, but must be"
 S DIR("?",4)="     after the start date."
 S Y=DT D DD^%DT S DIR("B")=Y
 D ^DIR K DIR I Y'>0  W !!!! K WVJSDT S WVPOP=1 Q
 I Y<WVJSDT W !!!,"     END DATE MUST BE AFTER START DATE",!!! K WVJSDT G STD
 S WVJEDT=$P(Y,".",1)_".9999"
 Q
 ;
DEVICE ;EP
 ;---> GET DEVICE AND POSSIBLY QUEUE TO TASKMAN.
 S ZTRTN="LOAD^WVGETALL"
 S ZTSAVE("WVAGE")="",ZTSAVE("WVJSDT")="",ZTSAVE("WVJEDT")=""
 S ZTSAVE("WVEC(")=""
 D ZIS^WVUTL2(.WVPOP,1)
 Q
 ;
LOAD ;EP
 ;---> AUTOLOAD OF PATIENTS
 N WVCOUNT,WVERROR,N,X,Y D SETVARS^WVUTL5
 D TOPHEAD^WVUTL7 S WVCONF=1
 S WVTITLE="* AUTOLOAD OF WOMEN PATIENTS *"
 D CENTERT^WVUTL5(.WVTITLE)
 U IO
 W:$Y>0 @IOF D HEADER7^WVUTL7
 S (WVCOUNT,N)=0
 S WVN=0 F  S WVN=$O(^DPT("ASX","F",WVN)) Q:'WVN  Q:WVPOP  D
 .S Y=^DPT(WVN,0)
 .;---> QUIT IF NOT FEMALE.
 .Q:$P(Y,U,2)'="F"
 .;---> QUIT IF DECEASED OR LESS THAN WVAGE.
 .Q:+$$AGE^WVUTL1(WVN)<WVAGE
 .Q:$D(^WV(790,WVN,0))
 .; Quit if patient not a veteran or doesn't have selected eligibility
 .; code
 .Q:'$$VECCHK^WVGETAL1(WVN)
 .;Q:$$GET1^DIQ(2,WVN,1901,"I")'="Y"
 .;Quit if not active patient
 .Q:$$HOS(WVN)<1
 .I $Y+5>IOSL D:WVCRT DIRZ^WVUTL3 Q:WVPOP  D HEADER7^WVUTL7
 .W !?3,$$NAME^WVUTL1(WVN),?30,$$SSN^WVUTL1(WVN)
 .W ?45,$$SLDT2^WVUTL5($$DOB^WVUTL1(WVN))
 .D AUTOADD^WVPATE(WVN,DUZ(2),.WVERROR)
 .I WVERROR<0 W ?60,"FAILED" Q
 .S WVCOUNT=WVCOUNT+1 W ?60,"ADDED" ;,?70,WVN
 .W !?3,"Age: "_$$AGE^WVUTL9(WVN)_" / Veteran: "_$$VET^WVUTL1A(WVN)_" / Elig Code: "_$P($$ELIG^WVUTL9(WVN),U,2),!
 W !!?5,"TOTAL: ",WVCOUNT," PATIENT",$S(WVCOUNT=1:"",1:"S")
 W " ADDED TO THE WOMEN'S HEALTH DATABASE.",!
 I WVCRT&('$D(IO("S"))) D DIRZ^WVUTL3 W @IOF
 K TEST1,TEST2 D ^%ZISC
 Q
 ;
 ;
TEXT1 ;EP
 ;;This utility will examine the VISTA Patient file (#2) for ALL
 ;;WOMEN VETERANS or WOMEN patients with an ELIGIBILITY CODE you
 ;;select over a given age who were seen in the date range selected,
 ;;and add them to the Women's Health Database.
 ;;
 ;;You will be asked to select a cutoff age (e.g., 40 and over),
 ;;Start and End Activity dates and Eligibility Code(s).
 ;;Patients not having a visit or admission between these dates
 ;;will not be added to the file.  These dates can be no more
 ;;than 3 years prior to today's date.
 ;;
 ;;Women already in the Women's Health Database will not be added twice.
 ;;Women who are deceased will not be added.  Women added to the Women's
 ;;Health Database will be given Breast and Cervical Treatment Needs of
 ;;"Undetermined", with no due dates.
 ;;
 ;;This utility may be run at any time, as often as desired.  It may be
 ;;useful to run it on a monthly basis in order to pick up new women who
 ;;are added to the Patient Database.
 S WVTAB=5,WVLINL="TEXT1" D PRINTX
 Q
 ;
 ;
TEXT2 ;EP
 ;;Before the program begins, you will be prompted for a "DEVICE:".
 ;;The name, social security number, and date of birth of each
 ;;patient added to the Women's Health Database will be displayed
 ;;on the DEVICE.
 ;;This DEVICE may be a printer, or you may enter "HOME" to have the
 ;;information simply display on your screen.
 ;;
 ;;If the DEVICE you select is a printer, it may be preferable
 ;;to "queue" the job, in order to free up your terminal.
 ;;See your computer sitemanager for assistance with queuing jobs.
 ;;
 ;;WARNING: The first time this utility is run, it may add several
 ;;thousand patients to the Women's Health Database.  It may take
 ;;several minutes or even hours to run, depending on the size of the
 ;;database and speed of the computer.  Subsequent runs should be much
 ;;quicker.
 ;;
 ;;You may type "^" at anytime to quit before the program begins.
 S WVTAB=5,WVLINL="TEXT2" D PRINTX
 Q
 ;
HELP1 ;EP
 ;;Enter a two-digit number that will be the lowest age of patients
 ;;added to the Women's Health Database.  For example, if you enter 15,
 ;;all women age 15 and older will be included, 14 and under will not.
 S WVTAB=5,WVLINL="HELP1" D HELPTX
 Q
 ;
 ;
PRINTX ;EP
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  W !,T,$P(X,";;",2)
 Q
 ;
HELPTX ;EP
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  S DIR("?",I)=T_$P(X,";;",2)
 S DIR("?")=DIR("?",I-1) K DIR("?",I-1)
 Q
HOS(WVN) ;Comes here to determine if visit/adm. is current
 ;WVN=DFN, WVJSDT=Selected earliest date for consideration.
 S WVST="ADFN"_WVN
 S TEST1=$O(^DGPM(WVST,WVJSDT)) I TEST1>WVJSDT I TEST1<WVJEDT Q 1
 S TEST2=$O(^SCE("ADFN",WVN,WVJSDT)) I TEST2>WVJSDT I TEST2<WVJEDT Q 1
 Q 0
