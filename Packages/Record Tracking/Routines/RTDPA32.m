RTDPA32 ;MJK/TROY ISC;Borrower File Lookup; ; 5/19/87  2:48 PM ;
 ;;v 2.0;Record Tracking;**16**;10/22/91 
BOR D EQUALS^RTUTL3 W !,"[",$P(RTMV0,"^")," OPTION]"
BOR1 S DIC="^RTV(195.9,",DIC(0)="IZDALEMQ",DIC("DR")="3////"_+RTAPL,DIC("S")="S Z0=^(0),Z=$P($P(Z0,U),"";"",2) I $P(Z0,U,3)="_+RTAPL_" D DICS1^RTDPA31",DIC("V")="S RTA="_+RTAPL_" D DICV^RTDPA31 K RTA",DIC("A")="Select Borrower: "
 D ^DIC K DIC Q:Y<0  S RTB=+Y,Y=0 D CHK:$D(^RTV(195.9,RTB,0)) I 'Y K RTB W *7 G BOR1
 D DR^RTDPA3 Q
 ;
DUPCHK ;Input Transform for Application field for file 195.9 (BORROWERS)
 Q:'$D(^RTV(195.9,"ABOR",$P(^RTV(195.9,DA,0),"^"),X))  Q:$O(^(X,0))=DA  K X Q:'$D(^RTV(195.9,+$O(^(0)),0))
 W !!,"This borrower is already in borrower file." D CHK K:'Y X Q
 ;
CHK ;The current naked reference must be the zeroth node of an entry
 ;in the BORROWERS/FILE AREAS file (#195.9)
 S Y=1 I $P(^(0),"^",10)="i" W !?5,"...borrower has been inactivated" S Y=0 Q
 I $P(^(0),"^",10)="r" W !?5,"...borrower's privileges have been revoked" S Y=0 Q
 I $D(^("KEY")),$P(^("KEY"),U)]"",'$D(^XUSEC($P(^("KEY"),U),DUZ)) W !?5,"...you do not have the necessary security privileges",!?8,"to choose this borrower!" S Y=0 Q
 Q
