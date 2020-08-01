SYNFVIT ;ven/gpl - fhir loader utilities ;Aug 15, 2019@14:44:21
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ;
 q
 ;
importVitals(rtn,ien,args) ; entry point for loading vitals for a patient
 ; calls the intake Vitals web service directly
 ;
 n grtn
 n root s root=$$setroot^SYNWD("fhir-intake")
 n % s %=$$wsIntakeVitals(.args,,.grtn,ien)
 ;i $d(grtn) d  ; something was returned
 ;. k @root@(ien,"load","vitals")
 ;. m @root@(ien,"load","vitals")=grtn("vitals")
 ;. if $g(args("debug"))=1 m rtn=grtn
 s rtn("vitalsStatus","status")=$g(grtn("status","status"))
 s rtn("vitalsStatus","loaded")=$g(grtn("status","loaded"))
 s rtn("vitalsStatus","errors")=$g(grtn("status","errors"))
 ;b
 ;
 ;
 q
 ;
wsIntakeVitals(args,body,result,ien) ; web service entry (post)
 ; for intake of one or more Vital signs. input are fhir resources
 ; result is json and summarizes what was done
 ; args include patientId
 ; ien is specified for internal calls, where the json is already in a graph
 n root,troot
 s root=$$setroot^SYNWD("fhir-intake")
 ;
 n jtmp,json,jrslt,eval
 ;i $g(ien)'="" if $$loadStatus("vitals","",ien)=1 d  q  ;
 ;. s result("vitalsStatus","status")="alreadyLoaded"
 i $g(ien)'="" d  ; internal call
 . ;d getIntakeFhir^SYNFHIR("json",,"Observation",ien,1)
 . s troot=$na(@root@(ien,"type","Observation"))
 . s eval=$na(@root@(ien,"load"))
 e  q 0  ; sending json to this routine in BODY is not supported
 ;. ;s args("load")=0
 ;. merge jtmp=BODY
 ;. do decode^SYNJSONE("jtmp","json")
 s json=$na(@root@(ien,"json"))
 i '$d(json) q 0  ;
 ;m ^gpl("gjson")=json
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
 . s result("vitals",1,"log",1)="Error, patient not found.. terminating"
 ;
 ;
 new zi s zi=0
 for  set zi=$order(@troot@(zi)) quit:+zi=0  do  ;
 . ;
 . ; define a place to log the processing of this entry
 . ;
 . new jlog set jlog=$name(@eval@("vitals",zi))
 . ;
 . ; insure that the resourceType is Observation
 . ;
 . new type set type=$get(@json@("entry",zi,"resource","resourceType"))
 . if type'="Observation" do  quit  ;
 . . set @eval@("vitals",zi,"vars","resourceType")=type
 . . do log(jlog,"Resource type not Observation, skipping entry")
 . set @eval@("vitals",zi,"vars","resourceType")=type
 . ;
 . ; determine the Observation category and quit if not vital-signs
 . ;
 . new obstype set obstype=$get(@json@("entry",zi,"resource","category",1,"coding",1,"code"))
 . if obstype="" do  ; category is missing, try mapping the code
 . . new trycode,trydisp,tryy
 . . set trycode=$g(@json@("entry",zi,"resource","code","coding",1,"code"))
 . . set trydisp=$g(@json@("entry",zi,"resource","code","coding",1,"display"))
 . . s tryy=$$loinc2sct(trycode)
 . . if tryy="" d  quit  ;
 . . . d log(jlog,"Observation Category missing, not vital signs; code is: "_trycode_" "_trydisp)
 . . if tryy'="" set obstype="vital-signs"
 . . d log(jlog,"Derived category is "_obstype)
 . ;
 . if obstype'="vital-signs" do  quit  ;
 . . set @eval@("vitals",zi,"vars","observationCategory")=obstype
 . . do log(jlog,"Observation Category is not vital-signs, skipping")
 . set @eval@("vitals",zi,"vars","observationCategory")=obstype
 . ;
 . ; see if this resource has already been loaded. if so, skip it
 . ;
 . if $g(ien)'="" if $$loadStatus("vitals",zi,ien)=1 do  quit  ;
 . . d log(jlog,"Vital sign already loaded, skipping")
 . ;
 . ; determine Vitals type, code, coding system, and display text
 . ;
 . new vittype set vittype=$get(@json@("entry",zi,"resource","code","text"))
 . if vittype="" set vittype=$get(@json@("entry",zi,"resource","code","coding",1,"display"))
 . do log(jlog,"Vitals type is: "_vittype)
 . set @eval@("vitals",zi,"vars","type")=vittype
 . ;
 . ; determine the id of the resource
 . ;
 . new id set id=$get(@json@("entry",zi,"resource","id"))
 . set @eval@("vitals",zi,"vars","id")=id
 . d log(jlog,"ID is: "_id)
 . ;
 . new obscode set obscode=$get(@json@("entry",zi,"resource","code","coding",1,"code"))
 . do log(jlog,"code is: "_obscode)
 . set @eval@("vitals",zi,"vars","code")=obscode
 . ;
 . s ^gpl("vitals",obscode,vittype)=""
 . ; here's what we got so far:
 . ;^gpl("vitals","29463-7","Body Weight")=""
 . ;^gpl("vitals","39156-5","Body Mass Index")=""
 . ;^gpl("vitals","55284-4","Blood Pressure")=""
 . ;^gpl("vitals","8302-2","Body Height")=""
 . ;^gpl("vitals","8331-1","Oral temperature")=""
 . ;
 . new codesystem set codesystem=$get(@json@("entry",zi,"resource","code","coding",1,"system"))
 . do log(jlog,"code system is: "_codesystem)
 . set @eval@("vitals",zi,"vars","codeSystem")=codesystem
 . ;
 . ; determine the value and units
 . ;
 . new value set value=$get(@json@("entry",zi,"resource","valueQuantity","value"))
 . do log(jlog,"value is: "_value)
 . set @eval@("vitals",zi,"vars","value")=value
 . ;
 . new unit set unit=$get(@json@("entry",zi,"resource","valueQuantity","unit"))
 . do log(jlog,"units are: "_unit)
 . set @eval@("vitals",zi,"vars","units")=unit
 . ;
 . ; fix blood preasure readings (combine two readings to one)
 . ;
 . if obscode="55284-4" do  ; Blood Pressure
 . ; as of fhir r4 and Synthea Covid, there are 2 loinc codes for BP - gpl
 . if $$loinc2sct(obscode)=75367002 d  ; it's a blood pressure
 . . new tmpjson,systolic,diastolic,combined
 . . merge tmpjson=@json@("entry",zi)
 . . d log(jlog,"Combining Blood Pressure values")
 . . n tn s tn=$na(tmpjson("resource","component"))
 . . n tx
 . . f tx=1,2  d  ;
 . . . if $g(@tn@(tx,"code","coding",1,"code"))="8480-6" d  ; Systolic Blood Pressure
 . . . . s systolic("units")=$g(@tn@(tx,"valueQuantity","unit"))
 . . . . s unit=systolic("units")
 . . . . s systolic("value")=$g(@tn@(tx,"valueQuantity","value"))
 . . . . s value=systolic("value")
 . . . . d log(jlog,("Systolic value is: "_systolic("value")))
 . . . if $g(@tn@(tx,"code","coding",1,"code"))="8462-4" d  ; Diastolic Blood Pressure
 . . . . s diastolic("units")=$g(@tn@(tx,"valueQuantity","unit"))
 . . . . s unit=diastolic("units")
 . . . . s diastolic("value")=$g(@tn@(tx,"valueQuantity","value"))
 . . . . s value=diastolic("value")
 . . . . d log(jlog,("Diastolic value is: "_diastolic("value")))
 . . s combined=$g(systolic("value"))_"/"_$g(diastolic("value"))
 . . s value=combined
 . . d log(jlog,"Combined Blood Pressure value is: "_combined)
 . . set @eval@("vitals",zi,"vars","value")=combined
 . . set @eval@("vitals",zi,"vars","units")=$g(diastolic("units"))
 . . d log(jlog,"Blood Pressure units are: "_$g(diastolic("units")))
 . . ;b
 . ;
 . ; determine the effective date
 . ;
 . new effdate set effdate=$get(@json@("entry",zi,"resource","effectiveDateTime"))
 . do log(jlog,"effectiveDateTime is: "_effdate)
 . set @eval@("vitals",zi,"vars","effectiveDateTime")=effdate
 . new fmtime s fmtime=$$fhirTfm^SYNFUTL(effdate)
 . d log(jlog,"fileman dateTime is: "_fmtime)
 . set @eval@("vitals",zi,"vars","fmDateTime")=fmtime ;
 . new hl7time s hl7time=$$fhirThl7^SYNFUTL(effdate)
 . d log(jlog,"hl7 dateTime is: "_hl7time)
 . set @eval@("vitals",zi,"vars","hl7DateTime")=hl7time ;
 . ;
 . ; set up to call the data loader
 . ;
 . n RETSTA,DHPPAT,DHPSCT,DHPOBS,DHPUNT,DHPDTM,DHPPROV,DHPLOC
 . ;
 . s DHPPAT=$$dfn2icn^SYNFUTL(dfn)
 . s @eval@("vitals",zi,"parms","DHPPAT")=DHPPAT
 . ;
 . n sct s sct=$$loinc2sct(obscode) ; find the snomed code
 . i sct="" d  quit
 . . d log(jlog,"Snomed Code not found for vitals code: "_obscode_" -- skipping")
 . . s @eval@("vitals",zi,"status","loadstatus")="cannotLoad"
 . . s @eval@("vitals",zi,"status","issue")="Snomed Code not found for vitals code: "_obscode_" -- skipping"
 . . s @eval@("vitals","status","errors")=$g(@eval@("vitals","status","errors"))+1
 . s @eval@("vitals",zi,"parms","DHPSCT")=sct
 . d log(jlog,"Snomed Code is: "_sct)
 . s DHPSCT=sct
 . ;
 . s DHPOBS=value
 . s @eval@("vitals",zi,"parms","DHPOBS")=value
 . d log(jlog,"Value is: "_value)
 . ;
 . s DHPUNT=unit
 . s @eval@("vitals",zi,"parms","DHPUNT")=unit
 . d log(jlog,"Units are: "_unit)
 . ;
 . s DHPDTM=hl7time
 . s @eval@("vitals",zi,"parms","DHPDTM")=hl7time
 . d log(jlog,"HL7 DateTime is: "_hl7time)
 . ;
 . s DHPPROV=$$MAP^SYNQLDM("OP","provider")
 . n DHPPROVIEN s DHPPROVIEN=$o(^VA(200,"B",DHPPROV,""))
 . if DHPPROVIEN="" S DHPPROVIEN=3
 . s @eval@("vitals",zi,"parms","DHPPROV")=DHPPROVIEN
 . d log(jlog,"Provider for outpatient is: #"_DHPPROVIEN_" "_DHPPROV)
 . ;
 . s DHPLOC=$$MAP^SYNQLDM("OP","location")
 . n DHPLOCIEN s DHPLOCIEN=$o(^SC("B",DHPLOC,""))
 . if DHPLOCIEN="" S DHPLOCIEN=4
 . s @eval@("vitals",zi,"parms","DHPLOC")=DHPLOCIEN
 . d log(jlog,"Location for outpatient is: #"_DHPLOCIEN_" "_DHPLOC)
 . ;
 . s @eval@("vitals",zi,"status","loadstatus")="readyToLoad"
 . ;
 . if $g(args("load"))=1 d  ; only load if told to
 . . if $g(ien)'="" if $$loadStatus("vitals",zi,ien)=1 do  quit  ;
 . . . d log(jlog,"Vital sign already loaded, skipping")
 . . d log(jlog,"Calling VITUPD^SYNDHP61 to add vital")
 . . D VITUPD^SYNDHP61(.RETSTA,DHPPAT,DHPSCT,DHPOBS,DHPUNT,DHPDTM,DHPPROV,DHPLOC)       ; vitals update
 . . d log(jlog,"Return from VITUPD^ZZDHP61 was: "_$g(RETSTA))
 . . if +$g(RETSTA)=1 do  ;
 . . . s @eval@("vitals","status","loaded")=$g(@eval@("vitals","status","loaded"))+1
 . . . s @eval@("vitals",zi,"status","loadstatus")="loaded"
 . . else  s @eval@("vitals","status","errors")=$g(@eval@("vitals","status","errors"))+1
 ;
 if $get(args("debug"))=1 do  ;
 . m jrslt("source")=@json
 . m jrslt("args")=args
 . m jrslt("eval")=@eval
 m jrslt("vitalsStatus")=@eval@("vitalsStatus")
 set jrslt("result","status")="ok"
 set jrslt("result","loaded")=$g(@eval@("vitals","status","loaded"))
 set jrslt("result","errors")=$g(@eval@("vitals","status","errors"))
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
 q
 ;
loadStatus(typ,zx,zien) ; extrinsic return 1 if resource was loaded
 n root s root=$$setroot^SYNWD("fhir-intake")
 n rt s rt=0
 i $g(zx)="" i $d(@root@(zien,"load",typ)) s rt=1 q rt
 i $get(@root@(zien,"load",typ,zx,"status","loadstatus"))="loaded" s rt=1
 q rt
loinc2sct(loinc) ; extrinsic returns a Snomed code for a Loinc code
 ; for vitals
 ; thanks to Ferdi for the Snomed mapping
 ;
 ; here's what we got so far:
 ;^gpl("vitals","29463-7","Body Weight")=""
 ;^gpl("vitals","39156-5","Body Mass Index")="" ; oops
 ;^gpl("vitals","55284-4","Blood Pressure")=""
 ;^gpl("vitals","8302-2","Body Height")=""
 ;^gpl("vitals","8331-1","Oral temperature")="" ;
 ;
 S SCTA("29463-7",27113001)="9^Body weight"
 S SCTA("8302-2",50373000)="8^Body height"
 S SCTA("55284-4",75367002)="1^Blood pressure"
 S SCTA("85354-9",75367002)="1^Blood pressure"
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
testall ; run the vitals import on all imported patients
 new root s root=$$setroot^SYNWD("fhir-intake")
 new indx s indx=$na(@root@("POS","DFN"))
 n dfn,ien,filter,reslt
 s dfn=0
 f  s dfn=$o(@indx@(dfn)) q:+dfn=0  d  ;
 . s ien=$o(@indx@(dfn,""))
 . q:ien=""
 . s filter("dfn")=dfn
 . k reslt
 . d wsIntakeVitals(.filter,,.reslt,ien)
 q
 ;
