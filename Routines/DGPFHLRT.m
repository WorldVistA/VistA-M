DGPFHLRT ;ALB/RPM - PRF HL7 MESSAGE RETRANSMIT ; 7/18/06 10:49am
 ;;5.3;Registration;**425,650**;Aug 13, 1993;Build 3
 ;This routine generates a QRY~R02 HL7 message for all Incomplete
 ;status PRF HL7 EVENT (#26.21) file patient query records.
 ;
 Q  ;no direct entry
 ;
RUNQRY ;Generate new PRF QRY~R02 HL7 Query for a patient
 ;This procedure scans all entries in the ASTAT index of the PRF HL7
 ;EVENT (#26.21) file, looking for INCOMPLETE status HL7 query records
 ;
 N DGASGN  ;array of Category I assignment ien's
 N DGDFN   ;pointer to patient in PATIENT (#2) file
 N DGLIEN  ;PRF HL7 EVENT (#26.21) file IEN
 N DGPFL   ;array of event data fields
 ;
 S DGLIEN=0
 F  S DGLIEN=$O(^DGPF(26.21,"ASTAT","I",DGLIEN)) Q:'DGLIEN  D
 . K DGPFL,DGASGN
 . Q:'$$GETEVNT^DGPFHLL1(DGLIEN,.DGPFL)
 . ;
 . Q:($P($G(DGPFL("STAT")),U,1)'="I")
 . ;
 . S DGDFN=$P($G(DGPFL("DFN")),U,1)
 . Q:DGDFN']""
 . ;
 . ;If patient already has the total possible number of Cat I flags,
 . ;then mark the query event file as COMPLETE and quit.
 . I $$GETALL^DGPFAA(DGDFN,.DGASGN,"",1)=$$CNTRECS^DGPFUT1(26.15) D  Q
 . . D STOEVNT^DGPFHLL1(DGDFN,"C")
 . ;
 . ;mark the event in ERROR when attempt limit is reached and quit
 . I $$QRYCNT(DGLIEN)+1>$$TRYLIMIT() D  Q
 . . D STOEVNT^DGPFHLL1(DGDFN,"E")
 . ;
 . ;run query in deferred mode
 . I $$SNDQRY^DGPFHLS(DGDFN,2)
 . ;
 Q
 ;
QRYCNT(DGEVNT) ;get number of logged query attempts
 ;This function counts the number of entries in the PRF HL7 QUERY LOG
 ;(#26.19) file for a given PRF HL7 EVENT.
 ;
 ;  Input:
 ;    DGEVNT  - pointer to PRF HL7 EVENT (#26.21) file
 ;
 ;  Function value - number of logged query attempts
 ;
 N DGCNT
 N DGLIEN
 ;
 S DGEVNT=+$G(DGEVNT)
 S DGCNT=0
 S DGLIEN=0
 F  S DGLIEN=$O(^DGPF(26.19,"C",DGEVNT,DGLIEN))  Q:'DGLIEN  D
 . S DGCNT=DGCNT+1
 ;
 Q DGCNT
 ;
TRYLIMIT() ;get PRF Query Try Limit parameter value
 ;
 ;  Input:  none
 ;
 ;  Output:
 ;    Function value - DGPF QUERY TRY LIMIT parameter [DEFAULT=5]
 ;
 N DGVAL
 S DGVAL=$$GET^XPAR("PKG","DGPF QUERY TRY LIMIT",1,"Q")
 Q $S(DGVAL="":5,1:DGVAL)
