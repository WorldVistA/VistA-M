DGPTMSGD ;ALB/JDS - PTF MULTIMESSAGE DELETE ; 19 DEC 84@ 0800
 ;;5.3;Registration;;Aug 13, 1993
 D LO^DGUTL
EN S Z="^PATIENT^NUMBER" R !!,"DELETE BY [P]ATIENT OR [N]UMBER: ",X:DTIME G Q:X=""!('$T)!(X="^") D IN^DGHELP G:%'=-1 @X W !!,"Enter 'P' to delete PTF messages by patient",!,"   or 'N' to delete PTF messages by number" G EN
P S DIC="^DPT(",DIC(0)="QEAM",DIC("S")="I $D(^DGM(""PT"",+Y))",DIC("A")="Select Patient whose messages you wish to check off:  " D ^DIC G Q:+Y'>0 S DGPTF=+Y K DIC S %DT="XT",X="N" D ^%DT S NOW=+Y D READ G EN
LOOP F I=0:0 S I=$O(^DGM("PT",DGPTF,I)) Q:I'>0  W ! R:Z>20 "'^' TO STOP",X:DTIME D BACK:Z>20 Q:X["^"  W I,?10 I $D(^DGM(I,"M",0)) D MES1
READ R !!,"Enter the message #'s you wish to release:  ",X:DTIME G Q:X']""!('$T) G @($S(X["^":"Q",X["-":"THRU",X[",":"PICK",X?.N:"ONE",X="ALL"!(X="all"):"ALL",1:"HELP"))
THRU S DGFR=$P(X,"-",1),DGTO=$P(X,"-",2) D DEL G Q
DEL S DIK="^DGM(" F I=DGFR:1:DGTO I $D(^DGM(I,0)) I 'DGPTF!($P(^(0),U,2)=DGPTF) S DA=I D ^DIK W !,I,?10,"** Deleted **"
 Q
ONE S DGFR=X,DGTO=X D DEL G Q
PICK S J=1,A=X
PICK1 S DGFR=$P(A,",",J) Q:DGFR'>0  S DGTO=DGFR D DEL S J=J+1 G PICK1
 G Q
HELP W !!,"Enter:",!?10,"ALL to release all messages",!?10,"# to release a specific message",!?10,"#-# to release a range of messages",!?10,"#,#,#... to release a group of messages"
 S Z=10 I X["??" W !,"Choose From:" G LOOP
 W !!,"Do you want to see a list of messages for this patient" S %=1 D YN^DICN G Q:%<0,HELP:'%,LOOP:%'=2 G READ
ALL S J=0,DGALL=""
ALL1 S J=$O(^DGM("PT",DGPTF,J)) G Q:J'>0 S DGFR=J,DGTO=J D DEL G ALL1
 Q
BACK S Z=0 F J=1:1:12 W $C(8)
 Q
MES1 F J=0:0 S J=$O(^DGM(I,"M",J)) Q:J'>0  S L=^(J,0) W:J>1 ! D MESS
 Q
MESS F K=0:1:2 I $L(L)>(65*K) W:K ! W ?13,$E(L,1+(K*65),65*(K+1)) S Z=Z+1
 Q
N S DGPTF=0 R !!,"Enter the message #'s you wish to release: ",X:DTIME G Q:('$T) G @($S(X="":"EN",X["^":"Q",X["-":"THRU",X[",":"PICK",X?.N:"ONE",1:"HLPN"))
HLPN W !!,"Enter:",!?10,"# to release a specific message",!?10,"#-# to release a range of messages",!?10,"#,#,#... to release a group of messages",!
 S DIC="^DGM(",DIC(0)="M" S:X'["?" X="?" D ^DIC G N
Q K %Y,L,K,DA,Z,Y,%,DGPTF,J,I,X,A,DIK,DIC,%DT,DGFR,DGTO Q
