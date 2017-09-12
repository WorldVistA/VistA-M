ECX3P8PT ;ALB/JAP - PATCH ECX*3*8 Post-Install ; July 14, 1998
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
 ;
POST ;Entry point
 ;update records in file #727.1
 D MOD7271^ECX3P8P3
 ;add records to file #727.2
 D ADD7272^ECX3P8P1
 ;add records to file #729
 D ADD729^ECX3P8P1
 ;modify records in file #730
 D MOD730^ECX3P8P2
 ;add new records to file #730
 D ADD730^ECX3P8P2
 Q
