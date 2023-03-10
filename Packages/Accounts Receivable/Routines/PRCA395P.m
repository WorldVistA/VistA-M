PRCA395P ;MNTVBB/RS - PRCA patch 395 post install ; OCT 27, 2021
 ;;4.5;Accounts Receivable;**395**;Mar 20, 1995;Build 9
 ;Per VA Directive 6402, this routine should not be modified.
 ; Reference to $$GET^XPAR in ICR #2263
 ; Reference to EN^XPAR in ICR #2263
 ; 
 Q
 ;
 ;
PARAM ; add/edit new sftp site parameters
 N ENT,PAR,INST,DATA,CURR
 ;
 S ENT="PKG"                                        ; entity package
 S PAR="PRCA SFTP"                             ; parameter definition - new one        
 ;
 S INST="SFTP SERVER"                                   ; parameter instance
 S DATA="vhactxftparc01.vha.domain.ext",DATA(1,0)=""    ; default parameter value upon patch install
 S CURR=$$GET^XPAR(ENT,PAR,INST,"Q")                    ; current value of parameter
 I CURR="" D EN^XPAR(ENT,PAR,INST,.DATA)                ; create/update parameter
 ;
 S INST="SFTP USERNAME"
 S DATA="mccf",DATA(1,0)=""
 S CURR=$$GET^XPAR(ENT,PAR,INST,"Q")
 I CURR="" D EN^XPAR(ENT,PAR,INST,.DATA)
 ;
 D PRCAKEY
 Q
 ;
PRCAKEY ;
 S DATA="PRCAPRVKEY(10/29/2021 11:18 am)"
 S DATA(1,0)="$ZZZZZ,*4SRNI>*RXXbN><Sjf)*NF*VZZZZZ/"
 S DATA(2,0)="1I[_xIAmcy8Z\w$NgUkJ:::::_ }!I-C::::JI-r#w|:::::::::_:::_xK::::UceQvgeA3"
 S DATA(3,0)="3.DuuuuuZsuu&uuuTsuxJQsky|JX:Y(.KC+10JBOKZb22Ut-9ENACO.ar-1Zt?D;]Za?9wM&"
 S DATA(4,0)="*s; \dVG#OfOqH(k(f'""J|Gaos|oBEHZty-9HWZO|RmBOsrr6Cvfq(d~w6vfCw,He1Dy'>(#"
 S DATA(5,0)="(0e:,c(pR%9LBADP:SqqPFoXR}q>kpB993#G$V>U_q3vUYN 7&#SD:(eU0q(G4M}b{N{.3./"
 S DATA(6,0)="--O+#ef`b4x0=k 'fb7y3WK(e2ua:`~IT5f Nnqe&lk{CS-S(et!4L~f:/E+t4c,W[.mQ&Y!"
 S DATA(7,0)=")|xSi}dWG-2n26aKb*7{\nnl|7*q{-X:9uayJCRLQ+*r1I#[gRx7{iGiItCctRD$i)XUzz;"""
 S DATA(8,0)=".RhQtM.|;mHzeNt&Wo*o%i.e/s 7w#//g& xq32*qt./'FDH$P?bC:X~&j{NcM>>DL))e0z&"
 S DATA(9,0)="21n[:Ld$w)*a__vX?z$dmsi""VrA0aHw<.E|%m=.**r_fAn{sI -|r%{w(_Z-vr @&ef#=u;*"
 S DATA(10,0)="1*82E~T<2k480tJFW/A#VI</<;9?Mo\A5R8vR!ZOBeee)X>HP#~>=w/{7eeee`=q+,h0/2@#"
 S DATA(11,0)="&=   Se I YDGMz t@KdV(]L>8:&b/KkSXMD[3jPd>e07([3uexOqo& V\?5y/<M(z.VS!t2"
 S DATA(12,0)="*P{G![M\$woYGZ""o]f"",$_)b},sJ:K$]?E9[-?2\*e-KXbFq*~D2Us2#NqOGk!.}N4YkEyt1"
 S DATA(13,0)=",(Z/q[kY-kWX5?B-@Y5(Ujwo{~Q@%`*`PIhoQRpgqL?C:G3)C{w-{CtgrQwX"":kECA3%jij$"
 S DATA(14,0)="33b!,81XsOQck|&:i""E/B?.h\wF>xNEbK(wJN7|TLZ-ah""/[ibukYr++9WeyUlUxLs75(#x&"
 S DATA(15,0)="%?GbEI> pfTTr.6mZ)m3[F|LLWG}EWkmAA?~a<D,fp#=x/DG}4})jx>6,Fh8E:x6:8aErID0"
 S DATA(16,0)="/;;ff(b$bG\Mal)PN|ubbMp(Z;.L$a5GbjDrH`C.T`.@a0&,aN,UUR*ue;:lX+0*#>M3R::"""
 S DATA(17,0)="1|rObn(.i#OgqC'&(#)Wzkcj,8z)GGR|,&:{{NmCZU&O[r|,COUmF*?43mpR9|k<-{,l[Zc-"
 S DATA(18,0)="3eLzk<zgUa}l4p<M*wopg6LhiLFpMU2nnnn4,nn""nnn6nbpD0bcN`b}4ntdpU,""xta/[OFP1"
 S DATA(19,0)="0~8eE'ffC2e$}8V#>UVIS$Q{A=HEH3.ApAA/YT;''8RY0%)8QfDOq|Vh?|{e&Q[0|N;QT%{)"
 S DATA(20,0)="*zXY_tNX\N9G0;a_fWRxsHX?Uh.Jb}Q_7EWVbl&W3[wGJZ?|f~0bxv/LW,9//o~ZO'JXfI#&"
 S DATA(21,0)="/0u-u3+-Ifo]-l0Kl77V1Jy&i""K5]\o-!Zp&:?Akb%Aym[?%i kpzzdiK~9YdbuFudLqV}I$"
 S DATA(22,0)="-I>DGsTPB,t.Y`..\+ o7|uPDOt2VF\VBXr*S""Sr$yh7L:=21e6?>c7.yKzyKtlaVdOFEb2"""
 S DATA(23,0)="1,[6{$iE4A4:{qvWVK_:$;Nkl)|c9i .n./#.e<W;RnL;;W*e*4o%-j""<~,nT{i  ny\ Rr&"
 S DATA(24,0)=""" |,}\,YEO(d}#Ff|&|Z'EU'6pRg)/9.jFR7'#G$.xF'V""*6BA/XjSTFvbV}j<ABIBvGUkG1"
 S DATA(25,0)="*d*4#S_#f*M 2_#{J [F|=8*V9<.=RmX1X6K@[AydRt11 WuTv#'_bv.<A3X`I{:b*o````'"
 S DATA(26,0)="*.'Hp\<42c0>@tq)FHgmX<LC%R9R_HaHxsjXGs/mXdSP_yv!!CtR<* 04{tdE77_!X3PBP<("
 S DATA(27,0)="34{4.KR*x66zEu|F@nG6REf0c1nn5/2{J7Z>UF'`nfR*@>\>K*T5sP@UUrY[s4&w*&ALwRt-"
 S DATA(28,0)="%Qs<Lb~Q]#UEFN`]>CNyrUIJZi>#UUui,_;so@QzSZ1qSMARD,!o!o_$[+`y0=1ArZ=0vNS*"
 S DATA(29,0)=")v4E-E8|wL:w/xmYvw\9@gwYL{- :Tj<t}w'My&D&Ywj2Eg9??YYY4@Y8Dxo;'F8\]{Y=D.+"
 S DATA(30,0)="(|as PI@SFx1y8e, 3q'K&nG`8v:U1+'-:|A=+3L,8Uh)4yYXyXj-6j{S@M*l,d'I3""6rrf!"
 S DATA(31,0)="1_utwW_)asP`JW=B)t[D}1U.DKq<i.s`F9T'LLUG71tKC.'ia""`t=j9NWxhujSNhxL]ua{}0"
 S DATA(32,0)="#70[mkD%:9#Qx1_MD%;mn`$OVkQda-t83F>3*wd>1V-_[Oix95vz)#|n7VD7:G.[\JQ=&N[."
 S DATA(33,0)="(Yk~UYQrp 45K<GA?_/@LU2jpa821@)ak444M;43|@E:=F*-:r5MqyAP<jLd7fL;=1|/QL-!"
 S DATA(34,0)="&$KG*vA$H3@GT5G:]W""]ldjuLj<_""-;8qk#H@(<]!;5va>ac[q_4'L:e(ez8""+w,8NljG(Y$"
 S DATA(35,0)="!K .&\#iz{)az*7N\x@eW`EYYcq2sNl;i+(OE&f$Vz%ExP}z':_M:*saZ,K=c$HfyzA;}hY*"
 S DATA(36,0)=""".#J\N';v0Lvz#d:Lg$Z,Ist0Lx::T*dICm:U83CgCD#ndBsZsHvIP%$@H\+:+(sC>mCok32"
 S DATA(37,0)="/QMyl3bhRk3:2FkuuuuF&jpS|:<M(#='zG/hR#:8UjV-QM=MkOW-3~~l3,VSqr=8DrUtR8#."
 S DATA(38,0)="!,8WYF!..1"
 S DATA(39,0)="!fffff+x]OI5+xmmYO5<(`X2+OC+Mfffff%"
 S INST="SFTP SSH PRIVATE KEY"
 S CURR=$$GET^XPAR(ENT,PAR,INST,"Q")
 I CURR="" D EN^XPAR(ENT,PAR,INST,.DATA)
 Q
 ;
