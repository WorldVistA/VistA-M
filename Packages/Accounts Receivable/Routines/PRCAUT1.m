PRCAUT1 ;SF-ISC/YJK-AR 2ND UTILITY ROUTINE ;4/8/94  1:43 PM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Subroutines for multiple appropriation and mult.care
 ;and calculation of interest and admin.charge.
MULTPAY ;apply the payment to multiple appropriation.- oldest first
 Q:'$D(PRCAEN)!('$D(PRCAMT))  Q:PRCAMT'>0  S PRCAMT1=PRCAMT
 S PRCAKA1=$O(^PRCA(433,PRCAEN,4,"B","")) Q:PRCAKA1=""  S PRCAKA2=$O(^PRCA(433,PRCAEN,4,"B",PRCAKA1,"")) D P1
 F I=0:0 S PRCAKA1=$O(^PRCA(433,PRCAEN,4,"B",PRCAKA1)) Q:(PRCAKA1="")!(PRCAMT1'>0)  S PRCAKA2=$O(^(PRCAKA1,"")) I $D(^PRCA(433,PRCAEN,4,PRCAKA2,0)) D P1
 K PRCAKA1,PRCAKA2,I Q  ;end of MULTPAY
P1 S PRCAUMT=$P(^PRCA(433,PRCAEN,4,PRCAKA2,0),U,2)
 I PRCAUMT>PRCAMT1 S PRCAUMT=PRCAUMT-PRCAMT1,PRCAUMT1=PRCAMT1,PRCAMT1=0
 E  S PRCAMT1=PRCAMT1-PRCAUMT,PRCAUMT1=PRCAUMT,PRCAUMT=0
 S $P(^PRCA(433,PRCAEN,4,PRCAKA2,0),U,2)=PRCAUMT,$P(^(0),U,4)=1,$P(^(0),U,5)=PRCAUMT1 K PRCAUMT,PRCAUMT1 Q
 ;
COMMON ;Edit common number series for AR - 8K#### or K8####
 W !,"This option is no longer supported by the AR package.",!,"Please use the IFCAP option 'Establish Common Numbering Series' under",!,"the IFCAP package coordinator menu." Q
DEVICE ;assign a printer in the AR section for only AR use.
 W !,"This option is no longer supported by the AR package.",!,"Please use the AR Site Parameter option edit." Q
ARPARAM Q
ADDPARM Q
 ;
HOLD W !,"..........PLEASE HOLD ON.............." Q
