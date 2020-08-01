SYNFPROC ;ven/gpl - fhir loader utilities ;Aug 15, 2019@14:27:49
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ;
 ;
 q
 ;
importProcedures(rtn,ien,args)  ; entry point for loading Procedures for a patient
 ; calls the intake Procedures web service directly
 ;
 n grtn
 n root s root=$$setroot^SYNWD("fhir-intake")
 d wsIntakeProcedures(.args,,.grtn,ien)
 ;
 s rtn("proceduresStatus","status")=$g(grtn("status","status"))
 s rtn("proceduresStatus","loaded")=$g(grtn("status","loaded"))
 s rtn("proceduresStatus","errors")=$g(grtn("status","errors"))
 ;b
 ;
 ;
 q
 ;
wsIntakeProcedures(args,body,result,ien) ; web service entry (post)
 ; for intake of one or more Procedures. input are fhir resources
 ; result is json and summarizes what was done
 ; args include patientId
 ; ien is specified for internal calls, where the json is already in a graph
 ;
 n root,troot
 s root=$$setroot^SYNWD("fhir-intake")
 ;
 n jtmp,json,jrslt,eval
 i $g(ien)'="" d  ; internal call
 . s troot=$na(@root@(ien,"type","Procedure"))
 . s eval=$na(@root@(ien,"load")) ; move eval to the graph
 e  q 0  ; sending not decoded json in BODY to this routine not supported
 ; todo: locate the patient and add the procedure in BODY to the graph
 s json=$na(@root@(ien,"json"))
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
 i $g(dfn)="" do  quit  ; need the patient
 . s result("procedures",1,"log",1)="Error, patient not found.. terminating"
 ;
 ;
 new zi s zi=0
 for  set zi=$order(@troot@(zi)) quit:+zi=0  do  ;
 . ;
 . ; define a place to log the processing of this entry
 . ;
 . new jlog set jlog=$name(@eval@("procedures",zi))
 . ;
 . ; insure that the resourceType is Procedure
 . ;
 . new type set type=$get(@json@("entry",zi,"resource","resourceType"))
 . if type'="Procedure" do  quit  ;
 . . set @eval@("procedures",zi,"vars","resourceType")=type
 . . do log(jlog,"Resource type not Procedure, skipping entry")
 . set @eval@("procedures",zi,"vars","resourceType")=type
 . ;
 . ; see if this resource has already been loaded. if so, skip it
 . ;
 . if $g(ien)'="" if $$loadStatus("procedure",zi,ien)=1 do  quit  ;
 . . d log(jlog,"Procedure already loaded, skipping")
 . ;
 . ; determine Procedure snomed code, coding system, and display text
 . ;
 . new sctcode set sctcode=$get(@json@("entry",zi,"resource","code","coding",1,"code"))
 . do log(jlog,"code is: "_sctcode)
 . set @eval@("procedures",zi,"vars","code")=sctcode
 . ;
 . ;
 . new codesystem set codesystem=$get(@json@("entry",zi,"resource","code","coding",1,"system"))
 . do log(jlog,"code system is: "_codesystem)
 . set @eval@("procedures",zi,"vars","codeSystem")=codesystem
 . ;
 . ; determine the date and time
 . ;
 . new performeddate set performeddate=$get(@json@("entry",zi,"resource","performedDateTime"))
 . i performeddate="" set performeddate=$get(@json@("entry",zi,"resource","performedPeriod","start"))
 . do log(jlog,"onsetDateTime is: "_performeddate)
 . set @eval@("procedures",zi,"vars","performedDateTime")=performeddate
 . new fmOnsetDateTime s fmOnsetDateTime=$$fhirTfm^SYNFUTL(performeddate)
 . d log(jlog,"fileman onsetDateTime is: "_fmOnsetDateTime)
 . set @eval@("procedures",zi,"vars","fmOnsetDateTime")=fmOnsetDateTime ;
 . new hl7OnsetDateTime s hl7OnsetDateTime=$$fhirThl7^SYNFUTL(performeddate)
 . d log(jlog,"hl7 onsetDateTime is: "_hl7OnsetDateTime)
 . set @eval@("procedures",zi,"vars","hl7OnsetDateTime")=hl7OnsetDateTime ;
 . ;
 . ;
 . ; determine the encounter visit ien
 . n encounterId
 . s encounterId=$g(@json@("entry",zi,"resource","context","reference"))
 . i encounterId="" s encounterId=$g(@json@("entry",zi,"resource","encounter","reference"))
 . i encounterId["urn:uuid:" s encounterId=$p(encounterId,"urn:uuid:",2)
 . s @eval@("procedures",zi,"vars","encounterId")=encounterId
 . d log(jlog,"reference encounter ID is : "_encounterId)
 . ;
 . ; determine visit ien
 . ;
 . n visitIen s visitIen=$$visitIen^SYNFENC(ien,encounterId)
 . s @eval@("procedures",zi,"vars","visitIen")=visitIen
 . d log(jlog,"visit ien is: "_visitIen)
 . ;
 . ; set up to call the data loader
 . ;
 . ;PRCADD(RETSTA,DHPPAT,DHPVST,DHPCNT,DHPDSCT,DHPDTM)
 . n RETSTA,DHPPAT,DHPVST,DHPCNT,DHPDSCT,DHPDTM ;
 . s (DHPPAT,DHPVST,DHPCNT,DHPDSCT,DHPDTM)=""
 . ;
 . s DHPPAT=$$dfn2icn^SYNFUTL(dfn)
 . s @eval@("procedures",zi,"parms","DHPPAT")=DHPPAT
 . ;
 . s DHPCNT=1 ; always one procedure per resource
 . ;
 . s DHPVST=visitIen
 . s @eval@("procedures",zi,"parms","DHPVST")=visitIen
 . ;
 . s DHPDSCT=sctcode
 . s @eval@("procedures",zi,"parms","DHPDSCT")=DHPDSCT
 . ;
 . s DHPDTM=hl7OnsetDateTime
 . s @eval@("procedures",zi,"parms","DHPDTM")=DHPDTM
 . ;
 . ;
 . s @eval@("procedures",zi,"status","loadstatus")="readyToLoad"
 . ;
 . if $g(args("load"))=1 d  ; only load if told to
 . . if $g(ien)'="" if $$loadStatus("procedures",zi,ien)=1 do  quit  ;
 . . . d log(jlog,"Procedure already loaded, skipping")
 . . d log(jlog,"Calling PRCADD^SYNDHP65 to add procedure")
 . . D PRCADD^SYNDHP65(.RETSTA,DHPPAT,DHPVST,DHPCNT,DHPDSCT,DHPDTM) ; procedures update
 . . m @eval@("procedures",zi,"status")=RETSTA
 . . d log(jlog,"Return from data loader was: "_$g(RETSTA))
 . . if +$g(RETSTA)=1 do  ;
 . . . s @eval@("procedures","status","loaded")=$g(@eval@("procedures","status","loaded"))+1
 . . . s @eval@("procedures",zi,"status","loadstatus")="loaded"
 . . else  d  ;
 . . . s @eval@("procedures","status","errors")=$g(@eval@("procedures","status","errors"))+1
 . . . s @eval@("procedures",zi,"status","loadstatus")="notLoaded"
 . . . s @eval@("procedures",zi,"status","loadMessage")=$g(RETSTA)
 ;
 if $get(args("debug"))=1 do  ;
 . m jrslt("source")=@json
 . m jrslt("args")=args
 . m jrslt("eval")=@eval
 m jrslt("proceduresStatus")=@eval@("proceduresStatus")
 set jrslt("result","status")="ok"
 set jrslt("result","loaded")=$g(@eval@("procedures","status","loaded"))
 set jrslt("result","errors")=$g(@eval@("procedures","status","errors"))
 i $g(ien)'="" d  ; called internally
 . ;m result=@eval
 . m result("status")=jrslt("result")
 . ;m result("dfn")=dfn
 . ;m result("ien")=ien
 e  d  ;
 . d encode^SYNJSONE("jrslt","result")
 . set HTTPRSP("mime")="application/json"
 q
 ;
log(ary,txt)  ; adds a text line to @ary@("log")
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
 ;
testall ; run the procedures import on all imported patients
 new root s root=$$setroot^SYNWD("fhir-intake")
 new indx s indx=$na(@root@("POS","DFN"))
 n dfn,ien,filter,reslt
 s dfn=" "
 f  s dfn=$o(@indx@(dfn),-1) q:+dfn=0  d  ;
 . s ien=$o(@indx@(dfn,""))
 . q:ien=""
 . s filter("dfn")=dfn
 . s filter("load")=1
 . k reslt
 . d wsIntakeProcedures(.filter,,.reslt,ien)
 q
 ;
testone(reslt,doload,ien) ; run the procedures import on one patients
 ; ien is optional but will be used if specified
 new root s root=$$setroot^SYNWD("fhir-intake")
 new indx s indx=$na(@root@("POS","DFN"))
 n dfn,filter
 n done s done=0
 s dfn=0
 i $g(ien)="" f  s dfn=$o(@indx@(dfn)) q:+dfn=0  q:done  d  ;
 . s ien=$o(@indx@(dfn,""))
 . q:ien=""
 . q:$d(@root@(ien,"load","procedures"))
 . s done=1
 i $g(ien)'="" d  ;
 . s filter("dfn")=$g(dfn)
 . s filter("debug")=1
 . i $g(doload)=1 s filter("load")=1
 . k reslt
 . d wsIntakeProcedures(.filter,,.reslt,ien)
 . s done=1
 q
 ;
procsum ; search all loaded patients and catelog the procedure codes
 n root,json,ien,table
 s root=$$setroot^SYNWD("fhir-intake")
 s ien=0
 f  s ien=$o(@root@(ien)) q:+ien=0  d  ;
 . k json
 . d getIntakeFhir^SYNFHIR("json",,"Procedure",ien,1)
 . n cde,txt,rien
 . s rien=0
 . f  s rien=$o(json("entry",rien)) q:+rien=0  d  ;
 . . n gn s gn=$na(json("entry",rien,"resource"))
 . . s cde=$g(@gn@("code","coding",1,"code"))
 . . q:cde=""
 . . s txt=$g(@gn@("code","coding",1,"display"))
 . . i '$d(table(cde)) s table(cde_" "_txt)=1 q  ;
 . . s table(cde,txt)=$g(table(cde,txt))+1
 n zi s zi=""
 f  s zi=$o(table(zi)) q:zi=""  d  ;
 . w !,zi
 . ;w "|"
 . ;w $o(table(zi,""))
 ;zwr table
 q
 ;
