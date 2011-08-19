OOPSGUIS ;WIOFO/LLH-RPC Broker calls for GUI ;03/25/04
 ;;2.0;ASISTS;**8,11**;Jun 03, 2002
 ;
STA(RESULTS) ; Get listing of Stations from Edit Site Parameter
 ;
 ; Output:  RESULTS contains a listing or all stations listed in the
 ;          Edit Site Parameter file.  This list will be used for
 ;          selecting a station from any field that expects an entry
 ;          from the Institution file.  If no stations exist, then
 ;          a call will automatically be made to GETINST^OOPSGUI7
 ;          to use the rpc to get all the stations.
 ;
 N ARR,CN,FAC,IFLAG,SNAME,SNUM,SP,STA,VAL
 K ^TMP("OOPSINST",$J)
 S (CN,SP)=0
 F  S SP=$O(^OOPS(2262,SP)) Q:SP=""  S STA=0 D
 .F  S STA=$O(^OOPS(2262,SP,STA)) Q:STA'>0  S IEN=0 D
 ..F  S IEN=$O(^OOPS(2262,SP,STA,IEN)) Q:IEN'>0  D
 ...S FAC=$P($G(^OOPS(2262,SP,STA,IEN,0)),U,1)
 ...I '$G(FAC) Q
 ...; have station #, now go to the institution file and get the info
 ...I $$GET1^DIQ(4,FAC,101)=1 Q           ; FAC inactive, don't get
 ...S SNAME=$$GET1^DIQ(4,FAC,.01) I $G(SNAME)="" Q
 ...S SNUM=$$GET1^DIQ(4,FAC,99)
 ...S VAL=SNAME_" = "_SNUM
 ...S CN=CN+1,^TMP("OOPSINST",$J,CN)=FAC_":"_VAL_$C(10)
 S CN=CN+1,^TMP("OOPSINST",$J,CN)="999999:All Stations"
 I CN=1 D GETINST^OOPSGUI7(.ARR) Q   ; if only entry = all get all
 S RESULTS=$NA(^TMP("OOPSINST",$J))
 Q
 ;
SIGNCA7(RESULTS,INPUT,SIGN) ; Validates Electronic Signature and creates
 ;                         validation code to ensure data not changed
 ;  Input:   INPUT - FILE^FIELD^IEN where File and Field are the file 
 ;                   and field the data is being filed into and IEN
 ;                   is the internal record number.
 ;            SIGN - the electronic signature to be encrypted
 ; Output: RESULTS - is an array containing a list of fields that did
 ;                   not pass data validation prior to applying the ES.
 ;
 N CALL,CHKSUM,IEN,ESIG,FILE,FLD,FLD48,FLD84,FLD95,FLD96,FLD97,REC,REC1
 N SIGNBLK,VALID,VER,DR,DA,DIE
 S RESULTS="SIGNED"
 S FILE=$P($G(INPUT),U),FLD=$P($G(INPUT),U,2),IEN=$P($G(INPUT),U,3)
 I '$G(IEN)!('$G(FILE))!('$G(FLD)) S RESULTS(1)="Invalid Parameters" Q
 I $G(SIGN)="" S RESULTS="No signature passed in" Q
 S CALL=$S(FLD=48:"E",FLD=84:"W",1:"")
 I CALL="" S RESULTS="Invalid field number" Q
 ; S VALID=0 D CHKFLD(IEN,CALL.VALID) I 'VALID Q
 S ESIG=$$HASH($$DECRYP^XUSRB1(SIGN))
 I $G(ESIG)=""!(ESIG'=$P($G(^VA(200,DUZ,20)),U,4)="") D  Q
 . S RESULTS="Invalid Electronic Signature"
 S SIGNBLK=$P($G(^VA(200,DUZ,20)),U,2)
 I SIGNBLK="" S RESULTS="No signature block on file" Q
 K DR S DIE="^OOPS("_FILE_",",DA=IEN
 D NOW^%DTC S DTIME=%
 I CALL="E" D
 .S REC=$G(^OOPS(FILE,IEN,0)),REC1=$G(^OOPS(FILE,IEN,"CA7S2"))
 .S CHKSUM=$$SUM(IEN_U_REC_U_REC1)
 .S FLD48=$$ENCODE(SIGNBLK,DUZ,CHKSUM),FLD96=1
 .S FLD95=$$SUM(SIGNBLK)
 .S DR="47////^S X=+DUZ;48////^S X=FLD48;49////^S X=DTIME"
 .S DR=DR_";95////^S X=FLD95;96////^S X=FLD96"
 I CALL="W" D
 .S REC=$G(^OOPS(FILE,IEN,"CA7S10")),REC1=$G(^OOPS(FILE,IEN,"CA7S13"))
 .S CHKSUM=$$SUM(IEN_U_REC_U_REC1)
 .S FLD84=$$ENCODE(SIGNBLK,DUZ,CHKSUM)
 .S FLD97=$$SUM(SIGNBLK)
 .S DR="83////^S X=+DUZ;84////^S X=FLD84;85////^S X=DTIME"
 .S DR=DR_";97////^S X=FLD97"
 D ^DIE
 I $G(Y)'="" S RESULTS="Problem filing E-Signature" Q
 ; patch 11 - send bulletin when employee signs CA7
 I CALL="E" D
 .N GRP,X0,STR
 .S X0=$P($G(^OOPS(2264,IEN,0)),U,5)
 .S STR=$G(^OOPS(2260,X0,0)) K XMY
 .S XMB(1)=$$GET1^DIQ(2260,X0,4)
 .S XMB(2)=$P(STR,U,1)
 .S XMB="OOPS EMPSIGNCA7"
 .S GRP="OOPS WCP"
 .D MFAC^OOPSMBUL
 .D ^XMB K XMB,XMY,XMM,XMDT
 Q
HASH(X) ;
 D HASH^XUSHSHP
 Q X
ENCODE(X,X1,X2) ; X=SIGN BLK, X1=DUZ, X2=CHKSUM CRITICAL FIELDS
 D EN^XUSHSHP
 Q X
DECODE(RESULTS,IEN,CALL,FORM) ;
 ; Call to return electronic signature to readable form
 ;  Input:  IEN    - internal record number of CA7 case
 ;         CALL    - call menu - either E (Employee) or W (Workers Comp)
 ;         FORM    - form - right now only expects CA7
 ; Output: RESULTS - readable electronic signature
 ;
 N FILE,NODE,REC,REC1,VAL,VALID,VER,X,X1,X2
 S RESULTS="",VALID=1
 I '$G(IEN)!($G(CALL)="")!($G(FORM)="") Q
 S (NODE,FILE,VER)=""
 I FORM="CA7" S FILE=2264
 S NODE=$S(CALL="E":"CA7S7",CALL="W":"CA7S15",1:"")
 I FILE=""!(NODE="") Q
 S VER=$P($G(^OOPS(FILE,IEN,"CA7S7")),U,5) I VER'=1 Q
 I CALL="E" D
 .S VAL=$P($G(^OOPS(FILE,IEN,"CA7S7")),U,4) I VAL="" S VALID=0
 .S REC=$G(^OOPS(FILE,IEN,0)),REC1=$G(^OOPS(FILE,IEN,"CA7S2"))
 I CALL="W" D
 .S VAL=$P($G(^OOPS(FILE,IEN,"CA7S15")),U,11) I VAL="" S VALID=0
 .S REC=$G(^OOPS(FILE,IEN,"CA7S10")),REC1=$G(^OOPS(FILE,IEN,"CA7S13"))
 ;
 I 'VALID Q
 S X=$P($G(^OOPS(FILE,IEN,NODE)),U,2) I X="" Q       ; ES VALIDATION #
 S X1=$P($G(^OOPS(FILE,IEN,NODE)),U,1)               ; USER NUMBER
 S X2=$$SUM(IEN_U_REC_U_REC1)                        ; CHECKSUM
 D DE^XUSHSHP
 ; I $$SUM(X)'=VAL S X="DECODING FAILED"
 S RESULTS=X
 Q
 ;
SUM(X) ;CALCULATE CHECKSUM VALUE FOR STRING
 N I,Y
 S Y=0 F I=1:1:$L(X) S Y=$A(X,I)*I+Y
 Q Y
CLRES(IEN,CALL,FORM) ; Clear signature from CA7, if necessary
 ;   Input:  IEN - record IEN for CA7
 ;          CALL - calling menu - either E (EMP) or W (Workers comp)
 ;          FORM - form where ES should be removed (now only CA7)
 N FILE,SIG,NODE,FIELD
 S (FILE,SIG,NODE,FIELD)="",RESULTS="FAILED"
 I ('$G(IEN)),($G(CALL)=""),($G(FORM)="") Q
 I FORM="CA7" S FILE=2264
 I FILE=2264 D
 .I CALL="E" S SIG="CA7S7;1,5"
 .I CALL="W" S SIG="CA7S15;1,3"
 S NODE=$P(SIG,";") Q:NODE="" 
 S FIELD=$P(SIG,";",2)
 I '$D(^OOPS(FILE,IEN,NODE)) Q
 F I=$P(FIELD,","):1:$P(FIELD,",",2) S $P(^OOPS(FILE,IEN,NODE),U,I)=""
 Q
GETDLOC(RESULTS,INPUT) ; Get Detail Loc for specific incident setting
 ;  Input:  INPUT - File _"^"_Station IEN from a station in the 
 ;                  site par file_"^"_rec ien from file to retrieve
 ;                  subfile information for.
 ; Output: RESULTS - listing of valid sub file data
 ;
 N CN,FIEN,FILE,I,REC,STA
 S CN=0
 S FILE=$P($G(INPUT),U,1),STA=$P($G(INPUT),U,2),FIEN=$P($G(INPUT),U,3)
 I FILE=""!(STA="")!(FIEN="") D  Q
 . S ^TMP($J,"DLOC",CN)="MISSING PARAMETERS",RESULTS=$NA(^TMP($J,"DLOC"))
 S REC=$O(^OOPS(FILE,FIEN,1,"B",STA,""))
 I '$G(REC) S ^TMP($J,"DLOC",CN)="NO DETAIL LOCATIONS LOADED",RESULTS=$NA(^TMP($J,"DLOC")) Q
 I '$D(^OOPS(FILE,"F",REC,FIEN)) D  Q
 .S ^TMP($J,"DLOC",CN)="NO DETAIL LOCATIONS LOADED",RESULTS=$NA(^TMP($J,"DLOC"))
 S DATA=""
 F  S DATA=$O(^OOPS(FILE,"F",REC,FIEN,DATA)) Q:DATA=""  S DATAIEN=0 D
 .S DATAIEN=$O(^OOPS(FILE,"F",REC,FIEN,DATA,DATAIEN))
 .S ^TMP($J,"DLOC",CN)=DATA_U_DATAIEN,CN=CN+1
 S RESULTS=$NA(^TMP($J,"DLOC"))
 Q
