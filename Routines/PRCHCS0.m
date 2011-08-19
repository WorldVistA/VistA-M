PRCHCS0 ;WISC/RHD-LOG CODE SHEET EDIT--CALLED FROM PRCHCS ;12/1/93  09:50
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
SC ;MOVES SOURCE CODE TO EACH LINE ITEM IN PO
 Q:'$D(PRCHPO)  S Y=+$P($G(^PRC(442,PRCHPO,1)),U,7) Q:'$D(^PRCD(420.8,Y,0))  S Y=$P(^(0),U,1)
 F I=0:0 S I=$O(^PRC(442,PRCHPO,2,I)) Q:'I  S X=$P($G(^(I,2)),U,2),$P(^(4),U,10)=$S(Y'="B":Y,X]"":6,1:2)
 Q
HDR I '$D(IOM) D ^%ZISC
 N J,I,Y F I=1:1:8 S X=I*10-1 I X'>IOM W ?X,I
 S Y="",$P(Y,"1234567890",9)="" W !,$E(Y,1,IOM)
 S Y="",$P(Y,"----+----|",9)="" W !,$E(Y,1,IOM) Q
DSP W !! D HDR Q:'$D(^PRCF(423,DA,300))  S X=+^(300),Y=^("CODE",1,0) W !,"  Line Item: ",X,!,Y D ERR:$L(Y)'=80!($O(^PRCF(423,DA,"CODE",1))) Q
SIG ; PUT ELEC.SIG.BASED ON P.O.RECORD NO. ONTO P.O.AND SET FLAG TO INDICATE LOG CODE SHEETS WERE GENERATED
 K PRCHNM S DA=PRCHPO,P=+PRC("PER"),PRCSIG="" D ESIG^PRCUESIG(DUZ,.PRCSIG) S ROUTINE="PRCUESIG" D:PRCSIG'=1 QQ Q:'PRCSIG  S PRCHNM=PRCSIG
 D NOW^%DTC I PRCHTYP="A" S $P(^PRC(442,PRCHPO,18),U,4)=PRCHKEY,$P(^(18),U,11)="Y",PRCSIG="" K PRCHNM D ENCODE^PRCHES8(DA,DUZ,.PRCSIG) S ROUTINE=$T(+0) D:PRCSIG<1 QQ Q:'PRCSIG  K ^PRC(442,"AE","N",PRCHPO) S PRCHNM=PRCSIG Q
 I PRCHTYP="R" S $P(^PRC(442,PRCHPO,11,PRCHRPT,1),U,1)=PRCHKEY,$P(^(1),U,6)="Y",PRCSIG="" K PRCHNM D ENCODE^PRCHES3(PRCHPO,PRCHRPT,DUZ,.PRCSIG) S ROUTINE=$T(+0) D:PRCSIG<1 QQ Q:'PRCSIG  K ^PRC(442,"AF","N",PRCHPO,PRCHRPT) S PRCHNM=PRCSIG
 Q
ERR W !?5,"This code sheet is not 80 characters and needs to be edited!",$C(7) Q
ERR1 W !?5,"Code sheet for line/item number "_PRCHLI_" has not been completed",!,?5,"and needs to be edited !",$C(7)
 W !! S %A="Do you want to re-create the code sheet for this line/item ",%B="'YES' will rebuild the code sheet from the P.O. data as it was before",%B(1)="editing.  Any other answer will do nothing."
 Q
ASK W !!?2,"Press RETURN to continue diplaying code sheets or '^' to transmit/edit: " R X:DTIME Q:X=""  I X="^" S PRCHLI="z" Q
 W !!,"Only an up-arrow or a return are allowed.  If you wish to see the rest",!,"of the code sheets online, press return.  Otherwise, enter '^'." G ASK
QQ S:'$D(ROUTINE) ROUTINE=$T(+0) W !!,$$ERR^PRCHQQ(ROUTINE,PRCSIG) W:PRCSIG=0!(PRCSIG=-3) !,"Notify Application Coordinator!",$C(7) S DIR(0)="EAO",DIR("A")="Press <return> to continue" D ^DIR K ROUTINE
 Q
Q ;EXIT ROUTINE FOR PRCHCS
 K %DT,DA,DIC,DIE,DIK,DR,I,J,K,X,Y,Z,PRCFA,PRCH,PRCHAUTO,PRCHBTYP,PRCHLI,PRCFASYS,PRCFCS,PRCH0,PRCH2,PRCH4,PRCHCOM,PRCHI,PRCHI0,PRCHIV0,PRCHLCNT,PRCHOK,PRCHQTY,PRCHR0,PRCHRRI,PRCHSRC,ROUTINE
 Q
