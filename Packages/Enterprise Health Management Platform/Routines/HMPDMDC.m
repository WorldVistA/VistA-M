HMPDMDC ;SLC/MKB,DP,ASMR/RRB - CLiO extract;8/2/11  15:29
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^MDC(704.101                 5748 (Private)
 ; ^MDC(704.102                 5748 (Private)
 ; ^MDC(704.117                 5748 (Private)
 ; ^MDC(704.118                 5811 (Private)
 ; DIC                          2051
 ; DIQ                          2056
 ; XLFDT                       10103
 ; XLFSTR                      10104
 Q
 ; ------------ Get observations from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's observations
 N HMPCLIO,HMPN,HMPITM,HMPCNT,X
 ;
 ; get one observation
 I $L($G(ID)) D EN1(ID,.HMPITM),XML(.HMPITM) Q
 ;
 ; get all patient observations
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999),HMPCNT=0
 ;D QRYPT^MDCLIO1("HMPCLIO",DFN,BEG,END) ;all [verified] observations
 D QRYPT("HMPCLIO",DFN,BEG,END) ;all [verified] observations
 S HMPN=0 F  S HMPN=$O(HMPCLIO(HMPN)) Q:(HMPN<1)!(HMPCNT'<MAX)  D
 . S ID=$G(HMPCLIO(HMPN)) K HMPITM ;GUID
 . D EN1(ID,.HMPITM) Q:'$D(HMPITM)
 . D XML(.HMPITM) S HMPCNT=HMPCNT+1
 Q
 ;
EN1(GUID,CLIO) ; -- return an observation in CLIO("attribute")=value
 N HMPT,HMPC,LOC,I,X,Y K CLIO
 S GUID=$G(GUID) Q:GUID=""  ;invalid GUID
 ;D QRYOBS^MDCLIO1("HMPC",GUID) Q:'$D(HMPC)  ;doesn't exist
 D QRYOBS("HMPC",GUID) Q:'$D(HMPC)  ;doesn't exist
 Q:$L($G(HMPC("PARENT_ID","E")))            ;PARENT also in list
 S CLIO("id")=GUID,CLIO("vuid")=$G(HMPC("TERM_ID","I"))
 S CLIO("name")=$G(HMPC("TERM_ID","E"))
 S CLIO("value")=$G(HMPC("SVALUE","E"))
 S CLIO("units")=$G(HMPC("UNIT_ID","ABBV"))
 S CLIO("entered")=$G(HMPC("ENTERED_DATE_TIME","I"))
 S CLIO("observed")=$G(HMPC("OBSERVED_DATE_TIME","I"))
 ;D QRYTYPES^MDCLIO1("HMPT")
 D QRYTYPES("HMPT")
 F I=3:1:7 S X=$G(HMPT(I,"XML")) Q:I<1  I $L($G(HMPC(X,"E"))) D
 . S Y=HMPT(I,"NAME"),Y=$S(Y="LOCATION":"bodySite",1:$$LOW^XLFSTR(Y))
 . S CLIO(Y)=HMPC(X,"I")_U_HMPC(X,"E")
 S CLIO("range")=$G(HMPC("RANGE","E"))
 S CLIO("status")=$G(HMPC("STATUS","E"))
 S LOC=$G(HMPC("HOSPITAL_LOCATION_ID","I")),CLIO("facility")=$$FAC^HMPD(LOC)
 S CLIO("location")=LOC_U_$G(HMPC("HOSPITAL_LOCATION_ID","E"))
 S CLIO("comment")=$G(HMPC("COMMENT","E"))
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(OBS) ; -- Return observation as XML in @HMP@(#)
 N ATT,X,Y,I,J,P,NAMES,TAG
 D ADD("<observation>") S HMPTOTL=$G(HMPTOTL)+1
 S ATT="" F  S ATT=$O(OBS(ATT)) Q:ATT=""  D
 . S X=$G(OBS(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^HMPD(X)_"' />" D ADD(Y) Q
 . I $L(X)>1 D
 .. S Y="<"_ATT_" "
 .. F P=1:1 S TAG=$P("code^name^Z",U,P) Q:TAG="Z"  I $L($P(X,U,P)) S Y=Y_TAG_"='"_$$ESC^HMPD($P(X,U,P))_"' "
 .. S Y=Y_"/>" D ADD(Y)
 D ADD("</observation>")
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^HMPD($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; Add a line @HMP@(n)=X
 S HMPI=$G(HMPI)+1
 S @HMP@(HMPI)=X
 Q
 ;
 ; -- CliO specific code accessing the ^MDC( global for data
 ; 
QRYPT(HMPRET,HMPDFN,HMPFR,HMPTO,HMPSTAT) ; List of observations by pt, datetime, status
 K @HMPRET
 N HMPDT,HMPIEN
 S HMPSTAT=$G(HMPSTAT,1) ; Default to Verified
 F HMPDT=HMPFR-.0000001:0 S HMPDT=$O(^MDC(704.117,"AS",HMPSTAT,HMPDFN,HMPDT)) Q:'HMPDT!(HMPDT>HMPTO)  D
 . F HMPIEN=0:0 S HMPIEN=$O(^MDC(704.117,"AS",HMPSTAT,HMPDFN,HMPDT,HMPIEN)) Q:'HMPIEN  D
 . . S:$P(^MDC(704.117,HMPIEN,0),U,9)=HMPSTAT @HMPRET@(HMPIEN)=$P(^MDC(704.117,HMPIEN,0),U)
 Q
 ;
QRYOBS(HMPRET,HMPID) ; Return a single observation
 K @HMPRET
 N HMPTMP,HMPIEN
 S HMPIEN=$$FIND1^DIC(704.117,"","PKX",HMPID,"PK")
 I HMPIEN<1 S @HMPRET@(0)="-1^No such observation '"_HMPID_"'" Q
 D GETS^DIQ(704.117,HMPIEN_",","*","EIR","HMPTMP")
 M @HMPRET=HMPTMP(704.117,HMPIEN_",") K HMPTMP
 S @HMPRET@("TERM_ID","I")=$$GET1^DIQ(704.117,HMPIEN_",",".07:99.99")
 S @HMPRET@("TERM_ID","E")=$$GET1^DIQ(704.117,HMPIEN_",",".07:.02")
 S @HMPRET@("TERM_ID","GUID")=$$GET1^DIQ(704.117,HMPIEN_",",".07")
 S @HMPRET@("TERM_ID","ABBV")=$$GET1^DIQ(704.117,HMPIEN_",",".07:.03")
 D:$$GET1^DIQ(704.117,HMPIEN_",",".07:.06","I")=3  ; Coded data values
 . S HMPTMP=$$FIND1^DIC(704.101,"","PKX",@HMPRET@("SVALUE","I"),"PK")
 . S @HMPRET@("SVALUE","E")=$$GET1^DIQ(704.101,HMPTMP_",",.02)
 D QRYQUAL(HMPRET,HMPIEN)
 D QRYCTX($NA(@HMPRET@("CONTEXT")),HMPID)
 Q
 ;
QRYQUAL(HMPRET,HMPIEN) ; Returns the qualifiers for obs in HMPIEN
 ; We do NOT want to kill HMPRET here because it points at the parent node of the return
 N HMPQUAL
 F Y=0:0 S Y=$O(^MDC(704.118,"PK",HMPIEN,Y)) Q:'Y  D  ;ICR 5811 DE2818 ASF 11/25/15
 . S HMPQUAL=$$GET1^DIQ(704.101,Y_",",".05:.02")
 . S @HMPRET@(HMPQUAL,"I")=$$GET1^DIQ(704.101,Y_",","99.99")
 . S @HMPRET@(HMPQUAL,"E")=$$GET1^DIQ(704.101,Y_",",".02")
 . S @HMPRET@(HMPQUAL,"GUID")=$$GET1^DIQ(704.101,Y_",",".01")
 . S @HMPRET@(HMPQUAL,"ABBV")=$$GET1^DIQ(704.101,Y_",",".03")
 Q
 ;
QRYCTX(HMPRET,HMPID) ; We need a terminology based context observation relationship here
 N HMPIEN,HMPCTX,HMPDT,HMPFR,HMPTO,HMPDFN,HMPTERM,HMPCNT,HMPXID,HMPOBS
 S HMPIEN=+$$FIND1^DIC(704.117,"","PKX",HMPID,"PK") Q:HMPIEN<1
 S HMPCTX=$$GET1^DIQ(704.117,HMPIEN_",",.07) ; GET THE PRIMARY TERM (GUID)
 ; FILTER OUT EVERYTHING BUT SpO2 for now
 Q:HMPCTX'="{5F84DD55-3CCF-094C-2536-B51EB7FAD999}"
 S HMPDFN=+$$GET1^DIQ(704.117,HMPIEN_",",.08,"I") ; GET THE PATIENT
 S HMPDT=+$$GET1^DIQ(704.117,HMPIEN_",",.05,"I") ; GET THE OBS DATE
 S HMPFR=$$FMADD^XLFDT(HMPDT,0,0,0,-30) ; PREVIOUS 30 SECONDS
 S HMPTO=$$FMADD^XLFDT(HMPDT,0,0,0,30) ; NEXT 30 SECONDS
 ; Now we find the context observations
 F HMPDT=HMPFR:0 S HMPDT=$O(^MDC(704.117,"PT",HMPDFN,HMPDT)) Q:'HMPDT!(HMPDT>HMPTO)  D  ;ICR 5810 DE2818 ASF 11/25/15 
 . F HMPOBS=0:0 S HMPOBS=$O(^MDC(704.117,"PT",HMPDFN,HMPDT,HMPOBS)) Q:'HMPOBS  D
 . . Q:$$GET1^DIQ(704.117,HMPOBS_",",.09,"I")'=1  ; Verified Only
 . . S HMPXID=$$GET1^DIQ(704.117,HMPOBS_",",.01)
 . . Q:HMPXID=HMPID  ; You should ignore yourself in this loop
 . . S HMPTERM=$$GET1^DIQ(704.117,HMPOBS_",",".07")
 . . ; INSERT FILTER CODE FOR O2 Flowrate and Concentration here - In the future we will find all context terms for an observation in terminology
 . . Q:(HMPTERM'="{56F82CAC-3564-46CE-A520-1025020DADE9}")&(HMPTERM'="{3BB314E8-9BBB-480E-B34E-B56EDE43BAC4}")
 . . S HMPCNT=$O(@HMPRET@(""),-1)+1,@HMPRET@(0)=HMPCNT
 . . S @HMPRET@(HMPCNT,"OBS_ID","I")=HMPXID
 . . S @HMPRET@(HMPCNT,"OBS_ID","E")=HMPXID
 . . S @HMPRET@(HMPCNT,"TERM_ID","I")=$$GET1^DIQ(704.117,HMPOBS_",",".07:99.99")
 . . S @HMPRET@(HMPCNT,"TERM_ID","E")=$$GET1^DIQ(704.117,HMPOBS_",",".07:.02")
 . . S @HMPRET@(HMPCNT,"SVALUE","I")=$$GET1^DIQ(704.117,HMPOBS_",",".1","I")
 . . S @HMPRET@(HMPCNT,"SVALUE","E")=$$GET1^DIQ(704.117,HMPOBS_",",".1","E")
 . . D QRYQUAL($NA(@HMPRET@(HMPCNT)),HMPOBS)
 Q
 ;
QRYTYPES(HMPRET) ; Return the terminology Term Types
 K @HMPRET
 N X
 F X=0:0 S X=$O(^MDC(704.102,X)) Q:'X  D  ;ICR 5748 DE2818 ASF 11/25/15
 . S @HMPRET@(X,"NAME")=$P(^MDC(704.102,X,0),U,1)
 . S @HMPRET@(X,"XML")=$P(^MDC(704.102,X,0),U,2)
 . S @HMPRET@("B",$P(^MDC(704.102,X,0),U,1),X)=""
 Q
 ;
