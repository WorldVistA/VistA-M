SYNFHIRU ;ven/gpl - fhir loader utilities ;2018-08-17  3:27 PM
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ;
 q
 ;
wsUpdatePatient(ARGS,BODY,RESULT)    ; recieve from updatepatient
 ;
 s U="^"
 ;S DUZ=1
 ;S DUZ("AG")="V"
 ;S DUZ(2)=500
 S USER=$$DUZ^SYNDHP69
 ;
 new json,ien,root,gr,id,return
 set root=$$setroot^SYNWD("fhir-intake")
 set id=$get(ARGS("id"))
 ;
 ; first locate the patient to be updated
 ;
 n icn s icn=$g(ARGS("icn"))
 i (icn="")&(id="") d  q 0 ; set http error to bad request
 . s HTTPERR=400 ; bad request
 s ien=$o(@root@("POS","ICN",icn,""))
 i ien="" d  ; try id
 . s ien=$o(@root@("POS","ICN",id,"")) ; ok to use id instead of icn
 . i ien'="" s icn=id
 i ien="" d  q 0 ; icn not found
 . s HTTPERR=404
 ;
 merge json=BODY
 i '$d(json) d  q 0 ;
 . s HTTPERR=400
 ;
 n gr1,zi,cnt,rien ; initial entries
 do decode^SYNJSONE("json","gr1")
 ;
 ; shift resource numbers to fit in graph
 ;
 n lastrien s lastrien=$o(@root@(ien,"json","entry"," "),-1)
 s zi=0 s cnt=0
 f  s zi=$o(gr1("entry",zi)) q:+zi=0  d  ;
 . s cnt=cnt+1
 . s rien=lastrien+cnt
 . m gr(ien,"json","entry",rien)=gr1("entry",zi)
 ;
 ;
 do indexFhir(ien,"gr")
 ;k ^gpl("gr")
 ;m ^gpl("gr")=gr ; for debugging
 ;
 ;
 if $get(ARGS("returngraph"))=1 do  ;
 . merge return("graph")=gr
 set return("status")="ok"
 set return("icn")=icn
 set return("ien")=ien
 n bundle s bundle=$$bundleId($na(gr(ien)))
 set return("bundle")=bundle
 set ARGS("bundle")=bundle ; ingest only resources in this bundle
 s SYNBUNDLE=bundle
 ;
 ; commit the bundle to the graph
 m @root=gr
 ;
 new rdfn set rdfn=$o(@root@("SPO",ien,"DFN",""))
 if rdfn'="" set @root@("DFN",rdfn,ien)=""
 ;
 if rdfn'="" do  ; patient creation was successful
 . if $g(ARGS("load"))="" s ARGS("load")=1
 . ;do taskLabs(.return,ien,.ARGS)
 . DO importLabs^SYNFLAB(.return,ien,.ARGS)
 . do importVitals^SYNFVIT(.return,ien,.ARGS)
 . do importEncounters^SYNFENC(.return,ien,.ARGS)
 . do importImmu^SYNFIMM(.return,ien,.ARGS)
 . do importConditions^SYNFPR2(.return,ien,.ARGS)
 . do importAllergy^SYNFALG(.return,ien,.ARGS)
 . do importAppointment^SYNFAPT(.return,ien,.ARGS)
 . do importMeds^SYNFMED2(.return,ien,.ARGS)
 . do importProcedures^SYNFPROC(.return,ien,.ARGS)
 . do importCarePlan^SYNFCP(.return,ien,.ARGS)
 ;
 k SYNBUNDLE
 do encode^SYNJSONE("return","RESULT")
 set HTTPRSP("mime")="application/json"
 ;
 quit 1
 ;
indexFhir(ien,root)  ; generate indexes for parsed fhir json
 ;
 i $g(root)="" set root=$$setroot^SYNWD("fhir-intake")
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
 ;
 n bund
 s bund=$$bundleId(jindex)
 s %wi=0
 f  s %wi=$o(@jroot@(%wi)) q:+%wi=0  d  ;
 . s @jindex@(%wi,"bundle")=bund
 . d setIndex(jindex,%wi,"bundle",bund)
 ;
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
 i type="Immunization" d  q  ;
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
 i enc="" s enc=$g(@ary@("resource","encounter","reference")) q:enc=""
 d setIndex(index,purl,"encounterReference",enc)
 n pat s pat=$g(@ary@("resource","subject","reference")) q:pat=""
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
bundleId(ary) ; extrinsic returns the bundle date range
 n low,high
 s low=$o(@ary@("POS","dateTime",""))
 q:low="" ""
 s high=$o(@ary@("POS","dateTime",""),-1)
 s low=$p(low,"T",1)
 s high=$p(high,"T",1)
 q low_":"_high
 ;
clearIndexes(gn)        ; kill the indexes
 k @gn@("SPO")
 k @gn@("POS")
 k @gn@("PSO")
 k @gn@("OPS")
 q
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
