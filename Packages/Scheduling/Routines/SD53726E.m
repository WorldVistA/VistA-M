SD53726E ;MNT/BJR - ENVIRONMENT CHECK WITH PRE-INIT CODE ;04/5/19 5:52pm
 ;;5.3;Scheduling;**726**;Aug 13, 1993;Build 36
 ;
 Q
 ;
 ;Calls to %ZIS supported by ICR #10086
 ;Call to BMES^XPDUTL supported by ICR #10141
 ;
POS1 ; Ask device to print the Remap Clinic Report
 K DIR
 S %ZIS="QNM0" D ^%ZIS I POP D BMES^XPDUTL("This is a required response.  Select a printer.") G POS1
 S XPDQUES("POS1")=ION
 D HOME^%ZIS
 Q
