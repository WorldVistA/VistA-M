VPRDMDC ;SLC/MKB,DP -- CLiO extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**1,2**;Sep 01, 2011;Build 317
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^MDC(704.101                 5748 (Private)
 ; ^MDC(704.102                 5809 (Private)
 ; ^MDC(704.1122                5999 (Private)
 ; ^MDC(704.116                 5995 (Private)
 ; ^MDC(704.1161                5996 (Private)
 ; ^MDC(704.117                 5810 (Private)
 ; ^MDC(704.118                 5811 (Private)
 ; DIC                          2051
 ; DIQ                          2056
 ; XLFDT                       10103
 ; XLFSTR                      10104
 ; XPAR                         2263
 ;
 ; ------------ Get observations from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's observations
 N VPRCLIO,VPRN,VPRITM,VPRCNT,X
 ;
 ; get one observation
 I $L($G(ID)) D EN1(ID,.VPRITM),XML(.VPRITM) Q
 ;
 ; get all patient observations
 S DFN=+$G(DFN) Q:DFN<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999),VPRCNT=0
 ;D QRYPT^MDCLIO1("VPRCLIO",DFN,BEG,END) ;all [verified] observations
 D QRYPT("VPRCLIO",DFN,BEG,END) ;all [verified] observations
 S VPRN=0 F  S VPRN=$O(VPRCLIO(VPRN)) Q:(VPRN<1)!(VPRCNT'<MAX)  D
 . S ID=$G(VPRCLIO(VPRN)) K VPRITM ;GUID
 . D EN1(ID,.VPRITM) Q:'$D(VPRITM)
 . D XML(.VPRITM) S VPRCNT=VPRCNT+1
 Q
 ;
EN1(GUID,CLIO) ; -- return an observation in CLIO("attribute")=value
 N VPRT,VPRC,LOC,I,X,Y K CLIO
 S GUID=$G(GUID) Q:GUID=""  ;invalid GUID
 ;D QRYOBS^MDCLIO1("VPRC",GUID) Q:'$D(VPRC)  ;doesn't exist
 D QRYOBS("VPRC",GUID) Q:'$D(VPRC)  ;doesn't exist
 Q:$L($G(VPRC("PARENT_ID","E")))            ;PARENT also in list
 S CLIO("id")=GUID,CLIO("vuid")=$G(VPRC("TERM_ID","I"))
 S CLIO("name")=$G(VPRC("TERM_ID","E"))
 S CLIO("value")=$G(VPRC("SVALUE","E"))
 S CLIO("units")=$G(VPRC("UNIT_ID","ABBV"))
 S CLIO("entered")=$G(VPRC("ENTERED_DATE_TIME","I"))
 S CLIO("observed")=$G(VPRC("OBSERVED_DATE_TIME","I"))
 ;D QRYTYPES^MDCLIO1("VPRT")
 D QRYTYPES("VPRT")
 F I=3:1:7 S X=$G(VPRT(I,"XML")) Q:I<1  I $L($G(VPRC(X,"E"))) D
 . S Y=VPRT(I,"NAME"),Y=$S(Y="LOCATION":"bodySite",1:$$LOW^XLFSTR(Y))
 . S CLIO(Y)=VPRC(X,"I")_U_VPRC(X,"E")
 S CLIO("range")=$G(VPRC("RANGE","E"))
 S CLIO("status")=$G(VPRC("STATUS","E"))
 S LOC=$G(VPRC("HOSPITAL_LOCATION_ID","I")),CLIO("facility")=$$FAC^VPRD(LOC)
 S CLIO("location")=LOC_U_$G(VPRC("HOSPITAL_LOCATION_ID","E"))
 S CLIO("comment")=$G(VPRC("COMMENT","E"))
 Q
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(OBS) ; -- Return observation as XML in @VPR@(#)
 N ATT,X,Y,I,J,P,NAMES,TAG
 D ADD("<observation>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(OBS(ATT)) Q:ATT=""  D
 . S X=$G(OBS(ATT)),Y="" Q:'$L(X)
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" D ADD(Y) Q
 . I $L(X)>1 D
 .. S Y="<"_ATT_" "
 .. F P=1:1 S TAG=$P("code^name^Z",U,P) Q:TAG="Z"  I $L($P(X,U,P)) S Y=Y_TAG_"='"_$$ESC^VPRD($P(X,U,P))_"' "
 .. S Y=Y_"/>" D ADD(Y)
 D ADD("</observation>")
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^VPRD($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
 ;
 ; -- CliO specific code accessing the ^MDC( global for data
 ; 
QRYPT(VPRRET,VPRDFN,VPRFR,VPRTO,VPRSTAT) ; List of observations by pt, datetime, status
 K @VPRRET
 N VPRDT,VPRIEN
 S VPRSTAT=$G(VPRSTAT,1) ; Default to Verified
 F VPRDT=VPRFR-.0000001:0 S VPRDT=$O(^MDC(704.117,"AS",VPRSTAT,VPRDFN,VPRDT)) Q:'VPRDT!(VPRDT>VPRTO)  D
 . F VPRIEN=0:0 S VPRIEN=$O(^MDC(704.117,"AS",VPRSTAT,VPRDFN,VPRDT,VPRIEN)) Q:'VPRIEN  D
 . . S:$P(^MDC(704.117,VPRIEN,0),U,9)=VPRSTAT @VPRRET@(VPRIEN)=$P(^MDC(704.117,VPRIEN,0),U)
 Q
 ;
QRYOBS(VPRRET,VPRID) ; Return a single observation
 K @VPRRET
 N VPRTMP,VPRIEN
 S VPRIEN=$$FIND1^DIC(704.117,"","PKX",VPRID,"PK")
 I VPRIEN<1 S @VPRRET@(0)="-1^No such observation '"_VPRID_"'" Q
 D GETS^DIQ(704.117,VPRIEN_",","*","EIR","VPRTMP")
 M @VPRRET=VPRTMP(704.117,VPRIEN_",") K VPRTMP
 S @VPRRET@("TERM_ID","I")=$$GET1^DIQ(704.117,VPRIEN_",",".07:99.99")
 S @VPRRET@("TERM_ID","E")=$$GET1^DIQ(704.117,VPRIEN_",",".07:.02")
 S @VPRRET@("TERM_ID","GUID")=$$GET1^DIQ(704.117,VPRIEN_",",".07")
 S @VPRRET@("TERM_ID","ABBV")=$$GET1^DIQ(704.117,VPRIEN_",",".07:.03")
 D:$$GET1^DIQ(704.117,VPRIEN_",",".07:.06","I")=3  ; Coded data values
 . S VPRTMP=$$FIND1^DIC(704.101,"","PKX",@VPRRET@("SVALUE","I"),"PK")
 . S @VPRRET@("SVALUE","E")=$$GET1^DIQ(704.101,VPRTMP_",",.02)
 D QRYQUAL(VPRRET,VPRIEN)
 D QRYCTX($NA(@VPRRET@("CONTEXT")),VPRID)
 D QRYSET(VPRRET,VPRIEN)
 Q
 ;
QRYQUAL(VPRRET,VPRIEN) ; Returns the qualifiers for obs in VPRIEN
 ; We do NOT want to kill VPRRET here because it points at the parent node of the return
 N VPRQUAL
 F Y=0:0 S Y=$O(^MDC(704.118,"PK",VPRIEN,Y)) Q:'Y  D
 . S VPRQUAL=$$GET1^DIQ(704.101,Y_",",".05:.02")
 . S @VPRRET@(VPRQUAL,"I")=$$GET1^DIQ(704.101,Y_",","99.99")
 . S @VPRRET@(VPRQUAL,"E")=$$GET1^DIQ(704.101,Y_",",".02")
 . S @VPRRET@(VPRQUAL,"GUID")=$$GET1^DIQ(704.101,Y_",",".01")
 . S @VPRRET@(VPRQUAL,"ABBV")=$$GET1^DIQ(704.101,Y_",",".03")
 Q
 ;
QRYCTX(VPRRET,VPRID) ; We need a terminology based context observation relationship here
 N VPRIEN,VPRCTX,VPRDT,VPRFR,VPRTO,VPRDFN,VPRTERM,VPRCNT,VPRXID,VPROBS
 S VPRIEN=+$$FIND1^DIC(704.117,"","PKX",VPRID,"PK") Q:VPRIEN<1
 S VPRCTX=$$GET1^DIQ(704.117,VPRIEN_",",.07) ; GET THE PRIMARY TERM (GUID)
 ; FILTER OUT EVERYTHING BUT SpO2 for now
 Q:VPRCTX'="{5F84DD55-3CCF-094C-2536-B51EB7FAD999}"
 S VPRDFN=+$$GET1^DIQ(704.117,VPRIEN_",",.08,"I") ; GET THE PATIENT
 S VPRDT=+$$GET1^DIQ(704.117,VPRIEN_",",.05,"I") ; GET THE OBS DATE
 S VPRFR=$$FMADD^XLFDT(VPRDT,0,0,0,-30) ; PREVIOUS 30 SECONDS
 S VPRTO=$$FMADD^XLFDT(VPRDT,0,0,0,30) ; NEXT 30 SECONDS
 ; Now we find the context observations
 F VPRDT=VPRFR:0 S VPRDT=$O(^MDC(704.117,"PT",VPRDFN,VPRDT)) Q:'VPRDT!(VPRDT>VPRTO)  D
 . F VPROBS=0:0 S VPROBS=$O(^MDC(704.117,"PT",VPRDFN,VPRDT,VPROBS)) Q:'VPROBS  D
 . . Q:$$GET1^DIQ(704.117,VPROBS_",",.09,"I")'=1  ; Verfied Only
 . . S VPRXID=$$GET1^DIQ(704.117,VPROBS_",",.01)
 . . Q:VPRXID=VPRID  ; You should ignore yourself in this loop
 . . S VPRTERM=$$GET1^DIQ(704.117,VPROBS_",",".07")
 . . ; INSERT FILTER CODE FOR O2 Flowrate and Concentration here - In the future we will find all context terms for an observation in terminology
 . . Q:(VPRTERM'="{56F82CAC-3564-46CE-A520-1025020DADE9}")&(VPRTERM'="{3BB314E8-9BBB-480E-B34E-B56EDE43BAC4}")
 . . S VPRCNT=$O(@VPRRET@(""),-1)+1,@VPRRET@(0)=VPRCNT
 . . S @VPRRET@(VPRCNT,"OBS_ID","I")=VPRXID
 . . S @VPRRET@(VPRCNT,"OBS_ID","E")=VPRXID
 . . S @VPRRET@(VPRCNT,"TERM_ID","I")=$$GET1^DIQ(704.117,VPROBS_",",".07:99.99")
 . . S @VPRRET@(VPRCNT,"TERM_ID","E")=$$GET1^DIQ(704.117,VPROBS_",",".07:.02")
 . . S @VPRRET@(VPRCNT,"SVALUE","I")=$$GET1^DIQ(704.117,VPROBS_",",".1","I")
 . . S @VPRRET@(VPRCNT,"SVALUE","E")=$$GET1^DIQ(704.117,VPROBS_",",".1","E")
 . . D QRYQUAL($NA(@VPRRET@(VPRCNT)),VPROBS)
 Q
 ;
QRYSET(VPRRET,VPRIEN) ; Return the Obs Set/View information
 N VPRDFN,VPRSET,VPRDT,VPRPG,VPRVW,X
 S VPRDFN=+$G(@VPRRET@("PATIENT_ID","I"))
 S VPRSET=+$O(^MDC(704.1161,"AS",VPRIEN,0)) Q:VPRSET<1  ;not part of set
 S @VPRRET@("SET_ID","GUID")=$$GET1^DIQ(704.116,VPRSET_",",".01")
 S VPRDT=$$GET1^DIQ(704.116,VPRSET_",",".02","I")
 ; loop backwards to find supplemental page for Obs_Set
 F  S VPRDT=$O(^MDC(704.1122,"ADT",VPRDFN,VPRDT),-1) Q:VPRDT<1  D  Q:VPRPG  ;found
 . S VPRPG=+$O(^MDC(704.1122,"ADT",VPRDFN,VPRDT,0))
 . I $P($G(^MDC(704.1122,VPRPG,0)),U,10)'=VPRSET S VPRPG="" Q
 . S @VPRRET@("SUPP_PAGE","GUID")=$$GET1^DIQ(704.1122,VPRPG_",",".01")
 . S @VPRRET@("SUPP_PAGE","DISPLAY_NAME")=$$GET1^DIQ(704.1122,VPRPG_",",".08")
 . S @VPRRET@("SUPP_PAGE","ACTIVATED_DATE_TIME")=$$GET1^DIQ(704.1122,VPRPG_",",".11","I")
 . S @VPRRET@("SUPP_PAGE","DEACTIVATED_DATE_TIME")=$$GET1^DIQ(704.1122,VPRPG_",",".21","I")
 . S VPRVW=$$GET1^DIQ(704.1122,VPRPG_",",".02"),X=$$GET^XPAR("ALL","VPR OBS VIEW TYPE",VPRVW,"E")
 . I $L(X) S @VPRRET@("SUPP_PAGE","TYPE")=X
 Q
 ;
QRYTYPES(VPRRET) ; Return the terminology Term Types
 K @VPRRET
 N X
 F X=0:0 S X=$O(^MDC(704.102,X)) Q:'X  D
 . S @VPRRET@(X,"NAME")=$P(^MDC(704.102,X,0),U,1)
 . S @VPRRET@(X,"XML")=$P(^MDC(704.102,X,0),U,2)
 . S @VPRRET@("B",$P(^MDC(704.102,X,0),U,1),X)=""
 Q
