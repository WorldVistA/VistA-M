SCRPU4 ;ALB/CMM - PRINT PC TEAM/PRACT/ATTEND ; 29 Jun 99  04:11PM
 ;;5.3;Scheduling;**41,177**;AUG 13, 1993
 ;
PCMM(DFN,ADATE,PRINT) ; display primary care team, primary care provider and team phone for patient DFN on date ADATE
 ;DFN - patient ien
 ;ADATE - date to find primary care team, provider and team phone (default = today)
 ;PRINT - default 1 to print data; otherwise don't print
 ;
 I '$D(PRINT) S PRINT=1
 I PRINT'=""&(PRINT'=1) Q  ;don't print data
 I '$D(ADATE) S ADATE=DT
 I ADATE="" S ADATE=DT
 I '$D(DFN) Q
 D TDATA^SDPPTEM(DFN,"",ADATE,"P")
 Q
