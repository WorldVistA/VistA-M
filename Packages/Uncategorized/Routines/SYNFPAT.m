SYNFPAT ;ven/gpl - fhir loader utilities ;2018-05-08  4:18 PM
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ;
 q
 ;
importPatient(rtn,ien) ; register and import a fhir patient (demographics only)
 ;
 if $get(ien)="" quit
 new fhir
 do getIntakeFhir^SYNFHIR("fhir",,"Patient",ien)
 ;
 ; set up logging and parameter area
 ;
 new PLD merge PLD=@$$setPLD^SYNFUTL(ien,"Patient")
 new parms set parms=PLD("parms") ; global name of where to put the parms
 ;
 if $g(@PLD("status")@("loadStatus"))="loaded" do  quit  ;
 . new zdfn s zdfn=$g(@PLD("status")@("DFN"))
 . do log^SYNFUTL("Patient "_ien_" already loaded DFN= "_zdfn)
 . set rtn("loadStatus")="already loaded"
 . set rtn("dfn")=zdfn
 ;
 kill @PLD("parms")
 kill @PLD("log")
 ;
 do log^SYNFUTL("Patient load begins for fhirien= "_ien)
 ;
 ; name
 ;
 new patname
 set patname=$$patname("fhir")
 if patname'="" do  ;
 . set @parms@("NAME")=patname
 . do log^SYNFUTL("Patient name is: "_patname)
 else  do log^SYNFUTL("Patient Name Error")
 ; need to find the entry for the Patient resource
 ;
 n zntry s zntry=$o(fhir("Patient","entry",""))
 ;
 ;
 ; gender
 ;
 new psex
 set psex=$get(fhir("Patient","entry",zntry,"resource","gender"))
 if psex'="" do  ;
 . do log^SYNFUTL("Patient gender is: "_psex)
 . set @parms@("SEX")=$select(psex="male":"M",psex="female":"F",1:"F")
 else  do log^SYNFUTL("Patient gender not found")
 ;
 ; date of birth
 ;
 new dob
 set dob=$get(fhir("Patient","entry",zntry,"resource","birthDate"))
 if dob'="" do  ;
 . new X,Y
 . set X=dob
 . do ^%DT
 . if Y=-1 do log^SYNFUTL("Patient date of birth error "_dob) quit  ;
 . set @parms@("DOB")=Y
 else  do log^SYNFUTL("Patient date of birth error "_dob)
 ;
 ; id - fhir id, not ICN
 ;
 new pid
 set pid=$get(fhir("Patient","entry",zntry,"resource","id"))
 if pid="" s pid=$get(fhir("Patient","entry",zntry,"resource","identifier",1,"value"))
 if pid="" do log^SYNFUTL("Patient ID is missing")
 else  do  ;
 . set @parms@("ID")=pid
 . do log^SYNFUTL("Patient ID is "_pid)
 ;
 ; ethnicity code
 ;
 do INITMAPS^SYNQLDM
 new eary,ecd
 ;do adb^SYNFUTL("eary","fhir","text","ethnicity") ; array defined by
 ;set ecd=$get(eary("coding",1,"code")) ; the ethnic code
 set ecd=$$deriveCode("fhir","us-core-ethnicity",zntry)
 if ecd'="" d  ;
 . do log^SYNFUTL("Ethnicity code is "_ecd)
 . new ecdn
 . set ecdn=$$MAP^SYNQLDM(ecd)
 . if ecdn="" do  quit  ;
 . . do log^SYNFUTL("Ethnicity code "_ecd_" does not map")
 . set @parms@("ETHNICITY")=ecdn
 else  do log^SYNFUTL("Ethnicity code missing")
 ;
 ; race code
 ;
 new rary,rcd
 ;do adb^SYNFUTL("rary","fhir","text","race") ; array defined by
 ;set rcd=$get(rary("coding",1,"code")) ; the ethnic code
 set rcd=$$deriveCode("fhir","us-core-race",zntry)
 if rcd'="" d  ;
 . do log^SYNFUTL("Race code is "_rcd)
 . new rcdn
 . set rcdn=$$MAP^SYNQLDM(rcd)
 . if rcdn="" do  quit  ;
 . . do log^SYNFUTL("Race code "_rcd_" does not map")
 . set @parms@("RACE")=rcdn
 else  do log^SYNFUTL("Race code missing")
 ;
 ; address
 ;
 s @parms@("CITY")=$g(fhir("Patient","entry",zntry,"resource","address",1,"city"))
 s @parms@("STATE")=$g(fhir("Patient","entry",zntry,"resource","address",1,"state"))
 s @parms@("ZIP")=$g(fhir("Patient","entry",zntry,"resource","address",1,"postalCode"))
 s @parms@("STREET_ADD1")=$g(fhir("Patient","entry",zntry,"resource","address",1,"line",1))
 s @parms@("PH_NUM")=$g(fhir("Patient","entry",zntry,"resource","telecom",1,"value"))
 s @parms@("IMP_TYPE")="I" ; individual not batch load
 s @parms@("SSN")=$$patssn("fhir")
 s @parms@("MARITAL_STATUS")=$get(fhir("Patient","entry",zntry,"resource","maritalStatus","coding",1,"code"))
 ;
 ; call import routine
 ;
 n MISC
 m MISC=@parms
 n ISIRC s ISIRC=$$IMPORTPT^ISIIMP03(.MISC)
 d log^SYNFUTL("Called IMPORTPT^ISIIMP03 to import patient")
 d log^SYNFUTL("Return code from Import: "_ISIRC)
 d log^SYNFUTL("Return values from Import: "_$G(ISIRESUL(1)))
 i ISIRC="" do  quit  ;
 . d log^SYNFUTL("No return from patient load")
 . s rtn("status")="Patient load error"
 n zdfn s zdfn=0
 i $g(ISIRESUL(1))'="" s zdfn=$P(ISIRESUL(1),"^",1)
 ;
 ; load failed
 ;
 i +zdfn<1 d  q  ;
 . s rtn("loadStatus")="notLoaded"
 . s rtn("loadMessage")=ISIRC
 . s @PLD("status")@("loadStatus")="notLoaded"
 . s @PLD("status")@("loadMessage")=ISIRC
 ;
 ; load successful
 ;
 new icn set icn=$$newIcn2(zdfn,pid)
 if icn'=-1 s @PLD("status")@("ICN")=icn
 s @PLD("status")@("DFN")=zdfn
 s @PLD("status")@("loadStatus")="loaded"
 set @PLD("index")@("DFN",zdfn,ien)=""
 set @PLD("index")@("ICN",icn,ien)=""
 set @PLD("index")@(ien,"DFN",zdfn)=""
 set @PLD("index")@(ien,"ICN",icn)=""
 d setIndex^SYNFUTL(ien,"DFN",zdfn)
 d setIndex^SYNFUTL(ien,"ICN",icn)
 ;
 s rtn("dfn")=zdfn
 s rtn("loadStatus")="loaded"
 if icn'=-1 s rtn("icn")=icn
 ;
 quit
 ;
deriveCode(zary,zname,zntry) ; finds the code for ethnicity and race
 ;
 n zary2,zdex,zz1,zurl,done,zcode
 s zcode=""
 s done=0
 s zzi=0
 f  s zzi=$o(@zary@("Patient","entry",zntry,"resource","extension",zzi)) q:+zzi=0  q:done  d  ;
 . s zurl=$g(@zary@("Patient","entry",zntry,"resource","extension",zzi,"url"))
 . i $$urlEnd^SYNFUTL(zurl)=zname d  ;
 . . m zary2=@zary@("Patient","entry",zntry,"resource","extension",zzi)
 . . d valueDex2^SYNFUTL("zary2","zdex")
 . . q:'$d(zdex)
 . . s zcode=$o(zdex("code",""))
 . . q:zcode=""
 . . s done=1
 q zcode
 ;
patname(ary) ; ary is passed by name
 new given,family
 n zntry s zntry=$o(@ary@("Patient","entry","")) ; which resource is the Patient
 ;
 ; Synthea patient resources are 1; new fhir Patient resources are 2
 ;
 set family=$get(@ary@("Patient","entry",zntry,"resource","name",1,"family"))
 set given=$get(@ary@("Patient","entry",zntry,"resource","name",1,"given",1))
 if family="" quit ""
 if given="" quit ""
 new X,Y
 set X=family
 x ^%ZOSF("UPPERCASE")
 set family=Y
 set X=given
 x ^%ZOSF("UPPERCASE")
 set given=Y
 ;
 quit family_","_given
 ;
patssn(fary) ; extrinsic returns the ssn of the patient extracted from
 ; the fhir array, passed by name
 new ssnref,tary,ssn
 ; set ssnref="http://standardhealthrecord.org/fhir/StructureDefinition/shr-demographics-SocialSecurityNumber-extension"
 set ssnref="http://hl7.org/fhir/sid/us-ssn"
 do adb^SYNFUTL("tary",fary,"system",ssnref) ; array defined by
 ;
 set ssn=$get(tary("value"))
 if ssn["-" set ssn=$tr(ssn,"-","")
 quit ssn
 ;
 ; sample patient fhir
 ;g("Patient","entry",1,"fullUrl")="urn:uuid:a13f2440-a3ec-419a-8259-82710d695fdf"
 ;g("Patient","entry",1,"resource","address",1,"city")="Fitchburg"
 ;g("Patient","entry",1,"resource","address",1,"country")="US"
 ;g("Patient","entry",1,"resource","address",1,"extension",1,"extension",1,"url")="latitude"
 ;g("Patient","entry",1,"resource","address",1,"extension",1,"extension",1,"valueDecimal")=42.562168065623744
 ;g("Patient","entry",1,"resource","address",1,"extension",1,"extension",2,"url")="longitude"
 ;g("Patient","entry",1,"resource","address",1,"extension",1,"extension",2,"valueDecimal")=-71.81748413047194
 ;g("Patient","entry",1,"resource","address",1,"extension",1,"url")="http://hl7.org/fhir/StructureDefinition/geolocation"
 ;g("Patient","entry",1,"resource","address",1,"line",1)="9802 Bosco Field"
 ;g("Patient","entry",1,"resource","address",1,"line",2)="Suite 454"
 ;g("Patient","entry",1,"resource","address",1,"postalCode")="01420"
 ;g("Patient","entry",1,"resource","address",1,"state")="MA"
 ;g("Patient","entry",1,"resource","birthDate")="1925-06-02"
 ;g("Patient","entry",1,"resource","communication",1,"language","coding",1,"code")="en-US"
 ;g("Patient","entry",1,"resource","communication",1,"language","coding",1,"display")="English (United States)"
 ;g("Patient","entry",1,"resource","communication",1,"language","coding",1,"system")="http://hl7.org/fhir/ValueSet/languages"
 ;g("Patient","entry",1,"resource","deceasedDateTime")="2002-10-08T06:31:48-04:00"
 ;g("Patient","entry",1,"resource","extension",1,"url")="http://hl7.org/fhir/us/core/StructureDefinition/us-core-race"
 ;g("Patient","entry",1,"resource","extension",1,"valueCodeableConcept","coding",1,"code")="2106-3"
 ;g("Patient","entry",1,"resource","extension",1,"valueCodeableConcept","coding",1,"display")="White"
 ;g("Patient","entry",1,"resource","extension",1,"valueCodeableConcept","coding",1,"system")="http://hl7.org/fhir/v3/Race"
 ;g("Patient","entry",1,"resource","extension",1,"valueCodeableConcept","text")="race"
 ;g("Patient","entry",1,"resource","extension",2,"url")="http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity"
 ;g("Patient","entry",1,"resource","extension",2,"valueCodeableConcept","coding",1,"code")="2186-5"
 ;g("Patient","entry",1,"resource","extension",2,"valueCodeableConcept","coding",1,"display")="Nonhispanic"
 ;g("Patient","entry",1,"resource","extension",2,"valueCodeableConcept","coding",1,"system")="http://hl7.org/fhir/v3/Ethnicity"
 ;g("Patient","entry",1,"resource","extension",2,"valueCodeableConcept","text")="ethnicity"
 ;g("Patient","entry",1,"resource","extension",3,"url")="http://hl7.org/fhir/StructureDefinition/birthPlace"
 ;g("Patient","entry",1,"resource","extension",3,"valueAddress","city")="Easton"
 ;g("Patient","entry",1,"resource","extension",3,"valueAddress","country")="US"
 ;g("Patient","entry",1,"resource","extension",3,"valueAddress","state")="MA"
 ;g("Patient","entry",1,"resource","extension",4,"url")="http://hl7.org/fhir/StructureDefinition/patient-mothersMaidenName"
 ;g("Patient","entry",1,"resource","extension",4,"valueString")="Jeramie91 Waelchi310"
 ;g("Patient","entry",1,"resource","extension",5,"url")="http://hl7.org/fhir/us/core/StructureDefinition/us-core-birthsex"
 ;g("Patient","entry",1,"resource","extension",5,"valueCode")="M"
 ;g("Patient","entry",1,"resource","extension",6,"url")="http://hl7.org/fhir/StructureDefinition/patient-interpreterRequired"
 ;g("Patient","entry",1,"resource","extension",6,"valueBoolean")="false"
 ;g("Patient","entry",1,"resource","extension",7,"url")="http://standardhealthrecord.org/fhir/StructureDefinition/shr-actor-FictionalPerson-extension"
 ;g("Patient","entry",1,"resource","extension",7,"valueBoolean")="true"
 ;g("Patient","entry",1,"resource","extension",8,"url")="http://standardhealthrecord.org/fhir/StructureDefinition/shr-demographics-FathersName-extension"
 ;g("Patient","entry",1,"resource","extension",8,"valueHumanName","text")="Veronica383 Abbott509"
 ;g("Patient","entry",1,"resource","extension",9,"url")="http://standardhealthrecord.org/fhir/StructureDefinition/shr-demographics-SocialSecurityNumber-extension"
 ;g("Patient","entry",1,"resource","extension",9,"valueString")="999-67-7452"
 ;g("Patient","entry",1,"resource","gender")="male"
 ;g("Patient","entry",1,"resource","id")="a13f2440-a3ec-419a-8259-82710d695fdf"
 ;g("Patient","entry",1,"resource","identifier",1,"system")="https://github.com/synthetichealth/synthea"
 ;g("Patient","entry",1,"resource","identifier",1,"value")="72bcbb80-2cbd-4523-82c1-30a34e08a72a"
 ;g("Patient","entry",1,"resource","identifier",2,"system")="http://hl7.org/fhir/sid/us-ssn"
 ;g("Patient","entry",1,"resource","identifier",2,"type","coding",1,"code")="SB"
 ;g("Patient","entry",1,"resource","identifier",2,"type","coding",1,"system")="http://hl7.org/fhir/identifier-type"
 ;g("Patient","entry",1,"resource","identifier",2,"value")=999677452
 ;g("Patient","entry",1,"resource","identifier",2,"value","\s")=""
 ;g("Patient","entry",1,"resource","identifier",3,"system")="urn:oid:2.16.840.1.113883.4.3.25"
 ;g("Patient","entry",1,"resource","identifier",3,"type","coding",1,"code")="DL"
 ;g("Patient","entry",1,"resource","identifier",3,"type","coding",1,"system")="http://hl7.org/fhir/v2/0203"
 ;g("Patient","entry",1,"resource","identifier",3,"value")="S99925046"
 ;g("Patient","entry",1,"resource","maritalStatus","coding",1,"code")="M"
 ;g("Patient","entry",1,"resource","maritalStatus","coding",1,"system")="http://hl7.org/fhir/v3/MaritalStatus"
 ;g("Patient","entry",1,"resource","maritalStatus","text")="M"
 ;g("Patient","entry",1,"resource","meta","profile",1)="http://standardhealthrecord.org/fhir/StructureDefinition/shr-demographics-PersonOfRecord"
 ;g("Patient","entry",1,"resource","multipleBirthBoolean")="false"
 ;g("Patient","entry",1,"resource","name",1,"family")="Abbott509"
 ;g("Patient","entry",1,"resource","name",1,"given",1)="Arlie395"
 ;g("Patient","entry",1,"resource","name",1,"prefix",1)="Mr."
 ;g("Patient","entry",1,"resource","name",1,"use")="official"
 ;g("Patient","entry",1,"resource","resourceType")="Patient"
 ;g("Patient","entry",1,"resource","telecom",1,"system")="phone"
 ;g("Patient","entry",1,"resource","telecom",1,"use")="home"
 ;g("Patient","entry",1,"resource","telecom",1,"value")="(454) 841-5126"
 ;g("Patient","entry",1,"resource","text","div")="<div>Generated by <a href=""https://github.com/synthetichealth/synthea"""
 ;g("Patient","entry",1,"resource","text","div","\",1)=">Synthea</a>. Version identifier: 4d02400401b9fab839e47bf5b2f1f6a8c683ab55</div>"
 ;g("Patient","entry",1,"resource","text","status")="generated"
 ;
 ; patient load template (D LOADMISC^ISIIMPU1(.G))
 ;G("CITY")="FIELD|.114"
 ;G("DFN_NAME")="PARAM|"
 ;G("DOB")="FIELD|.03"
 ;G("EMPLOY_STAT")="FIELD|.31115"
 ;G("ETHNICITY")="FIELD|2.06,.01"
 ;G("IMP_BATCH_NUM")="PARAM|"
 ;G("IMP_TYPE")="PARAM|"
 ;G("INSUR_TYPE")="FIELD|2.312,.01"
 ;G("LOW_DOB")="PARAM|.03"
 ;G("MARITAL_STATUS")="FIELD|.05"
 ;G("MRG_SOURCE")="FIELD|.01"
 ;G("NAME")="FIELD|.01"
 ;G("NAME_MASK")="MASK|.01"
 ;G("OCCUPATION")="FIELD|.07"
 ;G("PH_NUM")="FIELD|.131"
 ;G("PH_NUM_MASK")="MASK|.131"
 ;G("RACE")="FIELD|2.02,.01"
 ;G("SEX")="FIELD|.02"
 ;G("SSN")="FIELD|.09"
 ;G("SSN_MASK")="MASK|.09"
 ;G("STATE")="FIELD|.115"
 ;G("STREET_ADD1")="FIELD|.111"
 ;G("STREET_ADD2")="FIELD|.112"
 ;G("TEMPLATE")="PARAM|"
 ;G("TYPE")="FIELD|391"
 ;G("UP_DOB")="PARAM|.03"
 ;G("VETERAN")="FIELD|1901"
 ;G("ZIP_4")="FIELD|.1112"
 ;G("ZIP_4_MASK")="MASK|.1112
 ;"
newIcn(dfn) ; extrinsic which creates a new ICN for the patient
 ; if none exists. returns the ICN
 ;
 new tmpicn
 set tmpicn=$$icn(dfn)
 if tmpicn'=-1 do  quit tmpicn
 . n ien s ien=$$dfn2ien^SYNFUTL(dfn)
 . if ien'="" do setIndex^SYNFUTL(ien,"ICN",tmpicn)
 ;
 ; lock here
 ;
 set tmpicn=$o(^DPT("AICN",99999999999),-1)+1
 if tmpicn=1 s tmpicn=50000001 ; first ICN in the system
 ;
 ;991.01    INTEGRATION CONTROL NUMBER (NJ12,0Xa), [MPI;1]
 ;991.02    ICN CHECKSUM (Fa), [MPI;2]
 ;991.1     FULL ICN (FXa), [MPI;10]
 ;
 new fda,tchk
 set tchk=$$CHECKDG^MPIFSPC(tmpicn)
 set fda(2,dfn_",",991.01)=tmpicn
 set fda(2,dfn_",",991.02)=tchk
 set fda(2,dfn_",",991.1)=tmpicn_"V"_tchk
 do UPDATE^DIE("","fda",,"err")
 if $data(err) do  quit -1
 . D ^ZTER
 ;
 new ficn s ficn=tmpicn_"V"_tchk
 S ^DPT("AFICN",ficn,dfn)=""
 S ^DPT("ARFICN",dfn,ficn)=""
 ;
 n ien s ien=$$dfn2ien^SYNFUTL(dfn)
 if ien'="" do setIndex^SYNFUTL(ien,"ICN",ficn)
 ;
 quit ficn
 ;
icn(dfn) ; extrinsic returns the ICN of the patient
 ; returns -1 if none exists
 new zicn
 set zicn=$$GET1^DIQ(2,dfn_",",991.01)
 ;set zicn=$o(^DPT("AICN",dfn,""))
 if zicn="" q -1
 ;
 quit zicn_"V"_$$CHECKDG^MPIFSPC(zicn)
 ;
newIcn2(dfn,pid) ; extrinsic which creates a new ICN for the patient based on the Synthea patient id (pid)
 ; returns the ICN
 ;
 i $g(pid)="" d  ; pid not provided.. go find it
 . n fien s fien=$$dfn2ien^SYNFUTL(dfn)
 . s pid=$$ien2pid^SYNFUTL(fien)
 i $g(pid)="" q -1
 new tmpicn
 ;
 s tmpicn=$$pid2icn^SYNFUTL(pid) ; generate the icn from the pid
 ;
 ;991.01    INTEGRATION CONTROL NUMBER (NJ12,0Xa), [MPI;1]
 ;991.02    ICN CHECKSUM (Fa), [MPI;2]
 ;991.1     FULL ICN (FXa), [MPI;10]
 ;
 new fda,tchk,err
 set tchk=$$CHECKDG^MPIFSPC(tmpicn)
 i +dfn=0 b
 set fda(2,dfn_",",991.01)=tmpicn
 set fda(2,dfn_",",991.02)=tchk
 set fda(2,dfn_",",991.1)=tmpicn_"V"_tchk
 do UPDATE^DIE("","fda",,"err")
 if $data(err) do  quit -1
 . D ^ZTER
 . zwrite err
 ;
 new ficn s ficn=tmpicn_"V"_tchk
 S ^DPT("AFICN",ficn,dfn)=""
 S ^DPT("ARFICN",dfn,ficn)=""
 ;
 n ien s ien=$$dfn2ien^SYNFUTL(dfn)
 if ien'="" do setIndex^SYNFUTL(ien,"ICN",ficn)
 ;
 quit ficn
 ;
fixindex1 ; create the ICN and DFN indexes
 d clearIndexes^SYNFUTL ; blow away the indexes
 n gn,zi
 s gn=$$setroot^SYNWD("fhir-intake")
 s zi=0
 f  s zi=$o(@gn@(zi)) q:+zi=0  d  ;
 . n gn2,dfn,icn
 . s gn2=$na(@gn@(zi,"load","Patient","status"))
 . ;w !,gn2," ",$g(@gn2@("DFN"))
 . s dfn=$g(@gn2@("DFN"))
 . q:dfn=""
 . ;s icn=$g(@gn2@("ICN"))
 . s icn=$o(^DPT("ARFICN",dfn,""))
 . q:icn=""
 . s @gn@(zi,"DFN",dfn)=""
 . d setIndex^SYNFUTL(zi,"DFN",dfn)
 . i icn'="" d
 . . s @gn@(zi,"ICN",icn)=""
 . . d setIndex^SYNFUTL(zi,"ICN",icn)
 q
 ;
fixicn1 ; fix all DPT ICN indexes
 k ^DPT("AICN")
 K ^DPT("AFICN")
 K ^DPT("ARFICN")
 n zi s zi=0
 f  s zi=$o(^DPT(zi)) q:+zi=0  d  ;
 . n icn,icnck
 . s icn=$$GET1^DIQ(2,zi_",",991.01)
 . s icnck=$$GET1^DIQ(2,zi_",",991.02)
 . q:icn=""
 . q:icnck=""
 . n ficn s ficn=icn_"V"_icnck
 . s ^DPT("AICN",icn,zi)=""
 . s ^DPT("AFICN",ficn,zi)=""
 . s ^DPT("ARFICN",zi,ficn)=""
 q
 ;
genAllIcns ; regenerates all ICNs; insterts in PATIENT file and regenerates indexes
 n root s root=$$setroot^SYNWD("fhir-intake")
 n zi s zi=0
 f  s zi=$o(@root@(zi)) q:+zi=0  d  ;
 . n pid,dfn,icn
 . s pid=$$ien2pid^SYNFUTL(zi)
 . s dfn=$$ien2dfn^SYNFUTL(zi)
 . i dfn<1 q
 . i pid="" q
 . s icn=$$newIcn2^SYNFPAT(dfn,pid)
 . w !,"fien: "_zi_" dfn: "_dfn_" pid: "_pid_" icn: "_icn
 d fixicn1 ; fix ^DPT indexes
 d fixindex1 ; fix graph indexes
 q
 ;
