IBDF1B1B ;ALB/CJM - ENCOUNTER FORM PRINT (IBDF1B continued - user options for printing- continuation of IBDF1B1); 3/1/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
ENDV ;entire divisions were choosen, find all clinics (with encounter forms defined)
 N IBCLN,IBDIV,NODE,DIVISION,ALL
 ;
 ;if ^TMP("IBDF",$J,"D","ALL") exists then all divisions were chosen
 S ALL=$S($D(^TMP("IBDF",$J,"D","ALL")):1,1:0)
 ;
 ;user did not select ALL, so make a list of the divisions he did choose
 I 'ALL S IBDIV=0 F  S IBDIV=$O(^TMP("IBDF",$J,"D",IBDIV)) Q:'IBDIV  S DIVISION(IBDIV)=""
 ;
 ;loop through all the clinics finding ones in selected divisions
 S IBCLN="" F  S IBCLN=$O(^SC(IBCLN)) Q:IBCLN=""  D
 .S NODE=$G(^SC(IBCLN,0))
 .;
 .;make sure it's in one of the selected divisions
 .S IBDIV=$P(NODE,"^",15)
 .I IBDIV,'ALL Q:'$D(DIVISION(IBDIV))
 .;
 .;check that location is a clinic
 .Q:$P(NODE,"^",3)'="C"
 .;
 .;if it's a restart make sure the IBDIV does not precede the starting division
 .I IBSTRTDV]" ",IBDIV S DIVISION=$P($G(^DG(40.8,IBDIV,0)),"^") I DIVISION'=IBSTRTDV,DIVISION']IBSTRTDV Q
 .;
 .;don't put it on the list if there is nothing to print
 .I '$$DIVHAS^IBDF1B1A(IBDIV),'$$CLNCHAS^IBDF1B1A(IBCLN) Q
 .;
 .;it passed all the tests, put it on the list
 .S ^TMP("IBDF",$J,"C",IBCLN)=""
 ;
 ;don't need list of divisions anymore
 K ^TMP("IBDF",$J,"D")
 Q
