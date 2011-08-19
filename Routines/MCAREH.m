MCAREH ;WISC/MLH-ENTER/EDIT CARDIAC PROCEDURES-HELP ;5/2/96  10:26
 ;;2.3;Medicine;;09/13/1996
DATE ;    provide guidance for the date prompt
 N HEADING
 W @$G(IOF)
 S HEADING=MCARDE_" PROCEDURES"
 I $G(IOST)?1"C-VT100".E F I=3,4 W *27,"#",I,$$CENTER(HEADING,40),!
 E  W $$CENTER(HEADING,80),!
 W !,"TO ENTER A NEW PROCEDURE:"
 W !!?5,"Enter the date and time when the procedure was performed."
 W !!,"TO EDIT AN EXISTING PROCEDURE:"
 W !!?5,"Enter the patient's name, last name first, or 1st initial of the"
 W !,?5,"last name and the last 4 digits of the social security number.",!
 W !?5,"A partial name may be entered"_$S($G(MCESON)=1:" or a release status",1:"")_"."
 W !?5,"This will bring up all entries matching that part of the name."
 W !!?5,"Or you may enter the date and time when the procedure was"
 W !?5,"performed.  This must be an exact match."
 W !!?5,"Or enter a ? to choose from a list of procedures."
 W !!?5,"Release Control is "_$S($G(MCESON)=1:"available",1:"not available")_".  "
 I $G(MCESON)=1 D
 .W "You can ",$S($G(MCESSEC)=1:"",1:"not "),"release the reports."
 .W !?5,"You currently "_$S($G(MCESSEC)=1:"have",1:"don't have")_" the "
 .W:$G(MCESKEY)'="" "'"_MCESKEY_"' "
 .W "Key."
 W !
 Q
 ;
CENTER(TEXT,MGN) ;
 W $J("",MGN-$L(TEXT)/2),TEXT
 Q ""
