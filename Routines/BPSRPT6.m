BPSRPT6 ;BHAM ISC/BEE - ECME REPORTS ;14-FEB-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,5,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ;Get the Insurance Company pointer and name
 ;
 ; Returned Value -> ptr^Insurance Company Name
 ; 
INSNAM(BP59) N BPIN,BPDOS,BPDFN,BPSZZ,BP36,BPX,BPINAME,BPIBA,BP36IEN
 ;
 ;Reset Insurance
 S BP36=""
 ;
 ;First Pull From BPS Transactions
 S BPIN=+$P($G(^BPST(BP59,9)),U)
 I +BPIN D
 . S BPINAME=$P($G(^BPST(BP59,10,BPIN,0)),U,7)
 . S BPIBA=$P($G(^BPST(BP59,10,BPIN,0)),U,1)
 . S BP36IEN=$$INSPL^IBNCPDPI(BPIBA)
 . S:BP36IEN]""&BPINAME]"" BP36=BP36IEN_"^"_BPINAME
 ;If Not Found, look up using API
 I BP36="" D
 .S BPDOS=+$P($G(^BPST(BP59,12)),U,2)\1
 .I BPDOS=0 S BPDOS=+$P($G(^BPST(BP59,0)),U,8)\1
 .S BPDFN=+$P($G(^BPST(BP59,0)),U,6)
 .S BPX=$$INSUR^IBBAPI(BPDFN,BPDOS,,.BPSZZ,"1")
 .S BP36=$G(BPSZZ("IBBAPI","INSUR",1,1))
 ;
 ;If Not Found, put in MISSING INSURANCE
 I $TR(BP36,U)="" S BP36=" ^**MISSING INSURANCE**"
 ;
 Q BP36
 ;
 ;Select an Insurance Company file entry (Fileman Lookup)
 ;
 ; Returned value -> Insurance Company Name
 ; 
SELINS() N INS
 S INS=$$SELINSUR^IBNCPDPI("Select Insurance","")
 I $P(INS,U)=-1 S INS="^"
 E  S INS=$P(INS,U,2)
 Q INS
 ;
 ;Get the drug name for display
 ;
 ; Input variable ->  BP50 - Lookup to DRUG (#50)
 ;                   BPLEN - Length of the display field
 ; Returned value -> Name of the drug
 ; 
DRGNAM(BP50,BPLEN) Q $E($$DRUGDIE^BPSUTIL1(+BP50,.01,"E"),1,BPLEN)
 ;       
 ;Select a DRUG file entry (Fileman Lookup)
 ;
 ; Returned Variable -> Y
 ; 
SELDRG N DIC S DIC(0)="QEAM",DIC=50,DIC("A")="Select Drug: "
 D DRUGDIC^BPSUTIL1(.DIC)
 Q
 ;
 ;Get the drug class for display
 ;
 ; Input variable -> BP50605 - Lookup to VA DRUG CLASS (#50.605)
 ;                   BPLEN - Length of the display field
 ; Returned value -> Name of the drug class
 ;                   
DRGCLNAM(BP50605,BPLEN) N IEN,Y
 K ^TMP($J,"BPSRPT6")
 S Y=""
 I BP50605]"" D 
 .D C^PSN50P65(BP50605,"","BPSRPT6")
 .S IEN=$O(^TMP($J,"BPSRPT6",0))
 .I IEN]"" S Y=$E($G(^TMP($J,"BPSRPT6",IEN,1)),1,BPLEN)
 K ^TMP($J,"BPSRPT6")
 Q Y
 ;
 ;Select a VA DRUG CLASS file entry (Fileman Lookup)
 ;
SELDRGC N DIR,DIRUT,DTOUT,DUOUT,IEN,TOT,X
 K ^TMP($J,"BPSRPT6")
 ;
 F  D  Q:Y]""
 .K ^TMP($J,"BPSRPT6"),^TMP($J,"BPSRPT6X")
 .S DIR(0)="FO^1:35"
 .S DIR("A")="Select Drug Class"
 .S DIR("?")="Answer with VA DRUG CLASS CODE, or CLASSIFICATION. TYPE '??' FOR A LIST"
 .S DIR("??")="^D DCLIST^BPSRPT6"
 .D ^DIR
 .I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(Y)="") S Y="^" Q
 .;
 .;Get list based on original user input
 .D C^PSN50P65("",Y,"BPSRPT6X")
 .;
 .;Get list based on uppercase input
 .S Y=$$UP^XLFSTR(Y)
 .D C^PSN50P65("",Y,"BPSRPT6")
 .;
 .;Merge lists together
 .M ^TMP($J,"BPSRPT6")=^TMP($J,"BPSRPT6X")
 .K ^TMP($J,"BPSRPT6X")
 .;
 .; Reset 0 node based on combined lists
 .S Y=0 F TOT=0:1 S Y=$O(^TMP($J,"BPSRPT6",Y)) Q:'+Y
 .S ^TMP($J,"BPSRPT6",0)=TOT
 .;
 .;Check for no entries found
 .I TOT<1 W "  ??" S Y="" Q
 .;
 .;Check for Unique Entry
 .I TOT=1 D  Q
 ..S Y="",IEN=$O(^TMP($J,"BPSRPT6",0))
 ..I IEN]"" S Y=$G(^TMP($J,"BPSRPT6",IEN,1)) W $C(13),"Select Drug Class: ",Y
 .;
 .;Check for multiple entries - allow user to pick
 .I TOT>1 S Y=$$DCSEL(TOT)
 .I Y="^^" S Y=""
 .;
 Q
 ;
 ;List Entries in VA DRUG CLASS
 ;
DCLIST N CL,DTOUT,IEN,Y
 K ^TMP($J,"BPSRPT6")
 D C^PSN50P65("","??","BPSRPT6")
 ;
 ;First create new index - sorted by CLASSIFICATION
 S IEN=0 F  S IEN=$O(^TMP($J,"BPSRPT6",IEN)) Q:'IEN  D
 .S CL=$G(^TMP($J,"BPSRPT6",IEN,1)) Q:CL=""
 .S ^TMP($J,"BPSRPT6","B",CL,IEN)=$G(^TMP($J,"BPSRPT6",IEN,".01"))
 ;
 ;Now loop through and display entries
 S $X=0,$Y=0 W !,?3,"Choose from: ",!
 S (Y,CL)="" F  S CL=$O(^TMP($J,"BPSRPT6","B",CL)) Q:CL=""  D  Q:Y]""
 .S IEN="" F  S IEN=$O(^TMP($J,"BPSRPT6","B",CL,IEN)) Q:IEN=""  D  Q:Y]""
 ..W ?3,$G(^TMP($J,"BPSRPT6","B",CL,IEN)),!,?3,CL,!
 ..I $Y>19!'$Y D
 ...W ?3 R "'^' TO STOP: ",Y:$G(DTIME,300)
 ...E  S DTOUT=1
 ...W $C(13),$J("",17),$C(13)
 ...I ($G(DTOUT)=1)!($G(Y)="^") S Y="^" Q
 ...S $X=0,$Y=0
 ;
 K ^TMP($J,"BPSRPT6")
 Q
 ;
 ;Allow user to pick VA DRUG CLASS entry based on initial input
 ;
 ; Input variable - TOT -> Total entries placed in ^TMP($J,"BPSRPT6")
 ; Returned value - VA DRUG CLASSIFICATION
 ;
DCSEL(TOT) N CL,DTOUT,I,IEN,IX,Y
 ;
 ;First create new index
 F IX="B","N" K ^TMP($J,"BPSRPT6",IX)
 S Y="",IEN=0 F  S IEN=$O(^TMP($J,"BPSRPT6",IEN)) Q:'IEN  D
 .S CL=$G(^TMP($J,"BPSRPT6",IEN,1)) Q:CL=""
 .S ^TMP($J,"BPSRPT6","B",CL,IEN)=$G(^TMP($J,"BPSRPT6",IEN,".01"))
 ;
 ;Now loop through and allow one to be picked
 S (Y,CL)="" F  S CL=$O(^TMP($J,"BPSRPT6","B",CL)) Q:CL=""  D  Q:Y]""
 .S IEN="" F  S IEN=$O(^TMP($J,"BPSRPT6","B",CL,IEN)) Q:IEN=""  D  Q:Y]""
 ..S I=$G(I)+1 W !,?5,I,?9,$G(^TMP($J,"BPSRPT6","B",CL,IEN)),!,?3,CL
 ..S ^TMP($J,"BPSRPT6","N",I)=CL
 ..;
 ..;Stop after every 5 entries
 ..I I#5=0 I TOT>I D  Q:$G(Y)="^"!($G(Y)="^^")
 ...W !,"Press <RETURN> to see more, '^' to exit this list, OR"
 ...W !,"CHOOSE 1 - "_I R ": ",Y:DTIME S:'$T DTOUT=1
 ...I ($G(DTOUT)=1)!(Y="^") S Y="^^"
 ..;
 ..;Stop after last entry
 ..I I=TOT D
 ...W !,"CHOOSE 1 - "_I R ": ",Y:DTIME S:'$T DTOUT=1
 ..I ($G(DTOUT)=1)!(Y="^") S Y="^^"
 ..;
 ..;Check for valid entry
 ..I Y="^^" S Y=""
 ..I Y]"",'$D(^TMP($J,"BPSRPT6","N",Y)) W "  ??" S Y=""
 ..I Y]"",$D(^TMP($J,"BPSRPT6","N",Y)) S Y=$G(^TMP($J,"BPSRPT6","N",Y))
 ;
 Q Y
 ;
 ;Get DRUG file pointer
 ;       
 ; Return Value -> n = ptr to DRUG (#50)
 ;                 0 = Unknown
 ; 
GETDRUG(BPRX) Q +$$RXAPI1^BPSUTIL1(BPRX,6,"I")
 ;
 ;Get VA DRUG CLASS pointer
 ;       
 ; Input Variables: BP50 - ptr to DRUG (#50)
 ;
 ; Return Value -> n = ptr to VA DRUG CLASS (#50.605)
 ;                 0 = Unknown
 ;
GETDRGCL(BP50) Q $$DRUGDIE^BPSUTIL1(BP50,25)
 ;
 ;Determine whether claim was Mail, Window, or CMOP
 ;
 ; Input Variables: BPREF - refill # (0-No Refills,1-1st Refill, 2-2nd, ...) 
 ;
 ; Return Value -> M = Mail
 ;                 W = Window
 ;                 C = CMOP
 ;
MWC(BPRX,BPREF) Q $$MWC^PSOBPSU2(BPRX,BPREF)
 ;
 ;Get Patient Name
 ;
 ; Input variable -> BPDFN - ptr to PATIENT (#2)
 ; Returned value -> Patient Name (shortened)
 ; 
PATNAME(BPDFN) Q $E($P($G(^DPT(BPDFN,0)),U),1,25)
 ;
 ;Get Last 4 of SSN
 ;
 ; Input variable -> BPDFN - ptr to PATIENT (#2)
 ; Returned value -> Last 4 digits of patient's SSN
 ; 
SSN4(BPDFN) N X
 S X=$P($G(^DPT(BPDFN,0)),U,9)
 Q $E(X,$L(X)-3,$L(X))
 ;
 ;Get RX#
 ;
 ; Returned value -> RX#
 ; 
RXNUM(BPRX) Q $$RXAPI1^BPSUTIL1(+BPRX,.01,"I")
 ;
 ;Determine $Collected
 ;
 ; Returned Value -> $Collected
 ;
COLLECTD(BPRX,BPREF,BPPAYSEQ) N COL,RET
 S RET=$$BILLINFO^IBNCPDPI(BPRX,BPREF,BPPAYSEQ)
 S COL=$P(RET,U,5) I COL="0",($P(RET,U,3)=16)!($P(RET,U,3)=27) S COL=""
 I $P(RET,U,7)=1 S COL="N/A"
 Q COL_U_$P(RET,U,2)
 ;
 ;Determine Bill #
 ;
 ; Returned Value -> Bill Number
 ;
BILL(BPRX,BPREF,BPPSEQ) ;
 N BPSARR,BPSZ,IBIEN
 I BPPSEQ=1 Q $P($$BILLINFO^IBNCPDPI(BPRX,BPREF,BPPSEQ),U,1)
 I BPPSEQ=2 S BPSZ=$$RXBILL^IBNCPUT3(BPRX,BPREF,"S",,.BPSARR),IBIEN="" D  I +IBIEN>0 Q $P($G(BPSARR(IBIEN)),U,1)
 . S IBIEN=+$P(BPSZ,U,2) Q:IBIEN>0     ; get active bill first
 . S IBIEN=+$O(BPSARR(999999999),-1)   ; get most recent bill next
 . Q
 Q ""
 ;
 ;Get the Closed Claim Reason
 ;
 ; Input variable -> 0 for All Closed Claim Reasons or
 ;                   lookup to CLAIMS TRACKING NON-BILLABLE REASONS (#356.8)
 ; Returned value -> ALL or the selected Closed Claim Reason
 ; 
GETCLR(RSN) ;
 I RSN="0" S RSN="ALL"
 E  S RSN=$P($G(^IBE(356.8,+RSN,0)),U)
 Q RSN
 ;
 ;Get the Closed By Person
 ;
 ; Returned Value -> Closed By Name
 ; 
CLSBY(BP59) N BP02,CBY,Y
 S BP02=+$P($G(^BPST(BP59,0)),U,4)
 S CBY=+$P($G(^BPSC(BP02,900)),U,3)
 S Y=$$GET1^DIQ(200,CBY_",",".01")
 Q Y
 ;
 ;Get the Claim Status
 ;
 ; Input Variables: BPREF - refill # (0-No Refills,1-1st Refill, 2-2nd, ...) 
 ;
STATUS(BPRX,BPREF,BPSEQ) Q $$STATUS^BPSOSRX(BPRX,BPREF,0,,$G(BPSEQ))
 ;
 ;Elapsed Time
 ;
 ; Returned Value -> TIME - Elapsed Processing Time
 ; 
ELAPSE(BP59) Q $$TIMEDIFI^BPSOSUD($P($G(^BPST(BP59,0)),U,11),$P($G(^BPST(BP59,0)),U,8))
 ;
 ;Get RX issue date
 ;
RXISSDT(BPRX) Q +$$RXAPI1^BPSUTIL1(BPRX,1,"I")
 ;
 ;
 ;Get RX's fill date
RXFILDT(BPRX) Q +$$RXAPI1^BPSUTIL1(BPRX,22,"I")
 ;
 ;Get Refill's issue date
 ;
REFISSDT(BPRX,BPREF) Q $$REFDISDT(BPRX,BPREF)
 ;
 ;Get Refill's dispense date
 ;
REFDISDT(BPRX,BPREF) Q +$$RXSUBF1^BPSUTIL1(BPRX,52,52.1,+BPREF,10.1,"I")
 ;
 ;Get Refill's refill date
 ;
REFFILDT(BPRX,BPREF) Q +$$RXSUBF1^BPSUTIL1(BPRX,52,52.1,+BPREF,.01,"I")
 ;
 ;Get RX's release date
 ;
RXRELDT(BPRX) Q +$$RXAPI1^BPSUTIL1(BPRX,31,"I")
 ;
 ;Get Refill's release date
 ;
REFRELDT(BPRX,BPREF) Q +$$RXSUBF1^BPSUTIL1(BPRX,52,52.1,+BPREF,17,"I")
 ;
 ;See if refill exists
 ;
IFREFILL(BPRX,BPREF) Q $S(+$$RXSUBF1^BPSUTIL1(BPRX,52,52.1,+BPREF,.01,"I"):1,1:0)
 ;
 ;Get RX status
 ;
 ; Input Variables -> BP59 = ptr to BPS TRANSACTIONS
 ;                            
RXSTATUS(BP59) Q $$RXST^BPSSCRU2(BP59)
 ;
 ;Return RX Quantity (From BPS TRANSACTION)
 ;
QTY(BP59) Q +$P($G(^BPST(BP59,5)),U,1)
 ;
 ;Return NDC Number
GETNDC(BPRX,BPREF) Q $$GETNDC^PSONDCUT(BPRX,BPREF)
 ;
 ;Return Copay Status ($)
COPAY(BPRX) Q $S(+$$RXAPI1^BPSUTIL1(BPRX,105,"I"):"$",1:"")
