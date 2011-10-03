IBPU ;ALB/CPM - ARCHIVE/PURGING UTILITIES ; 20-APR-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ASK(FILE,JOB) ; User prompts to find/archive/purge entries for each data file.
 ;         Input:  FILE -- Billing Data file number
 ;                  JOB --  1  Find Billing Data to Archive
 ;                      --  2  Archive Billing Data
 ;                      --  3  Purge Billing Data
 ;         Output:  -1  -- Exit option
 ;                  0   -- No action to be taken
 ;                  1^a -- Take action.
 ;                          Optional second piece (a) is ien of
 ;                          log entry if a restart is required.
 N FNAME,STATUS,Y
 S STATUS=$$LOG($G(FILE)) I 'STATUS W !,"File #",FILE," is not defined." Q 0
 S FNAME=$P($G(^DIC(FILE,0)),"^")
 I (JOB=2&(STATUS=1))!(JOB=3&(STATUS<3)) W !,"You must ",$S(STATUS=1:"find ",1:"archive "),FNAME," entries before you can ",$S(JOB=2:"archive.",1:"purge.") Q 0
 S STATUS=STATUS-JOB+1
 Q $S(STATUS>1:$$RESTART(FNAME,FILE,JOB),1:$$START(FNAME,JOB))
 ;
START(NAME,JOB) ; Start find/archive/purge action?
 ;         Input:  NAME -- File name
 ;                  JOB -- same as above (1, 2, or 3)
 ;         Output:    1 -- Yes,   0 -- No,  -1 -- Exit Option
 N DESC,DIR,DIRUT,DUOUT,DTOUT,Y
 S DESC=$P("find^archive^purge","^",JOB)
 S DIR(0)="Y",DIR("A")="Do you wish to "_DESC_" "_NAME_" file entries"
 S DIR("?",1)="Enter:  'Y'  to "_DESC_" "_NAME_" entries"
 S DIR("?",2)="        'N'  to ignore "_$P("find^archiv^purg","^",JOB)_"ing "_NAME_" entries, or"
 S DIR("?")="        '^'  to quit this option." D ^DIR
 Q $S($D(DIRUT)!($D(DUOUT))!($D(DTOUT)):-1,Y:1,1:0)
 ;
RESTART(NAME,FILE,JOB) ; Re-start find/archive action?
 ;         Input:  NAME -- File name
 ;                 FILE -- Billing Data file number
 ;                  JOB -- same as above (only 1 or 2)
 ;         Output:    1 -- Yes,   0 -- No,  -1 -- Exit Option
 N DIR,DIRUT,DUOUT,DTOUT,Y
 W !,NAME," file entries have already been ",$P("found.^archived.","^",JOB)
 S DIR(0)="Y",DIR("A")="Do you wish to "_$S(JOB=1:"delete your search template and start",1:"archive these entries")_" again"
 S DIR("?",1)="Enter:  'Y'  to "_$S(JOB=1:"delete your current search template and search",1:"archive entries")_" again"
 S DIR("?",2)="        'N'  to "_$S(JOB=1:"retain your current search template",1:"ignore archiving this file")_", or"
 S DIR("?")="        '^'  to quit this option." D ^DIR
 Q $S($D(DIRUT)!($D(DUOUT))!($D(DTOUT)):-1,Y:"1^"_$$LOGIEN^IBPU1(FILE),1:0)
 ;
LOG(FILE) ; Determine Log status for a file.
 ;         Input:  FILE -- Billing Data file number
 ;         Output:  0   -- File undefined, or invalid file number
 ;                  1   -- No active log entry on file
 ;                  2   -- Active log entry on file - entries FOUND
 ;                  3   -- Active log entry on file - entries ARCHIVED
 N Y,LOG,LOG1,LOG2
 I '$D(^DIC(+$G(FILE))) S Y=0 G LOGQ
 S DA=$$LOGIEN^IBPU1(FILE)
 S LOG=$G(^IBE(350.6,DA,0)),LOG1=$G(^(1)),LOG2=$G(^(2))
 I $P(LOG,"^",5)'=1 S Y=1
LOGQ Q $S($D(Y):Y,$P(LOG2,"^",2):3,$P(LOG1,"^",2):2,1:1)
 ;
NUM() ; How many previous fiscal year's worth of data should be retained?
 ; Input:  NONE    Output:  number of years, or  -1  to exit option.
 N DIR,DIRUT,DUOUT,DTOUT,Y
 S DIR("A")="Select the number of previous fiscal year's data to retain: "
 S DIR("?",1)="Please select the number of previous fiscal years' worth of billing"
 S DIR("?")="data that you wish to retain in your system, or '^' to exit."
 S DIR(0)="NA^1:20:0",DIR("B")=1 D ^DIR
 Q $S($D(DIRUT)!($D(DUOUT))!($D(DTOUT)):-1,1:Y)
 ;
DAT() ; What is the date through which data should be archived?
 ; Input:  NONE    Output:  final date for archiving, or  -1  to exit.
 N %DT,DTOUT,X,Y
 S %DT="AEPX",%DT(0)=-$$LAST^IBPFU(1),%DT("A")="Enter the final date through which data should be archived: "
 D ^%DT
 Q Y
