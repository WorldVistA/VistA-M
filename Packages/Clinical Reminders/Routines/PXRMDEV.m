PXRMDEV ;SLC/PKR - This is a driver for testing Clinical Reminders. ;11/29/2011
 ;;2.0;CLINICAL REMINDERS;**4,6,11,16,18**;Feb 04, 2005;Build 152
 ;
 ;==================================================
CMOUT ;Do formatted Clinical Maintenance output.
 N DUE,DUECOL,HIST,LAST,LASTCOL,LNUM,RIEN,RNAME,STATUS,STATCOL,TEMP,TYPE
 W !!,"Formatted Output:"
 S RIEN=$O(^TMP("PXRHM",$J,""))
 S RNAME=$O(^TMP("PXRHM",$J,RIEN,""))
 S TEMP=$G(^TMP("PXRHM",$J,RIEN,RNAME))
 S STATUS=$P(TEMP,U,1)
 S DUE=$$DDATE^PXRMDATE($P(TEMP,U,2))
 S LAST=$$DDATE^PXRMDATE($P(TEMP,U,3))
 S STATCOL=41-($L(STATUS)/2)
 S DUECOL=53-($L(DUE)/2)
 S LASTCOL=67-($L(LAST)/2)
 W !!,?36,"--STATUS--",?47,"--DUE DATE--",?61,"--LAST DONE--",!
 W !,RNAME,?STATCOL,STATUS,?DUECOL,DUE,?LASTCOL,LAST,!
 S LNUM=0
 F  S LNUM=$O(^TMP("PXRHM",$J,RIEN,RNAME,"TXT",LNUM)) Q:LNUM=""  D
 . W !,^TMP("PXRHM",$J,RIEN,RNAME,"TXT",LNUM)
 Q
 ;
 ;==================================================
DEB ;Prompt for patient and reminder by name input component.
 N DATE,DFN,DIC,DIR,DIROUT,DTOUT,DUOUT,PXRMITEM,PXRHM,PXRMTDEB,X,Y
 S DIC=2,DIC("A")="Select Patient: "
 S DIC(0)="AEQMZ"
 D ^DIC
 I $D(DTOUT)!$D(DUOUT) Q
 S DFN=+$P(Y,U,1)
 I DFN=-1 W !,"No patient selected!" Q
 S DIC=811.9,DIC("A")="Select Reminder: "
 D ^DIC
 I $D(DIROUT)!$D(DIRUT) Q
 I $D(DTOUT)!$D(DUOUT) Q
 S PXRMITEM=+$P(Y,U,1)
 I PXRMITEM=-1 W !,"No reminder selected!" Q
 S DIR(0)="LA"_U_"0"
 S DIR("A")="Enter component number 0, 1, 5, 10, 11, 12, 55: "
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) Q
 I $D(DTOUT)!$D(DUOUT) Q
 I X="" S X=5
 S PXRHM=X
 S DIR(0)="DA^"_0_"::ETX"
 S DIR("A")="Enter date for reminder evaluation: "
 S DIR("B")=$$FMTE^XLFDT($$DT^XLFDT,"D")
 S DIR("PRE")="S X=$$DCHECK^PXRMDATE(X) K:X=-1 X"
 W !
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT) Q
 I $D(DTOUT)!$D(DUOUT) Q
 S DATE=Y
 I $D(^PXD(811.9,PXRMITEM,20,"E","PXRMD(811.5,")) S PXRMTDEB=$$ASKYN^PXRMEUT("N","Display all term findings","","")
 D DOREM(DFN,PXRMITEM,PXRHM,DATE)
 Q
 ;
 ;==================================================
DEV ;Prompt for patient and reminder by name and evaluation date.
 N DATE,DFN,DIC,DIROUT,DIRUT,DTOUT,DUOUT,PXRMITEM,PXRHM,PXRMTDEB,REF,X,Y
 S DIC=2,DIC("A")="Select Patient: "
 S DIC(0)="AEQMZ"
 D ^DIC
 I $D(DIROUT)!$D(DIRUT) Q
 I $D(DTOUT)!$D(DUOUT) Q
 S DFN=+$P(Y,U,1)
 S DIC=811.9,DIC("A")="Select Reminder: "
 D ^DIC
 I $D(DIROUT)!$D(DIRUT) Q
 I $D(DTOUT)!$D(DUOUT) Q
 S PXRMITEM=+$P(Y,U,1)
 S PXRHM=5
 S DIR(0)="DA^"_0_"::ETX"
 S DIR("A")="Enter date for reminder evaluation: "
 S DIR("B")=$$FMTE^XLFDT($$DT^XLFDT,"D")
 S DIR("PRE")="S X=$$DCHECK^PXRMDATE(X) K:X=-1 X"
 W !
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT) Q
 I $D(DTOUT)!$D(DUOUT) Q
 S DATE=Y
 I $D(^PXD(811.9,PXRMITEM,20,"E","PXRMD(811.5,")) S PXRMTDEB=$$ASKYN^PXRMEUT("N","Display all term findings","","")
 D DOREM(DFN,PXRMITEM,PXRHM,DATE)
 Q
 ;
 ;==================================================
DOREM(DFN,PXRMITEM,PXRHM,DATE) ;Do the reminder
 N DEFARR,FIEVAL,FINDING,PXRMDEBG,PXRMID,REF,TFIEVAL
 ;This is a debugging run so set PXRMDEBG.
 S PXRMDEBG=1
 D DEF^PXRMLDR(PXRMITEM,.DEFARR)
 I +$G(DATE)=0 D EVAL^PXRM(DFN,.DEFARR,PXRHM,1,.FIEVAL)
 I +$G(DATE)>0 D EVAL^PXRM(DFN,.DEFARR,PXRHM,1,.FIEVAL,DATE)
 ;
 I $D(^TMP(PXRMID,$J,"FFDEB")) M FIEVAL=^TMP(PXRMID,$J,"FFDEB") K ^TMP(PXRMID,$J,"FFDEB")
 ;
 W !!,"The elements of the FIEVAL array are:"
 S REF="FIEVAL"
 D AWRITE^PXRMUTIL(REF)
 ;
 I $G(PXRMTDEB) D
 . W !!,"Term findings:"
 . S REF="TFIEVAL"
 . S FINDING=0
 . F  S FINDING=$O(^TMP("PXRMTDEB",$J,FINDING)) Q:FINDING=""  D
 .. K TFIEVAL M TFIEVAL(FINDING)=^TMP("PXRMTDEB",$J,FINDING)
 .. W !,"Finding ",FINDING,":"
 .. D AWRITE^PXRMUTIL(REF)
 . K ^TMP("PXRMTDEB",$J)
 ;
 W !!,"The elements of the ^TMP(PXRMID,$J) array are:"
 I $D(PXRMID) S REF="^TMP(PXRMID,$J)" D AWRITE^PXRMUTIL(REF) K ^TMP(PXRMID,$J)
 ;
 W !!,"The elements of the ^TMP(""PXRHM"",$J) array are:"
 S REF="^TMP(""PXRHM"",$J)"
 D AWRITE^PXRMUTIL(REF)
 ;
 I $D(^TMP("PXRHM",$J)) D CMOUT
 I PXRHM=12 D MHVCOUT
 K ^TMP("PXRM",$J),^TMP("PXRHM",$J),^TMP("PXRMMHVC",$J)
 Q
 ;
 ;==================================================
MHVCOUT ;Do formatted MHV combined output.
 N DUE,DUECOL,HIST,LAST,LASTCOL,LNUM,RIEN,RNAME,STATUS,STATCOL,TEMP,TYPE
 W !!,"Formatted Output:"
 S RIEN=$O(^TMP("PXRMMHVC",$J,""))
 S TEMP=^TMP("PXRMMHVC",$J,RIEN,"STATUS")
 S STATUS=$P(TEMP,U,1)
 S DUE=$$DDATE^PXRMDATE($P(TEMP,U,2))
 S LAST=$$DDATE^PXRMDATE($P(TEMP,U,3))
 S STATCOL=41-($L(STATUS)/2)
 S DUECOL=53-($L(DUE)/2)
 S LASTCOL=67-($L(LAST)/2)
 S RNAME=$P(^PXD(811.9,RIEN,0),U,3)
 I RNAME="" S RNAME=$P(^PXD(811.9,RIEN,0),U,1)
 W !!,?36,"--STATUS--",?47,"--DUE DATE--",?61,"--LAST DONE--",!
 W !,RNAME,?STATCOL,STATUS,?DUECOL,DUE,?LASTCOL,LAST,!
 W !!,"---------- Detailed Output ----------"
 S LNUM=0
 F  S LNUM=$O(^TMP("PXRMMHVC",$J,RIEN,"DETAIL",LNUM)) Q:LNUM=""  D
 . W !,^TMP("PXRMMHVC",$J,RIEN,"DETAIL",LNUM)
 W !!,"---------- Summary Output ----------"
 S LNUM=0
 F  S LNUM=$O(^TMP("PXRMMHVC",$J,RIEN,"SUMMARY",LNUM)) Q:LNUM=""  D
 . W !,^TMP("PXRMMHVC",$J,RIEN,"SUMMARY",LNUM)
 Q
 ;
