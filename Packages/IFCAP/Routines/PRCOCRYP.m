PRCOCRYP ;(WASH CIOFO)/LKG- ENCODE/DECODE FIELD IN PHA ;4/28/97  10:41
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ENCODE(X,X1) ; Encode
 ;X is the input string to be encoded
 ;X1 is the document number
 ;Returns encoded string
 N PA,PI,PL,PY,PY1
 I $G(X)=""!($G(X1)="") S PY="" G ENX
 I X["^"!(X["|")!(X["~")!(X["$") S PY="" G ENX
 S PL=$L(X) D CL S PY=""
 F PI=1:1:PL S PY1=$E(PA(PI),$A(X,PI)-31),PY=PY_PY1
ENX Q PY
 ;
DECODE(X,X1) ; Decode
 ;X is the encoded input string
 ;X1 is the document number
 ;Returns decode string
 N PA,PI,PL,PY,PY1
 I $G(X)=""!($G(X1)="") S PY="" G DEX
 S PL=$L(X) D CL S PY=""
 F PI=1:1:PL S PY1=$F(PA(PI),$E(X,PI))+30,PY=PY_$C(PY1)
DEX Q PY
 ;
CL F PI=1:1:PL S PA(PI)=$P($T(Z+(X1+PI#20+1)),";",3,9)
 Q
Z ;;
 ;;e&Qu|l) Jjk1O+NpA=3*Lbv[(XF,zZWHgi>S"UM;0@.dIon}4_Pw-8qyC?K/YV|6t7sE]fx'D`TB%R#a{\!G<29h5rc:|m|
 ;;j<eH|,xKA9\; s>?%`51I=il_fQ)-tFWg@0D[T2{MZLb/o8y.Jp3Oh7w:knRmq|VXu#E]GYC+'!rP(4ScBU"Nv*}z&da|6|
 ;;(iLJ|!E'S<MRe&p.mjI\d`u9tzb1ZsHoTnY;av%0O+hX,gx[?qCFA/:6{V7y*f|}]258)4GUNl-Q_@r#cPW>=w kB3D"|K|
 ;;,gkh|FDc4}K9n5YC#af;x3/Uty_N@'rS[sz: dJ02b7*p>`WlOm6qI1Q\Me&)i|.ETGwH"RLVu{oBv=P?8+X-j%A!(<]|Z|
 ;;LM@\|Gv]-3_41`'*y?UPwCZX% xIq{(fti)r9HSgRJb6cdsz[>uKF}QpBl;A2D|VO=eY</Em&onT.j#+,058"ahk!WN:|7|
 ;;YZ 5|7/<9,`0:NyRaQlhv)X1Do6'({!mLjAtCO+nwd]z>}GUqT.K4ePp#;Msf"|FHc8[JbI2%Sx-3EurkgBV?\*iW&_@|=|
 ;;Nn3I|mMy9*0"QW'CfD&;}- (6Bv>kYgj_GJFE`q]!H27usXz5ZxR%p.Kh{)tUe|:=LV@/[Sw1<ObP#,8daoT\4cri?Al|+|
 ;;g?)#|Kz'vnX_}+Fkea1<Z,SDh `Y62BHuN-JqO>5j(xsl3*!{G"T&M[/wW4Ppi|CLtUI9bm:r%fRV.@dQE0A]c\=oy7;|8|
 ;;z `y|ed0Ccm\jB#SgOfIJ&_(6s{K"@L);>P5<uYD2+nvVRb:'W?XNioqA17-rU|=wFt*Gh[4QTZlp]x%8,E.}kMH9/!3|a|
 ;;%7xb|(Of1\C{.= Kt&vz8_`D;+BYc-GkQ"[gJd]oInwyT'l>)e:XN3UVahiS0!|9PqEsL?HA4,R/Mm2W<*6pjrF#@uZ}|5|
 ;;;aew|6\W:mYiF.f"hR<XqE4_sdk-3T,yO#Ix}`r'n /C)tp9{=NBljLKgvuc[P|&!>]VU20zD+1A5H8%SGQ?@*(Zbo7J|M|
 ;;k(]'|[m!8OPYLQosE tw{xHuZv"*Gh;7N2.DJi3<%e)@a0fBU&dCR1A+=Mn\pj|zTyK`#/S_br:-V>FI96,}cq4l5?WX|g|
 ;;cah`|z\*"GTeO=MFIZ5vbu>m_9)C}6Ps73%x]w[?Xrf+QKRqWB<4EY8DSn1kL |oV-@2#lU(Jp,A{;0d/H&jg.Niy!:'|t|
 ;;Ps9>|0\caKwU]%*y}GH,m7QdhT&b1V-L5Ogxqju=f`32(.Win;#Aot4N!@'r/{|Rk_<EC"B8l +6)YFz?ID:evMJ[SpZ|X|
 ;;ybrE|S<dP&]2i8Ia'MjcKYu;:Rn=G/)t?1W+#%5Ql(v6pFO`D@V,oCkgzX}LH-|xZ\h3_N9.7f>Be!*sT w"UAJ4{q[0|m|
 ;;J+vb|R)h\XyOVZ@tE{QTM]8;c?NPaBW:40,1dY%FG!L[iD(A.2p=-S'&<sqImk|U3n g/96z>Hx`C"fl5e#uw}Krj7_o|*|
 ;;W1)`|t7D=9PaT*8<d+3/vIEQrcb-gBjYH]MSU#Nwis5.om_%Cu>}6x{;!FA\y |ekKl,O&['?VG0:2@LZXfJ4"zpnRq(|h|
 ;;Ho.?|]Eek<yL5v3I`c[x74aYqnDuz1bp+\2smlVCQSP#G&j;X9r%g' w!TKURJ|fF>=}:0@(8tW-Aid6h*{/,)ON_B"M|Z|
 ;;CnfO|Wb2+sd3a,6#k{&LU(".qMNG'A%mg:J?Dwc!x5XvS;yj4t<uP@h_KT98 }|\H1ZQ-rFiI)>zVEo*Be]p0lRY[=/`|7|
 ;;7Uvo|3Z%-yK2]s?}mBLQ!OVN'd58&+rk4;_ >u#/1PIt@<x[G`WA"CMiqpj=,:|a)glXJn0RbwFfDz*e(\H9hc6.{TSY|E|
