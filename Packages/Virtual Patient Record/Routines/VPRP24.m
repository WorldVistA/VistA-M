VPRP24 ;SLC/MKB -- SDA utilities for patch 24 ;11/8/18  14:11
 ;;1.0;VIRTUAL PATIENT RECORD;**24**;Sep 01, 2011;Build 3
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^ORD(100.98                   6982
 ; ORQ1, ^TMP("ORR",$J           3154
 ; XLFSTR                       10104
 ;
POST ; -- postinit
 ;D PCMM^VPRIDX
 Q
 ;
 ; The following api's support the P24 Partial Load entities:
 ;
RXQ ; -- find active Rx where Sig'[PI
 N ORDG,ORLIST,VPRI,VPRN,ORDER,SIG,PI
 S ORDG=+$O(^ORD(100.98,"B","O RX",0))
 D EN^ORQ1(DFN_";DPT(",ORDG,2) S VPRN=0
 S VPRI=0 F  S VPRI=$O(^TMP("ORR",$J,ORLIST,VPRI)) Q:VPRI<1  S ORDER=$G(^(VPRI)) D  Q:VPRN'<DMAX
 . S PI=$$WP^VPRSDA(+ORDER,"PI") Q:PI=""
 . S SIG=$$WP^VPRSDA(+ORDER,"SIG") Q:SIG[PI
 . S SIG=$$UP^XLFSTR(SIG),PI=$$UP^XLFSTR(PI)
 . S PI=$$TRIM^XLFSTR(PI) Q:SIG[PI
 . S VPRN=VPRN+1,DLIST(VPRN)=+ORDER
 K ^TMP("ORR",$J)
 Q
