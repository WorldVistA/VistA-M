ORQQVI2 ;SLC/dee- RPC calls to GMRVPCE0, Vitals data event drivers ;2/2/98
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10**;Dec 17, 1997
 ;
 Q
 ;
 ; ORQDATA is in the format
 ;   ORQDATA(i)="VST^DT^encounter date"                       required
 ;   ORQDATA(i)="VST^PT^pointer to patient"                   required
 ;   ORQDATA(i)="VST^HL^pointer to Hospital Location"         required
 ;   ORQDATA(i)="VIT^vital type^^^value^provider^units^date/time"
 ; ORVITALS is the array passed to GMRV in the PCE Device Interface
 ;   format.
 ; ORQVIT is an array subscipted by the index in ORVITALS that contains
 ;   the subscript of the data gotten from ORQDATA.  This is used to tell
 ;   the caller which item had an ERROR or WARNING.
 ; ORRETURN(0) is 1 if no ERRORs or WARNINGs
 ;              0 if there are WARNING(s) but no ERRORs
 ;             -1 if there are ERROR(s)
 ; ORRETURN(n) where n>0 is an error or warning in validating the data
 ;   1 piece:  subscript of ORQDATA that the error or warning is on
 ;   2 piece:  "ERROR" or "WARNING"
 ;   3 piece:  text message about error or warning
 ;   4 piece:  data item that generated the error or warning
 ;
VALIDATE(ORRETURN,ORQDATA) ;
 ; Given the array ORQDATA passed in by PCE Device Interface whose
 ; format is described in the PCE Device Interface documentation, this
 ; procedure will validate the Vitals data.  If the data is invalid,
 ; the procedure will return the errors in the form given above.
 ;
 N ORVITALS,ORQVIT
 ;Initialize RETURN to no errors
 K ORRETURN
 S ORRETURN(0)=1
 D PREVITAL(.ORRETURN,.ORVITALS,.ORQVIT,.ORQDATA)
 D VALIDATE^GMRVPCE0(.ORVITALS)
 D POSTVIT(.ORRETURN,.ORQVIT,.ORVITALS)
 Q
 ;
VALSTORE(ORRETURN,ORQDATA) ;Calls VALIDATE and if no errors calls STORE
 ; Given the array ORQDATA passed in by PCE Device Interface whose
 ; format is described in the PCE Device Interface documentation, this
 ; procedure will validate the Vitals data.  If the data is invalid,
 ; the procedure will return the errors in the form given above.
 ; If there are no errors then this procedure will call 
 ; Vitals/Measurements to store the data in the GMRV's 
 ; Patient Measurements (120.5) file.
 ;
 N ORVITALS,ORQVIT
 ;Initialize RETURN to no errors
 K ORRETURN
 S ORRETURN(0)=1
 D PREVITAL(.ORRETURN,.ORVITALS,.ORQVIT,.ORQDATA)
 D VALIDATE^GMRVPCE0(.ORVITALS)
 D POSTVIT(.ORRETURN,.ORQVIT,.ORVITALS)
 I ORRETURN(0)=1 D STORE^GMRVPCE0(.ORVITALS)
 Q
 ;
PREVITAL(ORRETURN,ORVITALS,ORQVIT,ORQDATA) ;format array for call to Vitlals
 N ORQTYPE,ORQCODE,ORINDEX1,ORINDEX2,ORRETINX,ORQITEM
 N ORQNODT,ORQNOPT,ORQNOHL
 S (ORQNODT,ORQNOPT,ORQNOHL)=1
 S ORVITALS("SOURCE")="^"_DUZ
 S ORINDEX2=0
 S ORRETINX=$O(ORRETURN(""),-1)
 S ORINDEX1=""
 F  S ORINDEX1=$O(ORQDATA(ORINDEX1)) Q:'ORINDEX1  D
 . S ORQDATAX=ORQDATA(ORINDEX1),ORQTYPE=$P(ORQDATAX,"^"),ORQCODE=$P(ORQDATAX,"^",2)
 . I ORQTYPE="PRV" S ORVITALS("PROVIDER",1)=ORQCODE Q
 . I ORQTYPE="VST" D  Q
 .. I ORQCODE="DT" D  Q
 ... S ORQNODT=0
 ... S ORQITEM=$P(ORQDATAX,"^",3)
 ... S $P(ORVITALS("ENCOUNTER"),"^",1)=ORQITEM
 ... I ORQITEM>$$NOW^XLFDT D
 .... S ORRETINX=ORRETINX+1
 .... S ORRETURN(ORRETINX)=ORINDEX1_"^ERROR^Date/Time entered cannot be in the future^"_$$FMTE^XLFDT(ORQITEM)
 .... S ORRETURN(0)=-1
 ... I ORQITEM'>1800000 D
 .... S ORRETINX=ORRETINX+1
 .... S ORRETURN(ORRETINX)=ORINDEX1_"^ERROR^Encounter Date/Time not valid^"_ORQITEM
 .... S ORRETURN(0)=-1
 .. I ORQCODE="PT" D  Q
 ... S ORQNOPT=0
 ... S ORQITEM=$P(ORQDATAX,"^",3)
 ... S $P(ORVITALS("ENCOUNTER"),"^",2)=ORQITEM
 ... I '($D(^DPT(+ORQITEM,0))#2) D
 .... S ORRETINX=ORRETINX+1
 .... S ORRETURN(ORRETINX)=ORINDEX1_"^ERROR^Patient missing or invalid in file 2^"_ORQITEM
 .... S ORRETURN(0)=-1
 .. I ORQCODE="HL" D  Q
 ... S ORQNOHL=0
 ... S ORQITEM=$P(ORQDATAX,"^",3)
 ... S $P(ORVITALS("ENCOUNTER"),"^",3)=ORQITEM
 ... I '$D(^SC(ORQITEM,0)) D
 .... S ORRETINX=ORRETINX+1
 .... S ORRETURN(ORRETINX)=ORINDEX1_"^ERROR^HOSPITAL LOCATION Missing is not in file 44^"_ORQITEM
 .... S ORRETURN(0)=-1
 ...; I $D(^PX(815,1,"DHL","B",ORQITEM)) D
 ...;. S ORRETINX=ORRETINX+1
 ...;. S ORRETURN(ORRETINX)=ORINDEX1_"^ERROR^HOSPITAL LOCATION Can not be a disposition clinic^"_ORQITEM
 ...;. S ORRETURN(0)=-1
 . I ORQTYPE="VIT" D  Q
 .. S ORINDEX2=ORINDEX2+1
 .. S ORQVIT(ORINDEX2)=ORINDEX1
 .. S ORVITALS("VITALS",+$P(ORQDATAX,"^",6),ORINDEX2)=ORQCODE_"^"_$P(ORQDATAX,"^",5)_"^"_$P(ORQDATAX,"^",7,8)
 I ORQNODT D
 . S ORRETINX=ORRETINX+1
 . S ORRETURN(ORRETINX)="^ERROR^Required data item, ENCOUNTER DATE/TIME, is missing^"
 . S ORRETURN(0)=-1
 I ORQNOPT D
 . S ORRETINX=ORRETINX+1
 . S ORRETURN(ORRETINX)="^ERROR^Required data item, PATIENT, is missing^"
 . S ORRETURN(0)=-1
 I ORQNOHL D
 . S ORRETINX=ORRETINX+1
 . S ORRETURN(ORRETINX)="^ERROR^Required data item, HOSPITAL LOCATION, is missing^"
 . S ORRETURN(0)=-1
 Q
 ;
POSTVIT(ORRETURN,ORQVIT,ORVITALS) ;return errors and warnings
 N ORVAR,ORINDEX,ORQTYPE
 S ORINDEX=$O(ORRETURN(""),-1)
 F ORQTYPE="WARNING","ERROR" D
 . S ORVAR="ORVITALS("""_ORQTYPE_""")"
 . F  S ORVAR=$Q(@ORVAR) Q:ORVAR'[("ORVITALS("""_ORQTYPE_"""")  D
 .. S ORINDEX=ORINDEX+1
 .. S ORRETURN(ORINDEX)=$G(ORQVIT($P(ORVAR,",",4)))_"^"_ORQTYPE_"^"_@ORVAR
 .. I ORQTYPE="WARNING" S:ORRETURN(0)>0 ORRETURN(0)=0
 .. E  S ORRETURN(0)=-1
 Q
 ;
HELP(ORQLST,ORQTYPE) ; This procedure will return help for a particular
 ; measurement type in an array.
 ;   Input
 ;   Variables:  ORQTYPE=Type of measurement (abbreviation
 ;               (req.)  from PCE Device Interface Specification).
 ;               ORQLST=Array root to store help text in
 ;
 D HELP^GMRVPCE0(ORQTYPE,"ORQLST")
 Q
 ;
RATECHK(ORRETURN,ORQTYPE,ORQRATE,ORQUNIT) ;
 ; Extrinsic function to validate the
 ; rate for a particular measurement
 ;   Input
 ;   Variables:  ORQTYPE=Type of measurement (abbreviation
 ;               (req.)  from PCE Device Interface Specification).
 ;               ORQRATE=Measurement rate to be validated.
 ;               (req.)
 ;               ORQUNIT=Unit of measurement for rate, if specified.
 ;               (opt.)
 ;   Return value:  1 if rate is valid.
 ;                  0 if rate is invalid.
 ;
 S ORRETURN=$$RATECHK^GMRVPCE0(ORQTYPE,ORQRATE,$G(ORQUNIT))
 Q
 ;
VMTYPES(ORRETURN,ORQTYPE) ;
 ; This function returns one if ORQTYPE is a valid type abbrev.
 ; from the PCE Device Interface Specification.
 S ORRETURN=$$VMTYPES^GMRVPCE0(ORQTYPE)
 Q
