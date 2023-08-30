VPRSDAHX ;SLC/MKB -- SDA Hx utilities ;7/29/22  14:11
 ;;1.0;VIRTUAL PATIENT RECORD;**30**;Sep 01, 2011;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNVSIT                     2028
 ; ^AUTTHF                       4295
 ; ^PXRMINDX                     4290
 ; PXPXRM                        4250
 ; WVRPCVPR, ^TMP("WVPREGST"     7199
 ;
 ;
 ; Queries called from GET^DDE, returns DLIST(#)=ien
 ; Expects context variables DFN, DSTRT, DSTOP, DMAX
 ;
HFM ; -- get V Health Factors, for Family History
 N ITEM,DATE,DA,X,VPRN S VPRN=0
 S ITEM=0 F  S ITEM=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM)) Q:ITEM<1  D  Q:VPRN'<DMAX
 . S X=$P($G(^AUTTHF(+ITEM,0)),U) I X'["FAMILY HISTORY",X'["FAMILY HX" Q
 . S DATE=DSTRT F  S DATE=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM,DATE)) Q:DATE<1!(DATE>DSTOP)  D  Q:VPRN'<DMAX
 .. S DA=0 F  S DA=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM,DATE,DA)) Q:DA<1  S VPRN=VPRN+1,DLIST(VPRN)=DA_U_ITEM Q:VPRN'<DMAX
 Q
 ;
HFS ; -- get V Health Factors, for Social History
 N ITEM,DATE,DA,VPRN S VPRN=0
 S ITEM=0 F  S ITEM=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM)) Q:ITEM<1  I $$SOCHIST(ITEM) D  Q:VPRN'<DMAX
 . S DATE=DSTRT F  S DATE=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM,DATE)) Q:DATE<1!(DATE>DSTOP)  D  Q:VPRN'<DMAX
 .. S DA=0 F  S DA=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM,DATE,DA)) Q:DA<1  S VPRN=VPRN+1,DLIST(VPRN)=DA_U_ITEM Q:VPRN'<DMAX
 Q
SOCHIST(IEN) ; -- find social history factors
 N X S X=$P($G(^AUTTHF(+IEN,0)),U)
 I (X["TOBACCO")!(X["SMOK") Q 1
 ;I (X["LIVES")!(X["LIVING") Q 1
 ;I (X["RELIGIO")!(X["SPIRIT") Q 1
 Q 0
 ;
 ;
HF1 ; -- get info for single HF record [ID Action]
 ; Expects/updates DIEN = #9000010.23 ien
 ;       Returns VPRVST = #9000010 ien
 ;              VPRVST0 = Visit zero node
 ;                VPRHF array
 K VPRHF D:$$ZERO^VPRENC("HF",+DIEN) VHF^PXPXRM(+DIEN,.VPRHF)
 S VPRVST=+$G(VPRHF("VISIT")),VPRVST0=$G(^AUPNVSIT(+VPRVST,0))
 S VPRHF=DIEN,DIEN=+DIEN
 Q
 ;
WVPLQ ; -- Women's Health Pregnancy Log [Query]
 ; Query called from GET^DDE, returns DLIST(1)=DFN if data
 ; Expects context variables DFN, DSTRT, DSTOP, DMAX
 ;
 K ^TMP("WVPREGST",$J)
 D BASELINE^WVRPCVPR(DFN)
 S:$D(^TMP("WVPREGST",$J,"BASELINE")) DLIST(1)=DFN
 ;S:$G(^TMP("WVPREGST",$J,"BASELINE","TO TIME"))'<$$FMADD^XLFDT(DT,-14) DLIST(1)=DFN
 Q
 ;
WVPL1(IEN) ; -- set up pregnancy API array (IEN will be DFN)
 ; Returns VPRPREG array to entity
 I $G(IEN)<1 S DDEOUT=1 Q
 D:'$D(^TMP("WVPREGST",$J,"BASELINE")) BASELINE^WVRPCVPR(IEN)
 I '$D(^TMP("WVPREGST",$J,"BASELINE")) S DDEOUT=1 Q
 M VPRPREG=^TMP("WVPREGST",$J,"BASELINE")
 S DFN=IEN,IEN=$G(^TMP("WVPREGST",$J,"BASELINE","EXTERNAL ID"))
 Q
