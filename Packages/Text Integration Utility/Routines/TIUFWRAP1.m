TIUFWRAP1 ;SPFO/AJB - Clean File #8927 ;04/06/22  12:50
 ;;1.0;TEXT INTEGRATION UTILITIES;**338,254**;Jun 20, 1997;Build 9
 ;
 Q
 ;
BACKUP(BU,DISPLAY) ; saves a copy of #8927 to ^XTMP
 N PD S BU=1,DT=$G(DT,$$DT^XLFDT),PD=$$FMADD^XLFDT(DT,30) ; purge date=t+30
 I '$D(^XTMP("TIUFWRAP")) D  Q
 . W !!,"Saving a copy of the TIU TEMPLATE file..."
 . S ^XTMP("TIUFWRAP",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"File #8927 Backup"
 . M ^XTMP("TIUFWRAP",8927)=^TIU(8927)
 . W "done.",! D FMR^TIUFWRAP2("EA","Press <Enter> to continue.")
 S ^XTMP("TIUFWRAP",0)=PD_U_DT_U_"File #8927 Backup" ; update 0 node only
 Q:'DISPLAY
 W !!,"File #8927 backup already exists.  Updating purge date for saved data."
 W ! D FMR^TIUFWRAP2("EA","Press <Enter> to continue.")
 Q
 ;
RESTORE ; restores data from ^XTMP to #8927
 I '$D(^XTMP("TIUFWRAP")) D  Q
 . W !!,"Backup global NOT found!",!!,"Use the BACKUP option to save a copy of File #8927",!
 . D FMR^TIUFWRAP2("EA","Press <Enter> to continue.")
 W ! I '+$$FMR^TIUFWRAP2("YA","Are you sure you wish to restore TIU TEMPLATE from the backup? ","NO") Q
 W !!,"Restoring the TIU TEMPLATE file..." K ^TIU(8927),@OUTPUT M ^TIU(8927)=^XTMP("TIUFWRAP",8927) W "done.",!
 D FMR^TIUFWRAP2("EA","Press <Enter> to continue.")
 Q
 ;
GATHER(UPDATE,LOD) ; analyze File #8927 - main loop starts at root level
 N IEN,INDEX S UPDATE=+$G(UPDATE,0)
 S INDEX="" F  S INDEX=$O(^TIU(8927,"AROOT",INDEX),-1) Q:INDEX=""  S IEN=0 F  S IEN=$O(^TIU(8927,"AROOT",INDEX,IEN)) Q:'+IEN  D
 . D EE^TIUFWRAP(IEN,0,"",LOD) ; evaluate the entry ITEMS & BOILERPLATE TEXT
 Q
 ;
UPDATE(BU) ;
 I '$D(^XTMP("TIUFWRAP")) D  Q
 . W !!,"Backup global NOT found!",!!,"Use the BACKUP option to save a copy of File #8927",!
 . D FMR^TIUFWRAP2("EA","Press <Enter> to continue.")
 I +BU D  Q  ; backup present, update the file
 . N LOD S LOD=$$LOD^TIUFWRAP2(.LOD) Q:LOD=U!(LOD="Q")  ; set level of detail
 . K @OUTPUT W @IOF,"Updating File #8927..."
 . D GATHER^TIUFWRAP1(1,LOD) D:LOD>1 GATHER^TIUFWRAP1(1,1) ; if level of detail includes wrapping, do basic clean after (for wrapped fields/objects)
 . W "done." W ! I $$FMR^TIUFWRAP2("EA","Press <Enter> to continue.")
 Q
 ;
EMAIL ; mail the results
 N IEN,INDEX,XMDUN,XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ
 S INDEX="" F  S INDEX=$O(@OUTPUT@(INDEX)) Q:INDEX=""  D
 . S XMDUZ=.5,XMTEXT="XMTEXT(",XMY(+DUZ)=""
 . N SUB S (SUB,XMSUB)="File #8927 ["_INDEX_"]" ; subject
 . S IEN=0 F  S IEN=$O(@OUTPUT@(INDEX,IEN)) Q:'+IEN  D
 . . S XMTEXT(IEN)=@OUTPUT@(INDEX,IEN)
 . D ^XMD
 . W:$D(XMMG) !!,XMMG ; error message
 . W:'$D(XMMG) !!,"Message Subject: ",SUB
 . W:'$D(XMMG) !,"Message ID     : ",XMZ
 W ! D FMR^TIUFWRAP2("EA","Press <Enter> to continue.")
 Q
 ;
PREPOUT(DATA,OUTPUT,TYPE) ; prepare output
 N LOC S LOC=$NA(^TMP($J,"OUTPUT",TYPE))
 N TOTAL S TOTAL=0
 N IEN S IEN=0 F  S IEN=$O(@DATA@(IEN)) Q:'+IEN  D
 . N NODE0,POWNER S NODE0=$G(^TIU(8927,IEN,0))
 . S TOTAL=TOTAL+1,@LOC@(TOTAL)="IEN:  "_IEN
 . S POWNER=$P(NODE0,U,6) I +POWNER S POWNER=$$GET1^DIQ(200,POWNER,.01),POWNER=$S(POWNER="":"<unknown>",1:POWNER) ; imported entries may not have an entry in File #200
 . I POWNER'="" S TOTAL=TOTAL+1,@LOC@(TOTAL)="Personal Owner:  "_POWNER ; display personal owner
 . ; display the path
 . N LEN,PIE S LEN=$L(@DATA@(IEN,"PATH"),U) F PIE=1:1:LEN D
 . . N LN S LN=$$SETSTR^VALM1(" ","",(PIE-1)*4,1) ; pad spaces before data
 . . S LN=$S(PIE'=LEN:LN_"<",1:LN_" - ")
 . . S TOTAL=TOTAL+1,@LOC@(TOTAL)=LN_$P(@DATA@(IEN,"PATH"),U,PIE)_$S(PIE'=LEN:">",1:"") ; set the entry for display
 . . I PIE=LEN,$D(@DATA@(IEN,"NODE")) D  ; display the lines (if any) for each entry
 . . . N LEN,PIE S LEN=$L(@DATA@(IEN,"NODE"),U)
 . . . F PIE=1:1:LEN S @LOC@(TOTAL)=@LOC@(TOTAL)_$S(LEN=1:" ["_$P(@DATA@(IEN,"NODE"),U)_"]",PIE=1:" ["_$P(@DATA@(IEN,"NODE"),U,PIE)_",",PIE<LEN:$P(@DATA@(IEN,"NODE"),U,PIE)_",",1:$P(@DATA@(IEN,"NODE"),U,PIE)_"]")
 . K @DATA@(IEN) ; remove entries as we go
 . I +$O(@DATA@(IEN)) S TOTAL=TOTAL+1,@LOC@(TOTAL)="" ; blank line
 ;K DATA ; remove remaining data
 Q
 ;
PRINT ; print the results to a device
 N END,X S (END,X)="" F  S X=$O(@OUTPUT@(X)) Q:X=""  S @OUTPUT@(X,.1)=X,$P(@OUTPUT@(X,.2),"-",$L(X))="-"
 S X="" F  S X=$O(@OUTPUT@(X)) Q:X=""  S @OUTPUT@(X,($O(@OUTPUT@(X,""),-1)+1))="" ; add a blank line between each group
 N ZTSAVE S ZTSAVE("OUTPUT")="" W !,IOCUON
 D EN^XUTMDEVQ("PRINT^TIUFWRAP2(OUTPUT)","File #8927 Analysis",.ZTSAVE)
 W ! I END'=U,$$FMR^TIUFWRAP2("EA","Press <Enter> to continue ")
 Q
 ;
VIEW ; view the results
 N DISPLAY,DY W $G(IOCUON)
 S X="" F  S X=$O(@OUTPUT@(X)) Q:X=""  S DISPLAY(X)=$NA(@OUTPUT@(X))
 K DIERR D DOCLIST^DDBR("DISPLAY","NR")
 Q
 ;
