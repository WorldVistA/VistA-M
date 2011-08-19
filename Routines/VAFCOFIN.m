VAFCOFIN ;BIR/DR-TREATING FACILTIY MFU PROCESSING ROUTINE ; 2/1/10 12:46pm
 ;;5.3;Registration;**821**;Aug 13, 1993;Build 7
 ;Reference to EXC, START, and STOP^RGHLLOG supported by IA #2796
 ;
 ;***NOTE***
 ;This routine is copy of original VAFCTFIN before DG*5.3*821
 ;It is modified so VistA can process MFN~M05 in old format until
 ;MPI starts sending new format.
 ;
IN ;This entry point is used to process the Treating Facility Master File Update Message.
 ;It is called by the VAFC MFN-M05 CLIENT processing routine when a MFN
 ;message is received.
 ;There are no inputs or outputs
 ;
 I HL("MTN")="MFK" D RSP Q
 N VAFC,STATN,VAFCI,MSG,SG,VAFCARR,PDFN,INST,MFUPT,PDLT,TFIEN
 N ICN,MFI,MFE,MFA,HLCOMP,CNT,X,VAFCERR,VAFCX
 ;quit if Master Patient Index (MPI) is not installed
 S X="MPIF001" X ^%ZOSF("TEST") Q:'$T
 S X="MPIFQ0" X ^%ZOSF("TEST") Q:'$T
 S X="RGRSBUL1" X ^%ZOSF("TEST") Q:'$T
 S X="RGRSBULL" X ^%ZOSF("TEST") Q:'$T
INIT ;Process in the Treating Facility MFN msg
 F VAFCI=1:1 X HLNEXT Q:HLQUIT'>0  S (MSG,VAFC(VAFCI))=HLNODE,SG=$E(HLNODE,1,3) D:SG?2A1(1A,1N) PICK
 ;reconcil the inbound TF list from the MPI to the local TF list
 D RECONCIL
 ;create response message
 S CNT=1
 S HLA("HLA",1)="MSA"_HL("FS")_"AA"_HL("FS")_HL("MID")_HL("FS") S CNT=CNT+1
 S HLA("HLA",CNT)=MFI S CNT=CNT+1
 S VAFCX=0 F  S VAFCX=$O(MFE(VAFCX)) Q:'VAFCX  S HLA("HLA",CNT)=MFE(VAFCX),CNT=CNT+1,HLA("HLA",CNT)=MFA(VAFCX),CNT=CNT+1
 ;generate an application level ack (MFK) identifying the status of the adds/edits/deletes of TF's passed in
 D ROUTE
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.VAFCERR,"",.HLP)
 Q
PICK ;check routine for segment entry point
 I $T(@SG)]"" D @SG
 I $T(@SG)="" Q
 Q
MSH ;;MSH
 ;process the MSH segment
 S (HLFS,HL("FS"))=$E(MSG,4),(HLECH,HL("ECH"))=$E(MSG,5,8)
 S HLCOMP=$E(HL("ECH"),1)
 S VAFCARR("SENDING SITE")=$P(MSG,HL("FS"),4)
 Q
EVN ;;EVN
 ;process the EVN segment
 S STATN=+$$SITE^VASITE()_"^"_$$FMDATE^HLFNC($P(MSG,HL("FS"),3))
 Q
PID ;;PID
 ;process the PID segment
 S PDFN=+$P(MSG,HL("FS"),4)
 Q
MFI ;;MFI
 ;process the MFI segment
 S MFI=MSG
 S MFUPT=$P(MSG,HL("FS"),4)
 S VAFCARR("CMOR")=$P($P(MSG,HL("FS"),8),$E(HL("ECH"),1))
 Q
MFE ;;MFE
 ;process the MFE segment
 N HLCOMP,NXTSGMT,TYPE
 S HLCOMP=$E(HL("ECH"),1)
 S PDLT=$$FMDATE^HLFNC($P(MSG,HL("FS"),4))
 S ICN=$P($P(MSG,HL("FS"),5),HLCOMP,4)
 S INST=$P($P(MSG,HL("FS"),5),HLCOMP)
 S TYPE=$P(MSG,HL("FS"),2)
 S MFE(INST)=MSG
 S MFI(ICN,INST)=PDLT_"^^"_TYPE
 Q
ZET ;;ZET
 ;process Patient's Date Last Treated Event Type, ZET segment
 N PDLTET,IPP
 S PDLTET=$P(MSG,HL("FS"),2)
 S $P(MFI(ICN,INST),"^",2)=PDLTET
 ;DG*5.3*800 - Process In-Person Proofed
 S IPP=$P(MSG,HL("FS"),3) ;In-Person Proofed
 S $P(MFI(ICN,INST),"^",6)=IPP
 Q
RSP ;response process logic entry point
 Q
ROUTE ;routing logic entry point
 N MPI
 S MPI=$$MPILINK^MPIFAPI() D
 .I $P($G(MPI),U)'=-1 S HLL("LINKS",1)="VAFC MFN-M05 CLIENT"_"^"_MPI
 .I $P($G(MPI),U)=-1 D
 .. N RGLOG D START^RGHLLOG(HLMTIEN,"","")
 .. D EXC^RGHLLOG(224,"No MPI link identified in CIRN SITE PARAMETER file (#991.8)",$G(PDFN))
 .. D STOP^RGHLLOG(0)
 Q
TEST ;
 W $$REPROC^HLUTIL(39266,"D IN^VAFCTFIN")
 Q
RECONCIL ;
 N DFN,MFIC,VAFCX,VAFCY,TFL,CNFLT,LOCCMOR,VAFCTYPE
 S CNFLT=0
 S DFN=$$GETDFN^MPIF001(ICN)
 I DFN'>0 S CNFLT=1_"^"_$P($G(DFN),"^",2)
 I MFUPT="REP" I +CNFLT=0 D TFL^VAFCTFU1(.TFL,DFN) S VAFCX=0 F  S VAFCX=$O(TFL(VAFCX)) Q:'VAFCX  D
 . S MFIC($P(TFL(VAFCX),"^"))=TFL(VAFCX) I '$D(MFI(ICN,$P(TFL(VAFCX),"^"))) D DEL(ICN,$P(TFL(VAFCX),"^"))
 ;VAFCX=ICN and VAFCY=INSTITUTION
 S VAFCX=0 F  S VAFCX=$O(MFI(VAFCX)) Q:'VAFCX  D
 . S VAFCY=0 F  S VAFCY=$O(MFI(VAFCX,VAFCY)) Q:'VAFCY  D
 ..S VAFCTYPE=$P(MFI(VAFCX,VAFCY),"^",3)
 ..I +CNFLT=1 S MFA(VAFCY)="MFA"_HL("FS")_VAFCTYPE_HL("FS")_VAFCY_HL("FS")_$$HLDATE^HLFNC($$NOW^XLFDT)_HL("FS")_"U"_HLCOMP_$S(VAFCTYPE="MDL":"Delete of ",1:"Update of ")_VAFCY_" Failed at "_$P($$SITE^VASITE,"^",3)_" due to "_$P(CNFLT,"^",2)
 ..I +CNFLT=0 I VAFCTYPE="MAD"!(VAFCTYPE="MUP") D ADDUPD(DFN,VAFCY,$P(MFI(VAFCX,VAFCY),"^"),$P(MFI(VAFCX,VAFCY),"^",2),$P(MFI(VAFCX,VAFCY),"^",6))
 ..I +CNFLT=0 I VAFCTYPE="MDL" D DEL(ICN,VAFCY)
 Q
ADDUPD(DFN,INST,PDLT,PDLRTET,IPP) ;add or update TF entry
 N ERROR,STA
 S STA=INST
 S INST=$$LKUP^XUAF4(INST)
 D FILE^VAFCOTFU(DFN,INST_"^"_$G(PDLT)_"^"_$G(PDLRTET),1,1,.ERROR,$G(IPP))
 S MFA(STA)="MFA"_HL("FS")_"MUP"_HL("FS")_STA_HL("FS")_$$HLDATE^HLFNC($$NOW^XLFDT)_HL("FS")
 I '$D(ERROR(STA)) S MFA(STA)=MFA(STA)_"S"
 I $D(ERROR(STA)) S MFA(STA)=MFA(STA)_"U"_HLCOMP_ERROR(STA)_HL("FS")
 Q
DEL(ICN,INST) ;delete a TF entry
 N ERROR,STA
 S STA=INST
 S INST=$$LKUP^XUAF4(INST)
 S ERROR=$$DELETETF^VAFCOTFU(ICN,INST)
 S MFA(STA)="MFA"_HL("FS")_"MDL"_HL("FS")_STA_HL("FS")_$$HLDATE^HLFNC($$NOW^XLFDT)_HL("FS")
 I +ERROR'=1 S MFA(STA)=MFA(STA)_"S"
 I +ERROR=1 S MFA(STA)=MFA(STA)_"U"_HLCOMP_"Delete Failed: "_$P(ERROR,"^",2)
 Q
