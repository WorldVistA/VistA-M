XVEMSF7 ;DJB/VSHL**DIP,DIPT [07/16/94];2017-08-15  4:47 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
DIP ;;;
 ;;; D I P     Print Data
 ;;;
 ;;; 1. ENTRY POINT: EN1^DIP
 ;;;    Kills all input variables before it quits.
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    L........Set to zero or a string whose numeric evaluation is zero.
 ;;;    DIC......The global root or file number.
 ;;;    FLDS.....Fields to be printed, separated by commas.
 ;;;             FLDS=".01,.03,1;C20"
 ;;;             FLDS="[DEMO]"
 ;;;    FLDS(1)..If there are more fields than can fit in string FLDS.
 ;;;    BY.......Sort fields separated by commas. If BY is undefined, user is
 ;;;             prompted for sort conditions.
 ;;;             BY=".01;C1,.02"
 ;;;             BY="DIAGNOSIS,@" @ will ask user for that SORT BY response.
 ;;;             BY="[DEMOSORT]"
 ;;;             If BY includes more than one field, the same comma-piece
 ;;;             will identify the field in the FR and TO variables.
 ;;;    FR.......The START WITH: values of the SORT BY fields. If FR is
 ;;;             undefined, user will be asked START WITH: questions.
 ;;;             Each comma-piece can be:
 ;;;             The START WITH value.
 ;;;             Null. Sort will start from beginning of file.
 ;;;             ?. Causes START WITH: prompt.
 ;;;             @. Sort will begin with null values (entries that have no data).
 ;;;    TO.......The GO TO: values. Its characteristics are same as FR.
 ;;;    DHD......The header desired for the output. Can be:
 ;;;             @ if no header is desired.
 ;;;             @@ if no header and no formfeed is desired.
 ;;;             A literal.
 ;;;             A line of M code which must begin with a write statement.
 ;;;             Ex. DHD="W ?0 D ^ZZHDR"
 ;;;             A print template enclosed in brackets.
 ;;;             Two print templates separated by a minus sign. The first will
 ;;;             be the header and the second the trailer. ("[DEMO]-[DEMO1]")
 ;;;   DIASKHD...If set to null user will be prompted to enter a header.
 ;;;   PG........Starting page number.
 ;;;   DHIT......M code which will be executed for every entry after all the
 ;;;             fields specified in FLDS have been printed.
 ;;;   DIOEND....M code executed after printout has finished.
 ;;;   DIOBEG....M code executed before printout starts.
 ;;;   DCOPIES...If %ZIS chooses an SDP. Gives multiple copies.
 ;;;   IOP.......Set equal to a device name to preanswer the DEVICE prompt.
 ;;;             Set IOP="Q;MY PRINTER" to establish queueing.
 ;;;   DQTIME....If output is queued, this contains time to print (T@1500).
 ;;;   DIS(0)....Screen out certain entries. Contains an IF statement. If TRUE
 ;;;             the entry will print. D0 will equal internal entry number.
 ;;;   DIS(n)....You can set other elements of the DIS array. If many elements,
 ;;;             DIS(0) must be true and any one of the other elements must be
 ;;;             true for the entry to print.
 ;;;***
DIPT ;;;
 ;;; D I P T    Print and Sort Template Display
 ;;;
 ;;; 1. ENTRY POINT: ^DIPT
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    D0.....Internal number of PRINT TEMPLATE file.
 ;;;
 ;;; 1. ENTRY POINT: DIBT^DIPT
 ;;;
 ;;; 2. INPUT VARIABLES
 ;;;    D0.....Internal number of SORT TEMPLATE file.
 ;;;***
