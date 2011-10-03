WVDIAGS ;HCIOFO/FT,JR IHS/ANMC/MWR - RES/DIAG SYNONYM ADD/EDIT/PRINT ;8/3/98  16:26
 ;;1.0;WOMEN'S HEALTH;;Sep 30, 1998
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  ADD/EDIT/PRINT/PURGE SYNONYMS FOR WV RESULTS/DIAGNOSIS FILE.
 ;;
 ;
EDITSYN ;EP
 ;---> EDIT SYNONYMS FOR RESULTS/DIAGNOSIS.
 ;---> CALLED BY OPTION "WV EDIT RES/DIAG SYNONYMS".
 D SETVARS^WVUTL5
 F  D  Q:$G(Y)<0
 .D TITLE^WVUTL5("EDIT SYNONYMS FOR RESULTS/DIAGNOSIS FILE")
 .D TEXT1
 .D DIC^WVFMAN(790.31,"QEMA",.Y,"   Select RESULT/DIAGNOSIS: ")
 .Q:Y<0
 .D DIE^WVFMAN(790.31,".3;.31",+Y,1,.WVPOP)
 .S:WVPOP Y=-1
 W @IOF
 D KILLALL^WVUTL8
 Q
 ;
PRINTSYN ;EP
 ;---> CALLED BY OPTION "WV PRINT RES/DIAG SYNONYMS".
 D SETVARS^WVUTL5
 S DIC="^WV(790.31,"
 S FLDS="[WV PRINT RES/DIAG SYNONYMS]"
 S BY=.01,(FR,TO)=""
 K IO("Q") S %ZIS="Q" D ^%ZIS I POP D EXIT Q
 S IOP=ION I $D(IO("Q")) S IOP="Q;"_ION
 K IO("Q") S WVIOST=$E(IOST)
 D EN1^DIP
 D:$E(WVIOST)="C" DIRZ^WVUTL3
EXIT ;
 K IOP,WVIOST
 D KILLALL^WVUTL8
 Q
 ;
 ;
TEXT1 ;EP
 ;;You may enter a synonym for each Result/Diagnosis.  The synonym will
 ;;allow the Result/Diagnosis to be called up by typing only a few
 ;;characters.  Synonyms should be unique and less than 6 characters.
 ;;
 ;;For example, "C1" might be used for CIN I/mild dysplasia; "C2" for
 ;;CIN II/moderate dysplasia; "C3" for CIN III/severe dysplasia,
 ;;and so on.
 ;;
 ;;
 S WVTAB=5,WVLINL="TEXT1" D PRINTX
 Q
 ;
PRINTX ;EP
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  W !,T,$P(X,";;",2)
 Q
