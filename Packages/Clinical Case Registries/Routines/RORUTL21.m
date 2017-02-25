RORUTL21 ;HCIOFO/BH,SG - VACCINATION DATA SEARCH ; 12/13/05 2:16pm
 ;;1.5;CLINICAL CASE REGISTRIES;**29**;Feb 17, 2006;Build 18
 ;
 ; This routine uses the following IAs:
 ; #10104   UP^XLFSTR (supported)
 ; #5521   ^AUPNVIMM (private)
 ; #2056    GETS^DIQ
 ;
 ;******************************************************************************
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*29   APR  2016   T KOPP       Added routine for immunization search.
 ;******************************************************************************
 Q
 ;
 ;***** QUERIES THE IMMUNIZATION DATA FOR SPECIFIC VACCINE NAME PATTERN MATCHES
 ;
 ; PATIEN        IEN of the patient (DFN)
 ;
 ; ROR8PAT      Closed root of a variable, which contains a list
 ;               of pattern matches for names of vaccines of interest
 ;               [in the format ROR(i)=pattern to match]
 ;
 ; [[.]ROR8DST]  Closed root of an array where the data will be
 ;               returned (^TMP("RORUTL21",$J), by default).
 ;               The data will be stored into the destination
 ;               array in following format:
 ;
 ;                 @ROR8DST = number of vaccination records found
 ;                    @ROR8DST@(i)  
 ;                                 ^01: Vaccine Name
 ;                                 ^02: Event Date
 ;                             
 ;               The function should return the following values:
 ;
 ;                 <0  Error code (the search will be aborted)
 ;                  0 or greater = the # of matches found
 ;
 ;  RORVSDT      Start date (FileMan)
 ; [RORVEDT]     End date   (FileMan)
 ;
QUERY(PATIEN,ROR8PAT,ROR8DST,RORVSDT,RORVEDT) ;
 N DFN,RC,ROR1,RESULT
 ;
 S DFN=PATIEN
 S:$G(ROR8DST)="" ROR8DST=$NA(^TMP("RORUTL21",$J))
 Q:$G(ROR8PAT)="" -1               ; No vaccines to search for
 ;---
 S:$G(RORVEDT)'>0 RORVEDT=DT
 S RC=0
 ;
 ;--- Look for vaccine data (immunizations)
 S (ROR1,RESULT)=0
 F  S ROR1=$O(^AUPNVIMM("C",DFN,ROR1)) Q:'ROR1  D
 . N MATCH,RORIDATA,RORIERR,ROREVDT,RORVACNM,RORL,PATT,X,Y,Z
 . ;get vaccine data   field #1201 = event date/time
 . K RORIDATA,RORIERR D GETS^DIQ(9000010.11,ROR1_",",".01;.03;1201","IE","RORIDATA","RORIERR")
 . Q:$D(RORIERR("DIERR"))
 . S ROREVDT=$G(RORIDATA(9000010.11,ROR1_",",1201,"I")) ;get event date/time
 . I 'ROREVDT D
 .. N Z
 .. S Z=$G(RORIDATA(9000010.11,ROR1_",",.03,"I")) ; if no event date, get the visit date
 .. I Z'="" S ROREVDT=$P($G(^AUPNVSIT(Z,0)),U)
 . Q:ROREVDT>(RORVEDT_.999999)  ;date/time past end date
 . Q:ROREVDT<RORVSDT  ;date/time before start date
 . S RORVACNM=$$UP^XLFSTR($G(RORIDATA(9000010.11,ROR1_",",.01,"E"))) ;get name of vaccine in all uppercase
 . S RORL=0,MATCH=0
 . F  S RORL=$O(@ROR8PAT@(RORL)) Q:'RORL  S PATT=$G(^(RORL)) I PATT'="" D  Q:MATCH
 .. ; Check if vaccine name matches any of the pattern matches
 .. I RORVACNM?@(PATT) S MATCH=1 D  Q
 ... S RESULT=RESULT+1,@ROR8DST@(RESULT)=RORVACNM_U_ROREVDT
 S @ROR8DST=RESULT,RC=RESULT
 Q RC
 ;
 ; RORVLST      Closed root of a variable, which contains a list
 ;               of vaccines matching search criteria
 ;               [in the format RORVLST(i)=vaccine name^event date
 ;
 ; PATIEN        IEN of the patient (DFN)
 ;
 ; ROR8VLST      Closed root of an array where the data will be
 ;               returned.
 ;               The data will be stored into the destination
 ;               array in following format:
 ;
 ;                 @ROR8VLST = # of vaccines found
 ;                    @ROR8VLST@(Vaccine Name,Event Date) = null  
 ;                             
 ; The function should return the following values:
 ;
 ;        <0  Error
 ;         0  OK
 ;
PROCESS(RORVLST,PATIEN,ROR8VLST) ; 
 N CT,RC,ROR,RORNM,RORDT
 S CT=0
 S RC=-1,ROR=0 F  S ROR=$O(@RORVLST@(ROR)) Q:'ROR  D
 . S RORNM=$P(@RORVLST@(ROR),U),RORDT=$P(@RORVLST@(ROR),U,2)
 . I RORNM=""!(RORDT="") Q
 . S @ROR8VLST@(RORNM,RORDT)="",RC=1,CT=CT+1
 S @ROR8VLST=CT
 Q RC
 ;
