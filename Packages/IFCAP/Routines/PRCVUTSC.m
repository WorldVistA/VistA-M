PRCVUTSC ;WOIFO/DST - Convert non-formatted string ; 2/11/03 4:52pm
 ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CONV(STR,ACT,SC) ; 
 ; 
 ; Initial data for HL7, HL() array, will be used in this routine.
 ; Such as HL("ECH"), HL("FS")...
 ;
 ; Input:
 ;       STR - A string to be convert
 ;       ACT - Action, E - from escape sequences to special char
 ;                     C - from special char to escape sequences
 ;       SC  - String of special character used in this HL7 message
 ;               SC char 1 - Field separator
 ;                  char 2 - Component separator
 ;                  char 3 - Repetition separator
 ;                  char 4 - Escape sequence character
 ;                  char 5 - Subcomponent separator
 ;
 ; Output:
 ;       STR1 - A converted string
 ;        
 N LEN,SP,SP1,STR1,PRCVFS,PRCVCS,PRCVRS,PRCVES,PRCVSS
 I $L($G(STR))=0!($L($G(ACT))=0) Q ""
 S PRCVFS=$E(SC,1)
 S PRCVCS=$E(SC,2)
 S PRCVRS=$E(SC,3)
 S PRCVES=$E(SC,4)
 S PRCVSS=$E(SC,5)
 S LEN=$L(STR)
 I ACT="C" D TOC Q STR1
 ;
TOE ; Converted from Escape Sequences to special characters
 ; PRCVFS <== \F\  Field separator
 ; PRCVCS <== \S\  Component separator
 ; PRCVRS <== \R\  Repetition separator
 ; PRCVES <== \E\  Escape sequence character
 ; PRCVSS <== \T\  Sub-component separator
 ;
 N I,J,K,LEN1,SE,SE1,SP,STR2
 S LEN1=0
 S STR1=STR
 ;
 ; Go through special characters listed in CH and converted, one by one.
 ;
 F K=1:1 Q:$P($T(CH+K),";;",2)']""  D
 . S SE=$P($P($T(CH+K),";;",2),";",2)  ; correspond special character
 . F I=1:1 S STR2(I)=$P(STR1,SE,I) Q:STR2(I)=""  S SE1(I)=SE
 . K STR2(I)
 . F J=1:1:I-1 S LEN1=LEN1+$L(STR2(J))+$L(SE1(J))
 . I LEN1>$L(STR1) K SE1(I-1)
 . S LEN1=0
 . S SP=$P($P($T(CH+K),";;",2),";",1)
 . S STR2=""
 . F I=1:1 Q:$G(STR2(I))']""  D
 .. S STR2=STR2_STR2(I)
 .. S:$D(SE1(I)) STR2=STR2_@SP
 . S STR1=STR2
 . K SP,STR2
 Q STR1
 ;
TOC ; Converted from special characters to Escape Sequences
 ; PRCVFS ==> \F\  Field separator
 ; PRCVCS ==> \S\  Component separator
 ; PRCVRS ==> \R\  Repetition separator
 ; PRCVES ==> \E\  Escape sequence character
 ; PRCVSS ==> \T\  Sub-component separator
 ;
 N C1,I
 S STR1=""
 F I=1:1:LEN D
 . S C1=$E(STR,I)
 . S STR1=STR1_$S(C1=PRCVFS:"\F\",C1=PRCVCS:"\S\",C1=PRCVRS:"\R\",C1=PRCVES:"\E\",C1=PRCVSS:"\T\",1:C1)
 . Q
 Q
 ;
CH ; Convert characters
 ;;PRCVFS;\F\;Field separator
 ;;PRCVCS;\S\;Component separator
 ;;PRCVRS;\R\;Repetition separator
 ;;PRCVES;\E\;Escape sequence character
 ;;PRCVSS;\T\;Subcomponent separator
 ;;
