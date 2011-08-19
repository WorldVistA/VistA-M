IBCIASN ;DSI/JSR - STANDALONE OPTION TO RE-ASSIGN CLAIMS ;18-MAY-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;; Program Description
 ; This routine is a standalone option routine which allows any user to
 ; re-assign a bill without going through the core IB Enter/Edit Bill 
 ; options.  Typically this optional way to assign a bill can be
 ; placed on any menu.  The decision for this will be determined 
 ; at the sites.
 ;
EN ;
 S IBQUIT=0
 F  D ASK Q:IBQUIT=1
 G Q1
ASK ; 
 N %,D,DIC,DISYS,IBCIBII,IBCIBIL,IBCICNM,IBCICOD,IBIFN,TYPE,X
 S IBQUIT=0,DIC="^IBA(351.9,",DIC(0)="AEMQZ",DIC("A")="Select ClaimsManager Bill: " W !!
 ;
 ; The security Key will determine the type of filtering
 ; Without IBCI CLAIMSMANAGER ASSIGN users will only be able to:
 ;     1) select from claims assigned to themselves
 ;     2) only select claims with IB Status of 1
 ; With IBCI CLAIMSMANAGER ASSIGN users will only be able to:
 ;     1) select from a list of all claims in 351.9 that have an IB 
 ;        status of 1
 ;
 I '$D(^XUSEC("IBCI CLAIMSMANAGER ASSIGN",DUZ)) D
 . S DIC("S")="I $D(^IBA(351.9,""ASN"",DUZ,+Y)),$F("".1."","".""_$P($G(^DGCR(399,+Y,0)),U,13)_""."")"  ;DSI/DJW 3/21/02
 E  D
 . S DIC("S")="I $F("".1."","".""_$P($G(^DGCR(399,+Y,0)),U,13)_""."")" ;DSI/DJW 3/21/02
 D ^DIC I Y<1 S IBQUIT=1 Q
 S IBIFN=+Y
 L +^DGCR(399,IBIFN):0 E  D  Q
 . W !!?4,"*** RECORD IS LOCKED ***"
 . W !?4,"Another user is currently editing this bill."
 . W !?4,"Please try again later."
 . Q
 D INFO
 L -^DGCR(399,IBIFN)
 Q
INFO ; Display the data elements on the 0 node of file 351.9 and displays
 ; biller and coder.
 ; For the purpose of defining a comment path TYPE=5 indicates that a
 ; stand alone option is calling ^IBCISC.
 ; This options allows for the re-assignement of a claim from a coder
 ; biller.
 S TYPE=5 ; This determines which path of comments/assign to person
 D STATS^IBCISC
 Q:$D(DIRUT)  ; Exit out of process
 D COMMENT^IBCIUT7(IBIFN,TYPE)
 Q
Q1 ;
 K %,IBQUIT,IBIFN,Y
 Q
