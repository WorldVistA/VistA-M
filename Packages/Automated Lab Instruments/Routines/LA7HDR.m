LA7HDR ;DALOI/JMC - LAB HDR ORU (Observation Result) message builder ;12/08/09  16:39
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**68,74**;Sep 27, 1994;Build 229
 ;
 ; Reference to variable DIQUIET supported by DBIA #2098
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 Q
 ;
 ;
QUEUE ;
 ; Called by protocol LA7 LAB RESULTS ACTION
 ; and below (APQ) for AP subscripts
 ; Call with:
 ;  LRAA   - accession area (CH,MI subscript)
 ;  LRAD   - accession date (CH,MI subscript)
 ;  LRAN   - accession number (CH,MI subscript)
 ;  LRIDT  - inverse date/time (collection date/time)
 ;  LRSS   - test subscript defined in LABORATORY TEST file (#60)
 ;  LRDFN  - IEN in LAB DATA file (#63)
 ;  LRSPEC - specimen
 ;  LRSB (Optional) - array of Chemistry results
 ;                      ex. glucose LRSB(2)=LR NODE
 ;
 ;ZEXCEPT: LRAA,LRAD,LRAN,LRDFN,LRNIFN,LRSA,LRSB,LRTMPO
 ;
 N I,LA76248,LA7V,LA7VCH,LASTYP,LAVERR,X,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 ;
 ; If no accession area then quit - not much we can do.
 I $G(LRAA)="" Q
 ;
 ; If LRSS not defined then set from file #68
 I $G(LRSS)="" N LRSS S LRSS=$P($G(^LRO(68,LRAA,0)),"^",2)
 ;
 ; Not supporting AU and BB at this time (or if LRSS is null).
 I "AUBB"[LRSS Q
 ;
 ; Check if CPRS has called us more than once for this accession.
 ; Results are processed on first call.
 I $D(LRTMPO("LRIFN")),$G(LRNIFN)>1 Q
 I LRSS="MI",$D(LRTMPO("LRIFN")),$G(^TMP("LA7HDR",$J))=(LRAA_"^"_LRAD_"^"_LRAN) K ^TMP("LA7HDR",$J) Q
 ;
 ; Quit if test patient on a production account.
 I $$TESTPAT^VADPT($P($G(^LR(LRDFN,0)),"^",3)),$$PROD^XUPROD(0) Q
 ;
 ; Check for configuration LA7HDR in 62.48 to see if turned on and site wants subscribers to receive HL7 messages for this event.
 ; Task HL7 message building and transmission.
 ; HDR-2 will be using HL7 messaging, no call to VDEF API.
 S LA76248=$O(^LAHM(62.48,"B","LA7HDR",0))
 I 'LA76248 Q
 I '$P(^LAHM(62.48,LA76248,0),"^",3) Q  ; not active
 ;
 S ZTRTN="BUILD^LA7HDR",ZTDTH=$H,ZTIO="",ZTDESC="Tasked Lab HL7 HDR ORU Build"
 F I="LRAA","LRAD","LRAN","LRIDT","LRSS","LRDFN" S ZTSAVE(I)=""
 I LRSS="CH" D
 . S LA7V=0
 . F  S LA7V=$O(LRSB(LA7V)) Q:'LA7V  D
 . . I $P(LRSB(LA7V),"^")="" Q
 . . S LA7VCH(LA7V)=LRSB(LA7V)
 . . I $D(LRSA(LA7V,2)) S LA7VCH(LA7V,1)="C"
 . S ZTSAVE("LA7VCH*")="",ZTSAVE("LRSPEC")=""
 I LRSS="CH",'$D(LA7VCH) Q
 S ZTSAVE("LA7MTYP")="ORU"
 D ^%ZTLOAD
 I $G(ZTSK)'>0 Q
 ;
 ; Set flag to handle CPRS calling us multiple times during verifying session for each ordered test.
 S ^TMP("LA7HDR",$J)=LRAA_"^"_LRAD_"^"_LRAN
 ;
 Q
 ;
 ;
APQ(LRDFN,LRSS,LRIDT) ; Anatomic Pathology (CY,EM,SP) subscript entry point from FileMan cross-reference on specific fields.
 ; Called by field #.11 in sub-files #63.02, 63.08, 63.09 - AP does not work through CPRS extended action protocols
 ;
 ; Only send file #2 patients to HDR
 I $P($G(^LR(LRDFN,0)),"^",2)'=2 Q
 ;
 D QUEUE
 Q
 ;
 ;
BUILD ; Tasked entry point to build HL7 message to VA's HDR
 ; Tasked from above.
 ;
 ;ZEXCEPT: LA7MTYP,LA7VCH,LRAA,LRAD,LRAN,LRDFN,LRIDT,LRSPEC,LRSS
 ;
 N DIQUIET,FDA,GBL,HL,HLQ,PNM,RUID,SITE
 N LA76248,LA76249,LA76249P,LA7CODE,LA7DT,LA7ERR,LA7EVNT,LA7ID,LA7INTYP,LA7LNCVR,LA7LOAD,LA7ND,LA7NOMSG,LA7NVAF,LA7RSITE,LA7X,LA7Y,LRQUIET,LRNLT,LRUID
 ;
 ; Prevent FileMan from issuing any unwanted WRITE(s).
 S (DIQUIET,LRQUIET)=1
 ; Insure DILOCKTM is defined
 D DT^DICRW
 ;
 S (LA7ERR,LA7NVAF)=0,LA7EVNT="LA7 LAB RESULTS AVAILABLE (EVN)"
 ; Create 62.49 entry but don't store message text.
 S LA7NOMSG=2
 ;
 I $G(LA7MTYP)="" S LA7MTYP="ORU"
 ;
 S LA7X=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3))
 S LRUID=$P(LA7X,"^"),RUID=$P(LA7X,"^",5)
 I LRUID="" S LRUID=$$LRUID^LRX(LRAA,LRAD,LRAN)
 ;
 S (LA7RSITE,SITE)="LA7HDR",LA7ID=LA7RSITE_"-O-",LA76248=$O(^LAHM(62.48,"B",LA7RSITE,0))
 ; No entry in 62.48 - *** Need to add error logging ****
 I 'LA76248 Q
 I '$P(^LAHM(62.48,LA76248,0),"^",3) Q  ; not active
 S LA7INTYP=+$P(^LAHM(62.48,LA76248,0),"^",9)
 ;
 ; Determine if patient needs to have initial load sent to HDR.
 ; *** need to establish location of HDR flag in 63***
 S LA7LOAD=0
 ;
 ; Create new outgoing entry in 62.49
 S (LA76249,LA76249P)=$$INIT6249^LA7VHLU
 I LA76249<1 D  Q
 . ; Log entry creation error
 ;
 ; Lock record while building message.
 F  L +^LR(LRDFN,LRSS,LRIDT,0):DILOCKTM Q:$T  H 5
 ;
 K ^TMP("LA7-QRY",$J)
 ;
 ; Check "CH" test results for ordered tests.
 ; Per Change Control Board decision to perform lab test's result aggregation on VistA -
 ;   - besides test verified during this session include all other test results stored with this specimen.
 I LRSS="CH" D
 . N FDA,FDAIEN,LA7ER,LA7VT,LRSB
 . S LA7Y=1
 . F  S LA7Y=$O(^LR(LRDFN,LRSS,LRIDT,LA7Y)) Q:'LA7Y  D
 . . I '$D(LA7VCH(LA7Y)) S LA7VCH(LA7Y)=^LR(LRDFN,LRSS,LRIDT,LA7Y)
 . . I $P(LA7VCH(LA7Y),"^")="" Q
 . . S LA7CODE=$$DEFCODE^LA7VHLU5(LRSS,LA7Y,$P(LA7VCH(LA7Y),"^",3),LRSPEC)
 . . S LRSB=LA7Y S:$G(LA7VCH(LA7Y,1))="C" $P(LRSB,"^",2)="C"
 . . D STORE^LA7QRY2
 . . K FDA,FDAIEN,LA7ER
 . . S FDA(2,62.49162,"+2,"_LA76249_",",.01)=LRSB
 . . I $G(LA7VCH(LA7Y,1))="C" S FDA(2,62.49162,"+2,"_LA76249_",",.02)="C"
 . . S FDAIEN(1)=LA76249
 . . D UPDATE^DIE("","FDA(2)","FDAIEN","LA7ER(2)")
 . . D CLEAN^DILF
 ;
 I "CYEMSP"[LRSS D
 . S LRSB=.012,LA7CODE=$$DEFCODE^LA7VHLU5(LRSS,LRSB,"","")
 . D STORE^LA7QRY2
 ;
 I LRSS="MI" D
 . S LRSPEC=$P(^LR(LRDFN,LRSS,LRIDT,0),"^",5)
 . S LA7ND=0
 . F LA7ND=1,5,8,11,16 I $D(^LR(LRDFN,LRSS,LRIDT,LA7ND)) D
 . . I $P(^LR(LRDFN,LRSS,LRIDT,LA7ND),"^",2)="" Q  ; If no status -  skip
 . . I $D(^TMP("LA7-QRY",$J,LRDFN,LRIDT,LRSS)) Q  ; Already marked this report to send
 . . S LRSB=$S(LA7ND=1:11,LA7ND=5:14,LA7ND=8:18,LA7ND=11:22,LA7ND=16:33,1:11)
 . . S LA7CODE=$$DEFCODE^LA7VHLU5(LRSS,LRSB,"",LRSPEC)
 . . D STORE^LA7QRY2
 ;
 S GBL="^TMP(""HLS"","_$J_")"
 D STARTMSG^LA7VHLU(LA7EVNT,.LA76249,LA7NOMSG)
 I $G(HL) S LA7ERR=$TR(HL,"^","-")
 S (HLQ,HL("Q"))=""
 D CHKACC^LA7VMSG
 I 'LA7ERR D
 . I LA7LOAD D
 . . N LA7EDT,LA7SC,LA7SDT,LA7SPEC,LRIDT,LRSS,LRUID
 . . S (LA7SC,LA7SPEC)="*",LA7SDT=$$FMADD^XLFDT(DT,-730,0,0,0),LA7EDT=DT
 . . D BCD^LA7QRY2
 . D BUILDMSG^LA7QRY1
 . D SENDMSG^LA7VMSG1
 S LA7ID=LA7RSITE_"-O-"
 D SETID^LA7VHLU1(LA76249,LA7ID,LRUID,1)
 D SETID^LA7VHLU1(LA76249,"",LRUID,0)
 I $G(PNM)="" D DEM^LRX
 I PNM'="" D
 . D SETID^LA7VHLU1(LA76249,LA7ID,PNM,0)
 . D SETID^LA7VHLU1(LA76249,"",PNM,0)
 D UPDT6249^LA7VORM1
 ;
 ; File additional data
 S FDA(1,62.49,LA76249_",",151)=LRUID
 S FDA(1,62.49,LA76249_",",156)=LRIDT
 S FDA(1,62.49,LA76249_",",157)=LRSS
 S FDA(1,62.49,LA76249_",",158)=LRDFN
 D FILE^DIE("","FDA(1)","LA7ERR(1)")
 D CLEAN^DILF
 ;
 ; Release locks on entries.
 L -^LAHM(62.49,LA76249)
 L -^LR(LRDFN,LRSS,LRIDT,0)
 ;
 ; Cleanup
 K LA7ND,LRUID,LRNLT,LRIDT,LRSS,LRDFN,LA7VCH,LA7MTYP
 D EXIT^LA7HDR1
 Q
 ;
 ;
RTR(LA7SS) ;
 ; Call with LA7SS = list of subscripts that HDR wants separated by ";"
 ;                   (LA7SS="CH;MI;EM")
 ;
 ; Setup link and subscriber array for HL7 HDR message generation
 ; Determine if HDR wants to receive lab results for this subscript
 ; Called by subscriber router protocol LA7 LAB RESULTS TO HDR (SUB)
 ; Check outgoing message and find OBR segment to determine Laboratory
 ;  subscript this result is associated with and if it's contained in
 ;  the LA7SS subscript list.
 ;
 ;ZEXCEPT: HL,HLL,HLNEXT,HLNODE
 ;
 N LA7I,LA7SEG,LA7VI,LA7VJ,LA7X,LRSS,LRX
 ;
 S LRSS=""
 F LA7VI=1:1 X HLNEXT Q:HLQUIT'>0  D  Q:LRSS'=""
 . I $E(HLNODE,1,3)'="OBR" Q
 . S LA7SEG(0)=HLNODE
 . S LA7VJ=0
 . F  S LA7VJ=$O(HLNODE(LA7VJ)) Q:'LA7VJ  S LA7SEG(LA7VJ)=HLNODE(LA7VJ)
 . S LRX=$$P^LA7VHLU(.LA7SEG,21,HL("FS")),LRX=$$UNESC^LA7VHLU3(LRX,HL("FS")_HL("ECH"))
 . S LRSS=$P(LRX,"^",2)
 ;
 F LA7I=1:1 S LA7X=$P(LA7SS,";",LA7I) Q:LA7X=""  D  Q:LA7X=""
 . I LA7X=LRSS S HLL("LINKS",1)="LA7 LAB RESULTS TO HDR (SUB)^VDEFVIE4",LA7X=""
 Q
 ;
 ;
HDRLOAD(LA7SDT,LA7EDT,LA7LIMIT,LA7EVENT) ; Load patient's historical lab results to HDR (Health Data Repository).
 ; Call with LA7SDT = start date of data extraction in FileMan format
 ;           LA7EDT = end date of data extraction in FileMan format
 ;         LA7LIMIT = # of messages to create this session (default =1000)
 ;         LA7EVENT = name of HL7 event protocol to transmit messages
 ;
 D HDRLOAD^LA7HDR1
 Q
 ;
 ;
RECOVER ; Recover failed transmissions or message building
 ; Called by option Recover/Transmit Lab HDR Result Messages [LA7 HDR RECOVER]
 ;
 D RECOVER^LA7HDR1
 Q
