HMPDJ01 ;SLC/MKB,ASMR/MBS -- Orders ;Apr 15, 2016 09:18:55
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;Sep 01, 2011;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          ICR
 ; -------------------          -----
 ; ^DPT                         10035
 ; ^OR(100                       5771
 ; ^ORA(102.4                    5769
 ; ^ORD(100.98                    873
 ; ^PXRMINDX                     4290
 ; ^RADPT                        2480
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DIC                           2051
 ; DIQ                           2056
 ; GMRCGUIB                      2980
 ; LR7OU1                        2955
 ; ORQ1,^TMP("ORR"               3154
 ; ORQ12,^TMP("ORR"              5704
 ; ORX8                          2467
 ; PSS51P1                       4546
 ;
 ; All tags expect DFN, ID, [HMPSTART, HMPSTOP, HMPMAX, HMPTEXT]
 Q
 ;
OR1(ID) ; -- order ID >> ^TMP("ORR",$J,ORLIST,HMPN)
 N ORDER,CHILD,HMPC
 D ORX(ID,.ORDER)
 ;DE2818, ^OR(100) - ICR 5771
 S HMPC=0 F  S HMPC=$O(^OR(100,ID,2,HMPC)) Q:HMPC<1  D
 . K CHILD D ORX(HMPC,.CHILD)
 . M ORDER("children",HMPC)=CHILD
 S ORDER("lastUpdateTime")=$$EN^HMPSTMP("order") ;RHL 20141231
 S ORDER("stampTime")=ORDER("lastUpdateTime") ; RHL 20141231
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("order",ORDER("uid"),ORDER("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("ORDER","order")
 Q
ORX(IFN,ORD) ; -- extract order IFN into ORD("attribute")
 N DA,HDFN,I,LOC,ORDSTAT,ORLIST,ORLST,X,X0,X8
 S ORLST=$S(+$G(HMPN):HMPN-1,1:0) S:'$D(ORLIST) ORLIST=$H
 D GET^ORQ12(IFN,ORLIST,1)  ; this modifies ^TMP("ORR",$J)
 S X0=$G(^TMP("ORR",$J,ORLIST,ORLST))
 N $ES,$ET,ERRPAT,ERRMSG
 S $ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 S ERRMSG="A problem occurred converting record "_IFN_" for the orders domain"
 ;
 S ORD("localId")=IFN,ORD("uid")=$$SETUID^HMPUTILS("order",DFN,IFN)
 S X=$$OI^ORX8(+X0) I $L(X) D
 . N ARRAY,NAME
 . S ARRAY("Code")=1_U_"oi",ARRAY("Name")=2,ARRAY("PackageRef")=3
 . D SPLITVAL^HMPUTILS(X,.ARRAY) S ORD("name")=ARRAY("Name")
 . S NAME="" F  S NAME=$O(ARRAY(NAME)) Q:NAME=""  S ORD("oi"_NAME)=$G(ARRAY(NAME))
 S ORD("displayGroup")=$P(X0,U,2)
 S ORD("entered")=$$JSONDT^HMPUTILS($P(X0,U,3))
 S ORD("start")=$$JSONDT^HMPUTILS($P(X0,U,4)),ORD("stop")=$$JSONDT^HMPUTILS($P(X0,U,5))  ;US10045, DE3054
 S ORD("statusCode")="urn:va:order-status:"_$P(X0,U,7)
 S ORD("statusName")=$P(X0,U,6)
 S ORD("statusVuid")="urn:va:vuid:"_$$STS^HMPDOR($P(X0,U,7))
 D SETTEXT^HMPUTILS($NA(^TMP("ORR",$J,ORLIST,ORLST,"TX")),$NA(^TMP("HMPTEXT",$J,IFN)))
 M ORD("content","\")=^TMP("HMPTEXT",$J,IFN)
 ; DE3504 - Jan 18, 2016, added the code for US10045 below
 ; US10045 - PB Dec 7, 2015 if ORDER is saved, signed, discontinued, then ORDER is unsigned
 S HDFN=+$P($G(^OR(100,+IFN,0)),U,2)
 S ORDSTAT=$$ORDACT(HDFN,+IFN) I ORDSTAT="DC" D
 . ; DE3777 - March 15, 2016 - Modified the statusName to "UNRELEASED" for the  order to match the status
 . ;  that appears in CPRS if the ORDER was DISCONTINUED and is UNSIGNED
 . N HDC,HDCRSN,HMPORACT,HPTR,HSIGN
 . S HDC=$O(^OR(100,IFN,8,"C","DC","")),HSIGN="" Q:'(HDC>0)
 . S HMPORACT=$G(^OR(100,IFN,8,HDC,0))
 . ; The 15th piece of HMPORACT is the RELEASE STATUS - '11' FOR unreleased
 . I $P(HMPORACT,U,15)=11 S ORD("statusName")="UNRELEASED",ORD("statusCode")="urn:va:order-status:unr"
 . S:$P($G(HMPORACT),U,4)=2 HSIGN="*UNSIGNED*"
 . S HPTR=+$P($G(^OR(100,IFN,6)),U,4),HDCRSN=$P($G(^ORD(100.03,HPTR,0)),U)  ;Combined fixes Mar 16, 2016 DE3777 CK - PB - DE4027
 . I $L(HDCRSN) S ORD("content","\",2)=" <"_$G(HDCRSN)_"> "_HSIGN  ; add DC order not signed in JSON object
 . ; DE3777 - end of changes
 ;
 S X=$$GET1^DIQ(100,IFN_",",1,"I") I X D
 . S ORD("providerUid")=$$SETUID^HMPUTILS("user",,+X)
 . S ORD("providerName")=$$GET1^DIQ(200,X_",",.01)  ;DE2818, ICR 10060
 S LOC=+$$GET1^DIQ(100,IFN_",",6,"I"),FAC=$$FAC^HMPD(LOC) I LOC D
 . S ORD("locationName")=$$GET1^DIQ(44,LOC_",",.01)  ;DE2818, ICR 10040
 . S ORD("locationUid")=$$SETUID^HMPUTILS("location",,LOC)
 D FACILITY^HMPUTILS(FAC,"ORD")
 S ORD("service")=$$GET1^DIQ(100,IFN_",","12:1")
 S X=$$GET1^DIQ(100,IFN_",",9,"I") S:X ORD("predecessor")=$$SETUID^HMPUTILS("order",DFN,+X)
 S X=$$GET1^DIQ(100,IFN_",",9.1,"I") S:X ORD("successor")=$$SETUID^HMPUTILS("order",DFN,+X)
 D RESULTS
 ; US11945 - Get parent and child orders for order
 D KIN
 ; sign/verify
 ;US10045 modifications to get signed, verified and reviewed datetime stamp from HMP(800000
 N C,HMUSR,HMORIN,HMPFND,HMPUF,HMSRVR,HPROV,HX8,ORFLG,ORIFN,ORIN ; US11894 Dec 18, 2015 - added variables used by Order Flag and Unflag
 D  ; US11894 Dec 18, 2015 - Order flagged and unflagged added to JSON
 . S C=0,HMORIN=0  ; C = count for JSON object, HMORIN = IEN in sub-file
 . S HMSRVR=$$SRVRNO^HMPOR(HDFN) Q:'HMSRVR  ; if 'HMSRVR then not subscribed
 . ; DE3584 Feb 1, 2016 - begin
 . I '$D(^HMP(800000,HMSRVR,1,HDFN,1,IFN)) D  ; orders not in HMP(800000) add them
 ..  N HMVALS,RSLT  ; HMVALS = fields to update in 800000.14
 ..  D ORDRVALS^HMPOR(.HMVALS,IFN)  ; get fields from ORDER file and map to HMP fields
 ..  Q:'$O(HMVALS(0))  ; error setting up fields, HMVALS("ERR") will be defined
 ..  S HMVALS(1.01)=$$NOW^XLFDT  ; (#1.01) TRACKING START
 ..  D ADDORDR^HMPOR(.RSLT,.HMVALS,IFN,HDFN)  ; may want to log error if RSLT<0
 . ; DE3584 Feb 1, 2016 - end
 . F  S HMORIN=$O(^HMP(800000,HMSRVR,1,HDFN,1,IFN,2,HMORIN)) Q:'HMORIN  D
 ..  S C=C+1,HMPFND=$G(^HMP(800000,HMSRVR,1,HDFN,1,IFN,2,HMORIN,0))
 ..  S HMPUF=$P(HMPFND,U,2),HMPUF=$S(HMPUF="U":"Unflagged",1:"Flagged")
 ..  S ORD("orderFlags",C,"order"_HMPUF_"DateTime")=$$JSONDT^HMPUTILS($P(HMPFND,U))
 ..  S HMUSR=$P(HMPFND,U,3)
 ..  S ORD("orderFlags",C,"order"_HMPUF_"By")=$$GET1^DIQ(200,HMUSR_",",.01,"E")
 ..  S ORD("orderFlags",C,"order"_HMPUF_"Reason")=$P(HMPFND,U,4)
 ;
 I $D(^HMP(800000,HMSRVR,1,HDFN,1,IFN)) D  Q  ; check for existence of order in ^HMP(800000)
 . S I=0,HX8=$G(^HMP(800000,HMSRVR,1,HDFN,1,IFN,0)),HPROV=$P(HX8,U,3)
 . I HPROV'="" D USER(.I,"S",HPROV,$P(HX8,U,4))  ; get signed date/time
 . I $P(HX8,U,6) D USER(.I,"N",$P(HX8,U,5),$P(HX8,U,6))  ; order verified by a nurse get the timestamp
 . I $P(HX8,U,8) D USER(.I,"C",$P(HX8,U,7),$P(HX8,U,8))  ; order was verified by a clerk get the timestamp
 . I $P(HX8,U,10) D USER(.I,"R",$P(HX8,U,9),$P(HX8,U,10))  ;order was reviewed get the timestamp
 ;
 ; DE3504 - Jan 18, 2016, go to ORDER file to get data
 N ORACTION
 S (ORACTION,I)=0
 F  S ORACTION=$O(^OR(100,IFN,8,ORACTION)) Q:'ORACTION  D
 . S HX8=$G(^OR(100,IFN,8,ORACTION,0)) I $P(HX8,U,6) D  ; only if order is signed
 .. S HPROV=$P(HX8,U,5) S:HPROV<1 HPROV=$P(HX8,U,3)  ; signed by or provider
 .. D USER(.I,"S",HPROV,$P(HX8,U,6))  ; date/time signed
 .. I $P(HX8,U,9)  D USER(.I,"N",$P(HX8,U,8),$P(HX8,U,9))   ; verifying nurse and date/time
 .. I $P(HX8,U,11) D USER(.I,"C",$P(HX8,U,10),$P(HX8,U,11)) ; verifying clerk and date/time
 .. I $P(HX8,U,19) D USER(.I,"R",$P(HX8,U,18),$P(HX8,U,19)) ; chart reviewed by and date/time
 ;
 Q
 ;
KIN ; US11945 - Add parents/children (kin) to order
 N HMPNOJS,HMPORKIN,I
 S HMPNOJS=1 D RELATED^HMPORRPC(.HMPORKIN,IFN)
 S:$D(@HMPORKIN@("parent")) ORD("parentOrderUid")=$$SETUID^HMPUTILS("order",DFN,+@HMPORKIN@("parent"))
 S I="" F  S I=$O(@HMPORKIN@("children",I)) Q:I=""  D
 . S ORD("childrenOrderUids",I)=$$SETUID^HMPUTILS("order",DFN,+@HMPORKIN@("children",I))
 Q
RESULTS ; -- add ORD("results",n,"uid") list
 N ORPK,ORPKG,ORDG
 S ORPK=$G(^OR(100,IFN,4)),ORPKG=ORD("service"),ORDG=ORD("displayGroup")
 I ORPKG="GMRC" D  Q
 . N HMPD,I,N,X D DOCLIST^GMRCGUIB(.HMPD,+ORPK)  ; HMPD contains global references
 . S N=1,ORD("results",N,"uid")=$$SETUID^HMPUTILS("consult",DFN,+ORPK)
 . S I=0 F  S I=$O(HMPD(50,I)) Q:I<1  S X=$G(HMPD(50,I)) D
 .. Q:'$D(@(U_$P(X,";",2)_+X_")"))  ;text deleted
 .. S N=N+1,ORD("results",N,"uid")=$$SETUID^HMPUTILS("document",DFN,+X)
 . Q:ORDG'="PROC"
 . N HMPC D FIND^DIC(702,,"@","Q",+ORPK,,"ACON",,,"HMPC") ;CP
 . S I=0 F  S I=$O(HMPC("DILIST",2,I)) Q:I<1  D
 .. S X=+$G(HMPC("DILIST",2,I))_";MDD(702,"
 .. S N=N+1,ORD("results",N,"uid")=$$SETUID^HMPUTILS("procedure",DFN,X)
 I ORPKG="LR" D  Q
 . Q:$L(ORPK,";")'>3  ;no results yet, or parent order
 . N SUB,IDT,CDT,ITM,HMPT,ID,T,N,LRDFN,IDX
 . S SUB=$P(ORPK,";",4),IDT=$P(ORPK,";",5),CDT=9999999-IDT
 . I SUB="CH" D  Q
 .. S ITM=+$G(ORD("oiPackageRef")) D EXPAND^LR7OU1(ITM,.HMPT)
 .. S (T,N)=0 F  S T=$O(HMPT(T)) Q:T<1  S ID=$O(^PXRMINDX(63,"PI",DFN,T,CDT,"")) I $L(ID) S N=N+1,ORD("results",N,"uid")=$$SETUID^HMPUTILS("lab",DFN,$P(ID,";",2,9))
 . I SUB="MI" D  Q
 .. S ITM="M;A;",N=0,LRDFN=$$LRDFN^HMPXGLAB(DFN)  ;DE2818
 .. F  S ITM=$O(^PXRMINDX(63,"PI",DFN,ITM)) Q:$E(ITM,1,4)'="M;A;"  I $D(^(ITM,CDT)) D
 ... S IDX=LRDFN_";MI;"_IDT
 ... F  S IDX=$O(^PXRMINDX(63,"PI",DFN,ITM,CDT,IDX)) Q:IDX=""  S ID=$P(IDX,";",2,99),N=N+1,ORD("results",N,"uid")=$$SETUID^HMPUTILS("lab",DFN,ID)
 .. S N=N+1,ORD("results",N,"uid")=$$SETUID^HMPUTILS("document",DFN,SUB_";"_IDT)
 . ; SUB:"AP" [AU,CY,EM,SP]
 . S ORD("results",1,"uid")=$$SETUID^HMPUTILS("lab",DFN,SUB_";"_IDT)
 . S ORD("results",2,"uid")=$$SETUID^HMPUTILS("document",DFN,SUB_";"_IDT)
 I ORPKG["PS" D  Q
 . S:ORPK ORD("results",1,"uid")=$$SETUID^HMPUTILS("med",DFN,IFN)
 I ORPKG="RA" D  Q
 . N IDT,CN S IDT=+$O(^RADPT("AO",+ORPK,DFN,0)) Q:'IDT
 . S CN=0 F  S CN=$O(^RADPT("AO",+ORPK,DFN,IDT,CN)) Q:CN<1  S ORD("results",CN,"uid")=$$SETUID^HMPUTILS("image",DFN,IDT_"-"_CN)
 ; rest should be generic (OR) orders
 I ORDG="NTX" S ORD("results",1,"uid")=$$SETUID^HMPUTILS("treatment",DFN,IFN) Q
 I ORDG="V/M" Q  ;no link
 Q
 ;
NTX1(IFN) ; -- extract nursing treatment order IFN into NTX("attribute")
 N NTX,X
 D ORX(IFN,.NTX) ;get basic order info
 S NTX("orderUid")=NTX("uid")
 S NTX("uid")=$$SETUID^HMPUTILS("treatment",DFN,IFN)
 S X=$$VALUE^ORX8(IFN,"COMMENT") S:$L(X) NTX("instructions")=X
 S X=$$VALUE^ORX8(IFN,"SCHEDULE") I X D
 . D ZERO^PSS51P1(X,,,,"HMPS")
 . S NTX("scheduleName")=$G(^TMP($J,"HMPS",X,.01))
 . S NTX("adminTimes")=$G(^TMP($J,"HMPS",X,1))
 . K ^TMP($J,"HMPS")
 S NTX("lastUpdateTime")=$$EN^HMPSTMP("treatment") ;RHL 20141231
 S NTX("stampTime")=NTX("lastUpdateTime") ; RHL 20141231
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("treatment",NTX("uid"),NTX("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("NTX","treatment")
 Q
 ;
USER(N,ROLE,IEN,DATE) ; -- add signature/verification data
 S N=+$G(N)+1
 S ORD("clinicians",N,"signedDateTime")=$$JSONDT^HMPUTILS(DATE)
 S ORD("clinicians",N,"role")=$G(ROLE)
 Q:+$G(IEN)<1
 S ORD("clinicians",N,"uid")=$$SETUID^HMPUTILS("user",,IEN)
 S ORD("clinicians",N,"name")=$$GET1^DIQ(200,IEN_",",.01)  ;DE2818, ICR 10060
 Q
 ;
ORDACT(HMPDFN,ORDRNUM) ; function, if patient and order are in HMP(800000) return status code, Jan 10, 2016 US10045, US11894
 N SRV S SRV=$$SRVRNO^HMPOR(HMPDFN)  ; server number for patient
 Q:'(SRV>0) ""  ; not found, return null
 Q $P($G(^HMP(800000,SRV,1,HMPDFN,1,ORDRNUM,0)),U,14)  ; ORDER ACTION returned
 ;
TM(X) ; -- strip seconds off a FM time
 N D,T,Y S D=$P(X,"."),T=$P(X,".",2)
 S Y=D_$S(T:"."_$E(T,1,4),1:"")
 S Y=$$JSONDT^HMPUTILS(Y)
 Q Y
 ;
