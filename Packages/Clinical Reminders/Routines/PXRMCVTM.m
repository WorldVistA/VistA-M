PXRMCVTM ;SLC/AGP - CPRS Coversheet timer test. ;10/14/2020
 ;;2.0;CLINICAL REMINDERS;**45,42**;Feb 04, 2005;Build 245
 ;
 ;===============
EN ;Prompt for patient and reminder by name input component.
 N BOP,CLOCKE,CLOCKS,CNT,CPUTMAX,DFN,DIC,DIROUT,DIRUT,DTOUT,DUOUT
 N IDX,IENMAXC,IENMAXW,LOC,MSEC,NL,OUTPUT
 N REMIEN,REMS,TOTTM,USER,WCDIFF,WCMAX,X,Y
 S DIC=2,DIC("A")="Select Patient: "
 S DIC(0)="AEQMZ"
GPAT D ^DIC
 I $D(DIROUT)!$D(DIRUT) Q
 I $D(DTOUT)!$D(DUOUT) Q
 S DFN=+$P(Y,U)
 I DFN=-1 G GPAT
 ;
GUSER ;
 K Y
 S DIC=200,DIC("A")="Select User: "
 S DIC(0)="AEQMZ"
 D ^DIC
 I $D(DIROUT)!$D(DIRUT) Q
 I $D(DTOUT)!$D(DUOUT) Q
 S USER=+$P(Y,U)
 I USER=-1 G GUSER
 ;
GLOC ;
 K Y
 S DIC=44,DIC("A")="Select Location: "
 S DIC(0)="AEQMZ"
 D ^DIC
 I $D(DIROUT)!$D(DIRUT) Q
 I $D(DTOUT)!$D(DUOUT) Q
 S LOC=+$P(Y,U)
 I LOC=-1 G GLOC
 ;
GCVL ;
 S NL=1,OUTPUT(NL)="Patient: "_$P(^DPT(DFN,0),U,1)
 S NL=NL+1,OUTPUT(NL)="User: "_$P(^VA(200,USER,0),U,1)
 S NL=NL+1,OUTPUT(NL)="Location: "_$P(^SC(LOC,0),U,1)
 S NL=NL+1,OUTPUT(NL)=""
 S CLOCKS=$H
 D REMLIST^PXRMCVRL(.REMS,USER,LOC)
 S IDX=+$O(REMS(""))
 I IDX=0 D  G REPORT
 . S NL=NL+1,OUTPUT(NL)="There are no cover sheet reminders defined for this user and location."
 S CLOCKE=$H
 S NL=NL+1,OUTPUT(NL)="Total time to build reminder list: "_$$HDIFF^XLFDT(CLOCKE,CLOCKS,2)_" seconds"
 S (IENMAXC,IENMAXW)=$P(REMS(IDX),U,2)
 S (CNT,CPUTMAX,TOTTM,WCMAX)=0,IDX=""
 S CLOCKS=$H
 S CNT=0,IDX=""
 F  S IDX=$O(REMS(IDX)) Q:IDX=""  D
 .S REMIEN=$P(REMS(IDX),U,2)
 .D DOREM(DFN,REMIEN,0,DT,.NL,.OUTPUT,.MSEC,.WCDIFF)
 .I MSEC>CPUTMAX S CPUTMAX=MSEC,IENMAXC=REMIEN
 .S TOTTM=TOTTM+MSEC
 .I WCDIFF>WCMAX S WCMAX=WCDIFF,IENMAXW=REMIEN
 .S CNT=CNT+1
 S CLOCKE=$H
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="Total number of reminders evaluated: "_CNT
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="Elapsed wall clock time: "_$$HDIFF^XLFDT(CLOCKE,CLOCKS,2)_" seconds"
 S NL=NL+1,OUTPUT(NL)="Total CPU cover sheet evaluation time: "_TOTTM_" milliseconds"
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="Longest CPU evaluation time"
 S NL=NL+1,OUTPUT(NL)="Reminder: "_$P(^PXD(811.9,IENMAXC,0),U)_" (IEN="_IENMAXC_")"
 S NL=NL+1,OUTPUT(NL)="Reminder CPU evaluation time: "_CPUTMAX_" milliseconds"
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="Longest wall clock evaluation time"
 S NL=NL+1,OUTPUT(NL)="Reminder: "_$P(^PXD(811.9,IENMAXW,0),U)_" (IEN="_IENMAXW_")"
 S NL=NL+1,OUTPUT(NL)="Reminder wall clock evaluation time: "_WCMAX_" seconds"
 S NL=NL+1,OUTPUT(NL)=""
REPORT ; Display the report.
 S BOP=$$BORP^PXRMUTIL("B")
 I BOP="B" D
 . S X="IORESET"
 . D ENDR^%ZISS
 . D BROWSE^DDBR("OUTPUT","NR","CPRS Cover Sheet Timing Test")
 . W IORESET
 . D KILL^%ZISS
 I BOP="P" D GPRINT^PXRMUTIL("OUTPUT")
 Q
 ;
DOREM(DFN,PXRMITEM,PXRHM,DATE,NL,OUTPUT,MSEC,WCDIFF) ;Do the reminder
 ;Reference to XLFSHAN ICR #6157
 N DEFARR,END,ETIME,FIEVAL,START,WEND,WSTART
 ;This is a debugging run so set PXRMDEBG.
 S START=$$CPUTIME^XLFSHAN
 S WSTART=$H
 D DEF^PXRMLDR(PXRMITEM,.DEFARR)
 I +$G(DATE)=0 D EVAL^PXRM(DFN,.DEFARR,PXRHM,1,.FIEVAL)
 I +$G(DATE)>0 D EVAL^PXRM(DFN,.DEFARR,PXRHM,1,.FIEVAL,DATE)
 S END=$$CPUTIME^XLFSHAN
 S WEND=$H
 ;
 S WCDIFF=$$HDIFF^XLFDT(WEND,WSTART,2)
 S ETIME=$$ETIMEMS^XLFSHAN(START,END)
 S MSEC=+ETIME
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="Reminder: "_$P(^PXD(811.9,PXRMITEM,0),U)_" (IEN="_PXRMITEM_")"
 S NL=NL+1,OUTPUT(NL)="Reminder CPU evaluation time: "_ETIME
 S NL=NL+1,OUTPUT(NL)="Reminder wall clock evaluation time: "_WCDIFF_" seconds"
 Q
 ;
