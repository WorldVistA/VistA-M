HMPMONL ;ASMR/BL, monitor library support ;Sep 24, 2016 03:07:36
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;April 14,2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q  ; no entry from top
 ;DE6526, DE6644 - routine refactored, 7 September 2016
 ;
LASTREAM() ; extrinsic variable, last freshness stream entry for this server, expects HMPMNTR in symbol table
 N SRVRNM,STREAM
 S SRVRNM=$P(HMPMNTR("zero node"),U)  ; SERVER field (#.01)
 ; last freshness stream entry, $C(1) collates after all numerics
 S STREAM=$O(^XTMP("HMPFS~"_SRVRNM_"~9"_$C(1)),-1)
 Q:$P(STREAM,"~")'="HMPFS" ""   ; not a freshness stream, return null
 Q:$P(STREAM,"~",2)'=SRVRNM ""  ; nothing for this server, return null
 Q STREAM  ; return freshness stream
 ;
SLOTS() ; extrinsic variable, check HMP EXTRACT RESOURCE entry in RESOURCE file (#3.54)
 N HMPOUT
 ;^DD(3.54,1,0)= AVAILABLE SLOTS
 D FIND^DIC(3.54,"",1,"BX","HMP EXTRACT RESOURCE","","","","","HMPOUT")  ; B cross-ref., exact match
 Q $G(HMPOUT("DILIST","ID",1,1)) ; AVAILABLE SLOTS
 ;
FRESHPRE() ; extrinsic variable, return ^XTMP freshness prefix, expects HMPMNTR in symbol table
 Q "HMPFX~"_$P(HMPMNTR("zero node"),U)_"~" ; ^XTMP prefix from node zero in file 800000
 ;
HDR(TXT) ; function, create header with TXT on left
 N HDR,X,Y
 S X=$G(HMPMNTR("site name"))_":"_$G(HMPMNTR("site hash"))  ; header
 S Y=$S($L(X)>1:X,1:"eHMP support")  ; in case HMPMNTR array not present
 S HDR=$J(Y,$L(Y)\2+40)  ; center site name and hash
 S Y=$G(TXT),$E(HDR,1,$L(Y))=Y  ;put TXT on the left
 S Y=$$NOW^HMPMONL,$E(HDR,80-$L(Y),79)=Y  ; $$NOW on the right
 Q HDR  ;  header line
 ;
NOW() ;extrinsic variable, return now in ISO format
 N HL7DT S HL7DT=$$FMTHL7^HMPSTMP($$NOW^XLFDT)
 ; e.g. 2016-12-20 09:26:51
 Q $E(HL7DT,1,4)_"-"_$E(HL7DT,5,6)_"-"_$E(HL7DT,7,8)_" "_$E(HL7DT,9,10)_":"_$E(HL7DT,11,12)_":"_$E(HL7DT,13,14)
 ;
CHKIOSL ; handle end of page
 Q:'((IOSL-4)>$Y)  ; not at bottom, exit
 D RTRN2CON  ; prompt for return to continue
 Q:HMPROMPT=U  ; no formfeed if timeout or '^'escape
 D FORMFEED  ; clear screen
 Q
 ;
NOTYET ;
 W !!,"* This feature not yet implemented.*",! Q
 ;
RTRN2CON ; return to continue prompt
 N DIR,DIROUT,DUOUT,X,Y
 ;skip line, give user a prompt to continue
 W ! S DIR(0)="EA",DIR("A")="Press ENTER to continue: " D ^DIR  ; handle the prompe here
 ; exit if user enters '^', if timeout leave DTOUT in symbol table
 S:$D(DTOUT)!$D(DUOUT)!$D(DIROUT) HMPROMPT=U ; exit eHMP monitor
 Q
 ;
FORMFEED ; issue form feed
 W @IOF S $X=0 Q  ; reset cursor and $X
 ;
