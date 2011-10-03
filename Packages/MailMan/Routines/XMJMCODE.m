XMJMCODE ;ISC-SF/GMB-Message En/Decryption ;08/24/2001  10:56
 ;;8.0;MailMan;;Jun 28, 2002
 ; Replaces ^XME,^XME1 (ISC-WASH/CAP/THM)
ENCMSG(XMZ) ; Encode a message
 N I
 W:$G(XMIA) !,$$EZBLD^DIALOG(34615) ; Scrambling...
 S I=.999999
 F  S I=$O(^XMB(3.9,XMZ,2,I)) Q:I'>0  S ^(0)=$$ENCSTR(^XMB(3.9,XMZ,2,I,0))
 Q
ENCSTR(XMCLEAR) ; Encode a string
 N I,XMCODED
 S XMCODED=""
 F I=1:1:$L(XMCLEAR) S XMCODED=XMCODED_$C($F(XMSECURE(I#XMSECURE+1),$E(XMCLEAR,I))+30)
 Q XMCODED
DECMSG(XMZ) ; Decode a message
 N I
 W:$G(XMIA) !,$$EZBLD^DIALOG(34616) ; UnScrambling...
 S I=.999999
 F  S I=$O(^XMB(3.9,XMZ,2,I)) Q:I'>0  S ^(0)=$$DECSTR(^XMB(3.9,XMZ,2,I,0))
 Q
DECSTR(XMCODED) ; Decode a string
 N I,XMCLEAR
 S XMCLEAR=""
 F I=1:1:$L(XMCODED) S XMCLEAR=XMCLEAR_$E(XMSECURE(I#XMSECURE+1),$A(XMCODED,I)-31)
 Q XMCLEAR
CRE8KEY(XMKEY,XMHINT,XMABORT) ;
 D ASKKEY(.XMKEY,.XMABORT) Q:XMABORT
 N DIR,X,Y
 S DIR(0)="3.9,1.8"
 S DIR("A")=$$EZBLD^DIALOG(34617) ; Enter Scramble Hint
 D ^DIR I $D(DUOUT)!$D(DTOUT) S XMABORT=1 Q
 S XMHINT=Y
 Q
KEYOK(XMZ,XMHINT) ; Ask user for key and make sure it's right
 N XMKEY,XMTRY,XMOK,XMABORT
 U IO(0)
 W !!,$$EZBLD^DIALOG(34624) ; This message has been secured with a password:
 D NOGOID^XMJMP2(XMZ,$G(^XMB(3.9,XMZ,0)))
 I " "[XMHINT D
 . W !,$$EZBLD^DIALOG(34620.1) ; There is no scramble hint.
 E  D
 . ; The scramble hint is: '_XMHINT_'
 . W !,$$EZBLD^DIALOG(34620,XMHINT)
 S (XMOK,XMABORT)=0
 F XMTRY=1:1:3 D  Q:XMOK!XMABORT
 . D ASKKEY(.XMKEY,.XMABORT) Q:XMABORT
 . I $$GOODKEY(XMZ,XMKEY) S XMOK=1 Q
 . W $C(7),$$EZBLD^DIALOG(34621,XMTRY) ; "   Not the proper password.  Strike _XMTRY_.
 I 'XMOK,'XMABORT W $$EZBLD^DIALOG(34622) ; "  Yer out!
 I 'XMOK!XMABORT K XMSECURE
 Q 'XMABORT&XMOK
ASKKEY(XMKEY,XMABORT) ;
 F  D  Q:XMKEY'="?"!XMABORT
 . W !,$$EZBLD^DIALOG(34618) ; "Enter Scramble Password: "
 . X ^%ZOSF("EOFF") R XMKEY:15 S:'$T XMKEY=U X ^%ZOSF("EON") U IO
 . I XMKEY[U S XMABORT=1 Q
 . I $L(XMKEY)>2,$L(XMKEY)<21 S XMKEY=$$UP^XLFSTR(XMKEY) Q:$L(XMKEY)+1'=$L(XMKEY,$E(XMKEY))
 . S XMKEY="?"
 . ;The scramble password is a secret code which must be entered by the
 . ;reader in order to see the message.  Upper and lower case characters
 . ;are treated the same.  (The password is not case sensitive.)
 . ;The password must be from 3 to 20 characters long, and may not be
 . ;just one repeating character.
 . W !
 . D BLD^DIALOG(34619,"","","XMTEXT","F")
 . D MSG^DIALOG("WH","","","","XMTEXT")
 . W !
 Q
GOODKEY(XMZ,XMKEY) ; Function checks key and make sure it's right.
 ; If it is, XMSECURE is defined, and function returns 1;
 ; Else XMSECURE is not defined, and function returns 0
 D LOADCODE
 D ADJUST(.XMKEY)
 I $$ENCSTR(XMKEY)=$E($G(^XMB(3.9,XMZ,"K")),2,99) Q 1
 K XMSECURE
 Q 0
ADJUST(XMKEY) ; Capitalize the key, pad the key, & adjust cylinder with key
 N I,J,XMRW
 S:XMKEY?.E1L.E XMKEY=$$UP^XLFSTR(XMKEY)
 F  Q:$L(XMKEY)>XMSECURE  S XMKEY=XMKEY_XMKEY
 S XMKEY=$E(XMKEY,1,XMSECURE)
 S XMRW=0
 F I=1:1:XMSECURE S XMRW=XMRW+$A(XMKEY,I)
 S XMRW=XMRW#96
 S:$G(XMPAKMAN) XMPAKMAN("XMRW")=XMRW
 F I=1:1:XMSECURE D
 . S J=$F(XMSECURE(I),$E(XMKEY,I))-1+XMRW#40
 . S XMSECURE(I)=$E(XMSECURE(I),J,999)_$E(XMSECURE(I),1,J-1)
 Q
LOADCODE ; Load Bazeries Cylinder
 N XMLINE,I
 F I=1:1 S XMLINE=$P($T(Z+I),";",3,9) Q:XMLINE=""  S XMSECURE(I)=XMLINE
 S XMSECURE=I-1
 Q
Z ;;
 ;;j+?F}hmi<Q#uZ|]Jdgwb'52NBr,fP6&:{s./*E(4an)A-Y 7cKMt[Ce;OGD=op"~UL0Xy89x%1lv!VH@\>_R3zkTS$`WI^q
 ;;~7C|(lbZo5f&mz3*}E{ `eVtGSMN"I>WBy48K/THiu^[1Fcaqp,_L=h.j]X<AP?O$@YQ\d!rU9;:D)2gk+n%J-wR6vs'0x#
 ;;j+?F}hmi<Q#uZ|]Jdgwb'52NBr,fP6&:{s./*E(4an)A-Y 7cKMt[Ce;OGD=op"~UL0Xy89x%1lv!VH@\>_R3zkTS$`WI^q
 ;;:eR^K{=o1$+VM3qd@h8ks<W;Hzpu-wbrmTNix?7GYQSlv'*~(4a".c}g[E|%>9O#/0JIF\yj2!Ptn)_D B]C6A&`ZfX,U5L
 ;;CNl<v_F8sDZfGmUy&ui'%T:+z]$>OVxMw)^n.6d *ge;oY(kjHq,[QE-|WRh2~SP1/}aBLK"3J45t{cbpr09A`!7XI#?=@\
 ;;~7C|(lbZo5f&mz3*}E{ `eVtGSMN"I>WBy48K/THiu^[1Fcaqp,_L=h.j]X<AP?O$@YQ\d!rU9;:D)2gk+n%J-wR6vs'0x#
 ;;q^,M?Q$+E%:ICN"PxdHc3w_~k[-m.s/}u|5 zOh4'8#;v!`FeSV7t(2U]fJlpTa&D=96@\n>ZGiRKAX)1jr0bLBgYy*<o{W
 ;;`kC4xY$)*8-1o3NXJ.2 ;n0bK|=?d}g{HQUmsShGc[Ai<l>#F5Iqf9BMRpu~V&Z/a:!7TLtz6Ery,wePjD+v(_%^"O'@W\]
 ;; 6[2F5ETNc/mjglK0bZ<CHvp-)~IV%,=}79Y:i+r(yeGD;zJ"4'qd.sh?*on#&kM3XfA\!_S]BWLQO@U8RtP$`^|u>wx{1a
 ;;$7q_@*0u<\E~t(zW/QbT,3yR>v?}U1D^4:J|h{"nerGxsPH[ C'K8I2g)Ya&oZ#9dSi.kNjfB6A!`XF]l+-wpm=cMO;5L%V
 ;;fk&A^NROib:7sa>JIyo'Z;]H-)qx/dDX9FgwL8|01@r.pSQ6~432_5"}?<EC+UzntWG=,Vm*jK\#h!`M TcB{YvPeu(%l$[
 ;;(wFr,+[Lylm=RPJ:9DI)|_UNMT~;K/{8k6-% vzBj7q3'x\"ZgE*dHus#V4Ytpc!GCb1O0@WQah}25o&`$eS>fn<.Xi^?]A
 ;;`B8Fr{$hy]L,NeKXtc'asxbp*@nA~PiVQ -OoJ)R;/v_9}(?|UD<lMIz%\Y6Sw2C4=g&7u":+d!E#T.5k[j^1GHmZ0f>3qW
 ;;ex3:uFt*+L-hR$Mp4(<Y[ryl\~TK>1"'Pi7Nd}G5#/2WXInQ9|j{. 6!SJ0Oz8V%wA_D@Uvac=g,o;Hk?mb]EBq&f^`C)sZ
 ;;kO;/"1r?[x#EloIz.<Vpb|8WL{K&a%:tny}`Quv5h-m2U0>9M]j)fNX7S@PYD$='T_Cg!JAq+H^FGs(i,6ce Bwd*~RZ\43
 ;;(r{dz)P5F1H'a=sm^g"Eu-%7&\.UJxy<h q?vw*o+#2TV}W|L0QI9iXtOB:Y]e3>4$`p6fnj8cSM;Kb_Z[GC/A!@NlDkR~,
 ;;Z#;Fr|WdD\5=U{kf`XR0w~[A&L>}p"!mIMY4t2q8)1gx^hi K.Vco<7TJ3/*@QO(-SvB:y6N$a_bGj'Heu]l+%zsn9?P,EC
 ;;M|.y]37'\p6{UAz^fm4Ik"9c&gn;D#le+=VB*J8bG%Z2hQtu_>,~vW/}ji:X`NY0[w5rHq)O- LSo?a!T1KE@P<FxsR$C(d
 ;;|Qv<[=NC#}!zO$GtF/,KjU;W6S9rV+%@'-:R3e&D7TBq8(o.?k"g>L_Z)2*Pyx{X05diHaphb41fM]Im`\lYAncs~EwJ^ u
 ;;B*6IQt9jf|YH7%gdi<cO3\mN5{&'Uv1/^Gl0V)w>`z@#A4_To b]DnJx$Zyk+Ku8pCrPRSq!?:MaEs[,-=L2WFeX~;h(}."
 ;;
