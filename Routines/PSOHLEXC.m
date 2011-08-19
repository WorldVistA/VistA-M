PSOHLEXC ;BIR/RTR-Process exceptions in HL7 message ;07/01/02
 ;;7.0;OUTPATIENT PHARMACY;**111**;DEC 1997
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^VA(200 supported by DBIA 224
 ;
 ;Don't worry about ICN, just get it when you build message
CHECK ;Check for application acknowledgement exceptions
 I $G(HL("SAN"))="" S PSOEXMS="Missing sending application name." D NAK Q
 S PSOHY("EXAPP")=HL("SAN")
 I '$G(PSOHY("PAT"))!('$D(^DPT(+$G(PSOHY("PAT")),0))) S PSOEXMS="Invalid patient entry." D NAK Q
 I +$P($G(^DPT(PSOHY("PAT"),.35)),"^") S PSOEXMS="Patient is deceased." D NAK Q
 I $G(PSOHY("OCC"))'="NW" S PSOEXMS="Invalid Order Control Code." D NAK Q
 I '$G(PSOHY("LOC")) S PSOEXMS="No Patient Location." D NAK Q
 I $G(PSOHY("CHNUM"))="" S PSOEXMS="Missing CHCS Placer Order Number." D NAK Q
 I $D(^PS(52.41,"C",PSOHY("CHNUM"),PSOHY("EXAPP"))) S PSOEXMS="Duplicate order number in Outpatient Pending file." D NAK Q
 I $D(^PSRX("D",PSOHY("CHNUM"),PSOHY("EXAPP"))) S PSOEXMS="Duplicate order number in Outpatient Prescription file." D NAK Q
 I $G(PSOHY("REF"))="" S PSOEXMS="Missing number of refills." D NAK Q
 I $G(PSOHY("SDT"))="" S PSOEXMS="Missing effective date." D NAK Q
 I '$G(PSOHY("ENTER")) S PSOEXMS="Missing Entered by data." D NAK Q
 ;Drug exceptions
 I '$G(PSOHY("DRUG"))!('$D(^PSDRUG(+$G(PSOHY("DRUG")),0))) S PSOEXMS="Invalid drug entry." D NAK Q
 I $P($G(^PSDRUG(PSOHY("DRUG"),2)),"^",3)'["O" S PSOEXMS="Drug not marked for outpatient use." D NAK Q
 I $P($G(^PSDRUG(PSOHY("DRUG"),"I")),"^"),$P($G(^("I")),"^")<DT S PSOEXMS="Drug is inactive." D NAK Q
 I '$P($G(^PSDRUG(PSOHY("DRUG"),2)),"^") S PSOEXMS="Drug not associated with a Pharmacy Orderable Item." D NAK Q
 S PSOHY("ITEM")=$P($G(^PSDRUG(PSOHY("DRUG"),2)),"^")
 ;Provider exceptions
CAN ;Also doing provider exceptions on the cancel message
 I '$G(PSOHY("PROV")) S PSOEXMS="Invalid provider entry." D NAK Q
 I '$P($G(^VA(200,PSOHY("PROV"),"PS")),"^") S PSOEXMS="Provider is not authorized to write med orders." D NAK Q
 I '$D(^XUSEC("PROVIDER",PSOHY("PROV"))) S PSOEXMS="Provider does not hold the PROVIDER key." D NAK Q
 N DA,DIC,DIQ,DR,X,Y
 K ^UTILITY("DIQ1",$J) S DIC=200,DR="9.2;53.4",DA=PSOHY("PROV"),DIQ(0)="I" D EN^DIQ1
 I $G(^UTILITY("DIQ1",$J,200,PSOHY("PROV"),9.2,"I")),$P($G(^("I")),"^")'>DT S PSOEXMS="Provider has a termination date." D NAK G END
 I $G(^UTILITY("DIQ1",$J,200,PSOHY("PROV"),53.4,"I")),$P($G(^("I")),"^")'>DT S PSOEXMS="Provider has an inactive date." D NAK
END K ^UTILITY("DIQ1",$J)
 Q
 Q
ACK ;Send a positive acknowledgement of the order
 I $G(HL("APAT"))'="AL" Q
 K PSOEXMS
 D MSH
 S ^TMP("HLA",$J,1)="MSA"_HL("FS")_"AA"_HL("FS")_$G(HL("MID"))_HL("FS")_$G(PSOEXMS)
 D SEND
 Q
NAK ;Send a negative acknowledgement of the order
 S PSOEXXQ=1
 I $G(HL("APAT"))'="AL" Q
 D MSH
 ;S ^TMP("HLA",$J,1)="MSA"_HL("FS")_$S($G(PSOHBDS):"AR",1:"AE")_HL("FS")_$G(HL("MID"))_HL("FS")_$G(PSOEXMS)
 ;For now, always sending back the AA, not the AR or AE
 S ^TMP("HLA",$J,1)="MSA"_HL("FS")_"AA"_HL("FS")_$G(HL("MID"))_HL("FS")_$G(PSOEXMS)
 ;Sending AR back for missing segments, AE for other data validations
 D SEND
 Q
MSH ;
 K ^TMP("HLA",$J)
 S PSOHEID=$G(HL("EID")),PSOHEIDS=$G(HL("EIDS"))
 S PSOHLRS=""
 ;Vista HL7 will build the MSH
 Q
SEND ;
 D GENACK^HLMA1(PSOHEID,HLMTIENS,PSOHEIDS,"GM",1,.PSOHLRS)
 K ^TMP("HLA",$J)
 Q
