SYNDHP79 ; HC/fjf/art - HealthConcourse - DHP REST handlers ;03/27/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ; 
 ;  -------------------------------------------
 ;  Save patient vitals to VistA bridge routine
 ;  -------------------------------------------
 ;
PATVITSV ; save patient vitals for one patient to VistA
 ;
 ;   DHPPATVITPST
 ;
 ;CRASH
 D PARSEVITU
 D VITUPD^SYNDHP61(.RETSTA,DHPICN,DHPSCT,DHPOBS,DHPUNT,DHPDTM)
 D ADD^RGNETWWW(RETSTA_$C(13,10))
 Q
 ;
 ;
PARSEVITU ;
 ;
 S C=",",L=":"
 S PARAMS=RGNETREQ("BODY",1)
 ;CRASH
 F I=1:1:$L(PARAMS,C) D
 .S PARAMS($P($P(PARAMS,C,I),L))=$P($P(PARAMS,C,I),L,2)
 F I="ICN","SCT","OBS","UNT","DTM" S @("DHP"_I)=PARAMS(I)
 ;S ^ZZFJF(99)=DHPICN_"^"_DHPSCT_"^"_DHPOBS_"^"_DHPUNT_"^"_DHPDTM
 Q
 ;
 ;  ---------------------------------------------
 ;
PATPRBSVX ; - old save patient problems for one patient to VistA
 ; >>>>>> THIS IS OLD CODE <<<<<<<
 ; >>>>>> SEE PATPRBSV BELOW <<<<<<<
 ;
 ;   DHPPATPRBUPD
 ;
 ;CRASH
 D PARSEPUPD
 D PROBUPD^SYNDHP61(.RETSTA,DHPICN,DHPSCT,DHPDES,DHPROV,DHPDTM,DHPRID)
 D ADD^RGNETWWW(RETSTA_$C(13,10))
 Q
 ;
 ;
PARSEPUPDX ;
 ;
 S C=",",L=":"
 D SYNDHPLOG($H)
 S PARAMS=RGNETREQ("BODY",1)
 I $L(PARAMS,L)=1 S C="&",L="="
 F I=1:1:$L(PARAMS,C) D
 .S PARAMS($P($P(PARAMS,C,I),L))=$P($P(PARAMS,C,I),L,2)
 F I="ICN","SCT","DES","ROV","DTM","RID" S @("DHP"_I)=PARAMS(I)
 ;S ^ZZFJF(99)=DHPICN_"^"_DHPSCT_"^"_DHPOBS_"^"_DHPUNT_"^"_DHPDTM
 Q
 ;
 ;  ---------------------------------------------
 ;
 ;
PATPRBSV ; save patient problems for one patient to VistA
 ;
 ;   DHPPATPRBUPD
 ;
 ;CRASH
 D PARSEPUPD
 D PRBUPDT^SYNDHP62(.RETSTA,DHPPAT,DHPVST,DHPROV,DHPONS,DHPABT,DHPCLNST,DHPSCT)
 D ADD^RGNETWWW(RETSTA_$C(13,10))
 Q
 ;
 ;
PARSEPUPD ;
 ;
 S C=",",L=":"
 D SYNDHPLOG($H)
 S PARAMS=RGNETREQ("BODY",1)
 I $L(PARAMS,L)=1 S C="&",L="="
 F I=1:1:$L(PARAMS,C) D
 .S PARAMS($P($P(PARAMS,C,I),L))=$P($P(PARAMS,C,I),L,2)
 F I="PAT","VST","ROV","ONS","ABT","CLNST","SCT" S @("DHP"_I)=PARAMS(I)
 Q
 ;
 ;
PATDEMSV ; save demographics for one patient
 ;
 ; *** may have been overtaken by events
 ; *** may be removed at some suitable juncture or use ISI?
 ;
 ;   DHPPATDEMUPD
 ;
 ;D PARSEDEM
 ;D DEMUPD^SYNDHP61(.RETSTA,DHPICN,DHPSCT,DHPDES,DHPICD,DHPROV,DHPDTM,DHPRID)
 ;D ADD^RGNETWWW(RETSTA_$C(13,10))
 Q
PARSEDEM ;
 ;
 S C=",",L=":"
 S PARAMS=RGNETREQ("BODY",1)
 F I=1:1:$L(PARAMS,C) D
 .S PARAMS($P($P(PARAMS,C,I),L))=$P($P(PARAMS,C,I),L,2)
 ;CRASH
 F I="ICN","SCT","DES","ICD","ROV","DTM","RID" S @("DHP"_I)=PARAMS(I)
 ;S ^ZZFJF(99)=DHPICN_"^"_DHPSCT_"^"_DHPOBS_"^"_DHPUNT_"^"_DHPDTM
 Q
 ;
 ;  ---------------------------------------------
 ;
PATIMUSV ; save Immunizations for one patient
 ;
 ;   DHPPATIMMUPD
 ;
 D PARSEIMU
 ; Immunizations update
 D IMMUNUPD^SYNDHP61(.RETSTA,DHPICN,DHPVIS,DHPCVX,DHPLOC,DHPROU,DHPDOS,DHPDTM,DHPPROV)
 D ADD^RGNETWWW(RETSTA_$C(13,10))
 Q
PARSEIMU ;
 ;
 N C,I,L,PARAMS
 ;
 S C=",",L=":"
 S PARAMS=RGNETREQ("BODY",1)
 F I=1:1:$L(PARAMS,C) D
 .S PARAMS($P($P(PARAMS,C,I),L))=$P($P(PARAMS,C,I),L,2)
 ;CRASH
 F I="ICN","VIS","CVX","LOC","ROU","DOS","DTM","PROV" S @("DHP"_I)=PARAMS(I)
 ;S ^ZZART(99)=DHPICN_U_DHPVIS_U_DHPCVX_U_DHPLOC_U_DHPROU_U_DHPDOS_U_DHPDTM_U_DHPPROV
 Q
 ;
 ;  ---------------------------------------------
 ;
PATAPTCR ; create Appointment for one patient
 ;
 ;   DHPPATAPTCRE
 ;
 D PARSEAPT
 ; Appointment create
 D APPTADD^SYNDHP62(.RETSTA,DHPPAT,DHPCLIN,DHPAPTDT,DHPLEN)
 D ADD^RGNETWWW(RETSTA_$C(13,10))
 Q
PARSEAPT ;
 ;
 N C,I,L,PARAMS
 ;
 S C=",",L=":"
 S PARAMS=RGNETREQ("BODY",1)
 F I=1:1:$L(PARAMS,C) D
 .S PARAMS($P($P(PARAMS,C,I),L))=$P($P(PARAMS,C,I),L,2)
 ;CRASH
 F I="PAT","CLIN","APTDT","LEN" S @("DHP"_I)=PARAMS(I)
 ;S ^ZZART(99)=DHPPAT_U_DHPCLIN_U_DHPAPTDT_U_DHPLEN
 Q
 ;
 ;  ---------------------------------------------
 ;
PATAPTCI ; check-in one Appointment for one patient
 ;
 ;   DHPPATAPTCI
 ;
 D PARSECI
 ; Appointment create
 D APPTCKIN^SYNDHP62(.RETSTA,DHPPAT,DHPCLIN,DHPAPTDT,DHPCIDT)
 D ADD^RGNETWWW(RETSTA_$C(13,10))
 Q
PARSECI ;
 ;
 N C,I,L,PARAMS
 ;
 S C=",",L=":"
 S PARAMS=RGNETREQ("BODY",1)
 F I=1:1:$L(PARAMS,C) D
 .S PARAMS($P($P(PARAMS,C,I),L))=$P($P(PARAMS,C,I),L,2)
 ;CRASH
 F I="PAT","CLIN","APTDT","CIDT" S @("DHP"_I)=PARAMS(I)
 ;S ^ZZART(99)=DHPPAT_U_DHPCLIN_U_DHPAPTDT_U_DHPCIDT
 Q
 ;
 ;
 ;  ---------------------------------------------
 ;
PATLABSV ; create one lab result for one patient
 ;
 ;   DHPPATLABUPD
 ;
 D PARSELAB
 ; Lab Result create
 D LABADD^SYNDHP63(.RETSTA,DHPPAT,DHPLOC,DHPTEST,DHPRSLT,DHPRSDT,DHPLOINC)
 D ADD^RGNETWWW(RETSTA_$C(13,10))
 Q
PARSELAB ;
 ;
 N C,I,L,PARAMS
 ;
 S C=",",L=":"
 S PARAMS=RGNETREQ("BODY",1)
 F I=1:1:$L(PARAMS,C) D
 .S PARAMS($P($P(PARAMS,C,I),L))=$P($P(PARAMS,C,I),L,2)
 ;CRASH
 F I="PAT","LOC","TEST","RSLT","RSDT","LOINC" S @("DHP"_I)=PARAMS(I)
 ;S ^ZZART(99)=DHPPAT_U_DHPLOC_U_DHPTEST_U_DHPRSLT_U_DHPRSDT_U_DHPLOINC
 Q
 ;
 ;  ---------------------------------------------
 ;
SYSFAC ; create/delete system facility parameter
 ;
 ;   DHPSYSFACUPD
 ;
 F I="FAC" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 S ^zzfjf("FAC")=DHPFAC
 D FACPAR^SYNDHP69(.RETSTA,DHPFAC)
 D ADD^RGNETWWW(RETSTA_$C(13,10))
 Q 
 ;
 ;  ---------------------------------------------
 ;
PARSEICN ; ICN PARSER
 ; 
 ;CRASH
 F I="ICN" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 Q
PARSETRAITS ; Traits parser
 ;
 F I="SSN","DOB","GENDER" S @("DHP"_I)=$$GETPARAM^RGNETWWW(I)
 S DHPNAME=$$GETPARAM^RGNETWWW("NAME",1,1)
 S DHPNAME=DHPNAME_","_$$GETPARAM^RGNETWWW("NAME",1,2)_" "
 Q
SYNDHPLOG(TS) ; log arrays
 I $D(RGNETREQ) M ^SYNDHPLOG(TS,"RGNETREQ")=RGNETREQ
 I $D(RGCFG) M ^SYNDHPLOG(TS,"RGCFG")=RGCFG
 q
