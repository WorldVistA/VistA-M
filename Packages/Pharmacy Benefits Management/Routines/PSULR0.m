PSULR0 ;BIR/PDW - PBM LABORATORY EXTRACT ;25 AUG 1998
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
EN ;EP  Tasking Entry Point for generating LAB mail messages, Summaries, & Prints
 ;
 ;   pull in fresh copy of variables
 S PSUVARS="PSUSDT,PSUEDT,PSUMON,PSUDUZ,PSUMASF,PSUPBMG,PSUSMRY,ZTIO,PSUSNDR,PSUOPTS"
 F I=1:1:$L(PSUVARS,",") S @$P(PSUVARS,",",I)=$P(^XTMP("PSU_"_PSUJOB,1),U,I)
 ;   save off a copy of variables
 ;S X="PSUSDT,PSUEDT,PSUMON,PSUDUZ,PSUMASF,PSUPBMG,PSUSMRY,PSUSNDR,PSULRSUB,PSULRJOB,PSUJOB,PSUOPTN,PSURTN"
 ;F I=1:1 S Y=$P(X,",",I) Q:Y=""  I $D(@Y) S X(Y)=@Y
 ;M ^XTMP(PSULRSUB,"SAVE")=X
 K X
 ;
 ;   process Lab entries put into ^XTMP(PSULRSUB,"EVENTS") by IV, UD, OP
 ;
 D EN^PSULR1
 D EN^PSULR2 ; Gather patient test(s) 'CH' nodes and get test results
 D EN^PSULR3 ; Generate Records for detailed message and source for summary
 K PSUMSG
 D EN^PSULR4(.PSUMSG) ; Generate Detailed Mail Message
 S PSUSUB="PSU_"_PSUJOB
 I $D(^XTMP(PSUSUB)),PSUMASF M ^XTMP(PSUSUB,"CONFIRM")=PSUMSG
 I $D(^XTMP(PSUSUB)),PSUPBMG M ^XTMP(PSUSUB,"CONFIRM")=PSUMSG
 D EN^PSULR5 ; Summaries
 Q
 ;
PRINT ;EP  Tasking Entry Point for generating LAB printouts
 D EN^PSULR6
 Q
 ;
EXIT ;EP EXIT
 M Z=^XTMP(PSUARSUB,PSUARJOB,"SAVE")
 K ^XTMP(PSUARJOB)
 ; Kill PSU Variables
 D VARKILL^PSUTL
 ;      Restore Important Variables
 S Y="" F  S Y=$O(Z(Y)) Q:Y=""  S @Y=Z(Y)
 K Z
 Q
 ;
LAB(PSUPK,PSUDIV,PSUORD,PSUDFN,PSUDRGNM,PSUDRCD) ;EP pass by value into lab extract
 I PSUDRCD="" Q  ; No Drug Class Code passed
 ; PSUPK - Package "IV" "UD" "OP"
 ; PSUDIV - DIVISION   ( internal form )
 ; PSUORD - ORDER NUMBER (IV - order # , UD - order # , OP - Prescription Number)
 ; PSUDFN - Patient IEN
 ; PSUDRGN - Drug Generic Name ["FREE TEXT"]
 ; PSUDRCD - VA Drug Class Code
 ;
 ; Screen out test patients
 Q:$$TESTPAT^PSUTL1(PSUDFN)
 ;
 N PSULRDA
 ;       set basics
 I '$G(PSUJOB) S PSUJOB=$J
 I '$G(PSULRSUB) S PSULRSUB="PSULR_"_PSUJOB
 I '$G(PSULRJOB) S PSULRJOB=PSUJOB
 I '$D(^XTMP(PSULRSUB,PSULRJOB)) D
 . S X1=DT,X2=+0 D C^%DTC
 . S ^XTMP(PSULRSUB,PSULRJOB)=DT_U_X_U_" PBM LAB EXTRACT"
 ;
 ;   Setup XTMP for Lab
 S X1=DT,X2=6 D C^%DTC
 S ^XTMP(PSULRSUB,0)=X_U_DT_"^  PBM Extract - Laboratory Module"
 ;
 I '$D(^XTMP(PSULRSUB,"CODES")) D SETCODES
 ;
 ;      test to see if one of the select drug class codes
 I '$D(^XTMP(PSULRSUB,"CODES",PSUDRCD)) Q
 ;
 ;     store event
 S PSULRDA=$O(^XTMP(PSULRSUB,"EVENT",""),-1)+1
 S ^XTMP(PSULRSUB,"EVENT",PSULRDA)=PSUPK_U_PSUDIV_U_PSUDFN_U_PSUORD_U_PSUDRGNM_U_PSUDRCD
 Q
 ;
SETCODES ;EP TO SETUP CODES
 ;       set basics
 I '$G(PSUJOB) S PSUJOB=$J
 I '$G(PSULRSUB) S PSULRSUB="PSULR_"_PSUJOB
 I '$G(PSULRJOB) S PSULRJOB=PSUJOB
 I '$D(^XTMP(PSULRSUB,PSULRJOB)) D
 . S X1=DT,X2=+0 D C^%DTC
 . S ^XTMP(PSULRSUB,PSULRJOB)=DT_U_X_U_" PBM LAB EXTRACT"
 F X="AN500","CV200","CV350","CV800","GA301","HS502" S ^XTMP(PSULRSUB,"CODES",X)=""
 Q
 ;
CLEAR ;EP Clear PSULR out of XTMP
 S X="PSULR"
 F  S X=$O(^XTMP(X)) Q:$E(X,1,5)'="PSULR"  W !,X K ^XTMP(X)
 Q
