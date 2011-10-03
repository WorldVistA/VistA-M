XQCHK3 ; OAK-BY/BDT - This routine for XQCHK; 5/20/08
 ;;8.0;KERNEL;**503**;Jul 10, 1995;Build 2
 ;;"Per VHA Directive 2004-038, this routine should not be modified".
 ;
 Q
OPACCES ;Entry point for the option that checks to see if a user has
 ;access to a particular option by calling the above function.
 N DIC,X,Y,XQANS,XQOPN,XQUSER,XQUSN,XQOPT
 ;get user
 S DIC(0)="AEMNQ",DIC="^VA(200,",DIC("A")="Please enter the user's name: " D ^DIC
 I $D(DUOUT)!($D(DTOUT)) D KILLFM Q
 I Y=-1 W !!?5,"Sorry we couldn't find that user in the New Person File.",! D KILLFM Q
 S XQUSN=+Y,XQUSER=$P(Y,U,2) D KILLFM
 ;get option
 S DIC(0)="AEMNQ",DIC="^DIC(19,",DIC("A")="Please enter the name of the option: " D ^DIC
 I $D(DUOUT)!($D(DTOUT)) D KILLFM Q
 I Y=-1 W !!?5,"Sorry we couldn't find that option.",! D KILLFM Q
 S XQOPN=+Y,XQOPT=$P(Y,U,2) D KILLFM
 ;check keys
 S XQANS=$$ACCESS(XQUSN,XQOPN)
 ;print out
 D PRINT(XQANS)
 Q
 ;
ACCESS(%XQUSR,%XQOP) ;Find out if a user has access to a particular option
 ;;W $$ACCESS(DUZ,Option IEN) returns:
 ;;
 ;;-1:no such user in the New Person File
 ;;-2: User terminated or has no access code
 ;;-3: no such option in the Option File
 ;;0: no access found in any menu tree the user owns
 ;;
 ;;All other cases return a 4-piece string stating
 ;;access ^ menu tree IEN ^ a set of codes ^ key
 ;;
 ;;O^tree^codes^key: No access because of locks (see XQCODES below)
 ;;where 'tree' is the menu where access WOULD be allowed
 ;;and 'key' is the key preventing access
 ;;
 ;;1^OpIEN^^: Access allowed through Primary Menu
 ;;2^OpIEN^codes^: Access found in the Common Options
 ;;3^OpIEN^codes^: Access found in top level of secondary option
 ;;4^OpIEN^codes^: Access through a the secondary menu tree OpIEN.
 ;;
 ;;XQCODES can contain:
 ;;N=No Primary Menu in the User File (warning only)
 ;;L=Locked and the user does not have the key (forces 0 in first piece)
 ;;R=Reverse lock and user has the key (forces 0 in first piece)
 ;
 N XQUSR,U S U="^"
 S XQUSR=$$ACTIVE^XUSER(%XQUSR)
 I XQUSR="" Q -1
 I +XQUSR=0 Q -2
 ;
 ;Convert %XQOP to its IEN if the name is passed
 I %XQOP'=+$G(%XQOP) D
 .I $D(^DIC(19,"B",%XQOP))<1 S %XQOP=0 Q
 .E  S %XQOP=$O(^DIC(19,"B",%XQOP,0))
 .Q
 I '%XQOP Q -3
 I '$D(^DIC(19,%XQOP,0)) Q -3
 ;checking
 N XQRT,XQRT1 S XQRT="",XQRT1=""
 S XQRT=$$CKPM(%XQUSR,%XQOP) ;primary menu and sub-menu in the primary menu
 I $P(XQRT,U)=1 Q XQRT
 I $P(XQRT,U)="N" Q XQRT
 S XQRT1=XQRT
 S XQRT=$$CKCM(%XQUSR,%XQOP) ;common menu
 I $P(XQRT,U)=2 Q XQRT
 I $P(XQRT,U)=0 S XQRT1=XQRT
 S XQRT=$$CKTSM(%XQUSR,%XQOP) ;top level of secondary menus
 I $P(XQRT,U)=3 Q XQRT
 I $P(XQRT,U)=0 S XQRT1=XQRT
 S XQRT=$$CKTESM(%XQUSR,%XQOP) ;sub-menu in secondary menus
 I $P(XQRT,U)=4 Q XQRT
 I $P(XQRT,U)=0 S XQRT1=XQRT
 I XQRT1="" S XQRT1=0
 Q XQRT1
 ;
CKPM(XQUSR,XQIEN) ;
 ;Look in the user's primary menu tree
 ;take in XQUSR = IEN in New Person file; XQIEN = IEN in the Option file
 ;Return = access ^ menu tree IEN ^ a set of codes ^ key
 N XQPM,XQDIC,XQTL,XQRT
 S XQPM=$P($G(^VA(200,XQUSR,201)),"^")
 I 'XQPM Q "N"
 ; check Lock on the Primary menu
 S XQRT=$$KEYSTOP(XQIEN,XQUSR)
 I XQRT'="OK" Q "0^"_XQPM_"^"_XQRT
 ; 
 S XQDIC="P"_XQPM
 I '$D(^XUTL("XQO",XQDIC,"^",XQIEN)) Q ""
 S XQTL=$P($G(^XUTL("XQO",XQDIC,"^",XQIEN)),"^",2,99)
 I XQTL="" Q ""
 S XQRT=$$KEYS(XQTL,XQUSR)
 I XQRT="OK" Q "1^"_XQPM
 Q "0^"_XQPM_"^"_XQRT
 ;
CKCM(XQUSR,XQIEN) ;
 ;Look in the user's primary menu tree
 ;take in XQUSR = IEN in New Person file; XQIEN = IEN in the Option file
 ;Return = access ^ menu tree IEN ^ a set of codes ^ key
 N XQTL,XQDIC,XQCOM,XQRT
 S XQCOM=$O(^DIC(19,"B","XUCOMMAND",0))
 S XQDIC="PXU"
 I '$D(^XUTL("XQO",XQDIC,"^",XQIEN)) Q "N"
 S XQTL=$P($G(^XUTL("XQO",XQDIC,"^",%XQOP)),"^",2,99)
 I XQTL="" Q ""
 S XQRT=$$KEYS(XQTL,XQUSR)
 I XQRT="OK" Q "2^"_"^^^"_XQCOM
 Q "0^"_"^"_XQRT_"^"_XQCOM
 ;
CKTSM(XQUSR,XQIEN) ;
 ;Look in the user's primary menu tree
 ;take in XQUSR = IEN in New Person file; XQIEN = IEN in the Option file
 ;Return = access ^ menu tree IEN ^ a set of codes ^ key
 N XQDIC,XQRT,XQTL
 S XQDIC="U"_XQUSR
 I '$D(^VA(200,XQUSR,203,"B",XQIEN)) Q "N"
 S XQTL=$P($G(^XUTL("XQO",XQDIC,"^",XQIEN)),"^",2,99)
 I XQTL="" Q ""
 S XQRT=$$KEYS(XQTL,XQUSR)
 I XQRT="OK" Q "3^"_XQIEN
 Q "0^"_XQIEN_"^"_XQRT
 ;
CKTESM(XQUSR,XQIEN) ;
 ;Look in the user's primary menu tree
 ;take in XQUSR = IEN in New Person file; XQIEN = IEN in the Option file
 ;Return = access ^ menu tree IEN ^ a set of codes ^ key
 N XQI,XQY,XQRT,XQDIC,XQTL S XQI=0,XQRT="",XQY=""
 F  S XQI=$O(^VA(200,XQUSR,203,"B",XQI)) Q:XQI'>0  D
 .S XQDIC="P"_XQI
 .S XQTL=$G(^XUTL("XQO",XQDIC,"^",XQIEN)) I XQTL="" Q
 .S XQTL=$P(XQTL,"^",2,99) I XQTL="" Q
 .S XQRT=$$KEYSTOP(XQI,XQUSR)
 .I XQRT="OK" S XQRT=$$KEYS(XQTL,XQUSR)
 .S XQY=XQI
 .I XQRT="OK" S XQI="ZZZ" Q
 I XQRT="OK" Q "4^"_XQY
 I XQRT="" Q XQRT
 Q "0^"_XQY_"^"_XQRT
 ;
KEYS(XQA,XQUSR) ;Check for keys, reverse keys...
 ;XQA         = ^XUTL("XQO",XQDIC,"^",%XQOP) or U_^DIC(19,%XQOP,0)
 ;XQUSR       = IEN user in the New Person #200 file
 ;Return XQRT = Null or Lock/ReLock if found
 ;
 N XQL,XQRL,XQRT S XQRT="OK"
 S XQL=$$CHCKL^XQCHK2(XQA,XQUSR) ;check for keys
 I +XQL>0 S XQRT="L^"_$P(XQL,"^",2)
 S XQRL=$$CHCKRL^XQCHK2(XQA,XQUSR) ;check for reverse keys
 I +XQRL>0 S XQRT="R^"_$P(XQRL,"^",2)
 Q XQRT
 ;
KEYSTOP(XQIEN,XQUSR) ;check Lock and Reversed Lock on the top level menu
 ;;XQIEN       = IEN option in the Option #19 file 
 ;;XQUSR       = IEN use in the New Person #200 file
 ;;Return XQRT = Null or Lock/ReLock if found
 N XQL,XQRL,XQRT S XQRT="OK"
 S XQL=$$CHKTOPL^XQCHK2(XQIEN,XQUSR) ;check for keys on top level
 I +XQL>0 S XQRT="L^"_$P(XQL,"^",2)
 S XQRL=$$CHKTOPRL^XQCHK2(XQIEN,XQUSR) ;check for reverse keys on top level
 I +XQRL>0 S XQRT="R^"_$P(XQRL,"^",2)
 Q XQRT
 ;
PRINT(XQANS) ; print out the result
 N XQRSLT,XQTREE,XQPTR,XQCODES,XQKEY
 S XQRSLT=+XQANS,XQTREE=""
 S XQPTR=$P(XQANS,U,2)
 I XQPTR>0 S XQTREE=$P(^DIC(19,$P(XQANS,U,2),0),U)
 S XQCODES=$P(XQANS,U,3),XQKEY=$P(XQANS,U,4)
 ;-------------------------------------------------------------------------------
 I XQRSLT=-1 W !!?5,"User ",XQUSER," is not in the New Person File."
 I XQRSLT=-2 W !!?5,"User ",XQUSER," has an active termination date,",!?5,"or no verify code."
 I XQRSLT=-3 W !!?5,"Option ",XQOPT," is not in the Option File."
 I XQRSLT=0 D
 .W !!?5,"User ",XQUSER," does not have access to the option",!?5,XQOPT,"."
 .I XQCODES["L" W !!?5,"There is a lock somewhere in the menu tree "_XQTREE,!?5,"and the user does not hold the key "_XQKEY_"."
 .I XQCODES["R" W !!?5,"There is a reverse lock somewhere in the menu tree "_XQTREE,!?5,"and the user holds the key "_XQKEY_"."
 .Q
 I XQRSLT=1 W !!?5,"User ",XQUSER," has access to the option ",XQOPT,!?5,"through the primary menu ",XQTREE," (",$P(^DIC(19,XQPTR,0),U,2),")."
 I XQRSLT=2 W !!?5,"User ",XQUSER," has access to the option ",XQOPT,!?5,"through the Common Options (XUCOMMAND)."
 I XQRSLT=3 W !!?5,"User ",XQUSER," has access to the option ",XQOPT,!?5,"as a top-level secondary menu option."
 I XQRSLT=4 W !!?5,"User ",XQUSER," has access to the option ",XQOPT,!?5,"through the secondary menu tree ",XQTREE," (",$P(^DIC(19,XQPTR,0),U,2),")."
 W !
 Q
 ;
KILLFM ;Kill off the FileMan variables
 K D0,DI,DIC,DIE,DISYS,DQ,DR,DUOUT,DTOUT,X,Y
 Q
