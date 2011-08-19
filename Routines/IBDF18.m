IBDF18 ;A;B/CJM - ENCOUNTER FORM - utilities for Problem List ;15OCT93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
GETFORM() ;allows the user to select an encounter form with a Clinic Common Problem List
 ;returns <the form ien, or 0 if none selected>^<form name>
 N FORM,LIST,QUIT,ANS
 S (LIST,QUIT)=0 F  D  Q:QUIT
 .S FORM=$$SLCTFORM^IBDFU4(0)
 .I 'FORM S QUIT=1 Q
 .D FIND(FORM,0,.LIST,0)
 .I LIST S QUIT=1 Q
 .W !,"The form you selected doesn't contain a Clinic Common Problem List!",!,"Do you want to select another form? "
 .R ANS:DTIME
 .S:'$T!(ANS="")!(ANS["^")!(ANS["N")!(ANS["n") QUIT=1,FORM=0
 Q FORM_"^"_$P($G(^IBE(357,FORM,0)),"^")
 ;
 ;
COPYFORM(FORM,ARY) ;creates a list of problem groups and problems found in FORM on the list of clinic common problems
 ;returns the length of the returned list
 ;FORM is the ien of an encounter form
 ;@ARY is the array where the list should be placed
 ;each problem will have the format 'problem ien^problem text'
 ;each group will have the format '^header text to display (could be null)'
 ;following each group will be the problems on it
 ;
 ;the ruturned list will look like this:
 ;@ARY@(1)=^group header
 ;@ARY@(2)=problem ien^problem text
 ;@ARY@(3)=problem ien^problem text
 ;
 ;
 ;@ARY@(k)=^next group header
 ;@ARY@(k+1)=problem ien^problem text
 ;....
 ;
 Q:'$G(FORM) 0
 Q:'$L($G(ARY)) 0
 N BLOCK,LIST,INTRFACE,COUNT
 S (BLOCK,LIST,INTRFACE,COUNT)=0
 F  D FIND(FORM,.BLOCK,.LIST,.INTRFACE) Q:'LIST  D COPYLIST(LIST,ARY,.COUNT)
 Q COUNT
 ;
COPYLIST(LIST,ARY,COUNT) ;copies the entries from LIST to @ARY, starting subscript at COUNT+1
 ;
 N SLCTN,SUBCOL,TEXT,IEN,NODE,TSUBCOL,NOTREAL,NODE,GROUP,ORDER,HDR
 ;
 D SUBCOL(LIST,.TSUBCOL) ;find the subcolumn containing the text
 ;don't bother returning list of problems if there is no subcolumn containing the problem text
 Q:'$G(TSUBCOL)
 ;
 S GROUP=0 F  S GROUP=$O(^IBE(357.3,"APO",LIST,GROUP)) Q:'GROUP  D
 .S HDR=$P($G(^IBE(357.4,GROUP,0)),"^") I HDR="BLANK" S HDR=""
 .S COUNT=COUNT+1,@ARY@(COUNT)="^"_HDR
 .S ORDER="" F  S ORDER=$O(^IBE(357.3,"APO",LIST,GROUP,ORDER)) Q:ORDER=""  S SLCTN=0 F  S SLCTN=$O(^IBE(357.3,"APO",LIST,GROUP,ORDER,SLCTN)) Q:'SLCTN  D
 ..S NODE=$G(^IBE(357.3,SLCTN,0)),IEN=$P(NODE,"^"),NOTREAL=$P(NODE,"^",2)
 ..Q:'IEN!(NOTREAL)
 ..S SUBCOL=$O(^IBE(357.3,SLCTN,1,"B",TSUBCOL,0)) Q:'SUBCOL  S NODE=$G(^IBE(357.3,SLCTN,1,SUBCOL,0)) S:$P(NODE,"^")=TSUBCOL TEXT=$P(NODE,"^",2) I $L(TEXT) S COUNT=COUNT+1,@ARY@(COUNT)=IEN_"^"_TEXT Q
 Q
 ;
 ;
SUBCOL(LIST,TSUBCOL) ;finds the subcolumn containing the text
 ;TSUBCOL should be passed by reference - used to return the subcolumn
 ;LIST is the selection list to search
 S TSUBCOL=""
 ;
 N SC,PIECE,NODE S SC=0
 ;
 ;refering to the data returned by the package interface, piece 2 is the description
 F  S SC=$O(^IBE(357.2,LIST,2,SC)) Q:'SC  S NODE=$G(^IBE(357.2,LIST,2,SC,0)),PIECE=$P(NODE,"^",5) I PIECE=2 S TSUBCOL=$P(NODE,"^") Q
 Q
 ;
FIND(FORM,BLK,LIST,INTRFACE) ;finds the block & list containing the Clinic Common Problem List
 N INTRFACE,QUIT
 S BLK=+$G(BLK),LIST=+$G(LIST),INTRFACE=+$G(INTRFACE)
 ;
 ;if not already found,find the package interface for selecting PROBLEMS
 I 'INTRFACE S INTRFACE=$O(^IBE(357.6,"B","GMP SELECT CLINIC COMMON PROBL",0))
 I 'INTRFACE S (BLK,LIST)=0 QUIT
 ;
 I BLK D
 .F  S LIST=$O(^IBE(357.2,"C",BLK,LIST)) Q:'LIST  I $P($G(^IBE(357.2,LIST,0)),"^",11)=INTRFACE Q
 I BLK,LIST QUIT
 S QUIT=0
 F  S BLK=$O(^IBE(357.1,"C",FORM,BLK)) Q:'BLK  D  Q:QUIT
 .S LIST=0 F  S LIST=$O(^IBE(357.2,"C",BLK,LIST)) Q:'LIST  I $P($G(^IBE(357.2,LIST,0)),"^",11)=INTRFACE S QUIT=1 Q
 I 'BLK!('LIST) S (BLK,LIST)=0
 Q
