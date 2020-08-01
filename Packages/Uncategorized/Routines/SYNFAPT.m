SYNFAPT ;ven/gpl - fhir loader utilities ;Aug 15, 2019@15:24:38
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ;
 q
 ;
importAppointment(rtn,ien,args) ; entry point for loading Appointment for a patient
 ; calls the intake Appointment web service directly
 ;
 n grtn
 d wsIntakeAppointment(.args,,.grtn,ien)
 s rtn("apptStatus","status")=$g(grtn("status","status"))
 s rtn("apptStatus","loaded")=$g(grtn("status","loaded"))
 s rtn("apptStatus","errors")=$g(grtn("status","errors"))
 ;b
 ;
 ;
 q
 ;
wsIntakeAppointment(args,body,result,ien)       ; web service entry (post)
 ; for intake of one or more Appointment. input are fhir resources
 ; result is json and summarizes what was done
 ; args include patientId
 ; ien is specified for internal calls, where the json is already in a graph
 n jtmp,json,jrslt,eval
 i $g(ien)'="" d  ; internal call
 . d getIntakeFhir^SYNFHIR("json",,"Appointment",ien,1)
 e  d  ;
 . s args("load")=0
 . merge jtmp=BODY
 . do decode^SYNJSONE("jtmp","json")
 ;if '$d(json) d  ; if no appointment, get a random set of appointments
 ;. d getRandomApt(.json) ; get a random set of appointments
 i '$d(json) q  ;
 m ^gpl("gjson")=json
 ;b
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
 . s result("appointment",1,"log",1)="Error, patient not found.. terminating"
 ;
 ;
 new zi s zi=0
 for  set zi=$order(json("entry",zi)) quit:+zi=0  do  ;
 . ;
 . ; define a place to log the processing of this entry
 . ;
 . new jlog set jlog=$name(eval("appointment",zi))
 . ;
 . ; insure that the resourceType is Apppointment
 . ;
 . new type set type=$get(json("entry",zi,"resource","resourceType"))
 . if type'="Appointment" do  quit  ;
 . . set eval("appointment",zi,"vars","resourceType")=type
 . . do log(jlog,"Resource type not Appointment, skipping entry")
 . set eval("appointment",zi,"vars","resourceType")=type
 . ;
 . ; see if this resource has already been loaded. if so, skip it
 . ;
 . if $g(ien)'="" if $$loadStatus("appointment",zi,ien)=1 do  quit  ;
 . . d log(jlog,"Appointment already loaded, skipping")
 . ;
 . ; determine the id of the resource
 . ;
 . ;new id set id=$get(json("entry",zi,"resource","id"))
 . ;set eval("appointment",zi,"vars","id")=id
 . ;d log(jlog,"ID is: "_id)
 . ;
 . ; determine the onset date and time
 . ;
 . new startdate set startdate=$get(json("entry",zi,"resource","start"))
 . do log(jlog,"startDateTime is: "_startdate)
 . set eval("appointment",zi,"vars","startDateTime")=startdate
 . new fmStartDateTime s fmStartDateTime=$$fhirTfm^SYNFUTL(startdate)
 . d log(jlog,"fileman startDateTime is: "_fmStartDateTime)
 . set eval("appointment",zi,"vars","fmStarttDateTime")=fmStartDateTime ;
 . new hl7StartDateTime s hl7StartDateTime=$$fhirThl7^SYNFUTL(startdate)
 . d log(jlog,"hl7 startDateTime is: "_hl7StartDateTime)
 . set eval("appointment",zi,"vars","hl7StartDateTime")=hl7StartDateTime ;
 . ;
 . ; determine clinical status (active vs inactive)
 . ;
 . n clinicalstatus set clinicalstatus=$get(json("entry",zi,"resource","status"))
 . ;
 . ; set up to call the data loader
 . ;
 . ;APPTADD(RETSTA,DHPPAT,DHPCLIN,DHPAPTDT,DHPLEN) ;Create appointment
 . ;
 . ; Input:
 . ;   DHPPAT   - Patient ICN (required)
 . ;   DHPCLIN  - Clinic Name (required)
 . ;   DHPAPTDT - Appointment Date & Time (required) all dates received in HL7 format
 . ;   DHPLEN   - Appointment length as minutes (optional, defaults to 15 mins.)
 . ;
 . ; Output:   RETSTA
 . ;  1 - success
 . ; -1 - failure -1^message
 . ;
 . n RETSTA,DHPPAT,DHPCLIN,DHPAPTDT,DHPLEN,DHPCIDT,DHPCODT
 . s (RETSTA,DHPPAT,DHPCLIN,DHPAPTDT,DHPLEN,DHPCIDT,DHPCODT)=""      ;Appointment update
 . ;
 . s DHPPAT=$$dfn2icn^SYNFUTL(dfn)
 . s eval("appointment",zi,"parms","DHPPAT")=DHPPAT
 . ;
 . s DHPAPTDT=hl7StartDateTime
 . s eval("appointment",zi,"parms","DHPAPTDT")=DHPAPTDT
 . ;
 . ;s DHPPROV=$$MAP^SYNQLDM("OP","provider") ; map should return the NPI number
 . ;n DHPPROVIEN s DHPPROVIEN=$o(^VA(200,"B",DHPPROV,""))
 . ;if DHPPROVIEN="" S DHPPROVIEN=3
 . ;s eval("appointment",zi,"parms","DHPPROV")=DHPPROV
 . ; log(jlog,"Provider NPI for outpatient is: "_DHPPROV)
 . ;
 . s DHPCLIN=$$MAP^SYNQLDM("OP","location")
 . n DHPLOCIEN s DHPLOCIEN=$o(^SC("B",DHPCLIN,""))
 . if DHPLOCIEN="" S DHPLOCIEN=4 S DHPCLIN=$$GET1^DIQ(44,DHPLOCIEN_",",.01)
 . s eval("appointment",zi,"parms","DHPCLIN")=DHPCLIN
 . d log(jlog,"Location for outpatient is: #"_DHPLOCIEN_" "_DHPCLIN)
 . ;
 . s eval("appointment",zi,"status","loadstatus")="readyToLoad"
 . ;
 . if $g(args("load"))=1 d  ; only load if told to
 . . if $g(ien)'="" if $$loadStatus("appointment",zi,ien)=1 do  quit  ;
 . . . d log(jlog,"Appointment already loaded, skipping")
 . . d log(jlog,"Calling APPTUPDT^SYNDHP62 to add appointment")
 . . D APPTADD^SYNDHP62(.RETSTA,DHPPAT,DHPCLIN,DHPAPTDT,DHPLEN) ;Create appointment
 . . ;D APPTUPDT^SYNDHP62(.RETSTA,DHPPAT,DHPCLIN,DHPAPTDT,DHPLEN,DHPCIDT,DHPCODT)        ;Appointment update
 . . m eval("appointment",zi,"status")=RETSTA
 . . d log(jlog,"Return from data loader was: "_$g(RETSTA))
 . . if +$g(RETSTA)=1 do  ;
 . . . s eval("status","loaded")=$g(eval("status","loaded"))+1
 . . . s eval("appointment",zi,"status","loadstatus")="loaded"
 . . else  d  ;
 . . . s eval("status","errors")=$g(eval("status","errors"))+1
 . . . s eval("appointment",zi,"status","loadstatus")="notLoaded"
 . . . s eval("appointment",zi,"status","loadMessage")=$g(RETSTA)
 . . n root s root=$$setroot^SYNWD("fhir-intake")
 . . k @root@(ien,"load","appointment",zi)
 . . m @root@(ien,"load","appointment",zi)=eval("appointment",zi)
 ;
 if $get(args("debug"))=1 do  ;
 . m jrslt("source")=json
 . m jrslt("args")=args
 . m jrslt("eval")=eval
 m jrslt("appointmentStatus")=eval("appointmentStatus")
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
testall ; run the appointment import on all imported patients
 new root s root=$$setroot^SYNWD("fhir-intake")
 new indx s indx=$na(@root@("POS","DFN"))
 n dfn,ien,filter,reslt
 s dfn=0
 f  s dfn=$o(@indx@(dfn)) q:+dfn=0  d  ;
 . s ien=$o(@indx@(dfn,""))
 . q:ien=""
 . s filter("dfn")=dfn
 . k reslt
 . d wsIntakeAppointment(.filter,,.reslt,ien)
 q
 ;
testone(reslt,doload)   ; run the appointment import on imported patient
 new root s root=$$setroot^SYNWD("fhir-intake")
 new indx s indx=$na(@root@("POS","DFN"))
 n dfn,ien,filter
 n done s done=0
 s dfn=0
 f  s dfn=$o(@indx@(dfn)) q:+dfn=0  q:done   d  ;
 . s ien=$o(@indx@(dfn,""))
 . q:ien=""
 . q:$d(@root@(ien,"load","appointment"))
 . s filter("dfn")=dfn
 . s filter("debug")=1
 . i $g(doload)=1 s filter("load")=1
 . k reslt
 . ;w !,"loading appointments for ien=",ien,!
 . d wsIntakeAppointment(.filter,,.reslt,ien)
 . ;zwr reslt
 . s done=1
 q
 ;
getRandomApt(ary)       ; make a web service call to get random appointments
 n srvr
 s srvr="http://postfhir.vistaplex.org:9080/"
 i srvr["postfhir.vistaplex.org" s srvr="http://138.197.70.229:9080/"
 i $g(^%WURL)["http://postfhir.vistaplex.org:9080" d  q  ;
 . s srvr="localhost:9080/"
 . n url
 . s url=srvr_"randomappointment"
 . n ok,r1
 . s ok=$$%^%WC(.r1,"GET",url)
 . i '$d(r1) q  ;
 . d decode^SYNJSONE("r1","ary")
 n url
 s url=srvr_"randomAllergy"
 n ret,json,jtmp
 s ret=$$GETURL^XTHC10(url,,"jtmp")
 d assemble^SYNFPUL("jtmp","json")
 i '$d(json) q  ;
 d decode^SYNJSONE("json","ary")
 q
 ;
