PRCNPURG ;SSI/ALA-Purge transactions ;[ 03/08/96  10:15 AM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
EN ;  Ask for number of days to retain transactions
 K DIR S DIR("A")="Select number of days to retain equipment/turn-in requests "
 S DIR("?")="Enter the number of days from today that completed and cancelled equipment/turn-in requests will be retained"
 S DIR(0)="N^7:365" D ^DIR G EXIT:$D(DIRUT)
 S NDYS=X
EQR ;  Purge completed equipment requests
 S GLO=413,DIK="^PRCN(413," D CAN
 F ST=16,34 S NN="",DIK="^PRCN(413," D
 . F  S NN=$O(^PRCN(413,"AC",ST,NN)) Q:NN=""  D
 .. S X1=$P(^PRCN(413,NN,0),U,8),X2=NDYS
 .. D C^%DTC Q:X'>DT  S DA=NN D DK
 K DA,NN,X1,X2,ST,X,DIK
TIR ;  Purge completed turn-in requests
 S GLO=413.1,DIK="^PRCN(413.1," D CAN
 S NN="",DIK="^PRCN(413.1,"
 F  S NN=$O(^PRCN(413.1,"AC",24,NN)) Q:NN=""  D
 . S X1=$P(^PRCN(413.1,NN,0),U,8),X2=NDYS
 . D C^%DTC Q:X'>DT  S DA=NN D DK
EXIT K NN,DIK,DA,X1,X2,X,DIR,NDYS
 Q
DK D ^DIK
 Q
CAN ;  Purge cancelled transactions
 S NN="" F  S NN=$O(^PRCN(GLO,"AC",20,NN)) Q:NN=""  S DA=NN D DK
 K GLO
 Q
