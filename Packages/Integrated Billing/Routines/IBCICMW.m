IBCICMW ;DSI/JSR - CLAIMSMANAGER WORKSHEET REPORT ;20-APR-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;; Program Description
 ;  This routine is a Look-upList routine that envoked ListManager
 ;  Browse Template ^IBCIBW.  
 ;  User can view the error messages for a claim in browse mode only.
 ;  Browse Mode is active during the look-up.
 ;  The data is extracted using ^IBCIWK which envokes this LM template.
 ;  The visual formating is done in ^IBCIMG.
 ;
EN ;
 S IBQUIT=0
 N I
 F I=1:1 D ASK Q:IBQUIT=1
 G Q1
ASK ; 
 S IBQUIT=0,DIC="^IBA(351.9,",DIC(0)="AEMQZ",DIC("A")="Select ClaimsManager Bill: " W !!
 D ^DIC I Y<1 S IBQUIT=1 Q
 S IBIFN=+Y D EN^IBCIWK(0)
 Q
ERR ;
 W @IOF
 W !!?10,"ClaimsManager Worksheet Report"
 W !!?5,"ClaimsManager does not have a Claims Worksheet on file for this Claim."
 W !!?5,"Claim No: "_$P(Y(0),U,1)_" Patient: "_$P($G(^DPT($P(Y(0),U,2),0)),U,1)_" Not on File"
 W !!?5,"Please verify that you entered the correct patient."
 Q
Q1 K %,IBQUIT,IBIFN,Y
 Q
