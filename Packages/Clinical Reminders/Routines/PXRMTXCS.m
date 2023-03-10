PXRMTXCS ; SLC/PKR - Taxonomy code search routines. ;05/13/2021
 ;;2.0;CLINICAL REMINDERS;**26,65**;Feb 04, 2005;Build 438
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
 ;=====================================================
UIDSEARCH(CODESYS,CODE,ENCOUNTERDT,CODELIST) ; Find all taxonomies that have this coding
 ;system code pair marked as UID and return all the active, on the encounter date, UID
 ;codes from that coding system that are marked as UID in those taxonomies. If the encounter
 ;date is not passed, the active check is skipped. The list is returned in CODELIST.
 ;CODELIST(UIDCODE)=Code Description
 ;CODELIST(UIDCODE,"TAX",TAXONOMY IEN)=""
 N ACTDT,ENCDATE,IEN,INACTDT,INACTIVE,NINACTDT,UIDCODE
 K CODELIST
 S ENCDATE=$P(+$G(ENCOUNTERDT),".",1)
 S IEN=0
 F  S IEN=+$O(^PXD(811.2,IEN)) Q:IEN=0  D
 . I $D(^PXD(811.2,IEN,20,"AUID",CODESYS,CODE)) D
 .. S UIDCODE=""
 .. F  S UIDCODE=$O(^PXD(811.2,IEN,20,"AUID",CODESYS,UIDCODE)) Q:UIDCODE=""  D
 ... S ACTDT=$O(^PXD(811.2,IEN,20,"AUID",CODESYS,UIDCODE,""))
 ... S INACTDT=$O(^PXD(811.2,IEN,20,"AUID",CODESYS,UIDCODE,ACTDT,""))
 ...;Make sure the code is active on the encounter date. If the
 ...;encounter date is in the future no codes will be returned.
 ... S INACTIVE=0
 ... I ENCDATE>0 D
 .... I ENCDATE<ACTDT S INACTIVE=1 Q
 .... S NINACTDT=$S(INACTDT="DT":DT,1:INACTDT)
 .... I ENCDATE>NINACTDT S INACTIVE=1
 ... I INACTIVE Q
 ... S CODELIST(UIDCODE)=^PXD(811.2,IEN,20,"AUID",CODESYS,UIDCODE,ACTDT,INACTDT)
 ... S CODELIST(UIDCODE,"TAX",IEN)=""
 Q
 ;
