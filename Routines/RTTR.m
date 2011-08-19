RTTR ;ISC-ALBANY/PKE;Record Transfer Option ; ; 9/10/90  14:24 ;
 ;;v 2.0;Record Tracking;;10/22/91 
 D DT^DICRW S X=$T(+1),DIK="^DOPT("""_$P(X," ;",1)_"""," G:$D(^DOPT($P(X," ;"),10)) A S ^DOPT($P(X," ;"),0)=$P(X,";",3)_"^1N^" F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT($P(X," ;"),I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A D OVERALL^RTPSET Q:$D(XQUIT)  W !! S DIC="^DOPT("""_$P($T(+1)," ;")_""",",DIC(0)="IQEAMZ" D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Transfer a Record to another Institution
 ; include reply
 W ! K RTB,RTJST S X="TRANSFER TO" D LK I RTINACFL D TFR^RTSYS I Y>0 S RTKEY=1,RTB=+Y D DR^RTDPA3,CO^RTT I $D(RTPAST),RTPAST'<DT,'$D(RTJST) D A^RTTR2
Q K RTKEY,RTFIN,RTINACFL,RTB,RTPAST,RTJST
 K ^TMP($J,"RT"),RTAR,RTV,J,DA,DIE,DIC,DR Q
 ;
2 ;;Return transferred Record from another Institution
 W ! K RTB S X="TRANSFER BACK" D LK I 'RTINACFL D CI^RTT
 G Q
 ;
3 ;;Create Record/volume from another Institution
 G TRAN^RTDPA1
 ;
4 ;;Request Transfer from another Institution
 G 4^RTTR1
 Q
LK S DIC="^DIC(195.3,",DIC(0)="IEMQEZ",DIC("S")="I $P(^(0),U,3)=+RTAPL" D ^DIC K DIC Q:Y<0  S RTMV=+Y,RTMV0=Y(0),RTINACFL=$P(Y(0),"^")["TRANSFER TO"
 Q
DAT ;to allow backdating of record transfers to institutions
 ;RTPAST used in rt charge template
 S DIR(0)="D^:NOW:AETX",DIR("A")="Enter the date of Transfer",DIR("B")="NOW" D ^DIR K DIR Q:$D(DUOUT)!($D(DTOUT))  S RTPAST=Y Q
 ;
INST S A=+RTAPL D DIC^RTDPA31 S DIC="^RTV(195.9,",DIC("A")="Select Institution: "
 S DIC(0)="IAEMQ",DIC("S")="S Z0=^(0),Z=$P($P(Z0,U),"";"",2) I Z=""DIC(4,"",$P(Z0,U,3)="_+RTAPL_" D DICS1^RTDPA31"
 Q
SM ;site manager instituition/borrower setup
 D DIP W !!,"Remote Institution Parameters:",!,"-----------------------------"
RE D INST,^DIC I Y'<0 S DA=+Y,DIE="^RTV(195.9,",DR="[RT FILE ROOM/REMOTE]" D ^DIE K DQ,DE G RE
 K RTREMOTE,DIC,DA,D0,DR,DIE Q
 Q
DIP W !!?5,"...compiling Remote/Institution profile for ",$P($P(RTAPL,"^",1),";",2),!
 S DIC="^RTV(195.9,",(BY,FLDS)="[RT FILE ROOM/REMOTE]",L=0,(FR,TO)="",DIS(0)="I $P(^RTV(195.9,D0,0),U,3)=+RTAPL" K DTOUT D EN1^DIP K DIC,FLDS,BY,L,TO,FR,IOP Q
