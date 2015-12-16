ECXUTL3 ;ALB/GTS - Utilities for DSS Extracts ;3/26/15  16:33
 ;;3.0;DSS EXTRACTS;**11,24,32,33,35,37,39,42,46,92,105,120,144,149,154**;Dec 22,1997;Build 13
 ;
OUTPTTM(ECXDFN,ECXDT) ;* Return PC Team from PCMM files or DPT
 ; Variables -
 ;            ECXDFN - IEN from Patient file (Required)
 ;            ECXDT  - Relevant Date for Primary Care Team
 ;                      (Defaults to DT)
 ;
 ; Returned: ECXTM -
 ;            Pointer to team file (#404.51)
 ;            or, if error or none defined, returns 0
 ;
 Q:'$G(ECXDFN) 0 ;** Quit if ECXDFN not defined
 N ECXTM
 S:'$D(ECXDT) ECXDT=DT
 I $T(OUTPTTM^SDUTL3)[",SCDATE" D
 .S ECXTM=+$$OUTPTTM^SDUTL3(ECXDFN,ECXDT)
 I $T(OUTPTTM^SDUTL3)'[",SCDATE" D
 .S ECXTM=+$$OUTPTTM^SDUTL3(ECXDFN)
 I ECXTM=0 D
 .S ECXTM=+$P($G(^DPT(+ECXDFN,"PC")),U,2)
 Q ECXTM
 ;
OUTPTPR(ECXDFN,ECXDT) ;* Return PC Provider from PCMM files or DPT
 ; Variables -
 ;            ECXDFN - IEN from Patient file (Required)
 ;            ECXDT  - Relevant Date for Primary Care Provider
 ;                      (Defaults to DT)
 ;
 ; Returned: ECXPR -
 ;            Pointer to file #200 
 ;            or, if error or none defined, returns a 0
 ;
 Q:'$G(ECXDFN) 0 ;** Quit if ECXDFN not defined
 N ECXPR
 S:'$D(ECXDT) ECXDT=DT
 I $T(OUTPTPR^SDUTL3)[",SCDATE" D
 .S ECXPR=+$$OUTPTPR^SDUTL3(ECXDFN,ECXDT)
 I $T(OUTPTPR^SDUTL3)'[",SCDATE" D
 .S ECXPR=+$$OUTPTPR^SDUTL3(ECXDFN)
 I ECXPR=0 D
 .S ECXPR=+$G(^DPT(+ECXDFN,"PC"))
 Q ECXPR
 ;
PAT(ECXDFN,ECXDATE,ECXDATA,ECXPAT) ;Return basic patient data for extract
 ; Will not return data associated with test patients (SSN begin w 00000)
 ; Variables -
 ;  Input  ECXDFN - Patient internal entry number, DFN file#2; required
 ;         ECXDATE- Date used to get specific data from GETSTAT^DGMSTAPI
 ;                  for MST. If no date, defaults to today's date,
 ;                  standard FM format, optional
 ;         ECXDATA- Code indicating which data to return, optional.
 ;                  If code not specified then returns all. Codes are:
 ;                  1 - DEM^VADPT (demographic data)
 ;                  2 - ADD^VADPT (current address)
 ;                  3 - ELIG^VADPT (eligibility & enrollment location)
 ;                  4 - OPD^VADPT (other patient data)
 ;                  5 - SVC^VADPT & GETSTAT^DGMSTAPI (service & MST inf)
 ;         ECXPAT(- Passed by reference; required
 ;
 ;  Output:
 ;         ECXPAT   0 error or test patient no data in ECXPAT array
 ;                  1 data returned in ECXPAT array
 ;         ECXPAT(  Local array with patient data.
 ;
 N SSN,I,ECXCOD,ECXDAT,DFN,VAPA,VADM,VAEL,VAPD,VASV,STR,ECXAR,DIC,DIQ,RCNUM,RCVAL,COLMETH
 N DA,DR,PELG,MELIG,ZIP,MPI
 I ECXDFN="" Q 0
 S SSN=$$GET1^DIQ(2,ECXDFN,.09,"I"),DFN=ECXDFN,ECXPAT=0
 ;I $E(SSN,1,3)="000"!(SSN="") K ECXPAT Q 0  ;154 removed as these checks are done in ECXUTL5 ;test patient
 ;test patient extended checks; mtl extract excluded
 I $G(ECHEAD)'="MTL" D  I $G(ECXPAT)="" Q 0  ;154 modified section for SSN testing
 .I $G(ECHEAD)="ECS" I $E(SSN,1,5)="00000" I "^CH103^CH104^CH105^CH106^CH107^CH108^CH109^"[("^"_$G(ECPNM)_"^") Q  ;154 If event capture extract and 5 leading zeroes test patient and workload is CH103 to CH109 then allow test SSN
 .I '$$SSN^ECXUTL5(SSN) K ECXPAT
 S STR="NAME;SSN;DOB;SEX;RACE;RELIGION;STATE;COUNTY;ZIP;SC%;MEANS;ELIG;"
 S STR=STR_"EMPLOY;AO STAT;IR STAT;EC STAT;POW STAT;POW LOC;MST STAT;"
 S STR=STR_"ENROLL LOC;MPI;VIETNAM;POS;MARITAL;CL STAT;COMBSVCI;COMBSVCL" ;149 COMB SVS IND,LOC
 ;initialize return array values
 F I=1:1 S ECXDAT=$P(STR,";",I) Q:ECXDAT=""  S ECXPAT(ECXDAT)=""
 F I=1:1:$L(ECXDATA,";") S ECXDAT=$P(ECXDATA,";",I) I ECXDAT'="" D
 . S ECXCOD(ECXDAT)=""
 ;
 ;- Get ICN if MPI installed
 S X="MPIF001" X ^%ZOSF("TEST") I $T D
 .;
 .;- Get 1st piece (either ICN # or -1 if error)
 . S MPI=+$$GETICN^MPIF001(DFN)
 .;
 .;- If error, set to null
 . S ECXPAT("MPI")=$S(MPI>0:MPI,1:"")
 D  ;get demographic data
 . I ECXDATA'="",'$D(ECXCOD(1)) Q
 . D DEM^VADPT
 . S ECXPAT("NAME")=$E($P(VADM(1),",")_"    ",1,4)
 . S ECXPAT("SSN")=$P(VADM(2),U),ECXPAT("MARITAL")=$P(VADM(10),U)
 . S ECXPAT("DOB")=$$ECXDOB^ECXUTL($P(VADM(3),U))
 . S ECXPAT("SEX")=$P(VADM(5),U),ECXPAT("RELIGION")=$P(VADM(9),U)
 . S DIC=10,DR=2,DA=+VADM(8),DIQ="ECXAR",DIQ(0)="I" D EN^DIQ1
 . S ECXPAT("RACE")=$G(ECXAR(10,DA,DR,"I")),ECXPAT=1
 . ;add new race and ethnicity fields for FY2003
 . S (ECXPAT("ETHNIC"),ECXPAT("RACE1"))=""
 . S X="DGUTL4" X ^%ZOSF("TEST") I $T D
 .. S COLMETH=$$PTR2CODE^DGUTL4($G(VADM(11,1,1)),3,4) I COLMETH="S" D
 ... S ECXPAT("ETHNIC")=$$PTR2CODE^DGUTL4(+$G(VADM(11,1)),2,4)
 .. S (RCVAL,RCNUM)=""
 .. F  S RCNUM=$O(VADM(12,RCNUM)) Q:RCNUM=""  Q:RCVAL="C"  S COLMETH=$$PTR2CODE^DGUTL4(+$G(VADM(12,RCNUM,1)),3,4) I COLMETH="S" D
 ... S RCVAL=$$PTR2CODE^DGUTL4(+$G(VADM(12,RCNUM)),1,4)
 ... I RCVAL="C" S ECXPAT("RACE1")=RCVAL Q
 ... S ECXPAT("RACE1")=ECXPAT("RACE1")_RCVAL
 .I ECXPAT("RACE1")="" S ECXPAT("RACE1")=$$CHECKRC(+VADM(8)) ;144 If RACE1 is null, check value in RACE field
 D  ;get address information
 . I ECXDATA'="",'$D(ECXCOD(2)) Q
 . D ADD^VADPT
 . S DIC=5,DR=2,DA=+VAPA(5),DIQ="ECXAR",DIQ(0)="I" D EN^DIQ1
 . S ECXPAT("STATE")=$G(ECXAR(5,DA,DR,"I"))
 . S DIC=5,DA=+VAPA(5),DR=3,DR(5.01)=2,DA(5.01)=+VAPA(7),DIQ="ECXAR"
 . S DIQ(0)="I" D EN^DIQ1
 . S ECXPAT("COUNTY")=$G(ECXAR(5.01,DA(5.01),2,"I"))
 . S ECXPAT("ZIP")=$P(VAPA(11),U,2)
 . S ECXPAT("COUNTRY")=$$GET1^DIQ(779.004,+$P($G(VAPA(25)),U),.01)
 . S ECXPAT=1
 D  ;get eligibility information
 . I ECXDATA'="",'$D(ECXCOD(3)) Q
 . D ELIG^VADPT
 . S PELG=$P(VAEL(1),U),MELIG=$S(PELG="":"",1:$$GET1^DIQ(8,PELG,8,"I"))
 . S ECXPAT("POS")=$P($G(^DIC(21,+VAEL(2),0)),U,3)
 . S ECXPAT("SC STAT")=$S(+VAEL(3):"Y",+VAEL(3)=0:"N",1:"")
 . S ECXPAT("SC%")=$P(VAEL(3),U,2)
 . S ECXPAT("VET")=$S(VAEL(4):"Y",VAEL(4)=0:"N",1:"")
 . S ECXPAT("MEANS")=$P(VAEL(9),U),ECXPAT=1
 . S ECXPAT("ELIG")=$$ELIG(MELIG,ECXPAT("SC%"))
 . ;get enrollment location
 . S DIC=2,DR=27.02,DA=ECXDFN,DIQ="ECXAR",DIQ(0)="I" D EN^DIQ1
 . S ECXDAT=$G(ECXAR(2,ECXDFN,DR,"I")) I ECXDAT K ECXAR D
 . . S DIC=4,DA=ECXDAT,DR=99,DIQ="ECXAR",DIQ(0)="I" D EN^DIQ1
 . . S ECXPAT("ENROLL LOC")=ECXAR(4,ECXDAT,DR,"I")
 . ;get Emergency Response Indicator (FEMA)
 . S ECXPAT("ERI")=$$GET1^DIQ(2,ECXDFN,.181,"I")
 D  ;get other patient information
 . I ECXDATA'="",'$D(ECXCOD(4)) Q
 . D OPD^VADPT
 . S ECXPAT("EMPLOY")=$P(VAPD(7),U),ECXPAT=1
 D  ;get service information
 . I ECXDATA'="",'$D(ECXCOD(5)) Q
 . D SVC^VADPT
 . S ECXPAT("VIETNAM")=$S(VASV(1):"Y",VASV(1)=0:"N",1:"U") ;149 
 . S ECXPAT("AO STAT")=$S(VASV(2):"Y",VASV(2)=0:"N",1:"U")
 . S ECXPAT("IR STAT")=$S(VASV(3):"Y",VASV(3)=0:"N",1:"U")
 . S ECXPAT("EC STAT")=$$GET1^DIQ(2,ECXDFN,.322013,"I")
 . S ECXPAT("POW STAT")=$S(VASV(4):"Y",VASV(4)=0:"N",1:"U")
 . S ECXPAT("POW LOC")=$P(VASV(4,3),U),ECXPAT=1
 . S ECXPAT("PHI")=$S(VASV(9)=1:"Y",VASV(9)=0:"N",1:"")
 . S ECXPAT("CL STAT")=$S($G(VASV(15)):"Y",$G(VASV(15))=0:"N",1:"") ;144,149 Camp Lejeune status will be in VASV(15) when SVC^VADPT provides it
 . ;- Agent Orange Location (K=Korean DMZ,V=Vietnam)
 . S ECXPAT("AOL")=$P($G(VASV(2,5)),U)
 . S ECXPAT("COMBSVCI")=$S(VASV(5):"Y",VASV(5)=0:"N",1:"") ;149 COMBAT SVC IND
 . S ECXPAT("COMBSVCL")=$$GET1^DIQ(22,$P($G(VASV(5,3)),"^"),1) ;149 COMBAT SVC LOC USE ABBR
 . ;get patient OEF/OIF status and date of return
 . D OEFDATA^ECXUTL4
 . ;
 . ;get patient current MST status
 . I ECXDATE'="",ECXDATE'["." S ECXDATE=ECXDATE+.9
 . S X="DGMSTAPI" X ^%ZOSF("TEST") I $T D
 . . S ECXDAT=$$GETSTAT^DGMSTAPI(DFN,ECXDATE)
 . . S ECXPAT("MST STAT")=$S(+ECXDAT>0:$P(ECXDAT,U,2),1:"")
 I 'ECXPAT K ECXPAT Q 0
 Q 1
 ;
ELIG(ECXELIG,ECXSVCP) ;Converts veteran eligibility code to NPCD code
 ; Variables -
 ;  Input  ECXELIG - Pointer to MAS ELIGIBILITY CODE file #8.1
 ;         ECXSVCP - Number value rep. service connected percentage.
 ;
 ;  Output:
 ;         ECXNCPD  NPCD Eligibility Code
 ;
 N TEXT,IEN,SCPER,FND,NPCD,I,ECXBG,ECXEN,ECXNPCD
 I ECXELIG="" Q ""
 F I=1:1 S TEXT=$P($T(ELGTXT+I),";",3,999) Q:TEXT="END"  D  I $D(NPCD) Q
 . S IEN=$P(TEXT,";"),SCPER=$P(TEXT,";",2)
 . I ECXELIG=IEN D
 . . I SCPER="" S NPCD=$P(TEXT,";",3) Q
 . . S ECXBG=$S($E(SCPER)="<":0,$E(SCPER)=">":$P(SCPER,">",2)+1,SCPER["-":+SCPER,1:"")
 . . S ECXEN=$S($E(SCPER)="<":$P(SCPER,"<",2),$E(SCPER)=">":100,SCPER["-":$P(SCPER,"-",2),1:"")
 . . I ECXSVCP'<ECXBG,ECXSVCP'>ECXEN S NPCD=$P(TEXT,";",3)
 S ECXNPCD=$G(NPCD)
 Q ECXNPCD
ELGTXT ;Eligibility codes
 ;;1;>49;10;SC 50-100%
 ;;2;;20;Aid & Attendance
 ;;15;;21;Housebound
 ;;16;;22;Mexican Border War
 ;;17;;23;WWI
 ;;18;;24;POW
 ;;3;40-49;30;SC 40-49%
 ;;3;30-39;31;SC 30-39%
 ;;3;20-29;32;SC 20-29%
 ;;3;10-19;33;SC 10-19%
 ;;3;<10;34;SC less than 10%
 ;;4;;40;NSC - VA Pension
 ;;5;;50;NSC
 ;;21;;60;Catastrophic Disability
 ;;12;;101;CHAMPVA
 ;;13;;102;Collateral of Veteran
 ;;14;;103;Employee
 ;;6;;104;Other Federal Agency
 ;;7;;105;Allied Veteran
 ;;8;;106;Humanitarian Emergency
 ;;9;;107;Sharing Agreement
 ;;10;;108;Reimbursable Insurance
 ;;19;;109;TRICARE/CHAMPUS
 ;;22;;25;Purple Heart Recipient
 ;;END
 ;
CPT(ECXCPT,ECXMOD,ECXQUA) ;Returns a str with CPT code and modifier codes
 ;Return string is composed of a 5 character CPT code 2 character quantity
 ;plus up to 5 modifier codes, 2 characters each.
 ; Variables -
 ;  Input  ECXCPT  - Pointer value to the CPT file (#81)
 ;         ECXMOD - A string with pointer values to the CPT
 ;                   MODIFIER file (#81.3) separated by ";"
 ;         ECXQUA  - Number of time this procedure performed
 ;
 ;  Output:
 ;         CPTMOD  - String of up to 17 characters, 5 character CPT
 ;                   code 2 character qty plus up to 5 2-character
 ;                   code modifiers.
 ;
 N CPT,MOD,I,CPTMOD
 S ECXQUA=$G(ECXQUA,"01"),ECXMOD=$G(ECXMOD)
 S:$L(ECXQUA)'=2 ECXQUA="0"_ECXQUA
 S CPT=$$CPT^ICPTCOD(ECXCPT,"") I +CPT=-1 Q ""
 S CPT=$P(CPT,U,2)_ECXQUA
 F I=1:1:99 I $P(ECXMOD,";",I)'="" D
 . S MOD=$$MOD^ICPTMOD($P(ECXMOD,";",I),"I","")
 . I +MOD>0,$P(MOD,U,2)'="99" S CPT=CPT_$P(MOD,U,2)
 S CPTMOD=$TR($E(CPT,1,17)," ")
 Q CPTMOD
 ;
CPTOUT(ECXCPT) ;output transform for CPT code plus modifiers
 ;input  ECXCPT  - character string of CPT code plus modifiers (required)
 ;
 N J,CPTX,MOD,MODS,MODX,CPTMOD
 Q:$G(ECXCPT)="" ""
 S (CPTMOD,MODX)=""
 S CPTX="("_+$E(ECXCPT,6,7)_") "_$E(ECXCPT,1,5),MODS=$E(ECXCPT,8,17)
 F J=1:2:9 S MOD=$E(MODS,J,J+1) Q:MOD=""  D
 .I J>1 S MODX=MODX_", "_MOD Q
 .S MODX=MODX_"-"_MOD
 S:$L(CPTX)>3 CPTMOD=CPTMOD_CPTX_MODX
 Q CPTMOD
 ;
CHECKRC(RACEIEN) ;144 API added to check RACE for non-stardard values that can be converted.  If the value can be converted then it will be stored in RACE1 upon return
 N NAME,DIC,X,Y,PTFVAL
 S NAME=$$PTR2TEXT^DGUTL4(RACEIEN)
 S PTFVAL=""
 I NAME="AMER INDIAN OR ALASKAN NATIVE"!(NAME="AMERICAN INDIAN")!(NAME="AMERICAN INDIAN/ALASKAN NATIVE")!(NAME="AMERICAN INDIAN OR ALASKAN NATIVE") S X="AMERICAN INDIAN OR ALASKA NATIVE"
 I NAME="AMERICAN INDIAN/ALASKA NATIVE"!(NAME="AMERICAN INDIAN/ALASKAN")!(NAME="AMERICAN INDIANT OR ALASKA NATIVE") S X="AMERICAN INDIAN OR ALASKA NATIVE"
 I NAME="BLACK"!(NAME="BLACK NOT OF HISP ORIG")!(NAME="BLACK, NON HISPANIC")!(NAME="BLACK, NOT OF HISPANIC ORIGIN") S X="BLACK OR AFRICAN AMERICAN"
 I NAME="BLACK,NOT OF HISPANIC ORIGIN"!(NAME="HISPANIC BLACK")!(NAME="HISPANIC, BLACK")!(NAME="HISPANIC,BLACK") S X="BLACK OR AFRICAN AMERICAN"
 I NAME="WHITE NOT OF HISP ORIG"!(NAME="WHITE, NON HISPANIC")!(NAME="WHITE, NOT OF HISPANIC")!(NAME="WHITE, NOT OF HISPANIC ORIGIN")!(NAME="WHITE,NOT OF HISPANIC ORIGIN") S X="WHITE"
 I NAME="CAUCASIAN"!(NAME="CAUCASIAN, NOT OF HISPANIC ORIGIN")!(NAME="HISPANIC WHITE")!(NAME="HISPANIC, WHITE")!(NAME="HISPANIC,WHITE") S X="WHITE"
 I NAME="PACIFIC ISLANDER" S X="NATIVE HAWAIIAN OR OTHER PACIFIC ISLANDER"
 S DIC(0)="MQ",DIC=10 D ^DIC ;Find standard race in RACE file
 I Y S PTFVAL=$$PTR2CODE^DGUTL4(+Y,1,4) ;If found, get PTF value to return
 Q PTFVAL
