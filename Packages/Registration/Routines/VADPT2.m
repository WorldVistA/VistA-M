VADPT2 ;ALB/MJK - ESTABLISH PATIENT VARIABLES ; 3/23/88  9:13 PM ; [10/20/95 4:02pm]
 ;;5.3;Registration;**69,749**;Aug 13, 1993;Build 10
5 ; -- INP call
 S (VAWD,VATS,VADX,VAPP,VAAP,VARM)="" S VANOW=$$NOW^XLFDT K VAMV,VAMV0
 I '$D(VAINDT) N VAINDT S VAINDT=VANOW
 S VATD=9999999.999999-VAINDT
 F VAID=VATD:0 S VAID=$O(^DGPM("APID",DFN,VAID)) Q:'VAID  S VAMV=$O(^(VAID,0)) D CHK I $D(VAMV) K:"^3^4^5^"[("^"_VAMT_"^") VAMV,VAMV0 Q
 ;
 G:'$D(VAMV0) DONE
 S (VAPRT,VAPRC,VACN)=1 D GET^VADPT30
 S VAMV0=^DGPM(VAMV,0),VAMVT=$P(VAMV0,"^",4),VACA=$P(VAMV0,"^",14),VACA0=$S($D(^DGPM(+VACA,0)):^(0),1:"")
 ;
 ; set: adm ifn(1) ; doctor(2) ; tr spec(3) ; ward(4) ; room(5) ; attending (11)
 S @VAV@($P(VAS,"^",1))=VACA,@VAV@($P(VAS,"^",2))=VAPP,@VAV@($P(VAS,"^",3))=VATS,@VAV@($P(VAS,"^",4))=VAWD,@VAV@($P(VAS,"^",5))=$P(VARM,"^",2),@VAV@($P(VAS,"^",11))=VAAP
 ;
 ; set bed/no bed  mvt type(6)
 D IB S @VAV@($P(VAS,"^",6))=VAZ
 ;
 ; set adm date(7)
 S Y=+VACA0 X:Y ^DD("DD") S @VAV@($P(VAS,"^",7))=+VACA0_"^"_Y
 ;
 ; set: adm type(8) ; adm dx(9) ; ptf ifn(10)
 S @VAV@($P(VAS,"^",8))=$P(VACA0,"^",4)_"^"_$S($D(^DG(405.1,+$P(VACA0,"^",4),0)):$P(^(0),"^"),1:""),@VAV@($P(VAS,"^",9))=$P(VACA0,"^",10),@VAV@($P(VAS,"^",10))=$P(VACA0,"^",16)
 ;
DONE K VAID,VANOW,VACA,VACA0,VAMV,VAMV0,VATD,VAMT,VAMVT D KVAR^VADPT30 Q
 ;
IB ;In-Bed status
 ; input:  VAINDT = internal date of requested info
 ;         VAMV   = starting IFN
 ;         VAMV0  = 0th of VAMV
 ;
 ; output: VAZ    = <O:not in bed OR 1: in bed>^fac. mvt name
 ;         VAZ(2) = abs ret date
 ;
 S VAZ=0,VAZ(2)=""
 S VAXI=+$O(^DGPM("APMV",DFN,+$P(VAMV0,"^",14),9999999.999999-VAINDT)),VAXI=+$O(^(VAXI,0))
 I 'VAXI,$D(VAIP("L")),$P(VAMV0,"^",2)=4 S VAXI=VAMV ; only used via IN5
 G IBQ:'VAXI
 S VAX0=$S($D(^DGPM(VAXI,0)):^(0),1:"")
 G IBQ:VAX0']"",IBQ:"^3^5^"[("^"_$P(VAX0,"^",2)_"^")
 S VAXI=$S($D(^DG(405.1,+$P(VAX0,"^",4),0)):$P(^(0),"^"),1:"")
 ; -- check in-bed status flag
 S VAZ=$S('$D(^DG(405.2,+$P(VAX0,"^",18),"E")):1,1:'^("E"))_"^"_VAXI,VAZ(2)=$P(VAX0,"^",13)
IBQ K VAXI,VAX0 Q
 ;
CHK ; -- check if mvt exists and if 'while asih' type d/c
 ;    if VAMV returned undefined then continue $Oing
 ;
 I $D(^DGPM(+VAMV,0)) S VAMV0=^(0),VAMT=$P(VAMV0,"^",2)
 I '$D(VAMV0) K VAMV G CHKQ
 I "^42^47^"[("^"_$P(VAMV0,"^",18)_"^"),$P(VAMV0,"^",22)'=2,$O(^DGPM("APMV",DFN,+$P(VAMV0,"^",14),VAID)),$O(^($O(^(VAID)),0)),$D(^DGPM($O(^(0)),0)),"^13^44^"[("^"_$P(^(0),"^",18)_"^") K VAMV,VAMV0
 ; info: 47 mvt can not have seq #; will always be null
CHKQ Q
 ;
ADM ; -- send back adm ifn for dfn on vaindt or now
 S VADT=$S($D(VAINDT):VAINDT,1:"") I 'VADT  S VADT=$$NOW^XLFDT
 S VAID=9999999.999999-VADT,VADMVT=""
 F  S VAID=$O(^DGPM("ATID1",DFN,VAID)) Q:'VAID  S VAMV=+$O(^DGPM("ATID1",DFN,VAID,0)) I $D(^DGPM(VAMV,0)) S VAMV0=^(0),VAMV1=$S($D(^DGPM(+$P(VAMV0,"^",17),0)):^(0),1:9999999.999999) D  Q:VADMVT!($P(VAMV0,U,18)'=40)
 .I VAMV0'>VADT,VAMV1>VADT S VADMVT=VAMV
 K VAID,VADT,VAMV,VAMV0,VAMV1
