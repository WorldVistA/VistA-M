GMVBP5 ;HIOFO/YH,FT-CALCULATE KYOCERA B/P GRAPH DATA (CONT.) ;11/6/01  14:36
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
SETA ;
 I GK="Unavailable" S GK="Unavail"
 S (GMRSITE,GMRSITE(1),GMRSITE(2),GMRINF,GMRVJ)=""
 I GK'="" D
 . S GMRSITE(1)=$P($G(^TMP($J,"GMRVG",GI,GDT1,GK)),"^"),GMRVJ=$P($G(^(GK)),"^",2),GMRINF=$P($G(^(GK)),"^",4)
 . I GMRSITE(1)'="" D SYNOARY^GMVLGQU
 I GI="C" S ^TMP($J,"GMRK","G"_(1240+GCNTD))=GK_^TMP($J,"GMRK","G"_(1240+GCNTD)) Q
 I GK'="" S GK=GK_$S(GMRVJ=1:"*",1:" ")
 I GI="B" S ^TMP($J,"GMRK","G"_(450+GCNTD))=$S($L(GMRSITE," ")>3:$P(GMRSITE," ",2,4),1:GMRSITE),^TMP($J,"GMRK","G"_(GJ*16+GCNTD+1))=GK S:$L(GMRSITE," ")>3 ^TMP($J,"GMRK","G"_(1240+GCNTD))="  "_$P(GMRSITE," ") Q
 I GI="P" D  Q
 . S ^TMP($J,"GMRK","G"_(GJ+1*16+GCNTD+1))=GK_" "_$S($L(GMRSITE," ")>3:$P(GMRSITE," "),1:"")
 . S ^TMP($J,"GMRK","G"_(1120+GCNTD))=$S($L(GMRSITE," ")>3:$P(GMRSITE," ",2,4),1:GMRSITE)
 I GI="M" S ^TMP($J,"GMRK","G"_(1220+GCNTD))=GK Q
 I GI="S"!(GI="D") S ^TMP($J,"GMRK","G"_(GJ*16+GCNTD+1))=$S(GK>0:240-GK/10,1:""),^TMP($J,"GMRK","G"_(GJ+1*16+GCNTD+1))=GK
 I GI="P",(GK>0!(GK="0")) S ^TMP($J,"GMRK","G"_(430+GCNTD))=$S(GK["*":"P*",1:"P")
 I GI="S",GK>0 S ^TMP($J,"GMRK","G"_(1200+GCNTD))=$S(GK["*":"S*",1:"S")
 I GI="D",GK>0 S ^TMP($J,"GMRK","G"_(1100+GCNTD))=$S(GK["*":"D*",1:"D")
 I GK>0,GI="P" S ^TMP($J,"GMRK","G"_(GJ*16+GCNTD+1))=$S(^("G"_(GJ*16+GCNTD+1))<1.4:1.4,^("G"_(GJ*16+GCNTD+1))>19.5:19.5,1:^("G"_(GJ*16+GCNTD+1))) S:^("G"_(GJ*16+GCNTD+1))<1.4!(^("G"_(GJ*16+GCNTD+1))>19.4) ^TMP($J,"GMRK","G"_(430+GCNTD))="P**"
 I GK>0,GI="S" S ^TMP($J,"GMRK","G"_(GJ*16+GCNTD+1))=$S(^("G"_(GJ*16+GCNTD+1))<1.4:1.4,^("G"_(GJ*16+GCNTD+1))>19.5:19.5,1:^("G"_(GJ*16+GCNTD+1))) S:^("G"_(GJ*16+GCNTD+1))<1.5!(^("G"_(GJ*16+GCNTD+1))>19.4) ^TMP($J,"GMRK","G"_(1200+GCNTD))="S**"
 I GK>0,GI="D" S ^TMP($J,"GMRK","G"_(GJ*16+GCNTD+1))=$S(^("G"_(GJ*16+GCNTD+1))<1.4:1.4,^("G"_(GJ*16+GCNTD+1))>19.5:19.5,1:^("G"_(GJ*16+GCNTD+1))) S:^("G"_(GJ*16+GCNTD+1))<1.5!(^("G"_(GJ*16+GCNTD+1))>19.4) ^TMP($J,"GMRK","G"_(1100+GCNTD))="D**"
 Q
