DGBUL ;ALB/MRL - SEND DG BULLETIN ; 22 MAY 1987
 ;;5.3;Registration;**31,244,545,730**;Aug 13, 1993;Build 2
 ;
 N DIC,DIX,DIY,DO,DD
 I '$D(DGB),'$D(XMSUB) G Q
 K:$D(DGTEXT) XMTEXT I '$D(DGTEXT)&('$D(XMTEXT)) G Q
 S DGB=+$P($G(^DG(43,1,"NOT")),"^",DGB)
 I '$D(^XMB(3.8,DGB,0)) G Q
 ;
 ;Protect Fileman from Mailman call
 N DICRREC,DIDATA,DIEFAR,DIEFCNOD,DIEFDAS,DIEFECNT,DIEFF,DIEFFLAG
 N DIEFFLD,DIEFFLST,DIEFFREF,DIEFFVAL,DIEFFXR,DIEFI,DIEFIEN,DIEFLEV
 N DIEFNODE,DIEFNVAL,DIEFOUT,DIEFOVAL,DIEFRFLD,DIEFRLST,DIEFSORK
 N DIEFSPOT,DIEFTMP,DIEFTREF,DIFLD,DIFM,DIQUIET,DISYS,D,D0,DA
 ;next line from DG*730
 K:$D(XMY) XMY
 ;
 S XMY("G."_$P($G(^XMB(3.8,DGB,0)),"^",1))="" ; pass mailgroup
 G Q:'$D(DUZ) S:'$D(DGSM) DGSM=1 S XMTEXT=$S('$D(XMTEXT):"DGTEXT(",1:XMTEXT),XMDUZ=$S(($D(DUZ)#2):DUZ,1:.5) S:$D(DUZ)#2&(DGSM) XMY(DUZ)="" K:'$D(XMY) DGSM D ^XMD:$D(XMY)
Q K DGSM,DGB,DGTEXT,XMR,DGII,XMY,XMTEXT,XMDUZ,XMSUB Q
 ;
EDIT ;
 F I=1:1 S J=$P($T(T+I),";;",2) Q:J']""  W !,J
 W ! S DIE="^DG(43,",(DA,Y)=1,DR="500:513" D ^DIE K D,D0,DI,DIC,DQ,X,DR,DIE,DA,Y,I,J Q
T ;
 ;;This option is used to specify the mailgroup you desire specific types of
 ;;notification to be made to.  The mailgroup can be one created locally or a
 ;;distributed 'DG' mailgroup.  If a mailgroup is selected notification concerning
 ;;that specific action will be made in the form of a mailman bulletin.  If no
 ;;notification is desired for a specific action no mailgroup should be specified.
 ;;If you have any questions concerning the purpose of a specific type of
 ;;notification enter a question mark at the applicable prompt.
