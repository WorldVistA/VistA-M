RMPRPOST ;PHX/JLT,HNB-POST INIT / DELETE LOAN PROGRAM ;5/23/95
 ;;3.0;PROSTHETICS;;Feb 09, 1996
 ;POST INIT
 ;quit if prosthetics not in package file
 I '$D(^DIC(9.4,"B","PROSTHETICS")) W !,$C(7),?5,"PROSTHETICS PACKAGE NOT LOADED ON THIS SYSTEM!" Q
 G POST
 Q
LOAN ;check if loan program has already been deleted
 I '$D(^RMPR(660.1)) W !,$C(7),?5,"LOAN PROGRAM HAS ALREADY BEEN DELETED!" Q
 ;ask to delete loan program, some sites may be using
 S DIR(0)="Y",DIR("A")="Ready to Delete the Loan Program"
 S DIR("B")="YES" D ^DIR Q:Y'=1
 W !!,?5,"Searching for and deleting Loan Cards" K RMPRFIND
 F RMPRL=0:0 S RMPRL=$O(^RMPR(660.1,RMPRL)) Q:RMPRL'>0  I $D(^RMPR(660.1,RMPRL,0)),$P(^(0),U,9)=1 S DIK="^RMPR(660.1,",DA=RMPRL D ^DIK W "." S RMPRFIND=1
 I '$D(RMPRFIND) W !!,?5," ** No Loan Cards have been entered on your system"
 I $D(RMPRFIND) W !!,?5," ** All Loan Card Entries have been Deleted"
 K ^RMPR(660.1,"AF"),^RMPR(660.1,"AG"),^RMPR(660.1,"AC"),^RMPR(660.1,"AD"),^RMPR(660.1,"AP"),^RMPR(660.1,"AR"),DA,DIK
 W !!,?5,"Removing Loan Card Fields from the 660.1 Data Dictionary"
 F DA=.05,6,7,8,9,12,19,21,22 S DA(1)="660.1",DIK="^DD(660.1," D ^DIK
 S DIU=660.18,DIU(0)="S" D EN^DIU2
 W !!,?5,"Re-indexing File 660.1"
 K DA,DIK S DIK="^RMPR(660.1," D IXALL^DIK
 W !!,?5,"Deleting File 660.2"
 S DIU="^RMPR(660.2,",DIU(0)="DS" D EN^DIU2 K DIU
 W !!,?5,"Deleting Loan Card Options"
OPT ;delete options
 F OPT="RMPR LOAN DEL","RMPR LOAN CREATE","RMPR LOAN RET","RMPR LOAN DISP","RMPR LOAN FOLLOW-UP","RMPR LOAN PRINT ALL","RMPR LOAN EDIT","RMPR LOAN STAT","RMPR LOAN MENU" D
 .F REN=0:0 S REN=$O(^DIC(19,"B",OPT,REN)) Q:REN'>0  W !!,?5,"Deleting "_OPT_" Option" S DA=REN,DIK="^DIC(19," D ^DIK K DA,DIK
 ;end of deleting loan progarm
 ;
 Q
 ;
POST ;POST INIT FOR VERSION 3.0
AR ;DELETE OLD LAB AMIS CODES FROM FILE 660
 W !!,"Deleting Expired Fields From File 660 "
 F DA=41,65,66,67 S DIK="^DD(660,",DA(1)=660 D ^DIK W "."
 ;
PT ;DELETE EXPIRED FIELDS FROM FILE PROSTHETICS PATIENT FILE 665
 W !!,"Deleting Expired Fields From File 665 "
 K DA,DIK F DA=3,4,5,6,7,8,9,11,17,24,25,29 S DIK="^DD(665,",DA(1)=665 D ^DIK W "."
 S DIU=665.011,DIU(0)="S" D EN^DIU2 K DA,DIU S DIU=665.029,DIU(0)="S" D EN^DIU2 W "."
 S DIU=665.5,DIU(0)="DST" D EN^DIU2 W "."
 S DIU=660.95,DIU(0)="DST" D EN^DIU2 W "."
 S DA=3,DA(1)=664.2,DIK="^DD(664.2," D ^DIK W "."
 S DIU=664.23,DIU(0)="S" D EN^DIU2 W "."
 W !!,"Setting New Cross References ..."
 S DIK="^RMPR(665.4,",DIK(1)="2^AH1" D ENALL^DIK
 S DIK="^RMPR(665.4,",DIK(1)="11^AH2" D ENALL^DIK
 W !!,"Removing Obsolete Keys ..."
 S RMPRKEY=0
 F RMPRKEYS="RMPR TEST","RMPRCC","RMPRSP","RMPR PRINT","RMPRCANCEL" D
 .S RMPRKEY=$O(^DIC(19.1,"B",RMPRKEYS,RMPRKEY))
 .D:RMPRKEY DEL^XPDKEY(RMPRKEY)
 .S RMPRKEY=0
 K RMPRKEY,RMPRKEYS
 ;MOVE THE SITE PARAMETER FILE OUT OF DIC
 I '$D(^RMPR(669.9)) D
 .W !!,"Moving the Site Parameter File Data"
 .;move the data first
 .S ^RMPR(669.9,0)=^DIC(669.9,0) W "."
 .;Loop to get multi-divisional sites
 .S RMPRB=0
 .F  S RMPRB=$O(^DIC(669.9,RMPRB)) Q:RMPRB'>0  D
 ..M ^RMPR(669.9,RMPRB)=^DIC(669.9,RMPRB) W "."
 .;at one time DINUM was set to 1, this is no longer the case
 .;M ^RMPR(669.9,1)=^DIC(669.9,1) W "."
 .M ^RMPR(669.9,"AC")=^DIC(669.9,"AC") W "."
 .M ^RMPR(669.9,"B")=^DIC(669.9,"B") W "."
 .M ^RMPR(669.9,"C")=^DIC(669.9,"C") W "."
 .W !!,"Deleting the OLD Site Parameter File "
 .S DIU="^DIC(669.9,",DIU(0)="DT" D EN^DIU2 W "..."
 ;Close-out purchasing purge changed from 90 to 120 as min.
 ;Cancelation Purchasing Purge changed from 90 to 120 as min.
 ;Need to check values and reset in file 669.9
 W !!,"Checking Purge Parameters ...",!
 S RMPRB=0
 F  S RMPRB=$O(^RMPR(669.9,RMPRB)) Q:RMPRB'>0  D
 .I $P(^RMPR(669.9,RMPRB,0),U,9)<120 S $P(^(0),U,9)=120 W !,"Close-Out Purchasing Purge set to 120 Days for ",$P(^(0),U,1),"."
 .I $P(^RMPR(669.9,RMPRB,0),U,10)<120 S $P(^(0),U,10)=120 W !,"Cancellation Purchasing Purge set to 120 Days for ",$P(^(0),U,1),"."
 ;
 ;If sites choose to they can run RMPRFRM, to reset the remarks in
 ;file 660.  Purchasing, Line Item Remarks add to Close-out remarks.
 ;caution to sites, this routine will not take into consideration
 ;the remarks that were added via ED2 option, after the transaction
 ;closed.  This will have to be a local decesion.
 ;RMPRFRM is not exported, must contact the developers for a copy.
 I $D(^DD(669.9)) W !!,?20,"THANK YOU, ALL DONE!"
 E  W !!!,"Installation NOT COMPLETE, D ^RMPTINIT to Finish This Installation!"
EXIT Q
