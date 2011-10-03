IBARXDOC ;ALB/AAS - INTEGRATED BILLING, PHARMACY COPAY INTERFACE DOC ;14-FEB-91
 ;;2.0;INTEGRATED BILLING;**156**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
XTYPE ; - tag XTYPE - returns array of billable action types for service
 ;       input x=service^dfn
 ;      output y= 1 if successful, -1^error code in not successful
 ;             y(action type,n) = action type^unit cost^service
 ;
 ;              action type is internal number in file 350.1
 ;              n=0 not billable, n=1 billable, n=2 additional data needed
 ;
 ;
NEW ;
 ;  - process new/renew/refill rx for charges
 ;  - input  x=service^dfn^action type^user duz
 ;  -        x(n)=softlink^units
 ;
 ;  - output y= 1^sum of total charges of y(n)'s if success, or -1^error code if error
 ;           y(n) pieces are:
 ;                  1 - IBnumber
 ;                  2 - total charge this entry
 ;                  3 - AR bill number
 ;                  4 - cap met flag (1=yes,0=no)
 ;                  5 - Full or Partial bill ("F", "P" or "")
 ;                  6 - Exempt (1=exempt,0=non-exempt,-1=copay off)
 ;                  7 - IEN from file 354.71
 ;
 ;
CANCEL ;  - cancel charges for a rx
 ;  - input  x   = service^dfn^^user duz
 ;           x(n)=IBnumber^Cancellation reason
 ;
 ;  - output y   = 1 if sucess, -1^error code if error
 ;           y(n)= IBnumber^total charge^AR bill number
 ;   if y  =  -1^error code then one or more
 ;      y(n)'s will =-1^error code
 ;
 ;
UPDATE ;  - will cancel current open charge and create updated entry
 ;  - input x    = service^dfn^action type^user duz
 ;          x(n) = softlink^units^IBnumber of parent to cancel^cancellation reason
 ;
 ;  - output y    = 1 if success, -1^error code if err
 ;           y(n) pieces are:
 ;                  1 - IBnumber
 ;                  2 - total charge this entry
 ;                  3 - AR bill number
 ;                  4 - cap met flag (1=yes,0=no)
 ;                  5 - Full or Partial bill ("F", "P" or "")
 ;                  6 - Exempt (1=exempt,0=non-exempt,-1=copay off)
 ;                  7 - IEN from file 354.71
 ;
STATUS ; - will return the status of an entry in file 350
 ;
 ; - call with $$STATUS^IBARX(ien from 350)
 ;
 ; - output will be:
 ;       0 = not a valid 350 ien
 ;       1 = Billed
 ;       2 = Cancelled
 ;       3 = Updated
 ;
CANIBAM ; - will allow to cancel a potential charge that has not been charged.
 ;
 ; - call with D CANIBAM^IBARX where is defined with an array of entries
 ;   to be cancelled from 354.71
 ;    ex: X("3543243A")=23423^1
 ;        X(1)=32942^1
 ;   First piece of X is the ien and second piece is the reason
 ;
 ; - output will be Y in the same numbered array where Y(x) =
 ;                   any positive number for OK
 ;                   -1^message for not OK
 ;
UPIBAM ;  - will cancel current potential charge and create updated entry
 ;    in file 354.71 - ONLY one allowed at a time.
 ;  - input x    = service^dfn^action type^user duz
 ;          x(n) = softlink^units^IBAM number (in 354.71) to cancel^cancellation reason
 ;
 ;  - output y    = 1 if success, -1^error code if err
 ;           y(n) pieces are: new IBAM number if success, -1^error code if err
 ;
