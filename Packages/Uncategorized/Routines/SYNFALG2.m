SYNFALG2 ;ven/gpl - fhir loader utilities ; 2/20/18 4:11am
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ; (c) Sam Habiel 2018
 ;
 QUIT
 ;
MEDALGY(dfn,root,json,zi,eval,jlog,args) ; allergy is rxnorm
 ;
 n SYNDFN,SYNRXN,SYNDF,SYNPA,SYNDUZ,SYNSS,SYNDATE,SYNCOMM
 ;
 S SYNDFN=dfn
 d log(jlog,"Patient DFN: "_SYNDFN)
 s eval("allergy",zi,"vars","dfn")=SYNDFN
 ;
 s SYNRXN=$get(json("entry",zi,"resource","code","coding",1,"code"))
 d log(jlog,"Allergin is RxNorm: "_SYNRXN)
 set eval("allergy",zi,"vars","code")=SYNRXN
 ;
 S SYNDUZ=$$USERDUZ
 d log(jlog,"Provider DUZ: "_SYNDUZ)
 s eval("allergy",zi,"vars","duz")=SYNDUZ
 ;
 new onsetdate set onsetdate=$get(json("entry",zi,"resource","assertedDate"))
 do log(jlog,"onsetDateTime is: "_onsetdate)
 set eval("allergy",zi,"vars","onsetDateTime")=onsetdate
 new fmOnsetDateTime s fmOnsetDateTime=$$fhirTfm^SYNFUTL(onsetdate)
 i $l(fmOnsetDateTime)=14 s fmOnsetDateTime=$e(fmOnsetDateTime,1,12)
 d log(jlog,"fileman onsetDateTime is: "_fmOnsetDateTime)
 set eval("allergy",zi,"vars","fmOnsetDateTime")=fmOnsetDateTime ;
 S SYNDATE=fmOnsetDateTime
 ;
 s eval("allergy",zi,"status","loadstatus")="readyToLoad"
 ;
 if $g(args("load"))=1 d  ; only load if told to
 . n ien s ien=$$dfn2ien^SYNFUTL(dfn) ;
 . if $g(ien)'="" if $$loadStatus^SYNFALG("allergy",zi,ien)=1 do  quit  ;
 . . d log(jlog,"Allergy already loaded, skipping")
 . d log(jlog,"Calling ADDMEDADR^SYNFALG2 to add allergy")
 . n ok
 . s ok=$$ADDMEDADR(SYNDFN,SYNRXN,,,SYNDUZ,,SYNDATE) ;
 . m eval("allergy",zi,"status")=ok
 . d log(jlog,"Return from data loader was: "_ok)
 . if +$g(ok)=1 do  ;
 . . s eval("status","loaded")=$g(eval("status","loaded"))+1
 . . s eval("allergy",zi,"status","loadstatus")="loaded"
 . else  d  ;
 . . s eval("status","errors")=$g(eval("status","errors"))+1
 . . s eval("allergy",zi,"status","loadstatus")="notLoaded"
 . . s eval("allergy",zi,"status","loadMessage")=ok
 . n root s root=$$setroot^SYNWD("fhir-intake")
 . i $g(ien)'="" d  ;
 . . k @root@(ien,"load","allergy",zi)
 . . m @root@(ien,"load","allergy",zi)=eval("allergy",zi)
 ;
 q
 ;
USERDUZ() ; extrinsic returning the DUZ of the user
 n npi,duz
 s npi=$$MAP^SYNQLDM("OP","provider") ; map should return the NPI number
 s duz=$O(^VA(200,"ANPI",npi,""))
 q duz
 ;
log(ary,txt) ; adds a text line to @ary@("log")
 s @ary@("log",$o(@ary@("log",""),-1)+1)=$g(txt)
 q
 ;
ADDMEDADR(SYNDFN,SYNRXN,SYNDF,SYNPA,SYNDUZ,SYNSS,SYNDATE,SYNCOMM) ; [Public] Add an allergy/adrxn using a Medications RxNorm Code
 ; Uses IA#4682 to record an allergy in the patient's chart
 ;
 ; Input:
 ; - SYNDFN   (r) = DFN
 ; - SYNRXN   (r) = RxNorm Ingredient or Clinical Drug code
 ; - SYNDF    (o) = "D"rug or "F"ood
 ; - SYNPA    (o) = Nature of Reaction: "P"harmacologic or "A"llergic
 ; - SYNDUZ   (o) = Recorder of reaction
 ; - SYNSS    (o) = ";" delimited list of signs and symptoms
 ; - SYNDATE  (o) = Date of recording of signs and symptoms
 ; - .SYNCOMM (o) = Comments in 1,2,3 etc passed by reference
 ;
 ; Output:
 ; - Can be called as a routine; but you won't get any error information
 ; - with $$, you will get:
 ; - 0^note to sign (if any) or -1^error message
 ;
 ; Translate RXN to VUID
 ; get VUIDs
 ; Output like this: 50.6~4030995
 ; or -1^message
 n fileVUIDs s fileVUIDs=$$ETSRXN2VUID^SYNFMED(SYNRXN)
 i fileVUIDs<0 quit fileVUIDs
 ;
 ; Get the first one
 n firstFileVUID s firstFileVUID=$P(fileVUIDs,U)
 ;
 ; Error if not found
 if firstFileVUID="" quit:$quit "-2^no-suitable-vuid-term-was-CD-or-IN" quit
 ;
 kill ^TMP("SYN",$J) ; we put all the reactant info here
 ;
 ; find variable pointer
 new synvuid ; For Searching Compound Index
 set synvuid(1)=$p(firstFileVUID,"~",2)
 set synvuid(2)=1
 new file set file=$p(firstFileVUID,"~",1)
 if 'file set $ec=",u-no-supposed-to-happen,"
 new ien set ien=$$FIND1^DIC(file,"","XQ",.synvuid,"AMASTERVUID")
 if 'ien quit:$quit "-3^VUID-not-found. Is your NDF up to date?" quit
 ;
 new drugName set drugName=$$GET1^DIQ(file,ien,.01)
 ;
 ; load the data into the global for the API
 set ^TMP("SYN",$J,"GMRAGNT")=drugName_U_ien_";"_$piece($$ROOT^DILFD(file),U,2) ; variable pointer syntax
 set ^TMP("SYN",$J,"GMRATYPE")=$G(SYNDF,"D") ; Allergen type: Drug OR Food (D or F)
 set ^TMP("SYN",$J,"GMRANATR")=$G(SYNPA,"U") ; nature of reaction: Allergic or Pharmacologic (default unknown)
 set ^TMP("SYN",$J,"GMRAORIG")=$G(SYNDUZ,DUZ) ; Originator
 set ^TMP("SYN",$J,"GMRAORDT")=$G(SYNDATE,DT) ; Date of recording of reaction (not date of reaction)
 new ssErr set ssErr=0
 if $get(SYNSS)]"" do
 . set ^TMP("SYN",$J,"GMRASYMP",0)=$L(SYNSS,";") ; Signs and symptoms need to be entered by IENs
 . new i for i=1:1:$l(SYNSS,";") do  q:ssErr  ; put signs and symptoms in 1,2,3 etc
 .. new ssIEN set ssIEN=$$FIND1^DIC(120.83,,"QX",$piece(SYNSS,";",i),"B")
 .. if 'ssIEN set ssErr=1
 .. set ^TMP("SYN",$J,"GMRASYMP",i)=ssIEN_U_$piece(SYNSS,";",i)
 i ssErr quit:$quit "-4^one or more signs/symptoms cannot be found" quit
 set ^TMP("SYN",$J,"GMRACHT",0)=1 ; marked in chart
 set ^TMP("SYN",$J,"GMRACHT",1)=$$NOW^XLFDT() ; marked now
 set ^TMP("SYN",$J,"GMRAOBHX")="h" ; historical. No sense in doing "observed"
 if $data(SYNCOMM) merge ^TMP("SYN",$J,"GMRACMTS")=SYNCOMM
 ;
 ; call the API
 N ORY
 D UPDATE^GMRAGUI1(0,SYNDFN,$NA(^TMP("SYN",$J)))
 ;
 ; API return -1^message or 0^note to sign
 if $piece(ORY,U)=-1 quit:$quit -5_U_$piece(ORY,U,2) quit
 quit:$quit 0_U_$piece(ORY,U,2)
 quit
 ;
TEST D EN^%ut($T(+0),3) quit
STARTUP ; M-UNIT STARTUP
 ; Delete all traces of patients allergies from DFN 1
 ; ZEXCEPT: DFN
 S DFN=1
 N DIK,DA
 S DIK=$$ROOT^DILFD(120.86),DA=DFN D ^DIK
 S DIK="^GMR(120.8,"
 S DA=0
 F  S DA=$O(^GMR(120.8,"B",1,DA)) Q:'DA  D ^DIK
 QUIT
 ;
TADDMEDADR1 ; @TEST Simple allergen NOS - Contraceptive CD.
 ; ZEXCEPT: DFN
 N % S %=$$ADDMEDADR(DFN,831533)
 D CHKTF^%ut(+%=0)
 quit
 ;
TADDMEDADR2 ; @TEST Allergen as "food" (really penicillin IN)
 ; ZEXCEPT: DFN
 N % S %=$$ADDMEDADR(DFN,70618,"F")
 D CHKTF^%ut(+%=0)
 quit
 ;
TADDMEDADR3 ; @TEST Pharmacological or Allergic (Simvastatin CD)
 ; ZEXCEPT: DFN
 N % S %=$$ADDMEDADR(DFN,198211,"D","P")
 D CHKTF^%ut(+%=0)
 quit
 ;
TADDMEDADR4 ; @TEST Different Originator (Tamoxifen CD)
 ; ZEXCEPT: DFN
 N ORIG S ORIG=$O(^XUSEC("PROVIDER",""))
 N % S %=$$ADDMEDADR(DFN,313195,"D","P",ORIG)
 D CHKTF^%ut(+%=0)
 quit
 ;
TADDMEDADR5 ; @TEST Different Origination date (Aliskiren/Amlodipine IN)
 ; ZEXCEPT: DFN
 N ORIG S ORIG=$O(^XUSEC("PROVIDER",""))
 N % S %=$$ADDMEDADR(DFN,1009219,"D","P",ORIG,,$$FMADD^XLFDT(DT,-120))
 D CHKTF^%ut(+%=0)
 quit
 ;
TADDMEDADR6 ; @TEST Signs and symptoms singular (Cephalexin CD)
 ; ZEXCEPT: DFN
 N ORIG S ORIG=$O(^XUSEC("PROVIDER",""))
 N % S %=$$ADDMEDADR(DFN,309110,"D","A",ORIG,"HIVES",$$FMADD^XLFDT(DT,-120))
 D CHKTF^%ut(+%=0)
 quit
 ;
TADDMEDADR7 ; @TEST Signs and symptoms plural (Cephalexin IN)
 ; ZEXCEPT: DFN
 N ORIG S ORIG=$O(^XUSEC("PROVIDER",""))
 N % S %=$$ADDMEDADR(DFN,2231,"D","A",ORIG,"HIVES;RHINITIS;WHEEZING",$$FMADD^XLFDT(DT,-120))
 D CHKTF^%ut(+%=0)
 quit
 ;
TADDMEDADR8 ; @TEST Comments (Levothyroxine IN)
 ; ZEXCEPT: DFN
 N ORIG S ORIG=$O(^XUSEC("PROVIDER",""))
 N COMM S COMM(1)="This seems to only happen with specific forumlations of Synthroid"
 S COMM(2)="I think it's just the 125mcg (pink one)"
 N % S %=$$ADDMEDADR(DFN,10582,"D","A",ORIG,"HIVES;RHINITIS;WHEEZING",$$FMADD^XLFDT(DT,-120),.COMM)
 D CHKTF^%ut(+%=0)
 quit
 ;
TADDMEDERR1 ; @TEST Test error messages: -1 Bad Rxn
 ; ZEXCEPT: DFN
 N % S %=$$ADDMEDADR(DFN,83153328978194871234)
 D CHKTF^%ut(+%=-1)
 quit
TADDMEDERR2 ; @TEST Test error messages: -2 No VUID for Rxn - too hard
 ; ZEXCEPT: DFN
 quit
 ;
TADDMEDERR3 ; @TEST Test error messages: -3 NDF product cannot be found - too hard
 ; ZEXCEPT: DFN
 quit
 ;
TADDMEDERR4 ; @TEST Test error messages: -4 Bad S/S
 ; ZEXCEPT: DFN
 N ORIG S ORIG=$O(^XUSEC("PROVIDER",""))
 N % S %=$$ADDMEDADR(DFN,309110,"D","A",ORIG,"OIUSLDFKJLSKDJF",$$FMADD^XLFDT(DT,-120))
 D CHKTF^%ut(+%=-4)
 quit
 ;
TADDMEDERR5 ; @TEST Test error message: -5 API error
 ; ZEXCEPT: DFN
 N ORIG S ORIG=$O(^XUSEC("PROVIDER",""))
 N % S %=$$ADDMEDADR(DFN,2231,"D","A",ORIG,"HIVES;RHINITIS;WHEEZING",$$FMADD^XLFDT(DT,-120))
 D CHKTF^%ut(+%=-5)
 quit
 ;
SHUTDOWN ; M-UNIT SHUTDOWN
 ; ZEXCEPT: DFN
 K DFN
 QUIT
 ;
