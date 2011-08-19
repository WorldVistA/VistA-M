XIPXREF ;OIFO/SO- CONTAINS ANYCROSS REFERENCE LOGIC;5:20 AM  21 Jun 2003
 ;;8.0;KERNEL;**292**;Jul 10, 1995
 ;
X512AD ;Cross-reference to determine if any changes have been made to
 ;a record during the Update process
 N XIPXREF
 S XIPXREF=0
 D CHK
 I XIPXREF S ^XIP(5.12,"AD",DA)=""
 Q
 ;
X513AC ;
 N XIPXREF
 S XIPXREF=0
 D CHK
 I XIPXREF S ^XIP(5.13,"AC",DA)=""
 Q
 ;
CHK ;Compare the X1(n) array to X2(n) array
 N I
 S I=0
 F  S I=$O(X1(I)) Q:I<1  D
 . I X1(I)'=X2(I) S XIPXREF=1
 Q
