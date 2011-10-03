BPSPRRX3 ;ALB/SS - ePharmacy secondary billing ;16-DEC-08
 ;;1.0;E CLAIMS MGMT ENGINE;**8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
PROMPTS(BPSPRARR) ;
 ;BPSPRARR - array to pass values determined earlier (if any) and to return user's input/corrections
 ;returns 
 ; 1  = the data is correct
 ; -1 = the data is not correct - Do not create the claim
 ;
 ; Check paramters
 I $G(BPSPRARR("PRESCRIPTION"))="" Q -1
 I $G(BPSPRARR("FILL NUMBER"))="" Q -1
 I $G(BPSPRARR("FILL DATE"))="" Q -1
 ;
 ;
 N BPQ,BPSQ,BPSPLAN,BPX,BPSDFLT,BPSSET,BPSDFN
 N BPSPIEN,BPSSET,BPCNT,BPSRJ,BPSPAID
 N BPRATTYP,BPSPDRJ,BPSPLNSL,BPX1
 ;
 S (BPQ,BPSQ)=0
 ;
 ; Other Payer IEN defaults to 1 since we don't do tertiary
 S BPSPIEN=1
 ;
 ; Get Primary BPS Transaction
 S BP59=$$IEN59^BPSOSRX(BPSPRARR("PRESCRIPTION"),BPSPRARR("FILL NUMBER"),1)
 ;
 ; Get/validate Patient DFN
 S BPSDFN=$P($G(^BPST(BP59,0)),U,6)
 I BPSDFN="" S BPSDFN=$$RXAPI1^BPSUTIL1(BPSPRARR("PRESCRIPTION"),2,"I")
 I BPSDFN="" Q -1
 ;
 ; Validate and Display current COB fields
 I $$DISPSEC(BP59,BPSDFN,.BPSPRARR)
 ;
 S BPQ=0
 I $G(BPSPRARR("PLAN"))=""!($G(BPSPRARR("RTYPE"))="")!($G(BPSPRARR("308-C8"))="") S BPQ=1
 I BPSQ=0 F BPX=4,5 I $P($G(BPSPRARR("OTHER PAYER",BPSPIEN,0)),U,BPX)="" S BPQ=1
 I BPQ=0,'$D(BPSPRARR("OTHER PAYER",BPSPIEN,"P")),'$D(BPSPRARR("OTHER PAYER",BPSPIEN,"R")) S BPQ=1
 ;
 ; Prompt to continue or not
 W !
 I BPQ=1 W !,"Required secondary claim information is missing. Enter all required information",!
 E  S BPQ=$$YESNO^BPSSCRRS("Do you want to edit this Secondary Claim Information (Y/N)","N") Q:BPQ=-1 -1 G:BPQ=0 END
 ;
 ; Prompt for Secondary Insurance Plan
 W !
 F  D  Q:BPSQ'=0
 . S BPSPLAN=$$SELECTPL^BPSPRRX1(BPSDFN,$G(BPSPRARR("FILL DATE")),.BPSPLNSL,"SECONDARY INSURANCE POLICY",$G(BPSPRARR("PLAN")))
 . I BPSPLAN=0 S BPSQ=-1 Q
 . I $P(BPSPLNSL(7),U)'=2 W !,"Must select a Secondary insurance plan." Q
 . S BPSPRARR("PLAN")=BPSPLAN
 . S BPSPRARR("INS NAME")=$P(BPSPLNSL(1),U,2)
 . S BPSQ=1
 Q:BPSQ=-1 -1
 ;
 ; Prompt for Rate Type and store in BPSPRARR("RTYPE")
 F  S BPRATTYP=$$RATETYPE^BPSPRRX2($S($G(BPSPRARR("RTYPE"))]"":BPSPRARR("RTYPE"),1:8)) Q:BPRATTYP'=""
 I BPRATTYP=-1 Q -1
 S BPSPRARR("RTYPE")=BPRATTYP
 ;
 ; Prompt for OTHER COVERAGE CODE
 S BPSSET="" D SET308(.BPSSET)
 S RETV=$$PROMPT("SRA"_U_BPSSET,"OTHER COVERAGE CODE:  ",$G(BPSPRARR("308-C8")),"Indicate whether or not the patient has other insurance coverage")
 Q:RETV<0 -1
 S BPSPRARR("308-C8")=RETV
 ;
 ; Prompt for OTHER PAYER ID
 S BPSDFLT=$P(BPSPRARR("OTHER PAYER",BPSPIEN,0),U,4)
 S RETV=$$PROMPT("FR"_U_"0:10:","OTHER PAYER ID",$G(BPSDFLT),"ID assigned to the payer") Q:RETV<0 -1
 Q:RETV=-1 -1
 S $P(BPSPRARR("OTHER PAYER",BPSPIEN,0),U,4)=RETV
 ;
 ; Prompt for OTHER PAYER DATE
 S BPSDFLT=$P(BPSPRARR("OTHER PAYER",BPSPIEN,0),U,5)
 S RETV=$$PROMPT("DR"_U_"","OTHER PAYER DATE",$$FMTE^XLFDT($G(BPSDFLT)),"Payment or denial date of the claim submitted to the other payer. Used for coordination of benefits.")
 Q:RETV=-1 -1
 S $P(BPSPRARR("OTHER PAYER",BPSPIEN,0),U,5)=RETV
 ;
 ; Prompt for Paid Amount or Reject Codes
 S BPSSET="PAID:PAID AMOUNTS;REJECT:REJECT CODES"
 S BPSDFLT=""
 I $D(BPSPRARR("OTHER PAYER",BPSPIEN,"P")) S BPSDFLT="PAID AMOUNTS"
 I $D(BPSPRARR("OTHER PAYER",BPSPIEN,"R")) S BPSDFLT=$S(BPSDFLT="PAID AMOUNTS":"",1:"REJECT CODES")
 S BPSPDRJ=$$PROMPT("SRA"_U_BPSSET,"Edit Paid Amounts or Reject Codes (PAID AMOUNTS/REJECT CODES):  ",BPSDFLT,"Edit the Paid Amounts or Reject Codes")
 Q:BPSPDRJ=-1 -1
 ;
 ; Prompt to edit paid amounts
 D:BPSPDRJ="PAID"
 . ; Remove reject codes.
 . K BPSPRARR("OTHER PAYER",BPSPIEN,"R")
 . S $P(BPSPRARR("OTHER PAYER",BPSPIEN,0),U,7)=""
 . ;
 . K BPSPAID
 . S (BPCNT,BPX,BPQ)=0
 . S BPSSET="00:BLANK;01:DELIVERY;02:SHIPPING;03:POSTAGE;04:ADMINISTRATIVE;05:INCENTIVE;06:COGNITIVE SERVICE;07:DRUG BENEFIT;08:SUM OF ALL REIMBURSEMENT;98:COUPON;99:OTHER"
 . F BPX1=0:1 S BPX=$O(BPSPRARR("OTHER PAYER",BPSPIEN,"P",BPX)) Q:'BPX  D  Q:BPQ=1
 . . S BPSQUAL=$P(BPSPRARR("OTHER PAYER",BPSPIEN,"P",BPX,0),U,2)
 . . S BPSAMT=$P(BPSPRARR("OTHER PAYER",BPSPIEN,"P",BPX,0),U,1)
 . . S BPQ=$$ASKPAID(BPSSET,BPSQUAL,BPSAMT,.BPSCNT,.BPSPAID)
 . ;
 . I 'BPQ F  S BPQ=$$ASKPAID(BPSSET,"","",.BPSCNT,.BPSPAID) Q:BPQ=1
 . ; Enter update values into the BPSPRARR array
 . K BPSPRARR("OTHER PAYER",BPSPIEN,"P")
 . S BPX=0 F BPX1=0:1 S BPX=$O(BPSPAID(1,BPX)) Q:BPX=""  D
 . . I $P(BPSPAID(1,BPX),U,2)="00" S $P(BPSPAID(1,BPX),U,2)="  "
 . . S BPSPRARR("OTHER PAYER",BPSPIEN,"P",BPX,0)=BPSPAID(1,BPX)
 . . ;
 . . ; Set the OTHER PAYER AMOUNT PAID COUNT
 . . S $P(BPSPRARR("OTHER PAYER",BPSPIEN,0),U,6)=BPX1
 . Q
 ;
 ; Edit/add reject codes
 D:BPSPDRJ="REJECT"
 . ; Remove paid amounts on the prior claim.
 . K BPSPRARR("OTHER PAYER",BPSPIEN,"P")
 . S $P(BPSPRARR("OTHER PAYER",BPSPIEN,0),U,6)=""
 . ;
 . K BPSRJ
 . S (BPCNT,BPX)=0
 . F BPX1=0:1 S BPX=$O(BPSPRARR("OTHER PAYER",BPSPIEN,"R",BPX)) Q:'BPX  D
 . . S BPSDFLT=BPSPRARR("OTHER PAYER",BPSPIEN,"R",BPX,0)
 . . S RETV=$$PROMPT("PO^9002313.93:AEMNQ","OTHER PAYER REJECT CODE",$G(BPSDFLT),"Enter the reject code returned by the previous payer")
 . . Q:RETV=-1
 . . S BPCNT=BPCNT+1
 . . S BPSRJ(BPCNT)=$P(RETV,U,2)
 . F  S RETV=$$PROMPT("PO^9002313.93:AEMNQ","OTHER PAYER REJECT CODE","","Enter the reject code returned by the previous payer") Q:RETV=-1  S BPCNT=BPCNT+1,BPSRJ(BPCNT)=$P(RETV,U,2)
 . K BPSPRARR("OTHER PAYER",BPSPIEN,"R")
 . S BPX=0 F BPX1=0:1 S BPX=$O(BPSRJ(BPX)) Q:BPX=""  D
 . . S BPSPRARR("OTHER PAYER",BPSPIEN,"R",BPX,0)=BPSRJ(BPX)
 . . ; Set the OTHER PAYER REJECT COUNT
 . . S $P(BPSPRARR("OTHER PAYER",BPSPIEN,0),U,7)=BPX1
 . Q
 ;
 I '$D(BPSPRARR("OTHER PAYER",BPSPIEN,"P")),'$D(BPSPRARR("OTHER PAYER",BPSPIEN,"R")) W !,"No Paid Amounts or Reject Codes entered" Q -1
 ;
 ; Default OTHER PAYER COVERAGE TYPE to PRIMARY
 S $P(BPSPRARR("OTHER PAYER",BPSPIEN,0),U,2)="01"
 ;
 ; Default OTHER PAYER ID QUALIFIER to BIN
 S $P(BPSPRARR("OTHER PAYER",BPSPIEN,0),U,3)="03"
 ;
END ; Prompt to continue
 W !
 I $$YESNO^BPSSCRRS("IS THIS CLAIM CORRECT?(Y/N)","Y")<1 Q -1
 Q 1
 ;
 ; 
ASKPAID(BPSSET,BPSQUAL,BPSAMT,BPSCNT,BPSPAID) ;
 N RETV1,RETV2
ASK1 S RETV1=$$PROMPT("SOA"_U_BPSSET,"OTHER PAYER AMOUNT PAID QUALIFIER:  ",$G(BPSQUAL),"Type of payment from other sources (including coupons)")
 I RETV1=-1!(RETV1="") Q 1
 I RETV1="08",$D(BPSPAID(2)) W !,"  Qualifier '08' cannot be entered with other qualifiers" G ASK1
 S RETV2=$$PROMPT("NO"_U_"0:999999:2","OTHER PAYER AMOUNT PAID",$G(BPSAMT),"Amount of any payment from other sources (including coupons)")
 I RETV2=-1!(RETV2="") Q 1
 S BPCNT=BPCNT+1
 S BPSPAID(1,BPCNT)=RETV2_U_RETV1
 S BPSPAID(2,RETV1)=""
 I RETV1="08" Q 1
 Q 0
 ;
DISPSEC(BP59,BPSDFN,BPSPRARR) ;
 ; Validate and Display the current secondary insurance information and prompt to edit.
 ; Return:  0 = Invalid data
 ;          1 = Valid data
 ;
 N BPSCOB,BPX,BPQ,BPSRET,BPSPIEN,BPSRESP,BPSOPDT,BPSINS,BPSSTAT,BPSCOV,BP592
 ; Other Payer IEN defaults to 1 since we don't do tertiary
 S BPSPIEN=1
 ; Get patient insurances
 S BPSRET=$$INSUR^IBBAPI($G(BPSDFN),$G(BPSPRARR("FILL DATE")),"E",.BPSINS,"1,7,8")
 ; Get the first Secondary insurance for default
 S (BPSCOB,BPSPRARR("PLAN"))="",(BPX,BPQ)=0
 F  S BPX=$O(BPSINS("IBBAPI","INSUR",BPX)) Q:'BPX  D  Q:BPQ
 . I $P(BPSINS("IBBAPI","INSUR",BPX,7),U)'=2 Q
 . S BPSPRARR("PLAN")=$P(BPSINS("IBBAPI","INSUR",BPX,8),U)
 . S BPSPRARR("INS NAME")=$P(BPSINS("IBBAPI","INSUR",BPX,1),U,2)
 . S BPSCOB="SECONDARY",BPQ=1
 . Q
 S BPSRET=0
 ; Get the Other Payer Date in internal format from the response
 S BPSOPDT="",BPSRESP=$P($G(^BPST(BP59,0)),U,5)
 I BPSRESP S BPSOPDT=($P($G(^BPSR(BPSRESP,0)),U,2))\1
 ; Set array of Other Payer Data
 S BPSPRARR("OTHER PAYER",BPSPIEN,0)="1^01^03^"_$G(BPSPRARR("BIN NUMBER"))_"^"_$G(BPSOPDT)_"^0^0"
 ; Get Rate Type for the Secondary Insurance
 S BP592=$$IEN59^BPSOSRX($G(BPSPRARR("PRESCRIPTION")),$G(BPSPRARR("FILL NUMBER")),2)
 S BPSPRARR("RTYPE")=$$GETRTP59^BPSPRRX5(BP592)
 I BPSPRARR("RTYPE")="" S BPSPRARR("RTYPE")=8
 ; Get Coverage Code
 S BPSSTAT=$P($$STATUS^BPSOSRX($G(BPSPRARR("PRESCRIPTION")),$G(BPSPRARR("FILL NUMBER")),,,1),U)
 I $G(BPSPRARR("PRIOR PAYMENT"))>0 S BPSCOV="02 (OTHER COVERAGE EXISTS - PAYMENT COLLECTED)"
 E  I BPSSTAT["E REJECTED" S BPSCOV="03 (OTHER COVERAGE EXISTS - THIS CLAIM NOT COVERED)"
 E  S BPSCOV="04 (OTHER COVERAGE EXISTS - PAYMENT NOT COLLECTED)"
 S BPSPRARR("308-C8")=$P(BPSCOV," ",1)
 ; Write Data
 W !!,"Data for Secondary Claim"
 W !,"------------------------"
 W !,"Insurance:  "_$G(BPSPRARR("INS NAME"))_"    COB: "_BPSCOB
 W !,"Rate Type:  "_$$GET1^DIQ(399.3,$G(BPSPRARR("RTYPE"))_",",.01,,,,)
 W !,"Other Coverage Code:  "_BPSCOV
 W !,"Other Payer Coverage Type:  01 (PRIMARY)"
 W !,"Other Payer ID Qualifier:  03 (BANK INFORMATION NUMBER (BIN))"
 W !,"Other Payer ID:  "_$G(BPSPRARR("BIN NUMBER"))
 W !,"Other Payer Date:  "_$$FMTE^XLFDT($G(BPSOPDT))
 ; Build/Write Paid Amounts if previous claim was paid
 K BPSPRARR("OTHER PAYER",BPSPIEN,"P")
 I BPSSTAT["E PAYABLE",BPSPRARR("PRIOR PAYMENT")]"" D
 . W !,"Other Payer Paid Qualifier:  08 (SUM OF ALL REIMBURSEMENT)"
 . S BPSPRARR("OTHER PAYER",BPSPIEN,"P",1,0)=$G(BPSPRARR("PRIOR PAYMENT"))_"^08"
 . W !,"Other Payer Amount Paid:  "_$G(BPSPRARR("PRIOR PAYMENT"))
 . S $P(BPSPRARR("OTHER PAYER",BPSPIEN,0),U,6)=1
 ; Build/Write Reject Codes if previous claims was rejected
 K BPSPRARR("OTHER PAYER",BPSPIEN,"R")
 I BPSSTAT["E REJECTED" D
 . N BPARR,BPX D GETRJCOD^BPSSCRU3(BP59,.BPARR,0,55,"")
 . S BPX=0 F  S BPX=$O(BPARR(BPX)) Q:BPX=""  D
 . . W !,"Other Payer Reject Code:  "_BPARR(BPX)
 . . S BPSPRARR("OTHER PAYER",BPSPIEN,"R",BPX,0)=$P(BPARR(BPX),":")
 . . S $P(BPSPRARR("OTHER PAYER",BPSPIEN,0),U,7)=BPX
 Q 1
 ;
PROMPT(ZERONODE,PRMTMSG,DFLTVAL,BPSHLP) ;
 ;prompts for selection
 ;returns selection
 ;OR -1 when timeout and uparrow
 ;
 N Y,DUOUT,DTOUT,BPQUIT,DIROUT
 N DIR
 S DIR(0)=ZERONODE
 S DIR("A")=PRMTMSG
 I BPSHLP]"" S DIR("?")=BPSHLP
 S:$L($G(DFLTVAL))>0 DIR("B")=DFLTVAL
 D ^DIR
 I (Y=-1)!$D(DIROUT)!$D(DUOUT)!$D(DTOUT) Q -1
 Q Y
 ;
 ;because the set of codes is too long to fit the MUMPS code line - use a special code to populte set of codes
SET308(BPSSET) ;
 N BPX,BPZ
 F BPX=2:1 S BPZ=$P($T(SET308C8+BPX),";;",2) Q:BPZ=""  D
 . S BPSSET=BPSSET_$P(BPZ,U)_";"
 Q
 ;
SET308C8 ;set of codes for 308-C8
 ; set of codes
 ;;00:NOT SPECIFIED
 ;;01:NO OTHER COVERAGE IDENTIFIED
 ;;02:OTHER COVERAGE EXISTS - PAYMENT COLLECTED
 ;;03:OTHER COVERAGE EXISTS - THIS CLAIM NOT COVERED
 ;;04:OTHER COVERAGE EXISTS - PAYMENT NOT COLLECTED
 ;;05:MANAGED CARE PLAN DENIAL
 ;;06:OTHER COVERAGE DENIED - NOT A PARTICIPATING PROVIDER
 ;;07:OTHER COVERAGE EXISTS - NOT IN EFFECT AT THE TIME OF SERVICE
 ;;08:CLAIM IS A BILLING FOR A COPAY
 ;;
 ;
 ;BPSPRRX3
