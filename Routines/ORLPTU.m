ORLPTU ; SLC/PKS  OE/RR - Terminated users, pointer removal. ; [3/13/00 1:04pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**44**;Dec 17, 1997
 ;
 ; OE/RR - Remove pointers from team lists file.
 ; The records to be edited are pointers to file #200, NEW PERSON.
 ; Routine is triggered by Kernel's XU USER TERMINATE event.
 ;
 ; This routine also removes the complete team list record from
 ; team file ^OR(100.21 if the Team List involved is a Personal
 ; type list and the terminated user is the only user on the list.
 ;
 ; Entries are removed from the following files::
 ;
 ; File Name       File#,Field#        Field Name
 ; -------------------------------------------------------------
 ; OE/RR LIST      100.21,2            USER
 ; OE/RR LIST      100.21,3            AUTOLINK
 ;
 ; The first example is a subfile multiple pointer and DINUM field.
 ; The second example is a subfile multiple variable pointer.
 ; Variable "USER" is DUZ of user for whom entries will be removed;
 ; it's value must be available to the routine from Kernel.
 ;
 ; =============================================================
 ;
 ; EXAMPLES of file entries with pointers being removed:
 ;    (Where "777" is the USER) -
 ;
 ; ^OR(100.21,140,1,777,0) = 777
 ; ^OR(100,21,140,2,1,0) = 777;VA(200,^B
 ;
 ; =============================================================
 ;
 ; Variables used:
 ;
 ;   USER   = DUZ of terminated user.
 ;   DIK,DA = Used by call to ^DIK.
 ;   RFILE  = Root file.
 ;   IEN    = Record IEN.
 ;   SIEN   = Subfile IEN.
 ;   TEAM   = IEN of team to kill if terminated user is only user.
 ;   ORYDAT = File data holder.
 ;
 ; -------------------------------------------------------------
 ;
 Q
 ;
PASS(TU) ; TU (Terminated User = USER variable) sent in call at this tag.
 ;
 N USER
 S USER=TU     ; Assign USER variable.
 I USER="" Q   ; Punt right away if there's a problem.
 D MAIN        ; Skip next tag, go to main processing.
 Q
 ;
KUSER ; Get USER from kernel - called by option: OR TERMINATE CLEANUP.
 ;
 N USER
 S USER=$GET(XUIFN) ; Assign USER variable.
 I USER="" Q        ; Punt here if there's a problem.
 ;
MAIN ; Processing portion of routine.
 ;
 N DIK,DA,RFILE,IEN,TEAM,CNT,SIEN,ORYDAT
 ;
 ; Order through the file for each team:
 S RFILE="^OR(100.21," ; Assign root file string.
 S IEN=0               ; Initialize.
 ;
 F  S IEN=$ORDER(^OR(100.21,IEN)) Q:+IEN=0  D  ; Each team.
 .S TEAM=""
 .S CNT=0
 .S SIEN=0
 .;
 .; Check and remove user from teams as applicable:
 .F CNT=0:1 S SIEN=$ORDER(^OR(100.21,IEN,1,SIEN)) Q:+SIEN=0  D
 ..I SIEN=USER D  ; If user is on team, set FM vars and call DIK.
 ...N DA
 ...S DA=SIEN,DA(1)=IEN,DIK=RFILE_DA(1)_",1,"
 ...D ^DIK
 ...;
 ...; Set up for possible team kill if team type is "P" (Personal):
 ...I $P(^OR(100.21,IEN,0),"^",2)="P" S TEAM=IEN
 .;
 .; Check and remove user for AUTOLINKS if found:
 .S SIEN=0  ; Initialize again.
 .F  S SIEN=$O(^OR(100.21,IEN,2,SIEN)) Q:+SIEN=0  D
 ..I +(^OR(100.21,IEN,2,SIEN,0))=USER D
 ...;
 ...; Check for correct type of AUTOLINK:
 ...S ORYDAT="^OR(100.21,"_IEN_",2,"_SIEN_",0)"
 ...I $G(@ORYDAT)'["VA" Q  ; Not a ^VA(200 file pointer.
 ...;
 ...N DA
 ...S DA=SIEN,DA(1)=IEN,DIK=RFILE_DA(1)_",2,"
 ...D ^DIK
 .;
 .; Remove team entry altogether if terminated user is only user:
 .I CNT=1&'(TEAM="") D  ; Set FM vars, call DIK, kill team entry.
 ..N DA
 ..S DA=TEAM,DIK=RFILE
 ..D ^DIK
 ..;
 ..; Call tag/routine to clean up pointers to the list in file 123.5:
 ..D CLNLIST^GMRCTU(TEAM,0)
 ;
 Q
 ;
