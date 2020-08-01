SYNFLAB ;ven/gpl - fhir loader utilities ;Aug 15, 2019@14:20:15
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ;
 q
 ;
importLabs(rtn,ien,args) ; entry point for loading labs for a patient
 ; calls the intake Labs web service directly
 ;
 n grtn
 n root s root=$$setroot^SYNWD("fhir-intake")
 n % s %=$$wsIntakeLabs(.args,,.grtn,ien)
 ;i $d(grtn) d  ; something was returned
 ;. k @root@(ien,"load","labs")
 ;. m @root@(ien,"load","labs")=grtn("labs")
 ;. if $g(args("debug"))=1 m rtn=grtn
 s rtn("labsStatus","status")=$g(grtn("status","status"))
 s rtn("labsStatus","loaded")=$g(grtn("status","loaded"))
 s rtn("labsStatus","errors")=$g(grtn("status","errors"))
 ;b
 ;
 ;
 q
 ;
wsIntakeLabs(args,body,result,ien) ; web service entry (post)
 ; for intake of one or more Lab results. input are fhir resources
 ; result is json and summarizes what was done
 ; args include patientId
 ; ien is specified for internal calls, where the json is already in a graph
 n root,troot
 s root=$$setroot^SYNWD("fhir-intake")
 ;
 n jtmp,json,jrslt,eval
 ;i $g(ien)'="" if $$loadStatus("labs","",ien)=1 d  q  ;
 ;. s result("labsStatus","status")="alreadyLoaded"
 i $g(ien)'="" d  ; internal call
 . s troot=$na(@root@(ien,"type","Observation"))
 . s eval=$na(@root@(ien,"load")) ; move eval to the graph
 . ;d getIntakeFhir^SYNFHIR("json",,"Observation",ien,1)
 e  q 0  ; sending not decoded json in BODY to this routine is not done
 ; todo: locate the patient and add the labs in BODY to the graph
 ;. ;s args("load")=0
 ;. merge jtmp=BODY
 ;. do decode^SYNJSONE("jtmp","json")
 ;. s troot=$na(@root@(ien,"type","Observation"))
 i '$d(@troot) q 0  ;
 s json=$na(@root@(ien,"json"))
 ;m ^gpl("gjson")=@troot
 ;
 ; determine the patient
 ;
 n dfn
 if $g(ien)'="" d  ;
 . s dfn=$$ien2dfn^SYNFUTL(ien) ; look up dfn in the graph
 else  d  ;
 . s dfn=$g(args("dfn"))
 . i dfn="" d  ;
 . . n icn s icn=$g(args("icn"))
 . . i icn'="" s dfn=$$icn2dfn^SYNFUTL(icn)
 i $g(dfn)="" do  quit 0  ; need the patient
 . s result("labs",1,"log",1)="Error, patient not found.. terminating"
 ;
 ;
 new zi s zi=0
 for  set zi=$order(@troot@(zi)) quit:+zi=0  do  ;
 . ;
 . ; define a place to log the processing of this entry
 . ;
 . new jlog set jlog=$name(@eval@("labs",zi))
 . ;
 . ; insure that the resourceType is Observation
 . ;
 . new type set type=$get(@json@("entry",zi,"resource","resourceType"))
 . if type'="Observation" do  quit  ;
 . . set @eval@("labs",zi,"vars","resourceType")=type
 . . do log(jlog,"Resource type not Observation, skipping entry")
 . set @eval@("labs",zi,"vars","resourceType")=type
 . ;
 . ; determine the Observation category and quit if not labs
 . ;
 . new obstype set obstype=$get(@json@("entry",zi,"resource","category",1,"coding",1,"code"))
 . if obstype="" do  ; category is missing, try mapping the code
 . . new trycode,trydisp,tryy
 . . set trycode=$g(@json@("entry",zi,"resource","code","coding",1,"code"))
 . . set trydisp=$g(@json@("entry",zi,"resource","code","coding",1,"display"))
 . . s tryy=$$loinc2sct(trycode)
 . . if tryy="" d  quit  ;
 . . . d log(jlog,"Observation Category missing, not vital signs; code is: "_trycode_" "_trydisp)
 . . if tryy'="" set obstype="laboratory"
 . . d log(jlog,"Derived category is "_obstype)
 . ;
 . if obstype'="laboratory" do  quit  ;
 . . set @eval@("labs",zi,"vars","observationCategory")=obstype
 . . do log(jlog,"Observation Category is not laboratory, skipping")
 . set @eval@("labs",zi,"vars","observationCategory")=obstype
 . ;
 . ; see if this resource has already been loaded. if so, skip it
 . ;
 . if $g(ien)'="" if $$loadStatus("labs",zi,ien)=1 do  quit  ;
 . . d log(jlog,"Lab already loaded, skipping")
 . ;
 . ; determine Labs type, code, coding system, and display text
 . ;
 . new labtype set labtype=$get(@json@("entry",zi,"resource","code","text"))
 . if labtype="" set labtype=$get(@json@("entry",zi,"resource","code","coding",1,"display"))
 . do log(jlog,"Labs type is: "_labtype)
 . set @eval@("labs",zi,"vars","type")=labtype
 . ;
 . ; determine the id of the resource
 . ;
 . new id set id=$get(@json@("entry",zi,"resource","id"))
 . set @eval@("labs",zi,"vars","id")=id
 . d log(jlog,"ID is: "_id)
 . ;
 . new obscode set obscode=$get(@json@("entry",zi,"resource","code","coding",1,"code"))
 . do log(jlog,"code is: "_obscode)
 . set @eval@("labs",zi,"vars","code")=obscode
 . ;
 . s ^gpl("labs",obscode,labtype)=""
 . ;
 . new codesystem set codesystem=$get(@json@("entry",zi,"resource","code","coding",1,"system"))
 . do log(jlog,"code system is: "_codesystem)
 . set @eval@("labs",zi,"vars","codeSystem")=codesystem
 . ;
 . ; determine the value and units
 . ;
 . new value set value=$get(@json@("entry",zi,"resource","valueQuantity","value"))
 . do log(jlog,"value is: "_value)
 . set @eval@("labs",zi,"vars","value")=value
 . ;
 . new unit set unit=$get(@json@("entry",zi,"resource","valueQuantity","unit"))
 . do log(jlog,"units are: "_unit)
 . set @eval@("labs",zi,"vars","units")=unit
 . ;
 . ; determine the effective date
 . ;
 . new effdate set effdate=$get(@json@("entry",zi,"resource","effectiveDateTime"))
 . do log(jlog,"effectiveDateTime is: "_effdate)
 . set @eval@("labs",zi,"vars","effectiveDateTime")=effdate
 . new fmtime s fmtime=$$fhirTfm^SYNFUTL(effdate)
 . d log(jlog,"fileman dateTime is: "_fmtime)
 . set @eval@("labs",zi,"vars","fmDateTime")=fmtime ;
 . new hl7time s hl7time=$$fhirThl7^SYNFUTL(effdate)
 . d log(jlog,"hl7 dateTime is: "_hl7time)
 . set @eval@("labs",zi,"vars","hl7DateTime")=hl7time ;
 . ;
 . ; set up to call the data loader
 . ;
 . n RETSTA,DHPPAT,DHPSCT,DHPOBS,DHPUNT,DHPDTM,DHPPROV,DHPLOC,DHPLOINC
 . ;
 . s DHPPAT=$$dfn2icn^SYNFUTL(dfn)
 . s @eval@("labs",zi,"parms","DHPPAT")=DHPPAT
 . ;
 . ;n vistalab s vistalab=$$MAP^SYNQLDM(obscode)
 . s DHPLOINC=obscode
 . d log(jlog,"LOINC code is: "_DHPLOINC)
 . s @eval@("labs",zi,"parms","DHPLOINC")=DHPLOINC
 . ;
 . n vistalab s vistalab=$$graphmap^SYNGRAPH("loinc-lab-map",obscode)
 . i +vistalab=-1 s vistalab=$$graphmap^SYNGRAPH("loinc-lab-map"," "_obscode)
 . i +vistalab'=-1 d
 .. d log(jlog,"Lab found in graph: "_vistalab)
 .. s @eval@("labs",zi,"parms","vistalab")=vistalab
 . if +vistalab=-1 s vistalab=labtype
 . s vistalab=$$TRIM^XLFSTR(vistalab) ; get rid of trailing blanks
 . ;n sct s sct=$$loinc2sct(obscode) ; find the snomed code
 . ;i vistalab="" d  quit
 . ;. d log(jlog,"VistA lab not found for loinc code: "_obscode_" "_labtype_" -- skipping")
 . ;. s @eval@("labs",zi,"status","loadstatus")="cannotLoad"
 . ;. s @eval@("labs",zi,"status","issue")="VistA lab not found for loinc code: "_obscode_" "_labtype_" -- skipping"
 . ;. s @eval@("status","errors")=$g(@eval@("status","errors"))+1
 . s @eval@("labs",zi,"parms","DHPLAB")=vistalab
 . d log(jlog,"VistA Lab is: "_vistalab)
 . s DHPLAB=vistalab
 . ;
 . s DHPOBS=value
 . s recien=$o(^LAB(60,"B",DHPLAB,""))
 . n xform s xform=$$GET1^DIQ(60,recien_",",410)
 . n dec s dec=0
 . i xform["S Q9=" d
 . . s dec=+$p($p(xform,"""",2),",",3)
 . i $l($p(DHPOBS,".",2))>1 d
 . . s DHPOBS=$s(dec<4:$j(DHPOBS,1,dec),dec>3:$j(DHPOBS,1,3),1:$j(DHPOBS,1,0)) ; fix results with too many decimal places
 . s @eval@("labs",zi,"parms","DHPOBS")=DHPOBS
 . d log(jlog,"Value is: "_DHPOBS)
 . ;
 . ;i DHPLOINC="2093-3" s DHPOBS=$J(DHPOBS,1,0) ;Total Cholesterol
 . ;i DHPLOINC="33914-3" s DHPOBS=$J(DHPOBS,1,0) ;Estimated Glomerular Filtration Rate
 . ;i DHPLOINC="18262-6" s DHPOBS=$J(DHPOBS,1,0) ;Low Density Cholesterol
 . ;i DHPLOINC="2085-9" s DHPOBS=$J(DHPOBS,1,0) ;High Density Cholesterol
 . ;i DHPLOINC="2571-8" s DHPOBS=$J(DHPOBS,1,0) ;Tryglycerides
 . ;i DHPLOINC="2339-0" s DHPOBS=$J(DHPOBS,1,0) ;Glucose
 . ;
 . s DHPUNT=unit
 . s @eval@("labs",zi,"parms","DHPUNT")=unit
 . d log(jlog,"Units are: "_unit)
 . ;
 . s DHPDTM=hl7time
 . s @eval@("labs",zi,"parms","DHPDTM")=hl7time
 . d log(jlog,"HL7 DateTime is: "_hl7time)
 . ;
 . s DHPPROV=$$MAP^SYNQLDM("OP","provider")
 . n DHPPROVIEN s DHPPROVIEN=$o(^VA(200,"B",DHPPROV,""))
 . if DHPPROVIEN="" S DHPPROVIEN=3
 . s @eval@("labs",zi,"parms","DHPPROV")=DHPPROVIEN
 . d log(jlog,"Provider for outpatient is: #"_DHPPROVIEN_" "_DHPPROV)
 . ;
 . s DHPLOC=$$MAP^SYNQLDM("OP","location")
 . n DHPLOCIEN s DHPLOCIEN=$o(^SC("B",DHPLOC,""))
 . if DHPLOCIEN="" S DHPLOCIEN=4
 . s @eval@("labs",zi,"parms","DHPLOC")=DHPLOC
 . d log(jlog,"Location for outpatient is: #"_DHPLOCIEN_" "_DHPLOC)
 . ;
 . s @eval@("labs",zi,"status","loadstatus")="readyToLoad"
 . ;
 . if $g(args("load"))=1 d  ; only load if told to
 . . ;new (DHPPAT,DHPSCT,DHPOBS,DHPUNT,DHPDTM,DHPPROV,DHPLOC,DHPLOINC,DHPLAB)
 . . if $g(ien)'="" if $$loadStatus("labs",zi,ien)=1 do  quit  ;
 . . . d log(jlog,"Lab already loaded, skipping")
 . . d log(jlog,"Calling LABADD^SYNDHP63 to add lab")
 . . ;new (DHPPAT,DHPSCT,DHPOBS,DHPUNT,DHPDTM,DHPPROV,DHPLOC,DHPLOINC,DHPLAB,DUZ,DT,U,jlog,ien,zi,eval)
 . . ;LABADD(RETSTA,DHPPAT,DHPLOC,DHPTEST,DHPRSLT,DHPRSDT) ;Create lab test
 . . D LABADD^SYNDHP63(.RETSTA,DHPPAT,DHPLOC,DHPLAB,DHPOBS,DHPDTM,DHPLOINC)     ; labs update
 . . d log(jlog,"Return from LABADD^ZZDHP63 was: "_$g(RETSTA))
 . . i $g(DEBUG)=1 ZWRITE RETSTA
 . . if +$g(RETSTA)=1 do  ;
 . . . s @eval@("labs","status","loaded")=$g(@eval@("labs","status","loaded"))+1
 . . . s @eval@("labs",zi,"status","loadstatus")="loaded"
 . . else  s @eval@("labs","status","errors")=$g(@eval@("labs","status","errors"))+1
 ;
 if $get(args("debug"))=1 do  ;
 . m jrslt("source")=@json
 . m jrslt("args")=args
 . m jrslt("eval")=@eval
 m jrslt("labsStatus")=@eval@("labsStatus")
 set jrslt("result","status")="ok"
 set jrslt("result","loaded")=$g(@eval@("labs","status","loaded"))
 set jrslt("result","errors")=$g(@eval@("labs","status","errors"))
 i $g(ien)'="" d  ; called internally
 . ;m result=eval
 . m result("status")=jrslt("result")
 . ;b
 e  d  ;
 . d encode^SYNJSONE("jrslt","result")
 . set HTTPRSP("mime")="application/json"
 q 1
 ;
log(ary,txt) ; adds a text line to @ary@("log")
 s @ary@("log",$o(@ary@("log",""),-1)+1)=$g(txt)
 w:$G(DEBUG) !,"      ",$G(txt)
 q
 ;
loadStatus(typ,zx,zien) ; extrinsic return 1 if resource was loaded
 n root s root=$$setroot^SYNWD("fhir-intake")
 n rt s rt=0
 i $g(zx)="" i $d(@root@(zien,"load",typ)) s rt=1 q rt
 i $get(@root@(zien,"load",typ,zx,"status","loadstatus"))="loaded" s rt=1
 q rt
loinc2sct(loinc) ; extrinsic returns a Snomed code for a Loinc code
 ; for labs
 ; thanks to Ferdi for the Snomed mapping
 ;
 ; here's what we got so far:
 ;^gpl("labs","29463-7","Body Weight")=""
 ;^gpl("labs","39156-5","Body Mass Index")="" ; oops
 ;^gpl("labs","55284-4","Blood Pressure")=""
 ;^gpl("labs","8302-2","Body Height")=""
 ;^gpl("labs","8331-1","Oral temperature")="" ;
 ;
 S SCTA("29463-7",27113001)="9^Body weight"
 S SCTA("8302-2",50373000)="8^Body height"
 S SCTA("55284-4",75367002)="1^Blood pressure"
 S SCTA(78564009)="5^Pulse rate"
 S SCTA("8331-1",386725007)="2^Body Temperature"
 S SCTA(86290005)="3^Respiration"
 S SCTA(48094003)="10^Abdominal girth measurement"
 S SCTA(21727005)="11^Audiometry"
 S SCTA(252465000)="21^Pulse oximetry"
 S SCTA(22253000)="22^Pain"
 ;
 q $o(SCTA(loinc,""))
 ;
testall ; run the labs import on all imported patients
 new root s root=$$setroot^SYNWD("fhir-intake")
 new indx s indx=$na(@root@("POS","DFN"))
 n dfn,ien,filter,reslt
 s dfn=0
 f  s dfn=$o(@indx@(dfn)) q:+dfn=0  d  ;
 . s ien=$o(@indx@(dfn,""))
 . q:ien=""
 . s filter("dfn")=dfn
 . k reslt
 . d wsIntakeLabs(.filter,,.reslt,ien)
 q
 ;
labsum ; summary of lab tests for patient ien pien
 n root s root=$$setroot^SYNWD("fhir-intake")
 n table
 n zzi s zzi=0
 f  s zzi=$o(@root@(zzi)) q:+zzi=0  d  ;
 . n labs
 . d getIntakeFhir^SYNFHIR("labs",,"Observation",zzi,1)
 . n zi s zi=0
 . f  s zi=$o(labs("entry",zi)) q:+zi=0  d  ;
 . . n groot s groot=$na(labs("entry",zi,"resource"))
 . . i $g(@groot@("category",1,"coding",1,"code"))'="laboratory" q  ;
 . . n loinc
 . . s loinc=$g(@groot@("code","coding",1,"code"))
 . . q:loinc=""
 . . ;i loinc="6082-2" b  ;
 . . n text s text=$g(@groot@("code","coding",1,"display"))
 . . i $d(table(loinc_" "_text)) d  ;
 . . . s table(loinc_" "_text)=table(loinc_" "_text)+1
 . . e  d  ;
 . . . s table(loinc_" "_text)=1
 . . . w !,"patient= "_zzi_" entry= "_zi,!
 . . . n rptary m rptary=@root@(zzi,"json","entry",zi,"resource")
 . . . zwrite rptary
 zwrite table
 q
 ;
