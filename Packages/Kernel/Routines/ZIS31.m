%ZIS31 ;SFISC/AC - DEVICE HANDLER -- RESOURCES ;10/13/89  13:51
 ;
 L ^%ZISL(3.54):1
 I '$T S POP=1 W:'$D(IOP) *7,"  [NOT AVAILABLE]" Q
 S X=$O(^%ZISL(3.54,"B",IO,0))
 I 'X  D FLST S ^%ZISL(3.54,"B",IO,L)="",X=L
 I '($D(^%ZISL(3.54,+X,0))#2) S ^(0)=IO_"^"_%ZISRL,A=^%ZISL(3.54,0),$P(A,"^",3)=+X,$P(A,"^",4)=$P(A,"^",4)+1,^(0)=A,IO(1,IO)="RES",%ZISD0=+X G R1
 S %ZISD0=+X
 S X=$P(^(0),"^",2) I 'X S POP=1 W:'$D(IOP) *7,"  [NOT AVAILABLE]" L  Q
 S X=X-1,$P(^(0),"^",2)=X,IO(1,IO)="RES"
 ;
R1 ;
 ;S %ZISROOT="^%ZISL(3.54,"_%ZISD0_",1," S:'$D(^%ZISL(3.54,%ZISD0,1,0)) ^(0)="^3.542^^" D FLST S ^%ZISL(3.54,%ZISD0,1,"B",L,L)="",X=L
 S:'$D(^%ZISL(3.54,%ZISD0,1,0)) ^(0)="^3.542^^"
 ;D FLST 
 F L=1:1:(%ZISRL+1) I '$D(^%ZISL(3.54,%ZISD0,1,L,0)) Q
 I '$T,L=(%ZISRL+1) S POP=1 K IO(1,IO) Q
 S ^%ZISL(3.54,%ZISD0,1,"B",L,L)="",X=L
 S ^%ZISL(3.54,%ZISD0,1,+X,0)=+X_"^"_%ZISV_"^"_$J,A=^%ZISL(3.54,%ZISD0,1,0),$P(A,"^",3)=+X,$P(A,"^",4)=$P(A,"^",4)+1,^(0)=A
 L  Q
 ;
FLST S:'$D(^%ZISL(3.54,0)) ^(0)="RESOURCE^3.54^^" S X=$P(^(0),"^",3),A=X
 F I=+X:0 S I=+$O(^%ZISL(3.54,I)) Q:I'>0  S A=I
 S L=A+1 Q
NTRMS ;
