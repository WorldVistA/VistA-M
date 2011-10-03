LA7SBC ;DALISC/JMC - HP-PCL Compatible Barcode 128 Utility ; 12/3/1997
 ;;5.2;LAB MESSAGING;**27**;Sep 27, 1994
 ; Extensively borrowered from Douglas K. Martin, M.D.
 ;
BC128(D,O,H,XX,YY,W) ;
 ; Inputs:
 ;   D    = Data string to print in bar code
 ;   O    = Orientation of bar code
 ;          0=portrait (default)
 ;          1=landscape
 ;   H    = Height of bar code in dots (1/300 inch)
 ;   XX   = Horizontal position on page in dots
 ;   YY   = Vertical position on page in dots
 ;   W    = Width of bar in dots (3=default)
 ; Purpose:
 ;   Accepts a barcode 128 string and writes an HPCL-compatible
 ;   string that will display the barcode on an HP laser printer.
 ;   A barcode font cartridge is not required.
 ;   The current cursor position is stored upon entry and restored before exiting.
 N %,LA71,LA72,LA73,LA74,LA75,C,P,X
 S X=0 X ^%ZOSF("RM")
 S D=$$DATA(D)
 S C=$C(27)_"*c",P=$C(27)_"*p+"
 S W=$G(W,3),H=$G(H,60),O='$G(O)+1
 W $C(27),"&f0S" ;Push cursor position
 W:$G(XX) $C(27)_"*p"_+XX_"X"
 W:$G(YY) $C(27)_"*p"_+YY_"Y"
 W C_H_$E("BA",O)
 F %=1:1:$L(D) D
 . S LA71=$P($T(@$A(D,%)),";;",2),LA74=11,LA75=0
 . F LA72=1:1:$L(LA71) D
 . . S LA73=+$E(LA71,LA72),LA74=LA74-LA73,LA73=LA73*W
 . . Q:'LA73
 . . I LA72#2 W C_LA73_$E("ab",O)_"0P" S LA75=LA73
 . . E  W P_(LA73+LA75)_$E("XY",O) S LA75=0
 . S LA74=LA74*W+LA75
 . W:LA74>0 P_LA74_$E("XY",O)
 W $C(27),"&f1S" ;Pop cursor position
 Q ""
 ;
DATA(X) ;
 Q:X="" ""
 N CD,T,Y,LA71,LA72,T1
 S T=0,T=$$T(X),CD=T,Y=$C(T+8)
 F  Q:X=""  D
 . S T1=$$T(X)
 . I T1'=T D CD(6-T1) S T=T1
 . S LA71=$E(X,1,T=2+1),X=$E(X,T=2+2,255),LA72=$A(LA71)
 . I T=2 D CD($S(LA71>95:LA71-95,LA71:LA71+32,1:31))
 . E  D CD($S(LA72<32:LA72+96,LA72=32:31,1:LA72))
 S CD=CD#103,CD=$S('CD:31,CD>95:CD-95,1:CD+32)
 Q Y_$C(CD,11)
 ;
T(X) Q $S(X?2N.E:2,$A(X)<32:0,$A(X)>95:1,T=2:0,1:T)
 ;
CD(X) S CD=$S(X=31:0,X<11:X+95,1:X-32)*$L(Y)+$G(CD),Y=Y_$C(X)
 Q
 ;
1 ;;11431
2 ;;41111
3 ;;41131
4 ;;11314
5 ;;11413
6 ;;31114
7 ;;41113
8 ;;21141
9 ;;21121
10 ;;21123
11 ;;2331112
31 ;;21222
33 ;;22212
34 ;;22222
35 ;;12122
36 ;;12132
37 ;;13122
38 ;;12221
39 ;;12231
40 ;;13221
41 ;;22121
42 ;;22131
43 ;;23121
44 ;;11223
45 ;;12213
46 ;;12223
47 ;;11322
48 ;;12312
49 ;;12322
50 ;;22321
51 ;;22113
52 ;;22123
53 ;;21321
54 ;;22311
55 ;;31213
56 ;;31122
57 ;;32112
58 ;;32122
59 ;;31221
60 ;;32211
61 ;;32221
62 ;;21212
63 ;;21232
64 ;;23212
65 ;;11132
66 ;;13112
67 ;;13132
68 ;;11231
69 ;;13211
70 ;;13231
71 ;;21131
72 ;;23111
73 ;;23131
74 ;;11213
75 ;;11233
76 ;;13213
77 ;;11312
78 ;;11332
79 ;;13312
80 ;;31312
81 ;;21133
82 ;;23113
83 ;;21311
84 ;;21331
85 ;;21313
86 ;;31112
87 ;;31132
88 ;;33112
89 ;;31211
90 ;;31231
91 ;;33211
92 ;;31411
93 ;;22141
94 ;;43111
95 ;;11122
96 ;;11142
97 ;;12112
98 ;;12142
99 ;;14112
100 ;;14122
101 ;;11221
102 ;;11241
103 ;;12211
104 ;;12241
105 ;;14211
106 ;;14221
107 ;;24121
108 ;;22111
109 ;;41311
110 ;;24111
111 ;;13411
112 ;;11124
113 ;;12114
114 ;;12124
115 ;;11421
116 ;;12411
117 ;;12421
118 ;;41121
119 ;;42111
120 ;;42121
121 ;;21214
122 ;;21412
123 ;;41212
124 ;;11114
125 ;;11134
126 ;;13114
127 ;;11411
