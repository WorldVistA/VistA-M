DICLIB ;SFISC/TKW - LIBRARY OF FUNCTIONS FOR ^DIC ;05:00 PM  14 Oct 1998
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
NXTNO(F,DA,FLAGS) ;GET NEXT RECORD NUMBER FOR FILE OR SUBFILE F (F CAN CONTAIN A GLOBAL REFERENCE TO IMPROVE EFFICIENCY)
 ;DA=DA ARRAY (IF F IS A SUBFILE)
 ;FLAGS (OPTIONAL) IF IT CONTAINS "U", WILL UPDATE LAST REC.# ON 0 NODE
 N I,X,Y,DIC,% S X=0,I=1
 S:'F DIC=$TR(F,")",",") S:F DIC=$$ROOT^DIQGU(F,.DA)
 G:DIC="" QI G:'$D(@(DIC_"0)")) QI
INCR L @("+"_DIC_"0):10") G:'$T QL
 I 'X S Y=@(DIC_"0)"),X=$P($P(Y,U,3),"."),%=+$P(Y,U,2) I '$D(^DIA(%,"B")) S %=0
 F I=1:1 S X=X+1 Q:'$D(@(DIC_X_")"))&$S(%:+$O(^DIA(%,"B",X_","))'=X&'$D(^(X)),1:1)  I I=100 S I=0 Q
 I 'I L @("-"_DIC_"0)") G INCR
 I $G(FLAGS)["U" S $P(@(DIC_"0)"),U,3,4)=X_U_($P(Y,U,4)+1)
 L @("-"_DIC_"0)")
 Q X
QI D BLD^DIALOG(200) G Q0
QL D BLD^DIALOG(110,F)
Q0 Q 0
 ;DIALOG #200  'An input variable or parameter is missing or invalid.'
 ;       #110  'The record is currently locked'
