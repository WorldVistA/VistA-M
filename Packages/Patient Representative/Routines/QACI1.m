QACI1 ; OAKOIFO/TKW - DATA MIGRATION - AUTO-CLOSE ROCS ;4/25/05  16:51
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
EN ; Auto-close open ROCs with a Date of Contact prior to user-selected date.
 I $D(^XTMP("QACMIGR","ROC","U")) D
 . W !!,"*** CAUTION! You have already moved some ROCs to the staging area. To migrate"
 . W !,"any changes to these ROCs, you will need to run the option to move data to"
 . W !,"the staging area again. ***" Q
 I $D(^XTMP("QACMIGR","ROC","D")) D
 . W !!,"*** You cannot auto-close ROCs that have already migrated into PATS ***" Q
 I '$D(^XTMP("QACMIGR","ROC","E")) D  Q
 . W !!,"*** CAUTION! You have not yet run the option to generate the error report.",!,"     You must run it before auto-closing ROCs!" Q
 N PATSCLDT,ROCIEN,ROC0,ROC2,ROCNO,CONVROC,CONDATE,INFOBY,ENTBY,STATION,TXT,EDITEBY,EDITIBY,EDITDIV,EDITITXT,EDITRTXT,PATSFDA,PATSIENS,DOTCNT,PATSCDT,CURRDT
 N PATSCNT S PATSCNT=0
 S CURRDT=$$DT^XLFDT()
 S PATSCDT=$$FMTE^XLFDT(CURRDT)
 S DOTCNT=0
 ; Set default text to replace null issue text or null resolution text
 S TXT(1)="This R.O.C. was auto-closed prior to migration to PATS"
 ; Prompt them for auto-close date
 S PATSCLDT=$$DEFDATE^QACI1A
 W !!!,"You have asked to auto-close Open ROCs with a Date of Contact prior to",!,"the beginning of the previous quarter --  "_$$FMTE^XLFDT(PATSCLDT),!
 D  Q:Y'=1
 . N DIR S DIR(0)="YO"
 . S DIR("A")="Are you sure"
 . S DIR("B")="YES"
 . D ^DIR Q
 W !,"."
 ;
 ; Initialize header for all migration data so Kernel will kill global in 30 days.
 S $P(^XTMP("QACMIGR",0),"^",1,2)=$$FMADD^XLFDT(CURRDT,30)_"^"_CURRDT
 ; Set a flag indicating that auto-close in in process
 S $P(^XTMP("QACMIGR","AUTO","C"),"^",2)=1
 ; Read through CONSUMER CONTACTS and auto-close ROCs.
 F ROCIEN=0:0 S ROCIEN=$O(^QA(745.1,ROCIEN)) Q:'ROCIEN  S ROC0=$G(^(ROCIEN,0)) D
 . S DOTCNT=DOTCNT+1 I DOTCNT=500 W "." S DOTCNT=0
 . ; Quit if ROC is already closed or if ROC number is null.
 . Q:$P($G(^QA(745.1,ROCIEN,7)),"^",2)="C"
 . S ROCNO=$P(ROC0,"^") Q:ROCNO=""
 . S CONVROC=$$CONVROC^QACI2C(ROCNO)
 . ; Quit is ROC has errors, or has been migrated.
 . Q:$D(^XTMP("QACMIGR","ROC","E",ROCNO_" "))
 . Q:$D(^XTMP("QACMIGR","ROC","D",CONVROC))
 . ; Quit if date of contact is past the close date, or if it's null
 . S CONDATE=$P(ROC0,"^",2) Q:CONDATE>PATSCLDT
 . S CONDATE=$$FMTE^XLFDT(CONDATE,5)
 . Q:CONDATE=""
 . S ROC2=$G(^QA(745.1,ROCIEN,2))
 . S (EDITEBY,EDITIBY,EDITDIV,EDITITXT,EDITRTXT)=0
 . ;Extract and check DIVISION. Quit if station number is invalid.
 . S STATION=+$P(ROC0,"^",16)
 . I 'STATION S STATION=$$LKUP^XUAF4($P(ROCNO,".")),EDITDIV=1
 . Q:$$STA^XUAF4(STATION)=""
 . ;Extract info taken by and entered by--quit if both are null.
 . S INFOBY=$P(ROC0,"^",6),ENTBY=$P(ROC0,"^",7)
 . I ENTBY="" S ENTBY=INFOBY,EDITEBY=1
 . I INFOBY="" S INFOBY=ENTBY,EDITIBY=1
 . Q:INFOBY=""
 . ;Make sure there is at least one issue code on the ROC, unless
 . ;  the date of contact is in or prior to FY 2003.
 . S I=$O(^QA(745.1,ROCIEN,3,0)),X=$P($G(^QA(745.1,ROCIEN,3,+I,0)),"^"),X=$P($G(^QA(745.2,+X,0)),"^")
 . I X="",$P(ROC0,"^",2)>3030930 Q
 . ; Issue Text
 . S TXT="" D
 .. F I=0:0 S I=$O(^QA(745.1,ROCIEN,4,I)) Q:'I  S TXT=$G(^(I,0)) Q:TXT]""
 .. Q
 . I TXT="" S EDITITXT=1
 . ; Resolution Text
 . S TXT="" D
 .. F I=0:0 S I=$O(^QA(745.1,ROCIEN,6,I)) Q:'I  S TXT=$G(^(I,0)) Q:TXT]""
 .. Q
 . I TXT="" S EDITRTXT=1
 . ;
 . ; Set status of ROC to Closed and update any missing required fields
 . ;   with their default values
 . K ^TMP("DIERR",$J)
 . K PATSFDA S PATSIENS=ROCIEN_","
 . S PATSFDA(745.1,PATSIENS,27)="C"
 . S PATSFDA(745.1,PATSIENS,26)=CURRDT
 . I EDITEBY S PATSFDA(745.1,PATSIENS,9)=ENTBY
 . I EDITIBY S PATSFDA(745.1,PATSIENS,8)=INFOBY
 . I EDITDIV S PATSFDA(745.1,PATSIENS,37)=STATION
 . D FILE^DIE("","PATSFDA")
 . K PATSFDA
 . I $D(^TMP("DIERR",$J)) D REOPEN Q
 . ; Update Issue Text if necessary.
 . I EDITITXT D WP^DIE(745.1,PATSIENS,22,"","TXT")
 . I $D(^TMP("DIERR",$J)) D REOPEN Q
 . ; Update Resolution Text if necessary.
 . I EDITRTXT D WP^DIE(745.1,PATSIENS,25,"","TXT")
 . I $D(^TMP("DIERR",$J)) D REOPEN Q
 . ; Build a list of ROCs that were auto-closed.
 . S ^XTMP("QACMIGR","AUTO","C",ROCNO_" ")=PATSCDT_"^"_EDITEBY_"^"_EDITIBY_"^"_EDITITXT_"^"_EDITRTXT_"^"_EDITDIV
 . ; Update the count of ROCs that were autoclosed
 . S PATSCNT=PATSCNT+1
 . Q
 W "Done."
 ; Update count of ROCs autoclosed, set flag to indicate process is done.
 S PATSCNT=$P(^XTMP("QACMIGR","AUTO","C"),"^")+PATSCNT D
 . I PATSCNT=0 K ^XTMP("QACMIGR","AUTO","C") Q
 . S ^XTMP("QACMIGR","AUTO","C")=PATSCNT_"^0" Q
 ; Print report of ROCs auto-closed.
 D ENRPT2^QACI1A
 Q
 ;
REOPEN ; Re-open ROC if an error occurred during FileMan update
 K PATSFDA,^TMP("DIERR",$J)
 S PATSFDA(745.1,PATSIENS,27)="O"
 D FILE^DIE("","PATSFDA")
 K PATSFDA Q
 ;
 ;
