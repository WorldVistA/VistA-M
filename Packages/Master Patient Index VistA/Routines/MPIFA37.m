MPIFA37 ;BIR/DLR-Utility for processing an ADT-A37 Un-link ID ;DEC 11, 2001
 ;;1.0; MASTER PATIENT INDEX VISTA ;**22**;30 Apr 99
DBIA ; Supported IA's
 ;
 ;IA: 2796  - EXC, START, and STOP^RGHLLOG
 ;IA: 2988  - $$DELALLTF and $$DELETETF^VAFCTFU
 ;
IN ;Entry point for processing ADT-A37 - unlink patient information
 ;Called from the MPIF ADT-A37 CLIENT protocol processing routine
 ;There are no inputs or outputs
 ;
 N MPIF,STATN,MPIFI,MSG,SG,MPIFARR,PDFN,INST,MFUPT,PDLT,TFIEN,ICNAUTH,MPISITE
 N ICN,HLCOMP,CNT,X,MPIFERR,MPIFX,MPIDFN,MPISSN,ERROR,DFN,NODE,CMOR2,PID
 S MPISSN="",MPIDFN="",ICN="",ERROR=""
INIT ;Process in the Treating Facility MFN msg
 F MPIFI=1:1 X HLNEXT Q:HLQUIT'>0  S (MSG,MPIF(MPIFI))=HLNODE,SG=$E(HLNODE,1,3) D:SG?2A1(1A,1N) PICK
 ;replace/remove/unlink the mismatched ICN in PID(2) as well as the old CMOR from the patients record
 S CMOR2="",DFN=$$GETDFN^MPIF001(+PID(2)) I +DFN>0 S NODE=$$MPINODE^MPIFAPI(DFN) I NODE'="" S CMOR2=$P(NODE,"^",3)
 ;if assigning authority = site station# then remove the ICN from site 
 I $P(PID(2),"^",2)=$P($$SITE^VASITE,"^",3) D REPLACE("@","",PID(2),CMOR2,.ERROR)
 ;if assigning authority '= site station# then remove assigning authority from TF list for the given ICN
 I $P(PID(2),"^",2)'=$P($$SITE^VASITE,"^",3) S MPISITE=$$IEN^XUAF4($P(PID(2),"^",2)) D
 . I $P(PID(2),"^",2)'>0 S ERROR="-1^Unable to remove station#"_$P(PID(2),"^",2)_" from TF list" Q
 . I +$P(PID(2),"^",2)>0 S ERROR=$$DELETETF^VAFCTFU(ICN,MPISITE)
 S ERROR=$S(+ERROR=0:"",1:$P(ERROR,"^",2))
 ;create response message
 S CNT=1
 S HLA("HLA",1)="MSA"_HL("FS")_"AA"_HL("FS")_HL("MID")_HL("FS")_$G(ERROR) S CNT=CNT+1
 ;Send back the appl. ack (ACK) with the ADT-A37 transaction status
 D ROUTE
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.MPIFERR,"",.HLP)
 Q
PICK ;check routine for segment entry point
 I $T(@SG)]"" D @SG
 I $T(@SG)="" Q
 Q
MSH ;;MSH
 ;process the MSH segment
 S (HLFS,HL("FS"))=$E(MSG,4),(HLECH,HL("ECH"))=$E(MSG,5,8)
 S HLCOMP=$E(HL("ECH"),1)
 S MPIFARR("SENDING SITE")=$P(MSG,HL("FS"),4)
 Q
EVN ;;EVN
 ;process the EVN segment
 S STATN=+$$SITE^VASITE()_"^"_$$FMDATE^HLFNC($P(MSG,HL("FS"),3))
 Q
PID ;;PID
 ;process the PID segment
 N ARRAY,MPIJ
 D PIDP^RGADTP1(.MSG,.ARRAY,.HL)
 S MPIJ=$P(MSG,HL("FS"),2)
 S MPISSN=$G(ARRAY("SSN")),MPIDFN=$G(ARRAY("DFN")),ICN=$G(ARRAY("ICN"))
 S PID(MPIJ)=+ICN_"^"_$G(ARRAY("MPISSITE"))
 Q
RESP ;response process logic entry point
 Q
ROUTE ;routing logic entry point
 N MPI S MPI=$$MPILINK^MPIFAPI() D
 .I $P($G(MPI),U)'=-1 S HLL("LINKS",1)="MPIF ADT-A37 CLIENT"_"^"_MPI
 .I $P($G(MPI),U)=-1 D
 .. N RGLOG D START^RGHLLOG(HLMTIEN,"","")
 .. D EXC^RGHLLOG(224,"Unable to send ADT-A37 for DFN"_$G(DFN)_" : No MPI link identified",$G(PDFN))
 .. D STOP^RGHLLOG(0)
 Q
REPLACE(ICN1,CMOR1,ICN2,CMOR2,ERROR) ;
 ;replace icn1 with icn2 and cmor1 with cmor2
 N MPIARR
 S ERROR=0
 I $G(ICN2)'="" S DFN=$$GETDFN^MPIF001(+ICN2) I +DFN'>0 S ERROR="-1^Unable to break ICN "_+ICN2_" because that ICN is unknown"
 Q:+$G(ERROR)=-1
 S MPIARR(991.01)="@",MPIARR(991.02)="@",MPIARR(991.03)="@",MPIARR(991.05)="@",MPIARR(992)=$P(ICN2,"V"),MPIARR(993)=CMOR2
 S ERROR=$$DELALLTF^VAFCTFU(+ICN2)
 S ERROR=$$UPDATE^MPIFAPI(DFN,"MPIARR",1)
 Q
