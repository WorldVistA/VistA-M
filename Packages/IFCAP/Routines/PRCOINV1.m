PRCOINV1 ;WISC/DJM/LEM-INV Server Interface to IFCAP ;11/29/93  08:17
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
MSG S M1="" F  S M1=$O(ERR(CC,M1)) Q:M1=""  Q:ERR(CC,M1)]""
 Q:M1=""
 S XMSUB="IFCAP 'INV' for Purchase Order "_CC,XMDUZ="IFCAP 'INV' SERVER" F I=1:1:5 D GET^XMA2 I I<5 Q:XMZ>0
 I I=5,XMZ<1 Q  ;MIGHT NEED TO REDO 'GET^XMA2' IF I=5 AND THERE IS NO XMZ.
 S M1="",L=1 F  S M1=$O(ERR(CC,M1)) Q:M1=""  I ERR(CC,M1)]"" D
 .I M1=0,$P(ERR(CC,M1),U)]"" S ^XMB(3.9,XMZ,2,L,0)="Purchase Order Acknowledgment "_CC_" was not found in the CI file.",L=L+1
 .I M1>0,$P(ERR(CC,M1),U,2,99)]"" F II=2:1:12 S BB=$P(ERR(CC,M1),U,II) I BB]"" D
 ..I II=2 S ^XMB(3.9,XMZ,2,L,0)="Item "_M1_" was not found in CI "_CC_".",L=L+1 Q
 ..I II=3 S ^XMB(3.9,XMZ,2,L,0)="The Vendor Stock Number wasn't found in item "_M1_".",L=L+1 Q
 ..I II=5 S ^XMB(3.9,XMZ,2,L,0)="There is no quantity listed for item "_M1_".",L=L+1 Q
 ..I II=6 S ^XMB(3.9,XMZ,2,L,0)="There is no Unit of Purchase listed for item "_M1_".",L=L+1 Q
 ..I II=7 S ^XMB(3.9,XMZ,2,L,0)="There is no Unit Cost listed for item "_M1_".",L=L+1 Q
 ..I II=9 S ^XMB(3.9,XMZ,2,L,0)="The Vendor Stock Number from the INV doesn't match the one from item "_M1_".",L=L+1 Q
 ..I II=10 S ^XMB(3.9,XMZ,2,L,0)="The Quantity listed in the INV doesn't match the one listed in item "_M1_".",L=L+1 Q
 ..I II=11 S ^XMB(3.9,XMZ,2,L,0)="The Unit of Purchase listed in the INV doesn't match the one in item "_M1_".",L=L+1 Q
 ..I II=12 S ^XMB(3.9,XMZ,2,L,0)="The Unit Cost listed in the INV doesn't match the one in item "_M1_".",L=L+1 Q
 ..Q
 .Q
 Q:L=1  S L=L-1,^XMB(3.9,XMZ,2,0)="^3.9A^"_L_"^"_L_"^"_DT
 S XMDUN="IFCAP 'INV' PROBLEM",X="G.EDP" D WHO^XMA21 S:'$L($O(XMY(""))) XMY(.5)="" S:$G(PPM)]"" XMY(PPM)="" D ENT1^XMD K XMY Q
BUL ;THIS BULLETIN WILL NOTIFY THAT A 'INV' TRANSACTION HAS ARRIVED FROM AUSTIN
 N XMDUZ,XMB,DATE,X,Y,XMB,%,%DT
 S XMDUZ="INV Server Interface",XMB="PRCOEDI ACKNOWLEDGE" D NOW^%DTC S Y=%,%DT="S" D DD^%DT S XMB(3)=$P(Y,"@"),XMB(4)=$P(Y,"@",2),XMB(5)=CC
 S DATE=$P(LINE,U,5),X1=$E(DATE,1,4)-1700_"0101",X2=+$E(DATE,5,7)-1 D C^%DTC S Y=X_"."_$P(LINE,U,6) D DD^%DT S XMB(1)=Y,XMB(2)=$P(LINE,U,3) D ^XMB Q
 Q
DATE(DATE) ;THIS EXTRINSIC FUNCTION WILL RETURN THE DATE IN YYYYJJJ FORMAT WHERE YYYY IS 4 DIGIT YEAR AND JJJ IS THE DAY OF THE YEAR.
 ;  THE INPUT, DATE, IS THE DATE TO CONVERT ENTERED IN VA FILEMAN FORMAT WITHOUT ANY TIME.  THE DATE MUST CONTAIN YEAR, MONTH AND DAY.
 N X,%Y S X1=DATE,X2=$E(DATE,1,3)_"0101" D ^%DTC S X=X+1,X="000"_X,X=$E(X,$L(X)-2,99) Q $E(DATE,1,3)+1700_X
