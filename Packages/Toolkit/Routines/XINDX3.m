XINDX3 ;ISC/REL,GRK,RWF - PROCESS MERGE/SET/READ/KILL/NEW/OPEN COMMANDS ;06/24/08  15:44
 ;;7.3;TOOLKIT;**20,27,61,68,110,121,128,132,133**;Apr 25, 1995;Build 15
 ; Per VHA Directive 2004-038, this routine should not be modified.
PEEK S Y=$G(LV(LV,LI+1)) Q
PEEK2 S Y=$G(LV(LV,LI+2)) Q
INC2 S LI=LI+1 ;Drop into INC
INC S LI=LI+1,S=$G(LV(LV,LI)),S1=$G(LV(LV,LI+1)),CH=$E(S)
 G ERR:$A(S)=10 Q
DN S LI(LV)=LI,LI(LV,1)=AC,LV=LV+1,LI=LI(LV),AC=NOA
 Q
UP ;Inc LI as we save to skip the $C(10).
 D PEEK S:$A(Y)=10 LI=LI+1 S LI(LV)=LI,LV=LV-1,LI=LI(LV),AC=LI(LV,1) Q
PEEKDN S Y=$G(LV(LV+1,LI(LV+1)+1)) Q
FIND F Y=LI:1:AC Q:L[$G(LV(LV,Y))
ERR D E^XINDX1(43) S (S,S1,CH)="" Q
 Q
 Q
S ;Set
 S STR=ARG,ARG="",RHS=0 D ^XINDX9
S2 S GK="" D INC I S="" D:'RHS E^XINDX1(10) Q
 I CH=",","!""#&)*+-,./:;<=?\]_~"[$E(S1),RHS=1 D E^XINDX1(10) G S2 ;patch 121
 I CH="," S RHS=0 G S2
 I CH="=" S RHS=1 I "!#&)*,/:;<=?\]_~"[$E(S1) D:$E(S1,1,2)'="##" E^XINDX1(10) G S2 ;patch 119
 I CH="$",'RHS D  D:% E^XINDX1(10) ;Can't be on left side of set.
 . S %=1
 . I "$E$P$X$Y"[$E(S,1,2) S %=0 Q
 . I "$EC$ET$QS"[$E(S,1,3) S %=0 Q
 . I "$ZE$ZT"[$E(S,1,3) S %=0 Q  ;Pickup in XINDX9
 . Q
 I CH="^" D FL G S2
 I CH="@" S Y=$$ASM(LV,LI,",") S:Y'["=" RHS=1 D INC,ARG^XINDX2 G S2
 I CH="(",$D(LV(LV,"OBJ",LI-1)) D ARG^XINDX2 G S2
 I CH="(" D MULT G S2
 I CH="#",$E(S,1,2)="##" D ARG^XINDX2 G S2 ;Cache Objects
 D FL G S2
 ;NOA=number of arguments
MULT D INC S NOA=S I S'>0 S ERR=5 G ^XINDX1
 D DN S AC=AC+LI F  Q:AC'>LI  S:'RHS GK="*" D INC,ARG^XINDX2
 D UP
 Q
FL ;
 S:'RHS GK="*" D ARG^XINDX2
 Q
VLNF(X) ;Drop into VLN
VLN ;Valid Local Name > Variable
 S ERR=0
 Q:X?1(1U,1"%").15UN
 I X?1(1A,1"%").15AN D E^XINDX1(57) Q  ;Lowercase
 D E^XINDX1(11) ;Too long or other problem
 Q
VGN ;Valid Global Name
 S ERR=0 I X'?1(1U,1"%").7UN D E^XINDX1(12)
 Q
KL ;Process KILL
 S STR=ARG,ARG(1)=ARG,ARG="" D ^XINDX9
A D INC Q:S=""  G A:CH="," S LOC="L" D @$S(CH="@":"KL1",CH="^":"KL2",CH="(":"KL4",1:"KL3") G A
KL1 D INC,ARG^XINDX2 Q
KL2 S GK="!"
 I S1'="(" S ERR=24 D ^XINDX1
 G ARG^XINDX2
KL3 I "^DT^DTIME^DUZ^IOST^IOM^U^"[("^"_S_"^") S ERR=39,ERR(1)=S D ^XINDX1
 I "IO"=S D:S1="(" PEEKDN S ERR=39,ERR(1)=S_$S(S1["(":S1_Y_")",1:"") D:S1'="(" ^XINDX1 I S1="(",("QC"'[$E(Y,2)) D ^XINDX1
KL5 S GK="!" D ARG^XINDX2 Q  ;KILL SUBS
 Q
KL4 S NOA=S1 D DN,ARGS^XINDX2,UP,INC2 Q
NE ;NEW
 S ERR=$S("("[$E(ARG):26,1:0) I ERR G ^XINDX1 ;look for null or (
 S STR=ARG D ^XINDX9 K ERTX
N2 D INC Q:S=""  G N2:CH=","
 ;I CH?1P,("%@()"'[CH)&("$E"'[$E(S,1,2)) D E^XINDX1(11) G N2
 ;check for "@", functions, special variables, or %variables
 I CH?1P,(CH'=S) D  I $G(ERTX)]"" K ERTX G N2
 . Q:"@("[CH!(CH="%"&($E(S,2,8)?.1A.E))  ;check what's indirected on next pass or
 . ;if not $ET or $ES must use indirection 
 . I "$"[CH Q:$E(S,1,3)="$ET"!($E(S,1,3)="$ES")  I LI>1,(LV(LV,LI-1)="@") Q
 . D E^XINDX1(11)
 . Q
 S GK="~" D ARG^XINDX2
 G N2
 ;
RD S STR=ARG D ^XINDX9 S ARG=""
RD1 D INC Q:S=""
 ;I (CH="!")!(CH=",")!(CH=Q)!(CH="#") G RD1
 ;I CH="^" S ERR=11 D ^XINDX1
 I '((CH="%")!(CH?1A)!(CH="*")) D RD3 G RD1
 S Y=$$ASM(LV,LI,",") I Y'[":" S ERR=33,RDTIME=1 D ^XINDX1
 D RD2 G RD1
RD2 Q:","[CH
 I "*#"[CH D E^XINDX1(41)
 I "#:"[CH D INC,ARG^XINDX2,INC G RD2
 I (CH="%")!(CH?1A) S LOC="L",GK="*" D ARG^XINDX2,INC G RD2
 D INC G RD2
RD3 Q:","[CH  I "!#?"[CH D INC G RD3
 I (CH="%")!(CH?1A)!(CH="@") D ARG^XINDX2,INC G RD3
 Q
O S STR=ARG,AC=99 D ^XINDX9,INC S ARG="" I S["@" D ARGS^XINDX2 Q
 D ARG^XINDX2,INC D  D INC,ARGS^XINDX2 Q
 . F  D INC Q:":"[S
 . Q
 Q
ERRCP S ERR=5 D ^XINDX1 Q
ST ;
 S:'$D(V(LOC,S)) V(LOC,S)="" S:V(LOC,S)'[GK V(LOC,S)=V(LOC,S)_GK,GK="" Q
 Q
ASM(WL,SI,L,SEP) ;
 N %,CH,Y S SEP=$G(SEP),Y="" F %=SI:1 S CH=$G(LV(WL,%)) Q:L[CH  S Y=Y_SEP_CH
 Q Y
