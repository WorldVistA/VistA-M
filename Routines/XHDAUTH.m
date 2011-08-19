XHDAUTH ; SLC/JER - Authentication calls for HeVD ; 25 Jul 2003  9:42 AM
 ;;1.0;HEALTHEVET DESKTOP;;Jul 15, 2003
AUTHNTC(XHDY,ACCESS,VERIFY) ; authenticate user based on access/verify pair
 N XHD,UID,SPEC,COL,XHDI
 S (XHD,XHDI)=0
 S XHDY=$NA(^TMP("XHDCUID",$J)) K @XHDY
 D XMLHDR(XHDY,.XHDI)
 S UID=$$CHKAV^XUVERIFY(ACCESS_";"_VERIFY)
 I '+UID D
 . S XHDI=XHDI+1
 . S @XHDY@(XHDI)="<errorText>Invalid Access/Verify Code Pair</errorText>"
 E  D UIDTBL(XHDY,UID,.XHDI)
 D XMLFOOT(XHDY,.XHDI)
 Q
BYPASS(XHDY) ; get user demographics w/o security
 N XHD,UID,SPEC,COL,XHDI
 S (XHD,XHDI)=0,UID=$G(DUZ)
 S XHDY=$NA(^TMP("XHDCUID",$J)) K @XHDY
 D XMLHDR(XHDY,.XHDI)
 I '+UID D
 . S XHDI=XHDI+1
 . S @XHDY@(XHDI)="<errorText>Invalid Access/Verify Code Pair</errorText>"
 E  D UIDTBL(XHDY,UID,.XHDI)
 D XMLFOOT(XHDY,.XHDI)
 Q
XMLHDR(XHDY,XHDI) ; append header
 S XHDI=XHDI+1
 S @XHDY@(XHDI)="<result xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xsi:noNamespaceSchemaLocation=""AuthenticateSchema.xsd"">"
 Q
XMLFOOT(XHDY,XHDI)        ; append footer
 S XHDI=XHDI+1
 S @XHDY@(XHDI)="</result>"
 Q
UIDTBL(XHDY,UID,XHDI) ; userIdTable
 N SSN,NSDA,FNM,LNM,MI,TITLE
 S NSDA=+$G(^VA(200,UID,3.1))
 I NSDA D
 . N NSE
 . S NSE=$G(^VA(20,NSDA,1)),LNM=$P(NSE,U),FNM=$P(NSE,U,2),MI=$E($P(NSE,U,3))
 E  D
 . N NAME
 . S NAME=$$NAME^XUSER(UID)
 . S LNM=$$NAME^TIULS(NAME,"LAST"),FNM=$$NAME^TIULS(NAME,"FIRST"),MI=$$NAME^TIULS(NAME,"MI")
 S SSN=$E($P($G(^VA(200,UID,1)),U,9),6,10)
 S TITLE=$P($G(^VA(200,UID,20)),U,3)
 S XHDI=XHDI+1,@XHDY@(XHDI)="<userInfo>"
 D ADDELEM(XHDY,"uniqueId",UID,.XHDI)
 D ADDELEM(XHDY,"firstName",FNM,.XHDI)
 D ADDELEM(XHDY,"lastName",LNM,.XHDI)
 D ADDELEM(XHDY,"middleInitial",MI,.XHDI)
 D ADDELEM(XHDY,"title",TITLE,.XHDI)
 D ADDELEM(XHDY,"lastFourSSN",SSN,.XHDI)
 S XHDI=XHDI+1,@XHDY@(XHDI)="</userInfo>"
 Q
 ;
ADDELEM(XHDY,TAG,VAL,XHDI)        ; Insert an element with its value
 S XHDI=XHDI+1,@XHDY@(XHDI)="<"_TAG_$S(VAL']"":"/>",1:">"_$$ESCAPE^XHDLXM(VAL)_"</"_TAG_">")
 Q
BUILDROW(COL,RNM) ; Resolve fields for each row
 S COL(1)=$$ESCAPE^XHDLXM(RNM)
 Q
