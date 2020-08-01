SYNFPUL ;ven/gpl - fhir loader utilities ;2018-08-17  3:26 PM
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ;
 ;
 ; patient list pull routines
 q
 ;
wsPull(rtn,filter)      ; pull web service. assumes url to list is passed as filter("listurl")=url
 ;
 n groot s groot=$$setroot^SYNWD("patient-lists")
 ;
 n listurl s listurl=$g(filter("listurl"))
 q:listurl=""
 i listurl["synthea1m.vistaplex.org" d  ;
 . s listurl="http://138.197.147.128"_$p(listurl,"synthea1m.vistaplex.org",2)
 ;
 n listname
 s listname=$re($p($re(listurl),"/",1))
 i listname[":" s listname=$p(listname,":",2)
 i listname["?" s listname=$p(listname,"?",1)
 ;
 n ret,json,jtmp
 s ret=$$GETURL^XTHC10(listurl,,"jtmp")
 d assemble("jtmp","json")
 ;s ret=$$%^%WC(.json,"GET",listurl)
 w !,"return is: ",ret,!
 ;zwrite json
 ;
 n lien,jary
 s lien=$o(@groot@("B",listname,""))
 i lien'="" k @groot@(lien)
 e  set lien=$order(@groot@(" "),-1)+1
 s @groot@("B",listname,lien)=""
 ;
 set gr=$name(@groot@(lien,"list"))
 do decode^SYNJSONE("json",gr)
 s @gr@("listname")=listname
 do indexList(lien)
 s rtn("listien")=lien
 ;
 ;w !
 ;zwrite @gr@(*)
 ;
 q
 ;
testpull        ;
 s lurl="http://synthea1m.vistaplex.org:9080/see/tag:random-over50-notDead-M-10-2?format=json"
 s filter("listurl")=lurl
 d wsPull(.g,.filter)
 q
 ;
indexList(ien)  ; produce the index for a patient list
 ;
 n lroot s lroot=$$setroot^SYNWD("patient-lists")
 n zi s zi=""
 f  s zi=$o(@lroot@(ien,"list","items",zi)) q:zi=""  d  ;
 . n title s title=$g(@lroot@(ien,"list","items",zi,"title"))
 . s @lroot@(ien,"B",title,zi)=""
 q
 ;
wsLol(rtn,filter)       ; list of list web service
 ;
 n groot s groot=$$setroot^SYNWD("list-of-lists")
 ;
 n listurl s listurl="http://synthea1m.vistaplex.org:9080/see/rand*?format=json"
 ;n listurl s listurl="http://138.197.147.128:9080/see/rand*?format=json"
 ;
 n listname
 s listname=listurl
 ;s listname=$re($p($re(listurl),"/",1))
 ;i listname[":" s listname=$p(listname,":",2)
 i listname["?" s listname=$p(listname,"?",1)
 ;
 n zret,json,jtmp
 ;s zret=$$GETURL^XTHC10(listurl,,"jtmp")
 ;d assemble("jtmp","json")
 s zret=$$%^%WC(.json,"GET",listurl)
 ;w !,"return is: ",zret,!
 ;zwrite json
 ;
 n lien,jary
 s lien=$o(@groot@("B",listname,""))
 i lien'="" k @groot@(lien)
 e  set lien=$order(@groot@(" "),-1)+1
 s @groot@("B",listname,lien)=""
 ;
 set gr=$name(@groot@(lien,"list"))
 do decode^SYNJSONE("json",gr)
 s @gr@("listname")=listname
 do indexLol(lien)
 k @gr@("listname")
 ;
 s rtn=$na(^TMP("SYNFHIR",$J))
 k @rtn
 n jout m jout=@gr
 k jout("listname")
 ;m @rtn=json
 d encode^SYNJSONE("jout",rtn)
 set HTTPRSP("mime")="application/json"
 q
 ;
wsLol2(rtn,filter)      ; list of list web service
 ;
 n groot s groot=$$setroot^SYNWD("list-of-lists")
 ;
 ;n listurl s listurl="http://synthea1m.vistaplex.org:9080/see/rand*?format=json"
 n listurl s listurl="http://138.197.147.128:9080/see/rand*?format=json"
 ;
 n listname
 s listname=listurl
 ;s listname=$re($p($re(listurl),"/",1))
 ;i listname[":" s listname=$p(listname,":",2)
 i listname["?" s listname=$p(listname,"?",1)
 ;
 n zret,json,jtmp
 ;s zret=$$GETURL^XTHC10(listurl,,"jtmp")
 ;d assemble("jtmp","json")
 s zret=$$%^%WC(.json,"GET",listurl)
 ;w !,"return is: ",zret,!
 ;zwrite json
 ;
 ;n lien,jary
 ;s lien=$o(@groot@("B",listname,""))
 ;i lien'="" k @groot@(lien)
 ;e  set lien=$order(@groot@(" "),-1)+1
 ;s @groot@("B",listname,lien)=""
 ;
 ;set gr=$name(@groot@(lien,"list"))
 ;do decode^SYNJSONE("json",gr)
 ;s @gr@("listname")=listname
 ;do indexLol(lien)
 ;k @gr@("listname")
 ;
 s rtn=$na(^TMP("SYNFHIR",$J))
 k @rtn
 ;n jout m jout=@gr
 ;k jout("listname")
 m @rtn=json
 ;d encode^SYNJSONE("jout",rtn)
 set HTTPRSP("mime")="application/json"
 q
 ;
indexLol(ien)   ;
 ;
 n lroot s lroot=$$setroot^SYNWD("list-of-lists")
 n zi s zi=""
 f  s zi=$o(@lroot@(ien,"list","items",zi)) q:zi=""  d  ;
 . n title s title=$g(@lroot@(ien,"list","items",zi,"title"))
 . s @lroot@(ien,"B",title,zi)=""
 q
 ;
getlol  ; get list of lists
 ;
 n groot s groot=$$setroot^SYNWD("list-of-lists")
 ;
 n listurl
 ;s listurl="http://synthea1m.vistaplex.org:9080/see/dhp-vista*?format=json"
 s listurl="http://138.197.147.128:9080/see/dhp-vista*?format=json"
 ;
 n listname
 s listname=listurl
 i listname["?" s listname=$p(listname,"?",1)
 ;
 q:$d(@groot@("B",listname))  ; list already loaded
 ;
 n zret,json,jtmp
 ;s zret=$$%^%WC(.json,"GET",listurl)
 s zret=$$GETURL^XTHC10(listurl,,"jtmp")
 d assemble("jtmp","json")
 w !,"return is: ",zret,!
 ;zwrite json
 ;
 n lien,jary
 s lien=$o(@groot@("B",listname,""))
 i lien'="" k @groot@(lien)
 e  set lien=$order(@groot@(" "),-1)+1
 s @groot@("B",listname,lien)=""
 ;
 set gr=$name(@groot@(lien,"list"))
 do decode^SYNJSONE("json",gr)
 s @gr@("listname")=listname
 do indexLol(lien)
 ;
 q
 ;
assemble(in,out)        ; reassemble json from the pieces
 n zi,zj
 s @out=""
 s zi=0
 f  s zi=$o(@in@(zi)) q:+zi=0  d  ;
 . s @out=@out_@in@(zi)
 . s zj=0
 . f  s zj=$o(@in@(zi,zj)) q:+zj=0  d  ;
 . . s @out=@out_$g(@in@(zi,zj))
 q
 ;
load1list(zlist)        ;
 n lroot s lroot=$$setroot^SYNWD("patient-lists")
 n lolroot s lolroot=$$setroot^SYNWD("list-of-lists")
 n uselist
 ;s uselist="http://synthea1m.vistaplex.org:9080/see/dhp-vista*"
 s uselist="http://138.197.147.128:9080/see/dhp-vista*"
 n lolien s lolien=$o(@lolroot@("B",uselist,"")) ; ien of the list of lists
 ;
 n uselist2 s uselist2=zlist
 n zl
 s zl=$o(@lolroot@(lolien,"B",uselist2,""))
 i zl="" d  q  ;
 . w !,"Error, list not found: "_uselist2
 ;
 n ltitle s ltitle=$g(@lolroot@(lolien,"list","items",zl,"title"))
 n lurl s lurl=$g(@lolroot@(lolien,"list","items",zl,"url"))
 ;
 i lurl="" d  q  ;
 . w !,"error list url not found"
 ;
 n lien
 s lien=$o(@lroot@("B",ltitle,""))
 i lien'="" d  q lien  ;
 . w !,"list already loaded: "_ltitle_" ien: "_lien
 ;
 w !,"title: ",ltitle
 w !,"url: ",lurl
 ;
 n filter s filter("listurl")=lurl
 n lret
 d wsPull(.lret,.filter)
 ;
 s lien=$g(lret("listien"))
 i lien="" d  q  ;
 . w !,"error, list ien not returned"
 ;
 q lien
 ;
test1pat(rtn,start,end) ;
 k rtn
 n lroot s lroot=$$setroot^SYNWD("patient-lists")
 n uselist s uselist="dhp-vista-1000-1"
 n listien s listien=$o(@lroot@("B",uselist,""))
 q:listien=""
 n listroot s listroot=$na(@lroot@(listien,"list","items"))
 n pid,purl
 i $g(start)="" s start=1
 i $g(end)="" s end=start
 n num
 f num=start:1:end d
 . s pid=$g(@listroot@(num,"title"))
 . s purl=$g(@listroot@(num,"url"))
 . n filter
 . s filter("id")=pid
 . s filter("url")=purl
 . q:purl=""
 . d wsLoadPat(.rtn,.filter)
 q
 ;
loadpats(rtn,listien)   ;
 k rtn
 n lroot s lroot=$$setroot^SYNWD("patient-lists")
 n froot s froot=$$setroot^SYNWD("fhir-intake")
 q:listien=""
 n listroot s listroot=$na(@lroot@(listien,"list","items"))
 n pid,purl
 n num s num=0
 f  s num=$o(@listroot@(num)) q:+num=0  d  ;
 . s pid=$g(@listroot@(num,"title"))
 . s purl=$g(@listroot@(num,"url"))
 . n filter
 . s filter("id")=pid
 . s filter("url")=purl
 . q:purl=""
 . i $d(@froot@("B",pid)) d  q  ; already loaded
 . . w !,"patient already loaded: "_pid
 . w !,"loading patient "_pid
 . d wsLoadPat(.rtn,.filter)
 q
 ;
wsLoadPat(zrtn,zfilter) ; load one patient from a URL
 ; zfilter("url")=patienturl
 ; zfilter("id")=patientID
 ; returns same as wsPostFHIR^SYNFHIR
 ;
 s U="^"
 ;
 n ret,json,purl
 s purl=$g(zfilter("url"))
 i purl="" d  q  ;
 . s zrtn="-1^URL not found"
 i purl["synthea1m.vistaplex.org" d  ;
 . s purl="http://138.197.147.128"_$p(purl,"synthea1m.vistaplex.org",2)
 ;
 ;s ret=$$%^%WC(.json,"GET",purl)
 n jtmp
 s ret=$$GETURL^XTHC10(purl,,"jtmp")
 d assemble("jtmp","json")
 i +ret=-1 d  s $ec=",u-error,"
 . w !,ret," ",purl
 ;
 i json["error" s zrtn="-1^Bundle returned error" q  ;
 i json="" s zrtn="-1^Bundle returned null" q  ;
 ;
 new ien,root,gr,id,return
 set root=$$setroot^SYNWD("fhir-intake")
 set id=$get(zfilter("id"))
 ;
 set ien=$order(@root@(" "),-1)+1
 set gr=$name(@root@(ien,"json"))
 do decode^SYNJSONE("json",gr)
 do indexFhir^SYNFHIR(ien)
 W:ien#500=0 !,"Patient # "_ien_" "_$$FMTE^XLFDT($$NOW^XLFDT)
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
 . do importLabs^SYNFLAB(.return,ien,.ARGS)
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
 ;do encode^SYNJSONE("return","RESULT")
 ;do encode^SYNJSONE("return","zrtn")
 set HTTPRSP("mime")="application/json"
 ;
 quit
 ;
TEST1K  ; test loading first 1000 patients in the lists
 d getlol ; get the list of lists
 n lstien ; ien in patient-lists that we will process
 n lname s lname="dhp-vista-1000-1" ; name of the first list
 s lstien=$$load1list(lname) ; load the first list and return the ien
 d loadpats(.return,lstien) ; load the patients from the first list
 q
 ;
LOADALL ; load all 50000 patients
 d getlol ; get the list of lists
 n lstien ; ien in patient-lists that we will process
 n tlname s tlname="dhp-vista-1000-" ; template for the list names
 n ii
 f ii=1:1:50 d  ; for all 50 lists
 . s lname=tlname_ii ; name of the list
 . s lstien=$$load1list(lname) ; load the list and return the ien
 . d loadpats(.return,lstien) ; load the patients from the list
 q
 ;
CLEANGRAPH      ;
 ;
 n groot s groot=$$setroot^SYNWD("fhir-intake")
 n zi,zj,zk
 s (zi,zj,zk)=""
 f  s zi=$o(@groot@("B",zi)) q:zi=""  d  ;
 . s zj=$o(@groot@("B",zi,""))
 . s zk=$o(@groot@("B",zi,zj))
 . i zk'="" d  ; a duplicate
 . . i $$ien2dfn^SYNFUTL(zk)'="" q  ; has a VistA record
 . . w !,"removing ien: "_zk_" name: "_zi
 . . k @groot@(zk) ; clear the graph
 . . k @groot@("B",zi,zk) ; remove from the index
 q
 ;
