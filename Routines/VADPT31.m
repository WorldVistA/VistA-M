VADPT31 ;ALB/MRL/MJK - PATIENT VARIABLES [IN5], CONT.; 12 DEC 1988
 ;;5.3;Registration;**498,509**;Aug 13, 1993
 ;Inpatient variables [Version 5.0 and above]
EN N VAINDT,VAMV,VAMV0
 S VAMV=+E,VAMV0=^DGPM(VAMV,0),VAX("CA")=+$P(VAMV0,"^",14) G ENQ:'$D(^DGPM(+VAX("CA"),0))
 I $D(VAIP("M")) D CE G ENQ:'$D(^DGPM(+E,0)) S VAMV=+E,VAMV0=^(0)
 S @VAV@($P(VAS,"^",1))=E
 S Y=$P(VAMV0,"^",2),@VAV@($P(VAS,"^",2))=Y_"^"_$S($D(^DG(405.3,+Y,0)):$P(^(0),"^"),1:"")
 S Y=$S(+VAMV0:+VAMV0,1:"") X:Y ^DD("DD") S @VAV@($P(VAS,"^",3))=+VAMV0_"^"_Y
 S Y=$P(VAMV0,"^",18),@VAV@($P(VAS,"^",4))=Y_"^"_$S($D(^DG(405.2,+Y,0)):$P(^(0),"^"),1:"")
 S Y=+$P(^DGPM(VAX("CA"),0),"^",16) S:Y @VAV@($P(VAS,"^",12))=Y
 ;
 S VATD=VAX("DT") D FIND
 S @VAV@($P(VAS,"^",5))=VAWD,@VAV@($P(VAS,"^",6))=VARM,@VAV@($P(VAS,"^",7))=VAPP,@VAV@($P(VAS,"^",8))=VATS,@VAV@($P(VAS,"^",9))=VADX,@VAV@($P(VAS,"^",18))=VAAP
 ;
 S VANODE=$G(^DGPM(VAX("CA"),0)) I $P(VANODE,"^",2)=1  D
 .N DCD
 .S DCD=+$P(VANODE,"^",17) I DCD S DCD=+$G(^DGPM(DCD,0))
 .S VANODE=$G(^DGPM(VAX("CA"),"DIR"))
 .S Y=$P(VANODE,"^",1)
 .I Y="" S Y=$S('DCD:1,(DCD<3030414.999999):"",1:1) Q:Y=""
 .S @VAV@($P(VAS,"^",19),1)=Y_"^"_$$EXTERNAL^DILFD(405,41,,Y)
 .S Y=$P(VANODE,"^",2) S @VAV@($P(VAS,"^",19),2)=Y_"^"_$$EXTERNAL^DILFD(405,42,,Y)
 .S Y=$P(VANODE,"^",3) S @VAV@($P(VAS,"^",19),3)=Y_"^"_$$EXTERNAL^DILFD(405,43,,Y)
 ;
 S VAINDT=+VAMV0 D IB^VADPT2 S @VAV@($P(VAS,"^",10))=+VAZ
 I 'VAZ,$D(VAZ(2)),VAZ(2)?7N!(VAZ(2)?7N1".".N) S Y=VAZ(2) X ^DD("DD") S @VAV@($P(VAS,"^",11))=VAZ(2)_"^"_Y
 ;
 I $D(VAIP("M")) S VASET=$S(VAIP("M"):14,1:13),VASET(VASET)="",VANODE=$P(VAS,"^",VASET) D COPY ; last or adm
 I '$D(VAIP("M")),$D(VAIP("D")),"^l^L^"[("^"_$E(VAIP("D"))_"^") S VASET(14)="",VANODE=$P(VAS,"^",14) D COPY ; last
 I "^3^5^"[("^"_$P(VAMV0,"^",2)_"^") S VASET(17)="",VANODE=$P(VAS,"^",17) D COPY ; d/c
 I '$D(VASET(13)) S VAMV=VAX("CA"),VAMV0=^DGPM(VAMV,0),VANODE=$P(VAS,"^",13) D STORE ; adm
 D BLD^VADPT32 G ENQ:'$D(^UTILITY("VADPTZ",$J,DFN))
 S VAXE=$S($D(^UTILITY("VADPTZ",$J,DFN,1)):^(1),1:""),VAMV0=$P(VAXE,"||",2),VAMV=+VAXE
 I VAMV,"^3^5^"[("^"_$P(VAMV0,"^",2)_"^"),'$D(VASET(17)) S VANODE=$P(VAS,"^",17) D STORE ; d/c
 I VAMV,'$D(VASET(14)) S VANODE=$P(VAS,"^",14) D STORE ;last
 I $S('VANN:1,'$D(^UTILITY("VADPTZ",$J,DFN,+VANN)):1,1:0) G ENQ
 I $D(^UTILITY("VADPTZ",$J,DFN,VANN-1)) S VAXE=^(VANN-1),VAMV=+VAXE,VAMV0=$P(VAXE,"||",2) I VAMV S VANODE=$P(VAS,"^",16) D STORE ; following
 I $D(^UTILITY("VADPTZ",$J,DFN,VANN+1)) S VAXE=^(VANN+1),VAMV=+VAXE,VAMV0=$P(VAXE,"||",2) I VAMV S VANODE=$P(VAS,"^",15) D STORE ; prior
 ;
ENQ K VAMVX,VANODE,VAMCC,VAXE,VANN D KVAR^VADPT30 Q
 ;
FIND ;
 S VAMVX=VAMV,VAMV0X=VAMV0
 S (VAWD,VATS,VAMV,VARM,VAPP,VAAP,VADX)=""
 I $P(VAMV0,"^",2)=4!($P(VAMV0,"^",2)=5) D LODGER G FINDQ
 S VATD=9999999.999999-VATD,(VACN,VAPRC,VAPRT)=1 D GET^VADPT30
FINDQ S VAMV=VAMVX,VAMV0=VAMV0X K VAMVX,VAMV0X
 Q
 ;
CE I 'VAIP("M") S E=+VAX("CA") Q
 S E=$O(^DGPM("APMV",DFN,+VAX("CA"),0)) Q:E'>0  S E=$O(^DGPM("APMV",DFN,+VAX("CA"),E,0)) Q
 ;
STORE ; store 'other nodes'
 S @VAV@(VANODE)=+VAMV
 S Y=+VAMV0 X:Y ^DD("DD") S @VAV@(VANODE,1)=+VAMV0_"^"_Y
 S Y=$P(VAMV0,"^",2),@VAV@(VANODE,2)=Y_"^"_$S($D(^DG(405.3,+Y,0)):$P(^(0),"^"),1:"")
 S Y=$P(VAMV0,"^",18),@VAV@(VANODE,3)=Y_"^"_$S($D(^DG(405.2,+Y,0)):$P(^(0),"^"),1:"")
 S VATD=+VAMV0 D FIND
 S @VAV@(VANODE,4)=VAWD,@VAV@(VANODE,5)=VAPP,@VAV@(VANODE,6)=VATS,@VAV@(VANODE,7)=VADX
 Q
 ;
COPY ; copy from primary to other nodes
 S @VAV@(VANODE)=VAMV
 ; 1-mvt d/t ; 2-transaction type ; 3-mvt type
 S @VAV@(VANODE,1)=@VAV@($P(VAS,"^",3)),@VAV@(VANODE,2)=@VAV@($P(VAS,"^",2)),@VAV@(VANODE,3)=@VAV@($P(VAS,"^",4))
 ; 4-ward ; 5-doc ; 6-treat spec ; 7-dx
 S @VAV@(VANODE,4)=@VAV@($P(VAS,"^",5)),@VAV@(VANODE,5)=@VAV@($P(VAS,"^",7)),@VAV@(VANODE,6)=@VAV@($P(VAS,"^",8)),@VAV@(VANODE,7)=@VAV@($P(VAS,"^",9))
 Q
 ;
LODGER ; -- get lodger data
 S VAWD=$S($P(VAMV0,"^",2)=4:$P(VAMV0,"^",6),$D(^DGPM(+$P(VAMV0,"^",14),0)):$P(^(0),"^",6),1:"")
 S VAWD=$S($D(^DIC(42,+VAWD,0)):VAWD_"^"_$P(^(0),"^"),1:"")
 S VARM=$S($P(VAMV0,"^",2)=4:$P(VAMV0,"^",7),$D(^DGPM(+$P(VAMV0,"^",14),0)):$P(^(0),"^",7),1:"")
 S VARM=$S($D(^DG(405.4,+VARM,0)):VARM_"^"_$P(^(0),"^"),1:"")
 Q
