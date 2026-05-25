IBCE837ACC ;EDE/JWS - ACC consume X12 claim data ;
 ;;2.0;INTEGRATED BILLING;**770**;23-MAY-18;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to D DUZ^XUP(IBREG) in ICR #4129
 ; Reference to $P($G(^DPT(IBPATIEN,"ENR")),"^") in ICR ***NEW*** (Pending)
 ; Reference to $P($G(^DGEN(27.11,IBPGIEN,0)),"^",7) in ICR #5158
 ; Reference to ENCODE^XLFJSON in ICR #6682
 Q
 ;
POST(RESULT,ARG) ;Entry point to consume Community Care X12 Claim data
 ; Input: ARG
 N DUZ,IBPAYERID,IBPATICN,IBAUTH,IBREF
 N I,X,Y,IBND,ERROR,IBX12IEN,IBSITE,IBX12,IBSEG,IBIO,IBSLINE,LOOP,IBI,IBFT,IBREFD9,IBDUP,OK,IBNOTE,IBREG,IBACCRPC
 N IBDA,IBDOB,IBPT,IBPN,DA,DIE,DR,DIC,DOB,IBACCRPC1
 N IBPDX,IBDOS,IBLDOS,IBPATSSN,IBPNPI,IBCPT,IBPATFN,IBPATLN,IBPATMN
 N IBSPID,IBPATIEN,IBPN1,IBSEGN,IBTNUM,VADM,IBPN2,IBX
 N DA,DD,DIC,DO,DINUM,DLAYGO,DTOUT,DUOUT,RES,X,Y,DOB
 K RESULT
 D DTNOLF^DICRW
 K ^TMP("IBCE837ACC",$J) ; used for return message to TAS API
 K ^TMP("IB837ACC",$J) ; use this global to save claim info that will be used to create the K# in file 399
 I $D(ARG)'>1 S ^TMP("IBCE837ACC",$J,"Status")="0^Invalid or no data passed to VistA." G FINISH
 ; get AUTHORIZER,IB ACC user to begin claim creation process
 ; Change the DUZ to be this user.
 ; *** Integration Agreement 4129 - Activated on 30-June-2003 ***
 S IBACCRPC1=1
 S IBREG=$$IBREG()
 D DUZ^XUP(IBREG)  ; IA#4129
 D NOW^%DTC
 S Y=% D DD^%DT S IBND=%
 S IBDA(364.9,"+1,",.01)=IBND
 K ERROR
 D UPDATE^DIE(,"IBDA","IBX12IEN","ERROR")
 I $D(ERROR) S ^TMP("IBCE837ACC",$J,"Status")="0^Problem interpreting X12 data" G FINISH
 ;JWS;IB*2.0*770v10;EBILL-3551;10/24/24;get site/division identifier from JSON data received
 S IBSITE(1)=$G(ARG("stationDiv"))
 S IBSITE=$$DIV(IBSITE(1))
 S IBX12=IBX12IEN(1),IBSEG="",IBIO="O",LOOP=1
 F IBI=1:1 S IBSEG="SEG"_IBI Q:'$D(ARG(IBSEG))  D
 . ;JWS;EBILL-6035;IB*2.0*770v46;semi-colon issue in billing provider name, change to space ' '
 . S ARG(IBSEG)=$TR(ARG(IBSEG),">;",": ") ; colon (:) is a reserved character in JSON, so data is coming over with > delimiter for sub-fields
 . N DA,DD,DIC,DO,DINUM,DLAYGO,DTOUT,DUOUT,RES,X,Y,DOB,SEG,SEG2,IBPN2
 . S DA(1)=IBX12,DLAYGO=364.9001,DIC(0)="L",DIC="^IBA(364.9,"_DA(1)_",1,",X=ARG(IBSEG)
 . D FILE^DICN S RES=+Y K DD,DO
 . S SEG=$P(ARG(IBSEG),"*",1,3),SEG2=$P(SEG,"*",2)
 . ; skip ST (transaction set header)
 . I $E(SEG,1,3)="ST*" Q  ;trans set header
 . I $E(SEG,1,4)="BHT*" Q
 . I $E(SEG,1,3)="SE*" Q  ;trans set trailer
 . I $E(SEG,1,3)="HL*" D  Q
 .. S LOOP=$P(ARG(IBSEG),"*",4)  ;20=information source, 22=subscriber , 23=patient/dependent
 .. I LOOP=20 S LOOP="20^IBCE837ACC1" Q
 .. I LOOP=22 S LOOP="22^IBCE837ACC1" Q
 .. I LOOP=23 S LOOP="23^IBCE837ACC1" Q
 .. Q
 . I $E(SEG,1,3)="LX*" D  Q
 .. S IBSLINE=$P(ARG(IBSEG),"*",2),LOOP="24^IBCE837ACC3"
 .. ;JWS;12/4/24;IB*2.0*770v15;EBILL-4618;adding line payment amounts to encounter
 .. N X,IBIEN
 .. S X=$G(ARG(IBSLINE_"_SVC03")) I X="" Q
 .. N FDA,ERROR,DA,D0,DR,DIE,DIC,DI,DQ,DD,DINUM,DLAYGO,DTOUT,DUOUT
 .. S IBIEN="+1,"_IBX12_","
 .. S FDA(364.96,IBIEN,.01)=IBSLINE
 .. S FDA(364.96,IBIEN,.02)=$J(X,"",2)
 .. D UPDATE^DIE(,"FDA","IBIEN","ERROR")
 .. S $P(^TMP("IB837ACC",$J,"L",IBSLINE,0),"^",6)=X
 .. Q
 . I $E(SEG,1,4)="CAS*" Q  ;skip all adjustment segments
 . I $E(SEG,1,4)="AMT*" Q  ;skip all payor paid amt segments
 . I $E(SEG,1,3)="OI*" Q  ;other insurance info
 . I $E(SEG,1,4)="MOA*" Q  ;adj info
 . I $E(SEG,1,4)="MIA*" Q  ;inpatient adjudication info
 . I $E(SEG,1,7)="NM1*41*" Q  ;submitter
 . I $E(SEG,1,7)="PER*IC*" Q  ;contact info - skip all,$G(LOOP)=1 Q
 . I $E(SEG,1,7)="NM1*40*" Q  ;skip receiver segments
 . I +$G(LOOP)>1 S:$E(SEG,1,4)="CLM*" LOOP="23^IBCE837ACC1" D @LOOP Q
 . Q
 ;
ALL ;entry point for auth/create function
 I $G(IBPATIEN) D PCP^IBCE837ACCU(IBPATIEN,$G(IBFT))
 N IBER,IBERRMSG,IBIFN
 I $G(IBFT)="" D UP(IBX12,25,5,""),STAT(IBX12,2) D  Q:'$G(IBACCRPC1) 0  G FINISH
 . S ^TMP("IBCE837ACC",$J,"Status")="1^X12 claim data received, but appears incomplete."
 . Q
 ;JWS;EBILL-3551;11/1/2024;IB*2.0*770v10;if patient is not found, then added, and encounter is re-processed, need to load patient link
 I $G(IBPATIEN) D
 . N DA,D0,DR,DIE,DIC,DI,DQ,DD,DINUM,DLAYGO,DTOUT,DUOUT
 . S DA=IBX12
 . S DR="2.01////"_IBPATIEN
 . S DIE="^IBA(364.9,"
 . D ^DIE
 . Q
 ; below will create fields used for worklist landing page(s), routing info, etc...
 D
 . I $G(IBREFD9)'="",$D(^IBA(364.9,"D",IBREFD9)) S IBDUP=1
 . N DA,D0,DR,DIE,DIC,DI,DQ,DD,DINUM,DLAYGO,DTOUT,DUOUT
 . S DA=IBX12
 . ;S DR=".02////"_IBPATLN_";.03////"_IBPATFN_";.04////"_IBPATMN_";.1////"_IBDOB_";.11////"_$G(IBPATSSN)_";.06////"_$G(IBFT)_";.05////"_IBIO
 . ;JWS;12/29/25;EBILL-6340;remedy semi-colon failure potential
 . S DR=".02////^S X=IBPATLN;.03////^S X=IBPATFN;.04////^S X=IBPATMN;.1////"_$G(IBDOB)_";.11////"_$G(IBPATSSN)_";.06////"_$G(IBFT)_";.05////"_IBIO
 . S DR=DR_";.12////"_$G(IBDOS)_";.13////"_$G(IBCPT)_";.14////"_$G(IBPDX)_";.15////"_$G(IBREFD9)
 . I $G(IBACCRPC1) D
 .. N X,IBPAY
 .. S DR=DR_";.16////0;.2////"_IBSITE_";.24////"_IBSITE(1)
 .. ;JWS;8/14/25;EBILL-5876; don't extract dups;770v39
 .. I '$G(IBDUP) S DR=DR_";.21////1"
 .. ;JWS;12/4/24;IB*2.0*770v15;EBILL-4618;adding payment and charge amounts to encounter
 .. S X=0 F  S X=$O(^TMP("IB837ACC",$J,"L",X)) Q:X=""  S IBPAY=$G(IBPAY)+$P($G(^(X,0)),"^",6)
 .. ;JWS;EBILL-4922;IB*2.0*770v18;add payer claim control number to encounter
 .. S DR=DR_";.27////"_$J($G(IBPAY),"",2)_";.28////"_$J($P($G(^TMP("IB837ACC",$J)),"^",5),"",2)_";.29////"_$P($G(^TMP("IB837ACC",$J)),"^",44)
 . I $G(IBPT)'="" S DR=DR_";.08////"_IBPT_";.07////"_IBPN_";.09////"_$G(IBPNPI)
 . ;JWS;11/13/24;EBILL-3551;IB*2.0*770v11;add Service Facility name [25] and NPI [26] to encounter 0 node
 . I $D(^TMP("IB837ACC",$J,1,77)) S DR=DR_";.25////"_$P($G(^(77)),"^",2)_";.26////"_$P($G(^(77)),"^")
 . S DIE="^IBA(364.9,"
 . D ^DIE
 . Q
 ;JWS;2/4/25;EBILL-3551;enter previous activity entry for all encounters
 I $G(IBACCRPC1) D
 . N DA,FDA,ERROR,IBIENA,DA,D0,DR,DIE,DIC,DI,DQ,DD,DINUM,DLAYGO,DTOUT,DUOUT
 . S IBIENA="+1,"_IBX12_","
 . S FDA(364.94,IBIENA,.01)=IBND
 . S FDA(364.94,IBIENA,.02)=DUZ
 . S FDA(364.94,IBIENA,.03)=$O(^IBA(364.92,"B",1000,0))
 . D UPDATE^DIE(,"FDA","IBIENA","ERROR")
 . Q
 I $G(IBACCRPC1),$G(IBDUP) D  G FINISH
 . N IBIENA,FDA,ERROR,DA,D0,DR,DIE,DIC,DI,DQ,DD,DINUM,DLAYGO,DTOUT,DUOUT
 . D UP(IBX12,17,5,""),STAT(IBX12,2)
 . S ^TMP("IBCE837ACC",$J,"Status")="1^Duplicate claim (REF*D9) : "_$G(IBREFD9)
 . K DA
 . S IBIENA="+1,"_IBX12_","
 . S FDA(364.94,IBIENA,.01)=IBND
 . S FDA(364.94,IBIENA,.02)=DUZ
 . S FDA(364.94,IBIENA,.03)=$O(^IBA(364.92,"B",1001,0))
 . D UPDATE^DIE(,"FDA","IBIENA","ERROR")
 . Q
 I +$G(IBPATIEN) D
 . S OK=$$CHKINS^IBCE837ACCU(IBPATIEN,$G(IBDOS),$G(IBFT),.IBNOTE)
 . ;JWS;IB*2.0*770v4; if no OHI, then close encounter
 . I OK=3 D UP(IBX12,3,5,""),STAT(IBX12,2)  ; no OHI on file
 . ;JWS;7/22/25;EBILL-5677;if Combat Vet, check combat vet end date and if expired, remove SC failure reason
 . ;N IB36491 S IB36491=$O(^IBA(364.91,"B",21,0)) I 'IB36491 Q
 . ;S IBX=$O(^IBA(364.9,IBX12,5,"B",IB36491,0)) I IBX D
 . ;. S IBX1=$$CVEDT^IBACV(IBPATIEN,IBDOS)
 . ;. I $P(IBX1,"^")=0 S DA(1)=IBX12,DIK="^IBA(364.9,"_DA(1)_",5,",DA=IBX D ^DIK
 . Q
 . ; check priority group;5/21/25;JWS;EBILL-5447;remove priority group check
 . ;S OK=$$CHKPG^IBCE837ACC2A(IBPATIEN,.IBNOTE)
 . ;I 'OK D UP(IBX12,6,5,IBNOTE)
 . ;JWS;2/18/25;EBILL-4972;IB*2.0*770v20;allow to skip sc/sa (all RUR reasons) failure reasons
 . ;I OK=2,'$P($G(^IBA(364.9,IBX12,0)),"^",31) D UP(IBX12,10,5,IBNOTE)
 ; if inpatient claim, set exception
 ; JWS;10/30/2025;EBILL-5763;process inpatient CMS-1550 professional claims without PTF
 ; I $G(IBIO)="I",'$$ACCFT^IBCE837ACC2A($P($G(^TMP("IB837ACC",$J)),"^",6),IBFT) D UP(IBX12,7,5,"")
 I $G(IBIO)="I" D UP(IBX12,7,5,"")
 ; perform CPT check/changes for Medicare Primary claims, skip Dental
 I $G(IBFT)'=7 D PS^IBCE837ACC4
 S OK=$$EX^IBCE837ACC3()
 I $P(OK,"^",2)>0 D  I OK="END" Q:'$G(IBACCRPC1) 0  G FINISH
 . I $G(IBACCRPC1) S ^TMP("IBCE837ACC",$J,"Status")="1^X12 claim data received, claim determined non-billable."
 . N IBIENA,FDA,ERROR,DA,D0,DR,DIE,DIC,DI,DQ,DD,DINUM,DLAYGO,DTOUT,DUOUT
 . ;JWS;7/2/25;EBILL-5531;procedures with Q1 modifier are non-billable or EBILL-5534 procedures determined non-billable
 . I $P($P($G(^TMP("IB837ACC",$J)),"^",2),"*",3)="M" D UP(IBX12,24,5,"")
 . I $P($P($G(^TMP("IB837ACC",$J)),"^",2),"*",3)="C" D UP(IBX12,26,5,"")
 . I $P(OK,"^")'=$P(OK,"^",2) Q  ;not all cpts are nonbillable
 . S OK="END"
 . D STAT(IBX12,2)
 . ;JWS;2/4/25;EBILL-3551;remove unbillable activity code
 . Q
 ;JWS;EBILL-4022;IB*2.0*770vxx;start;check for VistA claim / CC Encounter duplicates
 ;S OK=$$CHKDUP^IBCE837ACC4(IBX12,IBPATIEN,IBDOS,IBFT)
 ;I OK D  Q:'$G(IBACCRPC1) 0  G FINISH
 ;. D UP(IBX12,108,5,""),STAT(IBX12,2)
 ;. I $G(IBACCRPC1) S ^TMP("IBCE837ACC",$J,"Status")="1^X12 claim data received, encounter already billed."
 ;. Q
 ;JWS;EBILL-4022;end
 ; add Medicare excluded services check here - if Medicare and one of the excluded services, set [41] of ^TMP("IB837ACC",$J) = payer sequence "S"
 ; if secondary payer is NOT in the COB switch table as enabled for COB EDI billing, create claim but set to force print
 I $P(^TMP("IB837ACC",$J),"^",40) D
 . N IBCOB
 . I $P(^TMP("IB837ACC",$J),"^",3)'="" S IBCOB=$$SW^IBCE837ACCU2($P($P(^TMP("IB837ACC",$J),"^",3),"*"),IBFT) I 'IBCOB D
 .. ;set the error status in X12 file, set force print
 .. S $P(^TMP("IB837ACC",$J),"^",42)=1
 .. D UP(IBX12,102,5,""),USERUP(IBX12)
 .. I $G(IBACCRPC1) S ^TMP("IBCE837ACC",$J,"Status")="1^X12 claim data received, claim contains Medicare Excluded Services."
 .. Q
 . S $P(^TMP("IB837ACC",$J),"^",41)="S"
 ;JWS/12/13/24;EBILL-3551;IB*2.0*770v16;below should fall thru and allow claim to be created, but FORCE LOCAL PRINT should be set
 ;I 'OK D UP(IBX12,102,5,""),USERUP(IBX12) ;;Q:'$G(IBACCRPC1) 0  G FINISH
 ;JWS;EBILL-4398;IB*2.0*770v7;moved below from before check for excluded services and cpt exceptions to after
 I $O(^IBA(364.9,IBX12,5,0)) S OK=1 D  I 'OK Q:'$G(IBACCRPC1) 0  G FINISH
 . N X,X1,X2,OK1 S OK1=1
 . S X=0 F  S X=$O(^IBA(364.9,IBX12,5,X)) Q:X'=+X  S X1=$P(^(X,0),"^"),X2=$$GET1^DIQ(364.91,X1_",",.01,"E") I X2'=24,X2'=26,X2<100 S OK1=0 Q
 . I OK1 Q
 . S OK=0
 . ;JWS;IB*2.0*770v4; if no OHI, do not assign to a wl, quit
 . ;JWS;IB*2.0*770v16;12/16/24;code 3 might not be ien 3
 . S X=$O(^IBA(364.91,"B",3,0)) I X,$D(^IBA(364.9,IBX12,5,"B",X)) D  Q
 .. S ^TMP("IBCE837ACC",$J,"Status")="1^X12 claim data received, no OHI to bill. No VistA claim # created."
 . D USERUP(IBX12)
 . ;JWS;EBILL-4386;IB*2.0*770v7;change HIMS to FRPTF
 . ;JWS;11/25/24;IB*2.0*770v14;change FRPTF to PTF
 . ;JWS;12/4/24;IB*2.0*770v15;remove inpatient check/assignment, allow $$USER to handle
 . ;JWS;2/4/25;EBILL-3551;moved prev act entry
 . I $G(IBACCRPC1) S ^TMP("IBCE837ACC",$J,"Status")="1^X12 claim data received but not autobilled. "_$S($G(IBFT)="":"Could not determine form type.",1:"No VistA claim # created.")
 . Q
 ; attempt to create claim in VistA - file 399
 ;JWS;6/4/25;EBILL-5371;use Division sent with encounter
 ; change $$DIV("",1) to $$MCD^IBACCROWFT(IBSITE(1))
 S IBIFN=$$CREATE^IBCE837ACC2(IBPATIEN,IBFT,IBIO,$$MCD^IBACCROWFT(IBSITE(1)))  ;4th parameter will be division received from Payer EDI json
 I '$G(IBIFN) Q:'$G(IBACCRPC1) 0  S ^TMP("IBCE837ACC",$J,"Status")="1^X12 claim data received but not autobilled.  No VistA claim # created." G FINISH
 D
 . N DA,D0,DR,DIE,DIC,DI,DQ,DD,DINUM,DLAYGO,DTOUT,DUOUT,FDA,ERROR,IBIENA
 . S DA=IBX12
 . S DR="2.01////"_IBPATIEN_";2.02////"_$G(IBIFN)_";.21////1"
 . S DIE="^IBA(364.9,"
 . D ^DIE
 ;JWS;EBILL-5705;6/23/25;moved reasonable charges check to before enter/edit checks
 S OK=$$FINAL^IBCE837ACC4(IBIFN,IBX12) I 'OK S ^TMP("IBCE837ACC",$J,"Status")="1^X12 claim data received, VistA claim created, eBilling edit errors found."
 ; perform ib edit checks
 D
 . N PRCASV,VACNTRY,VAPA,IBACCRPC
 . S IBACCRPC=1
 . D EN^IBCBB
 I IBER'=""!$D(^TMP($J,"BILL-WARN")) D  I IBER'="WARN" Q:'$G(IBACCRPC1) 0  G FINISH
 . N X,I,J,NOTE,RET
 . I IBER'="WARN" D UP(IBX12,100,5,"")
 . ;get warnings from ^TMP($J,"BILL-WARN",#)
 . I $D(^TMP($J,"BILL-WARN")) S X="" F I=1:1 S X=$O(^TMP($J,"BILL-WARN",X)) Q:X=""  S NOTE(I)=$$STRIP^IBCE837ACC2A(^(X))
 . ;get errors from IBER variable, comma delimited
 . I IBER'="",IBER'="WARN" D
 .. ;JWS;2/4/25;EBILL-3551;moved prev act entry, appending note to existing entry
 .. N IBPAIEN,ERR
 .. S I=$G(I)+1,NOTE(I)="**Errors**:"
 .. F J=1:1 S X=$P(IBER,";",J) Q:X=""  I $D(^IBE(350.8,+$O(^IBE(350.8,"AC",X,0)),0)) S Y=^(0),NOTE($G(I)+J)=$E($P(Y,"^",2),1,80)
 .. ;D ADDPREVACT^IBACCWLUTIL(.RET,IBX12,DUZ,1000,"BILL","BILL",.NOTE)
 .. S IBPAIEN=$O(^IBA(364.9,IBX12,4,"A"),-1) I IBPAIEN D
 ... S IBPAIEN=IBPAIEN_","_IBX12_","
 ... D WP^DIE(364.94,IBPAIEN,10,"A","NOTE","ERR")
 .. D USERUP(IBX12)
 .. I $G(IBACCRPC1) S ^TMP("IBCE837ACC",$J,"Status")="1^X12 claim data received, VistA claim created, eBilling edit errors found."
 . Q
 ;JWS;EBILL-5705;6/23/25;moved reasonable charges check to before enter/edit checks
 ;S OK=$$FINAL^IBCE837ACC4(IBIFN,IBX12) I 'OK Q:'$G(IBACCRPC1) 0  S ^TMP("IBCE837ACC",$J,"Status")="1^X12 claim data received, VistA claim created, eBilling edit errors found." G FINISH
 ;JWS;EBILL-3551;1/13/25;IB*2.0*770v17;execute DSS scrubber call
 S OK=$$SCRUB^IBCE837ACC4(IBIFN)
 I '$G(OK) D  Q:'$G(IBACCRPC1) 0  G FINISH
 . D UP(IBX12,105,5,""),USERUP(IBX12)
 . I $G(IBACCRPC1) S ^TMP("IBCE837ACC",$J,"Status")="1^X12 claim data received, VistA claim created.  DSS Scrubber error."
 . Q
 ;JWS;2/4/25;EBILL-3551;last check of failure codes before authorize
 I $O(^IBA(364.9,IBX12,5,0)) D USERUP(IBX12) Q:'$G(IBACCRPC1) 0  G FINISH
 ;JWS;1/16/2025;EBILL-4866;IB*2.0*770v17;begin;flag to prevent auto-authorize and auto-transmit
 S OK=0,X=$$FIND1^DIC(364.991,,"X","ACCAUTOTRANSMITOFF") I X D
 . N XDIV
 . S XDIV=$$GET1^DIQ(364.991,X_",",.1)
 . I $F(XDIV,$E(IBSITE,1,3)_"|") S OK=1
 . Q
 I OK D  Q:'$G(IBACCRPC1) 0  G FINISH
 . D UP(IBX12,107,5,""),USERUP(IBX12)
 . I $G(IBACCRPC1) S ^TMP("IBCE837ACC",$J,"Status")="1^X12 claim data received, VistA claim ready for authorization."
 . Q
 ;JWS;1/16/2025;EBILL-4866;end
 ;
 D AUTH^IBCE837ACCU2(IBIFN,.IBERRMSG,$$MCRWNR^IBEFUNC($$CURR^IBCEF2(IBIFN)))
 I $G(IBERRMSG)="" D  Q:'$G(IBACCRPC1) 1  G FINISH
 . ; if successfully authorized and can transmit, then clear out 364.9 fields and change status to closed(2)
 . N DA,D0,DR,DIE,DIC,DI,DQ,DD,DINUM,DLAYGO,DTOUT,DUOUT,FDA,ERROR,IBIENA,IBST,DUZ
 . ;JWS;6/11/25;EBILL-5456;use AUTHORIZER,IB ACC as the user
 . S IBREG=$$IBREG()
 . D DUZ^XUP(IBREG)  ; IA#4129
 . S DA=IBX12
 . S DR=".16////2;2.03////1;3.01////@"
 . S DIE="^IBA(364.9,"
 . D ^DIE
 . S ^TMP("IBCE837ACC",$J,"Status")="1^X12 claim data received, VistA claim created and successfully transmitted."
 . ; set claim (399) status after authorization
 . K DA,D0,DR,DIE,DIC,DI,DQ,DD,DINUM,DLAYGO
 . S DA=IBIFN
 . ;JWS;4/29/25;need to set MRA date and user if Medicare
 . S IBST=$S($$MCRWNR^IBEFUNC($$CURR^IBCEF2(IBIFN)):2,1:3)
 . S DR=".13////"_IBST_$S(IBST=2:";7////"_DT_";8////"_DUZ,1:";9////1")
 . S DIE="^DGCR(399,"
 . D ^DIE
 . Q
 ;JWS;2/4/25;moved prev act entry
 Q:'$G(IBACCRPC1) 0
 G FINISH
 ;
DT(FIELD) ;
 N XDT,DATE
 S DATE=$P(ARG(IBSEG),"*",4)
 I $F(DATE,"-") S XDT=$S($E(DATE,1,2)=19:2,1:3)_$E(DATE,3,8)_"-"_$S($E(DATE,10,11)=19:2,1:3)_$E(DATE,12,17) D SET^IBCE837ACC1(XDT,FIELD) Q
 I DATE'="" S XDT=$S($E(DATE,1,2)=19:2,1:3)_$E(DATE,3,8) I XDT'="" D SET^IBCE837ACC1(XDT,FIELD) Q
 Q
 ;
USERUP(IBX12) ;
 N DA,D0,DR,DIE,DIC,DI,DQ,DD,DINUM,DLAYGO,DTOUT,DUOUT,XD,XIAG
 S DA=IBX12 ;;I DA="" Q  - GEN ERROR MESSAGE
 ; field 3.01 - assigned to group (possible if only SC issue, assign to RUR)
 ;JWS;EBILL-4386;IB*2.0*770v7;change HIMS to FRPTF
 ;JWS;11/25/24;IB*2.0*770v14;change FRPTF to PTF
 ;JWS;12/4/24;IB*2.0*770v15;remove inpatient check/assignment, allow $$USER to handle
 S XD=$$USER^IBCE837ACC4(IBX12),XIAG=$$GET1^DIQ(364.9,IBX12_",",3.02,"I")
 ;JWS;12/9/24;EBILL-3551;allow update and not change 3.02
 S DR="3.01////"_XD_$S($G(XIAG)'="":"",1:";3.02////"_XD)_";3.03////"_IBND
 S DIE="^IBA(364.9,"
 D ^DIE
 Q
 ;
FINISH ;
 ;JWS;10/31/25;moved FINISH to IBCE837ACC2A
 G FINISH^IBCE837ACC2A
 ;
UP(IBIEN,IBVAL,IBFLD,NOTE) ;
 Q:$G(IBVAL)=""
 N IBVAL1,WL
 ;JWS;IB*2.0*770v19;EBILL-4921;1/29/25;added worklist to failure reason code multiple for filtering display
 ;JWS;2/4/25;EBILL-3551;make sure all failure reasons have a default wl
 S WL=$S(IBVAL=1!(IBVAL>3&(IBVAL<7)):"FRT",IBVAL=2:"RUR",IBVAL=3!(IBVAL=16)!(IBVAL=18):"IV",IBVAL=7:"PTF",IBVAL>7&(IBVAL<11):"RUR",1:"NEXT")
 ;11/24/25;JWS;EBILL-6206;add error 27 for missing taxonomy to FRT
 I WL="NEXT" S WL=$S(IBVAL=11:"FRT",IBVAL>11&(IBVAL<16):"RUR",IBVAL>18&(IBVAL<24):"RUR",IBVAL=27:"FRT",IBVAL=109:"FRT",IBVAL=110:"FRT",IBVAL>23:"BILL",1:"")
 S IBVAL1=$O(^IBA(364.91,"B",IBVAL,0)) Q:IBVAL1=""
 S DIC="^IBA(364.9,"_IBIEN_",5,",DIC(0)="L",DA(1)=IBIEN,X=IBVAL1,DLAYGO=364.95 K DD,DO D FILE^DICN K DO,DD,DLAYGO
 S IBTNUM=+Y
 I NOTE="" S NOTE=$$GET1^DIQ(364.91,IBVAL1,.02)
 ;JWS;IB*2.0*770v19;EBILL-4921;1/29/25;added worklist to failure reason code multiple for filtering display
 ;JWS;12/29/25;EBILL-6340;fix issue with semi-colon in proc name when modifier is expired or invalid
 S DR=".02////^S X=NOTE;.03////"_WL_";.04////"_$S(IBVAL=4!(IBVAL=5):$P(NOTE,":",2),1:"")
 S DIE=DIC,DA=IBTNUM D ^DIE K DIE,DIC,DA,DINUM,DO,DD,DR
 I '$G(IBACCRPC1) Q
 ;JWS;10/23/25;EBILL-6172;add initial failure reasons to encounter file
 S DIC="^IBA(364.9,"_IBIEN_",7,",DIC(0)="L",DA(1)=IBIEN,X=IBVAL1,DLAYGO=364.97 K DD,DO D FILE^DICN K DO,DD,DLAYGO
 S IBTNUM=+Y
 I NOTE="" S NOTE=$$GET1^DIQ(364.91,IBVAL1,.02)
 ;JWS;12/29/25;EBILL-6340;fix issue with semi-colon in proc name when modifier is expired or invalid
 S DR=".02////^S X=NOTE;.03////"_WL_";.04////"_$S(IBVAL=4!(IBVAL=5):$P(NOTE,":",2),1:"")
 S DIE=DIC,DA=IBTNUM D ^DIE K DIE,DIC,DA,DINUM,DO,DD,DR
 Q
 ;
IBREG() ; Returns IEN (Internal Entry Number) from file #200 for
 ; the ACC Bill Authorizer ; AUTHORIZER,IB ACC
 ; Output:    -1   if record not on file
 ;            IEN  if record is on file
 N DIC,X,Y
 S DIC(0)="MO",DIC="^VA(200,",X="AUTHORIZER,IB ACC"  ;ICR #10060 (Supported)
 D ^DIC
 ; if record is on file, return IEN else return -1
 Q +Y
 ;
DIV(IBDIV,IBINT) ; obtain division
 ; use new Facility cross/walk table to obtain division to use
 I $G(IBDIV)="" S:$G(IBINT)=1 IBDIV=$$GET1^DIQ(350.9,"1,",1.25,"I") Q:$G(IBINT)=1 IBDIV  S IBDIV=$P($$SITE^VASITE,"^",3)
 ;JWS;10/24/24;IB*2.0*770V8;EBILL-3551;added user group map logic by site/div number
 S IBDIV=$$RUST^IBACCROWFT(IBDIV)
 Q IBDIV  ;ptr to file 40.8
 ;
STAT(IBIEN,DATA) ; update status
 N DA,D0,DR,DIE,DIC,DI,DQ,DD,DINUM,DLAYGO,DTOUT,DUOUT
 S DA=IBIEN
 S DR=".16////"_DATA
 S DIE="^IBA(364.9,"
 D ^DIE
 ;JWS;8/14/25;EBILL-5876; don't extract dups;770v39; need for status field trigger addition
 I $G(IBDUP) S DR=".21////0" D ^DIE
 Q
 ;
