BPSPRRX6 ;ALB/SS - ePharmacy secondary billing ;12-DEC-08
 ;;1.0;E CLAIMS MGMT ENGINE;**8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 ;check if if prescription with given number exists
 ;BPSRX - RX#
 ;return:
 ; 1st piece - ien of #52
 ; 2nd piece - ien of #2
 ; -1 if "^" was entered
RXINFO(BPSRX) ;
 N BPSDFN,BPS52,BPSRET
 ;prompt for the patient
 S BPSDFN=$$PROMPT^BPSSCRCV("P^DPT(","SELECT PATIENT")
 I BPSDFN=-1 Q -1
 K ^TMP($J,"BPSPRRX")
 D RX^PSO52API(BPSDFN,"BPSPRRX",,BPSRX,"0")
 I +$G(^TMP($J,"BPSPRRX",BPSDFN,0))=-1 D  Q 0
 . W !,"Incorrect RX# or patient name entered.",!
 S BPSRET=+$O(^TMP($J,"BPSPRRX",BPSDFN,0))_U_BPSDFN
 K ^TMP($J,"BPSPRRX")
 Q BPSRET
 ;prompt for the fill# and do the rest
RXREFIL(BPS52,BPSDFN,BPSRXNO) ;
 N BPSRF,BPSARR,BPSVAL,BPSELCTD,BPSRETV,BPORRFDT
 K ^TMP($J,"BPSPRRX")
 D RX^PSO52API(BPSDFN,"BPSPRRX",BPS52,,"R")
 I +$G(^TMP($J,"BPSPRRX",BPSDFN,BPS52,"RF",0))=0 Q 0
 S BPSRF=0
 F  S BPSRF=$O(^TMP($J,"BPSPRRX",BPSDFN,BPS52,"RF",BPSRF)) Q:+BPSRF=0  D
 . S BPSVAL=$G(^TMP($J,"BPSPRRX",BPSDFN,BPS52,"RF",BPSRF,.01))
 . S BPSARR(BPSRF)=BPSRF_U_$P(BPSVAL,U)
 ;original fill date
 S BPORRFDT=$$RXFLDT^PSOBPSUT(BPS52,0)
 S BPSARR(0)=0_U_BPORRFDT
 F  S BPSELCTD=$$SELREFIL^BPSPRRX5(.BPSARR,"SELECT A FILL TO BILL","RX #"_BPSRXNO_" has the following fills:") Q:$P(BPSELCTD,U)'=""
 I BPSELCTD<0 Q -1
 Q BPSELCTD
 ;
 ;restore BPSPLAN,BPSPRDAT,BPSRTYPE from BPS TRANSACTION file
 ;used for 2ndary claims only
 ;input:
 ; BP59 - ien of BPA TRANSACTION file of the SECONDARY claim
 ;output:
 ; BPSPLAN - plan, ien of #(355.3), by reference
 ; BPSPRDAT - array with 2ndary data, by reference
 ; BPSRTYPE - Rate Type, ien of #(399.3), by reference
RESTOR59(BP59,BPSPLAN,BPSPRDAT,BPSRTYPE) ;
 ; Data from file 9002313.59 being saved into BPSPRDAT array
 N BP59PR,BPZ,BRXIEN,BFILL,BPSRESP
 S BPSPLAN=+$P($G(^BPST(BP59,10,1,0)),U,1)
 S BPSRTYPE=+$P($G(^BPST(BP59,10,1,0)),U,8)
 ;
 ; build array of COB secondary claim data from the BPS Transaction file - esg - 6/14/10
 S BPSPRDAT("337-4C")=$P($G(^BPST(BP59,12)),U,4)       ;1204 cob other payments count
 S BPSPRDAT("308-C8")=$P($G(^BPST(BP59,12)),U,5)       ;1205 other coverage code
 ;
 ; build COB data array - esg - 6/14/10
 N COBPIEN,APDIEN,REJIEN
 K BPSPRDAT("OTHER PAYER")
 S COBPIEN=0 F  S COBPIEN=$O(^BPST(BP59,14,COBPIEN)) Q:'COBPIEN  D
 . S BPSPRDAT("OTHER PAYER",COBPIEN,0)=$G(^BPST(BP59,14,COBPIEN,0))
 . ;
 . ; retrieve data from other payer amount paid multiple
 . S APDIEN=0 F  S APDIEN=$O(^BPST(BP59,14,COBPIEN,1,APDIEN)) Q:'APDIEN  D
 .. S BPSPRDAT("OTHER PAYER",COBPIEN,"P",APDIEN,0)=$G(^BPST(BP59,14,COBPIEN,1,APDIEN,0))
 .. Q
 . ;
 . ; retrieve data from other payer reject multiple
 . S REJIEN=0 F  S REJIEN=$O(^BPST(BP59,14,COBPIEN,2,REJIEN)) Q:'REJIEN  D
 .. S BPSPRDAT("OTHER PAYER",COBPIEN,"R",REJIEN,0)=$G(^BPST(BP59,14,COBPIEN,2,REJIEN,0))
 .. Q
 . Q
 ;
 S BPSPRDAT("BILLNDC")=$P($G(^BPST(BP59,1)),U,2)
 S BPZ=$$RXREF^BPSSCRU2(BP59)
 S BRXIEN=+BPZ
 S BFILL=+$P(BPZ,U,2)
 S BP59PR=$$IEN59^BPSOSRX(BRXIEN,BFILL,1)
 S BPSRESP=$P($G(^BPST(BP59PR,0)),U,5) ;#4 RESPONSE
 S BPSPRDAT("PRIOR PAYMENT")=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,500)),U,9))
 Q
 ;
SECBIL59(MOREDATA,IEN59) ; populate 2ndary billing fields in BPS TRANSACTION
 ; MOREDATA array filed into 9002313.59
 N BPTYPE,BPSTIME,BPCOB
 N AMTIEN,BPIEN1,BPIEN2,BPZ5914,BPZ,BPZ1,BPZ2,OPAMT,OPAPQ,OPAYD,OPREJ,PIEN,REJIEN
 I +$G(IEN59)=0 Q
 ;
 I $L($G(MOREDATA("337-4C"))) I $$FILLFLDS^BPSUTIL2(9002313.59,1204,IEN59,MOREDATA("337-4C"))<1 D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot populate (#1204) of (#9002313.59)")   ; cob other payments count
 I $L($G(MOREDATA("308-C8"))) I $$FILLFLDS^BPSUTIL2(9002313.59,1205,IEN59,MOREDATA("308-C8"))<1 D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot populate (#1205) of (#9002313.59)")   ; other coverage code
 ;
 ; store secondary billing related data entered by the user - esg 6/14/10
 S BPQ=0
 S PIEN=0 F  S PIEN=$O(MOREDATA("OTHER PAYER",PIEN)) Q:'PIEN!BPQ  D
 . S OPAYD=$G(MOREDATA("OTHER PAYER",PIEN,0)) Q:OPAYD=""
 . ;
 . ; count up the number of multiples we have in each set
 . S BPZ=0 F BPZ1=0:1 S BPZ=$O(MOREDATA("OTHER PAYER",PIEN,"P",BPZ)) Q:'BPZ
 . S BPZ=0 F BPZ2=0:1 S BPZ=$O(MOREDATA("OTHER PAYER",PIEN,"R",BPZ)) Q:'BPZ
 . I BPZ1,BPZ2 S BPQ=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot have both payments and rejects for the same OTHER PAYER.") Q
 . ;
 . ; add a new entry to subfile 9002313.5914
 . S BPZ5914=$$INSITEM^BPSUTIL2(9002313.5914,IEN59,PIEN,PIEN,"",,0)
 . I BPZ5914<1 S BPQ=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Can't create entry in COB OTHER PAYERS multiple of the BPS TRANSACTION file") Q
 . ;
 . ; set the rest of the pieces at this level
 . I $P(OPAYD,U,2)'="" I $$FILLFLDS^BPSUTIL2(9002313.5914,.02,PIEN_","_IEN59,$P(OPAYD,U,2))<1 S BPQ=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot populate (#.02) of (#9002313.5914)") Q
 . I $P(OPAYD,U,3)'="" I $$FILLFLDS^BPSUTIL2(9002313.5914,.03,PIEN_","_IEN59,$P(OPAYD,U,3))<1 S BPQ=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot populate (#.03) of (#9002313.5914)") Q
 . I $P(OPAYD,U,4)'="" I $$FILLFLDS^BPSUTIL2(9002313.5914,.04,PIEN_","_IEN59,$P(OPAYD,U,4))<1 S BPQ=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot populate (#.04) of (#9002313.5914)") Q
 . I $P(OPAYD,U,5)'="" I $$FILLFLDS^BPSUTIL2(9002313.5914,.05,PIEN_","_IEN59,$P(OPAYD,U,5))<1 S BPQ=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot populate (#.05) of (#9002313.5914)") Q
 . I $$FILLFLDS^BPSUTIL2(9002313.5914,.06,PIEN_","_IEN59,BPZ1)<1 S BPQ=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot populate (#.06) of (#9002313.5914)") Q
 . I $$FILLFLDS^BPSUTIL2(9002313.5914,.07,PIEN_","_IEN59,BPZ2)<1 S BPQ=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot populate (#.07) of (#9002313.5914)") Q
 . ;
 . ; now loop thru the other payer payment array
 . S AMTIEN=0 F  S AMTIEN=$O(MOREDATA("OTHER PAYER",PIEN,"P",AMTIEN)) Q:'AMTIEN!BPQ  D
 .. S OPAMT=$G(MOREDATA("OTHER PAYER",PIEN,"P",AMTIEN,0))
 .. S OPAPQ=$P(OPAMT,U,2)   ; 342-HC other payer amt paid qualifier (ncpdp 5.1 blank is OK)
 .. S OPAMT=+OPAMT          ; 431-DV other payer amt paid
 .. ;
 .. ; add a new entry to subfile 9002313.59141
 .. S BPIEN1=$$INSITEM^BPSUTIL2(9002313.59141,PIEN_","_IEN59,OPAMT,AMTIEN,"",,0)
 .. I BPIEN1<1 S BPQ=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Can't create entry in 9002313.59141 subfile") Q
 .. ;
 .. ; set piece 2
 .. I OPAPQ'="" I $$FILLFLDS^BPSUTIL2(9002313.59141,.02,AMTIEN_","_PIEN_","_IEN59,OPAPQ)<1 D
 ... S BPQ=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot populate (#.02) of (#9002313.59141)")
 ... Q
 .. Q
 . ;
 . ; now loop thru the other payer reject array
 . S REJIEN=0 F  S REJIEN=$O(MOREDATA("OTHER PAYER",PIEN,"R",REJIEN)) Q:'REJIEN!BPQ  D
 .. S OPREJ=$G(MOREDATA("OTHER PAYER",PIEN,"R",REJIEN,0)) Q:OPREJ=""  Q:$P(OPREJ,U,1)=""
 .. ;
 .. ; add a new entry to subfile 9002313.59142
 .. S BPIEN2=$$INSITEM^BPSUTIL2(9002313.59142,PIEN_","_IEN59,$P(OPREJ,U,1),REJIEN,"",,0)
 .. I BPIEN2<1 S BPQ=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Can't create entry in 9002313.59142 subfile") Q
 .. Q
 . Q
 Q
 ;
RES2NDCL(BP59,BPSPLAN,BPSPRDAT,BPSRTYPE) ; populate fields to resubmit SECONDARY claim
 ;use for secondary claims only
 ;input:
 ; BP59 - ien of the BPS TRANSACTION file of the secondary claim
 ; BPSPLAN - 
 ; BPSPRDAT - 
 ; BPSRTYPE - 
 ;output:
 ; 1 -success
 ; 0 -cannot populate fields
 ;
 N BPDOSDT,BPZ,BPRXIEN,BPRXR,BPBILL
 I $$COB59^BPSUTIL2(BP59)'=2 Q 0
 S BPBILL=$$PAYBLPRI^BPSUTIL2(BP59)
 I BPBILL'>0 S BPBILL=""
 ;Retrieve DOS
 S BPZ=$$RXREF^BPSSCRU2(BP59)
 S BPRXIEN=+BPZ
 S BPRXR=+$P(BPZ,U,2)
 S BPDOSDT=$$DOSDATE^BPSSCRRS(BPRXIEN,BPRXR)
 S (BPSPLAN,BPSPRDAT,BPSRTYPE)=""
 D RESTOR59^BPSPRRX6(BP59,.BPSPLAN,.BPSPRDAT,.BPSRTYPE)
 S BPSPRDAT("PRIMARY BILL")=BPBILL
 S BPSPRDAT("FILL DATE")=BPDOSDT
 S BPSPRDAT("RX ACTION")="ERES"
 S BPSPRDAT("FILL NUMBER")=BPRXR
 S BPSPRDAT("PRESCRIPTION")=BPRXIEN
 Q 1
 ;BPSPRRX6
