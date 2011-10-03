IVMCM ;ALB/SEK,KCL,RTK,AEG,BRM,AEG - PROCESS INCOME TEST (Z10) TRANSMISSIONS ; 8/15/08 10:18am
 ;;2.0;INCOME VERIFICATION MATCH;**12,17,28,41,44,53,34,49,59,55,63,77,74,123,115**;21-OCT-94;Build 28
 ;
 ;
ORF ; Handler for ORF type HL7 messages received from HEC
 ;
 ; Make sure POSTMASTER DUZ instead of DUZ of Person who
 ; started Incoming Logical Link.
 S DUZ=.5
 N CNT,IVMRTN,SEGCNT
 S IVMRTN="IVMCMX"  ;USE "IVMCMX" BECAUSE "IVMCM" ALREADY USED
 K ^TMP($J,IVMRTN),DIC
 S (DGMSGF,DGMTMSG)=1  ; HL7 rtn. Don't need DG interative messages.
 S HLECH=HL("ECH"),HLQ=HL("Q"),HLMID=HL("MID")
 K %,%H,%I D NOW^%DTC S HLDT=%
 F SEGCNT=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S CNT=0
 . S ^TMP($J,IVMRTN,SEGCNT,CNT)=HLNODE
 . F  S CNT=$O(HLNODE(CNT)) Q:'CNT  D
 . . S ^TMP($J,IVMRTN,SEGCNT,CNT)=HLNODE(CNT)
 S HLDA=HLMTIEN
 ;
 N SEG,EVENT,MSGID
 S:'$D(HLEVN) HLEVN=0
 D NXTSEG^DGENUPL(HLDA,0,.SEG)
 Q:(SEG("TYPE")'="MSH")  ;would not have reached here if this happened!
 S EVENT=$P(SEG(9),$E(HLECH),2)
 ;
 ; INITIALIZE HL7 VARIABLES
 S HLEID="VAMC "_$P($$SITE^VASITE,"^",3)_" ORF-"_EVENT_" SERVER"
 S HLEID=$O(^ORD(101,"B",HLEID,0))
 D INIT^HLFNC2(HLEID,.HL)
 S HLEIDS=$O(^ORD(101,HLEID,775,"B",0))
 ;
 ; Handle means test signature ORF (Z06) event
 I EVENT="Z06" D ORF^IVMPREC7
 ;
 ; Handle income test ORF (Z10) event
 I EVENT="Z10" D Z10
 ;
 ; Handle enrollment/elig. ORF (Z11) event
 I EVENT="Z11" D
 .S MSGID=SEG(10)
 .D ORFZ11^DGENUPL(HLDA,MSGID)
 ;
 K ^TMP($J,IVMRTN)
 Q
 ;
 ;
Z10 ; Entry point for receipt of ORF~Z10 transmission
 ; The Income Test (Z10) transmission has the following format:
 ;
 ;       BHS           ORF msgs do not include batch header or trailer.
 ;       {MSH
 ;        PID          They will include the sequence:  MSA 
 ;        ZIC                                           QRD
 ;        ZIR                                           QRF
 ;        {ZDP         These segments will follow the MSH segment.
 ;         ZIC
 ;         ZIR
 ;        }
 ;        {ZMT
 ;        }
 ;        ZBT
 ;       }
 ;       BTS
 ;
 S IVMORF=1 ; set ORF msg flag
 S (HLEVN,IVMCT,IVMERROR,IVMCNTR)=0 ; init vars
 ;
ORU ; Entry point for receipt of ORU~Z10 trans (called by IVMPREC2)
 S IVMTYPE=5,IVMZ10F=1
 ;
 ; - loop through the msg in (#772 file), and process (PROC) msgs
 S IVMDA=0 F  S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)) Q:'IVMDA  S IVMSEG=$G(^(IVMDA,0)) I $E(IVMSEG,1,3)="MSH" D PROC Q:'IVMDA
 ;
 ; - if ORF msg flag, update the Query Tran Log
 I $G(IVMORF) D
 .I $G(DFN),$D(IVMMCI) D
 ..N IVMCR
 ..S IVMCR=$P("1^2^3^7^5^6^4","^",IVMTYPE)  ;map reason to test type
 ..D FIND^IVMCQ2(DFN,IVMMCI,HLDT,$S($D(HLERR):5,1:IVMCR),1)
 ;
 ; - if tests are uploaded, generate notification msg
 I $D(^TMP($J,"IVMBULL")) D ^IVMCMB
 ;
ENQ ;
 K IVMDA,IVMORF,IVMSEG,IVMFLGC,IVMTYPE,IVMMTIEN,IVMMTDT,IVMDGBT,IVMMCI
 K ^TMP($J,"IVMCM"),^("IVMBULL"),DGMSGF,DGADDF,IVMCPAY,IVMBULL,DFN
 K DGMTMSG,IVMZ10F
 Q
 ;
PROC ; Process each HL7 message from (#772) file
 ;
 N IVMFUTR,TMSTAMP,SOURCE,NODE,HSDATE,IVMZ10,DGMTP,DGMTACT,DGMTI,DGMTA
 S DGMTACT="ADD"
 D PRIOR^DGMTEVT
 S IVMZ10="UPLOAD IN PROGRESS"
 S IVMFUTR=0 ;this flag will indicate whether or not a test with a future date is being uploaded
 S IVMMTIEN=0
 ;
 S MSGID=$P(IVMSEG,HLFS,10) ; msg control id for ACK's
 ; - check if DCD messaging is enabled
 I '$$DCDON^IVMUPAR1() D PROB^IVMCMC("Facility has DCD messaging disabled") Q
 ;
 ; - check HL7 msg structure for errors
 K HLERR,^TMP($J,"IVMCM")
 D ^IVMCMC I $D(HLERR) K:HLERR="" HLERR Q
 ;
 ; Determine type of test/transmission
 S IVMTYPE=0
 ;
 ; - was a means test sent?
 I $P($G(^TMP($J,"IVMCM","ZMT1")),HLFS,2) S IVMTYPE=1 ; MT trans
 ;
 ; - if MT and CT transmitted, error - pt can't have both unless
 ;   one is a deletion, but HEC not currently handling that situation
 I IVMTYPE,$P($G(^TMP($J,"IVMCM","ZMT2")),HLFS,2) D PROB^IVMCMC("Patient  can not have both a Means Test and Copay Test") Q
 I $P($G(^TMP($J,"IVMCM","ZMT2")),HLFS,2) S IVMTYPE=2 ; CT trans
 ;
 ; - if no MT or CT or LTC then Income Screening
 I 'IVMTYPE,'$P($G(^TMP($J,"IVMCM","ZMT4")),HLFS,2) S IVMTYPE=3 ; IS trans
 ;
 ;send an eligibility query if no eligibility code
 I '$$ELIG^IVMCUF1(DFN),'$$PENDING^DGENQRY(DFN) I $$SEND^DGENQRY1(DFN)
 ;
 ; obtain locks used to sychronize upload with local income test options
 D GETLOCKS^IVMCUPL(DFN)
 ;
 ;
MT ; If transmission is a Means Test
 N NODE0,RET,CODE,DATA,MTSIG,MTSIGDT
 S HLQ=$G(HL("Q"))
 S:HLQ="" HLQ=""""""
 I IVMTYPE=1 D  I $D(HLERR) G PROCQ
 .S IVMMTDT=$$FMDATE^HLFNC($P($G(^TMP($J,"IVMCM","ZMT1")),HLFS,2))
 .S TMSTAMP=$$FMDATE^HLFNC($P($G(^TMP($J,"IVMCM","ZMT1")),HLFS,25))
 .S HSDATE=$$FMDATE^HLFNC($P($G(^TMP($J,"IVMCM","ZMT1")),HLFS,24))
 .S SOURCE=$P($G(^TMP($J,"IVMCM","ZMT1")),HLFS,22)
 .S MTSIG=$P($G(^TMP($J,"IVMCM","ZMT1")),HLFS,27)
 .S MTSIGDT=$$FMDATE^HLFNC($P($G(^TMP($J,"IVMCM","ZMT1")),HLFS,15))
 .S IVMLAST=$$LST^DGMTU(DFN,$E(IVMMTDT,1,3)_1231,1)
 .; Check that test is for same year
 .I $P(IVMLAST,U,2),$E($P(IVMLAST,U,2),1,3)'=$E(IVMMTDT,1,3) S IVMLAST=""
 .Q:$$UPDMTSIG^IVMCMF(+IVMLAST,TMSTAMP,MTSIG,MTSIGDT)
 .I $$Z06MT^EASPTRN1(+IVMLAST) D PROB^IVMCMC("IVM Means Test already on file for this year") Q
 .I '$$ELIG^IVMUFNC5(DFN) S ERRMSG="Means Test upload not appropriate for current patient"
 .I $$AGE^IVMUFNC5(DT)>$$INCY^IVMUFNC5(IVMMTDT) D
 ..N CATCZMT S CATCZMT=$G(^TMP($J,"IVMCM","ZMT1"))
 ..S CATC=$$CATC^IVMUFNC5(CATCZMT)
 ..I '+$G(CATC) S ERRMSG="Only Means Tests in current/previous income years are valid (not effective)"
 .I $G(ERRMSG)'="" D PROB^IVMCMC(ERRMSG) K ERRMSG,CATC Q
 .;
 .; - perform edit checks and file MT
 .D CHKDT
 .;deletion indicator sent?
 .I $P($G(^TMP($J,"IVMCM","ZMT1")),HLFS,3)=HLQ D  Q
 ..D
 ...;if there is a future test for that income year, delete that
 ...N IEN,DATA,IVMPAT
 ...S IEN=$$FUTURE(DFN,($E(IVMMTDT,1,3)-1),1,.IVMPAT)
 ...I IEN S DATA(.06)="" I $$UPD^DGENDBS(301.5,IVMPAT,.DATA)
 ...I IEN,$D(^DGMT(408.31,IEN,0)) D
 ....S IVMMTIEN=IEN
 ....S IVMFUTR=1
 ...E  D
 ....S IVMFUTR=0
 ..Q:('IVMMTIEN)
 ..S NODE0=$G(^DGMT(408.31,IVMMTIEN,0))
 ..I $$EN^IVMCMD(IVMMTIEN) D
 ...S RET=$$LST^DGMTU(DFN,DT,IVMTYPE)
 ...S CODE=$S(($E($P(RET,"^",2),1,3)=$E(DT,1,3)):$P(RET,"^",4),1:"")
 ...D ADD^IVMCMB(DFN,IVMTYPE,$S(IVMFUTR:"DELETE FUTR TEST",1:"DELETE PRMRY TEST"),+$G(NODE0),$$GETCODE^DGMTH($P(NODE0,"^",3)),CODE)
 .;
 .;check timestamp - if matches current primary test and hardship matches, then this is a duplicate and does not need to be uploaded
 .I TMSTAMP D
 ..S NODE=""
 ..I IVMFUTR N IVMMTIEN S IVMMTIEN=$$FUTURE(DFN,($E(IVMMTDT,1,3)-1),1)
 ..Q:'IVMMTIEN
 ..S NODE=$G(^DGMT(408.31,IVMMTIEN,2))
 .S NODE0=$G(^DGMT(408.31,IVMMTIEN,0))
 .I TMSTAMP,TMSTAMP=$P(NODE,"^",2),IVMMTDT=$P(NODE0,"^"),SOURCE=$P(NODE,"^",5),(HSDATE=$P(NODE,"^")) Q
 .;
 .D DELTYPE^IVMCMD(DFN,IVMMTDT,2)
 .D EN^IVMCM1
 ;
 ;
CT ; If transmission is a Copay Test
 N NODE0,RET,CODE,DATA
 I IVMTYPE=2 D  I $D(HLERR) G PROCQ
 .S IVMMTDT=$$FMDATE^HLFNC($P($G(^TMP($J,"IVMCM","ZMT2")),HLFS,2))
 .S TMSTAMP=$$FMDATE^HLFNC($P($G(^TMP($J,"IVMCM","ZMT2")),HLFS,25))
 .S SOURCE=$P($G(^TMP($J,"IVMCM","ZMT2")),HLFS,22)
 .S IVMLAST=$$LST^DGMTU(DFN,$E(IVMMTDT,1,3)_1231,2)
 .S IVMCPAY=$$RXST^IBARXEU(DFN)
 .I $$AGE^IVMUFNC5(DT)>$$INCY^IVMUFNC5(IVMMTDT) D PROB^IVMCMC("Only Copay Tests in the current/previous income years are valid. (Not effective)") Q
 .; - perform edit checks and file CT
 .D CHKDT
 .;deletion indicator sent?
 .I $P($G(^TMP($J,"IVMCM","ZMT2")),HLFS,3)=HLQ D  Q
 ..D
 ...;if there is a future test for that income year, delete that
 ...N IEN,DATA,IVMPAT
 ...S IEN=$$FUTURE(DFN,($E(IVMMTDT,1,3)-1),2,.IVMPAT)
 ...I IEN S DATA(.07)="" I $$UPD^DGENDBS(301.5,IVMPAT,.DATA)
 ...I IEN,$D(^DGMT(408.31,IEN,0)) D
 ....S IVMMTIEN=IEN
 ....S IVMFUTR=1
 ...E  D
 ....S IVMFUTR=0
 ..Q:('IVMMTIEN)
 ..S NODE0=$G(^DGMT(408.31,IVMMTIEN,0))
 ..I $$EN^IVMCMD(IVMMTIEN) D
 ...S RET=$$LST^DGMTU(DFN,DT,IVMTYPE)
 ...S CODE=$S(($E($P(RET,"^",2),1,3)=$E(DT,1,3)):$P(RET,"^",4),1:"")
 ...D ADD^IVMCMB(DFN,IVMTYPE,$S(IVMFUTR:"DELETE FUTR TEST",1:"DELETE PRMRY TEST"),+$G(NODE0),$$GETCODE^DGMTH($P(NODE0,"^",3)),CODE)
 .;
 .;check timestamp - if matches current primary test, then this is a duplicate and does not need to be uploaded
 .I TMSTAMP D
 ..S NODE=""
 ..I IVMFUTR N IVMMTIEN S IVMMTIEN=$$FUTURE(DFN,($E(IVMMTDT,1,3)-1),2)
 ..Q:'IVMMTIEN
 ..S NODE=$G(^DGMT(408.31,IVMMTIEN,2))
 .S NODE0=$G(^DGMT(408.31,IVMMTIEN,0))
 .I TMSTAMP,TMSTAMP=$P(NODE,"^",2),IVMMTDT=$P(NODE0,"^"),SOURCE=$P(NODE,"^",5) Q
 .;
 .D DELTYPE^IVMCMD(DFN,IVMMTDT,1)
 .D EN^IVMCM1
 ;
IS ; - If transmission is income screening info only then do not process
 ; - outside of the scope of MTS
 ;I IVMTYPE=3 S IVMMTDT=0 D EN^IVMCM1 I $D(HLERR) G PROCQ
 I IVMTYPE=3 S IVMMTDT=0
 ;
LTC ; If transmission contains a Long Term Care Test (TYPE 4 TEST)
 I $P($G(^TMP($J,"IVMCM","ZMT4")),HLFS,2) D LTC^IVMCM1
 ;
PROCQ ;
 ; release locks used to sychronize upload with local income test options
 D RELLOCKS^IVMCUPL(DFN)
 Q
 ;
CHKDT ; check date of income test being uploaded
 ; Is it a future date?  If so, set IVMFUTR=1
 ;
 ; IVMMTIEN is the IEN of current primary test for the year
 ;
 I $E($P(IVMLAST,"^",2),1,3)=$E(IVMMTDT,1,3) S IVMMTIEN=+IVMLAST
 I IVMMTDT>DT S IVMFUTR=1
 Q
FUTURE(DFN,YEAR,TYPE,IVMPAT) ;
 ;Returns the ien of the future test, if there is one
 ;Inputs:  DFN
 ;         YEAR  - income year
 ;         TYPE - type of test
 ;Output:
 ;  function value - ien of future means test, if there is one, "" otherwise
 ;  IVMPAT - Pointer to the IVM Patient file for the income year if there is an entry (pass by reference)
 ;
 N RET
 S RET=""
 S IVMPAT=$$FIND^IVMPLOG(DFN,YEAR)
 I IVMPAT S RET=$P($G(^IVM(301.5,IVMPAT,0)),"^",$S(TYPE=1:6,1:7))
 Q RET
