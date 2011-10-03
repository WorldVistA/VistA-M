IBCONS2 ;ALB/CPM - NSC W/INSURANCE OUTPUT (CON'T) ;31-JAN-92
 ;;2.0;INTEGRATED BILLING;**19,36,54,66,91,99,108,120,142,174,155**;21-MAR-94
 ;
 ;MAP TO DGCRONS2
 ;
LOOP1 ; Compilation for both Inpatient Admisssion and Discharge reports.
 N DA,IBADM K ^TMP($J,"PATIENT INCLUDE"),^TMP($J,"PATIENT EXCLUDE")
 D DIV
 F I=(IBBEG-.0001):0 S I=$O(^DGPM(IBSUB,I)) Q:'I!(I>(IBEND+.99))  D
 . S DFN=0 F  S DFN=$O(^DGPM(IBSUB,I,DFN)) Q:'DFN  S DA=+$O(^(DFN,0)) D  D:PTF PTF I $G(IBDV) D PROC K IBADMVT
 ..  S:IBINPT=2 DA=+$P($G(^DGPM(DA,0)),"^",14),IBADM=+$G(^DGPM(DA,0))
 ..  S PTF=$P($G(^DGPM(DA,0)),"^",16)
 ..  S IBADMVT=DA
 ..  S IBDV=+$P($G(^DIC(42,+$P($G(^DGPM(DA,0)),"^",6),0)),"^",11)
 K ^TMP($J,"PATIENT INCLUDE"),^TMP($J,"PATIENT EXCLUDE")
 Q
 ;
 ;
LOOP2 ; Compilation for the Outpatient report
 N DFN,IBDTA,IBDV,IBVAL,IBFILTER,IBCBK,IBNO,IBOE,IBOE0,IBSTOP,IBOEZ,Y,Y0,IBQUERY2
 D DIV K ^TMP($J,"PATIENT INCLUDE"),^TMP($J,"PATIENT EXCLUDE")
 ;
 S IBQUERY2=""
 S IBVAL("BDT")=IBBEG,IBVAL("EDT")=IBEND+.99
 S IBFILTER="I '$P(Y0,U,6)"
 S IBCBK="D CALLBCK^IBCONS2(Y,Y0,.IBQUERY2)"
 K ^TMP("IBOEC",$J)
 D SCAN^IBSDU("DATE/TIME",.IBVAL,IBFILTER,IBCBK,1) K ^TMP("DIERR",$J)
 I $G(IBQUERY2) D CLOSE^IBSDU(IBQUERY2)
 ;
 ; Process stand-alone add/edits extracted
 S DFN=0 F  S DFN=$O(^TMP("IBOEC",$J,DFN)) Q:'DFN  I $D(^DPT(DFN,0)) D
 . S IBDTA=0 F  S IBDTA=$O(^TMP("IBOEC",$J,DFN,IBDTA)) Q:'IBDTA  D
 .. K IBOE,IBSTOP,IBCOMB
 .. S IBNO=1
 .. S IBOEZ=0 F  S IBOEZ=$O(^TMP("IBOEC",$J,DFN,IBDTA,IBOEZ)) Q:'IBOEZ  S IBOE0=$$SCE^IBSDU(IBOEZ,"",0) D
 ... S IBDV=$P(IBOE0,U,11)
 ... S:$L($G(IBOE(IBNO)))+$L(IBOEZ)+1>200 IBNO=IBNO+1
 ... S IBOE(IBNO)=$G(IBOE(IBNO))_IBOEZ_U I '$G(IBOE) S IBOE=+IBOE(1)
 ... S Z=+$P($G(^DIC(40.7,+$P(IBOE0,U,3),0)),U,2) S:Z IBCOMB(Z)=$G(IBCOMB(Z))+1
 .. S:'$D(IBSTOP) IBSTOP="Add/Edit Stop Code^"
 .. S Z=0 F  S Z=$O(IBCOMB(Z)) Q:'Z  S IBSTOP=IBSTOP_Z_$S(IBCOMB(Z)=1:"",1:"(x"_IBCOMB(Z)_")")_U
 .. ;
 .. S I=IBDTA
 .. I $G(IBOE) D PROCO ;All add/edit encounters for a patient/date on a single line
 ;
 K ^TMP("IBOEC",$J),^TMP($J,"PATIENT INCLUDE"),^TMP($J,"PATIENT EXCLUDE")
 Q
 ;
CALLBCK(IBOE,IBOE0,IBQUERY2) ; Executed by scan call back logic to process encounters
 ; IBOE = encounter ien
 ; IBOE0 = 0-node of the encounter
 ;
 N DFN,I,IBDC,IBDS,IBDV,IBSTOP,IBT,Z
 I '$$BDSRC^IBEFUNC3($P($G(IBOE0),U,5)) Q  ; non-billable visit data source
 ;
 S IBT=$P(IBOE0,U,8),DFN=$P(IBOE0,U,2),IBDV=$P(IBOE0,U,11),(IBDS,IBDC)=""
 S I=+IBOE0
 Q:'I  Q:DFN=""
 I IBT=1 D
 . S IBDC=+$P(IBOE0,U,4)
 . I IBDV="" S IBDV=$P($G(^SC(IBDC,0)),U,15)
 ;
 I IBT=3 D
 . S IBDS=$$DISND^IBSDU(IBOE,IBOE0)
 . I IBDV="" S IBDV=$P(IBDS,U,4)
 ;
 Q:'$$VALID()
 ;
 ; Screen to only include 1-3 originating process and
 ;  for 1 or 2, include only those that have appt types indicating they
 ;  are included on reports 
 ;
 I $S(IBT<3:$$RPT^IBEFUNC($P(IBOE0,U,10),+IBOE0),1:IBT=3) D
 . ; Extract add/edits to global so we can combine the data into one line (2 lines if RNB defined)
 . I IBT=2 D  Q  ; Stand-alone Add/Edits
 .. I VAUTD'=1 Q:'$D(VAUTD(+IBDV))
 .. I VAUTD=1 Q:'IBDV
 .. I +$$RNBOE(IBOE) S ^TMP("IBOEC",$J,DFN,(IBOE0\1)_".",IBOE)="" Q
 .. S ^TMP("IBOEC",$J,DFN,IBOE0\1,IBOE)=""
 . ;
 . I IBT=1 D  Q  ;Appointments
 .. I IBDC D
 ... S X=$$CHILD(IBOE,IBOE0,.IBVAL,.IBSTOP,.IBQUERY2)
 ... S IBSTOP="Clinic: "_$P($G(^SC(IBDC,0)),U)_$S('X:"",1:"  --  "_IBSTOP)
 ... S I=+IBOE0 D PROCO
 . ;
 . I IBT=3 D  Q  ;Registration
 .. N X
 .. Q:'$$DISCT^IBEFUNC(IBOE,IBOE0)
 .. S X=$$CHILD(IBOE,IBOE0,.IBVAL,.IBSTOP,.IBQUERY2)
 .. S IBSTOP="Registration: "_$P($G(^DIC(37,+$P(IBDS,U,7),0)),U)_$S('X:"",1:"  --  "_IBSTOP)
 .. S I=+IBOE0 D PROCO
 ;
 Q
 ;
CHILD(IBOE,IBOE0,IBVAL,IBSTOP,IBQUERY2) ;Find any child add/edits
 ;  IBSTOP and IBQUERY2 are returned
 N IBVAL1,IBFILTER,IBCBK,IBCOMB,Z
 M IBVAL1=IBVAL
 S (IBFILTER,IBSTOP)="",IBVAL1("DFN")=+$P(IBOE0,U,2)
 S IBCBK="I $S(Y=IBOE:1,1:$P(Y0,U,6)=IBOE),$P(Y0,U,3),$$RPT^IBEFUNC($P(Y0,U,10),+Y0) S Z=+$P($G(^DIC(40.7,+$P(Y0,U,3),0)),U,2) S:Z IBCOMB(Z)=$G(IBCOMB(Z))+1"
 D SCAN^IBSDU("PATIENT/DATE",.IBVAL1,IBFILTER,IBCBK,0,.IBQUERY2) K ^TMP("DIERR",$J)
 S Z=0 F  S Z=$O(IBCOMB(Z)) Q:'Z  S IBSTOP=$S(IBSTOP="":"Stop Codes^",1:IBSTOP)_Z_$S(IBCOMB(Z)=1:"",1:"(x"_IBCOMB(Z)_")")_U
 Q (IBSTOP'="")
 ;
PROC ;  -process each episode of care
 Q:'$$VALID()
PROCO ; Entrypoint for outpatient loop2
 K IBRMARK
 I '$G(IBSC) D TRACK^IBCONS3 ;     -find tracking entry get reason not billable
 I +$G(IBSC) S IBRMARK="{ALL MOVES SC}" ; stays with all SC moves not added to CT but on rpt w/RNB  ** PATCH 66
 D BILL,SET ;          -on billed or unbilled list
 Q
 ;
VALID() ;
 N IBOK
 S IBOK=0
 I +$G(IBSELRNG),$D(^TMP($J,"PATIENT EXCLUDE",DFN)) G VALIDQ ; pat already excluded from select range ** PATCH 66
 I +$G(IBSELRNG),+$G(IBSELRNG)<3,'$$PAT(DFN) G VALIDQ ; patient in selected range  ** PATCH 66
 I VAUTD'=1 G:'$D(VAUTD(+IBDV)) VALIDQ
 I VAUTD=1 G:'IBDV VALIDQ
 D PTCHK G:'IBFLAG VALIDQ ;  -is patient a vet and have ins data
 D INS G:'IBFLAG VALIDQ ;    -is insurance valid for date of care
 I +$G(IBSELRNG)=3,'$$PTINS(DFN) G VALIDQ ; patient ins is included in range  ** PATCH 66
 S IBOK=1
VALIDQ Q IBOK
 ;
INS S IBFLAG=$$INSURED^IBCNS1(DFN,I)
 I +IBFLAG,+IBINPT,'$$PTCOV^IBCNSU3(DFN,+I,"INPATIENT") S IBFLAG=0
 Q
 ;
PTCHK S IBFLAG=0 I $D(^DPT(+DFN,.312)),$G(^("VET"))="Y" S IBFLAG=1
 ; Patch #36 - removes non-veteran eligibilities and inpatient visits
 I 'IBINPT D
 .N IBTEMP,IBOE0 S IBTEMP=$$SCE^IBSDU(+IBOE,13,0),IBOE0=$$SCE^IBSDU(+IBOE)
 .I $P($G(^DIC(8,+IBTEMP,0)),U,5)="N" S IBFLAG=0 Q
 .I '$$APPTCT^IBEFUNC(IBOE0) S IBFLAG=0 Q
 Q
 ;
SET N DPT0,IBSUBSC2,IBSUBSC3,IBSUBSC4,IBSUBSC6 S DPT0=$G(^DPT(+DFN,0))
 S IBSUBSC2=+IBDV I +$G(IBSELCDV) S IBSUBSC2="COMBINED"
 S IBSUBSC3=$S(B]"":2,1:1)
 S IBSUBSC4=$P(DPT0,U,1) I +$G(IBSELTRM) S IBSUBSC4=+$$TERMDG(DFN)
 S IBSUBSC6=I F IBSUBSC6=IBSUBSC6:.000001 Q:'$D(^TMP($J,IBSUBSC2,IBSUBSC3,IBSUBSC4,DFN,IBSUBSC6))
 S ^TMP($J,IBSUBSC2,IBSUBSC3,IBSUBSC4,DFN,IBSUBSC6)=B
 I $D(IBSTOP),'$D(^TMP($J,IBSUBSC2,IBSUBSC3,IBSUBSC4,DFN,IBSUBSC6,1)) S ^(1)=IBSTOP
 I $G(IBRMARK)'="" S ^TMP($J,IBSUBSC2,IBSUBSC3,IBSUBSC4,DFN,IBSUBSC6,2)=$G(IBRMARK)
 K IBSTOP,IBRMARK
 Q
 ;
BILL ;  Add to billed list if is insurance bill, not canceled
 ;     if opt, date is in list, if inpt, admission date = event date
 ;  ** PATCH 66 modified to include check for bill authorized status and add that to the stored TMP array
 ;
 S B="",I1=$S(IBINPT=2:IBADM,IBINPT:I,1:I\1),IBAUTH=2 N IB0
 ; -- the following line modified in patch 19 to check for only inpt. bills ($p(^(0),u,5)<3) are counted as bills,
 ;    for when there is an outpatient bill with the same event date.
 I IBINPT,$D(^DGCR(399,"C",DFN)) F M=0:0 S M=$O(^DGCR(399,"C",DFN,M)) Q:'M  D  Q:$L(B)>200
 . S IB0=$G(^DGCR(399,M,0))
 . I IB0'="",$P(IB0,"^",5)<3,$P(IB0,"^",13)<7,$P($P(IB0,"^",3),".")=$P(I1,"."),$P(IB0,"^",11)="i" S B=B_M_"^" I $P(IB0,"^",13)<2 S IBAUTH=1
 ;
 I 'IBINPT,$D(^DGCR(399,"AOPV",DFN,I1)) F M=0:0 S M=$O(^DGCR(399,"AOPV",DFN,I1,M)) Q:'M  D  Q:$L(B)>200
 . S IB0=$G(^DGCR(399,M,0))
 . I IB0'="",$P(IB0,"^",13)<7,$P(IB0,"^",11)="i" S B=B_M_"^" I $P(IB0,"^",13)<2 S IBAUTH=1
 I +B S B=IBAUTH_"^"_B
 Q
 ;
PTF ;  if all movements are for sc condition then not billable
 ;
 S IBSC="" Q:'$D(^DGPT(+PTF))
 S IBMOV=0 F  S IBMOV=$O(^DGPT(PTF,"M",IBMOV)) Q:'IBMOV  S IBSC=$P($G(^(IBMOV,0)),"^",18) I IBSC=2!(IBSC="") Q
 S IBSC=$S(IBSC=2!(IBSC=""):0,1:1)
 Q
DIV ;adds the requested divisions to the report
 N IBDIV I +$G(IBSELCDV) S ^TMP($J,"COMBINED")="" Q
 I VAUTD'=1 D
 .S IBDIV="" F  S IBDIV=$O(VAUTD(IBDIV)) Q:'IBDIV  S ^TMP($J,IBDIV)=""
 I VAUTD=1 D
 .S IBDIV="" F  S IBDIV=$O(^DG(40.8,IBDIV)) Q:IBDIV']""!(+IBDIV'=IBDIV)  I $P($G(^DG(40.8,IBDIV,0)),"^",1)]"" S ^TMP($J,IBDIV)=""
 Q
 ;
PAT(DFN) ; true if patient is included in range requested   ** PATCH 66
 N IBX,IBY S IBX=1
 I $D(^TMP($J,"PATIENT INCLUDE",DFN)) S IBX=1 G PATQ
 I $D(^TMP($J,"PATIENT EXCLUDE",DFN)) S IBX=0 G PATQ
 ;
 I +$G(IBSELRNG)=2 S IBY=$$TERMDG(DFN) D
 . I IBY<$G(IBSELSR1) S IBX=0
 . I +$G(IBSELSR2),IBY>IBSELSR2 S IBX=0
 ;
 I +$G(IBSELRNG)=1 S IBY=$P($G(^DPT(+DFN,0)),U,1),IBX=$$STGRNG(IBY)
 ;
 I +IBX S ^TMP($J,"PATIENT INCLUDE",DFN)=""
 I 'IBX S ^TMP($J,"PATIENT EXCLUDE",DFN)=""
PATQ Q IBX
 ;
PTINS(DFN) ; check if patients ins is within selected range  ** PATCH 66
 N IBY,IBX,IBAR,IBI S IBX=1
 I $D(^TMP($J,"PATIENT INCLUDE",DFN)) S IBX=1 G PTINSQ
 I $D(^TMP($J,"PATIENT EXCLUDE",DFN)) S IBX=0 G PTINSQ
 ;
 I $G(IBSELRNG)=3 D ALL^IBCNS1(DFN,"IBAR",1,IBBEG),ALL^IBCNS1(DFN,"IBAR",1,IBEND) S IBX=0
 S IBI=0 F  S IBI=$O(IBAR(IBI)) Q:'IBI  S IBY=+$G(IBAR(IBI,0)),IBY=$P($G(^DIC(36,+IBY,0)),U,1) I +$$STGRNG(IBY) S IBX=1 Q
 ;
 I +IBX S ^TMP($J,"PATIENT INCLUDE",DFN)=""
 I 'IBX S ^TMP($J,"PATIENT EXCLUDE",DFN)=""
PTINSQ Q IBX
 ;
STGRNG(STRNG) ; check if the string passed in is contained within the selected ASCII range  ** PATCH 66
 N IBSB,IBSE,IBI,IBY,IBX S IBX=1,STRNG=$$ASCII($G(STRNG))
 F IBI=1:1 S IBSB=$P($G(IBSELSR1),",",IBI),IBY=$P(STRNG,",",IBI) Q:'IBSB  Q:IBSB<IBY  I IBSB>IBY S IBX=0 Q
 F IBI=1:1 S IBSE=$P($G(IBSELSR2),",",IBI),IBY=$P(STRNG,",",IBI) Q:'IBSE  Q:IBSE>IBY  I IBSE<IBY S IBX=0 Q
 Q IBX
 ;
ASCII(STRNG) ; returns string in ASCII ** PATCH 66
 N IBI,IBX,IBY S IBX=""
 I $G(STRNG)'="" F IBI=1:1 S IBY=$E(STRNG,IBI) Q:IBY=""  S IBX=IBX_$A(IBY)_"," Q:$L(IBX)>196
 Q IBX
 ;
TERMDG(DFN) ; returns a patients terminal digit  ** PATCH 66
 N TERMD,DPT0,SSN S TERMD="",DPT0=$G(^DPT(+DFN,0)),SSN=$P(DPT0,"^",9)
 S TERMD=$E(SSN,8,9)_$E(SSN,6,7)_$E(SSN,4,5)_$E(SSN,1,3)
 Q TERMD
 ;
RNBOE(IBOE) ; return a Reason Not Billable for the encounter if one can be found
 N IBX,IBR S IBR="" I +$G(IBOE) S IBX=+$O(^IBT(356,"ASCE",+IBOE,0)) I +IBX S IBR=$P($G(^IBT(356,IBX,0)),U,19)
 Q IBR
