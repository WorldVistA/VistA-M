NURCVED1 ;HIRMFO/YH-LIST & SELECT VITAL MEASUREMENTS ;9/27/90
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
EN1 ;SELECT VITALS AND CREATE STRING OF VITALS IN FORMAT, E.G., "T;P;R;"
 ;OUTPUT VARIABLE:   GMRVSTR = STRING OF VITALS SELECTED
 W !! S NSET=0,NCOL=5,NVTAL="" F N(1)=0:0 S NVTAL=$O(^GMRD(120.51,"C",NVTAL)) Q:NVTAL=""  S NN=$O(^GMRD(120.51,"C",NVTAL,0)) W ?NCOL,NVTAL,?NCOL+5,$P(^GMRD(120.51,NN,0),"^") S NSET=NSET+1,NCOL=40 I NSET=2 W ! S NSET=0,NCOL=5
SEL W !,"Select vitals to be entered (e.g., T;P;R;BP , ENTER RETURN FOR ALL) : "
 R NVTAL:DTIME I NVTAL["^"!('$T) S NURQUIT=1 G Q1
 I NVTAL="" S GMRSTR="T;P;R;BP;WT;HT;" G Q1
 I NVTAL?1"?".E W !,?5,"Type in the abbreviation of vital measurements you want separated by",!,?5,""";"" if there is more than one selected",!,?5,"e.g., T;P;R;BP",! G SEL
 I '(NVTAL?.A!(NVTAL?.AP&(NVTAL[";"))) G SEL
 D STRCHK I NURQUIT=1 S NURQUIT=0 G SEL
Q1 K N,NVTAL,NSET,NCOL Q
STRCHK ;
 S GMRSTR="" F NN=1:1 S N(1)=$P(NVTAL,";",NN) Q:N(1)=""  D SCREEN
 Q
SCREEN S N(2)=$S(N(1)["HT"!(N(1)["ht"):"HT;",N(1)["BP"!(N(1)["bp"):"BP;",N(1)["R"!(N(1)["r"):"R;",N(1)?1A&(N(1)["P"!(N(1)["p")):"P;",N(1)["WT"!(N(1)["wt"):"WT;",N(1)?1A&(N(1)["T"!(N(1)["t")):"T;",1:"") I N(1)'="" S GMRSTR=GMRSTR_N(2)
 Q
