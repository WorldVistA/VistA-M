MDCPMESQ ;HINES OIFO/TJ - CP Outbound message queue routine.;30 Jul 2007 ;10/5/11  15:39
 ;;1.0;CLINICAL PROCEDURES;**12,23**;Apr 01, 2004;Build 281
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  #10061       - IN5^VADPT                        Registration                   (supported)
 ;  # 2817       - access "AD" x-ref per ^DG(40.8,  Registration     (controlled subscription)
 ;  # 1373       - access ^ORD(101                  Kernel           (controlled subscription)
 ;  #10039       - access ^DIC(42                   Registration                   (supported)
 ;  # 1181       - access DGPM* event variables     Registration     (controlled subscription)
 ;  #10063       - ^%ZTLOAD TaskMan calls/variables Kernel                         (supported)
 ;  #2164        - GENERATE^HLMA                    HL7                            (supported)
 ;  #2161        - INIT^HLMA and HL7 env. variables HL7                            (supported)
 ;
 ; only call via line tags.
 Q
QUE(MDCIEN,MDCEVN,MDCCOMM) ;
 ; XUTMDEVQ is a little faster and easier here since we're not actually trying to keep the task ID from TaskMan.
 N MDX S MDX("ZTDTH")=$H
 S MDCCOMM="HL7-TASK-QUEUE "_$S($$NODEV^XUTMDEVQ("SEND^MDCPMESQ","MD CP Flowsheets HL7","MDCIEN;MDCEVN",.MDX)<0:"FAILURE",1:"SUCCESS")
 Q MDCCOMM["SUCCESS"
 ;
SEND    ;
 ; ASSUME MDCIEN AND MDCEVN ARE AS BUILT ABOVE
 K HLA,HLEVN,RESULTS,SEND,VFLAG,MSHP
 N HL,HLES,HLECH,HLQ,HLFS,HLCS,MDCPROTO,MDCFDA,MDCOPTNS
 S MDCPROTO=$P($T(@MDCEVN),";",3)
 ;
 ; Step 1 - set up HL7 environment/var. for message
 D INIT^HLFNC2(MDCPROTO,.HL)
 ;I $G(HL) D  Q 0  ; error occurred
 ;. ; Save error text back to record, so we can trace the error.
 ;. K MDCFDA
 ;. S MDCFDA(704.005,MDCIEN_",",.1)=$P(HL,2)
 ;. D UPDATE^DIE("","MDCFDA")
 S HLFS=$G(HL("FS")) I HLFS="" S HLFS="|"
 S HLCM=$E(HL("ECH"),1),HLRP=$E(HL("ECH"),2)
 S HLES=$E(HL("ECH"),3),HLSC=$E(HL("ECH"),4)
 S HL7RC=HLES_HLFS_HLCM_HLRP_HLSC,HLECH=HL("ECH"),HLQ=HL("Q")
 S HLMAXLEN=245
 S VFLAG="V",OUT="",MSHP="ADT"
 ;
 ; Step 2 - Call to MDCADT to set up HLA array
 D BLDMSG^MDCADT(MDCIEN,VFLAG,.OUT,MSHP,MDCEVN)
 M HLA=OUT
 ;
 I MDCEVN="A08" D
 .; We have to set up the HLL("LINKS") array here.
 .S MDCPROT=$$GET1^DIQ(704.005,MDCIEN_",",".21","I")
 .S MDCPROT=$$GET1^DIQ(704.006,MDCPROT_",",".01","I")
 .S HLL("LINKS",1)=$P(^ORD(101,MDCPROT,0),U)_U_$$EXTERNAL^DILFD(101,770.7,"",$P(^ORD(101,MDCPROT,770),U,7))
 ;
 ; Step 3 - Call HL7 to Transmit each message to all TCP links.
 D GENERATE^HLMA(MDCPROTO,"LM",1,.MDCCOMM,"",.MDCOPTNS)
 I +$P(MDCCOMM,U,2) D  Q 0
 . K MDCFDA
 . S MDCFDA(704.005,MDCIEN_",",.1)="HL7 GENERATION ERROR: "_$P(MDCCOMM,U,2)_" - "_$P(MDCCOMM,U,3)
 . D UPDATE^DIE("","MDCFDA")
 Q 1
 ;
PROTOCOL ;
A01 ;;MDC CPAN VS; Admission
A02 ;;MDC CPTP VS; Transfer
A03 ;;MDC CPDE VS; Discharge
A08 ;;MDC CPUPI VS; Retransmit PII
A11 ;;MDC CPCAN VS; Cancel Admission
A12 ;;MDC CPCT VS; Cancel Transfer
A13 ;;MDC CPCDE VS; Cancel Discharge
