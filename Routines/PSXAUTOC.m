PSXAUTOC ;BIR/WPB/PDW-Routine to Automatically Run CMOP CS Suspense ;14 DEC 2001
 ;;2.0;CMOP;**23,28,36,41**;11 Apr 97
 ;This routine will be called from a menu option and will allow
 ;the user to start or change auto-processing. The user must hold
 ;the PSXAUTOX security key.
START ;
 S PSXCS=1
 G START^PSXAUTO
EN ;the PSO* variables must be set in order to run the routine.These
 ;are not set when the job is kicked off automatically each day.
 S PSXCS=1
 G EN^PSXAUTO
