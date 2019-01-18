UKOP6LEX ; OSE/SMH - Lexicon Utilites for Korea;Jan 18, 2019@13:21
 ;;0.1;KOREA SPECIFIC MODIFICATIONS;;
 ;
TEST ;
 D EN("/cygdrive/c/Users/Hp/Documents/OSEHRA/p6/","KCD7-active.csv")
 quit
 ;
EN(path,file) ; [Public] Main Entry point for loading the KCD7 CSV
 K ^TMP($J)
 N % S %=$$FTG^%ZISH(path,file,$NA(^TMP($J,0)),2)
 i '% w "error loading file...",!
 ;
 ; parse the fields
 n fields,stats
 n i f i=0:0 s i=$o(^TMP($j,i)) q:'i  do 
 . do PARSE(.fields,^(i))
 . do WRITE(.fields)
 . do ANAL(.fields,.stats)
 . ; do PROCESS(.fields)
 zwrite stats
 ;
 ; field 3 = ICD-10 dx
 ; field 6 = Korean Text
 ; field 7 = English Text
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
WRITE(fields) ;
 n dx s dx=fields(3)
 n ko s ko=fields(6)
 n en s en=fields(7)
 n ien s ien=$$CODEABA^ICDEX(dx,80,30)
 w ien," ",dx," ",ko," ",en,!
 quit
 ;
PROCESS(fields) ;
 n dx s dx=fields(3)
 n ko s ko=fields(6)
 n en s en=fields(7)
 quit
 ;
ANAL(fields,stats) ; 
 n dx s dx=fields(3)
 n ko s ko=fields(6)
 n en s en=fields(7)
 n ien s ien=$$CODEABA^ICDEX(dx,80,30)
 s stats("total")=$g(stats("total"))+1
 i ien<0 s stats("notFound")=$g(stats("notFound"))+1
 e       s stats("found")=$g(stats("found"))+1
 quit
 ;
BACKUP ; [PRIVATE] [Backup the files before modifying them]
 K ^UKOBACKUP
 M ^UKOBACKUP(80)=^ICD9
 M ^UKOBACKUP(757.01)=^LEX(757.01)
 quit
 ;

