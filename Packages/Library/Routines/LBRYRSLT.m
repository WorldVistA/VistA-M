LBRYRSLT ;SSI/ALA-Resubmit Local Title to FORUM ;[ 05/23/97  12:13 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
 I $G(LBRYPTR)="" D  I $G(LBRYPTR)="" W !!,$C(7),"No Site has been selected" HANG 2 Q
 . D ^LBRYASK
START W @IOF,?5,"VA Library Serials Title Setup for "_LBRYNAM
 D NOW^%DTC S Y=X X ^DD("DD") S YDT=Y W ?60,YDT,!
 S DIC="^LBRY(680.5,",DIC(0)="AEMQZ"
 S DIC("A")="Select TITLE AUTHORITY TITLE: ",DIC("S")="I Y>99000"
 D ^DIC K DIC("A") G:Y<0 EXIT1
 S (LBRYCLS,DA)=+Y
 W !!,"Are you sure you want to resend title "_$P(^LBRY(680.5,LBRYCLS,0),U)
 D YN^DICN I %'=1 G START
 D ^LBRYLTF
 W !!,"Title will be sent to FORUM for processing by National Librarians."
 R !,"Press return to continue ",C:DTIME
 G START
EXIT1 K YDT,DIC,LBRYCLS,DA,Y
 Q
