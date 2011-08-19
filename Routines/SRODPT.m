SRODPT ;B'HAM ISC/MAM - SURGERY INFORMATION GENERATOR ; 18 FEB 91 3:00 PM
 ;;3.0; Surgery ;;24 Jun 93
DEM ; demographic information
 Q:'$D(SRFN)  S SR(0)=^SRF(SRFN,0),DFN=$P(SR(0),"^") D DEM^VADPT S SRFN(1)=VADM(1),SRFN(2)=$P(SR(0),"^",9),SRFN(3)=$P(SR(0),"^",10)
 S SRFN(4)=$S($D(^SRF(SRFN,33)):$P(^(33),"^"),1:"") I $D(^SRF(SRFN,34)) S SRFN(4)=SRFN(4)_"^"_$P(^(34),"^")
 S SRFN(5)=$P(SR(0),"^",3) I SRFN(5)'="" S SRFN(5)=$S(SRFN(5)="M":"MAJOR",1:"MINOR")
 S SRFN(6)=$P(SR(0),"^",4) I SRFN(6)'="" S SRFN(6)=$P(^SRO(137.45,SRFN(6),0),"^")
 S SRFN(7)=$S($D(^SRF(SRFN,1.1)):$P(^(1.1),"^",3),1:"") I SRFN(7)'="" S SRFN(7)=+SRFN(7)
 Q
CON ; concurrent case information
 Q:'$D(^SRF(SRFN,"CON"))  S SRFN("CON")=$P(^SRF(SRFN,"CON"),"^") S SRFN("CON")=SRFN("CON")_"^"_$P(^SRF(SRFN("CON"),"OP"),"^")_"^"_$P(^SRF(SRFN("CON"),"OP"),"^",2)
 Q
OPS ; operation information
 S SRFN("OP")=$P(^SRF(SRFN,"OP"),"^")_"^"_$P(^SRF(SRFN,"OP"),"^",2)
 Q
