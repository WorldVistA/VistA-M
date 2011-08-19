PRCOEDI ;WISC/DJM-IFCAP EDI ENTRY ROUTINE ; 7/21/99 11:24am
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Receives variable PRCOPODA from calling routines.
 ;
 ; PRCOPODA = sting of up to 4 '^' pieces.
 ;            piece 1 = ien of 442 record
 ;            piece 2 = (optional) flag if not new order
 ;            piece 3 = (optional) amendment number
 ;            piece 4 = (optional) ien of 442 record if
 ;                        amendment is PO number change
 ;
 ;      piece 2 flag values:
 ;                  1 = create a PHM, do not transmit to EDI
 ;                  2 = create a PHA, do not transmit to EDI
 ; 
NEW N A,AMEND,A1,A12,CSDA,IEN,MO,PRC,PRCFA,PRCFASYS,PRCPXMZ,PTSW,RECORD
 N REQUEST,SERVICE,TEST,TOTAL,VAR1,VAR2,VAR3,VEN,V1,V2,V3,V4,V5,V6
 N W1,W2,YR,XMZ
 S VAR1=$P(PRCOPODA,"^",1)
 S W2="PHA"
 I $P(PRCOPODA,"^",2)=1 S W2="PHM"
 S AMEND=0
 I $P(PRCOPODA,"^",2)]"" S AMEND=1 ; amendment, don't send to EDI
 S A=$G(^PRC(442,VAR1,0))
 I A="" W:'AMEND W2," not generated - purchase order corrupted.",!! Q
 S PRC("SITE")=$P($P(A,U),"-")
 S YR=$E(DT,2,3)
 S MO=$E(DT,4,5)
 S PRC("FY")=$E(100+$S(MO>9:YR+1,1:YR),2,3)
 S SERVICE=$P(A,U,12)
 I SERVICE>0 D  I $G(REQUEST)=3 W:'AMEND W2," not generated - inappropriate for this order.",!! Q
 . S RECORD=$G(^PRC(442,VAR1,13,SERVICE,0))
 . I RECORD]"" S REQUEST=$P(RECORD,U,9)
 S A1=$G(^PRC(442,VAR1,1))
 I A1="" W:'AMEND W2," not generated - PO informated corrupted",!! Q
 I $P(A1,U,7)=1 W W2," not generated - not used for GSA Supply Depot orders.",!! Q
 K ^TMP($J,"STRING")
 S VAR2=""
 S A12=$G(^PRC(442,VAR1,12))
 I A12]"",'AMEND G:$P(A12,U,10)>0 EXIT ;Already has EDI message #
 I 'AMEND S $P(A12,U,10)=999999999,^PRC(442,VAR1,12)=A12
 ;
 ; build segments
 D HE^PRCOE3(PRCOPODA,.VAR2) G:VAR2]"" EXIT
 D BI^PRCOE1(A,VAR1,.VAR2) G:VAR2]"" EXIT
 D VE^PRCOE1(A1,.VAR2) G:VAR2]"" EXIT
 D ST^PRCOE1(A,A1,VAR1,.VAR2) G:VAR2]"" EXIT
 D MI^PRCOE3(VAR1,.VAR2) G:VAR2]"" EXIT
 D AC^PRCOE4(A,A1,VAR1,.VAR2) G:VAR2]"" EXIT
 S TOTAL="" D IT^PRCOE2(VAR1,.VAR2,.TOTAL) G:VAR2]"" EXIT
 D CO^PRCOE3(VAR1,.VAR2,.TOTAL) G:VAR2]"" EXIT
 ;
 S IEN=$S($P($G(^PRC(442,VAR1,23)),U,7)>0:$P(^(23),U,7),1:PRC("SITE"))
 S PTSW=$P($G(^PRC(411,IEN,9)),U,4) ; test or production site
 S V2=""
 S VEN=$P(A1,U)
 I VEN>0,'AMEND S V1=$G(^PRC(440,VEN,3)),V2=$P(V1,U,2)
 S W1=PRC("SITE")
 S V3=$P($P(A,U),"-")_$P($P(A,U),"-",2)
 S V4=$S(PTSW="T":"IST",1:"ISM")
 I 'AMEND,V2="Y",$P($G(^PRC(442,VAR1,23)),U,11)'="P",$P($G(^(12)),U,16)'="n" S V4=$S(PTSW="T":"IST^EDT",1:"ISM^EDP")
 I AMEND D EN^DDIOL("...now generating the "_W2_" transaction...","","!!")
 D TRANSMIT^PRCPSMCS(W1,W2,V3,V4,200,1)
 S XMZ=$O(PRCPXMZ(0))
 I XMZ>0 S $P(^PRC(442,VAR1,12),U,10)=PRCPXMZ(XMZ)
 I AMEND G EXIT
 ;
 ;  NOW, IF THIS IS NOT FROM AMENDMENTS AND IS AN EDI 'PHA',
 ;  LETS ADD IT TO FILE 443.75.
 ;
 S W1=$P(A,U)
 S W2="PHA"
 S V3=PRCPXMZ(XMZ)
 S V5=$P(A1,U,10)
 S V6=VAR1
 S VAR3=$P(A1,U)
 S V4=$P($G(^PRC(440,VAR3,3)),U,3)
 I V2="Y",$P($G(^PRC(442,VAR1,12)),U,16)'="n",$P($G(^(23)),U,11)'="P" D ENTER^PRCOEDI(W1,W2,V3,V4,V5,V6)
 ;
EXIT I VAR2]"" W:'AMEND W2," not generated - missing information (data code: ",VAR2,")",!!
 K ^TMP($J,"STRING"),PRCOUT Q
 ;
VDEC(VALUE,LENGTH) ;
 ;  EXTRINSIC FUNCTION TO CONVERT NUMBER WITH DECIMAL INTO VIRTUAL
 ;  DECIMAL.
 ;
 ;   VALUE = NUMBER WITH DECIMAL TO CONVERT
 ;  LENGTH = NUMBER OF VIRTUAL DECIMAL PLACES
 ;
 ;  CALLED FROM PRCOE4
 ;
 N V1,V2
 S (V1,V2)="" G:'$D(VALUE) EXIT1
 S V1=$P(VALUE,".",1),V2=$P(VALUE,".",2)
 I '$D(LENGTH) S LENGTH=0,V2="" G EXIT1
 I LENGTH=0 S V2="" G EXIT1
 I LENGTH>0,LENGTH'<$L(V2) S $P(V2,"0",LENGTH)="0",V2=$E(V2,1,LENGTH)
 I LENGTH>0,LENGTH<$L(V2) S V2=$E(V2,1,LENGTH)
EXIT1 Q V1_V2
 ;
ENTER(ENTRY,TRANS,XMZ,VENDOR,SENDER,POINTER,RFQ,TXT) ;
 ;
 ;  THIS IS THE PARAMETER PASSED CALL TO ENTER A NEW ENTRY INTO
 ;  FILE 443.75.  ONE ENTRY WILL BE CREATED FOR EACH 'PHA'
 ;  TRANSACTION.  ONE OR MORE ENTRIES WILL BE CREATED FOR EACH 'RFQ'
 ;  OR 'TXT' TRANSACTION (THE CALLING ROUTINE WILL HAVE TO MAKE
 ;  SEPARATE CALLS, ONE FOR EACH DIFFERENT VENDOR).
 ;
 ;  INPUT PARAMETERS                 WHAT IT REPRESENTS
 ;   ENTRY                   IF THE TRANSACTION IS A 'PHA' THEN SEND
 ;                           THE FILE 442, .01 FIELD VALUE.
 ;                           IF THE TRANSACTION IS A 'RFQ' OR A 'TXT'
 ;                           SEND THE RFQ NUMBER.
 ;   TRANS                   SEND THE TYPE OF TRANSACTION BEING SENT
 ;                           TO AUSTIN ('PHA', 'RFQ' OR 'TXT').
 ;    XMZ                    THE MAILMAN NUMBER OF THE TRANSACTION.
 ;  VENDOR                   THE VENDOR ID USED IN THE TRANSACTION.
 ;  SENDER                   THE DUZ OF THE PERSON CREATING THE
 ;                           TRANSACTION ENTERING INTO FILE 443.75.
 ;  POINTER                  THE INTERNAL ENTRY NUMBER OF THE ENTRY.
 ;    RFQ                    THIS FIELD WILL CONTAIN '00' OR '01'.
 ;                           '00' IS A NORMAL RFQ.
 ;                           '01' IS A CANCELLED RFQ.
 ;    TXT                    THE TXT MESSAGE NUMBER.  THIS PARAMETER
 ;                           IS OPTIONAL.  ALL OTHER PARAMETERS ARE
 ;                           REQUIRED.
 ;
 ;  NOTHING ADDITIONAL IS RETURNED FROM THIS CALL.
 ;
 ;  ALL PASSED PARAMETERS ARE UNCHANGED.
 ;
 N I,IEN,PRCNO,PRC,PRCDA
 S IEN=""
 ;  SEE IF THE TRANSACTION IS ALREADY ENTERED IN FILE 443.75.
 ;  IF SO JUST UPDATE THE MAILMAN MESSAGE NUMBER AND DATE/TIME
 ;  THE MESSAGE WS MAILED.
 ;
 I TRANS="PHA" D  I IEN>0 Q
 .  S IEN=$O(^PRC(443.75,"AO",TRANS,ENTRY,VENDOR,0))
 .  I IEN>0 D UPDATE
 .  Q
 ;
 I TRANS="RFQ" D  I IEN>0 Q
 .  S IEN=$O(^PRC(443.75,"AC",TRANS,ENTRY,VENDOR,RFQ,0))
 .  I IEN>0 D UPDATE
 .  Q
 ;
 I TRANS="TXT" D  I IEN>0 Q
 .  S IEN=$O(^PRC(443.75,"AF",TRANS,ENTRY,VENDOR,TXT,0))
 .  I IEN>0 D UPDATE
 .  Q
 ;
 ;  CONTINUE HERE IF NO RECORD OF THE TRANSACTION WAS FOUND.
 ;
 F I=1:1:100 L +^PRC(443.75):1 Q:$T=1
 G:'$T STOP
 K PRCNO
 S PRCNO=1+$O(^PRC(443.75,"B",""),-1)
 S PRC(1,443.75,"?+1,",.01)=PRCNO
 S PRC(2)=""
 D UPDATE^DIE("","PRC(1)","PRC(2)")
 S PRCDA=PRC(2,1)
 L -^PRC(443.75)
 ;
 ;  HAVING CREATED A NEW ENTRY LETS POPULATE IT.
 ;
 F  L +^PRC(443.75,PRCDA):1 Q:$T=1
 S X=$P($$NET^XMRENT(XMZ),U)
 S %DT="ST"
 D ^%DT
 S:Y>0 PRC(1,443.75,"?+1,",6)=Y
 S PRC(1,443.75,"?+1,",1)=ENTRY
 S PRC(1,443.75,"?+1,",3)=TRANS
 S PRC(1,443.75,"?+1,",5)=VENDOR
 S PRC(1,443.75,"?+1,",4)=XMZ
 S PRC(1,443.75,"?+1,",5.5)=SENDER
 S:TRANS="RFQ" PRC(1,443.75,"?+1,",6.5)=RFQ
 S:$G(TXT)]"" PRC(1,443.75,"?+1,",2)=TXT
 S:TRANS="PHA" PRC(1,443.75,"?+1,",7)=POINTER
 S:TRANS'="PHA" PRC(1,443.75,"?+1,",8)=POINTER
 S PRC(1,443.75,"?+1,",.01)=PRCDA
 D UPDATE^DIE("","PRC(1)")
 L -^PRC(443.75,PRCDA)
STOP Q
 ;
UPDATE ;  COME HERE TO UPDATE AN EXISTING RECORD IN FILE 443.75.
 S PRC(1,443.75,"?+1,",.01)=IEN
 S PRC(1,443.75,"?+1,",4)=XMZ
 S X=$P($$NET^XMRENT(XMZ),U)
 S %DT="ST"
 D ^%DT
 S:Y>0 PRC(1,443.75,"?+1,",6)=Y
 F  L +^PRC(443.75,IEN):1 Q:$T=1
 D UPDATE^DIE("","PRC(1)")
 L -^PRC(443.75,IEN)
 G STOP
