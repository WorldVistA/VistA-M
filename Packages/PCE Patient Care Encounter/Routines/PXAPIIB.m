PXAPIIB ;ISA/AAS - SUPPORTED REFERENCES FOR AICS ; 1/5/07 4:59pm  ; Compiled January 18, 2007 10:03:16
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**183**;Aug 12, 1996;Build 3
 ;
 ; -- Output transforms, used for outputting entry during formatting
 ;    and after scanning before sending to PCE.
 ; -- called by the package interface file and IBDFBK3
 ;
DSPLYED(IEN) ; -- function, returns .01 field of entry ien
 ; -- output transform for Education Topics (file #9999999.09)
 ; -- example of use: S Y=$$DSPLYED^PXAPIIB(Y)
 Q $P($G(^AUTTEDT(+$G(IEN),0)),"^")
 ;
DSPLYIM(IEN) ; -- function, returns .01 field of entry ien
 ; -- output transform for Immunizations (file #9999999.14)
 Q $P($G(^AUTTIMM(+$G(IEN),0)),"^")
 ;
DSPLYEX(IEN) ; -- function, returns .01 field of entry ien
 ; -- output transform for EXAMS (file #9999999.15)
 Q $P($G(^AUTTEXAM(+$G(IEN),0)),"^")
 ;
DSPLYTR(IEN) ; -- function, returns .01 field of entry ien
 ; -- output transform for TREATMENTS (file #9999999.17)
 Q $P($G(^AUTTTRT(+$G(IEN),0)),"^")
 ;
DSPLYSK(IEN) ; -- function, returns .01 field of entry ien
 ; -- output transform for Education Topics (file #9999999.28)
 Q $P($G(^AUTTSK(+$G(IEN),0)),"^")
 ;
DSPLYHF(IEN) ; -- function, returns .01 field of entry ien
 ; -- output transform for Health Factors (file #9999999.64)
 Q $P($G(^AUTTHF(+$G(IEN),0)),"^")
 ;
 ;
 ; --  Validation routines, used by the utility to validate active
 ;     entries on a form, called from package interface file.
 ;
TESTEDT ; -- does X point to a valid Education Topic?  Kills X if not.
 ;    input  X := pointer to 9999999.09
 ;    output   := if valid x=x,y=""
 ;             := if entry not exist           x is killed, y=""
 ;             := if entry exist but inactive  x is killed, y=.01 field
 ; 
 I '$G(X) K X S Y="" Q
 I '$D(^AUTTEDT(X,0)) K X S Y="" Q
 I $P($G(^AUTTEDT(X,0)),"^",3) S Y=$P(^AUTTEDT(X,0),"^") K X
 Q
 ;
TESTIMM ; -- does X point to a valid Immunization?  Kills X if not.
 ;    input  X := pointer to 9999999.14
 ;    output   := if valid x=x,y=""
 ;             := if entry not exist           x is killed, y=""
 ;             := if entry exist but inactive  x is killed, y=.01 field
 ;
 I '$G(X) K X S Y="" Q
 I '$D(^AUTTIMM(X,0)) K X S Y="" Q
 I $P($G(^AUTTIMM(X,0)),"^",7) S Y=$P(^AUTTIMM(X,0),"^") K X
 Q
 ;
TESTEXM ; -- does X point to a valid EXAM?  Kills X if not.
 ;    input  X := pointer to 9999999.15
 ;    output   := if valid x=x,y=""
 ;             := if entry not exist           x is killed, y=""
 ;             := if entry exist but inactive  x is killed, y=.01 field
 ;
 I '$G(X) K X S Y="" Q
 I '$D(^AUTTEXAM(X,0)) K X S Y="" Q
 I $P($G(^AUTTEXAM(X,0)),"^",4) S Y=$P(^AUTTEXAM(X,0),"^") K X
 Q
 ;
TESTTRT ; -- does X point to a valid Treatment?  Kills X if not.
 ;    input  X := pointer to 9999999.17
 ;    output   := if valid x=x,y=""
 ;             := if entry not exist           x is killed, y=""
 ;             := if entry exist but inactive  x is killed, y=.01 field
 ;
 I '$G(X) K X S Y="" Q
 I '$D(^AUTTTRT(X,0)) K X S Y="" Q
 I $P($G(^AUTTTRT(X,0)),"^",4) S Y=$P(^AUTTTRT(X,0),"^") K X
 Q
 ;
TESTSK ; -- does X point to a valid Skin Test?  Kills X if not.
 ;    input  X := pointer to 9999999.28
 ;    output   := if valid x=x,y=""
 ;             := if entry not exist           x is killed, y=""
 ;             := if entry exist but inactive  x is killed, y=.01 field
 ;
 I '$G(X) K X S Y="" Q
 I '$D(^AUTTSK(X,0)) K X S Y="" Q
 I $P($G(^AUTTSK(X,0)),"^",3) S Y=$P(^AUTTSK(X,0),"^") K X
 Q
 ;
TESTHF ; -- does X point to a valid Health Factor? Kills X if not.
 ;    input  X := pointer to 9999999.64
 ;    output   := if valid x=x,y=""
 ;             := if entry not exist           x is killed, y=""
 ;             := if entry exist but inactive  x is killed, y=.01 field
 ;
 I '$G(X) K X S Y="" Q
 I '$D(^AUTTHF(X,0)) K X S Y="" Q
 I $P($G(^AUTTHF(X,0)),"^",11) S Y=$P(^AUTTHF(X,0),"^") K X
 Q
 ;
POV(VISIT,ARRAY) ;
 ; -- return purpose of visit for a visit pointer
 ;    Input  Visit := visit pointer
 ;           Array := call by reference the array to put the POV into
 ;    Output Array
 ;
 N I K ARRAY
 I $G(VISIT)<0 G POVQ
 S I=0 F  S I=$O(^AUPNVPOV("AD",VISIT,I)) Q:'I  S ARRAY(I)=^AUPNVPOV(I,0)
POVQ Q
