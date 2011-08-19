PRCFFU14 ;WISC/SJG-1358 OBLIGATION UTILITY ;8/18/94  17:03
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN(IEN) ; Called from 1358 obligation processing
 ; IEN - Internal entry number from 410
 W !,"Editing Auto Accrual information...",!
 S (ACCEDIT,AUTOACC,EXIT)=0
 D GENDIQ^PRCFFU7(410,IEN,"1;11;13;21;52","IEN","")
 I $G(PRCTMP(410,IEN,21,"I"))="",$G(PRCTMP(410,IEN,1,"I"))="O" D  Q
 .S FLDCHK=1
 .K MSG W !!
 .S MSG(1)="The DATE COMMITTED is missing - cannot process in Fiscal!!"
 .S MSG(2)="Please return this 1358 to the Service!!"
 .D EN^DDIOL(.MSG) W ! K MSG H 3
 .Q 
 D GENDIQ^PRCFFU7(410,IEN,"1;3;17.5;20","IEN","")
 N PRCCOMCT,PRCBOCCT
 S PRCCOMCT=$G(PRCTMP(410,IEN,20,"I")),PRCBOCCT=$G(PRCTMP(410,IEN,17.5,"I"))
 I $G(PRCTMP(410,IEN,1,"I"))="O",$G(PRCTMP(410,IEN,3,"I"))=1,$J(PRCCOMCT,0,2)'=$J(PRCBOCCT,0,2) D  Q
 . S FLDCHK=1
 . K MSG W !!
 . S MSG(1)="The COMMITTED COST does not equal BOC $ AMOUNT!"
 . S MSG(2)="Please return this 1358 to the Service!!"
 . D EN^DDIOL(.MSG) W ! K MSG H 3
 . Q
 S POIEN=$G(PRCTMP(410,IEN,52,"I")) I POIEN]"" D
 .D GENDIQ^PRCFFU7(442,POIEN,".8;29;30","IEN","")
 .N FISCSTAT S FISCSTAT=$G(PRCTMP(442,POIEN,.8,"I")) I FISCSTAT=45 K PRCTMP(410,IEN,52),PRCTMP(442,POIEN)
 .Q
 I $G(PRCTMP(410,IEN,52,"I"))="" I '$D(NEWDATE) D DATE,FLAG,PROMPT I 'Y!($D(DIRUT)) D:EXIT MSG5 G:EXIT EN2
 I $G(PRCTMP(410,IEN,52,"I"))="" I $D(NEWDATE) D DATE,FLAG S OB=IEN D MSG1(NEWDATE,NEWACC),CHK1(NEWDATE),PROMPT1 I Y!($D(DIRUT)) D:EXIT MSG5 G:EXIT EN2
 I $G(PRCTMP(410,IEN,52,"I"))'="" D  G:EXIT EN2
 .S OB=IEN
 .S NEWDATE=$G(PRCTMP(442,POIEN,29,"E")) I $D(TMP("NEWDATE")) S NEWDATE=$P(TMP("NEWDATE"),U,2)
 .S NEWACC=$G(PRCTMP(442,POIEN,30,"E")) I $D(TMP("NEWACC")) S NEWACC=$P(TMP("NEWACC"),U,2)
 .D MSG1(NEWDATE,NEWACC),CHK1(NEWDATE),PROMPT1 I Y!($D(DIRUT)) D:EXIT MSG5 Q
 .Q
EN1 W ! D DATE,MSG3(NEWDATE),CHK1(NEWDATE),FLAG,MSG4(NEWACC)
 I EXIT D MSG5 G EN2
 W ! D CHK
 I (NEWDATE="")&(NEWACC="YES") D
 .K MSG W !!
 .S MSG(1)="This 1358 Obligation does not have an Ending Date, but the"
 .S MSG(2)="Auto Accrual flag is set to 'YES'.",MSG(3)="  "
 .S MSG(4)="The Auto Accural flag will be corrected and set to 'NO'."
 .D EN^DDIOL(.MSG) W ! K MSG H 3
 .Q
EN2 S TMP("NEWACC")=NEWACC,$P(TMP("NEWACC"),U,2)=$S(NEWACC=0:"NO",NEWACC=1:"YES",1:"YES")
 S TMP("NEWDATE")=NEWDATE S Y=NEWDATE D DD^%DT S $P(TMP("NEWDATE"),U,2)=Y
 KILL AUTOACC,OLDACC,OLDDATE
 QUIT
 ;
PROMPT ; Prompt user
 S EXIT=0
 D EN^DDIOL("This 1358 Obligation appears to be for services.")
 S DIR(0)="Y",DIR("A")="Will this 1358 Obligation need to be accrued in FMS",DIR("B")="YES"
 S DIR("?")="  '^' to exit this option."
 S DIR("?",1)="Enter one of the following:"
 S DIR("?",2)="  'NO' or 'N' if no accrual is needed OR it is for one month."
 S DIR("?",3)="  'YES' or 'Y' if the 1358 covers more than one month AND accrual is needed."
 S DIR("?",4)="  'RETURN' for YES."
 S DIR("??")="^D MSG2^PRCFFU15"
 D ^DIR K DIR W !
 I 'Y!($D(DIRUT)) D MSG5 Q
 S NEWDATE="",NEWACC=Y(0)
 Q
MSG1(DATE,FLAG) ; Display current auto accrual information
 K MSG W !
 S MSG(1)="CURRENT VALUES FOR AUTO ACCRUAL FOR 1358: "
 S MSG(2)="  ENDING DATE FOR SERVICE: "_DATE
 S MSG(3)="  AUTO ACCRUAL FLAG: "_FLAG
 D EN^DDIOL(.MSG) K MSG
 Q
PROMPT1 ; Prompt for correct values
 S EXIT=0
 S DIR(0)="Y",DIR("A")="Are these Auto Accrual values correct",DIR("B")="YES",DIR("??")="^D MSG2^PRCFFU15"
 W ! D ^DIR K DIR W !
 I Y S EXIT=1
 Q
DATE ; Determine ending date
 D DATE^PRCFFU17
 Q
MSG3(DATE) ; Prompt for ending date
MSG31 S EXIT=0,DIR(0)="D",DIR("A")="END DATE FOR 1358"
 D ^DIR K DIR
 I $D(DIRUT) S EXIT=1 Q
 I Y S NEWDATE=Y
 S X1=NEWDATE,X2=$G(PRCTMP(410,IEN,21,"I")) D ^%DTC I X<0 W ! D EN^DDIOL("The Ending Date cannot come before the Committed Date - "_$G(PRCTMP(410,IEN,21,"E"))) W ! G MSG31
 Q
FLAG ; Determine prompt for Auto Accrual
 D FLAG^PRCFFU17
 Q
MSG4(FLAG) ; Prompt for auto accrual
 Q:EXIT
 S DIR(0)="Y",DIR("A")="AUTO ACCRUAL FLAG"
 D ^DIR K DIR
 I $D(DIRUT) S EXIT=1 Q
 S NEWACC=$S($E(Y,1)="Y":1,$E(Y,1)="N":0,$G(DIRUT)=1:0,'Y:0,Y:1,1:1)
 Q
MSG5 ; Exit message
 D MSG5^PRCFFU15
 Q
CHK ; Check for changes
 D CHK^PRCFFU17
 Q
CHK1(DATE) ;Check for Ending Date crossover to next FY
 S X="0930"_PRC("FY") D ^%DT
 S X2=Y ; end of FY for 1358
 S X=DATE D ^%DT
 S X1=Y D ^%DTC
 I X>0 W ! D EN^DDIOL("NOTE: The Ending Date for Service exceeds the End of the Fiscal Year!!")
 W !
 Q
