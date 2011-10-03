PRCOESE ;WISC/DJM-IFCAP EDI POA Server Interface ; [8/31/98 1:55pm]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
SERV N A,AA,AC,ACD,B,CC,CU,CU1,CU2,C1L,DA,DC,DIE,DR,EE,ERR,FOB,G,G1,I,IT
 N KD,KP,L,LINE,LN,MPN,M1,N,N1,N1L,N2,N2L,N3,N3L,PC,PN,PO,PO1,PPM,PPT
 N PRC,PRCNO,PRCOI,PU,QT,QTFLG,RP,S1,UC,UC1,UC2,UNIT,UP,UPN,VP,V1,V2
 N X,X1,X2,PRCTC,PRCX,RECORD,STATION,STCK,VENDOR
 K ERR
 ;
 ;If QTFLG=1, processing stops because the error is serious
 ;
 S (QTFLG,LN)=0
 F  S LN=$O(^PRCF(423.6,PRCDA,1,LN)) QUIT:'LN  G:QTFLG>0 S1 D MAIN
 ;
 QUIT
 ;
MAIN ;Start processing the POA segments
 ;
 S LINE=^(LN,0)
 I LINE["$" D S1 QUIT  ;End of this record. Stop and process any errors.
 ;
 S A=$P(LINE,U)
 S AA="SEG"_$S(A="ISM":"1",A="HE":"2",A="VE":"3",A="AC":"4",A="ST":"5",A="IT":"6",A="DE":"7",A="AK":"8",A="CO":"9",1:"10")
 ;
 D @AA ;Process segment
 ;
 QUIT
 ;
SEG1 S B=$P(LINE,U,4)
 G:B'="POA" SEG10
 S CC=$P(LINE,U,7)
 F  Q:$A(CC,$L(CC))'=32  S CC=$E(CC,1,$L(CC)-1)
 S CC=$E(CC,1,3)_"-"_$E(CC,4,$L(CC))
 S ERR(CC,0)=""
 S STATION=$P(LINE,U,3)
 S STCK=$O(^PRC(411,"B",STATION,0))
 I STCK'>0 S ERR("STATION")=STATION,QTFLG=1 Q
 S PO=$O(^PRC(442,"B",CC,0))
 S:PO="" ERR(CC,0)="*",QTFLG=1
 Q:QTFLG>0
 S PO1=$G(^PRC(442,PO,1))
 S:PO1="" ERR(CC,0)="*",QTFLG=1
 Q:QTFLG>0
 S PPM=$P(PO1,U,10)
 D BUL^PRCOESE1
 ;
 ; GATHER DATA FROM CONTROL SEGMENT.
 ;
 S PRCTC=$P(LINE,U,4)
 S X1=$E($P(LINE,U,5),1,4)-1700_"0101"
 S X2=$E($P(LINE,U,5),5,7)-1
 D C^%DTC
 S PRCX=X_"."_$P(LINE,U,6)
 ;
 QUIT  ;Exit the SEG1 sub routine
 ;
SEG2 QUIT
 ;
SEG3 ; GET DATA FROM "VE" SEGMENT.
 S VENDOR=$P(LINE,U,2)
 ;
 ; NOW LETS FIND THE PROPER RECORD IN FILE 443.75.
 ;
 ;Austin did not provide the Vendor_Id.  Use the PO to get it.
 I VENDOR="" D  QUIT:QTFLG=1
 . N PO,IEN
 . S PO=CC                                  ;PO number
 . S IEN=$O(^PRC(442,"B",PO,""))            ;Get IEN
 . S VENDOR=$P($G(^PRC(442,IEN,1)),U)       ;Internal_Vendor_Number
 . S VENDOR=$P($G(^PRC(440,VENDOR,3)),U,3)  ;Vendor_Id
 . I VENDOR'="" QUIT                        ;Vendor_Id (yes) 
 . S $P(ERR("VENDOR"),U)="*",QTFLG=1        ;Vendor_Id (no)
 .  ;
 S RECORD=$O(^PRC(443.75,"AO","PHA",CC,VENDOR,0))
 I RECORD="" S $P(ERR("RECORD"),U)="*",QTFLG=1
 ;
 QUIT  ;Exit the SEG3 sub routine
 ;
SEG4 S ERR(CC,"AC")=""
 I $P(LINE,U,3)]"" D  ;
 .  S FOB=$G(^PRC(442,PO,1))
 .  S:FOB="" ERR(CC,"AC")="*"
 .  S:$P(FOB,U,6)="" ERR(CC,"AC")="*"
 .  I $P(FOB,U,6)'=$P(LINE,U,3) S $P(ERR(CC,"AC"),U,2)="*"
 .  Q
 .  ;
 I $P(LINE,U,3)="" D  ;
 .  S FOB=$G(^PRC(442,PO,1))
 .  S:$P(FOB,U,6)'="" $P(ERR(CC,"AC"),U,3)="*"
 .  Q
 .  ;
 S KP=$P(LINE,U,5)
 S KD=$P(LINE,U,6)
 S (EE,G1,PC)=""
 S AC=$G(^PRC(442,PO,5,0))
 S:AC="" $P(ERR(CC,"AC"),U,4)="*"
 S:$P(AC,U,4)'>0 $P(ERR(CC,"AC"),U,4)="*"
 Q:$P(ERR(CC,"AC"),U,4)]""
 F ACD=1:1:$P(AC,U,4) D  ;
 .  S PPT(ACD)=$G(^PRC(442,PO,5,ACD,0))
 .  I +$P(PPT(ACD),U)=$P(PPT(ACD),U) S EE=$S(EE]"":EE_"^"_ACD,1:ACD)
 .  Q
 .  ;
 I EE]"" D  ;
 .  S G=$P(EE,U)
 .  S PC=$P(PPT(ACD),U)/100
 .  S G1=$P(PPT(ACD),U,2)
 .  Q
 .  ;
 I KP]"",PC'>0 S $P(ERR(CC,"AC"),U,7)="*"
 I EE]"",KP]"",KP'=PC S $P(ERR(CC,"AC"),U,5)="*"
 I KD]"",G1="" S $P(ERR(CC,"AC"),U,8)="*"
 I EE]"",KD]"",KD'=G1 S $P(ERR(CC,"AC"),U,6)="*"
 I KP="",PC>0 S $P(ERR(CC,"AC"),U,9)="*"
 I KD="",G1>0 S $P(ERR(CC,"AC"),U,10)="*"
 ;
 QUIT  ;Exit the SEG4 sub routine
 ;
SEG5 QUIT
 ;
SEG6 ;Process the "IT" segment from Austin
 S B=$P(LINE,U,2)    ;item line number  
 I B'>0 S $P(ERR(CC,.5),U,13)="*" Q
 S ERR(CC,B)=""
 S IT=$O(^PRC(442,PO,2,"B",B,0))
 S:IT="" $P(ERR(CC,B),U,2)="*"
 Q:IT=""
 S IT=$G(^PRC(442,PO,2,IT,0))
 S:IT="" $P(ERR(CC,B),U,2)="*"
 Q:IT=""
 S VP=$P(IT,U,6)
 S:VP="" $P(ERR(CC,B),U,3)="*"
 S:$E(VP,1)="#" VP=$E(VP,2,99)
 S:VP'=$P(LINE,U,5) $P(ERR(CC,B),U,9)="*"
 S QT=$P(IT,U,2)
 S:QT="" $P(ERR(CC,B),U,5)="*"
 S QT=QT\1+(QT#1>0)_"00"
 S:QT'=$P(LINE,U,8) $P(ERR(CC,B),U,10)="*"
 S PN=$P(LINE,U,6) ;Product number
 I PN]"" D  ;
 .  S RP=$P(IT,U,5)
 .  S:RP="" $P(ERR(CC,B),U,8)="*"
 .  I RP]"" D  ;
 .  .  S MPN=$G(^PRC(441,RP,3))
 .  .  S:MPN="" $P(ERR(CC,B),U,8)="*"
 .  .  I MPN]"" D  ;
 .  .  .  S MPN=$P(MPN,U,5)
 .  .  .  S:$E(MPN,1)="#" MPN=$E(MPN,2,99)
 .  .  .  S:MPN'=PN $P(ERR(CC,B),U,8)="*"
 .  .  .  Q
 .  .  Q
 .  Q
 .  ;
 S DC=$P(LINE,U,7) ;Get the National drug code
 I DC]"" D
 .  S N=$P(IT,U,15)
 .  S:N="" $P(ERR(CC,B),U,4)="*"
 .  I N]"" D
 .  .  S N1=$P(N,"-")
 .  .  S N2=$P(N,"-",2)
 .  .  S N3=$P(N,"-",3)
 .  .  S N1="000000"_N1
 .  .  S N1L=$L(N1)
 .  .  S N1=$E(N1,N1L-5,N1L)
 .  .  S N2="0000"_N2
 .  .  S N2L=$L(N2)
 .  .  S N2=$E(N2,N2L-3,N2L)
 .  .  S N3="00"_N3
 .  .  S N3L=$L(N3)
 .  .  S N3=$E(N3,N3L-1,N3L)
 .  .  S N=N1_N2_N3
 .  .  S:N'=DC $P(ERR(CC,B),U,4)="*"
 .  .  Q
 .  Q
 .  ;
 S UC=$P(LINE,U,10) ;Get the unit cost
 S UC1=$E(UC,1,$L(UC)-4)
 S UC2=$E(UC,$L(UC)-3,99)
 S UC1=$E(UC1+1000000,2,7)
 I UC2="0000" S UC=UC1_UC2 G S6B
 S UC2="."_UC2
 S UC2=$E($E(UC2+.005,2,3)_"0000",1,4)
 S UC=UC1_UC2
S6B S CU=$P(IT,U,9)
 S:CU="" $P(ERR(CC,B),U,7)="*"
 G:CU="" S6A
 I CU]"",CU="N/C" D  G S6A
 .  S CU="0000000000"
 .  S:UC'=CU $P(ERR(CC,B),U,12)="*"
 .  Q
 .  ;
 S CU1=$P(CU,".")
 S CU2=$P(CU,".",2)
 S CU1="000000"_CU1
 S C1L=$L(CU1)
 S CU1=$E(CU1,C1L-5,C1L)
 S CU2=CU2_"0000"
 S CU2=$E(CU2,1,4)
 S CU=CU1_CU2
 S:UC'=CU $P(ERR(CC,B),U,12)="*"
S6A S PU=$P(LINE,U,9) ;Get the unit of purchase
 S UP=$P(IT,U,3)
 S:UP="" $P(ERR(CC,B),U,6)="*"
 I UP]"" D  ;
 .  S UPN=$G(^PRCD(420.5,UP,0))
 .  S:UPN="" $P(ERR(CC,B),U,6)="*"
 .  I UPN]"" S UNIT=$P(UPN,U) S:UNIT'=PU $P(ERR(CC,B),U,11)="*"
 .  Q
 .  ;
 S DA(1)=PO
 S DIE="^PRC(442,DA(1),2,"
 S DR="12///@;12.5///@;13///@;13.5///@"
 S DA=B
 D ^DIE
 S PRC(1,443.75,"?+1,",.01)=$P($G(^PRC(443.75,RECORD,0)),U)
 S PRC(1,443.75,"?+1,",23)=PRCTC
 S PRC(1,443.75,"?+1,",24)=PRCX
 I $G(ERR(CC,B))]"" D  ;
 .  S PRC(1,443.75,"?+1,",19)="E"
 .  S PRC(1,443.75,"?+1,",20)=ERR(CC,B)
 .  Q
 .  ;
 D UPDATE^DIE("","PRC(1)")
 ;
 QUIT  ;Exit the SEG6 sub routine
 ;
SEG7 QUIT
 ;
SEG8 K DIE,DA,DR
 S B=$P(LINE,U,2)
 I B'>0 S $P(ERR(CC,.5),U,13)="*" Q
 S B=$O(^PRC(442,PO,2,"B",B,0))
 I B'>0 S $P(ERR(CC,B),U,2)="*" Q
 S DA(1)=PO
 S DA=B
 S DIE="^PRC(442,DA(1),2,"
 I $P($G(ERR(CC,B)),U,2)="" D  ;
 .  S V1=$P(LINE,U,3)
 .  S V2=$P(LINE,U,4)
 .  S:$P(^PRC(442,PO,2,B,2),U,9)="" DR="12///^S X=V1;12.5///^S X=V2"
 .  S:'$D(DR) DR="13///^S X=V1;13.5///^S X=V2"
 .  D ^DIE
 .  Q
 .  ;
 QUIT  ;Exit the SEG8 sub routine
 ;
SEG9 QUIT
 ;
SEG10 S ERR("SEG")=A,QTFLG=1
 ;
 QUIT  ;Exit the SEG10 sub routine
 ;
S1 D ^PRCOESE1
 ;
 QUIT
