PRSNRIA ;WOIFO/DAM - Nurse POC Report;9/3/2009
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
DEP ; Entry point for Data Entry Personnel
 N PRSIEN,GROUP
 D ACCESS^PRSNUT02(.GROUP,"E",DT)
 I $P($G(GROUP(0)),U,2)="E" D  Q
 .W !,$P(GROUP(0),U,3)
 D MAIN
 Q
 ;
DAP ; Entry point for Data Approval Personnel
 N PRSIEN,GROUP
 D ACCESS^PRSNUT02(.GROUP,"A",DT)
 I $P($G(GROUP(0)),U,2)="E" D  Q
 .W !,$P(GROUP(0),U,3)
 D MAIN
 QUIT
 ;
COORD ;Entry point for VANOD Coordinator
 ; Coordinator has no access limits so let them pick any nurse
 N PRSIEN,DIC,X,Y,DTOUT,DUOUT
 S DIC="^PRSPC(",DIC(0)="AEQMZ",DIC("S")="I $$ISNURSE^PRSNUT01(Y)"
 D ^DIC
 Q:Y'>0!$D(DTOUT)!$D(DUOUT)
 S PRSIEN=$P(Y,U)
 D MAIN
 QUIT
 ;
NURSE ;Entry point for VANOD Nurse
 N PRSIEN,SSN
 S PRSIEN="",SSN=$P($G(^VA(200,DUZ,1)),"^",9)
 I SSN'="" S PRSIEN=$O(^PRSPC("SSN",SSN,0))
 I 'PRSIEN W !!,*7,"Your SSN was not found in both the New Person & Employee File!" Q
 ;
 ; if not in 450 as a nurse then explain and quit
 I +$$ISNURSE^PRSNUT01(PRSIEN)'>0 D NOTNRSDX^PRSNRMM1  Q
 ;
 D MAIN
 Q
 ;
MAIN ; loop through Location or t&l 
 ; 
 ; pick a NURSE from the group or the T&L unit
 ;  
 ;  ien value from group variable); If coordinator has already picked a 
 ;  nurse, or nurse is doing a lookup on ;self based on SSN and DUZ, then 
 ;PRSIEN is set and the line of code below will not be executed.
 ;
 N VALUE
 I $G(PRSIEN)'>0 D
 .  S VALUE=+GROUP($O(GROUP(0)))
 .  Q:VALUE'>0
 .  S PRSIEN=+$$PICKNURS^PRSNUT03($P(GROUP(0),U,2),VALUE)
 ;
 N POCD,PPIEN,PRSNDAY,DAYNODE,RANGE,BEG,END,EXTBEG,EXTEND
 ;
 ; User is prompted for a date or date range 
 ;
 S RANGE=$$POCRANGE^PRSNUT01()
 ; QUIT HERE IF RANGE=0 
 Q:+RANGE'>0
 ;
 S BEG=$P($G(RANGE),U)
 S END=$P($G(RANGE),U,2)
 ;
 ;
 S PPIEN=+$G(^PRST(458,"AD",BEG))
 ;
 ; If a record exists for the nurse and the date range, then the 
 ; Individual Activity report is displayed
 ; If record doesn't exist for the date range selected, then a 
 ; message is displayed, "NO RECORDS EXIST FOR THAT DATE RANGE",
 ; and the user is re-prompted for a date.
 ;
 ;call to generate and display report for individual activity
 N %ZIS,POP,IOP
 S %ZIS="MQ"
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D
 . K IO("Q")
 . N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 . S ZTDESC="NURSE POINT OF CARE DAILY ACTIVITY REPORT"
 . S ZTRTN="REPORT^PRSNRIA"
 . S ZTSAVE("PRSIEN")=""
 . S ZTSAVE("BEG")=""
 . S ZTSAVE("END")=""
 . D ^%ZTLOAD
 . I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" Queued."
 E  D
 . D REPORT
 Q
 ;
REPORT ;
 ;
 U IO
 D POCDSPLY^PRSNRUT0(PRSIEN,BEG,END)
 W !!,"End of Report"
 D ^%ZISC
 Q
