SYNFGR  ;ven/gpl - fhir loader utilities ;2018-08-17  3:27 PM
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ;
 q
 ;
resources(ary,lvl)      ; finds all the fhir resources and counts them up
 ; returns ary, passed by name
 ;
 n root s root=$$setroot^SYNWD("fhir-intake")
 n ien,rien
 s (ien,rien)=0
 f  s ien=$o(@root@(ien)) q:+ien=0  d  ;
 . s rien=0
 . f  s rien=$o(@root@(ien,"json","entry",rien)) q:+rien=0  d  ;
 . . n rtype,rtext,rcode
 . . s rtype=$g(@root@(ien,"json","entry",rien,"resource","resourceType"))
 . . q:rtype=""
 . . s @ary@(rtype)=$g(@ary@(rtype))+1
 . . q:$g(lvl)<2
 . . i rtype="Goal" d  ;
 . . . s rtext=$g(@root@(ien,"json","entry",rien,"resource","description","text"))
 . . . q:rtext=""
 . . . s @ary@(rtype,rtext)=$g(@ary@(rtype,rtext))+1
 . . i rtype="Observation" d  ;
 . . . s rtext=$g(@root@(ien,"json","entry",rien,"resource","category",1,"coding",1,"code"))
 . . . q:rtext=""
 . . . ;i rtext="procedure" b
 . . . s @ary@(rtype,rtext)=$g(@ary@(rtype,rtext))+1
 . . i rtype="Procedure" d  ;
 . . . s rtext=$g(@root@(ien,"json","entry",rien,"resource","code","text"))
 . . . q:rtext=""
 . . . s rcode=$g(@root@(ien,"json","entry",rien,"resource","code","coding",1,"code"))
 . . . q:rcode=""
 . . . s @ary@(rtype,rtext,rcode)=$g(@ary@(rtype,rtext,rcode))+1
 . . i rtype="DiagnosticReport" d  ;
 . . . s rtext=$g(@root@(ien,"json","entry",rien,"resource","code","coding",1,"display"))
 . . . q:rtext=""
 . . . s @ary@(rtype,rtext)=$g(@ary@(rtype,rtext))+1
 . . i rtype="CarePlan" d  ;
 . . . s rtext=$g(@root@(ien,"json","entry",rien,"resource","category",1,"coding",1,"display"))
 . . . q:rtext=""
 . . . s @ary@(rtype,rtext)=$g(@ary@(rtype,rtext))+1
 q
 ;
careplans(ary,lvl)      ; finds all the careplans and counts them up
 ; returns ary, passed by name
 ;
 n root s root=$$setroot^SYNWD("fhir-intake")
 n ien,rien
 s (ien,rien)=0
 f  s ien=$o(@root@(ien)) q:+ien=0  d  ;
 . s rien=0
 . f  s rien=$o(@root@(ien,"json","entry",rien)) q:+rien=0  d  ;
 . . n rtype,rtext,rcode
 . . s rtype=$g(@root@(ien,"json","entry",rien,"resource","resourceType"))
 . . q:rtype=""
 . . ;s @ary@(rtype)=$g(@ary@(rtype))+1
 . . i rtype="Goal" d  ;
 . . . s rtext=$g(@root@(ien,"json","entry",rien,"resource","description","text"))
 . . . q:rtext=""
 . . . s @ary@(rtype,rtext)=$g(@ary@(rtype,rtext))+1
 . . i rtype="CarePlan" d  ;
 . . . s rtext=$g(@root@(ien,"json","entry",rien,"resource","category",1,"coding",1,"display"))
 . . . s rcode=$g(@root@(ien,"json","entry",rien,"resource","category",1,"coding",1,"code"))
 . . . q:rtext=""
 . . . s rtext=$g(rcode)_" "_rtext
 . . . s @ary@(rtype,rtext)=$g(@ary@(rtype,rtext))+1
 . . . n cp s cp=$na(@root@(ien,"json","entry",rien,"resource"))
 . . . i $d(@cp@("activity")) d  ;
 . . . . n act s act=0
 . . . . f  s act=$o(@cp@("activity",act)) q:+act=0  d  ;
 . . . . . n acode,atext,atext2
 . . . . . s acode=$g(@cp@("activity",act,"detail","code","coding",1,"code"))
 . . . . . s atext=$g(@cp@("activity",act,"detail","code","coding",1,"display"))
 . . . . . s atext2=acode_" "_$e(atext,1,60)
 . . . . . s @ary@(rtype,rtext,"activity",atext2)=$g(@ary@(rtype,rtext,"activity",atext2))+1
 q
 ;
makecpmap ; make a careplan map in a graph
 ;
 n root,map
 s root=$$setroot^SYNWD("careplanmap")
 d careplans("map")
 k @root
 m @root=map
 q
 ;
careplanshf(ary,lvl)      ; finds all the careplans and counts them up
 ; returns ary, passed by name
 ;
 n root s root=$$setroot^SYNWD("fhir-intake")
 n ien,rien
 s (ien,rien)=0
 n done s done=0
 f  s ien=$o(@root@(ien)) q:+ien=0  q:done  d  ;
 . s rien=0
 . f  s rien=$o(@root@(ien,"json","entry",rien)) q:+rien=0  d  ;
 . . n rtype,rtext,rtext2,rtext3,rcode,catext
 . . s rtype=$g(@root@(ien,"json","entry",rien,"resource","resourceType"))
 . . q:rtype=""
 . . ;s @ary@(rtype)=$g(@ary@(rtype))+1
 . . i rtype="Goal" d  ;
 . . . s rtext=$g(@root@(ien,"json","entry",rien,"resource","description","text"))
 . . . s rtext=$$HFGOAL^SYNFHF(rtext)
 . . . q:rtext=""
 . . . s @ary@(rtype,rtext)=$g(@ary@(rtype,rtext))+1
 . . i rtype="CarePlan" d  ;
 . . . n catien s catien=""
 . . . s rtext=$g(@root@(ien,"json","entry",rien,"resource","category",1,"coding",1,"display"))
 . . . s rcode=$g(@root@(ien,"json","entry",rien,"resource","category",1,"coding",1,"code"))
 . . . q:rtext=""
 . . . s catext=$$HFCPCAT^SYNFHF(rcode,rtext)
 . . . s catien=$p(catext,"^",1)
 . . . s catext=$p(catext,"^",2)
 . . . ;s rtext=$g(rcode)_" "_rtext
 . . . s @ary@(rtype,catext)=$g(@ary@(rtype,catext))+1
 . . . s rtext3=$$HFCP^SYNFHF(rcode,rtext,catien)
 . . . s rtext3=$p(rtext3,"^",2)
 . . . s @ary@(rtype,catext,"carePlanHF",rtext3)=$g(@ary@(rtype,catext,"carePlanHF",rtext3))+1
 . . . n cp s cp=$na(@root@(ien,"json","entry",rien,"resource"))
 . . . i $d(@cp@("activity")) d  ;
 . . . . n act s act=0
 . . . . f  s act=$o(@cp@("activity",act)) q:+act=0  d  ;
 . . . . . n acode,atext,atext2
 . . . . . s acode=$g(@cp@("activity",act,"detail","code","coding",1,"code"))
 . . . . . s atext=$g(@cp@("activity",act,"detail","code","coding",1,"display"))
 . . . . . ;s atext2=acode_" "_$e(atext,1,60)
 . . . . . s atext2=$e(atext,1,60)
 . . . . . s atext2=$$HFACT^SYNFHF(acode,atext2,catien)
 . . . . . s atext2=$p(atext2,"^",2)
 . . . . . s @ary@(rtype,catext,"activity",atext2)=$g(@ary@(rtype,catext,"activity",atext2))+1
 . . . ;s done=1
 q
 ;
makecpmaphf ; make a careplan map in a graph
 ;
 n root,map
 d purgegraph^SYNWD("cpmaphf3")
 s root=$$setroot^SYNWD("cpmaphf3")
 ;k @root
 d careplanshf("map")
 m @root=map
 q
 ;
