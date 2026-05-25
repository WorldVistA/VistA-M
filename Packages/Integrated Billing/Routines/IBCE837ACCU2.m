IBCE837ACCU2 ;EDE/JWS - ACC consume X12 claim data ;
 ;;2.0;INTEGRATED BILLING;**770**;23-MAY-18;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; Reference to $$CPT^ICPTCOD in ICR #1995 (Supported)
 ;
AUTH(IBIFN,ERRMSG,IBMRANOT) ; Entry Point
 ; This procedure's job is to authorize this bill.  The manual
 ; process to authorize a bill is found in routine IBCB1.  This
 ; routine borrows heavily from that routine.
 ;
 ; *** Any changes here should be considered also in IBCB1 ***
 ;
 ;
 ; Input
 ;    IBIFN - internal bill#
 ;    IBMRANOT - 1 indicates process is NOT from MRA
 ;
 ; Output
 ;    ERRMSG - optional output parameter, passed by reference
 ;           - error message text
 ;
 N IBTXSTAT,IB364,PRCASV,DFN,STSMSG,DIE,DA,DR,IBYY
 ;
 ; Check the bill, make sure the current status is valid
 S IBIFN=+$G(IBIFN),ERRMSG=""
 ; Update the review status for all EOB's on file
 D STAT^IBCEMU2(IBIFN,3)     ; Accepted - Complete EOB
 ;
 ; Checks for need to add any codes to bill for EDI (call in quiet mode)
 D AUTOCK^IBCEU2(IBIFN,1)
 ;
 ; Calculate transmittable status
 ;   0 = not transmittable
 ;   1 = yes, live transmittable
 ;   2 = yes, test transmittable
 ; P432 add MRANOT flag so it will create new entry in trans file for non-MRA's
 S IBTXSTAT=+$$TXMT^IBCEF4(IBIFN,,$G(IBMRANOT))
 ;
 ; If transmittable, add this bill to the bill transmission file
 I IBTXSTAT D  I ERRMSG'="" G AUTHX
 . S IB364=$$ADDTBILL^IBCB1(IBIFN,IBTXSTAT)
 . Q
 ;
 ; Pass completed bill to Accounts Receivable (quietly)
 I $G(IBMRANOT)'=1 D ARPASS^IBCB1(IBIFN,0) I '$G(PRCASV("OKAY")) S ERRMSG="Error while passing bill to A/R." G AUTHX
 ;
AUTHX ;
 Q
 ;
SFRP ;check service facility and rendering provider
 ;if no service facility passed in X12, use original billing provider, per TR3 guides
 ;I '$D(^TMP("IB837ACC",$J,1,77)) D
 ;. N XNPI
 ;. S XNPI=$P($G(^TMP("IB837ACC",$J,1,85)),"^")
 ;. S OK=$$CHK35593^IBCE837ACCU(XNPI) I 'OK D UP^IBCE837ACC(IBX12,5,5,"NO SERVICE FACILITY IN X12 DATA") Q
 ;. M ^TMP("IB837ACC",$J,1,77)=^TMP("IB837ACC",$J,1,85)
 ;. Q
 ; if no rendering provider in X12, use original billing provider, per TR3 guides
 ;I '$D(^TMP("IB837ACC",$J,1,82)) D
 ;. N XNPI
 ;. S XNPI=$P($G(^TMP("IB837ACC",$J,1,85)),"^")
 ;. S OK=$$CHK35593^IBCE837ACCU(XNPI) I 'OK D UP^IBCE837ACC(IBX12,5,4,"NO RENDERING PROVIDER IN X12 DATA") Q
 ;. M ^TMP("IB837ACC",$J,1,82)=^TMP("IB837ACC",$J,1,85)
 ;. Q
 Q
 ;
SW(IBINS,IBFT) ; check file 364.8
 ;Prevent claims going out via EDI with NOEXC Payer ID;need function to check file 364.8
 N IBPID,OK,IB3648,IB3648FT,IB3648TF,IBTPAID,IBEXSV
 ; get payer id for claim COB value
 S IBPID=$$PAYERID(IBINS,IBFT)
 ; if no payer id, quit not allowed for edi
 I IBPID="" Q 0
 ; if Primary Payer ID, CI5-3 is not in the PayerIDSwitch file, send as is.
 S (OK,IB3648)=0 F  S IB3648=$O(^IBA(364.8,"B",IBPID,IB3648)) Q:IB3648=""  D  Q:OK
 . ; has entry been deactivate or flagged as deleted
 . I $P($G(^IBA(364.8,IB3648,0)),"^",9)=1 Q
 . S IB3648FT=$P($G(^IBA(364.8,IB3648,0)),"^",4)
 . I IB3648FT'=1,IBFT'=IB3648FT Q
 . S IB3648TF=$P($G(^IBA(364.8,IB3648,0)),"^",8)
 . ;jws;4/20/25;can't do this check, no claim created yet, so no IBIEN value
 . ;I $$PROD^XUPROD(1),'+$$TEST^IBCEF4(IBIEN),IB3648TF Q   ;ICR 4440 (Supported)
 . S OK=1
 . Q
 ; if no entry found in COB-SWITCH file, quit not allowed for edi
 I 'IB3648 Q 0
 S IBEXSV=$P($G(^IBA(364.8,IB3648,0)),"^",11)
 ; if entry in PAYER ID - COB SWITCH file is found for all form types or specific form, quit 1 (approved for EDI)
 I IBEXSV=1!(IBEXSV=IBFT) Q 1
 ; otherwise, quit not allowed for EDI
 Q 0
 ;
PAYERID(IBINS,IBFT) ;
 N IBINST,IBEBI
 S IBINST=$S(IBFT=3:4,IBFT=7:15,1:2)
 S IBEBI=$P($G(^DIC(36,IBINS,3)),U,IBINST)
 S IBEBI=$$UP^XLFSTR(IBEBI)
 Q IBEBI
 ;
24 ;LOOP 24
 ;SVx segments are service lines, SV1 = prof, SV2 = inst, SV3 = dental and 1st cpt code, SV5 - durable medical equip
 I $E(SEG,1,2)="SV" D  Q
 . ;JWS;9/24/25;EBILL-6055;check procedure codes if surgical range 10000 thru 69999
 . I $E(SEG,1,3)="SVD" Q
 . N XIBPC,XIBMOD,I,X1
 . S ^TMP("IB837ACC",$J,"L",IBSLINE,$P(ARG(IBSEG),"*"))=ARG(IBSEG)
 . S XIBPC=$P($P(ARG(IBSEG),":",2),"*")
 . ;JWS;10/9/25;EBILL-6111;check modifiers
 . I $E(SEG,1,3)="SV2" S XIBMOD=$P($P(ARG(IBSEG),"*",3),":",3,6)
 . E  S XIBMOD=$P($P(ARG(IBSEG),"*",2),":",3,6)
 . I $G(IBFT)="" D FT^IBCE837ACC3($S($E(ARG(IBSEG),3)=1:2,$E(ARG(IBSEG),3)=2:3,$E(ARG(IBSEG),3)=3:7,1:""))
 . I $G(IBCPT)="" S IBCPT=XIBPC
 . I $G(IBFT)=3,$$OPPROV^IBCE837ACC3(XIBPC) S $P(^TMP("IB837ACC",$J),"^",45)=1
 . ;JWS;10/9/25;EBILL-6111;check modifiers
 . F I=1:1:$L(XIBMOD,":") S X1=$P(XIBMOD,":",I) I X1'="" D
 .. N X2,XPN
 .. S X2=$$GETMOD^IBCE837ACC4(X1)
 .. I X2 Q
 .. S XPN=$P($$CPT^ICPTCOD(XIBPC),"^",3)  ;ICR #1995 (Supported)
 .. S X2N=$$AMBMOD^IBCE837ACC3($E(X1))_" to "_$$AMBMOD^IBCE837ACC3($E(X1,2))
 .. D UP^IBCE837ACC(IBX12,111,5,XIBPC_" "_XPN_": "_X1_" "_X2N)
 .. Q
 . Q
 I $E(SEG,1,4)="CR1*" Q  ;amb info - not done at line level for VA
 I $E(SEG,1,4)="CR3*" S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",8)=$P(ARG(IBSEG),"*",2,4) Q  ;durable med equip cert
 I $E(SEG,1,4)="CRC*" D  Q
 . I SEG2=70 S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",7)=$P(ARG(IBSEG),"*",2,4) Q  ;hospice
 . I SEG2="09" S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",9)=$P(ARG(IBSEG),"*",2,5) Q  ;cond indicator/dme
 ; get date of service from 1st service line
 I $E(SEG,1,4)="DTP*" D  Q
 . I SEG2=472 D  Q
 .. N IBXDOS
 .. I $P(ARG(IBSEG),"*",4)="" Q
 .. S IBXDOS=3_$E($P(ARG(IBSEG),"*",4),3,8),$P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",14)=IBXDOS
 .. I $G(IBDOS)="" S (IBDOS,IBLDOS)=IBXDOS D SET^IBCE837ACC1(IBDOS,8),SET^IBCE837ACC1(IBLDOS,39) Q
 .. I $G(IBXDOS)>IBDOS S IBLDOS=IBXDOS D SET^IBCE837ACC1(IBLDOS,39)
 .. Q
 . I SEG2=441!(SEG2=139) S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^")=$P(ARG(IBSEG),"*",2),$P(^(0),"^",2)=$P(ARG(IBSEG),"*",4) Q
 . I SEG2=452 D SETL^IBCE837ACC3(3) Q
 . I SEG2=446 D SETL^IBCE837ACC3(4) Q
 . I SEG2=196 D SETL^IBCE837ACC3(5) Q
 . I SEG2=198 D SETL^IBCE837ACC3(15) Q
 . I SEG2=607 S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",10)=$P(ARG(IBSEG),"*",4) Q  ;certification revision/recert date
 . I SEG2=463 S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",11)=$P(ARG(IBSEG),"*",4) Q  ;DME begin therapy date
 . I SEG2=461 S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",12)=$P(ARG(IBSEG),"*",4) Q  ;DME last cert date
 . Q
 I $E(SEG,1,4)="REF*" D  Q
 . I SEG2="VY" S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",13)=$P(ARG(IBSEG),"*",3) Q  ;link sequence number - pharmacy
 . I SEG2="XZ" S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",13)=$P(ARG(IBSEG),"*",3) Q  ;pharmacy prescription#
 . Q
 I $E(SEG,1,4)="PWK*" Q
 I $E(SEG,1,3)="K3*"  Q
 I $E(SEG,1,4)="NTE*" D  Q
 . I SEG2="TPO" Q
 . N I
 . F I=1:1 I '$D(^TMP("IB837ACC",$J,"L",IBSLINE,"NTE",SEG2,I)) S ^(I)=$P(ARG(IBSEG),"*",3) Q
 . Q
 I $E(SEG,1,4)="HCP*" D  Q
 . S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",6)=$P(ARG(IBSEG),"*",3)  ;line level paid amt
 . I '$G(IBACCRPC1) Q
 . N IBIEN
 . N FDA,ERROR,DA,D0,DR,DIE,DIC,DI,DQ,DD,DINUM,DLAYGO,DTOUT,DUOUT
 . S IBIEN="+1,"_IBX12_","
 . S FDA(364.96,IBIEN,.01)=IBSLINE
 . S FDA(364.96,IBIEN,.02)=$P(ARG(IBSEG),"*",3)
 . D UPDATE^DIE(,"FDA","IBIEN","ERROR")
 . Q
 ;
 I $E(SEG,1,4)="LIN*" S ^TMP("IB837ACC",$J,"L",IBSLINE,"LIN")=$P(ARG(IBSEG),"*",3,4) Q  ;pharmacy
 I $E(SEG,1,4)="CTP*" S ^TMP("IB837ACC",$J,"L",IBSLINE,"CTP")=$P(ARG(IBSEG),"*",5,6) Q  ;drug quantity
 I $E(SEG,1,4)="NM1*" D  Q
 . I SEG2=82 D  Q  ;NM101='82' - rendering provider
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other payer rendering provider
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. ;11/24/25;JWS;EBILL-6206;add error 27 for missing taxonomy
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),82,IBSLINE) I OK<1 D UP^IBCE837ACC(IBX12,$S(OK=-1:27,1:4),5,IBPN1_":"_$P(ARG(IBSEG),"*",10)) Q
 .. S ^TMP("IB837ACC",$J,"L",IBSLINE,1,82)=$P(ARG(IBSEG),"*",10)_"^"_IBPN1_"^"_$S(OK=1:355.93,1:200)
 .. Q
 . I SEG2=72 D  Q   ;NM101='72' - operating physician
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other provider
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),72,IBSLINE) I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10)) Q
 .. S ^TMP("IB837ACC",$J,"L",IBSLINE,1,72)=$P(ARG(IBSEG),"*",10)_"^"_IBPN1_"^"_$S(OK=1:355.93,1:200)
 .. Q
 . I SEG2="DQ" D  Q  ;NM101='DQ' = supervising provider
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other payer supervising provider
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),"DQ",IBSLINE) I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10)) Q
 .. S ^TMP("IB837ACC",$J,"L",IBSLINE,1,"DQ")=$P(ARG(IBSEG),"*",10)_"^"_IBPN1_"^"_$S(OK=1:355.93,1:200)
 .. Q
 . I SEG2="ZZ" D  Q   ;NM101='ZZ' - other operating physician
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other provider
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),"ZZ",IBSLINE) I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10)) Q
 .. S ^TMP("IB837ACC",$J,"L",IBSLINE,1,"ZZ")=$P(ARG(IBSEG),"*",10)_"^"_IBPN1_"^"_$S(OK=1:355.93,1:200)
 .. Q
 . I SEG2="DD" D  Q   ;NM101='DD' - assistant surgeon
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other provider
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),"DD",IBSLINE) I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10)) Q
 .. S ^TMP("IB837ACC",$J,"L",IBSLINE,1,"DD")=$P(ARG(IBSEG),"*",10)_"^"_IBPN1_"^"_$S(OK=1:355.93,1:200)
 .. Q
 . I SEG2="DN" D  Q  ;referring provider
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other payer referring provider
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. ;11/24/25;JWS;EBILL-6206;add error 27 for missing taxonomy
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),"DN",IBSLINE) I OK<1 D UP^IBCE837ACC(IBX12,$S(OK=-1:27,1:4),5,IBPN1_":"_$P(ARG(IBSEG),"*",10)) Q
 .. ;JWS;IB*2.0*770v11;11/11/24;EBILL-3551;address NOT ON FILE name issue
 .. I $F(IBPN1,"NOT ON FILE") S IBPN1=$G(IBPN2)
 .. S ^TMP("IB837ACC",$J,"L",IBSLINE,1,"DN")=$P(ARG(IBSEG),"*",10)_"^"_IBPN1_"^"_$S(OK=1:355.93,1:200)
 .. Q
 . I SEG2="QB" Q
 . I SEG2="PW" D NEXT Q  ;VistA does not send Ambulance info at line level
 . I SEG2=45 D NEXT Q  ;VistA does not send Ambulance info at line level
 . I SEG2=77 D NEXT Q  ;service facility - not used at line level for VA
 . I SEG2="DK" D NEXT Q
 . Q
 I $E(SEG,1,7)="PRV*PE*" Q  ;rendering provider specialty info
 I $E(SEG,1,7)="PRV*AS*" Q  ;assistant surgeon specialty info
 I $E(SEG,1,4)="SVD*" Q
 I $E(SEG,1,3)="LQ*" Q
 I $E(SEG,1,4)="FRM*" Q
 I $E(SEG,1,4)="TOO*" D  Q
 . F I=1:1:32 I '$D(^TMP("IB837ACC",$J,"L",IBSLINE,"TOO",I)) S ^(I)=ARG(IBSEG) Q
 . Q
 I $E(SEG,1,7)="QTY*PT*" Q
 I $E(SEG,1,7)="QTY*FL*" Q
 I $E(SEG,1,4)="MEA*" Q
 I $E(SEG,1,4)="CN1*" Q
 I $E(SEG,1,4)="PS1*" Q
 Q
 ;
NEXT ;
 S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N3*" S IBI=IBI+1
 S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N4*" S IBI=IBI+1
 Q
 ;
