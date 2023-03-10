PRCHUEI ;OI&T/LKG -Routine for testing ;1/21/22  12:04
 ;;5.1;IFCAP;**227**;Oct 20, 2000;Build 1
 ;Per VA Directive 6402, this routine should not be modified.
VALIDUEI(PRCSTR) ; Returns '1' if UEI is valid and '0' if not
 N PRCVALID S PRCVALID=0
 I PRCSTR'?12UN Q 0
 I $E(PRCSTR)="0" Q 0
 I PRCSTR["O" Q 0
 I PRCSTR["I" Q 0
 I $E(PRCSTR,12)=$$UEICHK(PRCSTR) S PRCVALID=1 ; Valid if checksums match
 Q PRCVALID
 ;
UEICHK(PRCROOT) ; Calculates checksum
 N PRCI,PRCJ,PRCLEN,PRCSUM,PRCVAL
 S PRCLEN=11 ; Consider the initial 11 characters of the GSA Unique Entity Identifier; the 12th character is the checksum digit to be calculated
 F PRCI=1:1 D  Q:PRCSUM?1N  ; Repeat the calculation until a single digit value has been calculated
 . S PRCSUM=0
 . F PRCJ=1:1:PRCLEN D  ; Go down the length of the string to extract each character for processing
 . . S PRCVAL=$E(PRCROOT,PRCJ) S:PRCI=1 PRCVAL=$A(PRCVAL) ; use the ASCII code value for characters in initial string but not sums
 . . S PRCVAL=(PRCVAL*PRCJ)#10 ; Calculate modulo 10 of product value times position
 . . S PRCSUM=PRCSUM+PRCVAL ; Sum up the modulo values
 . S PRCROOT=PRCSUM,PRCLEN=$L(PRCROOT) ; The sum is the new string to process
 Q PRCROOT ; Function returning the calculated checksum digit
