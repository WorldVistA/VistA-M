IBAPDX ;ALB/CPM - EXTRACT MEANS TEST BILLING DATA FOR PDX ; 09-APR-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EXTR(TRAN,DFN,ARR) ; PDX Entry Point for the data extraction.
 ; Input:   TRAN --  Pointer to transaction in file #394.61
 ;          DFN  --  Pointer to the patient in file #2
 ;          ARR  --  Root for the output extract array
 ; Output:    0  --  Extraction was successful, or
 ;        -1^err --  if an error was encountered during the extract.
 ;
 ; NOTES : If TRAN is passed
 ;           The patient pointer of the transaction will be used
 ;           Encryption will be based on the transaction
 ;         If DFN is passed
 ;           Encryption will be based on the site parameter
 ;       : Pointer to transaction takes presidence over DFN ... if
 ;         TRAN>0 the DFN will be based on the transaction
 ;
 S TRAN=+$G(TRAN)
 S DFN=+$G(DFN)
 Q:(('TRAN)&('DFN)) "-1^Did not pass pointer to transaction or patient"
 I (TRAN) Q:('$D(^VAT(394.61,TRAN))) "-1^Did not pass valid pointer to VAQ - TRANSACTION file"
 I (TRAN) S DFN=+$P($G(^VAT(394.61,TRAN,0)),"^",3) Q:('DFN) "-1^Transaction did not contain pointer to PATIENT file"
 Q:('$D(^DPT(DFN))) "-1^Did not pass valid pointer to PATIENT file"
 ;
 N C,ERR,KEY1,KEY2,IBARR,IBATYP,IBCRYP,IBD,IBDF,IBEFDT,IBENC,IBI,IBID,IBN,IBND,IBREF,IBSEQ,STRING,Y,IBENCPT,IBSNDR,IBSTR S ERR=0
 I $G(ARR)="" S ERR="-1^Did not pass root for the output array." G EXTRQ
 ;
 ; - set variables for encryption
 D ENCR^IBAPDX0 G:ERR<0 EXTRQ
 ;
 ; - get Continuous Patient data
 S IBSTR=$G(^IBE(351.1,+$O(^IBE(351.1,"B",DFN,0)),0)) I 'IBSTR S @ARR@("VALUE",351.1,.01,0)="",@ARR@("ID",351.1,.01,0)="" G CLOCK
 S (IBENC,STRING)=$P($$PT^IBEFUNC(+IBSTR),"^") X:$$NCRPFLD^VAQUTL2(2,.01) IBCRYP
 S (IBID,@ARR@("VALUE",351.1,.01,0),@ARR@("ID",351.1,.01,0))=IBENC
 S (IBENC,STRING)=$$DAT1^IBOUTL($P(IBSTR,"^",2)) X:$$NCRPFLD^VAQUTL2(351.1,.02) IBCRYP
 S @ARR@("VALUE",351.1,.02,0)=IBENC,@ARR@("ID",351.1,.02,0)=IBID
 ;
CLOCK ; - get active billing clock data
 S IBSTR=$G(^IBE(351,+$O(^IBE(351,"ACT",DFN,0)),0)) I 'IBSTR S @ARR@("VALUE",351,.01,0)="",@ARR@("ID",351,.01,0)="" G EXTRQ
 I '$D(IBID) S (IBENC,STRING)=$P($$PT^IBEFUNC(+$P(IBSTR,"^",2)),"^") X:$$NCRPFLD^VAQUTL2(2,.01) IBCRYP S IBID=IBENC
 S IBEFDT=$P(IBSTR,"^",3),(IBENC,STRING)=+IBSTR X:$$NCRPFLD^VAQUTL2(351,.01) IBCRYP
 S (IBREF,@ARR@("VALUE",351,.01,0))=IBENC,@ARR@("ID",351,.01,0)=IBID
 S (IBENC,STRING)=$$DAT1^IBOUTL(IBEFDT) X:$$NCRPFLD^VAQUTL2(351,.03) IBCRYP
 S @ARR@("VALUE",351,.03,0)=IBENC,@ARR@("ID",351,.03,0)=IBREF
 F IBI=5:1:9 D
 .S (IBENC,STRING)=+$P(IBSTR,"^",IBI) X:$$NCRPFLD^VAQUTL2(351,".0"_IBI) IBCRYP
 .S @ARR@("VALUE",351,".0"_IBI,0)=IBENC,@ARR@("ID",351,".0"_IBI,0)=IBREF
 ;
 ; - get all charges billed within the active clock period
 S IBD="" F  S IBD=$O(^IB("AFDT",DFN,IBD)) Q:'IBD  D
 .S IBDF=0 F  S IBDF=$O(^IB("AFDT",DFN,IBD,IBDF)) Q:'IBDF  D
 ..S IBN=0 F  S IBN=$O(^IB("AF",IBDF,IBN)) Q:'IBN  D
 ...S IBND=$G(^IB(IBN,0)) Q:'IBND
 ...Q:$P(IBND,"^",8)["ADMISSION"
 ...I $P(IBND,"^",15)'<IBEFDT S IBARR(+$P(IBND,"^",14),IBN)=""
 ;
 ; - set all billed charges into the extract array
 I '$D(IBARR) S @ARR@("VALUE",350,.01,0)="",@ARR@("ID",350,.01,0)="" G EXTRQ
 D CHG^IBAPDX0
 ;
EXTRQ Q ERR
