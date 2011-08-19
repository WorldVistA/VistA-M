LA7QRY ;DALOI/JMC - Lab HL7 Query Utility ;Apr 26, 2007
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,69,68**;Sep 27, 1994;Build 56
 ;
 ; Reference to variable DIQUIET supported by DBIA #2098
 ; Reference to ^DPT("SSN") global supported by DBIA #10035
 ;
 Q
 ;
GCPR(LA7PTID,LA7SDT,LA7EDT,LA7SC,LA7SPEC,LA7QERR,LA7DEST,LA7HL7) ; Entry point for Government Computerized Patient Record query
 ;
 ; Call with LA7PTID = patient identifier, either SSN or MPI/ICN or medical record number.
 ;                     if MPI/ICN then should be full ICN (10 digit number followed by "V" and six digit checksum)
 ;                     Pass in the 2nd piece of this variable the type of identifier:
 ;                     SS = Social Security number
 ;                     PI = VA MPI Integration Control Number
 ;                     MR = medical record number of patient in file PATIENT/IHS (#9000001)
 ;                     Example: 1000720100V271387^PI
 ;                                  123456789^SS
 ;                                  123456789^MR
 ;
 ;            LA7SDT = start date of query (FileMan D/T,time optional)
 ;            LA7EDT = end date of query (FileMan D/T, time optional)
 ;                     (FileMan D/T^type of date ("CD" or "RAD")
 ;                     Both start and end date values can pass a parameter in the second piece to indicate that  the date values are for specimen collection date/time (CD) or results available date (RAD)
 ;                     Example: LA7SDT="2991001.1239^CD"
 ;                              LA7EDT="2991002.0331^CD"
 ;                              LA7SDT="3010201^RAD"
 ;                              LA7EDT="3010201^RAD"
 ;
 ;             LA7SC = Array of search codes, either NLT or LOINC (code^coding system ("NLT" or "LN");
 ;                     Example: LA7SC(1)="89628.0000^NLT"
 ;                              LA7SC(2)="84330.0000^NLT"
 ;                              LA7SC(3)="84295.0000^NLT"
 ;                              LA7SC(4)="14749-6^LN"
 ;
 ;                   = The "*" (wildcard) for any code;
 ;                     Example: LA7SC="*"
 ;
 ;                   = A list of subscripts (separated by commas) from where the results will be extracted ("CH", "MI", "SP", "EM", "CY").
 ;                     Example: LA7SC="CH,MI" (CH and MI results only)
 ;                     
 ;                     Pass in the 2nd piece of LA7SC the indicator (1) to return VUID when available.
 ;                     Example: LA7SC="*^1) or LA7SC="CH,MI^1"
 ;
 ;           LA7SPEC = array of specimen types using HL7 source table 0070 or "*" (wildcard) for any code
 ;                     Currently specimen type only supported for CH and MI subscripted tests.
 ;                     Example: LA7SPEC="*"
 ;                                or
 ;                              LA7SPEC(1)="UR"
 ;                              LA7SPEC(2)="SER"
 ;                              LA7SPEC(3)="PLAS"
 ;
 ;           LA7QERR = array (by reference) to return any errors
 ;
 ;           LA7DEST = closed root global reference to return search results (optional). If this parameter is omitted or equals an empty string, then node ^TMP("HLS",$J) is used.
 ;                     Example: LA7DEST=$NA(^TMP("ZZTMP",$J))
 ;
 ;            LA7HL7 = HL7 field separator and encoding characters (4) to use to encode results (optional).
 ;                     If undefined or incomplete (length<5) then uses field separator = "|" and encoding characters ="^\~&"
 ;
 ; Returns    LA7DEST = contains global reference of search results in HL7 message structure, usually ^TMP("HLS",$J)
 ;
 ;            LA7QERR = array (by reference) containing any errors
 ;
 N DFN,DIQUIET,LA761,LA76248,LA7CODE,LA7INTYP,LA7NLT,LA7NOMSG,LA7PTYP,LA7QUIT,LA7SCDE,LA7X,LRDFN,LRIDT,LRSS,LRSSLST
 ;
 D CLEANUP
 S U="^",DT=$$DT^XLFDT,DTIME=$$DTIME^XUP($G(DUZ))
 S GBL=$S($G(LA7DEST)'="":LA7DEST,1:"^TMP(""HLS"","_$J_")")
 K LA7QERR
 ; Prevent FileMan from issuing any unwanted WRITE(s).
 S DIQUIET=1
 ; Currently not using file #62.48 for configuration information.
 S (LA76248,LA7INTYP)=0
 ;
 ; Setup DUZ array to 'non-human' user LRLAB,HL if DUZ not valid
 ; Handle calls from non-VistA packages.
 I $G(DUZ)<1 D
 . S LA7X=$$FIND1^DIC(200,"","OX","LRLAB,HL","B","")
 . I LA7X<1 D  Q
 . D DUZ^XUP(LA7X)
 ;
 ; Identify patient, quit if error
 D PATID^LA7QRY2
 I $D(LA7QERR) Q ""
 ;
 ; Move LA7SC into local variable to check and modify if necessary.
 M LA7SCDE=LA7SC
 ;
 ; Resolve search codes to lab datanames
 S LA7SCDE=$G(LA7SCDE)
 ;
 ; Set flag to return VUID when available
 I $P(LA7SCDE,"^",2)=1 S LA7INTYP=30
 ;
 ; Parse list of subscripts if any.
 D SCLIST^LA7QRY2($P(LA7SCDE,"^"),.LRSSLST)
 Q:$D(LA7QERR) ""
 ;
 ; If passing specific subscripts but no specific search codes then use wildcard ("*") for search codes.
 I LA7SCDE'="",$P(LA7SCDE,"^")'="*",'$O(LA7SCDE(0)) S $P(LA7SCDE,"^")="*"
 I $P(LA7SCDE,"^")'="*",$O(LA7SCDE(0)) D CHKSC^LA7QRY1
 ;
 ; Convert specimen codes to file #61 Topography entries
 S LA7SPEC=$G(LA7SPEC)
 I LA7SPEC'="*"  D SPEC^LA7QRY1
 ;
 ; Search by collection or results available date
 I $P(LA7SDT,"^",2)="" S $P(LA7SDT,"^",2)="CD"
 I $P(LA7SDT,"^",2)="RAD" D BRAD^LA7QRY2
 I $P(LA7SDT,"^",2)="CD" D BCD^LA7QRY2
 ;
 I '$D(^TMP("LA7-QRY",$J)) D
 . S LA7QERR(99)="No results found for requested parameters"
 . S GBL=""
 E  S LA7NOMSG=1 D BUILDMSG^LA7QRY1
 ;
 D CLEANUP
 ;
 Q GBL
 ;
 ;
CLEANUP ; Cleanup TMP nodes that are used.
 ;
 N I
 F I="LA7-61","LA7-DN","LA7-INST-DNS","LA7-LN","LA7-NLT","LA7-QRY" K ^TMP(I,$J)
 D KVAR^LRX
 ;
 Q
