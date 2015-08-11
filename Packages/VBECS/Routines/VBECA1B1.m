VBECA1B1 ;HIOFO/BNT - VBECS Patient Data API continued ;04/12/2005 03:10
 ;;1.0;VBECS;**54**;Apr 14, 2005;Build 19
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Call to $$STRIP^XLFSTR is supported by IA: 10104
 ; Call to $$FMTE^XLFDT is supported by IA: 10103
 ; Call to $$NS^XUAF4 is supported by IA: 2171
 ; Call to $$STA^XUAF4 is supported by IA: 2171
 ; Call to F4^XUAF4 is supported by IA: 2171
 ;
ENELE(ELE) ; -- element end event handler
 Q
 ;
CHAR(TEXT) ; -- element char event handler
 Q
 ;
ABOSTELE(ELE,ATR) ; -- element start event handler for Patient ABO/Rh API
 I ELE="Patient" S ABO=$G(ATR("abo")),RH=$G(ATR("rh")),ABORH=$G(ATR("abo"))_" "_$G(ATR("rh"))
 Q
 ;
TRSTELE(ELE,ATR) ; -- element start event handler for Patient Transfusion Reaction History API
 I ELE="TransfusionReaction" D
  . S VBECLN=VBECLN+1,@VBECRES@(VBECLN)=$G(ATR("date"))_"^"_$G(ATR("type"))
  . D:$L($G(ATR("comment"))) BLDCMT(ATR("comment"))
  . I $G(ATR("unitId"))]"" S @VBECRES@(VBECLN)=@VBECRES@(VBECLN)_"^"_$G(ATR("unitId"))_"^"_$G(ATR("productTypeName"))_"^"_$G(ATR("productTypePrintName"))
 Q
 ;
BLDCMT(STR) ; Build comment text paragraph
 N CNT
P1 I $L(STR)<80 S CNT=$G(CNT)+1,@VBECRES@(VBECLN,CNT)=STR Q
 F L=80:-1:1 Q:$E(STR,L)=" "
 S CNT=$G(CNT)+1,@VBECRES@(VBECLN,CNT)=$E(STR,1,L-1),STR=$E(STR,L+1,99999) G P1
 ;
ABSTELE(ELE,ATR) ; -- element start event handler Patient Antibodies Identified API
 I ELE="Antibody" D
  . S VBECLN=VBECLN+1,@VBECRES@(VBECLN)=$G(ATR("name"))
  . D:$L($G(ATR("comment"))) BLDCMT(ATR("comment"))
 Q
 ;
AVUSTELE(ELE,ATR) ; -- element start event handler Patient Available Units API
 I ELE="Patient" S @VBECRES@("UNIT",$J,0)=$$STRIP^XLFSTR($G(ATR("abo"))," ")_"^"_$S($G(ATR("rh"))="P":"POS",$G(ATR("rh"))="N":"NEG",1:"")_U_$G(ATR("dfn"))_U_$G(ATR("firstName"))_U_$G(ATR("lastName"))_U_$G(ATR("dob"))_U_$G(ATR("ssn"))
 ;
 I ELE="Unit" D
  . S IDT=9999999-$G(ATR("dateAssigned")),EDT=$G(ATR("expDate"))
  . S EFLG=$S(EDT-DT<2:"*",EDT-DT<1:"**",1:"")
  . S EDT=$TR($$FMTE^XLFDT(EDT,"5DZ"),"@"," ")
  . S DTYP=$S($G(ATR("status"))="A":"Autologous",$G(ATR("status"))="D":"Directed",1:"")
  . ; Added $$STRIP to support 035 VistA MR 030407
  . I $G(ATR("divisionCode")) D F4^XUAF4($$STRIP^XLFSTR(ATR("divisionCode")," "),.DIVARR,"","")
  . S UDIV=$S($G(DIVARR("NAME"))]"":$G(DIVARR("NAME")),1:"Unknown")
  . F  Q:'$D(@VBECRES@("UNIT",$J,IDT))  S IDT=IDT+.0001
  . S @VBECRES@("UNIT",$J,IDT)=EFLG_U_EDT_" "_U_$$TRIM^XLFSTR($G(ATR("id")),"LR"," ")_U_$G(ATR("product"))_U_$G(ATR("volume"))_U_$G(ATR("abo"))_U_$G(ATR("rh"))_U_DTYP_U_UDIV_U
  . S @VBECRES@("UNIT",$J,IDT)=@VBECRES@("UNIT",$J,IDT)_$S($G(ATR("location"))]"":ATR("location"),1:"BLOOD BANK")_U_$G(ATR("productCode"))_U_$G(ATR("labelid"))
  . ;RLM Added the labelid
 Q
 ;
TRANSTEL(ELE,ATR) ; -- element start event handler for Transfusion History API
 I ELE="Transfusion" D
  . N IDT,TDT,UNITS,VAL
  . S VBECLN=VBECLN+1
  . S IDT=9999999-$P($G(ATR("date")),".")
  . S TDT=9999999-IDT
  . S UNITS=+$G(ATR("unitsPooled")) S:UNITS'>0 UNITS=1
  . ; 038 VistA MR 031407 - Increment date counter for multiple records
  . F  Q:'$D(@VBECRES@("TRAN",IDT))  S IDT=IDT+.0001
  . S @VBECRES@("TRAN",IDT)=TDT_"^"_UNITS_"\"_$G(ATR("productTypePrintName"))_";"
  . S @VBECRES@("TRAN",$G(ATR("productTypePrintName")))=$G(ATR("productTypeName"))
 Q
 ;
RPTSTELE(ELE,ATR) ; -- element start event handler
 I ELE="SpecimenTest" D
 . S VBECSTC=VBECSTC+1 D
 . . I ATR("printTestName")="DAT Poly CC" Q
 . . I ATR("printTestName")="DAT IgG CC" Q
 . . I $G(ATR("orderableTestName"))="TRW" Q
 . . S @VBECRES@("SPECIMEN",VBECSTC)=$G(ATR("cprsOrderId"))_"^"_$G(ATR("divisionCode"))_"^"_$G(ATR("enteringTechId"))_"^"_$G(ATR("orderableTestName"))_"^"_$G(ATR("printTestName"))_"^"_$G(ATR("requestorId"))
 . . S @VBECRES@("SPECIMEN",VBECSTC)=@VBECRES@("SPECIMEN",VBECSTC)_"^"_$G(ATR("result"))_"^"_$G(ATR("testDate"))
 . . I $G(ATR("comment"))]"" D
 . . . S @VBECRES@("SPECIMEN",VBECSTC,1)=$E($G(ATR("comment")),1,245)
 . . . S @VBECRES@("SPECIMEN",VBECSTC,2)=$E($G(ATR("comment")),246,490)
 . . . S @VBECRES@("SPECIMEN",VBECSTC,3)=$E($G(ATR("comment")),491,999)
 . . I $G(ATR("cannedComment"))]"" I $G(ATR("result"))="Pos" D
 . . . S VBECSTN("Antibody Screen Interp")="",VBECSTN("DAT Poly Interp")="",VBECSTN("DAT IgG Interp")="",VBECSTN("DAT Comp Interp")=""
 . . . I $G(ATR("printTestName"))]"",'$D(VBECSTN(ATR("printTestName"))) Q
 . . . S @VBECRES@("SPECIMEN",VBECSTC,4)=$E($G(ATR("cannedComment")),1,245)
 . . . S @VBECRES@("SPECIMEN",VBECSTC,5)=$E($G(ATR("cannedComment")),246,490)
 . . . S @VBECRES@("SPECIMEN",VBECSTC,6)=$E($G(ATR("cannedComment")),491,999)
 I ELE="ComponentRequest" D
 . S VBECCRC=VBECCRC+1 D
 . . S @VBECRES@("COMPONENT REQUEST",VBECCRC)=$G(ATR("componentClassName"))_"^"_ATR("unitsRequested")_"^"_$G(ATR("dateRequested"))_"^"_$G(ATR("dateWanted"))_"^"_$G(ATR("requestorId"))_"^"_$G(ATR("enteredById"))_"^"_$G(ATR("cprsOrderId"))
 I ELE="Unit" D
 . S VBECUNC=VBECUNC+1 D
 . . ; fixed VBECUNC variable to address 034 VistA MR 030407
 . . S @VBECRES@("UNIT",VBECUNC)=$G(ATR("expDate"))_"^"_$G(ATR("product"))_"^"_$G(ATR("abo"))_"^"_$G(ATR("rh"))_"^"_$G(ATR("divisionCode"))_"^"_$G(ATR("location"))_"^"_$G(ATR("status"))_"^"_$G(ATR("id"))
 Q
