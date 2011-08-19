LA7QRY1 ;DALOI/JMC - Lab HL7 Query Utility ;June 23, 2008
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,61,68**;Sep 27, 1994;Build 56
 ;
 ; Reference to ADM^VADPT2 supported by DBIA #325
 ; Reference to BLDPID^VAFCQRY supported by DBIA #3630
 Q
 ;
CHKSC ; Check search NLT/LOINC codes
 ;
 N J
 ;
 S J=0
 F  S J=$O(LA7SCDE(J)) Q:'J  D
 . N X
 . S X=LA7SCDE(J)
 . I $P(X,"^",2)="NLT",$D(^LAM("E",$P(X,"^"))) D  Q
 . . S ^TMP("LA7-NLT",$J,$P(X,"^"))=""
 . I $P(X,"^",2)="LN",$D(^LAB(95.3,$P($P(X,"^"),"-"))) D  Q
 . . S ^TMP("LA7-LN",$J,$P($P(X,"^"),"-"))=""
 . S LA7QERR(6)="Unknown search code "_$P(X,"^")_" passed"
 . K LA7SCDE(J)
 Q
 ;
 ;
SPEC ; Convert HL7 Specimen Codes to File #61, Topography codes
 ; Find all topographies that use this HL7 specimen code
 N J,K,L
 ;
 S J=0
 F  S J=$O(LA7SPEC(J)) Q:'J  D
 . S K=LA7SPEC(J),L=0
 . F  S L=$O(^LAB(61,"HL7",K,L)) Q:'L  S ^TMP("LA7-61",$J,L)=""
 Q
 ;
 ;
BUILDMSG ; Build HL7 message with result of query
 ;
 I $G(LA7NOMSG)=1 N HL,HLECH,HLFS,HLQ,LA7ECH,LA7FS,LA7MSH
 N LA,LA763,LA7ID,LA7NTESN,LA7NVAF,LA7OBRSN,LA7OBXSN,LA7PIDSN,LA7QUIT,LA7ROOT,LA7X,LRIDT,LRPOC,LRSS,X
 ;
 ; Create dummy MSH to pass HL7 delimiters
 I $G(LA7NOMSG)=1 D
 . I $L($G(LA7HL7))'=5 S LA7HL7="|^\~&"
 . S (HL("FS"),HLFS,LA7FS)=$E(LA7HL7),(HL("ECH"),HLECH,LA7ECH)=$E(LA7HL7,2,5)
 . S (HLQ,HL("Q"))=""
 . S LA7MSH(0)="MSH"_LA7FS_LA7ECH_LA7FS
 . S $P(LA7MSH(0),LA7FS,7)=$$FMTHL7^XLFDT($$NOW^XLFDT)_LA7FS
 . D FILESEG^LA7VHLU(GBL,.LA7MSH)
 ;
 F X="AUTO-INST","LRDFN","LRIDT","SUB","HUID","NLT","RUID","SITE" S LA(X)=""
 ;
 ; Find POC user to identify those specimens that are POC.
 S LRPOC=$$FIND1^DIC(200,"","OX","LRLAB,POC","B","")
 ;
 ; Take search results and put in HL7 message structure
 S LA7ROOT="^TMP(""LA7-QRY"",$J)",(LA7QUIT,LA7PIDSN)=0,LA7ID="LA7QRY-O-"
 F  S LA7ROOT=$Q(@LA7ROOT) Q:LA7ROOT=""  D  Q:LA7QUIT
 . I $QS(LA7ROOT,1)'="LA7-QRY"!($QS(LA7ROOT,2)'=$J) S LA7QUIT=1 Q
 . I LA("LRDFN")'=$QS(LA7ROOT,3) D PAT
 . I LA("LRIDT")'=$QS(LA7ROOT,4) D
 . . I $G(LA7INTYP)=30,$G(LA7OBRSN) D PAT
 . . D ORC
 . I LA("SUB")'=$QS(LA7ROOT,5) D
 . . I $G(LA7INTYP)=30,$G(LA7OBRSN) D PAT
 . . D ORC
 . I LA("NLT")'=$P($QS(LA7ROOT,6),"!") D ORC
 . D OBX
 ;
 Q
 ;
 ;
PAT ; Build PID/PV1 segments
 ;
 N I,LA7,LA7ERR,LA7PID,LA7PV1,VADMVT,VAINDT
 ;
 S (LA("LRDFN"),LRDFN)=$QS(LA7ROOT,3)
 S LRDPF=$P(^LR(LRDFN,0),"^",2),DFN=$P(^(0),"^",3)
 D DEM^LRX
 ;
 ; Build PID segment
 S LA7PIDSN=LA7PIDSN+1
 ;
 ; Check if this field has been built previously for this patient
 ; Save this field to TMP global to use for subsequent calls.
 I $D(^TMP($J,"LA7VHLU","PID",DFN,LA7FS_LA7ECH)) D
 . M LA7PID=^TMP($J,"LA7VHLU","PID",DFN,LA7FS_LA7ECH)
 . S $P(LA7PID(0),LA7FS,2)=LA7PIDSN
 E  D
 . D BLDPID^VAFCQRY(DFN,LA7PIDSN,"ALL",.LA7,.HL,.LA7ERR)
 . S I=0
 . F  S I=$O(LA7(I)) Q:'I  S LA7PID(I-1)=LA7(I)
 . M ^TMP($J,"LA7VHLU","PID",DFN,LA7FS_LA7ECH)=LA7PID
 ;
 D FILESEG^LA7VHLU(GBL,.LA7PID)
 I '$G(LA7NOMSG),$G(LA76249) D FILE6249^LA7VHLU(LA76249,.LA7PID)
 ;
 ; Build PV1 segment if building message for HDR and other subscribers
 I $G(LA7INTYP)=30 D PV1
 ;
 S (LA7OBRSN,LA7OBXSN,LA7NTESN)=0,(LA("LRIDT"),LA("SUB"))=""
 Q
 ;
 ;
ORC ; Build ORC segment
 ;
 N LA764,LA7NLT,LRNMSP,X
 ;
 S (LA("LRIDT"),LRIDT)=$QS(LA7ROOT,4),(LA("SUB"),LRSS)=$QS(LA7ROOT,5)
 S LA763(0)=$G(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),0))
 S X=$G(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),"ORU"))
 S LA("HUID")=$P(X,"^"),LRNMSP="LR"
 I LA("HUID")="" S LA("HUID")=$P(LA763(0),"^",6)
 S LA("HUID","NMSP")=LRNMSP
 I "CHMI"[LA("SUB") S LA("HUID","SITE")=$P(LA763(0),"^",14)
 E  S LA("HUID","SITE")=""
 ;
 S LA("RUID")=$P(X,"^",5),LRNMSP="LR"
 I LRPOC,LRPOC=$P(X,"^",4) S LRNMSP="LRPOC"
 S LA("RUID","NMSP")=LRNMSP
 S LA("RUID","SITE")=$P(X,"^",3)
 I LA("RUID")="" D
 . S LA("RUID")=LA("HUID")
 . S LA("RUID","NMSP")=LA("HUID","NMSP")
 . S LA("RUID","SITE")=LA("HUID","SITE")
 ;
 S LA("SITE")=$P(X,"^",2)
 S LA7NVAF=$$NVAF^LA7VHLU2(0),LA7NTESN=0
 ;
 S (LA("NLT"),LA7NLT)=$P($QS(LA7ROOT,6),"!"),(LA764,LA("ORD"))=""
 I LA7NLT'="" D
 . S LA764=+$O(^LAM("E",LA7NLT,0))
 . I LA764 S LA("ORD")=$$GET1^DIQ(64,LA764_",",.01)
 ;
 D ORC^LA7VORU,OBR
 ;
 Q
 ;
 ;
OBR ; Build OBR segment
 ;
 N LA7RS
 ;
 I LA("SUB")="CH" D
 . D OBR^LA7VORU
 . D NTE^LA7VORU
 . S LA7OBXSN=0
 ;
 Q
 ;
 ;
OBX ; Build OBX segment
 ;
 N LA7DATA,LA7VT
 ;
 S LA7NTESN=0
 I LA("SUB")="MI" D MI^LA7VORU1 Q
 I "CYEMSP"[LA("SUB") D AP^LA7VORU2 Q
 ;
 S LA7VT=$QS(LA7ROOT,7)
 D OBX^LA7VOBX(LA("LRDFN"),LA("SUB"),LA("LRIDT"),LA7VT,.LA7DATA,.LA7OBXSN,LA7FS,LA7ECH)
 I '$D(LA7DATA) Q
 D FILESEG^LA7VHLU(GBL,.LA7DATA)
 I '$G(LA7NOMSG),$G(LA76249) D FILE6249^LA7VHLU(LA76249,.LA7DATA)
 ; Send any test interpretation from file #60
 D INTRP^LA7VORUA
 ;
 ; Mark result as sent - set to 1, if corrected results set to 2
 I LA("SUB")="CH" D
 . I $P(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),$P(LA7VT,"^")),"^",10)>1 Q
 . S $P(^LR(LA("LRDFN"),LA("SUB"),LA("LRIDT"),$P(LA7VT,"^")),"^",10)=$S($P(LA7VT,"^",2)="C":2,1:1)
 ;
 Q
 ;
 ;
PV1 ; Build PV1 segment for HDR
 N LA7DT,LA7PCE,LA7SDENC,LRDX,LRIDT,LRSS,LRUID,VADMVT,VAINDT
 S LRIDT=$QS(LA7ROOT,4),LRSS=$QS(LA7ROOT,5),LA7DT=0
 I LRIDT,LRSS'="" S LA7DT=$P($G(^LR(LRDFN,LRSS,LRIDT,0)),"^")
 I 'LA7DT Q
 ;
 S LRDX=""
 ; Determine if an inpatient at time of specimen and build inpatient PV1.
 S VAINDT=LA7DT D ADM^VADPT2
 I VADMVT S LA7PV1(0)=$$IN^VAFHLPV1(DFN,LA7DT,",3,6,7,10,18,21,36,39,44,45,",VADMVT,"",1,LRDX)
 ;
 ; If not an inpatient then build outpatient PV1.
 I 'VADMVT D
 . N LA7VPTR
 . S LA7PCE=$$PCENC^LA7VHLU3(LRDFN,LRSS,LRIDT),LA7VPTR=""
 . I LA7PCE'="" D
 . . S LA7SDENC=$$SDENC^LA7VHLU3(LA7PCE)
 . . I LA7SDENC'="" S LA7VPTR=LA7SDENC_";SCE("
 . I LA7VPTR="" S LA7VPTR=DFN_";DPT("
 . S LA7PV1(0)=$$OUT^VAFHLPV1(DFN,"",LA7DT,LA7VPTR,"A",1)
 ;
 D FILESEG^LA7VHLU(GBL,.LA7PV1)
 I '$G(LA7NOMSG),$G(LA76249) D FILE6249^LA7VHLU(LA76249,.LA7PV1)
 Q
