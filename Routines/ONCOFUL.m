ONCOFUL ;Hines OIFO/GWB - FOLLOWUP PROCEDURES ;07/12/00
 ;;2.11;ONCOLOGY;**22,23,25,26,29**;Mar 07, 1995
PAT ;Select patient
 W !
 S DIC="^ONCO(160,",DIC("A")=" Select Patient: ",DIC(0)="AEMQZ" D ^DIC
 Q:(Y<0)!(+Y[U)
 S (ONCOPAT,ONCOD0,DA)=+Y,X=Y(0,0),ONCOVP=$P(Y,U,2)
 S X=$P(X,",",2)_" "_$P(X,","),ONCONM=$$LCASE^ONCOU(X)
 Q
AP K ONCOD0,ONCOVP,ONCONM
DCL ;DISPLAY CONTACT LIST
 W @IOF,!!,?20,"********* DISPLAY CONTACTS **********",!!
 G FI:$D(ONCOVP)&($D(ONCOD0)) S DIC="^ONCO(160,",DIC("A")="       Select Patient: ",DIC(0)="AEMQZ" D ^DIC G EX:(Y<0)!(+Y[U) S (ONCOPAT,ONCOD0,DA)=+Y,X=Y(0,0),ONCOVP=$P(Y,U,2)
 S LN=$P(X,","),X=$P(X,",",2)_" "_LN S ONCONM=$$LCASE^ONCOU(X)
FI S FIL=$P(ONCOVP,";",2),DFN=$P(ONCOVP,";"),GLR=U_FIL_DFN_",",X=$P(@(GLR_"0)"),U)
X K D1 S D0=ONCOD0,D1=$O(^ONCO(160,D0,"C","B","PT",0)) I D1="" D ^ONCOFUM
ADC ;ADD CONTACTS
 K DXS,DIOT S D0=ONCOD0 D ^ONCOXCL
EC W !!?20,"********** ADD/EDIT CONTACTS **********",!! W:$D(ONCONM) ?20,"for: ",ONCONM,!!
 S F0=0,DA=ONCOD0,DIE="^ONCO(160,",DR="[ONCO FOLL-ADD CONTACT]" D ^DIE ;G EX:'F0,EX:$D(Y)=0,DCL
SA S DIR("A")="     Select Action",DIR(0)="S^1:Display Contacts;2:Edit Contact;3:Attempt a Follow-up;4:Another Patient;5:Exit Option",DIR("B")=3 D ^DIR G DCL:Y=1,ATM:Y=3,EC:Y=2,AP:Y=4,EX
 ;
ATM ;[AF Attempt a Follow-up] [ONCO FOLL-ATTEMPT FOLLOWUP]
 N ONCDUZ,ONCDT
 S ONCDUZ=DUZ,ONCDT=DT
 W @IOF,!!?20,"********** ATTEMPT A FOLLOW-UP **********",!!
 K ONCOVS,VS,DIC,DIE
 I '$D(ONCOD0) D PAT G EX:Y<0
 E  W:$D(ONCONM) ?20," for ",ONCONM
 I '$D(ONCONM) D PAT G EX:Y<0
FA S DA=ONCOD0,DR="[ONCO FOLL ATTEMPT]",DIE="^ONCO(160,",L=0,FG=0 W !! D ^DIE G EX:$D(Y)'=0,EX:'$D(D1) I 'FG&'($P($G(^ONCO(160,D0,"A",D1,0)),U,6)) G DEL
 S XX=^ONCO(160,ONCOD0,"A",ONCOD1,0) I $P(XX,U,2)=3&($P(XX,U,4)=8) S ONCOC0=$P(XX,U,3) W !!?5,"Generate Letter...!!" D LET^ONCOFUP K ONCOC0 G ATM
 G SA:$G(XRS)'=1 W !!?10,"Complete Follow-up for Successful Contact!!",! G DIE:XTY=3
FOL K DXS S DA(1)=ONCOD0,DIC(0)="LZ",(DIE,DIC)="^ONCO(160,"_DA(1)_",""F"",",DLAYGO=160,X=XDT I '$D(^ONCO(160,DA(1),"F")) S ^ONCO(160,DA(1),"F",0)="^160.04DAI^^"
 D ^DIC S DIE=DIE,DA=+Y G EX:Y<0
 ;DEVELOPERS NOTE:  For consistent functionality, the following line
 ;must be identical to the 160.04 DR string in the input template
 ;ONCO FOLLOWUP.
FOLDR S DR="S ONCOD1=DA;.01;S LC=X;1;S VS=X;3;S:VS=0 Y=""@999"";4;6//^S X=""Chart requisition"";S NF=X S:X'=5 Y=""@1000"",UF="""";7;S UF=X;S Y=""@1000"";@999;4////8;6////9;S NF=9;@1000;5;8////1;D TEMP451^ONCOAIS;S FG=1;"
 S FG=0 D ^DIE G UPDAT:FG I 'FG S ONCOVS="" D UPOUT G ATM
 ;
DIE K DXS S ONCOSTAT=1,DA=ONCOD0
 S DR="[ONCO FOLLOWUP]"
 S DIE="^ONCO(160,",FG=0 W !! D ^DIE I 'FG S ONCOVS="" G UPOUT
 ;
UPDAT S D0=ONCOD0 K DXS,DIOT D LST^ONCODLF,UPD^ONCOCRF
 W !,?5,"**********Following fields have been updated********",!
 N Y K DIQ,ONC S DIC="^ONCO(160,",DR=".01;16;15;15.2",DA=ONCOD0,DIQ="ONC"
 D EN^DIQ1 W !
 W !?2,"Name..: ",ONC(160,ONCOD0,.01)
 W ?35,"Date Last Contact: ",ONC(160,ONCOD0,16)
 W !?2,"Status: ",ONC(160,ONCOD0,15)
 W ?35,"Follow-Up Status.: ",ONC(160,ONCOD0,15.2)
 K DIR S DIR("A")=" DATA OK",DIR("B")="Yes",DIR(0)="Y" W !!
 D ^DIR Q:(Y=U)!(Y="")  G DIE:'Y,SA:ONCOVS D DEAD^ONCOFDP K ONCONM G ATM
 ;
UPOUT ;UPARROW out-check before deleting
 Q:'$D(ONCOD1)  Q:'$D(^ONCO(160,ONCOD0,"F",ONCOD1,0))  Q:$P(^(0),U,8)=1  D DEL^ONCOAIF G ATM
 Q
 ;
DEL ;delete entry
 Q:'$D(ONCOD1)  S DA(1)=ONCOD0,DA=ONCOD1,DIK="^ONCO(160,"_DA(1)_",""A""," D ^DIK
 W:$D(^ONCO(160,ONCOD0,"A",ONCOD1,0)) "*",$P(^(0),U,6) W !!,?10,"*********************ENTRY DELETED*************************",!!
 G EX
IN ;
NAM D HD W !! S DIC="^ONCO(160,",DIC(0)="AEQMZ",DIC("A")="         Enter Patient name: " D ^DIC G EX:Y<0 S (ONCOD0,D0)=+Y
T K IO("Q") S %ZIS="Q" W !! D ^%ZIS I POP S ONCOUT="" G NAM
 I '$D(IO("Q")) D TSK^ONCOFUL G EX
 S ZTRTN="TSK^ONCOFUL",ZTSAVE("ONCOD0")="",ZTDESC="ONCOLOGY PATIENT INQUIRY" D ^%ZTLOAD G EX
 ;
TSK ;Task for Patient Inquiry
DI U IO D HD S D0=ONCOD0
 K DIQ,ONC S DIC="^ONCO(160,",DR=".01;16;15;15.2",DA=ONCOD0,DIQ="ONC"
 D EN^DIQ1 W !
 W !?2,"Name..: ",ONC(160,ONCOD0,.01)
 W ?35,"Date Last Contact: ",ONC(160,ONCOD0,16)
 W !?2,"Status: ",ONC(160,ONCOD0,15)
 W ?35,"Follow-Up Status.: ",ONC(160,ONCOD0,15.2)
 D SUM^ONCOAIF,LST^ONCODLF
 D ^%ZISC
 Q
 ;
HD W @IOF,!!!?15,"********** Patient Follow-up Inquiry ***********",!
 Q
EX ;EXIT ROUTINE
 K DA,D0,D1,DI,DIC,DIC1,DIE,DIK,ONCOD0,ONCOD1,ONCOVS,ONCONM,ONCOPAT,ONCOVP,%ZISOS
 K S,F0,FIL,GLR,J,LN,L,LA,NM,OD,OS,OF,%Y,ABS,AC,P,D,DN,DXS,DIYS,DN,ZZL,DIE,DR,ONCON,ONCOX
 Q
