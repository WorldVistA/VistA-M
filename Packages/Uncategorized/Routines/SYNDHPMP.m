SYNDHPMP ; AFHIL/FJF - HealthConcourse - terminology mapping ;03/26/2019
 ;;0.1;VISTA SYNTHETIC DATA LOADER;;Aug 17, 2018;Build 10
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
MAP(MAP,CODE,DIR,IOE) ; Return a mapped code for a given code
 ; 
 ;--------------------------------------------------------------------
 ;
 ; Input:
 ;   MAP - mapping to be used
 ;       currently the maps implemented are "sct2icd" (5/18/2018)
 ;                                          "sct2cpt" (9/07/2018)
 ;                                          "sct2icdnine" (8/28/2018)
 ;                                          "mh2loinc" (9/07/2018)
 ;                                          "mh2sct" (9/07/2018)
 ;                                          "sct2hf" (9/07/2018)
 ;                                          "flag2sct" (02/01/2019)
 ;                                          "sct2vit" (02/01/2019)
 ;                                          "ctpos2sct (02/01/2019)
 ;                                          "rxn2ndf" (02/01/2019)
 ;                                          "sct2os5" (02/02/2019)
 ;
 ;   CODE - map source code
 ;   DIR  - direction of mapping
 ;       D for direct (default)
 ;       I for inverse
 ;   IOE  - use internal or exernal mappings
 ;       I for internal SYN VistA(default)
 ;       H for external Health Concourse
 ; 
 ; Output:
 ;   1^map target code
 ;   or -1^exception
 ;
 ; -------------------------------------------------------------------
 ; 
MSTART ;
 ;
 N MAPA,MAPJ,MAPJ8,NODE,STA,RET,DOI,TAR,URL,C,P,SUB
 S U="^",C=":",P="|"
 S IOE=$S($G(IOE)="":"I",1:IOE)
 I "|I|H|"'[(P_IOE_P) Q -1_U_"invalid IOE parameter"
 S STA=1
 I IOE'="I" D  Q STA_U_TAR
 .; call the terminology server
 .S RET=$$GETURL^XTHC10($$TRMURL(IOE),,"MAPJ")
 .; check status of web call
 .I +RET'=200 S STA=-1,TAR=+RET_C_$P(RET,U,2) Q
 .; check for result returned from exernal server
 .; change numbers in valueString attribute to string
 .D NTS("MAPJ")
 .; decode the JSON into M array 
 .D DECODE^XLFJSON("MAPJ","MAPA")
 .I '$D(MAPA) S STA=-1,TAR="code not mapped" Q
 .; convert the number_" " back to a number
 .D RMS("MAPA")
 .S NODE="MAPA",TAR=""
 .F  S NODE=$Q(@NODE) Q:NODE=""  Q:TAR'=""  D
 ..Q:$QS(NODE,5)'="name"
 ..Q:@NODE'="code"
 ..S TAR=MAPA($QS(NODE,1),$QS(NODE,2),$QS(NODE,3),$QS(NODE,4),"valueString")
 .I TAR="" S STA=-1,TAR="code not mapped" Q
 ;I IOE'="I" Q 1_U_TAR
 ;
 ; if we are here then the caller passed I or null in the IOE parameter
 ;
 N DOI,FN,TAR
 S FN="2002.030"
 S DIR=$G(DIR,"D")
 S DOI=$S(DIR="I":"inverse",1:"direct")
 I '$D(^SYN(FN,MAP)) Q "-1^code not mapped"
 I '$D(^SYN(FN,MAP,DOI,CODE)) Q "-1^code not mapped"
 S TAR=$O(^SYN(FN,MAP,DOI,CODE,""))
 I MAP="sct2icd" S TAR=$TR(TAR,"?","A")
 ;W !,"Internal"
 Q 1_U_TAR
 ;
 ;
TRMURL(EXSRV) ; create url of mapping service
 ;
 ; once we have url - infuse it with mapping identifier and source code
 ; currently Health Concourse is only supported external server
 ; for additional servers add appropriate url builder below
 ; 
 ; Health Concourse
 I EXSRV="H" D
 .S URL="https://terminology-service.dev.openplatform.healthcare/vista2/"_MAP_"?searchString="_CODE
 ;
 ; Wolters Kluwer
 ; I EXSRV="W" D
 ; .S URL="https://Wolters Kluwer terminology-service_url with MAP and CODE"
 ;
 Q URL
 ;
MAPR(SURFORM,SFTYPE,MAOR) ; map reactions (SNOMED CT)
 ; map an allergic reaction surface form to an SCT code
 ; Input:
 ;   SURFORM - surface form
 ;   TYPE    - type of surface form
 ;             I - IEN
 ;             T - term
 ;   MAOR    - allergen or reaction
 ;             A - Allergen
 ;             R - Reaction
 ;
 I SURFORM="" Q "-1^Surface form cannot be null"
 I SFTYPE'="I",SFTYPE'="T" Q "-1^Type unrecognised - should be I or T"
 I MAOR'="A",MAOR'="R" Q "-1^Allergy/Reaction indicator unrecognised - should be A or R"
 N RSUB,INDX
 S RSUB=$S(MAOR="A":"ALLERGENS",1:"REACTIONS")
 S INDX=$S(SFTYPE="I":"ICT",1:"TCI")
 I '$D(^SYN("2002.010",RSUB,INDX,SURFORM)) Q "unmapped"
 QUIT $O(^SYN("2002.010",RSUB,INDX,SURFORM,""))
 ;
 ;
TEST ; tests
 ;
T1(code) ; SNOMED CT to ICD
 ; example SNOMED CT codes 37739004,37657006
 n csys,intext,dirinv
 f csys="sct2icd","sct2icdnine" d
 .f intext="I","H" d
 ..f dirinv="D" d
 ...w !,csys," code ",code," ",$s(intext="I":"Internal",1:"External")
 ...w !,$$MAP(csys,code,dirinv,intext)
 Q
 ;
T2(code) ; mental health to SNOMED CT
 ; example mental health codes PHQ-2,PHQ9,2
 n csys,intext,dirinv
 f csys="mh2sct" d
 .f intext="I","H" d
 ..f dirinv="D" d
 ...w !,csys," code ",code," ",$s(intext="I":"Internal",1:"External")
 ...w !,$$MAP(csys,code,dirinv,intext)
 Q
T3 ; new server (vista2) tests
 ;
T3V ;
 K
 ; sct2icd vista
 S URLSV="https://terminology-service.dev.openplatform.healthcare/vista/sct2icd?searchString=37739004"
 S RET=$$GETURL^XTHC10(URLSV,,"MAPSV")
 D DECODE^XLFJSON("MAPSV","MAPSVO")
 ; mh2sct vista
 S URLMV="https://terminology-service.dev.openplatform.healthcare/vista/mh2sct?searchString=PHQ-2"
 S RET=$$GETURL^XTHC10(URLMV,,"MAPMV") 
 D DECODE^XLFJSON("MAPMV","MAPMVO")
 ;
 W !,URLSV,!!
 ZW MAPSVO
 w !!,URLMV,!!
 ZW MAPMVO
 ;
 Q
 ;
T4V ;
 K
 ; sct2icd vista2
 S URLSV="https://terminology-service.dev.openplatform.healthcare/vista2/sct2icd?searchString=37739004"
 S RET=$$GETURL^XTHC10(URLSV,,"MAPSV")
 ; now scan json in MPASV to find string that look like numbers
 ; and convert them to strings by concateneating space
 D NTS("MAPSV")
 ; 
 D DECODE^XLFJSON("MAPSV","MAPSVO")
 ; now that json decodon complete remove space
 ;D RMS("MAPSVO")
 ; mh2sct vista
 S URLMV="https://terminology-service.dev.openplatform.healthcare/vista2/mh2sct?searchString=PHQ-2"
 S RET=$$GETURL^XTHC10(URLMV,,"MAPMV")
 ; now scan json in MPAMV to find string that look like numbers
 ; and convert them to strings by concatenating space
 D NTS("MAPMV")
 ;
 D DECODE^XLFJSON("MAPMV","MAPMVO")
 ;
 W !,URLSV,!!
 ZW MAPSVO
 w !!,URLMV,!!
 ZW MAPMVO
 ;
 Q
NTS(JSONA) ; change numbers to string to accommodate XTHC10 quirk
 ;
 N N,VALUE
 S N=JSONA
 F  S N=$Q(@N) Q:N=""  D
 .Q:@N'["valueString"
 .S VALUE=$P($P(@N,":",2),"""",2)
 .Q:VALUE'?1N.N
 .S VALUE=VALUE_" "
 .S $P(@N,"""",4)=VALUE
 Q
RMS(JSONA) ; convert numeric string to a number
 ;
 N N,VALUE
 S N=JSONA
 F  S N=$Q(@N) Q:N=""  D
 .Q:N'["valueString"
 .S VALUE=@N
 .Q:VALUE'?1N.N1" "
 .S VALUE=+VALUE
 .S @N=VALUE
 Q
 
