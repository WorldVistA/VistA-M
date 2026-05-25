IBCE837ACCU1 ;EDE/JWS - ACC consume X12 claim data ;
 ;;2.0;INTEGRATED BILLING;**770**;23-MAY-18;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
23 ;LOOP 23
 I $E(SEG,1,4)="PAT*" Q  ;patient - relationship to insured
 I $E(SEG,1,4)="SBR*" Q  ; LOOP=23
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
 . I SEG2="PW" D  Q  ;amb pickup add
 .. S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N3*" D
 ... D SET^IBCE837ACC1($P(ARG(IBSEGN),"*",2),1,"AMB") S IBI=IBI+1
 .. S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N4*" D
 ... D SET^IBCE837ACC1($P(ARG(IBSEGN),"*",2,4),2,"AMB") S IBI=IBI+1
 .. Q
 . I SEG2=45 D  Q  ;amb drop-off loc
 .. ;JWS;10/8/25;EBILL-6111;IB*2.0*770v49;adding amb drop-off loc name
 .. ;JWS;2/2/26;EBILL-6482;IB*2.0*770v61;wrong variable was IBSEGN, should have been IBSEG (current seg data)
 .. D SET^IBCE837ACC1($P(ARG(IBSEG),"*",4),5,"AMB")
 .. S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N3*" D
 ... D SET^IBCE837ACC1($P(ARG(IBSEGN),"*",2),3,"AMB") S IBI=IBI+1
 .. S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N4*" D
 ... D SET^IBCE837ACC1($P(ARG(IBSEGN),"*",2,4),4,"AMB") S IBI=IBI+1
 .. Q
 . I SEG2="DN" D  Q  ;DN - referring prov
 .. N XIBPNAME,XIBPNPI
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other payer referring provider
 .. S XIBPNAME=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5),XIBPNPI=$P(ARG(IBSEG),"*",10)
 .. ;11/24/25;JWS;EBILL-6206;add error 27 for missing taxonomy
 .. S OK=$$CHK35593^IBCE837ACCU(XIBPNPI,"DN") I OK<1 D UP^IBCE837ACC(IBX12,$S(OK=-1:27,1:4),5,XIBPNAME_":"_XIBPNPI)
 .. ;JWS;IB*2.0*770v11;11/11/24;EBILL-3551;address NOT ON FILE name issue
 .. I $F(XIBPNAME,"NOT ON FILE") S XIBPNAME=$G(IBPN2)
 .. ;JWS;12/5/24;IB*2.0*770v15;remove storing referring provider into the encounter zero node
 .. ;I $G(IBPN)="" S IBPN=XIBPNAME,IBPT="DN",IBPNPI=XIBPNPI
 .. D SET^IBCE837ACC1(XIBPNPI,1.1,"DN"),SET^IBCE837ACC1(XIBPNAME,1.2,"DN"),SET^IBCE837ACC1($S(OK=1:355.93,1:200),1.3,"DN")
 .. Q
 . I SEG2=82 D  Q  ;NM101='82' - rendering prov
 .. N XIBPNAME,XIBPNPI
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other payer rendering
 .. S XIBPNAME=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5),XIBPNPI=$P(ARG(IBSEG),"*",10)
 .. I $G(IBPN)="" S IBPN=XIBPNAME,IBPT=82,IBPNPI=XIBPNPI
 .. ;11/24/25;JWS;EBILL-6206;add error 27 for missing taxonomy
 .. S OK=$$CHK35593^IBCE837ACCU(XIBPNPI,82) I OK<1 D UP^IBCE837ACC(IBX12,$S(OK=-1:27,1:4),5,XIBPNAME_":"_XIBPNPI)
 .. D SET^IBCE837ACC1(XIBPNPI,1.1,82),SET^IBCE837ACC1(XIBPNAME,1.2,82),SET^IBCE837ACC1($S(OK=1:355.93,1:200),1.3,82)
 .. Q
 . I SEG2=77 D  Q  ;NM101='77' - service facility
 .. D NEXT
 .. S IBPN1=$P(ARG(IBSEG),"*",4) I IBPN1="" Q  ;other payer service facility
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),77) I 'OK D UP^IBCE837ACC(IBX12,5,5,IBPN1_":"_$P(ARG(IBSEG),"*",10))
 .. ;JWS;IB*2.0*770v10;11/11/24;EBILL-3551;address NOT ON FILE name issue
 .. I $F(IBPN1,"NOT ON FILE") S IBPN1=$G(IBPN2)
 .. D SET^IBCE837ACC1($P(ARG(IBSEG),"*",10),1.1,77),SET^IBCE837ACC1(IBPN1,1.2,77),SET^IBCE837ACC1($S(OK=1:355.93,1:200),1.3,77)
 .. Q
 . I SEG2="DQ" D  Q  ;NM101='DQ' = supervising provider
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;other payer supervising provider
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),"DQ") I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10))
 .. D SET^IBCE837ACC1($P(ARG(IBSEG),"*",10),1.1,"DQ"),SET^IBCE837ACC1($S(OK=1:355.93,1:200),1.3,"DQ")
 .. Q
 . I SEG2=71 D  Q  ;NM101='71' = attending provider
 .. N XIBPNAME,XIBPNPI
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;
 .. S XIBPNAME=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5),XIBPNPI=$P(ARG(IBSEG),"*",10)
 .. I $G(IBPN)="" S IBPN=XIBPNAME,IBPT=71,IBPNPI=XIBPNPI
 .. ;11/24/25;JWS;EBILL-6206;add error 27 for missing taxonomy
 .. S OK=$$CHK35593^IBCE837ACCU(XIBPNPI,71) I OK<1 D UP^IBCE837ACC(IBX12,$S(OK=-1:27,1:4),5,XIBPNAME_":"_XIBPNPI)
 .. D SET^IBCE837ACC1(XIBPNPI,1.1,71),SET^IBCE837ACC1($S(OK=1:355.93,1:200),1.3,71)
 .. Q
 . I SEG2=72 D  Q  ;NM101='72' = operating physician
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),72) I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10))
 .. D SET^IBCE837ACC1($P(ARG(IBSEG),"*",10),1.1,72),SET^IBCE837ACC1(IBPN1,1.2,72),SET^IBCE837ACC1($S(OK=1:355.93,1:200),1.3,72)
 .. Q
 . I SEG2="ZZ" D  Q  ;NM101='ZZ' = other operating physician
 .. I $P(ARG(IBSEG),"*",4)="" Q  ;
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),"ZZ") I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10))
 .. D SET^IBCE837ACC1($P(ARG(IBSEG),"*",10),1.1,"ZZ"),SET^IBCE837ACC1($S(OK=1:355.93,1:200),1.3,"ZZ")
 .. Q
 . I SEG2=85 Q  ;other billing provider name
 . I SEG2="DD" D  Q  ;NM101='DD' = assistant surgeon
 .. I $P(ARG(IBSEG),"*",4)="" Q
 .. S IBPN1=$P(ARG(IBSEG),"*",4)_","_$P(ARG(IBSEG),"*",5)
 .. S OK=$$CHK35593^IBCE837ACCU($P(ARG(IBSEG),"*",10),"DD") I 'OK D UP^IBCE837ACC(IBX12,4,5,IBPN1_":"_$P(ARG(IBSEG),"*",10))
 .. D SET^IBCE837ACC1($P(ARG(IBSEG),"*",10),1.1,"DD"),SET^IBCE837ACC1($S(OK=1:355.93,1:200),1.3,"DD")
 .. Q
 . Q
 I $E(SEG,1,4)="DMG*" D  Q
 . ;JWS;1/6/26;EBILL-6357;only set IBDOB if not already defined with VistA patient info
 . S DOB=$P(ARG(IBSEG),"*",3) I DOB'="",$G(IBDOB)="" S IBDOB=$S($E(DOB,1,2)=19:2,1:3)_$E(DOB,3,8) Q
 . Q
 ;get claim charge amt and place of service code from CLM loop 2300
 I $E(SEG,1,4)="CLM*" D SET^IBCE837ACC1($P(ARG(IBSEG),"*",3),5),SET^IBCE837ACC1($P($P(ARG(IBSEG),"*",6),":"),6) Q
 I $E(SEG,1,4)="DTP*" D  Q
 . I SEG2=431 D DT(9) Q  ;399,.03  ;date of onset
 . I SEG2=454 D DT(10) Q  ;399,246  ;date of initial treatment
 . I SEG2=304 D DT(11) Q  ;399,237  ;date last seen
 . I SEG2=453 D DT(12) Q  ;399,247  ;date acute manifestation
 . I SEG2=439 D DT(13) Q  ;399,41,.02 - OCCURRENCE CODE = 01  ;accident date
 . I SEG2=484 D DT(14) Q  ;399,41,.02 - OCCURRENCE CODE = 10  ;last menstrual period
 . I SEG2=455 D DT(15) Q  ;399,245  ;date last x-ray
 . I SEG2=471 Q  ;hearing & vision prescription date
 . I SEG2=314 D DT(16) Q  ;399,263 and 264 ;disability start and end dates
 . I SEG2=360 D DT(37) Q  ;399,263  ;disability start date
 . I SEG2=361 D DT(38) Q  ;399,264  ;disability end date
 . I SEG2=297 D DT(17) Q  ;399,166  ;date last worked
 . I SEG2=296 D DT(18) Q  ;399,166  ;date authorized return to work
 . ;check admission date - if DTP segment exists, then it's inpatient claim
 . I SEG2=435 S IBIO="I" D DT(19) Q  ;admission date - inpatient
 . I SEG2="096" D DT(20) Q  ;discharge date
 . I SEG2="090" D DT(21) Q  ;assumed care date
 . I SEG2="091" D DT(22) Q  ;relinquished care date
 . I SEG2=444 D DT(23) Q  ;first visit date
 . I SEG2="050" Q  ;repricer date
 . I SEG2=573 Q  ;claim check/ remittance date
 . I SEG2=434 D  Q
 .. D DT(33) ;inst statement dates
 .. N IBXDOS
 .. I $P(ARG(IBSEG),"*",4)="" Q
 .. S IBXDOS=3_$E($P(ARG(IBSEG),"*",4),3,8)
 .. S IBDOS=IBXDOS D SET^IBCE837ACC1(IBDOS,8)
 .. S IBLDOS=3_$E($P($P(ARG(IBSEG),"*",4),"-",2),3,8)
 .. I IBLDOS=3 S IBLDOS=IBXDOS
 .. D SET^IBCE837ACC1(IBLDOS,39)
 .. Q
 . I SEG2=452 D DT(35) Q  ;dental appliance placement date
 . I SEG2=472 D  Q
 .. D DT(36)
 .. I $G(IBDOS)="" S (IBDOS,IBLDOS)=$P(^TMP("IB837ACC",$J),"^",36) D SET^IBCE837ACC1(IBDOS,8),SET^IBCE837ACC1(IBLDOS,39) Q  ;dental date of service - claim level
 .. Q
 I $E(SEG,1,4)="CL1*" D SET^IBCE837ACC1(ARG(IBSEG),1,"CL1") Q 
 I $E(SEG,1,4)="PWK*" Q
 I $E(SEG,1,4)="CN1*" Q  ;NON-HIPPA USE
 I $E(SEG,1,4)="REF*" D  Q
 . I SEG2="D9" S IBREFD9=$P(ARG(IBSEG),"*",3) Q  ;claim identifier for transmission intermediaries
 . I SEG2="EW" D SET^IBCE837ACC1($P(ARG(IBSEG),"*",3),24) Q
 . I SEG2="X4" D SET^IBCE837ACC1($P(ARG(IBSEG),"*",3),25) Q
 . ;JWS;10/23/25;EBILL-6172;add authorization and referral variables
 . I SEG2="G1" S IBAUTH=$P(ARG(IBSEG),"*",3) Q
 . I SEG2="9F" S IBREF=$P(ARG(IBSEG),"*",3) Q
 . ;JWS;EBILL-4922;IB*2.0*770v18;add payer claim control number to encounter
 . ;JWS;6/9/25;appears that cc encounters have the payer control number segment in loop 2330B (other payer claim control number)
 . ;JWS;6/9/25;so adding conditional check in case future encounters have value in loop 2300
 . I SEG2="F8",$P($G(^TMP("IB837ACC",$J)),"^",44)="" D SET^IBCE837ACC1($P(ARG(IBSEG),"*",3),44) Q
 . Q
 I $E(SEG,1,3)="K3*" Q  ;file info
 I $E(SEG,1,4)="NTE*" D SET^IBCE837ACC1($P(ARG(IBSEG),"*",3),1,"NTE"_"-"_$P(ARG(IBSEG),"*",2)) Q
 I $E(SEG,1,4)="CR1*" D SET^IBCE837ACC1(ARG(IBSEG),1,"CR1") S $P(^TMP("IBCE837ACC",$J),"^",40)=1 Q  ; ambulance transport info
 I $E(SEG,1,4)="CR2*" Q
 I $E(SEG,1,4)="CRC*" D  Q
 . I SEG2="07" D SET^IBCE837ACC1(ARG(IBSEG),1,"CRC07") Q  ;amb certification
 . I SEG2=75 D SET^IBCE837ACC1($P(ARG(IBSEG),"*",3,4),26) Q
 . I SEG2="ZZ" D SET^IBCE837ACC1($P(ARG(IBSEG),"*",3,4),27) Q 
 . Q
 ;get principle diagnosis code
 I $E(SEG,1,3)="HI*" D  Q
 . I $P(SEG2,":")="ABK" S IBPDX=$P($P(ARG(IBSEG),":",2),"*") D SET^IBCE837ACC1(ARG(IBSEG),1,"HI-D"),SET^IBCE837ACC1(IBPDX,7) Q  ;diagnosis codes
 . I $P(SEG2,":")="ABF" D SET^IBCE837ACC1(ARG(IBSEG),1,"HI-O") Q  ;other-diagnosis
 . I $P(SEG2,":")="ABJ" Q  ;admitting diagnosis - need if/when doing inpatient
 . I $P(SEG2,":")="APR" D SET^IBCE837ACC1($P(ARG(IBSEG),"*",2,4),28) Q  ;reason for visit
 . I $P(SEG2,":")="ABN" D SET^IBCE837ACC1(ARG(IBSEG),1,"HI-E") Q  ;external cause of injury
 . I $E(SEG2,1,3)="DR:" Q  ;DRG group (inpatient inst)
 . I $E(SEG2,1,3)="BP:" D SET^IBCE837ACC1($P($P(ARG(IBSEG),"*",2),":",2),34) Q  ;anesthesia surgical code
 . I $E(SEG2,1,4)="BBR:" D SET^IBCE837ACC1($P(ARG(IBSEG),"*",2),30) Q
 . I $E(SEG2,1,4)="BBQ:" D SET^IBCE837ACC1($P(ARG(IBSEG),"*",2,13),1,"PROC") Q
 . I $E(SEG2,1,3)="BI:" D SET^IBCE837ACC1($P(ARG(IBSEG),"*",2,13),1,"OSC") Q
 . I $E(SEG2,1,3)="BH:" D SET^IBCE837ACC1($P(ARG(IBSEG),"*",2,13),1,"OC") Q  ;"HI*BH:05:D8:20230501*BH:18:D8:20020301"
 . I $E(SEG2,1,3)="BE:" D SET^IBCE837ACC1($P(ARG(IBSEG),"*",2,13),1,"CV") Q  ;HI*BE:01:::2500*BE:80:::1
 . I $E(SEG2,1,3)="BG:" D SET^IBCE837ACC1($P(ARG(IBSEG),"*",2,13),1,"CC") Q
 . I $E(SEG2,1,3)="TC:" Q  ;probably never get - Treatment Code Info
 I $E(SEG,1,4)="DN1*" D SET^IBCE837ACC1($P(ARG(IBSEG),"*",2,5),1,"DN1") Q  ;ortho total months
 I $E(SEG,1,4)="DN2*" D SET^IBCE837ACC1($P(ARG(IBSEG),"*",2,7),1,"DN2") Q  ;tooth status
 Q
 ;
NEXT ;
 S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N3*" S IBI=IBI+1
 S IBSEGN="SEG"_(IBI+1) I $E($G(ARG(IBSEGN)),1,3)="N4*" S IBI=IBI+1
 Q
 ;
DT(FIELD) ;
 N XDT,DATE
 S DATE=$P(ARG(IBSEG),"*",4)
 I $F(DATE,"-") S XDT=$S($E(DATE,1,2)=19:2,1:3)_$E(DATE,3,8)_"-"_$S($E(DATE,10,11)=19:2,1:3)_$E(DATE,12,17) D SET^IBCE837ACC1(XDT,FIELD) Q
 I DATE'="" S XDT=$S($E(DATE,1,2)=19:2,1:3)_$E(DATE,3,8) I XDT'="" D SET^IBCE837ACC1(XDT,FIELD) Q
 Q
 ;
