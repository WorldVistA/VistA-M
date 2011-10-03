RORUTL08 ;HCIOFO/SG - REPORT PARAMETERS UTILITIES  ; 11/21/05 5:08pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** RETURNS CODE AND NAME OF THE REPORT PARAMETERS (#799.34)
 ;
 ; RPIEN         IEN of the report parameters
 ; [.NAME]       Report name is returned via this parameter
 ;
 ; Return Values:
 ;       ""  Code is not available
 ;           Code of the report
 ;
RPCODE(RPIEN,NAME) ;
 S NAME=""  Q:RPIEN'>0 ""
 N BUF
 S BUF=$G(^ROR(799.34,+RPIEN,0))  Q:BUF="" ""
 S NAME=$P(BUF,U)
 Q $P(BUF,U,4)
 ;
 ;***** RETURNS IEN AND NAME OF THE REPORT PARAMETERS (#799.34)
 ;
 ; CODE          Code of the report
 ; [.NAME]       Report name is returned via this parameter
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the item
 ;
RPIEN(CODE,NAME) ;
 N RC,RORBUF,RORMSG  S NAME=""
 D FIND^DIC(799.34,,"@;.01","QX",CODE,2,"KEY",,,"RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,799.34)
 S RC=+$G(RORBUF("DILIST",0))
 S:RC=1 NAME=$G(RORBUF("DILIST","ID",1,.01))
 Q $S(RC<1:-86,RC>1:-87,1:+RORBUF("DILIST",2,1))
 ;
 ;***** RETURNS REPORT PARAMETERS
 ;
 ; CODE          Report code
 ;
 ; .INFO         Reference to a local variable (output):
 ;
 ; INFO(
 ;   OFFSET+1)           Report Name
 ;   OFFSET+2)           Backgr. Processing    (0/1)
 ;   OFFSET+3)           reserved
 ;   OFFSET+4)           Code of the report
 ;   OFFSET+5)           Report Parameters IEN
 ;   OFFSET+6)           Inactivation Date     (FileMan)
 ;   OFFSET+7)           National              (0/1)
 ;   OFFSET+8)           List of parameter panels
 ;   OFFSET+9)           Report Builder        ($$TAG^ROUTINE)
 ;   OFFSET+10)          Default parameters    (XML)
 ;   OFFSET+11)          Default sorting modes (XML)
 ;   OFFSET+12)          Shared Templates      (0/1)
 ;
 ; [FLAGS]       Characters controlling behavior of the function
 ;               (they can be combined):
 ;                 E  Return external values also (when applicable)
 ;
 ; [OFFSET]      A number that is added to all subscripts in the
 ;               destination array (by default, it is zero).
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
RPINFO(CODE,INFO,FLAGS,OFFSET) ;
 N BUF,I,IEN,IENS,RC,RORBUF,RORMSG,TMP
 S FLAGS=$$UP^XLFSTR($G(FLAGS))
 S OFFSET=$S($G(OFFSET)>0:+OFFSET,1:0)
 ;--- Clear the output array
 K:'OFFSET INFO  S TMP=$$RPN
 F I=1:1:TMP  S INFO(OFFSET+I)=""
 ;--- Get the record IEN
 S IEN=$$RPIEN(CODE)  Q:IEN<0 IEN
 ;--- Load the parameters
 S IENS=IEN_",",I=$S(FLAGS["E":"EIN",1:"IN")
 S TMP=".01;.02;.03;.04;.05;.09;1;10.01;11;12"
 D GETS^DIQ(799.34,IENS,TMP,I,"RORBUF","RORMSG")
 I $G(DIERR)  D  Q RC
 . S RC=$$DBS^RORERR("RORMSG",-9,,,799.34,IENS)
 ;--- Name
 S INFO(OFFSET+1)=$G(RORBUF(799.34,IENS,.01,"I"))
 ;--- Background Processing
 I $G(RORBUF(799.34,IENS,.02,"I"))'=""  D
 . S INFO(OFFSET+2)=RORBUF(799.34,IENS,.02,"I")
 ;--- Code of the report
 S INFO(OFFSET+4)=$G(RORBUF(799.34,IENS,.04,"I"))
 ;--- Report Parameters IEN
 S INFO(OFFSET+5)=IEN
 ;--- Inactivation Date
 I $G(RORBUF(799.34,IENS,.05,"I"))'=""  D
 . S INFO(OFFSET+6)=RORBUF(799.34,IENS,.05,"I")
 ;--- National
 I $G(RORBUF(799.34,IENS,.09,"I"))'=""  D
 . S INFO(OFFSET+7)=RORBUF(799.34,IENS,.09,"I")
 ;--- List of parameter panels
 S INFO(OFFSET+8)=$G(RORBUF(799.34,IENS,1,"I"))
 ;--- Report Builder
 S INFO(OFFSET+9)=$G(RORBUF(799.34,IENS,10.01,"I"))
 ;--- Default parameters
 S I=0,BUF=""
 F  S I=$O(RORBUF(799.34,IENS,11,I))  Q:I'>0  D
 . S BUF=BUF_$$TRIM^XLFSTR(RORBUF(799.34,IENS,11,I))
 S:BUF'="" INFO(OFFSET+10)="<PARAMS>"_BUF_"</PARAMS>"
 ;--- Default sorting modes
 S I=0,BUF=""
 F  S I=$O(RORBUF(799.34,IENS,12,I))  Q:I'>0  D
 . S BUF=BUF_$$TRIM^XLFSTR(RORBUF(799.34,IENS,12,I))
 S:BUF'="" INFO(OFFSET+11)="<SORT_MODES>"_BUF_"</SORT_MODES>"
 ;--- Shared Templates
 S INFO(OFFSET+12)=$G(RORBUF(799.34,IENS,.03,"I"))
 Q 0
 ;
 ;***** RETURNS A LIST OF REPORTS AVAILABLE FOR THE REGISTRY
 ;
 ; .ROR8DST      Reference to a local variable. Report parameters are
 ;               returned into this array in the following format:
 ;
 ;                 ROR8DST(ReportCode)=ReportIEN^ReportName
 ;
 ; [REGIEN]      Registry IEN. If $G(REGIEN)>0, both the registry
 ;               specific (REGISTRY=REGIEN) and common (REGISTRY=0)
 ;               reports will be returned. Otherwise, only the common
 ;               ones will be returned.
 ;
 ; [CDT]         "Current" Date/Time (NOW by default)
 ;
 ;               If this date/time is equal or later that the
 ;               inactivation date from the record (only if there
 ;               is any) then the record is considered inactive
 ;               and will be skipped.
 ;
 ;               To include both active and inactive reports in the
 ;               list, pass a negative number as the value of this
 ;               parameter.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
RPLIST(ROR8DST,REGIEN,CDT) ;
 N CODE,I,IEN,IENS,NAME,INCTVDT,RC,RORMSG,RPLST
 K ROR8DST  S RC=0  S:'$G(CDT) CDT=$$NOW^XLFDT
 ;--- Load the list of available reports (report codes)
 S IENS=(+REGIEN)_","
 S RPLST=$$GET1^DIQ(798.1,IENS,27,,,"RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798.1,IENS)
 S RPLST=$TR(RPLST," ")
 ;--- Load the report parameters
 F I=1:1  S CODE=$P(RPLST,",",I)  Q:CODE=""  D  Q:RC<0
 . S IEN=$$RPIEN(CODE,.NAME)  Q:IEN'>0
 . S IENS=IEN_","
 . ;--- Skip inactive report parameters
 . S INCTVDT=$$GET1^DIQ(799.34,IENS,.05,"I",,"RORMSG")
 . I $G(DIERR)  D  Q
 . . S RC=$$DBS^RORERR("RORMSG",-9,,,799.34,IENS)
 . I INCTVDT>0  Q:CDT'<INCTVDT
 . ;--- Create a record in the destination array
 . S ROR8DST(CODE)=IEN_U_NAME
 Q $S(RC<0:RC,1:0)
 ;
 ;***** RETURNS NUMBER OF NODES IN THE PARAMETERS ARRAY
RPN() Q 12
