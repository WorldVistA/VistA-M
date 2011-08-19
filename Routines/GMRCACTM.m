GMRCACTM ; SLC/DLT,DCM,JFR - Set action menus  ;10/17/01 22:41
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4,11,18,15,17,22,55**;DEC 27, 1997;Build 4
 ;
 ; This routine invokes IA #2425
 ;
CPRS(GMRCPM,GUI) ;Entry point for setting menu actions for CPRS user
 ;Input:
 ;  GMRCPM=a list of File 123 IEN's to check for menu actions.
 ;       Passed in as '300;303;295;309;313'
 ;  GUI =1 if coming from the GUI; return field name in ORFLG also
 ;Output:
 ;  ORFLG(ien)= A^B^C^D^E^F^G^H where:
 ;    Ien = internal entry of record in file 123
 ;    A = a number representing one of the following:
 ;       1 - user has only review capabilities
 ;       2 - user has full update capabilities
 ;       3 - user has administrative update capabilities
 ;       4 - user has full update and admin user capabilities
 ;       5 - user has full update capabilities via unrestricted access
 ;    B = field in file 123.5 (REQUEST SERVICES) that gave the user 
 ;        update authority (ex.  Update user w/o Notification)
 ;    C = Service in file 123.5 (REQUEST SERVICES) that gave the user
 ;        update authority (ex. CARDIOLOGY,NEUROLOGY)
 ;    D = contains a 1 if user is allowed to associate medicine results
 ;        with a consult procedure request
 ;    F = contain a 1 if user can disassociate a medicine result that was
 ;        incorrectly associated with a consult procedure request
 ;    G = contains a 1 if user is allowed to EDIT and RESUBMIT a canceled
 ;        request
 ;    H = 0-4 depending on actions allowed on a Clin. Proc. request
 ;
 I '$L(GMRCPM) S ORFLG=1 Q
 K ORFLG
 N I,GMRCSS,GMRCIEN
 F I=1:1 S ORFLG=1,GMRCIEN=$P(GMRCPM,";",I) Q:GMRCIEN=""  D
 .S ORFLG(GMRCIEN)=1 ;set default answer to read only
 .I $P($G(^GMR(123,GMRCIEN,12)),U,5)="P" D  Q  ;IFC placer so only ED/RES
 .. ;can user edit/resubmit
 .. I $$VALPROV^GMRCEDIT(GMRCIEN) S $P(ORFLG(GMRCIEN),U,6)=1
 .S GMRCSS=+$P($G(^GMR(123,+GMRCIEN,0)),"^",5)
 .Q:'+$G(GMRCSS)
 .;when service is defined, check for service user 
 .D EN
 .S ORFLG(GMRCIEN)=ORFLG
 . ;what actions to allow if a Clincial Procedure
 . S $P(ORFLG(GMRCIEN),U,7)=$$CPACTM^GMRCCP(GMRCIEN)
 .I ORFLG>1 D
 .. ;can DUZ associate med results?  only if not a CP!
 .. N P4
 .. S P4=$S(+$P(ORFLG(GMRCIEN),U,7):0,1:$$CANDOMED^GMRCGUIU(GMRCIEN))
 .. S $P(ORFLG(GMRCIEN),U,4)=P4
 . ;can DUZ disassociate a med result?
 . S $P(ORFLG(GMRCIEN),U,5)=+$$REMUSR^GMRCDIS(GMRCIEN)
 . ;can user edit/resubmit
 . I $$VALPROV^GMRCEDIT(GMRCIEN) S $P(ORFLG(GMRCIEN),U,6)=1
 . Q
 Q
 ;
EN ;Set GMRCACTM with appropriate menu of actions based on user
 ;If ORFLG is DEFINED then GMRCACTM is returned as a set of codes:
 ;    1 = GMRCACTM USER REVIEW SCREEN - simple actions
 ;    2 = GMRCACTM SERVICE ACTION menu  - all actions possible for
 ;        clinical user in service
 ;    3 =  administrative user
 ; initialize GMRCACTM for read only
 S GMRCACTM="GMRCACTM USER REVIEW SCREEN"
 ; if service and entry aren't defined, assume read only access
 I '$D(XQADATA),$S('+$G(GMRCSS):1,1:0) D  Q
 .I $D(ORFLG) S ORFLG(GMRCIEN)=1 K GMRCACTM
 .Q
 ;
 ;Get the users service update level
 N GMRCFLG
 S GMRCFLG=$$VALID^GMRCAU(+GMRCSS,"",,$G(GUI))
 S:+GMRCFLG=1 GMRCFLG=$S(($D(ORFLG)&($$PATCH^XPDUTL("OR*3.0*243"))):"5^"_$P(GMRCFLG,U,2,9999),1:"2^"_$P(GMRCFLG,U,2,9999))
 ;
 ;If ORFLG is all that should be returned, than set and exit
 I $D(ORFLG) D  Q
 . K GMRCACTM
 . I GMRCFLG=0 S ORFLG=1 Q
 . S ORFLG=GMRCFLG Q
 ;
 ; If GMRCSS=and IFC sending service, only allow review screen
 I $D(^GMR(123.5,+GMRCSS,"IFC")),$P(^("IFC"),U) S GMRCFLG=0
 ;
 ;Process the GMRCFLG value to get the GMRCACTM defined.
 I GMRCFLG>0 D  Q
 . S GMRCACTM="GMRCACTM SERVICE ACTION MENU"
 Q
