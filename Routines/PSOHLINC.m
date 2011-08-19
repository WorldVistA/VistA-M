PSOHLINC ;BIR/RTR - Process incoming order messages from CHCS ;06/17/02
 ;;7.0;OUTPATIENT PHARMACY;**111,143**;DEC 1997
 ;
EN ;Process incoming outpatient order messages
 N PSOXLONG,PSOHDFOR,PSOHLTAG,PSOHBDS,PSOHMSG,PSOHLMIS,PSOHLRS,PSOHEID,PSOHEIDS,PSOHFSP,PSOHLNOP,PSOXHI,PSOHLZ,PSOHLZC,PSOHLRXO,PSOXMH,PSOHY,PSOEXMS,PSOEXXQ,PSOHG,PSOBH,X,Y
 I '$G(DT) S DT=$$DT^XLFDT
 S (PSOXLONG,PSOHLRXO,PSOHLNOP,PSOHDFOR)=0
 S PSOHFSP=$E(HL("ECH"),1)
 K PSOHLMIS
 F PSOXHI=1:1 K PSOHB X HLNEXT Q:HLQUIT'>0!(PSOHLNOP)!(PSOHDFOR)!(PSOXLONG)  S PSOHB=HLNODE,PSOXMH=$E(PSOHB,1,3) D
 .S PSOHG=0 F  S PSOHG=$O(HLNODE(PSOHG)) Q:'PSOHG!(PSOHLNOP)!(PSOHDFOR)!(PSOXLONG)  S PSOHB(PSOHG)=HLNODE(PSOHG)
 .I (PSOXMH'?3U),(PSOXMH'?2U1N) S PSOHDFOR=1 Q
 .I $T(@PSOXMH)]"" D @PSOXMH
 ;Quit if not a Pharmacy message, no acknowledgements
 I $G(PSOHLNOP) Q
 I $G(PSOHY("OCC"))="CA" D ENDC^PSOHLDC Q
 I PSOXLONG S PSOEXMS="Invalid NTE segment, greater than 245 characters." D NAK^PSOHLEXC Q
 S (PSOHBDS,PSOEXXQ)=0
 I PSOHDFOR S PSOEXMS="Invalid message structure." D NAK^PSOHLEXC Q
 F PSOHMSG="MSH","PID","PV1","ORC","RXO" Q:PSOEXXQ  I '$D(PSOHLMIS(PSOHMSG)) S PSOEXMS="Missing "_PSOHMSG_" segment." S PSOHBDS=1 D NAK^PSOHLEXC
 ;Quit if segment is missing
 I $G(PSOEXXQ) Q
 ;Quit if not a Pharmacy message, no acknowledgements
 ;I $G(PSOHLNOP) Q
 ;check for data exceptions
 D CHECK^PSOHLEXC
 ;PSOEXXQ set if a NAK was sent back
 I $G(PSOEXXQ) Q
 ;Enter order into Pending Outpatient Orders file
 D ADD^PSOHCPRS
 ;Send successful acknowledgement if PSOEXXQ not set
 I '$G(PSOEXXQ) D ACK^PSOHLEXC
 Q
 ;What about regular acknowledgements?  handled by HL7 package somehow
 Q
MSH ;Process MSH segment
 I $P(PSOHB,HL("FS"),5)'="PSO RECEIVE" S PSOHLNOP=1
 S PSOHLMIS("MSH")=""
 Q
PID ;Process PID segment
 D FORM
 S PSOHY("PAT")=+$P(PSOHB,HL("FS"),3)
 S PSOHLMIS("PID")=""
 Q
PV1 ;Process PV1 segment
 D FORM
 S PSOHY("LOC")=+$P(PSOHB,HL("FS"),3)
 S PSOHLMIS("PV1")=""
 Q
DG1 ;Process DG1 segment ; future use
 D FORM
 S $P(PSOHY("ICD"),U,$P(PSOHB,HL("FS"),1))=$P(PSOHB,HL("FS"),3)
ZCL Q  ;future use
 ;
ORC ;Process ORC segment
 S PSOHLRXO=1 ;For future use in processing NTE's, if other segments get NTE(6) or (7)
 D FORM
 I $O(PSOHB(""))'="" D ORC^PSOHLINL Q
 S PSOHY("OCC")=$P(PSOHB,HL("FS"))
 ;Set priority to Routine
 S PSOHY("PRIOR")="R"
 S PSOHY("CHNUM")=$P($P(PSOHB,HL("FS"),2),PSOHFSP)
 D NOW^%DTC S PSOHY("EDT")=%
 S X=$P(PSOHB,HL("FS"),9) D
 .I X S PSOHY("SDT")=$$HL7TFM^XLFDT(X) Q
 .S PSOHY("SDT")=$G(PSOHY("EDT"))
 S PSOHY("ENTER")=+$P(PSOHB,HL("FS"),10)
 S PSOHY("PROV")=+$P(PSOHB,HL("FS"),12)
 S PSOHLMIS("ORC")=""
 Q
RXO ;Process RXO segment
 D FORM
 I $O(PSOHB(""))'="" D RXO^PSOHLINL Q
 S PSOHY("DRUG")=+$P(PSOHB,HL("FS"),10)
 S PSOHY("QTY")=$P(PSOHB,HL("FS"),11)
 S PSOHY("REF")=$P(PSOHB,HL("FS"),13)
 S PSOHLMIS("RXO")=""
 Q
RXR ;Process RXR segment
 D FORM
 Q
ZRX ;Process ZRX segment
 D FORM
 S PSOHY("PICK")=$S($P(PSOHB,HL("FS"),4)="M":"M",1:"W")
 Q
NTE ;
 D FORM
 I $P(PSOHB,HL("FS"))=6 D COMM Q
 I $P(PSOHB,HL("FS"))=7 D SIG Q
 Q
COMM ;Process Provider Comments
 I $O(PSOHB(""))'="" D COMM^PSOHLINL Q
 K ^UTILITY($J,"W")
 S X=$P(PSOHB,HL("FS"),3,999)
 I $L(X)>245 S PSOXLONG=1 Q
 S DIWL=1,DIWR=70,DIWF="" D ^DIWP
 D ENCOMM^PSOHLINL
 K ^UTILITY($J,"W")
 Q
SIG ;Process SIG
 I $O(PSOHB(""))'="" D SIG^PSOHLINL Q
 K ^UTILITY($J,"W")
 S X=$P(PSOHB,HL("FS"),3,999)
 I $L(X)>245 S PSOXLONG=1 Q
 S DIWL=1,DIWR=70,DIWF="" D ^DIWP
 D ENSIG^PSOHLINL
 K ^UTILITY($J,"W")
 Q
FORM ;
 S PSOHB=$E(PSOHB,(4+$L(HL("FS"))),$L(PSOHB))
 Q
 ;AND IF YOU ADD PSOHLNEW TO THE PATCH, FIX THE HEADER OF THE 3 NODE TO MATCH HOW YOU DID IT IN PSOHCPRS. SINCE IT IS A WORD PROCESSING FIELD
 ; And maybe fix -1 problem if no related institution is found
 ; AND IF YOU PATCH PSOHLSN1, AT THE rxr POINT, INITIALIZE RTENAME AT THE BEGINNING OF EACH LOOP
