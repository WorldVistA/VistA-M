PXRMEDIT ; SLC/PKR - Clinical Reminder edit driver. ;04/24/2009
 ;;2.0;CLINICAL REMINDERS;**6,12**;Feb 04, 2005;Build 73
 ;
EDIT(ROOT,IENN) ;Call the appropriate edit routine.
 ;Reminder location list
 I ROOT="^PXRMD(810.9," D EDIT^PXRMLLED(ROOT,IENN) Q
 ;
 ;Taxonomy
 I ROOT="^PXD(811.2," D EDIT^PXRMTEDT(ROOT,IENN) Q
 ;
 ;Reminder term
 I ROOT="^PXRMD(811.5," D EDIT^PXRMTMED(ROOT,IENN) Q
 ;
 ;Reminder definition
 I ROOT="^PXD(811.9," D
 .;Build list of finding types for finding edit
 . N DEF,DEF1,DEF2 D DEF^PXRMRUTL("811.902",.DEF,.DEF1,.DEF2)
 .;Edit reminder
 . D ALL^PXRMREDT(ROOT,IENN,.DEF1)
 Q
 ;
