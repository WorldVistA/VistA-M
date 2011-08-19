ORWPFSS0 ;SCL/GDU - CPRS PFSS Parameter Maintainance;[02/24/05 13:13] ;2/28/05  09:51
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215**;Dec 17, 1997
 ;Routine to maintain the ORWPFSS ACTIVE Parameter. This parameter will
 ;determine if CPRS GUI will perform the activities required for PFSS.
 ;
 ;Local Variables
 ;  DIR   - Input array varaible for ^DIR
 ;  DTOUT - Output variable for ^DIR, timeout indicator
 ;  DUOUT - Output variable for ^DIR, up arrow indicator
 ;  EC    - Error Code
 ;  PC    - Parameter Check
 ;  PFSS  - Output variable for $$GET^XPAR, 
 ;          Current value of PFSS parameter
 ;          1 for active
 ;          0 for inactive
 ;          Null for not on file
 ;  OREM  - Output variable for ^XPAR, error code and text
 ;  Y     - Output variable for ^DIR, contains processed value of user
 ;          input.
 ;
 ;External references
 ;  HOME^%ZIS   DBIA 10086, User console device set up
 ;  ^DIR        DBIA 10026, FileMan user input reader
 ;  $$GET^XPAR  DBIA 2263, Get current value of parameter
 ;  ADD^XPAR    DBIA 2263, Add new parameter
 ;  GET^XPAR    DBIA 2263, Change current value of parameter
 ;
EN ;Routine entry point
 N DIR,DTOUT,DUOUT,EC,PC,PFSS,OREM,Y
 D:'$D(IO)!('$D(IOF)) HOME^%ZIS
 W @IOF,$P($T(SH),";",3)
 ; SUGGEST REPLACING PATCH CHECK WITH +$$SWSTAT^IBBAPI() CHECK
 ;Check for required patch, if missing alert user and quit
 ;Next 2 lines remarked out, to be implemented with release of 215
 ;To be removed with release of 228
 ;S PC=+$$PATCH^XPDUTL("OR*3.0*228")
 ;I PC=0 S EC=1 D ERTRAP Q
 ;Get current value of ORWPFSS ACTIVE parameter
 S PFSS=$$GET^XPAR("SYS","ORWPFSS ACTIVE",1,"I")
 ;If it does not exist add and default to inactive
 ;If error occurs during parameter add, alert user and quit
 I PFSS="" D  I OREM>0 Q
 . D ADD^XPAR("SYS","ORWPFSS ACTIVE",1,0,.OREM)
 . I OREM>0 S EC=2 D ERTRAP
 S DIR(0)="Y"
 I PFSS=1 D
 . ;If active present option to set PFSS to inactive
 . ;Confirm the user's selection
 . ;If error occurs during deactivation, alert user
 . W !!,$P($T(AM0),";",3),!,$P($T(AM1),";",3)
 . D ^DIR I Y=0!($D(DTOUT))!($D(DUOUT)) Q
 . W !!,$P($T(AM2),";",3)
 . D ^DIR I Y=0!($D(DTOUT))!($D(DUOUT)) Q
 . D CHG^XPAR("SYS","ORWPFSS ACTIVE",1,0,.OREM)
 . I OREM>0 S EC=4 D ERTRAP Q
 . W !!,$P($T(AM3),";",3)
 . S DIR(0)="E" D ^DIR
 E  D
 . ;If inactive present option to set active
 . ;Confirm the user's selection
 . ;If errors occurs during activation, alert user
 . W !!,$P($T(IM0),";",3),!,$P($T(IM1),";",3)
 . D ^DIR I Y=0!($D(DTOUT))!($D(DUOUT)) Q
 . W !!,$P($T(IM2),";",3)
 . D ^DIR I Y=0!($D(DTOUT))!($D(DUOUT)) Q
 . D CHG^XPAR("SYS","ORWPFSS ACTIVE",1,1,.OREM)
 . I OREM>0 S EC=3 D ERTRAP Q
 . W !!,$P($T(IM3),";",3)
 . S DIR(0)="E" D ^DIR
 Q
 ;
ERTRAP ;Error Trap, processes various errors and alerts the user
 I EC=1 W !!,$P($T(EM1),";",3),!,$P($T(EM2),";",3)
 I EC=2 W !!,$P($T(EM3),";",3)
 I EC=3 W !!,$P($T(EM4),";",3)
 I EC=4 W !!,$P($T(EM5),";",3)
 S DIR(0)="E"
 I EC>1 W !!,$P($T(EM6),";",3)," ",$P(OREM,U)," ",$P($T(EM7),";",3)," ",$P(OREM,U,2)
 W !!,$P($T(EM8),";",3)
 D ^DIR
 Q
 ;
 ;USER INTERFACE TEXT
EM1 ;;Required patch OR*3.0*228 is not installed. It must be installed
EM2 ;;before this option can be run.
EM3 ;;Error adding parameter ORWPFSS ACTIVE
EM4 ;;Error activating parameter ORWPFSS ACTIVE
EM5 ;;Error deactivating parameter ORWPFSS ACTIVE
EM6 ;;Error code:
EM7 ;;Error Description:
EM8 ;;Please report this problem to your support staff.
SH ;;CPRS - Activate/Deactivate PFSS
IM0 ;;PFSS for CPRS is >> INACTIVE <<
IM1 ;;Do you want to activate PFSS for CPRS?
IM2 ;;Are you sure you want to activate PFSS for CPRS?
IM3 ;;PFSS is now active for CPRS.
AM0 ;;PFSS for CPRS is >> ACTIVE <<
AM1 ;;Do you want to deactivate PFSS for CPRS?
AM2 ;;Are you sure you want to deactivate PFSS for CPRS?
AM3 ;;PFSS is now inactive for CPRS.
