GMVHPN2 ;HIOFO/YH,FT-HP LASER PAIN CHART - ^TMP DATA ;11/8/01  14:56
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10104 - ^XLFSTR calls          (supported)
 ;
SETA ;
 I GK="Unavailable" S GK="Unavail"
 I GK'="" D
 . S ^TMP($J,"GMRK","G"_(GJ+GCNTD+1))=GK,^TMP($J,"GMRK","G"_(GJ+20+GCNTD+1))=GK
 I GK'=99,"PASSREFUSEDUNAVAIL"'[$$UP^XLFSTR(GK) S ^TMP($J,"GMRK","G"_(410+GCNTD))="P"
 Q
PTID ;PRINT PATIENT ID
 W !,"SD1,277,2,1,4,10,5,1,6,5,7,4;SS;PA-2,-10.5;LB"_^TMP($J,"GMRK","G194")_"#;PA-2,-11;LB"_^("G196")_"   "_^("G197")_"#;"
 W !,"PA-2,-11.5;LB"_^TMP($J,"GMRK","G198")_"#;PA6,-12;LB"_^("G200")_"#;PA6,-12.5;LB"_^("G199")_"#;PA-2,-12;LB"_GMRDIV_"#;"
 W !,"PA-2,-12.5;LB"_GSTRFIN_"#;" Q
WRTLN ;PRINT LINE
 S I(1)="" F I=1:1:5 S I(2)=I-1,I(1)=I(1)_"PA"_(1.6*I(2)+0.2)_","_J_";LB"_^TMP($J,"GMRK","G"_(J(1)+I(2)))_"#;"
 W !,I(1) S I(1)="" F I=6:1:10 S I(2)=I-1,I(1)=I(1)_"PA"_(1.6*I(2)+0.2)_","_J_";LB"_^TMP($J,"GMRK","G"_(J(1)+I(2)))_"#;"
 W !,I(1) Q
