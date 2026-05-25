IBCE837ACC1 ;EDE/JWS - ACC consume X12 claim data ;
 ;;2.0;INTEGRATED BILLING;**770**;23-MAY-18;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
20 ;LOOP 20
 I $E(SEG,1,7)="PRV*BI*" Q
 I $E(SEG,1,4)="REF*" Q
 I $E(SEG,1,4)="NM1*" D  Q
 . I SEG2=85 D  Q  ;billing provider name,address info
 .. D NEXT
 .. S IBPN1=$P(ARG(IBSEG),"*",4) I IBPN1="" Q  ;other payer billing provider
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),85)
 .. D SET($P(ARG(IBSEG),"*",10),1.1,85),SET(IBPN1,1.2,85),SET($S(OK=1:355.93,1:200),1.3,85)
 .. Q
 . I SEG2=87 D NEXT Q  ;pay-to provider, address info
 . I SEG2="PE" D NEXT Q  ;pay-to plan name
 Q
 ;
22 ;LOOP 22
 I $E(SEG,1,4)="SBR*" Q  ;subscriber info
 I $E(SEG,1,4)="PAT*" D  Q  ;patient death and/or weight - prof
 . N IBDOD,IBPW
 . S IBDOD=$P(ARG(IBSEG),"*",7) I IBDOD'="" S IBDOD=$S($E(IBDOD,1,2)=19:2,1:3)_$E(IBDOD,3,8) D SET(IBDOD,31)
 . S IBPW=$P(ARG(IBSEG),"*",9) I IBPW'="" D SET(IBPW,32)
 . Q
 I $E(SEG,1,4)="NM1*" D  Q
 . I SEG2="IL" S IBPATICN=$P(ARG(IBSEG),"*",10) D PAT^IBCE837ACC4,NEXT Q  ;subscriber name, address info
 . I SEG2="PR" D  Q
 .. S IBPAYERID=$P(ARG(IBSEG),"*",10)
 .. D NEXT Q  ;payer name
 ;get patient DOB from DMG subscriber segment;only set if not defined by patient info
 I $E(SEG,1,4)="DMG*" S DOB=$P(ARG(IBSEG),"*",3) I DOB'="",$G(IBDOB)="" S IBDOB=$S($E(DOB,1,2)=19:2,1:3)_$E(DOB,3,8) Q
 I $E(SEG,1,4)="REF*" D  Q
 . I SEG2="SY" D  Q
 .. ;5/14/25 JWS;found during documentation, added if ssn="", try to get it from REF seg
 .. I $G(IBPATLN)'="",$G(IBPATSSN)="" S IBPATSSN=$P(ARG(IBSEG),"*",3) Q  ;sub secondary id - ssn
 . Q
 Q
 ; tag 23 - loop 2300 for incoming ACC encounter processing
23 ;LOOP 2300
 I $E(SEG,1,4)="PAT*" Q  ;patient - relationship to insured
 I $E(SEG,1,4)="SBR*" Q  ; LOOP=23 other subscriber loop 2320
 I $E(SEG,1,4)="NM1*" D  Q
 . I SEG2="PR" D NEXT Q  ;other payer name
 . I SEG2="IL" D  D NEXT Q  ;other subscriber name
 .. I $G(IBPATIEN)'="" Q
 .. ; 6/6/25;JWS;need to delete previous missing pat failure reason code 
 .. N IB36491 S IB36491=$O(^IBA(364.91,"B",1,0)) I 'IB36491 Q
 .. S IBX=0 F  S IBX=$O(^IBA(364.9,IBX12,5,IBX)) Q:IBX'=+IBX  I $P($G(^(IBX,0)),"^")=IB36491 S DA(1)=IBX12,DIK="^IBA(364.9,"_DA(1)_",5,",DA=IBX D ^DIK
 .. ;6/6/25;JWS;if previous icn lookup failed, attempt to find patient using other sub info (example had SSN here)
 .. D PAT^IBCE837ACC4
 .. Q
 . I SEG2="QC" D  Q  ;patient name
 .. D NEXT
 .. I $G(IBPATLN)=$P(ARG(IBSEG),"*",4),$G(IBPATFN)=$P(ARG(IBSEG),"*",5),$G(IBPATMN)=$P(ARG(IBSEG),"*",6) Q  ;patient is subscriber
 .. ;patient is not veteran, so generate exception error
 .. D UP^IBCE837ACC(IBX12,11,5,IBPATLN_","_IBPATFN_" "_$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)_" "_$P(ARG(IBSEG),"*",6))
 .. Q
 . I SEG2="PW" D  Q  ;amb pickup address
 .. S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N3*" D
 ... D SET($P(ARG(IBSEGN),"*",2),1,"AMB") S IBI=IBI+1
 ... S DA(1)=IBX12,DLAYGO=364.9001,DIC(0)="L",DIC="^IBA(364.9,"_DA(1)_",1,",X=ARG(IBSEGN)
 ... D FILE^DICN S RES=+Y K DD,DO
 .. S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N4*" D
 ... D SET($P(ARG(IBSEGN),"*",2,4),2,"AMB") S IBI=IBI+1
 ... ;1/30/26;JWS;EBILL-6482;IB*2.0*770v61;variable type was ARG(IBSEG) needed to be IBSEGN
 ... S DA(1)=IBX12,DLAYGO=364.9001,DIC(0)="L",DIC="^IBA(364.9,"_DA(1)_",1,",X=ARG(IBSEGN)
 ... D FILE^DICN S RES=+Y K DD,DO
 .. Q
 . I SEG2=45 D  Q  ;amb drop-off location
 .. ;JWS;10/8/25;EBILL-6111;ib*2.0*770v49;dropoff location name
 .. ;JWS;2/2/26;EBILL-6482;IB*2.0*770v61;wrong variable was IBSEGN, should have been IBSEG (current seg data)
 .. D SET($P(ARG(IBSEG),"*",4),5,"AMB")
 .. S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N3*" D
 ... D SET($P(ARG(IBSEGN),"*",2),3,"AMB") S IBI=IBI+1
 ... S DA(1)=IBX12,DLAYGO=364.9001,DIC(0)="L",DIC="^IBA(364.9,"_DA(1)_",1,",X=ARG(IBSEGN)
 ... D FILE^DICN S RES=+Y K DD,DO
 .. S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N4*" D
 ... D SET($P(ARG(IBSEGN),"*",2,4),4,"AMB") S IBI=IBI+1
 ... S DA(1)=IBX12,DLAYGO=364.9001,DIC(0)="L",DIC="^IBA(364.9,"_DA(1)_",1,",X=ARG(IBSEGN)
 ... D FILE^DICN S RES=+Y K DD,DO
 .. Q
 . I SEG2="DN" D  Q  ;DN - referring provider
 .. N XIBPNAME,XIBPNPI
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other payer referring provider
 .. S XIBPNAME=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5),XIBPNPI=$P(ARG(IBSEG),"*",10)
 .. ;11/24/25;JWS;EBILL-6206;add error 27 for missing taxonomy
 .. S OK=$$CHK35593^IBCE837ACCU(XIBPNPI,"DN") I OK<1 D UP^IBCE837ACC(IBX12,$S(OK=-1:27,1:4),5,XIBPNAME_":"_XIBPNPI)
 .. ;JWS;IB*2.0*770v11;11/11/24;EBILL-3551;address NOT ON FILE name issue
 .. I $F(XIBPNAME,"NOT ON FILE") S XIBPNAME=$G(IBPN2)
 .. ;JWS;12/5/24;IB*2.0*770v15;remove storing referring provider into the encounter zero node
 .. ;I $G(IBPN)="" S IBPN=XIBPNAME,IBPT="DN",IBPNPI=XIBPNPI
 .. D SET(XIBPNPI,1.1,"DN"),SET(XIBPNAME,1.2,"DN"),SET($S(OK=1:355.93,1:200),1.3,"DN")
 .. Q
 . I SEG2=82 D  Q  ;NM101='82' - rendering provider
 .. N XIBPNAME,XIBPNPI
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other payer rendering
 .. S XIBPNAME=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5),XIBPNPI=$P(ARG(IBSEG),"*",10)
 .. I $G(IBPN)="" S IBPN=XIBPNAME,IBPT=82,IBPNPI=XIBPNPI
 .. ;11/24/25;JWS;EBILL-6206;add error 27 for missing taxonomy
 .. S OK=$$CHK35593^IBCE837ACCU(XIBPNPI,82) I OK<1 D UP^IBCE837ACC(IBX12,$S(OK=-1:27,1:4),5,XIBPNAME_":"_XIBPNPI)
 .. D SET(XIBPNPI,1.1,82),SET(XIBPNAME,1.2,82),SET($S(OK=1:355.93,1:200),1.3,82)
 .. Q
 . I SEG2=77 D  Q   ;NM101='77' - service facility
 .. D NEXT
 .. S IBPN1=$P(ARG(IBSEG),"*",4) I IBPN1="" Q  ;other payer service facility
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),77) I 'OK D UP^IBCE837ACC(IBX12,5,5,IBPN1_":"_$P(ARG(IBSEG),"*",10))
 .. ;JWS;IB*2.0*770v10;11/11/24;EBILL-3551;address NOT ON FILE name issue
 .. I $F(IBPN1,"NOT ON FILE") S IBPN1=$G(IBPN2)
 .. D SET($P(ARG(IBSEG),"*",10),1.1,77),SET(IBPN1,1.2,77),SET($S(OK=1:355.93,1:200),1.3,77)
 .. Q
 . I SEG2="DQ" D  Q  ;NM101='DQ' = supervising provider
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other payer supervising provider
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),"DQ") I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10))
 .. D SET($P(ARG(IBSEG),"*",10),1.1,"DQ"),SET($S(OK=1:355.93,1:200),1.3,"DQ")
 .. Q
 . I SEG2=71 D  Q  ;NM101='71' = attending provider
 .. N XIBPNAME,XIBPNPI
 .. I $P(ARG(IBSEG),"*",4)="" Q
 .. S XIBPNAME=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5),XIBPNPI=$P(ARG(IBSEG),"*",10)
 .. I $G(IBPN)="" S IBPN=XIBPNAME,IBPT=71,IBPNPI=XIBPNPI
 .. ;11/24/25;JWS;EBILL-6206;add error 27 for missing taxonomy
 .. S OK=$$CHK35593^IBCE837ACCU(XIBPNPI,71) I OK<1 D UP^IBCE837ACC(IBX12,$S(OK=-1:27,1:4),5,XIBPNAME_":"_XIBPNPI)
 .. D SET(XIBPNPI,1.1,71),SET($S(OK=1:355.93,1:200),1.3,71)
 .. Q
 . I SEG2=72 D  Q  ;NM101='72' = operating physician
 .. I $P(ARG(IBSEG),"*",4)="" Q
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),72) I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10))
 .. D SET($P(ARG(IBSEG),"*",10),1.1,72),SET(IBPN1,1.2,72),SET($S(OK=1:355.93,1:200),1.3,72)
 .. Q
 . I SEG2="ZZ" D  Q  ;NM101='ZZ' = other operating physician
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),"ZZ") I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10))
 .. D SET($P(ARG(IBSEG),"*",10),1.1,"ZZ"),SET($S(OK=1:355.93,1:200),1.3,"ZZ")
 .. Q
 . I SEG2=85 Q  ;other billing provider name
 . I SEG2="DD" D  Q  ;NM101='DD' = assistant surgeon
 .. I $P(ARG(IBSEG),"*",4)="" Q
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),"DD") I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10))
 .. D SET($P(ARG(IBSEG),"*",10),1.1,"DD"),SET($S(OK=1:355.93,1:200),1.3,"DD")
 .. Q
 . Q
 I $E(SEG,1,4)="DMG*" D  Q
 . ;1/6/26;JWS;EBILL-6357;only set IBDOB if not already set by vista patient info
 . S DOB=$P(ARG(IBSEG),"*",3) I DOB'="",$G(IBDOB)="" S IBDOB=$S($E(DOB,1,2)=19:2,1:3)_$E(DOB,3,8) Q
 . Q
 ;get claim charge amt and place of service code from CLM loop 2300
 I $E(SEG,1,4)="CLM*" D SET($P(ARG(IBSEG),"*",3),5),SET($P($P(ARG(IBSEG),"*",6),":"),6) Q
 I $E(SEG,1,4)="DTP*" D  Q
 . I SEG2=431 D DT^IBCE837ACC(9) Q  ;399,.03  ;date of onset
 . I SEG2=454 D DT^IBCE837ACC(10) Q  ;399,246  ;date of initial treatment
 . I SEG2=304 D DT^IBCE837ACC(11) Q  ;399,237  ;date last seen
 . I SEG2=453 D DT^IBCE837ACC(12) Q  ;399,247  ;date acute manifestation
 . I SEG2=439 D DT^IBCE837ACC(13) Q  ;399,41,.02 - OCCURRENCE CODE = 01  ;accident date
 . I SEG2=484 D DT^IBCE837ACC(14) Q  ;399,41,.02 - OCCURRENCE CODE = 10  ;last menstrual period
 . I SEG2=455 D DT^IBCE837ACC(15) Q  ;399,245  ;date last x-ray
 . I SEG2=471 Q  ;hearing & vision prescription date
 . I SEG2=314 D DT^IBCE837ACC(16) Q  ;399,263 and 264 ;disability start and end dates
 . I SEG2=360 D DT^IBCE837ACC(37) Q  ;399,263  ;disability start date
 . I SEG2=361 D DT^IBCE837ACC(38) Q  ;399,264  ;disability end date
 . I SEG2=297 D DT^IBCE837ACC(17) Q  ;399,166  ;date last worked
 . I SEG2=296 D DT^IBCE837ACC(18) Q  ;399,166  ;date authorized return to work
 . ;check admission date - if DTP segment exists, then it's inpatient claim
 . I SEG2=435 S IBIO="I" D DT^IBCE837ACC(19) Q  ;admission date - inpatient
 . I SEG2="096" D DT^IBCE837ACC(20) Q  ;discharge date/hour for 837i
 . I SEG2="090" D DT^IBCE837ACC(21) Q  ;assumed care date
 . I SEG2="091" D DT^IBCE837ACC(22) Q  ;relinquished care date
 . I SEG2=444 D DT^IBCE837ACC(23) Q  ;first visit date
 . I SEG2="050" Q  ;repricer date
 . I SEG2=573 Q  ;claim check/ remittance date
 . I SEG2=434 D  Q
 .. D DT^IBCE837ACC(33)  ;inst statement dates
 .. N IBXDOS
 .. I $P(ARG(IBSEG),"*",4)="" Q
 .. S IBXDOS=3_$E($P(ARG(IBSEG),"*",4),3,8)
 .. S IBDOS=IBXDOS D SET(IBDOS,8)
 .. S IBLDOS=3_$E($P($P(ARG(IBSEG),"*",4),"-",2),3,8)
 .. I IBLDOS=3 S IBLDOS=IBXDOS
 .. D SET(IBLDOS,39)
 .. Q
 . I SEG2=452 D DT^IBCE837ACC(35) Q  ;dental appliance placement date
 . I SEG2=472 D  Q
 .. D DT^IBCE837ACC(36)
 .. I $G(IBDOS)="" S (IBDOS,IBLDOS)=$P(^TMP("IB837ACC",$J),"^",36) D SET(IBDOS,8),SET(IBLDOS,39) Q  ;dental date of service - claim level
 .. Q
 I $E(SEG,1,4)="CL1*" D SET(ARG(IBSEG),1,"CL1") Q 
 I $E(SEG,1,4)="PWK*" Q
 I $E(SEG,1,4)="CN1*" Q  ;NON-HIPPA USE
 I $E(SEG,1,4)="REF*" D  Q
 . I SEG2="D9" S IBREFD9=$P(ARG(IBSEG),"*",3) Q  ;claim identifier for transmission intermediaries
 . I SEG2="EW" D SET($P(ARG(IBSEG),"*",3),24) Q
 . I SEG2="X4" D SET($P(ARG(IBSEG),"*",3),25) Q
 . ;JWS;10/23/25;EBILL-6172;add authorization and referral variables
 . I SEG2="G1" S IBAUTH=$P(ARG(IBSEG),"*",3) Q
 . I SEG2="9F" S IBREF=$P(ARG(IBSEG),"*",3) Q
 . ;JWS;EBILL-4922;IB*2.0*770v18;add payer claim control number to encounter
 . ;JWS;6/9/25;appears that cc encounters have the payer control number segment in loop 2330B (other payer claim control number)
 . ;JWS;6/9/25;so adding conditional check in case future encounters have value in loop 2300
 . I SEG2="F8",$P($G(^TMP("IB837ACC",$J)),"^",44)="" D SET($P(ARG(IBSEG),"*",3),44) Q 
 I $E(SEG,1,3)="K3*" Q  ;file info
 I $E(SEG,1,4)="NTE*" D SET($P(ARG(IBSEG),"*",3),1,"NTE"_"-"_$P(ARG(IBSEG),"*",2)) Q
 I $E(SEG,1,4)="CR1*" D SET(ARG(IBSEG),1,"CR1") S $P(^TMP("IBCE837ACC",$J),"^",40)=1 Q  ; ambulance transport info
 I $E(SEG,1,4)="CR2*" Q
 I $E(SEG,1,4)="CRC*" D  Q
 . I SEG2="07" D SET(ARG(IBSEG),1,"CRC07") Q  ;amb certification
 . I SEG2=75 D SET($P(ARG(IBSEG),"*",3,4),26) Q
 . I SEG2="ZZ" D SET($P(ARG(IBSEG),"*",3,4),27) Q
 . Q
 ;get principle diagnosis code
 I $E(SEG,1,3)="HI*" D  Q
 . I $P(SEG2,":")="ABK" S IBPDX=$P($P(ARG(IBSEG),":",2),"*") D SET(ARG(IBSEG),1,"HI-D"),SET(IBPDX,7) Q  ;diagnosis codes
 . I $P(SEG2,":")="ABF" D SET(ARG(IBSEG),1,"HI-O") Q  ;other-diagnosis
 . I $P(SEG2,":")="ABJ" Q  ;admitting diagnosis - need if/when doing inpatient
 . I $P(SEG2,":")="APR" D SET($P(ARG(IBSEG),"*",2,4),28) Q  ;reason for visit
 . I $P(SEG2,":")="ABN" D SET(ARG(IBSEG),1,"HI-E") Q  ;external cause of injury
 . I $E(SEG2,1,3)="DR:" Q  ;DRG group (inpatient inst)
 . I $E(SEG2,1,3)="BP:" D SET($P($P(ARG(IBSEG),"*",2),":",2),34) Q  ;anesthesia surgical code
 . I $E(SEG2,1,4)="BBR:" D SET($P(ARG(IBSEG),"*",2),30) Q
 . I $E(SEG2,1,4)="BBQ:" D SET($P(ARG(IBSEG),"*",2,13),1,"PROC") Q
 . I $E(SEG2,1,3)="BI:" D SET($P(ARG(IBSEG),"*",2,13),1,"OSC") Q
 . I $E(SEG2,1,3)="BH:" D SET($P(ARG(IBSEG),"*",2,13),1,"OC") Q  ;"HI*BH:05:D8:20230501*BH:18:D8:20020301"
 . I $E(SEG2,1,3)="BE:" D SET($P(ARG(IBSEG),"*",2,13),1,"CV") Q  ;HI*BE:01:::2500*BE:80:::1
 . I $E(SEG2,1,3)="BG:" D SET($P(ARG(IBSEG),"*",2,13),1,"CC") Q
 . I $E(SEG2,1,3)="TC:" Q  ;probably never get - Treatment Code Info
 . Q
 I $E(SEG,1,4)="HCP*" Q  ;loop 2300 will not get HCP segments, and if so, don't need claim $
 I $E(SEG,1,4)="PRV*" Q
 I $E(SEG,1,4)="DN1*" D SET($P(ARG(IBSEG),"*",2,5),1,"DN1") Q  ;ortho total months
 I $E(SEG,1,4)="DN2*" D SET($P(ARG(IBSEG),"*",2,7),1,"DN2") Q  ;tooth status
 Q
 ;
SET(DATA,PIECE,TYPE) ;
 N I
 I $F(PIECE,"."),$G(TYPE)'="" D  Q
 . I $P(PIECE,".")=1 S $P(^TMP("IB837ACC",$J,$P(PIECE,"."),TYPE),"^",$P(PIECE,".",2))=DATA
 I $G(TYPE)'="" D  Q
 . I TYPE="CRC07" D  Q
 .. I '$D(^TMP("IB837ACC",$J,"CRC07",1)) S ^(1)=DATA Q
 .. I '$D(^TMP("IB837ACC",$J,"CRC07",2)) S ^(2)=DATA Q
 .. S ^TMP("IB837ACC",$J,TYPE,3)=DATA
 . I TYPE="CC" D  Q
 .. I '$D(^TMP("IB837ACC",$J,"CC",1)) S ^(1)=DATA Q
 .. I '$D(^TMP("IB837ACC",$J,"CC",2)) S ^(2)=DATA Q
 . I TYPE="CV" D  Q
 .. I '$D(^TMP("IB837ACC",$J,"CV",1)) S ^(1)=DATA Q
 .. I '$D(^TMP("IB837ACC",$J,"CV",2)) S ^(2)=DATA Q
 . I TYPE="OC" D  Q
 .. I '$D(^TMP("IB837ACC",$J,"OC",1)) S ^(1)=DATA Q
 .. I '$D(^TMP("IB837ACC",$J,"OC",2)) S ^(2)=DATA Q
 . I TYPE="OSC" D  Q
 .. I '$D(^TMP("IB837ACC",$J,"OSC",1)) S ^(1)=DATA Q
 .. I '$D(^TMP("IB837ACC",$J,"OSC",2)) S ^(2)=DATA Q
 . I TYPE="HI-O" D  Q
 .. ;JWS;EBILL-4928;IB*2.0*770v19;save off secondary diagnosis
 .. D SD
 .. I '$D(^TMP("IB837ACC",$J,"HI-O",1)) S ^(1)=DATA Q
 .. I '$D(^TMP("IB837ACC",$J,"HI-O",2)) S ^(2)=DATA Q
 . I TYPE="DN2" D  Q
 .. F I=1:1:35 I '$D(^TMP("IB837ACC",$J,"DN2",I)) S ^(I)=DATA Q
 . I $E(TYPE,1,3)="NTE" D  Q  ;claim note - loop 2300
 .. F I=1:1:5 I '$D(^TMP("IB837ACC",$J,"NTE",$P(TYPE,"-",2),I)) S ^(I)=DATA Q
 .. Q
 . S $P(^TMP("IB837ACC",$J,TYPE),"^",PIECE)=DATA
 . ;JWS;EBILL-4928;IB*2.0*770v19;save off secondary diagnosis
 . I TYPE="HI-D" D SD
 . Q
 S $P(^TMP("IB837ACC",$J),"^",PIECE)=DATA
 Q
 ;
SD ;save secondary diagnosis codes
 N X,I,XD
 ;HI*ABK:R0789*ABF:R7989*ABF:I10*ABF:N181*ABF:J449
 ;HI*ABF:H18231*ABF:I10*ABF:E785*ABF:I219*ABF:G250*ABF:Z87891*ABF:Z791*ABF:Z7982*ABF:Z79899*ABF:Z7902*ABF:Z7901
 S XD=$P($G(^IBA(364.9,IBX12,0)),"^",30)
 F I=2:1 S X=$P(DATA,"*",I) Q:X=""  I $P(X,":")="ABF" S XD=$G(XD)_$P(X,":",2)_","
 S $P(^IBA(364.9,IBX12,0),"^",30)=XD
 Q
 ;
NEXT ;
 S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N3*" D  S IBI=IBI+1
 . S DA(1)=IBX12,DLAYGO=364.9001,DIC(0)="L",DIC="^IBA(364.9,"_DA(1)_",1,",X=ARG(IBSEGN)
 . D FILE^DICN S RES=+Y K DD,DO
 S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N4*" D  S IBI=IBI+1
 . S DA(1)=IBX12,DLAYGO=364.9001,DIC(0)="L",DIC="^IBA(364.9,"_DA(1)_",1,",X=ARG(IBSEGN)
 . D FILE^DICN S RES=+Y K DD,DO
 Q
 ;
