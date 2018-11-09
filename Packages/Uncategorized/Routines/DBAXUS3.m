XUSRB1 ;iscSF/RWF - More Request Broker ;6/8/04  16:41
 ;;8.0;KERNEL;**28,82,135,275**;Jul 10, 1995
 Q  ;No entry from top
 ;
DECRYP(S) ;decrypt passed string
 ;VYD 5/19/95
 N ASSOCIX,IDIX,ASSOCSTR,IDSTR
 Q:$L(S)'>2 "" ;Bad call
 S ASSOCIX=$A($E(S,$L(S)))-31           ;get associator string index
 S IDIX=$A($E(S))-31                    ;get identifier string index
 S ASSOCSTR=$P($T(Z+ASSOCIX),";",3,9)   ;get associator string
 S IDSTR=$P($T(Z+IDIX),";",3,9)         ;get identifier string
 Q $TR($E(S,2,$L(S)-1),ASSOCSTR,IDSTR)  ;translated result
 ;
ENCRYP(S) ;RWF 2/5/96
 N %,ASSOCIX,IDIX,ASSOCSTR,IDSTR
 S ASSOCIX=$R(20)+1                     ;get associator index
 F  S IDIX=$R(20)+1 Q:ASSOCIX'=IDIX     ;get different identifier index
 S ASSOCSTR=$P($T(Z+ASSOCIX),";",3,9)   ;get associator string
 S IDSTR=$P($T(Z+IDIX),";",3,9)         ;get identifier string
 ;translated result
 Q $C(IDIX+31)_$TR(S,IDSTR,ASSOCSTR)_$C(ASSOCIX+31)
 ;
SENDKEYS(RESULT) ;send encryption keys to the client
 ;VYD 5/19/95
 N %,X
 S %=1
 F  S X=$P($T(Z+%),";",3,9) Q:X=""  S RESULT(%)=X,%=%+1
 Q
 ;
BLDDRUM Q  ;don't run this tag
 N I,%,ALLCHARS,RNDMSTR,CHAR
 X "ZP Z"                      ;position insertion point
 F I=1:1:20 D
 . S ALLCHARS="" F %=32:1:126 S:$C(%)'="^" ALLCHARS=ALLCHARS_$C(%)
 . S RNDMSTR=""
 . F %=1:1:94 D
 . . S POS=$R($L(ALLCHARS))+1,CHAR=$E(ALLCHARS,POS)
 . . S RNDMSTR=RNDMSTR_CHAR
 . . S ALLCHARS=$P(ALLCHARS,CHAR,1)_$P(ALLCHARS,CHAR,2) ;compress by 1
 . X "ZI "" ;;""_RNDMSTR"      ;save random string in routine
 X "ZS"                        ;save routine
 Q
 ;
 ;
Z ;;
 ;;_8WuRYmVc>Aw)=9QlO4iZ1+p}|T&Mt?Ff6{3B$,C~ ]rU"h@7/52#`(gqGKIXne*a\<SP[JHj:Lb'od!E0y.v-;N%xkzsD
 ;;Z\m?OYu4iEUj,nqJox0fwQcA@|p16e<L&[7gRNG5M$'/IbWhFD(sTC+t=l%98_Vv;P`*~K{.:2k#>)Sz y"]}daH-3rBX!
 ;;y6+ g!H)c5EbfCR8><aQ~}K4/0;j2kF*t$wL7T#"JuZvGBMD,Psnd:Iq=i%.N1_V?OWShep\]'X@l|Uo9([&rm3`z-{YAx
 ;;(3<U[XaR#t:+mPqlnyK~db]AprGj{Qgez?CLWD$.`59|icFI_"S*%2v16; 8h!MuV/),wH4ZkOJsxE@-=TNf0o>\}B&'7Y
 ;;k#(3oJPc7-j_qHeaY?U\x{Wv~<l5=,%'tm`1";fKdD6E/VMu>NZr0]wnGFOR8pB)h&9g i[|bST!yQ.CX+*zA}L2s4:$@I
 ;;v6?r}Ecx+`)Nq:MB-I*[Tm<DznL4~SgY8PWe5Jwt"\QV_y/uGK$F(,OZUd.j@i#&3{sl=H|ka>;1f %C2oAb]7'0X!Rhp9
 ;;jvaV#h;Zl'>$eXA-3rG2oKnOJ_uc\tPD8wS)}Tb7[M!p/~"+{f5s.k&UFQ61%?:*dz(@ BNW09|yi<E4mI`,CYg]HLqxR=
 ;;NT9dw$#YP@'.Cc=8?|<Z[+]Db-1v/yk;VJ>W:AXs0~(,{jt`R2xoM7&3zneq4IBF!_a\" pg*Sr%Ef)}56QulmOhLKUiHG
 ;;'=swo71,.(/FCK;g86LnO dckWiE4M|$#"tA`~mjY?z[\H{eN%B_2TZr+bxXPq@]3<U*S}V)&QIJ!hu95pD:aRlf>Gv-y0
 ;;TK_;%?>HRk',dz.cG3r!1l0I8oL~7[(D-An=*a$E:W6xYSq+)/h"UQeP2JZi@9XuNgm`4FV<M#CB]Oyfjv} bp|{5\w&st
 ;;)~s4n}qUev&!TD(AZk{`H|GV_@dl28bfYI$<F=:W]M3j"m#;6\u17Ea5-.t%9*rL oySNKJCz,>c+0/XiQPx[Rg'B?pwhO
 ;;jQI0sqKn"v3Ga1~SRzo/.Z6}lputW#$45 &,-hm@bd<:V])*iA9eL!Dyw|NX;(?BU+C'8crE`kFMT>PY{g\72H[OxJ%=f_
 ;;+5OF,|9!EQB7okb>6jpHAtq?ZnvsNrLI#`3\K$G;i(xPR=1]wc0}d.u%&:"agD-VW8mMT*_yz)[~lS@<{X4h2YJ'/CfeU
 ;;( :Uto7TH4'fPx|9BI}RV,*;u{z=p%1CwA6@EW_X])lZkm5ybeNhq>OG+3Jv`"iKF<DY&0!r[SMd/Q\$c?ja-~2#Lg8s.n
 ;;<pBn%i*c>u]@y_WIYP7+[3:}Z2 |V-0rdUHst`&6A,$g1FzQGlxoE)NvbKMJR=/qfwhS#m\(eX;.T'C9ak?{84L5~D!Oj"
 ;;8?xq}AW4*=wMF]e`E!C<DU7_{9Y"iHm'B|S;3f@nr/.I-j\gV$b J(Nl,k~uQRZOLsGv5ot>%1[)Xc0y+aPTh&6:2zKdp#
 ;;8IJZ:1~vFx7db\ CX4DRki{Y*N3u'#@UwW5/=0>tL-fqVa;jHns2,Or.EeA)|69p!%o[$yS<cGg+M"]K?`P(m&_}hTQBzl
 ;;*eGQ75o8n)h+Jm;j.@2Vs(l&T!ca3DAb-LP<,r=~qti}MfB4YR\]S>$ HO_9kF{U[Ipw:dvyN|%1g'#XK?6`/C"xZ0uEzW
 ;;/%[}6GC I=v5~Ud&`|y.TY,uqi*?W"s)9l1ne\<4mo+atb>(wB37Ef;LKZ8D$M:kXrNA!Qpz{FgSc#@'xVOh2]_JP-jHR0
 ;;.7[wIf4O#KJ)AgjBNd|<0qQhuXoma&=x36r5iG~F;>yD%E*(PkU]R C'n/2S-Vl?Y_"{:Hz,e!v+Zb\9MsWT$`pt18@Lc}
