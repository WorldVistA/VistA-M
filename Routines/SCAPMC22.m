SCAPMC22 ;ALB/REW - Team API's ; December 1, 1995
 ;;5.3;Scheduling;**41,148**;AUG 13, 1993
 ;;1.0
INPTTP(DFN,SCPTTPA,SCINACT,SCERR) ;inactivate patient from a position (pt tm pos assgn - #404.43
 ; input:
 ;  DFN     = pointer to PATIENT file (#2)
 ;  SCPTTPA   = pointer to pt team assign file (#404.43)
 ;  SCINACT = date to inactivate [default=DT]
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  SCOK    = 1 if inactivation entry made to file 404.43, 0 ow
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;             Foramt:
 ;  @SCERR@(0)=Number of erros, undefined if none
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 N SCTP,SC,SCPARM,SCESEQ,SCLSEQ,SCOK,SCND
 S SCOK=0
 G:'$$OKDATA APTTPQ ;setup/check variables
 S SCND=$G(^SCPT(404.43,SCPTTPA,0))
 G:SCINACT<$P(SCND,U,3) APTTPQ
 S SCTP=+$P(SCND,U,2)
 IF '$$PTTPACT(DFN,SCTP,SCINACT,.SCERR) D  G APTTPQ
 .S SCOK=0
 .S SCPARM("INACTIVE DATE")=SCINACT
 .S SCPARM("MESSAGE")="Patient not assigned to position on date"
 .D ERR^SCAPMCU1(SCESEQ,4044201,.SCPARM,"",.SCERR)
 ELSE  D
 .S SCOK=1
 .S SC($J,404.43,SCPTTPA_",",.04)=SCINACT
 .S SC($J,404.43,SCPTTPA_",",.08)=$G(DUZ,.5)
 .D NOW^%DTC
 .S SC($J,404.43,SCPTTPA_",",.09)=%
 .D UPDATE^DIE("","SC($J)","SCIEN",.SCERR)
 .I $D(@SCERR@("DIERR")) S SCOK=0
APTTPQ Q SCOK
 ;
PTTPACT(DFN,SCTP,SCDT,SCERR) ;is patient assigned to a position on a given date-time?
 N SCPTDTS,SCTPLST,SCOK,SCTM
 S SCTM=$P($G(^SCTM(404.57,SCTP,0)),U,2)
 S SCOK=0
 S (SCPTDTS("BEGIN"),SCPTDTS("END"))=SCDT
 IF $$TPPT^SCAPMC23(DFN,"SCPTDTS",,,,,0,"SCTPLST",.SCERR) S:$D(SCTPLST("SCTP",SCTM,SCTP)) SCOK=1
 Q SCOK
 ;
OKDATA() ;check/setup variables - return 1 if ok/0 if error
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK)
 IF '$D(^DPT(DFN,0))!('$D(^SCPT(404.43,SCPTTPA,0))) D  S SCOK=0
 . S SCPARM("PATIENT")=$G(DFN,"Undefined")
 . S SCPARM("Pt POSITION Asnt")=$G(SCPTTPA,"Undefined")
 . D ERR^SCAPMCU1(SCESEQ,4045101,.SCPARM,"",.SCERR)
 S:'$G(SCACT) SCACT=DT
 S:'$G(SCINACT) SCINACT=DT
 Q SCOK
 ;
INPTSCTP(DFN,SCTP,SCINACT,SCERR) ;inactivate patient from a position - using last pt position assignment - Note: This uses pointer to 404.57 (position) not 404.43 as input
 ; input:
 ;  DFN     = pointer to PATIENT file (#2)
 ;  SCTP    = pointer to POSITION file (#404.57)
 ;  SCINACT = date to inactivate [default=DT]
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  SCOK    = 1 if inactivation entry made to file 404.42, 0 ow
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;             Foramt:
 ;  @SCERR@(0)=Number of erros, undefined if none
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;
 N SCACT
 S SCACT=+$O(^SCPT(404.43,"ADFN",DFN,SCTP,""),-1)
 S SCPTTP=+$O(^SCPT(404.43,"ADFN",DFN,SCTP,SCACT,0))
 Q $$INPTTP(.DFN,.SCPTTP,.SCINACT,.SCERR)
