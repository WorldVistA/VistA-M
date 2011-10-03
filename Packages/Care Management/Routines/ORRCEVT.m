ORRCEVT ; SLC/MKB,JFR - Event utilities ; 7/5/05 11:15
 ;;1.0;CARE MANAGEMENT;**2**;Jul 15, 2003
 ;
 ; ID = "VST:"_alertID (="OR,<dfn>,<nien>;<user>;<date.time>")
 ;         or _apptID  (="A;<date.time>;<hospital location>;<dfn>")
 ;         or _visitID (="V;<date.time>;<hospital location>;<dfn>")
 ;         or _procID  (=order#)
 ;
PATS(ORY,ORUSR) ; -- Return list of patients for whom ORUSR has ADT alerts
 ; in @ORY@(PAT) = #event alerts
 ;    @ORY@(PAT,ID) = "" per alert
 ; [from ORRCDPT]
 N ORXQ,ORI,XQAID,PAT,NOT,X,ACTDT
 S ORY=$NA(^TMP($J,"ORRCEVT")) K @ORY
 S ORXQ=$NA(^TMP($J,"ORXQ")) K @ORXQ
 S ORUSR=+$G(ORUSR),ACTDT=$$PARAM^ORRCACK(ORUSR)
 D USER^XQALERT(ORXQ,ORUSR) Q:+$G(@ORXQ)<1
 S ORI=0 F  S ORI=$O(@ORXQ@(ORI)) Q:ORI<1  S XQAID=$P(@ORXQ@(ORI),U,2) D
 . Q:XQAID'?1"OR,".E  S PAT=+$P(XQAID,",",2),NOT=+$P(XQAID,",",3)
 . I $D(^TMP($J,"ORRCLST")),'$D(^TMP($J,"ORRCY",PAT)) Q
 . I $D(^TMP($J,"ORRCLST")) D
 .. I "^18^19^20^35^36^"'[(U_NOT_U) D:'$$INCLD  Q  ;non-ADT alerts
 ... S ^TMP($J,"ORRCNOTF",PAT)=1
 .. S X=+$G(@ORY@(PAT)),@ORY@(PAT)=X+1,@ORY@(PAT,"VST:"_XQAID)=""
 . I '$D(^TMP($J,"ORRCLST")) D  ; add pts to dynamic if other notifs
 .. I "^18^19^20^35^36^"'[(U_NOT_U) D:'$$INCLD  Q  ;non-ADT alerts
 ... S ^TMP($J,"ORRCNOTF",PAT)=1
 ... I '$D(^TMP($J,"ORRCY",PAT)) S ^TMP($J,"ORRCY",PAT)="" ; add patient
 .. S X=+$G(@ORY@(PAT)),@ORY@(PAT)=X+1,@ORY@(PAT,"VST:"_XQAID)=""
 K @ORXQ,^TMP($J,"ORSLT")
 Q
 ;
INCLD() ; -- Order already in Results column?
 I "^3^14^21^22^23^24^25^53^57^58^"'[(U_NOT_U) Q 0
 I (ACTDT<1)!(ACTDT>DT) Q 0
 N X,DATE,DATA
 S DATE=$P(XQAID,";",3),DATA=$G(^XTV(8992,ORUSR,"XQA",DATE,1))
 S X=$P(DATA,"|") S:$L(X,"~")>2 X=$P(X,"~",2,3) I X="" Q 0
 I '$G(^TMP($J,"ORSLT",PAT,X)) Q 0
 Q 1
 ;
IDS(ORY,ORPAT,ORBEG,OREND) ; -- Return appointments for ORPAT
 ; in @ORY@(ORPAT) = #appts
 ;    @ORY@(ORPAT,ID) = "" per appt
 ; [from ORRCDPT1]
 N ORRCVST,ORVST,ORI,CNT,ID,ORDG,ORLIST,ORIFN,STS,STRT,ORDT
 S ORY=$NA(^TMP($J,"ORRCEVT")) K @ORY
 S ORPAT=+$G(ORPAT),ORBEG=$G(ORBEG),OREND=$G(OREND)
 D VST^ORWCV(.ORRCVST,ORPAT,ORBEG,OREND,1) ;=ID^FMdate^ClinicName^StatusName
 M ORVST=ORRCVST
 S (CNT,ORI)=0 F  S ORI=$O(ORVST(ORI)) Q:ORI<1  D
 . S ID="VST:"_$P(ORVST(ORI),U)_";"_ORPAT
 . S CNT=CNT+1,@ORY@(ORPAT,ID)=""
 ;+scheduled Radiology procedures
 S ORDG=+$O(^ORD(100.98,"B","XRAY",0)),ORPAT=+ORPAT_";DPT("
 D EN^ORQ1(ORPAT,ORDG,2) S ORDT=$S($G(DT):DT,1:$P($$NOW^XLFDT,"."))
 S ORI=0 F  S ORI=$O(^TMP("ORR",$J,ORLIST,ORI)) Q:ORI<1  S ORIFN=^(ORI) D
 . S STS=$P($G(^OR(100,+ORIFN,3)),U,3),STRT=$P($G(^(0)),U,8)
 . Q:"^1^2^7^12^13^14^"[(U_STS_U)  I STRT,STRT<ORDT Q  ;done
 . S CNT=CNT+1,@ORY@(ORPAT,"VST:"_+ORIFN)=""
 S:CNT @ORY@(ORPAT)=CNT K ^TMP("ORR",$J,ORLIST)
 Q
 ;
LIST(ORY,ORPAT,ORUSR,ORDET) ; -- Return alerted events to ORUSR for ORPAT
 ; in @ORY@(#) = Item=ID^Text^Date in HL7 format, and also if ORDET
 ;             = Text=line of associated document text
 ; RPC = ORRC EVENTS BY PATIENT
 N ORXQ,ORN,I,XQAID,NOT,TEXT,DATE
 S ORXQ=$NA(^TMP($J,"ORXQ")) K @ORXQ D USER^XQALERT(ORXQ,+$G(ORUSR))
 S ORY=$NA(^TMP($J,"ORRCEVT")),ORN=0 K @ORY
 S I=0 F  S I=$O(@ORXQ@(I)) Q:I<1  D
 . S TEXT=$P(@ORXQ@(I),U),XQAID=$P(@ORXQ@(I),U,2),DATE=$P(XQAID,";",3)
 . Q:XQAID'?1"OR,".E  Q:+$P(XQAID,",",2)'=ORPAT
 . S NOT=+$P(XQAID,",",3) Q:"^18^19^20^35^36^"'[(U_NOT_U)
 . S ORN=ORN+1,@ORY@(ORN)="Item=VST:"_XQAID_U_$E(TEXT,23,99)_U_$$FMTHL7^XLFDT(DATE)
 . I $G(ORDET) D NOTE
 K @ORXQ
 Q
 ;
APPT(ORY,ORPAT,ORBEG,OREND,ORDET) ; -- Return past/future appointments
 ; in @ORY@(#) = Item=ID^Text^Date in HL7 format^Status, and also if ORDET
 ;             = Text=line of associated document text
 ; RPC = ORRC APPTS BY PATIENT
 N ORN,ORVST,ORI,X,ID,LOC,DATE,VISIT,ORNOTE,ORJ,ORDG,ORLIST,ORIFN,ORNOW
 N STS,STRT,NOW,ORRCVST,ORRCNOTE
 S ORPAT=+$G(ORPAT),ORBEG=$$HL7TFM^XLFDT($G(ORBEG)),OREND=$$HL7TFM^XLFDT($G(OREND)),NOW=$$NOW^XLFDT
 D VST^ORWCV(.ORRCVST,ORPAT,ORBEG,OREND,1) ;=ID^FMdate^ClinicName^StatusName
 M ORVST=ORRCVST
 S ORY=$NA(^TMP($J,"ORRCAPPT")),ORN=0 K @ORY
 S ORI=0 F  S ORI=$O(ORVST(ORI)) Q:ORI<1  D
 . S X=ORVST(ORI),DATE=$P(X,U,2)
 . S ID="VST:"_$P(X,U)_";"_ORPAT,LOC=+$P(ID,";",3)
 . S ORN=ORN+1,@ORY@(ORN)="Item="_ID_U_$P(X,U,3)_U_$$FMTHL7^XLFDT(DATE)_U_$P(X,U,4)
 . I $G(ORDET) D
 .. I DATE>NOW S ORN=ORN+1,@ORY@(ORN)="Text=Scheduled Appointment" Q
 .. I $G(^SC(LOC,"OOS")) S ORN=ORN+1,@ORY@(ORN)="Text=No note available" Q
 .. S VISIT=+$$GETENC^PXAPI(ORPAT,DATE,LOC) K ORNOTE
 .. D DETNOTE^ORQQVS(.ORRCNOTE,ORPAT,VISIT)
 .. M ORNOTE=ORRCNOTE
 .. S ORJ=0 F  S ORJ=$O(ORNOTE(ORJ)) Q:ORJ<1  S ORN=ORN+1,@ORY@(ORN)="Text="_ORNOTE(ORJ)
 ;+future Radiology procedures in #100
 S ORDG=+$O(^ORD(100.98,"B","XRAY",0)),ORPAT=+ORPAT_";DPT("
 D EN^ORQ1(ORPAT,ORDG,2) S ORNOW=$$NOW^XLFDT
 S ORI=0 F  S ORI=$O(^TMP("ORR",$J,ORLIST,ORI)) Q:ORI<1  S ORIFN=^(ORI) D
 . S STS=$P($G(^OR(100,+ORIFN,3)),U,3),STRT=$P($G(^(0)),U,8)
 . Q:"^1^2^7^12^13^14^"[(U_STS_U)  I STRT,STRT<ORNOW Q  ;done
 . S ORN=ORN+1,@ORY@(ORN)="Item=VST:"_+ORIFN_U_$$TXT^ORRCOR(+ORIFN)_U_$$FMTHL7^XLFDT(STRT)_U_$$STS^ORRCOR(+ORIFN)
 . I $G(ORDET) D ORD^ORRCOR
 K ^TMP("ORR",$J,ORLIST)
 Q
 ;
TEXT(ORY,VISIT) ; -- Return associated document text of VISITs
 ; where VISIT(#) = ID
 ; in @ORY@(#) = Item=ID^Text^Date in HL7 format
 ;             = Text=line of document text
 ; RPC = ORRC EVENTS BY ID
 N ORN,ORI,ID,XQAID,LOC,TEXT,DATE,VST,ORIFN,DFN,ORNOTE,ORRCNOTE,NOW
 S NOW=$$NOW^XLFDT,ORN=0,ORY=$NA(^TMP($J,"ORRCEVT")) K @ORY
 S ORI="" F  S ORI=$O(VISIT(ORI)) Q:ORI=""  S ID=$P(VISIT(ORI),":",2) D
 . I ID D  Q  ;order
 .. S DATE=$P($G(^OR(100,+ID,0)),U,8)
 .. S ORN=ORN+1,@ORY@(ORN)="Item=VST:"_ID_U_$$TXT^ORRCOR(+ID)_U_$$FMTHL7^XLFDT(DATE)
 .. S ORIFN=ID D ORD^ORRCOR
 . I ID?1"OR,".E D  Q  ;alert
 .. S TEXT=$$MSGTXT^ORRCXQ(ID),DATE=+$P(ID,";",3)
 .. S ORN=ORN+1,@ORY@(ORN)="Item=VST:"_ID_U_TEXT_U_$$FMTHL7^XLFDT(DATE)
 .. S XQAID=ID D NOTE
 . S DATE=$P(ID,";",2),LOC=+$P(ID,";",3),DFN=+$P(ID,";",4)
 . S ORN=ORN+1,@ORY@(ORN)="Item=VST:"_ID_U_$P($G(^SC(LOC,0)),U)_U_DATE
 . I DATE>NOW S ORN=ORN+1,@ORY@(ORN)="Text=Scheduled Appointment" Q
 . S VST=+$$GETENC^PXAPI(DFN,DATE,LOC) K ORNOTE,ORRCNOTE
 . D DETNOTE^ORQQVS(.ORRCNOTE,DFN,VST)
 . M ORNOTE=ORRCNOTE
 . S ORJ=0 F  S ORJ=$O(ORNOTE(ORJ)) Q:ORJ<1  S ORN=ORN+1,@ORY@(ORN)="Text="_ORNOTE(ORJ)
 Q
 ;
NOTE ; -- Add note text associated with event in alert XQAID to @ORY@(ORN)
 ;    Expects TEXT,DATE from alert
 N DFN,NOT,VDT,VAIP,VAERR,LOC,VISIT,ORZ,ORI,ENC,X0,ORRCZ
 S DFN=+$P(XQAID,",",2),NOT=+$P(XQAID,",",3),VDT=$$MSGDT^ORRCXQ(DATE,TEXT)
 I NOT=20,TEXT?1"Died on ".E S ORN=ORN+1,@ORY@(ORN)="Text=No details available." Q
 I NOT=19 D  ;Unsched visit
 . S LOC=0,VISIT=0 ;IA #2065
 . S ENC=0 F  S ENC=$O(^SCE("ADFN",DFN,VDT,ENC)) Q:ENC<1  D  Q:LOC
 .. S X0=$G(^SCE(ENC,0)) Q:$P(X0,U,6)  Q:$P(X0,U,8)=1  ;not parent, appt
 .. Q:$G(^SC(+$P(X0,U,4),"OOS"))  ;not OOS loc
 .. S LOC=+$P(X0,U,4),VISIT=+$P(X0,U,5)
 . S:VISIT<1 VISIT=+$$GETENC^PXAPI(DFN,VDT,LOC)
 . K ORZ D DETNOTE^ORQQVS(.ORRCZ,DFN,VISIT)
 . M ORZ=ORRCZ
 I NOT'=19 D  ;inpt mvt
 . S VAIP("D")=$S(NOT=18!(NOT=36):DATE,1:VDT) D IN5^VADPT
 . S VDT=+VAIP(13,1),LOC=+$G(^DIC(42,+VAIP(13,4),44))
 . S VISIT=+$$GETENC^PXAPI(DFN,VDT,LOC)
 . K ORZ D DETSUM^ORQQVS(.ORRCZ,DFN,VISIT)
 . M ORZ=ORRCZ
 . K ^TMP("PXKENC",$J)
 S ORI=0 F  S ORI=$O(ORZ(ORI)) Q:ORI<1  S ORN=ORN+1,@ORY@(ORN)="Text="_ORZ(ORI)
 Q
 ;
CLEAR(ORY,ORUSR,VISIT) ; -- Clear VISIT alerts for ORUSR
 ; where VISIT(#) = ID
 ; returns ORY(#) = ID ^ 1 or 0, if successful
 ; RPC = ORRC EVENTS ACKNOWLEDGE
 Q:'$G(ORUSR)  N ORN,ORI,XQAID S ORN=0 K ORY
 S ORI=""  F  S ORI=$O(VISIT(ORI)) Q:ORI=""  D
 . S XQAID=$P(VISIT(ORI),":",2)
 . D DELETE^ORRCXQ(XQAID)
 . S ORN=ORN+1,ORY(ORN)="VST:"_XQAID_"^1"
 Q
 ;
TEST19(USR) ; -- Trigger Unsched Visit alert to test
 N XQA,XQAID,XQAMSG
 S XQA(USR)="",XQAID="OR,54,19",XQAMSG="CPRS,JOH (C1239): Unscheduled visit on OCT 14,1999@17:16:21"
 D SETUP^XQALERT
 Q
 ;
TEST35(USR) ; -- Trigger Discharge alert to test
 N XQA,XQAID,XQAMSG
 S XQA(USR)="",XQAID="OR,?,35",XQAMSG="Discharged on ?"
 D SETUP^XQALERT
 Q
 ;
TEST20(USR) ; -- Trigger Deceased alert to test
 N XQA,XQAID,XQAMSG
 S XQA(USR)="",XQAID="OR,91265,20",XQAMSG="CPRS,K (C8838): Died on AUG 31,1999"
 D SETUP^XQALERT
 Q
