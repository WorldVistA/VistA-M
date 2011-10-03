XTHCUTL ;ISF/RWF - HTTP 1.0 CLIENT Utilities ;11/10/09  15:12
 ;;7.3;TOOLKIT;**123**;;Build 4
 Q
 ;<LI>  <A HREF="#Payroll_&_Personnel" TITLE="Payroll & Personnel Links">Payroll &amp;  Personnel</A> </LI>
 ;
DECODE(STR) ;DeCode a string &#32=" ", &lt;=<, &gt;=>, &nbsp;=" "
 N I,J
 S I=0
 F  S I=$F(STR,"&",I) Q:'I  S J=$P($E(STR,I,I+5),";"),J=$$LOW^XLFSTR(J),K=$S(J="nbsp":" ",J="lt":"<",J="gt":">",J="amp":"&",J="apos":"'",J="quot":"""",$E(J)="#":$E(J,2,4),1:"") D:$L(K)
 . I +K S K=$C(+K) ;&#65; The decimal value in ISO-latin-1 for A
 . S STR=$E(STR,1,I-2)_K_$E(STR,I+$L(J)+1,$L(STR))
 Q STR
 ;
UNHEX(HH) ;function - decode one pair of hex digits to ASCII char
 S HH=$TR(HH,"abcdef","ABCDEF")
 I $TR(HH,"0123456789ABCDEF")'="" Q "???" ;-- error - bad hex code --;
 S HH=$TR(HH,"ABCDEF",":;<=>?")
 Q $C($$UNHEXD($E(HH,1))*16+$$UNHEXD($E(HH,2)))
 ;
UNHEXD(X) ;function - convert hex digit back to decimal
 Q $A(X)-48
 ;
QUOTE ;
 F I=I+1:1 S CH=$E(STR,I) Q:CH=""!(CH=Q)
 I $E(STR,I+1)=Q S I=I+1 G QUOTE
 Q
 ;
TEST ;Unit Tests
 S STR="[&#32;&lt;&amp;&quot;&apos;&gt;&nbsp;]&#109;" I $$DECODE(STR)'="[ <&""'> ]m" W !,"Fail: ",STR
 S STR="&#48;&#49;&#50;&#51;&#52;&#53;&#54;&#55;&#56;&#57;&#65;&#66;&#67;&#68;&#69;&#70;" I $$DECODE(STR)'="0123456789ABCDEF" W !,"Fail: ",STR
 Q
