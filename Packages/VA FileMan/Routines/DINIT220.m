DINIT220 ;SFISC/DPC - LOAD DATA FOR DATA TYPE FILE ;25NOV2016
 ;;22.2;VA FileMan;**2**;Jan 05, 2016;Build 139
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT24 S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
 ;
POST23 ;POST-INIT FOR EXTENDED-DATA-TYPE PATCH.  SO WE DO NOT HAVE TO BRING ALONG THE DINIT ROUTINE ITSELF
 D CLEANDEF^DIETLIB
 D NOASK^DINIT
 S DIMODE="y" F DIFILE=.81,.81101,.81201,.86,.87 F DIFIELD=0:0 S DIFIELD=$O(^DD(DIFILE,DIFIELD)) Q:'DIFIELD  D ON^DIAUTL
 ;I $G(^DIC(9.4,13,0))["FILEMAN" S ^("VERSION")="23.0"
 Q
 ;
ENTRY ;
 ;;^DI(.81,0)
 ;;=DATA TYPE^.81^
 ;;^DI(.81,1,0)
 ;;=DATE/TIME^D
 ;;^DI(.81,2,0)
 ;;=NUMERIC^N
 ;;^DI(.81,3,0)
 ;;=SET OF CODES^S
 ;;^DI(.81,1,0)
 ;;=DATE/TIME^D
 ;;^DI(.81,2,0)
 ;;=NUMERIC^N
 ;;^DI(.81,3,0)
 ;;=SET OF CODES^S
 ;;^DI(.81,4,0)
 ;;=FREE TEXT^F
 ;;^DI(.81,5,0)
 ;;=WORD-PROCESSING^W
 ;;^DI(.81,6,0)
 ;;=COMPUTED^C
 ;;^DI(.81,7,0)
 ;;=POINTER TO A FILE^P
 ;;^DI(.81,8,0)
 ;;=VARIABLE-POINTER^V
 ;;^DI(.81,9,0)
 ;;=MUMPS^K
 ;;^DI(.81,99,0)
 ;;=RESERVED FOR FILEMAN
 ;;^DI(.87,0)
 ;;=DATA TYPE METHOD^.87^
 ;;^DI(.87,1,0)
 ;;=VALIDATE INTERNAL FORM
 ;;^DI(.87,2,0)
 ;;=INPUT TRANSFORM
 ;;^DI(.87,2,11)
 ;;=MUMPS CODE THAT TRANSFORMS X TO X, AND KILLS X IF IT IS INVALID
 ;;^DI(.87,2,21,0)
 ;;=^.871
 ;;^DI(.87,2.1,0)
 ;;=CODE TO SET POINTER SCREEN
 ;;^DI(.87,2.1,11)
 ;;=MUMPS CODE THAT SETS DIC("S")
 ;;^DI(.87,2.1,21,0)
 ;;=^.871
 ;;^DI(.87,2.1,41)
 ;;=1
 ;;^DI(.87,2.1,42)
 ;;=FOUr^3:245^D ^DIM
 ;;^DI(.87,3,0)
 ;;=OUTPUT TRANSFORM
 ;;^DI(.87,3,11)
 ;;=MUMPS CODE THAT TRANSFORMS Y TO Y.
 ;;^DI(.87,3,21,0)
 ;;=^.871
 ;;^DI(.87,3,21,1,0)
 ;;='Y COMES IN AS THE INTERNAL VALUE OF THE FIELD.  THE TRANSFORMED 'Y' IS THE USUAL EXTERNAL VALUE.
 ;;^DI(.87,4,0)
 ;;=XECUTABLE HELP
 ;;^DI(.87,4,11)
 ;;=MUMPS CODE THAT DOES A 'WRITE' TO TELL THE USER HOW TO ENTER DATA FOR THE FIELD
 ;;^DI(.87,4,21,0)
 ;;=^.871
 ;;^DI(.87,4,21,1,0)
 ;;=AT THE TIME THE XECUTABLE HELP IS EXECUTED, D0 IS THE ENTRY NUMBER IN THE FILE
 ;;^DI(.87,23,0)
 ;;=TRANSFORM FOR SORT
 ;;^DI(.87,23,11)
 ;;=MUMPS CODE THAT TRANSFORMS X TO X.
 ;;^DI(.87,23,21,0)
 ;;=^.871
 ;;^DI(.87,23,21,1,0)
 ;;=THE TRANSFORMED X IS THE VALUE USED FOR SORTING PURPOSES FOR FIELDS DEFINED WITH THIS METHOD.  'SET X=X' MEANS USE THE INTERNAL VALUE, AS WITH A DATE
 ;;^DI(.86,0)
 ;;=DATA TYPE PROPERTY^.86
 ;;^DI(.86,1,0)
 ;;=FIELD LENGTH
 ;;^DI(.86,1,11)
 ;;=THIS IS THE MAXIMUM LENGTH OF THE EXTERNAL VALUE OF THE FIELD.  E.G., '6' FOR MALE/FEMALE
 ;;^DI(.86,1,41)
 ;;=2
 ;;^DI(.86,1,42)
 ;;=N^1:999
 ;;^DI(.86,2,0)
 ;;=DECIMAL DEFAULT
 ;;^DI(.86,2,11)
 ;;=MAXIMUM NUMBER OF DECIMAL DIGITS THAT CAN OCCUR IN THE FIELD
 ;;^DI(.86,2,41)
 ;;=2
 ;;^DI(.86,2,42)
 ;;=N^1:3
 ;;^DI(.86,3,0)
 ;;=INTERNAL LENGTH
 ;;^DI(.86,3,11)
 ;;=THIS IS THE MAXIMUM LENGTH OF THE INTERNAL VALUE OF THE FIELD.  E.G., '1' FOR M/F
 ;;^DI(.86,3,41)
 ;;=2
 ;;^DI(.86,3,42)
 ;;=N^1:999 
 ;;^DI(.86,4,0)
 ;;=POINTER
 ;;^DI(.86,4,11)
 ;;=A File number or an open global reference without the "^" (e.g., "DPT(")
 ;;^DI(.86,4,41)
 ;;=4
 ;;^DI(.86,4,42)
 ;;=F^1:30^S:X X=$P($G(^DIC(X,0,"GL")),U,2),Y=X K:X'["("!("(,"'[$E(X,$L(X))) X I $D(X),$D(@("^"_X_"0)")) W "  (",$P(^(0),U),")"
 ;;^DI(.86,5,0)
 ;;=SET OF CODES
 ;;^DI(.86,5,41)
 ;;=4
 ;;^DI(.86,5,42)
 ;;=FU^5:245^I $L(X,";")<2!($L(X,";")-$L(X,":")) K X
 ;;^DI(.86,1.1,0)
 ;;=LEFT SIDE MINIMUM
 ;;^DI(.86,1.1,11)
 ;;=LOWEST NUMERIC VALUE OF LEFT SIDE
 ;;^DI(.86,1.1,41)
 ;;=2
 ;;^DI(.86,1.1,42)
 ;;=N^0:9999
 ;;^DI(.86,1.2,0)
 ;;=LEFT SIDE MAXIMUM
 ;;^DI(.86,1.2,11)
 ;;=HIGHEST NUMERIC VALUE OF LEFT SIDE
 ;;^DI(.86,1.2,41)
 ;;=2
 ;;^DI(.86,1.2,42)
 ;;=N^1:99999
 ;;^DI(.86,1.3,0)
 ;;=RIGHT SIDE MINIMUM
 ;;^DI(.86,1.3,11)
 ;;=LOWEST NUMERIC VALUE OF RIGHT SIDE
 ;;^DI(.86,1.3,41)
 ;;=2
 ;;^DI(.86,1.3,42)
 ;;=N^1:9999
 ;;^DI(.86,1.4,0)
 ;;=RIGHT SIDE MAXIMUM
 ;;^DI(.86,1.4,11)
 ;;=HIGHEST NUMERIC VALUE OF RIGHT SIDE
 ;;^DI(.86,1.4,41)
 ;;=2
 ;;^DI(.86,1.4,42)
 ;;=N^1:99999
 ;;^DI(.86,4.1,0)
 ;;=LAYGO
 ;;^DI(.86,4.1,11)
 ;;='YES' IF ADDING A NEW ENTRY TO THE POINTED-TO FILE IS PERMITTED
 ;;^DI(.86,4.1,41)
 ;;=3
 ;;^DI(.86,4.1,42)
 ;;=SOB^1:YES;0:NO
 ;;^DI(.86,7.1,0)
 ;;=PARAMETERS ALLOWED
 ;;^DI(.86,7.1,11)
 ;;='YES' if a label reference is allowed to include parameters in parentheses following the tag
 ;;^DI(.86,7.1,41)
 ;;=3
 ;;^DI(.86,7.1,42)
 ;;=SOB^1:YES;0:NO
 ;;^DI(.86,6.1,0)
 ;;=SECONDS ALLOWED
 ;;^DI(.86,6.1,11)
 ;;='YES' if a time value may be entered including SECONDS (e.g., '10:33:45')
 ;;^DI(.86,6.1,41)
 ;;=3
 ;;^DI(.86,6.1,42)
 ;;=SOB^1:YES;0:NO 
 ;;^DI(.86,6.2,0)
 ;;=EARLIEST DATE
 ;;^DI(.86,6.2,11)
 ;;=A date value representing the lowest possible value to be entered (e.g. '1/1/1841')
 ;;^DI(.86,6.2,41)
 ;;=1
 ;;^DI(.86,6.2,42)
 ;;=DO^
 ;;^DI(.86,6.3,0)
 ;;=TIME REQUIRED
 ;;^DI(.86,6.3,11)
 ;;='YES' if a time value must be entered
 ;;^DI(.86,6.3,41)
 ;;=3
 ;;^DI(.86,6.3,42)
 ;;=SOB^1:YES;0:NO
 ;;^DI(.86,6.4,0)
 ;;=IMPRECISE DATE
 ;;^DI(.86,6.4,11)
 ;;='YES' if the date being entered does NOT require a day of the month
 ;;^DI(.86,6.4,41)
 ;;=3
 ;;^DI(.86,6.4,42)
 ;;=SOB^1:YES;0:NO
 ;;^DI(.86,6.5,0)
 ;;=TIME OF DAY
 ;;^DI(.86,6.5,11)
 ;;='YES' if a time value MAY be entered along with the date
 ;;^DI(.86,6.5,41)
 ;;=3
 ;;^DI(.86,6.5,42)
 ;;=SOB^1:YES;0:NO
