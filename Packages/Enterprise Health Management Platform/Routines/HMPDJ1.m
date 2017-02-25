HMPDJ1 ;SLC/MKB,ASMR/RRB,CK - HMP Patient Object RPCs;May 15, 2016 14:15
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1,2**;May 15, 2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
PUT(HMP,PAT,TYPE,JSON) ; -- Save/update JSON OBJECT in ^HMP(800000.1), return UID if successful
 ; RPC = HMP PUT PATIENT DATA
 ;
 N ARRAY,CNT,ERR,HMPERR,UID,DA,X,I,DFN,HMPSYS
 ;M JSON=INPUT(0)
 D DECODE^HMPJSON("JSON","ARRAY","HMPERR")
 ;N XCNT S XCNT=$O(^XTMP("AGPARRAY",""),-1),XCNT=XCNT+1
 ;M ^XTMP("AGPARRAY",XCNT,"DATA")=ARRAY
 ;S ^XTMP("AGPARRAY",XCNT,"TYPE")=TYPE
 ;M ^XTMP("AGPARRAY")=ARRAY
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
 I $L(UID) S DA=+$O(^HMP(800000.1,"B",UID,0)) I DA<1 S ERR=$$ERR(3,UID) G PTQ
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
 K ^HMP(800000.1,DA,1) S ^(1,0)="^800000.101^^",CNT=0
 S I="" F  S I=$O(JSON(I)) Q:I=""  S CNT=CNT+1,^HMP(800000.1,DA,1,CNT,0)=JSON(I)
 S:$G(CNT) ^HMP(800000.1,DA,1,0)="^800000.101^"_CNT_U_CNT
 ;
PTQ ; add item count and terminating characters
 I $D(ERR) S HMP="{""apiVersion"":""1.01"",""error"":{""message"":"""_ERR_"""},""success"":false}" Q
 S HMP="{""apiVersion"":""1.01"",""data"":{""updated"":"_""""_$$HL7NOW_""""_",""uid"":"""_UID_"""},""success"":true}"
 S DFN=+$P(UID,":",5)
 D POST^HMPEVNT(DFN,TYPE,DA) ;UID)
 Q
 ;
NEW ; -- create new entry in ^HMP(800000.1) from PAT,TYPE,HMPSYS
 ;  Return UID & DA, or ERR
 N DFN,ICN
 S DFN=+$G(PAT),ICN="",TYPE=$G(TYPE)
 I 'DFN,DFN[";" S ICN=+$P($G(DFN),";",2),DFN=+$G(DFN)
 I 'DFN,ICN S DFN=+$$GETDFN^MPIF001(ICN)
 I 'DFN!'$L($G(^DPT(DFN,0))) S ERR=$$ERR(1,DFN) Q  ; IA 10035, DE2818
 I TYPE="" S ERR=$$ERR(2,"null") Q
 ;
 S DA=$$NEXTIFN I DA<1 S ERR=$$ERR(4) Q
 S UID="urn:va:"_TYPE_":"_HMPSYS_":"_DFN_":"_DA
 S ^HMP(800000.1,DA,0)=UID_U_DFN_U_TYPE
 S ^HMP(800000.1,"B",UID,DA)=""
 S ^HMP(800000.1,"C",DFN,TYPE,DA)=""
 Q
 ;
NEXTIFN() ; -- Returns next available IFN
 N I,HDR,TOTAL,DA
 L +^HMP(800000.1,0):$S($G(DILOCKTM)>0:DILOCKTM,1:5)
 I '$T Q "^"
 S HDR=$G(^HMP(800000.1,0)),TOTAL=+$P(HDR,U,4),I=$O(^HMP(800000.1,"?"),-1)
 F I=(I+1):1 Q:'$D(^HMP(800000.1,I,0))
 S DA=I,$P(HDR,U,3,4)=DA_U_(TOTAL+1) S ^HMP(800000.1,0)=HDR
 L -^HMP(800000.1,0)
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
 Q $$FMTHL7^HMPSTMP($$NOW^XLFDT)  ; DE5016
 ;
CONV ; -- convert uid format
 N DA,X0,UID,HMPSYS,DFN,COLL,NEW,I,JSON,HMPY,ERR,CNT
 S HMPSYS=$$SYS^HMPUTILS
 S DA=0 F  S DA=$O(^HMP(800000.1,DA)) Q:DA<1  D
 . S X0=$G(^HMP(800000.1,DA,0)),UID=$P(X0,U)
 . K ^HMP(800000.1,"B",UID,DA),JSON
 . S DFN=$P(X0,"^",2),COLL=$P(X0,"^",3)
 . S NEW="urn:va:"_COLL_":"_HMPSYS_":"_DFN_":"_DA
 . S $P(^HMP(800000.1,DA,0),U)=NEW,^HMP(800000.1,"B",NEW,DA)=""
 . ;decode JSON object, reset uid
 . S I=0 F  S I=$O(^HMP(800000.1,DA,1,I)) Q:I<1  S JSON(I)=$G(^(I,0))
 . Q:'$D(JSON)  K HMPY,ERR
 . D DECODE^HMPJSON("JSON","HMPY","ERR") I $D(ERR) W !,DA Q
 . S HMPY("uid")=NEW K JSON
 . D ENCODE^HMPJSON("HMPY","JSON","ERR") I $D(ERR) W !,DA Q
 . K ^HMP(800000.1,DA,1) S ^(1,0)="^800000.101^^",CNT=0
 . S I="" F  S I=$O(JSON(I)) Q:I=""  S CNT=CNT+1,^HMP(800000.1,DA,1,CNT,0)=JSON(I)
 . S:$G(CNT) ^HMP(800000.1,DA,1,0)="^800000.101^"_CNT_U_CNT
 Q
