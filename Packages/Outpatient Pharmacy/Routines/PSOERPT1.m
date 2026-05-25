PSOERPT1 ;BIRM/MFR - eRx Single Patient Medication Queue Supporting API's ; 12/10/22 10:57am
 ;;7.0;OUTPATIENT PHARMACY;**700,750,746,769,770**;DEC 1997;Build 145
 ;
SETHDR() ; - Displays the Header Line
 N HDR,SRTORD,SRTPOS
 ;
 S HDR="#",$E(HDR,5)="ERX ID",$E(HDR,19)=$S($G(PSODETDP):"",1:"DRUG NAME"),$E(HDR,42)="PROVIDER NAME",$E(HDR,59)="REC.DATE"
 S $E(HDR,68)="STA",$E(HDR,72)="PT",$E(HDR,75)="PR",$E(HDR,78)="DR "
 D INSTR^VALM1(IORVON_HDR_IOINORM,1,4)
 S SRTORD=$S(PSORDER="A":"^",1:"v")
 I PSOSRTBY="ALL" D
 . D INSTR^VALM1(IOINHI_IORVON_SRTORD_IOINORM,74,4)
 . D INSTR^VALM1(IOINHI_IORVON_SRTORD_IOINORM,77,4)
 . D INSTR^VALM1(IOINHI_IORVON_SRTORD_IOINORM,80,4)
 E  D
 . S SRTPOS=$S(PSOSRTBY="ID":11,PSOSRTBY="DR":28,PSOSRTBY="PR":55,PSOSRTBY="RE":67,PSOSRTBY="STA":71,PSOSRTBY="PAM":74,PSOSRTBY="PRM":77,1:80)
 . D INSTR^VALM1(IOINHI_IORVON_SRTORD_IOINORM,SRTPOS,4)
 Q
 ;
SETSORT(FIELD) ;Sets the data sorted by the FIELD specified
 ; Input: FIELD - Sort By Field
 N RECDAT,ERXIEN,CSGROUP,SORT,RELMSGID,ERXIEN
 K ^TMP("PSOERPTS",$J),^TMP("PSOERINC",$J)
 ; Loading eRx's (file #52.49)
 S ERXIEN=0,RECDAT=$$FMADD^XLFDT(DT,-PSOLKBKD)
 F  S RECDAT=$O(^PS(52.49,"PAT2",EPATIEN,RECDAT)) Q:'RECDAT  D
 . F  S ERXIEN=$O(^PS(52.49,"PAT2",EPATIEN,RECDAT,ERXIEN)) Q:'ERXIEN  D
 . . D SETITEM(ERXIEN,FIELD) S ^TMP("PSOERINC",$J,ERXIEN)=""
 . . S RELMSGID=0 F  S RELMSGID=$O(^PS(52.49,ERXIEN,201,"B",RELMSGID)) Q:'RELMSGID  D
 . . . I $$GET1^DIQ(52.49,RELMSGID,.03,"I")<$$FMADD^XLFDT(DT,-PSOLKBKD) Q
 . . . I $D(^TMP("PSOERINC",$J,RELMSGID)) Q
 . . . D SETITEM(RELMSGID,FIELD) S ^TMP("PSOERINC",$J,RELMSGID)=""
 K ^TMP("PSOERINC",$J)
 Q
 ;
SETITEM(ERXIEN,FIELD) ; Adds an eRx Record to the Sorted List
 ; Input: ERXIEN - eRx IEN - Pointer to #52.49
 ;        FIELD  - Sort By field
 N STATUS,MSGTYPE,ERXID,DRUG,CSGROUP,PROVIDER,PATMTCH,PROMTCH,DRUMTCH,Z,X,MSGDTTM
 S STATUS=$$GET1^DIQ(52.49,ERXIEN,1)
 ; Actionable/Non-Actionable Status
 I '$G(PSOALLST),$F(",RJ,RM,REM,PR,E,RXA,CXA,CAA,CAN,CXP,RXP,RXA,ICA,CNP,CRP,CRC,RRC,CXC,CNE,CRN,CRR,CRX,CXQ,RXA,RXC,RRN,RRX,RRR,RRP,IRA,",","_$E(STATUS,1,3)_",") Q
 S MSGTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 S MSGDTTM=$$GET1^DIQ(52.49,ERXIEN,.03,"I")
 ; Skip Change Request records w/ Processing Error Status
 I '$G(PSOALLST),MSGTYPE="CR",STATUS="CRE" Q
 ; Skip Inbound errors except RRE or CRE records
 I '$G(PSOALLST),MSGTYPE="IE",(STATUS'="RRE"),(STATUS'="CRE") Q
 ; Related Institution Filter (Non-MbM sites only)
 I '$G(MBMSITE),PSNPINST'=+$$GET1^DIQ(52.49,ERXIEN,24.1,"I") Q
 ; Controlled Substance Prompts Filter
 I $G(PSOCSERX)="CS",'$$GET1^DIQ(52.49,ERXIEN,95.1,"I") Q
 I $G(PSOCSERX)="Non-CS",$$GET1^DIQ(52.49,ERXIEN,95.1,"I") Q
 I '$$CSFILTER^PSOERXUT(ERXIEN) Q
 S ERXID=$$GET1^DIQ(52.49,ERXIEN,.01)
 S DRUG=$$GETDRUG^PSOERXU5(ERXIEN) I DRUG="" S DRUG=$S(MSGTYPE="IE":"<<INBOUND ERROR>>",1:"N/A")
 S CSGROUP=$S('PSOCSGRP:"ALL",$$GET1^DIQ(52.49,ERXIEN,95.1,"I"):"CS",1:"NON-CS")
 S PROVIDER=$$GET1^DIQ(52.49,ERXIEN,2.1) I PROVIDER="" S PROVIDER=$$GET1^DIQ(52.48,$$GETPROV^PSOERXU5(ERXIEN),.01)
 S PATMTCH=$$MATCH^PSOERPT2("PAM",ERXIEN)
 S PROMTCH=$$MATCH^PSOERPT2("PRM",ERXIEN)
 S DRUMTCH=$$MATCH^PSOERPT2("DRM",ERXIEN)
 S Z="",$P(Z,"^")=$E(DRUG,1,34),$P(Z,"^",2)=$E(PROVIDER,1,16),$P(Z,"^",3)=$$FMTE^XLFDT(MSGDTTM\1,"2Z")
 S $P(Z,"^",4)=STATUS,$P(Z,"^",5)=PATMTCH,$P(Z,"^",6)=PROMTCH,$P(Z,"^",7)=DRUMTCH
 I FIELD="ID" S SORT=$S(ERXID:1000000000000+ERXID,1:ERXID)_" "_ERXIEN
 I FIELD="DR" S SORT=$$UP^XLFSTR(DRUG)_" "_ERXIEN
 I FIELD="PR" S SORT=PROVIDER_" "_ERXIEN
 I FIELD="RE" S SORT=MSGDTTM_" "_ERXIEN
 I FIELD="STA" S SORT=STATUS_" "_RECDAT
 I FIELD="PAM" S X=$P(PATMTCH,"^"),SORT=$S(X="":1,X="M":2,1:3)_ERXIEN
 I FIELD="PRM" S X=$P(PROMTCH,"^"),SORT=$S(X="":1,X="M":2,1:3)_ERXIEN
 I FIELD="DRM" S X=$P(DRUMTCH,"^"),SORT=$S(X="":1,X="M":2,1:3)_ERXIEN
 I FIELD="ALL" S SORT=$$MATCHSRT^PSOERPT2($P(PATMTCH,"^"),$P(PROMTCH,"^"),$P(DRUMTCH,"^"))_ERXIEN
 S ^TMP("PSOERPTS",$J,CSGROUP,SORT)=Z
 S ^TMP("PSOERPTS",$J,CSGROUP,SORT,"ERXIEN")=ERXIEN
 I $P(PATMTCH,"^",2) S ^TMP("PSOERPTS",$J,CSGROUP,SORT,"PATAM")=1
 I $P(PROMTCH,"^",2) S ^TMP("PSOERPTS",$J,CSGROUP,SORT,"PROAM")=1
 I $P(PROMTCH,"^",3) S ^TMP("PSOERPTS",$J,CSGROUP,SORT,"PROAV")=1
 I $P(DRUMTCH,"^",2) S ^TMP("PSOERPTS",$J,CSGROUP,SORT,"DRUAM")=1
 Q
 ;
MATCHSUG(ERXIEN,VIEW) ; Match Suggestion Prompt
 ; Input: ERXIEN   - Pointer to ERX HOLDING QUEUE file (#52.49)
 ;     (o)VIEW     - View Only Mode (1:YES,0/null: NO)
 ;Output: VISTAPAT - VistA Patient (Pointer to #2) or 0 (Not selected or no suggestion on file)
 ;
 N MATCHSUG,MATCHCNT,LSTMTCH,LSTERXID,CNT,ERXPAT,VPAT,QUIT,DIR,DIRUT,DIROUT,X,Y,II,ERXID
 S ERXPAT=+$$GET1^DIQ(52.49,+$G(ERXIEN),.04,"I") I 'ERXPAT Q 0
 S (MATCHSUG,MATCHCNT,CNT,VPAT,QUIT)=0
 F  S VPAT=$O(^PS(52.49,"APATVPAT",ERXPAT,VPAT)) Q:'VPAT  S:'$$DEAD^PSONVARP(VPAT) MATCHCNT=MATCHCNT+1
 I MATCHCNT>3 S MATCHCNT=3
 S VPAT=0 F  S VPAT=$O(^PS(52.49,"APATVPAT",ERXPAT,VPAT)) Q:'VPAT  D  I MATCHSUG!(CNT>2)!QUIT Q
 . I $$DEAD^PSONVARP(VPAT) Q
 . S LSTERXID=0,LSTMTCH=9999999 F  S LSTMTCH=$O(^PS(52.49,"APATVPAT",ERXPAT,VPAT,LSTMTCH),-1) Q:'LSTMTCH  D  I LSTERXID Q
 . . S ERXID=$O(^PS(52.49,"APATVPAT",ERXPAT,VPAT,LSTMTCH,0)) Q:(ERXID=ERXIEN)  S LSTERXID=ERXID
 . I 'LSTERXID Q
 . S CNT=CNT+1
 . D CMPPAT(ERXIEN,VPAT,LSTERXID,CNT_"^"_MATCHCNT)
 . K DIR S DIR(0)="SOA^"_$S('$G(VIEW):"A:ACCEPT;",1:"")_$S(MATCHCNT>1&(MATCHCNT'=CNT):"N:NEXT;",1:"")_"F:FORGET;E:EXIT"
 . S DIR("A")="ACTION on SUGGESTION: "_$S('$G(VIEW):"(A)CCEPT  ",1:"")_$S(MATCHCNT>1&(MATCHCNT'=CNT):"(N)EXT  ",1:"")_"(F)ORGET  (E)XIT: "
 . S DIR("B")=$S(MATCHCNT>1&(MATCHCNT'=CNT):"NEXT",1:"EXIT")
 . S II=0
 . I '$G(VIEW) D
 . . S II=II+1,DIR("?",II)="  ACCEPT - Accepts the suggested VistA Patient and matches it to the eRx"
 . I MATCHCNT>1&(MATCHCNT'=CNT) D
 . . S II=II+1,DIR("?",II)="  NEXT   - Ignores this suggested VistA Patient and view the next one"
 . S II=II+1,DIR("?",II)="  FORGET - Forgets this suggested VistA Patient so that it is not presented"
 . S II=II+1,DIR("?",II)="           again in the future to any user"
 . S DIR("?")="  EXIT   - Exit and proceed to match the VistA Patient manually"
 . D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y="E") S QUIT=1 Q
 . I Y="A" S MATCHSUG=VPAT Q
 . I Y="N" W ! Q
 . I Y="F" D
 . . K DIR S DIR(0)="SA^Y:YES;N:NO",DIR("B")="NO"
 . . S DIR("A")="Are you sure this validated match should be forgotten? "
 . . S DIR("?")="This VistA Patient was previously matched and validated as a valid match for this eRx Patient. Once you forget this match it will no longer be suggested as a match for this eRx patient."
 . . W ! D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y="N") S VPAT=VPAT-1,CNT=CNT-1 W ! Q
 . . W !?50,"Forgetting..." K ^PS(52.49,"APATVPAT",ERXPAT,VPAT) H 1 W "done." W ! Q
 Q MATCHSUG
 ;
CMPPAT(ERXIEN,VISTAPAT,LSTERXID,COUNTER) ; Display the Comparison Between eRx and VistA Patients
 ;Input: ERXIEN   - Pointer to ERX HOLDING QUEUE file (#52.49)
 ;       VISTAPAT - VistA Patient (Pointer to #2)
 ;    (o)LSTERXID - Last eRx IEN with the Match (Pointer to #52.49)
 ;    (o)COUNTER  - P1: Entry # | P2: Number of Entries
 I '$D(^PS(52.49,+$G(ERXIEN),0))!'$D(^DPT(+$G(VISTAPAT),0)) Q
 N X,XX,LINE
 I $G(LSTERXID) D
 . W !?55,"|Sugg. " W $G(IOINHI)_+$G(COUNTER)_$G(IOINORM)_" of "_$G(IOINHI)_$P($G(COUNTER),"^",2)_$G(IOINORM)
 . W " - ",$G(IOINHI)_$$FMTE^XLFDT($$GET1^DIQ(52.49,LSTERXID,1.14,"I")\1,"2Z")_$G(IOINORM),"|"
 W !,$G(IORVON)_"ERX PATIENT"_$G(IORVOFF),?41,$G(IORVON)_"VISTA PATIENT"_$G(IORVOFF)
 I $G(LSTERXID) W ?55,"|From eRx#: "_$G(IOINHI)_$$GET1^DIQ(52.49,LSTERXID,.01)_$G(IOINORM),?79,"|"
 S $P(XX,"_",81)="" W !,XX
 D SETPAT^PSOERUT0("RS",ERXIEN,VISTAPAT)
 Q
 ;
CSERXS() ; Returns whether there are CS eRx on the list or not
 N CSERXS,LINE,ERXIEN
 S CSERXS=0
 S LINE=0 F  S LINE=$O(^TMP("PSOERPT0",$J,LINE)) Q:'LINE  D  I CSERXS Q
 . S SEQ=+$G(^TMP("PSOERPT0",$J,LINE,0)) I 'SEQ Q
 . S ERXIEN=+$G(^TMP("PSOERPT0",$J,SEQ,"ERXIEN"))
 . ;DO NOT FILL record
 . I $$GET1^DIQ(52.49,+$G(ERXIEN),10.5,"I")=2 Q
 . I $$GET1^DIQ(52.49,ERXIEN,95.1,"I") S CSERXS=1
 Q CSERXS
 ;
VAPATIEN() ; Returns the VistA Patient IEN or 0 (No VistA Patient Selected) or -1 (Different VistA Patients Selected)
 N VAPATIEN,LINE,ERXIEN,DFN,SEQ
 S VAPATIEN=""
 S LINE=0 F  S LINE=$O(^TMP("PSOERPT0",$J,LINE)) Q:'LINE  D  I VAPATIEN=-1 Q
 . S SEQ=+$G(^TMP("PSOERPT0",$J,LINE,0)) I 'SEQ Q
 . S ERXIEN=+$G(^TMP("PSOERPT0",$J,SEQ,"ERXIEN"))
 . S DFN=+$$GET1^DIQ(52.49,ERXIEN,.05,"I") I DFN,'VAPATIEN S VAPATIEN=DFN
 . I DFN,DFN'=VAPATIEN S VAPATIEN=-1
 Q VAPATIEN
 ;
OPACCESS(OPTION,USER,LIST) ; Returns whether the current user has priviledge to Perform a given action on a list of entries
 ; Input: OPTION - Option to be checked
 ;        USER   - Pointer to NEW PERSON file (#200)
 ;        LIST   - List of eRX Records to be checked
 ;Output: 1 - User has access | 0 - User does not have access
 N OPACCESS,SEQ,ERXIEN,PSOIEN
 S OPACCESS=1
 S SEQ=0 F  S SEQ=$O(LIST(SEQ)) Q:'SEQ  D  I 'OPACCESS Q
 . S ERXIEN=+LIST(SEQ)
 . ;DO NOT FILL record
 . I $$GET1^DIQ(52.49,+$G(ERXIEN),10.5,"I")=2 S OPACCESS=0
 . S PSOIEN=ERXIEN
 . S OPACCESS=$$OPACCESS^PSOERXU7(OPTION,USER,ERXIEN)
 Q OPACCESS
 ;
ALRDYVAL() ; Returns whether at least one record from the list has already been validated
 N ALRDYVAL,LINE,ERXIEN,SEQ
 S ALRDYVAL=0
 S LINE=0 F  S LINE=$O(^TMP("PSOERPT0",$J,LINE)) Q:'LINE  D  I ALRDYVAL Q
 . S SEQ=+$G(^TMP("PSOERPT0",$J,LINE,0)) I 'SEQ Q
 . S ERXIEN=+$G(^TMP("PSOERPT0",$J,SEQ,"ERXIEN"))
 . ;DO NOT FILL record
 . I $$GET1^DIQ(52.49,+$G(ERXIEN),10.5,"I")=2 Q
 . S ALRDYVAL=+$$GET1^DIQ(52.49,ERXIEN,1.7,"I")
 Q ALRDYVAL
 ;
VIDEO() ; Changes the Video Attributes for the list
 N I,LN,POS
 ; The command below is used to circumvent a bug with Reverse Video in ListMan
 ; (Related to Filtered BY line in the header)
 D CNTRL^VALM10(1,1,79,IORVOFF,IOINORM)
 ;
 I '$D(IORVOFF)!'$D(VALMEVL) Q
 F I=0:1:LINE D CNTRL^VALM10(I,1,80,IOINORM,IOINORM)
 ; - Highlighting the PRESCRIPTION line if SIG is displayed
 F I=1:1:LINE D
 . I $D(HIGHLN(I)),$D(UNDLN(I)) D CNTRL^VALM10(I,1,80,IOUON_IOINHI,IOUOFF_IOINORM) Q
 . I $D(HIGHLN(I)) D CNTRL^VALM10(I,1,80,IOINHI,IOINORM)
 . I $D(UNDLN(I)) D CNTRL^VALM10(I,1,80,IOUON,IOINORM)
 ; - Highlighting the group lines (order type and status)
 I $D(GRPLN) D
 . S LN=0 F I=1:1 S LN=$O(GRPLN(LN)) Q:'LN  D
 . . S LBL=GRPLN(LN),POS=41-($L(LBL)\2)
 . . D CNTRL^VALM10(LN,1,POS-1,IOUON,IOINORM)
 . . D CNTRL^VALM10(LN,POS,$L(LBL),IORVON,IORVOFF_IOINORM)
 . . D CNTRL^VALM10(LN,POS+$L(LBL),81-POS-$L(LBL),IOUON,IOINORM)
 ; - Highlighting Auto To Manual Match
 S LN=0 F I=1:1 S LN=$O(PTMTCHLN(LN)) Q:'LN  D
 . D CNTRL^VALM10(LN,72,1,IOINHI,IOINORM)
 S LN=0 F I=1:1 S LN=$O(PRMTCHLN(LN)) Q:'LN  D
 . D CNTRL^VALM10(LN,75,1,IOINHI,IOINORM)
 S LN=0 F I=1:1 S LN=$O(PRVALLN(LN)) Q:'LN  D
 . D CNTRL^VALM10(LN,76,1,IOINHI,IOINORM)
 S LN=0 F I=1:1 S LN=$O(DRMTCHLN(LN)) Q:'LN  D
 . D CNTRL^VALM10(LN,78,1,IOINHI,IOINORM)
 Q
 ;
ERXLST(RANGE,ERXLST) ; Given a Range of List Item returns the list of eRx's in an Array
 ; Input: RANGE  - User Selected Range (ex: '1-5'; '2,5,8,10'; '1-5,11-15', etc)
 ;Output: ERXLST - Array with the selected list of eRx IEN's (Pointer to #52.49) - ERXLST(ERXIEN)
 ;
 N L1,LINE,INVALID,SEG
 S INVALID=0 K ERXLST
 F L1=1:1:$L(RANGE,",") D
 . S SEG=$P(RANGE,",",L1) I SEG="" Q
 . I SEG["-" D
 . . F LINE=+$P(SEG,"-"):1:+$P(SEG,"-",2) D
 . . . S ERXIEN=+$G(^TMP("PSOERPT0",$J,LINE,"ERXIEN")) I 'ERXIEN S INVALID=1 Q
 . . . S ERXLST(LINE)=ERXIEN
 . E  D
 . . S ERXIEN=+$G(^TMP("PSOERPT0",$J,+SEG,"ERXIEN")) I 'ERXIEN S INVALID=1 Q
 . . S ERXLST(+SEG)=ERXIEN
 K:INVALID ERXLST
 Q
 ;
LSTERXS(ERXLST,ISSONLY,DISPSEQ) ; Given a list of eRx IENs (array passed in by Reference) it displays a list
 ;Input: (r) ERXLST  - Array with the list of eRx IEN's to be listed(Pointer to #52.49) - ERXLST(ERXIEN)
 ;       (o) ISSONLY - List Entries with Issues Only? (1: YES | 0: NO)
 ;       (o) DISPSEQ - Display the Sequence #? (1: YES | 0: NO)
 N SEQ,ERXIEN,HDR,XX,CNT,DIR
 S HDR=$S(DISPSEQ:"#",1:""),$E(HDR,$S(DISPSEQ:5,1:1))="ERX ID",$E(HDR,17)="DRUG NAME",$E(HDR,52)="PROVIDER",$E(HDR,75)="STS"
 S $P(XX,"-",80)="" W !,HDR,!,XX
 S (SEQ,CNT)=0 F  S SEQ=$O(ERXLST(SEQ)) Q:'SEQ  D
 . S ERXIEN=+ERXLST(SEQ)
 . I $G(ISSONLY),$P($G(ERXLST(SEQ)),"^",2)="" Q
 . W !,$S(DISPSEQ:SEQ_$S($$GET1^DIQ(52.49,ERXIEN,95.1,"I"):"]",1:"."),1:""),?$S(DISPSEQ:4,1:0),$$GET1^DIQ(52.49,ERXIEN,.01)
 . W ?16,$E($S($$GETDRUG^PSOERXU5(ERXIEN)'="":$$GETDRUG^PSOERXU5(ERXIEN),1:"N/A"),1,34)
 . W ?51,$E($$GET1^DIQ(52.49,ERXIEN,2.1),1,22)
 . W ?74,$$GET1^DIQ(52.49,ERXIEN,1)
 . I $P($G(ERXLST(SEQ)),"^",2)'="" D
 . . S CNT=CNT+1 W !,"REASON: ",$P($G(ERXLST(SEQ)),"^",2)
 . S CNT=CNT+1 I '(CNT#18) D PAUSE^VALM1 W !,HDR,!,XX
 Q
 ;
PATIDS ; Patient Lookup Identifiers Display (set on DIC("W"))
 N Z
 W "    ",$$FMTE^XLFDT($P(^(0),U,3),"5Z"),"  ",$P(^(0),U,9)
 S Z=$G(^(.11)) I $P(Z,U,4)'="" W "  ",$P(Z,U,4) I $P(Z,U,5) W ",",$P(^DIC(5,+$P(Z,U,5),0),U,2)
 Q
