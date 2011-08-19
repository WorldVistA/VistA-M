SCDXFU01 ;ALB/JRP - AMB CARE FILE UTILITIES;01-MAY-1996 ; 1/14/02 2:45pm
 ;;5.3;Scheduling;**44,64,97,121,247**;AUG 13, 1993
 ;
CRTXMIT(ENCPTR,DELPTR,EVNTDATE) ;Create entry in TRANSMITTED OUTPATIENT
 ; ENCOUNTER file (#409.73)
 ;
 ;Input  : ENCPTR - Pointer to entry in OUTPATIENT ENCOUNTER
 ;                  file (#409.68)
 ;         DELPTR - Pointer to entry in DELETED OUTPATIENT ENCOUNTER
 ;                  file (#409.74)
 ;         EVNTDATE - Date/time the [DELETED] OUTPATIENT ENCOUNTER
 ;                    occurred in FileMan format (Defaults to NOW)
 ;Output : XMITPTR - Pointer to entry in TRANSMITTED OUTPATIENT
 ;                   ENCOUNTER file (#409.73)
 ;         -1^Error - Unable to create entry / bad input
 ;Note   : When an encounter is deleted from the OUTPATIENT ENCOUNTER
 ;         file and an entry for the encounter is created in the
 ;         DELETED OUTPATIENT ENCOUNTER file, the ENCPTR and DELPTR
 ;         parameters should both be used.  This allows an existing
 ;         entry that points to the OUTPATIENT ENCOUNTER file (ENCPTR)
 ;         to be repointed to the related entry entry in the DELETED
 ;         OUTPATIENT ENCOUNTER file (DELPTR).  If an existing entry
 ;         for the OUTPATIENT ENCOUNTER is not found (or ENCPTR is not
 ;         passed/valid), a new entry will be created that points to
 ;         the DELETED OUTPATIENT ENCOUNTER.
 ;Note   : A value for DELPTR should not be passed when creating an
 ;         entry for an OUTPATIENT ENCOUNTER.  A value for ENCPTR does
 ;         not have to be passed when creating an entry for a DELETED
 ;         OUTPATIENT ENCOUNTER, but is recommended.
 ;Note   : If an entry for the [DELETED] OUTPATIENT ENCOUNTER already
 ;         exists, a new entry will not be created and a pointer to
 ;         the existing entry will be returned.
 ;
 ;Check input
 S ENCPTR=+$G(ENCPTR)
 S DELPTR=+$G(DELPTR)
 Q:(('ENCPTR)&('DELPTR)) "-1^Did not pass pointer to encounter"
 Q:(('$D(^SCE(ENCPTR)))&('$D(^SD(409.74,DELPTR)))) "-1^Did not pass valid pointer to encounter"
 S EVNTDATE=+$G(EVNTDATE)
 S:('EVNTDATE) EVNTDATE="NOW"
 ;Declare variables
 N ADDENC,XMITPTR,DIE,DA,DR,DIDEL,DIC,DA,DINUM,DLAYGO,X,Y
 ;do not recreate entries for encounters prior to 10/1/96
 Q:$$ENCDT(ENCPTR,DELPTR)<2961001 "-1^Encounter Date is prior to 10/1/96"
 ;Adding new Outpatient Encounter
 S ADDENC=1
 ;Adding new Deleted Outpatient Encounter
 S:(DELPTR) ADDENC=0
 ;Find existing Outpatient Encounter
 S XMITPTR=+$O(^SD(409.73,"AENC",ENCPTR,""))
 ;Adding an existing Outpatient Encounter - done
 Q:((ADDENC)&(XMITPTR)) XMITPTR
 ;Converting an Outpatient Encounter to a Deleted Outpatient Encounter
 ; Swap pointer & store event info - done
 I (('ADDENC)&(XMITPTR)) D  Q XMITPTR
 .S DIE="^SD(409.73,"
 .S DA=XMITPTR
 .S DR=".02///@;.03////^S X=DELPTR"
 .D ^DIE
 .D STREEVNT(XMITPTR,3,EVNTDATE,+$G(DUZ))
 ;Adding a new [Deleted] Outpatient Encounter - create entry
 ; using auto-numbering capabilities of file
 S DIC="^SD(409.73,"
 S DIC(0)="L"
 S X="+"
 S DLAYGO=409.73
 ;Adding a new Outpatient Encounter
 S DIC("DR")=".02////^S X=ENCPTR"
 ;Adding a new Deleted Outpatient Encounter
 S:('ADDENC) DIC("DR")=".03////^S X=DELPTR"
 ;Create entry
 D ^DIC
 ;Get pointer to entry
 S XMITPTR=+Y
 ;Error creating entry
 Q:(XMITPTR<0) "-1^Unable to create entry in Transmitted Outpatient Encounter file"
 ;Store event info
 D STREEVNT(XMITPTR,$S(('ADDENC):3,1:1),EVNTDATE,+$G(DUZ))
 ;Done
 Q XMITPTR
 ;
FINDXMIT(ENCPTR,DELPTR) ;Find entry in TRANSMITTED OUTPATIENT ENCOUNTER
 ; file (#409.73)
 ;
 ;Input  : ENCPTR - Pointer to entry in OUTPATIENT ENCOUNTER
 ;                  file (#409.68)
 ;         DELPTR - Pointer to entry in DELETED OUTPATIENT ENCOUNTER
 ;                  file (#409.74)
 ;Output : XMITPTR - Pointer to entry in TRANSMITTED OUTPATIENT
 ;                   ENCOUNTER file (#409.73)
 ;         0 - Entry in TRANSMITTED OUTPATIENT ENCOUNTER file for the
 ;             [DELETED] OUTPATIENT ENCOUNTER does not exist
 ;Note   : A value for DELPTR should not be passed if finding an entry
 ;         for an OUTPATIENT ENCOUNTER.  A value for ENCPTR should not
 ;         be passed if finding an entry for a DELETED OUTPATIENT
 ;         ENCOUNTER.  If values for both parameters are passed, the
 ;         pointer to the OUTPATIENT ENCOUNTER will be used.
 ;
 ;Check input
 S ENCPTR=+$G(ENCPTR)
 S DELPTR=+$G(DELPTR)
 Q:(('ENCPTR)&('DELPTR)) 0
 ;Find entry for Outpatient Encounter - done
 Q:(ENCPTR) +$O(^SD(409.73,"AENC",ENCPTR,""))
 ;Find entry for Deleted Outpatient Encounter - done
 Q +$O(^SD(409.73,"ADEL",DELPTR,""))
 ;
STREEVNT(XMITPTR,XMITEVNT,EVNTDATE,EVNTDUZ) ;Store event information for
 ; entry in TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73)
 ;
 ;Input  : XMITPTR - Pointer to entry in TRANSMITTED OUTPATIENT
 ;                   ENCOUNTER file (#409.73)
 ;         XMITEVNT - Flag denoting event causing transmission
 ;                    0 = Retransmit (DEFAULT)
 ;                    1 = Addition of entry in OUTPATIENT ENCOUNTER file
 ;                    2 = Editing of entry in OUTPATIENT ENCOUNTER file
 ;                    3 = Deletion of entry in OUTPATIENT ENCOUNTER file
 ;                        (Addition of entry in DELETED OUTPATIENT
 ;                         ENCOUNTER file)
 ;         EVNTDATE - Date/time event causing transmission occurred
 ;                    in FileMan format (defaults to NOW)
 ;         EVNTDUZ - Pointer to entry in NEW PERSON file (#2) that
 ;                   caused the event to occur (defaults to current DUZ)
 ;Output  : None
 ;Notes   : If EVNTDUZ and/or the current DUZ are not valid, POSTMASTER
 ;          (.5) will be used
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR)))
 S XMITEVNT=+$G(XMITEVNT)
 S:((XMITEVNT<0)!(XMITEVNT>3)) XMITEVNT=0
 S EVNTDATE=+$G(EVNTDATE)
 S:('EVNTDATE) EVNTDATE="NOW"
 S EVNTDUZ=+$G(EVNTDUZ,$G(DUZ))
 S:('$D(^VA(200,EVNTDUZ,0))) EVNTDUZ=.5
 ;Declare variables
 N DIE,DA,DR,DIDEL,X,Y,DIC
 ;Store event data
 S DIE="^SD(409.73,"
 S DA=XMITPTR
 S DR=".05////^S X=XMITEVNT;.06///^S X=EVNTDATE;.07////^S X=EVNTDUZ"
 D ^DIE
 ;Done
 Q
 ;
XMITFLAG(XMITPTR,RESET) ;Set/reset transmission flag for entry in
 ; TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73)
 ;
 ;Input  : XMITPTR - Pointer to entry in TRANSMITTED OUTPATIENT
 ;                   ENCOUNTER file (#409.73)
 ;         RESET - Denotes if transmission field should be turned
 ;                 on or off
 ;                 0 = Set TRANSMISSION REQUIRED field (#.04) equal
 ;                     to 'YES' (DEFAULT)
 ;                 1 = Set TRANSMISSION REQUIRED field (#.04) equal
 ;                     to 'NO'
 ;Output : None
 ;Notes  : Setting the TRANSMISSION REQUIRED field to 'YES' flags
 ;         the entry for transmission
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR)))
 S RESET=+$G(RESET)
 ;Declare variables
 N DIE,DA,DR,DIDEL,X,Y,DIC
 ;Store new value for transmission flag
 S DIE="^SD(409.73,"
 S DA=XMITPTR
 ;Set transmission flag
 S DR=".04///YES"
 ;Reset transmission flag
 S:(RESET) DR=".04///NO"
 D ^DIE
 ;If turning flag on, check for late activity & send bulletin
 I 'RESET I +$$XMIT4DBC^SCDXFU04(XMITPTR)>0 D LATEACT^SCDXMSG2(XMITPTR) ;SD*5.3*247
 ;Done
 Q
 ;
ENCDT(ENCPTR,DELPTR) ;returns the date of the encounter
 ;  Input  : ENCPTR - Pointer to entry in OUTPATIENT ENCOUNTER
 ;                    file (#409.68)
 ;           DELPTR - Pointer to entry in DELETED OUTPATIENT ENCOUNTER
 ;                    file (#409.74)
 ; Returned: Date of encounter (#.01 of #409.68)
 Q $S($D(^SCE(+$G(ENCPTR),0)):+^(0),$D(^SD(409.74,+$G(DELPTR),0)):^(0),1:"-1^No Pointer")
