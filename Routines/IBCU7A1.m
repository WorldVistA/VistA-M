IBCU7A1 ;ALB/ARH - BILL PROCEDURE MANIPULATIONS (BUNDLED) ; 10-OCT-03
 ;;2.0;INTEGRATED BILLING;**245,270**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
BNDL(IBIFN) ; manipulate a bill's CPT codes, replace bundled codes
 ; on facility and profesional bills global codes should be billed using their components
 ; on freestanding bills component codes should be billed as global
 ; - on facility bill, if a global code is found in the clinical data and on the bill then 
 ;   replace it on the bill with the institutional components
 ; - on professional bill, if the global code is found in the clinical data and the institutional components
 ;   are found on the bill then replace the institutional components with the professional components
 ; - on a freestanding bill if all institutional and professional components are found then
 ;   replace them with the global code
 ; maximum of 10 is insurance against infinite loops
 N IB0,IBCT,IBDVTY,IBTYPE,IBI,IBJ,IBLN,IBGLB,IBNLN,IBNEW,IBDEL,IBRPL,IBX,IBMSG,IBCHANGE S IBCHANGE=0
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)) Q:IB0=""
 S IBCT=$P(IB0,U,27) Q:'IBCT  S IBDVTY=$P($$RCDV^IBCRU8($P(IB0,U,22)),U,3)
 S IBTYPE=$S(IBDVTY=3:3,1:+IBCT)
 ;
 I +$O(^DGCR(399,+$G(IBIFN),"CP","B","94017;ICPT("),-1)<93000 Q  ; none of the bundled codes on bill
 ;
 I IBDVTY'=3 D GETSD^IBCU7U(IBIFN) ; for provider based sites global charge should be in clincal data
 ;
 ; loop through list of bundled procedures and find any on bill
 F IBI=1:1 S IBLN=$P($T(IPBI+IBI),";;",2) Q:IBLN=""  D
 . S IBGLB=$P(IBLN,":",1),IBCHANGE=0
 . ;
 . S IBNLN=$$IPB(IBLN,IBTYPE) Q:'IBNLN  S IBNEW=$P(IBNLN,":",2),IBDEL=$P(IBNLN,":",1)
 . ;
 . I IBDVTY'=3,'$D(^UTILITY($J,"CPT-CLN",+IBGLB)) Q
 . ;
 . ; search the bill for the list of procedures to be replaced
 . F IBJ=1:1 S IBRPL=$$FND(IBIFN,IBDEL) Q:'IBRPL  D  Q:IBJ>10
 .. ;
 .. I IBDVTY'=3,'$D(^UTILITY($J,"CPT-CLN",+IBGLB,+IBRPL)) Q
 .. S IBRPL=$P(IBRPL,U,2,999) I $L(IBRPL,U)'=$L(IBDEL,U) Q
 .. ;
 .. I +$$RPL(IBIFN,IBNEW,IBRPL) S IBCHANGE=1 ; replace procedures
 . ;
 . I +IBCHANGE S IBMSG(IBI)=$TR(IBDEL,"^",",")_" replaced by "_$TR(IBNEW,"^",",")
 ;
 I '$D(ZTQUEUED),'$G(IBAUTO),+$O(IBMSG(0)) S IBI=0 F  S IBI=$O(IBMSG(IBI)) Q:'IBI  W !,IBMSG(IBI)
 Q
 ;
RPL(IBIFN,NEWCPTS,OLDLIST) ; replace procedures on the bill
 ; Input:  NEWCPTS - list of CPT codes to add to the bill
 ;         OLDLIST - list of procedure ifn's on the bill to be replaced
 ; Output: returns true if changes made
 ; the list of new and replaced may not be the same length
 ; - if more CPT's to be added than exist then the first existing procedure is copied for the new CPT
 ; - if fewer CPT's to be added than exist then the extra entries on the bill are deleted
 N IBJ,IBFFN,IBRFN,IBNCPT,IBFND S IBFND=0
 ;
 S NEWCPTS=$G(NEWCPTS),OLDLIST=$G(OLDLIST),IBFFN=+OLDLIST
 ;
 F IBJ=1:1 S IBRFN=$P(OLDLIST,U,IBJ),IBNCPT=$P(NEWCPTS,U,IBJ) Q:('IBRFN)&('IBNCPT)  D  Q:'IBFND
 . I +IBRFN,'IBNCPT S IBFND=$$DELCPT^IBCU7U(IBIFN,IBRFN) Q
 . I 'IBRFN,+IBNCPT S IBFND=$$COPYCPT^IBCU7U(IBIFN,IBFFN,IBNCPT) Q
 . I +IBRFN,+IBNCPT S IBFND=$$EDITCPT^IBCU7U(IBIFN,IBRFN,IBNCPT)
 ;
 Q IBFND
 ;
FND(IBIFN,LIST) ; find first set of the procedures on the bill to be replaced
 ; if all found then returns procedure date followed by 'CP' ifn list
 ; Input:  list of CPT's to be replaced separated by '^', internal format
 ; Output: procedure date ^ ifn of procedures in bill CP multiple
 N IBJ,IBC1,IBC1N,IBC1D,IBC2,IBC2N,IBC2D,IBFND,IBNLIST S (IBFND,IBNLIST)=0 I '$G(LIST) G FNDQ
 ;
 ; start with the first procedure to be replaced if it is on the bill then search for the rest on same date
 S IBC1=$P(LIST,U,1)
 S IBC1N=0 F  S IBC1N=$O(^DGCR(399,+$G(IBIFN),"CP","B",IBC1_";ICPT(",IBC1N)) Q:'IBC1N  D  Q:IBFND
 . S IBC1D=$P($G(^DGCR(399,IBIFN,"CP",IBC1N,0)),U,2)
 . S IBFND=1,IBNLIST=IBC1D_U_IBC1N
 . ;
 . ; find other procedures to be replaced for same date
 . F IBJ=2:1 S IBC2=$P(LIST,U,IBJ) Q:'IBC2  S IBFND=0 D  Q:'IBFND
 .. S IBC2N=0 F  S IBC2N=$O(^DGCR(399,IBIFN,"CP","B",IBC2_";ICPT(",IBC2N)) Q:'IBC2N  D  Q:IBFND
 ... S IBC2D=$P($G(^DGCR(399,IBIFN,"CP",IBC2N,0)),U,2) I IBC1D'=IBC2D S IBFND=0 Q
 ... S IBFND=1,IBNLIST=IBNLIST_U_IBC2N
 . ;
 . I 'IBFND S IBNLIST=0
 ;
FNDQ Q IBNLIST
 ;
CHKIPB(CPT,TYPE) ; return procedures that may replace procedure passed in
 ; Input:  TYPE - 1 for institutional, 2 for professional, 3 for Non-Provider Based
 ; Output: Procedures to be replaced ':' Procedures they are replaced with
 N IBX,IBI,IBLN,IBRPL S IBX="",CPT=$G(CPT),TYPE=+$G(TYPE)
 I +TYPE,CPT>92999,CPT<94017 F IBI=1:1 S IBLN=$P($T(IPBI+IBI),";;",2) Q:IBLN=""  D  Q:+IBX
 . S IBRPL=$$IPB(IBLN,TYPE) I $P(IBRPL,":",1)[CPT S IBX=IBRPL
 Q IBX
 ;
 ;
IPB(LINE,TYPE) ; return procedures to be replaced and those they are replaced by for the type of bill
 ; Input:  LINE - line of bundled procedures from IPBI
 ;         TYPE - 1 for institutional, 2 for professional, 3 for Non-Provider Based
 ; Output: Procedures to be replaced ':' Procedures they are replaced with
 ; - institutional type the global is replaced by the technical componentes
 ; - professional type: the institutional components are replaced by the professional components
 ; - non-provider based: the institutional and professional components are preplaced by the global
 ;
 N IBNEW,IBDEL,IBX S (IBX,IBDEL,IBNEW)="",TYPE=$G(TYPE),LINE=$G(LINE)
 I TYPE=1 S IBNEW=$P(LINE,":",2),IBDEL=$P(LINE,":",1)
 I TYPE=2 S IBNEW=$P(LINE,":",3),IBDEL=$P(LINE,":",2)
 I TYPE=3 S IBNEW=$P(LINE,":",1),IBDEL=$P(LINE,":",2)_U_$P(LINE,":",3)
 S IBX=IBDEL_":"_IBNEW
 Q IBX
 ;
IPBI ; Facility Provider Based Replace Global by Technical Component: global:technical:professional
 ;;93000:93005:93010
 ;;93015:93017:93016^93018
 ;;93040:93041:93042
 ;;93224:93225^93226:93227
 ;;93230:93231^93232:93233
 ;;93235:93236:93237
 ;;93268:93270^93271:93272
 ;;93720:93721:93722
 ;;93784:93786^93788:93790
 ;;94014:94015:94016
 ;;
