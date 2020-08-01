SYNDHP47 ; HC/fjf/art - HealthConcourse - retrieve patient demographics ;2019-11-15  1:53 PM
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 ; (c) 2017-2019 Perspecta
 ; (c) 2019 OSEHRA
 ; 
 ; Licensed under the Apache License, Version 2.0 (the "License");
 ; you may not use this file except in compliance with the License.
 ; You may obtain a copy of the License at
 ; 
 ; http://www.apache.org/licenses/LICENSE-2.0
 ; 
 ; Unless required by applicable law or agreed to in writing, software
 ; distributed under the License is distributed on an "AS IS" BASIS,
 ; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 ; See the License for the specific language governing permissions and
 ; limitations under the License.
 ;
 QUIT
 ;
 ; ----------------  Get Patient Demographics  ----------------------
 ;
PATDEM(RETSTA,NAME,SSN,DOB,GENDER,RETJSON) ; get demographics for a patient by traits
 S RETSTA="-1^This service has been retired"
 QUIT
 ; Return patient demographics for name, SSN, DOB, and gender
 ;
 ; Input:
 ;   NAME    - patient name
 ;   SSN     - social security number
 ;   DOB     - date of birth
 ;   GENDER  - gender
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return patient demographics string (default)
 ; Output:
 ;   RETSTA  - a delimited string that has the following
 ;             ICN^Name^Phone Number^Gender^Date of Birth^Address1,Address2,Address3,^City^State^ZIP^resID
 ;          or patient demographics in JSON format
 ;
 ; validate patient
 N ICNST
 D PATVAL^SYNDHP43(.ICNST,NAME,SSN,DOB,GENDER)
 I +ICNST'=1 S RETSTA=ICNST QUIT
 S DHPICN=$P(ICNST,U,3)
 ; get patient IEN from ICN
 S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 ;
 ; get patient demographics
 N PATARRAY
 S RETSTA=$$GETPATS(.PATARRAY,PATIEN)
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.PATARRAY,.RETSTA)
 ;
 QUIT
 ;
 ; ----------------  Get Patient Demographics  ----------------------
 ;
PATDEMI(RETSTA,DHPICN,RETJSON) ; get demographics for patient by ICN
 ;
 ; Return patient demographics for given patient ICN
 ;
 ; Input:
 ;   ICN     - unique patient identifier across all VistA systems
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return patient demographics string (default)
 ; Output:
 ;   RETSTA  - a delimited string that has the following
 ;             ICN^Name^Phone Number^Gender^Date of Birth^Address1,Address2,Address3^City^State^ZIP^resID
 ;             ^self identified gender^email^language name,lang iso 639-1 code,lang system (hardcoded)
 ;             ^race text,race hl7 code,race hl7 system (hardcoded)
 ;             ^ethnicity text, ethnicity code, ethnicity hl7 system (hardcoded)
 ;
 ; validate ICN
 I $G(DHPICN)="" S RETSTA="-1^What patient?" QUIT
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTA="-1^Patient identifier not recognised" QUIT
 ; get patient IEN from ICN
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 ; get patient demographics
 N PATARRAY
 S RETSTA=$$GETPATS(.PATARRAY,PATIEN)
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.PATARRAY,.RETSTA)
 ;
 QUIT
 ;
GETPATS(PATARRAY,DFN) ; [Private] Get demographics for single patient
 N VA,VADM,VAPA,VAERR
 ; Next two calls: ICR 10061
 D DEM^VADPT
 D ADD^VADPT
 ;
 N RESID,NAME,PHONE,SEX,DOB,ADRS1,ADRS2,ADRS3,CITY,STATE,ZIP,ICN
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 S RESID=$$RESID^SYNDHP69("V",SITE,2,DFN)
 S NAME=VADM(1)
 S SEX=$P(VADM(5),U,2)
 N SID S SID=$$GET1^DIQ(2,DFN,.024) ; Self Identified Gender
 S DOB=$$FMTHL7^XLFDT($P(VADM(3),U)) ; ICR #10103
 S PHONE=VAPA(8)
 S ADRS1=VAPA(1)
 S ADRS2=VAPA(2)
 S ADRS3=VAPA(3)
 S CITY=VAPA(4)
 S STATE=$P(VAPA(5),U,2)
 S ZIP=VAPA(6)
 ;
 N EMAIL S EMAIL=$$GET1^DIQ(2,DFN,.133)
 ;
 ; Language
 N LANG,LANGIEN,LANGCODE,LANGSYS
 S (LANG,LANGCODE,LANGSYS)=""
 S LANG=$P($G(VADM(13,1)),U,2)
 I LANG'="" D
 . S LANGIEN=$$FIND1^DIC(.85,,"X",LANG)
 . S LANGCODE=$$GET1^DIQ(.85,LANGIEN,.02)
 . S LANGSYS="urn:ietf:bcp:47"
 ;
 ; TODO: There can be multiple races, but we won't handle that now
 ; Race
 N RACETEXT,RACECODE,RACESYS
 S (RACETEXT,RACECODE,RACESYS)=""
 I $D(VADM(12,1)) D
 . S RACETEXT=$P(VADM(12,1),U,2)
 . S RACECODE=$$GET1^DIQ(10,$P(VADM(12,1),U),3)
 . S RACESYS="urn:oid:2.16.840.1.113883.6.238"
 ;
 ; TODO: There can be multiple ethnicities, but we won't handle that now
 ; Ethnicity
 N ETHTEXT,ETHCODE,ETHSYS
 S (ETHTEXT,ETHCODE,ETHSYS)=""
 I $D(VADM(11,1)) D
 . S ETHTEXT=$P(VADM(11,1),U,2)
 . S ETHCODE=$$GET1^DIQ(10.2,$P(VADM(11,1),U),3)
 . S ETHSYS="urn:oid:2.16.840.1.113883.6.238"
 ;
 S ICN=$$GETICN^MPIF001(DFN) ; ICR 2701
 I +ICN=-1 S ICN=""
 ;
 N C S C=","
 N PATSTR
 S PATSTR=ICN_U_NAME_U_PHONE_U_SEX_U_DOB_U
 S PATSTR=PATSTR_ADRS1_C_ADRS2_C_ADRS3_U_CITY_U_STATE_U_ZIP_U
 S PATSTR=PATSTR_RESID_U_SID_U_EMAIL_U_LANG_C_LANGCODE_C_LANGSYS_U
 S PATSTR=PATSTR_RACETEXT_C_RACECODE_C_RACESYS_U
 S PATSTR=PATSTR_ETHTEXT_C_ETHCODE_C_ETHSYS
 QUIT PATSTR
 ;
PATDEMAL(RETSTA,DHPICN,RETJSON) ; [PUBLIC URL] /DHPPATDEMALL? get demographics for all patients
 ;
 ; Return patient demographics for all patients
 ;
 ; Input:
 ;   RETJSON - J = Return JSON (JSON is not currently supported for this call)
 ;             F = Return FHIR
 ;             0 or null = Return patient demographics string (default)
 ; Output:
 ;   RETSTA  - a delimited string that has the following
 ;             ICN^Name^Phone Number^Gender^Date of Birth^Address1,Address2,Address3^City^State^ZIP^resID
 ;             ^self identified gender^email^language name,lang iso 639-1 code,lang system (hardcoded)
 ;             ^race text,race hl7 code,race hl7 system (hardcoded)
 ;             ^ethnicity text, ethnicity code, ethnicity hl7 system (hardcoded)
 ;
 I ($G(RETJSON)="J"!($G(RETJSON)="F")) S RETSTA="-1^JSON for all patients is currently not supported" QUIT
 ;
 ; ZEXCEPT: HTTPARGS,SYNDEBUG
 ;
 ; New Variables for EN1^DIP
 N L,DIC,FLDS,BY,DR,FR,TO,DHD
 N HDH,DIASKHD,DIPCRIT,PG,DHIT
 N DIOEND,DIOBEG
 N DCOPIES
 N IOP,%ZIS
 N DQTIME
 N DIS,DISUPNO,DISPAR
 N DISTOP
 ;
 ; Output variables
 N SYNCT S SYNCT=0
 K ^TMP("SYNPATALL",$J)
 ;
 ; Setup minimum environment for Fileman
 N DIQUIET S DIQUIET=1
 D DT^DICRW
 ;
 ; Set-up main variables for ^DIP
 S DIC=2                        ; Patient File
 S FLDS="NUMBER"                ; Print IEN only
 S DHD="@@"                     ; No headers
 S DHIT="D COLLECT^"_$T(+0)     ; Call back on each entry
 S %ZIS="0"                     ; DO NOT OPEN HOME DEVICE! SOOO IMPORTANT!
 S IOP="NULL"                   ; Send output to null device
 I $D(SYNDEBUG) S IOP="0;132;9999999",%ZIS="" ; or send output to screen if debugging
 ;
 ; FN as FR,TO subscript
 N FN S FN=1
 ;
 ; If we have an identifier, don't sort on anything else. Figure this out and send it off.
 I $data(HTTPARGS("identifier"))!($data(HTTPARGS("_id"))) do  do PRINT quit
 . n id1
 . i $data(HTTPARGS("identifier")) s id1=HTTPARGS("identifier")
 . i $data(HTTPARGS("_id"))        s id1=HTTPARGS("_id")
 . n hasType,type,id
 . s hasType=id1["|"
 . i 'hasType s type="icn",id=id1
 . i hasType do
 .. n typeNote s typeNote=$p(id1,"|")
 .. s id=$p(id1,"|",2)
 .. i typeNote["icn"    s type="icn"
 .. e  i typeNote["dfn" s type="dfn"
 .. e  i typeNote["ssn" s type="ssn"
 .. e  s type="icn"
 . ;
 . if type="icn" S BY="'@991.1"
 . if type="dfn" S BY="'NUMBER"
 . if type="ssn" S BY="'@.09"
 . S FR(FN)=id
 . S TO(FN)=id
 ;
 ; BY for DIP
 ; Default sort; Sort output by name
 S BY=".01"
 S FR(FN)="",TO(FN)=""
 ;
 n z ; last character
 n Y I $D(^DD("OS",^DD("OS"),"HIGHESTCHAR")) X ^("HIGHESTCHAR")
 s z=$get(Y,"z")
 ;
 ; Name or Last Name
 ; Reuse first level sort
 i $data(HTTPARGS("name"))!($data(HTTPARGS("family"))) do
 . n name
 . i $data(HTTPARGS("name"))   s name=HTTPARGS("name")
 . i $data(HTTPARGS("family")) s name=HTTPARGS("family")
 . s name=$$UP^XLFSTR(name)
 . S FR(1)=name
 . S TO(1)=name_z
 ;
 ; DOB
 I $data(HTTPARGS("birthdate")) do
 . n birthdate s birthdate=HTTPARGS("birthdate")
 . n start,stop
 . i $l(birthdate,"-")=3 s (start,stop)=birthdate
 . i $l(birthdate,"-")=2 d
 .. s birthdate=$p(birthdate,"-",2)_"-"_$p(birthdate,"-",1) ; VA Fileman can't interpret 1905-08 but can 08-1905.
 .. s start=birthdate
 .. s stop=$p(birthdate,"-")+1_"-"_$p(birthdate,"-",2)
 . i $l(birthdate,"-")=1 s start=birthdate,stop=birthdate+1
 . S FN=FN+1
 . S BY=BY_",'@.03"
 . S FR(FN)=start
 . S TO(FN)=stop
 ;
 ; Sex
 I $data(HTTPARGS("gender")) do
 . N SEX S SEX=$$UP^XLFSTR($E(HTTPARGS("gender")))
 . S FN=FN+1
 . S BY=BY_",'@.02"
 . S FR(FN)=SEX
 . S TO(FN)=SEX
 ;
 ; Given Name. Walk over to name components and search that file.
 if $data(HTTPARGS("given")) do
 . S FN=FN+1
 . S BY=BY_",'@1.01:2"
 . n given s given=$$UP^XLFSTR(HTTPARGS("given"))
 . S FR(FN)=given
 . S TO(FN)=given_z
 ;
PRINT ; [Fall through]
 ; Paging support SYNMAX and SYNSKIPTO
 N SYNMAX
 I $d(HTTPARGS("_count")) set SYNMAX=HTTPARGS("_count")
 else  set SYNMAX=100
 ;
 N SYNSKIPTO
 I $d(HTTPARGS("_page")) set SYNSKIPTO=(HTTPARGS("_page")-1)*SYNMAX
 else  set SYNSKIPTO=0
 ;
 ; Central Call. Will call back COLLECT at each entry.
 D EN1^DIP
 ;
 I $G(^TMP("SYNPATALL",$J,SYNCT))'="" S $E(^TMP("SYNPATALL",$J,SYNCT),$L(^TMP("SYNPATALL",$J,SYNCT)))=""  ; remove trailing "|"
 ;
 ; Return variable
 S RETSTA=$NA(^TMP("SYNPATALL",$J))
 ;
 ; Currently not used
 ;I $G(RETJSON)="J"!($G(RETJSON)="F") D
 ;. S RETSTA=""
 ;. D TOJASON^SYNDHPUTL(.PATARRAY,.RETSTA)
 QUIT
 ;
COLLECT ; [Internal; call back from EN1^DIP
 ; Skip previous "pages"
 ; ZEXCEPT:DN,D0 from EN1^DIP
 ; ZEXCEPT:SYNSKIPTO,SYNCT,SYNMAX newed above 
 I SYNSKIPTO>0 S SYNSKIPTO=SYNSKIPTO-1 QUIT
 ;
 ; Count entry
 S SYNCT=SYNCT+1
 N PATARRAY,PATSTR ; PATARRAY not used
 S PATSTR=$$GETPATS(.PATARRAY,D0)
 S ^TMP("SYNPATALL",$J,SYNCT)=PATSTR_"|"
 I SYNCT>(SYNMAX-1) S DN=0,D0=-1 ; Stop Print loop
 QUIT
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 ;
PATDEMRNG(RETSTA,DHPPATS,RETJSON) ; get demographics for range of patients
 ;
 ; Return patient demographics for a range of patients
 ;
 ; Input:
 ;   DHPPATS - mmmmRnnnn where nnnn and mmmm are patient DFNs, mmmm<nnnn (limited 1000 patients for JSON)
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return patient demographics string (default)
 ; Output:
 ;   RETSTA  - a delimited string that has the following
 ;             ICN^Name^Phone Number^Gender^Date of Birth^Address1,Address2,Address3,^City^State^ZIP^resID|...
 ;          or patient demographics in JSON format
 ;
 ;
 N C,M,S,SOR,EOR,N,NOPATS,PATIEN,PTNTS,DHPICN,PATSTR,I,RESID
 S C=",",M="R"
 S S="_"
 N SITE S SITE=$P($$SITE^VASITE,U,3)
 ;
 N CT S CT=0
 K ^TMP("DHPPATRNG",$J) S ^TMP("DHPPATRNG",$J)=""
 K ^TMP("DHPCOUNT")
 N PATARRAY
 ;
 I DHPPATS'?1.N1"R"1.N S RETSTA="-1^Invalid range format" QUIT
 S SOR=$P(DHPPATS,M),EOR=$P(DHPPATS,M,2)
 I EOR<SOR S RETSTA="-1^End before beginning" QUIT
 S NOPATS=EOR-SOR+1
 I ($G(RETJSON)="J"!($G(RETJSON)="F")),NOPATS>1000 S RETSTA="-1^please limit JSON request to 1000 patients" QUIT
 ; find first patient IEN
 S PATIEN=SOR-1
 F  S PATIEN=$O(^DPT(PATIEN)) QUIT:(PATIEN>EOR)!(+PATIEN=0)  D
 .;W !,PATIEN
 .;Q
 .S PATSTR=$$GETPATS(.PATARRAY,PATIEN)
 .S ^TMP("DHPPATRNG",$J)=^TMP("DHPPATRNG",$J)_PATSTR_"|"
 .S CT=CT+1
 .S ^TMP("DHPCOUNT",$J,CT)=PATSTR
 S RETSTA=^TMP("DHPPATRNG",$J)
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.PATARRAY,.RETSTA)
 ;
 Q
 ;
 ; ----------- Unit Test -----------
TEST D EN^%ut($t(+0),3) quit
SETUP N X S X=0 X ^%ZOSF("RM") quit
T1 ;
 N ICN S ICN="1034989029V875306"
 N JSON S JSON=""
 N RETSTA
 D PATDEMI(.RETSTA,ICN,JSON)
 W $$ZW^SYNDHPUTL("RETSTA"),!!
 QUIT
 ;
T2 ;
 N ICN S ICN="1034989029V875306"
 N JSON S JSON="J"
 N RETSTA
 D PATDEMI(.RETSTA,ICN,JSON)
 W $$ZW^SYNDHPUTL("RETSTA"),!!
 QUIT
 ;
T3 ;
 N RANGE S RANGE="10R15"
 N JSON S JSON=""
 N RETSTA
 D PATDEMRNG(.RETSTA,RANGE,JSON)
 W $$ZW^SYNDHPUTL("RETSTA"),!!
 QUIT
 ;
T4 ;
 N RANGE S RANGE="10R15"
 N JSON S JSON="J"
 N RETSTA
 D PATDEMRNG(.RETSTA,RANGE,JSON)
 W $$ZW^SYNDHPUTL("RETSTA"),!!
 QUIT
 ;
T5 ; @TEST Get all Patients
 N ICN S ICN="ALL"
 N JSON S JSON=""
 N RETSTA
 D PATDEMAL(.RETSTA,ICN,JSON)
 w ! D ZWRITE^SYNDHPUTL(RETSTA)
 D CHKTF^%ut($O(@RETSTA@(0))>0)
 QUIT
 ;
T6 ; @TEST Get some patients by Given Name (AB)
 n RETSTA
 n HTTPARGS
 s HTTPARGS("given")="AB"
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 d CHKTF^%ut($O(@RETSTA@(0))>0)
 quit
 ;
T7 ; @TEST Get some patients by Last (B) and Given names (AL)
 n RETSTA
 n HTTPARGS
 s HTTPARGS("given")="AL"
 s HTTPARGS("family")="B"
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 d CHKTF^%ut($O(@RETSTA@(0))>0)
 quit
 ;
T8 ; @TEST Get some patients by exact DOB 2010-01-17
 n RETSTA
 n HTTPARGS
 s HTTPARGS("birthdate")="2010-01-17"
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 d CHKTF^%ut($O(@RETSTA@(0))>0)
 quit
 ;
T9 ; @TEST Get some patients by inexact DOB 2010-01
 n RETSTA
 n HTTPARGS
 s HTTPARGS("birthdate")="2010-01"
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 d CHKTF^%ut($O(@RETSTA@(0))>0)
 quit
 ;
T10 ; @TEST Get some patients by inexact DOB 2010
 n RETSTA
 n HTTPARGS
 s HTTPARGS("birthdate")="2010"
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 d CHKTF^%ut($O(@RETSTA@(0))>0)
 quit
T11 ; @TEST Get patients with inexact DOB 2010 and given name starting with A
 n RETSTA
 n HTTPARGS
 s HTTPARGS("birthdate")="2010"
 s HTTPARGS("given")="A"
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 d CHKTF^%ut($O(@RETSTA@(0))>0)
 quit
 ;
T12 ; @TEST Get patients with identifier by DFN
 n RETSTA
 n HTTPARGS
 s HTTPARGS("identifier")="dfn|1"
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 d CHKTF^%ut($O(@RETSTA@(0))>0)
 quit
 ;
T13 ; @TEST Get patients with identifier by SSN
 n RETSTA
 n HTTPARGS
 s HTTPARGS("identifier")="ssn|999998562"
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 d CHKTF^%ut($O(@RETSTA@(0))>0)
 quit
 ;
T14 ; @TEST Get patients with identifier by ICN
 n RETSTA
 n HTTPARGS
 s HTTPARGS("identifier")="icn|4068085986V151374"
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 d CHKTF^%ut($O(@RETSTA@(0))>0)
 quit
 ;
T15 ; @TEST Get patients with no _count (expect 100)
 n RETSTA
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 n cnt s cnt=0
 n i f i=0:0 s i=$O(@RETSTA@(i)) q:'i  s cnt=cnt+1
 d CHKEQ^%ut(cnt,100)
 quit
 ;
T16 ; @TEST Get patients with _count = 10
 n RETSTA
 n HTTPARGS
 s HTTPARGS("_count")=10
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 n cnt s cnt=0
 n i f i=0:0 s i=$O(@RETSTA@(i)) q:'i  s cnt=cnt+1
 d CHKEQ^%ut(cnt,10)
 quit
 ;
T17 ; @TEST Get patients with _count 10 and page 1
 n RETSTA
 n HTTPARGS
 s HTTPARGS("_count")=10
 s HTTPARGS("_page")=1
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 n cnt s cnt=0
 n i f i=0:0 s i=$O(@RETSTA@(i)) q:'i  s cnt=cnt+1
 d CHKEQ^%ut(cnt,10)
 quit
 ;
T18 ; @TEST Get patients with _count 10 and page 2
 n RETSTA
 n HTTPARGS
 s HTTPARGS("_count")=10
 s HTTPARGS("_page")=2
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 n cnt s cnt=0
 n i f i=0:0 s i=$O(@RETSTA@(i)) q:'i  s cnt=cnt+1
 d CHKEQ^%ut(cnt,10)
 ; Make sure 1st patient is 11th patient in B index
 n cnt s cnt=0
 n i s i="" f  s i=$o(^DPT("B",i)),cnt=cnt+1 q:i=""  q:cnt=11  w i," "
 n name s name=$p(@RETSTA@(1),U,2)
 d CHKEQ^%ut(name,i)
 quit
 ;
T19 ; @TEST Get patients all females with paging
 n RETSTA
 n HTTPARGS
 s HTTPARGS("_count")=100
 s HTTPARGS("_page")=1
 s HTTPARGS("gender")="female"
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 s HTTPARGS("_count")=100
 s HTTPARGS("_page")=2
 s HTTPARGS("gender")="female"
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 s HTTPARGS("_count")=100
 s HTTPARGS("_page")=3
 s HTTPARGS("gender")="female"
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 k HTTPARGS
 s HTTPARGS("_count")=10000
 s HTTPARGS("gender")="female"
 d PATDEMAL(.RETSTA)
 w ! d ZWRITE^SYNDHPUTL(RETSTA)
 quit
 ;
