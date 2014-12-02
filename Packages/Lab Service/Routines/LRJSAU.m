LRJSAU ;ALB/PO/DK/TMK Lab Audit Manager ;13 Jul 2009  2:29 AM
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
F60 ;File 60 entry point
 D EN2
 K ^TMP("LRJ SYS F60 AUD MANAGER",$J)
 Q
 ;
EN2 ; -- main entry point for LRJ SYS AUF60 MANAGER (file 60)
 ; -- required interface routine variable
 N LRJSROU S LRJSROU="LRJSAU"
 K ^TMP("LRJ SYS F60 AUD MANAGER",$J)
 D MSG2^LRJSAU60
 D EN^VALM("LRJ SYS MAP AUF60")
 Q
 ;
HDR2 ; -- header code
 S VALMHDR(1)="                         Lab File 60 Audit Manager"
 S VALMHDR(2)="                         Version: "_$$VERNUM()_"     Build: "_$$BLDNUM()
 Q
 ;
BUILD ; -- build display array
 K ^TMP("LRJ SYS F60 AUD MANAGER",$J)
 S VALMCNT=0
 D AUDCHK^LRJSAU60(1)
 Q
 ;
HELP ; -- help code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("LRJ SYS F60 AUD MANAGER",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("LRJ SYS F60 AUD MANAGER",$J)
 D CHGCAP^VALM("HEADER","")
 S VALMCNT=0
 Q
 ;
BLDNUM() ; -- returns the build number
 QUIT +$PIECE($PIECE($TEXT(LRJSAU+1),";",7),"Build ",2)
 ;
VERNUM() ; -- returns the version number for this build
 QUIT +$PIECE($TEXT(LRJSAU+1),";",3)
 ;
CLEAR ; -- clean up entries
 D REFRESH
 Q
 ;
REFRESH ; -- refresh display
 D BUILD
 D CHGCAP^VALM("HEADER","")
 S VALMBCK="R"
 Q
 ;
KILL ; -- kill off build data
 K ^TMP("LRJ SYS F60 AUD MANAGER",$J)
 K ^TMP($J,"LRAUDREQ")
 S VALMBG=1
 S VALMBCK="R"
 Q
 ;
AUDSET ; enable audit fields for file 60
 ; called from POST^LR425
 ; ICR 4122
 N LRI,LRAFLDS,LRSUB,LRSTR,LRAUDFIL
 F LRI=1:1 S LRAFLDS=$P($TEXT(AFLDS+LRI),";;",2) Q:LRAFLDS="$$END$$"  D
 . S LRAUDFIL=+$P($P(LRAFLDS,"^"),";",2) ; Pull off subfield # to get subfile if there
 . I LRAUDFIL D  ; Get subfile #
 . . S LRAUDFIL=$$GFLDSB^LRJSAU60(+LRAFLDS,LRAUDFIL)
 . S:'LRAUDFIL LRAUDFIL=+LRAFLDS
 . ;the following turns audit on for fields specified in SRS
 . D TURNON^DIAUTL(LRAUDFIL,$P(LRAFLDS,"^",2))
 Q
 ;
ADD(VALMCNT,MSG,LRBOLD) ; -- add line to build display
 SET VALMCNT=VALMCNT+1
 DO SET^VALM10(VALMCNT,MSG)
 IF $GET(LRBOLD) DO CNTRL^VALM10(VALMCNT,1,79,IOINHI,IOINORM)
 QUIT
 ;
 ; AFLDS data: 1st ^ piece: File #_[;_field # of subfile]-> if needed
 ;             2nd ^ piece: the field #'s within that file/subfile to audit, separated by ;
AFLDS ;fields to be audited according to SRS
 ;;60^.01;3;4;8;17;18;64.1
 ;;60;100^.01;1;2;95.3
 ;;60;200^.01
 ;;60;300^.01
 ;;60;2^.01
 ;;60;6^.01;1
 ;;60;500^.01
 ;;60;500.1^.01
 ;;$$END$$
