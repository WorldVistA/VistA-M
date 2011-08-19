ONCSEDEM ;Hines OIFO/SG - EDITS API (DEMO)  ; 11/6/06 11:56am
 ;;2.11;ONCOLOGY;**47**;Mar 07, 1995;Build 19
 ;
 Q
 ;
 ;***** DEMO ENTRY POINT
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see ^ONCSAPI)
 ;
DEMO(ONCSAPI) ;
 N CFGNAME,MSGLST,RC,REQUEST
 W !!?10,"DEMO CLIENT FOR THE EDITS API",!
 D CLEAR^ONCSAPIE(1)
 S REQUEST=$NA(^TMP("ONCSEDEM",$J,1))
 S MSGLST=$NA(^TMP("ONCSEDEM",$J,2))
 ;
 ;--- Check the DLL version
 S RC=$$CHKVER^ONCSAPIV(.ONCSAPI)
 D:RC<0 PRTERRS^ONCSAPIE(),CLEAR^ONCSAPIE()
 ;
 D
 . ;--- Ask user for configuration name
 . S RC=$$GETCFG(.CFGNAME)  Q:RC
 . ;--- Prepare and execute the EDITS request
 . W !,"Validating the data..."
 . S RC=$$RBQPREP^ONCSED01(.ONCSAPI,.REQUEST,CFGNAME)  Q:RC<0
 . D NAACCR(.REQUEST)
 . S RC=$$RBQEXEC^ONCSED01(.ONCSAPI,.REQUEST,MSGLST)   Q:RC<0
 . I RC>0  D  Q:RC<0
 . . N %ZIS,IOP,POP
 . . S %ZIS("B")="BROWSER"
 . . D ^%ZIS  Q:$G(POP)  U IO
 . . S RC=$$REPORT^ONCSED01(.ONCSAPI,MSGLST,"MT")
 . . D ^%ZISC
 ;
 ;--- Error processing and cleanup
 D:RC<0 PRTERRS^ONCSAPIE()
 K ^TMP("ONCSEDEM",$J)
 Q
 ;
 ;***** ASKS USER FOR CONFIGURATION NAME
 ;
 ; .CFGNAME      Reference to a local variable where the name
 ;               will be returned to.
 ;
 ; Return values:
 ;
 ;       <0  Error Descriptor (see ^ONCSAPI for details)
 ;        0  Ok
 ;        1  User canceled the output ('^' was entered)
 ;        2  Timeout
 ;
GETCFG(CFGNAME) ;
 N DA,DIR,DIRUT,DTOUT,DUOUT,RC,X,Y
 S CFGNAME=""
 S DIR(0)="FO",DIR("B")="DEFAULT"
 S DIR("A")="Configuration name"
 D ^DIR
 S RC=$S($D(DUOUT):1,$D(DTOUT):2,1:0)  Q:RC RC
 S CFGNAME=X
 Q 0
 ;
 ;***** GENERATES A NAACCR RECORD WITH RANDOM DATA
NAACCR(ONCDST) ;
 N I,TMP
 F I=1:1:10  D
 . S TMP="",$P(TMP,$C(64+$R(58)),$R(513)+1)=""
 . D WRITE^ONCSNACR(.ONCDST,TMP)
 Q
