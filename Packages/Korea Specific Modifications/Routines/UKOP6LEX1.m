UKOP6LEX1 ; OSE/SMH - Lexicon Utilites for Korea;Mar 08, 2019@14:05
 ;;0.1;KOREA SPECIFIC MODIFICATIONS;;
 ;
 ; This routine is a demo of loading KCD7 as another terminology
 ; rather than replacing ICD-10
 ;
 ; (c) Sam Habiel 2019
 ; Licensed under Apache 2.0
 ;
 ; General note: DIC is set in UPDATE^DIE call because one of the Lexicon 
 ; x-refs requires it (AWRD on 757.01). 
 ; 
 ; The current version of Fileman in VistA does not define for DIC for DBS
 ; calls. This was fixed in MSC Fileman around 2015.
 ;
EN2(path,file) ; [Public] Demo of loading this as another terminlogy -->
 K ^TMP($J)
 N % S %=$$FTG^%ZISH(path,file,$NA(^TMP($J,0)),2)
 i '% w "error loading file...",! quit
 ;
 ; ... rather than replacing ICD-10
 ; First, make sure you have no changes, and then load this
 ; Allow us to play with the lexicon
 S ^DD(757.01,.01,"LAYGO",1,0)="I 1"
 ;
 n kcd s kcd=$$KCDCREAT ; Create the KCD-7 coding system.
 ;
 n fields
 n i f i=0:0 s i=$o(^TMP($j,i)) q:'i  do 
 . ; parse the fields
 . do PARSE(.fields,^(i))
 . ;
 . ; print to screen
 . do WRITE(.fields)
 . ;
 . ; Load the data
 . if fields(10)=1 do PROCESS2(.fields,0,kcd) ; Patient Care Selectable Code
 . if fields(3)="소" do PROCESS2(.fields,1,kcd) ; Load Category
 ;
 ; Seal off lexicon again
 S ^DD(757.01,.01,"LAYGO",1,0)="I 0"
 ;
 quit
 ;
KCDCREAT() ; [Public] Create the KCD-7 as a new terminology
 n fda,DIERR,fdai
 s fda(757.03,"?+1,",.01)="KCD7" ; Source Abbreviation
 s fda(757.03,"?+1,",1)="KCD-7"  ; Nomenclature
 s fda(757.03,"?+1,",2)="Korean ICD-10" ; Source Title
 s fda(757.03,"?+1,",3)="Korea" ; Source
 s fda(757.03,"?+1,",4)=19187   ; Active Codes
 s fda(757.03,"?+1,",5)=19187   ; Codes
 s fda(757.03,"?+1,",11)=2700000 ; Implementation Date
 s fda(757.03,"?+1,",12)=20000  ; Search Threshold
 d UPDATE^DIE(,"fda","fdai")
 i $d(DIERR) s $ec=",U-ERROR,"
 quit fdai(1)
 ;
TEST2 ; [Public] This runs on the code on my machine
 D EN2("/cygdrive/c/Users/Hp/Documents/OSEHRA/p6/","KCD7.csv")
 quit
 ;
 ; ** THIS ONE IS A DANGEROUS ONE TO RUN. RUN THE MUPIP LOAD FIRST MANUALLY
 ;   TO MAKE SURE IT WORKS! **
RESTORE ; [PRIVATE] [Restore the original files]
 K ^ICD9
 K ^LEX(757)
 K ^LEX(757.001)
 K ^LEX(757.01)
 K ^LEX(757.02)
 K ^LEX(757.1)
 zsy "$gtm_dist/mupip load "_$ZD_"/lex_backup.zwr"
 K ^LEX(757.033)
 zsy "$gtm_dist/mupip load "_$ZD_"/lex_backup_cp.zwr"
 quit
 ;
PARSE(fields,line) ; [Private] Parse a CSV line
 ; w !,"new line: ",line
 n fieldCnt s fieldCnt=0
 n q s q=""""
 n cLoc s cLoc=0 ; comma Location
 n prevLoc s prevLoc=1 ; previous comma Location
 n error s error=0
 f cLoc=0:0 s cLoc=$find(line,",",cLoc) q:'cLoc  do  q:error
 . n field s field=$e(line,prevLoc,cLoc-2)
 . i field[q d  ; field is quoted
 .. n matchingQuote s matchingQuote=$find(line,q,cLoc)
 .. i 'matchingQuote w "error 1",! s error=1 quit
 .. i $e(line,matchingQuote)'=","!($e(line,matchingQuote)="") w "error 2",! s error=1 quit
 .. s fieldCnt=fieldCnt+1
 .. s field=$e(line,prevLoc+1,matchingQuote-2) ; don't include quotes
 .. s fields(fieldCnt)=field
 .. ; w !,cLoc," ",prevLoc," ",field
 .. s (cLoc,prevLoc)=matchingQuote+1 ; go beyond the comma after the quote
 . e  d
 .. s fieldCnt=fieldCnt+1
 .. s fields(fieldCnt)=field
 .. ; w !,cLoc," ",prevLoc," ",field
 .. s prevLoc=cLoc
 s fieldCnt=fieldCnt+1
 s field=$e(line,prevLoc,$l(line))
 s fields(fieldCnt)=field
 ; w !,cLoc," ",prevLoc," ",field
 ; r x
 quit
 ;
WRITE(fields) ; [Private] Write to the screen the data of the fields array
 n cat s cat=fields(3)
 n dx  s dx=fields(4)
 n ko  s ko=fields(7)
 n en  s en=fields(8)
 n sel s sel=fields(10)
 ; n ien s ien=$$CODEABA^ICDEX(dx,80,30)
 w cat," ",dx," ",ko," ",en," ",sel,!
 quit
 ;
PROCESS2(fields,isCateg,kcd) ; [Private] Add the data to VistA
 ; isCateg = is this an ICD-10 category rather than just an ordinary code?
 n dx s dx=fields(4)
 n ko s ko=fields(7)
 n en s en=fields(8)
 if isCateg do ADDCATEG2(dx,ko) if 1
 else  do ADDLEX2(dx,ko,en,kcd)
 quit
 ;
ADDCATEG2(code,text) ; [Private] Add KCD-7 Category to Lexicon
 w "Category: "_code_": "_text,!
 n fda,fdai,DIERR,DIC
 n cp s cp=$o(^LEX(757.033,411000000),-1)+1
 i cp<410000001 s cp=410000001
 s fdai(1)=cp
 ;
 ; Code and Date added
 s fda(757.033,"+1,",.01)="KCD7"_code
 s fda(757.033,"+1,",.02)=code
 s fda(757.033,"+1,",.03)=DT
 s fda(757.033,"+1,",.04)=30
 ;
 ; status
 s fda(757.331,"+2,+1,",.01)=2700000
 s fda(757.331,"+2,+1,",.02)=1
 ;
 ; name/title
 s fda(757.332,"+3,+1,",.01)=2700000
 s fda(757.332,"+3,+1,",.02)=text
 ;
 ; description
 s fda(757.043,"+4,+1,",.01)=2700000
 s fda(757.043,"+4,+1,",.02)=text
 ;
 s DIC="^LEX(757.033,"
 d UPDATE^DIE(,"fda","fdai")
 i $d(DIERR) s $ec=",U-error,"
 quit
 ;
ADDLEX2(code,ko,en,kcd) ; [Private] Add KCD7 Entry to Lexicon
 w "adding ",code," ",en,!
 n mc,ex,so,sm,DIERR,DIC
 n newmc s newmc=0
 ;
 ; Find English Expression in Expressions file
 ; if found, set major concept and semantic map iens
 ; TODO, maybe later: This can be better. Just get concepts that are active.
 D FIND^DIC(757.01,,"@","QX",$$UP^XLFSTR(en))
 if $get(^TMP("DILIST",$J,0)) do
 . n tmpex
 . s tmpex=^TMP("DILIST",$J,$O(^TMP("DILIST",$J,0)),1)
 . s mc=$p(^LEX(757.01,tmpex,1),U)
 . s sm=$o(^LEX(757.1,"B",mc,""))
 ;
 ; Otherwise create new entries in these files
 ; Make sure that the IEN is in the ICD-10 numberspace but not in SNOMED-CT
 else  do
 . s newmc=1
 . s mc=$o(^LEX(757,411000000),-1)+1
 . i mc<410000001 s mc=410000001
 . s sm=$o(^LEX(757.1,411000000),-1)+1
 . i sm<410000001 s sm=410000001
 ;
 ; Always get a new expression number
 ; (the expression is a new one in Korean)
 s ex=$o(^LEX(757.01,411000000),-1)+1
 i ex<410000001 s ex=410000001
 ;
 ; Get a new code ien
 s so=$o(^LEX(757.02,411000000),-1)+1
 i so<410000001 s so=410000001
 ;
 w mc," ",ex," ",so," ",sm,!!
 ;
 if newmc do
 . ; File Major Concept (only itself and pointer to the future expression entry)
 . n fda,fdai
 . s fdai(1)=mc
 . s fda(757,"+1,",.01)=ex
 . s fda(757,"+1,",1)=""
 . s DIC="^LEX(757,"
 . d UPDATE^DIE(,"fda","fdai")
 . i $d(DIERR) s $ec=",U-error,"
 . ;
 . ; Concept Frequency (always DINUMMED to Major Concept). 
 . ; 6 and 6 are hardcoded for ICD-10. Don't know if needs to change for KCD-7.
 . n fda,fdai
 . s fdai(1)=mc
 . s fda(757.001,"+1,",.01)=mc
 . s fda(757.001,"+1,",1)=6
 . s fda(757.001,"+1,",2)=6
 . s DIC="^LEX(757.001,"
 . d UPDATE^DIE(,"fda","fdai")
 . i $d(DIERR) s $ec=",U-error,"
 . ;
 . ; Semantic Map
 . n fda,fdai
 . s fdai(1)=sm
 . s fda(757.1,"+1,",.01)=mc
 . s fda(757.1,"+1,",1)=6    ; 6  = Diseases/Pathological Processes
 . s fda(757.1,"+1,",2)=47   ; 47 = Disease or Syndrome
 . s DIC="^LEX(757.1,"
 . d UPDATE^DIE(,"fda","fdai")
 . i $d(DIERR) s $ec=",U-error,"
 ;
 ; Expression (contains actual KCD-7 text)
 ; If we are adding a new expression, the Korean goes in as the Major Concept
 ; and the English goes in as the synonym.
 ; Otherwise, if we are adding an expression whose English form already exists,
 ; the Korean needs to become a Synonym
 ;
 ; New concept: Korean as Major Concept and English as Synonym
 if newmc do
 . n fda,fdai
 . s fdai(1)=ex
 . s fda(757.01,"+1,",.01)=ko
 . s fda(757.01,"+1,",1)=mc
 . s fda(757.01,"+1,",2)=1    ; Major Concept
 . s fda(757.01,"+1,",3)="D"  ; Direct
 . s fda(757.01,"+1,",4)=1    ; Major Concept
 . s DIC="^LEX(757.01,"
 . d UPDATE^DIE(,"fda","fdai")
 . i $d(DIERR) s $ec=",U-error,"
 . ;
 . n ex ; hide other expression
 . s ex=$o(^LEX(757.01,411000000),-1)+1
 . n fda,fdai
 . s fdai(1)=ex
 . s fda(757.01,"+1,",.01)=en
 . s fda(757.01,"+1,",1)=mc
 . s fda(757.01,"+1,",2)=2    ; Synonym
 . s fda(757.01,"+1,",3)="D"  ; Direct
 . s fda(757.01,"+1,",4)=12   ; Form = Other
 . s DIC="^LEX(757.01,"
 . d UPDATE^DIE(,"fda","fdai")
 . i $d(DIERR) s $ec=",U-error,"
 ;
 ; Existing Concept: English is Major concept, Korean is Synonym
 ; English already exists, so we don't do anything. We just add Korean.
 else  do
 . n fda,fdai
 . s fdai(1)=ex
 . s fda(757.01,"+1,",.01)=ko
 . s fda(757.01,"+1,",1)=mc
 . s fda(757.01,"+1,",2)=2    ; Type = Synonym
 . s fda(757.01,"+1,",3)="D"  ; Direct
 . s fda(757.01,"+1,",4)=12   ; Form = Other
 . s DIC="^LEX(757.01,"
 . d UPDATE^DIE(,"fda","fdai")
 . i $d(DIERR) s $ec=",U-error,"
 ;
 ; Codes w/ activation date (ICD-10 code)
 ; This file links Expression to major conepts and code
 n fda,fdai
 s fdai(1)=so
 s fda(757.02,"+1,",.01)=ex
 s fda(757.02,"+1,",1)=code
 s fda(757.02,"+1,",2)=kcd
 s fda(757.02,"+1,",3)=mc
 s fda(757.02,"+1,",4)=1 ; preferred term
 s fda(757.02,"+1,",6)=1 ; primary code
 s fda(757.28,"+2,+1,",.01)=2700000  ; Activation date
 s fda(757.28,"+2,+1,",1)=1          ; Active
 s DIC="^LEX(757.02,"
 d UPDATE^DIE(,"fda","fdai")
 i $d(DIERR) s $ec=",U-error,"
 quit
