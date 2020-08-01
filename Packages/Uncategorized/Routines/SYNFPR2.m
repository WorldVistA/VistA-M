SYNFPR2 ;ven/gpl - fhir loader utilities ;2018-08-17  3:27 PM
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ;
 ; use SYNDHP61 instead of SYNDHP62 for problem update
 q
 ;
importConditions(rtn,ien,args)   ; entry point for loading Problems for a patient
 ; calls the intake Conditions web service directly
 ;
 n grtn
 n root s root=$$setroot^SYNWD("fhir-intake")
 d wsIntakeConditions(.args,,.grtn,ien)
 i $d(grtn) d  ; something was returned
 . k @root@(ien,"load","conditions")
 . m @root@(ien,"load","conditions")=grtn("conditions")
 . if $g(args("debug"))=1 m rtn=grtn
 s rtn("problemStatus","status")=$g(grtn("status","status"))
 s rtn("problemStatus","loaded")=$g(grtn("status","loaded"))
 s rtn("problemStatus","errors")=$g(grtn("status","errors"))
 ;b
 ;
 ;
 q
 ;
wsIntakeConditions(args,body,result,ien)               ; web service entry (post)
 ; for intake of one or more Conditions. input are fhir resources
 ; result is json and summarizes what was done
 ; args include patientId
 ; ien is specified for internal calls, where the json is already in a graph
 n jtmp,json,jrslt,eval
 ;i $g(ien)'="" if $$loadStatus("conditions","",ien)=1 d  q  ;
 ;. s result("problemStatus","status")="alreadyLoaded"
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
 . ; insure that the resourceType is Observation
 . ;
 . new type set type=$get(json("entry",zi,"resource","resourceType"))
 . if type'="Condition" do  quit  ;
 . . set eval("conditions",zi,"vars","resourceType")=type
 . . do log(jlog,"Resource type not Condition, skipping entry")
 . set eval("conditions",zi,"vars","resourceType")=type
 . ;
 . ; see if this resource has already been loaded. if so, skip it
 . ;
 . if $g(ien)'="" if $$loadStatus("condition",zi,ien)=1 do  quit  ;
 . . d log(jlog,"Condition already loaded, skipping")
 . ;
 . ; determine Condition snomed code, coding system, and display text
 . ;
 . ;
 . ; determine the id of the resource
 . ;
 . ;new id set id=$get(json("entry",zi,"resource","id"))
 . ;set eval("conditions",zi,"vars","id")=id
 . ;d log(jlog,"ID is: "_id)
 . ;
 . new sctcode set sctcode=$get(json("entry",zi,"resource","code","coding",1,"code"))
 . do log(jlog,"code is: "_sctcode)
 . set eval("conditions",zi,"vars","code")=sctcode
 . ;
 . ;
 . new codesystem set codesystem=$get(json("entry",zi,"resource","code","coding",1,"system"))
 . do log(jlog,"code system is: "_codesystem)
 . set eval("conditions",zi,"vars","codeSystem")=codesystem
 . ;
 . ; determine the onset date and time
 . ;
 . new onsetdate set onsetdate=$get(json("entry",zi,"resource","onsetDateTime"))
 . do log(jlog,"onsetDateTime is: "_onsetdate)
 . set eval("conditions",zi,"vars","onsetDateTime")=onsetdate
 . new fmOnsetDateTime s fmOnsetDateTime=$$fhirTfm^SYNFUTL(onsetdate)
 . d log(jlog,"fileman onsetDateTime is: "_fmOnsetDateTime)
 . set eval("conditions",zi,"vars","fmOnsetDateTime")=fmOnsetDateTime ;
 . new hl7OnsetDateTime s hl7OnsetDateTime=$$fhirThl7^SYNFUTL(onsetdate)
 . d log(jlog,"hl7 onsetDateTime is: "_hl7OnsetDateTime)
 . set eval("conditions",zi,"vars","hl7OnsetDateTime")=hl7OnsetDateTime ;
 . ;
 . ; determine the abatement date and time, if any
 . ;
 . new abatementdate set abatementdate=$get(json("entry",zi,"resource","abatementDateTime"))
 . if abatementdate'="" d  ;
 . . do log(jlog,"abatementDateTime is: "_abatementdate)
 . . set eval("conditions",zi,"vars","abatementDateTime")=abatementdate
 . . new fmAbatementDateTime s fmAbatementDateTime=$$fhirTfm^SYNFUTL(abatementdate)
 . . d log(jlog,"fileman abatementDateTime is: "_fmAbatementDateTime)
 . . set eval("conditions",zi,"vars","fmAbatementDateTime")=fmAbatementDateTime ;
 . . new hl7AbatementDateTime s hl7AbatementDateTime=$$fhirThl7^SYNFUTL(abatementdate)
 . . d log(jlog,"hl7 abatementDateTime is: "_hl7AbatementDateTime)
 . . set eval("conditions",zi,"vars","hl7AbatementDateTime")=hl7AbatementDateTime ;
 . else  d log(jlog,"no abatementDateTime")
 . ;
 . ; determine clinical status (active vs inactive)
 . ;
 . n clinicalstatus set clinicalstatus=$get(json("entry",zi,"resource","clinicalStatus"))
 . i $get(abatementdate)'="" set clinicalstatus="inactive" ; VistA doesn't allow active problems with a resolution date
 . ;
 . ; determine the encounter visit ien
 . n encounterId
 . s encounterId=$g(json("entry",zi,"resource","context","reference"))
 . i encounterId="" s encounterId=$g(json("entry",zi,"resource","encounter","reference"))
 . i encounterId["urn:uuid:" s encounterId=$p(encounterId,"urn:uuid:",2)
 . s eval("conditions",zi,"vars","encounterId")=encounterId
 . d log(jlog,"reference encounter ID is : "_encounterId)
 . ;
 . ; determine visit ien
 . ;
 . n visitIen s visitIen=$$visitIen^SYNFENC(ien,encounterId)
 . s eval("conditions",zi,"vars","visitIen")=visitIen
 . d log(jlog,"visit ien is: "_visitIen)
 . ;
 . ; ckeck to see if the problem is an allergy in VistA
 . ;
 . n algy s algy=$$ISGMR^SYNFALG(sctcode)
 . i algy'=-1 d  ; this condition is an allergy in VistA
 . . n aname s aname=$p(algy,"^",2)
 . . d QADDALGY^SYNFALG(aname,fmOnsetDateTime,ien)
 . ;
 . ; set up to call the data loader
 . ;
 . ;PRBUPDT(RETSTA,DHPPAT,DHPVST,DHPROV,DHPONS,DHPABT,DHPCLNST,DHPSCT)   ;Problem/Condition update - deprecated
 . ;PROBUPD(RETSTA,DHPPAT,DHPSCT,DHPSDES,DHPROV,DHPDTM,DHPRID) ; problems update - use this one
 . n RETSTA,DHPPAT,DHPSCT,DHPSDES,DHPROV,DHPDTM,DHPRID ;
 . ;n RETSTA,DHPPAT,DHPVST,DHPROV,DHPONS,DHPABT,DHPCLNST,DHPSCT ;Problem/Condition update
 . ;s (DHPPAT,DHPVST,DHPROV,DHPONS,DHPABT,DHPCLNST,DHPSCT)=""      ;Condition update
 . s (DHPPAT,DHPSCT,DHPSDES,DHPROV,DHPDTM,DHPRID)=""
 . ;
 . s DHPPAT=$$dfn2icn^SYNFUTL(dfn)
 . s eval("conditions",zi,"parms","DHPPAT")=DHPPAT
 . ;
 . s DHPVST=visitIen
 . s eval("conditions",zi,"parms","DHPVST")=visitIen
 . ;
 . s DHPSCT=sctcode
 . s eval("conditions",zi,"parms","DHPSCT")=DHPSCT
 . ;
 . ;s DHPCLNST=$S(clinicalstatus="Active":"A",1:"I")
 . ;s eval("conditions",zi,"parms","DHPCLNST")=DHPCLNST
 . ;
 . s DHPDTM=hl7OnsetDateTime
 . s eval("conditions",zi,"parms","DHPDTM")=DHPDTM
 . ;
 . s DHPPROV=$$MAP^SYNQLDM("OP","provider") ; map should return the NPI number
 . ;n DHPPROVIEN s DHPPROVIEN=$o(^VA(200,"B",IMMPROV,""))
 . ;if DHPPROVIEN="" S DHPPROVIEN=3
 . s eval("conditions",zi,"parms","DHPPROV")=DHPPROV
 . d log(jlog,"Provider NPI for outpatient is: "_DHPPROV)
 . ;
 . ;s DHPLOC=$$MAP^SYNQLDM("OP","location")
 . ;n DHPLOCIEN s DHPLOCIEN=$o(^SC("B",DHPLOC,""))
 . ;if DHPLOCIEN="" S DHPLOCIEN=4
 . ;s eval("conditions",zi,"parms","DHPLOC")=DHPLOCIEN
 . ;d log(jlog,"Location for outpatient is: #"_DHPLOCIEN_" "_DHPLOC)
 . ;
 . s eval("conditions",zi,"status","loadstatus")="readyToLoad"
 . ;
 . if $g(args("load"))=1 d  ; only load if told to
 . . if $g(ien)'="" if $$loadStatus("conditions",zi,ien)=1 do  quit  ;
 . . . d log(jlog,"Condition already loaded, skipping")
 . . d log(jlog,"Calling PROBUPD^SYNDHP61 to add condition")
 . . D PROBUPD^SYNDHP61(.RETSTA,DHPPAT,DHPSCT,DHPSDES,DHPROV,DHPDTM,DHPRID) ; problems update - use this one
 . . ;D PRBUPDT^SYNDHP62(.RETSTA,DHPPAT,DHPVST,DHPROV,DHPONS,DHPABT,DHPCLNST,DHPSCT)      ;Problem/Condition update
 . . m eval("conditions",zi,"status")=RETSTA
 . . d log(jlog,"Return from data loader was: "_$g(RETSTA))
 . . if +$g(RETSTA)=1 do  ;
 . . . s eval("status","loaded")=$g(eval("status","loaded"))+1
 . . . s eval("conditions",zi,"status","loadstatus")="loaded"
 . . else  d  ;
 . . . s eval("status","errors")=$g(eval("status","errors"))+1
 . . . s eval("conditions",zi,"status","loadstatus")="notLoaded"
 . . . s eval("conditions",zi,"status","loadMessage")=$g(RETSTA)
 . . n root s root=$$setroot^SYNWD("fhir-intake")
 . . k @root@(ien,"load","conditions",zi)
 . . m @root@(ien,"load","conditions",zi)=eval("conditions",zi)
 ;
 if $get(args("debug"))=1 do  ;
 . m jrslt("source")=json
 . m jrslt("args")=args
 . m jrslt("eval")=eval
 set jrslt("result","status")="ok"
 set jrslt("result","loaded")=$g(eval("status","loaded"))
 i $g(ien)'="" d  ; called internally
 . m result=eval
 . m result("status")=jrslt("result")
 . m result("dfn")=dfn
 . m result("ien")=ien
 . ;b
 e  d  ;
 . d encode^SYNJSONE("jrslt","result")
 . set HTTPRSP("mime")="application/json"
 q
 ;
log(ary,txt)       ; adds a text line to @ary@("log")
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
testone(reslt,doload)     ; run the conditions import on all imported patients
 new root s root=$$setroot^SYNWD("fhir-intake")
 new indx s indx=$na(@root@("POS","DFN"))
 n dfn,ien,filter
 n done s done=0
 s dfn=0
 f  s dfn=$o(@indx@(dfn)) q:+dfn=0  q:done   d  ;
 . s ien=$o(@indx@(dfn,""))
 . q:ien=""
 . q:$d(@root@(ien,"load","conditions"))
 . s filter("dfn")=dfn
 . s filter("debug")=1
 . i $g(doload)=1 s filter("load")=1
 . k reslt
 . d wsIntakeConditions(.filter,,.reslt,ien)
 . s done=1
 q
 ;
