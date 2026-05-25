PSSP254 ;BIRM/SA - PATCH PSS*1*254 Pre/Post-Init Rtn ; Aug 25, 2021@16:00
 ;;1.0;PHARMACY DATA MANAGEMENT;**254**;9/30/97;Build 109
 ;
POST ; post install actions
 N PSSLINE,MTXT
 ;
 ; Post-install will only run on the first time the patch is installed
 ;I $$PATCH^XPDUTL("PSS*1.0*254") D  G END
 ;. D BMES^XPDUTL("No file updates made. Patch has already been installed before.")
 ;
 ;I $D(^XTMP("PSSP254B")) D  G END
 ;. D BMES^XPDUTL("No file updates made. Patch has already been installed.")
 ;
 ;Add a check for the new routes and new units here, if not run before, run those and give a different message
 I $D(^XTMP("PSSP254B")) D  G END
 . I '$D(^XTMP("PSSP254B","NEWROUTE")),'$D(^XTMP("PSSP254B","NEWUNIT")) D RTEUNIT^PSSP254A Q
 . D BMES^XPDUTL("No file updates made. Patch has already been installed.")
 ;
 ; This TEMP global will be used for the Mailman Message
 K ^TMP("PSS254P",$J)
 ;
 ; This TEMP global will be used to store backup data for Backing out the patch
 K ^XTMP("PSSP254B")
 S ^XTMP("PSSP254B",0)=$$FMADD^XLFDT(DT,180)_"^"_DT_"^PSS*1.0*254 - FDB v4.5 Upgrade - Backout Data"
 ;
 D SETTXT("The following updates have been automatically performed to support the First Data Bank (FDB) v4.5 Upgrade:")
 D SETTXT("")
 ;
 ; Updates to the PPSN & FDB WebServices
 D WS
 ; Updates to DOSE UNITS (#51.24) and DOSE UNIT CONVERSION (#51.25) files
 D ST
 ; Updates to STANDARD MEDICATION ROUTES (#51.23) file
 D MR
 ; Updates to the DOSING CHECK FREQUENCY field for the files #51 and #51.1
 D DCF
 ;
 ; Sends Mailman Message to Installer and PSNMGR key holders listing updates
 D MAIL
 K ^TMP("PSS254P",$J)
 D EN^PSSP254R ; generate Orderable items & Quick orders reports
END ; Post-install end point
 Q
 ;
ST ; Update entries in DOSE UNITS file (#51.24) and DOSE UNIT CONVERSION file (#51.25)
 N II,JJ,PSA,PSI,PSJ,PSL,PSLIST,PSX,SYM,TXT,X
 D BMES^XPDUTL("DOSE UNITS file (#51.24) and DOSE UNIT CONVERSION file (#51.25) Updates:")
 D SETTXT("")
 D SETTXT("DOSE UNITS (#51.24) and DOSE UNIT CONVERSION file (#51.25) Updates:")
 D SETTXT("===================================================================")
 ;
 S MTXT="o FDB DOSE UNIT updates:" D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 F PSJ=1:1 S PSLIST=$P($T(LI241+PSJ),";;",2) Q:PSLIST=""  D FDB
 D SETTXT("")
 S MTXT="o New Synonyms:" D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 F PSJ=1:1 S PSLIST=$P($T(LI242+PSJ),";;",2) Q:PSLIST=""  D SYN
 D SETTXT("")
 S MTXT="o Deleted entries:" D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 D DEL24
 D SETTXT("")
 S MTXT="o DOSE UNIT 1 updates:" D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 F PSJ=1:1 S PSLIST=$P($T(LI251+PSJ),";;",2) Q:PSLIST=""  D DUC
 D SETTXT("")
 S MTXT="o Deleted entries:" D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 D DEL25
 D SETTXT("")
 S MTXT="o DOSE UNIT 2 updates:" D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 F PSJ=1:1 S PSLIST=$P($T(LI252+PSJ),";;",2) Q:PSLIST=""  D UNIT2
 K DIE,DR,DA,XUMF
 ;
 D NEWUNITS^PSSP254A
 Q
 ;
FDB ; 1st DataBank Dose Unit Updates
 N DA,DIE,DR,FROM
 S DA=+$$FIND1^DIC(51.24,"","C",$P(PSLIST,U)) Q:DA<1
 S FROM=$$GET1^DIQ(51.24,DA,1)
 I FROM=$P(PSLIST,U,2) Q
 S XUMF=1,DR="1////"_$P(PSLIST,U,2),DIE=51.24 D ^DIE
 S MTXT="  - Entry #"_DA_": changed from '"_FROM_"' to '"_$P(PSLIST,U,2)_"'"
 D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 S ^XTMP("PSSP254B","DU-U",51.24,DA,1)=$P(PSLIST,U)_"^"_FROM_"^"_$P(PSLIST,U,2)
 Q
 ;
SYN ; SYNONYM updates
 N DA,DIC,DD,DO,DINUM,PSA,PSI,PSX,SYM,Y
 S PSA=+$$FIND1^DIC(51.24,"","B",$P(PSLIST,U)) Q:PSA<1
 S SYM=$P(PSLIST,U,2) F PSI=1:1 S PSX=$P(SYM,",",PSI) Q:PSX=""  D
 . I $D(^PS(51.24,PSA,1,"B",$E(PSX,1,30))) Q
 . S DA(1)=PSA,X=PSX,DIC="^PS(51.24,"_DA(1)_",1,",DIC(0)="L" D FILE^DICN
 . M ^XTMP("PSSP254B","DU-SYN-A",51.242,DA(1),DA,+$G(Y))=PSX
 . S MTXT="  - '"_PSX_"' added to entry '"_$P(PSLIST,U)_"'"
 . D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 Q
 ;
DEL24 ; delete entries from file #51.24
 N DA,DIK,TXT
 S XUMF=1
 F TXT="anti-Xa unit","ENEMA","OVULE(S)","SQUIRT(S)","TROCHE(S)" D
 . S DA=+$$FIND1^DIC(51.24,"","B",TXT) Q:'DA
 . M ^XTMP("PSSP254B","DU-D",51.24,DA)=^PS(51.24,DA)
 . S DIK="^PS(51.24," D ^DIK
 . S MTXT="  - Deleted entry '"_TXT_"' from DOSE UNITS file (#51.24)"
 . D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 Q
 ;
DUC ; update the DOSE UNIT 1 (#.01) of the DOSE UNIT CONVERSION file (#51.25)
 N DA,DIE,DR
 S DA=+$$FIND1^DIC(51.25,"","MX",$P(PSLIST,U)) Q:DA<1
 S XUMF=1,DR=".01////"_$P(PSLIST,U,2),DIE=51.25 D ^DIE
 S MTXT="  - Entry #"_DA_": changed from '"_$P(PSLIST,U)_"' to '"_$P(PSLIST,U,2)_"'"
 D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 S ^XTMP("PSSP254B","DUC-U",51.25,DA,.01)=$P(PSLIST,U)_"^"_$P(PSLIST,U,2)
 Q
 ;
DEL25 ; delete entries from the DOSE UNIT CONVERSION file (#51.25)
 N DA,DIK,TXT
 S XUMF=1
 F TXT="ENEMAS","OVULE(S)","SQUIRTS","TROCHES" D
 . S DA=+$$FIND1^DIC(51.25,"","B",TXT) Q:'DA
 . M ^XTMP("PSSP254B","DUC-D",51.25,DA)=^PS(51.25,DA)
 . S DIK="^PS(51.25," D ^DIK
 . S MTXT="  - Deleted entry '"_TXT_"' from DOSE UNIT CONVERSION file (#51.25)"
 . D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 Q
 ;
UNIT2 ; update the DOSE UNIT 2 field (#.01) and the CONVERSION FACTOR field (#1) entries in file (#51.25)
 K DIE,DR,DA,JJ,PSL,PSX,II
 S XUMF=1
 S PSL=$P(PSLIST,U,2) F II=1:1:$L(PSL,",") S PSX=$P(PSL,",",II) D
 . S DA(1)=$P(PSLIST,U)
 . S JJ=$O(^PS(51.25,DA(1),1,"B",$S(PSX["@":$P(PSX,"@"),1:$P(PSX,":")),0))
 . S DA=JJ I 'DA Q
 . I PSX'["@",$$GET1^DIQ(51.251,DA_","_DA(1)_",",.01)=$P(PSX,":",2)&($$GET1^DIQ(51.251,DA_","_DA(1)_",",1)=$P(PSX,":",3)) Q
 . S DIE="^PS(51.25,"_DA(1)_",1,"
 . S DR=".01////"_$S(PSX["@":"@",1:$P(PSX,":",2))_$S($P(PSX,":",3):";1////"_$P(PSX,":",3),1:"")
 . M ^XTMP("PSSP254B","DU2C-"_$S(PSX["@":"D",1:"U"),51.251,DA(1),DA)=^PS(51.25,DA(1),1,DA)
 . D ^DIE K DA,DIE,DR
 . I PSX["@" S MTXT="  - Deleted entry '"_$P(PSX,"@")_"' for "_$P($G(^PS(51.25,$P(PSLIST,U),0)),U)
 . I PSX'["@" S MTXT="  - Changed from '"_$P(PSX,":")_"' to '"_$P(PSX,":",2)_"' for "_$P($G(^PS(51.25,$P(PSLIST,U),0)),U)
 . D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 Q
 ;
MR ; STANDARD MEDICATION ROUTES (#51.23) file updates
 D SETTXT("")
 S MTXT="STANDARD MEDICATION ROUTES file (#51.23) Updates:"
 D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 D SETTXT("=================================================")
 F TXT="INTRA-AMNIOTIC;INTRA-AMNIOTIC","INTRATYMPANIC;INTRATYMPANIC","IONTOPHORESIS;IONTOPHORETIC","OPHTHALMIC;OPHTHALMIC (EYE)","OTIC;OTIC (EAR)","SUBMUCOSAL;SUBMUCOSAL INJECTION" D
 . S DA=$$FIND1^DIC(51.23,"","B",$P(TXT,";")) Q:'DA
 . I $$GET1^DIQ(51.23,DA,1)=$P(TXT,";",2) Q
 . S ^XTMP("PSSP254B","SMR-U",51.23,DA,1)=$$GET1^DIQ(51.23,DA,1)_"^"_$P(TXT,";",2)
 . S MTXT="  - Changed '"_$$GET1^DIQ(51.23,DA,1)_"' to '"_$P(TXT,";",2)_"'"
 . S DIE="^PS(51.23,",DR="1////"_$P(TXT,";",2) D ^DIE K DA,DIE,DR
 . D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 ;
 D NEWROUTE^PSSP254A
 Q
 ;
WS ; Web Service updates
 N SRVNAME,PSSCNT,PSSDATA,PSSTYPE,FDA
 S PSSTYPE=$G(XPDQUES("POS1")) ;Get the site type entered in the Installation question POS1 
 ; PSSTYPE will be a value of 1-5 (PRE-PROD, SQA, STAGE, DEVELOPMENT, PRODUCTION)
 I 'PSSTYPE S PSSTYPE=5
 D MES^XPDUTL("Setting up the servers for "_$S(PSSTYPE=1:"PRE-PROD",PSSTYPE=2:"SQA",PSSTYPE=3:"STAGING",PSSTYPE=4:"DEVELOPMENT",1:"PRODUCTION")_":")
 F PSSCNT=1:1 S PSSDATA=$P($T(WEBS+PSSCNT),";;",2) D  Q:PSSDATA=""
 . Q:PSSTYPE'=$P(PSSDATA,";")
 . S SRVNAME=$P(PSSDATA,";",3),PSSIEN=$$FIND1^DIC(18.12,,"B",SRVNAME) Q:'PSSIEN
 . K FDA M ^XTMP("PSSP254B","WS",18.12,PSSIEN)=^XOB(18.12,PSSIEN)
 . S PSSIEN=PSSIEN_"," D DISABLE(SRVNAME,PSSIEN)
 . S FDA(18.12,PSSIEN,.04)=$P(PSSDATA,";",4) ; server
 . S FDA(18.12,PSSIEN,.03)=$P(PSSDATA,";",5) ; port
 . S FDA(18.12,PSSIEN,.06)=1 ; status
 . I SRVNAME="PPSN" D
 . . S FDA(18.12,PSSIEN,3.02)="encrypt_only_tlsv12"
 . . S FDA(18.12,PSSIEN,3.03)=443 ; ssl port
 . D FILE^DIE("K","FDA","PSSERR") K FDA
 . I '$D(PSSERR("DIERR",1,"TEXT",1)) S MTXT="o WEB SERVER '"_SRVNAME_"' updated successfully"
 . I $D(PSSERR("DIERR",1,"TEXT",1)) S MTXT="o WEB SERVER '"_SRVNAME_"' Error: "_PSSERR("DIERR",1,"TEXT",1)
 . D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 Q
 ;
DISABLE(SRVNAME,PSSIEN) ; Disable PPSN server if it exists-will set it back to enabled
 N PSSERVER,PSSERR
 ; Set STATUS to DISABLED
 S PSSERVER(18.12,PSSIEN,.06)=0
 D FILE^DIE("","PSSERVER","PSSERR") ; update existing entry
 D BMES^XPDUTL("o WEB SERVER '"_SRVNAME_"' server temporarily disabled.")
 Q
 ;
DCF ; Converting DOSING CHECK FREQUENCY field in both files (MEDICATION INSTRUCTION (#51) & ADMINISTRATION SCHEDULE (#51.1))
 N FILE,FIELD,MEDSCH,OLDFREQ,NEWFREQ,XX,LINE,DIE,DR,DA,X,Y,REVFLG,FREQCHK,DRGCTR,DRGFILE,DRGNODE,TMPMSG
 ;
 D SETTXT("")
 S MTXT="DOSING CHECK FREQUENCY field Conversion:"
 D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 D SETTXT("========================================")
 F FILE=51,51.1 D
 . I FILE=51 S FIELD=32,DRGNODE=5,DRGFILE=51.321
 . E  S FIELD=11,DRGNODE=4,DRGFILE=51.111
 . ;
 . S MEDSCH=0 F  S MEDSCH=$O(^PS(FILE,MEDSCH)) Q:'MEDSCH  D
 . . S OLDFREQ=$$UP^XLFSTR($$GET1^DIQ(FILE,MEDSCH,FIELD)) I OLDFREQ="" Q
 . . S NEWFREQ=OLDFREQ I $E(OLDFREQ,1)="X" S NEWFREQ=+$E(OLDFREQ,2,3)_"X"_$E(OLDFREQ,$L(OLDFREQ))
 . . S FREQCHK=$$FREQCHK^PSSJSV(NEWFREQ)
 . . I FREQCHK'="",OLDFREQ=NEWFREQ Q
 . . S ^XTMP("PSSP254B","DCF",FILE,MEDSCH,FIELD)=OLDFREQ_"^"_$S(FREQCHK="":"@",1:NEWFREQ)
 . . K DIE,DR S DIE=FILE,DR=FIELD_"////"_$S(FREQCHK="":"@",1:NEWFREQ),DA=MEDSCH D ^DIE
 . . ;
 . . ;Impacted Drugs
 . . I FREQCHK="" S DRGCTR=0  F  S DRGCTR=$O(^PS(FILE,MEDSCH,DRGNODE,DRGCTR)) Q:(+DRGCTR'=DRGCTR)  D
 . . . S TMPMSG=$G(^PS(FILE,MEDSCH,DRGNODE,DRGCTR,0))_"^"_$$GET1^DIQ(DRGFILE,DRGCTR_","_MEDSCH_",",.01)
 . . . S ^XTMP("PSSP254B","DCFDRUG",FILE,MEDSCH,FIELD,DRGCTR)=TMPMSG
 . . . S DIE="^PS(FILE,MEDSCH,DRGNODE,",DA=DRGCTR,DA(1)=MEDSCH,DR=".01////@" D ^DIE
 ;
 S REVFLG=0
 I '$D(^XTMP("PSSP254B","DCF")) D
 . D SETTXT("There were no updates needed.")
 E  D
 . S FILE="" F  S FILE=$O(^XTMP("PSSP254B","DCF",FILE)) Q:'FILE  D
 . . S MTXT="o File: "_$S(FILE=51:"MEDICATION INSTRUCTION (#51)",1:"ADMINISTRATION SCHEDULE (#51.1)")
 . . D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 . . S MEDSCH="" F  S MEDSCH=$O(^XTMP("PSSP254B","DCF",FILE,MEDSCH)) Q:MEDSCH=""  D
 . . . S FIELD="" F  S FIELD=$O(^XTMP("PSSP254B","DCF",FILE,MEDSCH,FIELD)) Q:FIELD=""  D
 . . . . S XX=$G(^XTMP("PSSP254B","DCF",FILE,MEDSCH,FIELD))
 . . . . S MTXT="  - "_$$GET1^DIQ(FILE,MEDSCH,.01)_" ("_$$GET1^DIQ(FILE,MEDSCH,$S(FILE=51:1,1:8))
 . . . . I $P(XX,"^",2)="@" D
 . . . . . S MTXT=MTXT_") - '"_$P(XX,"^")_"' deleted - no longer supported."
 . . . . . S REVFLG=1
 . . . . . D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 . . . . . D LSTDRG(FILE,MEDSCH,FIELD)
 . . . . E  D
 . . . . . S MTXT=MTXT_") - Changed from '"_$P(XX,"^")_"' to '"_$P(XX,"^",2)_"'"
 . . . . . D BMES^XPDUTL(MTXT),SETTXT(MTXT)
 . . D SETTXT("")
 I '$G(REVFLG) D
 . D SETTXT("NOTE: No further (manual) updates are needed for the Medication Instructions")
 . D SETTXT("====  or Administration Schedule entries.")
 E  D
 . D SETTXT("NOTE: Make sure you review the entries that the DOSING CHECK FREQUENCY field")
 . D SETTXT("====  content was deleted and select the appropriate valid value for them.")
 ;
 Q
 ;
SETTXT(TXT) ; Setting Plain Text
 S PSSLINE=$G(PSSLINE)+1,^TMP("PSS254P",$J,PSSLINE)=TXT
 Q
 ;
LSTDRG(FILE,MEDSCH,FIELD) ;Display impacted drugs
 N DRGCTR,DRGFILE,DRGLIST,DRGNAME
 ;
 S DRGFILE=$S(FILE=51:51.321,1:51.111)
 S DRGCTR=""
 F  S DRGCTR=$O(^XTMP("PSSP254B","DCFDRUG",FILE,MEDSCH,FIELD,DRGCTR)) Q:DRGCTR=""  D
 . S DRGNAME=$P($G(^XTMP("PSSP254B","DCFDRUG",FILE,MEDSCH,FIELD,DRGCTR)),"^",2)
 . I DRGNAME'="" S DRGLIST(DRGNAME)=""   ;Setup for alphabetical display
 ;
 I $DATA(DRGLIST) D
 . S MTXT="    Impacted Drugs"
 . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 . S DRGNAME="" F  S DRGNAME=$O(DRGLIST(DRGNAME)) Q:DRGNAME=""  D
 . . S MTXT="      "_DRGNAME
 . . D MES^XPDUTL(MTXT),SETTXT(MTXT)
 Q
 ;
MAIL ; Sends Mailman message
 N II,XMX,XMSUB,XMDUZ,XMTEXT,XMY,DIFROM
 ;
 D BMES^XPDUTL("Sending Mailman Message with updates...")
 ;
 S II=0 F  S II=$O(^XUSEC("PSNMGR",II)) Q:'II  S XMY(II)=""
 S XMY(DUZ)="",XMSUB="PSS*1*254 FDB v4.5 Upgrade Installation Complete"
 S XMDUZ="PSS*1*254 Install",XMTEXT="^TMP(""PSS254P"",$J,"
 D ^XMD
 Q
 ;
LI241 ; FDB DOSE Unit entry list in file (#51.24)
 ;;APPLICATION(S)^APPLICATIONS
 ;;APPLICATORFUL(S)^APPLICATORFUL
 ;;CAP/TAB^TABLET-CAPSULE
 ;;CAPSULE(S)^CAPSULES
 ;;DROP(S)^DROPS
 ;;INCH(ES)^INCHES
 ;;MICROGRAM(S)^MICROGRAMS
 ;;MG-PE^MILLIGRAM PHENYTOIN EQUIVALENT
 ;;MICRO UNIT(S)^MICROUNITS
 ;;MILLIONUNIT(S)^MILLION UNITS
 ;;PIECE(S)^PIECES OF GUM
 ;;PUFF(S)^PUFFS
 ;;SCOOPFUL(S)^SCOOPS
 ;;SPRAY(S)^SPRAY
 ;;STRIP(S)^STRIPS
 ;;SUPPOSITORY(IES)^SUPPOSITORY
 ;;TABLESPOONFUL(S)^TABLESPOONFUL
 ;;TABLET(S)^TABLETS
 ;;TEASPOONFUL(S)^TEASPOONFUL
 ;;THOUSAND UNITS^THOUSAND UNITS
 ;;UNIT(S)^UNITS
 ;;
LI242 ; new SYNONYM list to be added in file (#51.24)
 ;;CAP/TAB^TABLET-CAPSULE,TABLET-CAPSULES
 ;;MG-PE^MILLIGRAM PHENYTOIN EQUIVALENTS,MILLIGRAM PHENYTOIN EQUIVALENT
 ;;THOUSAND UNITS^THOUSAND UNIT
 ;;
LI251 ; DOSE UNIT 1 entries of file (#51.25)
 ;;APPLICATION(S)^APPLICATIONS
 ;;APPLICATORFUL(S)^APPLICATORFUL
 ;;CAPSULE(S)^CAPSULES
 ;;DROP(S)^DROPS
 ;;INCH(ES)^INCHES
 ;;MICRO UNITS^MICROUNITS
 ;;MICROGRAM(S)^MICROGRAMS
 ;;MILLIONUNIT(S)^MILLION UNITS
 ;;PIECE(S)^PIECES OF GUM
 ;;PUFF(S)^PUFFS
 ;;SCOOPFULS^SCOOPS
 ;;SPRAY(S)^SPRAYS
 ;;STRIP(S)^STRIPS
 ;;SUPPOSITORY(IES)^SUPPOSITORY
 ;;TAB-CAPS^TABLET-CAPSULES
 ;;TABLESPOONFULS^TABLESPOONFUL
 ;;TABLET(S)^TABLET
 ;;TEASPOONFULS^TEASPOONFUL
 ;;TU^THOUSAND UNITS
 ;;UNIT(S)^UNITS
 ;;
LI252 ; DOSE UNIT 2 entries of file (#51.25)
 ;;67^APPLICATORFUL(S):APPLICATORFUL
 ;;1^APPLICATION(S):APPLICATIONS
 ;;7^INCH(ES):INCHES
 ;;9^TAB-CAPS:TABLET-CAPSULES,CAPSULE(S):CAPSULES,ENEMAS@,OVULE(S)@,PIECE(S):PIECES OF GUM,SCOOPFULS:SCOOPS,STRIP(S):STRIPS,SUPPOSITORY(IES):SUPPOSITORY,TABLET(S):TABLETS,TROCHES@
 ;;12^MICROGRAM(S):MICROGRAMS
 ;;15^SPRAY(S):SPRAYS,PUFF(S):PUFFS,SQUIRTS@
 ;;36^MILLIONUNIT(S):MILLION UNITS,UNIT(S):UNITS
 ;;38^MICROGRAM(S):MICROGRAMS
 ;;39^DROP(S):DROPS,TABLESPOONFULS:TABLESPOONFUL,TEASPOONFULS:TEASPOONFUL
 ;;40^MICRO UNITS:MICROUNITS,TU:THOUSAND UNITS:1000,UNIT(S):UNITS
 ;;41^MICROGRAM(S):MICROGRAMS
 ;;49^SPRAY(S):SPRAYS
 ;;52^PUFF(S):PUFFS,SQUIRTS@
 ;;61^MILLIONUNIT(S):MILLION UNITS:0.001,UNIT(S):UNITS
 ;;62^MICRO UNITS:MICROUNITS,TU:THOUSAND UNITS,MILLIONUNIT(S):MILLION UNITS
 ;;
 ;;3;STAGE;PEPS;mocha-ioc.pitc.domain.ext;8010
WEBS ;  Map the system type to the SERVER endpoint
 ;;1;PRE-PROD;PPSN;vaausapppps401.aac.domain.ext;443
 ;;1;PRE-PROD;PEPS;mocha-pre.pharmacy.healthevet.domain.ext;8011
 ;;2;SQA;PPSN;vaausapppps930.aac.domain.ext;443
 ;;2;SQA;PEPS;vaausapppps950.aac.domain.ext;8001
 ;;3;STAGE;PPSN;vaausapppps901.aac.domain.ext;443
 ;;3;STAGE;PEPS;mocha-pre.pharmacy.healthevet.domain.ext;8011
 ;;4;DEV;PPSN;vaausapppps910.aac.domain.ext;443
 ;;4;DEV;PEPS;vaausppsapp94.aac.domain.ext;8001
 ;;5;PROD;PPSN;vaww.ppsn.domain.ext;443
 ;;5;PROD;PEPS;mocha.pharmacy.healthevet.domain.ext;8011
 ;;
