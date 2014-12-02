PXRMTXCS ; SLC/PKR - Taxonomy code search routines. ;07/24/2013
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;
 ;=====================================================
CSEARCH(CODESYS,CODE,NFOUND,TAXLIST) ; Search all taxonomies to see if they
 ;contain CODE.
 N IEN,NAME
 K TAXLIST
 S NFOUND=0,NAME=""
 F  S NAME=$O(^PXD(811.2,"B",NAME)) Q:NAME=""  D
 . S IEN=$O(^PXD(811.2,"B",NAME,""))
 . I $D(^PXD(811.2,IEN,20,"AE",CODESYS,CODE)) S NFOUND=NFOUND+1,TAXLIST(NAME)=""
 Q
 ;
 ;=====================================================
SEARCH ; Let the user input a code then search all taxonomies to determine
 ;which ones include that code.
 N CODE,CODESYS,CODESYSL,CODESYSP,DATA,DIR,DIRUT,DTOUT,DUOUT,NFOUND
 N TAX,TAXLIST,RESULT,VALID,Y
 D CODESYSL^PXRMLEX(.CODESYSL)
 S DIR(0)="FAOU"
 S DIR("A")="Input a code to search for: "
GCODE W !
 D ^DIR
 I $D(DIRUT) Q
 S CODE=Y
 ;See if this is a valid code.
 S VALID=$$VCODE^PXRMLEX(CODE)
 I 'VALID W !,CODE," is not a valid code, try again." G GCODE
 S CODESYS=$$GETCSYS^PXRMLEX(CODE)
 ;DBIA #5679
 S CODESYSP=$P($$CSYS^LEXU(CODESYS),U,4)
 W !,"Searching for ",CODESYSP," code ",CODE
 D CSEARCH(CODESYS,CODE,.NFOUND,.TAXLIST)
 I NFOUND=0 W !,CODE," is not used in any taxonomies." G GCODE
 W !,CODESYSP," ",CODE," is used in the following taxonomies:"
 S TAX=""
 F  S TAX=$O(TAXLIST(TAX)) Q:TAX=""  W !," ",TAX
 G GCODE
 Q
 ; 
