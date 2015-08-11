HBHCFILE ; LR VAMC(IRMS)/MJT-HBHC populates ^HBHC(632) visit file, & ^HBHC(634), file for transmitting to Austin, calls ^HBHCAPPT, ^HBHCXMC, ^HBHCXMA, ^HBHCXMV, ^HBHCXMD, & HBHCXMM ; Nov 1999
 ;;1.0;HOSPITAL BASED HOME CARE;**2,5,6,8,9,10,16,21,24,27**;NOV 01, 1993;Build 2
 ;
 ;
 ; Reference/ICR
 ; PATIENT FILE/10035
 ; REGISTRATION/3744
 ;
 ;
 I $P(^HBHC(631.9,1,0),U,5)="" W !!,"***  NOTICE:  Hospital Number is missing from System Parameter file (#631.9).",!,"Transmission file building CANNOT proceed without this information.  Contact"
 I $P(^HBHC(631.9,1,0),U,5)="" W !,"IRM to enter this information using FileMan.",! H 10 Q
 L +^HBHC(634.5,0):0 I '$T W $C(7),!!,"Another user has the pseudo SSN file locked." H 3 G EXIT
 I ($D(^HBHC(634.1,"B")))!($D(^HBHC(634.2,"B")))!($D(^HBHC(634.3,"B")))!($D(^HBHC(634.5,"B")))!($D(^HBHC(634.7,"B"))) W $C(7),!!,"Records containing errors exist and must be corrected before transmit",!,"file can be created or updated.",!! H 3 Q
EN ; Entry point
 I $P(^HBHC(631.9,1,0),U,8)]"" W $C(7),!,"File Update in progress.  Please try again later." H 3 Q
 W !!,"This option builds the file for transmission to Austin.  Do you wish to",!,"continue" S %=2 D YN^DICN
 I %=0 W !!,"A 'Yes' response will add records to the file.  A 'No' response will return",!,"to the menu without updating the file." G EN
 G:%'=1 EXIT
MONTH ; Calculate default month value & last date to be included for transmission
 S X="T" D ^%DT S X1=$P(Y,"."),X2=-28 D C^%DTC S DIR("B")=+$E(X,4,5)
 S DIR(0)="SX^1:January;2:February;3:March;4:April;5:May;6:June;7:July;8:August;9:September;10:October;11:November;12:December;"
 S DIR("A")="Month for which data is to be transmitted"
 S DIR("?")="Month entered controls the ending date for data transmitted to Austin.  (e.g.  An August 5 transmission with July selected as month, will include data thru July 31.)"
 D ^DIR Q:$D(DIRUT)  S HBHCDIR=Y
 S X="T" D ^%DT S HBHCYEAR=$S(HBHCDIR>(+$E(Y,4,5)):($E(Y,1,3))-1,1:$E(Y,1,3))
 S Y=1700+HBHCYEAR,HBHCLEAP=$S(Y#400=0:1,Y#4=0&'(Y#100=0):1,1:0)
 S HBHCLSDT=HBHCYEAR_$S(HBHCDIR<10:"0"_HBHCDIR,1:HBHCDIR)_$S(((HBHCDIR=2)&('HBHCLEAP)):28,((HBHCDIR=2)&(HBHCLEAP)):29,"^1^3^5^7^8^10^12^"[HBHCDIR:31,1:30)_.9999
 S Y=$P(HBHCLSDT,".") D DD^%DT S HBHCCKDT=Y
NUMBER ; Edit Number of Visit Days to Scan system parameter
 W !
 K DIR S DIR(0)="631.9,3",DIR("A")="Number of Visit Days to Scan",DIR("B")=$P($G(^HBHC(631.9,1,0)),U,4)
 S DIR("?",1)="Enter number of days to be included when the system creates records in the",DIR("?",2)="HBHC Visit File from the appointment data entered via the Appointment",DIR("?")="Management  [HBHC APPOINTMENT]  option."
 D ^DIR
 G:($D(DTOUT))!($D(DUOUT)) EXIT
 S HBHCDIR=Y
 I (HBHCDIR'=DIR("B"))&(HBHCDIR?1.3N) K DIE S HBHCDAYS=Y,DIE="^HBHC(631.9,",DA=1,DR="3///^S X=HBHCDAYS" D ^DIE
 ; Check to ensure Number of Visit Days to Scan date < HBHCLSDT
 K %DT S X="T"-($S(HBHCDIR'=DIR("B"):HBHCDIR,1:DIR("B"))) D ^%DT
 I (Y_".9999")'<HBHCLSDT D DD^%DT W $C(7),!!,"Date Range is invalid.  Transmit Month Ending Date of:  ",HBHCCKDT,"  must",!,"be closer to today than the Number of Days to Scan Date:  ",Y,".",! G NUMBER
CLEANUP ; Cleanup ^HBHC(634) if new transmit cycle => all records flagged as transmitted
 I ('$D(^HBHC(631,"AE","F")))&('$D(^HBHC(631,"AF","F")))&('$D(^HBHC(632,"AC","F")))&('$D(^HBHC(633.2,"AC","F"))) K ^HBHC(634) S ^HBHC(634,0)="HBHC TRANSMIT^634"
 ; Flag used to control killing HBHCDAT, HBHCDTE, & HBHCNOW in HBHCAPPT
 S HBHCFLAG=1
QUEUE ; Queue
 S ZTIO="",ZTDTH=$H,ZTRTN="PLOOP^HBHCFILE",ZTSAVE("HBHC*")="",ZTDESC="HBPC Build Transmit File" D ^%ZTLOAD
 W $C(7),!!,"Build Transmit File processing has been queued.  Task number:  ",ZTSK H 3
 G EXIT
PLOOP ; Loop thru ^HBHC(632,"C" Appointment Date cross-ref & flag as 'P' (Record Prior to Package Startup Date) in Form 4 Transmit Status field if date < Package Startup Date
 S X1=$P(^HBHC(631.9,1,0),U,3),X2=-1 D C^%DTC S HBHCSTDT=X_.9999
 S HBHCAPDT=0,DIE="^HBHC(632,",DR="7///P"
 F  S HBHCAPDT=$O(^HBHC(632,"C",HBHCAPDT)) Q:(HBHCAPDT'>0)!(HBHCAPDT>HBHCSTDT)  S DA="" F  S DA=$O(^HBHC(632,"C",HBHCAPDT,DA)) Q:DA'>0  D:'$D(^HBHC(632,"AC","P",DA)) ^DIE
POP ; Populate ^HBHC(634) or ^HBHC(634.1/634.2/634.3/634.5/634.7 Error files
 D ^HBHCAPPT,^HBHCXMC,^HBHCXMA,^HBHCXMV,^HBHCXMD,TPATCHK
 ; MFH Sanction Date must exist for MFH data to be included in Austin transmit
 D:$P(^HBHC(631.9,1,0),U,9)]"" ^HBHCXMM
 ; Cleanup potential scrogged HBHC(632,"AC" cross-ref on Form 4 Transmit Status field (#7) as failsafe
 K ^HBHC(632,"AC") S DIK="^HBHC(632,",DIK(1)=7 D ENALL^DIK
 ; Send mail message
 D:('$D(^HBHC(634.1,"B")))&('$D(^HBHC(634.2,"B")))&('$D(^HBHC(634.3,"B")))&('$D(^HBHC(634.5,"B")))&('$D(^HBHC(634.7,"B"))) MAIL
EXIT ; Exit module
 L -^HBHC(634.5,0)
 K DA,DIE,DIR,DIRUT,DR,DTOUT,DUOUT,HBHCAPDT,HBHCCKDT,HBHCDAT,HBHCDAYS,HBHCDTE,HBHCDIR,HBHCFLAG,HBHCLEAP,HBHCLSDT,HBHCNOW,HBHCSTDT,HBHCYEAR,%,TMP,X,X1,X2,Y
 Q
TPATCHK ; HBH*1.0*27 ; Identify and remove test patients from the HBHC TRANSMIT file
 N HBHCSSN,HBHCTRDAT,HBHCDFN,HBHCTRIEN
 S HBHCTRDAT=0 F  S HBHCTRDAT=$O(^HBHC(634,"B",HBHCTRDAT)) Q:HBHCTRDAT'>0  D
 .S HBHCSSN=$E(HBHCTRDAT,9,17)
 .S HBHCDFN=$O(^DPT("SSN",HBHCSSN,0))
 .I $$TESTPAT^VADPT(HBHCDFN) D
 ..S HBHCTRIEN=$O(^HBHC(634,"B",HBHCTRDAT,0))
 ..N DIK,DA
 ..S DIK="^HBHC(634,",DA=HBHCTRIEN D ^DIK
 Q
MAIL ; Send completed mail message
 S TMP(1)=$P(HBHCDAT,"@")_" HBHC Build Transmit File is complete with no errors found.",TMP(2)="",TMP(3)="   Number of Visit Days to Scan system parameter:  "_$P(^HBHC(631.9,1,0),U,4),TMP(4)=""
 S Y=$P($P(HBHCDTE,U),"@") X ^DD("DD") S HBHCINFO=Y,Y=$P($P(HBHCDTE,U,2),"@") X ^DD("DD") S TMP(5)="   Date range:  "_$P(HBHCINFO,"@")_"  thru  "_$P(Y,"@"),TMP(6)=""
 D NOW^%DTC S Y=% X ^DD("DD")
 S TMP(7)="   Start time:  "_$P(HBHCDAT,"@",2)_"   End time:  "_$P(Y,"@",2)_"   Elapsed minutes:  "_($E(%_"000",9,10)-$E(HBHCNOW_"000",9,10)*60+$E(%_"00000",11,12)-$E(HBHCNOW_"00000",11,12)),TMP(8)=""
 S TMP(9)="*****   Reminder:  Please run Transmit File to Austin option.   *****"
 S XMDUZ="HBHC Build Transmit File Mail Group",XMSUB=$P(HBHCDAT,"@")_" HBHC Build Transmit File",XMY(DUZ)="",XMTEXT="TMP("
 D ^XMD
 Q
