PXCESK ;ISL/dee - Used to edit and display V SKIN TEST ;Mar 15, 2021@15:16:32
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27,124,162,210,211,217**;Aug 12, 1996;Build 134
 ;; ;
 Q
 ;
 ;Line with the line label "FORMAT"
 ;;Long name~File Number~Node Subscripts~Allow Duplicate entries (1=yes, 0=no)~File global name
 ;     1         2             3                   4                                   5
 ;
 ;Followning lines:
 ;;Node~Piece~,Field Number~Edit Label~Display Label~Display Routine~Edit Routine~Help Text for DIR("?")~Set of PXCEKEYS that can Edit~D if Detail Display Only~
 ;  1  ~  2  ~      3      ~     4    ~        5    ~        6      ~     7      ~       8              ~          9                  ~       10
 ;The Display & Edit routines are for special caces.
 ;  (The .01 field cannot have a special edit.)
 ;
 ;***Reading (.05) must be the line before Results (.04)***
 ;Adding/editing diagnosis removed in PX*1.0*211, reference to
 ;EPOV^PXCEVIMM replaced by SKIP^PXCESK.
 ;
FORMAT ;;Skin Test~9000010.12~0,12,13,80,811,812~1~^AUPNVSK
 ;;0~1~.01~Skin Test:  ~Skin Test:  ~$$DISPLYSK^PXCESK~~~~B
 ;;12~1~1201~Placement Date and Time:  ~Date/Time of Placement:  ~~EVENTDT^PXCESK(.PXCEAFTR)~~~D
 ;;12~2~1202~Ordering Provider:  ~Ordering Provider:  ~~EPROV12^PXCEPRV~~~D
 ;;12~4~1204~Administered By: ~Administered By:  ~~EPROV12^PXCEPRV~~~D
 ;;12~12~1212~Anatomic Location: ~Anatomic Location of Placement:  ~~~~~D
 ;;811~1~81101~Placement Comments:  ~Placement Comments:  ~~~~~D
 ;;812~2~81202~Package:  ~Package: ~~SKIP^PXCESK~~~D
 ;;812~3~81203~Data Source:  ~Data Source: ~~SKIP^PXCESK~~~D
 ;;0~6~.06~Reading Date and Time:  ~Reading Date/Time:  ~~EREADDT^PXCESK~~~D
 ;;12~14~1214~Hours Read Post-Placement:  ~Hours Read Post-Placement:  ~~~~~D
 ;;0~5~.05~Reading in millimeters (mm):  ~Reading in millimeters (mm):  ~~EREADING^PXCESK~~~D
 ;;0~4~.04~Results~Results:  ~~ERESULTS^PXCESK~~~D
 ;;0~7~.07~Reader:  ~Reader:  ~~EPROV12^PXCEPRV~~~D
 ;;13~1~1301~Reading Comments:  ~Reading Comments:  ~~~~~D
 ;;80~1~801~Diagnosis:  ~Diagnosis:  ~$$DISPLY01^PXCEPOV~SKIP^PXCESK~~S~
 ;;80~2~802~Diagnosis 2:  ~Diagnosis 2:  ~$$DISPLY01^PXCEPOV~SKIP^PXCESK~~S~
 ;;80~3~803~Diagnosis 3:  ~Diagnosis 3:  ~$$DISPLY01^PXCEPOV~SKIP^PXCESK~~S~
 ;;80~4~804~Diagnosis 4:  ~Diagnosis 4:  ~$$DISPLY01^PXCEPOV~SKIP^PXCESK~~S~
 ;;80~5~805~Diagnosis 5:  ~Diagnosis 5:  ~$$DISPLY01^PXCEPOV~SKIP^PXCESK~~S~
 ;;80~6~806~Diagnosis 6:  ~Diagnosis 6:  ~$$DISPLY01^PXCEPOV~SKIP^PXCESK~~S~
 ;;80~7~807~Diagnosis 7:  ~Diagnosis 7:  ~$$DISPLY01^PXCEPOV~SKIP^PXCESK~~S~
 ;;80~8~808~Diagnosis 8:  ~Diagnosis 8:  ~$$DISPLY01^PXCEPOV~SKIP^PXCESK~~S~
 ;;
 ;
 ;The interface for AICS to get list on form for help.
INTRFACE ;;PX SELECT SKIN TEST
 ;
 ;********************************
 ;Special cases for display.
 ;
 ;********************************
 ;Special cases for edit.
 ;
EREADING ;
 I $P(PXCEAFTR(0),"^",5)'="" D
 . N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 . S PXCEINT=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 . S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 . S DIR("B")=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 S DIR(0)="NAO^0:40:0"
 S DIR("A")=$P(PXCETEXT,"~",4)
 S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 D ^DIR
 K DIR,DA
 I X="@" S Y="@"
 E  I $D(DTOUT)!$D(DUOUT) S PXCEEND=1 Q
 S $P(PXCEAFTR(0),"^",5)=$P(Y,"^")
 Q
 ;
EREADDT ;
 N PXVPLACE
 I $P(PXCEAFTR(0),"^",6)'="" D
 . N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 . S PXCEINT=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 . S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 . S DIR("B")=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 S DIR(0)="9000010.12,.06AO"
 S DIR("A")=$P(PXCETEXT,"~",4)
 S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 D ^DIR
 K DIR,DA
 I X="@" S Y="@"
 E  I $D(DTOUT)!$D(DUOUT) S PXCEEND=1 Q
 S $P(PXCEAFTR(0),"^",6)=$P(Y,"^")
 N PXVX,X1,X2,X3
 S X1=$P(PXCEAFTR(0),"^",6) ; DATE READ
 S X2=$P(PXCEAFTR(12),"^") ; EVENT DATE AND TIME
 I X2="" S X2=$P($G(^AUPNVSIT(+$P(PXCEAFTR(0),U,3),0)),U,1)
 S PXVPLACE=$P(PXCEAFTR(12),U,8) ; PLACEMENT SKIN TEST
 I PXVPLACE D
 . S X2=$P($G(^AUPNVSK(PXVPLACE,12)),U)
 . I X2="" S X2=$P($G(^AUPNVSIT(+$P($G(^AUPNVSK(PXVPLACE,0)),U,3),0)),U,1)
 S X3=2 ; return difference in seconds
 S PXVX=""
 I $G(X1),$L(X1)>7,$G(X2),$L(X2)>7,$G(X2)'>$G(X1) S PXVX=$$FMDIFF^XLFDT(X1,X2,X3)\3600
 I PXVX D EN^DDIOL("Hours Read Post-Placement:  "_PXVX,"","!")
 Q
 ;
ERESULTS ;
 I $P(PXCEAFTR(0),"^",4)'="" D
 . N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 . S PXCEINT=$P(PXCEAFTR($P(PXCETEXT,"~",1)),"^",$P(PXCETEXT,"~",2))
 . S PXCEEXT=$$EXTERNAL^DILFD(PXCEFILE,$P(PXCETEXT,"~",3),"",PXCEINT,"PXCEDILF")
 . S DIR("B")=$S('$D(DIERR):PXCEEXT,1:PXCEINT)
 S DIR(0)="SOM^P:POSITIVE;N:NEGATIVE;D:DOUBTFUL;O:NO TAKE"
 S DIR("A")=$P(PXCETEXT,"~",4)
 S:$P(PXCETEXT,"~",8)]"" DIR("?")=$P(PXCETEXT,"~",8)
 D ^DIR
 K DIR,DA
 I X="@" S Y="@"
 E  I $D(DTOUT)!$D(DUOUT) S PXCEEND=1 Q
 S $P(PXCEAFTR(0),"^",4)=$P(Y,"^")
 Q
 ;
 ;********************************
EVENTDT(PXCEAFTR) ;Edit the Event Date and Time.
 N DEFAULT,EVENTDT,HELP,IEN,PROMPT
 S DEFAULT=$P(^TMP("PXK",$J,"SK",1,12,"BEFORE"),U,1)
 S HELP="D EVDTHELP^PXCESK"
 S PROMPT="Placement Date and Time"
 S EVENTDT=$$GETDT^PXDATE(-1,-1,-1,DEFAULT,PROMPT,HELP)
 S $P(PXCEAFTR(12),U,1)=EVENTDT
 Q
 ;
 ;********************************
EVDTHELP ;Event Date and Time help.
 N ERR,RESULT,TEXT
 S RESULT=$$GET1^DID(9000010.12,1201,"","DESCRIPTION","TEXT","ERR")
 D BROWSE^DDBR("TEXT(""DESCRIPTION"")","NR","V Skin Test Placement Date and Time Help")
 I $D(DDS) D REFRESH^DDSUTL S DY=IOSL-7,DX=0 X IOXY S $Y=DY,$X=DX
 Q
 ;
 ;********************************
 ;Display text for the .01 field which is a pointer to Skin Test.
 ;(Must have is called by ASK^PXCEVFI2 and DEL^PXCEVFI2.)
DISPLY01(PXCESK,PXCEDT) ;
 N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 S PXCEINT=$P(PXCESK,"^",1)
 S PXCEEXT=$$EXTERNAL^DILFD(9000010.12,.01,"",PXCEINT,"PXCEDILF")
 Q $S('$D(DIERR):PXCEEXT,1:PXCEINT)
 ;
 ;********************************
 ;
SAVE ;Special code for saving a Skin Test.
 N PXCERR
 S PXCERR=$P(^TMP("PXK",$J,PXCECATS,1,0,"AFTER"),"^",4,5)
 Q:PXCERR="^"
 I $P(PXCERR,"^",1)'=$P(^TMP("PXK",$J,PXCECATS,1,0,"BEFORE"),"^",4) S $P(^TMP("PXK",$J,PXCECATS,1,0,"AFTER"),"^",4)="@"
 I $P(PXCERR,"^",2)'=$P(^TMP("PXK",$J,PXCECATS,1,0,"BEFORE"),"^",5) S $P(^TMP("PXK",$J,PXCECATS,1,0,"AFTER"),"^",5)="@"
 D EN1^PXKMAIN
 S ^TMP("PXK",$J,PXCECATS,1,0,"AFTER")=PXCEAFTR(0)
 S ^TMP("PXK",$J,PXCECATS,1,12,"AFTER")=PXCEAFTR(12)
 S ^TMP("PXK",$J,PXCECATS,1,13,"AFTER")=PXCEAFTR(13)
 S ^TMP("PXK",$J,PXCECATS,1,80,"AFTER")=PXCEAFTR(80)
 S ^TMP("PXK",$J,PXCECATS,1,811,"AFTER")=PXCEAFTR(811)
 Q
 ;********************************
SKIP ;Used to by-pass roll and scroll editing of a field.
 S (X,Y)=""
 Q
 ;
 ;********************************
 ; When adding a new skin test entry, prompt if recording placement, reading, or both.
 ;   if recording reading, prompt to select corresponding placement entry.
NEW(PXCESKTYP,PXCEAFTR,PXCEPAT,PXCEVIEN) ;
 ;
 N DIR,DIRUT,PXCEEND,PXDATE,PXEND,PXNODE,PXSKIN,PXSKINNM,PXSKINP,PXSKINPDT,PXSKLST,PXSTART,X,Y
 ;
 S PXCEEND=0
 ;
 ; For Historical, set both placement and reading fields.
 I $P($G(^AUPNVSIT(+PXCEVIEN,0)),U,7)="E" D  Q 0
 . S PXCESKTYP="B"
 ;
 W !
 S DIR(0)="SA^A:ADMINISTRATION;R:READING;B:BOTH"
 S DIR("A")="Are you recording a skin test (A)dministration, (R)eading, or (B)oth? "
 D ^DIR
 ;
 I $D(DIRUT)!(Y'?1(1"A",1"R",1"B")) Q 1
 S PXCESKTYP=Y
 ;
 I Y'="R" Q PXCEEND
 ;
 S PXDATE=$P($G(^AUPNVSIT(+PXCEVIEN,0)),U,1)
 S PXSKIN=$P(PXCEAFTR(0),U,1)
 S PXSKINNM=$P($G(^AUTTSK(+PXSKIN,12)),U,1)
 I PXSKINNM="" S PXSKINNM=$P($G(^AUTTSK(+PXSKIN,0)),U,1)
 D SKLIST^PXVRPC8(.PXSKLST,PXCEPAT,PXSKIN,PXDATE,1)
 S PXNODE=$G(PXSKLST(1))
 S PXSTART=""
 S PXEND=""
 I $P(PXNODE,U,1)="DATERANGE" D
 . S PXSTART=$P(PXNODE,U,2)
 . S PXEND=$P(PXNODE,U,3)
 S PXNODE=$G(PXSKLST(2))
 S PXSKINPDT=""
 I $P(PXNODE,U,1)="PLACEMENT" D
 . S PXSKINPDT=$P(PXNODE,U,5)
 . S PXSKINP=$P(PXNODE,U,2)
 ;
 I 'PXSKINPDT D  Q 1
 . W !!,"We could not find a "_PXSKINNM_" skin test administered between "_$$FMTE^XLFDT(PXSTART,"D")
 . W !,"and "_$$FMTE^XLFDT(PXEND,"D")_" that does not already have a reading."
 . D WAIT^PXCEHELP
 ;
 K DIRUT,DIR,Y,X
 S DIR(0)="Y"
 S DIR("B")="YES"
 W !!,"Is this reading for the "_PXSKINNM_" skin test administered on"
 S DIR("A")=$$FMTE^XLFDT(PXSKINPDT,"M")
 D ^DIR
 ;
 I $D(DIRUT)!(Y'?1(1"1",1"0")) Q 1
 I Y D
 . W !!,"We will link this skin test reading to that placement entry.",!
 . H 1
 . S $P(PXCEAFTR(12),U,8)=PXSKINP
 I 'Y D
 . S PXCEEND=1
 . W !!,"You must first record the skin test placement before recording the reading."
 . D WAIT^PXCEHELP
 ;
 Q PXCEEND
 ;
 ;********************************
 ; Check if this is a placement or reading entry
EDIT(PXCESKTYP,PXCEAFTR,PXCEFIEN) ;
 I $P(PXCEAFTR(12),U,8) S PXCESKTYP="R" Q 0
 I $O(^AUPNVSK("APT",PXCEFIEN,0)) S PXCESKTYP="A" Q 0
 Q 0
 ;
 ;********************************
 ; Check if user should be prompted for this field.
 ; Depends on if PXCESKTYP is (A)dministration/(R)eading/(B)oth.
PROMPT(PXCESKTYP,PXFIELD) ;
 ;
 N PXPLACE,PXREAD
 ;
 I $G(PXCESKTYP)?1(1"",1"B") Q 1
 ;
 ; Placement fields
 S PXPLACE="^.01^.02^.03^1201^1202^1204^1211^1212^81101^81202^81203^"
 ;
 ; Reading fields
 S PXREAD="^.01^.02^.03^.04^.05^.06^.07^1208^1214^1220^1301^81202^81203^"
 ;
 I PXCESKTYP="A",PXPLACE[(U_PXFIELD_U) Q 1
 I PXCESKTYP="R",PXREAD[(U_PXFIELD_U) Q 1
 ;
 Q 0
 ;
 ;********************************
 ; Can this skin test entry be deleted?
CANDEL(PXCEFIEN) ;
 ;
 I '$D(^AUPNVSK("APT",PXCEFIEN)) Q 1
 ;
 W !!,"There is a skin test reading linked to this entry. "
 W !,"You must first delete the skin test reading entry (#"_$O(^AUPNVSK("APT",PXCEFIEN,0))_")"
 W !,"before deleting this placement entry."
 D WAIT^PXCEHELP
 ;
 Q 0
 ;
 ;
DISPLYSK(PXCESK,PXCEDT) ;Display the skin test.
 N PXREADTYP,PXTEXT
 S PXCESK=+PXCESK
 S PXTEXT=$P($G(^AUTTSK(PXCESK,0)),U,1)
 ;
 S PXREADTYP=""
 I $P($G(^AUPNVSK(+$G(IEN),12)),U,8) S PXREADTYP="R"
 I $O(^AUPNVSK("APT",+$G(IEN),0)) S PXREADTYP="A"
 S PXTEXT=PXTEXT_$S(PXREADTYP="R":" (Reading)",PXREADTYP="A":" (Placement)",1:"")
 ;
 Q PXTEXT
