BPSPRRX3 ;ALB/SS - ePharmacy secondary billing ;16-DEC-08
 ;;1.0;E CLAIMS MGMT ENGINE;**8,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;External reference to file 399.3 supported by IA 3822
 ;External reference to $$INSUR^IBBAPI supported by IA 4419
 ;External reference to $$PLANEPS^IBNCPDPU supported by IA 5572
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
 N BPSPIEN,BPSSET,BPCNT,BPSRJ,BPSPAID,RETV
 N BPRATTYP,BPSPDRJ,BPSPLNSL,BPX1,BPSFIEN,BPSPSARR,BPSPSHV
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
 . S BPSPSHV=$$PAYSHTV(BPSPLAN)
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
 . ; BPS NCPDP FIELD DEFS for field 342 codes
 . S BPSSET=$$GETCDLST(342,BPSPSHV)
 . F BPX1=0:1 S BPX=$O(BPSPRARR("OTHER PAYER",BPSPIEN,"P",BPX)) Q:'BPX  D  Q:BPQ=1
 . . S BPSQUAL=$P(BPSPRARR("OTHER PAYER",BPSPIEN,"P",BPX,0),U,2)
 . . S BPSAMT=$P(BPSPRARR("OTHER PAYER",BPSPIEN,"P",BPX,0),U,1)
 . . S BPQ=$$ASKPAID(BPSSET,BPSQUAL,BPSAMT,.BPCNT,.BPSPAID)
 . ;
 . I 'BPQ F  S BPQ=$$ASKPAID(BPSSET,"","",.BPCNT,.BPSPAID) Q:BPQ=1
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
 . F BPX1=0:1 S BPX=$O(BPSPRARR("OTHER PAYER",BPSPIEN,"R",BPX)) Q:'BPX  D  Q:BPCNT>4
 . . S BPCNT=BPCNT+1 I BPCNT>4 W !,"Maximum of 5 OTHER PAYER REJECT CODES reached." Q
 . . S BPSDFLT=BPSPRARR("OTHER PAYER",BPSPIEN,"R",BPX,0)
 . . S RETV=$$PROMPT("PO^9002313.93:AEMNQ","OTHER PAYER REJECT CODE",$G(BPSDFLT),"Enter the reject code returned by the previous payer")
 . . Q:RETV=-1
 . . S BPSRJ(BPCNT)=$P(RETV,U,2)
 . I BPCNT<5 F  S RETV=$$PROMPT("PO^9002313.93:AEMNQ","OTHER PAYER REJECT CODE","","Enter the reject code returned by the previous payer") Q:RETV=-1  D  Q:BPCNT>4
 . . S BPCNT=BPCNT+1
 . . S BPSRJ(BPCNT)=$P(RETV,U,2)
 . . I BPCNT>4 W !,"Maximum of 5 OTHER PAYER REJECT CODES reached."
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
ASKPAID(BPSSET,BPSQUAL,BPSAMT,BPCNT,BPSPAID) ;
 N RETV1,RETV2,BPSX,BPSPRA,BPSQ S BPSQ=0
 I BPCNT>8 W !,"  Maximum of 9 OTHER PAYER AMOUNT PAID reached." Q 1
ASK1 S RETV1=$$PROMPT("SOA"_U_BPSSET,"OTHER PAYER AMOUNT PAID QUALIFIER:  ",$G(BPSQUAL),"Type of payment from other sources (including coupons)")
 I RETV1=-1!(RETV1="") Q 1
 I RETV1="08",$D(BPSPAID(2)) W !,"  Qualifier '08' cannot be entered with other qualifiers" G ASK1
 S RETV2=$$PROMPT("NO"_U_"0:999999.99:2","OTHER PAYER AMOUNT PAID",$G(BPSAMT),"Amount of any payment from other sources (including coupons)")
 I RETV2=-1!(RETV2="") Q 1
 ; Check for duplicate qualifiers and add Amount Paid to previous amount entered
 I $D(BPSPAID(2,RETV1)) D  Q 0
 . S BPSX="" F  S BPSX=$O(BPSPAID(1,BPSX)) Q:BPSX=""  D  Q:BPSQ
 . . I $P(BPSPAID(1,BPSX),U,2)=RETV1 D
 . . . S BPSPRA=$P(BPSPAID(1,BPSX),U),$P(BPSPAID(1,BPSX),U)=BPSPRA+RETV2,BPSQ=1
 . . . W !,"  $",$FN(RETV2,",",2)," has been added to amount $",$FN(BPSPRA,",",2)," for Qualifier ",RETV1
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
 S BPSPRARR("337-4C")=1
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
 . N BPARR,BPX D GETOPAP(BPSRESP,.BPARR)
 . S BPX=0 F  S BPX=$O(BPARR(BPX)) Q:BPX=""  D
 . . W !,"Other Payer Paid Qualifier:  "_$P($G(BPARR(BPX)),U,2)_" ("_$$TRANCODE(342,$P($G(BPARR(BPX)),U,2))_")"
 . . S BPSPRARR("OTHER PAYER",BPSPIEN,"P",BPX,0)=BPARR(BPX)
 . . W !,"Other Payer Amount Paid:  $"_$FN($P($G(BPARR(BPX)),U,1),",",2)
 . . S $P(BPSPRARR("OTHER PAYER",BPSPIEN,0),U,6)=BPX
 ; Build/Write Reject Codes if previous claims was rejected
 K BPSPRARR("OTHER PAYER",BPSPIEN,"R")
 I BPSSTAT["E REJECTED" D
 . N BPARR,BPX D GETRJCOD(BP59,.BPARR)
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
GETCDLST(FLD,VERSION) ; Returns a list of codes by field/version for use in PROMPTS
 N FILE,CSUB,VSUB,ARRAY,BPSFIEN,IEN,X,BPSSET,BPSCD,BPSV,BPSOK
 S VERSION=$S(VERSION=5.1:51,VERSION=51:51,VERSION="D.0":"D0",VERSION="D0":"D0",1:"D0")
 S FILE=9002313.94,BPSSET=""
 S BPSFIEN=$O(^BPSF(9002313.91,"B",FLD,0))
 Q:BPSFIEN="" BPSSET
 S IEN=$O(^BPS(FILE,"B",BPSFIEN,0))
 Q:IEN="" BPSSET
 S BPSCD=0 F  S BPSCD=$O(^BPS(FILE,IEN,1,BPSCD)) Q:BPSCD=""  D
 . S (BPSOK,BPSV)=0 F  S BPSV=$O(^BPS(FILE,IEN,1,BPSCD,1,BPSV)) Q:BPSV=""  D  Q:BPSOK
 . . I $P($G(^BPS(FILE,IEN,1,BPSCD,1,BPSV,0)),U)=VERSION S BPSOK=1
 . I BPSOK S ARRAY(BPSCD)=$P(^BPS(FILE,IEN,1,BPSCD,0),U,1)_U_$P(^BPS(FILE,IEN,1,BPSCD,0),U,2)
 S X=0 F  S X=$O(ARRAY(X)) Q:X=""  D
 . S BPSSET=BPSSET_$P(ARRAY(X),U)_":"_$P(ARRAY(X),U,2)_";"
 Q BPSSET
 ;
PAYSHTV(BPSPLAN) ;Get the Billing Payer Sheet version for this plan
 ; BPSPLAN = IEN to GROUP INSURANCE PLAN file #355.3
 N BPSPSH,BPSBPSH
 ; Get Payer Sheets
 S BPSPSH=$$PLANEPS^IBNCPDPU(BPSPLAN)
 ; Get Billing Payer Sheet
 I +BPSPSH S BPSBPSH=$P($P(BPSPSH,"^",2),",")
 I $G(BPSBPSH)']"" Q ""
 Q $P(^BPSF(9002313.92,BPSBPSH,1),U,2)
 ;
TRANCODE(FLD,CODE) ;CODE will be the incoming reason for NCPDP code
 N BPSFIEN,BPSDESC,BPSDIEN,IEN,FILE,CSUB,X,ARRAY
 S BPSDIEN=0
 S BPSFIEN=$O(^BPSF(9002313.91,"B",FLD,0))
 S IEN=$O(^BPS(9002313.94,"B",BPSFIEN,0))
 S FILE=9002313.94,CSUB=9002313.941
 D GETS^DIQ(FILE,IEN_",","**","IE","ARRAY")
 S X=0 F  S X=$O(ARRAY(CSUB,X)) Q:X=""  D
 . Q:ARRAY(CSUB,X,.01,"I")'=CODE
 . S BPSDESC=ARRAY(CSUB,X,1,"E")
 S:$G(BPSDESC)="" BPSDESC="Description not found for NCPDP field code"
 Q BPSDESC
 ;
GETOPAP(BPSRESP,BPSDAT) ; Get the Other Payer Amount Paid values and qualifiers
 ; BPSRESP = IEN of BPS RESPONSE file
 ; BPSDAT(N)=Paid Amount^Qualifier
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
 ; Get Reject Codes
GETRJCOD(BP59,BPARR1) ;
 N BP59DAT S BP59DAT=$G(^BPST(BP59,0))
 N BPRESP,BPPOS,BPRAR,BPRCNT,BPRX,BPRJCOD,BPRJTXT,BPRJ,BPN1
 ;pointers for RESPONSE file (#9002313.03) by pointer in TRANSACTION file #9002313.59
 ;get response and position 
 I $$GRESPPOS^BPSSCRU3(BP59,.BPRESP,.BPPOS)=0 Q
 S (BPRCNT,BPRJ,BPN1)=0
 F  S BPRJ=$O(^BPSR(BPRESP,1000,BPPOS,511,BPRJ)) Q:+BPRJ=0  D  Q:BPRCNT>4
 . S BPRJCOD=$P($G(^BPSR(BPRESP,1000,BPPOS,511,BPRJ,0)),U)
 . Q:$L(BPRJCOD)=0
 . S BPRJTXT=$$GETRJNAM^BPSSCRU3(BPRJCOD)
 . ; Remove Duplicate Reject Codes and only allow 5 max
 . S BPRCNT=BPRCNT+1,BPRAR(BPRJCOD)=BPRJTXT
 I $D(BPRAR) D
 . S BPRX="" F  S BPRX=$O(BPRAR(BPRX)) Q:BPRX=""  D
 . . S BPN1=BPN1+1,BPARR1(BPN1)=BPRAR(BPRX)
 Q
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
 ;;00:NOT SPECIFIED BY PATIENT
 ;;01:NO OTHER COVERAGE IDENTIFIED
 ;;02:OTHER COVERAGE EXISTS - PAYMENT COLLECTED
 ;;03:OTHER COVERAGE BILLED - CLAIM NOT COVERED
 ;;04:OTHER COVERAGE EXISTS - PAYMENT NOT COLLECTED
 ;;08:CLAIM IS BILLING FOR PATIENT FINANCIAL RESPONSIBILITY ONLY
 ;;
 ;
 ;BPSPRRX3
