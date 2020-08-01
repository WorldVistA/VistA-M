SYNFIMM ;ven/gpl - fhir loader utilities ;Aug 15, 2019@15:21:45
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ;
 q
 ;
importImmu(rtn,ien,args) ; entry point for loading Immunizations for a patient
 ; calls the intake Immunizations web service directly
 ;
 n grtn
 d wsIntakeImmu(.args,,.grtn,ien)
 s rtn("immunizationsStatus","status")=$g(grtn("status","status"))
 s rtn("immunizationsStatus","loaded")=$g(grtn("status","loaded"))
 s rtn("immunizationsStatus","errors")=$g(grtn("status","errors"))
 quit
 ;
wsIntakeImmu(args,body,result,ien) ; web service entry (post)
 ; for intake of one or more Immunizations. input are fhir resources
 ; result is json and summarizes what was done
 ; args include patientId
 ; ien is specified for internal calls, where the json is already in a graph
 n jtmp,json,jrslt,eval
 ;i $g(ien)'="" if $$loadStatus("immunizations","",ien)=1 d  q  ;
 ;. s result("immunizationsStatus","status")="alreadyLoaded"
 i $g(ien)'="" d  ; internal call
 . d getIntakeFhir^SYNFHIR("json",,"Immunization",ien,1)
 e  d  ;
 . s args("load")=0
 . merge jtmp=BODY
 . do decode^SYNJSONE("jtmp","json")
 i '$d(json) q  ;
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
 . s result("immunizations",1,"log",1)="Error, patient not found.. terminating"
 ;
 ;
 new zi s zi=0
 for  set zi=$order(json("entry",zi)) quit:+zi=0  do  ;
 . ;
 . ; define a place to log the processing of this entry
 . ;
 . new jlog set jlog=$name(eval("immunizations",zi))
 . ;
 . ; insure that the resourceType is Observation
 . ;
 . new type set type=$get(json("entry",zi,"resource","resourceType"))
 . if type'="Immunization" do  quit  ;
 . . set eval("immunizations",zi,"vars","resourceType")=type
 . . do log(jlog,"Resource type not Immunization, skipping entry")
 . set eval("immunizations",zi,"vars","resourceType")=type
 . ;
 . ; see if this resource has already been loaded. if so, skip it
 . ;
 . if $g(ien)'="" if $$loadStatus("immunization",zi,ien)=1 do  quit  ;
 . . d log(jlog,"Immunization already loaded, skipping")
 . ;
 . ; determine Immunization cvx code, coding system, and display text
 . ;
 . ;
 . ; determine the id of the resource
 . ;
 . ;new id set id=$get(json("entry",zi,"resource","id"))
 . ;set eval("immunizations",zi,"vars","id")=id
 . ;d log(jlog,"ID is: "_id)
 . ;
 . new cvxcode set cvxcode=$get(json("entry",zi,"resource","vaccineCode","coding",1,"code"))
 . do log(jlog,"code is: "_cvxcode)
 . set eval("immunizations",zi,"vars","code")=cvxcode
 . ;
 . ;
 . new codesystem set codesystem=$get(json("entry",zi,"resource","vaccineCode","coding",1,"system"))
 . do log(jlog,"code system is: "_codesystem)
 . set eval("immunizations",zi,"vars","codeSystem")=codesystem
 . ;
 . ; determine the effective date
 . ;
 . new effdate set effdate=$get(json("entry",zi,"resource","date"))
 . do log(jlog,"effectiveDateTime is: "_effdate)
 . set eval("immunizations",zi,"vars","effectiveDateTime")=effdate
 . new fmtime s fmtime=$$fhirTfm^SYNFUTL(effdate)
 . d log(jlog,"fileman dateTime is: "_fmtime)
 . set eval("immunizations",zi,"vars","fmDateTime")=fmtime ;
 . new hl7time s hl7time=$$fhirThl7^SYNFUTL(effdate)
 . d log(jlog,"hl7 dateTime is: "_hl7time)
 . set eval("immunizations",zi,"vars","hl7DateTime")=hl7time ;
 . ;
 . ; determine the encounter visit ien
 . n encounterId
 . s encounterId=$g(json("entry",zi,"resource","encounter","reference"))
 . i encounterId["urn:uuid:" s encounterId=$p(encounterId,"urn:uuid:",2)
 . s eval("immunizations",zi,"vars","encounterId")=encounterId
 . d log(jlog,"reference encounter ID is : "_encounterId)
 . ;
 . n visitIen s visitIen=$$visitIen^SYNFENC(ien,encounterId)
 . s eval("immunizations",zi,"vars","visitIen")=visitIen
 . d log(jlog,"visit ien is: "_visitIen)
 . ;
 . ; set up to call the data loader
 . ;
 . ;IMMUNUPD(RETSTA,DHPPAT,VISIT,IMMUNIZ,ANATLOC,ADMINRT,DOSE,EVENTDT,IMMPROV)  ;Immunization update
 . n RETSTA,DHPPAT,VISIT,IMMUNIZ,ANATLOC,ADMINRT,DOSE,EVENTDT,IMMPROV      ;Immunization update
 . s (DHPPAT,VISIT,IMMUNIZ,ANATLOC,ADMINRT,DOSE,EVENTDT,IMMPROV)=""      ;Immunization update
 . ;
 . s DHPPAT=$$dfn2icn^SYNFUTL(dfn)
 . s eval("immunizations",zi,"parms","DHPPAT")=DHPPAT
 . ;
 . s VISIT=visitIen
 . s eval("immunizations",zi,"parms","VISIT")=visitIen
 . ;
 . s IMMUNIZ=cvxcode
 . s eval("immunizations",zi,"parms","IMMUNIZ")=IMMUNIZ
 . ;
 . ;
 . s EVENTDT=hl7time
 . s eval("immunizations",zi,"parms","EVENTDT")=hl7time
 . d log(jlog,"HL7 DateTime is: "_hl7time)
 . ;
 . s IMMPROV=$$MAP^SYNQLDM("OP","provider") ; should map to an NPI
 . ;n DHPPROVIEN s DHPPROVIEN=$o(^VA(200,"B",IMMPROV,""))
 . ;if DHPPROVIEN="" S DHPPROVIEN=3
 . s eval("immunizations",zi,"parms","IMMPROV")=IMMPROV
 . d log(jlog,"Provider NPI for outpatient is: "_IMMPROV)
 . ;
 . s DHPLOC=$$MAP^SYNQLDM("OP","location")
 . n DHPLOCIEN s DHPLOCIEN=$o(^SC("B",DHPLOC,""))
 . if DHPLOCIEN="" S DHPLOCIEN=4
 . s eval("immunizations",zi,"parms","DHPLOC")=DHPLOCIEN
 . d log(jlog,"Location for outpatient is: #"_DHPLOCIEN_" "_DHPLOC)
 . ;
 . s eval("immunizations",zi,"status","loadstatus")="readyToLoad"
 . ;
 . if $g(args("load"))=1 d  ; only load if told to
 . . if $g(ien)'="" if $$loadStatus("immunizations",zi,ien)=1 do  quit  ;
 . . . d log(jlog,"Immunization already loaded, skipping")
 . . d log(jlog,"Calling IMMUNUPD^ZZDHP61 to add immunization")
 . . D IMMUNUPD^SYNDHP61(.RETSTA,DHPPAT,.VISIT,IMMUNIZ,ANATLOC,ADMINRT,DOSE,EVENTDT,IMMPROV) ;Immunization update
 . . m eval("immunizations",zi,"status")=RETSTA
 . . d log(jlog,"Return from data loader was: "_$g(RETSTA))
 . . if +$g(RETSTA)=1 do  ;
 . . . s eval("immunizations","status","loaded")=$g(eval("immunizations","status","loaded"))+1
 . . . s eval("immunizations",zi,"status","loadstatus")="loaded"
 . . else  d  ;
 . . . s eval("immunizations","status","errors")=$g(eval("immunizations","status","errors"))+1
 . . . s eval("immunizations",zi,"status","loadstatus")="notLoaded"
 . . . s eval("immunizations",zi,"status","loadMessage")=$g(RETSTA)
 ;
 n root s root=$$setroot^SYNWD("fhir-intake")
 k @root@(ien,"load","immunizations")
 m @root@(ien,"load","immunizations")=eval("immunizations")
 ;
 if $get(args("debug"))=1 do  ;
 . m jrslt("source")=json
 . m jrslt("args")=args
 . m jrslt("eval")=eval
 m jrslt("immunizationsStatus")=eval("immunizationsStatus")
 set jrslt("result","status")="ok"
 set jrslt("result","loaded")=$g(eval("immunizations","status","loaded"))
 set jrslt("result","errors")=$g(eval("immunizations","status","errors"))
 i $g(ien)'="" d  ; called internally
 . ;m result=eval
 . m result("status")=jrslt("result")
 . ;b
 e  d  ;
 . d encode^SYNJSONE("jrslt","result")
 . set HTTPRSP("mime")="application/json"
 q
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
 ;
testall ; run the immunizations import on all imported patients
 new root s root=$$setroot^SYNWD("fhir-intake")
 new indx s indx=$na(@root@("POS","DFN"))
 n dfn,ien,filter,reslt
 s dfn=0
 f  s dfn=$o(@indx@(dfn)) q:+dfn=0  d  ;
 . s ien=$o(@indx@(dfn,""))
 . q:ien=""
 . s filter("dfn")=dfn
 . k reslt
 . d wsIntakeImmu(.filter,,.reslt,ien)
 q
 ;
testone(reslt,doload) ; run the immunizations import on all imported patients
 new root s root=$$setroot^SYNWD("fhir-intake")
 new indx s indx=$na(@root@("POS","DFN"))
 n dfn,ien,filter
 n done s done=0
 s dfn=0
 f  s dfn=$o(@indx@(dfn)) q:+dfn=0  q:done   d  ;
 . s ien=$o(@indx@(dfn,""))
 . q:ien=""
 . q:$d(@root@(ien,"load","immunizations"))
 . s filter("dfn")=dfn
 . s filter("debug")=1
 . i $g(doload)=1 s filter("load")=1
 . k reslt
 . d wsIntakeImmu(.filter,,.reslt,ien)
 . s done=1
 q
 ;
