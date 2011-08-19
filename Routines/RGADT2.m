RGADT2 ;HIRMFO/GJC-TFL FILE SEEDING ROUTINE (PD-MPI LOAD) ;09/21/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**4,17,20**;30 Apr 99
 Q  ; quit if called from the top
 ;
EN ; entry point to check the TREATING FACILITY LIST (TFL-391.91) file
 ; for the proper LAST TREATMENT DATE.  This code is part of the post
 ; init for RG*1*4.  This can also be called from the EN1 entry point
 ; to determine the LAST TREATMENT DATE for a specific patient.
 ; Closely linked to the MFU event message broadcasts used to update
 ; the TFL (#391.91) file.
 ;
 ;IA: 2053 - FILE^DIE
 ;IA: 2070 - check for national ICN, 1st piece "MPI" node (global read)
 ;IA: 2701 - $$IFLOCAL^MPIF001
 ;IA: 2546 - GETGEN/PARSE^SDOE
 ;IA: 2988 - FILE^VAFCTFU
 ;IA: 2541 - $$KSP^XUPARAM
 ;IA: 2953 - ^SCE("ADFN"
 ;IA: 10061 - IN5^VADPT
 ;IA: 10103 - $$FMDIFF/$$NOW^XLFDT
 ;IA: 10104 - $$STRIP^XLFSTR
 ;IA: 10070 - ^XMD
 ;IA: 10141 - $$PARCP/$$UPCP^XPDUTL
 ;
 Q:$P($G(^RGSITE(991.8,1,1)),"^",2)  ; seeding process ran in the past
 ;
 S:$D(ZTQUEUED) ZTREQ="@"
 S U="^",RGSITE=$$KSP^XUPARAM("INST") ;defines the local facility
 S RGSTRT=$$NOW^XLFDT(),RGCNT=0
 ; check to see if software is part of an KIDS install.  If not, no
 ; checkpoints needed.
 S RGICN=$S($D(XPDNM):+$$PARCP^XPDUTL("POST2"),1:0)
 ; check ALL patients with an Integration Control Number (ICN) for a
 ; given facility, make sure the DATE LAST TREATED field in the TFL
 ; file is correct.
 F  S RGICN=$O(^DPT("AICN",RGICN)) Q:RGICN'>0  D
 . S RGDFN=0
 . F  S RGDFN=$O(^DPT("AICN",RGICN,RGDFN)) Q:RGDFN'>0  D EN1(RGDFN)
 . S RGCNT=RGCNT+1 ; increment record counter
 . S:$D(XPDNM) RGSAVE=$$UPCP^XPDUTL("POST2",RGICN)
 . Q
 S RGFIN=$$NOW^XLFDT() D EMAIL^RGADT2 ; send completion message to user
 ; populate the 'MPI/PD SEEDING COMP DATE/TIME' (#12) field in the CIRN
 ; SITE PARAMETER FILE (#991.8)  (do not re-seed a facility)
 K RGFDA S RGFDA(991.8,"1,",12)=$$NOW^XLFDT()
 D FILE^DIE("K","RGFDA"),KILL
 QUIT
 ;
EN1(RGDFN,RGSUP) ; determine the LAST TREATMENT DATE for a single
 ; patient called from our seeding process above.
 ; input: RGDFN - the dfn of the patient
 ;        RGSUP - if 1, suppress add entries to the ADT HL7 PIVOT
 ;                (#391.71) file for TF messaging - VAFCTFMF (optional)
 ; output: RGDATE - patient's DATE LAST TREATED
 ;         RGENVR - event reason
 ;
 Q:$$LOCICN(RGDFN,$G(RGICN))  ; local ICN
 S U="^"
 S RGSITE=$$KSP^XUPARAM("INST") ;defines the local facility
 S (RGLAST,RGADMDIS)=$$ADMDIS(RGDFN) ; dt_"^"_event type or ""
 S RGADMDIS=$S(RGADMDIS]"":$P(RGADMDIS,"^"),1:"") ; event dt or null
 S:$P(RGLAST,"^",2)=3!(RGLAST="") RGENCDT=$$ENCDT(RGDFN,RGADMDIS)
 ; patient has been discharged or has never been admitted.  Has this
 ; individual been checked out of a clinic? 
 I $D(RGENCDT)#2,($P(RGLAST,U)) S RGLAST=$S(+RGENCDT>+RGLAST:RGENCDT,1:RGLAST)
 I $D(RGENCDT)#2,('$P(RGLAST,U)) S RGLAST=RGENCDT
 S RGTYPE=$P(RGLAST,"^",2),RGDATE=+RGLAST
 ; input variables to FILE^VAFCTFU
 ; RGDFN - patient ien ; RGSITE - treating facility
 ; RGDATE - date last treated ; RGENVR - event reason
 ;
 I RGDATE D SETMSG,FILE^VAFCTFU(RGDFN,RGSITE_U_RGDATE_U_RGENVR,$G(RGSUP))
 ; update the TFL file for the site running the seeding process,
 ; then build the HL7 message with the new DATE LAST TREATED &
 ; ADT/HL7 EVENT REASON values & send them to our CMOR/subscribers.
 ;
 D:$G(XPDNM)'="RG*1.0*4" KILL ; single patient operation, kill all
 ; variables (EN1 re-entrant when running post-install for RG*1.0*4)
 Q
 ;
KILL ; kill and quit
 K DFN,RGADMDIS,RGCNT,RGDATE,RGDFN,RGENCDT,RGENVR,RGFDA,RGFIN,RGICN
 K RGLAST,RGSAVE,RGSITE,RGSTRT,RGTYPE
 Q
 ;
ADMDIS(DFN) ; find the patient's last admission and discharge dates if
 ; they exist.
 ; Input: DFN - ien of the patient (file 2)
 ;Output: a valid discharge/admission date/time concatenated with
 ;        the event type (1=admission, 3=discharge) -or- null
 N %,VAERR,VAIP S VAIP("D")="LAST" D IN5^VADPT
 I '+$G(VAIP(17,1)),('+$G(VAIP(13,1))) Q ""
 ; no discharge date, no admission date, return null
 I '+$G(VAIP(17,1)) Q $P($G(VAIP(13,1)),U)_"^1"
 ; no discharge date, return admission date
 I '+$G(VAIP(13,1)) Q $P($G(VAIP(17,1)),U)_"^3"
 ; no admission date, return discharge date
 I +$G(VAIP(17,1))>(+$G(VAIP(13,1))) Q +$G(VAIP(17,1))_"^3"
 ; return discharge date
 Q +$G(VAIP(13,1))_"^1" ; return admission date
 ;
ENCDT(DFN,INPDT) ; find the last patient check out date/time.  'ADFN'
 ; cross-reference accessed through DBIA: 2953
 ; Input: DFN  - ien of the patient (file 2)
 ;        INPDT - date (if any) returned from the inpatient admission/
 ;               discharge subroutine     
 ;Output: a valid discharge/admission date/time concatenated with
 ;        the event type (5=check out) -or- null
 Q:'DFN "" ; we need dfn defined
 K RGDATA,RGPURGE,RGX,RGX1,RGX2 N RGX3
 S RGX=9999999.9999999,RGX2=0,RGX3=""
 F  S RGX=$O(^SCE("ADFN",DFN,RGX),-1) Q:'RGX!(INPDT>RGX)  D  Q:RGX2
 . S RGX1=0 F  S RGX1=$O(^SCE("ADFN",DFN,RGX,RGX1)) Q:'RGX1  D  Q:RGX2
 .. D GETGEN^SDOE(RGX1,"RGDATA")
 .. D PARSE^SDOE(.RGDATA,"EXTERNAL","RGPARSE")
 .. I $G(RGPARSE(.12))="CHECKED OUT" S RGX2=1,RGX3=RGX
 .. K RGDATA,RGPARSE
 .. Q
 . Q
 K RGDATA,RGPURGE,RGX,RGX1,RGX2
 Q RGX3_"^5" ; X is either null or the date/time of the check out
 ;
SETMSG ; define the variables used to build a HL7 message (RGADT1)
 S DFN=RGDFN
 S RGENVR=$S(RGTYPE=1:"A1",RGTYPE=3:"A2",1:"A3") ;A1=adm;A2=dis;A3=CO 
 Q
 ;
EMAIL ; Send a completion email message to the user who installed this patch,
 ; RG*1*4.  Show the number of records processed, elapsed time and the
 ; number of records processed per minute.
 N RGELAPS,RGARY,RGMIN
 S XMDUZ=.5,XMY(DUZ)="",XMTEXT="RGARY(1,"
 S XMSUB="CIRN-CPRS DATE LAST TREATED seeding (#391.91 ; .03) results"
 S RGMIN=$$FMDIFF^XLFDT(RGFIN,RGSTRT,2)/60 ; # of sec x (1 min/60 sec)
 S:RGMIN=0 RGMIN=1 ; avoid a possible divide by zero
 S RGELAPS=$$FMDIFF^XLFDT(RGFIN,RGSTRT,3)
 S RGARY(1,1)="# of processed patients, in the PATIENT (#2) file"
 S RGARY(1,2)="with an ICN: "_RGCNT
 S RGARY(1,3)="TFL seeding process run time: "_RGELAPS_" (DD HH:MM:SS format)"
 S RGARY(1,4)="# of records processed per minute: "_$$STRIP^XLFSTR($J((RGCNT/RGMIN),8,2)," ")
 D ^XMD K XMDUZ,XMSUB,XMTEXT,XMY
 Q
 ;
LOCICN(DFN,ICN) ; check if this patient has a national ICN without having a
 ; local ICN.  This function is used when an entire site (all patients)
 ; is seeding, or for individual patient seeding.
 ; note: IA 2070 covers the hit on the 'MPI' node
 ;       IA 2701 covers the call to $$IFLOCAL^MPIF001
 ;input variables:
 ; DFN(required)-Patient ien (PATIENT file #2)
 ; ICN(optional)-Integration Control Number(fld: 991.01, file 2)
 ;output variable:
 ; FLAG-0 if the patient has a national ICN and not a local ICN, else 1
 N FLAG S FLAG=1
 I +$G(ICN) D
 . I $P($G(^DPT(DFN,"MPI")),"^")=ICN,('$$IFLOCAL^MPIF001(DFN)) S FLAG=0
 . Q
 E  D
 . I $P($G(^DPT(DFN,"MPI")),"^"),('$$IFLOCAL^MPIF001(DFN)) S FLAG=0
 . Q
 Q FLAG
