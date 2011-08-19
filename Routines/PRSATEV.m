PRSATEV ; HISC/REL-Tour Verification ;3/23/92  11:26
 ;;4.0;PAID;;Sep 21, 1995
 S X=$G(^PRSPC(DFN,0)),DB=$P(X,"^",10),NH=$P(X,"^",50)
 I DB=1 S TT=$S(NH<1:2,1:0) Q
 I DB=2 S TT=$S(NH<2:3,1:0) Q
 S TT=4 S PP=$P(X,"^",21) I PP="T" S:$P(X,"^",20)=9 TT=3 Q
 I PP="L" S OCC=$P(X,"^",17) I "0602 0680"[$E(OCC,1,4),"23"[$E(OCC,5) S TT=3 Q
 Q:PP'="M"  S OCC=$P(X,"^",17),O2=$E(OCC,5,6),O1=+$E(OCC,1,4)
 I O1=610 S:"71 72 80 83"[O2 TT=0 Q
 I O1=605 S:"52 56"[O2 TT=0 Q
 Q
