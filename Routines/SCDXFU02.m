SCDXFU02 ;ALB/JRP - AMB CARE FILE UTILITIES;03-MAY-1996 ; 17 Apr 2000  5:27 PM
 ;;5.3;Scheduling;**44,110,128,66,215**;AUG 13, 1993
 ;
CRTDEL(ENCDATE,DFN,DELDATE,ENCNODE) ;Create entry in DELETED OUTPATIENT
 ; ENCOUNTER file (#409.74)
 ;
 ;Input  : ENCDATE - Date/time Outpatient Encounter occurred in
 ;                   FileMan format
 ;         DFN - Pointer to entry in PATIENT file (#2) that the
 ;               deleted Outpatient Encounter was for
 ;         DELDATE - FileMan date/time Outpatient Encounter was deleted
 ;                   (Defaults to NOW)
 ;         ENCNODE - Zero node of entry in OUTPATIENT ENCOUNTER file
 ;                   (#409.68) that was deleted
 ;Output : DELPTR - Pointer to entry in DELETED OUTPATIENT ENCOUNTER
 ;                  file (#409.74)
 ;         -1^Error - Unable to create entry / bad input
 ;
 ;Check input
 S ENCDATE=+$G(ENCDATE)
 Q:('ENCDATE) "-1^Did not pass date/time Outpatient Encounter occurred"
 S DFN=+$G(DFN)
 Q:('$D(^DPT(DFN,0))) "-1^Did not pass valid pointer to patient"
 S DELDATE=+$G(DELDATE)
 S:('DELDATE) DELDATE="NOW"
 S ENCNODE=$G(ENCNODE)
 ;Declare variables
 N DIC,DA,DINUM,DLAYGO,DIDEL,DELPTR
 ;Create entry
 S DIC="^SD(409.74,"
 S DIC(0)="L"
 S X=ENCDATE
 S DIC("DR")=".02////^S X=DFN;.03///^S X=DELDATE;11////^S X=ENCNODE"
 S DLAYGO=409.74
 K DD,DO D FILE^DICN
 ;Get pointer to entry
 S DELPTR=+Y
 ;Error creating entry
 S:(DELPTR<0) DELPTR="-1^Unable to create entry in Deleted Outpatient Encounter file"
 ;Done
 Q DELPTR
 ;
DELDEL(DELPTR) ;Delete entry in DELETED OUTPATIENT ENCOUNTER file (#409.74)
 ;
 ;Input  : DELDEL
 ;Output : 0 - Success
 ;        -1 - Unable to delete entry
 ;Note   : Success (0) is returned when a valid pointer to the
 ;         DELETED OUTPATIENT ENCOUNTER ERROR file is not passed
 ;         (Deleting an entry that doesn't exist is successful)
 ;       : It is the calling application's responsibility to also
 ;         delete the related entry in the TRANSMITTED OUTPATIENT
 ;         ENCOUNTER file (#409.73)
 ;
 ;Check input
 S DELPTR=+$G(DELPTR)
 Q:('$D(^SD(409.74,DELPTR,0))) 0
 ;Declare variables
 N DIK,DA,X,Y,DIC
 ;Delete entry
 S DIK="^SD(409.74,"
 S DA=DELPTR
 D ^DIK
 ;Done
 Q 0
 ;
PTR4MID(MID) ;Find entry in TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73)
 ; using Message Control ID
 ;
 ;Input  : MID - Message Control ID used when entry was transmitted to
 ;               National Patient Care Database
 ;Output : XMITPTR - Pointer to entry in TRANSMITTED OUTPATIENT
 ;                   ENCOUNTER file (#409.73)
 ;         0 - Entry in TRANSMITTED OUTPATIENT ENCOUNTER file with
 ;             given Message Control ID could not be found
 ;
 ;Check input
 S MID=$G(MID)
 Q:(MID="") 0
 ;Find entry - done
 Q +$O(^SD(409.73,"AACMID",MID,""))
 ;
PTRS4BID(BID,ARRAY) ;Find all entries in TRANSMITTED OUTPATIENT ENCOUNTER
 ; file (#409.73) with a specified Batch Control ID
 ;
 ;Input  : BID - Batch Control ID used when entries were transmitted
 ;               to National Patient Care Database
 ;         ARRAY - Array to place pointers to TRANSMITTED OUTPATIENT
 ;                 ENCOUNTER file (#409.73) into (Full global reference)
 ;                 (Defaults to ^TMP("AMB-CARE",$J,"BID"))
 ;Output : None
 ;         ARRAY(XMITPTR) - Array of pointers to TRANSMITTED OUTPATIENT
 ;                          ENCOUNTER file (#409.73)
 ;Note   : It is the responsibility of the calling procedure to
 ;         initialize (i.e. KILL) ARRAY
 ;
 ;Check input
 S BID=$G(BID)
 Q:(BID="")
 S ARRAY=$G(ARRAY)
 S:(ARRAY="") ARRAY="^TMP(""AMB-CARE"","_$J_",""BID"")"
 ;Build array of pointers (merge AACBID cross reference into ARRAY)
 M @ARRAY=^SD(409.73,"AACBID",BID)
 Q
 ;
CRTERR(XMITPTR,ERRCODE,NPCD) ;Create entry in TRANSMITTED OUTPATIENT ENCOUNTER
 ; ERROR file (#409.75)
 ;
 ;Input  : XMITPTR - Pointer to entry in TRANSMITTED OUTPATIENT
 ;                   ENCOUNTER file (#409.73)
 ;         ERRCODE - Error code (external format)
 ;            NPCD - '1' if filed by Austin acknowledgment (optional)
 ;
 ;Output : ERRPTR - Pointer to entry in TRANSMITTED OUTPATIENT ENCOUNTER
 ;                  ERROR file (#409.75)
 ;         -1^Error - Unable to create entry / bad input
 ;Notes  : ERRCODE must be a valid entry in TRANSMITTED OUTPATIENT
 ;         ENCOUNTER ERROR CODE file (#409.76)
 ;
 ;Check input
 ;Convert code to 'reason unknown' if necessary
 I $G(NPCD) D
 .I '$L(ERRCODE) S ERRCODE=999 Q
 .I '$O(^SD(409.76,"B",ERRCODE,"")) S ERRCODE=999
 .Q
 S XMITPTR=+$G(XMITPTR)
 Q:('$D(^SD(409.73,XMITPTR,0))) "-1^Did not pass valid pointer to Transmitted Outpatient Encounter"
 S ERRCODE=$G(ERRCODE)
 Q:(ERRCODE="") "-1^Did not pass valid error code"
 Q:('$O(^SD(409.76,"B",ERRCODE,""))) "-1^Did not pass valid error code"
 ;Declare variables
 N DIC,DA,DINUM,DLAYGO,X,Y
 ;Create entry
 S DIC="^SD(409.75,"
 S DIC(0)="L"
 S DLAYGO=409.75
 S X=XMITPTR
 S DIC("DR")=".02///^S X=ERRCODE"
 K DD,DO D FILE^DICN
 ;Get pointer to entry
 S ERRPTR=+Y
 ;Error creating entry
 S:(ERRPTR<0) ERRPTR="-1^Unable to create entry in Transmitted Outpatient Encounter Error file"
 ;Done
 Q ERRPTR
 ;
DELERR(ERRPTR) ;Delete entry in TRANSMITTED OUTPATIENT ENCOUNTER ERROR
 ; file (#409.75)
 ;
 ;Input  : ERRPTR - Pointer to entry in TRANSMITTED OUTPATIENT ENCOUNTER
 ;                  ERROR file (#409.75) to delete
 ;Output : 0 - Success
 ;        -1 - Unable to delete entry
 ;Note   : Success (0) is returned when a valid pointer to the
 ;         TRANSMITTED OUTPATIENT ENCOUNTER ERROR file is not passed
 ;         (Deleting an entry that doesn't exist is successful)
 ;
 ;Check input
 S ERRPTR=+$G(ERRPTR)
 Q:('$D(^SD(409.75,ERRPTR,0))) 0
 ;Declare variables
 N DIK,DA,X,Y,DIC
 ;Delete entry
 S DIK="^SD(409.75,"
 S DA=ERRPTR
 D ^DIK
 ;Done
 Q 0
 ;
DELAERR(XMITPTR,ERR) ;Delete all entries in TRANSMITTED OUTPATIENT ENCOUNTER
 ; ERROR file (#409.75) for a Transmitted Outpatient Encounter
 ;
 ;Input  : XMITPTR - Pointer to entry in TRANSMITTED OUTPATIENT
 ;                   ENCOUNTER file (#409.73) to delete errors for
 ;             ERR - Which error to delete.
 ;    0 OR NOTHING - delete ALL errors
 ;               1 - VISTA errors
 ;               2 - NPCDB errors
 ;               3 - HL7 errors
 ;                   
 ;Output : None
 ;
 ;Check input
 S XMITPTR=+$G(XMITPTR)
 S ERR=+$G(ERR)
 ;Declare variables
 N ERRPTR,TMP
 ;Find all entries in Transmitted Outpatient Encounter Error file that
 ; point to the Transmitted Outpatient Encounter and delete
 S ERRPTR=""
 F  S ERRPTR=+$O(^SD(409.75,"B",XMITPTR,ERRPTR)) Q:('ERRPTR)  DO
 .I '+ERR S TMP=$$DELERR(ERRPTR) ;default and all
 .N ERTYPE
 .S ERTYPE=+$P($G(^SD(409.75,ERRPTR,0)),U,2)
 .Q:'ERTYPE
 .S ERTYPE=$P($G(^SD(409.76,ERTYPE,0)),U,2)
 .I ERR=1,ERTYPE="V" S TMP=$$DELERR(ERRPTR) ;delete vista errors
 .I ERR=2,ERTYPE="N" S TMP=$$DELERR(ERRPTR) ;delete NPCDB errors
 .I ERR=3,ERTYPE="T" S TMP=$$DELERR(ERRPTR) ;delete HL7 errors
 .Q
 ;Done
 Q
