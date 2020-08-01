SYNFCP ;ven/gpl - fhir loader utilities ;Aug 15, 2019@14:28:47
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2019
 ;
 q
 ;
importCarePlan(rtn,ien,args)  ; entry point for loading Careplans for a patient
 ; calls the intake Careplan web service directly
 ;
 n grtn
 n root s root=$$setroot^SYNWD("fhir-intake")
 d wsIntakeCareplan(.args,,.grtn,ien)
 ;
 s rtn("careplanStatus","status")=$g(grtn("status","status"))
 s rtn("careplanStatus","loaded")=$g(grtn("status","loaded"))
 s rtn("careplanStatus","errors")=$g(grtn("status","errors"))
 ;
 ;
 q
 ;
wsIntakeCareplan(args,body,result,ien)        ; web service entry (post)
 ; for intake of one or more Careplan. input are fhir resources
 ; result is json and summarizes what was done
 ; args include patientId
 ; ien is specified for internal calls, where the json is already in a graph
 ;
 n root,troot
 s root=$$setroot^SYNWD("fhir-intake")
 ;
 n jtmp,json,jrslt,eval
 i $g(ien)'="" d  ; internal call
 . s troot=$na(@root@(ien,"type","CarePlan"))
 . s eval=$na(@root@(ien,"load")) ; move eval to the graph
 e  q 0  ; sending not decoded json in BODY to this routine not supported
 ; todo: locate the patient and add the encounters in BODY to the graph
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
 . s result("careplan",1,"log",1)="Error, patient not found.. terminating"
 ;
 ;
 new zi s zi=0
 for  set zi=$order(@troot@(zi)) quit:+zi=0  do  ;
 . ;
 . ; define a place to log the processing of this entry
 . ;
 . new jlog set jlog=$name(@eval@("careplan",zi))
 . ;
 . d log(jlog,"DFN: "_dfn)
 . ;
 . ; insure that the resourceType is CarePlan
 . ;
 . new type set type=$get(@json@("entry",zi,"resource","resourceType"))
 . if type'="CarePlan" do  quit  ;
 . . set @eval@("careplan",zi,"vars","resourceType")=type
 . . do log(jlog,"Resource type not CarePlan, skipping entry")
 . set @eval@("careplan",zi,"vars","resourceType")=type
 . ;
 . ; see if this resource has already been loaded. if so, skip it
 . ;
 . if $g(ien)'="" if $$loadStatus("condition",zi,ien)=1 do  quit  ;
 . . d log(jlog,"CarePlan already loaded, skipping")
 . ;
 . ; determine CarePlan snomed code, coding system, and display text
 . ;
 . ;
 . ; determine the id of the resource
 . ;
 . new id set id=$get(@json@("entry",zi,"resource","id"))
 . set @eval@("careplan",zi,"vars","id")=id
 . d log(jlog,"ID is: "_id)
 . ;
 . ;
 . ; determine the encounter visit ien
 . n encounterId
 . s encounterId=$g(@json@("entry",zi,"resource","context","reference"))
 . i encounterId="" s encounterId=$g(@json@("entry",zi,"resource","encounter","reference"))
 . ;i encounterId["urn:uuid:" s encounterId=$p(encounterId,"urn:uuid:",2)
 . s @eval@("careplan",zi,"vars","encounterId")=encounterId
 . d log(jlog,"reference encounter ID is : "_encounterId)
 . ;
 . ; determine visit ien
 . ;
 . n visitIen s visitIen=$$visitIen^SYNFENC(ien,encounterId)
 . s @eval@("careplan",zi,"vars","visitIen")=visitIen
 . d log(jlog,"visit ien is: "_visitIen)
 . n visitDate s visitDate=$$GET1^DIQ(9000010,visitIen_",",.01,"I")
 . i visitDate'=-1 d  ;
 . . s @eval@("careplan",zi,"vars","visitDate")=visitDate
 . . d log(jlog,"visit date is: "_visitDate)
 . e  d log(jlog,"visit date unknow")
 . ;
 . ; determine the category code
 . ;
 . new sctcode set sctcode=$get(@json@("entry",zi,"resource","category",1,"coding",1,"code"))
 . n cattext s cattext=$get(@json@("entry",zi,"resource","category",1,"coding",1,"display"))
 . n x s $p(x,"-",80)=""
 . do TONOTE^SYNFTIU(ien,encounterId,x)
 . do TONOTE^SYNFTIU(ien,encounterId,"Care Plan Instituted")
 . do TONOTE^SYNFTIU(ien,encounterId,"")
 . do TONOTE^SYNFTIU(ien,encounterId,"Care Plan Category: ")
 . do TONOTE^SYNFTIU(ien,encounterId,"  "_cattext_" (SCT:"_sctcode_")")
 . do log(jlog,"category code is: "_sctcode)
 . do log(jlog,"category text is: "_cattext)
 . set @eval@("careplan",zi,"vars","code")=sctcode
 . set @eval@("careplan",zi,"vars","categoryText")=cattext
 . d log(jlog,"Care Plan Category Code: "_sctcode)
 . d log(jlog,"Care Plan Category Text: "_cattext)
 . n hfcat,hfcatien
 . s hfcat=$$HFCPCAT^SYNFHF(sctcode,cattext)
 . s hfcatien=+hfcat
 . d log(jlog,"Care Plan Category HF: "_hfcat)
 . n hfcp
 . s hfcp=$$HFCP^SYNFHF(sctcode,cattext,hfcatien)
 . d log(jlog,"Care Plan HF: "_hfcp)
 . ;
 . ; determine the "addresses" code
 . ;
 . n addcode s addcode=""
 . i $g(@json@("entry",zi,"resource","addresses",1,"reference"))'="" d  ;
 . . n condref
 . . s condref=$g(@json@("entry",zi,"resource","addresses",1,"reference"))
 . . q:condref=""
 . . d log(jlog,"Addresses Condition Reference: "_condref)
 . . s addcode=$$DX^SYNFCP(ien,condref)
 . . d log(jlog,"Addresses Code: "_addcode)
 . . d TONOTE^SYNFTIU(ien,encounterId,"Care Plan Addresses:")
 . . d TONOTE^SYNFTIU(ien,encounterId,"  "_$p(addcode,"^",2)_"(SCT:"_$p(addcode,"^",1)_")")
 . e  d log(jlog,"No Addresses Condition")
 . ;
 . ; the following will be needed for addresses diagnosis code
 . ;
 . ;n icdcode,notmapped,icdcodetype
 . ;s notmapped=0
 . ;i visitDate<3151001 s icdcodetype="icd9"
 . ;e  s icdcodetype="icd10"
 . ;d log(jlog,"icd code type is: "_icdcodetype)
 . ;i icdcodetype="icd9" s icdcode=$$MAP^SYNDHPMP("sct2icdnine",sctcode)
 . ;e  s icdcode=$$MAP^SYNDHPMP("sct2icd",sctcode)
 . ;i +icdcode=-1 s notmapped=1
 . ;d:notmapped MAPERR^SYNQLDM(sctcode,icdcodetype)
 . ;do log(jlog,"icd mapping is: "_icdcode)
 . ;do:notmapped log(jlog,"snomed code "_sctcode_" is not mapped")
 . ;set @eval@("careplan",zi,"vars","mappedIcdCode")=icdcode
 . ;
 . ; determine the beginning date and time
 . ;
 . new begindate
 . set begindate=$get(@json@("entry",zi,"resource","period","start"))
 . do log(jlog,"beginDateTime is: "_begindate)
 . set @eval@("careplan",zi,"vars","beginDateTime")=begindate
 . new fmBeginDateTime s fmBeginDateTime=$$fhirTfm^SYNFUTL(begindate)
 . d log(jlog,"fileman beginDateTime is: "_fmBeginDateTime)
 . set @eval@("careplan",zi,"vars","fmBeginDateTime")=fmBeginDateTime ;
 . new hl7BeginDateTime s hl7BeginDateTime=$$fhirThl7^SYNFUTL(begindate)
 . d log(jlog,"hl7 beginDateTime is: "_hl7BeginDateTime)
 . set @eval@("careplan",zi,"vars","hl7BeginDateTime")=hl7BeginDateTime ;
 . ;
 . ; determine the end date and time, if any
 . ;
 . new enddate set enddate=$get(@json@("entry",zi,"resource","period","end"))
 . new hl7EndDateTime s hl7EndDateTime=""
 . if enddate'="" d  ;
 . . do log(jlog,"endDateTime is: "_enddate)
 . . set @eval@("careplan",zi,"vars","endDateTime")=enddate
 . . new fmEndDateTime s fmEndDateTime=$$fhirTfm^SYNFUTL(enddate)
 . . d log(jlog,"fileman endDateTime is: "_fmEndDateTime)
 . . set @eval@("careplan",zi,"vars","fmEndDateTime")=fmEndDateTime ;
 . . s hl7EndDateTime=$$fhirThl7^SYNFUTL(enddate)
 . . d log(jlog,"hl7 endDateTime is: "_hl7EndDateTime)
 . . set @eval@("careplan",zi,"vars","hl7EndDateTime")=hl7EndDateTime ;
 . else  d log(jlog,"no endDateTime")
 . ;
 . ; determine careplan status (active vs inactive)
 . ;
 . n careplanstatus
 . set careplanstatus=$get(@json@("entry",zi,"resource","status"))
 . d log(jlog,"CarePlan Status: "_careplanstatus)
 . n catstr
 . s catstr=sctcode_"~"_cattext_"~"_careplanstatus
 . d log(jlog,"Care Plan Category string: "_catstr)
 . ;
 . ; add begindate, enddate, and careplanstatus to note
 . d TONOTE^SYNFTIU(ien,encounterId,"  Begin Date: "_$$FMTE^XLFDT(begindate))
 . d TONOTE^SYNFTIU(ien,encounterId,"  End Date: "_$$FMTE^XLFDT(enddate))
 . d TONOTE^SYNFTIU(ien,encounterId,"  Status: "_careplanstatus)
 . ; determine the encounter visit ien
 . n encounterId
 . s encounterId=$g(@json@("entry",zi,"resource","context","reference"))
 . i encounterId="" s encounterId=$g(@json@("entry",zi,"resource","encounter","reference"))
 . ;i encounterId["urn:uuid:" s encounterId=$p(encounterId,"urn:uuid:",2)
 . s @eval@("careplan",zi,"vars","encounterId")=encounterId
 . d log(jlog,"reference encounter ID is : "_encounterId)
 . ;
 . ; determine visit ien
 . ;
 . n visitIen s visitIen=$$visitIen^SYNFENC(ien,encounterId)
 . s @eval@("careplan",zi,"vars","visitIen")=visitIen
 . d log(jlog,"visit ien is: "_visitIen)
 . ;
 . ; activities
 . ;
 . n actary,actstr,actien,an
 . s actien=0
 . s actary=""
 . s actstr=""
 . s an=$na(@json@("entry",zi,"resource","activity"))
 . i $d(@an) d TONOTE^SYNFTIU(ien,encounterId,"Care Plan Activities")
 . f  s actien=$o(@an@(actien)) q:+actien=0  d  ;
 . . i actstr'="" s actstr=actstr_"^"
 . . s actary(actien,"code")=$g(@an@(actien,"detail","code","coding",1,"code"))
 . . s actstr=actstr_$g(@an@(actien,"detail","code","coding",1,"code"))
 . . s actary(actien,"text")=$g(@an@(actien,"detail","code","coding",1,"display"))
 . . s actstr=actstr_"~"_$g(@an@(actien,"detail","code","coding",1,"display"))
 . . s actary(actien,"system")=$g(@an@(actien,"detail","code","coding",1,"system"))
 . . s actary(actien,"status")=$g(@an@(actien,"detail","status"))
 . . d TONOTE^SYNFTIU(ien,encounterId,"  "_$g(actary(actien,"text"))_" (SCT:"_$g(actary(actien,"code"))_")")
 . . d TONOTE^SYNFTIU(ien,encounterId,"    status: "_$g(actary(actien,"status")))
 . . s actary(actien,"hf")=$$HFACT^SYNFHF($g(actary(actien,"code")),$g(actary(actien,"text")),hfcatien)
 . . d log(jlog,"CP Activity HF: "_$g(actary(actien,"hf")))
 . . s actstr=actstr_"~"_$g(@an@(actien,"detail","status"))
 . m @eval@("careplan",zi,"vars","activities")=actary
 . s @eval@("careplan",zi,"vars","actString")=actstr
 . d log(jlog,"Activity string: "_actstr)
 . ;
 . ; goals
 . ;
 . n goalary,goalstr,goalien,gn,goalcnt,goalroot,goaladdr
 . s goalcnt=0
 . s goalien=0
 . s goalary=""
 . s goalstr=""
 . s gn=$na(@json@("entry",zi,"resource","goal"))
 . n root s root=$$setroot^SYNWD("fhir-intake")
 . n groot s groot=$na(@root@(ien,"json","entry"))
 . f  s goalien=$o(@gn@(goalien)) q:+goalien=0  d  ;
 . . s goalcnt=goalcnt+1
 . . i goalcnt=1 d TONOTE^SYNFTIU(ien,encounterId,"Care Plan Goals")
 . . i goalstr'="" s goalstr=goalstr_"^"
 . . s goalroot=$na(@groot@(zi-goalcnt))
 . . ;b
 . . i $g(@goalroot@("resource","resourceType"))'="Goal" q  ;
 . . ;
 . . ; determine the "addresses" code for the goal
 . . ;
 . . n addcode s addcode=""
 . . n addrref
 . . s addrref=$g(@goalroot@("resource","addresses",1,"reference"))
 . . i addrref'="" d  ;
 . . . d log(jlog,"Goal Addresses Reference: "_addrref)
 . . . s addcode=$$DX^SYNFCP(ien,addrref)
 . . . d log(jlog,"Goal Addresses Code: "_addcode)
 . . e  d log(jlog,"No Goal Addresses Condition")
 . . s goalary(goalien,"code")=+addcode
 . . s goalstr=goalstr_+addcode
 . . s goalary(goalien,"text")=$g(@goalroot@("resource","description","text"))
 . . s goalstr=goalstr_"~"_$g(@goalroot@("resource","description","text"))
 . . s goalary(goalien,"system")="SCT"
 . . s goalary(goalien,"status")=$g(@goalroot@("resource","status"))
 . . d TONOTE^SYNFTIU(ien,encounterId,"  "_$g(goalary(goalien,"text")))
 . . d TONOTE^SYNFTIU(ien,encounterId,"    Addresses Condition: "_$p(addcode,"^",2)_" (SCT:"_+addcode_")")
 . . d TONOTE^SYNFTIU(ien,encounterId,"    status: "_$g(goalary(goalien,"status")))
 . . s goalary(goalien,"hf")=$$HFGOAL^SYNFHF($g(goalary(goalien,"code")),hfcatien,$g(goalary(goalien,"text")),$tr(addcode,"^","-"))
 . . d log(jlog,"CP Goal HF: "_$g(goalary(goalien,"hf")))
 . . s goalstr=goalstr_"~"_$g(@goalroot@("resource","status"))
 . m @eval@("careplan",zi,"vars","goals")=goalary
 . s @eval@("careplan",zi,"vars","goalString")=goalstr
 . d:goalstr'="" log(jlog,"Goal string: "_goalstr)
 . ;
 . ;b
 . ;
 . ; set up to call the data loader
 . ;
 . ;CPLUPDT(RETSTA,DHPPAT,DHPVST,DHPCAT,DHPACT,DHPGOL,DHPSCT,DHPSDT,DHPEDT) ;
 . ;
 . ; Input:
 . ; DHPPAT - Patient ICN
 . ; DHPVST - Visit ID
 . ; DHPCAT - Category ID (SCT code. text,and FHIR status )
 . ; DHPACT - List of Activities (SCT code, text, and FHIR status )
 . ; DHPGOL - List of Goals
 . ; DHPSCT - Reason for CarePlan (SCT code)
 . ; DHPSDT - CarePlan Period start
 . ; DHPEDT - CarePlan period end (optional)
 . ;
 . ;
 . ; Output: RETSTA
 . ; 1 - success
 . ; -1 - failure -1^message . ;
 . ;
 . n RETSTA,DHPPAT,DHPVST,DHPCAT,DHPGOL,DHPSCT,DHPSDT,DHPEDT ;CarePlan update
 . s (DHPPAT,DHPVST,DHPCAT,DHPGOL,DHPSCT,DHPSDT,DHPEDT)="" ;CarePlan update
 . ;
 . s DHPPAT=$$dfn2icn^SYNFUTL(dfn)
 . s @eval@("careplan",zi,"parms","DHPPAT")=DHPPAT
 . ;
 . s DHPVST=visitIen
 . s @eval@("careplan",zi,"parms","DHPVST")=visitIen
 . ;
 . s DHPSCT=$s(addcode'="":+addcode,1:"")
 . s @eval@("careplan",zi,"parms","DHPSCT")=DHPSCT
 . ;
 . s DHPCAT=$g(catstr)
 . s @eval@("careplan",zi,"parms","DHPCAT")=DHPCAT
 . ;
 . s DHPSDT=$g(hl7BeginDateTime)
 . s @eval@("careplan",zi,"parms","DHPSDT")=DHPSDT
 . ;
 . s DHPEDT=$g(hl7EndDateTime)
 . s @eval@("careplan",zi,"parms","DHPEDT")=DHPEDT
 . ;
 . s DHPACT=actstr
 . s @eval@("careplan",zi,"parms","DHPACT")=DHPACT
 . ;
 . s DHPGOL=goalstr
 . s @eval@("careplan",zi,"parms","DHPGOL")=DHPGOL
 . ;
 . ;s DHPROV=$$MAP^SYNQLDM("OP","provider") ; map should return the NPI number
 . ;s @eval@("careplan",zi,"parms","DHPROV")=DHPROV
 . ;d log(jlog,"Provider NPI for outpatient is: "_DHPROV)
 . ;
 . ;s DHPLOC=$$MAP^SYNQLDM("OP","location")
 . ;n DHPLOCIEN s DHPLOCIEN=$o(^SC("B",DHPLOC,""))
 . ;if DHPLOCIEN="" S DHPLOCIEN=4
 . ;s @eval@("careplan",zi,"parms","DHPLOC")=DHPLOCIEN
 . ;d log(jlog,"Location for outpatient is: #"_DHPLOCIEN_" "_DHPLOC)
 . ;
 . s @eval@("careplan",zi,"status","loadstatus")="readyToLoad"
 . ;
 . if $g(args("load"))=1 d  ; only load if told to
 . . if $g(ien)'="" if $$loadStatus("careplan",zi,ien)=1 do  quit  ;
 . . . d log(jlog,"CarePlan already loaded, skipping")
 . . d  ;  use DATA2PCE
 . . . d log(jlog,"Calling CPLUPDT^SYNDHP91 to add care plans")
 . . . D CPLUPDT^SYNDHP91(.RETSTA,DHPPAT,DHPVST,DHPCAT,DHPACT,DHPGOL,DHPSCT,DHPSDT,DHPEDT) ;
 . . m @eval@("careplan",zi,"status")=RETSTA
 . . i $g(DEBUG)=1 ZWR RETSTA
 . . d log(jlog,"Return from data loader was: "_$g(RETSTA))
 . . if +$g(RETSTA)=1 do  ;
 . . . s @eval@("careplan","status","loaded")=$g(@eval@("careplan","status","loaded"))+1
 . . . s @eval@("careplan",zi,"status","loadstatus")="loaded"
 . . else  d  ;
 . . . s @eval@("careplan","status","errors")=$g(@eval@("careplan","status","errors"))+1
 . . . s @eval@("careplan",zi,"status","loadstatus")="notLoaded"
 . . . s @eval@("careplan",zi,"status","loadMessage")=$g(RETSTA)
 . . n root s root=$$setroot^SYNWD("fhir-intake")
 ;
 if $get(args("debug"))=1 do  ;
 . m jrslt("source")=@json
 . m jrslt("args")=args
 . m jrslt("eval")=@eval
 m jrslt("careplanStatus")=@eval@("careplanStatus")
 set jrslt("result","status")="ok"
 set jrslt("result","loaded")=$g(@eval@("careplan","status","loaded"))
 set jrslt("result","errors")=$g(@eval@("careplan","status","errors"))
 i $g(ien)'="" d  ; called internally
 . ;m result=@eval
 . m result("status")=jrslt("result")
 . ;m result("dfn")=dfn
 . ;m result("ien")=ien
 . ;b
 e  d  ;
 . d encode^SYNJSONE("jrslt","result")
 . set HTTPRSP("mime")="application/json"
 q
 ;
log(ary,txt)    ; adds a text line to @ary@("log")
 s @ary@("log",$o(@ary@("log",""),-1)+1)=$g(txt)
 w:$G(DEBUG) !,"      ",$G(txt)
 q
 ;
loadStatus(typ,zx,zien) ; extrinsic return 1 if resource was loaded
 n root s root=$$setroot^SYNWD("fhir-intake")
 n rt s rt=0
 i $g(zx)="" i $d(@root@(zien,"load",typ)) s rt=1 q rt
 i '$d(@root@(zien,"load",typ,zx,"status")) q rt
 i $get(@root@(zien,"load",typ,zx,"status","loadstatus"))="loaded" s rt=1
 q rt
 ;
DX(ien,ptr,sep) ; extrinsic returns code^text for diagnosis in
 ; a condition pointed to by ptr in patient ien
 ; sep is optional separator - default is "^"
 i $g(sep)="" s sep="^"
 n root s root=$$setroot^SYNWD("fhir-intake")
 i '$d(@root@(ien,"SPO",ptr)) q ""
 n sct,txt,rien
 i $o(@root@(ien,"SPO",ptr,"type",""))'="Condition" q ""
 s rien=$o(@root@(ien,"SPO",ptr,"rien",""))
 q:rien="" ""
 s sct=$g(@root@(ien,"json","entry",rien,"resource","code","coding",1,"code"))
 q:sct="" ""
 s txt=$g(@root@(ien,"json","entry",rien,"resource","code","coding",1,"display"))
 q sct_sep_txt
 ;
testall ; run the careplan import on all imported patients
 new root s root=$$setroot^SYNWD("fhir-intake")
 new indx s indx=$na(@root@("POS","DFN"))
 n dfn,ien,filter,reslt
 s dfn=0
 f  s dfn=$o(@indx@(dfn)) q:+dfn=0  d  ;
 . s ien=$o(@indx@(dfn,""))
 . q:ien=""
 . s filter("dfn")=dfn
 . k reslt
 . d wsIntakeCareplan(.filter,,.reslt,ien)
 q
 ;
testone(reslt,doload)   ; run the careplan import on all imported patients
 new root s root=$$setroot^SYNWD("fhir-intake")
 new indx s indx=$na(@root@("POS","DFN"))
 n dfn,ien,filter
 n done s done=0
 s dfn=0
 f  s dfn=$o(@indx@(dfn)) q:+dfn=0  q:done   d  ;
 . s ien=$o(@indx@(dfn,""))
 . q:ien=""
 . q:$d(@root@(ien,"load","careplan"))
 . s filter("dfn")=dfn
 . s filter("debug")=1
 . i $g(doload)=1 s filter("load")=1
 . k reslt
 . d wsIntakeCareplan(.filter,,.reslt,ien)
 . s done=1
 q
 ;
