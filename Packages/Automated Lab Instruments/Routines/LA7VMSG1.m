LA7VMSG1 ;DALOI/JMC - LAB ORU (Observation Result) message builder cont'd ;Aug 8, 2008
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**56,46,61,64,68,74**;Sep 27, 1994;Build 229
 ;
START ; Process entries in queue
 ; Called from LA7VMSG
 ;
 N EID,GBL,HLEID,HLMTIEN,HLRESLT,HLARYTYP,HLECH,HLFS,HLCOMP,HLFORMAT,RSITE
 N LA,LA76248,LA76249,LA76249P,LA7DT,LA7ECH,LA7END,LA7FS,LA7ID,LA7MID,LA7NVAF,LA7ROOT,LA7V,LA7VS,LA7VER,LA7V0N,LA7VIEN,LA7X
 N LAER,LRDFN,LRIDT,LRNT,LRSS,LRUID
 ;
 ; variable list
 ; LA("LRUID") - Host Unique ID from the local ACCESSION file (#68)
 ; LA("SITE")  - Primary site number of remote site ($$SITE^VASITE)
 ; LA("RUID")  - Remote sites Unique ID from ACCESSION file (#68)
 ; LA("ORD")   - Free text ordered test name from WKLD CODE file (#64)
 ; LA("LRNLT") - National Laboratory test code from WKLD CODE file (#64)
 ; LA("LRIDT") - Inverse date/time (accession date/time)
 ; LA("LRSS")  - test subscript defined in LABORATORY TEST file (#60)
 ; LA("LRDFN") - IEN in LAB DATA file (#63)
 ; LA("ORDT")  - Order date
 ; LA(62.49)   - entry in #62.49 which contains pointer to results to build
 ;
 D LOCK^DILF("^LAHM(62.49,""HL7 PROCESS"",LA7MTYP)")
 I '$T Q
 ;
 S GBL="^TMP(""HLS"","_$J_")"
 ;
 D SORTPAT
 I $D(^TMP("LA76248",$J)) D PROCESS
 D KVAR^LRX
 ;
 ; Release lock
 L -^LAHM(62.49,"HL7 PROCESS",LA7MTYP)
 ;
 K ^TMP("LA76248",$J),^TMP("LA7VS",$J),^TMP("HLS",$J)
 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
 Q
 ;
 ;
SORTPAT ; Sort all results for transmission
 ;
 N LA76248,LA76249,LA7END,LA7ROOT,LRDFN,LRUID
 ;
 K ^TMP("LA76248",$J)
 ; Flag to indicate end of global.
 S LA7END=0
 ;
 ; Sort by configuration (LA76248), patient (LRDFN), UID (LRUID), file #62.49 ien (LA76249)
 ; Check status of each message to insure that cross-reference is not an orphan which can cause
 ; repetitive message generation and receving problems.
 S LA7ROOT="^LAHM(62.49,""AC"",LA7MTYP,""P"")"
 F  S LA7ROOT=$Q(@LA7ROOT) Q:LA7END  D
 . I $QS(LA7ROOT,3)'=LA7MTYP!($QS(LA7ROOT,6)<1) S LA7END=1 Q
 . S LA76248=$QS(LA7ROOT,5),LA76249=$QS(LA7ROOT,6)
 . D LOCK^DILF("^LAHM(62.49,LA76249)") Q:'$T
 . I $P($G(^LAHM(62.49,LA76249,0)),"^",3)'="P" K ^LAHM(62.49,"AC",LA7MTYP,"P",LA76248,LA76249) L -^LAHM(62.49,LA76249) Q
 . S LRDFN=$P($G(^LAHM(62.49,LA76249,63)),"^",8)
 . S LRUID=$P($G(^LAHM(62.49,LA76249,63)),"^",1)
 . I LRDFN,LRUID'="" S ^TMP("LA76248",$J,LA76248,LRDFN,LRUID,LA76249)=""
 . L -^LAHM(62.49,LA76249)
 ;
 Q
 ;
 ;
PROCESS ; Process and build messages to be sent
 ;
 N LA7101,LA76248,LA76249,LA76249P,LA7INTYP,LA7NTESN,LA7OBRSN,LA7OBXSN,LA7PIDSN,LA7SMSG,LA7VS,LRDFN
 ;
 ; Cleanup
 K ^TMP("LA7VS",$J),^TMP("HLS",$J)
 ; Initialize variables
 S (LA76248,LA76249,LA76249P,LA7END,LRDFN)=0,LRUID=""
 ;
 ; Process sorted list of results to transmit.
 S LA7ROOT="^TMP(""LA76248"",$J)"
 F  S LA7ROOT=$Q(@LA7ROOT) Q:LA7ROOT=""  D  Q:LA7END
 . I $QS(LA7ROOT,1)'="LA76248"!($QS(LA7ROOT,2)'=$J) S LA7END=1 Q
 . I LA76248'=$QS(LA7ROOT,3) D CONFIG
 . I '$P(LA76248(0),"^",3) Q
 . S LA7INTYP=+$P(LA76248(0),"^",9)
 . S (LA76249,LA(62.49))=$QS(LA7ROOT,6)
 . S LA7X=$G(^LAHM(62.49,LA76249,63))
 . S LA("HUID")=$P(LA7X,U),LA("SITE")=$P(LA7X,U,2),LA("RUID")=$P(LA7X,U,3),LA("ORD")=$P(LA7X,U,4),LA("NLT")=$P(LA7X,U,5),LA("LRIDT")=$P(LA7X,U,6),LA("SUB")=$P(LA7X,U,7),LA("LRDFN")=$P(LA7X,U,8),LA("ORDT")=$P(LA7X,U,9)
 . S LA7NVAF=$$NVAF^LA7VHLU2(+LA("SITE"))
 . I LRUID'=$QS(LA7ROOT,5),LA7SMSG=2 D PAT Q:LA7END
 . I LRDFN'=$QS(LA7ROOT,4) D PAT Q:LA7END
 . S LRUID=$QS(LA7ROOT,5)
 . S ^TMP("LA7VS",$J,LA76249)=LA76249P
 . N LA76249
 . S LA76249=LA76249P
 . I LA7MTYP="ORU" D EN^LA7VORU(.LA)
 . I LA7MTYP="ORR" D EN^LA7VORR1(.LA)
 ;
 I LA76249P D SENDMSG
 ;
 Q
 ;
 ;
STARTMSG ; Initialize a HL7 message and variables
 ;
 N LA7EVNT,SITE
 ;
 K ^TMP("LA7VS",$J),@GBL
 ;
 S LA76249P=LA76249
 S SITE=$$RETFACID^LA7VHLU2(LA("SITE"),2,1)
 ;
 I LA7MTYP="ORU" S LA7EVNT="LA7V Results Reporting to "_SITE
 I LA7MTYP="ORR" S LA7EVNT="LA7V Order Response to "_SITE
 D STARTMSG^LA7VHLU(LA7EVNT,LA76249P)
 I $G(HL) S LA7END=1
  ;
 Q
 ;
 ;
SENDMSG ; File HL7 message with HL and LAB packages
 ;
 ; No data to send
 I '$D(^TMP("HLS",$J)) Q
 ;
 D GEN^LA7VHLU
 I $P(LA7MID,U)=0 D
 . N LA7X
 . S LA7X(1)=LA76249P,LA7X(2)=$TR($P(HLMID,"^",2,3),"^","-")
 . D CREATE^LA7LOG(28)
 ;
 D UPDT6249
 D UPDLPD
 ;
 S (LA76249P,LA7PIDSN,LA7OBRSN,LA7OBXSN,LA7NTESN)=0
 ;
 Q
 ;
 ;
CONFIG ; Setup for this configuration
 ;
 ; Send a building message
 I LA76249P D SENDMSG
 ;
 ; Retrieve configuration information from #62.48
 S LA76248=$QS(LA7ROOT,3)
 S LA76248(0)=$G(^LAHM(62.48,LA76248,0))
 ;
 ; Flag to control message building; 1-one patient/msg, 2-one order/msg
 S LA7SMSG=+$P(LA76248(0),"^",8)
 ;
 ; Initialize variables
 S (LA76249,LA76249P,LRDFN)=0
 S LRUID="",LA7ID=$P(LA76248(0),"^")_"-O-"
 ;
 Q
 ;
 ;
PAT ; Build patient information
 ;
 N LA7ALTID,LA7EXTID,LA7PID,LA7PV1
 ;
 ; If one patient/msg or one order/msg and message building then send it.
 I LA7SMSG>0,LA76249P D SENDMSG
 ;
 ; If no message building then start one.
 I 'LA76249P S LA7PIDSN=0 D STARTMSG Q:LA7END
 ;
 ; Setup PID and PV1 segments.
 S LRDFN=$QS(LA7ROOT,4)
 S LRDPF=$P(^LR(LRDFN,0),"^",2),DFN=$P(^(0),"^",3)
 D DEM^LRX
 I $G(PNM)'="" D
 . D SETID^LA7VHLU1(LA76249,LA7ID,PNM,0)
 . D SETID^LA7VHLU1(LA76249,"",PNM,0)
 I $G(SSN)'="" D
 . D SETID^LA7VHLU1(LA76249,LA7ID,SSN,0)
 . D SETID^LA7VHLU1(LA76249,"",SSN,0)
 ;
 ; Send placer's patient id (PID-3), return in PID-2, return PID-4 with alternate id
 S (LA7ALTID,LA7EXTID)=""
 D PTEXTID^LA7VHLU(LA("SITE"),LA("RUID"),.LA7EXTID)
 I $G(LA7EXTID("PID-2"))'="" S LA7EXTID=$$CNVFLD^LA7VHLU3(LA7EXTID("PID-2"),LA7EXTID("ECH"),LA7ECH)
 I $G(LA7EXTID("PID-4"))'="" S LA7ALTID=$$CNVFLD^LA7VHLU3(LA7EXTID("PID-4"),LA7EXTID("ECH"),LA7ECH)
 ;
 ; Build PID segment
 D PID^LA7VPID(LRDFN,LA7EXTID,.LA7PID,.LA7PIDSN,.HL,LA7ALTID)
 D FILESEG^LA7VHLU(GBL,.LA7PID)
 D FILE6249^LA7VHLU(LA76249P,.LA7PID)
 ;
 ; Build PV1 segment
 ; Not built when sending to DoD facility - not used by CHCS
 I LA7NVAF'=1 D
 . D PV1^LA7VPID(LRDFN,.LA7PV1,LA7FS,LA7ECH)
 . D FILESEG^LA7VHLU(GBL,.LA7PV1)
 . D FILE6249^LA7VHLU(LA76249P,.LA7PV1)
 ;
 S LRUID="",(LA7OBRSN,LA7OBXSN,LA7NTESN)=0
 ;
 Q
 ;
 ;
UPDT6249 ; Update entries in file #62.49
 ;
 N LA7ERR,LA76249,LA76249P
 ;
 ; UNDEF HL array will cause HL7 filers to stop. The $G(HL(x)) prevents the filers from halting on UNDEF error but we
 ; want to log the missing HL array as an error for system monitoring/troubleshooting.
 I $D(HL)<10 D ^%ZTER
 ;
 S LA76249=0
 F  S LA76249=$O(^TMP("LA7VS",$J,LA76249)) Q:'LA76249  D
 . N FDA,LA7ERR
 . S LA76249P=+$G(^TMP("LA7VS",$J,LA76249))
 . ; Set pointer to parent on child entry.
 . I LA76249'=LA76249P S FDA(1,62.49,LA76249_",",6)=LA76249P
 . I $P(^LAHM(62.49,LA76249,0),"^",3)'="E" D
 . . I $G(HL("APAT"))="AL"!($G(HL("APAT"))="") S FDA(1,62.49,LA76249_",",2)="A"
 . . E  S FDA(1,62.49,LA76249_",",2)="X"
 . S FDA(1,62.49,LA76249_",",102)=$G(HL("SAN"))
 . S FDA(1,62.49,LA76249_",",103)=$G(HL("SAF"))
 . S FDA(1,62.49,LA76249_",",108)=$G(HL("MTN"))
 . S FDA(1,62.49,LA76249_",",110)=$G(HL("PID"))
 . S FDA(1,62.49,LA76249_",",111)=$G(HL("VER"))
 . I $P($G(LA7MID),"^")'="" S FDA(1,62.49,LA76249_",",109)=$P(LA7MID,"^")
 . I $P($G(LA7MID),"^",2) D
 . . S FDA(1,62.49,LA76249_",",160)=$P(LA7MID,"^",2)
 . . S FDA(1,62.49,LA76249_",",161)=$P(LA7MID,"^",3)
 . D FILE^DIE("","FDA(1)","LA7ERR(1)")
 . D CLEAN^DILF
 . D UPID^LA7VHLU1(LA76249)
 ;
 Q
 ;
 ;
UPDLPD ; Update lab pending orders (#69.6) for each entry in #62.49
 ;
 N LA76249
 ;
 S LA76249=0
 F  S LA76249=$O(^TMP("LA7VS",$J,LA76249)) Q:'LA76249  D UPD696
 Q
 ;
 ;
UPD696 ; Update LAB PENDING ORDERS file #69.6
 ;
 N LA74,LA7696,LA76964,LA7ERR,LA7ORDT,LA7STAT,LA7X
 ;
 ; Find "Results Available" status in #64.061
 S LA7STAT=$$FIND1^DIC(64.061,"","OMX","Results Available","","I $P(^LAB(64.061,Y,0),U,7)=""U""")
 ;
 S LA7X=$G(^LAHM(62.49,LA76249,63))
 ;
 ; Ordering institution - pointer to file #4
 S LA74=$P(LA7X,"^",2)
 I LA74="" Q
 ;
 ; Ordered test
 S LA7ORDT=$P(LA7X,"^",4)
 I LA7ORDT="" Q
 ;
 ; File #69.6 ien and ordered test multiple ien
 S LA7696=0
 F  S LA7696=$O(^LRO(69.6,"RST",LA74,LA("RUID"),LA7696)) Q:'LA7696  D
 . N FDA
 . S LA76964=$O(^LRO(69.6,LA7696,2,"B",LA7ORDT,0))
 . I LA76964<1 Q
 . ;
 . D LOCK^DILF("^LRO(69.6,LA7696)")
 . ; Cannot get lock on ENTRY in 69.6
 . I '$T D CREATE^LA7LOG(33) Q
 . ;
 . ; Store outgoing HL7 message ID
 . S FDA(1,69.64,LA76964_","_LA7696_",",7)=$P(LA7MID,U)
 . ; Set to Results Available.
 . S FDA(1,69.64,LA76964_","_LA7696_",",5)=LA7STAT
 . D FILE^DIE("","FDA(1)","LA7ERR(1)")
 . D CLEAN^DILF
 . ;
 . L -^LRO(69.6,LA7696)
 ;
 Q
