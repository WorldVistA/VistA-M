VAFCTFPR ;ALB/JLU,CML-MFU PROCESSING ROUTINE ;06/25/98
 ;;5.3;Registration;**149,261,255,307,414,474,520,712**;Aug 13, 1993;Build 7
 ;Reference to EXC^RGHLLOG and START^RGHLLOG supported by IA #2796
 ;
EN ;This entry point is used to process the Master File Update Message.
 ;It is called by the VAFC MFU-TFL ClIENT when a MFU message is received
 ;There are no inputs or outputs
 ;
 ;quit if Master Patient Index (MPI) is not installed
 S X="MPIF001" X ^%ZOSF("TEST") Q:'$T
 S X="MPIFQ0" X ^%ZOSF("TEST") Q:'$T
 S X="RGRSBUL1" X ^%ZOSF("TEST") Q:'$T
 S X="RGRSBULL" X ^%ZOSF("TEST") Q:'$T
 K X N ICN,PDFN,TYPE,VAFCER,VAFCARR,SG
 N VAFC,MFNQUIT,VAFCI,MSG,MFUPT,INST,PDLT,VAFCTFT
MFN ;Read Treating Facility MFN M05 (PROCESS LOGIC) msg into VAFC()
 F VAFCI=1:1 X HLNEXT Q:HLQUIT'>0  S VAFC(VAFCI)=HLNODE
MFNP ;Process in the TF updates messages
 S VAFCI="" F  S VAFCI=$O(VAFC(VAFCI)) Q:'VAFCI!($G(MFNQUIT)=1)  S MSG=VAFC(VAFCI),SG=$E(MSG,1,3) D:SG?2A1(1A,1N) PICK
 Q
INIT ;Process in the ADT A04/A08 (routing logic)
 F VAFCI=1:1 X HLNEXT Q:HLQUIT'>0  S (MSG,VAFC(VAFCI))=HLNODE,SG=$E(HLNODE,1,3) D:SG?2A1(1A,1N) PICK
 Q
PICK ;check routine for segment entry point
 I $T(@SG)]"" D @SG
 I $T(@SG)="" Q
 Q
MSH ;;MSH
 ;process the MSH segment
 D START^RGHLLOG($G(HLMTIENS))
 S (HLFS,HL("FS"))=$E(MSG,4),(HLECH,HL("ECH"))=$E(MSG,5,8)
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
 N NXTSGMT,VAFCMPI
 S MFUPT=$P(MSG,HL("FS"),2)
 ;master file update type is not TFL SET quit flag
 I MFUPT'="TFL" S MFNQUIT=1 Q
 N HLCOMP
 S HLCOMP=$E(HL("ECH"),1)
 S TYPE=$P(MSG,HL("FS"),4)
 ;is this coming from the CMOR if so pass a '1' to FILE to end transmission
 S VAFCTFT=0 I TYPE="REP" S VAFCTFT=1
 S VAFCARR("CMOR")=$P($P(MSG,HL("FS"),8),HLCOMP,1)
 S NXTSGMT=$G(VAFC(+$O(VAFC(VAFCI))))
 I $P(NXTSGMT,HL("FS"))="MFE" S ICN=$P($P(NXTSGMT,HL("FS"),5),HLCOMP,4) I $G(ICN)="" S MFNQUIT=1 D EXC^RGHLLOG(210,"Msg#"_$G(HL("MID"))_" failed to Update TF from "_$G(VAFCARR("SENDING SITE"))_".  ICN not sent.",$G(PDFN)) Q
 ;check for CMOR mismatch
 S PDFN=$$GETDFN^MPIF001(ICN)
 I +$G(PDFN)<0 S MFNQUIT=1 D EXC^RGHLLOG(210,"Msg#"_$G(HL("MID"))_" failed to update TF from "_$G(VAFCARR("SENDING SITE"))_" for ICN#"_$G(ICN)) Q
 S VAFCMPI=$$MPINODE^MPIFAPI(PDFN)
 ;if from CMOR delete all TF's and replace with CMOR's list (need to log exception if problems deleting TF's)
 I TYPE="REP" D
 . ;if CMOR mismatch quit the exception will be logged in MFE subroutine
 .;**712 NO NEED TO CHECK CMOR ANYMORE I $P($G(VAFCMPI),"^",3)'=$G(VAFCARR("CMOR")) Q
 . S VAFCER=$$DELALLTF^VAFCTFU(ICN) I VAFCER S MFNQUIT=1 D EXC^RGHLLOG(212,"Msg#"_$G(HL("MID"))_" failed to Delete ALL TF's for ICN#"_$G(ICN),$G(PDFN)) Q
 Q
MFE ;;MFE
 ;process the MFE segment
 N HLCOMP,NXTSGMT
 S HLCOMP=$E(HL("ECH"),1)
 S PDLT=$$FMDATE^HLFNC($P(MSG,HL("FS"),4))
 S INST=$P($P(MSG,HL("FS"),5),HLCOMP) ; **520 REMOVE + AND GET PIECE
 S INST=$$LKUP^XUAF4(INST) ; **520 REMOVE +
 I INST="" S MFNQUIT=1 Q  ; log exception, set MFNQUIT flag and quit
 S PDFN=$$GETDFN^MPIF001(ICN)
 D  Q:$G(MFNQUIT)=1
 .;if unable to get DFN from ICN set MFNQUIT flag and quit
 .I +$G(PDFN)<0 S MFNQUIT=1 D EXC^RGHLLOG(210,"Msg#"_$G(HL("MID"))_" failed to update TF from "_$G(VAFCARR("SENDING SITE"))_" for ICN#"_$G(ICN)) Q
 .N VAFCDATA,LOCNAME,LASTNAME,LOCSSN,LOCICN,LOCCMOR
 .S LOCNAME=$$GET1^DIQ(2,+PDFN_",",.01)
 .S LASTNAME=$P(LOCNAME,",",1)
 .S LOCSSN=$$GET1^DIQ(2,+PDFN_",",.09)
 .S LOCICN=+$$GETICN^MPIF001(PDFN)
 .S LOCCMOR=$$GETVCCI^MPIF001(PDFN)
 .;CMOR MISMATCH or CMOR = null log exception, set MFNQUIT flag and quit
 .;**712 NO NEED TO CHECK CMOR ANYMORE
 .;I LOCCMOR'=VAFCARR("CMOR")!(VAFCARR("CMOR")="") D  Q
 .;.D EXC^RGHLLOG(211,"Msg#"_$G(HL("MID"))_" failed to update from "_$G(VAFCARR("SENDING SITE"))_" for "_$G(LOCNAME)_" ICN#"_$G(ICN)_" due to mismatch CMOR "_$G(VAFCARR("CMOR"))_"/"_$G(LOCCMOR)_" (local)",$G(PDFN)) S MFNQUIT=1
 ;check next segment, if it exist and it is a ZET segment quit and let the ZET module add the TF
 S NXTSGMT=$G(VAFC(+$O(VAFC(VAFCI)))) I $P($G(NXTSGMT),HL("FS"))="ZET" Q
 D FILE^VAFCTFU(PDFN,INST_"^"_$G(PDLT),$G(VAFCTFT))
 Q
ZET ;;ZET
 ;process Patient's Date Last Treated Event Type, ZET segment
 K PDLTET
 S PDLTET=$P(MSG,HL("FS"),2)
 D FILE^VAFCTFU(PDFN,INST_"^"_PDLT_"^"_PDLTET,$G(VAFCTFT))
 Q
TFPRQ Q
 ;
POPQ Q
 ;
UP ;entry point to process local A04 messages.
 ;This is call by the VAFC TFL-UPDATE CLIENT
 N STATN,PDFN,VAFCARR,HLFS,HLECH,SG,VAFCI
 N VAFC
 D INIT
 ;file the TF and trigger the TF update
 D FILE^VAFCTFU(PDFN,+$$SITE^VASITE,1)
UPQ Q
