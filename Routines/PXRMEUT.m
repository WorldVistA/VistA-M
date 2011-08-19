PXRMEUT ; SLC/PJH - General extract utilities ;11/02/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,17**;Feb 04, 2005;Build 102
 ;
 ;=================================================
ASKNUM(TEXT,MIN,MAX) ;
 N DIR,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="N"_U_MIN_":"_MAX
 S DIR("A")=TEXT
 S DIR("B")=MIN
 S DIR("?")="Enter a number between "_MIN_" and "_MAX_"."
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S Y=MIN
 Q Y
 ;
 ;=================================================
ASKYN(DEF,TEXT,RTN,HLP) ;
 N DIR,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="Y0"
 S DIR("A")=TEXT
 S DIR("B")=DEF
 S DIR("?")="Enter Y or N."
 I $G(RTN)'="",$G(HLP)'="" D
 . S DIR("?")="Enter Y or N. For detailed help type ??"
 . S DIR("??")=U_"D HELP^"_RTN_"(HLP)"
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S Y=DEF
 Q Y
 ;
 ;=================================================
BHELP ;Write the beginning date help.
 N BDHTEXT,%DT
 S BDHTEXT(1)="This is the beginning date for the "_LIT_"."
 D HELP^PXRMEUT(.BDHTEXT)
 S %DT="P",%DT(0)=-DT
 D HELP^%DTC
 Q
 ;
 ;=================================================
CALC(NEXT,START,END) ;Calculate period start and end dates
 ;Next is current run period
 N CMON,CYR,ETYPE,NMON,NYR,PERIOD,YEAR
 ;extract year and period (M1,M2,Q1,Q2,Y etc)
 I NEXT["/" S YEAR=$P(NEXT,"/",2),PERIOD=$P(NEXT,"/"),ETYPE=$E(PERIOD)
 I NEXT?4N S YEAR=NEXT,PERIOD="",ETYPE="Y"
 ;Two digit year
 S CYR=$E(YEAR,3,4),NYR=CYR
 ;If yearly use Jan 1st of current year and next
 I ETYPE="Y" D
 .S CMON="1",NMON="1",NYR=NYR+1
 ;If quarterly use start of first month of next quarter
 I ETYPE="Q" D
 .S CMON=$E(PERIOD,2,99),NMON=CMON*3+1 I NMON>12 S NYR=NYR+1,NMON=1
 .S CMON=CMON*3-2
 ;If monthly use start of next month
 I ETYPE="M" D
 .S CMON=$E(PERIOD,2,99),NMON=CMON+1 I NMON>12 S NYR=NYR+1,NMON=1
 ;Zero fill the month fields
 S CMON=$$RJ^XLFSTR(CMON,2,0),NMON=$$RJ^XLFSTR(NMON,2,0)
 ;Zero fill the year fields
 S CYR=$$RJ^XLFSTR(CYR,2,0),NYR=$$RJ^XLFSTR(NYR,2,0)
 ;Report start date is start of current period 
 S START=3_CYR_CMON_"01"
 ;Report end date is start of next period less one day
 S END=$$FMADD^XLFDT(3_NYR_NMON_"01",-1)
 Q
 ;
 ;=================================================
DATES(BDATE,EDATE,LIT) ;Get a past date range.
BEGIN ;Select the beginning date.
 N DIR,%DT,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="DA^::ETX"
 S DIR("A")="Enter "_LIT_" BEGINNING DATE: "
 S DIR("PRE")="S X=$$DCHECK^PXRMDATE(X) K:X=-1 X"
 S DIR("?")="For detailed help type ??"
 S DIR("??")=U_"D BHELP^PXRMEUT"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S BDATE=Y
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G BEGIN
 S BDATE=Y
 ;
END ;Select the ending date.
 S DIR(0)="DA^"_BDATE_"::ETX"
 S DIR("A")="Enter "_LIT_" ENDING DATE: "
 S DIR("PRE")="S X=$$DCHECK^PXRMDATE(X) K:X=-1 X"
 S DIR("?")="This date cannot be before "_$$FMTE^XLFDT(BDATE,"D")_". For detailed help type ??"
 S DIR("??")=U_"D EHELP^PXRMEUT"
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT) Q
 I $D(DUOUT) G BEGIN
 S EDATE=Y
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G END
 K DIROUT,DIRUT,DTOUT,DUOUT
 Q
 ;
 ;=================================================
DOCUMENT(PXRMLIST,PXRMRULE,INDP,INTP,BEG,END) ;Document how the
 ;list was built.
 N CDATE,CLASS,CREATOR,IND,LDATA,LNAME
 N NDL,NL,NPAT,OUTPUT,SNAME,SOURCE,TEXT,TYPE,VALMCNT
 K ^TMP("PXRMLRED",$J)
 S LDATA=$G(^PXRMXP(810.5,PXRMLIST,0))
 S LNAME=$P(LDATA,U,1)
 S CDATE=$P(LDATA,U,4)
 S SOURCE=$P(LDATA,U,5),SNAME="NONE"
 ;Check if generated from #810.2
 I SOURCE S SNAME="Extract Parameter - "_$P($G(^PXRM(810.2,SOURCE,0)),U)
 ;If not check if generated from #810.4
 I 'SOURCE S SOURCE=$P(LDATA,U,6) S:SOURCE SNAME="List Rule - "_$P($G(^PXRM(810.4,SOURCE,0)),U)
 ;Creator
 S CREATOR=+$P(LDATA,U,7)
 S CREATOR=$S(CREATOR>0:$$GET1^DIQ(200,CREATOR,.01),1:"None")
 ;Type
 S TYPE=$P(LDATA,U,8)
 S TYPE=$$EXTERNAL^DILFD(810.5,.08,"",TYPE,.EM)
 ;Class
 S CLASS=$P($G(^PXRMXP(810.5,PXRMLIST,100)),U,1)
 S CLASS=$S(CLASS="N":"National",CLASS="V":"VISN",1:"Local")
 S NPAT=$P(^PXRMXP(810.5,PXRMLIST,30,0),U,4)
 S TEXT(1)="List Name: "_LNAME_" ("_NPAT_" patients)"
 S TEXT(2)=" Created: "_$$FMTE^XLFDT(CDATE,"5Z")
 S TEXT(2)=$$LJ^XLFSTR(TEXT(2),40)_"Creator: "_CREATOR
 S TEXT(3)=" Class: "_CLASS
 S TEXT(3)=$$LJ^XLFSTR(TEXT(3),40)_"Type: "_TYPE
 S TEXT(4)=" Source: "_SNAME
 S TEXT(5)=" Patient List Beginning Date: "_$$FMTE^XLFDT(BEG,"5Z")
 S TEXT(6)=" Patient List Ending Date: "_$$FMTE^XLFDT(END,"5Z")
 S TEXT(7)=" "
 S NL=7
 F IND=1:1:NL S ^PXRMXP(810.5,PXRMLIST,200,IND,0)=TEXT(IND)
 D BLDLIST^PXRMLRED(PXRMRULE,3)
 F IND=1:1:VALMCNT S NL=NL+1,^PXRMXP(810.5,PXRMLIST,200,NL,0)=^TMP("PXRMLRED",$J,IND,0)
 S NL=NL+1,^PXRMXP(810.5,PXRMLIST,200,NL,0)=" --- List Build Information ---"
 S NL=NL+1,^PXRMXP(810.5,PXRMLIST,200,NL,0)="List Build Beginning Date: "_$$FMTE^XLFDT(BEG,"5Z")
 S NL=NL+1,^PXRMXP(810.5,PXRMLIST,200,NL,0)="List Build Ending Date: "_$$FMTE^XLFDT(END,"5Z")
 S NL=NL+1,^PXRMXP(810.5,PXRMLIST,200,NL,0)=" "
 S NL=NL+1,^PXRMXP(810.5,PXRMLIST,200,NL,0)="Include deceased patients: "_$S(INDP:"Yes",1:"No")
 S NL=NL+1,^PXRMXP(810.5,PXRMLIST,200,NL,0)="Include test patients: "_$S(INTP:"Yes",1:"No")
 ;Get the beginning and ending date information
 D DOCDATES^PXRMEUT1(PXRMRULE,BEG,END,.NDL,.OUTPUT)
 F IND=1:1:NDL S NL=NL+1,^PXRMXP(810.5,PXRMLIST,200,NL,0)=OUTPUT(IND)
 S ^PXRMXP(810.5,PXRMLIST,200,0)=U_U_NL_U_NL_U_DT_U
 K ^TMP("PXRMLRED",$J)
 Q
 ;
 ;=================================================
EHELP ;Write the ending date help.
 N EDHTEXT,%DT
 S EDHTEXT(1)="This is the ending date for the "_LIT_"."
 D HELP^PXRMEUT(.EDHTEXT)
 S %DT="P",%DT(0)=-DT
 D HELP^%DTC
 Q
 ;
 ;=================================================
HELP(HTEXT) ;General help text output routine.
 N IND,NIN,NOUT,TEXTIN,TEXOUT
 ;Make sure the text is in a form the formatting routine can handle.
 S IND="",NIN=0
 F  S IND=$O(HTEXT(IND)) Q:IND=""  S NIN=NIN+1,TEXTIN(NIN)=HTEXT(IND)
 D FORMAT^PXRMTEXT(1,72,NIN,.TEXTIN,.NOUT,.TEXTOUT)
 F IND=1:1:NOUT W !,TEXTOUT(IND)
 W !
 Q
 ;
 ;=================================================
LDELOK(LISTIEN) ;Return a 1 if it is ok for this user to delete the list.
 N CREATOR,DELOK
 S CREATOR=$P(^PXRMXP(810.5,LISTIEN,0),U,7)
 S DELOK=$S(CREATOR=DUZ:1,$D(^XUSEC("PXRM MANAGER",DUZ)):1,1:0)
 Q DELOK
 ;
 ;=================================================
MES(TEXT) ;General mail message
 N XMSUB
 K ^TMP("PXRMXMZ",$J)
 S XMSUB="CLINICAL REMINDER EXTRACT"
 S ^TMP("PXRMXMZ",$J,1,0)=TEXT
 D SEND^PXRMMSG("PXRMXMZ",XMSUB)
 Q
 ;
 ;=================================================
PERIOD(FREQ) ;Calculate next period
 N CMON,CUR,CYR,ETYPE,NEXT,PERIOD,YEAR
 ;Format current date YY/MM/DD
 S CUR=$$FMTE^XLFDT($$NOW^XLFDT,7)
 ;extract year and period
 S YEAR=$P(CUR,"/"),PERIOD=$P(CUR,"/",2)
 ;If yearly current year
 I FREQ="Y" D
 .S NEXT=YEAR
 ;If quarterly use current quarter
 I FREQ="Q" D
 .S NEXT="Q"_((PERIOD-1\3)+1)_"/"_YEAR
 ;If monthly use current month
 I FREQ="M" D
 .S NEXT="M"_PERIOD_"/"_YEAR
 Q NEXT
 ;
 ;=================================================
RMPAT(NODE,INDP,INTP) ;Remove dead and test patients from
 ;the list.
 I INDP,INTP Q
 N DFN,DOD,REMOVE
 S DFN=0
 F  S DFN=$O(^TMP($J,NODE,DFN)) Q:DFN=""  D
 .;DBIA 3744
 . S REMOVE=$S('INTP:$$TESTPAT^VADPT(DFN),1:0)
 . I REMOVE K ^TMP($J,NODE,DFN) Q
 . I INDP Q
 .;DBIA #10035
 . S DOD=+$P($G(^DPT(DFN,.35)),U,1)
 . I DOD=0 Q
 . K ^TMP($J,NODE,DFN)
 Q
 ;
