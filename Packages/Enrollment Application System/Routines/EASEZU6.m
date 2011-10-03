EASEZU6 ;ALB/jap - Utilities for 1010EZ Processing ;10/31/00  13:08
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**53**;Mar 15, 2001
 ;
ANAME(EASLN,LN,DATANM) ;special update logic for Names     
 ;output UPDATE = new data entered by user thru input transform
 ;
 N SUBIEN,MULTIPLE,KEYIEN,DKEY,SECT,QUES,ORIGINAL,TYPE,XPART,KEY,SUB,NAME,UNAME,UPDATE,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S SUBIEN=$P(LN,U,1),MULTIPLE=$P(LN,U,2),KEYIEN=$P(LN,U,3)
 S DKEY=$P($G(^TMP("EZDATA",$J,KEYIEN)),U,4),SECT=$P(DKEY,";",1),QUES=$P(DKEY,";",2)
 S X=$G(^TMP("EZTEMP",$J,SECT,MULTIPLE,QUES))
 Q:$P(X,U,1)'=KEYIEN
 S ORIGINAL=$P(X,U,2) K X
 ;user may update each name part
 S TYPE=$P(DATANM," ",1)_" "
 F XPART="LAST","FIRST","MIDDLE","SUFFIX" D  Q:($D(DTOUT)!$D(DUOUT))
 .;have keyien & subien (above) for last name, but need to get for each part
 .S KEY=+$$KEY711^EASEZU1(TYPE_XPART_" NAME")
 .Q:KEY<1
 .;get name part & make sure it's all uppercase
 .S X=$$DATA712^EASEZU1(EASAPP,KEY,MULTIPLE)
 .S NAME(XPART)=$$UC^EASEZT1($P(X,U,1)),SUB(XPART)=$P(X,U,2) K X
 .S DIR("A")=TYPE_XPART_" NAME"
 .I XPART="LAST" S DIR("??")="No punctuation is allowed other than ""-"" in a hyphenated name."
 .E  S DIR("??")="No punctuation or numerics are allowed."
 .S X=$G(^EAS(711,KEY,3)) I X'="" X X
 .;1st piece of DIR contains 'O', input is optional
 .S:$G(DIR(0))="" DIR(0)="FO^1:30^K:X'?.A X"
 .D ^DIR
 .;don't continue if user exited w/o input
 .Q:($D(DTOUT)!$D(DUOUT))
 .;pickup the DIR output
 .S UPDATE=$$UC^EASEZT1($G(Y)),UNAME(XPART)=UPDATE
 .I UNAME(XPART)="" S UNAME(XPART)=$G(NAME(XPART))
 Q:($D(DTOUT)!$D(DUOUT))
 K DIR,DTOUT,DUOUT,DIRUT
 ;file data element; a manually updated element is always 'accepted'
 F XPART="LAST","FIRST","MIDDLE","SUFFIX" D
 .Q:$G(UNAME(XPART))=$G(NAME(XPART))  Q:$G(UNAME(XPART))=""
 .S DIE="^EAS(712,EASAPP,10,",DA=SUB(XPART),DA(1)=EASAPP,DR(1)="10;"
 .S DR="1///^S X=UNAME(XPART);1.1///^S X=1;1.2///^S X=DT;1.3////^S X=DUZ"
 .D ^DIE
 ;put together updated full name
 S X=UNAME("LAST")_","_UNAME("FIRST")
 I $G(UNAME("MIDDLE"))'="" D
 .I $L(X)+$L(UNAME("MIDDLE"))>45 S MDL=$E(UNAME("MIDDLE"),1),X=X_" "_MDL
 .E  S X=X_" "_UNAME("MIDDLE")
 I $G(UNAME("SUFFIX"))'="" S X=X_" "_UNAME("SUFFIX")
 S UPDATE=X
 S VALMBCK="R"
 ;update screen list
 Q:UPDATE=ORIGINAL
 D FLDTEXT^VALM10(EASLN,"EZDATA",UPDATE)
 D FLDCTRL^VALM10(EASLN,"EZDATA",IORVON,IORVOFF)
 D WRITE^VALM10(EASLN)
 Q
 ;
APHONE(EASLN,LN,DATANM) ;special update logic for Phone Numbers
 ;
 N SUBIEN,MULTIPLE,KEYIEN,DKEY,SECT,QUES,ORIGINAL,TYPE,XPART,KEY,SUB,PHONE,UPHONE,UPDATE,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S SUBIEN=$P(LN,U,1),MULTIPLE=$P(LN,U,2),KEYIEN=$P(LN,U,3)
 S DKEY=$P($G(^TMP("EZDATA",$J,KEYIEN)),U,4),SECT=$P(DKEY,";",1),QUES=$P(DKEY,";",2)
 S X=$G(^TMP("EZTEMP",$J,SECT,MULTIPLE,QUES))
 Q:$P(X,U,1)'=KEYIEN
 S ORIGINAL=$P(X,U,2) K X
 ;user may update each phone number part
 S TYPE=$P(DATANM," ",1,3)_" "
 F XPART="AREA CODE","NUMBER","EXTENSION" D  Q:($D(DTOUT)!$D(DUOUT))
 .;have keyien & subien (above) for area code, but need to get for each part
 .S KEY=+$$KEY711^EASEZU1(TYPE_XPART)
 .Q:KEY<1
 .;get phone number part
 .S X=$$DATA712^EASEZU1(EASAPP,KEY,MULTIPLE)
 .S PHONE(XPART)=$P(X,U,1),SUB(XPART)=$P(X,U,2) K X
 .S DIR("A")=TYPE_XPART
 .I XPART="NUMBER" S DIR("?")="Use format nnn-nnnn.  Example: 222-1234"
 .I XPART="EXTENSION" S DIR("?")="Use up to 5 digits; no other characters.  Example: 12345"
 .S X=$G(^EAS(711,KEY,3)) I X'="" X X
 .;1st piece of DIR contains 'O', input is optional
 .S:$G(DIR(0))="" DIR(0)="FO^1:8"
 .D ^DIR
 .;don't continue if user exited w/o input
 .Q:($D(DTOUT)!$D(DUOUT))
 .;pickup the DIR output
 .S UPDATE=$G(Y),UPHONE(XPART)=UPDATE
 .I UPHONE(XPART)="" S UPHONE(XPART)=$G(PHONE(XPART))
 Q:($D(DTOUT)!$D(DUOUT))
 K DIR,DTOUT,DUOUT,DIRUT
 ;file data element; a manually updated element is always 'accepted'
 F XPART="AREA CODE","NUMBER","EXTENSION" D
 .Q:$G(UPHONE(XPART))=$G(PHONE(XPART))  Q:$G(UPHONE(XPART))=""
 .S DIE="^EAS(712,EASAPP,10,",DA=SUB(XPART),DA(1)=EASAPP,DR(1)="10;"
 .S DR="1///^S X=UPHONE(XPART);1.1///^S X=1;1.2///^S X=DT;1.3////^S X=DUZ"
 .D ^DIE
 ;put together updated full phone number
 S X=$G(UPHONE("NUMBER"))
 I $G(UPHONE("AREA CODE")) S X="("_UPHONE("AREA CODE")_")"_X
 I $G(UPHONE("EXTENSION"))'="" S X=X_" X"_UPHONE("EXTENSION")
 S UPDATE=X
 S VALMBCK="R"
 ;update screen list
 Q:UPDATE=ORIGINAL
 D FLDTEXT^VALM10(EASLN,"EZDATA",UPDATE)
 D FLDCTRL^VALM10(EASLN,"EZDATA",IORVON,IORVOFF)
 D WRITE^VALM10(EASLN)
 Q
 ;
ASTATE(EASLN,LN,DATANM) ;special update logic for any STATE
 ;
 N I,SUBIEN,MULTIPLE,KEYIEN,ORIGINAL,IEN,ABBR,AB,ZX,OUT,UPDATE,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S SUBIEN=$P(LN,U,1),MULTIPLE=$P(LN,U,2),KEYIEN=$P(LN,U,3)
 S ORIGINAL=$P($G(^TMP("EZDATA",$J,KEYIEN,MULTIPLE,1)),U,1)
 S DIR("A")=DATANM
 S DIR(0)="P^5:EMZ"
 D ^DIR
 ;don't continue if user exited w/o input
 Q:($D(DTOUT)!$D(DUOUT))
 K DIR,DTOUT,DUOUT,DIRUT
 ;pickup the DIR output
 S UPDATE=$P($G(Y(0)),U,1)
 ;don't continue if no data
 Q:UPDATE=""
 ;don't continue if no change to data
 Q:UPDATE=ORIGINAL
 S IEN=$P(Y,U,1)
 S ABBR=$P($G(^DIC(5,IEN,0)),U,2)
 ;make sure abbrev. matches web-based app
 S OUT=0 F I=1:1 S X=$P($T(STDAT+I),";;",2) Q:X="QUIT"  Q:OUT  D
 .S AB=$P(X,";",1),ZX=$P(X,";",2)
 .I (ZX[UPDATE)!(UPDATE[ZX) S ABBR=AB,OUT=1
 ;file data element; a manually updated element is always 'accepted'
 S DIE="^EAS(712,EASAPP,10,",DA=SUBIEN,DA(1)=EASAPP,DR(1)="10;"
 S DR="1///^S X=ABBR;1.1///^S X=1;1.2///^S X=DT;1.3////^S X=DUZ"
 D ^DIE
 S VALMBCK="R"
 ;update screen list
 D FLDTEXT^VALM10(EASLN,"EZDATA",UPDATE)
 D FLDCTRL^VALM10(EASLN,"EZDATA",IORVON,IORVOFF)
 D WRITE^VALM10(EASLN)
 Q
 ;
STDAT ;
 ;;AS;AMERICAN SAMOA
 ;;DC;DISTRICT OF COLUMBIA
 ;;FM;FEDERATED STATES OF MICRONESIA
 ;;GU;GUAM
 ;;MH;MARSHALL ISLANDS
 ;;MP;NORTHERN MARIANA ISLANDS
 ;;PW;PALAU (TRUST TERRITORY)
 ;;PR;PUERTO RICO
 ;;VI;VIRGIN ISLANDS
 ;;QUIT
 ;
ACOUNTY(EASLN,LN,DATANM) ;special update logic for COUNTY
 ;
 N SUBIEN,MULTIPLE,KEYIEN,ORIGINAL,KEY,ABBR,STATE,SIEN,CIEN,CCODE,ROOT,UPDATE,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S LN=^TMP("EASEXP",$J,"IDX",EASLN),SUBIEN=$P(LN,U,1),MULTIPLE=$P(LN,U,2),KEYIEN=$P(LN,U,3)
 S ORIGINAL=$P($G(^TMP("EZDATA",$J,KEYIEN,MULTIPLE,1)),U,1)
 S KEY=+$$KEY711^EASEZU1("APPLICANT STATE")
 Q:'KEY
 S ABBR="",STATE="",SIEN="",CIEN="",CCODE=""
 I KEY D
 .S ABBR=$P($$DATA712^EASEZU1(EASAPP,KEY,1),U,1)
 .I ABBR'="" S STATE=$$STATE^EASEZT1(ABBR)
 .I STATE'="" S SIEN=$O(^DIC(5,"B",STATE,0))
 Q:'SIEN
 S ROOT="DIC(5,"_SIEN_",1,"
 S DIR("A")=DATANM
 S DIR(0)="P"_U_ROOT_":QEMZ"
 D ^DIR
 ;don't continue if user exited w/o input
 Q:($D(DTOUT)!$D(DUOUT))
 K DIR,DTOUT,DUOUT,DIRUT
 ;pickup the DIR output
 S UPDATE=$P($G(Y(0)),U,1)
 ;don't continue if no data
 Q:UPDATE=""
 S CIEN=$P(Y,U,1) I CIEN'="" S CCODE=$P($G(^DIC(5,SIEN,1,CIEN,0)),U,3)
 S COUNTY=UPDATE I CCODE'="" S UPDATE=UPDATE_" ("_CCODE_")"
 ;don't continue if no change to data
 Q:UPDATE=ORIGINAL
 ;file data element; a manually updated element is always 'accepted'
 S DIE="^EAS(712,EASAPP,10,",DA=SUBIEN,DA(1)=EASAPP,DR(1)="10;"
 S DR="1///^S X=COUNTY;1.1///^S X=1;1.2///^S X=DT;1.3////^S X=DUZ"
 D ^DIE
 S VALMBCK="R"
 ;update screen list
 D FLDTEXT^VALM10(EASLN,"EZDATA",UPDATE)
 D FLDCTRL^VALM10(EASLN,"EZDATA",IORVON,IORVOFF)
 D WRITE^VALM10(EASLN)
 Q
 ;
ASSN(EASLN,LN,DATANM,ACCEPT) ;special update logic for Spouse/Dependent SSN
 N OUT,DIR,DIRUT,DTOUT,DUOUT,UPDATE,LINK13,OTHER,RESULT
 ;only used if DATANM["SOCIAL SECURITY NUMBER" and FILE'=2
 S OUT=0,UPDATE="" F  D  Q:OUT
 .S DIR("A")=DATANM
 .S DIR(0)="F^11:11^K:X'?3N1""-""2N1""-""4N X",DIR("?")="Use format nnn-nnn-nnn.  Example: 222-33-4444"
 .D ^DIR
 .I $D(DIRUT) S OUT=1 Q
 .I ($D(DTOUT)!$D(DUOUT)) S OUT=1 Q
 .;pickup the DIR output
 .S UPDATE=$P($G(Y(0)),U,1) S:UPDATE="" UPDATE=$P($G(Y),U,1)
 .;don't continue if no data
 .I UPDATE="" S OUT=1 Q
 .S UPDATE=$TR(UPDATE,"-","")
 .S LINK13=$P($G(^EAS(712,EASAPP,10,SUBIEN,2)),U,2)
 .S RESULT="",OTHER=0
 .F  S OTHER=$O(^DGPR(408.13,"SSN",UPDATE,OTHER)) Q:OTHER=""  Q:RESULT="^"  I OTHER,LINK13,OTHER'=LINK13 D
 ..S RESULT="^"
 ..W !,?3,"Sorry... that SSN is already used by another person"
 ..W !,?3,"in the INCOME PERSON File (#408.13).  Try again."
 .I RESULT="^" S UPDATE=""
 .I UPDATE'="" S OUT=1
 ;file the update, if any
 Q:UPDATE=""
 I 'ACCEPT S ACCEPT=1
 S SUBIEN=$P(LN,U,1),MULTIPLE=$P(LN,U,2),KEYIEN=$P(LN,U,3)
 S $P(^TMP("EZDATA",$J,KEYIEN,MULTIPLE,1),U,1,2)=UPDATE_U_ACCEPT
 ;file data element; any manually updated element is 'accepted'
 S DIE="^EAS(712,EASAPP,10,",DA=SUBIEN,DA(1)=EASAPP,DR(1)="10;"
 S DR="1.5///^S X=UPDATE;1.1///^S X=ACCEPT;1.2///^S X=DT;1.3////^S X=DUZ"
 D ^DIE
 S VALMBCK="R"
 ;update screen list
 D FLDTEXT^VALM10(EASLN,"EZDATA",UPDATE)
 D FLDCTRL^VALM10(EASLN,"EZDATA",IORVON,IORVOFF)
 D WRITE^VALM10(EASLN)
 Q
