PXVRPC7 ;BPFO/LMT - PCE RPCs for V Immunization ;07/12/16  14:44
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**216**;Aug 12, 1996;Build 11
 ;
 ;
 ; Reference to ENCODE^VPRJSON supported by ICR #6411
 ;
RPC(PXRSLT,PXFILTER,PXLIST,PXBEFORE,PXDEM) ; entry point for RPC
 ;
 ; Returns immunization records from the V Immunization and V Immunization Deleted file.
 ; There are two methods for defining the criteria to determine which records to return.
 ;
 ;    1. A specific list of record IENs can be passed in, and only those records will
 ;       be returned (if they exist on the system). When called in this way, the list
 ;       of records should be passed in PXLIST, and PXFILTER should not be defined (if
 ;       both PXLIST and PXFILTER are defined, only the records listed in PXLIST will
 ;       be returned, and the search criteria in PXFILTER will be ignored).
 ;
 ;       If an invalid IEN was passed in, the following error will be returned:
 ;          "Record with IEN #xxx does not exist."
 ;       If the record could not be returned for some other reason, the following
 ;       error will be returned:
 ;          "Unable to return record with IEN #xxx."
 ;
 ;    2. A time range (and other filter criteria) can be passed in PXFILTER, and a list
 ;       of records that meet that criteria will be returned. Any record added, edited,
 ;       or deleted (if PXFILTER("INC DELETE")=1) within that time range will be
 ;       returned.
 ;
 ;       To limit the number of records returned, PXFILTER("MAX") can be set to the maximum
 ;       number of records to be returned. The RPC will return a value called "Bookmark".
 ;       That value can be used to call the RPC again, this time passing in the "Boomark"
 ;       value in PXFILTER("BOOKMARK") (all other parameters should be defined exactly as when
 ;       previously called), and the RPC will return the next n number of records that meet
 ;       the search criteria, and starting where the previous call left off. So for example,
 ;       if there are 1,000 records that meet the search criteria, and PXFILTER("MAX") is
 ;       set to return a maximum of 100 records, the RPC will need to be called 10 times in
 ;       order to return all 1,000 records. Each subsequent time the RPC is called, the caller
 ;       would set PXFILTER("BOOKMARK") to the bookmark value returned in the previous call.
 ;       The caller would know when they reach the end and that there are no more records
 ;       to be returned, when the RPC returns TOTAL ITEMS=0.
 ;
 ; Note: All date/time references are to be in FileMan format.
 ;
 ;Input:
 ;  PXRSLT   - Return value passed by reference (Required)
 ;  PXFILTER - Search criteria (Optional)
 ;     ("START")       - Start date/time to begin search from (Defaults to T-1)
 ;     ("STOP")        - Stop date/time to end search (if time is not specified,
 ;                       midnight is assumed). (Defaults to T-1)
 ;    ("DATA SRC EXC") - A semi-colon delimited list of Data Source names (in external format)
 ;                       (e.g., SRC1;SRC2;SRCn) (Optional).
 ;                       Any immunization record whose DATA SOURCE matches one of the data names
 ;                       in this list will be filtered out, and will not be returned.
 ;     ("MAX")         - The maximum number of records to return (defaults to 99)
 ;     ("BOOKMARK")    - If wanting to get the next n number of records, the
 ;                       bookmark value returned in the previous call should be passed here. (Optional)
 ;     ("INC DELETE")  - Flag to control if records should also be returned from the V
 ;                       IMMUNIZATION DELETED file. (defaults to "1")
 ;                       1 - Include records from both the V IMMUNIZATION and V IMMUNIZATION DELETED files
 ;                       0 - Only include records from the V IMMUNIZATION file.
 ;  PXLIST - A list of record numbers (IENs) to return (Optional)
 ;           To specify an IEN from the V IMMUNIZATION file, set PXLIST(IEN)=""
 ;           To specify an IEN from the V IMMUNIZATION DELETED file, set PXLIST(IEN_"D")="" (e.g., PXLIST("123D")="")
 ;  PXBEFORE - A date in FileMan format (Optional)
 ;             It is used when the caller wants to see how the records being returned changed since that date. When
 ;             populated, it is used in a number of ways:
 ;             1. Additions: If a record was added after that date, and later edited, we will
 ;                return the record as if it's a new record (i.e., TYPE="ADD") (even though it's truly an
 ;                edited record), as from that date's perspective this is a new record.
 ;             2. Edits: a) We will return two versions of an edited record. One, will
 ;                be the way the record existed on that date (i.e., TYPE="UPDATE-BEFORE"). Two, will be the
 ;                current state of the record (i.e., TYPE="UPDATE-AFTER"). b) if no significant changes have been made to this record since
 ;                that date (i.e., the record was edited after that date, but none of the fields that are returned
 ;                in this call were modified with that edit), then we will not return this record, as nothing
 ;                significant changed since that date.
 ;             3. Deletes: a) If a record was added after that date and later deleted, we won't return the record,
 ;                as on that date the record did not exist, and the current record is deleted, so nothing
 ;                really changed since that date. b) If a record was edited after that date and then deleted,
 ;                the deleted record will be returned the way it existed on that date, as from that date's perspective
 ;                that is what the deleted record looked like.
 ;     PXDEM - Return patient demographics? (1=Yes/0=No) (Defaults to "1").
 ;
 ; Currently only JSON is supported.
 ;            PXFORMAT - In what format to return the data "JSON"/"DELIMITED". (Defaults to "JSON")
 ;
 ;Returns:
 ;  Each item returned will contain an immunization object, and if demographics are requested, a patient object.
 ;
 ;  The immunization object can be called: IMM-ADD, IMM-DELETE, IMM-UPDATE, IMM-UPDATE-BEFORE, or IMM-UPDATE-AFTER.
 ;     IMM-ADD - Used when the immunization record is a "new" record.
 ;     IMM-DELETE - Used when the immunizatin record is a deleted record.
 ;     IMM-UPDATE - Used wehn the immunizatin record was edited (and the caller did not pass in a date).
 ;     IMM-UPDATE-BEFORE/IMM-UPDATE-AFTER - Used when the immunizatin record was edited and the called passed in a date.
 ;          Two objects will be returned. The IMM-UPDATE-BEFORE object will be the way the record existed before that date,
 ;          and the IMM-UPDATE-AFTER will be the current state of the record.
 ;
 ;  For more details on the fields and attributes of the immunization and patient objects, please see the documentation.
 ;
 N DFN,PXBOOKMARK,PXBYLIST,PXCNT,PXDATASRC,PXERRCNT,PXEXDS,PXFILE,PXI,PXINCDEL,PXMAX,PXNEWBOOKMARK,PXSTART,PXSTOP,PXTIME,PXVIMM,PXX
 N PXFORMAT  ; currently, only JSON is supported. But in the future, perhaps change this to a paramater and also support other formats.
 ;
 S PXRSLT=$NA(^TMP("PXVRPC7-R",$J))
 K ^TMP("PXVRPC7",$J),^TMP("PXVRPC7-R",$J)
 ;
 I $G(PXFORMAT)'?1(1"JSON",1"DELIMITED") S PXFORMAT="JSON"
 I $G(PXDEM)'?1(1"0",1"1") S PXDEM=1
 S PXBEFORE=$G(PXBEFORE)
 ;
 S PXCNT=0
 S PXERRCNT=0
 ;
 S PXBYLIST=0
 I $O(PXLIST(""))'="" S PXBYLIST=1
 ;
 S PXBEFORE=$G(PXBEFORE)
 ;
 S PXI=""
 I PXBYLIST F  S PXI=$O(PXLIST(PXI)) Q:PXI=""  D
 . S PXVIMM=+PXI
 . I 'PXVIMM D  Q
 . . S PXERRCNT=PXERRCNT+1
 . . S ^TMP("PXVRPC7",$J,"ERRORS",PXERRCNT)="Record with IEN #"_PXI_" does not exist."
 . S PXFILE=$E(PXI,$L(PXI))
 . S PXFILE=$S(PXFILE="D":9000080.11,1:9000010.11)
 . I PXFILE=9000010.11,'$D(^AUPNVIMM(PXVIMM,0)) D  Q
 . . S PXERRCNT=PXERRCNT+1
 . . S ^TMP("PXVRPC7",$J,"ERRORS",PXERRCNT)="Record with IEN #"_PXI_" does not exist."
 . I PXFILE=9000080.11,'$D(^AUPDVIMM(PXVIMM,0)) D  Q
 . . S PXERRCNT=PXERRCNT+1
 . . S ^TMP("PXVRPC7",$J,"ERRORS",PXERRCNT)="Record with IEN #"_PXI_" does not exist."
 . I '$$GETREC("PXVRPC7",.PXCNT,PXVIMM,PXFILE,$G(PXDEM),$G(PXBEFORE)) D
 . . S PXERRCNT=PXERRCNT+1
 . . S ^TMP("PXVRPC7",$J,"ERRORS",PXERRCNT)="Unable to return record with IEN #"_PXI_"."
 ;
 I 'PXBYLIST D
 . ;S DFN=$G(PXFILTER("DFN"))
 . S PXSTART=$G(PXFILTER("START"))
 . I PXSTART="" S PXSTART=$$FMADD^XLFDT(DT,-1)
 . S PXSTOP=$G(PXFILTER("STOP"))
 . I PXSTOP="" S PXSTOP=$$FMADD^XLFDT(DT,-1)
 . I PXSTART,PXSTOP,PXSTOP<PXSTART D
 . . S PXX=PXSTART,PXSTART=PXSTOP,PXSTOP=PXX
 . I PXSTOP,$P(PXSTOP,".",2)="" S PXSTOP=PXSTOP_".24"
 . S PXEXDS=$G(PXFILTER("DATA SRC EXC"))
 . F PXX=1:1:99 S PXDATASRC=$P(PXEXDS,";",PXX) Q:PXDATASRC=""  S PXEXDS(+$O(^PX(839.7,"B",PXDATASRC,0)))=""
 . S PXMAX=+$G(PXFILTER("MAX"))
 . I PXMAX'>0 S PXMAX=99
 . S PXBOOKMARK=$G(PXFILTER("BOOKMARK"))
 . S PXINCDEL=$G(PXFILTER("INC DELETE"))
 . I PXINCDEL'?1(1"0",1"1") S PXINCDEL=1
 . ;
 . S PXTIME=PXSTART-.000000001
 . I PXBOOKMARK'="" S PXTIME=$P(PXBOOKMARK,U,1)
 . I $P(PXBOOKMARK,U,3)'="D" F  S PXTIME=$O(^AUPNVIMM("AT",PXTIME)) Q:('PXTIME)!(PXTIME>PXSTOP)!(PXCNT'<PXMAX)  D
 . . S PXVIMM=0
 . . I PXBOOKMARK'="" S PXVIMM=$P(PXBOOKMARK,U,2) S PXBOOKMARK=""
 . . F  S PXVIMM=$O(^AUPNVIMM("AT",PXTIME,PXVIMM)) Q:('PXVIMM)!(PXCNT'<PXMAX)  D
 . . . S PXNEWBOOKMARK=PXTIME_U_PXVIMM
 . . . I '$D(^AUPNVIMM(PXVIMM,0)) Q
 . . . S PXDATASRC=$P($G(^AUPNVIMM(PXVIMM,812)),U,3)
 . . . I $D(PXEXDS(+PXDATASRC)) Q
 . . . S PXX=$$GETREC("PXVRPC7",.PXCNT,PXVIMM,9000010.11,$G(PXDEM),$G(PXBEFORE))
 . ;
 . ; SEARCH DELETED FILE
 . S PXTIME=PXSTART-.000000001
 . I $P(PXBOOKMARK,U,3)="D" S PXTIME=$P(PXBOOKMARK,U,1)
 . I PXINCDEL F  S PXTIME=$O(^AUPDVIMM("DD",PXTIME)) Q:('PXTIME)!(PXTIME>PXSTOP)!(PXCNT'<PXMAX)  D
 . . S PXVIMM=0
 . . I $P(PXBOOKMARK,U,3)="D" S PXVIMM=$P(PXBOOKMARK,U,2) S PXBOOKMARK=""
 . . F  S PXVIMM=$O(^AUPDVIMM("DD",PXTIME,PXVIMM)) Q:('PXVIMM)!(PXCNT'<PXMAX)  D
 . . . S PXNEWBOOKMARK=PXTIME_U_PXVIMM_U_"D"
 . . . I '$D(^AUPDVIMM(PXVIMM,0)) Q
 . . . ;if record was added after PXBEFORE, don't include this record
 . . . I PXBEFORE,$P($G(^AUPDVIMM(PXVIMM,12)),U,5)>PXBEFORE Q
 . . . S PXDATASRC=$P($G(^AUPDVIMM(PXVIMM,812)),U,3)
 . . . I $D(PXEXDS(+PXDATASRC)) Q
 . . . S PXX=$$GETREC("PXVRPC7",.PXCNT,PXVIMM,9000080.11,$G(PXDEM),$G(PXBEFORE))
 ;
 S ^TMP("PXVRPC7",$J,"FACILITY ID")=$$STA^XUAF4($$KSP^XUPARAM("INST"))
 S ^TMP("PXVRPC7",$J,"TOTAL ITEMS")=PXCNT
 I 'PXBYLIST S ^TMP("PXVRPC7",$J,"BOOKMARK")=$G(PXNEWBOOKMARK)
 ;
 I $G(PXFORMAT)="JSON" D JSON("PXVRPC7")
 ;
 K ^TMP("PXVRPC7",$J)
 ;
 Q
 ;
JSON(PXSUB) ; return data in JSON format
 ;
 N PXATT,PXCAT,PXCNT,PXCNT2,PXCODE,PXCODES,PXCODESYS,PXFLD,PXFLDS,PXFLDSUB,PXGBL,PXNODE,PXPIECE,PXSUBTMP,PXTEMP,PXVAL
 ;
 S PXFLDS("IMM","PATIENT")="IEN^NAME"
 S PXFLDS("IMM","ORDERING PROVIDER")="IEN^NAME^NPI^VPID"
 S PXFLDS("IMM","ENCOUNTER PROVIDER")="IEN^NAME^NPI^VPID"
 S PXFLDS("IMM","DOCUMENTER")="IEN^NAME^NPI^VPID"
 S PXFLDS("IMM","LOT NUMBER")="IEN^NAME"
 S PXFLDS("IMM","MANUFACTURER")="IEN^NAME^MVX CODE"
 S PXFLDS("IMM","INFO SOURCE")="IEN^HL7 CODE^NAME"
 S PXFLDS("IMM","ADMIN ROUTE")="IEN^HL7 CODE^NAME"
 S PXFLDS("IMM","ADMIN SITE")="IEN^HL7 CODE^NAME"
 S PXFLDS("IMM","IMMUNIZATION")="IEN^NAME"
 S PXFLDS("IMM","DATA SOURCE")="IEN^NAME"
 S PXFLDS("IMM","FACILITY")="NAME^STATION NUMBER"
 S PXFLDS("IMM","LOCATION")="IEN^NAME"
 S PXFLDS("IMM","VIS OFFERED")="IEN^DATE OFFERED^NAME^EDITION DATE^LANGUAGE"
 S PXFLDS("PAT","ETHNICITY")="HL7 CODE^NAME"
 S PXFLDS("PAT","RACE")="HL7 CODE^NAME"
 S PXFLDS("PAT","ADDRESS")="STREET 1^STREET 2^STREET 3^CITY^STATE^ZIP"
 S PXFLDS("PAT","SUPPORT")="TYPE^NAME^RELATIONSHIP^PHONE^STREET 1^STREET 2^STREET 3^CITY^STATE^ZIP"
 S PXFLDS("PAT","PLACE OF BIRTH")="CITY^STATE"
 S PXFLDS("PAT","FACILITY")="NAME^STATION NUMBER"
 ;
 S PXSUBTMP="PXVRPC7-TMP"
 K ^TMP(PXSUBTMP,$J)
 ;
 S PXGBL=$NA(^TMP(PXSUB,$J))
 F  S PXGBL=$Q(@PXGBL) Q:PXGBL=""  Q:($QS(PXGBL,1)'=PXSUB)!($QS(PXGBL,2)'=$J)  D
 . I $QS(PXGBL,3)'="ITEMS" D  Q
 . . M ^TMP(PXSUBTMP,$J,$QS(PXGBL,3))=^TMP(PXSUB,$J,$QS(PXGBL,3))
 . S PXCNT=$QS(PXGBL,4)
 . S PXCAT=$QS(PXGBL,5)
 . S PXFLD=$QS(PXGBL,6)
 . S PXFLDSUB=$S(PXCAT="PATIENT":"PAT",1:"IMM")
 . ;
 . I PXFLDSUB="IMM",PXFLD="CODES" D  Q
 . . S PXCODESYS=$QS(PXGBL,7)
 . . S PXCODES=@PXGBL
 . . K @PXGBL
 . . F PXPIECE=1:1:99 S PXCODE=$P(PXCODES,U,PXPIECE) Q:PXCODE=""  D
 . . . S ^TMP(PXSUBTMP,$J,"ITEMS",PXCNT,PXCAT,"CODING SYSTEM",PXCODESYS,PXPIECE)=PXCODE
 . ;
 . I PXFLDSUB="IMM",PXFLD="VACCINE GROUP" D  Q
 . . S PXCNT2=$QS(PXGBL,7)
 . . S ^TMP(PXSUBTMP,$J,"ITEMS",PXCNT,PXCAT,"VACCINE GROUPS",PXCNT2)=@PXGBL
 . ;
 . S PXVAL=$G(PXFLDS(PXFLDSUB,PXFLD))
 . I PXVAL="" D  Q
 . . S ^TMP(PXSUBTMP,$J,"ITEMS",PXCNT,PXCAT,PXFLD)=@PXGBL
 . S PXTEMP=@PXGBL
 . K @PXGBL
 . S PXCNT2=$QS(PXGBL,7)
 . S PXNODE=$NA(^TMP(PXSUBTMP,$J,"ITEMS",PXCNT,PXCAT,PXFLD))
 . F PXPIECE=1:1:99 S PXATT=$P(PXVAL,U,PXPIECE) Q:PXATT=""  D
 . . I PXCNT2>0 S @PXNODE@(PXCNT2,PXATT)=$P(PXTEMP,U,PXPIECE)
 . . I PXCNT2'>0 S @PXNODE@(PXATT)=$P(PXTEMP,U,PXPIECE)
 ;
 D ENCODE^VPRJSON("^TMP("""_PXSUBTMP_""",$J)","^TMP("""_PXSUB_"-R"",$J)")  ;ICR 6411
 ;
 K ^TMP(PXSUBTMP,$J)
 ;
 Q
 ;
GETREC(PXSUB,PXCNT,PXVIMM,PXFILE,PXGETDEM,PXDATE) ; get one record and add it to ^TMP
 ;
 N DFN,PXADDDT,PXEDITED,PXIMMNODE,PXPATARR,PXRSLT,PXTYPE,PXVALID,PXVIMMARR
 ;
 ;shold we return this record as an add, update, or delete
 S PXTYPE=$S(PXFILE=9000080.11:"D",1:"A")
 I PXFILE=9000010.11 D
 . S PXADDDT=$P($G(^AUPNVIMM(PXVIMM,12)),U,5)
 . ;if record as added after PXDATE, treat it as an A, even if it was editted
 . I PXDATE,PXADDDT>PXDATE Q
 . S PXEDITED=$P($G(^AUPNVIMM(PXVIMM,801)),U,1)
 . I PXEDITED=1 S PXTYPE="U"  ; EDITED FLAG
 ;
 ; For updates, when PXDATE is defined, send before/after
 I PXTYPE="U",PXDATE S PXTYPE="UBA"
 ;
 S PXCNT=PXCNT+1
 ;
 I PXTYPE="UBA" D
 . D VIMM^PXVRPC7A(.PXVIMMARR,PXVIMM,PXFILE,PXDATE)
 . I '$$VALIDATE(.PXVIMMARR) D  Q
 . . S PXTYPE="A"
 . M ^TMP(PXSUB,$J,"ITEMS",PXCNT,"IMM-UPDATE-BEFORE")=PXVIMMARR
 ;
 S PXIMMNODE=$S(PXTYPE="A":"IMM-ADD",PXTYPE="D":"IMM-DELETE",PXTYPE="U":"IMM-UPDATE",1:"IMM-UPDATE-AFTER")
 ;for IMM-ADD and IMM-UPDATE-AFTER, we want to get the current state of the record.
 I PXTYPE'="D" S PXDATE=""
 S PXRSLT=$NA(^TMP(PXSUB,$J,"ITEMS",PXCNT,PXIMMNODE))
 K PXVIMMARR
 D VIMM^PXVRPC7A(.PXVIMMARR,PXVIMM,PXFILE,PXDATE)
 S PXVALID=$$VALIDATE(.PXVIMMARR)
 I 'PXVALID,PXTYPE="UBA",$D(^TMP(PXSUB,$J,"ITEMS",PXCNT,"IMM-UPDATE-BEFORE")) D
 . S PXTYPE="D"
 . S PXIMMNODE="IMM-DELETE"
 . M ^TMP(PXSUB,$J,"ITEMS",PXCNT,PXIMMNODE)=^TMP(PXSUB,$J,"ITEMS",PXCNT,"IMM-UPDATE-BEFORE")
 . K ^TMP(PXSUB,$J,"ITEMS",PXCNT,"IMM-UPDATE-BEFORE")
 ;
 I PXVALID M ^TMP(PXSUB,$J,"ITEMS",PXCNT,PXIMMNODE)=PXVIMMARR
 I '$D(^TMP(PXSUB,$J,"ITEMS",PXCNT)) D  Q 0
 . S PXCNT=PXCNT-1
 ;
 ; for edits, compare before/after. if nothing changed, don't include this record.
 I PXTYPE="UBA",$$COMPARE(PXSUB,PXCNT,"IMM-UPDATE-BEFORE","IMM-UPDATE-AFTER") D  Q 0
 . K ^TMP(PXSUB,$J,"ITEMS",PXCNT)
 . S PXCNT=PXCNT-1
 ;
 S DFN=+$G(^TMP(PXSUB,$J,"ITEMS",PXCNT,PXIMMNODE,"PATIENT"))
 I DFN,$G(PXGETDEM) D
 . ;K ^TMP(PXSUB,$J,PXCNT,PXIMMNODE,"PATIENT")
 . D DEM^PXVRPC7A(.PXPATARR,DFN)
 . M ^TMP(PXSUB,$J,"ITEMS",PXCNT,"PATIENT")=PXPATARR
 Q 1
 ;
VALIDATE(PXVIMMARR) ;validate immun record has minimum fields populated
 I '$G(PXVIMMARR("PATIENT")) Q 0
 I '$D(^DPT(+PXVIMMARR("PATIENT"),0)) Q 0
 I '$G(PXVIMMARR("ADMINISTERED DATE TIME")) Q 0
 I '$G(PXVIMMARR("IMMUNIZATION")) Q 0
 Q 1
 ;
COMPARE(PXSUB,PXCNT,PXSUB1,PXSUB2) ;
 ; Compare the two arryas (PXSUB1 and PXSUB2).
 ; Returns 1 - If they are equal
 ;         0 - if they are not equal
 ;
 N PXGBL,PXGBL2,PXNUM,PXRSLT,PXX
 ;
 S PXRSLT=1
 ;
 S PXGBL=$NA(^TMP(PXSUB,$J,"ITEMS",PXCNT,PXSUB1))
 F  S PXGBL=$Q(@PXGBL) Q:(PXGBL="")!('PXRSLT)  Q:($QS(PXGBL,1)'=PXSUB)!($QS(PXGBL,2)'=$J)!($QS(PXGBL,3)'="ITEMS")!($QS(PXGBL,4)'=PXCNT)!($QS(PXGBL,5)'=PXSUB1)  D
 . S PXGBL2="^TMP("
 . S PXNUM=$QL(PXGBL)
 . F PXX=1:1:PXNUM D
 . . I PXX=5 D  Q
 . . . S PXGBL2=PXGBL2_","""_PXSUB2_""""
 . . S PXGBL2=PXGBL2_$S(PXX=1:"",1:",")_""""_$QS(PXGBL,PXX)_""""
 . S PXGBL2=PXGBL2_")"
 . I $G(@PXGBL)'=$G(@PXGBL2) S PXRSLT=0
 ;
 Q PXRSLT
 ;
