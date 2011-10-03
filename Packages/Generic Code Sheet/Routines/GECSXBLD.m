GECSXBLD ;WISC/RFJ-map data into template map                       ;01 Nov 93
 ;;2.0;GCS;;MAR 14, 1995
 Q
 ;
 ;
MAPDATA(GECSDA) ;  map data to template
 ;  return 1 if code sheet is built, 0 if not built
 N %,%H,%I,CODESHET,DA,DA1,DATA,DELIMITR,FIELD,GECSDATE,GECSEND,GECSFLAG,GECSLINE,GECSMAP,GECSNOD1,GECSNOD2,GECSOT,GECSTNM,I,N,PIECE,SUB1,SUB2,X,Y
 ;
 ;  keypunched code sheet
 K CODESHET
 I $P($G(^GECS(2100,GECSDA,0)),"^",11)="[GECS KEYPUNCH]" D  Q GECSFLAG
 .   S %=0 F I=0:1 S %=$O(^GECS(2100,GECSDA,"KEY",%)) Q:%=""  S CODESHET(I)=^(%,0)
 .   I I=0 W !,"NOTHING TO KEYPUNCH." D KILLCS^GECSPUR1(GECSDA) W "  << CODE SHEET DELETED >>" S GECSFLAG=0 Q
 .   S %=$$SHEET,GECSFLAG=1
 ;
 ;  fill in fields code sheet
 ;  set gecsot variable to execute output transform
 S GECSOT=""
 ;  move code sheet field data into variable data
 K DATA
 S SUB1="" F  S SUB1=$O(^GECS(2100,GECSDA,SUB1)) Q:SUB1=""  I SUB1'="CODE" S:$D(^(SUB1))'["0" DATA(SUB1)=^(SUB1) I $D(^GECS(2100,GECSDA,SUB1,0)) D
 .   S DA1=0 F  S DA1=$O(^GECS(2100,GECSDA,SUB1,DA1)) Q:'DA1  D
 .   .   S SUB2="" F  S SUB2=$O(^GECS(2100,GECSDA,SUB1,DA1,SUB2)) Q:SUB2=""  S:$D(^GECS(2100,GECSDA,SUB1,DA1,SUB2)) DATA(SUB1,DA1,SUB2)=^(SUB2)
 ;
 ;  get template map
 S GECSTNM=$P(DATA(0),"^",11),GECSTNM=$E(GECSTNM,2,$L(GECSTNM)-1) I GECSTNM="" W !,"CODE SHEET ",$P(DATA(0),"^")," DOES NOT HAVE A TEMPLATE MAP DEFINED." Q 0
 S %=$O(^DIE("B",GECSTNM,0)) I '% W !,"INPUT TEMPLATE ",GECSTNM," NOT FOUND." Q 0
 D GETMAP^GECSXMAP(%) I '$D(GECSMAP) Q 0
 ;
 S GECSEND=80,DELIMITR=""
 ;  put code sheet specific code here!!!
 I $P(DATA(0),"^",2)="VOL" S GECSEND=81
 I $P(DATA(0),"^",2)="FMS" S DELIMITR="^",GECSEND=240
 I $P(DATA(0),"^",2)="FEN" S DELIMITR=".",GECSEND=240
 ;  end of code sheet specific code
 ;
 ;  build code sheet with data
 ;  set da for output transform
 S DA=GECSDA
 K GECSFLAG
 S (GECSLINE,GECSNOD1)=0 F  S GECSNOD1=$O(GECSMAP(GECSNOD1)) Q:'GECSNOD1  D
 .   ;  single field (not multiple)
 .   I GECSMAP(GECSNOD1)'["," D  Q
 .   .   F PIECE=1:1 S FIELD=$P(GECSMAP(GECSNOD1),"\",PIECE) Q:FIELD=""  D  Q:$G(GECSFLAG)
 .   .   .   S SUB1=$P(FIELD,";",2)
 .   .   .   S Y=$P($G(DATA(SUB1)),"^",$P(FIELD,";",3))
 .   .   .   D SETLINE(2100,+FIELD)
 .   ;  multiple field
 .   S SUB1=$P(GECSMAP(GECSNOD1),",",2)
 .   S DA1=0 F  S DA1=$O(DATA(SUB1,DA1)) Q:'DA1  S GECSNOD2=0 F  S GECSNOD2=$O(GECSMAP(GECSNOD1,GECSNOD2)) Q:'GECSNOD2  D
 .   .   F PIECE=1:1 S FIELD=$P(GECSMAP(GECSNOD1,GECSNOD2),"\",PIECE) Q:FIELD=""  D  Q:$G(GECSFLAG)
 .   .   .   S SUB2=$P(FIELD,";",2)
 .   .   .   S Y=$P($G(DATA(SUB1,DA1,SUB2)),"^",$P(FIELD,";",3))
 .   .   .   D SETLINE(+$P(GECSMAP(GECSNOD1),",",3),+FIELD)
 ;
 ;  put code sheet specific code here (after code sheets have been built)
 ;  reformat for amis
 I $P(DATA(0),"^",2)="AMS" D AMIS
 ;  end of code sheet specific code
 Q $$SHEET
 ;
 ;
SHEET() ;  move code sheets to code node
 D NOW^%DTC S GECSDATE=%
 K ^GECS(2100,GECSDA,"CODE")
 S GECSLINE="" F I=1:1 S GECSLINE=$O(CODESHET(GECSLINE)) Q:GECSLINE=""  S ^GECS(2100,GECSDA,"CODE",I,0)=CODESHET(GECSLINE)
 S I=I-1,^GECS(2100,GECSDA,"CODE",0)="^^"_I_"^"_I_"^"_$P(GECSDATE,".")_"^^"
 D PRINT^GECSUTIL(GECSDA)
 Q 1
 ;
 ;
SETLINE(FILE,FIELD) ;  build codeshet array with data in y
 I $D(^DD(FILE,+FIELD,2.1)),^(2.1)["GECSOT" X ^(2.1)
 S CODESHET(GECSLINE)=$G(CODESHET(GECSLINE))_$S($G(CODESHET(GECSLINE))="":"",$G(CODESHET(GECSLINE))=("LIN^"_$C(126)):"",$P(DATA(0),"^",2)="FEN"&(Y="$"):"",1:DELIMITR)_Y
 ;  for fms, put each segment on a new line
 I $P(DATA(0),"^",2)="FMS",Y=$C(126),$G(CODESHET(GECSLINE))'=("LIN^"_$C(126)) S GECSLINE=GECSLINE+1
 I $L($G(CODESHET(GECSLINE)))>GECSEND S CODESHET(GECSLINE+1)=$E(CODESHET(GECSLINE),GECSEND+1,999),CODESHET(GECSLINE)=$E(CODESHET(GECSLINE),1,GECSEND),GECSLINE=GECSLINE+1
 I Y="$" S GECSFLAG=1
 Q
 ;
 ;
AMIS ;  reformat for amis
 N %,CHAR,LINE,OLDCODE,X
 ;  move code sheet (in codeshet) to temp variable for processing
 K OLDCODE S %="" F  S %=$O(CODESHET(%)) Q:%=""  S OLDCODE(%)=CODESHET(%)
 K CODESHET S GECSLINE=0
 S CODESHET(0)=$E(OLDCODE(0),1,16)_"-",OLDCODE(0)=$E(OLDCODE(0),17,256)
 S LINE="" F  S LINE=$O(OLDCODE(LINE)) Q:LINE=""  F CHAR=1:10 S X=$E(OLDCODE(LINE),CHAR,CHAR+9) Q:X=""  D
 .   ;  if x is not 10 characters long, move up data from next line
 .   I $L(X)<10,$D(OLDCODE(LINE+1)) S %=10-$L(X),X=X_$E(OLDCODE(LINE+1),1,%),OLDCODE(LINE+1)=$E(OLDCODE(LINE+1),%+1,256)
 .   I X="0000000000" S X=""
 .   S CODESHET(GECSLINE)=$G(CODESHET(GECSLINE))_X_$S(X["$":"",1:"-")
 .   I $L(CODESHET(GECSLINE))>GECSEND S CODESHET(GECSLINE+1)=$E(CODESHET(GECSLINE),GECSEND+1,256),CODESHET(GECSLINE)=$E(CODESHET(GECSLINE),1,GECSEND),GECSLINE=GECSLINE+1
 Q
