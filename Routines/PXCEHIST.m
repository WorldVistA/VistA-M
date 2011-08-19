PXCEHIST ;ISL/dee - Used to add an historical visit and display a visit ;9/5/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**1,22**;Aug 12, 1996
 ;; ;
 Q
 ;
 ;Line with the line label "FORMAT"
 ;;Long name~File Number~Node Subscripts~Allow Duplicate entries (not used on visit)~File global name
 ;     1         2             3                   4                                        5
 ;
 ;Following lines:
 ;;Node~Piece~,Field Number~Edit Label~Display Label~Display Routine~Edit Routine~Help Text for DIR("?")~Set of PXCEKEYS that can Edit~D if Detail Display Only~
 ;  1  ~  2  ~      3      ~     4    ~        5    ~        6      ~     7      ~       8              ~          9                  ~       10
 ;The Display & Edit routines are for special cases.
 ;
FORMAT ;;Historical Encounter~9000010~0,21,150,800,811,812~~^AUPNVSIT
 ;;0~1~.01~Encounter Date and (optional) Time:  ~Encounter Date and Time:  ~~EVISITDT^PXCEHIST(-1)~~~B
 ;;0~5~.05~Patient Name:  ~Patient Name:  ~~EPAT^PXCEVSIT~~~D
 ;;0~6~.06~Location of Encounter:  ~Location of Encounter:  ~~ELOC^PXCEHIST~~~D
 ;;811~1~81101~Comment:  ~Comment:  ~~~~~D
 ;;
 ;
 ;********************************
 ;Special cases for display of visit are in PXCEVSIT.
 ;
 ;********************************
 ;Special cases for edit of visit are in PXCEVSIT and below.
 ;
EVISITDT(DTPARM) ;
 I $P(PXCEAFTR(0),"^",1)']"" D
 . D EVISITDT^PXCEVSIT(DTPARM)
 E  S (X,Y)=$P(PXCEAFTR(0),"^",1)
 Q
 ;
ELOC ;Used to edit location of the visit for historical visits
 ;Ask if it is a location outside the VA
 S DIR(0)="YA"
 S DIR("A")="Is this a VA location?  "
 I $P(PXCEAFTR(0),"^",6)]"" S DIR("B")="Y"
 E  I $P(PXCEAFTR(21),"^",1)]"" S DIR("B")="N"
 E  S DIR("B")="N"
 D ^DIR
 K DIR,DA
 I $D(DTOUT)!$D(DUOUT) S (PXCEEND,PXCEQUIT)=1 Q  ;for visit
 I Y S INOROUT="I" G IN
 E  S INOROUT="O" G OUT
 ;
IN ;This is a va location
 N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 I $P(PXCEAFTR(0),"^",6)'="" S PXCEINT=$P(PXCEAFTR(0),"^",6)
 E  S PXCEINT=+$$SITE^VASITE(+PXCEAFTR(0)) ;default to this site
 S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,.06,"",PXCEINT,"PXCEDILF")
 S DIR("B")=$S('$D(DIERR)&PXCEEXT]"":PXCEEXT,1:PXCEINT)
 S DIR(0)="9000010,.06A"
 S DIR("A")=$P(PXCETEXT,"~",4)
 S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 D ^DIR
 K DIR,DA
 I X="@" S Y="@"
 E  I $D(DTOUT)!$D(DUOUT) S (PXCEEND,PXCEQUIT)=1 Q  ;for visit
 ;
 S $P(PXCEAFTR(0),"^",6)=$P(Y,"^")
 S $P(PXCEAFTR(21),"^",1)=""
 S $P(PXCEAFTR(0),"^",3)="V"
 G FINISH
 ;
OUT ;This is a non va location
 I $P(PXCEAFTR(21),"^",1)'="" D
 . S DIR("B")=$P(PXCEAFTR(21),"^",1)
 S DIR(0)="9000010,2101A"
 S DIR("A")="Non VA Location of Encounter?  "
 D ^DIR
 K DIR,DA
 I X="@" S Y="@"
 E  I $D(DTOUT)!$D(DUOUT) S (PXCEEND,PXCEQUIT)=1 Q  ;for visit
 ;
 S $P(PXCEAFTR(21),"^",1)=$P(Y,"^")
 S $P(PXCEAFTR(0),"^",6)=""
 S $P(PXCEAFTR(0),"^",3)="O"
FINISH ;
 S $P(PXCEAFTR(0),"^",7)="E"
 S $P(PXCEAFTR(0),"^",22)=""
 Q
 ;
 ;********************************
 ;Display text for the .01 field which is a Date and Time.
 ;(Must have is called by ASK^PXCEVFI2 and DEL^PXCEVFI2.)
DISPLY01(PXCEVSIT) ;
 Q $$DISPLY01^PXCESIT(PXCEVSIT)
 ;
