PXCESK ;ISL/dee - Used to edit and display V SKIN TEST ;09/14/2015
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27,124,162,210**;Aug 12, 1996;Build 21
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
FORMAT ;;Skin Test~9000010.12~0,12,13,80,811,812~1~^AUPNVSK
 ;;0~1~.01~Skin Test:  ~Skin Test:  ~~~~~B
 ;;12~1~1201~Placement Date and Time:  ~Date/Time of Placement:  ~~~~~D
 ;;12~2~1202~Ordering Provider:  ~Ordering Provider:  ~~EPROV12^PXCEPRV~~~D
 ;;12~4~1204~Administered By: ~Administered By:  ~~EPROV12^PXCEPRV~~~D
 ;;12~12~1212~Anatomic Location: ~Anatomic Location of Placement:  ~~~~~D
 ;;811~1~81101~Placement Comments:  ~Placement Comments:  ~~~~~D
 ;;0~6~.06~Reading Date and Time:  ~Reading Date/Time:  ~~EREADDT^PXCESK~~~D
 ;;12~14~1214~Hours Read Post-Placement:  ~Hours Read Post-Placement:  ~~~~~D
 ;;0~5~.05~Reading in millimeters (mm):  ~Reading in millimeters (mm):  ~~EREADING^PXCESK~~~D
 ;;0~4~.04~Results~Results:  ~~ERESULTS^PXCESK~~~D
 ;;0~7~.07~Reader:  ~Reader:  ~~EPROV12^PXCEPRV~~~D
 ;;13~1~1301~Reading Comments:  ~Reading Comments:  ~~~~~D
 ;;80~1~801~Diagnosis:  ~Diagnosis:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~S~
 ;;80~2~802~Diagnosis 2:  ~Diagnosis 2:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~S~
 ;;80~3~803~Diagnosis 3:  ~Diagnosis 3:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~S~
 ;;80~4~804~Diagnosis 4:  ~Diagnosis 4:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~S~
 ;;80~5~805~Diagnosis 5:  ~Diagnosis 5:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~S~
 ;;80~6~806~Diagnosis 6:  ~Diagnosis 6:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~S~
 ;;80~7~807~Diagnosis 7:  ~Diagnosis 7:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~S~
 ;;80~8~808~Diagnosis 8:  ~Diagnosis 8:  ~$$DISPLY01^PXCEPOV~EPOV^PXCEVIMM~~S~
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
 S ^TMP("PXK",$J,PXCECATS,1,12,"AFTER")=PXCEAFTR(12)
 S ^TMP("PXK",$J,PXCECATS,1,13,"AFTER")=PXCEAFTR(13)
 S ^TMP("PXK",$J,PXCECATS,1,80,"AFTER")=PXCEAFTR(80)
 S ^TMP("PXK",$J,PXCECATS,1,811,"AFTER")=PXCEAFTR(811)
 Q
