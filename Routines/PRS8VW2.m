PRS8VW2 ;WCIOFO/JAH - DECOMPOSITION, VIEW RESULTS ;01/11/08
 ;;4.0;PAID;**6,32,34,45,69,112,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; 
 ; This routine is used to show the results of the decomp to
 ; the supervisor before certification.  It takes the values
 ; in the 8B string (NEW) and prints each type of time with the
 ; amount in a more readable format (ie - value in 8B = OE163,
 ; would print -->    Week 1    Overtime    16.75
 ; Called from CERT+18^PRS8VW, a continuation from that entry point.
 ;
 S CHECK=0
 ;
EN ;
 S E=E(1),W="Week 1",LOC=1 D SHOW
 S E=E(2),W="Week 2",LOC=2 D SHOW
 S E=E(3),W="Misc",LOC=0 D SHOW
 I 'CHECK,"C"'[$E(IOST) D
 .W !,DASH1
 .W !,TR
 K %,CHECK,D,E,I,L,LOC,USED,W,X,Y Q
 ;
SHOW ; --- show information
 F I=1:2 S X=$E(E,I,I+1) Q:X=""  D
 .I $D(USED(X)) Q
 .S USED(X)=""
 .S X(1)=$F(NEW,X)
 .I 'CHECK,'X(1) Q  ;not in string
 .I CHECK S LOC(1)=(I\2+1) S:'LOC LOC(1)=LOC(1)+50 D
 ..S FOUND(LOC(1))=$G(FOUND(LOC(1)))
 ..S $P(FOUND(LOC(1)),"^",$S(LOC<2:1,1:4))=X
 .;
 .;read from tables below
 .;
 .S Y=$P($T(@$E(X)),";;",2)
 .S Y(1)=$F(Y,$E(X,2)_":")
 .S Y=$P($E(Y,Y(1),999),":",1,2)
 .I 'CHECK W !,W,?15,$P($T(TYP+Y),";;",2)
 .S X=X(1),X1=52 D CON
 Q
 ;
CON ; --- convert to proper format
 I '+X S X=$E("00000000000",1,+$P(Y,":",2))
 I X,X1=52 S (X,Z)=$E(NEW,X(1),X(1)+$P(Y,":",2)-1)
 I I=73!(W="Misc"&(I=13)) S R=X/100 W ?50,$J(R,6,2) Q
 I W="Misc",I=3 S X=X*10
 S R=$E(X,1,$L(X)-1)_$S($E(X,$L(X))=3:".75",$E(X,$L(X))=2:".5",$E(X,$L(X))=1:".25",1:"") W ?50,$J(R,6,2) Q
 Q
 ;
 ; This internal table stores types of time codes and their
 ; corresponding descriptions and TT8B value field lengths. Each
 ; single char line label below is the 1st char of a type of time code.
 ; The text on the corresponding line contains '^' delimited
 ; pieces.  The 1st char of those pieces is the 2nd char of a type of
 ; time.  The text description for that time code is given by the
 ; the number in the 2nd ':' delimited piece.  That number indicates
 ; the line number below the label TYP in routine PRS8VW2.  The 3rd
 ; ':' delimited piece is the length of the time code's value in the
 ; TT8B String.
 ;
A ;;N:1:3^U:5:3^L:1:3^B:5:3^D:63:3^F:63:3
C ;;E:7:3^U:8:3^T:7:3^O:8:3^L:34:4^A:55:4^Y:57:3^D:60:6^F:70:3^G:70:3^H:71:3^I:71:3^P:72:3^Q:72:3^R:73:3^S:73:3
D ;;A:16:3^B:17:3^C:18:3^E:16:3^F:17:3^G:18:3^W:45:2^T:48:6
E ;;A:38:5^B:40:5^C:38:5^D:40:5
F ;;F:59:4^A:61:3^B:61:3^C:62:3^D:62:3^E:64:6
H ;;A:29:3^B:30:3^C:31:3^L:29:3^M:30:3^N:31:3^D:36:3^O:36:3
I ;;N:46:1
L ;;U:48:4^N:49:4^D:50:4^A:53:1
M ;;L:54:4
N ;;O:4:3^A:10:3^B:11:3^P:4:3^R:10:3^S:11:3^L:44:2^T:65:3^H:65:3^D:69:3^U:69:3
O ;;A:20:3^B:21:3^C:22:3^K:24:3^M:25:3^N:34:4^E:20:3^F:21:3^G:22:3^S:24:3^U:25:3
P ;;T:32:3^A:33:3^H:32:3^B:33:3^C:56:2
R ;;T:6:3^A:26:3^B:27:3^C:28:3^L:6:3^E:26:3^F:27:3^G:28:3^R:58:1^S:66:3^N:66:3
S ;;K:2:3^P:12:3^A:13:3^B:14:3^C:15:3^L:2:3^Q:12:3^E:13:3^F:14:3^G:15:3^R:67:3^S:67:3^D:68:3^H:68:3
T ;;F:19:3^A:42:3^C:43:3^G:19:3^B:42:3^D:43:3^L:47:3^O:52:1
U ;;N:9:3^S:9:3
V ;;C:37:6^S:37:6
W ;;D:3:3^P:3:3
Y ;;A:23:3^D:35:4^E:23:3^H:35:4
 ;
TYP ; literal values of activities (actual name)
 ;;Annual Leave
 ;;Sick Leave
 ;;Leave Without Pay
 ;;Non-Pay Time
 ;;Authorized Absence
 ;;Restored Annual Leave
 ;;Comp Time Earned
 ;;Comp Time Used
 ;;Unscheduled Regular
 ;;Night Differential-2
 ;;Night Differential-3
 ;;Saturday Premium
 ;;Sunday Premium-D
 ;;Sunday Premium-2
 ;;Sunday Premium-3
 ;;Overtime Hrs > 8 Day-D
 ;;Overtime Hrs > 8 Day-2
 ;;Overtime Hrs > 8 Day-3
 ;;Travel OT-FLSA
 ;;Overtime Total Hours-D
 ;;Overtime Total Hours-2
 ;;Overtime Total Hours-3
 ;;Scheduled Call-Back OT
 ;;Overtime on Holiday
 ;;Sleep Time
 ;;Reg Hrs @ Overtime Rate-D
 ;;Reg Hrs @ Overtime Rate-2
 ;;Reg Hrs @ Overtime Rate-3
 ;;Holiday Hours-D
 ;;Holiday Hours-2
 ;;Holiday Hours-3
 ;;Part Time Hours
 ;;Continuation of Pay
 ;;Standby Hours
 ;;On-Call Hours
 ;;Pieceworker Holiday Excused
 ;;VCS Sales
 ;;Environmental Differential
 ;;
 ;;Hazardous Duty Pay
 ;;
 ;;Travel
 ;;Training
 ;;Non-Pay Annual Leave
 ;;Days Worked
 ;;Insurance
 ;;T&L Change
 ;;Lump Sum Units-D
 ;;Lump Sum Units-2
 ;;Lump Sum Units-3
 ;;Lump Sum Expiration Date
 ;;Optional Withholding Tax
 ;;Foreign Cola
 ;;Military Leave
 ;;Calendar Year Adjustment
 ;;Workers Compensation
 ;;SF 2806 Adjustment
 ;;Payment Record Requested
 ;;Fire Fighter Normal Hours
 ;;Control Data
 ;;Care and Bereavement
 ;;Adoption
 ;;Donor Leave
 ;;Fee Basis
 ;;Base Tour Non Pay Hours
 ;;Recess
 ;;Saturday Premium-AWS
 ;;Sunday Premium-AWS
 ;;Night Differential-AWS
 ;;Comp Time for Travel Earned
 ;;Comp Time for Travel Used
 ;;Credit Hours Earned
 ;;Credit Hours Used
