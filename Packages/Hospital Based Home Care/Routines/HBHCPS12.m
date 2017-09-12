HBHCPS12 ; LR VAMC(IRMS)/MJT-HBHC POST initialization routine, re-create visits for FY98 in HBHC(632 file, cleanup corresponding files, send IRM message when complete ;9808
 ;;1.0;HOSPITAL BASED HOME CARE;**12**;NOV 01, 1993
 ; Modeles copied from HBHCFILE routine:  POP, EXIT1 (EXIT renamed EXIT1), MAIL
 S HBHCDUZ=DUZ
6314 ; Retain IENs w/Inactive Provider Number (field 6, file 631.4) in HBHC Provider
 ; Count number of provider numbers per provider, create local array
 S HBHCPRV=0 F  S HBHCPRV=$O(^HBHC(631.4,"C",HBHCPRV)) Q:HBHCPRV'>0  S HBHCIEN=0 F  S HBHCIEN=$O(^HBHC(631.4,"C",HBHCPRV,HBHCIEN)) Q:HBHCIEN'>0  D ARRAY
 ; Check to see whether provider has unique 'Active' provider number (HBHCFLAG = 1 if yes)
 S HBHCPRV=0 F  S HBHCPRV=$O(HBHC6314(HBHCPRV)) Q:HBHCPRV'>0  D LOOP2 K HBHC6314(HBHCPRV) S:HBHCFLAG=0 HBHC6314(HBHCPRV)=1,HBHC6314(HBHCPRV,HBHCLAST)=""
 ; Delete 'Active' & Unique provider number entries from local array, leaving local array of records to be processed (delete Inactive)
 S HBHCPRV=0 F  S HBHCPRV=$O(HBHC6314(HBHCPRV)) Q:HBHCPRV'>0  S HBHCIEN=0 F  S HBHCIEN=$O(HBHC6314(HBHCPRV,HBHCIEN)) Q:HBHCIEN'>0  S $P(^HBHC(631.4,HBHCIEN,0),U,7)="" K ^HBHC(631.4,"AC",1,HBHCIEN)
PARAM ; Retain/Set Number of Visit Days to Scan (field 3, file 631.9) System Parameter 
 S HBHCMJ=$P(^HBHC(631.9,1,0),U,4)
 S $P(^HBHC(631.9,1,0),U,4)=365
 ; Variable needed by HBHCFILE routine
 S HBHCLSDT=$S($E(DT,4,5)>9:2980930.9999,1:2980831.9999)
 ; Variable needed by HBHCAPPT routine
 S HBHCFLAG=1
 S ZTIO="",ZTDTH=$H,ZTRTN="DQ^HBHCPS12",ZTSAVE("HBHC*")="",ZTDESC="HBHC Patch 12 Post Install" D ^%ZTLOAD
 W $C(7),!!,"HBHC Patch 12 Post Install processing has been queued.  Task number:  ",ZTSK H 3
 G EXIT
DQ ; De-queue entry point
632 ; Delete FY98 entries from 632 (Visit) file
 S DIK="^HBHC(632,",HBHCDAT=2970930.9999999 F  S HBHCDAT=$O(^HBHC(632,"C",HBHCDAT)) Q:HBHCDAT'>0  S DA=0 F  S DA=$O(^HBHC(632,"C",HBHCDAT,DA)) Q:DA'>0  D ^DIK
634 ; Delete entries from 634 (Transmit) file
 K ^HBHC(634) S ^HBHC(634,0)="HBHC TRANSMIT^634"
6341 ; Delete entries from 634.1 (Admission Errors) file 
 K ^HBHC(634.1) S ^HBHC(634.1,0)="HBHC EVALUATION/ADMISSION ERROR(S)^634.1"
6342 ; Delete entries from 634.2 (Visit Errors) file 
 K ^HBHC(634.2) S ^HBHC(634.2,0)="HBHC VISIT ERROR(S)^634.2P"
6343 ; Delete entries from 634.3 (Discharge Errors) file 
 K ^HBHC(634.3) S ^HBHC(634.3,0)="HBHC DISCHARGE ERROR(S)^634.3"
6346 ; Delete FY98 entries from 634.6 (Transmit History) file
 S DIK="^HBHC(634.6,",HBHCDAT=2970930 F  S HBHCDAT=$O(^HBHC(634.6,"C",HBHCDAT)) Q:HBHCDAT'>0  S DA=0 F  S DA=$O(^HBHC(634.6,"C",HBHCDAT,DA)) Q:DA'>0  D ^DIK
CREATE ; Re-create visits for FY98 from Outpatient Encounter (409.68) file data, update Transmit (634) file &/or error files (634.1 thru 634.3)
POP ; Populate ^HBHC(634) or ^HBHC(634.1/634.2/634.3/634.5 Error files
 D ^HBHCAPPT,^HBHCXMC,^HBHCXMA,^HBHCXMV,^HBHCXMD
 ; Send mail message
 D:('$D(^HBHC(634.1,"B")))&('$D(^HBHC(634.2,"B")))&('$D(^HBHC(634.3,"B")))&('$D(^HBHC(634.5,"B"))) MAIL
EXIT1 ; Exit module
 L -^HBHC(634.5,0)
 K DA,DIE,DIR,DIRUT,DR,DTOUT,DUOUT,HBHCAPDT,HBHCCKDT,HBHCDAT,HBHCDAYS,HBHCDTE,HBHCDIR,HBHCFLAG,HBHCLEAP,HBHCLSDT,HBHCNOW,HBHCSTDT,HBHCYEAR,%,TMP,X,X1,X2,Y
 ; Reset Inactive Provider Number (field 6, file 631.4) in HBHC Provider
 S HBHCPRV=0 F  S HBHCPRV=$O(HBHC6314(HBHCPRV)) Q:HBHCPRV'>0  S HBHCIEN=0 F  S HBHCIEN=$O(HBHC6314(HBHCPRV,HBHCIEN)) Q:HBHCIEN'>0  S $P(^HBHC(631.4,HBHCIEN,0),U,7)=1 S ^HBHC(631.4,"AC",1,HBHCIEN)=""
 ; Reset Number of Visit Days to Scan (field 3, file 631.9) System Parameter 
 S $P(^HBHC(631.9,1,0),U,4)=HBHCMJ
MAILIRM ; Send mail message to IRM
 S TMP(1)="HBH*1*12 post installation is complete.  Please inform HBPC Users.",XMDUZ="HBHC Post Install",XMSUB="HBH*1*12 Post Install Complete",XMY(HBHCDUZ)="",XMTEXT="TMP("
 N DIFROM
 D ^XMD
EXIT ; Exit module
 K HBHCDAT,HBHCDTE,HBHCDUZ,HBHCIEN,HBHCFLAG,HBHCLAST,HBHCLSDT,HBHCMJ,HBHCNOW,HBHCPRV,HBHC6314
 Q
ARRAY ; Set HBHC6314 array
 S:$D(HBHC6314(HBHCPRV)) HBHC6314(HBHCPRV)=HBHC6314(HBHCPRV)+1
 S:'$D(HBHC6314(HBHCPRV)) HBHC6314(HBHCPRV)=1
 S HBHC6314(HBHCPRV,HBHCIEN)=""
 Q
LOOP2 ; Loop 2, determine whether record is Inactive or has Unique provider number
 S (HBHCFLAG,HBHCIEN)=0 F  S HBHCIEN=$O(HBHC6314(HBHCPRV,HBHCIEN)) Q:(HBHCIEN'>0)!(HBHCFLAG=1)  S HBHCLAST=HBHCIEN S:$P(^HBHC(631.4,HBHCIEN,0),U,7)="" HBHCFLAG=1
 Q
MAIL ; Send completed mail message
 S TMP(1)=$P(HBHCDAT,"@")_" HBHC Build Transmit File is complete with no errors found.",TMP(2)="",TMP(3)="   Number of Visit Days to Scan system parameter:  "_$P(^HBHC(631.9,1,0),U,4),TMP(4)=""
 S Y=$P($P(HBHCDTE,U),"@") X ^DD("DD") S HBHCINFO=Y,Y=$P($P(HBHCDTE,U,2),"@") X ^DD("DD") S TMP(5)="   Date range:  "_$P(HBHCINFO,"@")_"  thru  "_$P(Y,"@"),TMP(6)=""
 D NOW^%DTC S Y=% X ^DD("DD")
 S TMP(7)="   Start time:  "_$P(HBHCDAT,"@",2)_"   End time:  "_$P(Y,"@",2)_"   Elapsed minutes:  "_($E(%_"000",9,10)-$E(HBHCNOW_"000",9,10)*60+$E(%_"00000",11,12)-$E(HBHCNOW_"00000",11,12)),TMP(8)=""
 S TMP(9)="*****   Reminder:  Please run Transmit File to Austin option.   *****"
 S XMDUZ="HBHC Build Transmit File Mail Group",XMSUB=$P(HBHCDAT,"@")_" HBHC Build Transmit File",XMY(DUZ)="",XMTEXT="TMP("
 N DIFROM
 D ^XMD
 Q
