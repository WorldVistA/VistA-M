ALPBINP ;OIFO-DALLAS/SED/KC/MW  BCMA - BCBU INPT TO HL7 ;5/2/2002
 ;;3.0;BAR CODE MED ADMIN;**8,37**;May 2007;Build 10
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;This routine will intercept the HL7 message that it sent from Pharmacy
 ;to CPRS to update order information. The message is then parsed and 
 ;repackage so it can be sent to the BCBU workstation.
 ;
 ; Reference/IA
 ; EN^PSJBCBU/3876
 ; $$EN^VAFHLPID/263
 ; $$EN^VAFHAPV1/4512
 ; EN1^GMRADPT/10099
 ; EN^PSJBCMA1/2829
 ;
IPH(MSG) ;CAPTURE MESSAGE ARRAY FROM PHARMACY
 N VAIN,ALPMSG
 S ALPMSG=$S($L($G(MSG)):MSG,1:"MSG")
 I '$O(@ALPMSG@(0)) Q "0^MSG^Missing Message Array"
 S MSH=0
 F  S MSH=$O(@ALPMSG@(MSH)) Q:MSH'>0  Q:$E(@ALPMSG@(MSH),1,3)="MSH"
 I +MSH'>0 Q "0^MSG^Missing MSH Segment Bad Message"
 S MSFS=$E(@ALPMSG@(MSH),4,4)
 S MSCS=$E(@ALPMSG@(MSH),5,5)
 S MSCH=$E(@ALPMSG@(MSH),6,6)
 S MSCTR=$E(@ALPMSG@(MSH),4,8)
 ;The message is confirmed to be a Pharmacy message
 I $P(@ALPMSG@(MSH),MSFS,3)'="PHARMACY" Q "1^^Not a Pharmacy Message"
 ;A PID and PV1 segment is required for this message
 S PID=0
 F  S PID=$O(@ALPMSG@(PID)) Q:PID'>0  Q:$E(@ALPMSG@(PID),1,3)="PID"
 I +PID'>0 Q "0^MSG^Missing PID Segment Bad Message"
 ;Also the patient must have an inpatient status
 S PV1=0
 F  S PV1=$O(@ALPMSG@(PV1)) Q:PV1'>0  Q:$E(@ALPMSG@(PV1),1,3)="PV1"
 I +PV1'>0 Q "0^MSG^Missing PV1 Segment Bad Message"
 I $P(@ALPMSG@(PV1),MSFS,3)'="I" Q "1^^Not an Inpatient Pharmacy Message"
 S ORC=0
 F  S ORC=$O(@ALPMSG@(ORC)) Q:ORC'>0  Q:$E(@ALPMSG@(ORC),1,3)="ORC"
 I +ORC'>0 Q "0^MSG^Missing ORC Segment Bad Message"
 ;RE-BUILDING THE MESSAGE FOR BCBU
 S ALPDFN=$P(@ALPMSG@(PID),MSFS,4)
 I +ALPDFN'>0 Q "0^MSG^Invalid or Missing Patient - PID"
 S ALPORD=$P($P(@ALPMSG@(ORC),MSFS,4),MSCS,1)
 I ALPORD="" Q "0^MSG^Invalid or Missing Order Number - ORC"
 K ALPB
 D EN^PSJBCBU(ALPDFN,ALPORD,.ALPB)
SEED ;Entry point for ^ALPBIND
 N VAIN
 D INIT
 S SUB=0 F  S SUB=$O(ALPB(SUB)) Q:'SUB  D
 . ;convert and move the message to the HLA array for transport
 . S HLA("HLS",SUB)=$$CNV^ALPBUTL1(MSCTR,HLCTR,ALPB(SUB))
 . ;Now check for continuations 
 . S SUB1=0
 . F  S SUB1=$O(ALPB(SUB,SUB1)) Q:'SUB1  D
 . . S HLA("HLS",SUB,SUB1)=$$CNV^ALPBUTL1(MSCTR,HLCTR,ALPB(SUB,SUB1))
 . I $E(HLA("HLS",SUB),1,3)="RXE" S RXE=SUB
 . I $E(HLA("HLS",SUB),1,3)="PID" S PID=SUB
 . I $E(HLA("HLS",SUB),1,3)="PV1" S PV1=SUB
 K HLA("HLS",MSH)
 I '$D(HLA("HLS",PID)) Q "0^MSG^Missing PID Segment Bad Message"
 S ALPDFN=$P($P(HLA("HLS",PID),HLFS,4),HLCS,1)
 I +ALPDFN'>0 Q "0^MSG^Invalid or Missing Patient - PID"
 S HLA("HLS",PID)=$$EN^VAFHLPID(ALPDFN,"2,7,8,19")
 ;Fix RXE segement for Administration Type
 D RXE
 ;Get the Division that the patient is associated with
 D PDIV
 I ALPDIV="DOM",+$$GET^XPAR("PKG.BAR CODE MED ADMIN","PSB BKUP DOM FILTER",1,"Q")>0 Q "0^^Screen of DOMICILIARY"
 I '$D(HLL("LINKS")) Q "0^HL7^Missing HLL Links Array Division # "_ALPDIV
 ;SET NEW PV1
 D NOW^%DTC
 S STRING=$$EN^VAFHAPV1(ALPDFN,%,"2,3,7,18")
 S HLA("HLS",PV1)=STRING
 I +ORC>0 D
 . S ALPST=$$STAT^ALPBUTL1($P(HLA("HLS",ORC),HLFS,6))
 . Q:ALPST=""
 . S $P(HLA("HLS",ORC),HLFS,6)=$P(HLA("HLS",ORC),HLFS,6)_HLCS_ALPST
 D AL1
 ;Capture message to review for testing before sending
 D SEND
EXIT ;EXIT and kill
 K HLA,SUB,SUB1,STRING,ALPLOC,HLCS,HLCTR,HLFS,MSCH,MSCS,MSCTR
 K MSH,ORC,PID,PV1,RXE,RXR,ALPB,ALPBY,ALPBYN,ALPC,ALPDATA,ALPDFN
 K ALPDT,ALPI,ALPII,ALPIV,ALPOPTS,ALPOR,ALPORD,ALPST
 K ALPSTN,ALPSYM,EVENT,GMRA,GMRAL
 Q ALPRSLT
INI() ;INTIAL SET UP ENTRY
 G SEED
INIT ;CALL HL7 TO INITIALIZE MESSAGE VARIABLES
 ;SET UP ENVIRONMENT FOR MESSAGE
 K HL,HLA,HLECH,HLQ,ALPRSLT,ALPOPTS
 S EVENT="PSB BCBU ORM SEND"
 D INIT^HLFNC2(EVENT,.HL,1)
 S HLCS=$E(HL("ECH")),HLCTR=HLFS_HL("ECH")
 Q
SEND ;CALL HL7 TO TRANSMIT SINGLE MESSAGE
 K ALPRSLT,ALPOPTS
 D GENERATE^HLMA(EVENT,"LM",1,.ALPRSLT,"",.ALPOPTS)
 Q
AL1 ;ALLERGY SEGMENT BUILD
 ;The will build the ALP segment with the curent allergies
 ;for the patient to be added to the message
 N DFN
 Q:+ALPDFN'>0
 K GMRAL
 S DFN=ALPDFN
 S GMRA="0^0^111"  ;DEFINES WHAT ALLERGIES TO RETURN
 D EN1^GMRADPT
 Q:'$D(GMRAL)
 S ALPI=0,ALPC=1,ALPSYM=""
 F  S ALPI=$O(GMRAL(ALPI)) Q:+ALPI'>0  D
 . S ALPADR=""
 . I $P($P(GMRAL(ALPI),U,8),";",2)="P" S ALPADR="**ADR** "
 . S ALPDATA="AL1"_HLFS_ALPC_HLFS_$P(GMRAL(ALPI),U,7)
 . S ALPDATA=ALPDATA_HLFS_ALPI_HLCS_ALPADR_$E($P(GMRAL(ALPI),U,2),1,25)_HLCS_"VA120.8"
 . ;S ALPII=0 F  S ALPII=$O(GMRAL(ALPI,"S",ALPII)) Q:+ALPII'>0  D
 . ;. S ALPSYM=ALPSYM_$P(GMRAL(ALPI,"S",ALPII),";",1)_HLCS
 . ;S $P(ALPDATA,HLFS,6)=ALPSYM
 . S HLA("HLS",$O(HLA("HLS",9999999),-1)+1)=ALPDATA
 . S ALPC=ALPC+1
 K GMRAL
 Q
RXE ;
 Q:+$G(RXE)'>0
 K ^TMP("PSJ1",$J)
 Q:'$D(HLA("HLS",RXE))
 S DATA=HLA("HLS",RXE)
 D EN^PSJBCMA1(ALPDFN,ALPORD,1)
 S TYP=$P($G(^TMP("PSJ1",$J,4)),U,2)
 Q:TYP="CONTINUOUS"
 Q:TYP="FILL ON REQUEST"
 S ALP1=$P(DATA,HLFS,2),ALP2=$P(ALP1,HLCS,2)
 I ALP1[TYP Q
 I ALP2[TYP Q
 S $P(ALP2,"&",1)=$P(ALP2,"&",1)_" "_TYP
 S $P(ALP1,HLCS,2)=ALP2,$P(DATA,HLFS,2)=ALP1
 S HLA("HLS",RXE)=DATA
 K TYP,ALP1,ALP2,^TMP("PSJ1",$J)
 Q
PDIV ;PATIENT DIVISION
 ;Check ALPBMDT Variable
 S:+$G(ALPBMDT)'>0 ALPBMDT=0
 S ALPDIV=$$DIV^ALPBUTL1(ALPDFN,ALPBMDT)
 ;Screen Dom
 I ALPDIV="DOM",+$$GET^XPAR("PKG.BAR CODE MED ADMIN","PSB BKUP DOM FILTER",1,"Q")>0 Q
 ;Now do I send the Message or not Based of Division
 I $D(ALPHLL("LINKS")) M HLL("LINKS")=ALPHLL("LINKS")
 I '$D(HLL("LINKS")) D GET^ALPBPARM(.HLL,ALPDIV)
 Q
MEDL(ALPML) ;Use this entry to send MedLog messages
 N VAIN
 ;ALPML is the IEN of the MedLog for file #53.79
 I '$D(ALPML) Q "0^ALPML^No Med-Log Number"
 I '$D(^PSB(53.79,ALPML,0)) Q "0^"_ALPML_"^Med - Log Number Invalid"
 ;First get the required HL7 Variables
 D INIT
 ;Need to build the PID, PV1 and ORC segments
 S ALPDFN=+$P($G(^PSB(53.79,ALPML,0)),U,1)
 I +ALPDFN'>0 Q "0^"_ALPML_"^Invalid or Missing Patient - Med-Log"
 ;Get the Division that the patient is associated with
 D PDIV
 I ALPDIV="DOM",+$$GET^XPAR("PKG.BAR CODE MED ADMIN","PSB BKUP DOM FILTER",1,"Q")>0 Q "0^^Screen of DOMICILIARY"
 I '$D(HLL("LINKS")) Q "0^"_ALPML_"^Missing HLL Links Array Med-Log"
 S ALPST=$P($G(^PSB(53.79,ALPML,0)),U,9)
 S ALPBY=$P($G(^PSB(53.79,ALPML,0)),U,7)
 S ALPDT=$P($G(^PSB(53.79,ALPML,0)),U,6)
 S ALPOR=$P($G(^PSB(53.79,ALPML,.1)),U,1)
 S ALPBYN=$P($G(^VA(200,ALPBY,0)),U,1)
 S ALPSTN=$S($D(ALPST):$$EXTERNAL^DILFD(53.79,".09",,ALPST),1:"Non")
 I '$D(ALPOR) Q "0^"_ALPML_"^Invalid or Missing Pharmacy Order Number Med-Log"
 S PID=$$EN^VAFHLPID(ALPDFN,"2,7,8,19")
 I '$D(PID) Q "0^"_ALPML_"^Invalid or Missing Patient - PID Med-Log"
 S PV1=$$EN^VAFHAPV1(ALPDFN,DT,"2,3,7,18")
 I '$D(PV1) Q "0^"_ALPML_"^Invalid or Missing Patient Location - PV1 Med-Log"
 S HLA("HLS",1)=PID
 S HLA("HLS",2)=PV1
 ;BUILD ORC SEGMENT
 S ORC="ORC"_HLFS_"ML"_HLFS_ALPML_HLCS_"ML"_HLFS_ALPOR_HLCS_"PS"_HLFS
 S ORC=ORC_HLFS_ALPST_HLCS_ALPSTN_HLFS_HLFS_HLFS_HLFS
 S ORC=ORC_$$HLDATE^HLFNC(ALPDT,"TS")_HLFS_ALPBY_HLCS_ALPBYN
 S HLA("HLS",3)=ORC
 ;The Message is ready to send
 D SEND
 Q ALPRSLT
 ;
ADMQ ;Need to que a single patient init for admissions
 S ALDFN=ALPDFN
 S ZTDTH=$$NOW^XLFDT
 S ZTRTN="PAT^ALPBIND"
 S ZTDESC="PSB - Initialize Single Patient on Admission Contingency Workstation"
 S ZTIO="",ZTSAVE("ALDFN")=""
 D ^%ZTLOAD
 K ZTIO,ZTDESC,ZTRTN,ZTSK
 Q
PMOV(ALPDFN,ALPTYP,ALPTT,ALPBMDT) ;Entry Point to send patient movement
 N VAIN
 I +$G(ALPDFN)'>0 Q "0^^Missing Patient ID"
 D INIT
 ;Check Movement type. If not a discharge then don't pass date and time
 S:$G(ALPTT)'="DISCHARGE" ALPBMDT=0
 ;Get the Division that the patient is associated with
 D PDIV
 I ALPDIV="DOM",+$$GET^XPAR("PKG.BAR CODE MED ADMIN","PSB BKUP DOM FILTER",1,"Q")>0 Q "0^^Screen of DOMICILIARY"
 I '$D(HLL("LINKS")) Q "0^"_ALPDFN_"^Missing HLL Links Array Pat-Move"
 S HLA("HLS",1)=$$EN^VAFHLPID(ALPDFN,"2,7,8,19")
 S HLA("HLS",2)=$$EN^VAFHAPV1(ALPDFN,DT,"2,3,7,18")
 S:$G(ALPTT)="DISCHARGE" $P(HLA("HLS",2),HLFS,37)=$G(ALPTYP)
 D SEND
 I ALPTYP=14!(ALPTYP=41) S ALPTT="ADMISSION" ;FOR RETURN FROM ASIH
 I $G(ALPTT)="ADMISSION" D ADMQ
 ;SEND A DISCHARGE TO DIV SENDING ASIH
 I $G(ALPTYP)[13!($G(ALPTYP)[40) D
 .D INIT
 .S ALPWRD=$P($G(DGPMVI(5)),U,1) ;LAST WARD
 .I +ALPWRD'>0 S ALPRSLT="0^^Screen - No Ward" Q  ;NO WARD
 .S ALPBDIV=$P($G(^DIC(42,ALPWRD,0)),U,11)
 .D GET^ALPBPARM(.HLL,ALPBDIV)
 .S HLA("HLS",1)=$$EN^VAFHLPID(ALPDFN,"2,7,8,19")
 .S HLA("HLS",2)=$$EN^VAFHAPV1(ALPDFN,DT,"2,3,7,18")
 .S $P(HLA("HLS",2),HLFS,37)="ASIH"
 .D SEND
 Q ALPRSLT
