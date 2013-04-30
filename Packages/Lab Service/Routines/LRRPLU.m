LRRPLU ;DALOI/JMC - Lab Report Performing Lab Utility ;10/28/11  14:29
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 Q
 ;
 ;
EDIT(LRDFN,LRSS,LRIDT) ; Add/edit performing lab for a section of a report
 ; Call with LRDFN = File #63 IEN
 ;            LRSS = File #63 subscript
 ;           LRIDT = File #63 inverse date/time of specimen
 ;
 ;
 N DIR,DIROUT,DIRUT,DUOUT,LRHLP,LRLST,LRPL,LRX,LRY,X,Y
 ; Autospy does not have an inverse date/time
 I LRSS="AU" S LRIDT=0
 I LRSS="MI",'($$GET^XPAR("ALL","LR ASK PERFORMING LAB MICRO",1,"Q")) D NOASK^LRRPLUA Q
 I LRSS?1(1"SP",1"CY",1"EM"),'($$GET^XPAR("ALL","LR ASK PERFORMING LAB AP",1,"Q")) D NOASK^LRRPLUA Q
 F  D  Q:$D(DIRUT)
 . K LRPL,LRLST
 . D RETLST^LRRPL(.LRPL,LRDFN,LRSS,LRIDT,2)
 . ;
 . I $D(LRPL(0)) D
 . . M LRLST=LRPL(0) K LRPL(0)
 . . S LRPL(.5)="Current performing lab assignments:",LRPL(.6)=" "
 . E  S LRPL(.5)="Current performing lab assignments: None Listed"
 . D EN^DDIOL(.LRPL)
 . ;
 . K DIR,LRHLP
 . S DIR(0)="SO^1:Entire report;2:Specific sections of report"
 . I $D(LRLST) S DIR(0)=DIR(0)_";3:Delete performing laboratory"
 . E  S DIR("B")=1
 . S DIR("A")="Designate performing laboratory for"
 . I $G(DIR("B"))'="" S DIR("?")="Enter a code from the list or '^' to exit."
 . E  S DIR("?")="Enter a code from the list or <ENTER> to exit."
 . M LRHLP=LRPL
 . S X=$G(LRPL),LRHLP(X+1)=" ",LRHLP(X+2)=DIR("?")
 . S DIR("??")="^D EN^DDIOL(.LRHLP)"
 . D ^DIR
 . I $D(DIRUT) Q
 . I Y=1 D SET1(0) Q
 . I Y=2 D SET2 Q
 . I Y=3 D DEL Q
 ;
 Q
 ;
 ;
SET1(LRSECT) ; Set performing lab for entire or major section of report.
 ; Update if already set otherwise create a new record.
 ; Call with LRSECT = section of report
 ;
 N DIR,DIROUT,DIRUT,DUOUT,LRDIE,LRDPL,LRFDA,LRFLAG,LRIEN,LRREF,LRPLAB
 S LRFLAG=0
 I LRSS?1(1"MI",1"SP",1"CY",1"EM") S LRFLAG=1
 S LRDPL=$$GET^XPAR("USR","LR VER DEFAULT PERFORMING LAB",1,"Q")
 I LRDPL<1 S LRDPL=DUZ(2)
 S LRPLAB=$$SELPL^LRVERA(LRDPL,LRFLAG)
 I LRPLAB<1 Q
 S LRREF=LRDFN_","_LRSS_","_LRIDT_","_LRSECT
 ;
 ; Confirm that user wants to add/update record.
 W !
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="Sure you want to "_$S($D(^LR(LRDFN,"PL","B",LRREF)):"update",1:"add")_" this record"
 D ^DIR
 I Y'=1 Q
 ;
 ; Update existing entry
 I $D(^LR(LRDFN,"PL","B",LRREF)) D  Q
 . D UEE(LRDFN,LRREF,LRPLAB)
 . W !,"... assignment updated.",!
 ;
 ; Create new entry
 D CNE(LRDFN,LRREF,LRPLAB)
 W !,"... assignment created.",!
 ;
 Q
 ;
 ;
SET2 ; Set performing lab for specific section of report
 ;
 N DIR,DIROUT,DIRUT,DUOUT,I,LRCNT,LRI,LRPLIEN,LRQUIT,LRREC,LRREF,LRROOT,LRSEC,LRSECT,LRX,LRY
 ; Find the current existing sections of the report
 S LRREF="",(LRI,LRQUIT,LRREC)=0
 S (LRROOT,LRX)=LRDFN_","_LRSS_","_LRIDT_","
 F  S LRX=$O(^LR(LRDFN,"PL","B",LRX)) Q:LRX=""  D  Q:LRQUIT
 . I $P(LRROOT,",",1,3)'=$P(LRX,",",1,3) S LRQUIT=1 Q
 . S LRPLIEN=$O(^LR(LRDFN,"PL","B",LRX,0))
 . S LRI=$P(LRX,",",4,99),LRY="LRSEC("_LRDFN_",LRSS,"_LRIDT_",LRI)"
 . S @LRY=LRX_"^"_LRPLIEN
 ;
 I LRSS="MI" D MICHK
 I LRSS?1(1"SP",1"CY",1"EM") D APCHK
 I LRSS="AU" D AUCHK
 ;
 W !
 I $G(LRREC)<1 D  Q
 . S DIR(0)="E",DIR("A",1)="NO sections to designate.",DIR("A")="Press any key to continue"
 . D ^DIR
 ;
 S LRCNT=$O(LRREC(""),-1)
 F I=1:1:LRCNT S DIR("A",I)=$J(I,11)_"   -   "_$P(LRREC(I),"^")
 S DIR("A")="Select the section to designate (1-"_LRCNT_"): "
 S DIR(0)="NOA^1:"_LRCNT_":0"
 S DIR("??")="^D EN^DDIOL(.LRPL)"
 D ^DIR
 I $D(DIRUT) Q
 ;
 S LRSECT=$P(LRREC(Y),"^",2)
 ;
 I LRSS="MI" D
 . S LRX="1^^^^1^^^1^^^1^^^^^1^^^^^^^^^^^^^^^1^"
 . I $P(LRX,"^",LRSECT)!(LRSECT=99) D SET1(LRSECT) Q
 . ;
 . S LRX="^1^1^1^^1^1^^1^1^^1^1^1^1^^1^1^1^1^1^1^1^1^1^1^1^1^1^1^"
 . I $P(LRX,"^",LRSECT) D
 . . N LRY
 . . D GETMULTI
 . . W ! S LRX=$$SELMULTI(.LRY)
 . . I LRX#1=.1 W ! K LRY D MIAB(.LRY,$P(LRX,",",5)) S LRX=$$SELMULTI(.LRY)
 . . S LRREF=$P(LRX,"^",3)
 . . I LRREF'="" D SETREF
 ;
 I LRSS?1(1"SP",1"CY",1"EM") D
 . I LRSECT=1.2!(LRSECT=97)!(LRSECT=99) D  Q
 . . N LRY
 . . D GETMULTI
 . . W ! S LRX=$$SELMULTI(.LRY),LRREF=$P(LRX,"^",3)
 . . I LRREF'="" D SETREF
 . I LRSECT=2 D  Q
 . . N LRY
 . . D GETMULTI
 . . W ! S LRX=$$SELMULTI(.LRY)
 . . I LRX#1=.1 W ! K LRY D APSS(.LRY,$P(LRX,",",5)) S LRX=$$SELMULTI(.LRY)
 . . S LRREF=$P(LRX,"^",3)
 . . I LRREF'="" D SETREF
 . D SET1(LRSECT)
 ;
 I LRSS="AU" D
 . I LRSECT=84!(LRSECT="AZC") D  Q
 . . N LRY
 . . D GETMULTI
 . . W ! S LRX=$$SELMULTI(.LRY),LRREF=$P(LRX,"^",3)
 . . I LRREF'="" D SETREF
 . I LRSECT="AY" D  Q
 . . N LRY
 . . D GETMULTI
 . . W ! S LRX=$$SELMULTI(.LRY)
 . . I LRX#1=.1 W ! K LRY D APSS(.LRY,$P(LRX,",",3)) S LRX=$$SELMULTI(.LRY)
 . . S LRREF=$P(LRX,"^",3)
 . . I LRREF'="" D SETREF
 . D SET1(LRSECT)
 ;
 Q
 ;
 ;
SETREF ; Set reference to performing lab in file #63
 ; Update if already set otherwise create a new record.
 ;
 ; Confirm that user wants to add/update record.
 N DIR,DIROUT,DIRUT,DUOUT,LRDIE,LRDPL,LRFDA,LRFLAG,LRIEN,LRPLAB
 ;
 S LRFLAG=0
 I LRSS?1(1"MI",1"SP",1"CY",1"EM",1"AU") S LRFLAG=1
 S LRDPL=$$GET^XPAR("USR","LR VER DEFAULT PERFORMING LAB",1,"Q")
 I LRDPL<1 S LRDPL=DUZ(2)
 S LRPLAB=$$SELPL^LRVERA(LRDPL,LRFLAG)
 I LRPLAB<1 Q
 ;
 W !
 K DIR
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="Sure you want to "_$S($D(^LR(LRDFN,"PL","B",LRREF)):"update",1:"add")_" this record"
 D ^DIR
 I Y'=1 Q
 ;
 ; Update existing entry
 I $D(^LR(LRDFN,"PL","B",LRREF)) D  Q
 . D UEE(LRDFN,LRREF,LRPLAB)
 . W !,"... assignment updated.",!
 ;
 ; Create new entry
 D CNE(LRDFN,LRREF,LRPLAB)
 W !,"... assignment created.",!
 ;
 Q
 ;
 ;
DEL ; Delete existing performing laboratory designations.
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LRCNT,LRFDA,LRIEN,X,Y
 S LRCNT=$O(LRLST(""),-1)
 ;
 W !
 I LRCNT=1 S Y=1
 I LRCNT>1 D  Q:$D(DIRUT)
 . S DIR("A")="Select the section to delete (1-"_LRCNT_"): "
 . F I=1:1:LRCNT S DIR("A",I)=$J(I,11)_"   -   "_$P(LRLST(I),"^",3)
 . S DIR(0)="NOA^1:"_LRCNT_":0"
 . D ^DIR
 ;
 S LRIEN=$P(LRLST(Y),"^",2)
 ;
 ; Confirm that user wants to delete record.
 K DIR
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="Sure you want to delete this performing lab assignment"
 D ^DIR
 I Y'=1 W !,"... deletion cancelled.",! Q
 ;
 ; Delete existing entry
 D DEE(LRIEN_","_LRDFN_",")
 ;
 I '$D(^LR(LRDFN,"PL",LRIEN)) W !,"... assignment deleted.",!
 E  W "... assignment NOT deleted.",!
 ;
 Q
 ;
 ;
UEE(LRDFN,LRREF,LRPLAB) ; Update existing entry
 ; Call with LRDFN = File #63 IEN
 ;           LRREF = File #63 subscript reference
 ;           LRPLAB = Performing lab as IEN in file #4
 ;
 N LRDIE,LRFDA,LRIEN
 S LRIEN=$O(^LR(LRDFN,"PL","B",LRREF,0))
 S LRFDA(1,63.00012,LRIEN_","_LRDFN_",",.02)=LRPLAB
 D FILE^DIE("","LRFDA(1)","LRDIE(1)")
 Q
 ;
 ;
CNE(LRDFN,LRREF,LRPLAB) ; Create new entry
 ; Call with LRDFN = File #63 IEN
 ;           LRREF = File #63 subscript reference
 ;           LRPLAB = Performing lab as IEN in file #4
 ;
 N LRDIE,LRFDA,LRIEN
 S LRFDA(1,63.00012,"+1,"_LRDFN_",",.01)=LRREF
 S LRFDA(1,63.00012,"+1,"_LRDFN_",",.02)=LRPLAB
 D UPDATE^DIE("","LRFDA(1)","LRIEN","LRDIE(1)")
 Q
 ;
 ;
DEE(LRIENS) ; Delete existing entry
 ; Call with LRRIENS = File #63 performing lab reference IENS
 ;
 N LRDIE,LRFDA
 S LRFDA(1,63.00012,LRIENS,.01)="@"
 D FILE^DIE("","LRFDA(1)","LRDIE(1)")
 Q
 ;
 ;
MICHK ; Check MI for sections to link to a performing lab
 ;
 N I,LRI
 ;
 ; Bacteriology section
 S LRI=1
 I $D(^LR(LRDFN,LRSS,LRIDT,LRI)) D
 . D MICHK1
 . N LRJ
 . F LRJ=5,6 I $P(^LR(LRDFN,LRSS,LRIDT,LRI),"^",LRJ)'="" D
 . . S LRREF=LRROOT_LRI_";"_LRJ,LRREC=LRREC+1 D MICHK^LRRPL S $P(LRREC(LRREC),"^",2)=LRI_";"_LRJ
 . . S LRREC(LRREC,0)=$G(LRSEC(LRDFN,LRSS,LRIDT,LRI_";"_LRJ))
 ;
 ; Gram stain/Organism/Susceptibility/Remark section
 F LRI=2,3,4 I $O(^LR(LRDFN,LRSS,LRIDT,LRI,0)) D
 . D MICHK2
 . I LRI=3 D BUGCHK
 ;
 ; Parasite section - check for parasite and stage info
 S LRI=5
 I $D(^LR(LRDFN,LRSS,LRIDT,LRI)) D MICHK1
 ;
 F LRI=6,7 I $O(^LR(LRDFN,LRSS,LRIDT,LRI,0)) D
 . D MICHK2
 . I LRI=6 D BUGCHK
 ;
 ; Mycology section
 S LRI=8
 I $D(^LR(LRDFN,LRSS,LRIDT,LRI)) D MICHK1
 ;
 F LRI=9,10,15 I $O(^LR(LRDFN,LRSS,LRIDT,LRI,0)) D
 . D MICHK2
 . I LRI=9 D BUGCHK
 ;
 ; Mycobacteria section - also check for AFB stain
 S LRI=11
 I $D(^LR(LRDFN,LRSS,LRIDT,LRI)) D
 . D MICHK1
 . I $P(^LR(LRDFN,LRSS,LRIDT,LRI),"^",3)'="" D
 . . S LRREF=LRROOT_LRI_";3",LRREC=LRREC+1 D MICHK^LRRPL S $P(LRREC(LRREC),"^",2)=LRI_";3"
 . . S LRREC(LRREC,0)=$G(LRSEC(LRDFN,LRSS,LRIDT,LRI_";3"))
 ;
 ; TB/Organism/Susceptibilityr/Remark section
 F LRI=12,13,14 I $O(^LR(LRDFN,LRSS,LRIDT,LRI,0)) D
 . D MICHK2
 . I LRI=12 D BUGCHK
 ;
 ; Virology section
 S LRI=16
 I $D(^LR(LRDFN,LRSS,LRIDT,LRI)) D MICHK1
 ;
 F LRI=17,18 I $O(^LR(LRDFN,LRSS,LRIDT,LRI,0)) D
 . D MICHK2
 . I LRI=17 D BUGCHK
 ;
 ; Various preliminary comment sections
 F LRI=19:1:30 I $D(^LR(LRDFN,LRSS,LRIDT,LRI)) S LRREF=LRROOT_LRI,LRREC=LRREC+1 D MICHK^LRRPL S $P(LRREC(LRREC),"^",2)=LRI
 ;
 ; Sterility Results
 S LRI=31
 I $D(^LR(LRDFN,LRSS,LRIDT,LRI)) D MICHK1
 ;
 ; Comment on Specimen
 S LRI=99
 I $D(^LR(LRDFN,LRSS,LRIDT,LRI)) D MICHK1
 ;
 Q
 ;
 ;
MICHK1 ; Common MI checking logic
 ;
 S LRREF=LRROOT_LRI,LRREC=LRREC+1 D MICHK^LRRPL S $P(LRREC(LRREC),"^",2)=LRI
 S LRREC(LRREC,0)=$G(LRSEC(LRDFN,LRSS,LRIDT,LRI))
 Q
 ;
 ;
MICHK2 ; Common MI checking logic
 ;
 S LRREF=LRROOT_LRI_",0",LRREC=LRREC+1 D MICHK^LRRPL S $P(LRREC(LRREC),"^",2)=LRI
 S LRREC(LRREC,0)=$G(LRSEC(LRDFN,LRSS,LRIDT,LRI,0))
 Q
 ;
 ;
APCHK ; Check AP for sections to link to a performing lab
 ;
 N LRI
 ;
 F LRI=.2,.3,.4,.5,1,1.1,1.3,1.4 D
 . I LRI=1.3,LRSS'="SP" Q
 . I '$O(^LR(LRDFN,LRSS,LRIDT,LRI,0)) Q
 . S LRREF=LRROOT_LRI_",0",LRREC=LRREC+1 D APCHK^LRRPL S $P(LRREC(LRREC),"^",2)=LRI
 . S LRREC(LRREC,0)=$G(LRSEC(LRDFN,LRSS,LRIDT,LRI))
 ;
 ; Supplementary Report section (1.2)
 S LRI=1.2
 I $D(^LR(LRDFN,LRSS,LRIDT,LRI)) D
 . S LRREF=LRROOT_LRI_",0",LRREC=LRREC+1 D APCHK^LRRPL S $P(LRREC(LRREC),"^",2)=LRI
 . S LRREC(LRREC,0)=$G(LRSEC(LRDFN,LRSS,LRIDT,LRI))
 ;
 ; Special studies (2)
 S LRI=2
 I $D(^LR(LRDFN,LRSS,LRIDT,LRI)) D
 . N LRJ
 . S LRJ=0
 . F  S LRJ=$O(^LR(LRDFN,LRSS,LRIDT,LRI,LRJ)) Q:'LRJ  I $O(^LR(LRDFN,LRSS,LRIDT,LRI,LRJ,5,0)) D  Q
 . . S LRREF=LRROOT_LRI_",0",LRREC=LRREC+1 D APCHK^LRRPL S $P(LRREC(LRREC),"^",2)=LRI
 . . S LRREC(LRREC,0)=$G(LRSEC(LRDFN,LRSS,LRIDT,LRI))
 ;
 ; Delayed Report Comment (97) / Comment on Specimen (99)
 F LRI=97,99 I $D(^LR(LRDFN,LRSS,LRIDT,LRI)) D
 . S LRREF=LRROOT_LRI,LRREC=LRREC+1 D APCHK^LRRPL S $P(LRREC(LRREC),"^",2)=LRI
 . S LRREC(LRREC,0)=$G(LRSEC(LRDFN,LRSS,LRIDT,LRI))
 ;
 Q
 ;
 ;
AUCHK ; Check AU for sections to link to a performing lab
 ;
 N LRI
 ;
 ; Clinical Diagnoses (81) / Pathological Diagnoses (82)
 F LRI=81,82 D
 . I '$O(^LR(LRDFN,LRI,0)) Q
 . S LRREF=LRROOT_LRI,LRREC=LRREC+1 D AUCHK^LRRPL S $P(LRREC(LRREC),"^",2)=LRI
 . S LRREC(LRREC,0)=$G(LRSEC(LRDFN,LRI))
 ;
 ; Supplementary Report section (84)
 S LRI=84
 I $D(^LR(LRDFN,LRI)) D
 . S LRREF=LRROOT_LRI_",0",LRREC=LRREC+1 D AUCHK^LRRPL S $P(LRREC(LRREC),"^",2)=LRI
 . S LRREC(LRREC,0)=$G(LRSEC(LRDFN,LRI))
 .
 ; Special studies (AY)
 S LRI="AY"
 I $D(^LR(LRDFN,LRI)) D
 . N LRJ
 . S LRJ=0
 . F  S LRJ=$O(^LR(LRDFN,LRI,LRJ)) Q:'LRJ  I $O(^LR(LRDFN,LRI,LRJ,5,0)) D  Q
 . . S LRREF=LRROOT_LRI_",0",LRREC=LRREC+1 D AUCHK^LRRPL S $P(LRREC(LRREC),"^",2)=LRI
 . . S LRREC(LRREC,0)=$G(LRSEC(LRDFN,"AY"))
 ;
 ; Autospy comments (AZC)
 S LRI="AZC"
 I $D(^LR(LRDFN,LRI)) D
 . S LRREF=LRROOT_LRI,LRREC=LRREC+1 D AUCHK^LRRPL S $P(LRREC(LRREC),"^",2)=LRI
 . S LRREC(LRREC,0)=$G(LRSEC(LRDFN,"AZC"))
 ;
 Q
 ;
 ;
BUGCHK ; Check for organism/susceptibility
 ; Only check for susceptibilities on bacteria (3) or TB (12).
 ;
 N LRJ,LRK
 S LRJ=0
 F  S LRJ=$O(^LR(LRDFN,LRSS,LRIDT,LRI,LRJ)) Q:'LRJ  D
 . S LRREC(LRREC,LRJ)=$P(^LAB(61.2,+^(LRJ,0),0),"^")
 . S LRREC(LRREC,LRJ,0)=$G(LRSEC(LRDFN,LRSS,LRIDT,LRI,LRJ))
 . I LRI'=3,LRI'=12 Q
 . S LRK=2
 . F  S LRK=$O(^LR(LRDFN,LRSS,LRIDT,LRI,LRJ,LRK)) Q:'LRK!(LRK'<3)  D
 . . S LRREC(LRREC,LRJ,LRK)=$$GETDRUG^LRRPL(LRI,LRK)
 . . S LRREC(LRREC,LRJ,LRK,0)=$G(LRSEC(LRDFN,LRSS,LRIDT,LRI,LRJ,LRK))
 Q
 ;
 ;
SELMULTI(LRY) ; Handle multiple items type selection
 ; Flag whole section or indivudual items with performing lab.
 ; Present list of items and allow all or selected items to be designated
 ;
 ; Call with LRY = array of items to select/designate
 ;   Returns LRX = item selected
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,I,LRCNT,LRDEC,LRX
 ;
 S (I,LRDEC)=0,LRCNT=$O(LRY(""),-1)
 F  S I=$O(LRY(I)) Q:'I  S DIR("A",I+1)=$J($$LJ^XLFSTR(I,4),13)_" -   "_$P(LRY(I),"^") S:I#1=.1 LRDEC=1
 S DIR("A")="Select the item to designate (1-"_LRCNT_"): "
 S DIR(0)="NAO^1:"_LRCNT_":"_LRDEC,DIR("PRE")="I X'="""",'$D(DTOUT),'$D(LRY(X)) K X"
 S DIR("??")="^D EN^DDIOL(.LRPL)"
 D ^DIR
 I $D(DIRUT) S LRX=-1
 E  S LRX=Y_"^"_LRY(Y)
 ;
 Q LRX
 ;
 ;
GETMULTI ; Build array of existing items in multiple
 N LRI
 K LRY
 S LRI=0
 ;
 I LRSS="MI" D MIMULTI Q
 I LRSS?1(1"SP",1"CY",1"EM",1"AU") D APMULTI Q
 ;
 Q
 ;
 ;
MIMULTI ; Build array for MI subscript results.
 ;
 N LRX,X
 S LRX="^1^^1^^^1^^^1^^^^1^1^^^^1^"
 I $P(LRX,"^",LRSECT) D  Q
 . F  S LRI=$O(^LR(LRDFN,LRSS,LRIDT,LRSECT,LRI)) Q:'LRI  D
 . . S X=^LR(LRDFN,LRSS,LRIDT,LRSECT,LRI,0)
 . . I LRSECT=14 S X=$P(X,"^")
 . . S LRY(LRI)=X_"^"_LRROOT_LRSECT_","_LRI_",0"
 . S LRI=$O(LRY(""),-1)+1
 . S LRY(LRI)="ALL "_$S(LRSECT=14:"ANTIBIOTIC(for SERUM LEVEL)",1:"comments")_"^"_LRROOT_LRSECT_",0"
 ;
 S LRX="^^1^^^1^^^1^^^1^^^^^1^"
 I $P(LRX,"^",LRSECT) D  Q
 . F  S LRI=$O(^LR(LRDFN,LRSS,LRIDT,LRSECT,LRI)) Q:'LRI  D
 . . S LRY(LRI)=$P(^LAB(61.2,+^(LRI,0),0),"^")_"^"_LRROOT_LRSECT_","_LRI_",0"
 . . I LRSECT=3!(LRSECT=12) D
 . . . N LRFLAG
 . . . S X=$O(^LR(LRDFN,LRSS,LRIDT,LRSECT,LRI,2)),LRFLAG=0
 . . . I X\1=2 S LRFLAG=1
 . . . I LRSECT=3,$O(^LR(LRDFN,LRSS,LRIDT,LRSECT,LRI,3,0)) S LRFLAG=1
 . . . I LRFLAG<1 Q
 . . . S LRY(LRI+.1)=$P(LRY(LRI),"^")_" Specific Susceptibilities"_"^"_LRROOT_LRSECT_","_LRI_","
 . . . S $P(LRY(LRI),"^")=$P(LRY(LRI),"^")_" including All Susceptibilities"
 . S LRI=$O(LRY(""),-1)+1\1,LRY(LRI)="ALL items^"_LRROOT_LRSECT_",0"
 ;
 Q
 ;
 ;
MIAB(LRY,LRORG) ; Build array for MI susceptbility results.
 ; Call with LRY = array to return selections
 ;         LRORG = organism subscript
 ;
 N LRDN,LRI,LRJ
 ;
 S LRI=0,LRJ=2
 F  S LRJ=$O(^LR(LRDFN,LRSS,LRIDT,LRSECT,LRORG,LRJ)) Q:'LRJ!(LRJ'<3)  D
 . S LRDN=$$GETDRUG^LRRPL(LRSECT,LRJ)
 . S LRI=LRI+1,LRY(LRI)=LRDN_"^"_LRROOT_LRSECT_","_LRORG_","_LRJ
 ;
 ; Collect free text antibiotics (#200)
 I LRSECT=3,$D(^LR(LRDFN,LRSS,LRIDT,LRSECT,LRORG,3,0)) D
 . S LRJ=0
 . F  S LRJ=$O(^LR(LRDFN,LRSS,LRIDT,LRSECT,LRORG,3,LRJ)) Q:'LRJ  D
 . . S LRDN=$P(^LR(LRDFN,LRSS,LRIDT,LRSECT,LRORG,3,LRJ,0),"^")
 . . S LRI=LRI+1,LRY(LRI)=LRDN_"^"_LRROOT_LRSECT_","_LRORG_",3,"_LRJ_",0"
 Q
 ;
 ;
APMULTI ; Build array for AP subscript results.
 ;
 ; Autopsy comments (AZC)
 I LRSS="AU",LRSECT="AZC" D  Q
 . F  S LRI=$O(^LR(LRDFN,LRSECT,LRI)) Q:'LRI  S LRY(LRI)=^(LRI,0)_"^"_LRROOT_LRSECT_","_LRI_",0"
 . S LRI=$O(LRY(""),-1)+1,LRY(LRI)="ALL comments^"_LRROOT_LRSECT_",0"
 ;
 ; Autopsy Supplementary reports (84)
 I LRSS="AU",LRSECT=84 D  Q
 . F  S LRI=$O(^LR(LRDFN,LRSECT,LRI)) Q:'LRI  S LRX=$$FMTE^XLFDT(+^(LRI,0),"1MZ"),LRY(LRI)=LRX_"^"_LRROOT_LRSECT_","_LRI_",0"
 . S LRI=$O(LRY(""),-1)+1,LRY(LRI)="ALL Supplementary Reports^"_LRROOT_LRSECT_",0"
 ;
 ; Autopsy Special Studies (AY)
 I LRSS="AU",LRSECT="AY" D  Q
 . F  S LRI=$O(^LR(LRDFN,LRSECT,LRI)) Q:'LRI  D
 . . S LRX=$P(^LAB(61,+^(LRI,0),0),"^"),LRY(LRI)=LRX_"^"_LRROOT_LRSECT_","_LRI_",0"
 . . S LRY(LRI+.1)=$P(LRY(LRI),"^")_" Specific Special Studies"_"^"_LRROOT_LRSECT_","_LRI_","
 . . S $P(LRY(LRI),"^")=$P(LRY(LRI),"^")_" including All Special Studies"
 . S LRI=$O(LRY(""),-1)+1\1,LRY(LRI)="ALL Special Studies Reports^"_LRROOT_LRSECT_",0"
 ;
 ; Comment fields #97 and #99
 I LRSECT=97!(LRSECT=99) D  Q
 . F  S LRI=$O(^LR(LRDFN,LRSS,LRIDT,LRSECT,LRI)) Q:'LRI  S LRY(LRI)=^(LRI,0)_"^"_LRROOT_LRSECT_","_LRI_",0"
 . S LRI=$O(LRY(""),-1)+1,LRY(LRI)="ALL comments^"_LRROOT_LRSECT_",0"
 ;
 ; Supplementary Reports
 I LRSECT=1.2 D  Q
 . F  S LRI=$O(^LR(LRDFN,LRSS,LRIDT,LRSECT,LRI)) Q:'LRI  S LRX=$$FMTE^XLFDT(+^(LRI,0),"1MZ"),LRY(LRI)=LRX_"^"_LRROOT_LRSECT_","_LRI_",0"
 . S LRI=$O(LRY(""),-1)+1,LRY(LRI)="ALL Supplementary Reports^"_LRROOT_LRSECT_",0"
 ;
 ; Special Studies
 I LRSECT=2 D  Q
 . F  S LRI=$O(^LR(LRDFN,LRSS,LRIDT,LRSECT,LRI)) Q:'LRI  D
 . . S LRX=$P(^LAB(61,+^(LRI,0),0),"^"),LRY(LRI)=LRX_"^"_LRROOT_LRSECT_","_LRI_",0"
 . . S LRY(LRI+.1)=$P(LRY(LRI),"^")_" Specific Special Studies"_"^"_LRROOT_LRSECT_","_LRI_","
 . . S $P(LRY(LRI),"^")=$P(LRY(LRI),"^")_" including All Special Studies"
 . S LRI=$O(LRY(""),-1)+1\1,LRY(LRI)="ALL Special Studies Reports^"_LRROOT_LRSECT_",0"
 ;
 Q
 ;
 ;
APSS(LRY,LRORGT) ; Build array for AP special studies.
 ; Call with LRY = array to return selections
 ;        LRORGT = organ/tissue ien
 ;
 N LRI,LRJ,LRS,LRSST,LRSUB
 ;
 S (LRI,LRJ)=0
 ; Autopsy Special Studies (AY)
 I LRSS="AU",LRSECT="AY" D  Q
 . F  S LRJ=$O(^LR(LRDFN,LRSECT,LRORGT,5,LRJ)) Q:'LRJ  D
 . . S LRS=^LR(LRDFN,LRSECT,LRORGT,5,LRJ,0),LRSST=$$EXTERNAL^DILFD(63.26,.01,"",$P(LRS,"^"),"")
 . . S LRI=LRI+1,LRY(LRI)=LRSST_"^"_LRROOT_LRSECT_","_LRORGT_",5,"_LRJ
 ;
 S LRSUB=$S(LRSS="SP":63.819,LRSS="CY":63.919,1:63.219)
 F  S LRJ=$O(^LR(LRDFN,LRSS,LRIDT,LRSECT,LRORGT,5,LRJ)) Q:'LRJ  D
 . S LRS=^LR(LRDFN,LRSS,LRIDT,LRSECT,LRORGT,5,LRJ,0),LRSST=$$EXTERNAL^DILFD(LRSUB,.01,"",$P(LRS,"^"),"")
 . S LRI=LRI+1,LRY(LRI)=LRSST_"^"_LRROOT_LRSECT_","_LRORGT_",5,"_LRJ
 Q
