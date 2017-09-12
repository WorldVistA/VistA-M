SD53I603 ;ALB/ART - SD*5.3*603 Pre Install ;06/30/2014
 ;;5.3;Scheduling;**603**;Aug 13, 1993;Build 79
 ;
 QUIT
 ;
EN ;Main Entry Point
 ;Delete the global for the Standard Position file.
 ;A new file will be loaded with some renamed positions and new entries.
 ;
 KILL ^SD(403.46)
 SET ^SD(403.46,0)="STANDARD POSITION^403.46^0^0"
 ;
 QUIT
 ;
