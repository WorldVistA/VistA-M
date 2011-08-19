LAXSYMHQ ;MLD/ABBOTT/SLC/RAF - ABBOTT AxSYM 'HOST QUERY' PGM ; 6/12/96 0900;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**11,19**;Sep 27, 1994
 ;
 Q  ; call line tag
 ;
HQSET ; Build hst qry to send to AxSYM (stored in ^LA(INST,"HQ",CNT) nodes)
 ; called from Q^LAXSYM
 N I,FRM,CR,ETX,CKSM,STX,LF,CNT,X,EOT,LATEST
 S X="ERR^LAXSYMHQ",@^%ZOSF("TRAP"),(LRTST,I)=0
 S CNT=0,LF=$C(10),STX=$C(2),ETX=$C(3),CR=$C(13),EOT=4
 ;
 ; LATEST array
 F  S I=$O(^LAB(62.4,INST,3,I)) Q:'I  S X=$G(^(I,0)) S LATEST(+X)=$P(X,U,4)
 L +^LA(INST,"HQ")
 F I="H","P","O","L" D  ; loop thru frame types
 .S LRFRM=$G(LRFRM)+1 S:(LRFRM=8) LRFRM=0 ; increment frame cntr
 .S FRM=LRFRM_$S(I="H":$$H^LAXSYMBL,I="P":$$P^LAXSYMBL,I="O":$$O,1:$$L^LAXSYMBL)_CR_ETX
 .S CKSM=$$CKSUM^LAXSYMU(FRM) ; CR_ETX is counted in chksum
 .; build msg frame: <STX>~|~msg text~|~<CR><ETX>~checksum~<CR><LF>
 .S FRM=STX_FRM_CKSM_CR_LF
 .; set frame to ^LA(,"HQ" node
 .S CNT=$G(^LA(INST,"HQ"))+1,^LA(INST,"HQ")=CNT,^LA(INST,"TMPHQ",CNT)=FRM
OUT I $G(HQBAD)=0 D  ;positive query response sets
 .M ^LA(INST,"HQ")=^LA(INST,"TMPHQ")
 I $G(HQBAD)=1 D  ;negative query response sets
 .S FRM=^LA(INST,"TMPHQ",3),FRM="2Q|"_$P(FRM,"|",2,12)_"|X"_CR_ETX
 .S ^LA(INST,"TMPHQ",2)=STX_FRM_$$CKSUM^LAXSYMU(FRM)_CR_LF
 .S FRM=^LA(INST,"TMPHQ",4),FRM="3L|1"_CR_ETX
 .S ^LA(INST,"TMPHQ",3)=STX_FRM_$$CKSUM^LAXSYMU(FRM)_CR_LF
 .S ^LA(INST,"HQ")=3 K ^LA(INST,"TMPHQ",4)
 .M ^LA(INST,"HQ")=^LA(INST,"TMPHQ")
 K ^LA(INST,"TMPHQ")
 L -^LA(INST,"HQ")
 QUIT
 ;
O() ; Build Order frame  NOTEs:
 ; a. 10 chars is size limit for rev 1.xx  15 will be limit for rev 2
 ; b. Potential for REPEAT (multiple) tests to cause the Order frame to
 ;    exceed 247 chars!  However, if the AxSYM doesn't offer more than
 ;    about 25 tests, this should not be a problem.
 ;
 Q:$G(BAD) IN ; cannot process request - set in Q^LAXSYM
 N O,CNT,DLM,PRI,LRPRI,LRTEST,LRTST
 S (CNT,PRI,LRTEST,HQBAD)=0,LRPRI=9,$P(O,D,5)=""
 F  S LRTEST=$O(^LRO(68,WL,1,LADT,1,+LRAN,4,LRTEST)) Q:'LRTEST  D
 .Q:$L($P(^LRO(68,WL,1,LADT,1,+LRAN,4,LRTEST,0),U,5))
 .S CNT=CNT+1 S DLM=$S(CNT>1:"\",1:"")
 .S LRTST=$$PNL^LAXSYMBL ; get AxSYM's internal tst #
 .S:LRTST="" CNT=CNT-1
 .Q:LRTST=""  ; test not in Auto Inst file
 .S $P(O,D,5)=$P(O,D,5)_DLM_"^^^"_LRTST ; 'repeat' tests use '\'
 .S PRI=+$P($G(^LRO(68,WL,1,LADT,1,+LRAN,4,LRTEST,0)),U,2)
 .I PRI,(PRI<LRPRI) S LRPRI=PRI ; take 'highest' prio
 ;
 ; If no orders can be found, return orig query with 'X'
 I $P(O,D,5)="" S $P(IN,D,13)="X",HQBAD=1 Q IN
 ;
 S LRPRI=$E($P($G(^LAB(62.05,LRPRI,0)),U)) S:LRPRI="" LRPRI="R"
 ; 2nd pc is (hardcoded) # of 'O' frames.  Change if loop is needed
 S $P(O,D,1,3)="O|1|"_LRAN
 S $P(O,D,6)=LRPRI,$P(O,D,12)="A",$P(O,D,26)="Q"
 Q O
 ;
ERR ; Error Trap
 D ^LABERR
 K ^LA(INST,"HQ") ; remove bad data/incomplete list
 G OUT
