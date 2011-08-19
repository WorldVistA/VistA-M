VAFCQRY2 ;BIR/DLR-Query for patient demographics ;10/18/2000
 ;;5.3;Registration;**428**;Aug 13, 1993
 ;
 ;Reference to $$GETDFNS^MPIF002 supported by IA #3634.
 ;
CHKID(ICN,SSN,DFN) ;
 N EVN,PID,PD1,EVN,LTD,VAFCMN,VAFCER
 ;find the patient
 N LDFN,SITE,RDFN
 ;if DFN is not passed check ICN
 I $G(DFN)="" S DFN=$$GETDFN^MPIF001(+ICN) D  Q
 .;If ICN is identified return Patient Information
 . I DFN>0 Q
 . I DFN'>0,$G(SSN)="" S VAFCER="-1^Unknown ICN#"_$G(ICN) Q
 .;If ICN isn't identified and SSN exists use SSN to identify DFN
 . I DFN'>0,$G(SSN)'="" S RDFN=$$GETDFNS^MPIF002(SSN) S DFN=+RDFN D  Q
 ..;If LIST contains no matches return negative response
 .. I DFN=0 S VAFCER="-1^Unknown ICN#"_$G(ICN)_" and SSN#"_$G(SSN) Q
 ..;If LIST contains only one call check ICN
 .. I +DFN>0 S ICN=$$GETICN^MPIF001(+DFN) D  Q
 ...;If ICN return patient information.
 ... I +ICN>0 Q
 ...;If RDFN does not contain a national ICN return negative response with "Unknown ICN#"_ICN_" and known SSN#"_SSN_" was "_
 ... I +ICN'>0 S VAFCER="-1^Unknown ICN#"_$G(ICN)_", SSN#"_$G(SSN)_", DFN#"_$G(DFN)_" was "_$P(RDFN,"^",2) Q
 ;if DFN is passed
 I $G(DFN)'="" S ICN=$$GETICN^MPIF001(DFN) D  Q
 .;If ICN is identified return Patient Information
 . I +ICN>0 Q
 . I +ICN'>0,$G(SSN)="" S VAFCER="-1^Unknown ICN#"_$G(ICN) Q
 .;If ICN isn't identified and SSN exists use SSN to identify DFN
 . I +ICN'>0,SSN'="" S RDFN=$$GETDFNS^MPIF002(SSN) S DFN=+RDFN D  Q
 ..;If LIST contains no matches return negative response
 .. I +DFN=0 S VAFCER="-1^Unknown ICN#"_$G(ICN)_" for SSN#"_$G(SSN) Q
 ..;If LIST contains only one, check ICN
 .. I +DFN>0 S ICN=$$GETICN^MPIF001(DFN) D  Q
 ...;If ICN return patient information.
 ... I ICN>0 Q
 ...;If NOT ICN return negative response with "Unknown ICN#"_$G(ICN)_" and known SSN#"_SSN_" was "_
 ... S VAFCER="-1^Unknown ICN#"_$G(ICN)_" for known SSN#"_$G(SSN)_" was "_$P(RDFN,"^",2) Q
 Q
BLDEVN(DFN,SEQ,EVN,HL,EVR,ERR) ;build EVN for TF last treatment date and event reason
 N TFIEN,LTD,TFZN,USERID,COMP,SUBCOMP,USERNAME
 S COMP=$E(HL("ECH"),1),SUBCOMP=$E(HL("ECH"),4)
 S LTD=""
 ;reset EVR
 S EVR=""
 ;S TFIEN=$O(^DGCN(391.91,"APAT",DFN,+$$SITE^VASITE,0))
 ;if patient is not already in the associated facility list add
 D EN1^VAFCTF(DFN,1) S TFIEN=$O(^DGCN(391.91,"APAT",DFN,+$$SITE^VASITE,0))  ;suppress messaging 
 I $G(TFIEN)'="" S TFZN=^DGCN(391.91,TFIEN,0) S LTD=$P(TFZN,"^",3) I +$P(TFZN,"^",7)'=0 S EVR=$$GET1^DIQ(391.91,TFIEN_",",.07)
 ;check to see if this is a pivot file trigger if so reset trigger
 I +$G(PIVOTPTR)>0 I $D(^VAT(391.71,+$G(PIVOTPTR),0)) D
 . S USERNAME=$P(^VAT(391.71,+$G(PIVOTPTR),0),"^",9)
 I $G(USERNAME)="" S USERNAME=DUZ
 S USERNAME=$$GET1^DIQ(200,+USERNAME_",",.01)
 S USERNAME=$$HLNAME^HLFNC(USERNAME,HL("ECH"))
 S USERID=DUZ_COMP_$P(USERNAME,COMP)_COMP_$P(USERNAME,COMP,2)_COMP_COMP_COMP_COMP_COMP_COMP_"USVHA"_SUBCOMP_SUBCOMP_"0363"_COMP_"L"_COMP_COMP_COMP_"NI"_COMP_"VA FACILITY ID"_SUBCOMP_$P($$SITE^VASITE,"^",3)_SUBCOMP_"L"
 I $G(EVN(1))="" S EVN(1)="EVN"_HL("FS")_HL("FS")_$$HLDATE^HLFNC(LTD)_HL("FS")_HL("FS")_HL("FS")_USERID_HL("FS")_$$HLDATE^HLFNC(LTD)_HL("FS")_$P($$SITE^VASITE,"^",3)
 I $G(EVN(1))'="" S $P(EVN(1),HL("FS"),2)=$G(EVR),$P(EVN(1),HL("FS"),5)=$G(EVR),$P(EVN(1),HL("FS"),3)=$$HLDATE^HLFNC(LTD),$P(EVN(1),HL("FS"),7)=$$HLDATE^HLFNC(LTD),$P(EVN(1),HL("FS"),8)=$P($$SITE^VASITE,"^",3),$P(EVN(1),HL("FS"),6)=USERID
 Q
BLDPD1(DFN,SEQ,PD1,HL,ERR) ;
 N SITE,VAFCMN,COMP,CMOR
 S SITE=""
 S COMP=$E(HL("ECH"),1)
 ;get Patient File MPI node
 S VAFCMN=$$MPINODE^MPIFAPI(DFN)
 S CMOR=$P(VAFCMN,"^",3)
 I CMOR'="" S SITE=$$NS^XUAF4(CMOR)
 S PD1(1)="PD1"_HL("FS")_HL("FS")_HL("FS")_$P(SITE,"^")_COMP_"D"_COMP_$P(SITE,"^",2)
 Q
