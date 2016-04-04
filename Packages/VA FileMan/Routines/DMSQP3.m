DMSQP3 ;SFISC/EZ-DISPLAY POINTER COUNTS ;10/30/97  17:42
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
EN ; show individual table counts of links
 S DMQ="" D OK I DMQ K DMQ Q
 D PREASK I $D(DIRUT)!(DMQ) K DMQ Q
 D DT^DICRW,HOME^%ZIS
 D ASK D:'DMQ ASK1 D:'DMQ CLEAR,PAIRS,CNT,BUILD,PRT D EXIT Q
EN1 ; show summary counts of table links
 S DMQ="" D OK I DMQ K DMQ Q
 D PREASK I $D(DIRUT)!(DMQ) K DMQ Q
 D DT^DICRW,HOME^%ZIS D  D EXIT
 . D ASK2 Q:DMQ  D CLEAR,PAIRS,CNT,BUILD,TOTS
 . S DMDHD=$S(DMYN:"LISTING",1:"COUNTS")
 . S DMFLDS=$S(DMYN:"!INTERNAL(#6);"""",.01;""""",1:"!(#.01);""""")
 . S DMANS=""
 . F  D MENU Q:$D(DIRUT)  D READ Q:$D(DIRUT)!(DMANS=9)  D
 .. D:DMANS=1 PRT3^DMSQP4
 .. D:DMANS=2 PRT4^DMSQP4
 .. D:DMANS=3 PRT5^DMSQP4
 .. D:DMANS=4 PRT6^DMSQP4
 .. D:DMANS=5 PRT7^DMSQP4
 .. ; word-processing tables could be done calling PRT2^DMSQP4,
 .. ; see commented code in BUILD for some ideas about how.
 Q
MENU ; present a choice of reports, now that TMP arrays are built
 S DIR(0)="E" D ^DIR K DIR Q:$D(DIRUT)  W @IOF
 W !!!!!?9,"(1) SELF  Tables with Self-referential Pointers"
 W !?9,"(2) UP    Tables with Upward Links"
 W !?9,"(3) DOWN  Tables Linked from Below"
 W !?9,"(4) OUT   Tables Pointing Outward"
 W !?9,"(5) IN    Tables with Incoming Pointers"
 W !!?9,"(9) QUIT  Exit this Menu"
 W !! Q
READ ; reader for the menu
 S DIR(0)="SMA^1:SELF;2:UP;3:DOWN;4:OUT;5:IN;9:QUIT"
 S DIR("A")="Select a report: " D ^DIR S DMANS=Y K DIR
 Q
EXIT K DOT,DMANS,DMFILE,DMWP,DMFK,DMPFK,DMSR,DME,DMF,DMCOL,DMDM,DMYN
 K DMX,DMY,DMCT,DMBFK,DMBPFK,DMQ,DMFN,DMFN1,DMTBL,DMCI,DMEI,DMDI
 K DM1,DM2,DM3,DM4,DM5,DM6,DM7,DMDHD,DMFLDS
 K DMC1,DMC2,DMC3,DMC4,DMC5,DMC6,DMC7
 K DMCN2,DMCN3,DMCN4,DMCN5,DMCN6,DMCN7,DMCN8
CLEAR K ^TMP("DM",$J),^TMP("DMT",$J),^TMP("DMTN",$J)
 K ^TMP("DMP1",$J),^TMP("DMP2",$J)
 K ^TMP("DMCT1",$J),^TMP("DMCT2",$J),^TMP("DMFQ2",$J),^TMP("DMFQ3",$J)
 K ^TMP("DMFQ4",$J),^TMP("DMFQ5",$J),^TMP("DMFQ6",$J),^TMP("DMFQ7",$J)
 Q
OK ; check of okay to run
 I '$O(^DMSQ("S",0)) W !?5,"Sorry, SQLI files are empty.",! S DMQ=1 Q
 I $$WAIT^DMSQT1 D  S DMQ=1 Q
 . W !?5,"Try later.  SQLI is being re-built right now."
 Q
PREASK ; confirm that it's okay to wait for interactive processing
 S DIR(0)="Y",DIR("A")="This can take 1-2 minutes.  Continue"
 S DIR("B")="NO" D ^DIR K DIR S:Y=0 DMQ=1
 Q
ASK ; select file numbers
 S DM1=$O(^DMSQ("T","C",0)),DM2=$O(^DMSQ("T","C",99999999999),-1)
 S DIR(0)="NO^"_DM1_":"_DM2_":999999999",DIR("A")="Starting File Number"
 S DIR("?")="Enter the number of the file, e.g. 200 or 1.5215"
 S DIR("B")=.401 D ^DIR S:$D(DIRUT) DMQ=1 K DIR Q:DMQ  S DMFN=Y
 I '$D(^DMSQ("T","C",DMFN)) W !,"SQLI table not found." G ASK
 Q
ASK1 S DIR("B")=DMFN ; default to one file (not a range)
 S DIR(0)="NO^"_DM1_":"_DM2_":999999999",DIR("A")="  Ending File Number"
 S DIR("?")="Optionally enter a larger number for a range, e.g. 1.5217"
 D ^DIR S:$D(DTOUT)!$D(DUOUT) DMQ=1 K DIR Q:DMQ  S DMFN1=Y
 I '$D(^DMSQ("T","C",DMFN1)) D  G ASK1
 . W !!?5,"There isn't a table for the file number you've entered."
 . W !?5,"(The highest possible number is "_DM2_".)",!
 I DMFN1'=DMFN,DMFN1'>DMFN D  G ASK1
 . W !!?5,"Enter a LARGER number to get a range."
 . W !?5,"The highest possible number here is "_DM2_".",!
 Q
ASK2 ; prompt for style of listing (summary counts or detail)
 S DIR("A")="These reports show counts.  Or would you prefer details"
 S DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR S DMYN=Y S:$D(DIRUT) DMQ=1
 Q
BUILD ;
 S (DOT,DMFILE)=0
 F  S DMFILE=$O(^DMSQ("T","C",DMFILE)) Q:DMFILE'>0  D
 . S DOT=DOT+1 W:DOT#20=1 "."
 . S (DMWP,DMFK,DMPFK,DMSR)=0,DMX=$O(^DMSQ("T","C",DMFILE,0))
 . I '$D(^DMSQ("E","F",DMX,"F")) D DEFINE Q
 . ;word-processing domains are character, so DMWP never set
 . ;perhaps use dbs field retriever to get type (e.g. wp)
 . ;S DMCI=$O(^DMSQ("C","D",DMFILE,.01,0)) D:DMCI
 . ;. S DMEI=$P(^DMSQ("C",DMCI,0),U,1)
 . ;. S DMDI=$P(^DMSQ("E",DMEI,0),U,2)
 . ;. S:DMDI=$O(^DMSQ("DM","B","WORD_PROCESSING",0)) DMWP=DMWP+1
 . S DME=0 F  S DME=$O(^DMSQ("E","F",DMX,"F",DME)) Q:DME'>0  D
 .. S DMF=$O(^DMSQ("F","B",DME,0))
 .. S DMCOL=$P(^DMSQ("F",DMF,0),U,3)
 .. S:$P(^DMSQ("C",DMCOL,0),U,5) DMFK=DMFK+1
 .. S:'$P(^DMSQ("C",DMCOL,0),U,5) DMPFK=DMPFK+1
 .. S DMDM=$P(^DMSQ("E",DME,0),U,2)
 .. S DMY=$P(^DMSQ("DM",DMDM,0),U,4)
 .. S:DMX=DMY DMSR=DMSR+1
 .. D:$O(^DMSQ("E","F",DMX,"F",DME))="" DEFINE
 Q
DEFINE ;
 S DMBFK=0 S:$D(^TMP("DMCT1",$J,DMX))=1 DMBFK=^(DMX)
 S DMBPFK=0 S:$D(^TMP("DMCT2",$J,DMX))=1 DMBPFK=^(DMX)
 S ^TMP("DM",$J,DMFILE,DMWP,DMSR,DMPFK,DMBPFK,DMFK,DMBFK,DMX)=""
 Q
TOTS ;
 S (DOT,DM1,DMC1,DMC2,DMC3,DMC4,DMC5,DMC6,DMC7)=0
 S (DMCN2,DMCN3,DMCN4,DMCN5,DMCN6,DMCN7,DMCN8)=0
 F  S DM1=$O(^TMP("DM",$J,DM1)) Q:DM1=""  D
 . S DOT=DOT+1 W:DOT#20=1 "."
 . S DMTBL=$O(^DMSQ("T","C",DM1,0)),DMC1=DMC1+1,DM2=""
 . F  S DM2=$O(^TMP("DM",$J,DM1,DM2)) Q:DM2=""  D
 .. S ^TMP("DMFQ2",$J,999-DM2,DM2,DMTBL)=""
 .. S:DM2 DMCN2=DMCN2+1 S DMC2=DMC2+DM2,DM3=""
 .. F  S DM3=$O(^TMP("DM",$J,DM1,DM2,DM3)) Q:DM3=""  D
 ... S ^TMP("DMFQ3",$J,9999-DM3,DM3,DMTBL)=""
 ... S:DM3 DMCN3=DMCN3+1 S DMC3=DMC3+DM3,DM4=""
 ... F  S DM4=$O(^TMP("DM",$J,DM1,DM2,DM3,DM4)) Q:DM4=""  D
 .... S ^TMP("DMFQ4",$J,DM2,9999-DM4,DM4,DMTBL)=""
 .... S:DM4 DMCN4=DMCN4+1 S DMC4=DMC4+DM4,DM5=""
 .... F  S DM5=$O(^TMP("DM",$J,DM1,DM2,DM3,DM4,DM5)) Q:DM5=""  D
 ..... S ^TMP("DMFQ5",$J,9999-DM5,DM5,DMTBL)=""
 ..... S:DM5 DMCN5=DMCN5+1 S DMC5=DMC5+DM5,DM6=""
 ..... F  S DM6=$O(^TMP("DM",$J,DM1,DM2,DM3,DM4,DM5,DM6)) Q:DM6=""  D
 ...... S ^TMP("DMFQ6",$J,9999-DM6,DM6,DMTBL)=""
 ...... S:DM6 DMCN6=DMCN6+1 S DMC6=DMC6+DM6,DM7=""
 ...... F  S DM7=$O(^TMP("DM",$J,DM1,DM2,DM3,DM4,DM5,DM6,DM7)) Q:DM7=""  D
 ....... S ^TMP("DMFQ7",$J,9999-DM7,DM7,DMTBL)=""
 ....... S:DM7 DMCN7=DMCN7+1 S DMC7=DMC7+DM7
 ....... S:'(DM4+DM5+DM6+DM7) DMCN8=DMCN8+1
 S ^TMP("DMTN",$J,DMC1,DMCN2,DMCN3,DMCN4,DMCN5,DMCN6,DMCN7,DMCN8)=""
 S ^TMP("DMT",$J,DMC1,DMC2,DMC3,DMC4,DMC5,DMC6,DMC7)=""
 Q
PAIRS ; build array with to-table and from-tables that point
 S (DOT,DMFILE)=0 W !,"Please wait..."
 F  S DMFILE=$O(^DMSQ("T","C",DMFILE)) Q:DMFILE'>0  D
 . S DOT=DOT+1 W:DOT#20=1 "."
 . S DMX=$O(^DMSQ("T","C",DMFILE,0))
 . S DME=0 F  S DME=$O(^DMSQ("E","F",DMX,"F",DME)) Q:DME'>0  D
 .. S DMDM=$P(^DMSQ("E",DME,0),U,2)
 .. S DMY=$P(^DMSQ("DM",DMDM,0),U,4)
 .. S DMF=$O(^DMSQ("F","B",DME,0)) ; get foreign key ien
 .. S DMCOL=$P(^DMSQ("F",DMF,0),U,3) ; get column pointer
 .. I $P(^DMSQ("C",DMCOL,0),U,5) S ^TMP("DMP1",$J,DMY,DMX,DMF)=""
 .. E  S ^TMP("DMP2",$J,DMY,DMX)=""
 Q
CNT ; get reference counts
 S DM1=0 W "." F  S DM1=$O(^TMP("DMP1",$J,DM1)) Q:DM1'>0  D
 . S (DM2,DMCT)=0
 . F  S DM2=$O(^TMP("DMP1",$J,DM1,DM2)) Q:DM2'>0  D
 .. S DM3=0
 .. F  S DM3=$O(^TMP("DMP1",$J,DM1,DM2,DM3)) Q:DM3'>0  S DMCT=DMCT+1
 .. S ^TMP("DMCT1",$J,DM1)=DMCT
 S DM1=0 F  S DM1=$O(^TMP("DMP2",$J,DM1)) Q:DM1'>0  D
 . S (DM2,DMCT)=0
 . F  S DM2=$O(^TMP("DMP2",$J,DM1,DM2)) Q:DM2'>0  S DMCT=DMCT+1
 . S ^TMP("DMCT2",$J,DM1)=DMCT
 Q
PRT ;
 S DIC="1.5215",L=0,DHD="SQLI TABLE POINTER COUNTS"
 S FLDS="""SQLI TABLE NAME: "";C28;S,.01;X"
 S BY(0)="^TMP(""DM"",$J,",L(0)=8,FR(0,1)=DMFN,TO(0,1)=DMFN1
 S DISPAR(0,1)="^;""FILE/SUBFILE: "";C1;S"
 S DISPAR(0,1,"OUT")="S Y=Y_""  ""_$S($D(^DIC(Y)):$P(^(Y,0),U),1:$O(^DD(Y,0,""NM"",0)))"
 ;S DISPAR(0,2)="^;""WORD-PROCESSING TABLE? "";C50"
 ;S DISPAR(0,2,"OUT")="S Y=$S(+Y:""YES"",1:""NO"")"
 S DISPAR(0,3)="^;""SELF-REFERENTIAL POINTERS: "";C18"
 S DISPAR(0,4)="^;""POINTERS DOWNWARD TO THIS SUBFILE: "";C10;S"
 S DISPAR(0,5)="^;""POINTERS UPWARD FROM DEEPER SUBFILES: "";C7"
 S DISPAR(0,6)="^;""POINTERS OUTWARD TO OTHER FILES: "";C12;S"
 S DISPAR(0,7)="^;""POINTERS INWARD FROM OTHER FILES: "";C11"
 D EN1^DIP Q
