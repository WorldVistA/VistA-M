PXCEHF ;ISL/dee - Used to edit and display V HEALTH FACTORS ;01/06/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27,22,211**;Aug 12, 1996;Build 84
 ;; ;
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
FORMAT ;;Health Factors~9000010.23~0,12,220,811,812~1~^AUPNVHF
 ;;0~1~.01~Health Factor:  ~Health Factor:  ~~~~~~B
 ;;0~4~.04~Level/Severity:  ~Level/Severity:  ~~~~~~D
 ;;220~1~220~Magnitude: ~Magnitude: ~~MEAS^PXCEHF(.PXCEAFTR)~~~D
 ;;220~2~221~UCUM Code: ~UCUM Descriptione: ~~SKIP^PXCEHF~~~D
 ;;811~1~81101~Comments:  ~Comments:  ~~~~~D
 ;;
 ;Do not ask the following.
 ;;12~1~1201~Event Date and (optional) Time~Event Date and Time:  ~~E1201^PXCEPOV1(0,30,30)~~~D
 ;;12~2~1202~Ordering Provider:  ~Ordering Provider:  ~~EPROV12^PXCEPRV~~P~D
 ;;12~4~1204~Encounter Provider:  ~Encounter Provider:  ~~EPROV12^PXCEPRV~~~D
 ;
 ;The interface for AICS to get list on form for help.
INTRFACE ;;PX SELECT HEALTH FACTORS
 ;
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
DISPLY01(PXCEHF) ;
 N DIERR,PXCEDILF,PXCEEXT,PXCEINT
 S PXCEINT=$P(PXCEHF,"^",1)
 S PXCEEXT=$$EXTERNAL^DILFD(9000010.23,.01,"",PXCEINT,"PXCEDILF")
 Q $S('$D(DIERR):PXCEEXT,1:PXCEINT)
 ;
 ;********************************
MEAS(PXCEAFTR) ;Edit the measurement.
 N HFCHG,HFIEN,HFIENO,MAX,MAXDEC,MIN,TEMP,UCUMCODE,UCUMIEN
 S HFIENO=$P(PXCEVFIN(0),U,1)
 S HFIEN=$P(PXCEAFTR(0),U,1)
 S HFCHG=$S(HFIEN'=HFIENO:1,1:0)
 S TEMP=$G(^AUTTHF(HFIEN,220))
 I TEMP="" Q
 S MIN=$P(TEMP,U,1)
 I MIN="" Q
 S MAX=$P(TEMP,U,2)
 I MAX="" Q
 S MAXDEC=+$P(TEMP,U,3)
 S UCUMIEN=$P(TEMP,U,4)
 ;DBIA #6225
 S UCUMCODE=$S(UCUMIEN="":"",1:$$UCUMCODE^LEXMUCUM(UCUMIEN))
 N DIR,DIRUT,X,Y
 S DIR(0)="NA^"_MIN_":"_MAX_":"_MAXDEC
 I UCUMCODE'="" S DIR("A",2)="The units are: "_UCUMCODE
 S DIR("A",1)="Enter the measurment, the allowed range is "_MIN_" to "_MAX
 S DIR("A",2)="The maximum number of decimal digits is "_MAXDEC
 S DIR("A")="The current value is: "
 I HFCHG S $P(PXCEAFTR(220),U,1)=""
 S DIR("B")=$P(PXCEAFTR(220),U,1)
 D ^DIR
 I $D(DIRUT) Q
 S PXCEAFTR(220)=X_U_UCUMIEN
 Q
 ;
 ;********************************
SKIP ;Used to by-pass roll and scroll editing of a field.
 S (X,Y)=""
 Q
 ;
