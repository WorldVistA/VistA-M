LRLNCX  ;DALOI/FS- ROUTINE TO EXTRACT VISTA TEST NAMES FOR LOINC MAPPING;1-FEB-2001
 ;;5.2;LAB SERVICE;**232,278**;Sep 27,1994
 ;;
 ; Field Separator = "|"
 ;LR60 = IEN from ^LAB(60
 ;LRSP = SPECIMEN pointer to ^LAB(61
 ;LR60N = TEST NAME FOR ^LAB(60 - *? are translated to spaces for RELMA
 ;LRSPN = SPECIMEN NAME - attempt to get LOINC Abbrv if linked
 ;LRUNIT = REPORTING UNITS FROM ^LAB(60,IEN,1,LRSP,0)
 ;1-70|WBC BLD K/cmm
 ;Capture the output into a text file to import into Relma.
 ;Remove 1st and last lines before importing into Relma
EN ;
 K ^TMP("LR LOINC",$J),LREND,LRAA
 D MSG W !
 G END:$G(LREND)
 S LRFS="|",LR60=0,LR60N=""
 G @LRANS
3 ;Selected all tests
2 ;Selected accession area - screen on LRAA(#)
 D ASK G END:$G(LREND)
 F  S LR60N=$O(^LAB(60,"B",LR60N)) Q:LR60N=""  D
 . S LR60=0 F  S LR60=$O(^LAB(60,"B",LR60N,LR60)) Q:LR60<1  D
 . . Q:$G(^LAB(60,"B",LR60N,LR60))
 . . I '$D(^LAB(60,LR60,0))#2 K ^LAB(60,"B",LR60N,LR60) Q
 . . Q:$P(^LAB(60,LR60,0),U,3)="N"!($P(^(0),U,3)="")  D OUT
 Q
1 ;create individual test list.
 K ^TMP("LR LOINC",$J)
 S ^TMP("LR LOINC",$J,0)=DT_U_DT_U_"LRLNCX TEST LIST"
 K DIR
 S DIR(0)="PO^60:NQEMZ"
 S DIR("S")="I $L($P(^(0),U,3)),$P(^(0),U,3)'=""N"",$P($P(^(0),U,5),"";"",2)"
 F  D ^DIR Q:Y<1  S ^TMP("LR LOINC",$J,Y(0,0)_+Y,0)=+Y_U_Y(0,0)
 I $O(^TMP("LR LOINC",0))'="" D ASK G END:$G(LREND)
 S LRNX=0
 ;W !,$TR($$SITE^VASITE,U,"|")_"|"_$$FMTE^XLFDT($$NOW^XLFDT,1)
 F  S LRNX=$O(^TMP("LR LOINC",$J,LRNX)) Q:LRNX=""  D
 . S LR60=$G(^TMP("LR LOINC",$J,LRNX,0))
 . Q:'$G(LR60)
 . I $L($P(LR60,U,2)) S LR60N=$P(LR60,U,2),LR60=+LR60 D OUT
 G END
 Q
OUT ;
 I $G(LRAA) S LRNOP=1 D  Q:LRNOP
 . S LR8=0 F  S LR8=$O(^LAB(60,LR60,8,LR8)) Q:LR8<1!('$G(LRNOP))  D
 . . I $D(LRAA(+$P($G(^LAB(60,LR60,8,LR8,0)),U,2)))#2 S LRNOP=0
 S LRSP=0 F  S LRSP=$O(^LAB(60,LR60,1,LRSP)) Q:LRSP<1  D
 . S LRSP0=$G(^(LRSP,0)),LR61=$G(^LAB(61,LRSP,0)),LRUNIT=$P(LRSP0,U,7)
 . S LRSPN=$P(LR61,U),LR64061=$P(LR61,U,9),LRLSPN=$P(LR61,U,8)
 . K LR64N I LR64061 S LR64N=$P($G(^LAB(64.061,LR64061,0)),U,2)
 . S LRSPN=$S($D(LR64N):LR64N,$L(LRLSPN):LRLSPN,1:LRSPN)
 . D WRT
 Q
WRT ;LR60N [test name] - translate "*" or "?" to spaces
 W !,$E(LR60_"-"_LRSP_LRFS_$TR(LR60N,"*?"," ")_" "_LRSPN_LRFS_LRUNIT,1,80)
 Q
ASK ;
 K DIR S DIR(0)="Y",DIR("A")="Ready to Capture"
 D ^DIR S:$D(DIRUT) LREND=1
 Q
MSG ;
 W @IOF
 W !,"(NOTE) You should use the Add/Edit Topography Specimen HL7 Code"
 W !,"[LR LOINC LEDI HL7 CODE] option before you proceed."
 W !," -----    -----     -----     ----"
 W !,"This option will create a Local Master Observation File (LMOF)"
 W !,"from your local LABORATORY TEST (#60) file."
 W !!,"Only 'CH' subscripted test having a dataname and having a type"
 W !,"of 'BOTH', 'INPUT' or 'OUTPUT' will be extracted."
 W !,"The LMOF file will use the vertical bar '|' as the field separator."
 W !,"The 1st. field is the test internal number and internal number"
 W !,"of the spec. (i.e. 1-72 will represent test 1 and specimen 72)."
 W !,"The 2nd field contains |test name<SP>specimen."
 W !,"The 3rd field is the reporting unit only (if any)."
 W !!,"You will need to capture this printout into a text file."
 W !,"Using a text editor, remove extraneous lines from the beginning"
 W !,"and the end of the file so that only extracted test names remain."
 W !,"Save the edited file. Use this file in the import function of the"
 W !,"Regenstrief LOINC Mapping Assistant (RELMA)."
 W !,"Consult the Regenstrief RELMA documentation for specifics."
 K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) LREND=1 Q:$G(LREND)
SEL ;Select method of extraction
 K DIR,LRAA
 S (LRANS,LREND)=0
 S DIR(0)="SO^1:Individual single test;2:By Accession Area;3:All Test"
 S DIR("A")="Select extraction criteria"
 D ^DIR S:$D(DIRUT) LREND=1
 I Y>0 S LRANS=Y
 I LRANS=2 D
 . K DIR
 . S DIR(0)="PO^68:ENZM",DIR("A")="Select accession area "
 . S DIR("S")="I $P(^(0),U,17)'=""S"""
 . F  D ^DIR Q:Y<1  D
 . . S LRAA=Y
 . . S LRAA(+LRAA)=LRAA,DIR("A")="Select another accession area "
 Q
END ;
 K DIR,DIRUT,LR60,LR60N,LR61,LR64061,LR64N,LR8,LRAA,LRANS,LREND,LRFS,LRLSPN,LRNOP,LRNX,LRSITE,LRSP,LRSP0,LRSPN,LRUNIT,Y
 Q
