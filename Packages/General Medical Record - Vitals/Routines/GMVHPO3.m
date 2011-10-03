GMVHPO3 ;HIOFO/YH,FT-HP LASER PULSE OXIMETRY/RESP. GRAPH - ^TMP DATA ;11/6/01  15:19
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10104 - ^XLFSTR calls          (supported)
 ;
SETA ;
 I GK="Unavailable" S GK="Unavail"
 S (GMRSITE,GMRSITE(1),GMRSITE(2),GMRINF,GMRVJ)=""
 I GK'="" D
 . S GMRSITE(1)=$P($G(^TMP($J,"GMRVG",GI,GDT1,GK)),"^"),GMRVJ=$P($G(^(GK)),"^",2),GMRINF=$P($G(^(GK)),"^",4)
 . I GMRSITE(1)'="" D SYNOARY^GMVLGQU
 I GK'="","UNAVAILABLEPASSREFUSED"'[$$UP^XLFSTR(GK) S GK=GK_$S(GMRVJ=1:"*",1:" ")
 I GI="P" S ^TMP($J,"GMRK","G"_(510+GCNTD))=GK_$S($L(GMRSITE," ")>3:$P(GMRSITE," "),1:""),^("G"_(530+GCNTD))=$S($L(GMRSITE," ")>3:$P(GMRSITE," ",2,4),1:GMRSITE) Q
 I GI="PO2" D
 . S (GMRINF(1),GMRINF(2))="" I GMRINF'="" D PO2^GMVLGQU(.GMRINF)
 . S ^TMP($J,"GMRK","G"_(1430+GCNTD))=GMRINF(1)
 . S ^TMP($J,"GMRK","G"_(1450+GCNTD))=GMRINF(2)
 . S ^TMP($J,"GMRK","G"_(1470+GCNTD))=GMRSITE
 S ^TMP($J,"GMRK","G"_(GJ+GCNTD+1))=$S(GK>0:$S(GI="R":GK-4/2,GI="PO2":GK-64/2,1:""),1:"") S ^TMP($J,"GMRK","G"_(GJ+20+GCNTD+1))=$S(+GK=0.1:"0*",1:GK)_$S(GI="R":GMRSITE,1:"")
 I GI="R",GK>0 S ^TMP($J,"GMRK","G"_(410+GCNTD))=$S(GK["*":"R*",1:"R")
 I GI="PO2",GK>0 S ^TMP($J,"GMRK","G"_(430+GCNTD))=$S(GK["*":"POx*",1:"POx")
 I GK>0,GI="R" S ^TMP($J,"GMRK","G"_(GJ+GCNTD+1))=$S(^("G"_(GJ+GCNTD+1))<0.5:0.5,^("G"_(GJ+GCNTD+1))>18.7:18.7,1:^("G"_(GJ+GCNTD+1))) S:^("G"_(GJ+GCNTD+1))<0.6!(^("G"_(GJ+GCNTD+1))>18.6) ^TMP($J,"GMRK","G"_(410+GCNTD))="R**"
 I GK>0,GI="PO2" S ^TMP($J,"GMRK","G"_(GJ+GCNTD+1))=$S(^("G"_(GJ+GCNTD+1))<0.5:0.5,^("G"_(GJ+GCNTD+1))>18.7:18.7,1:^("G"_(GJ+GCNTD+1))) S:^("G"_(GJ+GCNTD+1))<0.6!(^("G"_(GJ+GCNTD+1))>18.6) ^TMP($J,"GMRK","G"_(430+GCNTD))="POx**"
 Q
PTID ;PRINT PATIENT ID
 W !,"SD1,277,2,1,4,9,5,1,6,5,7,4;SS;PA-2,-4.5;LB"_^TMP($J,"GMRK","G194")_"#;PA-2,-4.8;LB"_^("G196")_"   "_^("G197")_"#;"
 W !,"PA-2,-5.1;LB"_^TMP($J,"GMRK","G198")_"#;PA6,-5.1;LB"_^("G200")_"#;PA6,-5.4;LB"_^("G199")_"#;PA-2,-5.4;LB"_GMRDIV_"#;"
 W !,"PA-2,-5.7;LB"_GSTRFIN_"#;" Q
