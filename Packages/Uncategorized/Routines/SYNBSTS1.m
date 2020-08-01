SYNBSTS1 ;ven/gpl - fhir loader utilities ;2018-08-17  3:22 PM
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ;
 q
 ;
ICD9ROOT() ; returns the root of the snomed to icd9 graph
 n root s root=$$setroot^SYNWD("icd9tosnomed")
 q:root=""
 s root=$na(@root@("graph","icd9tosnomed.csv"))
 q root
 ;
ICD10ROOT() ; returns the root of the snomed to icd10 graph
 n root s root=$$setroot^SYNWD("sct2icd")
 s root=$na(@root@("graph","sct2icd"))
 q root
 ;
match ; try matching snomed codes between icd9 and icd10 graphs
 n zi,gicd9,gicd10
 s gicd9=$$ICD9ROOT
 s gicd10=$$ICD10ROOT
 s zi=0
 n cnt s cnt=0
 f  s zi=$o(@gicd9@(zi)) q:+zi=0  d  ;
 . q:'$d(@gicd9@(zi))
 . n sct,icd9,icd10
 . s sct=$g(@gicd9@(zi,"SNOMED"))
 . i sct="" d  q
 . . w !,"error, Snomed code not found ",zi," ",$g(@gicd9@(zi,"ICD9"))
 . s icd9=$g(@gicd9@(zi,"ICD9"))
 . i icd9="" d  q
 . . w !,"error, ICD9 code not found ",zi
 . n icd10dx
 . s icd10dx=$o(@gicd10@("ops",sct,"snomedCode",""))
 . i icd10dx="" d  q  ;
 . . w !,"error, snomed code not found in ICD10 graph ",zi," icd9= ",icd9
 . s icd10=$g(@gicd10@(icd10dx,"icd10code"))
 . i icd10="" d  q  ;
 . . w !,"error, icd10 code not found ",zi," icd9= ",icd9
 . i icd10["?" s icd10=$tr(icd10,"?","")
 . ;w !,"zi= ",zi," snomed= ",sct," icd10= ",icd10
 . s cnt=cnt+1
 w !,"count= ",cnt
 q
 ;
count ; count the unique snomed codes in the icd10 graph
 n sct,gicd9,gicd10
 s gicd9=$$ICD9ROOT
 s gicd10=$$ICD10ROOT
 s sct=""
 n cnt s cnt=0
 f  s sct=$o(@gicd10@("pos","snomedCode",sct)) q:sct=""  d  ;
 . s cnt=cnt+1
 w !,"count of snomed codes in icd10 graph= ",cnt
 q
 ;
matchbsts ; try matching snomed codes between icd9 and icd10 graphs and bsts
 n zi,gicd9,gicd10
 s gicd9=$$ICD9ROOT
 s gicd10=$$ICD10ROOT
 s zi=0
 n bsts9success,bsts10success,bstsSctSuccess,bstsSctError
 s (bsts9success,bsts10success,bstsSctSuccess,bstsSctError)=0
 n cnt s cnt=0
 f  s zi=$o(@gicd9@(zi)) q:+zi=0  d  ;
 . q:'$d(@gicd9@(zi))
 . n sct,icd9,icd10,bstsicd9,bstsicd10
 . s sct=$g(@gicd9@(zi,"SNOMED"))
 . i sct="" d  q
 . . w !,"error, Snomed code not found ",zi," ",$g(@gicd9@(zi,"ICD9"))
 . s icd9=$g(@gicd9@(zi,"ICD9"))
 . i icd9="" d  q
 . . w !,"error, ICD9 code not found ",zi
 . s bstsicd9=$$SCT2ICD9^C0TSUTL(sct)
 . i bstsicd9=-1 d  ;
 . . w !,"bsts_error, SCT code not found: ",sct
 . . s bstsSctError=bstsSctError+1
 . e  s bstsSctSuccess=bstsSctSuccess+1
 . i bstsicd9="" d  ;q
 . . w !,"bsts_error, ICD9 code not found ",zi," for SCT code ",sct
 . i bstsicd9>0 s bsts9success=bsts9success+1
 . n icd10dx
 . s icd10dx=$o(@gicd10@("ops",sct,"snomedCode",""))
 . i icd10dx="" d  q  ;
 . . w !,"error, snomed code not found in ICD10 graph ",zi," icd9= ",icd9
 . s icd10=$g(@gicd10@(icd10dx,"icd10code"))
 . i icd10="" d  ;q  ;
 . . w !,"error, icd10 code not found ",zi," icd9= ",icd9
 . i icd10["?" s icd10=$tr(icd10,"?","")
 . ;w !,"zi= ",zi," snomed= ",sct," icd10= ",icd10
 . s bstsicd10=$$SCT2ICD10^C0TSUTL(sct)
 . i bstsicd10=-1 d  ;
 . . w !,"bsts_error, SCT code not found: ",sct
 . . s bstsSctError=bstsSctError+1
 . i bstsicd10="" d  ;q
 . . w !,"bsts_error, ICD10 code not found ",zi," for SCT code ",sct," ",$$grsct2icd10(sct)
 . i $l(bstsicd10)>2 s bsts10success=bsts10success+1
 . s cnt=cnt+1
 w !,"count= ",cnt
 w !,"bsts ICD9 codes found: ",bsts9success
 w !,"bsts ICD10 codes found: ",bsts10success
 w !,"bsts SCT codes not found: ",bstsSctError
 w !,"bsts SCT codes found: ",bstsSctSuccess
 q
 ;
grsct2icd10(cde) ; extrinsic returns snomed to icd10 map from the graph
 ;
 q $$graphmap^SYNGRAPH("sct2icd",cde,"icd10code")
 ;
grsct2icd9(cde) ; extrinsic returns snomed to icd9 map from the graph
 ;
 q $$graphmap^SYNGRAPH("icd9tosnomed",cde,"ICD9")
 ;
