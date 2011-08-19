PRCHHS ;ID/RSD-HASHING ROUTINE ;25SEP1987/7:54 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN1 Q:X=""  S PX=$E(X,1,20),PY=PX,X="",PL=$L(PX) F PI=1:1:PL S PY1=$E(PY),PZ=$A(PY1)#20+1,PY=$E(PY,2,20),PA(PI)=$S(PY[PY1:$P($T(Z+(PZ+PI#20+1)),";",3,9),1:$P($T(Z+PZ),";",3,9))
 F PZ=1:1 Q:$L(X)>19  D C S X=$S(PZ#2:PX_X,1:X_PX)
 S X=$E(X,1,20) G Q
EN2 Q:X=""  S PX=X,X="",PL=$L(PX) D CL S PR=DA*P#94,PY="" F PI=1:1:PL S PA(PI)=$E(PA(PI),PR,999)_$E(PA(PI),1,PR-1),PY1=$E(PA(PI),$A(PX,PI)#94+1),PY=PY_PY1
 S X=PY G Q
EN3 Q:X=""  S PX=X,X="",PL=$L(PX) D CL S PR=DA*P#94,PY="" F PI=1:1:PL S PA(PI)=$E(PA(PI),PR,999)_$E(PA(PI),1,PR-1),PY1=$F(PA(PI),$E(PX,PI))-2,PY1=$S(PY1<32:PY1+94,1:PY1),PY=PY_$C(PY1)
 S X=PY G Q
Q K PA,PI,PJ,PL,PR,PX,PY,PY1,PZ Q
C S PR=0 F PI=1:1:PL S PR=PR+$A(PX,PI)
 S PR=PR#94,PY=""
 F PI=1:1:PL S PJ=$F(PA(PI),$E(PX,PI))-1+PR\2,PA(PI)=$E(PA(PI),PJ,999)_$E(PA(PI),1,PJ-1),PY1=$E(PA(PI),$A(PX,PI)#94+1) S PY=PY_PY1
 S PX=PY Q
CL F PI=1:1:PL S PA(PI)=$P($T(Z+(DA+PI#20+1)),";",3,9)
 Q
Z ;;
 ;;e&Qu9l) Jjk|1O+NpA=3*Lbv[(XF,zZWHgi>S"UM;0@.dIon}4_Pw-8qyC?K/YV6t7sE]f~x'D`TB%R#a{\!G<2$h5rc:m
 ;;j<e$H,xKA9\; s>?%`51I=il_fQ)-tFWg@0D[T2{MZLb/o8y.Jp3Oh7w:knRmqV~Xu#E]GYC+'!rP(4|ScBU"Nv*}z&da6
 ;;(iLJ=!E'S<MRe&p.mjI\d`u9tzb1ZsHoTnY;av~%0O+hX,gx[?qCFA/:6{V7|y*f}]258)4GUNl-Q_@r#cPW>$w kB3D"K
 ;;,gkh4FDc$}K9n5YC#af;x3/Uty~_N@'rS[sz: dJ02b7|*p>`WlOm6qI1Q\Me&)i.ETGwH"RLVu{oBv=P?8+X-j%A!(<]Z
 ;;LM@\hGv]-3_41`'*y?UPwCZX% xIq{(fti)r9HSgRJb6cd|sz[>uKF}QpBl;~A2DVO=eY</Em&onT.j#+,058"a$k!WN:7
 ;;YZ 5b7/<9,`0:NyRaQlhv)X1Do6'({!mLjAtCO+nwd]z>}GUqT.K4ePp#;Msf"FHc8[J$I2%Sx-~3EurkgBV?\*iW|&_@=
 ;;Nn3IPmMy9*0"QW|'CfD&;}- (6Bv>kYgj_GJFE`q]!H27usXz5ZxR%p.Kh{)tUe:~=LV@/[Sw1<Ob$#,8daoT\4cri?Al+
 ;;g?)#=Kz'vnX_}+Fkea1<Z,SDh~ `Y62BHuN-JqO>5j(xsl3*!{G"T&M[/wW4PpiCLtUI9bm:r%fRV.@dQE0A]c\$o|y7;8
 ;;z `yWed0Ccm\jB#SgOfIJ&_(6s{K"@L);>P5<uYD2+nvVRb:'$?XNioqA17-rU=wFt*Gh[4QTZlp]~x%8,E.}|kMH9/!3a
 ;;%7xbs(Of1\C{.= Kt&vz8_`D;+BYc-GkQ"[gJd|]oInwyT'l>)e:XN3UVahiS0!9PqE$L?HA4,R/Mm2W~<*6pjrF#@uZ}5
 ;;;aewf6\W:mYiF.$"hR<XqE4_sdk-3T,yO#Ix}`r'n /C)tp9{=NBljLKgvuc[P&!>]VU~20zD+1A5H8%SGQ?@*(Zb|o7JM
 ;;k(]'x[m!8OPYLQosE tw{$HuZv"*Gh;7N2.D~Ji3<%e)@a0fBU&dCR1A+=Mn\p|jzTyK`#/S_br:-V>FI96,}cq4l5?WXg
 ;;cah`&z\*"GTeO=MFI~Z5vbu>m_9)C}6Ps73%x]w[?Xrf+QKRqWB|<4EY8DSn1kL oV-@2#lU(Jp,A{;0d/H$jg.Niy!:'t
 ;;Ps9>f0\caKwU]%*y}GH,m7QdhT&b1V~-L5Ogx|qju=$`32(.Win;#Aot4N!@'r/{Rk_<EC"B8l +6)YFz?ID:evMJ[SpZX
 ;;ybrENS<dP&]~2i8Ia'MjcKYu;:Rn=G/)t?1W+#%5Q|l(v6pFO`D@V,oCkgzX}LH-xZ\h3_$9.7f>Be!*sT w"UAJ4{q[0m
 ;;J+vbNR)h\XyOVZ@tE{QTM|]8;c?$PaBW:40,1dY%FG!L[i~D(A.2p=-S'&<sqImkU3n g/96z>Hx`C"fl5e#uw}Krj7_o*
 ;;W1)`Xt7D=9PaT*8<d+3/vIEQrcb-gBjYH]MSU#Nwis5.om_%Cu>}6~x{;|!FA\y ekKl,O&['?VG0:2@LZ$fJ4"zpnRq(h
 ;;Ho.?I]Eek<yL5v3$`c[x~74aYqnDuz1bp+\2smlVCQSP#G&j;X9r%g' w!|TKURJfF>=}:0@(8tW-Aid6h*{/,)ON_B"MZ
 ;;CnfO'Wb2+sd3a,6#k{&LU(".qMNG$A%mg:J?Dwc!x5XvS;yj4t<uP@h_KT98 }\H1ZQ-rFi|I)>zVEo*B~e]p0lRY[=/`7
 ;;7UvoK3Z%-y$2]s?}mBLQ!OVN'd58&+rk4;_ >u#/1PIt@<~x[G`WA"CMiq|pj=,:a)glXJn0RbwFfDz*e(\H9hc6.{TSYE
