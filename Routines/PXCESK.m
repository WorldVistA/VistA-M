PXCESK ;ISL/dee - Used to edit and display V SKIN TEST ;3/11/04 1:49pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27,124,162**;Aug 12, 1996
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
 ;
FORMAT ;;Skin Test~9000010.12~0,12,811,812~1~^AUPNVSK
 ;;0~1~.01~Skin Test:  ~Skin Test:  ~~~~~B
 ;;0~5~.05~Reading in mm:  ~Reading in mm:  ~~EREADING^PXCESK~~~D
 ;;0~4~.04~Results~Results:  ~~ERESULTS^PXCESK~~~D
 ;;12~1~1201~Administered Date and (optional) Time~Date/Time of Administered:  ~~E1201^PXCEPOV1(0,30,30)~~~D
 ;;0~6~.06~Reading Date and (optional) Time~Reading Date:  ~~E1201^PXCEPOV1(0,30,60)~~~D
 ;;12~4~1204~Reader:  ~Reader:  ~~EPROV12^PXCEPRV~~~D
 ;;811~1~81101~Comments:  ~Comments:  ~~~~~D
 ;;0~8~.08~Diagnosis:  ~Diagnosis:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
 ;;0~9~.09~Diagnosis 2:  ~Diagnosis 2:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
 ;;0~10~.1~Diagnosis 3:  ~Diagnosis 3:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
 ;;0~11~.11~Diagnosis 4:  ~Diagnosis 4:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
 ;;0~12~.12~Diagnosis 5:  ~Diagnosis 5:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
 ;;0~13~.13~Diagnosis 6:  ~Diagnosis 6:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
 ;;0~14~.14~Diagnosis 7:  ~Diagnosis 7:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
 ;;0~15~.15~Diagnosis 8:  ~Diagnosis 8:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~~
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
 ;Display text for the .01 field which is a pointer to Skin Test.
 ;(Must have is called by ASK^PXCEVFI2 and DEL^PXCEVFI2.)
DISPLY01(PXCESK) ;
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
 Q
