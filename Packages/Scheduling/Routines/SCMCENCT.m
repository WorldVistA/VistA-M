SCMCENCT ;ALB/ART - PCMM Web RPC to Get Patient Encounters ;02/05/2015
 ;;5.3;Scheduling;**603**;Aug 13, 1993;Build 79
 ;
 QUIT
 ;
 ;Public, Supported ICRs
 ; #2056 - Data Base Server API: Data Retriever Utilities (DIQ)
 ; #10003 - Classic FileMan API: Date/Time Input & Conversion (%DT)
 ; #10035 - PATIENT FILE (^DPT)
 ; #10103 - Kernel Date functions (XLFDT)
 ;Subscription ICRs
 ; #2028 - READ ACCESS ONLY TO PCE VISIT FILE
 ; #2316 - DBIA2316 - V Provider (9000010.06) "AD" xref
 ;
ENCT(SCLIST,SCDFN,SCLKBK,SCLKEND) ;Get patient encounters
 ;Entry Point for RPC - SCMC GET PATIENT ENCOUNTERS
 ;Inputs: SCLIST - Array for patient encounter  info - passed by reference
 ;        SCDFN  - Patient DFN, if null returns all patients
 ;        SCLKBK - Number of days in the past to look for encounters, defaults to 30
 ;        SCLKEND - Number of days to end look back for encounters, defaults to 0
 ;Output: populated SCLIST
 ;
 NEW X,Y,%DT
 NEW SCDAYS,SCDAYEND,SCPASTDT,SCINDX,SCDFN1
 ;
 ;Number of days to look back for encounters
 SET SCDAYS=$GET(SCLKBK,30)
 SET SCDAYEND=$GET(SCLKEND,0)
 IF SCDAYEND'<SCDAYS DO  QUIT
 . SET ^TMP("SCMCENCT",$J,1)="-1^End Days must be less than Number of Days."
 ;
 ;begin date: today-SCDAYS days
 SET %DT=""
 SET X="T-"_SCDAYS
 DO ^%DT
 SET SCPASTDT=+Y
 ;end date: today
 IF SCDAYEND=0 DO
 . SET SCENDDT=DT_".235959"
 ELSE  DO
 . ;end date: today-SCDAYEND days
 . SET %DT=""
 . SET X="T-"_SCDAYEND
 . DO ^%DT
 . SET SCENDDT=+Y_".235959"
 ;
 K ^TMP("SCMCENCT",$J)
 S SCLIST=$NA(^TMP("SCMCENCT",$J)) ;set variable to name of global array where output data will be stored 
 S ^TMP("SCMCENCT",$J,1)="" ;initialize to no data found
 ;
 SET SCINDX=1
 ;
 IF $GET(SCDFN)="" DO
 . ;Look at all patients
 . SET SCDFN1=""
 . FOR  SET SCDFN1=$ORDER(^SCE("ACOD",SCDFN1)) QUIT:SCDFN1=""  DO
 . . DO FIND(SCDFN1,SCPASTDT,SCENDDT,.SCINDX)
 ELSE  DO
 . ;or specified patient
 . IF $$GET1^DIQ(2,SCDFN_",",.01)="" DO  QUIT
 . . SET ^TMP("SCMCENCT",$J,1)="-1^Patient was not found."
 . DO FIND(SCDFN,SCPASTDT,SCENDDT,.SCINDX)
 ;
 QUIT
 ;
FIND(SCDFN,SCPASTDT,SCENDDT,SCINDX) ;Look for Patient's Encounters in Outpatient Encounter and Visit Files
 ;Inputs: SCDFN  - Patient DFN
 ;        SCPPASDT - look for encounters greater than this date
 ;        SCENDDT - look for encounters less than this date
 ;        SCINDX - index for ^TMP, passed by reference
 ;Output: populated ^TMP("SCMCENCT",$J) global, RPC returns a global array
 ;
 NEW SCENCDT,SCENCIEN,SCPDUZ,SCPRISEC,SCVPIEN,SCVSTIEN
 NEW SCSTCIEN,SCSTOPCD,SCEPARNT,SCVPARNT,SCVTYPE,SCCOCOMP
 NEW SCLOC,SCCTYPE,SCNCNT,SCCAT,SCSTAT,SCPREC
 ;
 ;^SCE("ACOD",<dfn>,<checkout date>,<encounter ien>)=""
 SET SCCOCOMP=SCPASTDT-1 ;start at begin date -1
 FOR  SET SCCOCOMP=$ORDER(^SCE("ACOD",SCDFN,SCCOCOMP)) QUIT:('SCCOCOMP)!(SCCOCOMP>SCENDDT)  DO
 . SET SCENCIEN=""
 . FOR  SET SCENCIEN=$ORDER(^SCE("ACOD",SCDFN,SCCOCOMP,SCENCIEN)) QUIT:SCENCIEN=""  DO
 . . QUIT:+$$GET1^DIQ(409.68,SCENCIEN,.07,"I")\1<$GET(SCPASTDT)  ;checkout date < begin date
 . . SET SCVSTIEN=+$$GET1^DIQ(409.68,SCENCIEN,.05,"I") ;Visit File IEN
 . . QUIT:+$$GET1^DIQ(9000010,SCVSTIEN,.11,"I")  ;visit delete flag
 . . QUIT:$$GET1^DIQ(9000010,SCVSTIEN,.03,"I")'="V"  ;non VA visit
 . . SET SCENCDT=$$GET1^DIQ(409.68,SCENCIEN,.01,"I") ;encounter date
 . . SET SCSTCIEN=$$GET1^DIQ(409.68,SCENCIEN,.03,"I") ;clinic stop code ien
 . . SET SCSTOPCD=$$GET1^DIQ(40.7,SCSTCIEN,1) ;AMIS stop code
 . . SET SCEPARNT=$$GET1^DIQ(409.68,SCENCIEN,.06,"I") ;parent encounter ien
 . . SET SCVPARNT=$$GET1^DIQ(9000010,SCVSTIEN,.12,"I") ;parent visit ien
 . . SET SCVTYPE=$$GET1^DIQ(9000010,SCVSTIEN,15003,"I") ;visit type
 . . SET SCLOC=$$GET1^DIQ(9000010,SCVSTIEN,.22,"I") ;hospital location
 . . SET SCCTYPE=$$GET1^DIQ(44,SCLOC,2,"I") ;hospital location type
 . . SET SCNCNT=$$GET1^DIQ(44,SCLOC,2502,"I") ;hospital location non-count clinic
 . . SET SCCAT=$$GET1^DIQ(9000010,SCVSTIEN,.07,"I") ;visit service category
 . . SET SCSTAT=$$GET1^DIQ(9000010,SCVSTIEN,15002,"I") ;visit patient status
 . . ; Visit Providers - ^AUPNVPRV("AD",<visit ien>,<visit prov ien>)
 . . SET SCVPIEN=""
 . . SET SCPREC=0
 . . FOR  SET SCVPIEN=$ORDER(^AUPNVPRV("AD",SCVSTIEN,SCVPIEN)) QUIT:SCVPIEN=""  DO
 . . . SET SCPDUZ=$$GET1^DIQ(9000010.06,SCVPIEN,.01,"I") ;provider duz/ien for 200 file
 . . . SET SCPRISEC=$$GET1^DIQ(9000010.06,SCVPIEN,.04,"I") ;primary/secondary
 . . . SET ^TMP("SCMCENCT",$J,SCINDX)=SCDFN_U_SCENCDT_U_SCPDUZ_U_SCPRISEC_U_SCSTOPCD_U_SCVTYPE_U_SCCOCOMP_U_SCENCIEN_U_SCEPARNT_U_SCVSTIEN_U_SCVPARNT_U_SCCTYPE_U_SCNCNT_U_SCCAT_U_SCSTAT
 . . . SET SCINDX=SCINDX+1
 . . . SET SCPREC=1
 . . IF 'SCPREC DO
 . . . SET SCPDUZ=""
 . . . SET SCPRISEC=""
 . . . SET ^TMP("SCMCENCT",$J,SCINDX)=SCDFN_U_SCENCDT_U_SCPDUZ_U_SCPRISEC_U_SCSTOPCD_U_SCVTYPE_U_SCCOCOMP_U_SCENCIEN_U_SCEPARNT_U_SCVSTIEN_U_SCVPARNT_U_SCCTYPE_U_SCNCNT_U_SCCAT_U_SCSTAT
 . . . SET SCINDX=SCINDX+1
 ;
 QUIT
 ;
