KMPDUT4 ;OAK/RAK; Multi-Lookup ;2/17/04  10:46
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
SELECT(ARRAY,SORT,MAX,OPTION) ;select one or more entries
 ;--------------------------------------------------------------------
 ;  this routine lets user select one or more entries from a file
 ;
 ;    ARRAY - the array the data is to be stored in
 ;            this may be a local or global array
 ;            ARRAY(0) - will contain the number of entries selected
 ;
 ;     SORT - determines how the array is set
 ;            0 - internal file number
 ;            1 - first piece of zero node
 ;
 ;            if zero then ARRAY(internal_number)=external_format
 ;            if one then  ARRAY(external_format)=internal_number
 ;
 ;            internal_number - the internal file number selected
 ;            external_format - the first piece of the zero node or
 ;                              Y(0,0)
 ;
 ;      MAX - if defined this represents the maximum number of entries
 ;            to stuff into array
 ;            - if '*' is selected and the number of file entries
 ;              exceeds this number the array will be killed and
 ;              ARRAY(0) will be equal to "*"
 ;            - if while selecting one entry at a time the number
 ;              of entries is equal to MAX the routine will quit with
 ;              the entries stored as usual and ARRAY(0)=MAX
 ;            this is to prevent partition store errors with local
 ;            arrays or setting a global equal all the patients in
 ;            the patient file
 ;
 ;   OPTION - selected options
 ;            S - suppress asterisk (*)   ;'(* for All)' prompt
 ;            W - allow selected wildcards
 ;                example:  A*     - will select all entries beginning
 ;                                   with the letter 'A'
 ;                          SMITH* - will select all entries beginning
 ;                                   with 'SMITH'
 ;
 ;      DIC - this variable must be defined in the normal fileman
 ;            format
 ; DIC("A") - this variable should be defined
 ;            the string " (* for All)" will be concatenated to the end
 ; DIC("S") - may be defined if necessary and will be honored
 ;   DIC(0) - *** IMPORTANT ***
 ;            this will be set to DIC(0)="EQZ" for the purposes of
 ;            this routine
 ;
 ;  example:  S DIC=4,DIC("A")="Select Institution: "
 ;            D SELECT^KMPDUT4("^TMP($J,")
 ;            D SELECT^KMPDUT4("LOCAL",1,20)
 ;            D SELECT^KMPDUT4("LOCAL($J)",1,0,"W")
 ;
 ;            *** It is the programmers responsibility kill ***
 ;            ***    'ARRAY' when finished with the data    ***
 ;--------------------------------------------------------------------
 I $$CHECK^KMPDUT4A D FTR^KMPDUTL4("Press <RET> to continue") Q
 S OPTION=$$UP^XLFSTR($G(OPTION))
 S SORT=+$G(SORT),MAX=+$G(MAX) S:SORT'=1 SORT=0
 I MAX=1,(OPTION'["S") S OPTION=OPTION_"S"
 S DIC(0)="EMQZ",DTIME=$S($G(DTIME):DTIME,1:600)
 I $G(DIC("A"))'["(* for All): ",(OPTION'["S") D 
 .S DIC("A")=$G(DIC("A"))_" (* for All): "
 K @ARRAY F  D  Q:X=""!(X="^")
 .I MAX,(+$G(@ARRAY@(0))=MAX) S X="" Q
 .W !
 .I '$D(@ARRAY) W DIC("A")
 .E  W $J(" ",$L(DIC("A"))-12),"...another: "
 .R X:DTIME Q:X=""!(X="^")
 .I X="*",(MAX=1) D  Q
 ..W *7,!!?7,"...you are allowed only one selection...",!
 .I X="*",(OPTION["S") D  Q
 ..W *7,!!?7,"...'*' not allowed...",!
 .I X="*" D ALL^KMPDUT4B S X="" Q
 .I $E(X)="-" D MINUS^KMPDUT4C(X) Q
 .;-------------------------------------------------------------------
 .;  wildcard selection
 .;-------------------------------------------------------------------
 .I $E(X,2,999)["*",(OPTION["W") D WILDCARD^KMPDUT4B(X) Q
 .I $E(X,1,2)="?D"!($E(X,1,2)="?d") D DISPLAY^KMPDUT4B Q
 .I X="?",(MAX'=1) D HELP^KMPDUT4C
 .D ^DIC I Y>0,('$D(@ARRAY@($S(SORT=1:Y(0,0),1:+Y)))) D 
 ..I SORT=1 S @ARRAY@(Y(0,0))=+Y
 ..E  S @ARRAY@(+Y)=Y(0,0)
 ..S @ARRAY@(0)=$G(@ARRAY@(0))+1
EXIT ;
 K X,Y
 Q
