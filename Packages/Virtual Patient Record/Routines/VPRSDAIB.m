VPRSDAIB ;SLC/MKB,MRY -- Integrated Billing utilities ;10/18/22  14:11
 ;;1.0;VIRTUAL PATIENT RECORD;**31**;Sep 01, 2011;Build 3
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; IBBAPI                        4419
 ;
INQ ; -- Insurance query, creates VPRINS and DLIST arrays
 ; Expects DSTRT, DSTOP, DMAX from DDEGET and returns DLIST(#)=ien
 N NUM,I,VPRDT,VPRSTS,VPRX,IEN,CNT
 S VPRSTS=$G(FILTER("status"),"ARB"),VPRDT=DT,CNT=0
 I VPRSTS["A" S VPRDT="" ;no date if requesting inactive policies
 S:$G(DFN) NUM=$$INSUR^IBBAPI(DFN,VPRDT,VPRSTS,.VPRX,"*") Q:NUM<1
 S I=0 F  S I=$O(VPRX("IBBAPI","INSUR",I)) Q:(I<1)!(CNT>=DMAX)  D
 . I DSTRT,VPRX("IBBAPI","INSUR",I,10)<DSTRT Q  ;Effective date
 . I DSTOP,VPRX("IBBAPI","INSUR",I,10)>DSTOP Q  ;Effective date
 . S IEN=+$G(VPRX("IBBAPI","INSUR",I))
 . S DLIST(I)=IEN_","_DFN,CNT=CNT+1
 M VPRINS=VPRX("IBBAPI","INSUR")
 Q
 ;
INS1(IEN) ; -- set up one insurance record
 ; Returns VPRP = # in VPRINS(#) of current record
 N I K VPRP
 I '$G(IEN)!'$G(DFN) S DDEOUT=1 Q
 I '$D(VPRINS) D   ;create VPRINS array if needed
 . N NUM,VPRDT,VPRSTS,VPRX
 . S VPRDT="",VPRSTS="ARB" ;all policies
 . S NUM=$$INSUR^IBBAPI(DFN,VPRDT,VPRSTS,.VPRX,"*")
 . I NUM M VPRINS=VPRX("IBBAPI","INSUR")
 S I=0 F  S I=$O(VPRINS(I)) Q:I<1  I +$G(VPRINS(I))=+IEN S VPRP=I Q
 I '$G(VPRP) S DDEOUT=1 Q
 Q
 ;
DEL ; -- ID Action for Delete entity
 ; Expects DIEN, AVPR seq# in FILTER("sequence")
 ; Returns VPRIB(#)=data nodes, VPRINS(#)=IBBAPI data elements
 N SEQ K VPRIB,VPRINS
 S SEQ=+$G(FILTER("sequence"))
 I SEQ,$G(DIEN) D
 . M VPRIB=^XTMP("VPR-"_SEQ,DIEN)
 . S VPRINS(1)=$P($G(VPRIB(0)),"^",1)  ;Ins. Comp. ien
 . S VPRINS(8)=$P($G(VPRIB(0)),"^",18) ;Policy ien
 . S VPRINS(14)=$P($G(VPRIB(7)),"^",2) ;Subscriber ID
 Q
