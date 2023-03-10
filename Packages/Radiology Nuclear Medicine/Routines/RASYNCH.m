RASYNCH ;HISC/GRZES - synch orders with studies ; Jul 27, 2022@16:07:17
 ;;5.0;Radiology/Nuclear Medicine;**192**;Mar 16, 1998;Build 1
 ;
 ;Routine              File     IA          Type
 ;----------------------------------------------
 ;                     100      6475        (C)
 ;
EN ; entry point for option
 ;
 ;new system level variables do not kill them!
 N RACCESS,RADIVIEN,RAIMGTY,RAMDIV,RAMDV,RAMLC,RAMSG,RAQXIT
 S RAMSG="Select another case number."
 D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 Q:'$D(RAIMGTY)#2
 ;
 ;// main //
 ;ask the user for the case number, find accession, synch
 F  D CASE Q:RAQXIT="^"
 QUIT
 ;// end main //
 ;
 ;// begin CASE //
CASE ;get case number move forward
 ; Note: if user timed out or entered null var 'X'
 ; is set to a caret
 S RAQXIT=0 D ^RACNLU S (RAQXIT,X)=$G(X,"")
 K DIW,DIWT,RADATE,RAPRC,RARPT,RAST ;kill these vars; they're not needed.
 I RAQXIT="^" D  QUIT
 .W !!,"An exam was not selected."
 .W !!,"Exiting the option.",!
 .Q
 ;
 I '$D(RADFN)!('$D(RADTI))!('$D(RADTE))!('$D(RACNI))!('$D(RACN)) D  D EXIT QUIT
 .W !!,"The exam for this patient could not be found."
 .W !!,RAMSG,!
 .Q
 ;
 S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0))
 S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 I RAY2=""!(RAY3="") D  D EXIT Q
 .W !!,"The exam record for this patient is incomplete."
 .W !!,RAMSG,!
 .Q
 ;
 ;find the "ADC1" xref (if exists) and the "ADC" xref for this study 
 S RAADC1=$P(RAY3,U,31),RAADC=$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_RACN
 S RAOIFN=$P(RAY3,U,11),RAXSTS=+$P(RAY3,U,3)
 S RAXSTS(0)=$G(^RA(72,RAXSTS,0))
 I $P(RAXSTS(0),U,3)'=9!($P(RAXSTS(0),U)'="COMPLETE") D  D EXIT Q  ;dual conditions to be met
 .W !!,"Cannot synch an exam with its orders unless the status of the exam is COMPLETE."
 .W !!,RAMSG,!
 .Q
 ;
 S RAOIFN(0)=$G(^RAO(75.1,RAOIFN,0)),RAORIFN=+$P(RAOIFN(0),U,7) ;CPRS ptr to file #100
 K RAORSTS D GETS^DIQ(100,RAORIFN_",",5,"IE","RAORSTS") ;internal & external
 I $$GONOGO()=1 D  D EXIT Q  ;reference above
 .W !!,"Cannot synch COMPLETE exams unless they're tied to ACTIVE CPRS & ACTIVE"
 .W !,"or COMPLETE RIS orders.",!!,RAMSG,!
 .Q
 ;
 ;$$ASK() returns 1 (synch); 0 (no synch); -1 (timeout/caret(s) entered)
 D:$$ASK()=1 SYNCH
 ;
EXIT ;cleanup and exit the option
 K %,%DT,C,DIC,DPTDFN,RAORIFN,RAORSTS,RACCESS,RACN,RACNI,RAADC,RAADC1,RADFN,RADTE,RADTI
 K RAHEAD,RAI,RANME,RAOIFN,RASSN,RAXSTS,RAY2,RAY3,X,Y
 QUIT
 ;// end CASE //
 ;
ASK() ;Display the accession number for the study. Ask (yes/no) the user if they want
 ;to synch up active orders for this completed study.
 ;returns: 1 (synch); 0 (no synch); -1 (timeout/caret(s) entered)
 ;
 N RAYN K %,DIR,X,Y,DTOUT,DIROUT,DIRUT,DUOUT
 S DIR("A",1)="The accession number tied to this case is: '"_$S(RAADC1]"":RAADC1,1:RAADC)_"'."
 S DIR("A")="Would you like to proceed? ",DIR("B")="Yes"
 S DIR("?",1)="Enter 'Yes' to update the RIS & CPRS orders to COMPLETE or 'No' to"
 S DIR("?")="exit the option without updating the RIS & CPRS orders to COMPLETE."
 S DIR(0)="YA^" D ^DIR
 ;'X' is the user's unprocessed input
 ;'Y' is: 1 for 'Yes' & 0 for 'No'
 S RAYN=$S($D(DIRUT)#2!($D(DIROUT)#2):-1,1:Y) K %,DIR,X,Y,DTOUT,DIROUT,DIRUT,DUOUT
 Q RAYN
 ;
GONOGO() ;Do the statuses of the CPRS and RIS orders meet the criteria
 ; to synch with the completed exam?
 ;
 ;CPRS: 
 ; Global ^ORD(100.01,6,0)
 ; ^ORD(100.01,6,0) = "ACTIVE^actv"
 ;RIS:
 ; ^DD(75.1,5,0) = 1:DISCONTINUED;2:COMPLETE;3:HOLD;5:PENDING;
 ;                 6:ACTIVE;8:SCHEDULED;11:UNRELEASED;13:CANCELLED;
 ;
 ; order criteria: CPRS 'active' & RIS 'active' or RIS 'complete'
 ;
 ;  input: RAOIFN(0) local var; gbl scope
 ;         RAORSTS(100) local array var; gbl scope
 ; return: 0 both order statuses meet the criteria
 ;         1 both order statuses do not meet the criteria
 ;
 Q:$G(RAORSTS(100,RAORIFN_",",5,"I"))'=6 1
 Q:$P(RAOIFN(0),U,5)'=2&($P(RAOIFN(0),U,5)'=6) 1
 Q 0
 ;
SYNCH ;synch the orders for this completed exam.
 ;Variables: RAOIFN,RADFN,RADTI,RADTE,RACNI,RACN set in call to RACNLU.
 ;RADUZ used in SETLOG^RAORDU
 N RADUZ,RAOSTS
 S RADUZ=DUZ
 ;update RIS & CPRS orders to COMPLETE (2)
 S RAOSTS=2
 D ^RAORDU
 W !!,"Radiology order (IEN: "_RAOIFN_") request status updated to: '"_$$GET1^DIQ(75.1,RAOIFN_",",5,"","")_"'."
 W !,"CPRS order (IEN: "_RAORIFN_") status updated to: '"_$$GET1^DIQ(100,RAORIFN_",",5,"","")_"'."
 Q
 ;
