PRCFDSOD ;SSOI&TFO/LKG - Invoice Tracking Clerk Separation of Duties;11/26/10  13:25 ;12/2/10  16:00
 ;;5.1;IFCAP;**154**;Oct 20, 2000;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;Extrinsic function testing if user may certify invoice against 1358
 ;for payment
 ;
 ;Input variables:
 ;PRCIEN - Internal Entry Number of file #421.5 entry
 ;PRCDUZ - Internal Entry Number of current user in file #200
 ;Returns '1' if user not permitted to certify or error in call to function
 ;Returns '0' if user permitted to certify and no error in call
VIOLATE(PRCIEN,PRCDUZ) ;Checks if user certifying invoice would be violation
 N PRCARR,PRCPO,PRCRES,PRCVAL,PRCVIOL
 I $G(PRCIEN)'>0!($G(PRCDUZ)'>0) S PRCVIOL=1,PRCARR(1)="Call to function checking for violation not set up correctly.",PRCARR(1,"F")="!!?5",PRCARR(2)="Report error to IFCAP customer support.",PRCARR(2,"F")="!?5" D EN^DDIOL(.PRCARR) G VIOLX
 S PRCVIOL=0
 S PRCPO=$P($G(^PRCF(421.5,PRCIEN,0)),U,7)_","
 I PRCPO="," D  G VIOLX
 . S PRCVIOL=1,PRCARR(1)="File #421.5 entry is missing pointer to file #442 and corrupt.",PRCARR(1,"F")="!!?5",PRCARR(2)="Invoice cannot be certified for payment without entry correction.",PRCARR(2,"F")="!?5"
 . D EN^DDIOL(.PRCARR)
 D GETS^DIQ(442,PRCPO,".01;.02","E","PRCVAL")
 G VIOLX:$G(PRCVAL(442,PRCPO,.02,"E"))'["1358"
 S PRCPO=$G(PRCVAL(442,PRCPO,.01,"E"))
 D UOKCERT^PRCEMOA(.PRCRES,PRCPO,PRCDUZ)
 S:'PRCRES PRCVIOL=1
 I $P(PRCRES,U)="E" S PRCARR(1)="Error: "_$P(PRCRES,U,2),PRCARR(1,"F")="!!?2",PRCARR(2)="You cannot certify this invoice for payment without first addressing error.",PRCARR(2,"F")="!?2" D EN^DDIOL(.PRCARR)
 I $P(PRCRES,U)=0 S PRCARR(1)=$P(PRCRES,U,2),PRCARR(1,"F")="!!?2",PRCARR(2)="Due to segregation of duties, you cannot also certify an invoice for payment.",PRCARR(2,"F")="!?2" D EN^DDIOL(.PRCARR)
VIOLX Q PRCVIOL
