LAXSYMBL ;MLD/ABBOTT/SLC/RAF - ABBOTT AxSYM BUILD 'DWNLD' FILE ; 6/12/96 0900;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**11,19**;Sep 27, 1994
 ;
 Q  ; call line tag
 ;
BLDLST ; Build the worklist in prep for dwnlding to AxSYM
 ;  Called from LADOWN with the following set:
 ;   LRLL           = load list pointer
 ;   LRCUP1         = starting cup #
 ;   LRTRAY,LRTRAY1 = starting tray #
 ;   LRINST         = Auto Instrument pointer
 ;   LRFORCE        = 1 if send tray and cup
 ;
 N I,D,H,P,O,L,X,STX,ETX,CR,LF,CNT,LATEST,LRAN,LRACC,LRAD,LRFRM,SSN
 N LRFRAME,LRDFN,LRNAME,INST,LANM,LRTEST
 ;
 L +^LA(LRINST,"O") ; get global 1st!
 S D="|",STX=$C(2),ETX=$C(3),LF=$C(10),CR=$C(13),INST=LRINST
 S X="ERR^LAXSYMBL",@^%ZOSF("TRAP"),(LRTEST,LRFRAME,I)=0
 S LRCUP=LRCUP1-1 ; reset for $ORDER
 ; LATEST array
 F  S I=$O(^LAB(62.4,INST,3,I)) Q:'I  S X=$G(^(I,0)) S LATEST(+X)=$P(X,U,4)
 ;
 ; Main Loop thru Load/Work List file
 F  S LRCUP=$O(^LRO(68.2,LRLL,1,LRTRAY1,1,LRCUP)) Q:'LRCUP  D GETACCN
 ;
 K LRCUP1,LRCUP2,LRTRAY1 ; not killed in calling routine (LADOWN)
 L -^LA(INST,"O") ; release lock
 S LREND=1,^LA(INST,"Q")="" ; set dwnld-ready flag
 ;
 QUIT
 ;
GETACCN ; Get and save work/load list data to downlaod to AxSYM
 N LRAA
 S LRAA=$G(^LRO(68.2,LRLL,1,LRTRAY1,1,LRCUP,0)) Q:LRAA=""
 S LRAN=$P(LRAA,U,3) Q:LRAN=""  ; no accn num
 S LRAD=$P(LRAA,U,2) Q:LRAD=""  ; no accn date
 D PNM Q:LRACC=""  ; no accn
 S LRAN=$E("0000",$L(LRAN),4)_LRAN ; pad with zeros to 4 digits
 D FRAME
 Q
 ;
PNM ; Get patient name and last 4 from an accession.
 N DFN,X,PT S (LRACC,DFN,LRNAME)=""
 S X=$G(^LRO(68,+LRAA,1,LRAD,1,+LRAN,0)) Q:X=""  ; no accn on file
 S LRACC=$G(^(.2)),X=^LR(+X,0) ;Q:$P(X,U,2)'=2 ; Naked Ref=^LRO(68,LRAA,1,LRAD,1,+LRAN,.2) & ^LRO(68,LRAA,1,LRAD,1,+LRAN,X,0)
 ; "patient" could be in one of several files: 2, 62.3, 67, 67.1 etc.
 S DFN=$P(X,U,3),PT=$G(^DIC(+$P(X,U,2),0,"GL"))
 Q:PT=""  ; could not find global ref
 S PT=PT_+DFN_",0)",PT=$G(@PT),LRNAME=$P(PT,U),SSN=$P(PT,U,9)
 Q
 ;
FRAME ; Build frame to transmit to AxSYM (stored in ^LA(INST,"O",CNT) nodes)
 N I,FRM
 F I="H","P","O","L" D  ; loop thru frame types
 .S LRFRM=$G(LRFRM)+1 S:(LRFRM=8) LRFRM=0 ; increment frame cntr
 .S FRM=LRFRM_$S(I="H":$$H,I="P":$$P,I="O":$$O,1:$$L)_CR_ETX
 .S CKSM=$$CKSUM^LAXSYMU(FRM) ; CR_ETX is counted in chksum
 .; * build msg frame: <STX>~|~msg text~|~<CR><ETX>~checksum~<CR><LF>
 .S FRM=STX_FRM_CKSM_CR_LF
 .; set frame to ^LA( "O"utput node
 .S CNT=$G(^LA(INST,"O"))+1,^LA(INST,"O")=CNT,^LA(INST,"O",CNT)=FRM
 ;
 Q
 ;
H() ; Build hdr frame
 N H S H="H|\^&",$P(H,D,12,13)="P|1"
 Q H
 ;
P() ; Build Patient frame
 N P S P="P|1"
 ; 20 chars is size limit for rev 1.xx  15 will be limit for rev.2!
 S $P(P,D,4)=$E(LRACC,1,15)_"^" ; see above re: size limits
 S $P(P,D,5)=$G(SSN)
 S $P(P,D,6)=$E($P(LRNAME,","),1,20)_U_$E($P($P(LRNAME,",",2)," "),1,20)_U_$E($P(LRNAME," ",2))
 Q P
 ;
O() ; Build Order frame  NOTE:
 ; a. 10 chars is size limit for rev 1.xx  15 will be limit for rev 2
 ; b. Potential for REPEAT (multiple) tests to cause the Order frame
 ;    to exceed 247 chars!  However, if the AxSYM doesn't offer more
 ;    than about 25 tests, this should not be a problem.
 ;
 B  N O,CNT,DLM,PRI,LRPRI,LRTEST,LRTST
 S (CNT,PRI,LRTEST)=0,LRPRI=9,$P(O,D,5)=""
 F  S LRTEST=$O(^LRO(68.2,LRLL,1,LRTRAY1,1,LRCUP,1,LRTEST)) Q:'LRTEST  D
 .S CNT=CNT+1 S DLM=$S(CNT>1:"\",1:"")
 .S LRTST=$$PNL ; get AxSYM's internal tst #
 .S:LRTST="" CNT=CNT-1
 .Q:LRTST=""  ; test not in Auto Inst file
 .S $P(O,D,5)=$P(O,D,5)_DLM_"^^^"_LRTST ; 'repeat' tests use '\'
 .S PRI=+$P($G(^LRO(68.2,LRLL,1,LRTRAY1,1,LRCUP,1,LRTEST,0)),U,2)
 .I PRI,(PRI<LRPRI) S LRPRI=PRI ; take 'highest' prio
 ;
 S LRPRI=$E($P($G(^LAB(62.05,LRPRI,0)),U)) S:LRPRI="" LRPRI="R"
 ; 2nd pc is (hardcoded) # of 'O' frames.  Change if loop is needed
 S $P(O,D,1,3)="O|1|"_LRAN
 S $P(O,D,6)=LRPRI,$P(O,D,12)="A",$P(O,D,26)="O"
 Q O
 ;
L() ; Build Last (termination) frame
 Q "L|1"
 ;
PNL() ; Expand panel from load/work list
 N CT,I,T,TST,DLM S (CT,I,T)=0,TST=""
 Q:$D(LATEST(LRTEST)) LATEST(LRTEST) ; return single test
 ; expand panel
 F  S I=$O(^LAB(60,LRTEST,2,I)) Q:'I  S T=+$G(^(I,0)) D:T
 .S CT=CT+1 S DLM=$S(CT>1:"\^^^",1:"")
 .I $D(LATEST(T)) S TST=TST_DLM_LATEST(T)
 .I '$D(LATEST(T)) S CT=CT-1
 .Q
 ; Return panel tests that should look like: 321\^^^678\^^^452
 Q TST
 ;
ERR ; Error Trap
 D ^LABERR H 1
 K ^LA(INST,"O") ; remove incomplete list
 L -^LA(INST,"O")
 Q
