ENFAXMT2 ;WASHINGTON IRMFO/KLD/DH/SAB; CREATE CODE SHEET ;12/16/1998
 ;;7.0;ENGINEERING;**29,60**;Aug 17, 1993
 ;This routine should not be modified.
SEND ; Add code sheet to Generic Code Sheet (GCS) stack
 ; create GCS code sheet
 D CONTROL^GECSUFMS("E",ENFAP("SITE"),ENFAP("TRANS"),ENFAP("DOC"),ENFAP("AO"),0,"","ENFAXMT")
 ; send remaining segments to GCS
 F I=1:1:4 D:$D(X(I)) SETCS^GECSSTAA(GECSFMS("DA"),X(I))
 ; save copy of code sheet in ENG log file
 D @ENFAP("DOC")
 ; set code sheet status to Queue on GCS stack
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 K GECSFMS
 Q
 ;
FA ;copy FA
 S ^ENG(6915.2,ENFA("DA"),1)=$P(GECSFMS("CTL"),"^~")
 S ^ENG(6915.2,ENFA("DA"),2)=$P(GECSFMS("DOC"),U)
 S ^ENG(6915.2,ENFA("DA"),3)=$P(X(1),U,1,9)_U_$P(X(1),U,11,20)_U_$P(X(1),U,22,32)_U_$P(X(1),U,21)
 S ^ENG(6915.2,ENFA("DA"),6)=$P(X(3),"^~")
 S ^ENG(6915.2,ENFA("DA"),7)=$P(X(4),U,1,2)_U_$P(X(4),U,10)
 Q
 ;
FB ;copy FB
 S ^ENG(6915.3,ENFB("DA"),1)=$P(GECSFMS("CTL"),"^~")
 S ^ENG(6915.3,ENFB("DA"),2)=$P(GECSFMS("DOC"),U)
 S ^ENG(6915.3,ENFB("DA"),3)=$P(X(1),U,1,4)_U_$P(X(1),U,10,17)
 S ^ENG(6915.3,ENFB("DA"),4)=$P(X(2),U)_"^^^"_$P(X(2),U,8)
 S ^ENG(6915.3,ENFB("DA"),5)=$P(X(3),"^~")
 S ^ENG(6915.3,ENFB("DA"),6)=$P(X(4),U)_U_$P(X(4),U,2)_U_$P(X(4),U,10)
 Q
 ;
FC ;copy FC
 S ^ENG(6915.4,ENFC("DA"),1)=$P(GECSFMS("CTL"),"^~")
 S ^ENG(6915.4,ENFC("DA"),2)=$P(GECSFMS("DOC"),U)
 S ^ENG(6915.4,ENFC("DA"),3)=$P(X(1),U,1,4)_U_$P(X(1),U,10)_U_$P(X(1),U,12,21)
 S ^ENG(6915.4,ENFC("DA"),4)=$P(X(2),U)_U_$P(X(2),U,6)_U_$P(X(2),U,8,10)_U_$P(X(2),U,12,18)_U_$P(X(2),U,20)_U_$P(X(2),U,22,24)
 S ^ENG(6915.4,ENFC("DA"),5)=$P(X(3),"^~")
 S ^ENG(6915.4,ENFC("DA"),6)=$P(X(4),U,1,2)_U_$P(X(4),U,10)
 Q
 ;
FD ;copy FD
 S ^ENG(6915.5,ENFD("DA"),1)=$P(GECSFMS("CTL"),"^~")
 S ^ENG(6915.5,ENFD("DA"),2)=$P(GECSFMS("DOC"),U)
 S ^ENG(6915.5,ENFD("DA"),3)=$P(X(1),U,1,4)_U_$P(X(1),U,10)
 S ^ENG(6915.5,ENFD("DA"),4)=$P(X(3),"^~")
 S ^ENG(6915.5,ENFD("DA"),5)=$P(X(4),"^~")
 Q
 ;
FR ;copy FR
 S ^ENG(6915.6,ENFR("DA"),1)=$P(GECSFMS("CTL"),"^~")
 S ^ENG(6915.6,ENFR("DA"),2)=$P(GECSFMS("DOC"),U)
 S ^ENG(6915.6,ENFR("DA"),3)=$P(X(1),U,1,4)_U_$P(X(1),U,10,13)_U_$P(X(1),U,15,24)
 Q
 ;ENFAXMT2
