SCMCHLE ;BP/DJB - PCMM HL7 EVENT File Utils ; 11 Dec 2002  1:14 PM
 ;;5.3;Scheduling;**177,204,272**;May 01, 1999
 ;
 ;Reference routine: ^SCDXFU01
ADD(EVDATE,EVPTR,DFN,TP,FTEE) ;Add a new event to PCMM HL7 EVENT file (#404.48).
 ;
 ; Input: EVDATE - Date/time of PCMM event in FM format.
 ;                 Default="NOW"
 ;        EVPTR  - Variable pointer that records IEN and file where
 ;                 event occurred. Used to determine Table Designator
 ;                 and Table ID for the ZPC segment.
 ;        DFN    - Pointer to PATIENT file (#2).
 ;        TP     - Team Position (Used when processing deletes)
 ;                 In the case of changes to 404.53, this may be
 ;                 PrecepteeTP-PreceptorTP.
 ;Output: None
 ;
 NEW EVIEN
 Q:$G(SCMCOFF)  ;..djb/bp NOIS ISH-1299-40937. Turn off HL7 messaging.
 Q:'$G(EVPTR)  ;......................Event pointer
 S EVIEN=$$CREATE(.EVDATE) ;..........Create new entry
 Q:+EVIEN<0
 S DFN=$G(DFN)
 S TP=$G(TP)
 D STORE(EVIEN,EVPTR,DFN,$G(DUZ),TP,$G(FTEE)) ;Store event info
 D TRANSMIT(EVIEN,1) ;................Mark entry for transmission
 Q
 ;
CREATE(EVDATE) ;Create entry in PCMM HL7 EVENT (#404.48)
 ;
 ; Input: EVDATE - Date/time of PCMM event, in Fileman format.
 ;                 Default="NOW".
 ;Output: Pointer to entry in PCMM HL7 EVENT (#404.48)
 ;        -1^Error - Unable to create entry
 ;
 NEW SCERR,SCFDA,SCIEN
 S:'$G(EVDATE) EVDATE="NOW"
 ;
 S SCFDA(404.48,"+1,",.01)=EVDATE
 D UPDATE^DIE("E","SCFDA","SCIEN","SCERR")
 ;
 I $D(SCERR) Q "-1^Unable to create entry in PCMM HL7 EVENT file"
 Q SCIEN(1)
 ;
STORE(EVIEN,EVPTR,DFN,EVDUZ,TP,FTEE) ;Store data in PCMM HL7 EVENT file
 ;
 ; Input: EVIEN - Pointer to entry in PCMM HL7 EVENT file (#404.48)
 ;        EVPTR - Variable pointer that records IEN and file where
 ;                event occurred. Used to determine Table Designator
 ;                and Table ID for the ZPC segment.
 ;        DFN   - Pointer to PATIENT file (#2).
 ;        EVDUZ - Pointer to entry in NEW PERSON file (#200) that
 ;                caused event to occur (defaults to current DUZ).
 ;        TP    - Team Position (Used when processing deletes)
 ;                In the case of changes to 404.53, this may be
 ;       FTEE    Workload indicator
 ;Output: None
 ;Notes : If EVDUZ and current DUZ not valid, use POSTMASTER (.5)
 ;
 NEW SCERR,SCFDA,SCIENS
 ;
 ;Check input
 Q:'+$G(EVIEN)
 Q:'$D(^SCPT(404.48,EVIEN))
 Q:'$G(EVPTR)
 S:'+$G(EVDUZ) EVDUZ=$S($G(DUZ):DUZ,1:.5)
 I EVDUZ'=.5,'$D(^VA(200,EVDUZ)) S EVDUZ=.5
 ;
 S SCIENS=EVIEN_","
 S SCFDA(404.48,SCIENS,.02)=DFN ;....Patient
 S SCFDA(404.48,SCIENS,.04)=TP ;.....Team Position
 S SCFDA(404.48,SCIENS,.05)=EVDUZ ;..User
 S SCFDA(404.48,SCIENS,.07)=EVPTR ;..Variable event pointer
 I $G(FTEE) S SCFDA(404.48,SCIENS,.08)=FTEE  ;Workload Indicator
 D FILE^DIE(,"SCFDA","SCERR")
 Q
 ;
TRANSMIT(EVIEN,RESET) ;Set transmit flag in PCMM HL7 EVENT (#404.48)
 ;
 ;Input: EVIEN - Pointer to entry in PCMM HL7 EVENT file (#404.48)
 ;       RESET - Should TRANSMISSION REQUIRED fld be ON or OFF?
 ;                  0 = NO
 ;                  1 = YES (Default)
 ;Output: None
 ;Notes : Setting TRANSMISSION REQUIRED field to 'YES' flags entry
 ;        entry for transmission.
 ;
 NEW SCERR,SCFDA,SCIENS
 ;
 ;Check input
 Q:'+$G(EVIEN)
 Q:'$D(^SCPT(404.48,EVIEN))
 S RESET=$S($G(RESET)=0:"NO",1:"YES")
 ;
 S SCIENS=EVIEN_","
 S SCFDA(404.48,SCIENS,.03)=RESET
 D FILE^DIE("E","SCFDA","SCERR")
 Q
