MAGXCVS ;WOIFO/MLH - Imaging - index conversion - summary report ; 05/18/2007 11:23
 ;;3.0;IMAGING;**17,25,31,54**;03-July-2009;;Build 1424
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
MAKESUMM ; entry point - construct a summary report from site data
 ; This expects that the site will already have created an export file.
 ;
 N %ZIS,IOP,X,COUNT,LN,DATA,MAGIEN,PKG,CLS,TYP,SPEC,PROC,PROC2,DESC,PG
 N FRQTHRS ; --- frequency threshold for abridged report
 N NUPG ; ------ new-page flag
 N PROCTXT ; --- procedure text
 N PARENT ; ---- parent data file
 N DOCCAT ; ---- document category
 N OBJTYP ; ---- image object type
 N SAVBYGRP ; -- save-by group
 N KT ; -------- count for comparison with frequency threshold
 N SUB ; ------- station or substation mnemonic
 N FQFNAME ; --- fully qualified file name to process
 N FNAME ; ----- file name without directory or extension
 N RANGE ; ----- range of records (for documentation)
 N DTIME ; ----- timeout (in seconds) for input
 N FULABR ; ---- Full or Abridged report flag
 ;
 K ^TMP($J,"MAGIXCVSTAT")
 S COUNT=0
 S:'$D(DTIME) DTIME=$$DTIME^XUP(DUZ)
SM1 ; set frequency threshold based on full or abridged report
 ;
 K DIR S DIR(0)="SB^A:Abridged;F:Full"
 S DIR("A")="Abridged or Full report"
 S DIR("?",1)="Enter A if you wish to see the mapping only for those combinations"
 S DIR("?",2)="  of source field values that occurred more than 50 times."
 S DIR("?",3)=" "
 S DIR("?",4)="Enter F if you wish to see the mapping for all combinations of source"
 S DIR("?",5)="  field values in the range of image IENs that you mapped, even those"
 S DIR("?",6)="  that occurred fewer than 50 times."
 S DIR("?")=" "
 D ^DIR Q:$D(DTOUT)  Q:$D(DUOUT)  S FRQTHRS=$S(Y="A":50,1:1)
 ;
SM15 ; what export file?
 ;
 K DIR S DIR(0)="FO"
 S DIR("A")="Please enter the filename of the export file to use for input"
 S DIR("?")="Enter a file name, including the path, of the export file that contains the data to be summarized in the report."
 D ^DIR Q:$D(DTOUT)  Q:$D(DUOUT)  S FQFNAME=Y
 I FQFNAME="" W !!,"No filename entered. Goodbye!" Q
 S %ZIS="",%ZIS("HFSNAME")=FQFNAME,%ZIS("HFSMODE")="R",IOP="HFS"
 S $ET="G ERR^"_$T(+0)
 D ^%ZIS I POP=1 W !,"Unable to open "_FQFNAME_". Please try again." G SM15
 W ! S FNAME=$P($P(FQFNAME,"\",$L(FQFNAME,"\")),".")
 S SUB=$$UCASE^MAGXCVP($P(FNAME,"_")),RANGE=$P(FNAME,"_",2)
 I RANGE="" S RANGE="not given"
 K ^TMP($J,"MAGIXCVSTAT") S ^TMP($J,"MAGIXCVSTAT",0)=SUB_"^"_RANGE
 F LN=1:1 U IO R DATA:99999 Q:DATA="***end***"  I LN>1 D  ; Skip header
 . S MAGIEN=$P(DATA,$C(9))
 . S PKG=$P(DATA,$C(9),8) I PKG="" S PKG="(none)"
 . S CLS=+$P(DATA,$C(9),9),TYP=+$P(DATA,$C(9),10),SPEC=+$P(DATA,$C(9),11)
 . S PROC=+$P(DATA,$C(9),12)
 . S X=$P(DATA,$C(9),13),ORIG=$S(X="":"(none)",1:$P(X,"-")_" - "_$P(X,"-",2,999))
 . I ORIG="" S ORIG="(none)"
 . S DESC=$$STRIP^MAGXCVP($$UCASE^MAGXCVP($P(DATA,$C(9),2))) I DESC="" S DESC="(none)"
 . S PROCTXT=$$STRIP^MAGXCVP($$UCASE^MAGXCVP($P(DATA,$C(9),3))) I PROCTXT="" S PROCTXT="(none)"
 . S PARENT=$P(DATA,$C(9),4) I PARENT="" S PARENT="(none)"
 . S DOCCAT=$P(DATA,$C(9),5) I DOCCAT="" S DOCCAT="(none)"
 . S OBJTYP=$P(DATA,$C(9),6) I OBJTYP="" S OBJTYP="(none)"
 . S SAVBYGRP=$P(DATA,$C(9),7) I SAVBYGRP="" S SAVBYGRP="(none)"
 . S ^(SAVBYGRP)=$G(^TMP($J,"MAGIXCVSTAT",PKG,CLS,TYP,PROC,SPEC,ORIG,DESC,PROCTXT,PARENT,DOCCAT,OBJTYP,SAVBYGRP))+1
 . I LN#100=0 U IO(0) W "."
 . I LN#5000=0 U IO(0) W LN,!
 . Q
 D ^%ZISC
 U IO(0) W !,"File import complete.",! G SM2
 ;
 ; Reached when an error (including end-of-file) occurs.
ERR ;
 S $ET=""
 D ^%ZISC
 U IO(0) X "W !,$ZE" W !,"Processing interrupted after ",LN," lines.",!
 ;
SM2 ;
 W !,"This report must be run on at least a 132-column device.",!
 D EN^XUTMDEVQ("ANZRPT^"_$T(+0),"Print Image Index Summary Report",.ZTSAVE)
 Q
 ;
ANZRPT ;
 I IOM<132 W !,"This report must be run on at least a 132-column device.  Goodbye!",! Q
 N KT,NUPG,OBJTYP,PG,PROCTXT,SAVBYGRP
 N FQUIT ; --- quit flag from header logic
 N RDATE ; --- report date
 ;
 S RDATE=$$HTE^XLFDT($H,1)
 S PG=0
 S FQUIT=0
 S SUB=$O(^MAG(2006.1,0)) I SUB S SUB=$P($G(^MAG(2006.1,SUB,0)),U)
 ;
 S PKG=""
 F  S PKG=$O(^TMP($J,"MAGIXCVSTAT",PKG)) Q:PKG=""  D  Q:FQUIT
 . S CLS=""
 . F  S CLS=$O(^TMP($J,"MAGIXCVSTAT",PKG,CLS)) Q:CLS=""  D  Q:FQUIT
 . . S TYP=""
 . . F  S TYP=$O(^TMP($J,"MAGIXCVSTAT",PKG,CLS,TYP)) Q:TYP=""  D  Q:FQUIT
 . . . S PROC=""
 . . . F  S PROC=$O(^TMP($J,"MAGIXCVSTAT",PKG,CLS,TYP,PROC)) Q:PROC=""  D  Q:FQUIT
 . . . . S SPEC=""
 . . . . F  S SPEC=$O(^TMP($J,"MAGIXCVSTAT",PKG,CLS,TYP,PROC,SPEC)) Q:SPEC=""  D  Q:FQUIT
 . . . . . S ORIG=""
 . . . . . F  S ORIG=$O(^TMP($J,"MAGIXCVSTAT",PKG,CLS,TYP,PROC,SPEC,ORIG)) Q:ORIG=""  D SPEC1 Q:FQUIT
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
 ;
SPEC1 ;
 S NUPG=1
 S DESC=""
 F  S DESC=$O(^TMP($J,"MAGIXCVSTAT",PKG,CLS,TYP,PROC,SPEC,ORIG,DESC)) Q:DESC=""  D  Q:FQUIT
 . S PROCTXT=""
 . F  S PROCTXT=$O(^TMP($J,"MAGIXCVSTAT",PKG,CLS,TYP,PROC,SPEC,ORIG,DESC,PROCTXT)) Q:PROCTXT=""  D  Q:FQUIT
 . . S PARENT=""
 . . F  S PARENT=$O(^TMP($J,"MAGIXCVSTAT",PKG,CLS,TYP,PROC,SPEC,ORIG,DESC,PROCTXT,PARENT)) Q:PARENT=""  D  Q:FQUIT
 . . . S DOCCAT=""
 . . . F  S DOCCAT=$O(^TMP($J,"MAGIXCVSTAT",PKG,CLS,TYP,PROC,SPEC,ORIG,DESC,PROCTXT,PARENT,DOCCAT)) Q:DOCCAT=""  D  Q:FQUIT
 . . . . S OBJTYP=""
 . . . . F  S OBJTYP=$O(^TMP($J,"MAGIXCVSTAT",PKG,CLS,TYP,PROC,SPEC,ORIG,DESC,PROCTXT,PARENT,DOCCAT,OBJTYP)) Q:OBJTYP=""  D  Q:FQUIT
 . . . . . S SAVBYGRP=""
 . . . . . F  S SAVBYGRP=$O(^TMP($J,"MAGIXCVSTAT",PKG,CLS,TYP,PROC,SPEC,ORIG,DESC,PROCTXT,PARENT,DOCCAT,OBJTYP,SAVBYGRP)) Q:SAVBYGRP=""  S KT=^(SAVBYGRP) D  Q:FQUIT
 . . . . . . I KT<FRQTHRS Q  ; count must exceed frequency threshold
 . . . . . . I ($Y>(IOSL-3))!NUPG D ANZHED Q:FQUIT
 . . . . . . W DESC,"  ",?34,PROCTXT,"  ",?64,PARENT,"  ",?78,DOCCAT,"  ",?92,OBJTYP,"  ",?106,SAVBYGRP,"  ",?150,$J(KT,8),!
 . . . . . . Q
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
 ;
ANZHED ;
 I PG>0,IOT="TRM"!(IOT="VTRM") D  Q:FQUIT
 . R !!,"Press <RETURN> to continue, or '^' to exit: ",RET:DTIME
 . S FQUIT=(RET="^")
 . Q
 S PG=PG+1,NUPG=0
 W #!,"Site: ",SUB D CTR("IMAGE INDEX GENERATION REPORT") W ?115,"DATE ",RDATE,!
 ;W "Range: ",RANGE
 D CTR("Package: "_PKG)
 W ?122,$J("PAGE "_PG,8),!
 D CTR("Class: "_$S(CLS:CLS_" - "_$P($G(^MAG(2005.82,CLS,0)),"^"),1:"(none)")) W !
 D CTR("Type: "_$S(TYP:TYP_" - "_$P($G(^MAG(2005.83,TYP,0)),"^"),1:"(none)")) W !
 D CTR("Procedure/Event: "_$S(PROC:PROC_" - "_$P($G(^MAG(2005.85,PROC,0)),"^"),1:"(none)")) W !
 D CTR("Specialty: "_$S(SPEC:SPEC_" - "_$P($G(^MAG(2005.84,SPEC,0)),"^"),1:"(none)")) W !
 D CTR("Origin: "_ORIG) W !!
 W ?64,"Parent",!
 W "Short Description",?34,"Procedure Text",?64,"Data File",?78,"Document Cat",?92,"Object Type",?106,"Save By Group",?153,"Count",!!
 Q 
 ;
CTR(X) W ?65-($L(X)/2),X Q
EOR ;END ROUTINE
