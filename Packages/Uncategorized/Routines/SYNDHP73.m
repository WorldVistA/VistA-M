SYNDHP73 ;AFHIL DHP/fjf/art - HealthConcourse - DHP REST handlers ;2019-10-23  3:54 PM
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;  -------------------------------
 ;  Patient validate bridge routine
 ;  -------------------------------
 ;
PATVAL ; Verify patient on basis of name, SSN, DoB, Gender and Mother's Maiden name
 ;parse out RPC call parameters from REST request
 ;
 ;   DHPPATVAL
 ;
 ;S $ZT="^ZTER"
 D PARSEVAL
 ;
 D PATVAL^SYNDHP43(.RETSTA,DHPNAME,DHPSSN,DHPDOB,DHPGENDER,DHPMMDNM)
 ; RETSTA is string returned by
 ;S RETSTA="NOTHING SUCCEEDS LIKE A BUDGIE"
 ;
 Q
 ;
PARSEVAL ;
 ;
 F I="SSN","DOB","GENDER","MMDNM" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 S DHPNAME=$$GETPARAM^RGNETWWW("NAME",1,1)
 S DHPNAME=DHPNAME_","_$$GETPARAM^RGNETWWW("NAME",1,2)_" "
 Q
 ;
 ;  ---------------------------------------------
 ;  Patient demographics by traits bridge routine
 ;  ---------------------------------------------
 ;
PATDEM ; get patient demographics for one patient
 ;
 ;   DHPPATDEM
 ;
 D PARSEDEM
 D PATDEM^SYNDHP47(.RETSTA,DHPNAME,DHPSSN,DHPDOB,DHPGENDER,DHPJSON)
 Q
 ;
PARSEDEM ;
 ;
 F I="SSN","DOB","GENDER","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 S DHPNAME=$$GETPARAM^RGNETWWW("NAME",1,1)
 S DHPNAME=DHPNAME_","_$$GETPARAM^RGNETWWW("NAME",1,2)_" "
 Q
 ;
 ;  ------------------------------------------
 ;  Patient demographics by ICN bridge routine
 ;  ------------------------------------------
 ;
PATDEMI ; get patient demographics for one patient
 ;
 ;   DHPPATDEMICN
 ;
 D PARSEICN
 F I="JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATDEMI^SYNDHP47(.RETSTA,DHPICN,DHPJSON)
 Q
 ;
 ;  ----------------------------------------------------
 ;  All patient demographics by ICN="ALL" bridge routine
 ;  ----------------------------------------------------
 ;
PATDEMAL ; get patient demographics for all patients
 ;
 ;   DHPPATDEMALL
 ;
 D PARSEICN
 F I="JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATDEMAL^SYNDHP47(.RETSTA,DHPICN,DHPJSON)
 Q
 ;
 ;  ----------------------------------------------------
 ;  All patient ICN's bridge routine
 ;  ----------------------------------------------------
 ;
PATICNS ; get patient ICN for some or all patients
 ;
 ;   DHPPATICNALL
 ;
 F I="CNT","JSON","RND" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D ICNS^SYNDHPIC(.RETSTA,DHPCNT,DHPJSON,DHPRND)
 Q
 ;  ----------------------------------------------------
 ;  All patient demographics by ICN=range bridge routine
 ;  ----------------------------------------------------
 ;
PATDEMRG ; get patient demographics for a range of patients
 ;
 ;   DHPPATDEMRNG
 ;
 D PARSEICN
 F I="JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATDEMRNG^SYNDHP47(.RETSTA,DHPICN,DHPJSON)
 Q
 ;
 ;  ----------------------------------------------------
 ;  Patient condition SCT codes by traits bridge routine
 ;  ----------------------------------------------------
 ;
PATCON ; get patient condition SCT codes for one patient by traits
 ;
 ;   DHPPATCON
 ;
 D PARSECON
 D PATCONDS^SYNDHP03(.RETSTA,DHPNAME,DHPSSN,DHPDOB,DHPGENDER)
 Q
 ;
PARSECON ;
 ;
 F I="SSN","DOB","GENDER" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 S DHPNAME=$$GETPARAM^RGNETWWW("NAME",1,1)
 S DHPNAME=DHPNAME_","_$$GETPARAM^RGNETWWW("NAME",1,2)_" "
 Q
 ;
 ;  ----------------------------------------
 ;  Patient conditions by ICN bridge routine
 ;  ----------------------------------------
 ;
PATCONI ; get patient conditions for one patient by ICN
 ;
 ;   DHPPATCONICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATCONI^SYNDHP03(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  --------------------------------------------------------
 ;  Patient encounters for one patient by ICN bridge routine
 ;  --------------------------------------------------------
 ;
PATENCI ; get patient encounters for one patient by ICN
 ;
 ;   DHPPATENCICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATENCI^SYNDHP40(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  ---------------------------------------
 ;  Patients for a condition bridge routine
 ;  ---------------------------------------
 ;
PATCONAL ; get patients for a condition
 ;
 ;   DHPPATS4CON
 ;
 D PARSECONAL
 D PATCONAL^SYNDHP03(.RETSTA,DHPSCT,DHPJSON)
 Q
 ;
PARSECONAL ; generalise
 ;
 F I="SCT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 Q
 ;
 ;  --------------------------------------------------
 ;  Patient medication statement by ICN bridge routine
 ;  --------------------------------------------------
 ;
PATMEDS ; get patient medication statement for one patient by ICN
 ;
 ;   DHPPATMEDSICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATMEDS^SYNDHP48(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT)
 Q
 ;
 ;  -------------------------------------------------------
 ;  Patient medication administration by ICN bridge routine
 ;  -------------------------------------------------------
 ;
PATMEDA ; get patient medication administration for one patient by ICN
 ;
 ;   DHPPATMEDAICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATMEDA^SYNDHP48(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT)
 Q
 ;
 ;  -------------------------------------------------
 ;  Patient medication dispense by ICN bridge routine
 ;  -------------------------------------------------
 ;
PATMEDD ; get patient medication dispense for one patient by ICN
 ;
 ;   DHPPATMEDDICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATMEDD^SYNDHP48(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT)
 Q
 ;
 ;  ---------------------------------------
 ;  Patient vitals by traits bridge routine
 ;  ---------------------------------------
 ;
PATVIT ; get patient vitals for one patient by traits
 ;
 ;   DHPPATVIT
 ;
 D PARSEVIT
 D PATVIT^SYNDHP01(.RETSTA,DHPNAME,DHPSSN,DHPDOB,DHPGENDER,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;
PARSEVIT ;
 ;
 F I="SSN","DOB","GENDER","FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 S DHPNAME=$$GETPARAM^RGNETWWW("NAME",1,1)
 S DHPNAME=DHPNAME_","_$$GETPARAM^RGNETWWW("NAME",1,2)_" "
 Q
 ;
 ;  ------------------------------------
 ;  Patient vitals by ICN bridge routine
 ;  ------------------------------------
 ;
PATVITI ; get patient vitals for one patient by ICN
 ;
 ;   DHPPATVITICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATVITI^SYNDHP01(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  -----------------------------------------------
 ;  Patient health factors by traits bridge routine
 ;  -----------------------------------------------
 ;
PATHLF ; get patient health factors for one patient
 ;
 ;   DHPPATHLF
 ;
 D PARSETRAITS
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATHLF^SYNDHP09(.RETSTA,DHPNAME,DHPSSN,DHPDOB,DHPGENDER,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  --------------------------------------------
 ;  Patient health factors by ICN bridge routine
 ;  --------------------------------------------
 ;
PATHLFI ; get patient health factors for one patient
 ;
 ;   DHPPATHLFICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATHLFI^SYNDHP09(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  -------------------------------------------
 ;  Patient procedures by traits bridge routine
 ;  -------------------------------------------
 ;
PATPRC ; get patient procedures for one patient
 ;
 ;   DHPPATPRC
 ;
 D PARSETRAITS
 F I="FRDAT","TODAT" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATPRC^SYNDHP04(.RETSTA,DHPNAME,DHPSSN,DHPDOB,DHPGENDER,DHPFRDAT,DHPTODAT)
 Q
 ;
 ;  ----------------------------------------
 ;  Patient procedures by ICN bridge routine
 ;  ----------------------------------------
 ;
PATPRCI ; get patient procedures for one patient
 ;
 ;   DHPPATPRCICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATPRCI^SYNDHP04(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT)
 Q
 ;
 ;  ---------------------------------------
 ;  Patient allergies by ICN bridge routine
 ;  ---------------------------------------
 ;
PATALLI ; get patient allergies for one patient by ICN
 ;
 ;   DHPPATALLICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATALLI^SYNDHP57(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  -----------------------------------------------
 ;  Patient diagnostic report by ICN bridge routine
 ;  -----------------------------------------------
 ;
PATDXREP ; get patient diagnostic report for one patient by ICN
 ;
 ;   DHPPATDXRICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATDXRI^SYNDHP05(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  -------------------------------------
 ;  Patient labs by traits bridge routine
 ;  -------------------------------------
 ;
PATLAB ; get patient labs for one patient
 ;
 ;   DHPPATLAB
 ;
 D PARSETRAITS
 F I="FRDAT","TODAT" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATLAB^SYNDHP53(.RETSTA,DHPNAME,DHPSSN,DHPDOB,DHPGENDER,DHPFRDAT,DHPTODAT)
 Q
 ;
 ;  ----------------------------------
 ;  Patient labs by ICN bridge routine
 ;  ----------------------------------
 ;
PATLABI ; get patient labs for one patient
 ;
 ;   DHPPATLABICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATLABI^SYNDHP53(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  -------------------------------------------
 ;  Patient Enc Providers by ICN bridge routine
 ;  -------------------------------------------
 ;
PATPRVI ; get patient encounter providers for one patient
 ;
 ;   DHPPATPRVICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATPRVI^SYNDHP54(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;  ------------------------------------------
 ;  Patient Appointments by ICN bridge routine
 ;  ------------------------------------------
 ;
PATAPTI ; get patient appointments for one patient
 ;
 ;   DHPPATAPTICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATAPTI^SYNDHP41(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  -----------------------------------
 ;  Patient Flags by ICN bridge routine
 ;  -----------------------------------
 ;
PATFLGI ; get patient flags for one patient
 ;
 ;   DHPPATFLGICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATFLGI^SYNDHP08(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  ---------------------------------------------
 ;  Patient Immunizations by ICN bridge routine
 ;  ---------------------------------------------
 ;
PATIMMI ; get patient immunizations for one patient
 ;
 ;   DHPPATIMMICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATIMMI^SYNDHP02(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  ---------------------------------------------
 ;  Patient Goals by ICN bridge routine
 ;  ---------------------------------------------
 ;
PATGOLI ; get patient goals for one patient
 ;
 ;   DHPPATGOLICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATGOLI^SYNDHP07(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;
 ;  -----------------------------------------------
 ;  Patient observations by traits bridge routine
 ;  -----------------------------------------------
 ;
PATOBS ; get patient observations for one patient
 ;
 ;   DHPPATOBS
 ;
 D PARSETRAITS
 F I="FRDAT","TODAT" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATOBS^SYNDHP56(.RETSTA,DHPNAME,DHPSSN,DHPDOB,DHPGENDER,DHPFRDAT,DHPTODAT)
 Q
 ;
 ;  ---------------------------------------------
 ;  Patient observations by ICN bridge routine
 ;  ---------------------------------------------
 ;
PATOBSI ; get patient observations for one patient
 ;
 ;   DHPPATOBSICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATOBSI^SYNDHP56(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  ---------------------------------------------
 ;  Get one care team bridge routine
 ;  ---------------------------------------------
 ;
CARETEAM ; get one care team
 ;
 ;   DHPCARETEAM
 ;
 F I="TEAM","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D GETTEAM^SYNDHP58(.RETSTA,DHPTEAM,DHPJSON)
 Q
 ;
 ;  ---------------------------------------------
 ;  Get all care teams bridge routine
 ;  ---------------------------------------------
 ;
CARETEAMS ; get all care teams
 ;
 ;   DHPCARETEAMS
 ;
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D GETTEAMS^SYNDHP58(.RETSTA,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  ---------------------------------------------
 ;  get Care Plans for a patient by traits bridge routine
 ;  ---------------------------------------------
 ;
PATCPALL ; get all care plans
 ;
 ;   DHPPATCPALL
 ;
 D PARSETRAITS
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATCPALL^SYNDHP59(.RETSTA,DHPNAME,DHPSSN,DHPDOB,DHPGENDER,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  ---------------------------------------------
 ;  get Care Plans for a patient by ICN bridge routine
 ;  ---------------------------------------------
 ;
PATCPALLI ; get all care plans for a patient
 ;
 ;   DHPPATCPALLI
 ;
 F I="ICN","FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATCPALLI^SYNDHP59(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  --------------------------------------------------------
 ;  get one Care Plan for a patient by traits bridge routine
 ;  --------------------------------------------------------
 ;
PATCP ; get one care plan for a patient
 ;
 ;   DHPPATCP
 ;
 D PARSETRAITS
 F I="VRESID","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATCP^SYNDHP59(.RETSTA,DHPNAME,DHPSSN,DHPDOB,DHPGENDER,DHPVRESID,DHPJSON)
 Q
 ;
 ;  --------------------------------------------------------
 ;  get one Care Plan for a patient by ICN bridge routine
 ;  --------------------------------------------------------
 ;
PATCPI ; get one care plan for a patient
 ;
 ;   DHPPATCPI
 ;
 F I="ICN","VRESID","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATCPI^SYNDHP59(.RETSTA,DHPICN,DHPVRESID,DHPJSON)
 Q
 ;
 ;  ----------------------------------------------
 ;  Institution Information by HLOC bridge routine
 ;  ----------------------------------------------
 ;
HLOCINST ; get institution information for hospital location name
 ;
 ;    DHPHLOCINSTHLOCNAM
 ;
 D PARSEHLC
 D HOSINSTI^SYNDHP06(.RETSTA,DHPHLOC,DHPJSON)
 Q
 ;
PARSEHLC ; Hospital Location Name PARSER
 ;
 F I="HLOC","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 Q
 ;
 ;  ---------------------------------------------
 ;  Text Integration Utility (TIU) bridge routine
 ;  ---------------------------------------------
 ;
PATTIUI ; get patient notes for one patient by ICN
 ;
 ;   DHPPATTIUICN
 ;
 D PARSEICN
 F I="FRDAT","TODAT","JSON" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D PATTIUI^SYNDHP67(.RETSTA,DHPICN,DHPFRDAT,DHPTODAT,DHPJSON)
 Q
 ;
 ;  --------------------------------------------------
 ;  get record specified by resource ID bridge routine
 ;  --------------------------------------------------
 ;
GETRESID ; get record specified by resource ID
 ;
 ;   DHPGETRESID
 ;
 F I="RESID" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 D GETREC^SYNDHP99(.RETSTA,DHPRESID)
 Q
 ;
 ;  ---------------------------------------------
 ;  Mappings bridge routine
 ;  ---------------------------------------------
 ;
MAPSVC ; get mapped code for a given source and code
 ;
 ;   DHPMAPSVC
 ;
 D PARSEMAP
 D MAPSVC^SYNDHP83(.RETSTA,DHPMAP,DHPCODE,DHPDIR,DHPIOE)
 Q
 ;
 ;  ---------------------------------------------
 ;  Facility Suffix Parameter bridge routine
 ;  ---------------------------------------------
 ;
SYSFAC ; get system facility  suffix parameter
 ;
 ;   DHPSYSFACUPD
 ;
 S DHPFAC="DHP"_$$GETPARAM^RGNETWWW(1)
 D GETFACID^SYNDHP69(.RETSTA,DHPFAC)
 Q
 ;
LOGRST ; expunge VPRHTTP("log"
 ;
 ;   DHPVPRLOGRST
 ;
 D LOGRST^SYNDHP69(.RETSTA)
 Q
 ;
 ;  -------------------------------------
 ;
PARSEICN ; ICN PARSER
 ;
 F I="ICN" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 Q
 ;
PARSETRAITS ; Traits parser
 ;
 F I="SSN","DOB","GENDER" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 S DHPNAME=$$GETPARAM^RGNETWWW("NAME",1,1)
 S DHPNAME=DHPNAME_","_$$GETPARAM^RGNETWWW("NAME",1,2)_" "
 Q
 ;
PARSEMAP ; Map parser
 ;
 F I="MAP","CODE","DIR","IOE" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 Q
