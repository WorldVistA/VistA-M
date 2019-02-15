UKOP6LEX ; OSE/SMH - Lexicon Utilites for Korea;Feb 15, 2019@10:47
 ;;0.1;KOREA SPECIFIC MODIFICATIONS;;
 ;
 ;
EN(path,file) ; [Public] Main Entry point for loading the KCD7 CSV
 K ^TMP($J)
 N % S %=$$FTG^%ZISH(path,file,$NA(^TMP($J,0)),2)
 i '% w "error loading file...",!
 ;
 ; Deleting first
 w !,"Deleting US entries...",!
 D DEL
 ;
 ; Allow us to play with the lexicon
 S ^DD(757.01,.01,"LAYGO",1,0)="I 1"
 ;
 n fields,stats
 n i f i=0:0 s i=$o(^TMP($j,i)) q:'i  do 
 . ; parse the fields
 . do PARSE(.fields,^(i))
 . ;
 . ; print to screen
 . do WRITE(.fields)
 . ;
 . ; Load the data
 . if fields(10)=1 do PROCESS(.fields,0) ; Patient Care Selectable Code
 . if fields(3)="소" do PROCESS(.fields,1) ; Load Category
 ;
 ; Seal off lexicon again
 S ^DD(757.01,.01,"LAYGO",1,0)="I 0"
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
PROCESS(fields,isCateg) ; [Private] Add the data to VistA
 ; isCateg = is this an ICD-10 category rather than just an ordinary code?
 n dx s dx=fields(4)
 n ko s ko=fields(7)
 n en s en=fields(8)
 if isCateg do ADDCATEG(dx,ko) if 1
 else  do ADD(dx,ko)
 quit
 ;
ANAL(fields,stats) ; [No longer used] Analyze the ICD-10 codes compared with those in VistA
 n dx s dx=fields(4)
 n ko s ko=fields(7)
 n en s en=fields(8)
 n ien s ien=$$CODEABA^ICDEX(dx,80,30)
 s stats("total")=$g(stats("total"))+1
 i ien<0 s stats("notFound")=$g(stats("notFound"))+1
 e       s stats("found")=$g(stats("found"))+1
 quit
 ;
 ;
BACKUP ; [PRIVATE] [Backup the files before modifying them] - See BACKUP2 as well
 N POP
 N % S %=$$OPEN^%ZISH("",$ZD,"lex_backup.zwr","W")
 I $G(POP) w "error" quit
 U IO
 write "GT.M MUPIP EXTRACT UTF-8",!
 write "04-FEB-2019  10:46:22 ZWR",!
 zwrite ^ICD9
 zwrite ^LEX(757,*)
 zwrite ^LEX(757.001,*)
 zwrite ^LEX(757.01,*)
 zwrite ^LEX(757.02,*)
 zwrite ^LEX(757.1,*)
 D CLOSE^%ZISH
 QUIT
 ;
BACKUP2 ; [PRIVATE] [Extra file backup]
 N POP
 N % S %=$$OPEN^%ZISH("",$ZD,"lex_backup_cp.zwr","W")
 I $G(POP) w "error" quit
 U IO
 write "GT.M MUPIP EXTRACT UTF-8",!
 write "04-FEB-2019  10:46:22 ZWR",!
 zwrite ^LEX(757.033,*)
 D CLOSE^%ZISH
 QUIT
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
DEL ; [Public] Delete the Old ICD-10 codes
 D DELLEX
 D DELICD
 D DELCAT
 QUIT
 ;
DELLEX ; [Private] Delete ICD-10 codes from Lexicon
 ;
 ; This should delete everything, but doesn't. It deletes most of it though.
 ; pending further investigation.
 ; I have a feeling I am deleting far more than I need to; but I don't know
 ; any better now. Need to investigate why:
 ; 1. Entries in pointed to files are not in the ICD-10 range
 ; 2. Are these entries being shared by other coding systems
 ;
 ; so = 757.02 ien       (code ien)
 ; mc = 757/757.001 ien  (major concept)
 ; ex = 757.01 ien       (expression)
 ; sm = 757.1 ien        (semantic map)
 ;
 ; Delete ICD-10 starting from codes file
 n so,ex,mc,sm,zso,DA,DIK,zsm
 s so=4999999
 f  s so=$o(^LEX(757.02,so)) q:so>6999999  do
 . s zso=^LEX(757.02,so,0)
 . s ex=$p(zso,U,1)
 . s mc=$p(zso,U,4)
 . s sm=$o(^LEX(757.1,"B",mc,""))
 . w so," ",ex," ",mc," ",sm,!
 . ;
 . ; Now delete the entries
 . ; Semantic Map first
 . s DA=sm,DIK="^LEX(757.1," D ^DIK
 . ;
 . ; now expression
 . s DA=ex,DIK="^LEX(757.01," D ^DIK
 . ;
 . ; now major concept
 . s DA=mc f DIK="^LEX(757,","^LEX(757.001," D ^DIK
 . ;
 . ; last code system
 . s DA=so,DIK="^LEX(757.02," D ^DIK
 ;
 ; Delete ICD-10 starting from expressions file
 s ex=4999999
 f  s ex=$o(^LEX(757.01,ex)) q:ex>6999999  do
 . n zex s zex=^LEX(757.01,ex,1)
 . w zex,!
 . s mc=$p(zex,U)
 . ; now expression
 . s DA=ex,DIK="^LEX(757.01," D ^DIK
 . ;
 . ; now major concept
 . s DA=mc f DIK="^LEX(757,","^LEX(757.001," D ^DIK
 ;
 ; Now delete leftovers starting from semantic types file
 s sm=4999999
 f  s sm=$o(^LEX(757.1,sm)) q:sm>6999999  do
 . s zsm=^LEX(757.1,sm,0)
 . s mc=$p(zsm,U,1)
 . n sc s sc=$p(zsm,U,2) ; Semantic Class
 . n st s st=$p(zsm,U,3) ; Semantic Type
 . i sc'=6 quit          ; 6  = Diseases/Pathological Processes
 . i st'=47 quit         ; 47 = Disease or Syndrome
 . i mc<5000000 quit     ; numberspace for ICD-10
 . i mc>6999999 quit     ; ditto
 . w sm," ",zsm," ",mc,!
 . ;
 . ; now major concept
 . s DA=mc f DIK="^LEX(757,","^LEX(757.001," D ^DIK
 . ;
 . ; Semantic Map last
 . s DA=sm,DIK="^LEX(757.1," D ^DIK
 ;
 ; Now delete Sam's left overs 757/757.001
 s mc=4999999
 f  s mc=$o(^LEX(757,mc)) q:mc>6999999  do
 . w mc,!
 . s DA=mc f DIK="^LEX(757,","^LEX(757.001," D ^DIK
 quit
 ;
DELICD ; [Private] Delete ICD-10 codes from ICD-10 file
 n DIK s DIK="^ICD9("
 n DA s DA=499999
 f  s DA=$o(^ICD9(DA)) q:'DA  W:'(DA#100) "." do ^DIK
 quit
 ;
DELCAT ; [Private] Delete ICD-10 Categories from Lexicon
 n DIK s DIK="^LEX(757.033,"
 n DA s DA=4999999
 f  s DA=$o(^LEX(757.033,DA)) q:DA>6999999  W DA," " q:'DA  do ^DIK
 quit
 ;
ADD(code,text) ; [Private] Add Korean Lexicon Entries
 D ADDICD(code,text)
 D ADDLEX(code,text)
 QUIT
 ;
ADDICD(code,text) ; [Private] Add ICD-10 Entry to ICD file
 n lastien s lastien=$o(^ICD9(" "),-1)
 if lastien<500001 s lastien=500001
 else  s lastien=lastien+1
 w lastien," "
 n fda,fdai,DIERR
 n iens s iens="+1,"
 s fda(80,"+1,",.01)=code
 s fda(80,"+1,",1.1)=30             ; ICD-10 Clinical
 s fda(80.066,"+2,+1,",.01)=2700000 ; effective date
 s fda(80.066,"+2,+1,",.02)=1       ; Status = active
 s fda(80.067,"+3,+1,",.01)=2700000 ; effective date
 s fda(80.067,"+3,+1,",1)=text      ; Short Description
 s fda(80.068,"+4,+1,",.01)=2700000 ; effective date
 s fda(80.068,"+4,+1,",1)=text      ; Long Description
 s fdai(1)=lastien
 d UPDATE^DIE(,"fda","fdai")
 i $d(DIERR) s $ec=",U-error,"
 quit
 ;
ADDLEX(code,text) ; [Private] Add ICD-10 Entry to Lexicon
 n mc,ex,so,sm,DIERR
 ;
 ; Get the IEN, and then DINUM the other IENS to it.
 ; Make sure that the IEN is in the ICD-10 numberspace but not in SNOMED-CT
 s mc=$o(^LEX(757,6999999),-1)+1
 i mc<5000001 s mc=5000001
 s (ex,so,sm)=mc
 w mc,!
 ;
 ; File Major Concept (only itself and pointer to the future expression entry)
 n fda,fdai
 s fdai(1)=mc
 s fda(757,"+1,",.01)=ex
 s fda(757,"+1,",1)=""
 d UPDATE^DIE(,"fda","fdai")
 i $d(DIERR) s $ec=",U-error,"
 ;
 ; Concept Frequency (always DINUMMED to Major Concept). 6 and 6 are hardcoded 
 ; for ICD-10.
 n fda,fdai
 s fdai(1)=mc
 s fda(757.001,"+1,",.01)=mc
 s fda(757.001,"+1,",1)=6
 s fda(757.001,"+1,",2)=6
 d UPDATE^DIE(,"fda","fdai")
 i $d(DIERR) s $ec=",U-error,"
 ;
 ; Expression (contains actual ICD-10 text)
 n fda,fdai
 s fdai(1)=ex
 s fda(757.01,"+1,",.01)=text
 s fda(757.01,"+1,",1)=mc
 s fda(757.01,"+1,",2)=1    ; Major Concept
 s fda(757.01,"+1,",3)="D"  ; Direct
 s fda(757.01,"+1,",4)=1    ; Major Concept
 d UPDATE^DIE(,"fda","fdai")
 i $d(DIERR) s $ec=",U-error,"
 ;
 ; Codes w/ activation date (ICD-10 code)
 ; This file links Expression to major cocepts and code
 n fda,fdai
 s fdai(1)=so
 s fda(757.02,"+1,",.01)=ex
 s fda(757.02,"+1,",1)=code
 s fda(757.02,"+1,",2)=30 ; ICD-10
 s fda(757.02,"+1,",3)=mc
 s fda(757.02,"+1,",4)=1 ; preferred term
 s fda(757.02,"+1,",6)=1 ; primary code
 s fda(757.28,"+2,+1,",.01)=2700000  ; Activation date
 s fda(757.28,"+2,+1,",1)=1          ; Active
 d UPDATE^DIE(,"fda","fdai")
 i $d(DIERR) s $ec=",U-error,"
 ;
 ; Semantic Map
 n fda,fdai
 s fdai(1)=sm
 s fda(757.1,"+1,",.01)=mc
 s fda(757.1,"+1,",1)=6    ; 6  = Diseases/Pathological Processes
 s fda(757.1,"+1,",2)=47   ; 47 = Disease or Syndrome
 d UPDATE^DIE(,"fda","fdai")
 i $d(DIERR) s $ec=",U-error,"
 ;
 quit
 ;
ADDCATEG(code,text) ; [Private] Add ICD-10 Category to Lexicon
 w "Category: "_code_": "_text,!
 n fda,fdai,DIERR
 n cp s cp=$o(^LEX(757.033,6999999),-1)+1
 i cp<5000001 s cp=5000001
 s fdai(1)=cp
 ;
 ; Code and Date added
 s fda(757.033,"+1,",.01)="10D"_code
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
 d UPDATE^DIE(,"fda","fdai")
 i $d(DIERR) s $ec=",U-error,"
 quit
 ;
CHKLEX ; [Public] Check the number of entries in each of the lex files for ICD-10
 n file
 f file=757,757.001,757.01,757.02,757.033,757.1 do
 . n cnt s cnt=0
 . n ien s ien=4999999
 . n gl s gl=$$ROOT^DILFD(file,"",1)
 . f  s ien=$o(@gl@(ien)) q:ien>6999999  q:'ien  s cnt=cnt+1
 . w file," -> ",cnt,!
 ;
 f file=80,80.1 do
 . n cnt s cnt=0
 . n ien s ien=499999
 . n gl s gl=$$ROOT^DILFD(file,"",1)
 . f  s ien=$o(@gl@(ien)) q:'ien  s cnt=cnt+1
 . w file," -> ",cnt,!
 quit
 ;
TEST ; [Public] This runs on the code on my machine
 D EN("/cygdrive/c/Users/Hp/Documents/OSEHRA/p6/","KCD7.csv")
 quit
