PXCECSTP ;ISL/dee - Used to add a new visit from a secondary credit stop for a main visit in the Update Encounter display ;7/30/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**22**;Aug 12, 1996
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
FORMAT ;;Stop Code~9000010~0,21,150,800,811,812~~^AUPNVSIT
 ;;0~1~.01~Encounter Date and Time:  ~Encounter Date and Time:  ~~EVISITDT^PXCEVSIT(1)~~~
 ;;0~8~.08~Stop Code:  ~Stop Code:  ~$$DISPLY08^PXCECSTP~EWORKLOD^PXCECSTP~~~B
 ;;
 ;
 ;********************************
 ;Special cases for display of visit are in PXCEVSIT.
 ;
 ;********************************
 ;Special cases for edit of visit are in PXCEVSIT.
 ;
EWORKLOD ;
 I $P(PXCEAFTR(0),"^",7)="E" D  Q
 . W !,"Historical Encounters cannot have Stop Codes."
 . D WAIT^PXCEHELP
 . S (PXCEEND,PXCEQUIT,PXCELOOP)=1
 N DIC,DA,PXCANODE
 I $P(PXCEAFTR(150),"^",3)="P"!(PXCEFIEN'>0) D
 . S PXCEAFTR(0)=$P(PXCEAFTR(0),"^",1)_"^^^^"_$P(PXCEAFTR(0),"^",5,6)_"^^^^^^"_PXCEVIEN_"^^^^^^^^^"_$P(PXCEAFTR(0),"^",21,22)
 . S PXCEAFTR(150)="^"_$P(PXCEAFTR(150),"^",2)_"^S"
 . S PXCEAFTR(800)=""
 . S PXCEAFTR(811)=""
 . S PXCEAFTR(812)="^"_PXCEPKG_"^"_PXCESOR
 . F PXCENODE=0,21,150,800,811,812 S ^TMP("PXK",$J,"VST",1,PXCENODE,"BEFORE")=""
 . S ^TMP("PXK",$J,"VST",1,"IEN")=""
 S $P(PXCEAFTR(0),"^",1)=+^AUPNVSIT(PXCEVIEN,0)
EWORKLD2 ;
 K DTOUT,DUOUT,DIC
 I $P(PXCEAFTR(0),"^",8)]"" D
 . N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 . S PXCEINT=$P(PXCEAFTR(0),"^",8)
 . S Y=+PXCEINT
 . S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 . S DIC("B")=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 S DIC="^DIC(40.7,"
 S DIC(0)="AEMQ"
 S DIC("S")="I ($P(^(0),U,3)=""""!($P(^(0),U,3)'<$P(PXCEAFTR(0),U)))&($P(^(0),U,2)'=900)"
 S DIC("A")=$P(PXCETEXT,"~",4)
 D ^DIC
 K DIR,DA
 I +Y'>0!$D(DTOUT)!$D(DUOUT) S (PXCEEND,PXCEQUIT,PXCELOOP,PXCENOER)=1 Q
 S $P(PXCEAFTR(0),"^",8)=+Y
 Q
 ;
 ;********************************
 ;Display text for the .01 field which is a Date and Time.
 ;(Must have is called by ASK^PXCEVFI2 and DEL^PXCEVFI2.)
DISPLY01(PXCEVSIT) ;
 S PXCESC=$P(PXCEVSIT,"^",8)
 Q:PXCESC<1 ""
 G DISPLAY
 ;
DISPLY08(PXCESC) ;
DISPLAY N DIC,DR,DA,DIQ,PXCEDIQ1
 S DIC=40.7
 S DR=".01;1"
 S DA=PXCESC
 S DIQ="PXCEDIQ1"
 S DIQ(0)="E"
 D EN^DIQ1
 Q $J($G(PXCEDIQ1(40.7,DA,1,"E")),3)_"  "_$G(PXCEDIQ1(40.7,DA,.01,"E"))
 ;
