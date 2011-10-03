SROCON ;BIR/MAM - STUFF ENTRY IN CONCURRENT CASE ;06/28/10
 ;;3.0;Surgery;**78,119,161,174**;24 Jun 93;Build 8
 I $D(SRNOCON),SRNOCON=1 Q
 I $D(SRFLAG) S SRCON=$P(^SRF(DA(1),"CON"),"^")
 I '$D(SRFLAG) S SRCON=$P(^SRF(DA,"CON"),"^")
 N SRX S SRX=X
ASK N DIR,X,Y S DIR("A",1)="",DIR("A")="Do you want to store this information in the concurrent case ",DIR(0)="YO",DIR("B")="YES"
 S DIR("?")="^D HELP^SROCON" D ^DIR I Y=0 Q
STUFF ; concatonate field to SRODR
 D EN^DDIOL(" ","","!")
 I $G(SRFLAG)=1 S SRODR(130.213,DA(2)_","_SRCON_",",SRFLD)=SRX K SRFLAG Q
 S SRODR(130,SRCON_",",SRFLD)=SRX
 Q
HELP ;
 N SRMX S SRMX=X W @IOF S DFN=$P(^SRF(SRTN,0),"^") D DEM^VADPT S X=SRMX  ;; < RJS *161 >
 D EN^DDIOL("There is a concurrent surgical case associated with this procedure. A brief","","!!")
 D EN^DDIOL("description of that case is listed below.","","!")
 S SROPER=$P(^SRF(SRCON,"OP"),"^") I $O(^SRF(SRCON,13,0)) S SROTHER=0 F I=0:0 S SROTHER=$O(^SRF(SRCON,13,SROTHER)) Q:'SROTHER  D OTHER
 K SROPS,MM,MMM S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 S SRSUR=$S($D(^SRF(SRCON,.1)):$P(^(.1),"^",4),1:"") S:'SRSUR SRSUR="NOT ENTERED" S:SRSUR SRSUR=$P(^VA(200,SRSUR,0),"^")
 S SRSS=$P(^SRF(SRCON,0),"^",4) S:'SRSS SRSS="NOT ENTERED" S:SRSS SRSS=$P(^SRO(137.45,SRSS,0),"^")
 D EN^DDIOL("Surgeon: "_SRSUR,"","!!") D EN^DDIOL("Surgical Specialty: "_SRSS,"","!")
 D EN^DDIOL("Procedure: "_SROPS(1),"","!!")
 I $D(SROPS(2)) D EN^DDIOL(SROPS(2),"","!,?11")
 I $D(SROPS(3)) D EN^DDIOL(SROPS(3),"","!,?11")
 I $D(SROPS(4)) D EN^DDIOL(SROPS(4),"","!,?11")
 N SRW S SRW(1)="",SRW(2)="If you answer 'YES', the information you entered for this field will also"
 S SRW(3)="be stored for the concurrent case. If this information is not pertinent for"
 S SRW(4)="the concurrent case, enter 'NO'.",SRW(5)=""
 D EN^DDIOL(.SRW)
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SRCON,13,SROTHER,0),"^"))>235 S SRLONG=0,SROTHER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SRCON,13,SROTHER,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
LOOP ; break procedure
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<65  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
