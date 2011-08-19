MAGXCVH ;WOIFO/SEB,MLH - Image File Conversion Help ; 12 Aug 2003  5:04 PM
 ;;3.0;IMAGING;**17,25**;Sep 4, 2003
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ; Display additional help text.  Called from MAGSCNVL.
HELP(PROMPT) N FIELD
 S FIELD=$P("package^class^type^procedure/event^specialty^origin",U,PROMPT)
 W !,"Enter a valid ",FIELD," or '@' to delete the current value, '^P' to skip"
 W !,"to the package, '^C' to skip to the class, '^T' to skip to the type, '^E'"
 W !,"to skip to the procedure/event, '^S' to skip to the specialty, or '^' to exit."
 W !
 Q
 ;
 ; Verify deletion.  Called from MAGSCNVE.
DELETE() ;
 K DIR
 S DIR(0)="Y"
 S DIR("A")="Do you want to delete the current value",DIR("B")="NO"
 D ^DIR
 Q Y
