DBAM2KID ; Save patches to HFS files in respective folders ;12/14/98  10:56
 ; Get Mail Basket
 ; Order through all messages
 ; Parse on subject for patch namespace\version
 ; Save each under <patch>.txt for instructions and <patch>.kid for build
 S HOME=$I
 K REDLIST
 I '$D(DUZ) D ^XUP
 S DIC="^XMB(3.7,DUZ,2,",DIC(0)="AEMQZ",DIC("A")="Select Basket: " D ^DIC G:Y<0 EXIT S BASKET=+Y
 S DIR(0)="F^2:60",DIR("A")="Full path, up to but not including patch names" D ^DIR G:Y="^" EXIT S ROOT=Y
 S MESSAGE=0 F  S MESSAGE=$O(^XMB(3.7,DUZ,2,BASKET,1,MESSAGE)) Q:MESSAGE'>0  D  I $D(POP) G:POP ERROR
 . S SUBJECT=$P($G(^XMB(3.9,MESSAGE,0)),U) S NAME=$P($P(SUBJECT,"*")," ",$S(SUBJECT["EMERGENCY":3,1:2)) Q:'$L(NAME)  Q:'$O(^DIC(9.4,"C",NAME,""))
 . S VER=$P(SUBJECT,"*",2),NUM=$P($P(SUBJECT,"*",3)," "),SEQ=$P(SUBJECT,"SEQ #",2)
 . S PATCH=NAME_"-"_$TR(VER,".","p")_"_SEQ-"_SEQ_"_PAT-"_NUM
 .;
 .K ^TMP($J)
 .M ^TMP($J,"MSG")=^XMB(3.9,MESSAGE,2)
 .;
GETTXT .D   ; GET TEXT
 ..;
 ..S LINE=.99 F  S LINE=$O(^TMP($J,"MSG",LINE)) Q:LINE'>0  S TEXT=^TMP($J,"MSG",LINE,0) D ADDLINE("TEXT",TEXT) Q:TEXT["$END TXT"
 .;
GETKID .D   ; GET KIDS
 ..;
 ..s line=.99 F  S LINE=$O(^TMP($J,"MSG",LINE)) Q:LINE'>0  S TEXT=^TMP($J,"MSG",LINE,0) Q:TEXT["$KID"
 ..Q:TEXT'["$KID"
 ..I (NAME_"*"_$S(VER[".":$S(VER<1:"0"_VER,1:VER),1:VER_".0")_"*"_NUM)'=$P(TEXT," ",2) W !,SUBJECT Q
 ..;
 ..D ADDLINE("KIDS",SUBJECT)
 ..D ADDLINE("KIDS","Extracted from mail message")
 ..D ADDLINE("KIDS","**KIDS**:"_NAME_"*"_$S(VER[".":$S(VER<1:"0"_VER,1:VER),1:VER_".0")_"*"_NUM_U)
 ..D ADDLINE("KIDS","")
 ..F  S LINE=$O(^TMP($J,"MSG",LINE)) Q:LINE'>0  S TEXT=^TMP($J,"MSG",LINE,0) Q:TEXT["$END KID"  D ADDLINE("KIDS",TEXT)
 ..D ADDLINE("KIDS","**END**")
 ..D ADDLINE("KIDS","**END**")
 ..D ADDLINE("KIDS","")
 .;
 .; REDACTION / NAME DELETION
 .;
 .D REDACT
 .;
 .D NAMES
 .;
 .;
SAVTXT .; SAVE TEXT
 .;
 .U HOME W !!
 .U HOME W !,"Saving file: ",ROOT,PATCH,".txt"
 .D OPEN^%ZISH("OUTFILE",ROOT,PATCH_".txt","W")
 .Q:POP
 .U IO
 .S LINE=0 F  S LINE=$O(^TMP($J,"TEXT",LINE)) Q:LINE'>0  S TEXT=^TMP($J,"TEXT",LINE)  W TEXT,!
 .D CLOSE^%ZISH("OUTFILE")
 .U HOME W "   done."
 .;
SAVKID .; SAVE KIDS
 .;
 .U HOME W !,"Saving file: ",ROOT,PATCH,".kids"
 .D OPEN^%ZISH("OUTFILE",ROOT,PATCH_".kids","W")
 .Q:POP
 .U IO
 .S LINE=0 F  S LINE=$O(^TMP($J,"KIDS",LINE)) Q:LINE'>0  S TEXT=^TMP($J,"KIDS",LINE)  W TEXT,!
 .D CLOSE^%ZISH("OUTFILE")
 .U HOME W "   done."
 ;
 W !!!,"Done"
 ;
 I $O(REDLIST("")) D
 .W !!,"Lines that need to be manually redacted:",!
 .S REDLIST="" F  S REDLIST=$O(REDLIST(REDLIST)) Q:'REDLIST  W !,REDLIST(REDLIST)
 ;
EXIT K BASKET,NAME,DIC,Y,DIR,ROOT,SUBJECT,PATCH,VER,POP,LINE,MESSAGE,TEXT
 Q
 ;
ADDLINE(SUB,TXT) ;
 ;
 S ^TMP($J,SUB)=$G(^TMP($J,SUB))+1
 S ^TMP($J,SUB,^TMP($J,SUB))=TXT
 ;
 Q
 ;
ERROR W !,"ERROR ON OPEN"
 G EXIT
 ;
REDACT ;
 ;
 ;
 F SUB="TEXT","KIDS" S D0=0 F  S D0=$O(^TMP($J,SUB,D0)) Q:'D0  D
 .S TEXT=$G(^TMP($J,SUB,D0)) Q:'$L(TEXT)
 .S TEXT=$$REPLACE(TEXT,"fo-albany.med.va.gov","domain.ext")
 .S TEXT=$$REPLACE(TEXT,"fo-hines.med.va.gov","domain.ext")
 .S TEXT=$$REPLACE(TEXT,"fo-slc.med.va.gov","domain.ext")
 .S TEXT=$$REPLACE(TEXT,"FO-ALBANY.MED.VA.GOV","DOMAIN.EXT")
 .S TEXT=$$REPLACE(TEXT,"FO-HINES.MED.VA.GOV","DOMAIN.EXT")
 .S TEXT=$$REPLACE(TEXT,"FO-SLC.MED.VA.GOV","DOMAIN.EXT")
 .S TEXT=$$REPLACE(TEXT,"anonymous.software","")
 .S TEXT=$$REPLACE(TEXT,"MED.VA.GOV","DOMAIN.EXT")
 .S TEXT=$$REPLACE(TEXT,"VA.GOV","DOMAIN.EXT")
 .S TEXT=$$REPLACE(TEXT,"med.va.gov","domain.ext")
 .S TEXT=$$REPLACE(TEXT,"va.gov","domain.ext")
 .;
 .I ($$UPCASE(TEXT)["VA.GOV") S REDLIST($G(REDLIST)+1)=TEXT
 .I ($$UPCASE(TEXT)?.E1"10."1.3N1"."1.3N1"."1.3N.E)  S REDLIST($G(REDLIST)+1)=TEXT
 .;
 .S ^TMP($J,SUB,D0)=TEXT
 ;
 Q
 ;
NAMES ;
 ;scan for names
 ;
 K NAMES
 F SUB="TEXT","KIDS" S LINE=0 F  S LINE=$O(^TMP($J,SUB,LINE)) Q:'LINE  D
 .S TEXT=$G(^TMP($J,SUB,LINE))
 .;
 .F STR="Entered By  : ","Completed By: ","Released By : ","$TXT Created by " I $$SW(TEXT,STR) D
 ..S NAME=$P(TEXT,STR,2)
 ..S NAME=$P(NAME," ",1,2)
 ..I $L(NAME) S NAMES(NAME)=1
 ;
 ;scrub names from file
 ;
 F SUB="TEXT","KIDS" S LINE=0 F  S LINE=$O(^TMP($J,SUB,LINE)) Q:'LINE  D
 .S TEXT=$G(^TMP($J,SUB,LINE))
 .S MODIF=0
 .;
 .S NAME="" F  S NAME=$O(NAMES(NAME)) Q:'$L(NAME)  I (TEXT[NAME) D  Q
 ..F  Q:'(TEXT[NAME)  S TEXT=$P(TEXT,NAME,1)_$E("                                                 ",1,$L(NAME))_$P(TEXT,NAME,2,$L(TEXT,NAME))
 ..S MODIF=1
 .;
 .I MODIF S ^TMP($J,SUB,LINE)=TEXT
 ;
 ;
 Q
 ;
 ;
SW(T,S) Q $E(T,1,$L(S))=S
 ;
REPLACE(T,S,R) ;
 ;
 F  Q:'(T[S)  S T=$P(T,S,1)_R_$P(T,S,2,$L(T,S))
 ;
 Q T
 ;
UPCASE(TEXT) Q $TR(TEXT,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
