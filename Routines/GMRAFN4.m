GMRAFN4 ;HIRMFO/WAA-FDA MEDWATCH FORM ;11/30/95  15:22
 ;;4.0;Adverse Reaction Tracking;;Mar 29, 1996
REL ;This code is to find all the revelant test
 S GMRANOR=0,GMRANOC=0
 I GMRAPG1'=1 G RELCON
 I $D(^GMR(120.85,GMRAPA1,4,0)) S GMRAXX=1 D  S GMRANOR=1
 .S GMRAX=0 F  S GMRAX=$O(^GMR(120.85,GMRAPA1,4,GMRAX)) Q:GMRAX<1  S ^TMP($J,"GMR","T",GMRAXX)=$G(^GMR(120.85,GMRAPA1,4,GMRAX,0)),GMRAXX=GMRAXX+1
 .K GMRAX,GMRAXX
 .Q
CON ;This code is to find all the concomitant drug info
 I $D(^GMR(120.85,GMRAPA1,13,0)) S GMRAXX=1,GMRANOC=1 D
 .S GMRAX=0 F  S GMRAX=$O(^GMR(120.85,GMRAPA1,13,GMRAX)) Q:GMRAX<1  S ^TMP($J,"GMR","C",(GMRAXX))=^GMR(120.85,GMRAPA1,13,GMRAX,0),GMRAXX=GMRAXX+1
 .K GMRAX,GMRAXX
 .Q
RELCON W !,"6. Relevant test/laboratory data. including dates",?66,"|10. Concomitant medical products/therapy dates(exclude treatment)"
 W ! I GMRANOR I $D(^TMP($J,"GMR","T",1)) W "PLEASE SEE ATTACHED"
 W ?66,"|" I GMRANOC S GMRACCT=1 D CONCO^GMRAFN5
 W !
 W ?66,"|" I GMRANOC S GMRACCT=2 D CONCO^GMRAFN5
 W !
 W ?66,"|" I GMRANOC S GMRACCT=3 D CONCO^GMRAFN5
 W !
 W ?66,"|" I GMRANOC D
 .I $D(^TMP($J,"GMR","C",5)) W "PLEASE SEE ATTACHED" Q
 .S GMRACCT=4 D CONCO^GMRAFN5
 .Q
 W !
 W ?66,"|",$E(LINE2,68,131)
 W !,$E(LINE1,1,66),"|D. Suspect Medical Devices"
OTHER ;This code is for other relevant history
 S GMRANOO=0 I GMRAPG1'=1 G OTHER2
 I $D(^GMR(120.85,GMRAPA1,14,0)) S GMRANOO=1 K ^UTILITY($J,"W") S DIWL=5,DIWR=63,DIWF="" S GMRAX=0 D
 .F  S GMRAX=$O(^GMR(120.85,GMRAPA1,14,GMRAX)) Q:GMRAX<1  S X=$G(^(GMRAX,0)) D ^DIWP
 .S X=0 F  S X=$O(^UTILITY($J,"W",5,X)) Q:X<1  S ^TMP($J,"GMR","O",X)=$G(^UTILITY($J,"W",5,X,0))
 .Q
OTHER2 W !,"7. Other relevant History, including preexisting medical",?66,"|",$E(LINE1,68,131)
 W !,"   conditions",?66,"| Note: Please use the actual MedWatch form if the event"
 W ! I GMRANOO W ?5,^TMP($J,"GMR","O",1) K ^(1) S:'$D(^TMP($J,"GMR","O",2)) GMRANOO=0
 W ?66,"|       involves a suspected device as well as a suspect drug"
 W ! I GMRANOO W ?5,^TMP($J,"GMR","O",2) K ^(2) S:'$D(^TMP($J,"GMR","O",3)) GMRANOO=0
 W ?66,"|",$E(LINE2,68,131)
 W ! I GMRANOO W ?5,^TMP($J,"GMR","O",3) K ^(3) S:'$D(^TMP($J,"GMR","O",4)) GMRANOO=0
 W ?66,"|E. Reporter"
 W ! I GMRANOO W ?5,^TMP($J,"GMR","O",4) K ^(4) S:'$D(^TMP($J,"GMR","O",5)) GMRANOO=0
 W ?66,"|",$E(LINE1,68,131)
 W ! I GMRANOO D
 .I $D(^TMP($J,"GMR","O",6)) W ?5,"PLEASE SEE ATTACHED" Q
 .W ?5,^TMP($J,"GMR","O",5) K ^(5)
 .Q
 Q
