PXCEICR ;BHM/ADM - EDIT/DISPLAY CONTRAINDICATION/REFUSAL ;02/01/2016
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**215**;Aug 12, 1996;Build 10
 ;
 Q
 ;
 ;Line with the line label "FORMAT"
 ;;Long name~File Number~Node Subscripts~Allow Duplicate entries (1=yes, 0=no)~File global name
 ;     1         2             3                   4                                   5
 ;
 ;Following lines:
 ;;Node~Piece~,Field Number~Edit Label~Display Label~Display Routine~Edit Routine~Help Text for DIR("?")~Set of PXCEKEYS that can Edit~D if Detail Display Only~
 ;  1  ~  2  ~      3      ~     4    ~        5    ~        6      ~     7      ~       8              ~          9                  ~       10
 ;The Display & Edit routines are for special cases.
 ;  (The .01 field cannot have a special edit.)
 ;
FORMAT ;;Imm Contraindication/Refusal Event~9000010.707~0,12,801,811,812~1~^AUPNVICR
 ;;0~1~.01~Contraindication/Refusal:  ~Contra/Refusal Event:  ~~~~~B
 ;;0~4~.04~Immunization:  ~Immunization:  ~~EIMM^PXCEICR~~~D
 ;;12~1~1201~Event Date and Time: ~Event Date and Time: ~~~~~D
 ;;12~4~1204~Encounter Provider:  ~Encounter Provider:  ~~EPROV12^PXCEPRV~~~D
 ;;0~5~.05~Warning Until Date:  ~Warning Until Date:  ~~~~~D
 ;;0~6~.06~Date/Time Recorded: ~Date/Time Recorded:  ~~~~~D
 ;;811~1~81101~Comments:  ~Comments:  ~~~~~D
 ;;
 ;
 ;********************************
 ;Display text for the .01 field
 ;(Must have is called by ASK^PXCEVFI2 and DEL^PXCEVFI2.)
DISPLY01(PXCEICR) ;
 N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 S PXCEINT=$P(PXCEICR,"^",1)
 S PXCEEXT=$$EXTERNAL^DILFD(9000010.707,.01,"",PXCEINT,"PXCEDILF")
 Q $S('$D(DIERR):PXCEEXT,1:PXCEINT)
 ;
EIMM ; Edit Immunization
 N DA,DIR,DTOUT,DUOUT,X,Y
 I $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))'="" D
 . N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 . S PXCEINT=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 . S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 . S DIR("B")=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 S DIR(0)="PA^9999999.14:QEM"
 S DIR("S")="I $$IMMCRSEL^PXVUTIL($P($G(PXCEAFTR(0)),U,1),Y)"
 S DIR("A")=$P(PXCETEXT,"~",4)
 S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 D ^DIR
 I X="@" S Y="@"
 E  I $D(DTOUT)!$D(DUOUT) S PXCEEND=1
 S $P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))=$P(Y,"^")
 Q
 ;
CONTRA ;
 Q:'$G(PXCEPAT)!'+$G(PXD)
 N PXCNT,PXD1,PXEXT,PXIEN,PXRESULT,PXVJFLG,PXWUD
 S (PXVACK,PXCNT)=0,PXD1=+PXD,PXJUST=""
 D PATICR^PXAPIIM(.PXRESULT,PXCEPAT,PXD1)
 I '$O(PXRESULT(0)) Q
 S PXIEN=0 F  S PXIEN=$O(PXRESULT(PXIEN)) Q:'PXIEN  D CHK
 I PXCNT S PXCONTRA=1 D
 . I $P($G(PXCEAFTR("12")),"^",20) D JUST I PXVJFLG S PXVACK=1 Q
 . K DIR S DIR("A",1)=""
 . S DIR("A")="Acknowledge warning and proceed with administration",DIR(0)="Y",DIR("B")="NO"
 . S DIR("?",1)="Enter YES to acknowledge a warning of contraindication/refusal events"
 . S DIR("?")="associated with this immunization and to proceed with administration." D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT)!'Y Q
 . I Y D JUST I PXVJFLG S PXVACK=1 Q
 Q
CHK ;
 S PXWUD=$P(PXRESULT(PXIEN),"^",4) I $G(PXWUD),$G(PXWUD)<DT Q
 S PXCNT=PXCNT+1 I PXCNT=1 D WARN
 S PXEXT=$P($P(PXRESULT(PXIEN),"^",2),"|",2)
 I $G(PXWUD) S Y=PXWUD D DD^%DT S PXEXT=PXEXT_"  (Until "_Y_")"
 D EN^DDIOL(PXEXT,,"!,?4")
 N PXC S PXC=$G(PXRESULT(PXIEN,"COMMENTS")) I $L(PXC) S PXC="COMMENT: "_PXC D EN^DDIOL(PXC,,"!,?6")
 Q
WARN ;
 N PXX S PXX=$C(7)_"WARNING!" D EN^DDIOL(PXX,,"!!")
 D EN^DDIOL("Contraindication/refusal event(s) associated with this immunization:",,"!,?2")
 Q
JUST ; enter comment concerning override of warning
 S PXVJFLG=0
 K DIR I $D(PXCEAFTR("16")) S DIR("B")=$P(PXCEAFTR("16"),"^")
 S DIR("A")="Warning Override Justification",DIR(0)="9000010.11,1601" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S:Y="^" PXJUST="@" Q
 I Y="" D EN^DDIOL("Override justification entry is required to proceed with administration.",,"!,?2") G JUST
 S PXJUST=Y,PXVJFLG=1
 Q
