RORUTL03 ;HOIFO/CRT,SG - ENCRYPTION/DECRYPTION ; 7/14/05 2:59pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** DECRYPTS THE STRING
DECRYPT(S) ;
 N ASSOCIX,ASSOCSTR,IDIX,IDSTR
 S ASSOCIX=$A($E(S,$L(S)))-31,IDIX=$A($E(S))-31
 S ASSOCSTR=$P($T(Z+ASSOCIX),";;",2,99)
 S IDSTR=$P($T(Z+IDIX),";;",2,99)
 Q $TR($E(S,2,$L(S)-1),ASSOCSTR,IDSTR)
 ;
 ;***** ENCRYPTS THE STRING
ENCRYPT(S) ;
 N %,ASSOCIX,ASSOCSTR,IDIX,IDSTR
 S ASSOCIX=$R(20)+1
 F  S IDIX=$R(20)+1  Q:ASSOCIX'=IDIX
 S ASSOCSTR=$P($T(Z+ASSOCIX),";;",2,99)
 S IDSTR=$P($T(Z+IDIX),";;",2,99)
 Q $C(IDIX+31)_$TR(S,IDSTR,ASSOCSTR)_$C(ASSOCIX+31)
 ;
 ;***** RETURNS DEFAULT SITE FOR HL7 MESSAGES
SITE(CS) ;
 N RORSITE,RORSTN  S:$G(CS)="" CS="^"
 S RORSITE=$$SITE^VASITE
 I RORSITE<0  D  Q ""
 . D ERROR^RORERR(-56,,,,RORSITE,"$$SITE^VASITE")
 S RORSTN=$E($P(RORSITE,"^",3),1,3)
 Q RORSTN_CS_$P(RORSITE,"^",2)_CS_"99VA4"
 ;
 ;***** XOR ENCRYPTION (from ICR v2.1)
XOR(X) ;
 N I,SUFFIX
 ;--- Separate digits and letters (the suffix)
 I X'?1N.N  D  S SUFFIX=$E(X,I,99),X=$E(X,1,I-1)
 . F I=1:1  Q:$E(X,I)'?1N
 ;--- Convert the numeric part to hexadecimal
 S X=$$CNV^XLFUTL(X,16)
 ;--- Perform XOR of each hexadecimal digit with '1101' (0xD)
 S X=$TR(X,"0123456789ABCDEF","DCFE98BA54761032")
 ;--- Pad with 0xD from the left so that the value will contain
 ;    no less that 9 hexadecimal digits, convert numeric part
 ;--- back to decimal and append the suffix (if available)
 Q $$DEC^XLFUTL($TR($J(X,9)," ","D"),16)_$G(SUFFIX)
 ;
 ;***** ENCODES THE SPECIAL CHARACTERS (&, <, ', and ")
 ;
 ; STR           Source string
 ;
XMLENC(STR) ;
 N CH,I,IC
 F I=1:1:5  S CH=$E("&<""'>",I),IC=1  D
 . F  S IC=$F(STR,CH,IC)  Q:IC'>0  D
 . . S $E(STR,IC-1,IC-1)=$P("&amp;^&lt;^&quot;^&apos;^&gt;","^",I)
 Q STR
 ;
 ;***** ENCRYPTION/DECRYPTION TABLE
Z ;;
 ;;ko-ZJtdG)49K{nX1BS$vH<:Myf*>Ae0!jQW=;#PwsO`E'%+rmb[gpqN,l6/hFC@DcUa ]zR}"ViIxu?872.(TYL5_3
 ;;`R;M/9BqAF%tSs#Vh)dO1DZP>r *fX'u[.4KlY=-mg_ci802N7LTG<]!CWo:3?{v+,5Q}(@jaExn$pIyHwzU"k6Jeb
 ;;ZJk"WQmCn!Y,y@1d+8s?[lNMxgHE(t=uwX:qSLjAI*}6zoF{T3#;cap)/h5%`P4$r]G'9e2if_>UDKb7V<v0- RBO.
 ;;dpjt3g4W)qD0VNJarseB "?OYhcu[<M%Z`RIL_6:]AX-zG.#}$@vk7/5x*m;(yb2Fn+l'PwUof1K{9,EQi>H=CT8S!
 ;;:1}K$byP;jk)7'`x90Bcq@iSsEnu,(Nl-hf.Y_?J#R]+voQXZU8mrV[!p4tgOWMez CAaGFD6H53%L/dT2<*>"{wI=
 ;;J<oZ9phXVNn)m K`t/SI%]A5qOWe?;jTM!fz1l>[D_0xR32ic*4.P"G{r7}E8wvUgyudF+6-:B=$(sCY,LkbHa#'@Q
 ;;X,'4Ty;[a8/{6lF_V"}qLI!@x(D7bRmUHh]W15J%N0BYPkrs9:$)Zj>uvzwQ=ieC-oGA.#?tfdcOM3gp`S+En K2*<
 ;;W5[];4'<C$/xrZ(k{>?ghBzIFN}fAK"#`p_T!qtD*1E37XGVs@0nmdjSe+Y6Qyo-aUu%i8c=H2vJ) R:MLb.9,wlOP
 ;;tjEM+!=xXb)7,ZV{*ci3"8@_l-HS69L>2]AUF/Q%:qD?1m(yvO0e'hT<#o$p4dnIzKP`NrkaGg.ufCRB[; sJYwW}5
 ;;/zl-9y:Pj=(R'7QJI *CTX"p0]_3.idcuOBefVU#omwNZ`$vFs?L+1Sk<5,b)hM4A6[Y%aDrg@KqEW8t>H};n!2xG{
 ;;0Bo@_HfnK>LR}qWXV+D6`Y28=4CmsG/7-5Ab9!a#rPF.lM$hc3ijQk;),TvzUd<[:I"u1'NZSOw]*gxtE{eJpy (?%
 ;;D}LJyGO8`$*ZqH .j>cMh<d=fimszv[#-53F!+a;NC'6T91IV?(0@x/{B)w"]QY,UWprk4:ol%g2nE7teRKbAPuS_X
 ;;Y#_0*H<B=Q+FML6]s;r2:e8R}[icKA 1w{)vV5d,.$u"xD/Pg?IyfthO@CzjWp%!`N4Z'3-(oJ9XUE7kTlqSb>anGm
 ;;1']_GU<X`NgM?LS9{"jT%s$}y[nvtlefB2RKJW(/cIxDCPow4,>#zm+:5b@06O3Ap8=V*7ZFY!H-uEQk;a .q)irhd
 ;;z7AG@QX."%3Lq>METUo{Pp_ a6<0dYVSv8:bI)W9NK`(r'4fswimkRe]C2hg=HOj$1B*/nxt,;cJ#y+![?lFuZ-5D}
 ;;Ge6F Hx>q$mC%MTn,:"o'tX/*yP.{lZ!YkiVhuw_<KE5aR[;}W0gjsz3]@7cI2QN?f#4pvbr1OUBD9)=-L(JA+d`S8
 ;;>ym};d)-7DZ"Fe/Y<B:xwojR,Vh]O0Sc[`$sg8GXE!I1Qrzp._W%TNKk(=J 3i*2abuHA4C'?MvPq{n#56LftUl@9+
 ;;)9 WidFN,1KsmwQ>GJM{I4:C%}#Ep(?HB/r;t.U8ol['Lg"2hRDyZ5`nbf]qjc0!zS-TkYO<_=76a*X@$Pe3+AxVvu
 ;;jf"5VdHc#uA,W1i+v'6@pr{n;DJ!8(btPGaQM.LT3oeg?NB/9>Z`-}02*%x<7Ylsqz4OS E$R]KI[:UwC_=h)kXmyF
 ;;ar.{YU7mBZR@-K2 "+`M%8sq4JhPo<_XSg3WC;Tuxz,fvEiQ1p9=w}FAIj/keD0c?)LN6OHV]lG:5y'$*>nd[(tb!#
