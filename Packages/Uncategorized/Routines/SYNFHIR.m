SYNFHIR ;ven/gpl - fhir loader utilities ; 6/28/19 2:00pm
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ;
 q
 ;
wsPostFHIR(ARGS,BODY,RESULT,ien)    ; recieve from addpatient
 ; ien is for internal calls to this routine, and is the ien
 ; in the graphstore for the decoded json
 ;
 s U="^"
 ;S DUZ=1
 ;S DUZ("AG")="V"
 ;S DUZ(2)=500
 S USER=$$DUZ^SYNDHP69
 ;
 ;new json,ien,root,gr,id,return
 new json,root,gr,id,return
 set root=$$setroot^SYNWD("fhir-intake")
 set id=$get(ARGS("id"))
 ;
 i $g(ien)="" d  ; not called internally
 . set ien=$order(@root@(" "),-1)+1
 . set gr=$name(@root@(ien,"json"))
 . merge json=BODY
 . do decode^SYNJSON("json",gr)
 ;
 do indexFhir(ien)
 ;
 if id'="" do  ;
 . set @root@("B",id,ien)=""
 else  do  ;
 . ;
 ;
 if $get(ARGS("returngraph"))=1 do  ;
 . merge return("graph")=@root@(ien,"graph")
 set return("status")="ok"
 set return("id")=id
 set return("ien")=ien
 ;
 do importPatient^SYNFPAT(.return,ien)
 ;
 new rdfn set rdfn=$get(return("dfn"))
 if rdfn'="" set @root@("DFN",rdfn,ien)=""
 ;
 if rdfn'="" do  ; patient creation was successful
 . if $g(ARGS("load"))="" s ARGS("load")=1
 . ;do taskLabs(.return,ien,.ARGS)
 . DO importLabs^SYNFLAB(.return,ien,.ARGS)
 . do importVitals^SYNFVIT(.return,ien,.ARGS)
 . do importEncounters^SYNFENC(.return,ien,.ARGS)
 . do importImmu^SYNFIMM(.return,ien,.ARGS)
 . do importConditions^SYNFPRB(.return,ien,.ARGS)
 . do importAllergy^SYNFALG(.return,ien,.ARGS)
 . do importAppointment^SYNFAPT(.return,ien,.ARGS)
 . do importMeds^SYNFMED2(.return,ien,.ARGS)
 . do importProcedures^SYNFPROC(.return,ien,.ARGS)
 . do importCarePlan^SYNFCP(.return,ien,.ARGS)
 ;
 do encode^SYNJSON("return","RESULT")
 set HTTPRSP("mime")="application/json"
 ;
 quit 1
 ;
indexFhir(ien)  ; generate indexes for parsed fhir json
 ;
 new root set root=$$setroot^SYNWD("fhir-intake")
 if $get(ien)="" quit  ;
 ;
 new jroot set jroot=$name(@root@(ien,"json","entry")) ; root of the json
 if '$data(@jroot) quit  ; can't find the json to index
 ;
 new jindex set jindex=$name(@root@(ien)) ; root of the index
 d clearIndexes(jindex)
 ;
 new %wi s %wi=0
 for  set %wi=$order(@jroot@(%wi)) quit:+%wi=0  do  ;
 . new type
 . set type=$get(@jroot@(%wi,"resource","resourceType"))
 . if type="" do  quit  ;
 . . w !,"error resource type not found ien= ",ien," entry= ",%wi
 . set @jindex@("type",type,%wi)=""
 . d triples(jindex,$na(@jroot@(%wi)),%wi)
 quit
 ;
triples(index,ary,%wi)  ; index and array are passed by name
 ;
 i type="Patient" d  q  ;
 . n purl s purl=$g(@ary@("fullUrl"))
 . i purl="" s purl=type_"/"_$g(@ary@("resource","id"))
 . i $e(purl,$l(purl))="/" s purl=purl_%wi
 . d setIndex(index,purl,"type",type)
 . d setIndex(index,purl,"rien",%wi)
 i type="Encounter" d  q  ;
 . n purl s purl=$g(@ary@("fullUrl"))
 . i purl="" s purl=type_"/"_$g(@ary@("resource","id"))
 . i $e(purl,$l(purl))="/" s purl=purl_%wi
 . d setIndex(index,purl,"type",type)
 . d setIndex(index,purl,"rien",%wi)
 . n sdate s sdate=$g(@ary@("resource","period","start")) q:sdate=""
 . n hl7date s hl7date=$$fhirThl7^SYNFUTL(sdate)
 . d setIndex(index,purl,"dateTime",sdate)
 . d setIndex(index,purl,"hl7dateTime",hl7date)
 . n class s class=$g(@ary@("resource","class","code")) q:class=""
 . d setIndex(index,purl,"class",class)
 i type="Condition" d  q  ;
 . n purl s purl=$g(@ary@("fullUrl"))
 . i purl="" s purl=type_"/"_$g(@ary@("resource","id"))
 . i $e(purl,$l(purl))="/" s purl=purl_%wi
 . d setIndex(index,purl,"type",type)
 . d setIndex(index,purl,"rien",%wi)
 . n enc s enc=$g(@ary@("resource","context","reference"))
 . i enc="" s enc=$g(@ary@("resource","encounter","reference")) q:enc=""
 . d setIndex(index,purl,"encounterReference",enc)
 . n pat s pat=$g(@ary@("resource","subject","reference")) q:pat=""
 . d setIndex(index,purl,"patientReference",pat)
 i type="Observation" d  q  ;
 . n purl s purl=$g(@ary@("fullUrl"))
 . i purl="" s purl=type_"/"_$g(@ary@("resource","id"))
 . i $e(purl,$l(purl))="/" s purl=purl_%wi
 . d setIndex(index,purl,"type",type)
 . d setIndex(index,purl,"rien",%wi)
 . n enc s enc=$g(@ary@("resource","context","reference"))
 . i enc="" s enc=$g(@ary@("resource","encounter","reference")) q:enc=""
 . d setIndex(index,purl,"encounterReference",enc)
 . n pat s pat=$g(@ary@("resource","subject","reference")) q:pat=""
 . d setIndex(index,purl,"patientReference",pat)
 i type="Medication" d  q  ;
 . n purl s purl=$g(@ary@("fullUrl"))
 . i purl="" s purl=type_"/"_$g(@ary@("resource","id"))
 . i $e(purl,$l(purl))="/" s purl=purl_%wi
 . i purl="" s purl=type_"/"_$g(@ary@("resource","id"))
 . d setIndex(index,purl,"type",type)
 . d setIndex(index,purl,"rien",%wi)
 i type="medicationReference" d  q  ;
 . n purl s purl=$g(@ary@("fullUrl"))
 . i purl="" s purl=type_"/"_$g(@ary@("resource","id"))
 . i $e(purl,$l(purl))="/" s purl=purl_%wi
 . d setIndex(index,purl,"type",type)
 . d setIndex(index,purl,"rien",%wi)
 . n enc s enc=$g(@ary@("resource","context","reference"))
 . i enc="" s enc=$g(@ary@("resource","encounter","reference")) q:enc=""
 . d setIndex(index,purl,"encounterReference",enc)
 . n pat s pat=$g(@ary@("resource","subject","reference")) q:pat=""
 . d setIndex(index,purl,"patientReference",pat)
 i type="Immunizationi" d  q  ;
 . n purl s purl=$g(@ary@("fullUrl"))
 . i purl="" s purl=type_"/"_$g(@ary@("resource","id"))
 . i $e(purl,$l(purl))="/" s purl=purl_%wi
 . d setIndex(index,purl,"type",type)
 . d setIndex(index,purl,"rien",%wi)
 . n enc s enc=$g(@ary@("resource","encounter","reference")) q:enc=""
 . d setIndex(index,purl,"encounterReference",enc)
 . n pat s pat=$g(@ary@("resource","patient","reference")) q:pat=""
 . d setIndex(index,purl,"patientReference",pat)
 n purl s purl=$g(@ary@("fullUrl"))
 i purl="" s purl=type_"/"_$g(@ary@("resource","id"))
 i $e(purl,$l(purl))="/" s purl=purl_%wi
 d setIndex(index,purl,"type",type)
 d setIndex(index,purl,"rien",%wi)
 n enc s enc=$g(@ary@("resource","context","reference"))
 i enc="" s enc=$g(@ary@("resource","encounter","reference"))
 d setIndex(index,purl,"encounterReference",enc)
 n pat s pat=$g(@ary@("resource","subject","reference"))
 i pat="" s pat=$g(@ary@("resource","patient","reference"))
 d setIndex(index,purl,"patientReference",pat)
 q
 ;
setIndex(gn,sub,pred,obj)       ; set the graph indexices
 ;n gn s gn=$$setroot^SYNWD("fhir-intake")
 q:sub=""
 q:pred=""
 q:obj=""
 s @gn@("SPO",sub,pred,obj)=""
 s @gn@("POS",pred,obj,sub)=""
 s @gn@("PSO",pred,sub,obj)=""
 s @gn@("OPS",obj,pred,sub)=""
 q
 ;
clearIndexes(gn)        ; kill the indexes
 k @gn@("SPO")
 k @gn@("POS")
 k @gn@("PSO")
 k @gn@("OPS")
 q
 ;
wsShow(rtn,filter)      ; web service to show the fhir
 new type set type=$get(filter("type"))
 new root set root=$$setroot^SYNWD("fhir-intake")
 ;
 new ien set ien=$g(filter("ien"))
 if ien="" d  ;
 . n icn
 . s icn=$g(filter("icn"))
 . q:icn=""
 . s ien=$o(@root@("ICN",icn,""))
 if ien="" d  ;
 . n dfn
 . s dfn=$g(filter("dfn"))
 . q:dfn=""
 . s ien=$o(@root@("DFN",dfn,""))
 if ien="" quit  ;
 ;
 new jroot set jroot=$name(@root@(ien,"json"))
 ;
 new jtmp,juse
 set juse=jroot
 if type'="" do  ;
 . do getIntakeFhir("jtmp",$g(filter("bundle")),type,ien,1)
 . ;do getIntakeFhir("jtmp",,type,ien,1)
 . set juse="jtmp"
 do encode^SYNJSON(juse,"rtn")
 s HTTPRSP("mime")="application/json"
 quit
 ;
getIntakeFhir(rtn,id,type,ien,plain)    ; returns fhir vars for patient bundle=id resourceType type
 ; id is the bundle date range to be returned, optional
 ; if id is not passed, all resources of the type are returned
 ; ien is required and is the graph ien of the patient
 ; rtn passed by name. it will overlay results in @rtn, so is additive
 ; if plain is 1 then the array is returned without the type as the first
 ;    element of each node
 ;
 new root set root=$$setroot^SYNWD("fhir-intake")
 if $g(ien)="" set ien=$order(@root@("B",id,""))
 if ien="" quit  ;
 ;
 if $get(type)="" set type="all"
 kill @rtn
 ;
 i $g(id)="" s id=""
 i $g(SYNBUNDLE)'="" S id=SYNBUNDLE
 ;
 if type'="all" do  quit  ;
 . do get1FhirType(rtn,root,ien,type,$get(plain),id)
 ;
 new jindex set jindex=$name(@root@(ien))
 new %wj set %wj=""
 for  set %wj=$order(@jindex@("type",%wj)) quit:%wj=""  do  ;
 . ;w !,"type ",%wj
 . do get1FhirType(rtn,root,ien,%wj,$get(plain),id)
 ;
 quit
 ;
get1FhirType(rtn,root,ien,type,plain,bundle)   ; get one resourceType from the json
 new %wi set %wi=0
 new jindex set jindex=$name(@root@(ien))
 if '$data(@jindex@("type",type)) quit  ;
 for  s %wi=$order(@jindex@("type",type,%wi)) quit:+%wi=0  do  ;
 . i $g(@jindex@(%wi,"bundle"))'=bundle q  ;
 . if $get(plain)=1 merge @rtn@("entry",%wi)=@root@(ien,"json","entry",%wi)
 . else  merge @rtn@(type,"entry",%wi)=@root@(ien,"json","entry",%wi)
 quit
 ;
fhir2graph(in,out)      ; transforms fhir to a graph
 ; in and out are passed by name
 ; detects if json parser has been run and will run it if not
 ;
 new json
 if $ql($q(@in@("")))<2 do decode^SYNJSON(in,"json") set in="json"
 ;
 new rootj
 set rootj=$na(@in@("entry"))
 new i,cnt
 for i=1:1:$order(@rootj@(" "),-1) do  ;
 . new rname
 . set rname=$get(@rootj@(i,"resource","resourceType"))
 . if rname="" do  quit  ;
 . . w !,"error no resourceType in entry: ",i
 . . ;zwrite @rootj@(i,*)
 . . b
 . if '$data(@out@(rname)) set cnt=1
 . else  set cnt=$order(@out@(rname,""),-1)+1
 . merge @out@(rname,cnt)=@rootj@(i,"resource")
 quit
 ;
taskLabs(return,ien,ARGS) ;load Labs with TASKMAN
 ;
 NEW YSDUZ,ZTRTN,ZTDESC,ZTDTH,ZTSAVE,ZTIO,PATIEN  ;,JOBNBR
 SET YSDUZ=DUZ
 SET ZTRTN="runLabs^SYNFHIR"
 SET ZTDESC="Load Patient Labs"
 SET ZTDTH=$H
 SET ZTIO=""
 SET JOBNBR=$J
 SET PATIEN=ien
 SET ZTSAVE("PATIEN")=""
 ;Submit the job to Taskman
 ;ZWRITE ARGS
 DO ^%ZTLOAD
 ;
 QUIT
 ;
runLabs ; This is what is submitted to Taskman
 NEW args,ien,return
 ;
 SET ien=PATIEN
 SET args("load")=1
 DO importLabs^SYNFLAB(.return,ien,.args)
 ;
 QUIT
 ;
getEntry(ary,ien,rien) ; returns one entry in ary, passed by name
 n root s root=$$setroot^SYNWD("fhir-intake")
 i '$d(@root@(ien,"json","entry",rien)) q  ;
 m @ary@("entry",rien)=@root@(ien,"json","entry",rien)
 q
 ;
loadStatus(ary,ien,rien) ; returns the "load" section of the patient graph
 ; if rien is not specified, all entries are included
 n root s root=$$setroot^SYNWD("fhir-intake")
 i '$d(@root@(ien)) q
 i $g(rien)="" d  q  ;
 . k @ary
 . m @ary@(ien)=@root@(ien,"load")
 n zi s zi=""
 f  s zi=$o(@root@(ien,"load",zi)) q:$d(@root@(ien,"load",zi,rien))
 k @ary
 m @ary@(ien,rien)=@root@(ien,"load",zi,rien)
 q
 ;
wsLoadStatus(rtn,filter) ; displays the load status
 ; filter must have ien or dfn to specify the patient
 ; optionally, entry number (rien) for a single entry
 ; if ien and dfn are both specified, dfn is used
 ; now supports latest=1 to show the load status of the lastest added patient
 n root s root=$$setroot^SYNWD("fhir-intake")
 n ien s ien=$g(filter("ien"))
 i $g(filter("latest"))=1 d  ;
 . set ien=$o(@root@(" "),-1)
 n dfn s dfn=$g(filter("dfn"))
 i dfn'="" s ien=$$dfn2ien^SYNFUTL(dfn)
 n rien s rien=$g(filter("rien"))
 q:ien=""
 n load
 d loadStatus("load",ien,rien)
 s filter("root")="load"
 s filter("local")=1
 d wsGLOBAL^SYNVPR(.rtn,.filter)
 q
 ;
FILE(directory) ; [Public] Load files from the file system; OPT: SYN LOAD FILES
 ;
 if '$data(directory) do
 . N DIR,X,Y,DA,DIRUT,DTOUT,DUOUT,DIROUT
 . S DIR(0)="F^0:1024"
 . S DIR("A")="Enter directory from which to load Synthea Patients (FHIR DSTU3 or R4)"
 . D ^DIR
 . W !
 . if '$data(DIRUT) set directory=Y
 quit:'$data(directory)
 ;
 ; Load files from directory
 new synfiles
 new synmask set synmask("*.json")=""
 new % set %=$$LIST^%ZISH(directory,$na(synmask),$na(synfiles))
 if '% write "Failed to read any files. Check directory.",! quit
 ;
 new file set file=""
 for  set file=$order(synfiles(file)) q:file=""  do
 . if file["Information" quit  ; We don't process information files yet...
 . ;
 . write "Loading ",file,"...",!
 . kill ^TMP("SYNFILE",$J)
 . new % set %=$$FTG^%ZISH(directory,file,$name(^TMP("SYNFILE",$J,1)),3)
 . i '% write "Failed to read the file. Please debug me.",! quit
 . ;
 . ; Normalize overflow nodes (and hope for the best that we don't go over 32k)
 . new i,j set (i,j)=""
 . for  set i=$order(^TMP("SYNFILE",$J,i)) quit:'i  for  set j=$order(^TMP("SYNFILE",$J,i,"OVF",j)) quit:'j  do
 .. set ^TMP("SYNFILE",$J,i)=^TMP("SYNFILE",$J,i)_^TMP("SYNFILE",$J,i,"OVF",j)  ; ** NOT TESTED **
 . ;
 . ; Now load the file into VistA
 . write "Ingesting ",file,"...",!
 . do
 .. new file,directory,synfiles
 .. do KILL^XUSCLEAN ; VistA leaks like hell
 . new args,body,synjsonreturn,ien,root,gr
 . set root=$$setroot^SYNWD("fhir-intake")
 . set ien=$order(@root@(" "),-1)+1
 . set gr=$name(@root@(ien,"json"))
 . s body=$na(^TMP("SYNFILE",$J))
 . do decode^SYNJSON(body,gr)
 . ;merge body=^TMP("SYNFILE",$J) ;don't need to merge because we decoded
 . ;new % set %=$$wsPostFHIR(.args,.body,.synjsonreturn) ; % always comes out as 1. We will ignore it.
 . new % set %=$$wsPostFHIR(.args,.body,.synjsonreturn,ien) ; % always comes out as 1. We will ignore it.
 . ;
 . ; Get the status back from JSON
 . new synreturn,synjsonerror
 . do decode^SYNJSON($na(synjsonreturn),$na(synreturn),$na(synjsonerror))
 . if $data(synjsonerror) write "There is an error decoding the return. Debug me." quit
 . ;
 . if $get(synreturn("loadMessage"))["Duplicate" write "Patient Already Loaded",! quit
 . ;
 . write "Loaded with following data: ",!
 . write "DFN: ",synreturn("dfn"),?20,"ICN: ",synreturn("icn"),?50,"Graph Store IEN: ",synreturn("ien"),!
 . write "--------------------------------------------------------------------------",!
 . write "Type",?30,"Loaded?",?60,"Error",!
 . ;
 . write "ADR/Allergy"
 . write ?30,synreturn("allergyStatus","loaded")
 . write ?60,synreturn("allergyStatus","errors")
 . write !
 . ;
 . write "Appointments"
 . write ?30,synreturn("apptStatus","loaded")
 . write ?60,synreturn("apptStatus","errors")
 . write !
 . ;
 . write "Care Plans"
 . write ?30,synreturn("careplanStatus","loaded")
 . write ?60,synreturn("careplanStatus","errors")
 . write !
 . ;
 . write "Problems"
 . write ?30,synreturn("conditionsStatus","loaded")
 . write ?60,synreturn("conditionsStatus","errors")
 . write !
 . ;
 . write "Encounters"
 . write ?30,synreturn("encountersStatus","loaded")
 . write ?60,synreturn("encountersStatus","errors")
 . write !
 . ;
 . write "Immunization"
 . write ?30,synreturn("immunizationsStatus","loaded")
 . write ?60,synreturn("immunizationsStatus","errors")
 . write !
 . ;
 . write "Labs"
 . write ?30,synreturn("labsStatus","loaded")
 . write ?60,synreturn("labsStatus","errors")
 . write !
 . ;
 . write "Meds"
 . write ?30,synreturn("medsStatus","loaded")
 . write ?60,synreturn("medsStatus","errors")
 . write !
 . ;
 . write "Procedures"
 . write ?30,synreturn("proceduresStatus","loaded")
 . write ?60,synreturn("proceduresStatus","errors")
 . write !
 . ;
 . write "Vitals"
 . write ?30,synreturn("vitalsStatus","loaded")
 . write ?60,synreturn("vitalsStatus","errors")
 . write !
 . ;
 . write !
 quit
 ;
