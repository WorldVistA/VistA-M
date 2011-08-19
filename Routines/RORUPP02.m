RORUPP02 ;HCIOFO/SG - PATIENT EVENTS (EVENTS)  ; 1/20/06 1:55pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** ADDS THE EVENT REFERENCE
 ;
 ; PATIEN        Patient IEN
 ;
 ; AREA          Data area of the event (see the DATA AREA field
 ;               of the file #798.3 for details)
 ;
 ; [DATE]        Date/Time associated with the event (the current
 ;               date/time is used by default).
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
ADD(PATIEN,AREA,DATE) ;
 N IEN,IENS,RORFDA,RORIEN,RORMSG
 S:$G(DATE)'>0 DATE=$$NOW^XLFDT
 ;--- Do not record more than one reference per associated date.
 ;    Maybe in the future all references will be recorded but we
 ;    need only daily precision at the moment. If the reference
 ;    exists already, update it with the earlier associated date
 ;--- and the latter timestamp if necessary.
 S IEN=$O(^RORDATA(798.3,+PATIEN,2,"AD",AREA,DATE\1,""))
 I IEN  K DIERR  D  Q $S('$G(DIERR):0,1:-9)
 . N BUF,NOW
 . S IENS=IEN_","_(+PATIEN)_",",NOW=$$NOW^XLFDT
 . S BUF=$G(^RORDATA(798.3,+PATIEN,2,IEN,0))
 . S:NOW>$P(BUF,"^") RORFDA(798.32,IENS,.01)=NOW
 . S:DATE<$P(BUF,"^",3) RORFDA(798.32,IENS,2)=DATE
 . D:$D(RORFDA)>1 FILE^DIE(,"RORFDA","RORMSG")
 ;--- Create the new event reference
 S (RORFDA(798.3,"?+1,",.01),RORIEN(1))=+PATIEN
 S IENS="+2,?+1,"
 S RORFDA(798.32,IENS,.01)=$$NOW^XLFDT
 S RORFDA(798.32,IENS,1)=AREA
 S RORFDA(798.32,IENS,2)=DATE
 D UPDATE^DIE(,"RORFDA","RORIEN","RORMSG")
 Q $S('$G(DIERR):0,1:-9)
 ;
 ;***** CHECKS THE EVENTS
 ;
 ; PATIEN        Patient IEN
 ;
 ; AREA          Data area of the event (see the DATA AREA field
 ;               of the file #798.3 for details)
 ;
 ; .SDT          Reference to a local variable containing the start
 ;               date. The date can be modified by the function and
 ;               returned via this parameter.
 ;
 ; .EDT          Reference to a local variable containing the end
 ;               date. The date can be modified by the function and
 ;               returned via this parameter.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  No events (skip)
 ;        1  Events have been found (proceed)
 ;        2  The same as 1 + dates (SDT & EDT) have been modified
 ;
GET(PATIEN,AREA,SDT,EDT) ;
 N ED,FDTC,FEVT,IEN,NEWEDT,NEWSDT,ROOT,TMP
 S ROOT=$NA(^RORDATA(798.3,+PATIEN,2))
 S NEWSDT=999999999,NEWEDT=0,(FDTC,FEVT)=0
 ;--- If the data search time frame is too wide and some of the
 ;    event references have been purged already then the time
 ;    frame cannot be shrinked according to the references and the
 ;--- patient cannot be skipped if there are no references at all.
 S:SDT<$G(RORUPD("EETS")) NEWSDT=SDT,NEWEDT=EDT,FEVT=1
 ;--- Browse through the event references
 S ED=$O(@ROOT@("AT",AREA,SDT),-1)
 F  S ED=$O(@ROOT@("AT",AREA,ED))  Q:(ED="")!(ED'<EDT)  D
 . S IEN=""
 . F  S IEN=$O(@ROOT@("AT",AREA,ED,IEN))  Q:IEN=""  D
 . . S TMP=$P($G(@ROOT@(IEN,0)),"^",3),FEVT=1
 . . Q:TMP'>0
 . . S:TMP<NEWSDT NEWSDT=TMP,FDTC=1
 . . S:TMP>NEWEDT NEWEDT=TMP,FDTC=1
 Q:'FEVT 0
 I FDTC  S SDT=NEWSDT,EDT=NEWEDT  Q 2
 Q 1
 ;
 ;***** PURGES THE OLD EVENT REFERENCES
 ;
 ; DATE          Keep the references starting from this date
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
PURGE(DATE) ;
 N CNT,DA,DIK,IEN,IEN1,IENS,RC,REINDEX,ROOT,RORFDA,RORMSG
 S ROOT=$$ROOT^DILFD(798.3,,1)
 S DATE=DATE\1,(CNT,RC)=0
 F  S DATE=$O(@ROOT@("AT",DATE),-1)  Q:DATE=""  D  Q:RC<0
 . S IEN=""
 . F  S IEN=$O(@ROOT@("AT",DATE,IEN))  Q:IEN=""  D  Q:RC<0
 . . S IEN1="",REINDEX=0
 . . F  S IEN1=$O(@ROOT@("AT",DATE,IEN,IEN1))  Q:IEN1=""  D  Q:RC<0
 . . . ;---Check if the corresponding record exists
 . . . I '$D(@ROOT@(IEN,2,IEN1,0))  D  Q
 . . . . ;--- Delete the "stray" entry from the cross-reference
 . . . . K @ROOT@("AT",DATE,IEN,IEN1)
 . . . ;--- Delete the record
 . . . S IENS=IEN1_","_IEN_","
 . . . S RORFDA(798.32,IENS,.01)="@"
 . . . D FILE^DIE(,"RORFDA","RORMSG")
 . . . I $G(DIERR)  D  Q
 . . . . S RC=$$DBS^RORERR("RORMSG",-9,,,798.32,IENS)
 . . . S CNT=CNT+1
 . . ;--- Re-index the main record if necessary
 . . I REINDEX  K DA  S DIK=$$OREF^DILF(ROOT),DA=IEN  D IX^DIK
 D:CNT>0 LOG^RORLOG(2,CNT_" events were purged from the file #798.3")
 Q $S(RC<0:RC,1:0)
