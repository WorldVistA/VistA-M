VPRDJ03 ;SLC/MKB -- Consults,ClinProcedures,CLiO ;6/25/12  16:11
 ;;1.0;VIRTUAL PATIENT RECORD;**2**;Sep 01, 2011;Build 317
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC                          10040
 ; ^TIU(8925.1                   5677
 ; ^VA(200                      10060
 ; %DT                          10003
 ; DILFD                         2055
 ; DIQ                           2056
 ; GMRCGUIB                      2980
 ; GMRCSLM1,^TMP("GMRCR"         2740
 ; MCARUTL3                      3280
 ; MDPS1,^TMP("MDHSP"            4230
 ; ORX8                          2467
 ; TIULQ                         2693
 ; TIUSRVLO                      2834
 ; XLFSTR                       10104
 ; XUAF4                         2171
 ;
 ; All tags expect DFN, ID, [VPRSTART, VPRSTOP, VPRMAX, VPRTEXT]
 ;
GMRC1(ID) ; -- consult/request VPRX=^TMP("GMRCR",$J,"CS",VPRN,0)
 N CONS,ORDER,VPRD,X0,X,VPRJ,VPRTIU,NT
 S CONS("localId")=+VPRX,CONS("uid")=$$SETUID^VPRUTILS("consult",DFN,+VPRX)
 S CONS("dateTime")=$$JSONDT^VPRUTILS($P(VPRX,U,2))
 S CONS("statusName")=$P(VPRX,U,3),CONS("service")=$P(VPRX,U,4)
 S CONS("consultProcedure")=$P(VPRX,U,5)
 I $P(VPRX,U,6)="*" S CONS("interpretation")="SIGNIFICANT FINDINGS"
 S CONS("typeName")=$P(VPRX,U,7),CONS("category")=$P(VPRX,U,9)
 S ORDER=+$P(VPRX,U,8),CONS("orderName")=$P($$OI^ORX8(ORDER),U,2)
 S CONS("orderUid")=$$SETUID^VPRUTILS("order",DFN,ORDER)
 D DOCLIST^GMRCGUIB(.VPRD,+VPRX) S X0=$G(VPRD(0)) ;=^GMR(123,ID,0)
 S X=+$P(X0,U,14) I X D  ;ordering provider
 . S CONS("providerUid")=$$SETUID^VPRUTILS("user",,X)
 . S CONS("providerName")=$P($G(^VA(200,X,0)),U)
 S VPRJ=0 F  S VPRJ=$O(VPRD(50,VPRJ)) Q:VPRJ<1  S X=$G(VPRD(50,VPRJ)) D
 . Q:'$D(@(U_$P(X,";",2)_+X_")"))  ;text deleted
 . S CONS("results",VPRJ,"uid")=$$SETUID^VPRUTILS("document",DFN,+X)
 . D EXTRACT^TIULQ(+X,"VPRTIU",,.01)
 . S CONS("results",VPRJ,"localTitle")=$G(VPRTIU(+X,.01,"E"))
 . S NT=$$GET1^DIQ(8925.1,+$G(VPRTIU(+X,.01,"I"))_",",1501)
 . S:$L(NT) CONS("results",VPRJ,"nationalTitle")=NT
 S X=$P(X0,U,21),X=$S(X:$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U),1:$$FAC^VPRD)
 D FACILITY^VPRUTILS(X,"CONS")
 D ADD^VPRDJ("CONS","consult")
 Q
 ;
MDPS1(DFN,BEG,END,MAX) ; -- perform CP search (scope variables)
 N MCARCODE,MCARDT,MCARPROC,MCESKEY,MCESSEC,MCFILE,MDC,MDIMG,RES
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 K ^TMP("MDHSP",$J) S RES=""
 D EN1^MDPS1(.RES,DFN,BEG,END,MAX,"",0) ;RES=^TMP("MDHSP",$J)
 Q
 ;
MC1(ID) ; -- clinical procedure VPRX=^TMP("MDHSP",$J,VPRN)
 N X,Y,%DT,DATE,RTN,GBL,CONS,TIUN,VPRD,X0,PROC,VPRT,LOC,FAC
 S RTN=$P(VPRX,U,3,4) Q:RTN="PRPRO^MDPS4"  ;skip non-CP items
 S X=$P(VPRX,U,6),%DT="TXS" D ^%DT Q:Y'>0  S DATE=Y
 S GBL=+$P(VPRX,U,2)_";"_$S(RTN="PR702^MDPS1":"MDD(702,",1:$$ROOT^VPRDMC(DFN,$P(VPRX,U,11),DATE))
 Q:'GBL  I $G(ID),ID'=GBL Q                ;unknown, or not requested
 ;
 S CONS=+$P(VPRX,U,13) D:CONS DOCLIST^GMRCGUIB(.VPRD,CONS) S X0=$G(VPRD(0)) ;=^GMR(123,ID,0)
 S TIUN=+$P(VPRX,U,14) S:TIUN TIUN=TIUN_U_$$RESOLVE^TIUSRVLO(TIUN)
 S PROC("localId")=GBL,PROC("category")="CP"
 S PROC("uid")=$$SETUID^VPRUTILS("procedure",DFN,GBL)
 S PROC("name")=$P(VPRX,U),PROC("dateTime")=$$JSONDT^VPRUTILS(DATE)
 S X=$P(VPRX,U,7) S:$L(X) PROC("interpretation")=X
 S PROC("kind")="Procedure"
 I CONS,X0 D
 . N VPRJ S PROC("requested")=$$JSONDT^VPRUTILS(+X0)
 . S PROC("consultUid")=$$SETUID^VPRUTILS("consult",DFN,CONS)
 . S PROC("orderUid")=$$SETUID^VPRUTILS("order",DFN,+$P(X0,U,3))
 . S PROC("statusName")=$$EXTERNAL^DILFD(123,8,,$P(X0,U,12))
 . S VPRJ=0 F  S VPRJ=$O(VPRD(50,VPRJ)) Q:VPRJ<1  S X=+$G(VPRD(50,VPRJ)) D
 .. D NOTE(X)
 .. S:'TIUN TIUN=X_U_$$RESOLVE^TIUSRVLO(X)
 I TIUN D
 . S X=$P(TIUN,U,5) I X D
 .. S PROC("providers",1,"providerUid")=$$SETUID^VPRUTILS("user",,+X)
 .. S PROC("providers",1,"providerName")=$P(X,";",3)
 . S:$P(TIUN,U,11) PROC("hasImages")="true"
 . K VPRT D EXTRACT^TIULQ(+TIUN,"VPRT",,".03;.05;1211",,,"I")
 . S X=+$G(VPRT(+TIUN,.03,"I")),PROC("encounterUid")=$$SETUID^VPRUTILS("visit",DFN,X)
 . S LOC=+$G(VPRT(+TIUN,1211,"I")) I LOC S LOC=LOC_U_$P($G(^SC(LOC,0)),U)
 . E  S X=$P(TIUN,U,6) S:$L(X) LOC=+$O(^SC("B",X,0))_U_X
 . S:LOC PROC("locationUid")=$$SETUID^VPRUTILS("location",,+LOC),PROC("locationName")=$P(LOC,U,2),FAC=$$FAC^VPRD(+LOC)
 . I '$D(PROC("statusName")) S X=+$G(VPRT(+TIUN,.05,"I")),PROC("statusName")=$S(X<6:"PARTIAL RESULTS",1:"COMPLETE")
 . I '$G(PROC("results",+TIUN)) D NOTE(+TIUN)
 ; if no consult or note/visit ...
 S:'$D(PROC("statusName")) PROC("statusName")="COMPLETE"
 I '$D(FAC) S X=$P(X0,U,21),FAC=$S(X:$$STA^XUAF4(X)_U_$P($$NS^XUAF4(X),U),1:$$FAC^VPRD)
 D FACILITY^VPRUTILS(FAC,"PROC")
 D ADD^VPRDJ("PROC","procedure")
 Q
 ;
NOTE(DA) ; -- add TIU note info
 N VPRT,NT,TEXT
 D EXTRACT^TIULQ(DA,"VPRT",,.01)
 S PROC("results",DA,"uid")=$$SETUID^VPRUTILS("document",+$G(DFN),DA)
 S PROC("results",DA,"localTitle")=$G(VPRT(DA,.01,"E"))
 S NT=$$GET1^DIQ(8925.1,+$G(VPRT(DA,.01,"I"))_",",1501)
 S:$L(NT) PROC("results",DA,"nationalTitle")=NT
 Q
 ;
MDC1(ID) ; -- clinical observation
 N GUID,CLIO,VPRC,VPRT,LOC,FAC,I,X,Y
 S GUID=$G(ID) Q:GUID=""  ;invalid GUID
 D QRYOBS^VPRDMDC("VPRC",GUID) Q:'$D(VPRC)  ;doesn't exist
 Q:$L($G(VPRC("PARENT_ID","E")))            ;PARENT also in list
 ;
 S CLIO("localId")=GUID,CLIO("uid")=$$SETUID^VPRUTILS("obs",DFN,GUID)
 S X=$G(VPRC("TERM_ID","I")) S:X CLIO("typeVuid")="urn:va:vuid:"_X
 S CLIO("typeCode")="urn:va:clioterminology:"_$G(VPRC("TERM_ID","GUID"))
 S CLIO("typeName")=$G(VPRC("TERM_ID","E"))
 S CLIO("result")=$G(VPRC("SVALUE","E"))
 S X=$G(VPRC("UNIT_ID","ABBV")) S:$L(X) CLIO("units")=X
 S X=$G(VPRC("ENTERED_DATE_TIME","I")),CLIO("entered")=$$JSONDT^VPRUTILS(X)
 S X=$G(VPRC("OBSERVED_DATE_TIME","I")),CLIO("observed")=$$JSONDT^VPRUTILS(X)
 D QRYTYPES^VPRDMDC("VPRT")
 F I=3,5 S X=$G(VPRT(I,"XML")) I $L($G(VPRC(X,"E"))) D
 . S Y=VPRT(I,"NAME"),Y=$S(Y="LOCATION":"bodySite",1:$$LOW^XLFSTR(Y))
 . S CLIO(Y_"Code")=VPRC(X,"I"),CLIO(Y_"Name")=VPRC(X,"E")
 F I=4,6,7 S X=$G(VPRT(I,"XML")) I $L($G(VPRC(X,"E"))) D
 . S CLIO("qualifiers",I,"type")=$$LOW^XLFSTR(VPRT(I,"NAME"))
 . S CLIO("qualifiers",I,"code")=VPRC(X,"I")
 . S CLIO("qualifiers",I,"name")=VPRC(X,"E")
 S X=$G(VPRC("RANGE","E")) I $L(X) D
 . S Y=$S(X="Out of Bounds Low":"<",X="Out of Bounds High":">",1:$E(X))
 . S CLIO("interpretationCode")="urn:hl7:observation-interpretation:"_Y
 . S CLIO("interpretationName")=$S(X="<":"Low off scale",X=">":"High off scale",1:X)
 ; X=$G(VPRC("STATUS","E")) S:$L(X) CLIO("resultStatus")=$S(X="unverified":"active",1:"complete")
 I $D(VPRC("SUPP_PAGE")) D  ;add set info
 . S CLIO("setID")=$G(VPRC("SUPP_PAGE","GUID"))
 . S CLIO("setName")=$G(VPRC("SUPP_PAGE","DISPLAY_NAME"))
 . S X=$G(VPRC("SUPP_PAGE","TYPE")) S:$L(X) CLIO("setType")=X
 . S X=$G(VPRC("SUPP_PAGE","ACTIVATED_DATE_TIME")) S:X CLIO("setStart")=$$JSONDT^VPRUTILS(X)
 . S X=$G(VPRC("SUPP_PAGE","DEACTIVATED_DATE_TIME")) S:X CLIO("setStop")=$$JSONDT^VPRUTILS(X)
 S CLIO("statusCode")="urn:va:observation-status:complete",CLIO("statusName")="complete"
 S LOC=$G(VPRC("HOSPITAL_LOCATION_ID","I")),FAC=$$FAC^VPRD(LOC)
 S CLIO("locationUid")=$$SETUID^VPRUTILS("location",,LOC)
 S CLIO("locationName")=$G(VPRC("HOSPITAL_LOCATION_ID","E"))
 D FACILITY^VPRUTILS(FAC,"CLIO")
 S X=$G(VPRC("COMMENT","E")) S:$L(X) CLIO("comment")=X
 D ADD^VPRDJ("CLIO","obs")
 Q
