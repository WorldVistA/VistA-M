UKOP6LEX ; OSE/SMH - Lexicon Utilites for Korea;May 02, 2019@11:39
 ;;0.1;KOREA SPECIFIC MODIFICATIONS;;
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
EN(path,file) ; [Public] Main Entry point for loading the KCD7 CSV
 K ^TMP($J)
 N % S %=$$FTG^%ZISH(path,file,$NA(^TMP($J,0)),2)
 i '% w "error loading file...",! quit
 ;
 ; Deleting first
 w "Deleting US entries...",!
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
TEST ; [Public] This runs on the code on my machine
 D EN("/cygdrive/c/Users/Hp/Documents/OSEHRA/p6/","KCD7.csv")
 quit
 ;
TRAN ; [KIDS] Transport CSV file in KIDS global
 ; ZEXCEPT: XPDGREF,XPDQUIT
 D SAVDEV^%ZISUTL("XPDTRAN")
 n path s path="/cygdrive/c/Users/Hp/Documents/OSEHRA/p6/"
 n file s file="KCD7.csv"
 N % S %=$$FTG^%ZISH(path,file,$na(@XPDGREF@(0)),$QL(XPDGREF)+1)
 i '% w "error loading file...",! s XPDQUIT=1 quit
 D USE^%ZISUTL("XPDTRAN")
 D RMDEV^%ZISUTL("XPDTRAN")
 quit
 ;
POST ; [KIDS] Post Install
 ; ZEXCEPT: XPDGREF
 D DEL
 ;
 ; Allow us to play with the lexicon
 S ^DD(757.01,.01,"LAYGO",1,0)="I 1"
 ;
 n fields,stats
 n i f i=0:0 s i=$o(@XPDGREF@(i)) q:'i  do 
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
 ;
 ; Apparently, this is needed because Lex adds dots to all ICD-10 codes for lookup
 if dx'["." set dx=dx_"."
 ;
 if isCateg do ADDCATEG(dx,ko) if 1
 else  do ADD(dx,ko,en)
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
 ; so = 757.02 ien       (code ien)
 ; mc = 757/757.001 ien  (major concept)
 ; ex = 757.01 ien       (expression)
 ; sm = 757.1 ien        (semantic map)
 ;
 ; Delete ICD-10 from codes file
 D MES^XPDUTL("Deleting ICD-10 codes from Lexicon")
 n so,ex,mc,sm,zso,cs,DA,DIK,zsm
 s so=4999999
 f  s so=$o(^LEX(757.02,so)) q:so>6999999  do
 . s zso=^LEX(757.02,so,0)
 . s cs=$p(zso,U,3)
 . i cs'=30 quit
 . s DA=so,DIK="^LEX(757.02," W:'(DA#100) "." D ^DIK
 quit
 ;
DELICD ; [Private] Delete ICD-10 codes from ICD-10 file
 D MES^XPDUTL("Deleting ICD-10 codes from ICD file")
 n DIK s DIK="^ICD9("
 n DA s DA=499999
 f  s DA=$o(^ICD9(DA)) q:'DA  W:'(DA#100) "." do ^DIK
 quit
 ;
DELCAT ; [Private] Delete ICD-10 Categories from Lexicon
 D MES^XPDUTL("Deleting ICD-10 Categories from Lexicon")
 n DIK s DIK="^LEX(757.033,"
 n DA s DA=4999999
 f  s DA=$o(^LEX(757.033,DA)) q:DA>6999999  q:'DA  do
 . n z s z=^LEX(757.033,DA,0)
 . W:'(DA#100) "."
 . i $e(z,1,3)="10D" do ^DIK
 quit
 ;
ADD(code,ko,en) ; [Private] Add Korean Lexicon Entries
 D ADDICD(code,ko)
 D ADDLEX(code,ko,en)
 QUIT
 ;
ADDICD(code,text) ; [Private] Add ICD-10 Entry to ICD file
 n lastien s lastien=$o(^ICD9(" "),-1)
 if lastien<500001 s lastien=500001
 else  s lastien=lastien+1
 w:'(lastien#100) "."
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
 n DIC s DIC="ICD9("
 d UPDATE^DIE(,"fda","fdai")
 i $d(DIERR) s $ec=",U-error,"
 quit
 ;
ADDLEX(code,ko,en) ; [Private] Add ICD-10 Entry to Lexicon
 w "adding ",code," ",en,!
 n mc,ex,so,sm,DIERR,DIC
 n newmc s newmc=0
 ;
 ; Find English Expression in Expressions file
 ; if found, set exression, major concept and semantic map iens
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
 . s mc=$o(^LEX(757,6999999),-1)+1
 . i mc<5000001 s mc=5000001
 . s sm=$o(^LEX(757.1,6999999),-1)+1
 . i sm<5000001 s sm=5000001
 ;
 ; Always get a new expression number
 ; (the expression is a new one in Korean)
 s ex=$o(^LEX(757.01,6999999),-1)+1
 i ex<5000001 s ex=5000001
 ;
 ; Get a new code ien, but try the ICD-10 space since we deleted it
 ; It doesn't matter, but I would like to reuse the numbers
 n i f i=5000001:1 i '$d(^LEX(757.02,i)) quit
 set so=i
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
 . ; 6 and 6 are hardcoded for ICD-10.
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
 ; Expression (contains actual ICD-10 text)
 n fda,fdai
 s fdai(1)=ex
 s fda(757.01,"+1,",.01)=ko
 s fda(757.01,"+1,",1)=mc
 s fda(757.01,"+1,",2)=1    ; Major Concept
 s fda(757.01,"+1,",3)="D"  ; Direct
 s fda(757.01,"+1,",4)=1    ; Major Concept
 s DIC="^LEX(757.01,"
 d UPDATE^DIE(,"fda","fdai")
 i $d(DIERR) s $ec=",U-error,"
 ;
 ; Add English Expression as a synomym
 if newmc do
 . n ex ; hide other expression
 . s ex=$o(^LEX(757.01,6999999),-1)+1
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
 . ;
 ; Codes w/ activation date (ICD-10 code)
 ; This file links Expression to major conepts and code
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
 s DIC="^LEX(757.02,"
 d UPDATE^DIE(,"fda","fdai")
 i $d(DIERR) s $ec=",U-error,"
 quit
 ;
ADDCATEG(code,text) ; [Private] Add ICD-10 Category to Lexicon
 w "Category: "_code_": "_text,!
 n fda,fdai,DIERR,DIC
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
 ;
 ; subfile indexes don't get indexed, so try this
 N DA,DIK
 S DA=fdai(1),DIK="^LEX(757.033," D IX1^DIK
 ;
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
LEXANAL ; [Public] Analyze Pointer Structures in Lexicon
 n so,ex,mc,sm,zso,cs,DA,DIK,zsm,icd10only,total
 s (icd10only,total)=0
 s so=4999999
 f  s so=$o(^LEX(757.02,so)) q:so>6999999  do
 . s zso=^LEX(757.02,so,0)
 . s cs=$p(zso,U,3)
 . i cs'=30 quit
 . s ex=$p(zso,U,1)
 . s mc=$p(zso,U,4)
 . s sm=$o(^LEX(757.1,"B",mc,""))
 . n exc,i s (exc,i)=0 f  s i=$o(^LEX(757.02,"B",ex,i)) q:'i  s exc=exc+1
 . n mcc,i s (mcc,i)=0 f  s i=$o(^LEX(757.02,"AMC",mc,i)) q:'i  s mcc=mcc+1
 . n smc,i s (smc,i)=0 f  s i=$o(^LEX(757.1,"B",mc,i)) q:'i  s smc=smc+1
 . s total=total+1
 . i exc=1,mcc=1,smc=1 s icd10only=icd10only+1 quit
 . w so,?10,ex,"(",exc,")",?22,mc,"(",mcc,")",?34,sm,"(",smc,")",!
 . ; w "sm (757.1)",?15,sm
 . ; w ?30,"->",?35,^LEX(757.1,sm,0),!
 . ; w "ex (757.01)",?15,ex
 . ; w ?30,"->",?35,^LEX(757.01,ex,0),!
 . ; w "mc (757)",?15,mc
 . ; w ?30,"->",?35,^LEX(757,mc,0),!
 . ; w "so (757.02)",?15,so
 . ; w ?30,"->",?35,^LEX(757.02,so,0),!
 w "icd 10 only: ",icd10only,"/",total,!!
 quit
 ;
 s ex=4999999
 f  s ex=$o(^LEX(757.01,ex)) q:ex>6999999  do
 . n zex s zex=^LEX(757.01,ex,1)
 . n mc s mc=$p(zex,U)
 . n mcc,i s (mcc,i)=0 f  s i=$o(^LEX(757.01,"AMC",mc,i)) q:'i  s mcc=mcc+1
 . i mcc=1 quit  ; there are no ICD-10 expressions w more than one concept!!
 . w ex,?10,mc,"(",mcc,")",zex,!
 ;
 s sm=0
 f  s sm=$o(^LEX(757.1,sm)) q:sm>6999999  do
 . s zsm=^LEX(757.1,sm,0)
 . s mc=$p(zsm,U,1)
 . n sc s sc=$p(zsm,U,2) ; Semantic Class
 . n st s st=$p(zsm,U,3) ; Semantic Type
 . n mcc,i s (mcc,i)=0 f  s i=$o(^LEX(757.1,"B",mc,i)) q:'i  s mcc=mcc+1
 . i mcc=1 quit  ; 6 entries
 . w mc,"(",mcc,")",sc," ",st,!
 quit
 ;
