PRCHPAM9 ;ID/TKW,RSD-PRINT AMENDMENT ;6/9/99  15:43
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ACC W PRCHUL,!,"12.ACCOUNTING AND APPROPRIATION DATA (If required)" S X=$P(PRCH0,U,3) W ?56,"TOTAL AMOUNT: $",$J($P(PRCHP0,U,15),10,2)
 W !?5,$S('X:"",X<0:"Decrease ",1:"Increase "),$P(PRCHP0,U,4),"-",$P($P(PRCHP0,U,3)," ",1),"-",$P(PRCHP0,U,5),$S($P(PRCHP0,U,6)>0:"-"_$P(PRCHP0,U,6),1:""),$S($P(PRCHP0,U,8)>0:"-"_$P(PRCHP0,U,8),1:"")
 I X W "  $",$J($S(X<0:-X,1:X),10,2)
 W !,PRCHUL,!?16,"13.THIS ITEM APPLIES ONLY TO MODIFICATIONS OF CONTRACTS/ORDERS.",!?19,"IT MODIFIES THE CONTRACT/ORDER NO. AS DESCRIBED IN ITEM 14.",!,PRCHUL,!
 S Y=$G(^PRCD(442.2,+$P(PRCH0,U,4),0)),PRCHX=$P(Y,U,1),DIWL=1,DIWR=92,DIWF=""
 S PRCHI=$S($P(PRCHP0,U,2)=8:10,1:0)
 F  S PRCHI=$O(^PRCD(442.2,PRCHI)) Q:PRCHI>$S($P(PRCHP0,U,2)=8:19,1:10)  S Y=^(PRCHI,0),PRCHTYP=$P(Y,U,1) I PRCHTYP="A"!(PRCHTYP="B")!(PRCHTYP="C")!(PRCHTYP="D") D A
 S X="_",Y="_" S:$P(PRCH0,U,5)="Y" X="X" S:$P(PRCH0,U,5)'="Y" Y="X"
 W "IMPORTANT: Contractor __"_Y_"__ is not,  __"_X_"__ is required to sign this document and return",!?14
 S Y=$S($P(PRCH0,U,6):$P(PRCH0,U,6),1:"_") W "__"_Y_"__ copies to the issuing office.",!,PRCHUL
 D HDR
 W !!,"14.DESCRIPTION OF AMENDMENT/MODIFICATION (Organized by UCF section headings, including solicita-",!?42,"tion/contract subject matter where feasible.)",!! S PRCHDY=PRCHDY+5
 ;
ITEM F I=0:0 S I=$O(^TMP($J,"AMD",1,I)) Q:'I  D:PRCHDY>60 H W ?3,^(I,0),! S PRCHDY=PRCHDY+1
 D:PRCHDY>57 HDR W !,"Except as provided herein, all terms and conditions of the document referenced in Item 9A or 10A,",!,"as heretofore changed, remains unchanged and in full force and effect.",!,PRCHUL,! S PRCHDY=PRCHDY+4
 D:PRCHDY>47 HDR W "15A.NAME AND TITLE OF SIGNER (Type or print)",?46,"|16A.NAME AND TITLE OF CONTRACTING OFFICER (Type",!?46,"|    or print)",!
 S X=$P(PRCH1,U,2) I X]"" S DA=D0,P=+PRCH1
 W ?46,"| ",$$DECODE^PRCHES10(D0,D1),"  Contracting Officer"
 D FAXEMAIL^PRCHFPT3(+PRCH1,.PRCFAX,.PRCEMAIL)
 W:PRCFAX'="" !?46,"|FAX: ",PRCFAX
 W:PRCEMAIL'="" !?46,"|E-MAIL",!?46,"|",PRCEMAIL K PRCFAX,PRCEMAIL
 W !,$E(PRCHUL,1,46),"|",$E(PRCHUL,1,50),!
 W "15B.CONTRACTOR/OFFEROR",?34,"|15C.DATE",?46,"|16B.UNITED STATES OF AMERICA",?82,"|16C.DATE",!,?34,"|    SIGNED",?46,"|",?82,"|    SIGNED",!
 W ?2,$E(PRCHUL,1,28),?34,"|",?46,"| BY ",$E(PRCHUL,1,29),?82,"|",!
 W ?1,"(Signature of person authorized",?34,"|",?46,"|(Signature of Contracting Officer)",?82,"|",!
 W ?2,"to sign)",?34,"|",?46,"|",?82,"|",!,$E(PRCHUL,1,34),"|",$E(PRCHUL,1,11),"|",$E(PRCHUL,1,35),"|",$E(PRCHUL,1,14),!
 W "Exception to SF-30",?75,"SF-30 ADP (Rev 10-83)",!,"Approved by OIRM ____",!
 ;
EXIT K D0,D1,DA,P,I,J,X,Y,DIWF,DIWL,DIWR,PRCH0,PRCH1,PRCHAV,PRCHP0,PRCHP1,PRCHI,PRCHTYP,PRCHUL,PRCHX,PRCHDY,PRCHPG,PRCHPGT,PRCHREPR,PRCHTPG,^UTILITY($J),^TMP($J) D:$D(ZTSK) KILL^%ZTLOAD K ZTSK
 Q
 ;
A K ^UTILITY($J,"W") S X=$P(Y,U,2) D DIWP^PRCUTL($G(DA)) S X="" S:PRCHX=PRCHTYP X=$P(PRCH0,U,7) D:X]"" DIWP^PRCUTL($G(DA))
 W:PRCHX=PRCHTYP ?1,"X" S J=0 F I=0:0 S I=$O(^UTILITY($J,"W",1,I)) Q:'I  S J=J+1 W ?3,"|" W:J=1 PRCHTYP,"." W ?6,^(I,0),!
 W "___|",$E(PRCHUL,1,93),!
 Q
 ;
H D HDR W ! S PRCHDY=PRCHDY+1
 Q
 ;
HDR W:$Y>0 @IOF W !,$S($D(PRCHREPR):$E(PRCHUL,1,35)_" **REPRINT** "_$E(PRCHUL,49,98),1:PRCHUL)
 W !?3,"AMENDMENT OF SOLICITATION/MODIFICATION OF CONTRACT",?58,"|1.CONTRACT ID CODE",?79,"|PAGE   OF   PAGES",!
 W $E(PRCHUL,1,58),"|",$E(PRCHUL,1,20),"|"
 S X=(8-$L(PRCHPG))/2,Y=$P(X,".",1),Z=$P(X,".",2) W $E(PRCHUL,1,Y) W:Z "_" W PRCHPG,$E(PRCHUL,1,Y),"|_" S X=7-$L(PRCHPGT) W PRCHPGT W:X>0 $E(PRCHUL,1,X) W !
 S PRCHPG=PRCHPG+1,PRCHDY=4
 Q
 ;
EN2 ;ADJUSTMENT VOUCHER
 D EN2H F I=0:0 S I=$O(^TMP($J,"AMD",1,I)) Q:'I  D:PRCHDY>50 EN2H W ?3,^(I,0),! S PRCHDY=PRCHDY+1
 F I=PRCHDY:1:50 W !
 W !,PRCHUL,!,"Approve subject to final action on R/S on items indicated.",?65,"|   DATE    |    P.O. NO.",!,$E(PRCHUL,1,65),"|",?77,"|",!
 W "SIGNATURE OF CONTRACTING OFFICER",?65,"|",?77,"|",!,?65,"|",?77,"|",! S X=$$DECODE^PRCHES10(D0,D1) W "/ES/"_X_"     " S Y=$P(PRCH1,U,3) D DT^PRCHPAM
 W ?65,"| " S Y=$P(PRCH0,U,2) D DT^PRCHPAM W ?77,"|",!,$E(PRCHUL,1,65),"|",$E(PRCHUL,1,11),"|",$E(PRCHUL,1,19),!
 G EXIT
 ;
EN2H W:$Y>0 @IOF W ?5,"SUBJECT: ADJUSTMENT VOUCHER" W:$D(PRCHREPR) "   **REPRINT**" W !!!! S PRCHDY=0
 Q
