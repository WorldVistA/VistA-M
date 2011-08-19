FBAARB ;AISC/GRR,dmk-RE-OPEN BATCH PREVIOUSLY CLOSED ;18OCT94
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
BT W !!
 S DIC="^FBAA(161.7,",DIC(0)="AEQMZ",DIC("S")=$S($D(^XUSEC("FBAASUPERVISOR",DUZ)):"I $G(^(""ST""))=""C""",1:"I $P(^(0),U,5)=DUZ&($G(^(""ST""))=""C"")")
 D ^DIC K DIC G Q:X="^"!(X=""),BT:Y<0
 S FBBAT=+Y,FBTYPE=$P(Y(0),U,3)
 ;FBBAT=ien of batch in 161.7  FBTYPE= batch type (B2,B3,B5,B9)
 ;reset payment line item total and total dollars
 D CNTTOT(FBBAT)
 S DIE="^FBAA(161.7,",DR="4////^S X=DUZ;4.5///@;10////^S X=FBLCNT;8////^S X=FBTOTAL;11////^S X=""O"";S:$G(FBTYPE)'=""B9"" Y="""";9////^S X=FBLCNT",DA=FBBAT
 D ^DIE K DIE,DR
 S:FBTOTAL=0 $P(^FBAA(161.7,+FBBAT,0),U,9)=""
 S:FBLCNT=0 $P(^FBAA(161.7,+FBBAT,0),U,11)=""
 W !! D EN^DIQ W !,"Batch has been Re-opened!" D Q G BT
 ;
Q K DA,FBLCNT,FBTOTAL,FBBAT,Y
 Q
 ;
CNTTOT(B) ;called to determine line count and total dollars for a batch
 ; INPUT:  B = IEN of batch in 161.7
 ; OUTPUT: FBLCNT = total line items in batch
 ;         FBTOTAL= total dollars in batch
 ;
 N A
 S (FBLCNT,FBTOTAL)=0
 Q:'$G(B)
 Q:'$D(^FBAA(161.7,+B,0))  S A=$P($G(^(0)),U,3)
 Q:A']""
 D @A
 Q
B2 ;travel batch use ^FBAAC("AD", to locate line items
 N I,J
 S (I,J)=0 F  S I=$O(^FBAAC("AD",B,I)) Q:'I  F  S J=$O(^FBAAC("AD",B,I,J)) Q:'J  I $D(^FBAAC(I,3,J,0)) D
 . S FBLCNT=FBLCNT+1,FBTOTAL=FBTOTAL+$P(^(0),U,3)
 Q
 ;
B3 ;outpatient batch use ^FBAAC("AC", to locate line items
 N I,J,K,L
 S (I,J,K,L)=0
 F  S I=$O(^FBAAC("AC",B,I)) Q:'I  F  S J=$O(^FBAAC("AC",B,I,J)) Q:'J  F  S K=$O(^FBAAC("AC",B,I,J,K)) Q:'K  F  S L=$O(^FBAAC("AC",B,I,J,K,L)) Q:'L  I $D(^FBAAC(I,1,J,1,K,1,L,0)) D
 . S FBLCNT=FBLCNT+1,FBTOTAL=FBTOTAL+$P(^(0),U,3)
 Q
 ;
B5 ;pharmacy batch use ^FBAA(162.1,"AE", to locate line items
 N I,J
 S (I,J)=0
 F  S I=$O(^FBAA(162.1,"AE",B,I)) Q:'I  F  S J=$O(^FBAA(162.1,"AE",B,I,J)) Q:'J  I $D(^FBAA(162.1,I,"RX",J,0)) D
 . S FBLCNT=FBLCNT+1,FBTOTAL=FBTOTAL+$P(^(0),U,16)
 Q
 ;
B9 ;inpatient batch use ^FBAAI("AC", to locate line items
 N I
 S I=0
 F  S I=$O(^FBAAI("AC",B,I)) Q:'I  I $D(^FBAAI(I,0)) D
 . S FBLCNT=FBLCNT+1,FBTOTAL=FBTOTAL+$P(^(0),U,9)
 Q
