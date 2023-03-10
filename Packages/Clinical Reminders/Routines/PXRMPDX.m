PXRMPDX ; SLC/PKR - API for previous encounter diagnosis ;10/26/2020
 ;;2.0;CLINICAL REMINDERS;**44**;Feb 04, 2005;Build 11
 ;
 ;====================
PRENDIAG(DFN,BDT,ENCDATE,DIAGLIST) ;
 ;Reference to ICDEX supported by ICR #5747
 ;Reference to LEXSRC2 supported by ICR #4083
 N CODE,CODELIST,DONE,DS,LD,LEXDATA,NL,PS
 N STATUS,SD,TEMP,VPOVIEN
 I $G(^PXRMINDX(9000010.07,"DATE BUILT"))="" Q -1
 S DS=$$CTFMD^PXRMDATE(BDT)-.000001
 F PS="P","S" D
 . S CODE="",DONE=0
 . F  S CODE=$O(^PXRMINDX(9000010.07,"10D","PPI",DFN,PS,CODE)) Q:CODE=""  D
 .. K LEXDATA
 .. S STATUS=$$STATCHK^LEXSRC2(CODE,ENCDATE,.LEXDATA,30)
 ..;If the code is not active on the encounter date skip it.
 .. I $P(STATUS,U,1)=0 Q
 .. S DATE=DS
 .. F  S DATE=$O(^PXRMINDX(9000010.07,"10D","PPI",DFN,PS,CODE,DATE)) Q:DATE=""  D
 ... S VPOVIEN=""
 ... F  S VPOVIEN=$O(^PXRMINDX(9000010.07,"10D","PPI",DFN,PS,CODE,DATE,VPOVIEN)) Q:VPOVIEN=""  D
 ....;Filters
 .... S TEMP=^AUPNVPOV(VPOVIEN,0)
 .... S VISITIEN=$P(TEMP,U,3)
 ....;The encounter status must be CHECKED OUT.
 ....;ICR #4850
 .... S STATUS=$$STATUS^SDPCE(VISITIEN)
 .... I $P(STATUS,U,2)'="CHECKED OUT" Q
 .... S CODEIEN=$P($$CODEN^ICDEX(CODE,80),"~",1)
 .... S TEMP=$$SD^ICDEX(80,CODEIEN)
 .... I $D(LD(CODE)) Q
 .... S SD(TEMP,CODE)=$P(LEXDATA(1),U,1)
 .... S LD(CODE)=$P(LEXDATA(1),U,2)
 S DIAGLIST(1)="^Prior Encounter Diagnoses"
 I '$D(SD) Q 0
 S TEMP="",NL=1
 F  S TEMP=$O(SD(TEMP)) Q:TEMP=""  D
 . S CODE=$O(SD(TEMP,""))
 . S NL=NL+1
 . S DIAGLIST(NL)=CODE_U_TEMP_"^^^^^^^"_SD(TEMP,CODE)_U_LD(CODE)
 Q NL
 ;
