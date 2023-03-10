PXCEXAM ;ISL/dee,PKR - Used to edit and display V EXAM ;04/25/2022
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27,211,217**;Aug 12, 1996;Build 134
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
FORMAT ;;Exam~9000010.13~0,12,220,811,812~1~^AUPNVXAM
 ;;0~1~.01~Exam:  ~Exam:  ~~~~~B
 ;;0~4~.04~Results:  ~Results:  ~~~~~D
 ;;12~1~1201~Event Date and Time:  ~Event Date and Time: ~~EVENTDT^PXCEXAM(.PXCEAFTR)~~~D
 ;;12~4~1204~Encounter Provider:  ~Encounter Provider:  ~~EPROV12^PXCEPRV~~~D
 ;;220~1~220~Magnitude: ~Magnitude: ~~MEAS^PXCEXAM(.PXCEAFTR)~~~D
 ;;220~2~221~UCUM Code: ~UCUM Description: ~~SKIP^PXCEXAM~~~D
 ;;811~1~81101~Comments:  ~Comments:  ~~~~~D
 ;;812~2~81202~Package:  ~Package: ~~SKIP^PXCEXAM~~~D
 ;;812~3~81203~Data Source:  ~Data Source: ~~SKIP^PXCEXAM~~~D
 ;;
 ;
 ;The interface for AICS to get list on form for help.
INTRFACE ;;PX SELECT EXAMS
 ;********************************
 ;Special cases for display.
 ;
 ;********************************
 ;Special cases for edit.
 ;
 ;
 ;********************************
 ;Display text for the .01 field which is a pointer to Skin Test.
 ;(Must have is called by ASK^PXCEVFI2 and DEL^PXCEVFI2.)
DISPLY01(PXCEXAM,PXCEDT) ;
 N DIERR,PXCEDILF,PXCEINT,PXCEEXT
 S PXCEINT=$P(PXCEXAM,"^",1)
 S PXCEEXT=$$EXTERNAL^DILFD(9000010.13,.01,"",PXCEINT,"PXCEDILF")
 Q $S('$D(DIERR):PXCEEXT,1:PXCEINT)
 ;
 ;********************************
EVENTDT(PXCEAFTR) ;Edit the Event Date and Time.
 N DEFAULT,EVENTDT,HELP,IEN,PROMPT
 S IEN=+$P(^TMP("PXK",$J,"XAM",1,0,"BEFORE"),U,1)
 I (IEN>0),$$ISMAPPED^PXEXMGR(IEN) D  Q
 . W !,"The exam has mapped codes so the Event Date and Time cannot be edited.",!
 S DEFAULT=$P(^TMP("PXK",$J,"XAM",1,12,"BEFORE"),U,1)
 S HELP="D EVENTDTHELP^PXCEXAM"
 S PROMPT="Enter the Event Date and Time"
 S EVENTDT=$$GETDT^PXDATE(-1,-1,-1,DEFAULT,PROMPT,HELP)
 S $P(PXCEAFTR(12),U,1)=EVENTDT
 Q
 ;
 ;********************************
EVENTDTHELP ;Event Date and Time help.
 N ERR,RESULT,TEXT
 S RESULT=$$GET1^DID(9000010.13,1201,"","DESCRIPTION","TEXT","ERR")
 D BROWSE^DDBR("TEXT(""DESCRIPTION"")","NR","V Exam Event Date and Time Help")
 I $D(DDS) D REFRESH^DDSUTL S DY=IOSL-7,DX=0 X IOXY S $Y=DY,$X=DX
 Q
 ;
 ;********************************
MEAS(PXCEAFTR) ;Edit the measurement.
 N EXAMCHG,MAX,MAXDEC,MIN,MPARMS,PXAERR,UCUMCODE,UCUMIEN,UNITS,XAMIEN,XAMIENO
 S XAMIENO=$P(PXCEVFIN(0),U,1)
 S XAMIEN=$P(PXCEAFTR(0),U,1)
 S EXAMCHG=$S(XAMIEN'=XAMIENO:1,1:0)
 S MPARMS=$G(^AUTTEXAM(XAMIEN,220))
 I MPARMS="" Q
 S MIN=$P(MPARMS,U,1)
 I MIN="" Q
 S MAX=$P(MPARMS,U,2)
 I MAX="" Q
 S MAXDEC=+$P(MPARMS,U,3)
 S UCUMIEN=$P(MPARMS,U,4)
 S UCUMCODE=$$UCUMCODE^LEXMUCUM(UCUMIEN)
 S UNITS=$$UCUMFIELDS^PXUCUM(UCUMIEN,"DESCRIPTION")
 N DIR,DIRUT,X,Y
 I UCUMCODE="{clock_time}" D
 . S DIR(0)="FAO^6:7^K:'$$MAG^PXAIVAL(X,MPARMS,.PXAERR) X"
 . S DIR("A",1)="Enter clock time as HH:MMAM or HH:MMPM"
 I UCUMCODE="{mm/dd/yyyy}" D
 . S DIR(0)="FAO^10:10^K:'$$MAG^PXAIVAL(X,MPARMS,.PXAERR) X"
 . S DIR("A",1)="Enter month-day-year as MM/DD/YYYY"
 I (UCUMCODE'="{clock_time}"),(UCUMCODE'="{mm/dd/yyyy}") D
 . S DIR(0)="NAO^"_MIN_":"_MAX_":"_MAXDEC_"^K:$$MAXDECEX^PXMEASUREMENT(X,MAXDEC) X"
 . S DIR("A",1)="Enter the magnitude, the allowed range is "_MIN_" to "_MAX
 . S DIR("A",2)="The maximum number of decimal digits is "_MAXDEC
 . S DIR("A",3)="The units are: "_UNITS
 S DIR("A")="The current value is: "
 I EXAMCHG S $P(PXCEAFTR(220),U,1)=""
 S DIR("B")=$P(PXCEAFTR(220),U,1)
 D ^DIR
 I $D(DIRUT) Q
 S X=$$MAGFORMAT^PXMEASUREMENT(X)
 S PXCEAFTR(220)=X_U_UCUMIEN
 Q
 ;
 ;********************************
SKIP ;Used to by-pass roll and scroll editing of a field.
 S (X,Y)=""
 Q
 ;
