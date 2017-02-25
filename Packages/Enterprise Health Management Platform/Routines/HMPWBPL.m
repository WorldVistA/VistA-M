HMPWBPL ;;EJK/AGX - ENTRY POINT FOR ALL PROBLEM WRITEBACK ACTIVITY; 3/11/2016
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;DEC 11 2014;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ; INPUT PARAMETERS
 ;   DFN - Patient Identifier. 
 ;   PRV - IEN of provider updating the comment/note for this problem
 ;   VAMC - IEN of location from ^AUTTLOC (file 9999999.06)
 ;   GMPFLD(list) - array of related data
 ;      .01     ;DIAGNOSIS - ICD DIAGNOSIS FILE (FILE 
 ;      .03     ;DATE LAST MODIFIED - DEFAULTS TO CURRENT DATE, FILEMAN DATE FORMAT
 ;      .05     ;PROVIDER NARRATIVE - PROVIDER NARRATIVE FILE, FREE TEXT
 ;      .08     ;DATE ENTERED - FILEMAN DATE FORMAT
 ;      .12     ;STATUS - VALUES ARE (A)CTIVE OR (I)NACTIVE
 ;      .13     ;DATE OF ONSET - FILEMAN DATE FORMAT
 ;      1.01    ;PROBLEM - EXPRESSIONS FILE - Search text from file 9999999.27
 ;      1.02    ;CONDITION - VALUES ARE (T)RANSCRIBED, (P)ERMANENT OR (H)IDDEN
 ;      1.03    ;ENTERED BY - DUZ OF THE PERSON ENTERING THE PROBLEM (NEW PERSON FILE)
 ;      1.04    ;RECORDING PROVIDER - IEN FROM NEW PERSON FILE
 ;      1.05    ;RESPONSIBLE PROVIDER - IEN FROM NEW PERSON FILE
 ;      1.06    ;SERVICE - IEN to SERVICE/SECTION FILE (#49)
 ;      1.07    ;DATE RESOLVED - FILEMAN DATE FORMAT
 ;      1.08    ;IEN TO HOSPITAL LOCATION (FILE 44)
 ;      1.09    ;DATE RECORDED - FILEMAN DATE FORMAT
 ;      1.1     ;SERVICE CONNECTED - 1 FOR YES, 0 FOR NO
 ;      1.11    ;AGENT ORANGE EXPOSURE - 1 FOR YES, 0 FOR NO
 ;      1.12    ;IONIZING RADIATION EXPOSURE - 1 FOR YES, 0 FOR NO
 ;      1.13    ;PERSIAN GULF EXPOSURE  - 1 FOR YES, 0 FOR NO
 ;      1.14    ;PRIORITY - (A)CUTE OR (C)HRONIC
 ;      1.15    ;HEAD AND/OR NECK CANCER - 1 FOR YES, 0 FOR NO
 ;      1.16    ;MILITARY SEXUAL TRAUMA - 1 FOR YES, 0 FOR NO
 ;      1.17    ;COMBAT VETERAN - 1 FOR YES, 0 FOR NO
 ;      1.18    ;SHIPBOARD HAZARD & DEFENSE - 1 FOR YES, 0 FOR NO
 ;      (10,"NEW",1) ;FREE TEXT 60 CHARACTER LIMIT - 1 INDICATES THE NOTE NUMBER
 ;      10,0)   ;WHICH NOTE IS BEING ADDED OR CHANGED
 ;
 Q
 ;
PL(RSLT,DFN,PRV,VAMC,GMPFLD) ; MAIN ENTRY POINT FROM RPC HMP WRITEBACK PROBLEM
 N GMPDFN,GMPVAMC
 S GMPDFN=$G(DFN)
 ;if VAMC is not sent, get the default VAMC site id
 S GMPVAMC=$S($G(VAMC)'="":VAMC,1:+$$SITE^VASITE())
 S RETURN=0
 ;
 ;Lock the problem file. This is a carryover from the GMPLSAVE routine.
 ;For new entries, an IEN to the problem file is not yet assigned so the 
 ;entire file is locked to avoid a collission. 
 ;
 L +^AUPNPROB(0):10 I '$T D MSG^HMPTOOLS("Unable to lock problem file",1) Q
 ;
 ;save patient problem
 D NEW^GMPLSAVE
 ;if record field, DA will be populated. 
 I $G(DA)'>0 D MSG^HMPTOOLS("Problem was not successfully filed",1) Q
 L -^AUPNPROB(0)
 ;set filters for building the JSON result
 S FILTER("id")=DA
 S FILTER("noHead")=1
 S FILTER("domain")="problem"
 S FILTER("patientId")=GMPDFN
 ;create the JSON response
 D GET^HMPDJ(.RSLT,.FILTER)
 ;do not need the 'total' node
 K ^TMP("HMP",$J,"total")
 ;return everything else.
 S RSLT=$NA(^TMP("HMP",$J))
 Q
