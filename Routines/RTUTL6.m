RTUTL6 ;ALB/JLU-UTILITY PROGRAM;;9/10/90  10:00 AM;
 ;;v 2.0;Record Tracking;;10/22/91 
BUL ;This is the entry for the cancelation bulletin from RTQ41,
 ;
 Q:'$D(^DIC(195.1,1,2))  S JZ=$P(^(2),U) Q:'JZ
 I JZ>1 G:'$D(RTFR) E1 S JZ1=$P(RTFR,U),JZ1=$P(^RTV(195.9,JZ1,0),U,5) G:JZ1="" E2 S JM="D."_JZ1,XMY(JM)=""
 I JZ=1!(JZ=3) I $P(^DIC(195.1,1,2),U,2) S JM=$P(^(2),U,2),JM="G."_$P(^XMB(3.8,JM,0),U)_"@"_^XMB("NAME"),XMY(JM)=""
ALT Q:'$D(^RTV(190.1,DA,0))  S RTWK=^(0)
 S JR=$P(RTWK,U),JA=DA
 S RTCNBY=$S($D(^VA(200,DUZ,0)):$P(^(0),U),1:"Unknown")
 S JL=$P(RTWK,U,5),JL=$P(^RTV(195.9,JL,0),U)
 S RTRQT=$P(@(U_$P(JL,";",2)_$P(JL,";")_",0)"),U)
 S JN=$P(RTWK,U) I JN S JG=^RT(JN,0),JV=$P(JG,U,7),JT=$P(JG,U,3),JN=$P(JG,U),JN=$P(@(U_$P(JN,";",2)_$P(JN,";")_",0)"),U),JT=$P(^DIC(195.2,JT,0),U)
 E  S (JN,JT,JV)="Unknown"
 S XMB="RT CANCELED REQ",XMB(1)=JN,XMB(2)=JT,XMB(3)=JV,XMB(4)=JR,XMB(5)=RTRQT,XMB(6)=RTCNBY,XMB(7)=DA D ^XMB
 I $D(JZ1),JZ>1 W !,*7,"   ...notice for cancelation of request #",DA," has been sent to device ",JZ1
EX K XMB,XMTEXT,JS,JP,JL,RTTXT,RTWK,RTCNBY,RTRQT,JA,JG,JM,JN,JR,JT,JV,JZ,JZ1,XMY
 Q
 ;
E1 W !!,*7,"   ...File room is not defined can not print to printer." K JZ1 D ALT Q
E2 W !!,*7,"   ...Request printer not defined can not print to printer." K JZ1 D ALT Q
 ;
DT S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".") S:Y="//" Y="" Q
 Q
