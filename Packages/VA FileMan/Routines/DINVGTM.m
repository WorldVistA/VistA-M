DINVGTM ; VEN/SMH - GT.M (VMS) Specific Functions; 30NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
DEL(RN) ; Delete Routine; Fileman Entry Point.
 ; Input: Routine Name by Value
 ; Output: None
 ; Routine is NOT SAC Compliant due to use of GT.M specific IO parameters
LOOP ; Loop entry point
 N %ZR ; Output from GT.M %RSEL
 N %S,%O ; Source directory, object directory 
 ; 
 ; NB: For future works, %RSEL support * syntax to get a bunch of routines
 D SILENT^%RSEL(RN,"SRC") S %S=$G(%ZR(RN)) ; Source Directory
 D SILENT^%RSEL(RN,"OBJ") S %O=$G(%ZR(RN)) ; Object Directory
 ;
 I '$L(%S)&('$L(%O)) QUIT
 ;
 S RN=$TR(RN,"%","_") ; change % to _ in routine name
 ;
 N $ET,$ES S $ET="Q:$ES  S $EC="""" Q" ; In case somebody else deletes this; we don't crash
 ;
 I $L(%S) D  ; If source routine present?
 . O %S_RN_".m":(readonly):0
 . E  Q
 . C %S_RN_".m":(delete)
 ;
 I $L(%O) D  ; If object code present?
 . O %O_RN_".obj":(readonly):0
 . E  Q
 . C %O_RN_".obj":(delete)
 G LOOP
