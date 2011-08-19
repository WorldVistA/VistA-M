MPIFA43 ;BIR/DLR-Utility for processing an ADT-A43 Un-link ID ;MAR 18, 2002
 ;;1.0; MASTER PATIENT INDEX VISTA ;**22,41,46**;30 Apr 99;Build 5
DBIA ; Supported IA's
 ;
 ;IA: 2796  - EXC, START, and STOP^RGHLLOG
 ;IA: 2988  - $$DELALLTF and $$DELETETF^VAFCTFU
 ;IA: 3767  - PIDP^RGADTP1
 ;
IN ;Entry point for processing ADT-A43 - Move patient information
 ;Called from the MPIF ADT-A43 CLIENT protocol processing routine
 ;There are no inputs or outputs
 ;
 N MPIF,STATN,MPIFI,MSG,SG,MPIFARR,PDFN,INST,MFUPT,PDLT,TFIEN,ICNAUTH,MPISITE,MRG
 N ICN,HLCOMP,CNT,X,MPIFERR,MPIFX,MPIDFN,MPISSN,ERROR,DFN,NODE,CMOR2,PID,ARRAY
 S MPISSN="",MPIDFN="",ICN="",ERROR=""
INIT ;Process in the ADT-A43 Move Patient Identifier msg
  F MPII=1:1 X HLNEXT Q:HLQUIT'>0  S MSG=HLNODE D
 .S MPIJ=0 F  S MPIJ=$O(HLNODE(MPIJ)) Q:'MPIJ  S MSG(MPIJ)=HLNODE(MPIJ)
 .S SG=$E(HLNODE,1,3),MPIF(MPII)=HLNODE D:SG?2A1(1A,1N) PICK
 .;**45 ABOVE TO REPLACE COMMENTED LINE BELOW
 ;F MPIFI=1:1 X HLNEXT Q:HLQUIT'>0  S (MSG,MPIF(MPIFI))=HLNODE,SG=$E(HLNODE,1,3) D:SG?2A1(1A,1N) PICK
 D MOVE(.ARRAY,.ERROR)
 ;create response message
 S CNT=1
 S HLA("HLA",1)="MSA"_HL("FS")_$S($G(ERROR)=0:"AA",1:"AE")_HL("FS")_HL("MID")_HL("FS")_$S($G(ERROR)=0:"",1:$P(ERROR,"^",2)) S CNT=CNT+1
 D ROUTE
 ;Send back the appl. ack (ACK) with the ADT-A43 transaction status
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
 N COMP,REP,SUBCOMP,AUTH,IDTYP,LOC,AUTHTYP,MPIJ
 S COMP=$E(HL("ECH"),1),SUBCOMP=$E(HL("ECH"),4),REP=$E(HL("ECH"),2)
 S MPIJ=$P(MSG,HL("FS"),2)
 D PIDP^RGADTP1(.MSG,.ARRAY,.HL)
 ;ARRAY("ICN") = NEW ICN  and  ARRAY("DFN") = mismatched record to be corrected
 Q
PD1 ;processing PD1 fields for new CMOR
 N COMP
 S COMP=$E(HL("ECH"),1)
 S ARRAY("CMOR")=$P($P(HLNODE,HL("FS"),4),COMP,3)
 Q
MRG ;
 N COMP,REP,SUBCOMP,AUTH,IDTYP,LOC,AUTHTYP,FID,ID
 S COMP=$E(HL("ECH"),1),SUBCOMP=$E(HL("ECH"),4),REP=$E(HL("ECH"),2)
 N MPIFX,ID,AUTH
 S FID=$P(MSG,HL("FS"),2)
 F MPIFX=1:1:$L(FID,REP)+1 S ID=$P(FID,REP,MPIFX),PID=$P(ID,COMP),AUTH=$P($P(ID,COMP,4),SUBCOMP),AUTHTYP=$P($P(ID,COMP,4),SUBCOMP,2),IDTYP=$P(ID,COMP,5),LOC=$P($P(ID,COMP,6),SUBCOMP,2) D
 . I AUTH="USSSA" S MPISSN=PID
 . ;capture the old or mismatched ICN in ARRAY("ICNMISMATCH")
 . I AUTH="USVHA" I IDTYP="NI" S (ARRAY("ICNMISMATCH"),ICN)=PID S ARRAY("ICNMISMATCHLOC")=LOC
 . I AUTH="USVHA" I IDTYP="PI" S MPIDFN=PID S ARRAY("DFNLOC")=LOC
 Q
RSP ;response process logic entry point
 Q
ROUTE ;routing logic entry point
 N MPI S MPI=$$MPILINK^MPIFAPI() D
 .I $P($G(MPI),U)'=-1 S HLL("LINKS",1)="MPIF ADT-A43 CLIENT"_"^"_MPI
 .I $P($G(MPI),U)=-1 D
 ..N RGLOG D START^RGHLLOG(HLMTIEN,"","")
 ..D EXC^RGHLLOG(224,"No MPI link identified ",$G(PDFN))
 ..D STOP^RGHLLOG(0)
 Q
MOVE(ARRAY,ERROR) ;
 ;replace ARRAY("ICNMISMATCHED") with ARRAY("ICN")
 N MPIARR
 S ERROR=0
 ;I ARRAY("DFNLOC")="" OLD MESSAGING SO USE ARRAY("ICNMISMATCHLOC")
 I $G(ARRAY("DFNLOC"))="" S ARRAY("DFNLOC")=ARRAY("ICNMISMATCHLOC")
 I $G(ARRAY("CMOR"))="" S ARRAY("CMOR")=ARRAY("DFNLOC")
 ;if assigning authority'= site station# then Quit because this is not the mismatched site so MFN-M05 sent as a result of site removal on MPI will remove it from all sites TF list
 I ARRAY("DFNLOC")'=$P($$SITE^VASITE,"^",3) D  Q
 .;if assigning authority '= site station# then remove assigning authority from TF list for the given ICN
 .N MPISITE S MPISITE=$$IEN^XUAF4(ARRAY("DFNLOC"))
 . I ARRAY("DFNLOC")'>0 S ERROR="-1^Unable to remove station#"_ARRAY("DFNLOC")_" from TF list" Q
 . I +ARRAY("DFNLOC")>0 S ERROR=$$DELETETF^VAFCTFU(+ARRAY("ICNMISMATCH"),MPISITE)
 ;delete all TF's for this mismatched record
 S ERROR=$$DELALLTF^VAFCTFU(ARRAY("ICNMISMATCH"))
 ;if ARRAY("DFN")="" assume this is old message format and use ARRAY("ICNMISMATCHED") to get the DFN that was mismatched
 I $G(ARRAY("DFN"))="" D  Q
 . S ARRAY("DFN")=$$GETDFN^MPIF001(ARRAY("ICNMISMATCH")) I +ARRAY("DFN")'>0 S ERROR="-1^Unable to break ICN "_ARRAY("ICNMISMATCH")_" because that ICN is unknown"
 . Q:+$G(ERROR)=-1
 . S MPIARR(991.01)="@",MPIARR(991.02)="@",MPIARR(991.03)="@",MPIARR(991.05)="@",MPIARR(992)=$P(ARRAY("ICNMISMATCH"),"V"),MPIARR(993)=$P($$SITE^VASITE,"^")
 . S ERROR=$$UPDATE^MPIFAPI(ARRAY("DFN"),"MPIARR",1)
 ;if new messaging
 I ARRAY("ICN")'="""" D
 . ;delete the entry first to prevent the ICN from going into history
 . S MPIARR(991.01)="@",MPIARR(991.02)="@",MPIARR(991.03)="@",MPIARR(991.05)="@",MPIARR(992)=$P(ARRAY("ICNMISMATCH"),"V"),MPIARR(993)=$P($$SITE^VASITE,"^")
 . S ERROR=$$UPDATE^MPIFAPI(ARRAY("DFN"),"MPIARR",1)
 . ;update the record with the new ICN
 . S MPIARR(991.01)=$P(ARRAY("ICN"),"V"),MPIARR(991.02)=$P(ARRAY("ICN"),"V",2),MPIARR(991.03)=$$IEN^XUAF4(ARRAY("CMOR")),MPIARR(991.05)="@",MPIARR(992)=$P(ARRAY("ICNMISMATCH"),"V"),MPIARR(993)=$P($$SITE^VASITE,"^")
 ;move the mismatched record from ARRAY("ICNMISMATCH") to ARRAY("ICN")
 S ERROR=$$UPDATE^MPIFAPI(ARRAY("DFN"),"MPIARR",1)
 ;add LOCAL site to TF, if CMOR is different it will be auto added
 D FILE^VAFCTFU(ARRAY("DFN"),+$$SITE^VASITE,1)
 Q
