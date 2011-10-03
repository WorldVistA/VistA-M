EASXDRUT ;ALB/AEG - Duplicate Patient Relations Utilities ;7-12-02
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**10**;Mar 15, 2002
 ;
TEXT ; Print Screen Text upon Entry into the option.
 N TEX,I F I=1:1 S TEX=$P($T(DESC+I),";;",2) Q:TEX="QUIT"  D
 .I I'>2 W !,?17,TEX
 .E  W !,?3,TEX
 K I,X
 Q
 ;
DESC ; Text to be printed upon entry into the option.
 ;;*** DUPLICATE PATIENT RELATIONS REPORT ***
 ;;
 ;;This report will search the PATIENT RELATION file (#408.12) to identify
 ;;those entries where potential duplicates exist.
 ;;
 ;;This report is designed for an 80 column print device or a terminal
 ;;using the HOME device.  The report may take a long time to generate,
 ;;accordingly, it is recommended that it be queued to an 80 column
 ;;print device.  The P-MESSAGE device is NOT recommended for use, nor
 ;;should the output format be specified at the device prompt in order to 
 ;;do a screen capture.
 ;;QUIT
 ;
SETUP ; Setup output variables based on terminal type.
 S COL1=0
 S COL2=11
 S COL3=38
 S COL4=48
 S COL5=58
 S COL6=63
 S COL7=74
 S $P(EQL,"=",IOM)=""
 S $P(DAL,"-",IOM)=""
 Q
 ;
PAUSE ;
 N IY,ZZ
 S ZZ=$Y
 I $E(IOST,1,2)="C-" D
 .F IY=ZZ:1:(IOSL-4) W !
 .K DIR,DIRUT
 .S DIR(0)="E"
 .D ^DIR
 .;W @IOF
 Q
