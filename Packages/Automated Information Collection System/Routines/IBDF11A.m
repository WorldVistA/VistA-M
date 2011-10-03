IBDF11A ;ALB/CJM - ENCOUNTER FORM - (print manager setup - INFORMATION) ;April 20,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
INFO ;N I,LINE,DIR
 F I=0:1 S LINE=$P($T(TEXT+I),";;",2) Q:LINE=""  W !,LINE I $Y>(IOSL-4) S DIR(0)="E" D ^DIR W @IOF Q:'Y
 Q
TEXT ;;Care must be taken when defining reports to the Print Manager. Please
 ;;follow these rules:
 ;; 
 ;;  1) Entry points must involve no user interaction.
 ;;  2) The device must not be changed or closed.
 ;;  3) Local variables should be the same on exit as on entry.
 ;; 
 ;;THESE VARIABLES ARE AVAILABLE:
 ;;  
 ;;  DFN = ien of patient in the PATIENT file
 ;;  IBCLINIC = ien of clinic in the HOSPTIAL LOCATION file
 ;;  IBAPPT   = appointment date/time in FM format
 ;;  
 ;;FEATURES OF INTEREST, IN THE ORDER PERFORMED BY THE PRINT MANAGER:
 ;;  
 ;;  AVAILABLE?: The Print Manager will not print the report unless
 ;;  this is set to YES.
 ;; 
 ;;  REQUIRED VARIABLES: You can define a list of variables that should
 ;;  be defined. The Print Manager won't call the entry point unless
 ;;  they are defined.
 ;; 
 ;;  PROTECTED VARIABLES: You can define a list of variables (without 
 ;;  subscripts) that should be NEWed.
 ;; 
 ;;  ENTRY ACTION: Mumps code that should be Xecuted before calling
 ;;  the entry point.
 ;; 
 ;;  EXIT ACTION: Mumps code that should be Xecuted after calling
 ;;  the  entry point.
 ;; 
 ;;EXAMPLE: Supposing the entry point kills DFN. You could do this:
 ;;  
 ;;   REQUIRED VARIABLE: DFN
 ;;   PROTECTED VARIABLE: IBDFN
 ;;   ENTRY ACTION: S IBDFN=DFN
 ;;   EXIT ACTION: S DFN=IBDFN
 ;;  
 ;;
