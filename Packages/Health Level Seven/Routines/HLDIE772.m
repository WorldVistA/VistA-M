HLDIE772 ;CIOFO-O/LJA - Direct 772 & 773 Sets ; 11/18/2003 11:17
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 ;
 ;
 ; =================================================================
 ;
 ; The fields beginning with F2 have a common format...
 ;   [F]=Field,    [2]=772,    [01]=field#.01 & [2]=field#2
 ;
F201 ; 772 - .01 - 0;1   [B] - DATE/TIME ENTERED
 D UPD(0,1,VALUE) ; Sets the NODE(node,1) node...
 S XRF("B")="" ; Sets the XRF(xrf) node...
 Q
 ;
F22 ; 772 - 2 - 0;2 - SERVER APPLICATION
 D UPD(0,2,VALUE)
 Q
 ;
F2202 ; 772 - 2.02 - 2;2 - FAST PURGE DT/TM
 ; Only fire the ^HLMA(A)I xref when STATUS in 773 is changed...
 D UPD(2,2,VALUE)
 Q
 ;
F23 ; 772 - 3 - 0;3   [ae->AC,AH] - CLIENT APPLICATION
 ;
 ; ae->AC is in xref logic, but shouldn't be there!  So, not set.
 ; AH xref logic is not in DD, but should be!
 ;
 D UPD(0,3,VALUE)
 S XRF("AH")="",XRF("AC")=""
 Q
 ;
F24 ; 772 - 4 - 0;4   [AC] - TRANSMISSION TYPE
 ; AC is in xref logic, but shouldn't be there!  So, not set.
 D UPD(0,4,VALUE)
 S XRF("AC")=""
 Q
 ;
F25 ; 772 - 5 - 0;5 - RELATED MAILMAN MESSAGE
 D UPD(0,5,VALUE)
 Q
 ;
F26 ; 772 - 6 - 0;6   [C,AH] - MESSAGE ID
 D UPD(0,6,VALUE)
 S XRF("AH")="",XRF("C")=""
 Q
 ;
F27 ; 772 - 7 - 0;7 - ACKNOWLEDGMENT TO
 D UPD(0,7,VALUE)
 Q
 ;
F28 ; 772 - 8 - 0;8   [AI] - PARENT MESSAGE
 D UPD(0,8,VALUE)
 S XRF("AI")=""
 Q
 ;
F29 ; 772 - 9 - 0;9 - PRIORITY
 D UPD(0,9,VALUE)
 Q
 ;
F210 ; 772 - 10 - 0;10 - RELATED EVENT PROTOCOL
 D UPD(0,10,VALUE)
 Q
 ;
F211 ; 772 - 11 - 0;11   [AXMITOUT1] - LOGICAL LINK
 D UPD(0,11,VALUE)
 S XRF("AXMIT")=""
 Q
 ;
F212 ; 772 - 12 - 0;12 - SECURITY
 D UPD(0,12,VALUE)
 Q
 ;
F213 ; 772 - 13 - 1;1 - CONTINUATION POINTER
 D UPD(1,1,VALUE)
 Q
 ;
F214 ; 772 - 14 - 0;14 - MESSAGE TYPE
 D UPD(0,14,VALUE)
 Q
 ;
F215 ; 772 - 15 - 2;1 - DON'T PURGE
 D UPD(2,1,VALUE)
 Q
 ;
F216 ; 772 - 16 - 0;13 - NAMESPACE
 D UPD(0,13,VALUE)
 Q
 ;
F220 ; 772 - 20 - P;1   [AF,AXMITOUT2] - STATUS
 D UPD("P",1,VALUE)
 S XRF("AF")="",XRF("AXMIT")=""
 Q
 ;
F221 ; 772 - 21 - P;2   [ad->AC] - DATE/TIME PROCESSED
 ; ad->AC is in xref logic, but shouldn't be there!  So, not set.
 D UPD("P",2,VALUE)
 S XRF("AC")=""
 Q
 ;
F222 ; 772 - 22 - P;3 - ERROR MESSAGE
 D UPD("P",3,VALUE)
 Q
 ;
F223 ; 772 - 23 - P;4 - ERROR TYPE
 D UPD("P",4,VALUE)
 Q
 ;
F226 ; 772 - 26 - P;7 - ACK TIMEOUT
 D UPD("P",7,VALUE)
 Q
 ;
F2100 ; 772 - 100 - S;1 - NO. OF CHARACTERS IN MESSAGE
 D UPD("S",1,VALUE)
 Q
 ;
F2101 ; 772 - 101 - S;2 - NO. OF EVENTS IN MESSAGE
 D UPD("S",2,VALUE)
 Q
 ;
F2102 ; 772 - 102 - S;3 - TRANSMISSION TIME
 D UPD("S",3,VALUE)
 Q
 ;
 ; =================================================================
 ;
 ; The XRF fields all have a common format XRF_xrf
 ;
XRFAC ; AC XREF kills/sets...
 N APP2,APP3,DTPROC,SET,TTYPE
 ;
 ; The xref should be created ONLY if D/T PROCESSED is not present
 ; in the new data.  The KILL logic based on the pre-change data
 ; is always executed...
 ;
 ; D/T PROC'D check of new data to determine whether SET should occur...
 S X=NODE(0,1),APP2=$P(X,U,2),APP3=$P(X,U,3),TTYPE=$P(X,U,4)
 S DTPROC=$P(NODE("P",1),U,2)
 S SET=0 ; Default
 I APP3,TTYPE="O",'DTPROC S SET=1
 ;
 ; Do appropriate SETs and KILLs...
 D XRFSETC(FILE,+IEN,"AC",0,4,0,3,SET)
 ; SET controls whether new xref SET.  KILLs always occur...
 ;
 Q
 ;
XRFAF ; AF XREF kills/sets...
 D XRFSET(FILE,+IEN,"AF","P",1)
 Q
 ;
XRFAH ; AH XREF kills/sets...
 D XRFSETC(FILE,+IEN,"AH",0,3,0,6)
 Q
 ;
XRFAI ; AI XREF kills/sets...
 D XRFSET(FILE,+IEN,"AI",0,8)
 Q
 ;
XRFAXMIT ; A-XMIT-OUT XREF kills/sets...
 N IEN870,SET,STAT,STATCODE
 ;
 ;
 ; Get status IEN and CODE...
 S STAT=+NODE("P",1),STATCODE=$P($G(^HL(771.6,+STAT,0)),U,2)
 ;
 ; Get logical link IEN...
 S IEN870=$P(NODE(0,1),U,11)
 ;
 ; Now, determine whether SETs should occur...
 S SET=$S(STAT>0&(IEN870>0)&(STATCODE="PT"):1,1:0)
 ;
 D XRFSET(FILE,+IEN,"A-XMIT-OUT",0,11,SET)
 ;
 Q
 ;
XRFB ; B XREF kills/sets...
 D XRFSET(FILE,+IEN,"B",0,1)
 Q
 ;
XRFC ; C XREF kills/sets...
 D XRFSET(FILE,+IEN,"C",0,6)
 Q
 ;
 ;
XRFSET(FILE,IEN,XRF,ND,PCE,SET) ; Perform sets and (2 subscript xrf) kills...
 ;
 ; Note: change stored for evaluation into NODE("XRF")...
 ;
 N RUN,VAL
 ;
 ; Should XREF be created based on new data?
 ; If SET not defined, it should be SET=1 (to set)...
 S SET=$S('$D(SET):1,1:+$G(SET))
 ;
 ; Set KILL values based on original data before XRF set...
 S RUN=0 ; Pre-value...
 S VAL=$P(NODE(ND,RUN),U,+PCE) I VAL]"" D
 .  S NODE("XRF","KILL",XRF,VAL,+IEN)=""
 .  I FILE=772 KILL ^HL(772,XRF,VAL,+IEN)
 .  I FILE=773 KILL ^HLMA(XRF,VAL,+IEN)
 ;
 ; Set SET values based on post-change data...
 S RUN=1 ; Post-value...
 I SET D  ; Should SETs be executed? (This is the CONDITIONAL)
 .  S VAL=$P(NODE(ND,RUN),U,+PCE) I VAL]"" D
 .  .  S NODE("XRF","SET",XRF,VAL,+IEN)=""
 .  .  I FILE=772 S ^HL(772,XRF,VAL,+IEN)=""
 .  .  I FILE=773 S ^HLMA(XRF,VAL,+IEN)=""
 ;
 Q
 ;
XRFSETC(FILE,IEN,XRF,ND1,PC1,ND2,PC2,SET) ; [C]omplex (3 subscript) XREF set/kill...
 N RUN,VAL1,VAL2
 ;
 ; Note: change stored for evaluation into NODE("XRF")...
 ;
 ; Define SET for later...
 S SET=$S('$D(SET):1,1:+$G(SET))
 ;
 ; Set KILL values based on original data before XRF set...
 S RUN=0 ; Pre-value...
 S VAL1=$P(NODE(ND1,RUN),U,+PC1) I VAL1]"" D
 .  S VAL2=$P(NODE(ND2,RUN),U,+PC2) I VAL2]"" D
 .  .  S NODE("XRF","KILL",XRF,VAL1,VAL2,+IEN)=""
 .  .  I FILE=772 KILL ^HL(772,XRF,VAL1,VAL2,+IEN)
 .  .  I FILE=773 KILL ^HLMA(XRF,VAL1,VAL2,+IEN)
 ;
 ; Set SET values based on post-change data...
 S RUN=1 ; Pre-value...
 I SET D
 .  S VAL1=$P(NODE(ND1,RUN),U,+PC1) I VAL1]"" D
 .  .  S VAL2=$P(NODE(ND2,RUN),U,+PC2) I VAL2]"" D
 .  .  .  S NODE("XRF","SET",XRF,VAL1,VAL2,+IEN)=""
 .  .  .  I FILE=772 S ^HL(772,XRF,VAL1,VAL2,+IEN)=""
 .  .  .  I FILE=773 S ^HLMA(XRF,VAL1,VAL2,+IEN)=""
 ;
 Q
 ;
 ; =================================================================
 ;
UPD(ND,PCE,VAL) ; Update NODE(1) piece of data...
 ;
 ; Is the field being changed?  If not, quit...
 QUIT:$P(NODE(ND,0),U,PCE)=VAL  ;->
 ;
 ; Update node...
 S $P(NODE(ND,1),U,PCE)=VAL
 ;
 ; Count number pieces changed on each node...
 S NODE("CHG",ND)=$G(NODE("CHG",ND))+1
 S NODE("CHG",ND,PCE)=""
 ;
 Q
 ;
EOR ;HLDIE772 - Direct 772 & 773 Sets ; 11/18/2003 11:17
