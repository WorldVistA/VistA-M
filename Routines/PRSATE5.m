PRSATE5 ;WCIOFO/PLT-Check for Tour Overlap ;7/8/08  14:34
 ;;4.0;PAID;**117,121**;Sep 21, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ENT ;tour overlap check for all 14 days in file of a pp and an employee
 N DAY
 K PRSERR F DAY=1:1:14 D PPTDOL(SRT,PPI,DFN,DAY,.PRSDAY,1) QUIT:$G(PRSERR)
 QUIT
 ;
 ;srt=l for last pp, c for current, n for next, x for transmitted pp
 ;ppi=ien for file # 458
 ;dfn=ien of file #450
 ;day=day number 1, 2,...14
 ;.prsday(day) pass by '.' - local pp tour data retrived if defined
 ;^1=day #, ^2= tour ien of 457.1, ^3=temporary tour? 0,1,2 (next pp),
 ;^4= prior tour ien of 457.1
 ;^5=1 if secondary tour overlapped, ^6=secondary ien of 471.1
 ;^7,999=secondary tour hour segment
 ;prsc=1 check day-1 only (used all days check in pp)
 ;    >1 check day-1 and day+1 (used one day check)
PPTDOL(SRT,PPI,DFN,DAY,PRSDAY,PRSC) ;tour check for one day in a pp, define prserr=day if overlapped
 N A,B,C,I,PRS0,PRS1,PRS4,PRS71
 I '$G(PRSDAY(DAY)) S PRS0=$G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),PRS1=$G(^(1)),PRS4=$G(^(4))
 E  S PRS0=PRSDAY(DAY),PRS1=$P($$TOUR($P(PRS0,U,2)),"~",2,999),PRS4=$P($$TOUR($P(PRS0,U,6)),"~",2,999)
 D:SRT="N" NPP D:"LCX"[SRT LCPP:PRS1]""
 QUIT
 ;
NPP ;next pp (no secondary tour)
 S PRS71=$S($P(PRS0,U,3):$P(PRS0,U,4),1:$P(PRS0,U,2)),A=$$TOUR(PRS71),B=$$DAYT(PPI,DFN,SRT,DAY-1,.PRSDAY)
 ;if day-1 is a two-day tour
 I $P(B,"~")="Y",$$TOUROL($P(A,"~",2),$P(B,"~",2),4) D ERR(DAY,DAY-1,1) G:$G(PRSERR)=DAY NEXIT
 I DAY=1,$P(B,"~",3)="Y",$$TOUROL($P(A,"~",2),$P(B,"~",4),4) D ERR(DAY,DAY-1,3) G:$G(PRSERR)=DAY NEXIT
 ;if day is a two-day tour
 I $P(A,"~")="Y",DAY=14!(PRSC>1) S C=$$DAYT(PPI,DFN,SRT,DAY+1,.PRSDAY) I $$TOUROL($P(A,"~",2),$P(C,"~",2),3) D ERR(DAY,DAY+1,1) G:$G(PRSERR)=DAY NEXIT
NEXIT QUIT
 ;
LCPP ;last, current or transmitted pp
 ;check tour and secondary tours for the day
 I PRS4]"",$$TOUROL(PRS1,PRS4,"") D ERR(DAY,DAY,"") G:$G(PRSERR)=DAY LCEXIT
 ;day-1 tour or secondary is two-day tour
 S B=$$DAYT(PPI,DFN,SRT,DAY-1,.PRSDAY)
 F I=1,3 I $P(B,"~",I)="Y",$$TOUROL(PRS1,$P(B,"~",I+1),4) D ERR(DAY,DAY-1,I) G:$G(PRSERR)=DAY LCEXIT
 I PRS4]"" F I=1,3 I $P(B,"~",I)="Y",$$TOUROL(PRS4,$P(B,"~",I+1),4) D ERR(DAY,DAY-1,I+1) G:$G(PRSERR)=DAY LCEXIT
 QUIT:DAY'=14&(PRSC=1)
 ;day tour or secondary is two day tour
 S PRS71=$P(PRS0,U,2),A=$$TOUR(PRS71),PRS71=$P(PRS0,U,$S($G(PRSDAY(DAY)):6,1:13)),B=$$TOUR(PRS71)
 QUIT:$P(A,"~")'="Y"&($P(B,"~")'="Y")
 ;check day+1 including day 14
 S C=$$DAYT(PPI,DFN,SRT,DAY+1,.PRSDAY) QUIT:$P(C,"~",2)=""
 I $P(A,"~")="Y" F I=2,4 I $P(C,"~",I)]"",$$TOUROL(PRS1,$P(C,"~",I),3) D ERR(DAY,DAY+1,I-1) G:$G(PRSERR)=DAY LCEXIT
 I $P(B,"~")="Y" F I=2,4 I $P(C,"~",I)]"",$$TOUROL(PRS4,$P(C,"~",I),3) D ERR(DAY,DAY+1,I) G:$G(PRSERR)=DAY LCEXIT
LCEXIT QUIT
 ;
 ;a= ien of file #457.1
TOUR(A) ;ef: ~1=y if two day tour, ~2,999 =tour string
 QUIT:A<1 "~"
 QUIT $P($G(^PRST(457.1,A,0)),U,5)_"~"_$G(^(1))
 ;
 ;ppi= ien of 458, dfn= ien of 458
 ;a=l(ast), c(urrent), n(ext), x(transmit) pp
 ;b=day # (0,1,2,...13,14,15) of the pp
 ;.prsday = pass by '.'
DAYT(PPI,DFN,A,B,PRSDAY) ;ef: ~1=y if two-day tour, ~2 - tour string, ~3=y if two-day tour of secondary, ~4=secondary tour
 N C,D,E,F,G
 S C=$S(B=0&(A'="N"):PPI-1,B=15&("LX"[A):PPI+1,1:PPI),D=$S(B=0:14,B=15:1,1:B)
 I PPI=C,$G(PRSDAY(D)) S E=$G(PRSDAY(D)) QUIT:A="N"&B!(A="C"&(B=15)) $$TOUR($S($P(E,U,3):$P(E,U,4),1:$P(E,U,2)))  QUIT $$TOUR($P(E,U,2))_"~"_$P($$TOUR($P(E,U,6)),"~")_"~"_$P(E,U,7,999)
 S E=$G(^PRST(458,C,"E",DFN,"D",D,0)),F=$G(^(1))_"~"_$G(^(4)),G=$P(E,U,13)
 QUIT:A="N"&B!(A="C"&(B=15)) $$TOUR($S($P(E,U,3):$P(E,U,4),1:$P(E,U,2)))
 QUIT $P($$TOUR($P(E,U,2)),"~")_"~"_$P(F,"~")_$S(G:"~"_$P($$TOUR(G),"~")_"~"_$P(F,"~",2),1:"")
 ;
 ;
 ;tour of duty overlap check
 ;a=string of tour of duty, b=string of dour of duty
 ;string of tour of duty = start time^end time^special code^start time^...
 ;c - parameter is for checking tour string b against string a with options
 ;c = "" check tour string b against a
 ;c = 1 checked for first day tour of b only, 2 for second day only
 ;c = 3 checked for first day tour of b as second day, 4 for second day as first day
 ;c = 2 and 4 are only for b tour string with two-day tour
TOUROL(A,B,C) ;ef: =0 if not overlapped, =1 if overlapped
 N D,E,F,G,I,X,Y,Z
 ;connect hour segments in a and set start/end militay time in array d
 S Z=0,E=0 F I=1:1 S X=$P(A,U,I) QUIT:$P(A,U,I,999)=""  I I#3'=0 S Y=I>1 D MIL^PRSATIM S:Y<Z!(Y=Z&(I#3=2)) E=E+2400 S Z=Y,Y=E+Y,D(Y)=$G(D(Y))_(I#3) K:$G(D(Y))=21 D(Y)
 ;set hour segments in b to f with military time
 S (Z,E,G)=0,F="" F I=1:1 S X=$P(B,U,I) QUIT:$P(B,U,I,999)=""  I I#3'=0 S Y=I>1 D MIL^PRSATIM S:Y<Z!(Y=Z&(I#3=2)) E=E+2400 S Z=Y,Y=E+Y,G=G+1,$P(F,U,G)=Y
 ;connect hour segments, that is remove same end/start time
 F I=2:2 QUIT:$P(F,U,I)=""  S:$P(F,U,I)=$P(F,U,I+1) $P(F,U,I,I+2)=$P(F,U,I+2),I=I-2
 ;select first day hour segments from f and put in d if c#2=1, second day hour segmentd from f to d if c#2=0
 S D=F I C S:C#2=0 D="" F I=1:2 QUIT:$P(F,U,I)=""  I C#2=1&($P(F,U,I)>2359)!(C#2=0&($P(F,U,I+1)>2400)) S:C#2=1 D=$P(F,U,1,I-1) S:C#2=0 D=$P(F,U,I,999) QUIT
 ;add 2400 to hour segment of first day tour if c=3 and -2400 to hour segment of second day tour if c=4
 I C>2 F I=1:1 QUIT:$P(D,U,I)=""  S $P(D,U,I)=$S(C=4:-2400,1:2400)+$P(D,U,I) S:D<0&(I=1)&(C=4) $P(D,U,1)=0 I $P(D,U,I)>4800 S $P(D,U,I)=4800 QUIT
 ;check overlap
 S C=0 F I=1:2 S E=$P(D,U,I) QUIT:E=""!C  S G=$O(D(E)),C=$S(G'=$O(D($P(D,U,I+1)-1)):1,'G:0,D(G)'=1:1,1:0)
 QUIT C
 ;
 ;a = day number, b=day number
 ;c="" if a=b a's primary, a's secondary
 ;c=1 a's primary, b's primary tour, =3 a's primary, b's secondary
 ;c=2 a's secondary, b's primary, =4 a's secondary, b's secondary
ERR(A,B,C) ;define prserr=a
 N D,E,F,PPID
 S F=PPE S:SRT="N" F=$P($$DTPP^PRSU1B2($P($$PPDT^PRSU1B2(PPE,1),U,4)+14,"H"),U,2)
 S PPID=$S(SRT="X":"Xmitted",SRT="C":"Current",SRT="N":"Next",1:"Last")
 I A'=B S D(1)="ERROR: "_PPID_"-PP "_F_", Day "_A_" "_$S(C#2=1:"Primary",1:"Secondary")_" overlaps Day "_$S(B=0:14,B=15:1,1:B)_" "_$S(C<3:"Primary",1:"Secondary")_$S(A=1&(B=0):" of prior PP",A=14&(B=15):" of next PP",1:"")
 E  S D(1)="ERROR: "_PPID_"-PP "_F_", Day "_A_" Secondary Tour overlaps Primary Tour"
 S PRSERR=A I '$D(DDSFILE) D EN^DDIOL(.D) QUIT
 D HLP^DDSUTL(.D)
 QUIT
