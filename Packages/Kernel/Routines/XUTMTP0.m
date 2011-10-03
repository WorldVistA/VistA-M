XUTMTP0 ;SEA/RDS - TaskMan: ToolKit, Print, Part 2 ;12/16/94  15:47
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
 Q
STATUS ;
 S %=$P(XUTSK(.1),U) I %]"",$T(@%)]"" D @% Q
TRAP S XUTSK(.15,ZTC)="This task has an irregular status code." Q
 ;
CODES ;Messages For The Various Status Codes
0 S XUTSK(.15,ZTC)="Incomplete or still being created." Q
1 S XUTSK(.15,ZTC)="Stopped irregularly while scheduled." Q
2 S XUTSK(.15,ZTC)="Being inspected by Task Manager." Q
3 S XUTSK(.15,ZTC)="Stopped irregularly while waiting for a partition." Q
4 S XUTSK(.15,ZTC)="Being prepared." Q
5 S XUTSK(.15,ZTC)="Started running "_XUTSK("UPDATE")_" and stopped irregularly." Q
6 S XUTSK(.15,ZTC)="Completed "_XUTSK("UPDATE")_"." Q
A S XUTSK(.15,ZTC)="Stopped irregularly while waiting for a device." Q
B S XUTSK(.15,ZTC)="Rejected.",XUTSK(.15,ZTC+1)=$P(XUTSK(.1),U,3),ZTC=ZTC+1 Q
C S XUTSK(.15,ZTC)="Error "_XUTSK("UPDATE")_".",XUTSK(.15,ZTC+1)=$P(XUTSK(.1),U,3),ZTC=ZTC+1 Q
D S XUTSK(.15,ZTC)="Stopped by "_$S(ZTNAME'=$P(XUTSK(.1),U,10):$P(XUTSK(.1),U,10)_".",1:"you.") Q
E S XUTSK(.15,ZTC)="Interrupted while running." Q
F S XUTSK(.15,ZTC)="Unscheduled by "_$S(ZTNAME'=$P(XUTSK(.1),U,3):$P(XUTSK(.1),U,3)_".",1:"you.") Q
G S XUTSK(.15,ZTC)="Stopped irregularly while waiting for a link." Q
H S XUTSK(.15,ZTC)="Edited without being scheduled." Q
I S XUTSK(.15,ZTC)="Discarded by Task Manager because its record was incomplete." Q
J S XUTSK(.15,ZTC)="Currently being edited." Q
K S XUTSK(.15,ZTC)="Created without being scheduled." Q
L S XUTSK(.15,ZTC)="Preparing this task caused the submanager an error "_XUTSK("UPDATE")_".",XUTSK(.15,ZTC+1)=$P(XUTSK(.1),U,3),ZTC=ZTC+1 Q
 ;
 ;
