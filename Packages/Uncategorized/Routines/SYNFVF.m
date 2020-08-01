SYNFVF  ;ven/gpl - fhir loader utilities ;2018-08-17  3:28 PM
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2018
 ;
 q
 ;
 ; utilities to pull FHIR resources for VistA patients
 ;
vurl()  ; extrinsic returns the url for VistA get fhir
 q "https://vista-fhir-dev.openplatform.healthcare/api/Patient/"
 ;
wsIcnList(rtn,filter)   ; web service to return a list of ICNs for vista patients
 n dnfmin,dfnmax
 s dfnmin=$g(filter("dfnmin"))
 i dfnmin="" s dfnmin=$o(^DPT(0))
 s dfnmax=$g(filter("dfnmax"))
 i dfnmax="" s dfnmax=$o(^DPT("  "),-1)
 ;
 n tbl ; table of full ICNs sorted by dfn
 d sortAFICN(.tbl)
 ;
 n rtn1 ; json return before decode
 n zi s zi=+$o(tbl(dfnmin),-1)
 f  s zi=$o(tbl(zi)) q:+zi=0  q:zi>dfnmax  d  ;
 . n zj s zj=""
 . f  s zj=$o(tbl(zi,zj)) q:zj=""  d  ;
 . . s rtn1("return",zi,zj,"icn")=zj
 . . s rtn1("return",zi,zj,"dfn")=zi
 ;m rtn=rtn1
 d encode^SYNJSONE("rtn1","rtn")
 q
 ;
sortAFICN(ary)  ; sort the AFICN index by dfn
 n zii s zii=""
 f  s zii=$o(^DPT("AFICN",zii)) q:+zii=0  d  ;
 . n zdfn
 . s zdfn=$o(^DPT("AFICN",zii,""))
 . s ary(zdfn,zii)=""
 q
 ;
getVehuIcns     ; get the Dev VEHU ICNs and stores them in a graph
 n gn,root
 d purgegraph^SYNWD("vehu-icns")
 s root=$$setroot^SYNWD("vehu-icns")
 s gn="http://wip.vistaplex.org:9080/icnlist?dfnmax=100000"
 s ok=$$%^%WC(.g,"GET",gn)
 d decode^SYNJSONE("g","g2")
 ;
 n zi,zj s (zi,zj)=""
 f  s zi=$o(g2("return",zi)) q:zi=""  d  ;
 . f  s zj=$o(g2("return",zi,zj)) q:zj=""  d  ;
 . . s @root@(zi,zj)=""
 . . s @root@("ICN",zj,zi)=""
 ;
 q
 ;
getAllergies    ; get VEHU allergies fhir resources
 ;
 n icnroot s icnroot=$$setroot^SYNWD("vehu-icns")
 ;
 d purgegraph^SYNWD("fhir-vista-AllergyIntolerance")
 n zicn s zicn=""
 f  s zicn=$o(@icnroot@("ICN",zicn)) q:zicn=""  d  ;
 . n domain,entries
 . s domain="AllergyIntolerance"
 . d getDomain("entries",domain,zicn)
 . i '$d(entries) q  ;
 . s entries("ICN")=zicn
 . s entries("DFN")=$o(@icnroot@("ICN",zicn,""))
 . s zien=$$storeGraph("entries","fhir-vista-"_domain,zicn)
 q
 ;
getAppointments ; get VEHU appointment fhir resources
 ;
 n icnroot s icnroot=$$setroot^SYNWD("vehu-icns")
 ;
 d purgegraph^SYNWD("fhir-vista-Appointment")
 n zicn s zicn=""
 f  s zicn=$o(@icnroot@("ICN",zicn)) q:zicn=""  d  ;
 . n domain,entries
 . s domain="Appointment"
 . d getDomain("entries",domain,zicn)
 . i '$d(entries) q  ;
 . s entries("ICN")=zicn
 . s entries("DFN")=$o(@icnroot@("ICN",zicn,""))
 . s zien=$$storeGraph("entries","fhir-vista-"_domain,zicn)
 q
 ;
getProcedures   ; get VEHU procedure fhir resources
 ;
 n icnroot s icnroot=$$setroot^SYNWD("vehu-icns")
 ;
 d purgegraph^SYNWD("fhir-vista-Procedure")
 n zicn s zicn=""
 f  s zicn=$o(@icnroot@("ICN",zicn)) q:zicn=""  d  ;
 . n domain,entries
 . s domain="Procedure"
 . d getDomain("entries",domain,zicn)
 . i '$d(entries) q  ;
 . s entries("ICN")=zicn
 . s entries("DFN")=$o(@icnroot@("ICN",zicn,""))
 . s zien=$$storeGraph("entries","fhir-vista-"_domain,zicn)
 q
 ;
getDomain(rtn,domain,icn)       ; pull domain entries for VistA patient ICN
 n gn2
 s gn2="https://vista-fhir-dev.openplatform.healthcare/api/Patient/"
 ;
 n url,fhir,r1
 s url=gn2_icn_"/"_domain
 s ok=$$%^%WC(.fhir,"GET",url)
 d decode^SYNJSONE("fhir","r1")
 m @rtn@("entry")=r1("entry")
 ;
 q
 ;
storeGraph(ary,graph,id)        ; stores an array ary, passed by name
 ; into graphname graph with B index id
 ; extrinsic, returns the ien
 ;
 i graph="" s graph="misc"
 n root set root=$$setroot^SYNWD(graph)
 ;
 n ien,rien
 s ien=$o(@root@(" "),-1)+1
 ;
 m @root@(ien)=@ary
 ;
 s @root@("B",id,ien)=""
 ;
 q ien
 ;
wsGetAllergy(rtn,filter)        ; web service to pull a random allergy from
 ; graph fhir-vista-Allergy
 ;
 n root s root=$$setroot^SYNWD("fhir-vista-AllergyIntolerance")
 n max
 s max=$o(@root@(" "),-1)
 i +max=0 q  ; nothing to pull
 n ien s ien=$r(max)
 i '$d(@root@(ien)) s ien=$r(max)
 n r1
 s r1=$na(@root@(ien))
 i $g(filter("format"))="mumps" d  q  ;
 . m rtn=@r1
 d encode^SYNJSONE(r1,"rtn")
 q
 ;
wsGetAppointment(rtn,filter)    ; web service to pull a random appointments from
 ; graph fhir-vista-Appointment
 ;
 n root s root=$$setroot^SYNWD("fhir-vista-Appointment")
 n max
 s max=$o(@root@(" "),-1)
 i +max=0 q  ; nothing to pull
 n ien s ien=$r(max)
 i '$d(@root@(ien)) s ien=$r(max)
 n r1
 s r1=$na(@root@(ien))
 i $g(filter("format"))="mumps" d  q  ;
 . m rtn=@r1
 d encode^SYNJSONE(r1,"rtn")
 q
 ;
wsGetProcedure(rtn,filter)      ; web service to pull a random procedure from
 ; graph fhir-vista-Procedure
 ;
 n root s root=$$setroot^SYNWD("fhir-vista-Procedure")
 n max
 s max=$o(@root@(" "),-1)
 i +max=0 q  ; nothing to pull
 n ien s ien=$r(max)
 i '$d(@root@(ien)) s ien=$r(max)
 n r1
 s r1=$na(@root@(ien))
 i $g(filter("format"))="mumps" d  q  ;
 . m rtn=@r1
 d encode^SYNJSONE(r1,"rtn")
 q
 ;
