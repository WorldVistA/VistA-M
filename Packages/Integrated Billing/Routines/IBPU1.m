IBPU1 ;ALB/CPM - ARCHIVE/PURGING UTILITIES (CON'T.) ; 20-APR-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
NODUZ() ; Check for the existence of DUZ
 ;         Input:   NONE
 ;         Output:  0  --  has DUZ,  1  --  no DUZ
 N Y
 I $D(DUZ)[0 S Y=1 W !!,"Your DUZ code must be defined in order to use this option.",!
 Q +$G(Y)
 ;
NOESIG(USER) ; Check Electronic Signature Code
 ;         Input:   USER  --   ien in New Person file
 ;         Output:  0  --  has code,  1  --  no code
 N Y
 I $P($G(^VA(200,USER,20)),"^",4)="" S Y=1 W !!,"You must enter your Electronic Signature Code in order to use this option.",!
 Q +$G(Y)
 ;
ESIG(USER) ; Enter Electronic Signature Code
 ;         Input:   USER  --   ien in New Person file
 ;         Output:  0  --  not entered or '^' out,  1  --  entered OK
 N I,J,SIG,X,Y S SIG=$P($G(^VA(200,USER,20)),"^",4),Y=0
 W ! F J=1:1 Q:J=4  W !,"ENTER ELECTRONIC SIGNATURE: " X ^%ZOSF("EOFF") R X:$S($D(DTIME):DTIME,1:60) X ^%ZOSF("EON") Q:'$T!(X="")!($E(X)="^")  D HASH^XUSHSHP I X=SIG S Y=1 Q
 W !,"Your Electronic Signature Code has " W:'Y "not " W "been verified."
 Q Y
 ;
OKAY(JOB) ; Okay to queue this job?
 ;         Input:   JOB  --  1 - Search, 2 - Archive, 3 - Purge
 ;         Output:  0  --  No, not okay,  1  --  Yes, okay to continue
 N DIR,DIRUT,DUOUT,DTOUT,Y
 S DIR(0)="Y",DIR("A")="Is it okay to queue this "_$P("search^archive^purge","^",JOB)
 S DIR("?",1)="Enter:  'Y'  if you wish to task off this job, or"
 S DIR("?")="        'N' or '^'  to quit this option." W ! D ^DIR
 Q $S($D(DIRUT)!($D(DUOUT))!($D(DTOUT)):0,1:Y)
 ;
TASK ; Task off job.
 ;  Input:  IBOP  --  1 - Search, 2 - Archive, 3 - Purge
 ;          IBD(  --  input data
 S ZTRTN="QUE^IBP",ZTDTH=$H,(ZTSAVE("IBD("),ZTSAVE("IBOP"))="",ZTIO=$S(IBOP=2:ION,1:"")
 S ZTDESC=$P("FIND^ARCHIVE^PURGE","^",IBOP)_" BILLING DATA"_$S(IBOP=1:" TO ARCHIVE",1:"")
 D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"Unable to queue this job.")
 K ZTSK Q
 ;
 ;
DEL(FILE) ; Delete a search template from file #.401 (Sort Templates)
 ;         Input:   FILE  --   file for which template must be deleted
 ;         Output:  None
 N DA,DIK,TMPL
 S DA=$$LOGIEN(FILE)
 S TMPL=$P($G(^IBE(350.6,DA,0)),"^",2)
 I TMPL]"" S DA=$O(^DIBT("B",TMPL,0)) I DA S DIK="^DIBT(" D ^DIK
 Q
 ;
UPD(LOG,FIELD,VALUE) ; Update/Delete Log Entry fields
 ;         Input:   LOG   --  ien of log entry to be updated
 ;                  FIELD --  field number of field being updated
 ;                  VALUE --  value to be stuffed into field
 ;         Output:  NONE
 N DA,DR,DIE
 S DIE="^IBE(350.6,",DA=LOG,DR=FIELD_"///"_VALUE D ^DIE
 Q
 ;
LOGIEN(FILE) ; Find the most current log entry for a file
 ;         Input:   FILE  --   file for which log entry must be deleted
 ;         Output:  ien of most current log entry for a file
 Q +$O(^(+$O(^IBE(350.6,"AF",FILE,"")),0))
