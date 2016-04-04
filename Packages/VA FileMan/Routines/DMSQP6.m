DMSQP6 ;SFISC/EZ-DISPLAY TABLE GROUPINGS ;10/30/97  17:51
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
INIT ; initialize variables and clear tmp arrays
 D DT^DICRW
 S DMUCI="" I $D(^%ZOSF("UCI"))#2 X ^%ZOSF("UCI") S DMUCI=Y
CLEAR K ^TMP("DMPAIRS",$J),^TMP("DMCNT",$J),^TMP("DMLIST",$J)
 K ^TMP("DMFLAT",$J),^TMP("DMFIN",$J),^TMP("DMSHR",$J)
 Q
EXIT ; kill vars
 K DMANS,DMFILE,DMFTIEN,DMTTIEN,DMFK,DMDM,DMTR,DM3,J
 K DMCT,DM,DM1,DM2,DMX,DMX1,DMGRP,DMGCNT,DMG,DMAX,DMT,DMTOT,DMQ
 K DMSHRC,DMUCI,DMSPEC,DMSPECN,DMSPECG,DMQQ
 Q
PREASK ; confirm that it's okay to wait for interactive processing
 S DIR(0)="Y",DIR("A")="This can take 5-10 minutes.  Continue"
 S DIR("B")="NO" D ^DIR K DIR S:Y=0 DMQQ=1
 Q
ASK ; ask for a cutoff on pointed-to file references
 S DIR(0)="NO^0:1000",DIR("A")="Maximum pointing references",DIR("B")=5
 S DIR("?",1)="This cutoff is used as an upper limit on pointer links.  Tables with"
 S DIR("?",2)="more links than this upper limit are displayed as the set of shared tables.",DIR("?",3)=" "
 S DIR("?",4)="Others with common pointer links are then grouped together.  The resulting"
 S DIR("?",5)="subsets could be used in SQL Grant statements.",DIR("?",6)=" "
 S DIR("?")="Try using cutoffs between 3 and 10, comparing results."
 D ^DIR K DIR S DMANS=Y S:$D(DIRUT) DMQQ=1
 Q
ASK1 ; ask for a specific table of interest
 S DIC="1.5215",DIC(0)="QEAM",DIC("S")="I '$P(^(0),U,4)"
 S DIC("A")="Select a Table of Special Interest (Optional): "
 D ^DIC K DIC S DMSPEC=$S(Y=-1:"",1:+Y) S:$D(DTOUT)!$D(DUOUT) DMQQ=1
 S:DMSPEC DMSPECN=$P(^DMSQ("T",DMSPEC,0),U,1) S DMSPECG=""
 Q
EN ; find groups of tables that point to one another
 I '$O(^DMSQ("S",0)) W !?5,"Sorry, SQLI files are empty.",! Q
 I $$WAIT^DMSQT1 D  Q
 . W !?5,"Try later.  SQLI is being re-built right now."
 S DMQQ="" D PREASK I $D(DIRUT)!(DMQQ) K DMQQ Q
 D  D CLEAR,EXIT
 . D INIT,ASK Q:DMQQ  D ASK1 Q:DMQQ
 . D PAIRS,CNT,OTH,GRP,PRT D:DMSPEC PRT3 D PRT2
 Q
PRT ; print shared table list
 W !!,?9,"LISTING OF SHARED TABLES"
 S DIC="1.5215",L=0
 S DHD="SHARED TABLES = "_DMSHRC_"  (CUTOFF OF "_DMANS_")   "_DMUCI
 S FLDS=".01;C5;"""","" (""_INTERNAL(#6)_"")"";X"
 S BY(0)="^TMP(""DMSHR"",$J,",L(0)=2
 D EN1^DIP Q
PRT1 ; detailed report showing pointer links within groups
 W !!,?9,"DETAILED GROUP REPORT"
 S DIC="1.5215",L=0
 S DHD="DETAIL OF GROUPS = "_DMGCNT_"  (CUTOFF OF "_DMANS_")   "_DMUCI
 S FLDS="""FROM TABLE: "";C5,.01;X,"" (""_INTERNAL(#6)_"")"";X"
 S BY(0)="^TMP(""DMLIST"",$J,",L(0)=3
 S DISPAR(0,1)="^;""GROUP: "";S2"
 S DISPAR(0,1,"OUT")="S Y=$P(^DMSQ(""T"",Y,0),U,1)_"" (""_$P(^(0),U,7)_"")"""
 S DISPAR(0,2)="^;""TO TABLE: "";S;C1"
 S DISPAR(0,2,"OUT")="S Y=$P(^DMSQ(""T"",Y,0),U,1)_"" (""_$P(^(0),U,7)_"")"""
 D EN1^DIP Q
PRT2 ; print final list of tables by group
 W !!,?9,"COMPLETE REPORT OF ALL GROUPS"
 S DIC="1.5215",L=0
 S DHD="TABLE GROUPS = "_DMGCNT_"  (CUTOFF OF "_DMANS_")   "_DMUCI
 S FLDS=".01;C5;"""","" (""_INTERNAL(#6)_"")"";X"
 S BY(0)="^TMP(""DMFIN"",$J,",L(0)=4
 S DISPAR(0,2)="^;""TABLE COUNT="";C1;S2"
 S DISPAR(0,3)="^;""GROUP: "";C15"
 S DISPAR(0,3,"OUT")="S Y=$P(^DMSQ(""T"",Y,0),U,1)_"" (""_$P(^(0),U,7)_"")"""
 D EN1^DIP Q
PRT3 ; just show the group that includes the specified table
 W !!,?9,"PRINT OF JUST ONE GROUP (INCLUDING THE SPECIFIED TABLE)"
 I 'DMSPECG&$D(^TMP("DMCNT",$J,DMSPEC)) W !!,"The selected table doesn't fall in a group; see the shared set." Q
 I 'DMSPECG W !!,"There isn't a group for the selected table; it doesn't have pointer links." Q
 S DIC="1.5215",L=0
 S DHD="GROUP INCLUDING "_DMSPECN_"  (CUTOFF OF "_DMANS_")   "_DMUCI
 S FLDS=".01;C5;"""","" (""_INTERNAL(#6)_"")"";X"
 S BY(0)="^TMP(""DMFIN"",$J,",L(0)=4
 S DISPAR(0,2)="^;""TABLE COUNT="";C1;S2"
 S DISPAR(0,3)="^;""GROUP: "";C15",(FR(0,3),TO(0,3))=DMSPECG
 S DISPAR(0,3,"OUT")="S Y=$P(^DMSQ(""T"",Y,0),U,1)_"" (""_$P(^(0),U,7)_"")"""
 D EN1^DIP Q
PAIRS ; build array with to-table and from-tables that link
 S DMFILE=0
 W !,"...... Please wait.  Reports take a few minutes to process ...... "
 F  S DMFILE=$O(^DMSQ("T","C",DMFILE)) Q:DMFILE'>0  D
 . S DMFTIEN=$O(^DMSQ("T","C",DMFILE,0))
 . S DMFK=0
 . F  S DMFK=$O(^DMSQ("E","F",DMFTIEN,"F",DMFK)) Q:DMFK'>0  D
 .. S DMDM=$P(^DMSQ("E",DMFK,0),U,2)
 .. S DMTTIEN=$P(^DMSQ("DM",DMDM,0),U,4)
 .. S:(DMTTIEN'=DMFTIEN) ^TMP("DMPAIRS",$J,DMTTIEN,DMFTIEN)=""
 Q
CNT ; get reference counts
 S DM1=0
 F  S DM1=$O(^TMP("DMPAIRS",$J,DM1)) Q:DM1'>0  D
 . S DM2=0,DMCT=0,DMFILE=$P(^DMSQ("T",DM1,0),U,7)
 . F  S DM2=$O(^TMP("DMPAIRS",$J,DM1,DM2)) Q:DM2'>0  D
 .. S DMCT=DMCT+1
 . S ^TMP("DMCNT",$J,DM1)=DMCT
 Q
GRP ; group the sets of shared tables
 S DMGRP=0
 F  S DMGRP=$O(^TMP("DMPAIRS",$J,DMGRP)) Q:DMGRP'>0  W "." D
 . K DMSCR S DMSCR(DMGRP)="" F J=1:1:5 D
 .. S DM1=0 F  S DM1=$O(^TMP("DMPAIRS",$J,DM1)) Q:DM1'>0  D
 ... S DM2=0 F  S DM2=$O(^TMP("DMPAIRS",$J,DM1,DM2)) Q:DM2'>0  D
 .... S (DMX,DMQ)=0
 .... F  Q:DMQ  S DMX=$O(DMSCR(DMX)) Q:DMX'>0  D
 ..... S:DMX=DM1 DMSCR(DM2)="",DMQ=1
 ..... S:DMX=DM2 DMSCR(DM1)="",DMQ=1
 .... I DMQ D
 ..... S ^TMP("DMLIST",$J,DMGRP,DM1,DM2)=""
 ..... S ^TMP("DMFLAT",$J,DMGRP,DM1)="",^TMP("DMFLAT",$J,DMGRP,DM2)=""
 ..... K ^TMP("DMPAIRS",$J,DM1,DM2)
 S (DMGCNT,DM)=0
 F  S DM=$O(^TMP("DMLIST",$J,DM)) Q:DM'>0  S DMGCNT=DMGCNT+1
 S DM=0 F  S DM=$O(^TMP("DMFLAT",$J,DM)) Q:DM'>0  D
 . S (DMX,DMT,DMAX)=0 F  S DMX=$O(^TMP("DMFLAT",$J,DM,DMX)) Q:DMX'>0  D
 .. S DMTOT=$G(^TMP("DMCNT",$J,DMX)),DMT=DMT+1
 .. I DMTOT>DMAX S DMAX=DMTOT,DMG=DMX
 . S DMX1=0 F  S DMX1=$O(^TMP("DMFLAT",$J,DM,DMX1)) Q:DMX1'>0  D
 .. S DMTR=99999999-DMT,^TMP("DMFIN",$J,DMTR,DMT,DMG,DMX1)=""
 .. S:DMSPEC=DMX1 DMSPECG=DMG
 Q
OTH ; process with other factor, i.e. cutoff on pointer link limit
 S (DM1,DMSHRC)=0,^TMP("DMSHR",$J,0,0)=""
 F  S DM1=$O(^TMP("DMPAIRS",$J,DM1)) Q:DM1'>0  D
 . I $G(^TMP("DMCNT",$J,DM1))>DMANS D
 .. S DM2=0,DMSHRC=DMSHRC+1
 .. S ^TMP("DMSHR",$J,99999-($G(^TMP("DMCNT",$J,DM1))),DM1)=""
 .. F  S DM2=$O(^TMP("DMPAIRS",$J,DM1,DM2)) Q:DM2'>0  D
 ... K ^TMP("DMPAIRS",$J,DM1,DM2)
 .. S DM2=0 F  S DM2=$O(^TMP("DMPAIRS",$J,DM2)) Q:DM2'>0  D
 ... S DM3=0 F  S DM3=$O(^TMP("DMPAIRS",$J,DM2,DM3)) Q:DM3'>0  D
 .... I DM1=DM3 K ^TMP("DMPAIRS",$J,DM2,DM3)
 Q
