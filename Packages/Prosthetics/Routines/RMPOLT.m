RMPOLT ;EDS/PAK - HOME OXYGEN LETTERS ;7/24/98
 ;;3.0;PROSTHETICS;**29**;Feb 09, 1996
EN ; -- main entry point for RMPO LETTER
 ;
 ; Input:
 ;   RMPOLCD              - Selected Home Oxygen Letter code
 ;
 ; Called by:
 ;   RMPOLZ               - H.O. Letter Control module
 ;
 D EN^VALM("RMPO LETTER")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=$$CNTR^RMPOLY(" ",$$EXTERNAL^DILFD(669.965,1,"",RMPOLCD),80)
 S VALMHDR(2)=$$CNTR^RMPOLY(" ","HOME OXYGEN PATIENT LETTER LIST",80)
 Q
 ;
INIT ; -- init variables and list array
 N RMPODFN,REC,RMPOITEM,Y,X,SP
 ;
 ; for each entry in list for the selected letter type display details
 S RMPONAM="",VALMCNT=0,$P(SP," ",80)=" "
 F  S RMPONAM=$O(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM)) Q:RMPONAM=""  D
 . S RMPODFN=$P(^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM),U,2)
 . S REC=^TMP($J,RMPOXITE,"RMPODEMO",RMPODFN),VALMCNT=VALMCNT+1
 . S Y=$P(REC,U,3) D DD^%DT S RMPORX=Y,Y=$P(REC,U,4)
 . I Y'="" D DD^%DT
 . I Y="" S Y="No Rx!"
 . S RMPOEXP=Y,RMPOITEM=$P(REC,U,5)
 . S:RMPOITEM="" RMPOITEM="No Primary!"
 . ;
 . S X=$$SETFLD^VALM1($E(VALMCNT_SP,1,$P(VALMDDF("LINE #"),U,3)),"","LINE #")
 . S X=$$SETFLD^VALM1($P(REC,U),X,"PATIENT")
 . S X=$$SETFLD^VALM1($P(REC,U,2),X,"SSN")
 . S X=$$SETFLD^VALM1(RMPOITEM,X,"PRIMARY ITEM")
 . S X=$$SETFLD^VALM1(RMPORX,X,"ACTIVATION DATE")
 . S X=$$SETFLD^VALM1(RMPOEXP,X,"Rx EXPIRY DATE")
 . D SET^VALM10(VALMCNT,X,RMPODFN)
 ;
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAN^VALM10
 ;
 Q
 ;
EXPND ; -- expand code
 Q
 ;
EN02 ; Delete list entry
 ;
 N SEL,LINE
 ;
 ; Select lines to delete
 S SEL=$$SELN^RMPOLZA("L","Enter lines to delete",VALMCNT)
 I SEL="^" S ^TMP($J,RMPOXITE,"EXIT")=1 Q  ; quit to menu
 Q:'SEL
 ;
 N CNT
 ;
 ; for each patient selected remove 'Letter to be sent' from
 ; Prosthetics Patient File (665)
 F CNT=1:1 S LINE=$P(SEL,",",CNT) Q:LINE=""  D
 . S RMPODFN=$O(@VALMAR@("IDX",LINE,""))
 . D UPDLTR^RMPOLZA(RMPODFN,"@")
 . ;
 . ; purge work file holding data
 . K ^TMP($J,RMPOXITE,"RMPOLST",RMPOLCD,RMPONAM),^TMP($J,RMPOXITE,"RMPODEMO",RMPODFN)
 ;
 ; delete listman data and rebuild list from amended work file
 D CLEAN^VALM10,INIT
 Q:'$D(@VALMAR)  ; Quit if there are no entries in list
 S VALMBCK="R"
 Q
