PRCFFU6 ;WISC/SJG-OBLIGATION PROCESSING UTILITIES ;4/27/94  2:46 PM
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ; No Top Level Entry
 QUIT
COMP(REC442,REC410,FLAG) ; Compare values from 1358 SOE and 1358 SOM
 ; REC442 - IEN for original obligated 1358 from 442
 ; REC410 - IEN for adjusted unobligated 1358 from 410
 ; Get original values from 442
 ; FLAG = Return value for error check^increase/decrease condition
VAR ; Set up variables
 K TMP442,TMP410 N LOOPX,CPFLAG,CCFLAG,BOCFLAG,ERFLAG,CHANGE
 S (CPFLAG,CCFLAG,BOCFLAG,ERFLAG,CHANGE)=0
 F LOOPX="BOC","DEL","DELSCH","FOB","PPT","VEND" S PRCFA(LOOPX)=""
 F LOOPX="BOC","CC","FCP","VEND" S PRCFA("CHG",LOOPX)=""
 N DA S DIC=442,DR="1;2;3;3.4;5",DA=+REC442,DIQ="TMP442(",DIQ(0)="IE" D EN^DIQ1 K DIC,DIQ,DR
 N DA S DIC=410,DR="11;12;15;15.5;17;17.5",DA=+REC410,DIQ="TMP410(",DIQ(0)="IE" D EN^DIQ1 K DIC,DIQ,DR
VEN ; Compare Vendor
 ; Compare external vendor name on adjustment with external vendor name
 ; from 442
VEN1 I $G(TMP410(410,+REC410,12,"I"))'=$G(TMP442(442,+REC442,5,"I")) D  G:PRCFA("VEND")=1 CP
 .Q:$G(TMP442(442,+REC442,5,"I"))=""
 .I $G(TMP410(410,+REC410,12,"I"))="" D
 ..Q:$G(TMP410(410,+REC410,11,"E"))=$G(TMP442(442,+REC442,5,"E"))
 ..K MSG W !
 ..S MSG(1)="  The vendor on this 1358 adjustment is missing!",MSG(1.5)=" "
 ..S MSG(2)="  Vendor on original 1358 obligation: "_$G(PRCTMP(410,$G(PRCTMP(442,+REC442,.07,"I")),11,"E"))
 ..S MSG(3)="  Vendor pointer on original 1358 obligation: "_$G(PRCTMP(410,$G(PRCTMP(442,+REC442,.07,"I")),12,"I")),MSG(3.5)=" "
 ..S MSG(4)="  Please have IRM correct the vendor on the 1358 adjustment before proceeding."
 ..D EN^DDIOL(.MSG) K MSG
 ..S PRCFA("VEND")=1,PRCFA("CHG","VEND")="VENDOR"
 ..Q
 .Q
 ; Compare vendor pointer from adjustment with vendor pointer from 442
VEN2 I $G(PRCTMP(410,$G(PRCTMP(442,+REC442,.07,"I")),12,"I"))'=$G(TMP410(410,+REC410,12,"I")) D
 .I $G(TMP410(410,+REC410,12,"I"))="" Q:$G(PRCTMP(410,$G(PRCTMP(442,+REC442,.07,"I")),11,"E"))=$G(TMP410(410,+REC410,11,"E"))
 .S PRCFA("VEND")=1,PRCFA("CHG","VEND")="VENDOR"
 .K MSG W !
 .S MSG(1)="  The vendor pointer on this 1358 adjustment is different from the vendor"
 .S MSG(2)="  pointer on the 442 record!"
 .S MSG(2.5)=" "
 .S MSG(3)="  Vendor name on obligation: "_$G(PRCTMP(410,$G(PRCTMP(442,+REC442,.07,"I")),12,"E"))
 .S MSG(4)="  Vendor pointer: "_$G(PRCTMP(410,$G(PRCTMP(442,+REC442,.07,"I")),12,"I"))
 .S MSG(4.5)=" "
 .S MSG(5)="  Vendor name on adjustment: "_$G(TMP410(410,+REC410,12,"E"))
 .S MSG(6)="  Vendor pointer: "_$G(TMP410(410,+REC410,12,"I"))
 .S MSG(6.5)=" "
 .S MSG(7)="  Please contact IRM for assistance!"
 .D EN^DDIOL(.MSG) K MSG
 .Q
CP ; Compare Control Point
 I +$G(TMP410(410,+REC410,15,"I"))'=+$G(TMP442(442,+REC442,1,"I")) S CPFLAG=1,PRCFA("CHG","FCP")="FUND CONTROL POINT"
CC ; Compare Cost Center
 I +$G(TMP410(410,+REC410,15.5,"I"))'=+$G(TMP442(442,+REC442,2,"I")) S CCFLAG=1,PRCFA("CHG","CC")="COST CENTER"
BOC ; Compare BOC
 I +$G(TMP410(410,+REC410,17,"I"))'=+$G(TMP442(442,+REC442,3,"I")) S BOCFLAG=1,PRCFA("CHG","BOC")="BOC"
AMT ; Check for change in amounts
 I $G(TMP410(410,+REC410,17.5,"I")) D
 .I TMP410(410,+REC410,17.5,"I")>0 S IDFLAG="I"
 .I TMP410(410,+REC410,17.5,"I")<0 S IDFLAG="D"
 D
 .I BOCFLAG S (CHANGE,ERFLAG)=1 Q
 .I PRCFA("VEND") S (CHANGE,ERFLAG)=1 Q
 .I CPFLAG S (CHANGE,ERFLAG)=1 Q
 .I CCFLAG S (CHANGE,ERFLAG)=1 Q
 .Q
 QUIT ERFLAG_"^"_IDFLAG_"^"_CHANGE
UPDATE(REC442,REC410) ; Update Node 22 in File 442
 S AMT=+$G(TMP410(410,+REC410,17.5,"I"))+$G(TMP442(442,+REC442,3.4,"I"))
 S BOC=+$G(TMP442(442,+REC442,3,"I"))
 N DA S DA(1)=REC442
 S DIC="^PRC(442,"_DA(1)_",22,",DIC(0)="QEMZ",X=BOC D ^DIC
 I Y>0 S DIE=DIC,DA=+Y,DR="1////^S X=AMT" D ^DIE
 K DIC,DIE,DR,TMP410,TMP442,AMT,BOC
 QUIT
AUTACC ; Update Ending Date and Auto Accrual Flag
 Q:'$D(TMP("NEWDATE"))
 N DATE,FLAG
 S DATE=$P(TMP("NEWDATE"),U),FLAG=$P(TMP("NEWACC"),U)
 S DIE=442,DA=POIEN,DR="29///^S X=DATE;30///^S X=FLAG" D ^DIE K DIE,DR,TMP("NEWACC"),TMP("NEWDATE")
 QUIT
