LRLABAR ;SLC/FHS - LABEL BAR CODE DOWN LOAD FORMAT
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;Format F3 is for the bar code label
 ;Format F2 is for the plain non bar coded label.
 ;Designed on a 8646 thermal transfer printer
 ;Charater set=USA,Batch=disable,self test=disable
 ;Baud=9600,parity=even,label stock=regular,control mode=computer
 ;Protocol Command=User interface,format Rotation=breech,right margin=diable
 ;bar width=10 mil  LABEL SIZE= 1X3 IN. Part No 049114
 ;top dip sw=all 5 off  :mid dip sw=1 on 2-7 off
 ;bottom dip sw 1-2 off,3-4 on,5 off,6 on,7-8 off
ZIS S %ZIS="QN" D ^%ZIS I POP W !?7,$C(7),"NO DEVICE SELECTED ",! G STOP
 S ZTIO=ION,ZTDTH=$H,ZTDESC="BAR CODE FORMATE DOWN LOAD",ZTRTN="BAR^LRLABAR" D ^%ZTLOAD Q
BAR ;FORMAT BAR CODE LABELS
 D RESET
L0 D ENQ U IO W *2,*27,"P",*3 S:$D(TEST) X="PROGRAM MODE" D:$D(TEST) SHOW D ENQ ;SET INTO PROGRAM MODE
L1 U IO W *2,"E3;F3;H0;o2,415;f1;c2;d0,50;h1;w1;",*3 S:$D(TEST) X="L1" D:$D(TEST) SHOW D ENQ ;BLANK
L2 U IO W *2,"F3;H1;o20,415;f1;c0;d0,50;h1;w1;",*3 S:$D(TEST) X="L2" D:$D(TEST) SHOW D ENQ ;TEST/LOCATION
L3 U IO W *2,"F3;H2;o33,415;f1;c0;d0,50;h1;w1;",*3 S:$D(TEST) X="L3" D:$D(TEST) SHOW D ENQ ;SSN
L4 U IO W *2,"F3;H3;o47,415;f1;c1;d0,50;h1;w1;",*3 S:$D(TEST) X="L4" D:$D(TEST) SHOW D ENQ ;PATIENTS NAME 
L5 U IO W *2,"F3;H4;o60,160;f2;c2;d0,50;h1;w2;",*3 S:$D(TEST) X="L5" D:$D(TEST) SHOW D ENQ ;ACCESSION NUMBER
L6 U IO W *2,"F3;B5;o60,415;f1;c0,1;h20;w1;i0;d0,20;p@",*3 S:$D(TEST) X="L6" D:$D(TEST) SHOW D ENQ ; BARCODE
 U IO(0) D PRT
PLAIN ;REGULAR LABELS NO BAR CODE
L01 D ENQ U IO W *2,*27,"P",*3 S:$D(TEST) X="FORMAT F2" D:$D(TEST) SHOW D ENQ ;SET INTO PROGRAM MODE
L11 U IO W *2,"E2;F2;H0;o2,415;f1;c2;d0,50;h1;w1;",*3 S:$D(TEST) X="L11" D:$D(TEST) SHOW D ENQ ;BLANK
L21 U IO W *2,"F2;H1;o20,415;f1;c0;d0,50;h1;w1;",*3 S:$D(TEST) X="L21" D:$D(TEST) SHOW D ENQ ;TEST/LOCATION
L31 U IO W *2,"F2;H2;o33,415;f1;c0;d0,50;h1;w1;",*3 S:$D(TEST) X="L31" D:$D(TEST) SHOW D ENQ ;SSN
L41 U IO W *2,"F2;H3;o47,415;f1;c1;d0,50;h1;w1;",*3 S:$D(TEST) X="L41" D:$D(TEST) SHOW D ENQ ;PATIENTS NAME
L61 U IO W *2,"F2;H4;o65,415;f1;c1;d0,50;h1;w1;",*3 S:$D(TEST) X="L61" D:$D(TEST) SHOW D ENQ ;TUBE VOL ORDER #
 D PRT
TEST ;
 S PNM="PATIENTS,NAME",SSN="123-34-1234",LRURG="ROUTINE",LRAN=50,LRINFW="SICK GUY",LRCE=1100,LRTXT="GLU,NA,CO2,CL,K",LRTOP="RED",LRACC="CH 0521 50",LRLLOC="SICU" D F3,F2
 Q
F3 D ENQ U IO W *2,*27,"E3",*24,PNM_"  "_$P(SSN,"-",3),!,LRINFW,!,LRTXT,!,LRACC_"   "_LRURG_"   "_LRLLOC,!,"CH",!,$E("00000",$L(LRAN),5)_LRAN,*30,1,*23,*3 D ENQ
 Q
F2 D ENQ U IO W *2,*27,"E2",*24,PNM_"  "_$P(SSN,"-",3),!,LRINFW,!,LRTXT,!,LRACC_"   "_LRURG_"   "_LRLLOC,!,"RED TOP ORD:#   RM/BED ",*30,1,*23,*3
LF D ENQ U IO W *2,*12,*3 Q
 Q
RESET D ENQ U IO W *2,*16,*16,*3,! H 5
ENQ U IO W *5 F  U IO R *X:1 D:$D(TEST) SHOW Q:X=-1!(X=7)!(X=18)!(X=80)!(X=31)!(X=25)!(X=68)
RD F  U IO R *X:1 D:$D(TEST) SHOW Q:X=-1
 Q
PRT D ENQ U IO W *2,"R",*3 D ENQ Q
SHOW Q:IO(0)=IO  U IO(0) W !,X
STOP Q  ;
