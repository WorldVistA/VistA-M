LRJSMLA ;ALB/PO,GTS Lab Hospital Location Update Notification ;02/24/2010 11:45:51
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
 ;
 ;IA #1380 allows references to ^DG(405.4
 ;
BLDREC(LRFR,LRTO,LRES,LRTYPE) ; -- output the HLCMS updates
 ; Input:
 ;   LRFR - start time to report the raw data for.
 ;   LRTO - end to report the raw data.
 ;   LRES - Root for array that defines result data
 ;   LRTYPE - report type 
 ;         1: do not report records that that have changed 
 ;              but returned back to its original values (Default)
 ;         2: report all reocrds
 ; Output:   
 ;   @OUT@(seguence number) - array containing the results
 ;   
 NEW NODE,OUT,I,NOFFSET,KEEPHL,KEEPRM,KEEPBED,LRTMP,LAST,CURDATA,PREVDATA,TOTALRM,TOTALBED,LRCHAR
 SET LRTYPE=$G(LRTYPE,1)   ; if LRTYPE not defined, default type 1
 SET OUT=$NAME(@LRES@("OUT"))
 SET LRCHAR=0
 DO IOXY^XGF(IOSL-1,52)
 WRITE "[Extract HL Changes..."
 DO BLDRAW(LRFR,LRTO,OUT)
 ;
 FOR NOFFSET=1:1 QUIT:$QS(OUT,NOFFSET)="OUT"
 SET LRTMP=$NAME(@LRES@("TMP"))
 SET NODE=$NAME(@OUT@("SORT1RAW"))
 FOR I=1:1 SET NODE=$Q(@NODE) QUIT:$E(NODE,1,$L(OUT)-1)'=$E(OUT,1,$L(OUT)-1)  DO
 . D HANGCHAR^LRJSMLU(.LRCHAR)
 . SET:LRTYPE=1 @LRTMP@(I)=@NODE
 . SET:LRTYPE=2 @LRES@(I)=@NODE
 KILL @OUT
 QUIT:LRTYPE=2
 ; Continue for report type 1 starting from last node and remove BED, ROOM or LOCATION 
 ; to remove records that are not changed (actually ones that have changed and returned back 
 ; to original values)
 SET LAST=$O(@LRTMP@(""),-1)
 SET TOTALRM=0
 SET TOTALBED=0
 SET I=LAST+2
 FOR  SET I=I-2 QUIT:I<2  DO   ;I=LAST:-1:1 DO
 . D HANGCHAR^LRJSMLU(.LRCHAR)
 . SET PREVDATA=$G(@LRTMP@(I))
 . IF (PREVDATA="")!($P(PREVDATA,"^",1)="NEW") SET I=0  QUIT   ; got to NEW records, don't care any more
 . SET CURDATA=$G(@LRTMP@(I-1))
 . IF $P(PREVDATA,"^",1)="PREVIOUS" DO
 . . ;
 . . IF $P(PREVDATA,"^",2)="BED" DO
 . . . IF $P(PREVDATA,"^",8,9)=$P(CURDATA,"^",8,9) DO
 . . . . KILL @LRTMP@(I),@LRTMP@(I-1)
 . . . ELSE  SET TOTALBED=TOTALBED+1
 . . ;
 . . ELSE  IF $P(PREVDATA,"^",2)="ROOM" DO
 . . . IF TOTALBED=0 DO
 . . . . KILL @LRTMP@(I),@LRTMP@(I-1)
 . . . ELSE  SET TOTALRM=TOTALRM+1
 . . . SET TOTALBED=0      ; initialize the total number of beds for next room encounter
 . . ELSE  IF $P(PREVDATA,"^",2)="LOCATION" DO
 . . . IF TOTALRM=0,$P(PREVDATA,"^",4,9)="^^^^^" DO
 . . . . KILL @LRTMP@(I),@LRTMP@(I-1)
 . . . ELSE  SET (TOTALRM,TOTALBED)=0
 ;
 SET NODE=LRTMP
 FOR I=1:1 SET NODE=$Q(@NODE) QUIT:$E(NODE,1,$L(LRTMP)-1)'=$E(LRTMP,1,$L(LRTMP)-1)  SET @LRES@(I)=@NODE
 IF '$D(@LRES@(1)) SET @LRES@(1)="   NO CHANGES FOUND!!"
 KILL @LRTMP
 ;
 QUIT
 ;
BLDRAW(LRFR,LRTO,OUT) ; -- build raw data for given time interval into @OUT array
 ; Input:
 ;   LRFR - start date/time for raw data report
 ;   LRTO - end date/time for raw data report
 ;   OUT  - Name of array holding raw data
 ; Output:   
 ;   @OUT@ - array in the following format.
 ;   @OUT@(sort order, HL ien, 0, "CURRENT" or "PREVIOUS" or "NEW") = CURRENT or PREVIOUS  or NEW HL field values  
 ;   @OUT@(sort order, HL ien,"AAAROOM", room value,-.235681, "CURRENT" or "PREVIOUS" or "NEW")=CURRENT or PREVIOUS  or NEW room field values  
 ;   @OUT@(sort order, HL ien,"AAAROOM", room value, bed value, "CURRENT" or "PREVIOUS" or "NEW")=CURRENT or PREVIOUS  or NEW bed  field values  
 ; e.g.       
 ;        
 ;   @OUT@("SORT2RAW",432,0,"CURRENT")="CURRENT^LOCATION^432^ZZW 100Ar^WARD^ALABAMA^TROY^^^OSTOVARI,PARVIZ^3081208.165853"
 ;   @OUT@("SORT2RAW",432,0,"PREVIOUS")="PREVIOUS^LOCATION^432^ZZW 100A^^ALBANY AREA^DEVVLD^^"
 ;   @OUT@("SORT2RAW",432,"AAAROOM",1001,-.235681,"CURRENT")="CURRENT^ROOM^432^ZZW 100Ar^WARD^ALABAMA^TROY^^"
 ;   @OUT@("SORT2RAW",432,"AAAROOM",1001,-.235681,"PREVIOUS")="PREVIOUS^ROOM^432^ZZW 100A^^ALBANY AREA^DEVVLD^1001^"
 ;   @OUT@("SORT2RAW",432,"AAAROOM",1001,"AB","ACUR")="CURRENT^BED^432^ZZW 100Ar^WARD^ALABAMA^TROY^1001^"
 ;   @OUT@("SORT2RAW",432,"AAAROOM",1001,"AB","APREV")="PREVIOUS^BED^432^ZZW100A^^ALBANY AREA^DEVVLD^1001^AB"
 ;
 NEW CUR,PREV,MOD,REVNODE,HLIEN,NFLDNUM,RBIEN,NEWIENV,OLDIENV,NEWVAL,OLDVAL,USER,DTR,ENTNM,RBIEN,RMBD,RMBDUNQ,NODE,NARR,CURMBD,FLDNUM,HLSORT
 NEW NEWCUR,OLDBDNM,OLDRMNM,PREVIOUS,ROOMNAME,FLAG,BEDNAME,RMBDLIST,WLIEN,RMBDIEN
 NEW CURTYPE,PREVTYPE,IGNORE,ACTDT,INACTDT,LRCHAR
 SET LRCHAR=0
 ;
 SET REVNODE=$NAME(@OUT@("REVARR"))
 KILL @OUT,@REVNODE
 ;
 ;
 ; sort audit records; reverse HL and room-bed changes.
 DO SRTCHG^LRJSMLA1(LRFR,LRTO,REVNODE)
 ;
 ; for each HL ien, check to see if the entry is new or modified.
 SET HLIEN=0
 FOR  SET HLIEN=$O(@REVNODE@("N",HLIEN)) Q:'HLIEN  I $D(^SC(HLIEN)) DO
 . D HANGCHAR^LRJSMLU(.LRCHAR)
 . KILL ARR,MOD,NARR,CUR,PREV,RMBD,RMBDUNQ
 . SET (ACTDT,INACTDT)=""
 . ; get the current values for this HL
 . DO GHL(HLIEN,.CUR) ;Returns current Hosp Loc fields from file 44
 . ;
 . ; get the changes for this HL into NARR
 . MERGE NARR=@REVNODE@("N",HLIEN)
 . ;
 . ;CUR - current values of HL fields
 . DO ROLLUP(HLIEN,.CUR,.NARR,LRTO)  ;Roll back current HL values from current time to "TO" time
 . DO CLNUP^LRJSMLA1(.NARR) ;*Remove Room-Bed edits made before RM-BD added to Ward-Location
 . ;
 . SET CUR("HL","FLAG")="CURRENT"    ; HL record flag
 . SET CUR("HL","NAME")="LOCATION"   ; HL record type
 . ;
 . ; find out which node is new and which one is current.
 . SET NODE="NARR"
 . FOR  SET NODE=$Q(@NODE) QUIT:NODE=""  DO
 . . SET DTR=$P(@NODE,"^",6)     ; Date/Time Recorded
 . . QUIT:DTR>LRTO               ; quit if Date/time recorded is in future.
 . . SET NFLDNUM=$QS(NODE,4)     ; field number   
 . . SET RBIEN=$QS(NODE,3)       ; room-bed ien
 . . SET NEWIENV=$P(@NODE,"^",1) ; New IEN value
 . . SET OLDIENV=$P(@NODE,"^",2) ; Old IEN value
 . . SET NEWVAL=$P(@NODE,"^",3)  ; New value
 . . SET OLDVAL=$P(@NODE,"^",4)  ; Old value
 . . SET:DTR'="" CUR("HL","DTR")=DTR    ; date/time recorded. Last date/time changed for any fields. 
 . . SET USER=$P(@NODE,"^",5)    ; Accessed by (USER)
 . . SET:USER'="" CUR("HL","USER")=USER  ; accessed by (USER). Last user who changed any field.
 . . SET ENTNM=$P(@NODE,"^",7)   ; Entry Name From Audit File
 . . ;
 . . ; if change is to HL or Ward Loaction (room-bed ien is 0)
 . . IF RBIEN=0 DO
 . . . ;if HL change is to .01 field with no previous value
 . . . IF NFLDNUM=.01 DO
 . . . . IF OLDVAL="<no previous value>" DO
 . . . . . SET CUR("HL","FLAG")="NEW" ; HL record flag
 . . . ;
 . . . ; if current flag  not new, keep track and store the old value data in MOD array
 . . . IF $G(CUR("HL","FLAG"))'="NEW" DO
 . . . . ; store the old value only for the oldest changes for the given field
 . . . . IF '$D(MOD("HL",NFLDNUM)) DO 
 . . . . . SET MOD("HL",NFLDNUM)=OLDVAL  ; Old value
 . . . ;
 . . . ;  if type is modified
 . . . IF NFLDNUM="2" DO
 . . . . ; if type changed from other to  clinic/ward/operating room
 . . . . IF OLDVAL'="<no previous value>","CLINIC^WARD^OPERATING ROOM"'[OLDVAL,"CLINIC^WARD^OPERATING ROOM"[NEWVAL SET ACTDT=DTR
 . . . . ;
 . . . . ; if type changed from clinic/ward/operating room to other.
 . . . . IF "CLINIC^WARD^OPERATING ROOM"[OLDVAL,"CLINIC^WARD^OPERATING ROOM"'[NEWVAL SET INACTDT=DTR
 . . ;
 . . ; if this is for  Room-bed changes (Note: nodes sorted by date/time from lowest to highest)
 . . ; node value is in the format of:
 . . ;   new room-bed ien ^ New Value ^ Old ien ^ Old Value ^ Current Value 
 . . IF RBIEN'=0 DO
 . . . SET CURMBD=$P($G(^DG(405.4,+RBIEN,0)),"^")   ;room bed current value
 . . . ; Check room-bed .01 field to see if room bed is new or not
 . . . IF (NFLDNUM=".01") DO
 . . . . IF OLDVAL="<no previous value>" DO
 . . . . . KILL RMBDUNQ(+RBIEN,"CHANGE")  ; Make sure "CHANGED node does not exist" 
 . . . . . KILL RMBDUNQ(+RBIEN,"DELETED100")  ; If already deleted verify DELETED100 node does not exist" 
 . . . . . SET RMBDUNQ(+RBIEN,"NEW")=(+RBIEN)_"^"_NEWVAL_"^^^"_$$CURRMBED("NARR",RBIEN)
 . . . . ELSE  DO
 . . . . . KILL RMBDUNQ(+RBIEN,"NEW")  ; Make sure "CHANGED node does not exist" 
 . . . . . KILL RMBDUNQ(+RBIEN,"DELETED100")  ; If it was already deleted make sure DELETED100 node does not exist" 
 . . . . . ; only store the first change
 . . . . . SET:'$D(RMBDUNQ(+RBIEN,"CHANGE"))#2 RMBDUNQ(+RBIEN,"CHANGE")=(+RBIEN)_"^"_NEWVAL_"^"_(+RBIEN)_"^"_OLDVAL_"^"_$$CURRMBED("NARR",RBIEN)
 . . . ; 
 . . . ; ward location is added/removed to/from the room-bed 
 . . . IF (NFLDNUM="100,.01") DO
 . . . . ; if ward location is added to the room-bed.
 . . . . IF OLDVAL="<no previous value>" DO
 . . . . . SET:'$D(RMBDUNQ(+RBIEN,"CHANGE")) RMBDUNQ(+RBIEN,"NEW")=(+RBIEN)_"^"_CURMBD_"^^^"_CURMBD
 . . . . . KILL RMBDUNQ(+RBIEN,"DELETED100")  ; if deleted, verify DELETED100 node does not exist.
 . . . . .;
 . . . . ; if the the ward location is deleted from the room-bed, make sure not newed.
 . . . . IF NEWVAL="<deleted>" DO 
 . . . . . KILL RMBDUNQ(+RBIEN,"NEW")
 . . . . . SET RMBDUNQ(+RBIEN,"DELETED100")="^^"_(+RBIEN)_"^"_ENTNM_"^"_CURMBD  ; report Entry Name (ENTNM) from audit file 
 . . . ;
 . ;
 . ; Store results for current HL file entry in CUR and PREV arrays
 . IF $D(CUR("HL","FLAG")),CUR("HL","FLAG")'="NEW" DO
 . . MERGE PREV=CUR
 . . SET CUR("HL","FLAG")="CURRENT"
 . . SET PREV("HL","FLAG")="PREVIOUS"
 . ; modify the PREV array from MOD array to record changes for HL file
 . IF $G(CUR("HL","FLAG"))="" SET CUR("HL","FLAG")="CURRENT",PREV("HL","FLAG")="PREVIOUS",CUR("HL",.001)=HLIEN,PREV("HL",.001)=HLIEN,MOD("HL",.001)=HLIEN
 . SET FLDNUM=0 FOR  SET FLDNUM=$O(MOD("HL",FLDNUM)) QUIT:'FLDNUM  SET PREV("HL",FLDNUM)=MOD("HL",FLDNUM)
 . SET FLDNUM=0 FOR  SET FLDNUM=$O(PREV("HL",FLDNUM)) QUIT:'FLDNUM  SET:(FLDNUM'=.001)&(PREV("HL",FLDNUM)=$G(CUR("HL",FLDNUM))) PREV("HL",FLDNUM)=""
 . ;
 . ;determine if this HL was reactivated or inactivated.
 . IF ACTDT'="",ACTDT>INACTDT S CUR("HL",2506)=ACTDT        ; current reactivate date
 . IF INACTDT'="",INACTDT>ACTDT S CUR("HL",2505)=INACTDT    ; current inactivate date
 . IF ACTDT'="",ACTDT<INACTDT S PREV("HL",2506)=ACTDT       ; previous reactive date
 . IF INACTDT'="",INACTDT<ACTDT S PREV("HL",2505)=INACTDT   ; previous inactivate date
 . ;
 . ; Determine if HL type is changed or not.  
 . SET CURTYPE=CUR("HL",2)          ;$P(NEWCUR,"^",5)
 . SET PREVTYPE=$G(PREV("HL",2))    ;$P(PREVIOUS,"^",5)
 . SET IGNORE=0
 . IF CUR("HL","FLAG")="NEW" DO
 . . IF "CLINIC^WARD^OPERATING ROOM"'[CURTYPE SET IGNORE=1 QUIT   ;do not Report this HL.
 . IF CUR("HL","FLAG")="CURRENT" DO
 . . IF PREVTYPE="","CLINIC^WARD^OPERATING ROOM"'[CURTYPE SET IGNORE=1 QUIT   ;do not Report HL
 . . ;
 . . ; if type changed from others to "CLINIC^WARD^OPERATING ROOM"  report all room-beds containing location
 . . IF PREVTYPE'="","CLINIC^WARD^OPERATING ROOM"'[PREVTYPE,"CLINIC^WARD^OPERATING ROOM"[CURTYPE DO
 . . . SET CUR("HL","FLAG")="NEW"   ; force the HL to be new even though currently exists 
 . . . SET WLIEN=$$HLTOWL^LRJSMLA1(HLIEN)
 . . . SET RMBDIEN=0
 . . . ;IA #1380 for ^DG(405.4,"W", reference
 . . . FOR  SET RMBDIEN=$O(^DG(405.4,"W",WLIEN,RMBDIEN)) QUIT:'RMBDIEN  DO
 . . . . SET:$$KEEPBED^LRJSMLA1(+RMBDIEN,$NAME(@OUT@("REVARR","N",HLIEN))) RMBDUNQ(+RMBDIEN,"NEW")=(+RMBDIEN)_"^"_$P($G(^DG(405.4,RMBDIEN,0)),"^",1)_"^^^"_$P($G(^DG(405.4,RMBDIEN,0)),"^",1)
 . . ;
 . . ; if type changed from "CLINIC^WARD^OPERATING ROOM" to others report deleted room-beds containing location
 . . IF PREVTYPE'="","CLINIC^WARD^OPERATING ROOM"[PREVTYPE,"CLINIC^WARD^OPERATING ROOM"'[CURTYPE DO
 . . . SET WLIEN=$$HLTOWL^LRJSMLA1(HLIEN)
 . . . SET RMBDIEN=0
 . . . FOR  SET RMBDIEN=$O(^DG(405.4,"W",WLIEN,RMBDIEN)) QUIT:'RMBDIEN  DO
 . . . . SET RMBDUNQ(+RMBDIEN,"DELETED100")="^^"_(+RMBDIEN)_"^"_$P($G(^DG(405.4,RMBDIEN,0)),"^",1)_"^"_$P($G(^DG(405.4,RMBDIEN,0)),"^",1)
 . . . ;   
 . IF IGNORE=1 D  QUIT
 . . KILL @OUT@(HLIEN)
 . ;
 . ; store HL record in output array
 . SET HLSORT="SORT2RAW"
 . IF CUR("HL","FLAG")="NEW" SET HLSORT="SORT1RAW"
 . IF "NEW^CURRENT"[CUR("HL","FLAG") SET @OUT@(HLSORT,HLIEN,0,CUR("HL","FLAG"))=$$BLDHLREC(.CUR)
 . IF "CURRENT"[CUR("HL","FLAG") SET @OUT@(HLSORT,HLIEN,0,PREV("HL","FLAG"))=$$BLDHLREC(.PREV)
 . ;
 . KILL RMBDLIST
 . ;
 . IF HLSORT="SORT1RAW" DO
 . . SET NEWCUR=@OUT@(HLSORT,HLIEN,0,"NEW")
 . . SET PREVIOUS=$P(NEWCUR,"^",1,3)_"^^^^^"
 . IF HLSORT="SORT2RAW" DO
 . . SET NEWCUR=@OUT@(HLSORT,HLIEN,0,"CURRENT")
 . . SET PREVIOUS=@OUT@(HLSORT,HLIEN,0,"PREVIOUS")
 . ;
 . ; Build the NEW, CURRENT/PREVIOUS ROOM and BED records.
 . SET NODE="RMBDUNQ"
 . ;
 . ;NOTE: -.235681 is  the "BEDNAME" subscript on ROOM node to assure the ROOM node of the
 . ;       array is ordered before BED node.
 . ;       -.235681 not a legitimate BED name in .01 field of the ROOM-BED file
 . ;       .01 Input transform will prevent entry of -.235681 for bed name via FileMan
 . FOR  SET NODE=$Q(@NODE) QUIT:NODE=""  DO
 . . SET ROOMNAME=$P($P(@NODE,"^",5),"-",1)
 . . SET BEDNAME=$P($P(@NODE,"^",5),"-",2,3)
 . . SET OLDRMNM=$P($P(@NODE,"^",4),"-",1)
 . . SET OLDBDNM=$P($P(@NODE,"^",4),"-",2,3)
 . . SET FLAG=$QS(NODE,2)
 . . SET RBIEN=$QS(NODE,1)
 . . ;
 . . IF CUR("HL","FLAG")="NEW" DO
 . . . SET RMBDLIST("AAAROOM",ROOMNAME,-.235681,"NEW")="NEW^ROOM^"_$P(NEWCUR,"^",3,7)_"^"_ROOMNAME_"^"
 . . . SET RMBDLIST("AAAROOM",ROOMNAME,BEDNAME,"NEW")="NEW^BED^"_$P(NEWCUR,"^",3,7)_"^"_ROOMNAME_"^"_BEDNAME
 . . ELSE  DO
 . . . IF FLAG="DELETED100" DO
 . . . . SET RMBDLIST("AAAROOM",ROOMNAME,-.235681,"CURRENT")="CURRENT^ROOM^"_$P(NEWCUR,"^",3,7)_"^^"
 . . . . SET RMBDLIST("AAAROOM",ROOMNAME,-.235681,"PREVIOUS")="PREVIOUS^ROOM^"_$P(PREVIOUS,"^",3,7)_"^"_ROOMNAME_"^"
 . . . . SET RMBDLIST("AAAROOM",ROOMNAME,BEDNAME,"ACUR")="CURRENT^BED^"_$P(NEWCUR,"^",3,7)_"^"_ROOMNAME_"^"
 . . . . SET RMBDLIST("AAAROOM",ROOMNAME,BEDNAME,"APREV")="PREVIOUS^BED^"_$P(PREVIOUS,"^",3,7)_"^"_OLDRMNM_"^"_OLDBDNM
 . . . ELSE  DO
 . . . . SET RMBDLIST("AAAROOM",ROOMNAME,-.235681,"CURRENT")="CURRENT^ROOM^"_$P(NEWCUR,"^",3,7)_"^"_ROOMNAME_"^"
 . . . . SET RMBDLIST("AAAROOM",ROOMNAME,-.235681,"PREVIOUS")="PREVIOUS^ROOM^"_$P(PREVIOUS,"^",3,7)_"^"_ROOMNAME_"^"
 . . . . SET RMBDLIST("AAAROOM",ROOMNAME,BEDNAME,"ACUR")="CURRENT^BED^"_$P(NEWCUR,"^",3,7)_"^"_ROOMNAME_"^"_BEDNAME
 . . . . SET RMBDLIST("AAAROOM",ROOMNAME,BEDNAME,"APREV")="PREVIOUS^BED^"_$P(PREVIOUS,"^",3,7)_"^"_OLDRMNM_"^"_OLDBDNM
 . ; 
 . MERGE @OUT@(HLSORT,HLIEN)=RMBDLIST
 ;
 KILL @REVNODE
 QUIT
 ; 
BLDHLREC(RES) ; return the record from RES array.
 ; Input:
 ;        RES - new/current or previous results from audit file and file 44
 ; Output:
 ;        Return the record
 NEW X
 SET X=RES("HL","FLAG")           ; flag (.e.g.  NEW, CURRENT, PREVIOUS)
 SET X=X_"^"_RES("HL","NAME")     ; Record Type ( only "LOCATION")
 SET X=X_"^"_RES("HL",.001)       ; file 44 ien
 SET X=X_"^"_RES("HL",.01)        ; HL Name 
 SET X=X_"^"_RES("HL",2)          ; Type of file 44 entry
 SET X=X_"^"_RES("HL",3)          ; Institution
 SET X=X_"^"_RES("HL",3.5)        ; Division
 SET X=X_"^"_RES("HL",2505)       ; Inactivation Date
 SET X=X_"^"_RES("HL",2506)       ; Reactivation Date
 ;
 IF (RES("HL","FLAG")="NEW")!(RES("HL","FLAG")="CURRENT") DO
 . SET X=X_"^"_RES("HL","USER")   ; Accessed by (editing person)
 . SET X=X_"^"_RES("HL","DTR")    ; Date/Time of Change
 QUIT X
 ;
ROLLUP(HLIEN,CUR,NARR,TO) ; roll back the CUR HL values from current time back to "TO" time
 ; Input:
 ;        HLIEN - HL ien.
 ;        NARR -  array containing the audit file data for given HL
 ;        CUR -   array containing HL data.
 ;        TO -    End Date for extract
 ; Output:
 ;        CUR -  array containing HL data.
 ;
 NEW NODE,NFLDNUM,RBIEN,NEWIENV,OLDIENV,NEWVAL,OLDVAL,USER,DTR,ENTNM
 NEW REVNARR,RNODE
 ; Reverse the order of NARR array by date/time (first subscript) from highest to lowest 
 SET NODE="NARR"
 FOR  SET NODE=$Q(@NODE) QUIT:NODE=""  DO
 . SET RNODE="REVNARR("_(9999999-$QS(NODE,1))
 . FOR I=2:1 QUIT:$QS(NODE,I)=""  SET RNODE=RNODE_","_$QS(NODE,I)
 . SET RNODE=RNODE_")"
 . SET @RNODE=@NODE
 ;
 SET NODE="REVNARR"
 FOR  SET NODE=$Q(@NODE) QUIT:NODE=""  DO
 . SET DTR=$P(@NODE,"^",6)     ; Date/Time Recorded 
 . QUIT:'(DTR>TO)
 . SET NFLDNUM=$QS(NODE,4)     ; field number   
 . SET RBIEN=$QS(NODE,3)       ; room-bed ien
 . SET OLDVAL=$P(@NODE,"^",4)  ; Old value (from last audit after "TO" date/time
 . ; if change HL or Ward Location (room-bed ien is 0) 
 . ; rollback the current value to old value.
 . IF RBIEN=0 DO
 . . SET CUR("HL",NFLDNUM)=OLDVAL
 Q
 ;
GHL(HLIEN,CUR) ; get the fields that are to be reported for given HL into CUR array 
 ; Input:
 ;        HLIEN - Hosp Loc ien.
 ; Output:
 ;        CUR -  array containing hosiptal location data.
 NEW ARR,FILENUM
 SET FILENUM=44
 SET HLIEN=+HLIEN
 ;
 ;IA #10040 for Fileman ref (GETS^DIQ) into file 44 (Hospital Location)
 DO GETS^DIQ(FILENUM,HLIEN_",",$$GRPTLST^LRJSMLA1(FILENUM,2),"IE","ARR")
 SET CUR("HL",.001)=HLIEN                       ; ien
 SET CUR("HL",.01)=ARR(44,HLIEN_",",.01,"E")    ; HL name
 SET CUR("HL",2)=ARR(44,HLIEN_",",2,"E")        ; type
 SET CUR("HL",3)=ARR(44,HLIEN_",",3,"E")        ; institution
 SET CUR("HL",3.5)=ARR(44,HLIEN_",",3.5,"E")    ; division
 SET CUR("HL",2505)=ARR(44,HLIEN_",",2505,"E")  ; inactivation date
 SET CUR("HL",2506)=ARR(44,HLIEN_",",2506,"E")  ; reactivation date
 SET CUR("HL","NAME")="LOCATION"
 QUIT
 ;
CURRMBED(LRARRY,RBIEN) ; Find value of Room-Bed after last change before End-Date
 ;INPUT:
 ;  LRARRY - "NARR" Array name for local array with form: 
 ;           NARR(date time recorded, Ward Location ien, room-bed ien and ward(s) sub-file,  field number, audit file ien)
 ; Node data = new internal value (NULL) ^ old internal value (NULL) ^ new value ^ old value ^ user ^ data time recorded ^ audit file entry name
 ;
 ;  RBIEN  - Room-Bed IEN
 ;
 ;OUTPUT:
 ;  LRRMBD - Current Room-Bed just prior to Change Report "End Date"
 ;
 NEW LRWLN,LRRBWN,LRFN,LRAUDN,LRLASTDT
 ;
 ;[Two Room-Bed Audit records will not have the same dt/tm]
 SET (LRLASTDT,LRWLN,LRRBWN)=""
 FOR  SET LRRBWN=$$RBIENCK(.LRLASTDT,.LRWLN,LRARRY) Q:LRRBWN=RBIEN
 ;
 SET LRFN=$O(@LRARRY@(LRLASTDT,LRWLN,LRRBWN,"")) ;Get field number
 ;
 ; Find last audit file ien subscript
 SET LRAUDN=$O(@LRARRY@(LRLASTDT,LRWLN,LRRBWN,LRFN,""),-1)
 QUIT $P(@LRARRY@(LRLASTDT,LRWLN,LRRBWN,LRFN,LRAUDN),"^",3) ;Return "Changed to" Rm-Bed for last entry
 ;
RBIENCK(LRLSTDT,LRWLN,LRARRY) ; Check for correct Room-Bed IEN
 ;INPUT:
 ;  LRLSTDT - Date of Last Change being processed [Passed by Reference]
 ;  LRWLN   - IEN for Ward-Location being processed [Passed by Reference]
 ;  LRARRY  - "NARR" Array name for local array [Passed from CURRMBED] 
 ;
 ;OUTPUT:
 ;  Room-Bed IEN and Ward(s) sub-file just prior to "End Date" being processed
 ;
 SET LRLSTDT=$O(@LRARRY@(LRLSTDT),-1) ;Get last date
 ;
 SET LRWLN=$O(@LRARRY@(LRLSTDT,"")) ;Get Ward Location ien
 ;
 QUIT $O(@LRARRY@(LRLSTDT,LRWLN,"")) ;Return Room-Bed IEN and Ward(s) sub-file
