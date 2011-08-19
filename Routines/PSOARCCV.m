PSOARCCV ;BHAM ISC/LGH - gather psrx info ; 08/19/92
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
EN N X,XX,YX,DATE1,DATE2,DATE,%X,%Y
 S RX0=+RX0,%X="^PSRX("_+RX0_",",%Y="RX("_+RX0_"," D %XY^%RCR
 S $P(RX(RX0,3),"^",10)=$P("NON-","^",$S($D(^PS(55,$P(RX(RX0,0),"^",2),0)):$P(^(0),"^",2),1:0))_"SAFETY"
 S $P(RX(RX0,0),"^",2)=$S($D(^DPT(+$P(RX(RX0,0),"^",2),0)):$P(^(0),"^"),1:"UNKNOWN"),$P(RX(RX0,0),"^",3)=$S($D(^PS(53,+$P(RX(RX0,0),"^",3),0)):$P(^(0),"^",2),1:"UNKNOWN")
 S $P(RX(RX0,0),"^",15)=$P(^PSRX(RX0,"STA"),"^"),$P(RX(RX0,0),"^",10)=$P(^PSRX(RX0,"SIG"),"^")
 S $P(RX(RX0,0),"^",4)=$S($D(^VA(200,+$P(RX(RX0,0),"^",4),0)):$P(^(0),"^"),1:"UNKNOWN"),$P(RX(RX0,0),"^",5)=$S($D(^SC(+$P(RX(RX0,0),"^",5),0)):$P(^(0),"^"),1:"UNKNOWN")
 S $P(RX(RX0,0),"^",6)=$S($D(^PSDRUG(+$P(RX(RX0,0),"^",6),0)):$P(^(0),"^"),1:"UNKNOWN")
 S $P(RX(RX0,2),"^",9)=$S($D(^PS(59,+$P(RX(RX0,2),"^",9),0)):$P(^(0),"^"),1:"UNKNOWN")
 S $P(RX(RX0,0),"^",16)=$S($D(^VA(200,+$P(RX(RX0,0),"^",16),0)):$P(^(0),"^"),1:"UNKNOWN")
 S X=$P(RX(RX0,0),"^",15)
 S $P(RX(RX0,0),"^",15)=$S(X=1:"Non-Verified",X=2:"Refill",X=3:"Hold",X=4:"Non-Verified",X=5:"Suspended",X=11:"Expired",X=12:"Discontinued",X=13:"Deleted",X=14:"Discontinued",X=15:"Discontinued (Edit)",X=16:"Provider Hold",1:"Active")
 I $P(RX(RX0,2),"^",6) S $P(RX(RX0,2),"^",11)=$P(RX(RX0,2),"^",6)
 I $P(RX(RX0,0),"^",11)="M" S $P(RX(RX0,0),"^",11)="Mail"
 E  S $P(RX(RX0,0),"^",11)="Window"
 I $P(RX(RX0,2),"^",3) S $P(RX(RX0,2),"^",3)=$S($D(^VA(200,+$P(RX(RX0,2),"^",3),0)):$P(^(0),"^"),1:"UNKNOWN")
 I $P(RX(RX0,2),"^",10) S $P(RX(RX0,2),"^",10)=$S(+$D(^VA(200,+$P(RX(RX0,2),"^",10),0)):$P(^(0),"^"),1:"UNKNOWN",0:"")
 I $P(RX(RX0,3),"^",3) S $P(RX(RX0,3),"^",3)=$S(+$D(^VA(200,+$P(RX(RX0,3),"^",3),0)):$P(^(0),"^"),1:"UNKNOWN",0:"")
 I $O(RX(RX0,1,0)) S XTYPE=1 F X=0:0 S X=$O(RX(RX0,1,X)) Q:'X  S XY=X D:$G(RX(RX0,XTYPE,X,0))]"" REFILL,DATE
 S $P(RX(RX0,3),"^",11)=+$P(RX(RX0,0),"^",9)-(+$G(XY))
L I +$P($G(RX(RX0,"L",0)),"^",2) S XTYPE="L" F X=0:0 S X=$O(RX(RX0,"L",X)) Q:+X'>0  D LABEL,DATE
A I +$P($G(RX(RX0,"A",0)),"^",2) S XTYPE="A" F X=0:0 S X=$O(RX(RX0,"A",X)) Q:+X'>0  D AUDIT,DATE
P I $O(^PSRX(RX0,"P",0)) S XTYPE="P" F X=0:0 S X=$O(^PSRX(RX0,"P",X)) Q:'X  D:$G(^PSRX(RX0,XTYPE,X,0))]"" REFILL,DATE
 I +$G(RX(RX0,"IB")) S RX(RX0,"IB")=$S($D(^IBE(350.1,+$P(RX(RX0,"IB"),"^"),0)):$P(^(0),"^"),1:"UNKNOWN")
 I $G(RX(RX0,"TN"))]"" S $P(RX(RX0,3),"^",12)=$G(RX(RX0,"TN"))
CMOP I $O(RX(RX0,4,0)) F ZX=0:0 S ZX=$O(RX(RX0,4,ZX)) Q:'ZX  D
 .S ZST=+$P($G(RX(RX0,4,ZX,0)),"^",4) I $G(ZST)]"" S $P(RX(RX0,4,ZX,0),"^",4)=$S(ZST=0:"TRANS",ZST=1:"DISP",ZST=2:"RETRANS",ZST=3:"NOT DISP",1:"UNKNOWN")
 .S Y=+$P($G(RX(RX0,4,ZX,0)),"^",5) I Y D DATECV S $P(RX(RX0,4,ZX,0),"^",5)="CANCEL DATE/REASON "_$P(Y,"@")_"  "_$P($G(RX(RX0,4,ZX,1)),"^")
 .I $P(RX(RX0,4,ZX,0),"^",8)]"" S $P(RX(RX0,4,ZX,0),"^",8)="NDC: "_$P(RX(RX0,4,ZX,0),"^",8)
 .I $P($G(RX(RX0,4,ZX,1)),"^",2)]"" S Y=$P(RX(RX0,4,ZX,1),"^",2) X ^DD("DD") S $P(RX(RX0,4,ZX,0),"^",9)=$P(Y,"@")
 .S $P(RX(RX0,4,ZX,0),"^",10)=$P($G(RX(RX0,4,ZX,1)),"^",3)
 .S $P(RX(RX0,4,ZX,0),"^",11)=$P($G(RX(RX0,4,ZX,1)),"^",4)
 I $O(RX(RX0,5,0)) F ZX=0:0 S ZX=$O(RX(RX0,5,ZX)) Q:'ZX  D
 .S Y=+$P($G(RX(RX0,5,ZX,0)),"^",2) I Y D DATECV S $P(RX(RX0,5,ZX,0),"^",2)=$P(Y,"@",1)
CVDATES ;
 S Y=+$P(RX(RX0,0),"^",13) I Y D DATECV S $P(RX(RX0,0),"^",13)=$P(Y,"@",1)
 S Y=+$P(RX(RX0,2),"^") I Y D DATECV S $P(RX(RX0,2),"^")=$P(Y,"@",1)
 S Y=+$P(RX(RX0,2),"^",2) I Y D DATECV S $P(RX(RX0,2),"^",2)=$P(Y,"@",1)
 S Y=+$P(RX(RX0,2),"^",5) I Y D DATECV S $P(RX(RX0,2),"^",5)=$P(Y,"@",1)
 S Y=+$P(RX(RX0,2),"^",6) I Y D DATECV S $P(RX(RX0,2),"^",6)=$P(Y,"@",1)
 S Y=+$P(RX(RX0,2),"^",11) I Y D DATECV S $P(RX(RX0,2),"^",11)=$P(Y,"@",1)
 S Y=+$P(RX(RX0,2),"^",13) I Y D DATECV S $P(RX(RX0,2),"^",13)=$P(Y,"@",1)
 S Y=+$P(RX(RX0,3),"^") I Y D DATECV S $P(RX(RX0,3),"^")=$P(Y,"@",1)
 S Y=+$P(RX(RX0,3),"^",2) I Y D DATECV S $P(RX(RX0,3),"^",2)=$P(Y,"@",1)
 K X,XX,YX,DATE1,DATE2,DATE,%X,%Y,Y,XY,XTYPE
 Q
DATE ;
 Q:'$D(RX(RX0,XTYPE,X,0))
 S Y=+$P($G(RX(RX0,XTYPE,X,0)),"^") I Y D DATECV S $P(RX(RX0,XTYPE,X,0),"^")=$P(Y,"@",1)
 I XTYPE=1 S Y=+$P($G(RX(RX0,XTYPE,X,0)),"^",15) I Y D DATECV S $P(RX(RX0,XTYPE,X,0),"^",15)=$P(Y,"@",1)
 I XTYPE=1 S Y=+$P($G(RX(RX0,XTYPE,X,0)),"^",19) I Y D DATECV S $P(RX(RX0,XTYPE,X,0),"^",19)=$P(Y,"@",1)
 I XTYPE=1 S Y=+$P(RX(RX0,XTYPE,X,0),"^",18) I Y D DATECV S $P(RX(RX0,XTYPE,X,0),"^",18)=$P(Y,"@",1)
 Q
 ;
REFILL S $P(RX(RX0,XTYPE,X,0),"^",5)=$S($D(^VA(200,+$P(RX(RX0,XTYPE,X,0),"^",5),0)):$P(^(0),"^"),1:"UNKNOWN")
 S $P(RX(RX0,XTYPE,X,0),"^",7)=$S($D(^VA(200,+$P(RX(RX0,XTYPE,X,0),"^",7),0)):$P(^(0),"^"),1:"UNKNOWN")
 S $P(RX(RX0,XTYPE,X,0),"^",9)=$S($D(^PS(59,+$P(RX(RX0,XTYPE,X,0),"^",9),0)):$P(^(0),"^"),1:"UNKNOWN")
 I $P(RX(RX0,XTYPE,X,0),"^",17) S $P(RX(RX0,XTYPE,X,0),"^",17)=$S($D(^VA(200,+$P(RX(RX0,XTYPE,X,0),"^",17),0)):$P(^(0),"^"),1:"UNKNOWN")
 I $D(RX(RX0,XTYPE,X,"IB")) S $P(RX(RX0,XTYPE,X,0),"^",20)=RX(RX0,XTYPE,X,"IB")
 Q
AUDIT S $P(RX(RX0,"A",X,0),"^",3)=$S($D(^VA(200,+$P(RX(RX0,"A",X,0),"^",3),0)):$P(^(0),"^"),1:"UNKNOWN")
 S YX=$O(RX(RX0,"A",X)) Q:+YX'>0  S DATE=$P(RX(RX0,"A",YX,0),".",1)
 I $P(RX(RX0,"A",X,0),".",1)=DATE,$P(RX(RX0,"A",X,0),"^",2)["W",$P(RX(RX0,"A",YX,0),"^",2)["W" K RX(RX0,"A",X,0)
 Q
LABEL S $P(RX(RX0,"L",X,0),"^",4)=$S($D(^VA(200,+$P(RX(RX0,"L",X,0),"^",4),0)):$P(^(0),"^"),1:"UNKNOWN")
 S YX=$O(RX(RX0,"L",X)) Q:+YX'>0  S DATE2=$E($P(RX(RX0,"L",YX,0),"^"),1,10),DATE1=$E($P(RX(RX0,"L",X,0),"^"),1,10)
 Q
DATECV ;converts internal dates to ext dates
 X ^DD("DD") Q
