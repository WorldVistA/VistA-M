IVMPTRN7 ;ALB/KCL/CJM/PHH/BAJ,TDM - HL7 FULL DATA TRANSMISSION (Z07) BUILDER ; 8/15/08 10:30am
 ;;2.0;INCOME VERIFICATION MATCH;**9,11,24,34,74,88,105,115,142**;OCT 21, 1994;Build 3
 ;
 ;
FULL(DFN,IVMMTDT,EVENTS,IVMCT,IVMGTOT,IVMFLL,IVMNOMSH,IVMREC,IVMQUERY) ;
 ;Description: This entry point will be used to create an HL7 "Full Data Transmission" message for a patient.   Transmission of these messages will be in a batch of 1-100 individual HL7 messages.
 ;
 ;Input:
 ;  DFN - Patient IEN
 ;  IVMMTDT - date of the patient's Means Test or Copay Test
 ;  EVENTS () - an array of reasons for transmission, pass by reference.
 ;  EVENTS("IVM") = 1 if transmission due to IVM criteria, 0 otherwise
 ;  EVENTS(" "DCD")=1 if transmission due to DCD criteria, 0 otherwise
 ;  EVENTS("ENROLL")=1 if transmission due to enrollment criteria, 0 otherwise
 ;  IVMCT - count of segments transmitted, pass by reference
 ;  IVMGTOT - count of batchs transmitted, pass by reference
 ;  IVMFLL - (optional), flag for creating MSA, QRD segments for FULL query transmission, $G(IVMFLL) means yes
 ;  IVMNOMSH - (optional), if IVMNOMSH=1, means the MSH segment should not be built
 ;  IVMREC - (optional), if $G(IVMFLL), then this variable will contain the internal entry number of Query Income Year #301.9001 mult.
 ;  IVMQUERY - array passed in by reference where
 ;    IVMQUERY("LTD") -- # of the QUERY that is currently open or
 ;                undefined, zero, or null if no QUERY opened for
 ;                last treatment date
 ;    IVMQUERY("OVIS") -- # of the QUERY that is currently open or
 ;                undefined, zero, or null if no QUERY opened for
 ;                finding outpatient visits
 ;
 ;HL7 variables as defined by call to INIT^IVMUFNC:
 ;  HLEVN - HL7 message event counter 
 ;  HLSDT - a flag that indicates that the data to be sent is stored in the ^TMP("HLS") global array.
 ;
 ;The following variables returned by the INIT^HLTRANS entry point:
 ;  HLNDAP - Non-DHCP Application Pointer from file 770
 ;  HLNDAP0 - Zero node from file 770 corresponding to HLNDAP
 ;  HLDAP - DHCP Application Pointer from file 771
 ;  HLDAN - The DHCP Application Name (.01 field, file 771) for HLDAP
 ;  HLPID - HL7 processing ID from file 770
 ;  HLVER - HL7 version number from file 770
 ;  HLFS - HL7 Field Separater from the 'FS' node of file 771
 ;  HLECH - HL7 Encoding Characters from the 'EC' node of file 771
 ;  HLQ - Double quotes ("") for use in building HL7 segments
 ;  HLERR - if an error is encountered, an error message is returned in the HLERR variable.
 ;  HLDA - the internal entry number for the entry created in file 772
 ;
 ;  HLDT - the transmission date/time (associated with the entry in in file 772 identified by HLDA) in internal VA FileMan format.
 ;  HLDT1 - the same transmission date/time as the HLDT variable, only in HL7 format.
 ;
 ;Output:
 ;  ^TMP("HLS",$J,IVMCT) - global array containing all segments of the HL7 message that the VistA application wishes to send.  The HLSDT variable is defined above and the IVMCT variable is a sequential number starting at 1.
 ;
 N DGREL,DGINC,DR,I,IVMI,IVMDFN,IVMHLMID,IVMNTE,IVMPAT,IVMQRD,X,IVMCNTID
 ;
 ; IVM*2.0*142  Quit if test patient unless ^XTMP("IVMTST","Z07",DFN) set and user wishes test patient to send a Z07 for testing purpose.
 I $$TESTPAT^VADPT(DFN) Q:'$D(^XTMP("IVMTST","Z07",DFN))
 ; IVM*2.0*105 BAJ 10/20/2005
 ; Do Z07 Consistency checks and, if fail, prevent Z07 Build
 I '$$EN^IVMZ07C(DFN) Q
 ;
 ; INITIALIZE HL7 1.6 VARIABLES
 D INIT^HLFNC2(HLEID,.HL)
 ;
 ; quit if Pseudo SSN and not verified
 ; Q:'$$SNDPSSN(DFN)   ;Removed by IVM*2*105
 ; 
 S DGPRIM=$$GET1^DIQ(2,DFN_",",.361)
 I $G(DGPRIM)]"" S DGPRIM=$O(^DIC(8,"B",DGPRIM,0))
 I $G(DGPRIM)]"" S DGPRIM=$P($G(^DIC(8,DGPRIM,0)),U,9)
 I $G(DGPRIM)=14 D REM Q
 ;
 ; if count=0 and not first batch
 ;RMC;I IVMCT=0,$G(IVMGTOT) D FILE^HLTF
 ;
 ; HL7 event/message counter
 S HLEVN=$G(HLEVN)+1
 ;
 ; CREATE SLOT FOR EACH NEW BATCH
 I HLEVN=1 D
 . K HLMID,MTIEN,HLDT,HLDT1
 . D CREATE^HLTF(.HLMID,.MTIEN,.HLDT,.HLDT1)
 ;
 ; handle message header processing for HL7 full data trans (Z07) msg
 D MSH^IVMUFNC4($G(IVMNOMSH),$G(IVMFLL),$G(IVMREC),.IVMCT,.IVMCNTID)
 ;
 I IVMMTDT="" D
 .S IVMMTDT=$P($$LST^DGMTU(DFN,DT),"^",2)
 .I IVMMTDT="" S IVMMTDT=DT
 ;
 ; build HL7 Full Data Transmission (Z07) message
 D BUILD^IVMPTRN8(DFN,IVMMTDT,.IVMCT,.IVMQUERY)
 ;
 ; log patient transmission
 D
 .N IVMSTAT
 .S X=$$LST^DGMTCOU1(DFN,IVMMTDT,3)
 .S IVMSTAT=$S($E($P(X,"^",2),1,3)=$E(IVMMTDT,1,3):$P($G(^DGMT(408.31,+X,0)),"^",3),1:"")
 .;
 .D FILEPT^IVMPTRN3(DFN,$$LYR^DGMTSCU1(IVMMTDT),HLDT,IVMCNTID,.EVENTS,IVMSTAT,IVMINS)
 ;
 ;if number of HL7 events/msgs is 100 then call HL7 pkg to transmit batch
 I HLEVN=100 D
 .N IVMEVENT
 .; event code for Full Data Transmission
 .S IVMEVENT="Z07"
 .I $G(IVMFLL) D FILE1^IVMPTRN3 Q
 .D FILE^IVMPTRN3
 Q
 ;
SNDPSSN(DFN) ; check SSN and patient eligibility
 ;
 ; Input:
 ;  DFN           Patient file (#2) IEN
 ; Output:
 ;  <expression>  1: Pseudo SSN and Eligibility verified or
 ;                   not a Pseudo SSN
 ;                0: Psuedo SSN and Eligibility Pending verification
 ;                   Pending re-verification
 ;
 N SSN,PFLG
 ;
 ; Don't process records with corrupted nodes
 I '$D(^DPT(DFN,0)) D REM Q 0
 ;   
 S SSN=$P(^DPT(DFN,0),U,9)
 S PFLG=($E(SSN,$L(SSN))="P") I 'PFLG Q 1
 I ($P($G(^DPT(DFN,.361)),U)="V") Q 1
 ;
 D REM
 Q 0
 ;
REM ; Remove Psuedo SSN from Queue
 ; Set TRANSMISSION STATUS to transmission not required
 S PDATA(.03)=1 I $$UPD^DGENDBS(301.5,IVMDA,.PDATA,.ERR)
 K PDATA,ERR
 Q
