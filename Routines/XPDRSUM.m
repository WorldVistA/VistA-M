XPDRSUM ;SFISC/RWF - Routine checksum utilities ; 13 Oct 95 11:21
 ;;8.0;KERNEL;**10**;Jul 10, 1995
 Q
SUMA(GLO) ;This tag builds the old RSUM value
 ;Call with a reference to a global that has the routine
 N Y,%,%1,%2,%3 S Y=0
 F %=1,3:1 S %1=$G(@GLO@(%,0)),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*%2+Y
 Q Y
SUMB(GLO) ;This tag builds the new RSUM value
 ;Call with a reference to a global that has the routine
 N Y,%,%1,%2,%3 S Y=0
 F %=1,3:1 S %1=$G(@GLO@(%,0)),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*(%2+%)+Y
 Q Y
SUMC(GLO) ;This tag builds the new checksum for global
 ;Call with a reference to a global
 N Y,%,%1,%2,%3,%4,%5
 S Y=0,%=$NA(@GLO),%1=$E(%,1,$L(%)-1),%2=$L(%1)
 F %5=1:1 S GLO=$Q(@GLO) Q:GLO=""!($E(GLO,1,%2)'=%1)  S %3=@GLO F %4=1:1:$L(%3) S Y=$A(%3,%4)*(%4+%5)+Y
 Q Y
