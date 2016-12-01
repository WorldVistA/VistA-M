HMPDJ2 ;SLC/MKB,ASMR/RRB,CK - HMP Object RPCs;May 15, 2016 14:15
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1**;May 15, 2016;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
GET(HMP,FILTER) ; -- Return search results as JSON in @HMP@(n)
 ; RPC = HMP GET OBJECT
 N TYPE,HMPMAX,HMPI,HMPID,HMPERR,IEN
 S HMP=$NA(^TMP("HMP",$J)),HMPI=0 K @HMP
 ;
 ; parse & validate input parameters
 S TYPE=$G(FILTER("collection")),TYPE=$$LOW^XLFSTR(TYPE)
 S HMPMAX=+$G(FILTER("max"),9999) ;??
 S HMPID=$G(FILTER("id"))
 ;
 ;set error trap
 N $ES,$ET,ERRARRY,ERRDOM,ERRPAT,ERRMSG
 ;S $ET="D ERRHDLR^HMPDERRH G ERRQ^HMPDJ0"
 S ERRDOM="hmp",ERRMSG=$G(TYPE)
 K ^TMP($J,"HMP ERROR")
 ;
 ; extract data
 I $L(HMPID) D  G GQ
 . S IEN=+HMPID I 'IEN S IEN=+$O(^HMP(800000.11,"B",HMPID,0)) ;IEN or UID
 . D:IEN HMP1^HMPDJ02(800000.11,IEN)
 I TYPE="" S HMPERR="Missing or invalid collection type" G GQ
 S IEN=0 F  S IEN=$O(^HMP(800000.11,"C",TYPE,IEN)) Q:IEN<1  D HMP1^HMPDJ02(800000.11,IEN)
 ;
GQ ;build return JSON
 D GTQ^HMPDJ
 Q
 ;
DEL(HMP,HMPID) ; -- Delete object HMPID from ^HMP(800000.11)
 ; RPC = HMP DELETE OBJECT
 ;
 N ACTION,ERR,UID,DA,DIK,TYPE
 S UID=$G(HMPID) I '$L(UID) S ERR=$$ERR(3,"null") G PTQ
 S DA=+$O(^HMP(800000.11,"B",UID,0)) I DA<1 S ERR=$$ERR(3,UID) G PTQ
 S DIK="^HMP(800000.11," D ^DIK
 S ACTION="@",TYPE=$P(UID,":",3)
 G PTQ
 Q
 ;
PUT(HMP,TYPE,JSON) ; -- Save/update JSON OBJECT in ^HMP(800000.11), return UID if successful
 ; RPC = HMP PUT OBJECT
 ;
 N ACTION,ARRAY,CNT,ERR,HMPERR,UID,DA,X,I,HMPSYS
 D DECODE^HMPJSON("JSON","ARRAY","HMPERR")
 ;N XCNT S XCNT=$O(^XTMP("AGPARRAY",""),-1),XCNT=XCNT+1
 ;M ^XTMP("AGPARRAY",XCNT,"DATA")=ARRAY
 ;S ^XTMP("AGPARRAY",XCNT,"TYPE")=TYPE
 I $D(HMPERR) D  Q  ;S X=$G(ERR(1)) K ERR S ERR=X G PTQ
 . K ARRAY N HMPTMP,HMPTXT
 . S HMPTXT(1)="Problem decoding json input."
 . D SETERROR^HMPUTILS(.HMPTMP,.HMPERR,.HMPTXT,.JSON)
 . K HMPERR D ENCODE^HMPJSON("HMPTMP","ARRAY","HMPERR")
 . S HMP(.5)="{""apiVersion"":""1.01"",""error"":{"
 . M HMP(1)=ARRAY
 . S HMP(2)="}}"
 ;
 S UID=$G(ARRAY("uid")),HMPSYS=$$SYS^HMPUTILS
 I $L(UID) S DA=+$O(^HMP(800000.11,"B",UID,0)) I DA<1 S ERR=$$ERR(3,UID) G PTQ
 ;I $L(UID) S DA=+$O(^HMP(800000.11,"B",UID,0)) I DA<1 D NEW1(UID)
 I '$L(UID) D  G:$D(ERR) PTQ Q:$D(HMPERR)
 . D NEW Q:$D(ERR)
 . S ARRAY("uid")=UID K JSON
 . D ENCODE^HMPJSON("ARRAY","JSON","HMPERR")
 . I $D(HMPERR) D  Q  ;S X=$G(ERR(1)) K ERR S ERR=X Q
 .. K JSON N HMPTMP,HMPTXT
 .. S HMPTXT(1)="Problem encoding json output."
 .. D SETERROR^HMPUTILS(.HMPTMP,.HMPERR,.HMPTXT,.ARRAY)
 .. K HMPERR D ENCODE^HMPJSON("HMPTMP","JSON","HMPERR")
 .. S HMP(.5)="{""apiVersion"":""1.01"",""error"":{"
 .. M HMP(1)=JSON
 .. S HMP(2)="}}"
 ;
 K ^HMP(800000.11,DA,1) S ^(1,0)="^800000.111^^",CNT=0
 S I="" F  S I=$O(JSON(I)) Q:I=""  S CNT=CNT+1,^HMP(800000.11,DA,1,CNT,0)=JSON(I)
 S:$G(CNT) ^HMP(800000.11,DA,1,0)="^800000.111^"_CNT_U_CNT
 ;
PTQ ; add item count and terminating characters
 I $D(ERR) S HMP="{""apiVersion"":""1.01"",""error"":{""message"":"""_ERR_"""},""success"":false}" Q
 S HMP="{""apiVersion"":""1.01"",""data"":{""updated"":"_""""_$$HL7NOW_""""_",""uid"":"""_UID_"""},""success"":true}"
 D POSTX^HMPEVNT(TYPE,DA,$G(ACTION)) ;UID)
 Q
 ;
NEW1(UID) ; -- create new entry in ^HMP(800000.11) from PAT,TYPE,HMPSYS
 ;  Return UID & DA, or ERR
 S TYPE=$G(TYPE)
 I TYPE="" S ERR=$$ERR(2,"null") Q
 ;
 S DA=$$NEXTIFN I DA<1 S ERR=$$ERR(4) Q
 S UID="urn:va:"_TYPE_":"_HMPSYS_":"_DA
 S ^HMP(800000.11,DA,0)=UID_U_U_TYPE
 S ^HMP(800000.11,"B",UID,DA)=""
 S ^HMP(800000.11,"C",TYPE,DA)=""
 Q
 ;
NEW ; -- create new entry in ^HMP(800000.11) from PAT,TYPE,HMPSYS
 ;  Return UID & DA, or ERR
 S TYPE=$G(TYPE)
 I TYPE="" S ERR=$$ERR(2,"null") Q
 ;
 S DA=$$NEXTIFN I DA<1 S ERR=$$ERR(4) Q
 S UID="urn:va:"_TYPE_":"_HMPSYS_":"_DA
 S ^HMP(800000.11,DA,0)=UID_U_U_TYPE
 S ^HMP(800000.11,"B",UID,DA)=""
 S ^HMP(800000.11,"C",TYPE,DA)=""
 Q
 ;
NEXTIFN() ; -- Returns next available IFN
 N I,HDR,TOTAL,DA
 L +^HMP(800000.11,0):$S($G(DILOCKTM)>0:DILOCKTM,1:5)
 I '$T Q "^"
 S HDR=$G(^HMP(800000.11,0)),TOTAL=+$P(HDR,U,4),I=$O(^HMP(800000.11,"?"),-1)
 F I=(I+1):1 Q:'$D(^HMP(800000.11,I,0))
 S DA=I,$P(HDR,U,3,4)=DA_U_(TOTAL+1) S ^HMP(800000.11,0)=HDR
 L -^HMP(800000.11,0)
 Q DA
 ;
ERR(X,VAL) ; -- return error message
 N MSG  S MSG="Error"
 I X=1  S MSG="Patient with dfn '"_$G(VAL)_"' not found"
 I X=2  S MSG="Domain type '"_$G(VAL)_"' not recognized"
 I X=3  S MSG="UID '"_$G(VAL)_"' not found"
 I X=4  S MSG="Unable to create new object"
 I X=99 S MSG="Unknown request"
 Q MSG
 ;
HL7NOW() ; -- Return current time in HL7 format
 Q $P($$FMTHL7^XLFDT($$NOW^XLFDT),"-")
