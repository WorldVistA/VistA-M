HMPDJ09M ;SLC/MKB,ASMR/RRB - Mental Health;Nov 16, 2015 17:15:13
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; All tags expect DFN, ID, [HMPSTART, HMPSTOP, HMPMAX, HMPTEXT]
 Q
 ;
MH ; -- Mental Health Administrations [from ^HMPDJ0]
 I $G(HMPID) D MH1(HMPID) Q
 N CNT,HMPIDT,ID,FNUM,TOTAL,HMPOUT,HMPYS,IEN
 ;
 ;DE2818, for ^YTT(601.71), subscription needed to ICR 5044
 S IEN=0 F  S IEN=$O(^YTT(601.71,IEN)) Q:IEN'>0  D
 .S HMPYS("CODE")=IEN,HMPYS("DFN")=+$G(DFN),HMPYS("LIMIT")=999
 .K HMPOUT
 .D PTTEST^YTQPXRM2(.HMPOUT,.HMPYS)
 .I HMPOUT(1)["[ERROR]" Q
 .S TOTAL=$P(HMPOUT(1),U,2)+1
 .I $P(HMPOUT(1),U,2)<1 Q
 .;S CNT=1 F  S CNT=$O(HMPOUT(CNT)) Q:CNT'>0  D
 .F CNT=2:1:TOTAL D
 ..I $G(HMPOUT(CNT))="" Q
 ..S ID=$P(HMPOUT(CNT),U)
 ..D MH1(ID,IEN)
 ;handle old MH test before the latest revision to their package
 ;S FNUM=601.2 D SORT^HMPDJ09 ;sort ^PXRMINDX into ^TMP("HMPPX",$J,IDT)
 ;S HMPIDT=0 F  S HMPIDT=$O(^TMP("HMPPX",$J,HMPIDT)) Q:HMPIDT<1  D  Q:HMPI'<HMPMAX
 ;. S ID=0 F  S ID=$O(^TMP("HMPPX",$J,HMPIDT,ID)) Q:ID<1  D YT1^HMPDJ09(ID) Q:HMPI'<HMPMAX
 ;I HMPI'<HMPMAX Q
 ;handle new MH test  after revision to their package
 ;S FNUM=601.84 D SORT^HMPDJ09 ;sort ^PXRMINDX into ^TMP("HMPPX",$J,IDT)
 ;S HMPIDT=0 F  S HMPIDT=$O(^TMP("HMPPX",$J,HMPIDT)) Q:HMPIDT<1  D  Q:HMPI'<HMPMAX
 ;. S ID=0 F  S ID=$O(^TMP("HMPPX",$J,HMPIDT,ID)) Q:ID<1  D YT1^HMPDJ09(ID) Q:HMPI'<HMPMAX
 K ^TMP("HMPPX",$J)
 Q
 ;
MH1(ID,IEN) ; -- MH Administration
 N HMPY,COPY,GBL,ISCOPY,MH,NAME,NODE,CNT,I,X2,X,Y,TEMP,TEXT
 D ENDAS71^YTQPXRM6(.HMPY,ID)
 ;DE2818, for ^YTT(601.71), subscription needed to ICR 5044
 S NAME=$P($G(^YTT(601.71,IEN,0)),U)  ;(#.01) NAME
 S COPY=$G(^YTT(601.71,IEN,7))  ;(#21) COPYRIGHT TEXT
 S ISCOPY=+$P($G(^YTT(601.71,IEN,8)),U,5)  ;(#25) IS COPYRIGHTED
 ;HMPY(2) = Patient Name (1)^Test Code (2)^Test Title (3)^Internal Admin date (4)^External Admin Date (5)^Ordered by (6)
 S MH("localId")=ID,X2=$G(HMPY(2))
 S MH("uid")=$$SETUID^HMPUTILS("mh",DFN,ID)
 S MH("displayName")=$P(X2,U,2),MH("name")=$S(NAME'="":NAME,1:$P(X2,U,3))
 S MH("administeredDateTime")=$$JSONDT^HMPUTILS($P(X2,U,4))
 S X=$P(X2,U,6) I $L(X) D  ;ordered by
 . N HMPERR,HMPOUT  ;DE2818, changed ^VA(200,"B") global reference to FileMan
 . D FIND^DIC(200,"","@;.01","X",X,"","B","","","HMPOUT","HMPERR")
 . ; if single result found save it in Y, else zero
 . S Y=$S($P($G(HMPOUT("DILIST",0)),U)=1:$G(HMPOUT("DILIST",2,1)),1:0)
 . S MH("providerName")=X
 . S:Y MH("providerUid")=$$SETUID^HMPUTILS("user",,Y)
 ;get questions/answers for test
 S I=0,CNT=0 F  S I=$O(HMPY("R",I)) Q:I'>0  D
 .S NODE=$G(HMPY("R",I))
 .S CNT=CNT+1
 .K TEMP,^TMP($J,"HMP MH TEXT")
 .;answers
 .S TEMP=$P(NODE,U,2) I TEMP>0 D
 ..S MH("responses",CNT,"answer","uid")=$$SETVURN^HMPUTILS("mha-answer",TEMP)
 ..S MH("responses",CNT,"answer","text")=$P(NODE,U,6)
 .;questions
 .S TEMP=$P(NODE,U,3) I TEMP>0 D
 ..S MH("responses",CNT,"question","uid")=$$SETVURN^HMPUTILS("mha-question",TEMP)
 ..;DE2818 - ^YTT(601.72,D0,1,D1,0)= (#.01) QUESTION TEXT [1W], ICR 6277
 ..S GBL=$NA(^YTT(601.72,TEMP,1))
 ..D SETTEXT^HMPUTILS(GBL,$NA(^TMP($J,"HMP MH TEXT")))
 ..M MH("responses",CNT,"question","text","\")=^TMP($J,"HMP MH TEXT")
 ; get scale(s) for test
 S I=0,CNT=0 F  S I=$O(HMPY("SI",I)) Q:I'>0  D
 .S NODE=$G(HMPY("SI",I))
 .S CNT=CNT+1
 .S MH("scales",CNT,"scale","uid")=$$SETVURN^HMPUTILS("mha-scale",I)
 .S MH("scales",CNT,"scale","name")=$P(NODE,U,2)
 .S MH("scales",CNT,"scale","rawScore")=$P(NODE,U,3)
 .I $P(NODE,U,4)'="" S MH("scales",CNT,"scale","transformScore")=$P(NODE,U,4)
 S MH("isCopyright")=$S(ISCOPY=1:"true",1:"false")
 I ISCOPY=1 S MH("copyrightText")=COPY
 S MH("lastUpdateTime")=$$EN^HMPSTMP("mh") ;RHL 20150103
 S MH("stampTime")=MH("lastUpdateTime") ; RHL 20150103
 ;US6734 - pre-compile metastamp
 I $G(HMPMETA) D ADD^HMPMETA("mh",MH("uid"),MH("stampTime")) Q:HMPMETA=1  ;US6734,US11019
 D ADD^HMPDJ("MH","mh")
 Q
