MHV7RU ;WAS/GPM - HL7 RECEIVER UTILITIES ; [12/13/07 10:26pm]
 ;;1.0;My HealtheVet;**2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
VALIDDT(DT) ; Validate and convert date
 ;
 ;  Integration Agreements:
 ;        10103 : HL7TFM^XLFDT
 ;
 I DT="" Q 1
 I DT'?8.16N Q 0
 S DT=$$HL7TFM^XLFDT(DT)\1
 I DT'?7N Q 0
 Q 1
 ;
VALRTYPE(TYPE,REQ,ERR) ; Validate request type
 ;
 ;  Input:
 ;     TYPE - Request type string
 ;
 ;  Output:
 ;     REQ - Request parameter array
 ;        REQ("TYPE")
 ;        REQ("REQNAME")
 ;        REQ("BLOCKED")
 ;        REQ("REALTIME")
 ;        REQ("EXECUTE")
 ;        REQ("BUILDER")
 ;
 ;     ERR - Caret delimited error string
 ;           segment^sequence^field^code^ACK type^error text
 ;
 N REQTIEN,REQT0
 S REQTIEN=$O(^MHV(2275.3,"D",TYPE,0))
 I 'REQTIEN S ERR="103^AE^Request Type Not Found" Q 0
 S REQT0=$G(^MHV(2275.3,REQTIEN,0))
 ;
 S REQ("REQNAME")=$P(REQT0,"^",1)
 S REQ("TYPE")=$P(REQT0,"^",2)
 S REQ("BLOCKED")=$P(REQT0,"^",3)
 S REQ("REALTIME")=$P(REQT0,"^",4)
 S REQ("EXECUTE")=$TR($P(REQT0,"^",5),"~","^")
 S REQ("BUILDER")=$TR($P(REQT0,"^",6),"~","^")
 Q 1
 ;
VALIDID(ICN,DFN,SSN,ERR) ;Validate patient identifiers
 ; Will accept ICN, SSN, or DFN, but must have at least one.
 ; Validate one, in order of preference: ICN, SSN, DFN.
 ; If more than once sent, all must resolve to the same patient.
 ; Those not sent will be resolved and returned.
 ;
 ;  Integration Agreements:
 ;         2701 : GETDFN^MPIF001, GETICN^MPIF001
 ;        10035 : Direct reference of ^DPT(DFN,0);9
 ;                and reference of ^DPT("SSN") x-ref
 ;
 ;  Input:
 ;     ICN, DFN, SSN - Identifiers
 ;
 ;  Output:  Function value True if IDs are valid, False otherwise
 ;     ICN, DFN, SSN - Identifiers
 ;     ERR - Caret delimited error string
 ;           segment^sequence^field^code^ACK type^error text
 ; 
 N XSSN,XDFN
 S ERR=""
 I ICN="",SSN="",DFN="" S ERR="101^AE^Missing Patient ID" Q 0
 ;
 I ICN'="" D  Q:ERR'="" 0 Q 1
 . D LOG^MHVUL2("VALIDID","ICN="_ICN,"S","DEBUG")
 . I ICN'?9.10N1"V"6N S ERR="102^AE^Invalid ICN" Q
 . S XDFN=$$GETDFN^MPIF001(+ICN)
 . I XDFN<1 S ERR="204^AR^Patient Not Found" Q
 . I '$D(^DPT(XDFN,0)) S ERR="204^AR^Patient Not Found" Q
 . S XSSN=$P($G(^DPT(XDFN,0)),"^",9)
 . I SSN'="" D  Q:ERR'=""
 .. I SSN'?9N S ERR="102^AE^Invalid SSN" Q
 .. I SSN'=XSSN S ERR="204^AE^Patient SSN Mismatch" Q
 .. Q
 . I DFN'="" D  Q:ERR'=""
 .. I DFN'?1N.N  S ERR="102^AE^Invalid DFN" Q
 .. I DFN<1 S ERR="102^AE^Invalid DFN" Q
 .. I DFN'=XDFN S ERR="204^AE^Patient DFN Mismatch" Q
 .. Q
 . S DFN=XDFN,SSN=XSSN
 . D LOG^MHVUL2("VALIDID","SSN="_SSN,"S","DEBUG")
 . D LOG^MHVUL2("VALIDID","DFN="_DFN,"S","DEBUG")
 . Q
 ;
 I SSN'="" D  Q:ERR'="" 0 Q 1
 . D LOG^MHVUL2("VALIDID","SSN="_SSN,"S","DEBUG")
 . I SSN'?9N S ERR="102^AE^Invalid SSN" Q
 . S XDFN=$O(^DPT("SSN",SSN,""))
 . I XDFN<1 S ERR="204^AR^Patient Not Found" Q
 . I '$D(^DPT(XDFN,0)) S ERR="204^AR^Patient Not Found" Q
 . S ICN=$$GETICN^MPIF001(XDFN)
 . I ICN<1 S ICN=""
 . I DFN'="" D  Q:ERR'=""
 .. I DFN'?1N.N  S ERR="102^AE^Invalid DFN" Q
 .. I DFN<1 S ERR="102^AE^Invalid DFN" Q
 .. I DFN'=XDFN S ERR="204^AE^Patient DFN Mismatch" Q
 .. Q
 . S DFN=XDFN
 . D LOG^MHVUL2("VALIDID","ICN="_ICN,"S","DEBUG")
 . D LOG^MHVUL2("VALIDID","DFN="_DFN,"S","DEBUG")
 . Q
 ;
 I DFN'="" D  Q:ERR'="" 0 Q 1
 . D LOG^MHVUL2("VALIDID","DFN="_DFN,"S","DEBUG")
 . I DFN'?1N.N  S ERR="102^AE^Invalid DFN" Q
 . I DFN<1 S ERR="102^AE^Invalid DFN" Q
 . I '$D(^DPT(DFN,0)) S ERR="204^AR^Patient Not Found" Q
 . S ICN=$$GETICN^MPIF001(DFN)
 . I ICN<1 S ICN=""
 . S SSN=$P($G(^DPT(DFN,0)),"^",9)
 . D LOG^MHVUL2("VALIDID","ICN="_ICN,"S","DEBUG")
 . D LOG^MHVUL2("VALIDID","SSN="_SSN,"S","DEBUG")
 . Q
 ;
 S ERR="101^AE^Missing Patient ID"
 Q 0
 ;
