FHADR3 ; HISC/NCA - Facility Workload ;11/3/94  15:37
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter/Edit Outpatients Visits
 D QR^FHADR1 G:'PRE KIL
 S OLD=$S($E(PRE,5)=1:$E(PRE,1,3)-1_"0400",1:$E(PRE,1,5)-1_"00")
 S (Z,ZZZ)=""
 K DIC,DIE W ! S DIE="^FH(117.3,",DA=PRE
 S DR="21;23;S:X'="""" ZZZ=X"
 L +^FH(117.3,PRE,0):0 I '$T W !?5,"Another user is editing the entry." G KIL
 D ^DIE K DR
 I ZZZ,$D(^FH(117.3,OLD,"CLIN",0)) D
 .I '$D(^FH(117.3,PRE,"CLIN",0)) D
 ..S ^FH(117.3,PRE,"CLIN",0)="^117.325^^",NDE=$G(^FH(117.3,PRE,"CLIN",0)),NDE=$P(NDE,"^",4)
 ..F LP=0:0 S LP=$O(^FH(117.3,OLD,"CLIN",LP)) Q:LP<1  S Z1=$G(^(LP,0)) D 
 ...I Z1'="",'$D(^FH(117.3,PRE,"CLIN",LP,0)) S ^(0)=$P(Z1,"^",1),^FH(117.3,PRE,"CLIN","B",$P(Z1,"^",1),LP)="",NDE=NDE+1,$P(^FH(117.3,PRE,"CLIN",0),"^",3,4)=LP_"^"_NDE Q
 ..Q
 .Q
 S DR="I 'ZZZ S Y="""";25"
 S DR(2,117.325)=".01:1"
 D ^DIE L -^FH(117.3,PRE,0) K DIE,DR
KIL G KILL^XUSCLEAN
