SCMCHLX1 ;BP/DJB - PCMM HL7 EVENT File Xref Code ; 13 Dec 2002  1:25 PM
 ;;5.3;Scheduling;**177,264,272,515**;May 01, 1999;Build 14
 ;
TXREF(IFN) ;Logic for AEVENT* xrefs on TEAM file (404.51). Create entry in
 ;  PCMM HL7 EVENT file.
 ;
 ; Input: IFN - Pointer to entry in file
 ;Output: None
 ;
 ;Check input
 Q:'$G(IFN)
 ;
 ;Declare variables
 NEW DFN,DFNPTR,ND,VARPTR
 ;
 ;Store event variable pointer
 S VARPTR=IFN_";SCTM(404.51,"
 ;
 ;Quit if an event entry already exists for this record
 Q:$D(^SCPT(404.48,"AACXMIT",VARPTR))
 ;
 ;Create an entry in PCMM HL7 EVENT file (#404.48)
 D ADD^SCMCHLE("NOW",VARPTR)
 Q
 ;
PTXREF(IFN,OLDTYPE) ;Logic for AEVENT* xrefs on PATIENT TEAM ASSIGN file
 ;           (404.42). Create entry in PCMM HL7 EVENT file.
 ;
 ; Input: IFN - Pointer to entry in file
 ;    OLDTYPE - If OLDTYPE=1 then send a deletion since it's no
 ;              longer a primary care team.
 ;Output: None
 ;
 ;Check input
 Q:'$G(IFN)
 ;
 ;Declare variables
 NEW DFN,ND,VARPTR
 ;
 ;Get data
 S ND=$G(^SCPT(404.42,IFN,0)) ;.........Zero node of 404.42
 Q:ND']""
 I $P(ND,U,8)'=1,$G(OLDTYPE)'=1 Q  ;....Not Primary Care related
 S DFN=$P(ND,U,1) ;.....................Get pointer to 404.42
 Q:'DFN
 ;
 ;Store event variable pointer.
 S VARPTR=IFN_";SCPT(404.42,"
 ;
 ;Quit if an event entry for this record is already set to transmit.
 Q:$D(^SCPT(404.48,"AACXMIT",VARPTR))
 ;
 ;If event entry exists, turn on transmission flag.
 ;I $D(^SCPT(404.48,"AC",VARPTR)) D TRANSMIT^SCMCHLE(VARPTR,1) Q
 ;
 ;Create an entry in PCMM HL7 EVENT file (#404.48).
 D ADD^SCMCHLE("NOW",VARPTR,DFN)
 Q
 ;
PTPXREF(IFN,OLDROLE) ;Logic for AEVENT* xrefs on PATIENT TEAM POSITION ASSIGN
 ;            file (404.43). Create entry in PCMM HL7 EVENT file.
 ;
 ; Input: IFN - Pointer to entry in file
 ;    OLDROLE - If OLDROLE=1 then send a deletion since it's no
 ;              longer a primary care position.
 ;Output: None
 ;
 ;Check input
 Q:'$G(IFN)
 ;
 ;Declare variables
 NEW DFN,DFNPTR,ND,TP,VARPTR
 ;
 ;Get data
 S ND=$G(^SCPT(404.43,IFN,0)) ;............Zero node of 404.43
 Q:ND']""
 ;I $P(ND,U,5)'=1,$G(OLDROLE)'=1 Q  ;.......Not Primary Care related
 S SCTPA=$$TPACHK^SCMCHLB("",IFN)          ; 20070518 PATCH 515
 I ($P(ND,U,5)'=1)&($G(OLDROLE)'=1)&(SCTPA=0) Q  ;.......Not Primary Care AND NOT TPA
 S DFNPTR=$P(ND,U,1) ;.....................Get pointer to 404.42
 Q:'DFNPTR
 S DFN=$P($G(^SCPT(404.42,DFNPTR,0)),U,1) ;Pointer to PATIENT file
 Q:'DFN
 S TP=$P(ND,U,2) ;.........................Team Position
 ;
 ;Store event variable pointer
 S VARPTR=IFN_";SCPT(404.43,"
 ;
 ;Quit if an event entry already exists for this record
 Q:$D(^SCPT(404.48,"AACXMIT",VARPTR))
 ;
 ;Create an entry in PCMM HL7 EVENT file (#404.48)
 D ADD^SCMCHLE("NOW",VARPTR,DFN,TP)
 Q
 ;
POSHXREF(IFN) ;Logic for AEVENT* xrefs on POSITION ASSIGNMENT HISTORY file
 ;     (404.52). Create entry in PCMM HL7 EVENT file.
 ;
 ; Input: IFN - Pointer to entry in file
 ;Output: None
 ;
 ;Check input
 Q:'$G(IFN)
 ;
 ;Declare variables
 NEW ND,TP,VARPTR
 ;
 ;Get data
 S ND=$G(^SCTM(404.52,IFN,0)) ;..Zero node of 404.52
 S TP=$P(ND,U,1) ;...............Team Position
 ;
 ;Store event variable pointer
 S VARPTR=IFN_";SCTM(404.52,"
 ;
 ;Quit if an event entry already exists for this record
 Q:$D(^SCPT(404.48,"AACXMIT",VARPTR))
 ;
 ;Create an entry in PCMM HL7 EVENT file (#404.48)
 D ADD^SCMCHLE("NOW",VARPTR,,TP)
 Q
 ;
PREHXREF(IFN) ;Logic for AEVENT* xrefs on PRECEPTOR ASSIGNMENT HISTORY file
 ;     (404.53). Create entry in PCMM HL7 EVENT file.
 ;
 ; Input: IFN - Pointer to entry in file
 ;Output: None
 ;
 ;Check input
 Q:'$G(IFN)
 ;
 ;Declare variables
 NEW ND,TP,VARPTR
 ;
 ;Store event variable pointer
 S VARPTR=IFN_";SCTM(404.53,"
 ;
 ;Get data
 S ND=$G(^SCTM(404.53,IFN,0)) ;....Zero node of 404.53
 S TP=$P(ND,U,1)_"-"_$P(ND,U,6) ;..Team Position: Preceptee-Preceptor
 ;
 ;Quit if an event entry already exists for this record
 Q:$D(^SCPT(404.48,"AACXMIT",VARPTR))
 ;
 ;Create an entry in PCMM HL7 EVENT file (#404.48)
 D ADD^SCMCHLE("NOW",VARPTR,,TP)
 Q
POSBXREF(IFN,FILE) ;
 ;     (404.52). Create entry in PCMM HL7 EVENT file.
 ;
 ; Input: IFN - Pointer to entry in file
 ;Output: None
 S:'$G(FILE) FILE=404.52
 I FILE=404.52 Q:'$P($G(^SCTM(404.57,+$G(^SCTM(404.52,+$G(IFN),0)),0)),U,4)  ;quit if not pc
 ;
 ;  ;Check input
 Q:'$G(IFN)
 ;
 ;Declare variables
 NEW ND,TP,VARPTR
 ;
 ;Get data
 S ND=$G(^SCTM(404.52,IFN,0)) ;..Zero node of 404.52
 S TP=$P(ND,U,1) I FILE=404.57 S TP=IFN ;...............Team Position
 ;
 ;Store event variable pointer
 S VARPTR=IFN_";SCTM("_FILE_","
 ;
 ;Quit if an event entry already exists for this record
 N QUIT,I S QUIT=0
 F I=0:0 S I=$O(^SCPT(404.48,"AACXMIT",VARPTR,I)) Q:'I  I $P($G(^SCPT(404.48,I,0)),U,8) S QUIT=1 Q
 Q:QUIT
 ;
 ;Create an entry in PCMM HL7 EVENT file (#404.48)
 D ADD^SCMCHLE("NOW",VARPTR,,TP,1)
 Q
 ;
