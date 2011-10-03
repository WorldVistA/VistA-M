SCMCHLX ;BP/DJB - PCMM HL7 EVENT File Xref APIs ; 10 Dec 2002  8:44 PM
 ;;5.3;Scheduling;**177,264,272**;May 01, 1999
 ;
 ;Reference routine: SCDXFX01
AACXMIT(IFN,SET,OLDEVPTR) ;Logic for AACXMIT* xrefs on PCMM HL7 EVENT
 ;                 file (#404.48).
 ;
 ; Input: IFN: Pointer to entry in file
 ;        SET: 1 = Set xref
 ;             0 = Kill xref
 ;            -1 = Check value of TRANSMISSION REQUIRED field (#.04).
 ;                   If "YES"- Set xref
 ;                   If "NO" - Kill xref
 ;   OLDEVPTR: Previous value of EVENT POINTER field (#.07).
 ;             Only valid when KILLing xref is due to data in this
 ;             field changing.
 ;Output: None
 ;
 ;Check input
 Q:'$G(IFN)
 Q:'$D(^SCPT(404.48,IFN))
 S:$G(SET)="" SET=-1
 S OLDEVPTR=+$G(OLDEVPTR)
 ;
 ;Declare variables
 NEW EVPTR,EVENT,ND,XMIT
 ;
 ;Get data
 S ND=$G(^SCPT(404.48,IFN,0)) ;....Get zero node
 S XMIT=+$P(ND,"^",3) ;............Transmission Required field
 S EVPTR=$P(ND,"^",7) ;............Event Pointer field
 I 'SET,OLDEVPTR S EVPTR=OLDEVPTR ;Use old Event Pointer if killing
 ;                                 due to value changing.
 Q:'EVPTR  ;.......................Quit if no Event Pointer
 ;
 ;Set/Kill logic based on value of TRANSMISSION REQUIRED
 I SET=-1 S SET=$S(XMIT=1:1,1:0)
 ;
 ;Set/Kill xref
 I SET S ^SCPT(404.48,"AACXMIT",EVPTR,IFN)="" ;..Set xref
 E  KILL ^SCPT(404.48,"AACXMIT",EVPTR,IFN) ;.....Kill xref
 Q
 ;
TXREF(IFN) ;Logic for AEVENT* xrefs on TEAM file. Create entry in
 ;  PCMM HL7 EVENT file.
 ;
 ;***THIS CALL NOT USED***
 ;bp/djb 6/15/99
 ;No longer sending Primary Care Team data to Austin.
 ;
 D TXREF^SCMCHLX1($G(IFN))
 Q
 ;
PTXREF(IFN,OLDTYPE) ;Logic for AEVENT* xrefs on PATIENT TEAM ASSIGN file.
 ;           Create entry in PCMM HL7 EVENT file.
 ;
 ;***THIS CALL NOT USED***
 ;bp/djb 6/15/99
 ;No longer sending Primary Care Team data to Austin.
 ;
 D PTXREF^SCMCHLX1($G(IFN),$G(OLDTYPE))
 Q
 ;
PTPXREF(IFN,OLDROLE) ;Logic for AEVENT* xrefs on PATIENT TEAM POSITION
 ;            ASSIGN file. Create entry in PCMM HL7 EVENT file.
 D PTPXREF^SCMCHLX1($G(IFN),$G(OLDROLE))
 Q
 ;
POSHXREF(IFN) ;Logic for AEVENT* xrefs on POSITION ASSIGNMENT HISTORY file.
 ;     Create entry in PCMM HL7 EVENT file.
 D POSHXREF^SCMCHLX1($G(IFN))
 Q
 ;
PREHXREF(IFN) ;Logic for AEVENT* xrefs on PRECEPTOR ASSIGNMENT HISTORY file.
 ;     Create entry in PCMM HL7 EVENT file.
 D PREHXREF^SCMCHLX1($G(IFN))
 Q
POSBXREF(IFN,FILE) ;Logic for Bookable Hour Cross reference
 ;Create entry in PCMM HL7 EVENT file
 D POSBXREF^SCMCHLX1(+$G(IFN),$G(FILE))
 Q
