BPSOS2C ;BHAM ISC/FCS/DRS/DLF - BPSOS2 continuation ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
LABELS ;EP - from BPSOS2 ; set up the labels display
 N R,C,X,R1,I
 ;
 ; Display Headers for In Progress claims
 S R=1,C=3,X="* CLAIM STATUS *" D L1
 F I=0,10,30,40,50,60,70,90 S R=R+1,X=$$STATI^BPSOSU(I) D L1
 S R1=R
 ;
 ; Display Headers for Completed claims
 S R=1,C=40,X="* CLAIM RESULTS *" D L1
 F I=1:1:8 S R=R+1,X=$P($T(HDR+I),";",3) D L1
 ;
 ; Update Line Counter to side with highest number of rows
 S VALMCNT=$S(R>R1:R,1:R1)
 Q
L1 ; given R=row,C=col,X=string
 ; Duplicate of L1^BPSOS2B
 D SET^VALM10(R,$$SETSTR^VALM1(X,$G(@VALMAR@(R,0)),C,$L(X)))
 I $$VISIBLE^BPSOS2B(R) D WRITE^VALM10(R)
 Q
HDR ;;
 ;;Paid claims
 ;;Rejected claims
 ;;Dropped to Paper
 ;;Duplicate claims
 ;;Captured claims
 ;;Accepted Reversals
 ;;Rejected Reversals
 ;;Errors
