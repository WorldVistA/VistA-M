SCDXUTL4 ;ALB/JRP - ACRP ERROR CODE UTILITIES;08-OCT-1996
 ;;5.3;Scheduling;**68**;AUG 13, 1993
PAT4XMIT(XMITPTR) ;Return patient associated to entry in TRANSMITTED
 ; OUTPATIENT ENCOUNTER file (#409.73)
 ;
 ;Input  : XMITPTR - Pointer to entry in TRANSMITTED OUTPATIENT
 ;                   ENCOUNTER file (#409.73)
 ;Output : DFN^Name - Patient that is associated to the encounter
 ;                  DFN = Pointer to PATIENT file (#2)
 ;                  Name = Patient's name
 ;         0 - Error/bad input
 ;Notes  : This call follows the link from the TRANSMITTED OUTPATIENT
 ;         ENCOUNTER file (#409.73) to the OUTPATIENT ENCOUNTER file
 ;         (#409.68) [or DELETED OUTPATIENT ENCOUNTER file (#409.74)]
 ;         to the PATIENT file (#2)
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0))) 0
 ;Declare variables
 N DFN,DELPTR,ENCPTR,NODE,NAME
 S DFN=0
 ;Determine if entry in transmit file is for a deleted encounter or
 ; an existing encounter
 S NODE=$G(^SD(409.73,XMITPTR,0))
 S ENCPTR=+$P(NODE,"^",2)
 S DELPTR=+$P(NODE,"^",3)
 Q:(('ENCPTR)&('DELPTR)) 0
 ;Existing encounter
 I (ENCPTR) D
 .;Follow pointer to OUTPATIENT ENCOUNTER file
 .S NODE=$G(^SCE(ENCPTR,0))
 .;Get pointer to PATIENT file
 .S DFN=+$P(NODE,"^",2)
 ;Deleted encounter
 I (DELPTR) D
 .;Follow pointer to DELETED OUTPATIENT ENCOUNTER file
 .S NODE=$G(^SD(409.74,DELPTR,0))
 .;Get pointer to PATIENT file
 .S DFN=+$P(NODE,"^",2)
 ;Bad pointer to PATIENT file
 Q:('$D(^DPT(DFN,0))) 0
 ;Get patient's name
 S NODE=$G(^DPT(DFN,0))
 S NAME=$P(NODE,"^",1)
 ;No name on file
 S:(NAME="") NAME="NAME NOT ON FILE (#"_DFN_")"
 ;Done
 Q DFN_"^"_NAME
 ;
PAT4ERR(PTRERR) ;Return patient associated to entry in TRANSMITTED OUTPATIENT
 ; ENCOUNTER ERROR file (#409.75)
 ;
 ;Input  : PTRERR - Pointer to entry in TRANSMITTED OUTPATIENT
 ;                  ENCOUNTER ERROR file (#409.75)
 ;Output : DFN^Name - Patient that is associated to the error
 ;                  DFN = Pointer to PATIENT file (#2)
 ;                  Name = Patient's name
 ;         0 - Error/bad input
 ;Notes  : This call follows the link from the TRANSMITTED OUTPATIENT
 ;         ENCOUNTER ERROR file (#409.75) to the TRANSMITTED OUTPATIENT
 ;         ENCOUNTER file (#409.73) to the OUTPATIENT ENCOUNTER file
 ;         (#409.68) [or DELETED OUTPATIENT ENCOUNTER file (#409.74)]
 ;         to the PATIENT file (#2)
 ;
 ;Check input
 S PTRERR=+$G(PTRERR)
 Q:('$D(^SD(409.75,PTRERR,0))) 0
 ;Declare variables
 N NODE,XMITPTR
 ;Get pointer to TRANSMITTED OUTPATIENT ENCOUNTER file
 S NODE=$G(^SD(409.75,PTRERR,0))
 S XMITPTR=+$P(NODE,"^",1)
 Q:('XMITPTR) 0
 ;Return patient info
 Q $$PAT4XMIT(XMITPTR)
 ;
GETREJ(OUTARR,SCREEN,DOTS) ;Return list of all patients/encounters in the
 ; TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73) that were rejected
 ;
 ;Input  : OUTARR - Array to store output in (full global reference)
 ;                  Defaults to ^TMP("SCDX",$J)
 ;         SCREEN - Flag denoting if entries should be screen
 ;                  0 = Don't apply any screens (default)
 ;                  1 = Screen out entries that are marked for [re]xmit
 ;                  2 = Only return entries that are demographic rejects
 ;                  3 = Apply screen #1 & #2
 ;         DOTS - Flag denoting if dots (.) should be printed
 ;                0 = Don't print dots whild building list (default)
 ;                N = Print 1 dot for every N encounters found
 ;Output : PATCNT ^ ENCCNT
 ;           PATS = Number of patients that were found
 ;           COUNT = Number of entries in TRANSMITTED OUTPATIENT
 ;                   ENCOUNTER file (#409.73) that were found
 ;         If entries are found, OUTARR() will be in the format
 ;             OUTARR("NAME",NAME) = DFN ^ REJ
 ;             OUTARR("DFN",DFN,XMITPTR) = NAME
 ;         Where NAME = Patient's name
 ;               DFN = Pointer to entry in PATIENT file (#2)
 ;               REJ = Total number of encounters rejected for patient
 ;               XMITPTR = Pointer to entry in TRANSMITTED OUTPATIENT
 ;                         ENCOUNTER file (#409.73)
 ;Notes  : It is the responsibility of the calling program to
 ;         initialize (ie KILL) the output array
 ;
 ;Check input
 S OUTARR=$G(OUTARR)
 S:(OUTARR="") OUTARR="^TMP(""SCDX"","_$J_")"
 S SCREEN=+$G(SCREEN)
 S DOTS=+$G(DOTS)
 S:(DOTS<0) DOTS=0
 ;Declare variables
 N DFN,XMITPTR,PATCNT,ENCCNT,NAME,TMP,MARKED
 S PATCNT=0
 S ENCCNT=0
 ;Loop through all encounters that have been rejected
 S XMITPTR=""
 F  S XMITPTR=+$O(^SD(409.75,"B",XMITPTR)) Q:('XMITPTR)  D
 .;If applicable, screen out encounters marked for [re]transmission
 .I ((SCREEN=1)!(SCREEN=3)) D  Q:(MARKED)
 ..S TMP=$G(^SD(409.73,XMITPTR,0))
 ..S MARKED=+$P(TMP,"^",4)
 .;If applicable, screen out encounters that are not demographic rejects
 .I ((SCREEN=2)!(SCREEN=3)) Q:'$$REJ4DEMO^SCDXUTL3(XMITPTR)
 .;Get pointer to encounter's patient
 .S TMP=$$PAT4XMIT(XMITPTR)
 .S DFN=+$P(TMP,"^",1)
 .S NAME=$P(TMP,"^",2)
 .;Couldn't find patient - ignore
 .Q:('DFN)
 .;Increment patient count
 .S:('$D(@OUTARR@("DFN",DFN))) PATCNT=PATCNT+1
 .;Store patient & encounter in output array
 .S @OUTARR@("DFN",DFN,XMITPTR)=NAME
 .;Increment encounter counts
 .S TMP=$G(@OUTARR@("NAME",NAME))
 .S @OUTARR@("NAME",NAME)=DFN_"^"_(1+$P(TMP,"^",2))
 .S ENCCNT=ENCCNT+1
 .;Print dots ?
 .I (DOTS) W:('(ENCCNT#DOTS)) "."
 Q PATCNT_"^"_ENCCNT
 ;
XMIT4DFN(DFN,OUTARR) ;Return list of entries in TRANSMITTED OUTPATIENT
 ; ENCOUNTER file (#409.73) for a given patient
 ;
 ;Input  : DFN - Pointer to entry in PATIENT file (#2)
 ;         OUTARR - Array to store output in (full global reference)
 ;                  Defaults to ^TMP("SCDX",$J)
 ;Output : X - Number of entries in TRANSMITTED OUTPATIENT ENCOUNTER
 ;             file (#409.73) that were found
 ;         If entries are found, OUTARR() will be in the format
 ;             OUTARR(DFN,XMITPTR) = ""
 ;         Where XMITPTR = Pointer to entry in TRANSMITTED OUTPATIENT
 ;                         ENCOUNTER file (#409.73)
 ;Notes  : It is the responsibility of the calling program to
 ;         initialize (ie KILL) the output array
 ;
 ;Check input
 S DFN=+$G(DFN)
 Q:('$D(^DPT(DFN,0))) 0
 S OUTARR=$G(OUTARR)
 S:(OUTARR="") OUTARR="^TMP(""SCDX"","_$J_")"
 ;Declare variables
 N ENCPTR,DELPTR,XMITPTR,COUNT
 S COUNT=0
 ;Find all entries in the OUTPATIENT ENCOUNTER file (#409.68) that
 ;pertain to the given patient
 S ENCPTR=""
 F  S ENCPTR=+$O(^SCE("C",DFN,ENCPTR)) Q:('ENCPTR)  D
 .;Find entry in TRANSMITTED OUTPATIENT ENCOUNTER file
 .S XMITPTR=+$O(^SD(409.73,"AENC",ENCPTR,0))
 .Q:('XMITPTR)
 .;Store pointer in output array an increment counter
 .S @OUTARR@(DFN,XMITPTR)=""
 .S COUNT=COUNT+1
 ;Find all entries in DELETED OUTPATIENT ENCOUNTER file (#409.74) that
 ;pertain to the given patient
 S DELPTR=""
 F  S DELPTR=+$O(^SD(409.74,"PAT",DFN,DELPTR)) Q:('DELPTR)  D
 .;Find entry in TRANSMITTED OUTPATIENT ENCOUNTER file
 .S XMITPTR=+$O(^SD(409.73,"ADEL",DELPTR,0))
 .Q:('XMITPTR)
 .;Store pointer in output array an increment counter
 .S @OUTARR@(DFN,XMITPTR)=""
 .S COUNT=COUNT+1
 Q COUNT
