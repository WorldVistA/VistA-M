LRLRRVF ;LAB REFERENCE RANGE VALUE FORMATTING - LAB UTILITY; SLC-GDU; 5/25/07 3:50pm ; 5/29/07 3:21pm
 ;;5.2;LAB SERVICE;**372**;Sep 27, 1994;Build 11
EN(RLV,RHV) ;Entry point for this routine
 ;RLV - Range low value
 ;RHV - Range high value
 ;If both are null return the low value and quit
 I RLV="",RHV="" Q RLV
 ;If only the low is defined
 I RLV'="",RHV="" D  Q RLV
 . I RLV=0 S RLV="Ref: >="_RLV Q
 . I ($E(RLV,1,1)="<")!($E(RLV,1,1)=">") S RLV="Ref: "_RLV Q
 . I (RLV?.N.".".N) S RLV="Ref: >="_RLV Q
 . S RLV="Ref: "_RLV
 ;If only the high is defined
 I RLV="",RHV'="" D  Q RHV
 . I RHV=0 S RHV="Ref: "_RHV Q
 . I ($E(RHV,1,1)="<")!($E(RHV,1,1)=">") S RHV="Ref: "_RHV Q
 . I (RHV?.N.".".N) S RHV="Ref: <="_RHV Q
 . S RHV="Ref: "_RHV
 ;If both are defined
 Q RLV_" - "_RHV
