SCAPMC20 ;ALB/REW - Team APIs:APPTTM ; 20 Mar 1996
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;;1.0
ACOUTPT(DFN,SCFIELDA,SCERR) ;add/edit a record in OUTPATIENT PROFILE #404.41
 ; input:
 ;  DFN     = pointer to PATIENT file (#2)
 ;  SCFIELDA= array of additional fields to be added
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  Returned = ok?^404.41 ien^new?
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;             Foramt:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 N SCEXIST
 N SCESEQ,SCPARM,SCIEN,SC,SCFLD
 G:'$$OKDATA APTTMQ ;check/setup variables
 S SCEXIST=$D(^SCPT(404.41,DFN,0))#2
 IF SCEXIST D
 .IF $D(SCFIELDA) D
 ..S SCFLD=0
 ..F  S SCFLD=$O(@SCFIELDA@(SCFLD)) Q:'SCFLD  D
 ...S SC($J,404.41,(+DFN)_",",SCFLD)=@SCFIELDA@(SCFLD)
 .D FILE^DIE("E","SC($J)",SCERR)
 ELSE  D
 .S SCIEN(1)=DFN
 .S SC($J,404.41,"+1,",.01)="`"_DFN
 .IF $D(SCFIELDA) D
 ..S SCFLD=0
 ..F  S SCFLD=$O(@SCFIELDA@(SCFLD)) Q:'SCFLD  D
 ...S SC($J,404.41,"+1,",SCFLD)=@SCFIELDA@(SCFLD)
 .D UPDATE^DIE("E","SC($J)","SCIEN",SCERR)
 .IF $D(@SCERR)!($G(SCIEN(1))'=DFN) S @SCERR=1 K SCIEN
 .ELSE  D
 ..S SCEXIST=0
APTTMQ Q '$D(@SCERR@(0))_U_+$G(DFN)_U_'$G(SCEXIST)
 ;
OKDATA() ;setup/check variables
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK)
 IF '$D(^DPT(DFN,0)) D  S SCOK=0
 . S SCPARM("PATIENT")=DFN
 . D ERR^SCAPMCU1(SCESEQ,4045101,.SCPARM,"",.SCERR)
 Q SCOK
 ;
MAKEMANY(DFNA,SCOLDASS,SCBADASS,SCNEWASS) ;Not supported for use by PCMM Only
 ;   DFNA    - DFN ARRAY
 ;   SCOLDASS - Subset of DFNA that were previously assigned
 ;   SCBADASS - Subset of DFNA that could not be assigned
 ;   SCNEWASS - Subset of DFNA that were newly assigned
 ; Return: total^new^old^bad
 ; Note: No input error checking!!
 N DFN,SCX,SCOUTFLD,SCBADOUT,SCBADCNT,SCNEWCND,SCOLDCNT
 S (SCBADCNT,SCNEWCNT,SCOLDCNT)=0
 S DFN=0
 F  S DFN=$O(@DFNA@(DFN)) Q:'DFN  D
 .S SCOUTFLD(.04)=1
 .S SCX=$$ACOUTPT(DFN,"SCOUTFLD","SCBADOUT")
 .IF 'SCX D
 ..S @SCBADASS@(DFN)=""
 ..S SCBADCNT=SCBADCNT+1
 .ELSE  D
 ..IF $P(SCX,U,3) D
 ...S @SCNEWASS@(DFN)=""
 ...S SCNEWCNT=SCNEWCNT+1
 ..ELSE  D
 ...S @SCOLDASS@(DFN)=""
 ...S SCOLDCNT=SCOLDCNT+1
 Q (SCOLDCNT+SCNEWCNT)_U_SCNEWCNT_U_SCOLDCNT_U_SCBADCNT
 ;
PTPCNOTM(SCOUTA,SCDATE) ;Not Supported For Use by PCMM Only
 ;   SCOUTA - Output array of DFNs that are PC but no Team Now
 N DFN,SCPC
 S DFN=0
 F  S DFN=$O(^SCPT(404.41,"APC",DFN)) Q:'DFN  S SCPC=$O(^(DFN)) Q:'SCPC  D
 .Q:$D(^TMP("SCMC",$J,"EXCLUDE PT","SCPTA",+DFN))
 .S:'$$GETPCTM^SCAPMCU2(DFN,SCDATE,1) @SCOUTA@(DFN)=DFN_U_$P($G(^DPT(DFN,0)),U,1)
 Q
