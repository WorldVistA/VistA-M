SYNFCON ;ven/gpl - fhir loader utilities ;2018-08-17  3:28 PM
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ;
 q
 ;
importConditions(rtn,ien,args)  ; entry point for loading conditions for a patient
 ; calls the intake Conditions web service directly
 ;
 n grtn
 n root s root=$$setroot^SYNWD("fhir-intake")
 d wsIntakeConditions(.args,,.grtn,ien)
 i $d(grtn) d  ; something was returned
 . k @root@(ien,"load","conditions")
 . m @root@(ien,"load","conditions")=grtn("conditions")
 . if $g(args("debug"))=1 m rtn=grtn
 s rtn("conditionsStatus","status")=$g(grtn("status","status"))
 s rtn("conditionsStatus","loaded")=$g(grtn("status","loaded"))
 s rtn("conditionsStatus","errors")=$g(grtn("status","errors"))
 ;b
 ;
 ;
 q
 ;
wsIntakeConditions(args,body,result,ien)        ; web service entry (post)
 ; for intake of one or more Conditions. input are fhir resources
 ; result is json and summarizes what was done
 ; args include patientId
 ; ien is specified for internal calls, where the json is already in a graph
 n jtmp,json,jrslt,eval
 ;i $g(ien)'="" if $$loadStatus("conditions","",ien)=1 d  q  ;
 ;. s result("conditionsStatus","status")="alreadyLoaded"
 i $g(ien)'="" d  ; internal call
 . d getIntakeFhir^SYNFHIR("json",,"Condition",ien,1)
 e  d  ;
 . s args("load")=0
 . merge jtmp=BODY
 . do decode^SYNJSONE("jtmp","json")
 i '$d(json) q  ;
 m ^gpl("gjson")=json
 ;
 ; determine the patient
 ;
 n dfn,eval
 if $g(ien)'="" d  ;
 . s dfn=$$ien2dfn^SYNFUTL(ien) ; look up dfn in the graph
 else  d  ;
 . s dfn=$g(args("dfn"))
 . i dfn="" d  ;
 . . n icn s icn=$g(args("icn"))
 . . i icn'="" s dfn=$$icn2dfn^SYNFUTL(icn)
 i $g(dfn)="" do  quit  ; need the patient
 . s result("conditions",1,"log",1)="Error, patient not found.. terminating"
 ;
 ;
 new zi s zi=0
 for  set zi=$order(json("entry",zi)) quit:+zi=0  do  ;
 . ;
 . ; define a place to log the processing of this entry
 . ;
 . new jlog set jlog=$name(eval("conditions",zi))
 . ;
 . ; insure that the resourceType is Condition
 . ;
 . new type set type=$get(json("entry",zi,"resource","resourceType"))
 . if type'="Condition" do  quit  ;
 . . set eval("conditions",zi,"vars","resourceType")=type
 . . do log(jlog,"Resource type not Condition, skipping entry")
 . set eval("conditions",zi,"vars","resourceType")=type
 . ;
 . ; see if this resource has already been loaded. if so, skip it
 . ;
 . if $g(ien)'="" if $$loadStatus("conditions",zi,ien)=1 do  quit  ;
 . . d log(jlog,"Vital sign already loaded, skipping")
 . ;
 . ; determine Conditions code, coding system, and display text
 . ;
 . ;
 . ; determine the id of the resource
 . ;
 . new id set id=$get(json("entry",zi,"resource","id"))
 . set eval("conditions",zi,"vars","id")=id
 . d log(jlog,"ID is: "_id)
 . ;
 . new concode set concode=$get(json("entry",zi,"resource","code","coding",1,"code"))
 . do log(jlog,"code is: "_concode)
 . set eval("conditions",zi,"vars","code")=concode
 . ;
 . ;
 . new codesystem set codesystem=$get(json("entry",zi,"resource","code","coding",1,"system"))
 . do log(jlog,"code system is: "_codesystem)
 . set eval("conditions",zi,"vars","codeSystem")=codesystem
 . ;
 . ; determine the code display text
 . ;
 . new context s context=$get(json("entry",zi,"resource","code","coding",1,"display"))
 . do log(jlog,"display text is: "_context)
 . set eval("conditions",zi,"vars","text")=context
 . ;
 . ; determine the effective date
 . ;
 . new effdate set effdate=$get(json("entry",zi,"resource","onsetDateTime"))
 . do log(jlog,"effectiveDateTime is: "_effdate)
 . set eval("conditions",zi,"vars","effectiveDateTime")=effdate
 . new fmtime s fmtime=$$fhirTfm^SYNFUTL(effdate)
 . d log(jlog,"fileman dateTime is: "_fmtime)
 . set eval("conditions",zi,"vars","fmDateTime")=fmtime ;
 . new hl7time s hl7time=$$fhirThl7^SYNFUTL(effdate)
 . d log(jlog,"hl7 dateTime is: "_hl7time)
 . set eval("conditions",zi,"vars","hl7DateTime")=hl7time ;
 . ;
 . ; determine the abatement date
 . ;
 . new abatedate set abatedate=$get(json("entry",zi,"resource","abatementDateTime"))
 . do log(jlog,"abatementDateTime is: "_abatedate)
 . set eval("conditions",zi,"vars","abatementDateTime")=effdate
 . new fmtime s fmtime=$$fhirTfm^SYNFUTL(abatedate)
 . d log(jlog,"fileman abatementDateTime is: "_fmtime)
 . set eval("conditions",zi,"vars","fmAbatementDateTime")=fmtime ;
 . new hl7time s hl7time=$$fhirThl7^SYNFUTL(abatedate)
 . d log(jlog,"hl7 abatementDateTime is: "_hl7time)
 . set eval("conditions",zi,"vars","hl7AbatementDateTime")=hl7time ;
 . ;
 . ; determine the status
 . ;
 . n constatus s constatus=$get(json("entry",zi,"resource","clinicalStatus"))
 . do log(jlog,"Clinical Status is: "_constatus)
 . set eval("conditions",zi,"vars","clinicalStatus")=constatus
 . ;
 . ; set up to call the data loader
 . ;
 . n RETSTA,DHPPAT,DHPSCT,DHPDTM,DHPPROV,DHPLOC,DHPTXT
 . ;
 . s DHPPAT=$$dfn2icn^SYNFUTL(dfn)
 . s eval("conditions",zi,"parms","DHPPAT")=DHPPAT
 . ;
 . s DHPSCT=concode
 . s eval("conditions",zi,"parms","DHPSCT")=DHPSCT
 . ;
 . s DHPTXT=context
 . s eval("conditions",zi,"parms","DHPTXT")=DHPTXT
 . ;
 . ;
 . s DHPDTM=hl7time
 . s eval("conditions",zi,"parms","DHPDTM")=hl7time
 . d log(jlog,"HL7 DateTime is: "_hl7time)
 . ;
 . s DHPPROV=$$MAP^SYNQLDM("OP","provider")
 . n DHPPROVIEN s DHPPROVIEN=$o(^VA(200,"B",DHPPROV,""))
 . if DHPPROVIEN="" S DHPPROVIEN=3
 . s eval("conditions",zi,"parms","DHPPROV")=DHPPROVIEN
 . d log(jlog,"Provider for outpatient is: #"_DHPPROVIEN_" "_DHPPROV)
 . ;
 . s DHPLOC=$$MAP^SYNQLDM("OP","location")
 . n DHPLOCIEN s DHPLOCIEN=$o(^SC("B",DHPLOC,""))
 . if DHPLOCIEN="" S DHPLOCIEN=4
 . s eval("conditions",zi,"parms","DHPLOC")=DHPLOCIEN
 . d log(jlog,"Location for outpatient is: #"_DHPLOCIEN_" "_DHPLOC)
 . ;
 . s eval("conditions",zi,"status","loadstatus")="readyToLoad"
 . ;
 . if $g(args("load"))=1 d  ; only load if told to
 . . if $g(ien)'="" if $$loadStatus("conditions",zi,ien)=1 do  quit  ;
 . . . d log(jlog,"Vital sign already loaded, skipping")
 . . d log(jlog,"Calling data loader to add encounter")
 . . d log(jlog,"Return from data loader was: "_$g(RETSTA))
 . . if +$g(RETSTA)=1 do  ;
 . . . s eval("status","loaded")=$g(eval("status","loaded"))+1
 . . . s eval("conditions",zi,"status","loadstatus")="loaded"
 . . else  s eval("status","errors")=$g(eval("status","errors"))+1
 ;
 if $get(args("debug"))=1 do  ;
 . m jrslt("source")=json
 . m jrslt("args")=args
 . m jrslt("eval")=eval
 m jrslt("conditionsStatus")=eval("conditionsStatus")
 set jrslt("result","status")="ok"
 set jrslt("result","loaded")=$g(eval("status","loaded"))
 i $g(ien)'="" d  ; called internally
 . m result=eval
 . m result("status")=jrslt("result")
 . ;b
 e  d  ;
 . d encode^SYNJSONE("jrslt","result")
 . set HTTPRSP("mime")="application/json"
 q
 ;
log(ary,txt)    ; adds a text line to @ary@("log")
 s @ary@("log",$o(@ary@("log",""),-1)+1)=$g(txt)
 q
 ;
loadStatus(typ,zx,zien) ; extrinsic return 1 if resource was loaded
 n root s root=$$setroot^SYNWD("fhir-intake")
 n rt s rt=0
 i $g(zx)="" i $d(@root@(zien,"load",typ)) s rt=1 q rt
 i $get(@root@(zien,"load",typ,zx,"status","loadstatus"))="loaded" s rt=1
 q rt
 ;
testall ; run the conditions import on all imported patients
 new root s root=$$setroot^SYNWD("fhir-intake")
 new indx s indx=$na(@root@("POS","DFN"))
 n dfn,ien,filter,reslt
 s dfn=0
 f  s dfn=$o(@indx@(dfn)) q:+dfn=0  d  ;
 . s ien=$o(@indx@(dfn,""))
 . q:ien=""
 . s filter("dfn")=dfn
 . k reslt
 . d wsIntakeConditions(.filter,,.reslt,ien)
 q
 ;
