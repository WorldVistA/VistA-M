ORLP3U2 ; SLC/PKS - Team List routines. [3/27/00 4:01pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**63**;Dec 17, 1997
 ;
 Q
 ;
DEL ; Called by option: ORLP3M DELETE USER TEAMS.
 ; Allows CAC menu deletion of personal Team Lists.
 ;
 ; Variables used:
 ;
 ;    DIC     = Fileman lookup routine.
 ;    DIK     = Fileman deletion routine.
 ;    ORPTEAM = Personal Team to delete.
 ;    ORQUIT  = Flag for quitting input loop.
 ;    ORUSER  = Temporary user IEN holder.
 ;    ORHEAD  = Flag for user list heading.
 ;    ORNAME  = User name holder.
 ;    ORNODEL = Flag for no confirmation of deletion.
 ;    
 N ORPQUIT,ORPTEAM,ORQUIT,ORUSER,ORHEAD,ORNAME,ORNODEL
 ;
 ; Set up loop to control action:
 S ORPQUIT=1
 F  D  Q:'ORPQUIT
 .K DIC,DIK
 .S DIC="^OR(100.21,"
 .S DIC(0)="AEQM"
 .S DIC("S")="I $P(^OR(100.21,+Y,0),U,2)=""P"""
 .S DIC("A")="Select Personal Patient List to delete: "
 .W !
 .D ^DIC
 .K DIC
 .I Y<1 S ORPQUIT=0 Q  ; Punt if no selection made.
 .S ORPTEAM=Y
 .;
 .; Display any users currently on team:
 .S ORHEAD=1   ; Set flag for heading.
 .S ORUSER=0
 .F  S ORUSER=$O(^OR(100.21,+ORPTEAM,1,ORUSER)) Q:+ORUSER=0  D
 ..I ORHEAD D  ; First time through, print heading.
 ...S ORHEAD=0 ; Reset flag.
 ...W !!,"   Users currently on team ",$P(ORPTEAM,U,2),":",! ; Display heading.
 ..S ORNAME=$P($G(^VA(200,ORUSER,0)),U) ; Get user's name.
 ..W !,"      ",ORNAME
 .I 'ORHEAD W !
 .;
 .; Get confirmation before deleting the Team List:
 .S ORNODEL=0                    ; Preset flag.
 .S ORQUIT=0
 .F  Q:ORQUIT=1  D               ; Loop to control user entry.
 ..S %=1
 ..W !,"Are you ready to delete list "_$PIECE(ORPTEAM,U,2)
 ..D YN^DICN                     ; Fileman call for user input.
 ..I %=2 S (ORNODEL,ORQUIT)=1 Q  ; Set flags if user enters "NO."
 ..I %=1 S ORQUIT=1 Q            ; "YES" confirmation.
 ..W !,"Enter YES to delete the list, NO to quit." ; For inappropriate entries, loop will repeat.
 .I ORNODEL=1 Q                  ; Delete not confirmed.
 .W !,"Working..."               ; Keep user informed.
 .L +^OR(100.21,+ORPTEAM):3      ; Handle file locking.
 .S DIK="^OR(100.21,"
 .S DA=+ORPTEAM
 .D ^DIK                         ; Delete the Team List.
 .K DIC,DIK,DA,Y,%
 .L -^OR(100.21,+ORPTEAM)        ; Unlock the file.
 .W !,"Searching for/removing Consults pointers to deleted team..."
 .D CLNLIST^GMRCTU(+ORPTEAM,0)   ; Dump team pointers in file 123.5.
 .; Leave success message:
 .W !,"List deletion completed."
 ;
 Q
 ;
AR ; Called by option: ORLP3U ON/OFF A/L TEAMS.
 ; Allows users to add/remove themselves from Autolinked Team Lists.
 ;    (Thanks to Rebecca Bates, Dayton VAMC, for head start on this.)
 ;
 ; Variables used:
 ;
 ;    DIR      = Fileman user input routine.
 ;    DIC      = Fileman lookup routine.
 ;    DIE      = Fileman edit routine.
 ;    DIK      = Fileman deletion routine.
 ;    ORTEAM   = Holder for team IEN.
 ;    ORNAME   = Holder for team name.
 ;    ORCNT    = Counter variable.
 ;    ORNONE   = Flag; if true there are no current team assignments.
 ;    ORACT    = User input holder.
 ;    ORRESULT = Result of file locking call.
 ;
 ; Set up outer control loop for this option's menu function:
 N ORACT
 S ORACT=0
 F  Q:ORACT=3  D  ; Overall control loop.
 .;
 .N DIR,DIC,DIE,DIK,ORTEAM,ORNAME,ORNONE,ORRESULT
 .W ! ; Leave a blank line on the screen for clarity.
 .S ORNONE=1
 .I $D(^OR(100.21,"C",DUZ)) S ORNONE=0 D  ; Current team assignments display control loop.
 ..;
 ..; Get list of currently-assigned Teams:
 ..S ORTEAM="" ; Initialize.
 ..F  S ORTEAM=$O(^OR(100.21,"C",DUZ,ORTEAM))  Q:ORTEAM=""  D  ; Each Team where user is asociated.
 ...;
 ...; Next two lines of executable code create ^TMP entries as:
 ...;       ^TMP("ORLPAR",$J,228)="TEAM ABC"
 ...;    where 228 is a Team List IEN and "TEAM ABC" is a Team name,
 ...;    and the Team is an autolink type and subscribable (i.e.,
 ...;    the SUBSCRIBE field has a "Y" entry in it):
 ...I $P(^OR(100.21,ORTEAM,0),"^",2)["A",$P($G(^OR(100.21,ORTEAM,0)),"^",6)="Y" S ^TMP("ORLPAR",$J,ORTEAM)=$P(^OR(100.21,ORTEAM,0),"^")
 ..;
 ..; If still no valid data, reset ORNONE and punt:
 ..I '$D(^TMP("ORLPAR",$J)) S ORNONE=1 Q
 ..;
 ..; Display currently-associated Teams:
 ..W !,"You are associated with the following autolinked teams:",!
 ..S ORTEAM="" ; Initialize.
 ..F  S ORTEAM=$O(^TMP("ORLPAR",$J,ORTEAM))  Q:ORTEAM=""  D  ; Each team name.
 ...S ORNAME=^TMP("ORLPAR",$J,ORTEAM) ; Assign name variable.
 ...W !,"     "_ORNAME                ; Print to screen.
 .;
 .; If no current associations, indicate same:
 .I ORNONE W !,"You are not currently assigned to any teams."
 .W ! ; Whether current assignments or not, leave a blank line for clarity.
 .;
 .; Set up call to DIR and get user input:
 .S DIR("A")="Next action"
 .S DIR("B")="Quit"
 .S DIR("0")="SET^1:Add;2:Delete;3:Quit"
 .S DIR("?")="Enter 1, 2, or 3: "
 .I ORNONE D  ; Change menu choices if deletions not appropriate.
 ..S DIR("0")="S^1:Add;3:Quit"
 ..S DIR("?")="Enter either 1 or 3: "
 .D ^DIR
 .K DIR
 .I Y<0!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S ORACT=3 Q  ; Quit on errors.
 .I (+Y'=1)&(+Y'=2)&(+Y'=3) S ORACT=3 Q  ; Quit if no acceptable response.
 .S ORACT=+Y                ; Assign user's response.
 .I ORACT=3 Q               ; Quit if user doesn't want any changes.
 .;
 .; Process deletions:
 .I ORACT=2 D               ; Deletion control loop.
 ..;
 ..; Get user input on Team List for removal:
 ..S DIC(0)="AEMQZ"
 ..S DIC="^OR(100.21,"
 ..S DIC("S")="I $D(^TMP(""ORLPAR"",$J,+Y))"
 ..S DIC("A")="Autolinked team for removal of yourself as user/provider: "
 ..D ^DIC
 ..I $D(DTOUT)!$D(DUOUT) Q  ; Entry error.
 ..I +Y<1 Q                 ; No selection made or bad selection.
 ..S ORTEAM=+Y              ; Assign team IEN variable.
 ..S ORNAME=Y(0,0)          ; Assign team name variable.
 ..K DIC
 ..;
 ..; Remove the user from the list:
 ..S ORRESULT=$$ARLOCK
 ..I 'ORRESULT Q            ; Quit if there's a locking problem.
 ..S DA=DUZ
 ..S DA(1)=ORTEAM
 ..S DIK="^OR(100.21,"_DA(1)_","_1_","
 ..D ^DIK
 ..K DIK
 ..L -^OR(100.21,ORTEAM)    ; Clean up file lock.
 ..Q
 .;
 .; Process additions:
 .I ORACT=1 D               ; Addition control loop.
 ..;
 ..; Get user input on Team List for addition:
 ..S DIC="^OR(100.21,"
 ..S DIC(0)="AEMQZ"
 ..S DIC("S")="I $P(^OR(100.21,+Y,0),""^"",2)[""A"",$P($G(^OR(100.21,+Y,0)),""^"",6)=""Y"",'$D(^TMP(""ORLPAR"",$J,+Y))"
 ..S DIC("A")="Autolinked team for addition of yourself as user/provider: "
 ..D ^DIC
 ..K DIC
 ..I $D(DTOUT)!$D(DUOUT) Q  ; Entry error.
 ..I Y<1 Q                  ; No selection made or bad selection.
 ..S ORTEAM=+Y              ; Assign Team IEN variable.
 ..;
 ..; Add user to selected Team List:
 ..S ORRESULT=$$ARLOCK
 ..I 'ORRESULT Q            ; Quit if there's a locking problem.
 ..K Y,X
 ..S DIC("P")=$P(^DD(100.21,2,0),"^",2)
 ..S DIC(0)="LM"
 ..S DA=DUZ
 ..S DA(1)=ORTEAM
 ..S DLAYGO=100.212
 ..S X=$P($G(^VA(200,DUZ,0)),"^",1)
 ..S DIC="^OR(100.21,"_DA(1)_",1,"
 ..D ^DIC
 ..K DIC,DLAYGO
 ..L -^OR(100.21,ORTEAM)    ; Clean up file lock.
 ..Q
 .;
 .K ^TMP("ORLPAR",$J)       ; Cleanup each time through.
 ;
 K ^TMP("ORLPAR",$J)        ; Cleanup at end to be sure.
 K DIRUT,DTOUT,DUOUT        ; Cleanup error variables.
 Q
 ;
ARLOCK(ORTEST) ; Handle locking of select Team List before editing.
 ;
 ; Variable used:
 ;
 ;    ORTEST = Result of locking call.
 ;
 L +^OR(100.21,ORTEAM):5
 S ORTEST=$TEST
 I 'ORTEST W !,"Another user is editing this team.",!
 Q ORTEST
 ;
