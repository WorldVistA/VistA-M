SCMCDD ;ALB/REW - DD Calls used by PCMM ; 6 November 1995
 ;;5.3;Scheduling;**41,51,177,204**;AUG 13, 1993
 ;1
NEWHIST(FILE,IEN,DATE,SCERR,STATUS) ; PCMM history files - new record's dt & status
 ; Complete
 ; input:
 ;   FILE   = 404.52,404.53,404.58, or 404.59
 ;   IEN    = if file=404.58 - pointer to 404.51
 ;            otherwise      - pointer to 404.57
 ;   DATE   = effective date
 ;   SCERR  = [default = "SCERR"]
 ;   STATUS = [optional] 1=active/0=inactive - IF undefined don't check
 ; output:
 ;   Returned: 1 if ok to add, 0 if not^message^external
 ;  Note: For 404.52: special case
 ;   @scerr = error message array
 N SCDATES,SCX,SCOK,DIERR,SCLASTDT,Y,X
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 S SCOK=1
 ;verify date is after last date
 S SCLASTDT=$$LASTDATE^SCAPMCU1(FILE,IEN)
 IF SCLASTDT&(SCLASTDT'<DATE) D  G QTNWHIST
 .S Y=SCLASTDT D DD^%DT
 .S SCOK="0^New Date is not after last historical date("_Y_")"_U_SCLASTDT
 S SCX=$$DATES^SCAPMCU1(FILE,IEN,DATE)
 IF SCX<0 D  G QTNWHIST
 .S SCOK=0_U_"Error in ACTHIST call"
 .S SCPARM("NEW ENTRY")="Error in ACTHIST call"
 .D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 IF DATE'>$P(SCX,U,2)!(DATE'>$P(SCX,U,3)) D  G QTNWHIST
 .S SCOK=0_U_"Date On or Before Last Entry"
 .S SCPARM("EFFECTIVE DATE")=DATE
 .D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 ;bp/cmf 204 new code begin
 I $$BADNEWDT^SCMCDDA G QTNWHIST
 ;bp/cmf 204 new code end
 ;skip to end if status is not defined
 IF '$D(STATUS)!($G(STATUS)="") G QTNWHIST
 IF STATUS=+SCX D  G QTNWHIST
 .S SCOK=0_U_"Status Must Change from Prior Entry -  Current Status is "_$S(STATUS:"Active",1:"Inactive")
QTNWHIST Q SCOK
 ;
OKDEL(FILE,HISTIEN,SCERR) ;PCMM history files - delete record
 ; input:
 ;   FILE   = History File: 404.52,404.53,404.58, or 404.59
 ;   HISTIEN    = Entry in FILE
 ;   SCERR  = [default = "SCERR"]
 ; output:
 ;   Returned: 1 if ok to delete, 0 if not^message
 ;   @scerr = error message array
 N SCLASTDT,SCX,ROOT,SCNODE,SCOK,SCSTATUS
 S SCOK=1
 S ROOT="^SCTM("_FILE_","_HISTIEN_",0)"
 S SCNODE=$G(@ROOT)
 S SCLASTDT=$$LASTDATE^SCAPMCU1(FILE,$P(SCNODE,U,1)) ;1st pc=tm or pos
 IF SCLASTDT'=$P(SCNODE,U,2) D  G QTOKDEL
 .S Y=SCLASTDT D DD^%DT
 .S SCOK=0_U_"Date is not last historical date ("_Y_")"_U_SCLASTDT
 ;if active check if ok to inactivate
 S SCSTATUS=+$P(SCNODE,U,+($S((FILE=404.52)!(FILE=404.53):4,1:3)))
 S:SCSTATUS SCOK=$$OKINACT(FILE,$P(SCNODE,U,1),SCLASTDT,.SCERR)
QTOKDEL Q SCOK
 ;
OKINACT(FILE,IEN,DATE,SCERR) ;PCMM history files - inactivate record?
 ; input:
 ; ** Complete **
 ; input:
 ;   FILE   = History File: 404.52,404.53,404.58, or 404.59
 ;   IEN    = IEN of non-History File:
 ;                Team Position (#404.57) for 404.52 & 404.59
 ;                Team (#404.51) for 404.58
 ;   DATE   = Date to inactivate
 ;   SCERR  = [default = "SCERR"]
 ; output:
 ;   Returned: 1=ok on date/0 ow^1=ok in future/0 ow^message^techmessage
 ;   @scerr = error message array
 N SCLASTDT,SCX,ROOT,SCNODE,SCSTAT,SCOK,SCI,SCTP,SCOK,SCTPLST,SCPTLST,SCCLIN
 S SCOK=1
 S SCLASTDT=$$LASTDATE^SCAPMCU1(FILE,IEN)
 IF DATE<SCLASTDT D  G QTOKIN
 .S Y=SCLASTDT D DD^%DT
 .S SCOK="0^^Date is before last historical date("_Y_")"_U_SCLASTDT
 S SCDT("BEGIN")=DATE
 S SCDT("END")=3990101 ;infinite future
 S SCDT("INCL")=0 ;does not have to be continuous
 S SCX=$$ACTHIST^SCAPMCU2(FILE,IEN,"SCDT",.SCERR)
 IF SCX'>0 D  G QTOKIN
 .S:SCX<0 SCOK="0^^Error in active history call"
 .IF 'SCX D
 ..S Y=DATE D DD^%DT
 ..S SCOK="0^^Entry not active for date("_Y_")"_U_DATE
TEAMHIS IF FILE=404.58 D
 .; -- check positions for team
 .IF '$$TPTM^SCAPMC(IEN,"SCDT",,,"SCTPLST",.SCERR) S SCOK=0_U_U_"Error in Position List Call" Q
 .F SCI=1:1 S SCTP=$P($G(SCTPLST(SCI)),U,1) Q:'SCTP  D  Q:'SCOK
 ..; -- check if position is active
 ..IF '$P(SCTPLST(SCI),U,6)!($P(SCTPLST(SCI),U,6)>DATE) D  Q
 ...S Y=$P(SCTPLST(SCI),U,2) D DD^%DT
 ...S SCOK="0^^Active Team Position^"_$P($G(^SCTM(404.57,SCTP,0)),U,1)_" as of "_Y_U_SCTP_U_$P(SCTPLST(SCI),U,1)
 ..S SCX=$$OKINACT(404.59,SCTP,DATE,.SCERR)
 ..S:$P(SCX,U,1,2)["1" SCOK=SCX
 .; -- check for patients assigned to team - 999 - maybe able to remove
 .IF '$$PTTM^SCAPMC(IEN,"SCDT","^TMP($J,""SCPTLST"")",.SCERR) S SCOK=0_U_U_"Error in Patient List Call" Q
 .F SCI=1:1 S SCPT=$P($G(^TMP($J,"SCPTLST",SCI)),U,1) Q:'SCPT  D  Q:'SCOK
 ..IF $P(^TMP($J,"SCPTLST",SCI),U,4)>DATE S SCOK="1^0^Patient "_$P(^TMP($J,"SCPTLST",SCI),U,2)_" is active in the future" Q
 ..IF $P(^TMP($J,"SCPTLST",SCI),U,5)<DATE S SCOK=0_U_U_"Patient ("_$P(^TMP($J,"SCPTLST",SCI),U,2)_") is active"_U_$P(^TMP($J,"SCPTLST",SCI),U,1)_U_$P(^TMP($J,"SCPTLST",SCI),U,2) Q
POSHIS IF FILE=404.59 D
 .; -- check for practitioners assigned to position
 .IF '$$PRTP^SCAPMC(IEN,"SCDT","SCPRLST",.SCERR) S SCOK=0_U_U_"Error in Practitioner List Call" Q
 .F SCI=1:1 S SCPR=$P($G(SCPRLST(SCI)),U,1) Q:'SCPR  D  Q:'SCOK
 ..IF $P(SCPRLST(SCI),U,7)>DATE S SCOK="1^0^Team Member "_$P(SCPRLST(SCI),U,2)_" is active in the future in position "_U_$P(SCPRLST(SCI),U,1)_U_IEN Q
 ..IF $P(SCPRLST(SCI),U,8)<DATE S SCOK="0^^Team Member "_$P(SCPRLST(SCI),U,2)_" is active in position "_U_$P(SCPRLST(SCI),U,1)_U_IEN Q
 .;check if a clinic is assigned to position
 .S SCCLIN=$P($G(^SCTM(404.57,IEN,0)),U,9) Q:'SCCLIN  D
 ..S SCOK="0^^Clinic ("_$P($G(^SC(SCCLIN,0)),U,1)_") is associated with position"_U_SCCLIN
 .;check for patients assigned to position
 .IF '$$PTTP^SCAPMC(IEN,"SCDT","^TMP($J,""SCPTLST"")",.SCERR) S SCOK="0^^Error in patient list call" Q
 .F SCI=1:1 S SCPT=$P($G(^TMP($J,"SCPTLST",SCI)),U,1) Q:'SCPT  D  Q:'SCOK
 ..IF $P(SCPTLST(SCI),U,4)>DATE S SCOK="1^0^Patient "_$P(SCPTLST(SCI),U,1)_" is active in the future" Q
 ..IF $P(^TMP($J,"SCPTLST",SCI),U,5)<DATE S SCOK=0_U_U_"Patient "_$P(^TMP($J,"SCPTLST",SCI),U,2)_" is active"_U_$P(^TMP($J,"SCPTLST",SCI),U,1) Q
 ;IF FILE=404.52 or 404.53 - NO FURTHER CHECKS NEEDED
QTOKIN Q SCOK
 ;
OKCHGDT(FILE,HISTIEN,DATE,SCERR) ;PCMM history files - ok to change date?
 ; input:
 ;   FILE   = History File: 404.52,404.53,404.58, or 404.59
 ;   HISTIEN - IEN of History File (404.52,404.58 or 404.59)
 ;   SCERR  = [default = "SCERR"]
 ; output:
 ;   Returned: 1 if ok to change date, 0 if not^message
 ;   @scerr = error message array
 N SCX,ROOT,SCNODE,SCSTAT,SCOK
 S SCOK=1
 S ROOT="^SCTM("_FILE_","_HISTIEN_",0)"
 S SCNODE=$G(@ROOT)
 IF 'SCNODE S SCOK="0^Bad or Corrupt File Entry"_U_HISTIEN G QTOKCHK
 S SCSTAT=$S(FILE=404.52:$P(SCNODE,U,4),1:$P(SCNODE,U,3))
 ;check next & previous effective dates (must be of other status)
 ; i.e. if active check next & previous for inactive
 S SCX=$$DTAFTER^SCAPMCU2(FILE,$P(SCNODE,U,1),('SCSTAT),$P(SCNODE,U,2))
 IF SCX&(DATE'<SCX) D  G QTOKCHK
 .S Y=+SCX D DD^%DT
 .S SCOK=0_U_"Date Must be before "_Y_U_SCX
 S SCX=$$DTBEFORE^SCAPMCU2(FILE,$P(SCNODE,U,1),('SCSTAT),$P(SCNODE,U,2))
 IF DATE'>SCX D  G QTOKCHK
 .S Y=+SCX D DD^%DT
 .S SCOK=0_U_"Date Must be after "_Y_U_SCX
 ;bp/cmf 204 new code begin
 I $$BADCHGDT^SCMCDDA G QTOKCHK
 ;bp/cmf 204 new code end
 ;
QTOKCHK Q SCOK
