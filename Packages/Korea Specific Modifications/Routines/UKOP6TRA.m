UKOP6TRA ; OSE/SMH - OSEHRA Plan VI Translation API Calls &c;Dec 14, 2018@11:12
 ;;1.0;OSEHRA;
 ;
 QUIT
 ;
EXAMPLE ; [Example Usage]
 ;
 ; First create dialogs for all of the menu system
 D MENUDLG
 ;
 ; Then translate a specific menu menually, or use the automated translater here
 D TRAMENU("XUCORE")
 ;
 QUIT
 ;
TRAN(string,from,to,error) ; [Public $$] Translate string to another language
 ; Input: string (req) - string to translate
 ;          from (req) - language to translate from
 ;            to (req) - language to translate to
 ;        .error (opt) - a way to positively identify an error
 ;
 ; output: Translated string; or error number ^ error message
 ;
 ; Put the data into the JSON format the API wants
 ; NB: The VistA JSON encoder ALWAYS assumes that the top level entry is an object
 ;     That's why I add '[' and ']' to create an array rather than let the encoder do it.
 ;     I would like to fix that, but I don't want to today.
 n osedata s osedata("Text")=string
 n oseSendJSON d ENCODE^XLFJSON("osedata","oseSendJSON")
 s oseSendJSON(1)="["_oseSendJSON(1)_"]"
 ;
 ; url
 n url s url="https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&from="_from_"&to="_to
 ;
 ; API secret key & headers
 n key s key=$$ENV^%ZOSV("msTranslateAPIKey")
 i key="" w !!,"MS Translation API key not installed. quitting..." quit
 n oseguid D GETGUID^MDCLIO1(.oseguid)
 n oseSendHeaders
 s oseSendHeaders("Ocp-Apim-Subscription-Key")=key
 s oseSendHeaders("Content-Type")="application/json"
 s oseSendHeaders("X-ClientTraceId")=oseguid
 ;
 ; API call
 n oseOutput,oseHeaders
 n status s status=$$GETURL^XTHC10(url,1,"oseOutput",.oseHeaders,"oseSendJSON",.oseSendHeaders)
 n i f i=0:0 s i=$o(oseOutput(i)) q:'i  do
 . n j f j=0:0 s j=$o(oseOutput(i,j)) q:'j  s oseOutput(i)=oseOutput(i)_oseOutput(i,j)
 ;
 ; Decode JSON
 n oseTran
 d DECODE^XLFJSON("oseOutput","oseTran")
 ;
 ; Send back the translation or the error
 n out
 i status=200 s out=oseTran(1,"translations",1,"text")
 e  d 
 . s out=oseTran("error","code")_U_oseTran("error","message")
 . s error=out
 quit out
 ;
TEST D EN^%ut($T(+0),3) QUIT
T1 ; @TEST Run Translation Test
 n out s out=$$TRAN("Hello, what is your name?","en","ko")
 w out,!
 quit
 ;
MENUDLG ; [Public] Menu System Dialog File Creation 
 ; DIALOG NUMBER: 1012400.0028             TYPE: GENERAL MESSAGE
 ; PACKAGE: ORDER ENTRY/RESULTS REPORTING
 ; SHORT DESCRIPTION: Active Problems
 ;
 ; TEXT:
 ; Active Problems
 ; LANGUAGE: KOREAN
 ;  FOREIGN TEXT:
 ;  xxxxxx
 ;
 ; Dialog entries naming scheme: 
 ; - 19000.nnnnn1  for menu text
 ; - 19000.nnnnn35 for description
 ;
 n krnPkg s krnPkg=$$FIND1^DIC(9.4,,"QX","KERNEL","B")
 ;
 ; Delete everything
 D DELTRA
 ;
 n i f i=0:0 s i=$o(^DIC(19,i)) q:'i  do
 . n optionName  s optionName=$p(^DIC(19,i,0),U,1)
 . n englishText s englishText=$p(^DIC(19,i,0),U,2)
 . n osewp,% s %=$$GET1^DIQ(19,i,3.5,,"osewp")
 . ;
 . ; file menu text entry
 . n fda,ien,iens
 . n DIERR
 . s ien=19000+(i/100000)_1 ; e.g. menu text for 22 will go into 19000.000221
 . s iens(1)=ien
 . s fda(.84,"+1,",.01)=ien
 . s fda(.84,"+1,",1)=2 ; GENERAL MESSAGE
 . s fda(.84,"+1,",1.2)=krnPkg ; PACKAGE
 . s fda(.84,"+1,",1.3)=$e(optionName,1,42) ; SHORT DESCRIPTION
 . n osetext s osetext(1)=englishText ; wp field
 . s fda(.84,"+1,",4)="osetext" ; TEXT
 . d UPDATE^DIE("","fda","iens")
 . i $d(DIERR) s $ec=",u-error,"
 . ;
 . ; file description
 . i $o(osewp(0)) d
 .. k fda
 .. s ien=19000+(i/100000)_35
 .. s iens(1)=ien
 .. s fda(.84,"+1,",.01)=ien
 .. s fda(.84,"+1,",1)=2
 .. s fda(.84,"+1,",1.2)=krnPkg
 .. s fda(.84,"+1,",1.3)=$e(optionName,1,30)_" DESCRIPTION"
 .. s fda(.84,"+1,",4)="osewp" ; TEXT
 .. d UPDATE^DIE("","fda","iens")
 .. i $d(DIERR) s $ec=",u-error,"
 . w i," "
 quit
 ;
TRAMENU(menuName) ; [Public] Menu System Translation
 n menuIEN s menuIEN=$$FIND1^DIC(19,,"QX",menuName,"B")
 q:'menuIEN
 ;
 ; Start collecting menus to translate - main menu
 n menusToTranslate
 s menusToTranslate(menuIEN)=""
 ;
 ; Start collecting menus to translate - submenus
 n subMenuIEN s subMenuIEN=0
 f  s subMenuIEN=$O(^DIC(19,menuIEN,10,subMenuIEN)) q:'subMenuIEN  do
 . n z s z=^DIC(19,menuIEN,10,subMenuIEN,0)
 . n childMenuIEN s childMenuIEN=$p(z,U)
 . s menusToTranslate(childMenuIEN)=""
 ;
 ; Now loop through each one and translate
 n eachMenuIEN s eachMenuIEN=0
 d INIT^XTHC10(0)
 f  s eachMenuIEN=$O(menusToTranslate(eachMenuIEN)) q:'eachMenuIEN  do TRAONE(eachMenuIEN)
 d CLEANUP^XTHC10
 ;
 ; Now apply the menu translation to the menu system
 f  s eachMenuIEN=$O(menusToTranslate(eachMenuIEN)) q:'eachMenuIEN  do APPLYONE(eachMenuIEN)
 quit
 ;
TRAONE(menuIEN) ; [Public] Translate one menu to DUZ("LANG") language
 ;
 ; if no DUZ("LANG") quit
 if $get(DUZ("LANG"))<2 quit
 ;
 ; iens for menu text and description
 n dlgien1,dlgien2
 s dlgien1=19000+(menuIEN/100000)_1
 s dlgien2=19000+(menuIEN/100000)_35
 ;
 ; language two letter code (lowercase)
 n to s to=$$LOW^XLFSTR($$GET1^DIQ(.85,DUZ("LANG"),.02))
 ;
 ; Translate first entry (menu text)
 if $data(^DI(.84,dlgien1,0)) do
 . n oseEnglishText,% S %=$$GET1^DIQ(.84,dlgien1,4,,"oseEnglishText")
 . n englishText s englishText=oseEnglishText(1)
 . n furrinText  s furrinText=$$TRAN(englishText,"en",to)
 . s furrinText=furrinText_$e("   ",$l(furrinText)+1,3) ; add up to 3 spaces if shorter than 3 (min for option)
 . ;
 . ; File the foreign text
 . n furrinTextWP s furrinTextWP(1)=furrinText
 . n fda,iens
 . s iens(1)=DUZ("LANG")
 . s fda(.847,"?+1,"_dlgien1_",",.01)=DUZ("LANG")
 . s fda(.847,"?+1,"_dlgien1_",",1)="furrinTextWP"
 . n DIERR
 . d UPDATE^DIE(,"fda","iens")
 . i $d(DIERR) s $ec=",u-error,"
 . w "translated ",dlgien1," which is ",englishText," to ",furrinText,!
 ;
 ; Translate second entry (description)
 if $data(^DI(.84,dlgien2,0)) do
 . ; get wp field and put in one string for web service
 . n oseEnglishText,% S %=$$GET1^DIQ(.84,dlgien2,4,,"oseEnglishText")
 . n englishText s englishText=""
 . n i f i=0:0 s i=$o(oseEnglishText(i)) q:'i  s englishText=englishText_oseEnglishText(i)_" "
 . s $e(englishText,$l(englishText))="" ; remove trailing space
 . n furrinText s furrinText=$$TRAN(englishText,"en",to)
 . ;
 . ; File the foreign text
 . k ^UTILITY($J,"W")
 . N X,DIWL,DIWR,DIWF
 . S X=furrinText
 . S DIWL=1,DIWR=80,DIWF=""
 . D ^DIWP
 . n furrinTextWP m furrinTextWP=^UTILITY($J,"W",1)
 . n fda,iens
 . s iens(1)=DUZ("LANG")
 . s fda(.847,"?+1,"_dlgien2_",",.01)=DUZ("LANG")
 . s fda(.847,"?+1,"_dlgien2_",",1)="furrinTextWP"
 . n DIERR
 . d UPDATE^DIE(,"fda","iens")
 . i $d(DIERR) s $ec=",u-error,"
 . w "translated ",dlgien2," which is ",englishText," to ",furrinText,!
 quit
 ;
APPLYONE(menuIEN) ; [Public] Apply DUZ("LANG") language translation to menu system
 ; if no DUZ("LANG") quit
 if $get(DUZ("LANG"))<2 quit
 ;
 ; iens for menu text and description
 n dlgien1,dlgien2
 s dlgien1=19000+(menuIEN/100000)_1
 s dlgien2=19000+(menuIEN/100000)_35
 ;
 n fda,%,oseFurrinTextWP
 if $data(^DI(.84,dlgien1,0)) do
 . s %=$$GET1^DIQ(.847,DUZ("LANG")_","_dlgien1_",",1,,"oseFurrinTextWP")
 . n furrinText s furrinText=oseFurrinTextWP(1)
 . k oseFurrinTextWP
 . s fda(19,menuIEN_",",1)=furrinText
 ;
 if $data(^DI(.84,dlgien2,0)) do
 . S %=$$GET1^DIQ(.847,DUZ("LANG")_","_dlgien2_",",1,,"oseFurrinTextWP")
 . s fda(19,menuIEN_",",3.5)="oseFurrinTextWP"
 ;
 N DIERR
 d FILE^DIE("E","fda")
 i $d(DIERR) s $ec=",u-error,"
 quit
 ;
RESTORE ; [Public] Restore all the menus back to English
 ;
 ; Set language to English to get English Dialogs
 s DUZ("OLDLANG")=$G(DUZ("LANG"))
 s DUZ("LANG")=1
 ;
 ; Loop through every menu
 n menuIEN f menuIEN=0:0 s menuIEN=$o(^DIC(19,menuIEN)) q:'menuIEN  do
 . w menuIEN," "
 . n optionName  s optionName=$p(^DIC(19,menuIEN,0),U,1)
 . n menuText    s menuText=$p(^DIC(19,menuIEN,0),U,2)
 . ;
 . ; iens for menu text and description
 . n dlgien1,dlgien2
 . s dlgien1=19000+(menuIEN/100000)_1
 . s dlgien2=19000+(menuIEN/100000)_35
 . ;
 . ; Get English Text. If same as current menu text, quit (menu not translated)
 . n englishText s englishText=$$EZBLD^DIALOG(dlgien1)
 . i englishText="" quit
 . i englishText=menuText quit
 . ;
 . ; put english menu text and description back
 . n fda,DIERR,oseEngDesc
 . s fda(19,menuIEN_",",1)=englishText
 . if $data(^DI(.84,dlgien2,0)) do
 .. D BLD^DIALOG(dlgien2,,,"oseEngDesc")
 .. s fda(19,menuIEN_",",3.5)="oseEngDesc"
 . d FILE^DIE("","fda")
 . i $d(DIERR) s $ec=",u-error,"
 ;
 ; Get our language back
 S DUZ("LANG")=DUZ("OLDLANG")
 quit
 ;
DELTRA ; [Public] Delete Menu system translations
 ;
 ; Restore English Translations
 TSTART ()
 D RESTORE
 ;
 ; kill all old entries
 W "Killing Old Entries"
 n DA,DIK s DIK="^DI(.84,"
 n i f i=19000:0 s i=$o(^DI(.84,i)) q:i=""  q:i'<19001  w i," " s DA=i d ^DIK
 TCOMMIT
 quit
