SYNDHPGEN ; HC/art - code generator ;08/23/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;
 ;
 quit
 ;
GEN(RTN,ID,FILES) ; generate GETer code for a file
 ;inputs: ID - file name or abbreviation
 ;        FILES  - array of file numbers, by reference
 ;             FILES(1)=file number of file to extract
 ;             FILES(n)=file number^multiple level
 ;output: RTN - returned array of generated code, by reference
 ;        /tmp/genCode.txt - generated code (also written to the terminal screen)
 ;
 i $g(ID)="" w "0^ID is not defined",! quit
 i $g(FILES(1))="" w "0^FILES is not defined",! quit
 ;
 n IDtitle S IDtitle=$$TITLE^XLFSTR(ID)
 n cnt s cnt=0
 n fileCnt s fileCnt=0
 ; header
 s RTN(1)="GET1"_ID_"("_ID_","_ID_"IEN,RETJSON,"_ID_"J) ;get one "_IDtitle_" record"
 s RTN(2)=" ;inputs: "_ID_"IEN - "_IDtitle_" IEN"
 s RTN(3)=" ;        RETJSON - J = Return JSON"
 s RTN(4)=" ;output: "_ID_"  - array of "_IDtitle_" data, by reference"
 s RTN(5)=" ;        "_ID_"J - JSON structure of "_IDtitle_" data, by reference"
 s RTN(6)=" ;"
 ; initialization
 s RTN(7)=" I $G(DEBUG) W !,""--------------------------- "_IDtitle_" -----------------------------"",!"
 s RTN(8)=" N S S S=""_"""
 s RTN(9)=" N SITE S SITE=$P($$SITE^VASITE,""^"",3)"
 s cnt=10
 n i s i=""
 f  s i=$o(FILES(i)) q:i=""  d
 . s RTN(cnt)=" N FNBR"_i_" S FNBR"_i_"="_+FILES(i)_" ;"_$o(^DD(+FILES(i),0,"NM",""))
 . s cnt=cnt+1
 . s fileCnt=i
 s RTN(cnt)=" N IENS1 S IENS1="_ID_"IEN_"","""
 s cnt=cnt+1
 s RTN(cnt)=" ;"
 s cnt=cnt+1
 ; read record
 s RTN(cnt)=" N "_ID_"ARR,"_ID_"ERR"
 s cnt=cnt+1
 s RTN(cnt)=" D GETS^DIQ(FNBR1,IENS1,""**"",""EI"","""_ID_"ARR"","""_ID_"ERR"")"
 s cnt=cnt+1
 s RTN(cnt)=" I $G(DEBUG) W !,$$ZW^SYNDHPUTL("""_ID_"ARR"")"
 s cnt=cnt+1
 s RTN(cnt)=" I $G(DEBUG),$D("_ID_"ERR) W !,"">>ERROR<<"" W !,$$ZW^SYNDHPUTL("""_ID_"ERR"")"
 s cnt=cnt+1
 s RTN(cnt)=" I $D("_ID_"ERR),"_ID_"ERR(""DIERR"",1)=601 D  QUIT"
 s cnt=cnt+1
 s RTN(cnt)=" . S "_ID_"("""_IDtitle_""",""ERROR"")="_ID_"IEN"
 s cnt=cnt+1
 s RTN(cnt)=" . D:$G(RETJSON)=""J"" TOJASON^SYNDHPUTL(."_ID_",."_ID_"J)"
 s cnt=cnt+1
 s RTN(cnt)=" S "_ID_"("""_IDtitle_""","""_$$LOW^XLFSTR(ID)_"Ien"")="_ID_"IEN"
 s cnt=cnt+1
 s RTN(cnt)=" S "_ID_"("""_IDtitle_""",""resourceType"")=""xxxx"""
 s cnt=cnt+1
 s RTN(cnt)=" S "_ID_"("""_IDtitle_""",""resourceId"")=$$RESID^SYNDHP69(""V"",SITE,FNBR1,"_ID_"IEN)"
 s cnt=cnt+1
 ; populate array of field values
 n fields
 d meta^SYNDHPUTL(.fields,+FILES(1))
 n fieldNameCC,fieldType
 n field s field=""
 f  s field=$o(fields(field)) quit:field=""  d
 . s fieldNameCC=$p(fields(field),U,2)
 . s fieldType=$p(fields(field),U,3)
 . i fieldType'="M" D
 . . s RTN(cnt)=" S "_ID_"("""_IDtitle_""","""_fieldNameCC_""")=$G("_ID_"ARR(FNBR1,IENS1,"_field_",""E""))"
 . . s cnt=cnt+1
 . . i fieldType="P" d  ;pointer
 . . . s RTN(cnt)=" S "_ID_"("""_IDtitle_""","""_fieldNameCC_"Id"_""")=$G("_ID_"ARR(FNBR1,IENS1,"_field_",""I""))"
 . . . s cnt=cnt+1
 . . i fieldType="V" d  ;variable pointer
 . . . s RTN(cnt)=" S "_ID_"("""_IDtitle_""","""_fieldNameCC_"Id"_""")=$G("_ID_"ARR(FNBR1,IENS1,"_field_",""I""))"
 . . . s cnt=cnt+1
 . . i fieldType="S" d  ;set of codes
 . . . s RTN(cnt)=" S "_ID_"("""_IDtitle_""","""_fieldNameCC_"Cd"_""")=$G("_ID_"ARR(FNBR1,IENS1,"_field_",""I""))"
 . . . s cnt=cnt+1
 . . i fieldType="D" d  ;date
 . . . s RTN(cnt)=" S "_ID_"("""_IDtitle_""","""_fieldNameCC_"FM"_""")=$G("_ID_"ARR(FNBR1,IENS1,"_field_",""I""))"
 . . . s cnt=cnt+1
 . . . s RTN(cnt)=" S "_ID_"("""_IDtitle_""","""_fieldNameCC_"HL7"_""")=$$FMTHL7^XLFDT($G("_ID_"ARR(FNBR1,IENS1,"_field_",""I"")))"
 . . . s cnt=cnt+1
 . . . s RTN(cnt)=" S "_ID_"("""_IDtitle_""","""_fieldNameCC_"FHIR"_""")=$$FMTFHIR^SYNDHPUTL($G("_ID_"ARR(FNBR1,IENS1,"_field_",""I"")))"
 . . . s cnt=cnt+1
 ; multiples
 n multName1
 n i s i=1
 f  s i=$o(FILES(i)) q:i=""  d
 . s RTN(cnt)=" ;"
 . s cnt=cnt+1
 . s multName1=$$camelCase^SYNDHPUTL($o(^DD(+FILES(i),0,"NM","")))
 . s RTN(cnt)=" N IENS"_i_" S IENS"_i_"="""""
 . s cnt=cnt+1
 . s RTN(cnt)=" F  S IENS"_i_"=$O("_ID_"ARR(FNBR"_i_",IENS"_i_")) QUIT:IENS"_i_"=""""  D"
 . s cnt=cnt+1
 . n fields
 . d meta^SYNDHPUTL(.fields,+FILES(i))
 . n field s field=""
 . f  s field=$o(fields(field)) quit:field=""  d
 . . s fieldNameCC=$p(fields(field),U,2)
 . . s fieldType=$p(fields(field),U,3)
 . . s RTN(cnt)=" . S "_ID_"("""_IDtitle_""","""_multName1_"s"","""_multName1_""",+IENS"_i_","""_fieldNameCC_""")=$G("_ID_"ARR(FNBR"_i_",IENS"_i_","_field_",""E""))"
 . . s cnt=cnt+1
 . . i fieldType="P" d  ;pointer
 . . . s RTN(cnt)=" . S "_ID_"("""_IDtitle_""","""_multName1_"s"","""_multName1_""",+IENS"_i_","""_fieldNameCC_"Id"_""")=$G("_ID_"ARR(FNBR"_i_",IENS"_i_","_field_",""I""))"
 . . . s cnt=cnt+1
 . . i fieldType="V" d  ;variable pointer
 . . . s RTN(cnt)=" . S "_ID_"("""_IDtitle_""","""_multName1_"s"","""_multName1_""",+IENS"_i_","""_fieldNameCC_"Id"_""")=$G("_ID_"ARR(FNBR"_i_",IENS"_i_","_field_",""I""))"
 . . . s cnt=cnt+1
 . . i fieldType="S" d  ;set of codes
 . . . s RTN(cnt)=" . S "_ID_"("""_IDtitle_""","""_multName1_"s"","""_multName1_""",+IENS"_i_","""_fieldNameCC_"Cd"_""")=$G("_ID_"ARR(FNBR"_i_",IENS"_i_","_field_",""I""))"
 . . . s cnt=cnt+1
 . . i fieldType="D" d  ;date
 . . . s RTN(cnt)=" . S "_ID_"("""_IDtitle_""","""_multName1_"s"","""_multName1_""",+IENS"_i_","""_fieldNameCC_"FM"_""")=$G("_ID_"ARR(FNBR"_i_",IENS"_i_","_field_",""I""))"
 . . . s cnt=cnt+1
 . . . s RTN(cnt)=" . S "_ID_"("""_IDtitle_""","""_multName1_"s"","""_multName1_""",+IENS"_i_","""_fieldNameCC_"HL7"_""")=$$FMTHL7^XLFDT($G("_ID_"ARR(FNBR"_i_",IENS"_i_","_field_",""I"")))"
 . . . s cnt=cnt+1
 . . . s RTN(cnt)=" . S "_ID_"("""_IDtitle_""","""_multName1_"s"","""_multName1_""",+IENS"_i_","""_fieldNameCC_"FHIR"_""")=$$FMTFHIR^SYNDHPUTL($G("_ID_"ARR(FNBR"_i_",IENS"_i_","_field_",""I"")))"
 . . . s cnt=cnt+1
 . s RTN(cnt)=" . S "_ID_"("""_IDtitle_""","""_multName1_"s"","""_multName1_""",+IENS"_i_",""resourceId"")=$$RESID^SYNDHP69(""V"",SITE,FNBR1,"_ID_"IEN,FNBR"_i_"_U_+IENS"_i_")"
 . s cnt=cnt+1
 ; tail
 s RTN(cnt)=" ;"
 s cnt=cnt+1
 s RTN(cnt)=" I $G(DEBUG) W !,$$ZW^SYNDHPUTL("""_ID_""")"
 s cnt=cnt+1
 s RTN(cnt)=" ;"
 s cnt=cnt+1
 s RTN(cnt)=" D:$G(RETJSON)=""J"" TOJASON^SYNDHPUTL(."_ID_",."_ID_"J)"
 s cnt=cnt+1
 s RTN(cnt)=" ;"
 s cnt=cnt+1
 s RTN(cnt)=" QUIT"
 s cnt=cnt+1
 s RTN(cnt)=" ;"
 ;
 ; write the code
 n os s os=+$$GETOS^SYNDHPUTL()
 n dir s dir=""
 i os=1 s dir="[temp]"
 i os=2 s dir="c:\tmp"
 i os=3 s dir="/tmp"
 i dir="" w "Could not determine OS.",! quit
 i '$$OPEN^SYNDHPUTL("outFile",dir,"genCode.txt","W") w "Could not open output file.",! quit
 n i s i=""
 f  s i=$o(RTN(i)) quit:i=""  d
 . u 0 w RTN(i),!
 . u IO w RTN(i),!
 d CLOSE^SYNDHPUTL("outFile")
 quit
 ;
 ;>>>>>>>>>>> sample code for multiples, first & second levels coded above <<<<<<<<<<<<<
 ;
 S PROBLEM("Problem","shipboardHazardDefense")=$G(PROBARR(FNBR1,IENS,1.18,"E"))
 N IENS2 S IENS2=""
 F  S IENS2=$O(PROBARR(FNBR2,IENS2)) QUIT:IENS2=""  D
 . S PROBLEM("Problem","noteFacilitys","noteFacility",+IENS2,"resourceId")="V_"_SITE_S_FNBR1_S_PROBIEN_S_FNBR2_S_+IENS2
 . S PROBLEM("Problem","noteFacilitys","noteFacility",+IENS2,"noteFacilityId")=$G(PROBARR(FNBR2,IENS2,.01,"I"))
 . S PROBLEM("Problem","noteFacilitys","noteFacility",+IENS2,"noteFacility")=$G(PROBARR(FNBR2,IENS2,.01,"E"))
 . N IENS3 S IENS3=""
 . F  S IENS3=$O(PROBARR(FNBR3,IENS3)) QUIT:IENS3=""  D
 . . S PROBLEM("Problem","noteFacilitys","noteFacility",+IENS2,"notes","note",+IENS3,"resourceId")="V_"_SITE_S_FNBR1_S_PROBIEN_S_FNBR2_S_+IENS2_S_FNBR3_S_+IENS3
 . . S PROBLEM("Problem","noteFacilitys","noteFacility",+IENS2,"notes","note",+IENS3,"noteNmbr")=$G(PROBARR(FNBR3,IENS3,.01,"E"))
 . . S PROBLEM("Problem","noteFacilitys","noteFacility",+IENS2,"notes","note",+IENS3,"noteNarrative")=$G(PROBARR(FNBR3,IENS3,.03,"E"))
 . . S PROBLEM("Problem","noteFacilitys","noteFacility",+IENS2,"notes","note",+IENS3,"statusCd")=$G(PROBARR(FNBR3,IENS3,.04,"I"))
 . . S PROBLEM("Problem","noteFacilitys","noteFacility",+IENS2,"notes","note",+IENS3,"status")=$G(PROBARR(FNBR3,IENS3,.04,"E"))
 . . S PROBLEM("Problem","noteFacilitys","noteFacility",+IENS2,"notes","note",+IENS3,"dateNoteAdded")=$G(PROBARR(FNBR3,IENS3,.05,"E"))
 . . S PROBLEM("Problem","noteFacilitys","noteFacility",+IENS2,"notes","note",+IENS3,"dateNoteAddedFM")=$G(PROBARR(FNBR3,IENS3,.05,"I"))
 . . S PROBLEM("Problem","noteFacilitys","noteFacility",+IENS2,"notes","note",+IENS3,"dateNoteAddedHL7")=$$FMTHL7^XLFDT($G(PROBARR(FNBR3,IENS3,.05,"I")))
 . . S PROBLEM("Problem","noteFacilitys","noteFacility",+IENS2,"notes","note",+IENS3,"dateNoteAddedFHIR")=$$FMTFHIR^SYNDHPUTL($G(PROBARR(FNBR3,IENS3,.05,"I")))
 . . S PROBLEM("Problem","noteFacilitys","noteFacility",+IENS2,"notes","note",+IENS3,"authorId")=$G(PROBARR(FNBR3,IENS3,.06,"I"))
 . . S PROBLEM("Problem","noteFacilitys","noteFacility",+IENS2,"notes","note",+IENS3,"author")=$G(PROBARR(FNBR3,IENS3,.06,"E"))
 ;
