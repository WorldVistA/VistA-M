EASMTL10 ;MIN/TCM ALB/SCK,AMA - AUTOMATED MEANS TEST LETTERS - RERUN LETTERS ; 7/17/01
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**3,15,28,80**;Mar 15, 2001;Build 1
 ;
RERUN ;  Main entry point to rerun a processing date
 N EASDDD,EASLOC,EATYP,XX
 ;
 D:'$G(IOF) HOME^%ZIS
 W @IOF
 F XX=1:1:7 W !?2,$P($T(NOTICE+XX),";;",2)
 ;
 Q:'$$FILTER(.EASLOC)  ; Select Filter action, quit on uparrow
 Q:'$$LTRTYPE(.EATYP)  ; Select type of letter to reprint, quit on uparrow
 Q:'$$ASKDT(EATYP,.EASDDD)  ; Select date to reprint letters from, quit on uparrow
 D QUE1
 Q
 ;
FILTER(EASLOC) ; Filter by Patient Preferred Location
 ; Input:  None
 ;
 ; Output: EASLOC  -1 if an error occurred
 ;                  0 if not filtering by location
 ;                nnn IEN of filtered facility in the INSTITUTION File
 ;
 ;         RESULT   1 if result of function Ok
 ;                  0 if user enters "^" or exits
 ; 
 N DIR,DIRUT
 ;
 S EASLOC=-1
 I $$GET1^DIQ(713,1,8,"I") D  Q:$D(DIRUT) 0
 . S DIR(0)="YAO",DIR("A")="Filter letters by Preferred Facility? "
 . S DIR("B")="NO"
 . S DIR("?")="Enter 'YES' to limit letters to a specific Facility or 'NO' to print all letters"
 . D ^DIR K DIR
 . Q:$D(DIRUT)
 . I 'Y S EASLOC=0 Q
 . S DIR(0)="P^EAS(713,1,2,:QEM"
 . S EASLOC=$$FACNUM^EASMTL6
 E  D
 . S EASLOC=0
 Q 1
 ;
ASKDT(EATYP,EASDDD) ; Ask for processing date to look for letters
 ; Input   EATYP    Type of letter to be reprinted 
 ;
 ; Output  EASDDD   Selected processing date for type of letter 
 ;                  to be reprinted
 ;
 ;         RESULT   1 if result of function Ok
 ;                  0 if user enters "^" or exits
 ;
 N EASDT,RSLT,EAX,EASOFST
 ;
 S RSLT=0
AGN S EASDT=$$GETDT
 G:EASDT<0 ASKQ
 ;
 S EASOFST=$S(EATYP=2:30,EATYP=4:60,1:0)
 S EAX=$$FMADD^XLFDT(EASDT,-EASOFST,0,0,-1)
 S EAX=$O(^EAS(713.2,"AD",EAX))
 I 'EAX D  G AGN
 . W !!,"No valid processing date could be found for ",$S(EATYP=2:30,EATYP=4:0,1:60),"-day letters for ",$$FMTE^XLFDT(EASDT),"."
 . W !,"Please select another date."
 ;
 W !!,"To re-print "_$S(EATYP=2:30,EATYP=4:0,1:60)_"-day letters for "_$$FMTE^XLFDT(EASDT)
 W !,"the Search/Processing date of "_$$FMTE^XLFDT(EAX)_" will be used."
 ;EAS*1.0*80 -- to avoid confusion, changed "ALL" to "all valid"
 W !,"Please note: all valid "_$S(EATYP=2:30,EATYP=4:0,1:60)_"-day letters for this processing date will print"
 ;
 S DIR(0)="YAO"
 S DIR("?")="Enter 'YES' to use the "_$$FMTE^XLFDT(EAX)_" date.  Enter 'NO' to select a different date."
 S DIR("A")="Do you wish to use this date? "
 S DIR("B")="YES"
 D ^DIR K DIR
 I $D(DIRUT) G ASKQ
 I 'Y G AGN
 ;
 S EASDDD=EAX
 S RSLT=1
ASKQ Q RSLT
 ;
GETDT() ;
 N DIR,DIRUT
 ;
 S DIR(0)="DAO^:DT:EP"
 S DIR("?")="Select the date for the letters you wish to re-print."
 S DIR("A")="Enter re-print date: "
 D ^DIR K DIR
 S:$D(DIRUT) Y=-1
 Q +Y
 ;
LTRTYPE(EATYP) ;  Ask for a specific type of letter to print
 ; Input           None
 ;
 ; Output  EATYP    Type of letter to reprint
 ;                  1 - 60-day letter
 ;                  2 - 30-day letter
 ;                  4 - 0-day letter
 ;
 ;         RESULT   1 if result of function Ok
 ;                  0 if user enters "^" or exits
 ;
 N DIR,DIRUT
 ;
 S DIR(0)="SO^1:60-Day;2:30-Day;4:0-Day"
 S DIR("A")="Select letter type",DIR("A",1)=""
 S DIR("?")="Select the type of letter to re-print "
 D ^DIR K DIR
 Q:$D(DIRUT) 0
 S EATYP=+Y
 Q 1
 ;
QUE1 ;  Queue off the print job
 K IOP,IO("Q")
 N POP  ;EAS*1.0*80
 ;
 S %ZIS="QP",%ZIS("B")=$$GET1^DIQ(713,1,5)
 D ^%ZIS K %ZIS
 Q:POP
 I $D(IO("Q")) D QUEIT Q
 D EN1
 D ^%ZISC
 Q
 ;
QUEIT ;
 N ZTRTN,ZTDESC,EASX,ZTSAVE,ZTSK,ZTDTH,ZTQUEUED
 ;
 S ZTRTN="EN1^EASMTL10"
 S ZTDESC="EAS MT LETTERS REPRINT"
 F EASX="EASDDD","EATYP","EASLOC" S ZTSAVE(EASX)=""
 S ZTDTH="NOW"
 ;
 D ^%ZTLOAD
 I $D(ZTSK)[0 W !!?5,"Reprint canceled"
 E  W !!?5,"Letters queued, [",ZTSK,"]"
 D HOME^%ZIS
 Q
 ;
EN1 ;  Queued entry point for letter rerun
 N EASIEN,EASABRT,EASTMP
 ;
 S EASTMP="^TMP(""EASRP"",$J)"
 K @EASTMP
 ;
 I '$D(ZTQUEUED) W !,"...Gathering letters to re-print..."
 D BLD(EATYP,EASLOC,EASDDD,EASTMP)
 I '$D(ZTQUEUED),'$D(@EASTMP) D  Q
 . W !?3,$CHAR(7),">> No letters found to reprint for these parameters.",!
 D PRINT(EASTMP,EATYP)
 K @EASTMP
 Q
 ;
PRINT(EASTMP,EATYP) ;
 N EASIEN,EASABRT
 ;
 U IO
 S EASIEN=0
 F  S EASIEN=$O(@EASTMP@(EASIEN)) Q:'EASIEN  D  Q:$G(EASABRT)
 . D LETTER^EASMTL6A(EASIEN,EATYP)
 . I '$D(IO("Q")),$E(IOST,1,2)="C-" D
 . . S DIR(0)="E"
 . . D ^DIR K DIR
 . . S:'Y EASABRT=1
 Q
 ;
BLD(EATYP,EASLOC,EASDDD,EASTMP) ;  Sort letters for processing date in groups by type
 N EASIEN,EASPTR,DFN,EASLTR
 ;
 S EASIEN=0
 F  S EASIEN=$O(^EAS(713.2,"AD",EASDDD,EASIEN)) Q:'EASIEN  D
 . ; Begin Checks
 . S EASPTR=$$GET1^DIQ(713.2,EASIEN,2,"I")
 . S DFN=$$GET1^DIQ(713.1,EASPTR,.01,"I")
 . ;; Filter by site, Quit if filter not met
 . I +$G(EASLOC)>0 Q:$$GET1^DIQ(2,DFN,27.02,"I")'=+EASLOC
 . Q:'$$THRSHLD^EASMTL6(EATYP,EASIEN)  ; Quit if letter threshold not met
 . Q:$D(^EAS(713.2,"AC",1,EASIEN))  ; Quit if MT has been returned
 . Q:$D(^EAS(713.1,"AP",1,EASPTR))  ; Quit if prohibit flag set
 . Q:$$CHECKMT^EASMTUTL(EASPTR,EASIEN)  ; Quit if MT no longer required
 . Q:$$FUTMT^EASMTUTL(EASIEN)  ; Quit if future MT on file
 . Q:$$DECEASED^EASMTUTL(EASIEN)  ; Quit if patient deceased
 . I $$CHKADR^EASMTL6A(EASPTR),EATYP'=3 Q  ; Quit if bad address
 . ;EAS*1.0*80 -- copied User Enrollee check from BLD^EASMTL6
 . N EASUE S EASUE=$$UESTAT^EASUER(DFN)
 . Q:(EASUE'=1)  ; Quit if User Enrollee site is not this facility
 . S @EASTMP@(EASIEN)=EATYP
 Q
 ;
SINGLE ;  Rerun a single letter
 N Y,DIR,DIRUT,EASPTR,DFN,EASIEN,ZTSAVE,EASLOC,IOP,EAX,PRNOVRD
 ;
ASKPAT ;  Select patient to reprint a letter for
 S DIR(0)="PAO^713.1:EMZ"
 S DIR("A")="Select PATIENT: "
 S DIR("?")="Select Patient Letter status entry to reprint"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S EASPTR=+Y ; Ptr to file 713.1
 S DFN=+Y(0)
 Q:'DFN
 ;
 I $D(^EAS(713.1,"AP",1,EASPTR)) D  Q
 . W !!?4,$CHAR(7),"The Prohibit flag is set for this patient"
 I $$DECEASED^EASMTUTL("",DFN) D  Q
 . W !!?4,$CHAR(7),"Patient is deceased"
 ;
ASKLTR ;  Select LETTER STATUS file entry
 S DIR(0)="P^713.2:EMZ"
 S DIR("?",1)="Select Processing Date: "
 S DIR("A")="Select the letter processing date for this patient"
 S DIR("S")="I $P(^(0),U,2)=EASPTR" ; Set screen for selected patient
 D ^DIR K DIR
 Q:$D(DIRUT)
 S EASIEN=+Y
 ;
 I $$GET1^DIQ(713.2,EASIEN,4,"I") D  Q
 . W !!?4,$CHAR(7),"A Means Test has already been returned by this patient"
 ;
 I $$CHECKMT^EASMTUTL(EASPTR,EASIEN) D  Q
 . W !!?4,$CHAR(7),"Patient's Means Test is no longer required"
 ;
ASKTYP ; Allow only letters already sent to be reprinted
 N EASSC,EAX
 ;
 F EAX=6,4,"Z" D
 . I $P(^EAS(713.2,EASIEN,EAX),U,3) D
 . . I EAX=6 S EASSC=$G(EASSC)_"1:60-Day;"
 . . I EAX=4 S EASSC=$G(EASSC)_"2:30-Day;"
 . . I EAX="Z" S EASSC=$G(EASSC)_"4:0-Day"
 I $G(EASSC)']""  D  Q
 . W !!?4,$CHAR(7),"There are no letters to re-print for this patient"
 ;
 S DIR(0)="SO^"_EASSC,DIR("A")="Select letter type"
 S DIR("?")="Select letter type to re-print"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S EATYP=+Y
 ;
QUE2 ;  Que off print letter
 S ZTSAVE("EASIEN")="",ZTSAVE("EASPTR")="",ZTSAVE("EATYP")="",ZTSAVE("EASLOC")=""
 D EN^XUTMDEVQ("EN2^EASMTL10","EAS MT RERUN SINGLE LETTER",.ZTSAVE)
 Q
 ;
EN2 ;  Queued entry point to re-run a single letter
 ;
 D LETTER^EASMTL6A(EASIEN,EATYP)
 Q
 ;
LIST ;  List last processing dates for the Letter Status file
 N EAX
 ;
 W !!,"Available Processing Dates:"
 S EAX=0
 F  S EAX=$O(^EAS(713.2,"AD",EAX)) Q:'EAX  D
 . W !?6,$$FMTE^XLFDT(EAX,"2D")
 Q
 ;
NOTICE ;
 ;;Means Test Letters are indexed by the date on which the MT Letter search 
 ;;occurred and is dependent on the frequency the search job is run at your 
 ;;site.  When you select the reprint date for a letter, the software will
 ;;try to determine the appropriate search (processing) date required to print
 ;;the desired letters.  If the letters printed are not the desired letters,
 ;;you may need to try a later date.  
 ;;
