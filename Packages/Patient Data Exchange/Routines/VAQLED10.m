VAQLED10 ;ALB/JFP - LOAD/EDIT PDX RECORD, PROMPT PDX;01APR93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
INIT ; -- Intialization
 D ^VAQUTL98
 ;
 N POP,DFN
 ;
 S:'$D(VAQOPT) VAQOPT="" ; -- should be set from menu option
MAIN ; -- Main entry point
 K POP,DFN,X,Y,ND,NODE
 K BADSSN,FLE,FLD ; -- table entries
 K DIROUT,DIRUT,DTOUT,DUOUT
 K VAQIN,VAQDFN,VAQPTNM,VAQISSN,VAQIDOB,VAQEDOB,VAQPTID,VAQESSN
 S POP=0
 ;
 ; -- Call to Dir to request patient from patient file (2)
 S DIR("A")="Identify PDX: "
 S DIR(0)="FAO^1:30^K:(X'=$C(32)&($L(X)<3)) X"
 S DIR("?")="Enter Patient's Name (Last,First Middle) or SSN or Transaction #"
 S DIR("??")="^D HLPTRN1^VAQLED09"
 W !! D ^DIR K DIR G:$D(DIRUT) EXIT
 S (X,VAQIN)=Y
 ;
 ; -- Function call to get patient from transaction file (DIC)
 S VAQDFN=$$GETTRN^VAQUTL96(X)
 D:VAQDFN=-1 PTNFND ; -- patient not in transaction file
 G:POP MLOOP
 D:VAQDFN>0 HEADER ; --   builds variables for header
 D EP^VAQLED01 ; -- Call to list processor (status screen)
MLOOP G MAIN ; -- loop back until no more patient added
 ;
PTNFND ; -- Requested PDX not found
 W !,"Patient not found in PDX transaction file..."
 S POP=1
 QUIT
 ;
HEADER ; -- Extracts elements for header
 ;W !,"VAQDFN = ",VAQDFN
 F ND=0,"QRY" S NODE(ND)=$G(^VAT(394.61,+VAQDFN,ND))
 S VAQPTNM=$P(NODE("QRY"),U,1),VAQISSN=$P(NODE("QRY"),U,2)
 S VAQESSN=$$DASHSSN^VAQUTL99(VAQISSN)
 S VAQIDOB=$P(NODE("QRY"),U,3),VAQEDOB=$$DOBFMT^VAQUTL99(VAQIDOB)
 S VAQPTID=$P(NODE("QRY"),U,4)
 QUIT
 ;
EXIT ; -- Cleanup and exit routine
 K POP,DFN,X,Y,ND,NODE
 K BADSSN,FLE,FLD ; -- table entries
 K DIROUT,DIRUT,DTOUT,DUOUT
 K VAQIN,VAQDFN,VAQPTNM,VAQISSN,VAQIDOB,VAQEDOB,VAQPTID,VAQOPT,VAQESSN
 QUIT
 ;
END ; -- End of code
 QUIT
