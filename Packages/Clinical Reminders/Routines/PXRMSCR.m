PXRMSCR ;SLC/PKR - Screens for Clinical Reminders. ;05/01/2014
 ;;2.0;CLINICAL REMINDERS;**24,26**;Feb 04, 2005;Build 404
 ;============================================
WHFSCR(NODE,PIECE) ;Whole file screen based on Class.
 ;Prevent direct FileMan editing of national entries.
 I $G(PXRMNSCR)=1 Q 1
 I '$D(DIE) Q 1
 I $G(DIC)'=DIE Q 1
 ;Do not allow selection of entries whose Class is National.
 I $P($G(^(NODE)),U,PIECE)="N" Q 0
 Q 1
 ;
