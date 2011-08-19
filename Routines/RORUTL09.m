RORUTL09 ;HCIOFO/SG - LIST ITEM UTILITIES  ; 4/26/05 10:46am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** RETURNS CODE AND TEXT OF THE ITEM IN THE FILE #799.1
 ;
 ; ITEMIEN       IEN of the item
 ; [.TEXT]       Text of the item is returned via this parameter
 ;
 ; Return Values:
 ;       <0  Error code
 ;       ""  Code is not available
 ;       >0  Code of the item
 ;
ITEMCODE(ITEMIEN,TEXT) ;
 S TEXT=""  Q:ITEMIEN'>0 ""
 Q:'$D(^ROR(799.1,+ITEMIEN,0)) ""
 N IENS,RC,RORBUF,RORMSG
 S IENS=(+ITEMIEN)_","
 D GETS^DIQ(799.1,IENS,".01;.04",,"RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.1,IENS)
 S TEXT=$G(RORBUF(799.1,IENS,.01))
 Q $G(RORBUF(799.1,IENS,.04))
 ;
 ;***** RETURNS IEN AND TEXT OF THE ITEM IN THE FILE #799.1
 ;
 ; TYPE          Type of the item
 ; REGIEN        Registry IEN
 ; CODE          Code of the item
 ; [.TEXT]       Text of the item is returned via this parameter
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the item
 ;
ITEMIEN(TYPE,REGIEN,CODE,TEXT) ;
 N RC,RORBUF,RORMSG,SRCHVAL
 S TEXT="",SRCHVAL(1)=+TYPE,SRCHVAL(2)=+REGIEN,SRCHVAL(3)=+CODE
 D FIND^DIC(799.1,,"@;.01","QX",.SRCHVAL,2,"KEY",,,"RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.1)
 S RC=+$G(RORBUF("DILIST",0))
 S:RC=1 TEXT=$G(RORBUF("DILIST","ID",1,.01))
 Q $S(RC<1:-80,RC>1:-81,1:+RORBUF("DILIST",2,1))
 ;
 ;***** RETURNS A LIST OF ITEMS FROM THE FILE #799.1
 ;
 ; TYPE          Type of the items:
 ;                 3  Lab Group
 ;                 4  Drug Group
 ;
 ; REGIEN        Registry IEN
 ;
 ; .ROR8DST      Reference to a destination array.
 ;               Items are returned into this array in the following
 ;               format: ROR8DST(ItemCode)=ItemIEN^ItemText
 ;
 ; [CDT]         "Current" Date/Time (NOW by default)
 ;
 ;               If this date/time is equal or later that the
 ;               inactivation date from the item record (only if
 ;               there is any) then the item is considered inactive
 ;               and will be skipped.
 ;
 ;               To include both active and inactive items in the
 ;               list, pass a negative number as the value of this
 ;               parameter.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
ITEMLIST(TYPE,REGIEN,ROR8DST,CDT) ;
 N CODE,IEN,IENS,INCTVDT,NODE,RC,RORBUF,RORMSG
 S NODE=$NA(^ROR(799.1,"KEY",TYPE,REGIEN))  K ROR8DST
 S:'$G(CDT) CDT=$$NOW^XLFDT
 ;--- Load the active list items
 S CODE="",RC=0
 F  S CODE=$O(@NODE@(CODE))  Q:CODE=""  D  Q:RC<0
 . S IEN=$O(@NODE@(CODE,""))  Q:'IEN
 . S IENS=IEN_","  K RORBUF
 . ;--- Load text and inactivation date
 . D GETS^DIQ(799.1,IENS,".01;1","IE","RORBUF","RORMSG")
 . I $G(DIERR)  D  Q
 . . S RC=$$DBS^RORERR("RORMSG",-9,,,799.1,IENS)
 . ;--- Skip inactive items
 . S INCTVDT=$G(RORBUF(799.1,IENS,1,"I"))
 . I INCTVDT>0  Q:CDT'<INCTVDT
 . ;--- Create a record in the destination array
 . S ROR8DST(CODE)=IEN_U_$G(RORBUF(799.1,IENS,.01,"E"))
 Q $S(RC<0:RC,1:0)
