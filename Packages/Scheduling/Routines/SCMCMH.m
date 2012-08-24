SCMCMH ;BP/DMR - PCMM MHTC GUI FILTER; 4 JAN 11
 ;;5.3;Scheduling;**575**;AUG 13, 1993;Build 28
 ;
 ;This is a PCMM GUI filter to screen Mental Health Treatment 
 ;Coordinator. Patients should only have one MHTC.
 ;
TP(DFN,YY) ;Get patient MHTC info.
 ;
 ;Input  - DFN and YY = Team IEN from file 404.57.
 ;Output - 0 or 1, If 0 display don't display MHTC position.
 ;                 If 1 display MHTC position.
 ;
 I '$G(YY) Q 0
 I '$G(DFN) Q 0
 ;
 I $$GET1^DIQ(404.57,YY,.03)'["(MHTC)" Q 1
 ;
 S MH=""
 S MH=$$START^SCMCMHTC(DFN)
 I MH'="" D EXIT Q 0
 D EXIT Q 1
 ;
EXIT ;
 K MH
