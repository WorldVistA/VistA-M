SCMCNPER ;ALB/ART - PCMM Web Query New Person file ;03/13/2015
 ;;5.3;Scheduling;**603**;Aug 13, 1993;Build 79
 ;
 QUIT
 ;
 ;Cloned from XUPSQRY - PCMM Web needs Application Proxy Access
 ;added new parameter to lookup by DUZ, and add phone and pager to return
 ;don't filter out inactive, return info to PCMM Web
 ;
 ;Public, Supported ICRs
 ; #1625  - PERSON CLASS API'S
 ; #2343  - DBIA2343 (XUSER)
 ; #4574  - XUPS APIs
 ; #10000 - Classic FileMan API: Date/Time Manipulation (%DTC)
 ; #10060 - NEW PERSON FILE
 ; #10106 - HLFNC (HL7 APIs)
 ; #10112 - VASITE - Supported APIs for site info
 ;
 ;XUPSQRY ;EDS/GRR - Query New Person file ;4/9/04  10:40
 ;;8.0;KERNEL;**325**; Jul 10, 1995
 ;
 ;Input Parameter:
 ;   SCMCVPID - VPID of the user (Required for lookup by VPID)
 ;   SCMCDUZ  - File 200 IEN (Required for lookup by IEN)
 ;   SCMCLNAM - Part or all of the last name to use for basis
 ;              of query (Required for lookup by name)
 ;   SCMCFNAM - Part or all of the first name to use for basis
 ;              of query filter (optional, can be null)
 ;   SCMCSSN  - Social Security Number (null or full 9 digits) to
 ;              use as additional filter for query
 ;   SCMCPROV - If value set to "P", screen for only providers
 ;              (only persons with active person class)
 ;   SCMCSTN  - Filter persons based on station number entered
 ;              (optional, can be null)  This parameter is no longer used, but left as a place holder.
 ;   SCMCMNM  - Maximum Number of entries to return
 ;              (Number between 1 and 50.  Null defaults to 50)
 ;   SCMCDATE - Date to be used to determine whether person has
 ;              active person class.  If null, current date is used.
 ;
 ;Output:
 ;   RESULT - Name of global array were output data is stored
 ;            ^TMP($J,"SCMCQRY",1) - 1 if found, 0 if not found
 ;            ^TMP($J,"SCMCQRY",n,0) - VPID^IEN^Last Name~First Name~Middle Name^SSN^DOB^SEX^Phone^Pager^
 ;            ^TMP($J,"SCMCQRY",n,1) - Provider Type^
 ;            ^TMP($J,"SCMCQRY",n,2) - Provider Classification^
 ;            ^TMP($J,"SCMCQRY",n,3) - Provider Area of Specialization^
 ;            ^TMP($J,"SCMCQRY",n,4) - VA CODE^X12 CODE^Specialty Code
 ;            ^TMP($J,"SCMCQRY",n,5) - Result of call to $$ACTIVE^XUSER(SCMCIEN)^end-of-record character "|"
 ;
EN1(RESULT,SCMCVPID,SCMCDUZ,SCMCLNAM,SCMCFNAM,SCMCSSN,SCMCPROV,SCMCSTN,SCMCMNM,SCMCDATE) ;
 N %,SCMCNDAT
 K ^TMP($J,"SCMCQRY")
 K RESULT
 S RESULT=$NA(^TMP($J,"SCMCQRY")) ;set variable to name of global array where output data will be stored 
 S ^TMP($J,"SCMCQRY",1)=0 ;initialize to not found
 I $G(SCMCLNAM)="",($G(SCMCVPID)=""),($G(SCMCDUZ)="") Q  ;one of the 3 lookup parameters is required
 S SCMCFNAM=$G(SCMCFNAM)  ;Set to null if missing
 S SCMCSSN=$G(SCMCSSN)  ;Set to null if missing
 S SCMCPROV=$G(SCMCPROV)  ;Set to null if missing
 S SCMCSTN=$G(SCMCSTN)  ;Set to null if missing
 I $G(SCMCDATE)="" S SCMCDATE="" ;set to null if missing
 D NOW^%DTC
 S SCMCNDAT=%\1 ;set date to today and truncate time
 S SCMCDATE=$S(SCMCDATE="":SCMCNDAT,1:$$FMDATE^HLFNC(SCMCDATE)) ;change date from hl7 format to fileman format
 ;
 N SCMCCNT,SCMCNAME,SCMCIEN,SCMCDOB,SCMCSEX,SCMCPC,SCMCX12,SCMCPASS ;initialize new set of variables
 S:$G(SCMCMNM)="" SCMCMNM=50 ;set to default
 S SCMCCNT=0 ;Initialize variable
 ;
 ;Lookup by VPID
 I $G(SCMCVPID)'="" D  Q
 .S SCMCIEN=$$IEN^XUPS(SCMCVPID)
 .I +SCMCIEN>0 D
 ..D FILTER
 ..Q:SCMCPASS=0
 ..S SCMCCNT=SCMCCNT+1
 ..D FOUND(SCMCCNT,SCMCIEN,SCMCDATE) ;set array with person data
 ;
 ;Lookup by DUZ
 I $G(SCMCDUZ)'="" D  Q
 .Q:$$GET1^DIQ(200,SCMCDUZ_",",.01,"I")=""
 .S SCMCIEN=SCMCDUZ
 .D FILTER
 .Q:SCMCPASS=0
 .S SCMCCNT=SCMCCNT+1
 .D FOUND(SCMCCNT,SCMCIEN,SCMCDATE) ;set array with person data
 ;
 ;Lookup by name
 S SCMCIEN=0,SCMCNAME=SCMCLNAM ;initialize variables
 N SCMCRET,SCMCMSG,SCI
 D FIND^DIC(200,,"@;.01","PQ",SCMCLNAM,500,"B",,,"SCMCRET","SCMCMSG")
 S SCI=0
 F  S SCI=$O(SCMCRET("DILIST",SCI)) Q:SCI=""  D
 .S SCMCIEN=$P(SCMCRET("DILIST",SCI,0),U,1)
 .D FILTER
 .Q:SCMCPASS=0
 .S SCMCCNT=SCMCCNT+1
 .D FOUND(SCMCCNT,SCMCIEN,SCMCDATE) ;set array with person data
 Q
 ;
FILTER ;
 S SCMCPASS=1 ;initialize found flag to found
 I SCMCFNAM]"" S SCMCPASS=$$NMATCH(SCMCIEN,SCMCFNAM) ;check if matches name filter
 Q:'SCMCPASS  ;failed to match
 I SCMCSSN]"",($$GET1^DIQ(200,SCMCIEN_",",9)'=SCMCSSN) S SCMCPASS=0 Q  ;check ssn filter
 ;possible future use
 ;I SCMCSTN]"" S SCMCPASS=$$STNMAT(SCMCIEN,SCMCSTN) ;check station number
 ;Q:'SCMCPASS  ;failed match
 I SCMCPROV]"",($$GET^XUA4A72(SCMCIEN,SCMCDATE)<0) S SCMCPASS=0 Q  ;check if active person class
 Q
 ;
FOUND(SCMCCNT,SCMCIEN,SCMCDATE) ;format output array
 N SCMCNAME,SCMCSSN,SCMCVPID,SCMCSEX,SCMCDOB,SCMCPHON,SCMCPAGR,I,Y
 S Y=$$GET1^DIQ(200,SCMCIEN_",",.01) ;get full name
 S SCMCNAME=$$HLNAME^HLFNC(Y,"~|\/") ;format name into last name~first name~middle name
 I $L(SCMCNAME,"~")<3 S $P(SCMCNAME,"~",3)="" ;make sure formatted name has all 3 pieces
 S SCMCSSN=$$GET1^DIQ(200,SCMCIEN_",",9) ;ssn
 S SCMCVPID=$$GET1^DIQ(200,SCMCIEN_",",9000) ;vpid
 S SCMCSEX=$$GET1^DIQ(200,SCMCIEN_",",4,"I") ;sex
 S SCMCDOB=$$GET1^DIQ(200,SCMCIEN_",",5,"I") ;dob fileman format
 I SCMCDOB]"" S SCMCDOB=$$HLDATE^HLFNC(SCMCDOB,"DT") ;format dob to correct hl7 format yyyymmdd
 S SCMCPHON=$$GET1^DIQ(200,SCMCIEN_",",.132) ;office phone
 S SCMCPAGR=$$GET1^DIQ(200,SCMCIEN_",",.138) ;digital pager
 S ^TMP($J,"SCMCQRY",1)=1 ;set to indicate match found
 S ^TMP($J,"SCMCQRY",SCMCCNT,0)=SCMCVPID_"^"_SCMCIEN_"^"_SCMCNAME_"^"_SCMCSSN_"^"_SCMCDOB_"^"_SCMCSEX_"^"_SCMCPHON_"^"_SCMCPAGR_"^"
 S SCMCPC=$$GET^XUA4A72(SCMCIEN,SCMCDATE) ;get active person class data
 S:SCMCPC<0 SCMCPC="" ;no active person class
 F I=1:1:3 S ^TMP($J,"SCMCQRY",SCMCCNT,I)=$P(SCMCPC,"^",(1+I))_"^" ;put provider type, provider class, and are of specialization in output array
 S SCMCX12="" ;PCMM Web does not use this - 603
 S ^TMP($J,"SCMCQRY",SCMCCNT,4)=$P(SCMCPC,"^",7)_"^"_SCMCX12_"^"_$P(SCMCPC,"^",8)_"^" ;put va code, x12 code, specialty code
 S ^TMP($J,"SCMCQRY",SCMCCNT,5)=$$ACTIVE^XUSER(SCMCIEN)_"^|" ;603
 Q
 ;
NMATCH(SCMCIEN,SCMCFNAM) ;
 ;Match on First Name
 ;Input Parameters:
 ;      SCMCIEN - Internal Entry Number of New Person entry
 ;     SCMCFNAM - Part or all of Person first name
 ;Output:
 ;      SCMCOUT - 1 if name matched, 0 if name did not match
 ;
 N SCMCA,SCMCHFN,SCMCFN,SCMCNFN,SCMCOUT ;establish new variables
 S SCMCFN=$$GET1^DIQ(200,SCMCIEN_",",.01) ;get full name
 S SCMCHFN=$$HLNAME^HLFNC(SCMCFN,"~|\/") ;change to HL7 format (last name~first name~middle name)
 S SCMCNFN=$P(SCMCHFN,"~",2) ;get first name
 S SCMCOUT=$S($E(SCMCNFN,1,$L(SCMCFNAM))[SCMCFNAM:1,1:0) ; match first name to first name passed
 Q SCMCOUT  ;return 1 if name matched, 0 if no match
 ;
 ;STNMAT(SCMCIEN,SCMCSTN) ;Station Number matching (possible future use)
 ;Input Parameters:
 ;     SCMCIEN - Internal Entry Number of New Person entry
 ;     SCMCSTN - 3-6 character station number to use as screen
 ;               (i.e. 603 or 528A4)
 ;Output:
 ;     SCMCOUT - 1 if station matched, 0 if no station match
 ;
 ; NOTE: If this code is ever used, needs to be tested and subscription to ICR 4055
 ;
 ;NEW SCMCOUT,SCMCRET,SCI,SCHIT
 ;SET SCMCOUT=0
 ;DO DIVGET^XUSRB2(.SCMCRET,SCMCIEN)
 ;IF +SCMCRET(0)'=0 DO
 ;. SET SCHIT=0
 ;. SET SCI=""
 ;. FOR  SET SCI=$ORDER(SCMCRET(SCI)) QUIT:SCI=""!(SCHIT)  DO
 ;. . IF $PIECE(SCMCRET(SCI),U,3)=SCMCSTN DO
 ;. . . SET SCMCOUT=1
 ;. . . SET SCHIT=1
 ;QUIT SCMCOUT  ;return 1 if match, 0 if no match
 ;
