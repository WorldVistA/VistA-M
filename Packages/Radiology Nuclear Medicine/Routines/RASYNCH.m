RASYNCH ;HISC/GJC - synch orders with studies ; Mar 23, 2023@12:40:15
 ;;5.0;Radiology/Nuclear Medicine;**192,198**;Mar 16, 1998;Build 1
 ;
 ;Routine              File     IA          Type
 ;----------------------------------------------
 ;                     100      6475        (C)
 ;
 Q
 ;
EN ; entry point for option
 ;
 ;new system level variables do not kill them!
 N RAI,RAINDIE,RAQS,RAX,RAXIT S RAQS=0
 I '$D(RAMDIV)!('$D(RAMDV))!('$D(RAMLC))!('$D(RAIMGTY)) D
 .D SET^RAPSET1 S RAINDIE="" ;option called as stand alone
 .Q
 I $D(XQUIT) K XQUIT Q
 Q:'$D(RAIMGTY)#2  S RAXIT=0
 ;
 ;// main //
 ;ask the user for the case number, find accession, synch
 F  D PAT Q:RAXIT="^"
 QUIT
 ;// end main //
 ;
 ;// begin PAT //
PAT ;get patient DFN move forward
 ; Note: if user timed out or entered null var 'X'
 ; is set to a caret
 K ^TMP($J,"RASYNCH")
 S DIC(0)="AEMQ" D ^RADPA
 I +Y<0 S RAXIT="^"
 I RAXIT="^" D EXIT QUIT
 S RADFN=+Y
 ;
 D EN^RASYNCHLU ;RAQS is initialized, updated but not killed in RASYNCHLU
 I RAQS=0 D  D EXIT QUIT
 .I RACNT=0 W !!,"Completed/Canceled exams are not associated with an active CPRS order.",!
 .E  I RAQS=0 W !!,"An exam for this patient was not selected.",! ;out of sych exams yes, but none selected
 .Q
 S RAX=$G(^TMP($J,"RASYNCH",RAQS))
 F RAI=1:1:7 S @$P("RADFN^RADTI^RADTE^RACNI^RACN^RAOIFN^RAACC","^",RAI)=$P(RAX,"^",RAI)
 ;
 S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0))
 S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 I RAY2=""!(RAY3="") Q
 ;
 S RAOIFN=$P(RAY3,U,11),RAXSTS=+$P(RAY3,U,3)
 S RAOIFN(0)=$G(^RAO(75.1,RAOIFN,0)),RAORIFN=+$P(RAOIFN(0),U,7)
 S RAXSTS(0)=$G(^RA(72,RAXSTS,0)),RAORDNUM=$P(RAXSTS(0),U,3)
 ;exam must be canceled or completed to continue
 I RAORDNUM'=0,(RAORDNUM'=9) Q
 ;if exam canceled check the order reason if there use it.
 ; if order reason is not there check the canceled reason for the exam
 ;  if canceled reason is missing default to "EXAM CANCELLED"
 I RAORDNUM=0  D
 .S RAOREA=$P(RAOIFN(0),U,10) ;#10 REASON
 .S:RAOREA="" RAOREA=$P(RAY3,U,23) ;note RAOREA will be an IEN
 .S:RAOREA="" RAOREA=$$FIND1^DIC(75.2,,"B","EXAM CANCELLED")
 .Q
 ;
 ;$$ASK() returns 1 (synch); 0 (no synch); -1 (timeout/caret(s) entered)
 D:$$ASK()=1 SYNCH
 ;
EXIT ;cleanup and exit the option
 K %,%DT,C,DIC,DPTDFN,DTOUT,DUOUT,ORSTS,RAORIFN,RAORSTS,RACN,RACNI,RACNT,RAADC,RAADC1,RADFN,RADTE,RADTI
 K RAACC,RAHEAD,RAI,RANME,RAOIFN,RAORDNUM,RAOREA,RASSN,RAXSTS,RAY2,RAY3,X,Y,^TMP($J,"RASYNCH")
 D:$D(RAINDIE)#2 KILL^RAPSET1 ;run as a standalone option...
 QUIT
 ;// end CASE //
 ;
ASK() ;Display the accession number for the study. Ask (yes/no) the user if they want
 ;to synch up active orders for this completed study.
 ;returns: 1 (synch); 0 (no synch); -1 (timeout/caret(s) entered)
 ;
 W !!,"The accession number tied to this case is: '"_RAACC_"'."
 ;Check this accession if part of a set.
 ;If yes, is there an active descendent?
 ;If yes (1), do not update. Else (0) ask to proceed.
 I $P(RAY3,U,25)>0 I $$SET()>0 D  Q -1
 .W !,"'"_RAACC_"' is part of a set that has other associated active"
 .W !,"descendents. The order cannot be updated at this time."
 .Q
 N RAYN K %,DIR,X,Y,DTOUT,DIROUT,DIRUT,DUOUT
 S DIR("A")="Would you like to proceed? ",DIR("B")="Yes"
 S DIR("?",1)="Enter 'Yes' to update the RIS & CPRS orders to COMPLETE or 'No' to"
 S DIR("?")="exit the option without updating the RIS & CPRS orders to COMPLETE."
 S DIR(0)="YA^" D ^DIR
 ;'X' is the user's unprocessed input
 ;'Y' is: 1 for 'Yes' & 0 for 'No'
 S RAYN=$S($D(DIRUT)#2!($D(DIROUT)#2):-1,1:Y) K %,DIR,X,Y,DTOUT,DIROUT,DIRUT,DUOUT
 Q RAYN
 ;
SYNCH ;synch the orders for this completed exam.
 ;Variables: RAOIFN,RADFN,RADTI,RADTE,RACNI,RACN set in call to RACNLU.
 ;RADUZ used in SETLOG^RAORDU; RAORDNUM, RAOREA set above.
 N RADUZ,RAOSTS
 S RADUZ=DUZ,RAOREA=$G(RAOREA) ;IEN for record in file 75.2
 ;update RIS & CPRS orders to canceled (request status code = 1) if exam was canceled (order number = 0)
 ;or 'complete' (request status code = 2) if the exam was completed (order number = 9).
 S RAOSTS=$S(RAORDNUM=0:1,1:2)
 D ^RAORDU
 W !!,"Radiology order (IEN: "_RAOIFN_") request status updated to: '"_$$GET1^DIQ(75.1,RAOIFN_",",5,"","")_"'."
 W !,"CPRS order (IEN: "_RAORIFN_") status updated to: '"_$$GET1^DIQ(100,RAORIFN_",",5,"","")_"'."
 Q
 ;
SET() ;check other descendents to see if they're active.
 ;Note: RADFN, RADTI, RACNI, RACN are defined at this time.
 ;Output: 1 if an active descendent; else 0
 N RAF,RAR,RATMP,RAXS S (RAF,RAR)=0 ;assumes RACNI definition
 F  S RAR=$O(^RADPT(RADFN,"DT",RADTI,"P",RAR)) Q:RAR'>0  D  Q:RAF
 .S RATMP=$G(^RADPT(RADFN,"DT",RADTI,"P",RAR,0)),RAXS=$G(^RA(72,+$P(RATMP,U,3),0))
 .S RAXS(3)=$P(RAXS,U,3) ;order #
 .S RAF=RAXS(3)#9 ;is 0 if ord #: missing, 0 or 9
 .Q
 Q RAF
 ;
