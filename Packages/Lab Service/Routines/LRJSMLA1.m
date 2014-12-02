LRJSMLA1 ;ALB/PO,GTS Lab Hospital Location Update Notification ;02/19/2010 12:01:53
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
 ; IAs : 10040, 10039, 1380 & 5611
 ;
SRTCHG(LRFR,LRTO,REVNODE) ;  sort and reverse the relation room-bed to hospital location
 ; Input:
 ;   LRFR - start time to report the raw data
 ;   LRTO - end time to report the raw data.
 ; Output:   
 ;   @REVNODE@- array in the following format.
 ;
 ;@REVNODE@("N",HLIEN,LRDT,WLIEN,LRIEN,LRFLNUM,LRD0)=@NODE
 ;where :
 ;  HLIEN = hospital location ien
 ;  LRDT  = date/time recorded
 ;  WLIEN = Ward Location
 ;  LRIEN = Room-bed ien or {Room-bed ien, ward(s).  sub-file} 
 ;  LRFLNUM = field number 
 ;  LRD0    = ien of the audit file
 ;    @REVNODE@("N",hospital location ien, date time recorded, Ward Location ien, room-bed ien and ward(s) sub-file,  field number, audit file ien)
 ;    = new internal value ^ old internal value ^ new value ^ old value ^ user ^ data time recorded ^ entry name from audit file
 ;
 ;@REVNODE@("N",HLIEN,LRDT, 0,     0,     LRFLNUM, LRD0)=@NODE  for info extracted from Hospital Location
 ;@REVNODE@("N",HLIEN,LRDT, WLIEN, 0,     LRFLNUM, LRD0)=@NODE  for info extracted from Ward Location
 ;@REVNODE@("N",HLIEN,LRDT, WLIEN, LRIEN, LRFLNUM, LRD0)=@NODE  for info extracted room-bed info
 ;
 NEW OUTNODE,NOFFSET,NODE,FILENUM,LRIEN,LRDT,LRFLNUM,LRD0,HLIEN,RMD0,RMD1,WLIEN,HLIEN,DTR
 NEW LRCHAR,LRCNT,LRPROC
 KILL @REVNODE
 ;
 SET (LRCNT,LRCHAR)=0
 SET OUTNODE=$NAME(@REVNODE@("OUTARR"))
 FOR NOFFSET=1:1 Q:$QS(OUTNODE,NOFFSET)="OUTARR"
 SET NODE=OUTNODE
 ;
 ; get the audit data for files 42,44 and 405.4
 DO EXTRACT(42,LRFR,$$NOW^XLFDT(),NODE)
 DO EXTRACT(44,LRFR,$$NOW^XLFDT(),NODE)
 DO EXTRACT(405.4,LRFR,LRTO,NODE)
 ;
 FOR  SET NODE=$Q(@NODE) QUIT:NODE=""  Q:$QS(NODE,NOFFSET)'="OUTARR"  DO
 . SET LRCNT=LRCNT+1
 . IF LRCNT#150=0 DO
 . . D HANGCHAR^LRJSMLU(.LRCHAR)
 . . S LRCNT=0
 .;
 .;NOTE: 1st subscript of NODE must be $J for this to work
 . SET LRPROC=$QS(NODE,1)
 . I LRPROC=$J DO
 . . SET FILENUM=$QS(NODE,NOFFSET+1)
 . . SET LRIEN=$QS(NODE,NOFFSET+2)
 . . SET LRDT=$QS(NODE,NOFFSET+3)
 . . SET LRFLNUM=$QS(NODE,NOFFSET+4)
 . . SET LRD0=$QS(NODE,NOFFSET+5)
 . . ;
 . . IF FILENUM="44" D
 . . . SET HLIEN=LRIEN
 . . . SET @REVNODE@("N",HLIEN,LRDT,0,0,LRFLNUM,LRD0)=@NODE
 . . ;
 . . IF FILENUM="42" DO
 . . . SET HLIEN=$$WLTOHL(LRIEN)        ;Hospital Location ien
 . . . SET @REVNODE@("N",HLIEN,LRDT,LRIEN,0,LRFLNUM,LRD0)=@NODE
 . . ;
 . . IF FILENUM="405.4" D
 . . . SET RMD0=+LRIEN
 . . . ; if room's name changed or new room created or deleted
 . . . IF LRFLNUM=".01" D
 . . . . SET RMD1=0
 . . . . FOR  SET RMD1=$O(^DG(405.4,RMD0,"W",RMD1)) Q:'RMD1  D
 . . . . . SET WLIEN=+$P($G(^DG(405.4,RMD0,"W",RMD1,0)),"^",1)
 . . . . . SET HLIEN=$$WLTOHL(WLIEN)        ;Hospital Location ien
 . . . . . SET @REVNODE@("N",HLIEN,LRDT,WLIEN,LRIEN,LRFLNUM,LRD0)=@NODE
 . . . ;
 . . . IF LRFLNUM="100,.01" DO       ; if the field number is 100,.01  
 . . . . SET WLIEN=$P(LRIEN,",",2)   ; Ward Location ien
 . . . . SET HLIEN=$$WLTOHL(WLIEN)   ; Hospital Location ien
 . . . . SET @REVNODE@("N",HLIEN,LRDT,WLIEN,LRIEN,LRFLNUM,LRD0)=@NODE
 KILL @OUTNODE
 ;
 ;*Remove any HL activity that has nothing to report for entered date range
 SET HLIEN=0
 FOR  SET HLIEN=$O(@REVNODE@("N",HLIEN)) Q:'HLIEN  DO
 .S DTR=""
 .FOR  SET DTR=$O(@REVNODE@("N",HLIEN,DTR)) Q:'DTR  Q:DTR<LRTO  DO
 ..K:DTR>LRTO @REVNODE@("N",HLIEN,DTR)
 ;
 QUIT
 ;
EXTRACT(FILENUM,LRFR,LRTO,LRAUD) ; extract data from audit file for given file and date/time interval
 ; Input:
 ;   FILENUM - file number for which to get audit data 
 ;   LRFR - start time for which to get the audit data
 ;   LRTO - end time for which to get the audit data
 ; Output:   
 ;   @LRAUD@ - array in the following format.
 ; 
 ; @LRAUD@(FILENUM,LRIEN,LRDT,LRFLNUM,LRD0)=LRNEWIEN_"^"_LROLDIEN_"^"_LRNEW_"^"_LROLD_"^"_LRUSER_"^"_LRDT_"^"_LRENTNM
 ; @LRAUD@(file num, record ien, date time recorded, field number, audit file ien)=
 ;    = new internal value ^ old internal value ^ new value ^ old value ^ user ^ data time recorded ^ entry name from audit file
 ;    
 NEW LRDATA,LRD0,LRDT,LRFLDNM,LRFLNUM,LRIEN,LRNEW,LRNEWIEN,LROLD,LROLDIEN,LRUSER,LRENTNM,LRCHAR
 SET LRCHAR=0
 SET LRAUD=$G(LRAUD)
 SET LRDATA=$NAME(@LRAUD@("LRDATA"))
 KILL @LRDATA
 ; extract the audit data for given file number for given time interval.
 DO GAUDATA(FILENUM,LRFR,LRTO,.LRDATA)
 ;
 SET LRD0=0
 FOR  SET LRD0=$O(@LRDATA@(LRD0)) QUIT:'LRD0  DO
 . ; quit if  audited field is not to be monitored 
 . QUIT:'((";"_$$GMONLST(FILENUM,2)_";")[(";"_@LRDATA@(LRD0,.03)_";"))
 . SET LRDT=@LRDATA@(LRD0,".02")      ;date/time recorded
 . QUIT:(LRDT<LRFR)!(LRDT>LRTO)       ;make sure date time recorded is within range
 . SET LRENTNM=@LRDATA@(LRD0,1)       ;entry name from audit File
 . SET LRFLDNM=@LRDATA@(LRD0,1.1)     ;field name
 . SET LRFLNUM=@LRDATA@(LRD0,.03)     ;field number
 . SET LRIEN=@LRDATA@(LRD0,.01)       ;file entry ien
 . SET LRNEW=@LRDATA@(LRD0,3)         ;new value
 . SET LRNEWIEN=@LRDATA@(LRD0,3.1)    ;new internal value
 . SET LROLD=@LRDATA@(LRD0,2)         ;old value
 . SET LROLDIEN=@LRDATA@(LRD0,2.1)    ;old internal value
 . SET LRUSER=@LRDATA@(LRD0,.04)      ;user name
 . SET @LRAUD@(FILENUM,LRIEN,LRDT,LRFLNUM,LRD0)=LRNEWIEN_"^"_LROLDIEN_"^"_LRNEW_"^"_LROLD_"^"_LRUSER_"^"_LRDT_"^"_LRENTNM
 KILL @LRDATA
 QUIT
 ;
GAUDATA(FILENUM,LRFR,LRTO,LRDATA) ; -- Get audited data change for the given file changes
 ; Input:
 ;   FILENUM - file number for which to get audit data 
 ;   LRFR - start time for which to get the audit data  ( SEE NOTE)
 ;   LRTO - end time for which to get the audit data     (SEE NOTE
 ; Output:   
 ;   @LRDATA@ - array containing data to get from audit file
 ;   
 ; NOTE: print template seems that returns all the data and 
 ;        does not screen against given date range (FR and TO)
 ; 
 ; set up parameters to run the print template to a null device and store the
 ;  results in @LRDATA array
 ; in case there is no null defined, print template with IOP of ";;99999" still
 ;  will store the results in LRDATA 
 ; 
 NEW DIC,BY,FLDS,LRDEV,FR,TO,DIA,D0,DISYS,DILOCKTM,X1,IOP
 NEW LRDT,LRFLDNM,LRFLNUM,LRIEN,LRNEW,LROLD,LRUSER,LRX
 DO:'$D(U) DT^DICRW
 SET DIC="^DIA("_FILENUM_","
 SET BY="DATE/TIME RECORDED"
 SET FR=LRFR
 SET TO=LRTO
 SET FLDS="[LRJ SYS GET INDIRECT AUDIT]"  ; make sure LRDATA is set to array or temp global name before the print template gets called.
 ;
 FOR LRDEV="NULL DEVICE","NULL" SET IOP=$$GIOP(LRDEV) QUIT:IOP'=""
 IF IOP="" SET IOP=";;99999"   ; if no IOP then set the number of lines per page to maximum
 DO EN1^DIP
 QUIT
 ;
GIOP(DEVICE) ; -- return the device if exists and it is not FORCED to queue, otherwise return ""
 ;Input
 ;  DEVICE - Device to lookup
 ;
 ;Output
 ;  DEVICE - Device Characteristics
 ;             or
 ;           "" : Device doesn't exist
 ;           
 ;
 NEW IOP,%ZIS,POP,IO
 SET IOP=DEVICE
 SET %ZIS="NQ"     ; ^%ZIS call does not open the device & allows QUEUING. Replaces: %ZIS="N"
 DO ^%ZIS         ; retrun the characteristics of the device.
 IF POP=1  DO     ; does the device exist? 
 .SET DEVICE=""
 ELSE  DO
 . ; is queuing forced for this device? {%ZIS["Q" & QUEUING field = FORCED; returns IO("Q")=1}
 . IF $D(IO("Q"))=1 SET DEVICE=""  ;;Replaces: IF $P(^%ZIS(1,IOS,0),"^",12)=1 SET DEVICE=""
 ;
 DO ^%ZISC        ; restore the device variables 
 QUIT DEVICE
 ;
WLTOHL(WLIEN) ; -- get associated hospital location from ward location
 ;IA #10039 allows reference to ^DIC(42
 Q +$G(^DIC(42,WLIEN,44))
 ;
HLTOWL(HLIEN) ; get associated ward location from hospital location
 ;IA #10040 allows reference to ^SC(
 Q +$G(^SC(HLIEN,42))
 ;
KEEPBED(RMBDIEN,BEDNODE) ;* Check for existence of Room-Bed when Ward is reactivated
 ;
 ;Input:
 ;      RMBDIEN - IEN of Room-Bed record to check
 ;      BEDNODE - Reverse Location Array for report [$NAME(@OUT@("REVARR","N",HLIEN)) from LRJSMLA]
 ;
 ;Output:
 ;      RMBDXST :
 ;              0 - Room-Bed did not exist when reactivated
 ;              1 - Room-Bed existed when reactivated 
 ;
 NEW RMBDXST,LRDT,WLIEN,LRIEN,LRCHAR
 SET LRDT=""
 SET RMBDXST=0
 SET LRCHAR=0
 FOR  SET LRDT=$O(@BEDNODE@(LRDT)) QUIT:LRDT=""  QUIT:RMBDXST=1  DO
 .D HANGCHAR^LRJSMLU(.LRCHAR)
 .SET WLIEN=""
 .FOR  SET WLIEN=$O(@BEDNODE@(LRDT,WLIEN)) QUIT:WLIEN=""  QUIT:RMBDXST=1  DO
 ..SET LRIEN=""
 ..FOR  SET LRIEN=$O(@BEDNODE@(LRDT,WLIEN,LRIEN)) QUIT:LRIEN=""  QUIT:RMBDXST=1  DO
 ...SET:LRIEN[$P(RMBDIEN,",") RMBDXST=1
 QUIT RMBDXST
 ;
CLNUP(NODE) ;* Check for date of RM-BD change against when it was added to Location
 ;
 ;Input:
 ;      NODE  - Value of previous node [@OUT@(HLSORT,HLIEN,0,"PREVIOUS")]
 ;      
 ;Output:
 ;      NODE  - Room/Bed nodes with edits prior to addition of new Ward Location removed
 ;
 NEW LRDT,WLIEN,RMBDIEN,LRFLDNM,RMBDARY,LRCHAR
 ;
 SET LRDT=""
 SET LRCHAR=0
 FOR  SET LRDT=$O(NODE(LRDT)) QUIT:LRDT=""  DO
 .D HANGCHAR^LRJSMLU(.LRCHAR)
 .SET WLIEN=""
 .FOR  SET WLIEN=$O(NODE(LRDT,WLIEN)) QUIT:WLIEN=""  DO
 ..SET RMBDIEN=""
 ..FOR  SET RMBDIEN=$O(NODE(LRDT,WLIEN,RMBDIEN)) QUIT:RMBDIEN=""  DO
 ...SET LRFLDNM=""
 ...FOR  SET LRFLDNM=$O(NODE(LRDT,WLIEN,RMBDIEN,LRFLDNM)) QUIT:LRFLDNM=""  DO
 ....IF LRFLDNM[".01",$P(LRFLDNM,".",2)="01" DO
 .....SET:(LRFLDNM'["100") $P(RMBDARY(WLIEN,$P(RMBDIEN,","),LRFLDNM),"^")=LRDT ;Dt/Tm edited Rm-Bd name
 .....SET:(LRFLDNM'["100") $P(RMBDARY(WLIEN,$P(RMBDIEN,","),LRFLDNM),"^",3)=$O(NODE(LRDT,WLIEN,RMBDIEN,LRFLDNM,"")) ;IEN of Edited Rm-Bd
 .....SET:(LRFLDNM["100") $P(RMBDARY(WLIEN,$P(RMBDIEN,","),$P(LRFLDNM,",",2)),"^",2)=LRDT ;Dt/Tm added Rm-Bd to Ward-Loc
 ;
 ;Check RMBDARY for Room-Beds that were edited before adding to Ward-Location
 ; If found, remove changes prior to addition to Ward-Location
 ; 
 ; RMBDARY()=
 ;   Date/Time RM-BD edited ^ Date/Time RM-BD added to Ward-Loc ^ Last Subscript of RM-BD Edit NODE
 SET WLIEN=""
 FOR  SET WLIEN=$O(RMBDARY(WLIEN)) QUIT:WLIEN=""  DO
 .SET RMBDIEN=""
 .FOR  SET RMBDIEN=$O(RMBDARY(WLIEN,RMBDIEN)) QUIT:RMBDIEN=""  DO
 ..SET LRFLDNM=""
 ..FOR  SET LRFLDNM=$O(RMBDARY(WLIEN,RMBDIEN,LRFLDNM)) QUIT:LRFLDNM=""  DO
 ...IF $P(RMBDARY(WLIEN,RMBDIEN,LRFLDNM),"^")<$P(RMBDARY(WLIEN,RMBDIEN,LRFLDNM),"^",2) DO
 ....;  If PREVIOUS defines change but must report no change when the Rm-Bed is added during the
 ....;   date range, then KILL NODE if 2nd piece of NODE data is not Null
 ....KILL:(+$P(RMBDARY(WLIEN,RMBDIEN,LRFLDNM),"^")>0) NODE($P(RMBDARY(WLIEN,RMBDIEN,LRFLDNM),"^",1),WLIEN,RMBDIEN,LRFLDNM,$P(RMBDARY(WLIEN,RMBDIEN,LRFLDNM),"^",3))
 QUIT
 ;
 ;--------------------------------------------------------------------------
GRPTLST(FILENUM,PIECE) ; -- get the list of fields to be reported for given file Num
 QUIT $$GFLDS(FILENUM,"RPTLST",PIECE)
 ;
GMONLST(FILENUM,PIECE)  ; -- get the list of audited fields for given file number
 QUIT $$GFLDS(FILENUM,"MONLST",PIECE)
 ;
RPTLST ; -- list of files and fields to be reported
 ;;44^.01;2;3;3.5;2505;2506^44,.01;44,2;44,3;44,3.5;44,2505;44,2506
 ;;42^.01;.015;44^42,.01;42,.015;42,44
 ;;405.4^**^405.4,.01;405.41,.01
 ; End of List - do not change or remove this comment
 ; 
MONLST ; -- list of audited file numbers and fields to be monitored 
 ;;44^.01;2;3;3.5;2505;2506
 ;;42^.01;.015;44
 ;;405.4^.01;100,.01
 ; End of List - do not change or remove this comment
 ;
GFLDS(FILENUM,TAGRTN,PIECE) ; search in the given tag for FileNum and get list of fields
 NEW TAG,RTN,I,LIST,FLDS
 SET TAG=$P(TAGRTN,"^",1)
 SET RTN=$P(TAGRTN,"^",2)
 SET:'$D(PIECE) PIECE=2
 SET:RTN="" RTN=$T(+0)
 SET LIST="",FLDS=""
 FOR I=1:1 DO  QUIT:LIST=""
 .SET LIST=$P($TEXT(@TAG+I^@RTN),";;",2)
 .IF FILENUM=+LIST SET FLDS=$P(LIST,"^",PIECE),LIST=""
 QUIT FLDS
 ;
 ;----------------------------
 ;
AUDSET ; -- enable audit some fields for Hospital Location, Ward Location and Room-Bed  
 ; This API not executed by Lab system.
 ;   PURPOSE: Execute from programmer mode, IF Fileman Auditing required for HLCMS accidentally turned off.
 ;
 NEW LRI,LRAFLDS
 FOR LRI=1:1 SET LRAFLDS=$P($TEXT(AFLDS+LRI),";;",2) QUIT:LRAFLDS=""  DO
 . DO TURNON^DIAUTL(+LRAFLDS,$P(LRAFLDS,"^",2))  ;IA #5611 allows audit in HL files
 . W !,"Turning on audit for file/Subfile ",+LRAFLDS,?44,"for fields ",$P(LRAFLDS,"^",2)
 QUIT
 ;
AFLDS ; --- file^fields for which to turn on the audit
 ;;44^.01;2;3;3.5;2505;2506
 ;;42^.01;.015;44
 ;;405.4^.01
 ;;405.41^.01
 ; End of List - do not change or remove this comment
 ;
 ;----------------------------
