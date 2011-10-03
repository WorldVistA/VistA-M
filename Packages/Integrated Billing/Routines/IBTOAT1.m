IBTOAT1 ;ALB/AAS - CLAIMS TRACKING ADMISSION SHEET PRINT ; 18-JUN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**1**; 21-MAR-94
 ;
ONE ; -- print one sheet here - no close device, no form feeds
 ;    input   DFN  = patient file pointer
 ;          IBTRN  = Tracking module entry
 ;
 Q:'$D(DFN)
 I '$D(IOST) D HOME^%ZIS
 N I,J,X,Y,VADM,VAOA,VAPA,VA,VAEC,VAIN,IBTRND,VAEL,VAINDT,VA200
 ;
 ; -- Make sure tracking entry exists
 I +$G(IBTRN)<1!('$D(^IBT(356,+$G(IBTRN),0))) Q  ;D ADM^IBTUTL()
 S IBTRND=$G(^IBT(356,+$G(IBTRN),0))
 ;
 S TAB=4,TAB2=45
 W $C(13),?(IOM-15/2),"ADMISSION SHEET"
 S IBTITLE=$G(^IBE(350.9,1,5))
 F I=1:1:3 W !,?(IOM-$L($P(IBTITLE,"^",I))/2),$P(IBTITLE,"^",I)
 ;
 D DEMO,LINE,ADM,LINE,EM,LINE
 I $E(IOST,1,2)="C-" D PAUSE^VALM1 I $D(DIRUT) G END
 D INS,LINE,^IBTOAT2
END D KVAR^VADPT K VAEC,DIRUT
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
ADM ; -- print admissions data
 I $G(IBTRN)="" W !?TAB,"No admission Found",!!!! G ADMQ
 ;S VA200="" D INP^VADPT
 N VAINDT S VAINDT=$P(+$G(^DGPM(+$P($G(^IBT(356,IBTRN,0)),"^",5),0)),".")_.2359 D INP^VADPT
 W !?TAB,"Adm. Date: ",$P(VAIN(7),"^",2)
 W ?TAB2,"Adm. Type: ",$E($$ATYPE($P(IBTRND,"^",7)),1,19) ; urgent/emergent
 W !?TAB," Provider: ",$P(VAIN(2),"^",2)
 W ?TAB2,"Specialty: ",$P(VAIN(3),"^",2)
 W !?TAB,"     Ward: ",$P(VAIN(4),"^",2)
 W ?TAB2," Room/Bed: ",VAIN(5)
 W !?TAB,"Adm. Diag: ",$$ADMDIAG^IBTRE6(IBTRN)
 ;
ADMQ Q
 ;
DEMO ; -- print pt. demographics
 D 4^VADPT ;demographic and pt address
 D ELIG^VADPT ;eligiblity data
 ;
 W !!?TAB,"  Patient: ",VADM(1)
 W ?TAB2,"  Address: ",VAPA(1)
 W !?TAB,"    Pt ID: ",VA("PID")
 I VAPA(2)'="" W ?TAB2+11,VAPA(2)
 W !?TAB,"      Dob: ",$P(VADM(3),"^",2)
 I VAPA(3)'="" W ?TAB2+11,VAPA(3)
 W !?TAB,"       SC: ",$S(+VAEL(3):"YES - "_$P(VAEL(3),"^",2)_"%",1:"NO")
 W ?TAB2+11,VAPA(4),$S(VAPA(4)'="":", ",1:""),$P($G(^DIC(5,+VAPA(5),0)),"^",2),"  ",VAPA(6)
 W !?TAB,"      Sex: ",$P(VADM(5),"^",2),?TAB2,"    Phone: ",VAPA(8)
 Q
 ;
EM S VAROOT="VAEC",VAOA("A")=1 D OAD^VADPT K VAROOT ;emergency contact info
 S VAOA("A")=5 D OAD^VADPT ;patient employer info
 W !,?TAB," Employer: ",VAOA(9)
 W ?TAB2,"  E-Cont.: ",VAEC(9) I VAEC(10)'="" W " - ",VAEC(10)
 W !?TAB+11,VAOA(1),?TAB2+11,VAEC(1)
 I VAEC(2)'=""!(VAOA(2)'="") W !?TAB+11,VAOA(2),?TAB2+11,VAEC(2)
 I VAEC(3)'=""!(VAOA(3)'="") W !?TAB+11,VAOA(3),?TAB2+11,VAEC(3)
 W !?TAB+11,VAOA(4),$S(VAOA(4)'="":", ",1:""),$P($G(^DIC(5,+VAOA(5),0)),"^",2),"  ",VAOA(6)
 W ?TAB2+11,VAEC(4),$S(VAEC(4)'="":", ",1:""),$P($G(^DIC(5,+VAEC(5),0)),"^",2),"  ",VAEC(6)
 W !?TAB,"    Phone: ",VAOA(8),?TAB2,"    Phone: ",VAEC(8)
 Q
 ;
INS ; -- print insurance info
 N IBINS,IBCNT,I
 I '$D(IBDT) S IBDT=DT
 D ALL^IBCNS1(DFN,"IBINS",1,IBDT)
 I $G(IBINS(0))<1 W !,?TAB,"No Insurance Information",!!! G INSQ
 S MAX=$S(IOSL<61:1,IOSL<67:2,1:3)
 S I=0,IBCNT=0 F  S I=$O(IBINS(I)) Q:'I  S IBINS=IBINS(I,0) D  I '$D(IBALLIN),IBCNT>MAX W !?TAB,"MORE......" Q
 .S IBCNT=IBCNT+1
 .I IBCNT>1 W !
 .W !?TAB,"Ins. Co "_IBCNT_": ",$P($G(^DIC(36,+IBINS,0)),"^")
 .S X=$G(^DIC(36,+IBINS,.13)),X=$S($P(X,"^",3)'="":$P(X,"^",3),1:$P(X,"^"))
 .W ?TAB2,"    Phone: ",X
 .W !?TAB,"   Subsc.: ",$P(IBINS,"^",17)
 .W ?TAB2,"     Type: ",$E($P($G(^IBE(355.1,+$P($G(^IBA(355.3,+$P(IBINS,"^",18),0)),"^",9),0)),"^"),1,20)
 .W !?TAB,"Subsc. ID: ",$P(IBINS,"^",2)
 .W ?TAB2,"    Group: ",$$GRP^IBCNS($P(IBINS,"^",18))
INSQ Q
 ;
LINE ; -- write a line
 W !,$$L("-",IOM)
 Q
 ;
TWOL ; -- write two underlines
 W !?TAB,$$L("_",IOM-TAB),!!?TAB,$$L("_",IOM-TAB)
 Q
 ;
L(C,L) ; -- output line
 S:$G(C)="" C="-"
 S:$G(L)="" L=IOM
 Q $TR($J(" ",L)," ",C)
 ;
ATYPE(X) ; -- Admission Type Expand Set
 ; -- input internal form (number)
 ; -- output external form
 Q $P($P($P(^DD(356,.07,0),"^",3),+$G(X)_":",2),";",1)
