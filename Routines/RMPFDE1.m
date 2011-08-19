RMPFDE1 ;DDC/KAW-ENTER/EDIT REQUEST FOR ELIGIBILITY DETERMINATION [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
 ;; input: RMPFX
 ;;output: None
 S DFN=$P(^RMPF(791810,RMPFX,0),U,4) W @IOF,! D DISP^RMPFDD,PAT^RMPFUTL
 S X=$G(^RMPF(791810,RMPFX,2)),EL=$P(X,U,6),EU=$P(X,U,7),SE=$P(X,U,8)
 I EL,$D(^RMPF(791810.4,EL,0)) S RMPFELG=$P(^(0),U,1)
 I EU,$D(^VA(200,EU,0)) S EU=$P(^(0),U,1)
 W ! F I=1:1:80 W "-"
 W !?13,"Proposed Eligibility: ",RMPFELG
 W !?23,"Entered By: ",EU
A0 W !!,"<A>ccept, <E>dit, <R>eject or <RETURN> for no action: "
 D READ G END:$D(RMPFOUT)
A1 I $D(RMPFQUT) D  G A0
 .W !!,"Enter an <A> to accept the proposed eligibility"
 .W !?6,"an <E> to edit the eligibility"
 .W !?6,"an <R> to reject the order back to ASPS or"
 .W !?7,"a <RETURN> to exit without action."
 G END:Y="" S RMPFSEL=$E(Y,1) I "AaEeRr"'[RMPFSEL S RMPFQUT="" G A1
 I "Aa"[RMPFSEL S DR="2.02////"_EL_";2.03////"_DUZ_";2.04////1;2.05////"_DT D SET G END
 I "Rr"[RMPFSEL S DR=2.09 D SET G END
 I "Ee"[RMPFSEL S DR="2.02;2.03////"_DUZ_";2.04////1;2.05////"_DT_";2.09" D SET G END
END K SE,DFN,RMPFNAM,RMPFDOB,RMPFDOD,RMPFSSN,RMPFELG,RMPFE,RMPFSEL,RMPFTE,EL,EU,I Q
SET ;; input: RMPFX,DR,SE,RMPFSEL
 ;;output: None
 S S1=$P($G(^RMPF(791810,RMPFX,2)),U,2)
 S DIE="^RMPF(791810,",DA=RMPFX D ^DIE
 S SX=$G(^RMPF(791810,RMPFX,2)),S2=$P(SX,U,2),S3=$P(SX,U,9)
 S S4="" I S2,$D(^RMPF(791810.4,S2,0)) S S4=$P(^(0),U,1)
 I S2 S MS=$S("Aa"[RMPFSEL!(S1=S2):"Eligibility accepted as: "_S4,1:"Eligibility changed to: "_S4)
 I 'S2 S MS=$S(S3'="":"Record rejected with NO ELIGIBILITY",1:"NO ACTION TAKEN")
 W !!,MS
 I $P(SX,U,2)="",$P(SX,U,9)="" G SETE
 K ^RMPF(791810,"AF",SE,RMPFX) D MAIL
SETE K D,D0,DA,DI,DIC,DIE,DQ,DR,SX,X,S1,S2,S3,S4,MS Q
MAIL ;;Send message to ASPS mail group
 ;; input: MS,S3,RMPFNAM,RMPFSSN
 ;;output: None
 S MG=$O(^XMB(3.8,"B","RMPF ROES UPDATES (ASPS)",0))
 I 'MG W $C(7),!!,"*** MAIL GROUP RMPF ROES UPDATES (ASPS) NOT ESTABLISHED - NO MESSAGE SENT ***" G MAILE
 S XMY("G."_$P($G(^XMB(3.8,MG,0)),U,1))=""
 S XMSUB="ROES PATIENT ELIGIBILITY UPDATE"
 S XMTEXT(1)="ROES Patient Eligibility has been updated for the following patient:"
 S XMTEXT(2)=" "
 S XMTEXT(3)=RMPFNAM_"          "_RMPFSSN
 S XMTEXT(4)=" "
 S XMTEXT(5)=MS
 S XMTEXT(6)=" "
 S XMTEXT(7)="Comment: "_S3
 S XMTEXT="XMTEXT("
 D ^XMD W !!,"*** Message sent to ASPS Mail Group ***" H 2
MAILE K XCNP,XMDUZ,XMZ,S3,MS,MG,XMZ,XMDUZ,XCNP Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
