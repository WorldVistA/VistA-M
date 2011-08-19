IVMPTRN9 ;ALB/KCL/CN/BRM,TDM,EG - HL7 FULL DATA TRANSMISSION (Z07) BUILDER (CONTINUED) ; 10/11/07 12:19pm
 ;;2.0;INCOME VERIFICATION MATCH;**9,11,19,12,21,17,46,50,53,34,49,58,79,99,116,105,115**; 21-OCT-94;Build 28
 ;
 ;
GOTO ; place to break up the routine
 ;
 ; create (ZIO) Inpatient/Outpatient segment for veteran
 S N101015=$G(^DPT(DFN,1010.15))
 S ZIOSEG="ZIO^1^"_$$EN^IVMUFNC1(DFN,IVMMTDT,.IVMQUERY)  ;seq 1-3
 S ZIOSEG=ZIOSEG_"^"_$$LTD^IVMUFNC(DFN,.IVMQUERY)        ;seq 4
 S X=$P(N101015,"^",9),$P(ZIOSEG,U,6)=$S(X=0:"N",X=1:"Y",1:HLQ)   ;Appt Request
 S X=$P(N101015,"^",11),$P(ZIOSEG,U,7)=$S(X]"":$$HLDATE^HLFNC(X),1:HLQ) ;Appt Request Date
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=ZIOSEG
 ;
 ; create (NTE) Notes and Comments segment
 D NTE^IVMUFNC4(DFN,.IVMNTE,IVMMTDT)
 I '$D(IVMNTE) D
 . S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)="NTE^1"
 I $D(IVMNTE) D
 . ; - get notes and comments
 . F IVMSUB=0:0 S IVMSUB=$O(IVMNTE(IVMSUB)) Q:'IVMSUB  D
 . . S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=IVMNTE(IVMSUB)
 ;
 ; create (IN1) Insurance segment(s) for all active insurance
 K ^TMP("VAFIN1",$J)
 D EN^VAFHLIN1(DFN,"1,4,5,7,8,9,12,13,15,16,17,28,36")
 F IVMSUB=0:0 S IVMSUB=$O(^TMP("VAFIN1",$J,IVMSUB)) Q:'IVMSUB  D
 . S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=^TMP("VAFIN1",$J,+IVMSUB,0)
 ;
 ;find if the deletion flags were set in the IVM Patient file, and if so, should the deletion indicators be sent?
 F I="RX","MT","HARDSHIP","DATE OF TEST","LTC" S DELETE(I)=""
 S IVMPIEN=$$FIND^IVMPLOG(DFN,($E(IVMMTDT,1,3)-1))
 I IVMPIEN D
 . S IVMPNODE=$G(^IVM(301.5,IVMPIEN,0))
 . I $P(IVMPNODE,"^",8)!$P(IVMPNODE,"^",9)!$P(IVMPNODE,"^",10)!$P(IVMPNODE,"^",11) S DELETE("SET")=1
 . ;was the MT deletion flag set, and if so verify that there is no completed MT
 . I $P(IVMPNODE,"^",8),(TESTTYPE'=1)!(TESTCODE="")!("ACGP"'[TESTCODE) S DELETE("DATE OF TEST")=$P(IVMPNODE,"^",8),DELETE("MT")=1
 . ;
 . ;was the hardship deletion flag set, and if so verify that there is no completed hardship
 . I $P(IVMPNODE,"^",10),'HARDSHIP D
 . . S:('DELETE("DATE OF TEST")) DELETE("DATE OF TEST")=$P(IVMPNODE,"^",10)
 . . S DELETE("HARDSHIP")=1
 ;
 ; create (ZMT) Means Test segment 
 ;
 S SEQS=$S(TESTTYPE=1:"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,21,22,23,24,25,26,28,29,30",1:"1,17")
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^IVMCZMT(DFN,SEQS,IVMMTDT,1,1,.DELETE,1)
 ;
 ; create (ZMT) Rx-Copay Test segment
 I IVMPIEN D
 . ;was the RX deletion flag set, and if so verify that there is no completed test
 . I $P(IVMPNODE,"^",9),(TESTTYPE'=2)!(TESTCODE="")!("EM"'[TESTCODE) S DELETE("DATE OF TEST")=$P(IVMPNODE,"^",9),DELETE("RX")=1
 ;
 N IVMCPDT,CPTST,LINK,CPDATE
 ;should be ok to get the last co-pay test for this year vs. looking from the IVMMTDT backwards
 ;as long as the means test date is in the current year
 S CPTST=$$LST^DGMTU(DFN,$E(IVMIY,1,3)+1_1231,2)
 I CPTST D
 . S CPDATE=$P(CPTST,U,2)
 . S LINK=$P($G(^DGMT(408.31,+CPTST,2)),U,6)
 . I TESTTYPE=1,$E(CPDATE,1,3)=$E(IVMMTDT,1,3) D
 . . ;if you have a means test and a linked co-pay test then send both (the means test
 . . ;was already sent from above)
 . . ;if means and copay are not linked, don't send the co-pay test (the means test
 . . ;was already sent from above)
 . . I LINK=+$$LST^DGMTU(DFN,IVMMTDT,1) S TESTTYPE=2,(IVMCPDT,IVMMTDT)=CPDATE
 . . Q
 . Q
 ;always send the 2nd ZMT segment
 S SEQS="1,17"
 ;can also send a co-pay test if there is no means test (see module GETTYPE)
 I TESTTYPE=2 D
 . S SEQS="1,2,3,4,5,6,7,9,10,12,15,16,17,18,21,22,25,26,30"
 . Q
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^IVMCZMT(DFN,SEQS,IVMMTDT,2,2,.DELETE,1)
 ;
 ; create (ZMT) Long Term Care Copay Exemption Test segment
 I IVMPIEN D
 . ; set deletion indicators if LTC test deletion should be transmitted
 . I $P(IVMPNODE,"^",11) S DELETE("LTC")=1 S:('DELETE("DATE OF TEST")) DELETE("DATE OF TEST")=$P(IVMPNODE,"^",11)
 ;
 S SEQS="1,2,3,4,5,7,9,10,12,16,17,18,22,25,30"
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^IVMCZMT(DFN,SEQS,IVMMTDT,4,4,.DELETE,1)
 ;
 ;if the deletion flags were set in the IVM Patient file, unset them
 I $G(DELETE("SET")) D
 . N DATA
 . S DATA(.08)="",DATA(.09)="",DATA(.1)="",DATA(.11)=""
 . I $$UPD^DGENDBS(301.5,IVMPIEN,.DATA)
 ;
 ; create (ZBT) Beneficiary Travel segment based on last BT Claim
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZBT($$BTCLM^IVMUFNC4(DFN),"1,2,3,4,7")
 ;
 ; create (ZFE) Fee Basis segment(s)
 D EN^FBHLZFE(DFN,"1,2,3,4,5")
 F IVMSUB=0:0 S IVMSUB=+$O(FBZFE(IVMSUB)) Q:'IVMSUB  D
 . S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$G(FBZFE(+IVMSUB))
 ;
 ; create (ZSP) Service Period segment
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLZSP(DFN,1,1)
 ;
 ; optionally create (OBX) segment for Patient Sensitivity Flag
 K OBXTMP
 S OBXCNT=0,GETCUR=$$FINDSEC^DGENSEC(DFN)
 I GETCUR,$$GET^DGENSEC(GETCUR,.DGSEC) D
 . Q:(DGSEC("LEVEL")'=1)&(DGSEC("LEVEL")'=0)
 . S OBXTMP(2)="CE",OBXTMP(3)="38.1"_$E(HL("ECH"))_"SECURITY LOG"
 . S:DGSEC("LEVEL") OBXTMP(5)="Y"_$E(HL("ECH"))_"YES"_$E(HL("ECH"))_"HL70136"
 . S:'DGSEC("LEVEL") OBXTMP(5)="N"_$E(HL("ECH"))_"NO"_$E(HL("ECH"))_"HL70136"
 . S OBXTMP(11)="R",OBXTMP(14)=DGSEC("DATETIME")
 . S OBXTMP(16)="" I $G(DGSEC("SOURCE"))'="" D
 . . S $P(OBXTMP(16),$E(HL("ECH")),14)=$E(HL("ECH"),4)_DGSEC("SOURCE")
 . S IVMCT=IVMCT+1,OBXCNT=OBXCNT+1
 . S ^TMP("HLS",$J,IVMCT)=$$EN^VAFHLOBX(.OBXTMP,OBXCNT,"2,3,5,11,14,16")
 . I $G(OBXTMP(16))'="" S $P(^TMP("HLS",$J,IVMCT),"^",17)=$G(OBXTMP(16))
 ;
 ; create (OBX) segment for NTR
 ; CALL PIMS API TO GET NTRARRY OF NTR DATA
 S GETCUR=$$ENRGET^DGNTAPI1(DFN)
 I GETCUR D NTROBX^IVMPTRNA(.DGNTARR)
 I $D(NTROBX) D
 . S IVMCT=IVMCT+1,OBXCNT=OBXCNT+1
 . S ^TMP("HLS",$J,IVMCT)=$$EN^VAFHLOBX(.NTROBX,OBXCNT,"2,3,5,11,12,14,15,16,17")
 . I $G(NTROBX(16))'="" S $P(^TMP("HLS",$J,IVMCT),"^",17)=$G(NTROBX(16))
 . K NTROBX
 ;
 ; create (RF1) segment
 S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$RF1^IVMPTRNA(DFN,"SAD")
 F RF1TYP="CAD","CPH","PNO","EAD" D   ;Create Optional RF1 Segments
 . S RF1SEG=$$RF1^IVMPTRNA(DFN,RF1TYP) Q:RF1SEG=""
 . S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=RF1SEG
 ;
 Q
 ;
GETTYPE(DFN,IVMMTDT,CODE,HARDSHIP,ACTVIEN)      ;
 ;Determines the type of test to include in the Z10.  HEC wants only the
 ;test that they would consider primary,i.e., preference given to a comptleted means test, even if not currently in effect.
 ;
 ;Input:
 ;  DFN
 ;  IVMMTDT -date to be the search for the test
 ;Output:
 ;  Function value - type of test to send in Z10
 ;  CODE - status code of test (pass by reference)
 ;  HARDSHIP - hardship indicator (pass by reference)
 ;  ACTVIEN - ien of test that should have the associated Income Relations (pass by reference)
 ;
 N TESTTYPE,MTNODE,RXNODE,NODE0,NODE2
 S TESTTYPE=1
 S (HARDSHIP,CODE,ACTVIEN)=""
 Q:'$G(IVMMTDT) TESTTYPE
 Q:'$G(DFN) TESTTYPE
 ;
 S MTNODE=$$LST^DGMTU(DFN,IVMMTDT,1) I $E($P(MTNODE,"^",2),1,3)'=$E(IVMMTDT,1,3) S MTNODE=""
 S RXNODE=$$LST^DGMTU(DFN,IVMMTDT,2) I $E($P(RXNODE,"^",2),1,3)'=$E(IVMMTDT,1,3) S RXNODE=""
 ;
 I MTNODE="" S MTNODE=$$FUT^DGMTU(DFN,"",1) I $E($P(MTNODE,"^",2),1,3)'=$E(IVMMTDT,1,3) S MTNODE=""
 I RXNODE="" S RXNODE=$$FUT^DGMTU(DFN,"",2) I $E($P(RXNODE,"^",2),1,3)'=$E(IVMMTDT,1,3) S RXNODE=""
 D
 . ;determine which test has the associated income relations
 . ;
 . I +MTNODE S CODE=$P(MTNODE,"^",4) I CODE'="",("ACGPR"[CODE) S ACTVIEN=+MTNODE Q
 . I +RXNODE S CODE=$P(RXNODE,"^",4) I CODE'="",("EMI"[CODE) S ACTVIEN=+RXNODE Q
 . I +MTNODE S ACTVIEN=+MTNODE Q
 . I +RXNODE S ACTVIEN=+RXNODE Q
 I ACTVIEN,+MTNODE,+RXNODE D TRANSFER^DGMTU4(DFN,$S((ACTVIEN=+MTNODE):+RXNODE,1:+MTNODE),ACTVIEN)
 ;
 ;now find the primary test
 I '(+MTNODE) G CHKCOPAY
 S CODE=$P(MTNODE,"^",4)
 S HARDSHIP=$P($G(^DGMT(408.31,+MTNODE,0)),"^",20)
 I (CODE="")!("ACGP"'[CODE) S NODE2=$G(^DGMT(408.31,+MTNODE,2)),CODE=$$GETCODE^DGMTH($P(NODE2,"^",3)) I (CODE="")!("ACGP"'[CODE) G CHKCOPAY
 ;
 G QGETTYPE
 ;
CHKCOPAY        ;
 I '(+RXNODE) G QGETTYPE
 S CODE=$P(RXNODE,"^",4)
 I (CODE="")!("EM"'[CODE) S NODE2=$G(^DGMT(408.31,+RXNODE,2)),CODE=$$GETCODE^DGMTH($P(NODE2,"^",3)) I (CODE="")!("EM"'[CODE) G QGETTYPE
 S TESTTYPE=2
 ;
QGETTYPE        ;
 Q TESTTYPE
 ;
FILTER(DFN)     ; address transmission filter
 ; Check Bad Address Indicator for a known bad address and
 ; Scrutinize the Street Address line 1 field for known bad address
 ; strings based on functionality currently in place in HEC Legacy.
 ;
 ;  Input: DFN - ien of the Patient (#2) file
 ; Output:   0 - filter passed (ok to transmit address)
 ;           1 - filter failed (do not transmit address)
 ;
 N VAPA
 Q:'$G(DFN) 1  ;DFN missing
 Q:$$BADADR^DGUTL3(DFN) 1  ;check Bad Address Indicator
 D ADD^VADPT  ;get patient address
 ; Street Address Line 1 or Zip Code is <null>
 Q:($G(VAPA(1))="")!($P($G(VAPA(11)),"^")="") 1
 ; St Addr Line 1 contains 'UNKNOWN', 'HOMELESS', or 'ADDRESS'
 Q:(VAPA(1)["UNKNOWN")!(VAPA(1)["HOMELESS")!(VAPA(1)["ADDRESS") 1
 ; The first two characters of the address is equal to '**'
 Q:$E(VAPA(1),1,2)="**" 1
 ; passed all address filters - ok to send
 Q 0
