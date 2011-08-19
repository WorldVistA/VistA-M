SRORACE ;B'HAM ISC/ADM - PATIENT DEMOGRAPHIC INFO ; [ 04/05/04  9:47 AM ]
 ;;3.0; Surgery ;**125**;24 Jun 93
ENTH D DEM^VADPT
 ;Find patient's ethnicity and list it on the display
 W !," Ethnicity:" D
 .I $G(VADM(11)) W ?40,$P(VADM(11,1),U,2)
 .I '$G(VADM(11)) W ?40,"UNANSWERED"
 ;
 ;Find all race entries and place into a string with commas inbetween
 S SRORC=0,C=1,SRORACE="",SROLINE="",N=1,SROL=""
 F  S SRORC=$O(VADM(12,SRORC)) Q:SRORC=""  Q:C=11  D
 .I $G(VADM(12,SRORC)) S SRORACE(C)=$P(VADM(12,SRORC),U,2)
 .I SROLINE'="" S SROLINE=SROLINE_", "_SRORACE(C)
 .I SROLINE="" S SROLINE=SRORACE(C)
 .S C=C+1
 ;
 ;Find total length of 'race' string and wrap the text if necessary
 I $L(SROLINE)=40!$L(SROLINE)<40 S SROL(N)=SROLINE,SRNUM1=2
 I $L(SROLINE)>40 D WRAP
 ;
 W !," Race Category(ies):"
 I $G(VADM(12)) F D=1:1:SRNUM1-1 D
 .W:D=1 ?40,SROL(D)
 .W:D'=1 !,?40,SROL(D)
 ;
 I '$G(VADM(12)) W ?40,"UNANSWERED"
 ;
 K SROL,SROLINE,SRORC,SRORACE,SROLN,SROLN1,SROWRAP,SRNUM1
 Q
 ;
WRAP ;Wrap multiple race entries so that wrapped line
 ;does not break in the middle of a word
 ;
 S SROLNGTH=$L(SROLINE),E=40,SROWRAP="",SROLN="",SROLN1="",SROL=""
 F I=1:40:SROLNGTH S SROLN(I)=SROWRAP_$E(SROLINE,I,E) D
 .F K=40:-1:1 I $E(SROLN(I),K)[" " D  Q    ;Break lines at space
 ..S SROLN1(I)=$E(SROLN(I),1,K-1)
 ..S SROWRAP=$E(SROLN(I),K+1,E)
 .S E=E+40
 ;
 S:'$D(SROLN1(I)) SROLN1(I)=SROLN(I),SROWRAP=""
 I $L(SROLN1(I))+$L(SROWRAP)>39 S SROLN1(I+1)=SROWRAP   ;Last line 
 I $L(SROLN1(I))+$L(SROWRAP)'>39 S SROLN1(I)=SROLN1(I)_" "_SROWRAP
 ;
 ;Renumber the SROLN1 array to be in numeric order
 S SRNUM=0,SRNUM1=1
 F  S SRNUM=$O(SROLN1(SRNUM)) Q:SRNUM=""  D
 .S SROL(SRNUM1)=SROLN1(SRNUM)
 .S SRNUM1=SRNUM1+1
 Q
 ;
EXT I $L(SREXT)<40 W ?40,SREXT W:SRFLD=247 $S(SREXT="":"",SREXT=1:" Day",SREXT=0:" Days",SREXT>1:" Days",1:"") Q
 N I,J,X,Y S X=SREXT F  D  W:$L(X) ! I $L(X)<40!(X'[" ") W ?40,X Q
 .F I=0:1:38 S J=39-I,Y=$E(X,J) I Y=" " W ?40,$E(X,1,J-1) S X=$E(X,J+1,$L(X)) Q
 Q
