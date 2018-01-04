ETSRXN1 ;O-OIFO/FM23 - RxNorm APIs 2 ;03/06/2017
 ;;1.0;Enterprise Terminology Service;**1**;Mar 20, 2017;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
VUI2RXN(ETSVUID,ETSTTY,ETSSUB) ;Extract RxNorm Concept Numbers and other data for a given VA Unique ID
 ; Input  -- ETSVUID   VA Unique ID (VUID) (Required)
 ;           ETSTTY    Term Type Lookup (Optional)
 ;           ETSSUB    (Optional) Subscript for ^TMP array storing the results (default = ETSRXN)
 ; Output -- 
 ;   $$VUI2RXN - # records found or -1^<error message>
 ; 
 ;   ^TMP(ETSSUB,$J,RXCUI Count,     Results in the following subscripts:
 ;                              0) =  IEN^RXCUI (#.01)^Source (SAB) (#.02)^Term_Type (TTY) (#.03)^Code (#.04)^Suppression_Flag (SUPPRESS) (#.05)
 ;                              1) =  Text (STR) (#1)
 ;
 N ETSCIEN,ETSCNT,ETSDATA,ETSRXCUI,ETSSTR,ETSSUPP
 ;
 ;Check for missing variable, exit if not defined
 I $G(ETSVUID)="" Q "-1^VUID missing"
 ;
 ;Initialize looping
 S ETSCIEN="",ETSCNT=0
 ; 
 ;Set the default for the subscript if not sent
 S:$G(ETSSUB)="" ETSSUB="ETSRXN"
 ;
 ;Clear previous search to prevent result contamination
 K ^TMP(ETSSUB,$J)
 ;
 ;If no Term Type specified, loop through all Term Types
 I $G(ETSTTY)="" S ETSTTY="" D  Q ETSCNT
 .F  S ETSTTY=$O(^ETSRXN(129.2,"C","VANDF",ETSVUID,ETSTTY)) Q:ETSTTY=""  D
 ..F  S ETSCIEN=$O(^ETSRXN(129.2,"C","VANDF",ETSVUID,ETSTTY,ETSCIEN)) Q:'ETSCIEN  D VUIDATA
 .Q
 ;
 ;Return data for chosen Term Type
 F  S ETSCIEN=$O(^ETSRXN(129.2,"C","VANDF",ETSVUID,ETSTTY,ETSCIEN)) Q:'ETSCIEN  D VUIDATA
 ;
 ;Return record count
 Q ETSCNT
 ;
VUIDATA ;Store data
 S ETSCNT=ETSCNT+1
 K ETSDATA D GETS^DIQ(129.2,ETSCIEN_",",".01;.05;1","","ETSDATA")
 S ETSDATA="ETSDATA(129.2,"""_ETSCIEN_","")"
 S ETSRXCUI=@ETSDATA@(.01)
 S ETSSUPP=@ETSDATA@(.05)
 S ETSSTR=@ETSDATA@(1)
 S ^TMP(ETSSUB,$J,ETSCNT,0)=ETSCIEN_U_ETSRXCUI_U_"VANDF"_U_ETSTTY_U_ETSVUID_U_ETSSUPP
 S ^TMP(ETSSUB,$J,ETSCNT,1)=ETSSTR
 Q
 ;
NDC2RXN(ETSNDC,ETSSUB) ;Extract RxNorm Simple Concept Numbers and other data for a given National Drug Code
 ; Input  -- ETSNDC    National Drug Code (NDC) (Required)
 ;           ETSSUB    (Optional) Subscript for ^TMP array storing the results (default = ETSNDC)
 ; Output -- 
 ;   $$NDC2RXN - # records found or -1^<error message>
 ; 
 ;   ^TMP(ETSSUB,$J,RXCUI Count,0) =  IEN^RXCUI (#.01)^Source (SAB) (#.02)^Suppression_Flag (SUPPRESS) (#.03)
 ;
 N ETS1,ETS2,ETS3
 N ETSCIEN,ETSCNT,ETSDATA,ETSERR,ETSRXCUI,ETSSRC,ETSSUPP
 ;
 ;Check for missing variable, exit if not defined
 I $G(ETSNDC)="" Q "-1^NDC missing"
 ;
 ;Validate NDC input
 S ETSERR=""
 I ETSNDC["-" D  I +ETSERR Q ETSERR
 .I ETSNDC'?.6N1"-".4N1"-".2N S ETSERR="-1^Invalid NDC format" Q
 .S ETS1=$P(ETSNDC,"-"),ETS2=$P(ETSNDC,"-",2),ETS3=$P(ETSNDC,"-",3)
 .S ETSNDC=$E("00000",1,5-$L(ETS1))_ETS1_$E("0000",1,4-$L(ETS2))_ETS2_$E("00",1,2-$L(ETS3))_ETS3
 .Q
 ;
 I ETSNDC'?11.12N Q "-1^Invalid NDC format"
 ;
 ;Initialize looping
 S ETSCIEN="",ETSCNT=0
 ; 
 ;Set the default for the subscript if not sent
 S:$G(ETSSUB)="" ETSSUB="ETSNDC"
 ;
 ;Clear previous search to prevent result contamination
 K ^TMP(ETSSUB,$J)
 ;
 ;Store data for chosen NDC Code
NDCDATA F  S ETSCIEN=$O(^ETSRXN(129.21,"C","NDC",ETSNDC,ETSCIEN)) Q:'ETSCIEN  D
 .S ETSCNT=ETSCNT+1
 .K ETSDATA D GETS^DIQ(129.21,ETSCIEN_",",".01;.02;.03","","ETSDATA")
 .S ETSDATA="ETSDATA(129.21,"""_ETSCIEN_","")"
 .S ETSRXCUI=@ETSDATA@(.01)
 .S ETSSRC=@ETSDATA@(.02)
 .S ETSSUPP=@ETSDATA@(.03)
 .S ^TMP(ETSSUB,$J,ETSCNT,0)=ETSCIEN_U_ETSRXCUI_U_ETSSRC_U_ETSSUPP
 .Q
 ;
 ;Return record count
 Q ETSCNT
 ;
RXN2OUT(ETSRXCUI,ETSSUB) ;Extract VUID and NDC for a given RxNorm  Concept Unique ID (RXCUI)
 ; Input  -- ETSRXCUI  RxNorm  Concept Unique ID (RXCUI) (Required)
 ;           ETSSUB    (Optional) Subscript for ^TMP array storing the results (default = ETSOUT)
 ; Output -- 
 ;   $$RXN2OUT - # VUIDs^# NDCs found or -1^<error message>
 ; 
 ;   ^TMP(ETSSUB,$J,RXCUI,     Results in the following subscripts:
 ;                        "VUID") =  Count
 ;                        "VUID",VUID Count,0) =  IEN^RXCUI (129.2,#.01)^Source (SAB) (#.02)^Term_Type (TTY) (#.03)^Code (#.04)^Suppression_Flag (SUPPRESS) (#.05)
 ;                                          1) =  Text (STR) (#1)
 ;                        "NDC") =  Count
 ;                        "NDC",NDC Count,0) =  IEN^RXCUI (129.21,#.01)^Code (#.05)^Source (SAB) (#.02)^Suppression_Flag (SUPPRESS) (#.03)
 ;                        "NDC",NDC Count,1) =  Attribute Name (ATN) (129.21,#1)
 ;                        "NDC",NDC Count,2) =  Attribute Value (ATV) (129.21,#2)
 ;
 N ETSATN,ETSCIEN,ETSCODE,ETSDATA,ETSNCNT,ETSNDC,ETSSRC,ETSSTR,ETSSUPP,ETSTTY,ETSVCNT,ETSVUID
 ;
 ;Check for missing variable, exit if not defined
 I $G(ETSRXCUI)="" Q "-1^RXCUI missing"
 ; 
 ;Set the default for the subscript if not sent
 S:$G(ETSSUB)="" ETSSUB="ETSOUT"
 ;
 ;Clear previous search to prevent result contamination
 K ^TMP(ETSSUB,$J)
 ;
 ;Store VUID data
 ;Initialize looping
 S ETSCIEN="",ETSVCNT=0
 ;
 F  S ETSCIEN=$O(^ETSRXN(129.2,"B",ETSRXCUI,ETSCIEN)) Q:'ETSCIEN  I $$GET1^DIQ(129.2,ETSCIEN_",",.02)="VANDF" D
 .S ETSVCNT=ETSVCNT+1
 .K ETSDATA D GETS^DIQ(129.2,ETSCIEN_",",".04;.03;.05;1","","ETSDATA")
 .S ETSDATA="ETSDATA(129.2,"""_ETSCIEN_","")"
 .S ETSTTY=@ETSDATA@(.03)
 .S ETSVUID=@ETSDATA@(.04)
 .S ETSSUPP=@ETSDATA@(.05)
 .S ETSSTR=@ETSDATA@(1)
 .S ^TMP(ETSSUB,$J,ETSRXCUI,"VUID",ETSVCNT,0)=ETSCIEN_U_ETSRXCUI_U_"VANDF"_U_ETSTTY_U_ETSVUID_U_ETSSUPP
 .S ^TMP(ETSSUB,$J,ETSRXCUI,"VUID",ETSVCNT,1)=ETSSTR
 .Q
 ;
 S ^TMP(ETSSUB,$J,ETSRXCUI,"VUID")=ETSVCNT
 ;
 ;Store NDC data
 ;Initialize looping
 S ETSCIEN="",ETSNCNT=0
 ;
 F  S ETSCIEN=$O(^ETSRXN(129.21,"B",ETSRXCUI,ETSCIEN)) Q:'ETSCIEN  I $$GET1^DIQ(129.21,ETSCIEN_",",1)="NDC" D
 .S ETSNCNT=ETSNCNT+1
 .K ETSDATA D GETS^DIQ(129.21,ETSCIEN_",",".05;.02;.03;1;2","","ETSDATA")
 .S ETSDATA="ETSDATA(129.21,"""_ETSCIEN_","")"
 .S ETSCODE=@ETSDATA@(.05)
 .S ETSSRC=@ETSDATA@(.02)
 .S ETSSUPP=@ETSDATA@(.03)
 .S ETSATN=@ETSDATA@(1)
 .S ETSNDC=@ETSDATA@(2)
 .S ^TMP(ETSSUB,$J,ETSRXCUI,"NDC",ETSNCNT,0)=ETSCIEN_U_ETSRXCUI_U_ETSCODE_U_ETSSRC_U_ETSSUPP
 .S ^TMP(ETSSUB,$J,ETSRXCUI,"NDC",ETSNCNT,1)=ETSATN
 .S ^TMP(ETSSUB,$J,ETSRXCUI,"NDC",ETSNCNT,2)=ETSNDC
 .Q
 ;
 S ^TMP(ETSSUB,$J,ETSRXCUI,"NDC")=ETSNCNT
 ;
 ;Return record counts
 Q ETSVCNT_U_ETSNCNT
 ;
GETDATA(ETSRXCUI,ETSSUB) ;Extract all data related to a given RxNorm  Concept Unique ID (RXCUI)
 ; Input  -- ETSRXCUI  RxNorm  Concept Unique ID (RXCUI) (Required)
 ;           ETSSUB    (Optional) Subscript for ^TMP array storing the results (default = ETSDATA)
 ; Output -- 
 ;   $$RXN2OUT - 1 if records found; 0 if no records found; or -1^<error message>
 ; 
 ;   ^TMP(ETSSUB,$J,RXCUI,     Results in the following subscripts:
 ;                        "RXCONSO") =  RXNORM CONCEPTS NAMES AND SOURCES (File #129.2) Count
 ;                        "RXCONSO",RXCONSO Count,0) =  IEN^RXCUI (#.01)^Source (SAB) (#.02)^Term_Type (TTY) (#.03)^Code (#.04)^Suppression_Flag (SUPPRESS) (#.05)^Content_View_Flag (CVF) (#.06)
 ;                                                1) =  Text (STR) (#1)
 ;
 ;                        "RXNSAT") =  RXNORM SIMPLE CONCEPT AND ATOM ATTRIBUTES (File #129.21) Count
 ;                        "RXNSAT",RXNSAT Count,0) =  IEN^RXCUI (#.01)^Code (#.05)^Source (SAB) (#.02)^Suppression_Flag (SUPPRESS) (#.03)^Content_View_Flag (CVF) (#.04)
 ;                        "RXNSAT",RXNSAT Count,1) =  Attribute Name (ATN) (#1)
 ;                        "RXNSAT",RXNSAT Count,2) =  Attribute Value (ATV) (#2)
 ;
 ;                        "RXNREL") =  RXNORM RELATED CONCEPTS (File #129.22) Count
 ;                        "RXNREL",RXNREL Count,0) =  IEN^RXCUI (RXCUI1) (#.01)^Relationship (REL) (#.02)^RXCUI2 (#.03)^Secondary Relationship (RELA) (#.04)^Source (SAB) (#.05)^Suppression_Flag (SUPPRESS) (#.06)^Content_View_Flag (CVF) (#.07)
 ;
 ;                        "RXNSTY") =  RXNORM SEMANTIC TYPES (File #129.23) Count
 ;                        "RXNSTY",RXNSTY Count,0) =  IEN^RXCUI (#.01)^Semantic_Type (STY) (#.02)^Content_View_Flag (CVF) (#.03)
 ;
 N ETSATN,ETSATV,ETSCIEN,ETSCNT,ETSCODE,ETSCVF,ETSDATA,ETSI,ETSREL,ETSRELA,ETSRXN2,ETSSRC,ETSSTR,ETSSTY,ETSSUPP,ETSTTY
 ;
 ;Check for missing variable, exit if not defined
 I $G(ETSRXCUI)="" Q "-1^RXCUI missing"
 ; 
 ;Set the default for the subscript if not sent
 S:$G(ETSSUB)="" ETSSUB="ETSDATA"
 ;
 ;Clear previous search to prevent result contamination
 K ^TMP(ETSSUB,$J)
 ;
 ;Store RXCONSO data
 ;Initialize looping
 S ETSCIEN="",ETSCNT=0
 ;
 F  S ETSCIEN=$O(^ETSRXN(129.2,"B",ETSRXCUI,ETSCIEN)) Q:'ETSCIEN  D
 .S ETSCNT=ETSCNT+1
 .K ETSDATA D GETS^DIQ(129.2,ETSCIEN_",","**","","ETSDATA")
 .S ETSDATA="ETSDATA(129.2,"""_ETSCIEN_","")"
 .S ETSSRC=@ETSDATA@(.02)
 .S ETSTTY=@ETSDATA@(.03)
 .S ETSCODE=@ETSDATA@(.04)
 .S ETSSUPP=@ETSDATA@(.05)
 .S ETSCVF=@ETSDATA@(.06)
 .S ETSSTR=@ETSDATA@(1)
 .S ^TMP(ETSSUB,$J,ETSRXCUI,"RXCONSO",ETSCNT,0)=ETSCIEN_U_ETSRXCUI_U_ETSSRC_U_ETSTTY_U_ETSCODE_U_ETSSUPP_U_ETSCVF
 .S ^TMP(ETSSUB,$J,ETSRXCUI,"RXCONSO",ETSCNT,1)=ETSSTR
 .Q
 ;
 S ^TMP(ETSSUB,$J,ETSRXCUI,"RXCONSO")=ETSCNT
 ;
 ;Store RXNSAT data
 ;Initialize looping
 S ETSCIEN="",ETSCNT=0
 ;
 F  S ETSCIEN=$O(^ETSRXN(129.21,"B",ETSRXCUI,ETSCIEN)) Q:'ETSCIEN  D
 .S ETSCNT=ETSCNT+1
 .K ETSDATA D GETS^DIQ(129.21,ETSCIEN_",","**","","ETSDATA")
 .S ETSDATA="ETSDATA(129.21,"""_ETSCIEN_","")"
 .S ETSCODE=@ETSDATA@(.05)
 .S ETSSRC=@ETSDATA@(.02)
 .S ETSSUPP=@ETSDATA@(.03)
 .S ETSCVF=@ETSDATA@(.04)
 .S ETSATN=@ETSDATA@(1)
 .S ETSATV=@ETSDATA@(2)
 .S ^TMP(ETSSUB,$J,ETSRXCUI,"RXNSAT",ETSCNT,0)=ETSCIEN_U_ETSRXCUI_U_ETSCODE_U_ETSSRC_U_ETSSUPP_U_ETSCVF
 .S ^TMP(ETSSUB,$J,ETSRXCUI,"RXNSAT",ETSCNT,1)=ETSATN
 .S ^TMP(ETSSUB,$J,ETSRXCUI,"RXNSAT",ETSCNT,2)=ETSATV
 .Q
 ;
 S ^TMP(ETSSUB,$J,ETSRXCUI,"RXNSAT")=ETSCNT
 ;
 ;Store RXNREL data
 ;Initialize looping
 S ETSCIEN="",ETSCNT=0
 ;
 F  S ETSCIEN=$O(^ETSRXN(129.22,"B",ETSRXCUI,ETSCIEN)) Q:'ETSCIEN  D
 .S ETSCNT=ETSCNT+1
 .K ETSDATA D GETS^DIQ(129.22,ETSCIEN_",","**","","ETSDATA")
 .S ETSDATA="ETSDATA(129.22,"""_ETSCIEN_","")"
 .S ETSREL=@ETSDATA@(.02)
 .S ETSRXN2=@ETSDATA@(.03)
 .S ETSRELA=@ETSDATA@(.04)
 .S ETSSRC=@ETSDATA@(.05)
 .S ETSSUPP=@ETSDATA@(.06)
 .S ETSCVF=@ETSDATA@(.07)
 .S ^TMP(ETSSUB,$J,ETSRXCUI,"RXNREL",ETSCNT,0)=ETSCIEN_U_ETSRXCUI_U_ETSREL_U_ETSRXN2_U_ETSRELA_U_ETSSRC_U_ETSSUPP_U_ETSCVF
 .Q
 ;
 S ^TMP(ETSSUB,$J,ETSRXCUI,"RXNREL")=ETSCNT
 ;
 ;Store RXNSTY data
 ;Initialize looping
 S ETSCIEN="",ETSCNT=0
 ;
 F  S ETSCIEN=$O(^ETSRXN(129.23,"B",ETSRXCUI,ETSCIEN)) Q:'ETSCIEN  D
 .S ETSCNT=ETSCNT+1
 .K ETSDATA D GETS^DIQ(129.23,ETSCIEN_",","**","","ETSDATA")
 .S ETSDATA="ETSDATA(129.23,"""_ETSCIEN_","")"
 .S ETSSTY=@ETSDATA@(.02)
 .S ETSCVF=@ETSDATA@(.03)
 .S ^TMP(ETSSUB,$J,ETSRXCUI,"RXNSTY",ETSCNT,0)=ETSCIEN_U_ETSRXCUI_U_ETSSTY_U_ETSCVF
 .Q
 ;
 S ^TMP(ETSSUB,$J,ETSRXCUI,"RXNSTY")=ETSCNT
 ;
 ;Return results
 S ETSCNT=0 F ETSI="RXCONSO","RXNSAT","RXNREL","RXNSTY" S ETSCNT=ETSCNT+^TMP(ETSSUB,$J,ETSRXCUI,ETSI)
 I ETSCNT Q 1
 Q 0
