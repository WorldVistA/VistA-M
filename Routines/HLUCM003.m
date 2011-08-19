HLUCM003 ;CIOFO-O/LJA - HL7/Capacity Mgt API-II ;10/23/01 12:01
 ;;1.6;HEALTH LEVEL SEVEN;**88,103**;Oct 13, 1995
 ;
ADJTIME ; Adjust ^TMP times on basis of unit...
 N IENPAR
 S IENPAR=0
 F  S IENPAR=$O(^TMP($J,"HLPARENT",IENPAR)) Q:'IENPAR  D
 .  D ADJPAR(+IENPAR)
 Q
 ;
ADJPAR(IENPAR) ; Adjust times for one unit...
 N BEG,DATA,END,IEN772,NUM,PREVTM,TIME
 ;
 S NUM=0,IEN772=0
 F  S IEN772=$O(^TMP($J,"HLPARENT",+IENPAR,IEN772)) Q:'IEN772  D
 .  S NUM=NUM+1
 ;
 ; No adjustments necessary if only one message...
 QUIT:NUM'>1  ;->
 ;
 ; Find all times...
 S IEN772=0
 F  S IEN772=$O(^TMP($J,"HLPARENT",+IENPAR,IEN772)) Q:IEN772'>0  D
 .  S DATA=$P($G(^TMP($J,"HLCHILD",+IEN772)),"~",2,999) QUIT:DATA']""  ;->
 .  S X=$P(DATA,U,4) I X?7N.E S TIME(X)=""
 .  S X=$P(DATA,U,5) I X?7N.E S TIME(X)=""
 ;
 S BEG=$O(TIME(0)),END=$O(TIME(":"),-1)
 ;
 ; Set 1st time and last time...
 S IEN772=$O(^TMP($J,"HLPARENT",+IENPAR,0)) Q:IEN772'>0  ;->
 D CORRECT(+IENPAR,+IEN772,4,BEG)
 S IEN772=$O(^TMP($J,"HLPARENT",+IENPAR,":"),-1) QUIT:IEN772'>0  ;->
 D CORRECT(+IENPAR,+IEN772,5,END)
 ;
 ; Make other corrections...
 S IEN772=0,PREVTM=""
 F  S IEN772=$O(^TMP($J,"HLPARENT",+IENPAR,IEN772)) Q:IEN772'>0  D
 .  S DATA=$P($G(^TMP($J,"HLCHILD",+IEN772)),"~",2,999) QUIT:DATA']""  ;->
 .  S TIME(1)=$P(DATA,U,4),TIME(2)=$P(DATA,U,5)
 .
 .  ; If first time thru...
 .  I PREVTM="" D  QUIT  ;->
 .  .  I TIME(1)=TIME(2) S PREVTM=TIME(2) QUIT  ;->
 .  .  ; Set 1st entry's time to START=START (0 seconds)
 .  .  D CORRECT(+IENPAR,+IEN772,5,TIME(1))
 .  .  S PREVTM=TIME(1)
 .
 .  I TIME(1)'=PREVTM D
 .  .  D CORRECT(+IENPAR,+IEN772,4,PREVTM)
 .  .  S TIME(1)=PREVTM
 .
 .  I TIME(1)>TIME(2) D
 .  .  D CORRECT(+IENPAR,+IEN772,5,TIME(1))
 .  .  S TIME(2)=TIME(1)
 .
 .  S PREVTM=TIME(2)
 .  
 Q
 ;
CORRECT(PAR,CHLDIEN,PCE,NEW) ; Change CHILD data...
 N BEG,CHILD,DIFF,END,SEC,STORE
 ;
 ; Get CHILD and quit if no changes...
 S HLCHILD=$G(^TMP($J,"HLCHILD",+CHLDIEN)) QUIT:$P(HLCHILD,U,PCE)=NEW  ;->
 ;
 ; Put new value into CHILD...
 S $P(CHILD,U,PCE)=NEW
 ;
 ;Calculate SEC difference and set into CHILD...
 S BEG=$P(CHILD,U,4),END=$P(CHILD,U,5)
 S DIFF=$$FMDIFF^XLFDT(END,BEG,2)
 S $P(CHILD,U,3)=DIFF
 ;
 ; Store data...
 S ^TMP($J,"HLCHILD",+CHLDIEN)=HLCHILD
 ;
 Q
 ;
RECNM(PFX,IEN772,FULLNM,REPNM,SRCE) ; Record where name found...
 ; PFX - [n] for namespace, and [p] for protocol
 ; IEN772 - IEN of 772
 ; FULLNM - What is in entry itself, uninferred...
 ; REPNM - What is to be reported
 ; SRCE - Where it was inferred from
 ;
 QUIT:$G(^TMP($J,"HLUCM"))'="DEBUG GLOBAL"  ;->
 ;
 S REPNM=$G(PFX)_REPNM
 ;
 S ^TMP($J,"HLRECNM")=$G(^TMP($J,"HLRECNM"))+1
 S ^TMP($J,"HLRECNM",REPNM)=$G(^TMP($J,"HLRECNM",REPNM))+1
 S ^TMP($J,"HLRECNM",REPNM,SRCE)=$G(^TMP($J,"HLRECNM",REPNM,SRCE))+1
 S ^TMP($J,"HLRECNM",REPNM,SRCE,IEN772)=FULLNM
 ;
 QUIT
 ;
MSHMAIL(IEN772) ;
 N CT,INOUT,MIEN,NIEN,PCKG,RECNM,TXT,X,XMER,XMPOS,XMRG,XMZ
 S MIEN=$P($G(^HL(772,+IEN772,0)),U,5) QUIT:MIEN'>0 "" ;->
 S INOUT=$P(^HL(772,+IEN772,0),U,4)
 S INOUT=$S(INOUT="I":5,1:3)
 S CT=0,PCKG="",XMZ=+MIEN,XMER=0
 F  D  QUIT:CT>10!(PCKG]"")!($E(TXT,1,3)="MSH")!(XMER'=0)
 .  S CT=CT+1
 .  D REC^XMS3
 .  S TXT=$G(XMRG) QUIT:$E(TXT,1,3)'="MSH"  ;->
 .  S X=$E(TXT,4),RECNM=$P(TXT,X,INOUT)
 .  S PCKG=$$PCKGMSH(TXT,INOUT)
 .  D RECNM("[n]",IEN772,RECNM,PCKG,"MAIL")
 QUIT PCKG
 ;
MSH772(IEN772) ; Get PCKG from MSH segment in 772...
 ; Call here ONLY if can't get MSH segment from 773...
 N CT,IN,INOUT,PCKG,RECNM,TXT,X
 S IN=0,CT=0,PCKG=""
 S INOUT=$$INOUT(+IEN772)
 F  S IN=$O(^HL(772,+IEN772,"IN",IN)) Q:IN'>0!(CT>10)!(PCKG]"")  D
 .  S CT=CT+1
 .  S TXT=$G(^HL(772,+IEN772,"IN",+IN,0)) QUIT:TXT']""  ;->
 .  QUIT:$E(TXT,1,3)'="MSH"  ;->
 .  S X=$E(TXT,4),RECNM=$P(TXT,X,INOUT)
 .  S PCKG=$$PCKGMSH(TXT,INOUT)
 .  D RECNM("[n]",IEN772,RECNM,PCKG,772)
 QUIT PCKG
 ;
MSH773(IEN772) ; Get PCKG from MSH segment in 773...
 N IEN773,INOUT,MSH,PCKG,RECNM,X
 S IEN773=$O(^HLMA("B",IEN772,0)) QUIT:IEN773'>0 "" ;->
 S INOUT=$$INOUT(IEN772)
 S MSH=$G(^HLMA(+IEN773,"MSH",1,0)) QUIT:MSH']"" "" ;->
 S X=$E(MSH,4),RECNM=$P(MSH,X,INOUT)
 S PCKG=$$PCKGMSH(MSH,INOUT)
 I PCKG="VAMC" D
 .  N NMSP
 .  S NMSP=PCKG,INOUT=$S(INOUT=5:3,1:3)
 .  S X=$E(MSH,4),RECNM=$P(MSH,X,INOUT)
 .  S PCKG=$$PCKGMSH(MSH,INOUT) QUIT:$$PCKGMSH(MSH,INOUT)]""  ;->
 .  S PCKG=NMSP ; Reset
 D RECNM("[n]",IEN772,RECNM,PCKG,773)
 QUIT PCKG
 ;
INOUT(IEN772) ;
 N INOUT
 S INOUT=$P($G(^HL(772,+IEN772,0)),U,4)
 S INOUT=$S(INOUT="I":5,1:3) ; Default to O, which is case in HEC error
 QUIT INOUT
 ;
PCKGMSH(MSH,INOUT) ; Extract PCKG namespace from MSH segment
 N DEL,PFROM
 S DEL=$E(MSH,4),INOUT=$S($G(INOUT):INOUT,1:3)
 S PFROM=$P(MSH,DEL,INOUT) QUIT:PFROM']"" "" ;->
 QUIT $$FIXNMSP^HLUCM003(PFROM)
 ;
ERRCHK ; Error checks...
 ;
 ; DATE checks...
 S START=+$G(START),END=+$G(END)
 I START'?7N&(START'?7N1"."1.N) D ERR^HLUCM("INVALID START TIME")
 I END'?7N&(END'?7N1"."1.N) D ERR^HLUCM("INVALID END TIME")
 I '$D(ERRINFO("INVALID START TIME")) D
 .  I '$D(ERRINFO("INVALID END TIME")) D
 .  .  I START=END!(START<END) QUIT  ;->
 .  .  D ERR^HLUCM("END TIME PRECEDES START TIME")
 ;
 ; If condition=BOTH, can't be ALL(1/2) and ALL(1/2) or
 ; ALL(1/2) and SPECIFIC. BOTH can only be SPECIFIC and SPECIFIC.
 I COND="BOTH" D
 .  N P1,P2,P3
 .  S P1=$S($G(PNMSP)>0:1,1:0) ; namespace 0/1
 .  S P2=$S($G(IEN101)>0:1,1:0) ; protocol 0/1
 .  S P3=P1+P2 QUIT:P3'>0  ;->
 .  D ERR^HLUCM("BOTH NAMESPACES(S) AND PROTOCOL(S) MUST BE PASSED SPECIFICALLY")
 QUIT
 ;
SETMORE ; More defaults...
 ; 
 ; Check format of PNMSP...
 ; If not passed by reference...
 I 'NMSPTYPE D  ; Namespace(s) not passed as an array
 .  ; Passed as 1 or 2 or O^NMSP, but is it valid?
 .  I '$$OKPAR^HLUCM002(PNMSP) D
 .  .  D ERR^HLUCM("INVALID NAMESPACE PARAMETER")
 ;
 ; Check format of IEN101...
 ; If not passed by reference...
 I 'PROTYPE D  ; Protocol(s) not passed as an array
 .  ; Passed as 1 or 2 or 0^PROT or 0^IEN, but is it valid?
 .  I '$$OKPAR^HLUCM002(IEN101) D  ; Check format...
 .  .  D ERR^HLUCM("INVALID PROTOCOL PARAMETER")
 .  S IEN101=$$OKPAR101^HLUCM001($G(IEN101)) I IEN101']"" D
 .  .  I $D(ERRINFO("INVALID PROTOCOL PARAMETER")) QUIT  ;->
 .  .  QUIT:IEN101["0^9999999"  ;->
 .  .  D ERR^HLUCM("CAN'T FIND PROTOCOL")
 QUIT
 ;
FIXNMSP(PCKG,I772) ; First space piece, strip _
 N APPR,APPS,FACR,FACS,I773,MSH
 ;
 S I772=+$G(I772)
 ;
 ; Get 773 (or 772)-related information...
 S I773=$O(^HLMA("B",+I772,0))
 S MSH=$G(^HLMA(+I773,"MSH",1,0))
 I MSH']"" S X=$G(^HL(772,+I772,"IN",1,0)) S:$E(X,1,3)=MSH MSH=X
 S X=$E(MSH,4),APPS=$P(MSH,X,3),FACS=$P(MSH,X,4),APPR=$P(MSH,X,5),FACR=$P(MSH,X,6)
 ;
 S PCKG=$$NMSPCHG^HLUCM050(PCKG)
 ;
 QUIT $TR($E($P($P(PCKG," "),"-"),1,4),"_ ","") ;->
 ;
CTPCKG(PCKG) ; Should entry be counted on basis of package?
 ; (Might be countable if protocol matches remember.)
 ; If list of packages passed by reference, is PCKG in array?
 ; IEN101,NMSPTYPE,PNMSP -- req
 N CTPCKG
 ;
 ; Must count everything...
 I $G(PNMSP)=1!($G(PNMSP)=2) QUIT 1 ;->
 ;
 ; If passed namspace by array, is PCKG in array?
 I NMSPTYPE=1 QUIT $S($$REFPCKG^HLUCM001(PCKG):1,1:"") ;->
 ;
 ; If passed in "0^NAMESPACE" format...
 I $$OK0CALL^HLUCM002(PNMSP) D  QUIT $S(PCKG]"":1,1:"") ;->
 .  I $P(PNMSP,U,2)'=PCKG S PCKG=""
 ;
 QUIT ""
 ;
CTPROT(PROT) ; Should entry be counted on basis of protocol?
 ; (Might be countable if package matches remember.)
 ; IEN,PROTYPE -- req
 ;
 N CTPROT
 ;
 ; Must count everything...
 I $G(IEN101)=1!($G(IEN101)=2) QUIT 1 ;->
 ;
 ; If passed protocols by array, is PROT in array?
 I PROTYPE=1 QUIT $S($$REFPROT^HLUCM001(PROT):1,1:"") ;->
 ;
 ; If PROT not found, and passed 0^PROTNM or 0^PROTIEN, 
 ; can't do anything more...
 I $$OK0CALL^HLUCM002(IEN101) D  QUIT $S(PROT]"":1,1:"") ;->
 .  N VAL
 .  QUIT:PROT']""  ;->
 .  S VAL=$P(IEN101,U,2)
 .  I $P(PROT,"~")'=VAL&($P(PROT,"~",2)'=VAL) S PROT=""
 ;
 QUIT ""
 ;
EOR ; HLUCM003 - HL7/Capacity Mgt API-II ;10/23/01 12:01
