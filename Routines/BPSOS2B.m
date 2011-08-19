BPSOS2B ;BHAM ISC/FCS/DRS/DLF - BPSOS2 continuation ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
VALUES ;EP - from BPSOS2
 ; note!  This must correspond with the LABELS code in BPSOS2C
 N I,R,C,X,X2,X3
 ;
 ; Display In Progress Stats
 S R=1,C=29
 F I=0,10,30,40,50,60,70,90 D
 . S R=R+1,X=+$G(CHG("STAT",I)),X2=0,X3=3 D COM
 ;
 ; Display Completed Stats
 S R=1,C=65
 F I=203,202,208,204,205,206,207,201 D
 . S R=R+1,X=+$G(CHG("COMM",I)),X2=0,X3=7 D COM
 Q
 ;
COM ; Copied from COMMA^%DTC with NEWs added
 ; Input X=value to format
 ;       X2=# decimal digits opt. followed by "$"
 ;       X3=len of desired output
 N %,D,L
 I $D(X3) S X3=X3+1 ; make room for the trailing space we'll get rid of
 S D=X<0 S:D X=-X S %=$S($D(X2):+X2,1:2),X=$J(X,1,%),%=$L(X)-3-$E(23456789,%),L=$S($D(X3):X3,1:12)
 F %=%:-3 Q:$E(X,%)=""  S X=$E(X,1,%)_","_$E(X,%+1,99)
 S:$D(X2) X=$E("$",X2["$")_X S X=$J($E("(",D)_X_$E(" )",D+1),L)
 I $E(X,$L(X))=" " S X=$E(X,1,$L(X)-1)
 ;
 ; given R=row,C=col,X=string
 D SET^VALM10(R,$$SETSTR^VALM1(X,$G(@VALMAR@(R,0)),C,$L(X)))
 I $$VISIBLE(R) D WRITE^VALM10(R)
 Q
 ;
VISIBLE(R) ;EP -
 I $G(NODISPLY) Q 0
 I '$G(VALMBG) Q 0
 I R<VALMBG Q 0
 I R>(VALMBG+(18-3)) Q 0
 Q 1
