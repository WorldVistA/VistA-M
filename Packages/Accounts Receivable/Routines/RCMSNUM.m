RCMSNUM ;WASH-ISC@ALTOONA,PA/RGY-Assign Common Numbering Series ;1/11/96  11:40 AM
V ;;4.5;Accounts Receivable;**27,114,172**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
BNUM(SITE) ;Get next bill number
 NEW NUM
 L +^RC(342,"RCMSNUM"):15 I '$T Q "-1^Common Numbering series driver is busy"
 S NUM=$P($G(^RC(342,1,0)),"^",3),SITE=$G(SITE)
 I NUM="" D BNUM^PRCABJ S NUM=$P($G(^RC(342,1,0)),"^",3)
 I NUM="" L -^RC(342,"RCMSNUM") Q "-1^Cannot get bill number from site parameter file"
 S NUM=$$NUM^RCMSNUM(SITE,NUM)
 S:NUM>0 $P(^RC(342,1,0),"^",3)=$P(NUM,"-",2)
 L -^RC(342,"RCMSNUM")
 Q NUM
 ;
 ;
ENUM(SITE) ;Get next event number
 NEW NUM
 L +^RC(342,"RCMSNUM"):15 I '$T Q "-1^Common Numbering series driver is busy"
 S NUM=$P($G(^RC(342,1,0)),"^",6),SITE=$G(SITE)
 I NUM="" D ENUM^PRCABJ S NUM=$P($G(^RC(342,1,0)),"^",6)
 I NUM="" L -^RC(342,"RCMSNUM") Q "-1^Cannot get event number from site parameter file"
 S NUM=$$NUM^RCMSNUM(SITE,NUM)
 S:NUM>0 $P(^RC(342,1,0),"^",6)=$P(NUM,"-",2)
 L -^RC(342,"RCMSNUM")
 Q NUM
 ;
 ;
NUM(RCSITE,RCLASNUM) ;  get next bill number
 ;  pass the site number in rcsite
 ;  pass the last bill number used in rclasnum
 ;
 ;  returns the site-next bill number
 ;           ex  460-K100001
 ;
 ;  make sure the site number exists
 I $G(RCSITE)="" N RCSITE S RCSITE=$$SITE^RCMSITE
 ;
 ;  make sure an initial number is sent to the common numbering series
 I $G(RCLASNUM)="" Q "-1^Initial AR Common Numbering Series not supplied to driver"
 ;
 N RCDIGIT3,RCDIGIT4,RCDIGIT5,RCDIGIT6,RCDIGIT7,RCNEXNUM
 ;
 ;  breakout the last 5 digits of the bill number into its ascii number
 S RCDIGIT3=$A($E(RCLASNUM,3))
 S RCDIGIT4=$A($E(RCLASNUM,4))
 S RCDIGIT5=$A($E(RCLASNUM,5))
 S RCDIGIT6=$A($E(RCLASNUM,6))
 S RCDIGIT7=$A($E(RCLASNUM,7))
 ;
 ;  add 1 to the 5 digits until you find the next bill number not
 ;  assigned, or if you hit the limit for the common numbering series
 F  D  Q:RCNEXNUM
 .   ;
 .   ;  increment the number by 1
 .   S RCDIGIT7=$$ADDONE(RCDIGIT7)
 .   ;
 .   ;  if the last digit is greater than a z (ascii 90)
 .   ;  then increment digit 6 by 1 and set the last digit to a zero
 .   I RCDIGIT7>90 S RCDIGIT6=$$ADDONE(RCDIGIT6),RCDIGIT7=48
 .   ;
 .   ;  if the 6th digit is greater than a z
 .   ;  then increment digit 5 by 1 and set the 6th digit to a zero
 .   I RCDIGIT6>90 S RCDIGIT5=$$ADDONE(RCDIGIT5),RCDIGIT6=48
 .   ;
 .   ;  if the 5th digit is greater than a z
 .   ;  then increment digit 4 by 1 and set the 5th digit to a zero
 .   I RCDIGIT5>90 S RCDIGIT4=$$ADDONE(RCDIGIT4),RCDIGIT5=48
 .   ;
 .   ;  if the 4th digit is greater than a z
 .   ;  then increment digit 3 by 1 and set the 4th digit to a zero
 .   I RCDIGIT4>90 S RCDIGIT3=$$ADDONE(RCDIGIT3),RCDIGIT4=48
 .   ;
 .   ;  if the 3rd digit is greater than a z
 .   ;  then the common numbering series is full
 .   I RCDIGIT3>90 S RCNEXNUM="-1^AR Common Numbering Series is Full" Q
 .   ;
 .   ;  assemble the next bill number
 .   S RCNEXNUM=RCSITE_"-"_$E(RCLASNUM,1,2)_$C(RCDIGIT3)_$C(RCDIGIT4)_$C(RCDIGIT5)_$C(RCDIGIT6)_$C(RCDIGIT7)
 .   ;
 .   ;  if there is a bill already assigned this number
 .   ;  then stay in the loop and increment the counter again
 .   I $D(^PRCA(430,"B",RCNEXNUM)) S RCNEXNUM=0
 ;
 Q RCNEXNUM
 ;
 ;
ADDONE(DIGIT) ;  increment the digit
 S DIGIT=DIGIT+1
 ;  skip the ascii values 58 to 64 (punctuation characters)
 ;  go from ascii 57 (number 9) to ascii 65 (letter A)
 I DIGIT=58 S DIGIT=65
 ;  do not allow the digit to be the letter o (ascii 79)
 ;  if it is, increment it to the letter p (ascii 80)
 I DIGIT=79 S DIGIT=80
 Q DIGIT
 ;
 ;
OLDNUM(SITE,NUM) ;Get next number
 NEW X,Y,FLG
 I NUM="" S X="-1^No number sent to common numbering series driver" G Q
 S:$G(SITE)="" SITE=$$SITE^RCMSITE
BEG F Y=3:1:7 S X(Y)=$S($E(NUM,Y)]"":$A($E(NUM,Y)),1:48)
 F Y=7:-1:3 D  Q:FLG
   .I Y=3,X(Y)=$A("9") S X(Y)=$A("A") S FLG=1 Q
   .I X(Y)=$A("9"),X(Y-1)=$A("Z") S X(Y)=$A("A") S FLG=1 Q
   .I X(Y)=$A("N") S X(Y)=$A("P") S FLG=1 Q
   .I X(Y)=$A("9") S X(Y)=$A("0") S FLG=0 Q
   .I Y=7,X(7)=$A("Z") S FLG=2 Q
   .S X(Y)=X(Y)+1 S FLG=1
   .Q
 I FLG=1 D  I $D(^PRCA(430,"B",SITE_"-"_NUM)) G BEG
   .S NUM=$E(NUM,1,2) F Y=3:1:7 S NUM=NUM_$C(X(Y))
   .Q
 I FLG=2 S NUM="-1^Common Numbering series is 'full'"
 S:+NUM'=-1 NUM=SITE_"-"_NUM
Q Q NUM
