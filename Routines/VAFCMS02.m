VAFCMS02 ;BP-CIOFO/JRP-PIVOT FILE RETRANSMISSION ;8/3/1998
 ;;5.3;Registration;**209,149**;Aug 13, 1993
 ;
PATIENT ;Transmit demographic data for user selected entry in PATIENT file (#2)
 ;Input  : None
 ;Output : None
 ;Notes  : Creates entry in ADT/HL7 PIVOT file (#391.71) and flags
 ;         for transmission
 ;
 N DFN,PIVOTNUM,PIVOTPTR,VPTR
 F  W !! S DFN=$$GETDFN^VAFCMS01() Q:(DFN<1)  D
 .;Create entry in ADT/HL7 PIVOT file (returns pivot number)
 .S VPTR=DFN_";DPT("
 .S PIVOTNUM=+$$PIVNW^VAFHPIVT(DFN,$$NOW^XLFDT(),4,VPTR)
 .I ('PIVOTNUM) D  Q
 ..W !!,"** UNABLE TO TRANSMIT DEMOGRAPHIC DATA **"
 ..W !,"   UNABLE TO CREATE ENTRY IN ADT/HL7 PIVOT FILE"
 ..W !!
 ..H 2
 .;Convert pivot number to pointer
 .S PIVOTPTR=+$O(^VAT(391.71,"D",PIVOTNUM,0))
 .I ('PIVOTPTR) D  Q
 ..W !!,"** UNABLE TO TRANSMIT DEMOGRAPHIC DATA **"
 ..W !,"   UNABLE TO PROPERLY CREATE ENTRY IN ADT/HL7 PIVOT FILE"
 ..W !!
 ..H 2
 .;Transmit
 .D DEMO(PIVOTPTR)
 .W !,"Demographic data queued for transmission"
 Q
 ;
PIVOT ;Retransmit user selected entry in ADT/HL7 PIVOT file (#391.71)
 ;Input  : None
 ;Output : None
 ;
 N PIVOT
 F  W !! S PIVOT=$$GETPIVOT() Q:(PIVOT<1)  D
 .D RETRAN(PIVOT)
 .W !,"Selected entry queued for retransmission"
 Q
 ;
GETPIVOT() ;Get pointer to ADT/HL7 PIVOT file (#391.71)
 ;Input  : None
 ;Output : Pointer to ADT/HL7 PIVOT file
 ;         -1 returned if no selection made
 ;Notes  : Pivot file entry must point to a valid patient
 ;       : Selection of event types 2 (outpatient) and 5 (treating
 ;         facility update) are not supported/allowed
 ;
 N DIC,X,Y,DTOUT,DUOUT
 S DIC="^VAT(391.71,"
 S DIC(0)="AEMNQ"
 S DIC("S")="I "",1,3,4,""[+$P(^(0),""^"",4) I $D(^DPT(+$P(^(0),""^"",3),0))"
 D ^DIC
 Q +Y
 ;
RETRAN(PIVOT) ;Retransmit entry in ADT/HL7 PIVOT file (#391.71)
 ;Input  : PIVOT - Pointer to entry in ADT/HL7 PIVOT file (#391.71)
 ;Output : None
 ;Notes  : Support for pivot event types 2 (outpatient) and 5
 ;         (treating facility update) not implemented
 ;
 ;
 N NODE,TYPE
 ;Get event type out of pivot file
 S NODE=$G(^VAT(391.71,PIVOT,0))
 S TYPE=+$P(NODE,"^",4)
 ;Inpatient (A/D/T)
 I TYPE=1 D  Q
 .N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK
 .S ZTRTN="ADT^VAFCMS02("_PIVOT_")"
 .S ZTDESC="Retransmit admission history message(s) via HL7"
 .S ZTDTH=$H
 .S ZTIO=""
 .D ^%ZTLOAD
 ;Register
 I TYPE=3 D  Q
 .N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK
 .S ZTRTN="REG^VAFCMS02("_PIVOT_")"
 .S ZTDESC="Retransmit registration message via HL7"
 .S ZTDTH=$H
 .S ZTIO=""
 .D ^%ZTLOAD
 ;Demographic update
 I TYPE=4 D DEMO(PIVOT) Q
 Q
 ;
ADT(PIVOT) ;Transmit Admit/Discharge/Transfer entry in pivot file
 ;Input  : PIVOT - Pointer to entry in ADT/HL7 PIVOT file (#391.71)
 ;Output : None
 ;
 N NODE,DFN,ADMSSN,HISTORY
 ;Clean up HL7 variables
 K ^TMP("HLS",$J) D KILL^HLTRANS
 ;Get required info out of pivot file
 S NODE=$G(^VAT(391.71,PIVOT,0))
 S DFN=+$P(NODE,"^",3)
 S ADMSSN=+$P(NODE,"^",5)
 ;Build list of A/D/T events (i.e. movements) for related admission
 D BLDHIST^VAFCADT3(DFN,ADMSSN,"HISTORY")
 ;Transmit A/D/T history for related admission
 D ENTIRE^VAFCADT4(PIVOT)
 ;Clean up HL7 variables
 K ^TMP("HLS",$J) D KILL^HLTRANS
 S:($D(ZTQUEUED)) ZTREQ="@"
 Q
REG(PIVOT) ;Transmit Registration entry in pivot file
 ;Input  : PIVOT - Pointer to entry in ADT/HL7 PIVOT file (#391.71)
 ;Output : None
 ;
 N NODE,DFN,DATE,RESULT
 ;Clean up HL7 variables
 K ^TMP("HLS",$J) D KILL^HLTRANS
 ;Get required info out of pivot file
 S NODE=$G(^VAT(391.71,PIVOT,0))
 S DFN=+$P(NODE,"^",3),USER=+$P(NODE,"^",9)
 S DATE=+NODE
 ;Generate/send message
 S RESULT=$$EN^VAFCA04(DFN,DATE,USER,PIVOT)
 ;Clean up HL7 variables
 K ^TMP("HLS",$J) D KILL^HLTRANS
 S:($D(ZTQUEUED)) ZTREQ="@"
 Q
DEMO(PIVOT) ;Transmit Demographic Update entry in pivot file
 ;Input  : PIVOT - Pointer to entry in ADT/HL7 PIVOT file (#391.71)
 ;Output : None
 ;
 ;Flag entry in pivot file for transmission (let background job send it)
 D XMITFLAG^VAFCDD01(PIVOT)
 Q
