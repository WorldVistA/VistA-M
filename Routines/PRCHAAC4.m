PRCHAAC4 ;WIFO/CR-General Questions Utility ;7/8/05 1:43 PM
V ;;5.1;IFCAP;**79,100**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;This routine is called from the input template for Detailed purchase
 ;card and any other place where the field Federal Supply Classification
 ;is used. It is also used in combination with tags EN10-EN101 of
 ;PRCHNPO7. The variable PRCHANS is not killed here. Instead, it is 
 ;killed within various PO input templates where it is used.
 N L,M,X
 S L(1)=$TR($J("",60)," ","-")
 S L(2)="     Select one Item Type: Goods (G)  or  Services (S)"
 S L(3)=$TR($J("",60)," ","-")
 S M(1)="     Answer with G, g, S, s, or '^' to exit"
 ;
 D FT^PRC0A(.L,.M,"     Enter an Item Type","","")
 S X=$E(L,1,1) X "F %=1:1:$L(X) S:$E(X,%)?1L X=$E(X,0,%-1)_$C($A(X,%)-32)_$E(X,%+1,999)" S L=X
 I "GS^"'[L G V
 S PRCHANS=L
 QUIT
