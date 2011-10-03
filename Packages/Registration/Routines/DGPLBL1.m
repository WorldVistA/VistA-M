DGPLBL1 ;ALB/RPM - PATIENT INFORMATION LABEL UTILITIES ; 04/08/04
 ;;5.3;Registration;**571**;Aug 13, 1993
 ;
 ; This routine contains procedures that will define either a
 ; vertical or horizontal format form for printing patient labels
 ; on an Intermec label printer.  The formatting is done using
 ; Intermec Programming Language (IPL).  Use the appropriate entry
 ; point in the OPEN EXECUTE (#6) field of the TERMINAL TYPE (#3.2)
 ; file.
 ;
 ;     Vertical format: VINTERM^DGPLBL1
 ;   Horizontal format: HINTERM^DGPLBL1
 ;
 Q  ;no direct entry
 ;
VINTERM ;vertical label format loader for Intermec Label Printers
 ; This procedure programs the Patient Information label in vertical
 ; format for an Intermec label printer and stores it as format 2.
 ; This procedure must defined in the OPEN EXECUTE field of the
 ; TERMINAL TYPE (#3.2) file for the Intermec printer. 
 ;
 ;        Example:  OPEN EXECUTE: D VINTERM^DGPLBL1
 ; 
 U IO
 W "<STX><ESC>C<ETX>",!  ;operate in "advanced" mode
 W "<STX><ESC>P<ETX>",!  ;enter programming mode
 W "<STX>E2;F2;<ETX>",!  ;erase format 2;create format 2
 W "<STX>H0;o10,70;d0,40;f0;c25;k10;<ETX>",!  ;name field
 W "<STX>H1;o10,110;d0,40;f0;c25;k10;<ETX>",!  ;SSN field
 W "<STX>H2;o10,150;d0,40;f0;c25;k10;<ETX>",!  ;DOB field
 W "<STX>H3;o10,190;d0,40;f0;c25;k10;<ETX>",!  ;inpatient location
 Q
 ;
HINTERM ;horizontal label format loader for Intermec Label Printers
 ; This procedure programs the Patient Information label in horizontal
 ; format for an Intermec label printer and stores it as format 2.
 ; This procedure must defined in the OPEN EXECUTE field of the
 ; TERMINAL TYPE (#3.2) file for the Intermec printer. 
 ;
 ;        Example:  OPEN EXECUTE: D HINTERM^DGPLBL1
 ; 
 U IO
 W "<STX><ESC>C<ETX>",!  ;operate in "advanced" mode
 W "<STX><ESC>P<ETX>",!  ;enter programming mode
 W "<STX>E2;F2;<ETX>",!  ;erase format 2;create format 2
 W "<STX>H0;o210,51;d0,40;f3;c25;k10;<ETX>",!  ;name field
 W "<STX>H1;o170,51;d0,40;f3;c25;k10;<ETX>",!  ;SSN field
 W "<STX>H2;o130,51;d0,40;f3;c25;k10;<ETX>",!  ;DOB field
 W "<STX>H3;o90,51;d0,40;f3;c25;k10;<ETX>",!  ;inpatient location
 Q
