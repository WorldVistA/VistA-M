LA7UTILD ;DALOI/JMC - Duplicate comment check ;Jan 29, 2007
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
 ;
DUPCHK(LA7A,LA7B,LA7C) ; Perform duplicate comment check of two arrays, return unique entries in 3rd array
 ; Call with LA7A = array of existing comments on file (pass by reference)
 ;           LA7B = array of new comments to check against existing comments (LA7A array) (pass by reference)
 ;
 ; Returns   LA7C = array with only those comments that are new/unique (pass by reference)
 ;
 N LA7DUP,LA7I,LA7J,LA7K,LA7X,LA7Y
 S (LA7I,LA7J,LA7K)=0
 F  S LA7I=$O(LA7B(LA7I)) Q:'LA7I  D
 . S LA7X=$P(LA7B(LA7I,0),"^"),LA7X=$TR(LA7X," ",""),LA7X=$$UP^XLFSTR(LA7X)
 . S (LA7DUP,LA7J)=0
 . F  S LA7J=$O(LA7A(LA7J)) Q:'LA7J  D  Q:LA7DUP
 . . S LA7Y=$P(LA7A(LA7J,0),"^"),LA7Y=$TR(LA7Y," ",""),LA7Y=$$UP^XLFSTR(LA7Y)
 . . I LA7X=LA7Y S LA7DUP=1
 . I 'LA7DUP S LA7K=LA7K+1,LA7C(LA7K,0)=LA7B(LA7I,0)
 Q
