IBCNEUT1 ;DAOU/ESG - IIV MISC. UTILITIES ;03-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Can't be called from the top
 Q
 ;
FO(VALUE,LENGTH,JUSTIFY,FILL,TRUNC) ; Formatted output function
 ;
 ; Input parameters:
 ;   VALUE    the data to get formatted (required)
 ;   LENGTH   the resulting length of the formatted string (required)
 ;   JUSTIFY  "L" or "R" to indicate left or right justification
 ;               Default is "L" if not passed
 ;   FILL     the character to fill in the spaces
 ;               Default is a space if not passed
 ;   TRUNC    Whether or not to truncate Value if its longer than length
 ;               Default is Yes, to truncate if not passed
 ;
 NEW PAD,Z
 I LENGTH>200 S LENGTH=200               ; reasonable length
 S JUSTIFY=$G(JUSTIFY,"L")               ; default Left
 S FILL=$E($G(FILL)_" ")                 ; default space
 S TRUNC=$G(TRUNC,1)                     ; default true
 S $P(PAD,FILL,LENGTH-$L(VALUE)+1)=""
 S Z=""
 ;
 ; Check for JUSTIFY being "R" first
 I JUSTIFY["R" D  G FOXIT
 . I $L(VALUE)'>LENGTH S Z=PAD_VALUE Q
 . I 'TRUNC S Z=VALUE Q
 . S Z=$E(VALUE,$L(VALUE)-LENGTH+1,$L(VALUE)) Q
 . Q
 ;
 ; JUSTIFY is "L" below
 I $L(VALUE)'>LENGTH S Z=$E(VALUE_PAD,1,LENGTH) G FOXIT
 I 'TRUNC S Z=VALUE G FOXIT
 S Z=$E(VALUE,1,LENGTH)
 ;
FOXIT ;
 Q Z
 ;
 ;
AMLOOK(NAME,ERRFLG,LIST) ; Look-up an ins. co. name in Auto Match
 ;
 ; Input parameters
 ;   NAME       Insurance company name to look for (required)
 ;   ERRFLG     Error flag to determine whether or not to return
 ;                an array of all hits (optional)
 ;   LIST       The array to be built - passed by reference
 ;                (optional)
 ;                LIST(ins co name)=auto match value
 ;
 ; Output
 ;   The value of this function is either 0 or 1.
 ;     0 - no matches in the Auto Match file for this name
 ;     1 - at least one match was found in the Auto Match file
 ;
 NEW FOUND,AMIEN,INSNAME,AMV,AMVSTART,NOMATCH
 S FOUND=0                         ; default to not found
 KILL LIST                         ; initialize results array
 S ERRFLG=+$G(ERRFLG)              ; ERRFLG default is 0 if not present
 S NAME=$$TRIM^XLFSTR($G(NAME))    ; strip leading/trailing spaces
 I NAME="" G AMLOOKX               ; get out if NAME not present
 ;
 ; First look for direct hits in the Auto Match file
 S AMIEN=$O(^IBCN(365.11,"B",NAME,""))
 I AMIEN D
 . S FOUND=1
 . I 'ERRFLG Q
 . S INSNAME=$P($G(^IBCN(365.11,AMIEN,0)),U,2)
 . I INSNAME'="" S LIST(INSNAME)=NAME
 . Q
 ;
 ; If we found one and we're not building the array, then exit
 I FOUND,'ERRFLG G AMLOOKX
 ;
 ; Use the first character of the NAME as a seed value to start
 ; looping through the Auto Match entries.  Only need to look at
 ; entries with the "*" wildcard character.
 S AMV=$E(NAME)
 F  S AMV=$O(^IBCN(365.11,"B",AMV)) Q:$E(AMV)'=$E(NAME)  D  I FOUND,'ERRFLG Q
 . I AMV'["*" Q    ; only looking for wildcarded entries
 . ;
 . ; Ensure that the first part of NAME is the same as the first
 . ; part of the Auto Match value.
 . S AMVSTART=$P(AMV,"*",1)
 . I AMVSTART'="",$E(NAME,1,$L(AMVSTART))'=AMVSTART Q
 . ;
 . ; Build the NOMATCH variable and check it
 . D AMC("NAME",AMV,.NOMATCH,0)
 . I @NOMATCH Q
 . ;
 . ; We've got a match so process this accordingly
 . S FOUND=1
 . I 'ERRFLG Q
 . S AMIEN=$O(^IBCN(365.11,"B",AMV,""))
 . S INSNAME=$P($G(^IBCN(365.11,+AMIEN,0)),U,2)
 . I INSNAME'="" S LIST(INSNAME)=AMV
 . Q
 ;
 ; If we found one and we're not building the array, then exit
 I FOUND,'ERRFLG G AMLOOKX
 ;
 ; Now we need to look at the Auto Match entries which start with
 ; the "*" wildcard character.
 S AMV="*"
 F  S AMV=$O(^IBCN(365.11,"B",AMV)) Q:$E(AMV)'="*"  D  I FOUND,'ERRFLG Q
 . D AMC("NAME",AMV,.NOMATCH,0)    ; build the NOMATCH variable
 . I @NOMATCH Q                    ; check it
 . S FOUND=1                       ; We've got a match
 . I 'ERRFLG Q
 . S AMIEN=$O(^IBCN(365.11,"B",AMV,""))
 . S INSNAME=$P($G(^IBCN(365.11,+AMIEN,0)),U,2)
 . I INSNAME'="" S LIST(INSNAME)=AMV
 . Q
 ;
AMLOOKX ;
 Q FOUND
 ;
 ;
AMC(NAME,AMV,MATCH,FLAG) ; Auto Match check function
 ;
 ; NAME   - literal variable name to be matched; enclosed in quotes
 ; AMV    - Auto Match Value to be pattern matched
 ; MATCH  - Variable passed by reference; returns condition check command
 ; FLAG   - if 1, then pattern match check is positive (default)
 ;        - if 0, then pattern match check is negative
 ;
 NEW NUMPCE,J,PCE,PCE1
 S FLAG=$G(FLAG,1)
 S MATCH=NAME_$S('FLAG:"'?",1:"?")
 S NUMPCE=$L(AMV,"*")
 F J=1:1:NUMPCE D
 . S PCE=$P(AMV,"*",J),PCE1=""
 . I PCE'="" S PCE1="1"""_PCE_""""
 . S MATCH=MATCH_PCE1
 . I J'=NUMPCE S MATCH=MATCH_".E"
 . Q
AMCX ;
 Q
 ;
 ;
AMSEL(AMARRAY) ; Select an insurance company name from an Auto Match hit list
 ;
 ; Input
 ;   Array of Auto Match hits.  The structure of this array is the
 ;   same as that returned by the call to $$AMLOOK above.
 ;   AMARRAY(ins co name) = Auto Match value
 ;
 ; Output
 ;   Insurance Company name (subscript of input array), or
 ;   -1 if user entered "^" or timed out, or
 ;   0 if user didn't select any of these names
 ;   No changes are made to the array.
 ;
 NEW SEL,NM,CNT,MSG,MSGNUM,CH,TXT
 NEW DIR,X,Y,DIRUT,DTOUT,DUOUT,DIROUT
 S SEL=0
 I '$D(AMARRAY) G AMSELX    ; Get out if array not passed in
 ;
 ; Display the contents of the array
 S MSG(1)="Results of Auto Match search"
 S MSG(2)=""
 S MSG(3)="  "_$$FO("Insurance Company Name",30)_"   Auto Match Value"
 S MSG(4)="  "_$$FO("----------------------",30)_"   ----------------"
 S MSG(1,"F")="!!"
 S NM="",MSGNUM=$O(MSG(""),-1),CNT=0,CH=""
 F  S NM=$O(AMARRAY(NM)) Q:NM=""  D
 . S CNT=CNT+1
 . S TXT=$$FO(NM,30)_"   "_AMARRAY(NM)
 . S MSGNUM=MSGNUM+1
 . S MSG(MSGNUM)="  "_TXT
 . I $L(CH)>440 Q
 . I CH="" S CH=CNT_":"_TXT       ; building the set of codes string
 . E  S CH=CH_";"_CNT_":"_TXT     ; for the DIR reader later on
 . Q
 ;
 ; Get out if there are no entries in the list
 I 'CNT G AMSELX
 ;
 ; One more blank line in the display
 S MSGNUM=MSGNUM+1
 S MSG(MSGNUM)=""
 ;
 ; Display the entries in the list
 DO EN^DDIOL(.MSG)
 ;
 ; Ask the first question
 S DIR(0)="YO"
 S DIR("A")="Would you like to select this insurance company"
 I CNT>1 S DIR("A")="Would you like to select one of these insurance companies"
 S DIR("B")="Yes"
 D ^DIR K DIR
 I $D(DIRUT) S SEL=-1 G AMSELX
 I 'Y S SEL=0 G AMSELX
 ;
 ; User said Yes to the above question
 ; Get out if there is only one entry in the array
 I CNT=1 S SEL=$O(AMARRAY("")) G AMSELX
 ;
 ; At this point we know there are multiple entries in the list
 S DIR(0)="SO^"_CH
 S DIR("A")="Please choose an insurance company"
 D ^DIR K DIR
 I $D(DIRUT) S SEL=-1 G AMSELX
 I 'Y S SEL=0 G AMSELX
 S SEL=$$TRIM^XLFSTR($E(Y(0),1,30),"R")    ; strip trailing spaces
AMSELX ;
 Q SEL
 ;
