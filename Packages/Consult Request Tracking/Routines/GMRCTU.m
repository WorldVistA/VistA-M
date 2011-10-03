GMRCTU ; SLC-SLC/PKS  Consults - Terminated users/remove pointers. ; [2/8/00 11:15am]
 ;;3.0;CONSULT/REQUEST TRACKING;**9**;Dec 27, 1997
 ;
 ; OE/RR V3.0 - CONSULTS V3.0
 ;
 ; CONSULTS - Removes pointers upon termination.
 ; The records to be edited are pointers to file #200, NEW PERSON.
 ;
 ; ------------------------------------------------------------------
 ; Enter new files/fields at end of routine under entry label "TEXT."
 ; ------------------------------------------------------------------
 ;
 ; Triggered by Kernel's XU USER TERMINATE event.
 ; Applicable piece set to null or multiples delted. 
 ; Variable "USER" is DUZ of user for whom pointers will be removed.
 ; The "USER" value must be passed to the routine by Kernel.
 ;
 ; Variables used:
 ;    NPARY       = DB array with info on file/field.
 ;    CNT         = Overall counter variable.
 ;    INFO        = TEXT list variable.
 ;    VALUE       = Value match string.
 ;    DIE,DA,DR,X = Used by calls to ^DIE.
 ;    NODE        = Node to edit, if applicable.
 ;    PIECE       = Piece of node to edit.
 ;    RSTR        = Global root file string.
 ;    SSTR        = Subfile string.
 ;    FILENUM     = File number.
 ;    IEN         = IEN string.
 ;    SIEN        = Subfile IEN string.
 ;    FIELDNUM    = Data Dictionary field number.
 ;    APPSTR      = Append string variable.
 ;
 Q
 ;
EN ; Entry point - called by option: CONSULT TERMINATE CLEANUP.
 ;
 S USER=$GET(XUIFN) ; Assign user variable.
 I USER="" Q        ; If there's a problem, dump out right now.
 D START(USER)      ; Call the Control sequence for whole routine.
 Q
 ;
FINDVAL ; See if VALUE (desired USER) exists in the record.
 ;
 S VALUE="" ; Initialize.
 ;
 I SSTR="" D  Q  ; If no subfile, quit after this IF.
 .I $P($G(@(RSTR_+IEN_","_NODE_APPSTR)),"^",PIECE)=USER S VALUE=USER
 ;
 ; Process subfiles:
 I $P($G(@(RSTR_+IEN_","_SSTR_","_SIEN_","_NODE_APPSTR)),"^",PIECE)=USER S VALUE=USER
 ;
 Q
 ;
CALLDIE ; Set FM variables and call DIE.
 ;
 N DIE,DA,DR,X
 ;
 I SSTR="" D  Q  ; No subfile involved.
 .S DA=IEN,DIE=RSTR,DR=FIELDNUM_"///^S X=""@"""
 .LOCK +@(DIE_IEN_")"):0
 .D ^DIE ; User terminated, so call regardless of lock success.
 .LOCK -@(DIE_IEN_")")
 ;
 ; Process subfile:
 S DA(1)=IEN,DA=SIEN,DIE=RSTR_DA(1)_","_SSTR_",",DR=FIELDNUM_"///^S X=""@"""
 LOCK +@(DIE_IEN_")"):0
 D ^DIE ; User terminated, so call regardless of lock success.
 LOCK -@(DIE_IEN_")")
 ;
 Q
 ;
MAIN ; Outer FOR loop to scan file for IENs, deleting pointer entries.
 ;
 D INFO^GMRCTU1(FILENUM,FIELDNUM,.NPARY) ; DB call, gets information.
 ;
 I (NPARY("DIC",0)="")!(NPARY("LOC")="") Q  ; Problems?  Dump out.
 ;
 ; Assign variables from resulting call:
 S (RSTR,SSTR,NODE,PIECE,APPSTR)="" ; Initialize.
 S RSTR=NPARY("DIC",1) ; Assign global root string.
 ;
 ; If a multiple, set flag and assign subfile string:
 I $L($G(NPARY("DIC",2))) S SSTR=$P(NPARY("DIC",2),",",3)
 S NODE=$P(NPARY("LOC"),";",1)  ; Assign node variable.
 S PIECE=$P(NPARY("LOC"),";",2) ; Assign piece variable.
 S APPSTR=")"                   ; Assign append string.
 ;
 ; Order through file root entries:
 S IEN="" ; Initialize.
 ;
 F  S IEN=$O(@(RSTR_+IEN_")")) Q:+IEN=0  D
 .I SSTR="" D  Q          ; Is subfile involved?
 ..D FINDVAL              ; Check for value match.
 ..I VALUE=USER D CALLDIE ; If a match, clean out pointer entry.
 .;
 .; Process subfile multiples:
 .S SIEN=0 ; Initialize.
 .;
 .F  S SIEN=$O(@(RSTR_+IEN_","_SSTR_","_SIEN_")")) Q:+SIEN=0  D
 ..D FINDVAL ; Check for value match.
 ..I VALUE=USER D CALLDIE ; If a match, clean out pointer entry.
 ;
 Q
 ;
START(USER) ;Control sequence for complete process.
 ;
 N CNT,INFO
 S CNT=4 ; Set CNT to first TEXT entry.
 ;
 ; Overall loop to get data from TEXT entries (at end of routine):
 F  D  Q:INFO="QUIT"
 .N NPARY,VALUE,DIE,DA,DR,X,NODE,PIECE,RSTR,SSTR,FILENUM,IEN,SIEN,FIELDNUM,APPSTR
 .S CNT=CNT+1    ; Increment for each TEXT entry.
 .S INFO=$P($TEXT(TEXT+CNT),";;",2) ; Get TEXT string.
 .Q:INFO="QUIT"  ; Finished when no more valid entries are found.
 .; 
 .; Assign two variables from INFO string for each file/field:
 .S FILENUM=$P(INFO,",",1)
 .S FIELDNUM=$P(INFO,",",2)
 .;
 .D MAIN ; Proceed to main processing for each file/field.
 ;
 Q
 ;
 ; *******************************************************************
 ;
 ; Informational comments on files/fields added to TEXT section.  
 ;
 ; File Name            File#,Field    Field Name
 ; ------------------------------------------------------------------
 ; REQUEST SERVICES      123.5,123.5   SPECIAL UPDATES INDIVIDUAL
 ; REQUEST SERVICES      123.5,123.08  SERVICE INDIVIDUAL TO NOTIFY
 ; (NOTIF. BY PT. LOC)   123.54,1      INDIVIDUAL TO NOTIFY
 ; (UPD. USERS W/O NOT.) 123.55,.01    UPDATE USERS W/O NOTIFICATION
 ; (ADM. UPDATE USERS)   123.555,.01   ADMINISTRATIVE UPDATE USER
 ;
 ; ===================================================================
 ;
 ; EXAMPLES of files/pointer entries being removed for above list:
 ;    (Where "777" is the USER) -
 ;
 ; ^GMR(123.5,2,0) = MEDICINE^1^^18^777
 ; ^GMR(123.5,2,123) = 30^1795^2112^^^^^777^11^2199^^
 ; ^GMR(123.5,2,123.2,2,0) = 1;DIC(42,^777^138
 ; ^GMR(123.5,2,123.3,7,0) = 777                         (<--Multiple)
 ; ^GMR(123.5,2,123.33,2,0) = 777                        (<--Multiple)
 ;
 ; *******************************************************************
 ;
TEXT ; Make entries below for new files/fields for pointer removal.
 ; DO NOT remove or change the last line.
 ; Enter comma-delimited lists using DD "pointers in" format:
 ;    Filenumber,Fieldnumber,EntryPersonLocation/Initials
 ;
 ;;123.5,123.5,ISC-SLC/PKS
 ;;123.5,123.08,ISC-SLC/PKS
 ;;123.54,1,ISC-SLC/PKS
 ;;123.55,.01,ISC-SLC/PKS
 ;;123.555,.01,ISC-SLC/PKS
 ;;QUIT
 Q
 ;
CLNLIST(ORLTEAM,ORLTASK) ; Clean out pointers to 100.21 from 123.5 when a Team List is deleted.
 ;
 ; Called by MAIN^ORLPTU (which deletes Personal Team Lists upon
 ;    termination of a sole or last user of the list).
 ;
 ; Called by DEL^ORLP1 (when a non-Personal Team List is deleted).
 ;
 ; Called by DEL^ORLP3U2 (when a Personal Team List is deleted 
 ;    by menu action.
 ;
 ; The following pointers from 123.5 are processed here:
 ;
 ; Subfile Name            File#,Field    Field Name
 ; ----------------------------------------------------------------
 ; (SERVICE TEAM(S) TO NOTIFY)  123.1,.01    SERVICE TEAM TO NOTIFY
 ; (NOTIF. BY PT LOCATION)      123.2,2      TEAM TO NOTIFY
 ; (UPD. TEAMS W/O NOT.)        123.31,.01   UPDATE TEAMS W/O NOTIF.
 ; (ADM. UPDATE TEAMS)          123.34,.01   ADMIN. UPDATE TEAM
 ;
 ; =================================================================
 ;
 ; Variables used:
 ;
 ;    ORLTEAM = Team IEN, passed in call to this tag.
 ;    ORLTASK = Running via Taskman or not?  0=No, 1=Yes.
 ;    ORLGSTR = String for ^GMR(123.5 subfile.
 ;    ORLGIEN = Temporary GMRC target file IEN holder.
 ;    ORLSIEN = Temporary subfile IEN holder.
 ;
 I +ORLTEAM="" Q  ; Punt here if there's a problem.
 Q:'$D(ORLTASK)   ; Ditto.
 N ORLGSTR,ORLGIEN,ORLSIEN
 ;
 ; Check for team entry in 123.1,.01 via "AST" x-ref:
 S ORLGSTR="123.1"
 S ORLGIEN=0
 F  S ORLGIEN=$O(^GMR(123.5,"AST",ORLTEAM,ORLGIEN)) Q:+ORLGIEN=0  D
 .S ORLSIEN=0
 .F  S ORLSIEN=$O(^GMR(123.5,"AST",ORLTEAM,ORLGIEN,ORLSIEN)) Q:+ORLSIEN=0  D KPOINT
 ;
 ; Check for team entry in 123.2,2 via "ANT" x-ref:
 S ORLGSTR="123.2"
 S ORLGIEN=0
 F  S ORLGIEN=$O(^GMR(123.5,"ANT",ORLTEAM,ORLGIEN)) Q:+ORLGIEN=0  D
 .S ORLSIEN=0
 .F  S ORLSIEN=$O(^GMR(123.5,"ANT",ORLTEAM,ORLGIEN,ORLSIEN)) Q:+ORLSIEN=0  D KPOINT
 ;
 ; Check for team entry in 123.31,.01 via "AUT" x-ref:
 S ORLGSTR="123.31"
 S ORLGIEN=0
 F  S ORLGIEN=$O(^GMR(123.5,"AUT",ORLTEAM,ORLGIEN)) Q:+ORLGIEN=0  D
 .S ORLSIEN=0
 .F  S ORLSIEN=$O(^GMR(123.5,"AUT",ORLTEAM,ORLGIEN,ORLSIEN)) Q:+ORLSIEN=0  D KPOINT
 ;
 ; Check for team entry in 123.34,.01 via "AAT" x-ref:
 S ORLGSTR="123.34"
 S ORLGIEN=0
 F  S ORLGIEN=$O(^GMR(123.5,"AAT",ORLTEAM,ORLGIEN)) Q:+ORLGIEN=0  D
 .S ORLSIEN=0
 .F  S ORLSIEN=$O(^GMR(123.5,"AAT",ORLTEAM,ORLGIEN,ORLSIEN)) Q:+ORLSIEN=0  D KPOINT
 ;
 Q
 ;
KPOINT ; Set variables and call DIK to kill the pointer entry.
 ;
 N DIK,DA
 ;
 S DA=ORLSIEN
 S DA(1)=ORLGIEN
 S DIK="^GMR(123.5,"_DA(1)_","_ORLGSTR_","
 ;
 ; Wrap locking functionality around call to DIK:
 L +(^GMR(123.5,ORLGIEN)):0
 D ^DIK ; User terminated, so call regardless of lock success.
 L -(^GMR(123.5,ORLGIEN))
 I ORLTASK D MES^XPDUTL("Pointer to team IEN "_ORLTEAM_" removed from file 123.5, field "_ORLGSTR_" - service IEN "_ORLGIEN_".") ; Installation message to run under Taskman.
 ;
 Q
 ;
