VAQLED05 ;ALB/JFP,JRP - PDX, LOAD/EDIT DIFFERENCES,SCREEN;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;**6**;NOV 17, 1993
EP ; -- Main entry point
 W !,"Please wait while differences are found..."
EP1 D FLECHK^VAQUTL98,FLDCHK^VAQUTL98 ; -- Build table of excluded fields
 S (VAQECNT,VALMCNT)=0
 K ^TMP("VAQL2",$J),^TMP("VAQIDX",$J)
 I $D(^TMP("VAQLD",$J)) D MSG
 D:$D(XRTL) T0^%ZOSV ; -- Capacity start
 D MAIN,MULT
 I VAQECNT=0 D
 .S X=$$SETSTR^VALM1(" ","",1,80) D TMP2
 .S X=$$SETSTR^VALM1(" ** No differences found...","",1,80) D TMP2
 D EXIT
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ; -- Capacity stop
 QUIT
 ;
MAIN ; -- Loops thru patient file looking for differences by field
 S FLE=2,SEQ=0,(TYPE,FLD)=""
 F  S FLD=$O(^TMP("VAQTR",$J,"VALUE",FLE,FLD))  Q:FLD=""  D
 .I (FLE=2)&($D(FLD(FLD))) D KILL1  QUIT
 .S PDXVALUE=$G(^TMP("VAQTR",$J,"VALUE",FLE,FLD,SEQ))
 .I PDXVALUE="" D KILL QUIT
 .S PTVALUE=$G(^TMP("VAQPT",$J,"VALUE",FLE,FLD,SEQ))
 .I PDXVALUE=PTVALUE D KILL QUIT
 .D DISP1,DISP2
 QUIT
 ;
MULT ; -- Loop thru multiple associated with patient file
 S FLE=2,FLD=.01,SEQ=0,TYPE="M"
 F  S FLE=$O(^TMP("VAQTR",$J,"VALUE",FLE))  Q:(FLE="")  D M1
 QUIT
M1 I $D(FLE(FLE)) D KILL2 QUIT
 D MLOAD,MULTDIF
 QUIT
 ;
MLOAD ; -- Loads .01 field of multiple into an array for compare (patient)
 K ^TMP("PTVALUE",$J)
 S SEQ=""
 F  S SEQ=$O(^TMP("VAQPT",$J,"VALUE",FLE,FLD,SEQ))  Q:SEQ=""  D
 .S PTVALUE=$G(^TMP("VAQPT",$J,"VALUE",FLE,FLD,SEQ))
 .S:PTVALUE'="" ^TMP("PTVALUE",$J,PTVALUE)=""
 QUIT
 ;
MULTDIF ; -- Displays entries which do not match .01
 S SEQ="",FLD=.01
 F  S SEQ=$O(^TMP("VAQTR",$J,"VALUE",FLE,FLD,SEQ))  Q:SEQ=""  D
 .S PDXVALUE=$G(^TMP("VAQTR",$J,"VALUE",FLE,FLD,SEQ))
 .Q:PDXVALUE=""
 .I $D(^TMP("PTVALUE",$J,PDXVALUE)) D KF QUIT
 .D DISP1,DISP3,DISP4
 S X=$$SETSTR^VALM1(" ","",1,80) D TMP
 QUIT
 ;
DISP1 ; -- Display line 1
 S VAQECNT=VAQECNT+1
 S X=$$SETSTR^VALM1(VAQECNT,"",1,3)
 S FLDNAME="("_$P($G(^DD(FLE,FLD,0)),U,1)_")"
 S X=$$SETSTR^VALM1(FLDNAME,X,6,73)
 D TMP
 QUIT
 ;
DISP2 ; -- Display line 2
 S X=$$SETFLD^VALM1($S(PTVALUE'="":PTVALUE,1:"* no data in patient file "),"","PTVALUE")
 S X=$$SETFLD^VALM1($S(PDXVALUE'="":PDXVALUE,1:"* no data in PDX data file "),X,"PDXVALUE")
 D TMP
 S X=$$SETSTR^VALM1(" ","",1,80) D TMP
 QUIT
 ;
DISP3 ; -- Display line 3
 S X=$$SETFLD^VALM1("* multiple does not contain entry ","","PTVALUE")
 S X=$$SETFLD^VALM1(PDXVALUE,X,"PDXVALUE")
 D TMP
 QUIT
 ;
DISP4 ; -- Displays all fields associated with multiple from transaction file
 N FLD
 S FLD=.01
 F  S FLD=$O(^TMP("VAQTR",$J,"VALUE",FLE,FLD))  Q:FLD=""  D D41
 QUIT
D41 S PDXVALUE=$G(^TMP("VAQTR",$J,"VALUE",FLE,FLD,SEQ))
 S FLDNAME="  - ("_$P($G(^DD(FLE,FLD,0)),U,1)_")"
 S X=$$SETFLD^VALM1(FLDNAME,"","PTVALUE")
 S X=$$SETFLD^VALM1($S(PDXVALUE'="":PDXVALUE,1:"* no data in PDX data file "),X,"PDXVALUE")
 D TMP
 QUIT
 ;
KILL ; -- Kills entries which are not different for work arrays
 K ^TMP("VAQTR",$J,"VALUE",FLE,FLD,SEQ)
 K ^TMP("VAQPT",$J,"VALUE",FLE,FLD,SEQ)
 QUIT
KILL1 K ^TMP("VAQTR",$J,"VALUE",FLE,FLD)
 K ^TMP("VAQPT",$J,"VALUE",FLE,FLD)
 QUIT
KILL2 K ^TMP("VAQTR",$J,"VALUE",FLE)
 K ^TMP("VAQPT",$J,"VALUE",FLE)
 QUIT
KF ; -- kills fields in subfile
 N FLD S FLD=""
 F  S FLD=$O(^TMP("VAQTR",$J,"VALUE",FLE,FLD))  Q:FLD=""  D KILL
 QUIT
 ;
TMP ; -- Set the array used by list processor
 S VALMCNT=VALMCNT+1
 S ^TMP("VAQL2",$J,VALMCNT,0)=$E(X,1,79)
 S ^TMP("VAQL2",$J,"IDX",VALMCNT,VAQECNT)=""
 S:SEQ'="" ^TMP("VAQIDX",$J,VAQECNT)=DFNTR_"^"_DFNPT_"^"_FLE_"^"_FLD_"^"_SEQ_"^"_TYPE
 Q
MSG ; -- Displays entries not passing the input transform
 N ENTRY,NODE,FLDNAME,MSG,LN,X
 S X=$$SETSTR^VALM1(" ","",1,79) D TMP2
 S ENTRY=""
 F  S ENTRY=$O(^TMP("VAQLD",$J,ENTRY))  Q:ENTRY=""  D
 .S NODE=$G(^TMP("VAQLD",$J,ENTRY))
 .S FLDNAME=$P($G(^DD($P(NODE,U,1),$P(NODE,U,2),0)),U,1)
 .S MSG="* Upload of "_FLDNAME_" did not pass input transform"
 .S X=$$SETSTR^VALM1(MSG,"",1,79)
 .D TMP2
 S X=$$SETSTR^VALM1(" ","",1,79) D TMP2
 S LN=$$REPEAT^VAQUTL1("-",79)
 S X=$$SETSTR^VALM1(LN,"",1,79) D TMP2
 S X=$$SETSTR^VALM1(" ","",1,79) D TMP2
 K ENTRY,NODE,FLDNAME,MSG,LN,X
 QUIT
 ;
TMP2 ; -- Sets array for list processor for message
 S VALMCNT=VALMCNT+1
 S ^TMP("VAQL2",$J,VALMCNT,0)=$E(X,1,79)
 S ^TMP("VAQL2",$J,"IDX",VALMCNT,1)=""
 QUIT
 ;
EXIT ; -- Note: The list processor cleans up its own variables.
 ;          All other variables cleaned up here.
 K ^TMP("PTVALUE",$J)
 K VAQECNT,FLE,FLD,SEQ,TYPE,PDXVALUE,PTVALUE,X,FLDNAME
 Q
 ;
END ; -- End of code
 QUIT
