BPSPRRX6 ;ALB/SS - ePharmacy secondary billing ;12-DEC-08
 ;;1.0;E CLAIMS MGMT ENGINE;**8,10,11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
RXINFO(BPSRX) ;
 ;Check if if prescription with given number exists
 ;Input:
 ;  BPSRX - RX#
 ;Return:
 ;  1st piece - ien of #52
 ;  2nd piece - ien of #2
 ;  -1 if "^" was entered
 ;
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
 ;
RXREFIL(BPS52,BPSDFN,BPSRXNO) ;
 ; Prompt for the fill# and do the rest
 ;
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
SECBIL59(MOREDATA,IEN59) ;
 ; Populate secondary billing fields in BPS TRANSACTION
 ; MOREDATA array filed into 9002313.59
 N BPTYPE,BPSTIME,BPCOB
 N AMTIEN,BPIEN1,BPIEN2,BPZ5914,BPZ,BPZ1,BPZ2,OPAMT,OPAPQ,OPAYD,OPREJ,PIEN,REJIEN,BPQ
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
SECDATA(RX,FILL,BPSPLAN,BPSPRDAT,BPSRTYPE) ;
 ;Populate array elements to resubmit SECONDARY claim.  This builds the COB data using
 ;  the secondary claim that was previously submitted.
 ;This will be called by the PRO option (BPSPRRX, BPSPRRX5) and Resubmit with Edits (BPSRES)
 ;  if it cannot build the COB claim data from the primary claim, which will only happen
 ;  if the primary claim is missing (primary claim was paper).
 ;This is also called by BPSNCPDP when the secondary data is missing.  I believe that this
 ;  will only happen for a Resubmit (RES) from the ECME User Screen.  For this process, we
 ;  also need to compile the PRIMARY BILL, insurance plan, and rate type.
 ;
 ;Input:
 ;  RX - Prescription (#52) IEN
 ;  FILL - Fill Number
 ;  BPSPLAN - Plan (#355.3) IEN, by reference
 ;  BPSPRDAT - Array with secondary data, by reference
 ;  BPSRTYPE - Rate Type (#399.3) IEN, by reference
 ;Output:
 ;  1 - Success
 ;  0 - Cannot populate array
 ;
 N IEN59SEC,BPBILL
 I '$G(RX) Q 0
 I $G(FILL)="" Q 0
 ;
 ; Get Transaction IENs for the secondary transaction
 S IEN59SEC=$$IEN59^BPSOSRX(RX,FILL,2)
 ;
 ; Get Primary Bill for the secondary claim
 S BPBILL=$$PAYBLPRI^BPSUTIL2(IEN59SEC)
 I BPBILL>0 S BPSPRDAT("PRIMARY BILL")=BPBILL
 ;
 ; Get Plan, Rate Type, and Prior Payment from the secondary transaction
 S BPSPLAN=+$P($G(^BPST(IEN59SEC,10,1,0)),U,1)
 S BPSRTYPE=+$P($G(^BPST(IEN59SEC,10,1,0)),U,8)
 S BPSPRDAT("PRIOR PAYMENT")=$P($G(^BPST(IEN59SEC,10,1,2)),U,9)
 ;
 ; Build array of COB secondary claim data from the BPS Transaction file - esg - 6/14/10
 S BPSPRDAT("337-4C")=$P($G(^BPST(IEN59SEC,12)),U,4)  ;1204 cob other payments count
 S BPSPRDAT("308-C8")=$P($G(^BPST(IEN59SEC,12)),U,5)  ;1205 other coverage code
 ;
 ; Build COB data array - esg - 6/14/10
 N COBPIEN,APDIEN,REJIEN
 K BPSPRDAT("OTHER PAYER")
 S COBPIEN=0 F  S COBPIEN=$O(^BPST(IEN59SEC,14,COBPIEN)) Q:'COBPIEN  D
 . S BPSPRDAT("OTHER PAYER",COBPIEN,0)=$G(^BPST(IEN59SEC,14,COBPIEN,0))
 . ;
 . ; Retrieve data from other payer amount paid multiple
 . S APDIEN=0 F  S APDIEN=$O(^BPST(IEN59SEC,14,COBPIEN,1,APDIEN)) Q:'APDIEN  D
 .. S BPSPRDAT("OTHER PAYER",COBPIEN,"P",APDIEN,0)=$G(^BPST(IEN59SEC,14,COBPIEN,1,APDIEN,0))
 .. Q
 . ;
 . ; Retrieve data from other payer reject multiple
 . S REJIEN=0 F  S REJIEN=$O(^BPST(IEN59SEC,14,COBPIEN,2,REJIEN)) Q:'REJIEN  D
 .. S BPSPRDAT("OTHER PAYER",COBPIEN,"R",REJIEN,0)=$G(^BPST(IEN59SEC,14,COBPIEN,2,REJIEN,0))
 .. Q
 . Q
 Q 1
 ;
PRIMDATA(RX,FILL,COBARRAY) ;
 ; Build COB data from primary claim and response
 ; This is called by PRO option (BPSPRRX, BPSPRRX5) and Resubmit with Edits (BPSRES)
 ; 
 ; Input:
 ;   RX - Prescription IEN
 ;   FILL - Fill Number
 ;   COBARRAY - Array that will be build, passed by reference
 ; Return:
 ;   0 = Invalid data (transactions, claim, or response is missing)
 ;   1 = Valid data
 ;
 I '$G(RX) Q 0
 I $G(FILL)="" Q 0
 N IEN59PR,BPSIEN,BPSCLM,BPSRESP,BPSSTAT,BIN,BPSOPDT,BPX,BPSPIEN,CNT
 ;
 ; Get primary transaction and check that is exists
 S IEN59PR=$$IEN59^BPSOSRX(RX,FILL,1)
 I '$D(^BPST(IEN59PR)) Q 0
 ;
 ; Get Claim and Response and make sure they both exist
 S BPSCLM=+$P($G(^BPST(IEN59PR,0)),U,4)
 I BPSCLM=0 Q 0
 I '$D(^BPSC(BPSCLM)) Q 0
 S BPSRESP=+$P($G(^BPST(IEN59PR,0)),U,5)
 I BPSRESP=0 Q 0
 I '$D(^BPSR(BPSRESP)) Q 0
 ;
 ; Get status of primary transaction
 S BPSSTAT=$P($$STATUS^BPSOSRX(RX,FILL,,,1),U)
 ;
 ; If the primary claim is payable, get the PRIOR PAYMENT from the primary Response record
 S COBARRAY("PRIOR PAYMENT")=""
 I $$PAYABLE^BPSOSRX5(BPSSTAT),BPSRESP S COBARRAY("PRIOR PAYMENT")=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,500)),U,9))
 ;
 ; Get Coverage Code
 I $G(COBARRAY("PRIOR PAYMENT"))>0 S COBARRAY("308-C8")="02"
 E  I BPSSTAT["E REJECTED" S COBARRAY("308-C8")="03"
 E  S COBARRAY("308-C8")="04"
 ;
 ; Get BIN from the primary claim record
 S BIN=""
 I BPSCLM S BIN=$P($G(^BPSC(BPSCLM,100)),U)
 ;
 ; Get the Other Payer Date in internal format from the primary Response record
 S BPSOPDT=""
 I BPSRESP S BPSOPDT=($P($G(^BPSR(BPSRESP,0)),U,2))\1
 ;
 ; Default the Other Payer IEN 1 since we only do secondary
 S BPSPIEN=1
 S COBARRAY("337-4C")=BPSPIEN ; Other Payer Count
 ;
 ; Set array of Other Payer Data
 K COBARRAY("OTHER PAYER")
 S COBARRAY("OTHER PAYER",BPSPIEN,0)="1^01^03^"_BIN_"^"_BPSOPDT_"^0^0"
 ;
 ; Build Paid Amounts if previous claim was paid
 I BPSSTAT["E PAYABLE",$G(COBARRAY("PRIOR PAYMENT"))]"" D
 . N BPARR,BPX D GETOPAP(BPSRESP,.BPARR)
 . S BPX=0 F CNT=0:1  S BPX=$O(BPARR(BPX)) Q:BPX=""  S COBARRAY("OTHER PAYER",BPSPIEN,"P",BPX,0)=BPARR(BPX)
 . S $P(COBARRAY("OTHER PAYER",BPSPIEN,0),U,6)=CNT
 ;
 ; Build Reject Codes if previous claims was rejected
 I BPSSTAT["E REJECTED" D
 . N BPARR,BPX D GETRJCOD(BPSRESP,.BPARR)
 . S BPX=0 F CNT=0:1  S BPX=$O(BPARR(BPX)) Q:BPX=""  S COBARRAY("OTHER PAYER",BPSPIEN,"R",BPX,0)=BPARR(BPX)
 . S $P(COBARRAY("OTHER PAYER",BPSPIEN,0),U,7)=CNT
 Q 1
 ;
GETOPAP(BPSRESP,BPSDAT) ;
 ; Get the Other Payer Amount Paid values and qualifiers
 ; Input:
 ;   BPSRESP = IEN of BPS RESPONSE file
 ;   BPSDAT(N)=Array of Paid Amount^Qualifier (passed by reference)
 ;
 I '$G(BPSRESP) Q
 I '$D(^BPSR(BPSRESP,1000)) Q
 N CNT,BPS509,BPS559,BPS558,BPS523,BPS563,BPS562,BPS521,BPSQUAL,BPSAMNT,BPSTAX,BPSOAP,BPSX
 S CNT=0
 ; Set up D.0 fields for COB segment
 S BPS509=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,500)),U,9))
 ; If Total Amount Paid is a negative number, set it to zero.
 ; Zero Pay amount is allowed
 I BPS509<0 S BPS509=0
 ;
 ; Cognitive Services Qualifier/Professional Service Fee Paid
 S BPS562=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,560)),U,2))
 I BPS562<0 S BPS562=0
 I +BPS562 S CNT=CNT+1,BPSDAT(CNT)=BPS562_U_"06"
 ;
 ; Incentive Qualifier/Incentive Amt Paid
 S BPS521=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,500)),U,21))
 I BPS521<0 S BPS521=0
 I +BPS521 S CNT=CNT+1,BPSDAT(CNT)=BPS521_U_"05"
 ; Subtract Incentive Qualifier from Paid Amount for Drug Benefit
 S BPS509=BPS509-BPS521
 ;
 ; Default all Tax values to zero for negative values
 S BPS559=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,550)),U,9)) ; Percentage Sales Tax Paid
 I BPS559<0 S BPS559=0
 S BPS558=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,550)),U,8)) ; Flat Sales Tax Paid
 I BPS558<0 S BPS558=0
 S BPS523=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,500)),U,23)) ; Amount Attributed to Sales Tax
 I BPS523<0 S BPS523=0
 ;
 ; Sales Tax Qualifier
 S BPSTAX=BPS559+BPS558-BPS523
 I BPSTAX<0 S BPSTAX=0
 I +BPSTAX S CNT=CNT+1,BPSDAT(CNT)=BPSTAX_U_"10"
 ; Subtract Sales Tax Qualifier from Paid Amount for Drug Benefit
 S BPS509=BPS509-BPSTAX
 ;
 ; Set OTHER AMOUNT PAID multiples
 S BPS563=0 F  S BPS563=$O(^BPSR(BPSRESP,1000,1,563.01,BPS563)) Q:BPS563=""  D
 . S BPSQUAL=$P($G(^BPSR(BPSRESP,1000,1,563.01,BPS563,1)),U,1)
 . ; Quit if qualifier = 99 since there is no NCPDP mapping for this qualifier
 . Q:BPSQUAL']""!(BPSQUAL=99)
 . S BPSAMNT=$$DFF2EXT^BPSECFM($P($G(^BPSR(BPSRESP,1000,1,563.01,BPS563,1)),U,2))
 . ; Default negative amounts to zero
 . I BPSAMNT<0 S BPSAMNT=0
 . I $D(BPSOAP(BPSQUAL)) S BPSOAP(BPSQUAL)=BPSOAP(BPSQUAL)+BPSAMNT
 . I '$D(BPSOAP(BPSQUAL)) S BPSOAP(BPSQUAL)=BPSAMNT
 . ; Subtract Amount if Qualifier is 01,02,03,04 or 09
 . I "0102030409"[BPSQUAL S BPS509=BPS509-BPSAMNT
 I $D(BPSOAP) D
 . S BPSX="" F  S BPSX=$O(BPSOAP(BPSX)) Q:BPSX=""  D
 . . S CNT=CNT+1,BPSDAT(CNT)=BPSOAP(BPSX)_U_BPSX
 ; Set Drug Benefit Qualifier
 I BPS509<0 S BPS509=0
 S CNT=CNT+1,BPSDAT(CNT)=BPS509_U_"07"
 Q
 ;
GETRJCOD(BPRESP,BPARR) ;
 ; Get the first five reject codes w/o getting duplicates
 ; Input:
 ;   BPSRESP = IEN of BPS RESPONSE file
 ;   BPSARR1 = Array of Reject Codes
 ;
 I '$G(BPRESP) Q
 I '$D(^BPSR(BPRESP,1000)) Q
 N BPRCNT,BPRJ,BPPOS,BPRJCOD
 ;
 ; Default BPPOS to the first transaction in the RESPONSE multiple
 ; We only want the first five reject codes and no duplicates
 S (BPRCNT,BPRJ)=0,BPPOS=1
 F  S BPRJ=$O(^BPSR(BPRESP,1000,BPPOS,511,BPRJ)) Q:+BPRJ=0  D  Q:BPRCNT>4
 . S BPRJCOD=$P($G(^BPSR(BPRESP,1000,BPPOS,511,BPRJ,0)),U)
 . Q:$L(BPRJCOD)=0
 . ; Only store if not a duplicate
 . I '$D(BPARR(BPRJCOD)) S BPRCNT=BPRCNT+1,BPARR(BPRCNT)=BPRJCOD
 Q
 ;BPSPRRX6
