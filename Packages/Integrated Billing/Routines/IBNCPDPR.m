IBNCPDPR ;WOIFO/SS - ECME RELEASE CHARGES ON HOLD ;3/6/08  16:23
 ;;2.0;INTEGRATED BILLING;**276,347,384,452**;21-MAR-94;Build 26
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;==========
 ;version of "IB MT RELEASE CHARGES" option (^IBRREL) without PATIENT prompt
 ;(patient is selected from the User Screen)
 ;designed to use from ECME User Screen (IA #) in order to access Release
 ;copay functionality from ECME
 ;
RELH(DFN,IBRXIEN,IBREFL,IBMODE) ; entry point
 N IBNUM,IBPT
 N IBNCPDPR,IBNCPDPRDEF S IBNCPDPR=1
 K IBA,PRCABN,BPX,IBI,IBCNT,IB350
 S IB350=0
 S IBI=0 F IBNUM=1:1 S IBI=$O(^IB("AH",DFN,IBI)) Q:'IBI  S IBA(IBNUM)=IBI
 I '$D(IBA) W !!,"This patient does not have any charges 'on hold.'",! D PAUSE^VALM1 G RELHX
 ;
 S IBPT=$$PT^IBEFUNC(DFN) W @IOF,$P(IBPT,"^"),"      Pt ID: ",$P(IBPT,"^",2),! S I="",$P(I,"-",80)="" W I K I
 ;if the user selected specific RX/refill
 I IBMODE="C" D  S:IB350>0 IBNCPDPRDEF=$P(IB350,U,2)    ; default response# for list
 . ;find item that matches selected RX/refill
 . S IBCNT=0
 . F  S IBCNT=$O(IBA(IBCNT)) Q:+IBCNT=0  D  Q:IB350>0
 . . S BPX=$P($G(^IB(IBA(IBCNT),0)),U,4)
 . . I $P(BPX,":")'=52 Q  ;if not RX type
 . . I $P($P(BPX,";"),":",2)'=IBRXIEN Q  ;if not given RX#
 . . I IBREFL>0 I $P($P(BPX,";",2),":",2)'=IBREFL Q  ;if not given refill #
 . . S IB350=IBA(IBCNT)_"^"_IBCNT
 ;
 I IBMODE="C",IB350=0 D  G RELHX
 . W !!,"There is no copay charge 'on hold' for this Rx.",!
 . D PAUSE^VALM1
 . Q
 ;
 ; call the routine to display and release charges on hold
 D RESUME^IBRREL
 ;
RELHX ;
 Q
 ;
