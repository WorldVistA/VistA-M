PRC5INS1 ;WISC/RFJ-version 5 IFCAP installation continued ; 29 Jun 94
 ;;5.0;IFCAP;;4/21/95
 ;  environmental check for variable prc5inst
 I '$G(PRC5INST) K DIFQ Q
 I '$G(DUZ)!($G(DUZ(0))'["@") D ERROR("USER 'DUZ' VARIABLES **NOT** CORRECTLY DEFINED.") Q
 I +$$VERSION^XPDUTL("GEC")<2 D ERROR("GENERIC CODE SHEETS VERSION 2 NEEDS TO BE INSTALLED FIRST.") Q
 I +$$VERSION^XPDUTL("DG")<5.3 D ERROR("PIMS VERSION 5.3 NEEDS TO BE INSTALLED FIRST.") Q
 I +$$VERSION^XPDUTL("OR")<2.5 D ERROR("ORDER ENTRY VERSION 2.5 NEEDS TO BE INSTALLED FIRST.") Q
 I +$$VERSION^XPDUTL("VALM")<1 D ERROR("LIST MANAGER VERSION 1 NEEDS TO BE INSTALLED FIRST.") Q
 Q
 ;
 ;
ERROR(MSG) ;  do not allow installation of package
 W !!,"PLEASE FOLLOW INSTALLATION INSTRUCTIONS EXACTLY.",!,MSG
 K DIFQ,PRC5INST
 Q
 ;
 ;
CONTINUE ;  continue with installation of version 5
 W !!,"==================== *** STARTING  IFCAP  INSTALLATION *** ===================="
 ;  install part 1, inventory
 W !,"|",?78,"|",!,"|",?30,"----- PART 1 -----",?78,"|"
 W !,"PART 1: INSTALLING Generic Inventory Package ..."
 S (PRCPFLAG,PRCINSTL)=0
 I $P(PRC5INS1,"^",3)'="" D  I PRCPFLAG Q
 .   S XP="  THIS PART HAS ALREADY BEEN INSTALLED.  DO YOU WANT TO RE-INSTALL IT",XH="  ENTER 'YES' TO RE-INSTALL THE PART, 'NO' TO GO TO THE NEXT PART, '^' TO EXIT." S %=$$YN^PRCPUYN I %=2 S PRCINSTL=1 Q
 .   I %'=1 S PRCPFLAG=1 Q
 I 'PRCINSTL D
 .   D NOW^%DTC S Y=% D DD^%DT S PRCSTART=$J(Y,20) W ! D ^PRCPINIT
 .   D NOW^%DTC S Y=% D DD^%DT S PRCEND=$J(Y,20)
 .   S PRCTEXT(10,0)="PART 1: Generic Inventory Package "_PRCSTART_"  "_PRCEND
 ;  verify it was installed
 S DA=+$O(^DIC(9.4,"C","PRCP",0)),PRC5PRCP=DA_"^"_$G(^DIC(9.4,DA,"VERSION"))
 I +$P(PRC5PRCP,"^",2)=5,$P($G(^DIC(9.4,DA,22,+$O(^DIC(9.4,DA,22,"B",PRCVERS,0)),0)),"^",3) S Y=$P(^(0),"^",3) D DD^%DT S $P(PRC5INS1,"^",3)=Y
 I $P(PRC5INS1,"^",3)="" D NO Q
 ;
 ;  install part 2, ifcap
 W !!,"|",?78,"|",!,"|",?30,"----- PART 2 -----",?78,"|"
 W !,"PART 2: INSTALLING IFCAP Main System ..."
 S (PRCPFLAG,PRCINSTL)=0
 I $P(PRC5INS2,"^",3)'="" D  I PRCPFLAG Q
 .   S XP="  THIS PART HAS ALREADY BEEN INSTALLED.  DO YOU WANT TO RE-INSTALL IT",XH="  ENTER 'YES' TO RE-INSTALL THE PART, 'NO' TO GO TO THE NEXT PART, '^' TO EXIT." S %=$$YN^PRCPUYN(2) I %=2 S PRCINSTL=1 Q
 .   I %'=1 S PRCPFLAG=1 Q
 I 'PRCINSTL D
 .   D NOW^%DTC S Y=% D DD^%DT S PRCSTART=$J(Y,20) W ! D ^PRCINIT
 .   D NOW^%DTC S Y=% D DD^%DT S PRCEND=$J(Y,20)
 .   S PRCTEXT(11,0)="PART 2: IFCAP Main System         "_PRCSTART_"  "_PRCEND
 ;  verify it was installed
 S DA=+$O(^DIC(9.4,"C","PRC",0)),PRC5PRC=DA_"^"_$G(^DIC(9.4,DA,"VERSION"))
 I +$P(PRC5PRC,"^",2)=5,$P($G(^DIC(9.4,DA,22,+$O(^DIC(9.4,DA,22,"B",PRCVERS,0)),0)),"^",3) S Y=$P(^(0),"^",3) D DD^%DT S $P(PRC5INS2,"^",3)=Y
 I $P(PRC5INS2,"^",3)="" D NO Q
 ;
 ;
 ;  fire off mailman message
 D INSTALL^PRCPXTRM("IFCAP "_PRCVERS_" INSTALL","version "_PRCVERS,.PRCTEXT)
 W !!,"================== *** INSTALLATION OPTION 1 COMPLETED *** ================="
 W !,"CONGRATULATIONS !  IFCAP Version ",PRCVERS," - OPTION 1 COMPLETED."
 S %="",$P(%,"=",80)="" W !,%
 Q
NO ;  not installed
 W !!,"********************* === UNSUCCESSFUL INSTALLATION !! === ********************"
 K X S X(1)="You will not be able to continue with the installation of IFCAP until this part has been successfully installed." D DISPLAY^PRCPUX2(1,78,.X)
 W !,"PLEASE RE-RUN 'PRC5PKG' TO COMPLETE THE INSTALLATION !!"
 W !,"*******************************************************************************"
 Q
 ;
 ;
DESCRIP(FILESTRT,FILEEND) ;  remove ifcap file descriptions (node 21)
 ;  from filestrt to fileend.
 S FILESTRT=FILESTRT-.00001 F  S FILESTRT=$O(^DD(FILESTRT)) Q:'FILESTRT!(FILESTRT>FILEEND)  S FIELD=0 F  S FIELD=$O(^DD(FILESTRT,FIELD)) Q:'FIELD!(FIELD>1007)  K ^DD(FILESTRT,FIELD,21)
 Q
