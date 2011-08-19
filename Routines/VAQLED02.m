VAQLED02 ;ALB/JFP - PDX, LOAD/EDIT,SETUP OF DIFFERENCES;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EP ; -- Main entry point for the list processor
 ; -- K XQORS,VALMEVL ;(only kill on the first screen in)
 ;
 ;D CLEAR^VALM1
 S VAQBCK=0
 D MAIN^VAQLED04 ; -- collects PDX data and MAS data
 I '$D(^TMP("VAQTR",$J))!('$D(^TMP("VAQPT",$J))) D  QUIT
 .W !,"     Error...No data collected"
 .S VAQFLAG=1 D TRANEX
 D EN^VALM("VAQ LED DIFFERENCES PDX6")
 QUIT
 ;
INIT ; -- Builds array of differences between PDX minimal and the local
 ;    data stored in file 2.
 ;
 K ^TMP("VAQL2",$J)
 K ^TMP("VAQPT",$J,"ID"),^TMP("VAQTR",$J,"ID"),^TMP("VAQLD",$J)
 D EP^VAQLED05
 QUIT
 ;
HD ; -- Make header line for list processor
 D HD1^VAQEXT02 QUIT
 ;
FIELD ; -- Updates local patient file by field or fields selected
 S (VAQFLAG,VAQUPDFL)=0
 D SEL^VALM2
 Q:'$D(VALMY)
 D CLEAR^VALM1
 S ENTRY="" K ^TMP("VAQLD",$J)
 F  S ENTRY=$O(VALMY(ENTRY))  Q:ENTRY=""  D
 .S SDAT=$G(^TMP("VAQIDX",$J,ENTRY))
 .D UPDATE
 I VAQUPDFL=1 D WORKLD
 D EP1^VAQLED05 ; -- Redisplay
 S VALMBCK="R"
 S VAQBCK=1
 QUIT
 ;
UPDATE ; -- Loads fields for update
 S DFNTR=$P(SDAT,U,1)
 S DFNPT=$P(SDAT,U,2)
 I DFNPT="" W !,"Local patient pointer missing... unable to upload field" QUIT
 S (FLE,LFLE)=$P(SDAT,U,3)
 S FLD=$P(SDAT,U,4)
 S SEQ=$P(SDAT,U,5)
 S MFLAG=$P(SDAT,U,6)
 I LFLE'=2 S LFLE=2 ; -- only lock top level file
 S LOCKFLE=$G(^DIC(LFLE,0,"GL"))
 L +(@(LOCKFLE_DFNPT_")")):60
 I ('$T) W !,"Could not edit entry... record locked" K LOCKFLE  QUIT
 D:MFLAG="" UPDTER1
 D:MFLAG="M" UPDTEM1
 L -(@(LOCKFLE_DFNPT_")")) K LOCKFLE
 ; -- data loaded
 S VAQUPDFL=1
 I '($D(Y)#2) D KILL QUIT
 S ^TMP("VAQLD",$J,ENTRY)=FLE_"^"_FLD ; -- data not pass input transform
 QUIT
 ;
UPDTER1 ;  -- Updates patient with PDX data (field by field) ** NON MUTIPLE **
 S DIE=$G(^DIC(FLE,0,"GL"))
 S DA=DFNPT
 S DR=FLD_"///^S X=$G(^TMP(""VAQTR"",$J,""VALUE"",FLE,FLD,0))"
 D ^DIE
 K DIE,DA,DR
 QUIT
 ;
UPDTEM1 ;  -- Updates patient with PDX data (field by field) ** MULTIPLE **
 ;     Loads pointer to main file
 S MFLE=$G(^DD(FLE,0,"UP")) ; -- main file
 S MFLD="",MFLD=$O(^DD(MFLE,"SB",FLE,MFLD))
 S FLD=.01
 S DIE=$G(^DIC(MFLE,0,"GL"))
 S DA=DFNPT
 S DR=MFLD_"///"_$G(^TMP("VAQTR",$J,"VALUE",FLE,FLD,SEQ))
 D UPDTEM2
 D ^DIE
 K DIE,DA,DR,MFLE,MFLD,VALUE
 QUIT
 ;
UPDTEM2 ; -- Load fields into sub file for entry
 F  S FLD=$O(^TMP("VAQTR",$J,"VALUE",FLE,FLD))  Q:FLD=""  D
 .S VALUE=FLD_"///"_$G(^TMP("VAQTR",$J,"VALUE",FLE,FLD,SEQ))
 .S DR(2,FLE)=VALUE
 .S DR(2,FLE,FLD)=VALUE
 QUIT
 ;
LOAD ;  -- Loads all different fields from PDX segment to local patient file
 I '$D(^TMP("VAQIDX",$J)) S VALMBCK="Q"  QUIT
 S (VAQFLAG,VAQUPDFL)=0
 D CLEAR^VALM1
 S ENTRY="" K ^TMP("VAQLD",$J)
 F  S ENTRY=$O(^TMP("VAQIDX",$J,ENTRY))  Q:ENTRY=""  D
 .S SDAT=$G(^TMP("VAQIDX",$J,ENTRY))
 .D UPDATE
 I VAQUPDFL=1 D WORKLD
 D EP1^VAQLED05
 S VALMBCK="R"
 S VAQBCK=1
 QUIT
 ;
TRANEX ; -- Pauses screen
 D PAUSE^VALM1
 S:'$D(VAQFLAG) VAQFLAG=""
 S VALMBCK=$S(VAQFLAG=0:"R",1:"Q")
 QUIT
 ;
WORKLD ; -- Updates workload file for update
 S X=$$WORKDONE^VAQADS01("UPDTE",DFNTR,$G(DUZ))
 I X<0 W !,"Error updating workload file (UPDTE)... "_$P(X,U,2)
 I $P($G(^VAT(394.61,DFNTR,0)),U,4)=0 QUIT
 S X=$$WORKDONE^VAQADS01("SNSTVE",DFNTR,$G(DUZ))
 I X<0 W !,"Error updating workload file (SNSTVE)... "_$P(X,U,2)
 QUIT
 ;
KILL ; --
 K ^TMP("VAQTR",$J,"VALUE",FLE,$S(MFLAG="M":.01,1:FLD),SEQ)
 K ^TMP("VAQPT",$J,"VALUE",FLE,$S(MFLAG="M":.01,1:FLD),SEQ)
 QUIT
 ;
EXIT ; -- Note: The list processor cleans up its own variables.
 ;          All other variables cleaned up here.
 ;
 K ^TMP("VAQL2",$J),^TMP("VAQIDX",$J)
 K ^TMP("VAQPT",$J),^TMP("VAQTR",$J),^TMP("VAQLD",$J)
 K VAQFLAG,VAQUPDFL
 K DFNTR,DFNPT,FLE,FLD,SEQ,MFLAG,LFLE
 Q
 ;
END ; -- End of code
 QUIT
