DGPFDIV ;ALB/KCL - PRF ENABLE MEDICAL CENTER DIVISIONS ; 9/19/05 4:03pm
 ;;5.3;Registration;**650**;Aug 13, 1993;Build 3
 ;
 ;No direct entry
 QUIT
 ;
 ;
EN ;Main entry point for DGPF ENABLE DIVISIONS option.
 ;
 ;  Input: none
 ; Output: none
 ;
 ;The following User actions are available:
 ;  Action = 0 = Disable Medical Center Divisions
 ;  Action = 1 = Enable Medical Center Divisions
 ;  Action = 2 = View Medical Center Divisions
 ;
 N DGDIV   ;selected divisions array
 N DGQUIT  ;user selected action
 N DGSEL   ;user selected action array
 ;
 W !
 W !,"This option allows multi-divisional facilities to enable, disable, and view"
 W !,"individual medical center divisions as patient record flag assignment owners."
 ;
 ;loop actions - quit if none selected
 S DGQUIT=0
 F  D  Q:DGQUIT<1
 . ;
 . ;prompt user for action
 . K DGSEL,DGDIV
 . S DGQUIT=$$ASKACT(.DGSEL)
 . Q:DGQUIT<1
 . ;
 . ;if view action
 . I +$G(DGSEL("ACTION"))=2 D VIEW^DGPFDIV1 Q
 . ;
 . ;prompt user for divisions
 . S DGQUIT=$$ASKDIV(.DGSEL,.DGDIV)
 . ;
 . ;check to keep looping or Exit the For loop if result less than 0
 . I DGQUIT<1 S DGQUIT=$S(DGQUIT<0:DGQUIT,1:1) Q
 . ;
 . ;if enable/disable action
 . I +$G(DGSEL("ACTION"))<2 D SET(.DGSEL,.DGDIV)
 . ;
 ;
 Q
 ;
SET(DGSEL,DGDIV) ;enable/disable medical center divisions
 ;This procedure is used to enable or disable user selected medical
 ;center divisions.
 ;
 ;  Input:
 ;   DGSEL - (required) array containing the user selected action
 ;           (pass by reference)
 ;            Ex: DGSEL("ACTION")=0^disable
 ;                DGSEL("ACTION")=1^enable
 ;   DGDIV - (required) array of selected MEDICAL CENTER DIVISIONs
 ;           (passed by reference) subscripted by ien.
 ;             Example: DGDIV(500)=""
 ;
 ; Output: none
 ;
 N DGACT    ;user selected action
 N DGANS    ;$$ANSWER^DGPFUT result
 N DGEXIT   ;for loop exit flag
 N DGIEN    ;medical center division ien
 N DGIENS   ;FM iens
 N DGTXT    ;user prompt
 ;
 ;quit if not a valid action and division array not setup
 S DGACT=$G(DGSEL("ACTION"))
 I +DGACT'=0,(+DGACT'=1),($O(DGDIV(0))="") Q
 ;
 W !!,"Preparing to '"_$P(DGACT,U,2)_"' the selected medical center divisions as"
 W !,"patient record flag assignment owners...",!
 ;
 ;loop thru selected divisions and prompt user
 S DGIEN=0
 F  S DGIEN=$O(DGDIV(DGIEN)) Q:'$G(DGIEN)!$G(DGEXIT)  D
 . S DGIENS=DGIEN_","
 . S DGTXT="Ok to "_$P(DGACT,U,2)_" division: "
 . S DGANS=$$ANSWER^DGPFUT(DGTXT_$$GET1^DIQ(40.8,DGIENS,.01),"YES","Y")
 . I DGANS=0 W !?2,">>> "_$$EZBLD^DIALOG(261131)_".",! Q
 . I DGANS<0 S DGEXIT=1 Q
 . ;
 . ;attempt to lock record before update
 . I '$$LOCK^DGPFDIV1(DGIEN) D  Q
 . . W !?2,">>> "_$$EZBLD^DIALOG(261131)_": Record is currently locked.",!
 . ;
 . ;update record
 . I $$STODIV^DGPFDIV1(DGIEN,+DGACT) W !?2,">>> Medical center division has been "_$$EXTERNAL^DILFD(40.8,26.01,"",+DGACT),!
 . E  W !?2,">>> "_$$EZBLD^DIALOG(261131)_"Unable to file changes.",!
 . ;
 . ;unlock record after update
 . D UNLOCK^DGPFDIV1(DGIEN)
 ;
 Q
 ;
ASKACT(DGSEL) ;select division action
 ;This function is used to ask a user to select an action.
 ;
 ;  Input: none
 ;
 ; Output:
 ;   Function value - returns 1 on success (action selected), or
 ;                            0 if no action selected, or
 ;                           -1 if user up-arrows, double up-arrows or
 ;                              the ^DIR read times out.
 ;   DGSEL - on success, local array containing selected action
 ;           (passed by reference)  Ex: DGSEL("ACTION")=0^disable
 ;                                      DGSEL("ACTION")=1^enable
 ;                                      DGSEL("ACTION")=2^view
 ;
 N DIR,DIROUT,DIRUT,DUOUT,DTOUT,X,Y  ;^DIR reader vars
 N DGRSLT  ;function result
 ;
 S DGRSLT=0
 ;
 S DIR(0)="SO^E:Enable Medical Center Divisions;D:Disable Medical Center Divisions;V:View Medical Center Divisions"
 S DIR("A")="Select action"
 S DIR("?",1)="Enter 'Enable' if you would like to select medical center divisions as"
 S DIR("?",2)="being eligible for patient record flag assignment ownership."
 S DIR("?",3)=""
 S DIR("?",4)="Enter 'Disable' if you would like to change a division that is already"
 S DIR("?",5)="eligible for patient record flag assignment ownership to ineligible."
 S DIR("?",6)="Disabling a division will only be allowed if there are no active"
 S DIR("?",7)="assignments associated with the division."
 S DIR("?",8)=""
 S DIR("?")="Enter 'View' if you would like to view all medical center divisions."
 ;
 D ^DIR K DIR
 ;
 D:'$D(DIRUT)  ;setup user selected action
 . S DGSEL("ACTION")=$S($G(Y)="E":"1^enable",$G(Y)="D":"0^disable",1:"2^view")
 . S DGRSLT=1
 ;
 Q $S($D(DUOUT):-1,$D(DTOUT):-1,$D(DIROUT):-1,1:DGRSLT)
 ;
ASKDIV(DGSEL,DGDIV) ;select medical center divisions
 ;This function is used to ask a user to select the Medical Center
 ;Divisions that should be enabled or disabled as a PRF assignment owner.
 ;
 ;  Input:
 ;   DGSEL - (required) array containing the user selected action
 ;           (pass by reference)
 ;
 ; Output:
 ;   Function value - returns 1 on success (divisions selected), or
 ;                    returns 0 on failure (divisions not selected)
 ;   DGDIV - on success, the local array of selected MEDICAL CENTER
 ;           DIVISIONs (passed by reference) subscripted by ien.
 ;             Example: DGDIV(500)=""
 ;
 N DIR,DIROUT,DIRUT,DUOUT,DTOUT,X,Y ;reader vars
 N DGACT   ;user selected action
 N DGEXIT  ;for loop exit flag
 N DGRSLT  ;function result
 ;
 S (DGRSLT,DGEXIT)=0
 ;
 ;quit if not a valid action
 S DGACT=$G(DGSEL("ACTION"))
 I +DGACT'=0,(+DGACT'=1) Q 0
 ;
 W !!,"Enter each medical center division that you would like to "_$P(DGACT,U,2)_".",!
 ;
 ;select medical center divisions
 S DIR(0)="PO^40.8:AEM"
 S DIR("A")="Select medical center division"
 S DIR("S")="I $$SCRNSEL^DGPFDD(+Y,+DGACT),$$SCRNDIV^DGPFDD(+Y,+DGACT)"
 S DIR("?",1)="Enter the medical center division that you would like to "_$S(+DGACT:"enable",1:"disable")
 S DIR("?")="as a patient record flag assignment owner."
 ;
 K DGDIV
 ;select divisions loop
 F  D  Q:$D(DIRUT)
 . ;
 . D ^DIR
 . ;
 . ;exit loop on timeout, up-arrow, or null
 . Q:$D(DIRUT)
 . ;
 . ;place selected division ien in array
 . S DGDIV(+Y)=""
 ;
 K DIR
 I +$O(DGDIV(0)) S DGRSLT=1
 E  S DGRSLT=$S($D(DUOUT):-1,$D(DTOUT):-1,$D(DIROUT):-1,1:DGRSLT)
 ;
 Q DGRSLT
