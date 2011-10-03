FBAAEPI ;AISC/GRR-EDIT PREVIOUSLY ENTERED PHARMACY INVOICE ;7/16/2003
 ;;3.5;FEE BASIS;**38,61**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
RD W ! S DIC="^FBAA(162.1,",DIC(0)="AEQM",DIC("A")="Select Invoice #: ",DIC("S")="I $P(^(0),U,5)'=4!($P(^(0),U,5)=4&$D(^XUSEC(""FBAASUPERVISOR"",DUZ)))" D ^DIC K DIC("S") G END:X=""!(X="^"),RD:Y<0
 S (DA,FBDA)=+Y,DIE=DIC
 ; save FPPS data prior to edit session
 S (FBFPPSC,FBFPPSC(0))=$P($G(^FBAA(162.1,FBDA,0)),U,13)
 S DR="1;Q;12;S FBX=$$FPPSC^FBUTL5(1,FBFPPSC);S:FBX=-1 Y=0;S:FBX="""" Y=""@10"";13///^S X=FBX;S FBFPPSC=X;S Y=""@15"";@10;13///@;S FBFPPSC="""";@15;3;5"
 D ^DIE K DIC
 ; if FPPS CLAIM ID changed, then update Rx's
 I FBFPPSC'=FBFPPSC(0) D CKINVEDI^FBAAEPI1(FBFPPSC(0),FBFPPSC,FBDA)
 S DIC="^FBAA(162.1,DA,""RX"",",DIC(0)="AEQM",DIC("W")="W ?30,""DATE RX FILLED: "",$E($P(^(0),U,3),4,5)_""/""_$E($P(^(0),U,3),6,7)_""/""_$E($P(^(0),U,3),2,3)" D ^DIC G END:X=""!(X="^"),RD:Y<0 W !
 S (FBJ,FBK)=0
 ;check status of batch rx is in.
 S DA=+Y,DA(1)=FBDA S FBSTAT=$P($G(^FBAA(161.7,+$P($G(^FBAA(162.1,+FBDA,"RX",+DA,0)),U,17),"ST")),U) I FBSTAT]"" D
 .I '$D(^XUSEC("FBAASUPERVISOR",DUZ)) D
 .. I $S(FBSTAT="O":0,FBSTAT="C":0,1:1) D
 ... W !,*7,"You cannot edit a payment once released by a supervisor.",! S FBOUT=1 Q
 .I $S(FBSTAT="T":1,FBSTAT="V":1,1:0) D
 .. W !,*7,"You cannot edit an invoice when the batch has a status of transmitted",!,"or vouchered.",! S FBOUT=1
 I $G(FBOUT) D END G FBAAEPI
 S DIE="^FBAA(162.1,FBDA,""RX"","
 ; get current value of FPPS LINE ITEM to use as default
 S FBFPPSL=$P($G(^FBAA(162.1,FBDA,"RX",DA,3)),U)
 ; load current adjustment data
 D LOADADJ^FBRXFA(DA_","_FBDA_",",.FBADJ)
 ; save adjustment data prior to edit session in sorted list
 S FBADJL(0)=$$ADJL^FBUTL2(.FBADJ) ; sorted list of original adjustments
 ; load current remittance remark data
 D LOADRR^FBRXFR(DA_","_FBDA_",",.FBRRMK)
 ; save remittance remarks prior to edit session in sorted list
 S FBRRMKL(0)=$$RRL^FBUTL4(.FBRRMK)
 S DR=".01;S:FBFPPSC="""" Y=1;S FBX=$$FPPSL^FBUTL5(FBFPPSL);S:FBX=-1 Y=0;36///^S X=FBX;S FBFPPSL=X;1;1.5;1.6;3;S FBJ=X;I $P(^FBAA(162.1,DA(1),""RX"",DA,0),U,9)=1 S Y="""";I 1;5"
 S DR(1,162.11,1)="S FBA=$P($G(^FBAA(162.1,DA(1),""RX"",DA,2)),U,6);S FB1725=$S(FBA[""FB583"":+$P($G(^FB583(+FBA,0)),U,28),1:0);W:FB1725 !?2,""**Payment is for emergency treatment under 38 U.S.C. 1725."""
 S DR(1,162.11,2)="@12;S FBHAP=$P(^FBAA(162.1,DA(1),""RX"",DA,0),U,16);6.5;S FBK=X;S:FBK]"""" Y=""@20"";K FBADJ,FBRRMK;S Y=8"
 S DR(1,162.11,3)="@20;I FBK>FBJ S $P(^FBAA(162.1,DA(1),""RX"",DA,0),U,16)=FBHAP W !,*7,""Amount Paid cannot be greater than the Amount Claimed"" S Y=""@12"""
 ;S DR(1,162.11,4)="S:FBJ=FBK Y=""@5"";6////^S X=FBJ-FBK;Q;6R;7R;S:X'=4 Y=""@6"";20;S Y=""@6"";@5;6///@;7///@;20///@;@6;8"
 S DR(1,162.11,4)="K FBADJD;M FBADJD=FBADJ;S FBX=$$ADJ^FBUTL2(FBJ-FBK,.FBADJ,2,,.FBADJD,1);K FBADJD"
 S DR(1,162.11,5)="K FBRRMKD;M FBRRMKD=FBRRMK;S FBX=$$RR^FBUTL4(.FBRRMK,2,,.FBRRMKD);K FBRRMKD;S:FBX=-1 Y=0;8"
 D ^DIE
 ; if adjustment data changed then file
 I $$ADJL^FBUTL2(.FBADJ)'=FBADJL(0) D FILEADJ^FBRXFA(DA_","_FBDA_",",.FBADJ)
 ; if remit remark data changed then file
 I $$RRL^FBUTL4(.FBRRMK)'=FBRRMKL(0) D FILERR^FBRXFR(DA_","_FBDA_",",.FBRRMK)
END K D,DA,DIC,DIE,DR,FBJ,FBK,FBDA,FBOUT,FBSTAT,FBHAP,X,Y,FBA,FB1725
 K FBADJ,FBADJD,FBADJL,FBFPPSC,FBFPPSL,FBRRMK,FBRRMKD,FBRRMKL
 Q
