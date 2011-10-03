SCAPMC18 ;ALB/REW - Team APIs:ACPTCL ; 5 Jul 1995
 ;;5.3;Scheduling;**41,45,50,130,148**;AUG 13, 1993
 ;;1.0
ACPTCL(DFN,SCCL,SCFIELDA,SCACT,SCERR) ;add a patient to a clinic (enrollment)
 ; input:
 ;  DFN     = pointer to PATIENT file (#2)
 ;  SCCL    = pointer to HOSPITAL LOCATION file (#44)
 ;  SCFIELDA= array of additional fields to be added
 ;  SCACT   = date to activate [default=DT]
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  Returned = ien of enrollment multiple - 0 if none after^new?
 ;  SCERR() = Array of DIALOG file messages(errors).
 ;             Foramt:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 N SCPTCL,SCESEQ,SCPARM,SCIEN,SC,SCFLD,SCNEWCL,DIC,X,SCX,DLAYGO
 G:'$$OKDATA APTCLQ ;check/setup variables
 S SCPTCL=$$PTCLACT(DFN,SCCL,SCACT,.SCERR)
 IF SCPTCL G APTCLQ
 ELSE  D
 .D BEFORE^SCMCEV3(DFN)  ;invoke clinic enrollment event driver
 .S DIC="^DPT("_DFN_",""DE"","
 .S SCX=DIC_"0)"
 .L +@(SCX):5
 .IF '$T D:'$G(DGQUIET) EN^DDIOL("Enrollment being edited") Q
 .S DIC(0)="L"
 .S DIC("P")="2.001P"
 .S DA(1)=DFN
 .S X=SCCL
 .S DLAYGO=2
 .D FILE^DICN
 .IF (Y'>0) L -@(SCX)
 .S DIC=DIC_+Y_",1,"
 .S DIC("P")="2.011D"
 .S DA(1)=+Y
 .S DA(2)=DFN
 .S X=SCACT
 .IF $D(SCFIELDA) D
 ..K DIC("DR")
 ..S SCFLD=0
 ..F  S SCFLD=$O(@SCFIELDA@(SCFLD)) Q:'SCFLD  D
 ...S:'$D(DIC("DR")) DIC("DR")=SCFLD_"////"_@SCFIELDA@(SCFLD)
 ...S:$D(DIC("DR")) DIC("DR")=DIC("DR")_";"_SCFLD_"////"_@SCFIELDA@(SCFLD)
 .D FILE^DICN
 .S SCPTCL=$P(Y,U,2)
 .S SCNEWCL=$P(Y,U,3)
 .L -@(SCX)
 .D AFTER^SCMCEV3(DFN),INVOKE^SCMCEV3(DFN)
APTCLQ Q +$G(SCPTCL)_U_+$G(SCNEWCL)
 ;
PTCLACT(DFN,SCCL,SCDT,SCERR) ;what is patient/clinic enrollment date on a given date-time? Return date or 0
 N SCDATES,SCCLLST,SCOK,SCDATES
 S SCOK=0
 S (SCDATES("BEGIN"),SCDATES("END"))=SCDT
 IF $$CLPT^SCAPMC(DFN,"SCDATES","","SCCLLST",.SCERR) S:$D(SCCLLST("SCCL",SCCL)) SCOK=$O(SCCLLST("SCCL",SCCL,0))
 Q SCOK
 ;
OKDATA() ;setup/check variables
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK)
 IF +$G(SCCL)'=$G(SCCL) D  S SCOK=0
 . S SCPARM("CLINIC")=$G(SCCL,"Undefined")
 . D ERR^SCAPMCU1(SCESEQ,4045101,.SCPARM,"",.SCERR)
 IF '$D(^SC(+$G(SCCL),0)) D  S SCOK=0
 . S SCPARM("CLINIC")=$G(SCCL,"Undefined")
 . D ERR^SCAPMCU1(SCESEQ,4045101,.SCPARM,"",.SCERR)
 IF '$D(^DPT(DFN,0)) D  S SCOK=0
 . S SCPARM("PATIENT")=DFN
 . D ERR^SCAPMCU1(SCESEQ,4045101,.SCPARM,"",.SCERR)
 S:'$G(SCACT) SCACT=DT
 Q SCOK
