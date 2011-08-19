DINIT24 ;SFISC/GFT-INITIALIZE VA FILEMAN ;09:09 AM  15 Sep 1994
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 K ^DD(.5)
 ;BRING IN DD FOR FUNCTION FILE .5
 S ^DIC(.5,"%D",0)="^^4^4^2940908^"
 S ^DIC(.5,"%D",1,0)="This file stores information about FUNCTIONS used by FileMan.  The first"
 S ^DIC(.5,"%D",2,0)="100 records in this file are reserved for functions brought in during the"
 S ^DIC(.5,"%D",3,0)="FileMan INIT process.  The rest of the file is available for other"
 S ^DIC(.5,"%D",4,0)="developers to enter their own functions."
DD F I=1:1 S X=$T(DD+I),Y=$P(X," ",3,99) G ^DINIT25:X?.P S @("^DD(.5,"_$E($P(X," ",2),3,99)_")=Y")
 ;;0 ATTRIBUTE^
 ;;0,"NM","FUNCTION"
 ;;.01,0 NAME^RF^^0;1^K:$L(X)<2!($L(X)>30)!(X'?1U.ANP)!(X["$") X
 ;;.01,1,0 ^.1^1^1
 ;;.01,1,1,0 .5^B
 ;;.01,1,1,1 S @(DIC_"""B"",X,DA)=""""")
 ;;.01,1,1,2 K @(DIC_"""B"",X,DA)")
 ;;.01,3 Function Name must be 2-30 characters long, beginning with Alpha.
 ;;.01,"DEL",1,0 I DA<100
 ;;.02,0 MUMPS CODE^FR^^1;E1,255^D ^DIM I $D(X),'$D(DIQUIET),'$D(DDS) W "  ..OK"
 ;;.02,3 Enter MUMPS code that sets a value into 'X'.
 ;;.02,4 N D1 S D1(1)="For a 1-argument function, use 'X' as the argument.",D1(2)="For a 2-argument function, use 'X1' and 'X'.",D1(3)="Avoid FORs, IFs, and single-character scratch variables.",D1(4)="" D EN^DDIOL(.D1)
 ;;.02,9 @
 ;;1,0 EXPLANATION^F^^9;E1,245^K:$L(X)>245 X
 ;;2,0 DATE-VALUED^S^D:YES;X:NO;O:OPTIONAL (DEPENDS ON VALUE OF ARGUMENT);^2;1^Q
 ;;9,0 NUMBER OF ARGUMENTS^N^^3;1^K:X\1'=X!(X>8) X
 ;;10,0 WORD-PROCESSING^S^W:MEANINGFUL ONLY FOR W-P;^10;1
 ;;
OSDD ; BRING IN DD FOR MUMPS OS FILE .7 (CALLED FROM ^DINIT)
 F I=2:1 S X=$T(OSDD+I),Y=$P(X," ",3,99) Q:X?.P  S @("^DD(.7,"_$E($P(X," ",2),3,99)_")=Y")
 ;;0 FIELD^
 ;;.01,0 NAME^F^^0;1^Q
 ;;.01,1,0 ^.1^1^1
 ;;.01,1,1,0 .7^B
 ;;.01,1,1,1 S ^DD("OS","B",X,DA)=""
 ;;.01,1,1,2 K ^DD("OS","B",X,DA)
 ;;.01,21,0 ^^1^1^2940909^^
 ;;.01,21,1,0 Name of a MUMPS operating system that is supported by VA FileMan.
 ;;1,0 BREAK LOGIC^RF^^1;E1,250^D ^DIM
 ;;1,9 @
 ;;1,21,0 ^^2^2^2940909^^
 ;;1,21,1,0 MUMPS code to enable terminal break, i.e., to allow the user to interrupt
 ;;1,21,2,0 processing with <CTRL-C>.
 ;;419,0 MINIMUM SAFE $S^N^^0;2^K:+X'=X X
 ;;419,21,0 ^^1^1^2940909^
 ;;419,21,1,0 The minimum value for $S that will allow routines to process successfully.
 ;;2,0 GLOBAL LENGTH (MAX)^RN^^0;3^K:+X'=X!(X<30) X
 ;;2,21,0 ^^1^1^2940909^^
 ;;2,21,1,0 Maximum allowable length of a global.
 ;;3,0 ROUTINE SIZE (MAX)^RN^^0;4^K:+X'=X!(X<2048) X
 ;;3,21,0 ^^1^1^2940909^
 ;;3,21,1,0 Maximum allowable size of a routine.
 ;;4,0 CLOSING PRINCIPAL DEVICE^S^1:ALLOWED;^0;5^Q
 ;;4,21,0 ^^1^1^2940909^
 ;;4,21,1,0 Is closing a job's principal device allowed?
 ;;5,0 NEW COMMAND^S^1:SUPPORTED;^0;6^Q
 ;;5,21,0 ^^1^1^2940909^
 ;;5,21,1,0 Is the NEW command supported?
 ;;7,0 INDIVIDUAL SUBSCRIPT LENGTH^N^^0;7^K:X\1'=X!(X<9) X
 ;;7,21,0 ^^1^1^2940909^
 ;;7,21,1,0 Maximum length of an individual subscript.
 ;;8,0 SAVE SYMBOL TABLE^F^^8;E1,250^D ^DIM
 ;;8,9 @
 ;;8,21,0 ^^1^1^2940909^
 ;;8,21,1,0 MUMPS code that saves the contents of the local symbol table.
 ;;1820,0 ROUTINE EXISTENCE TEST^F^^18;E1,250^D ^DIM
 ;;1820,9 @
 ;;1820,21,0 ^^1^1^2940909^
 ;;1820,21,1,0 MUMPS code that tests for the existence of a routine.
 ;;2425,0 SET $X & $Y FROM 'IOX' & 'IOY'^F^^XY;E1,250^D ^DIM
 ;;2425,9 @
 ;;2425,21,0 ^^2^2^2940909^^
 ;;2425,21,1,0 MUMPS code to XECUTE to move the position of the cursor to the position
 ;;2425,21,2,0 specified by the variables IOX and IOY.
 ;;190416,0 WRITE FROM SDP^F^^SDP;E1,250^D ^DIM
 ;;190416,9 @
 ;;190416,21,0 ^^4^4^2940909^
 ;;190416,21,1,0 MUMPS code that READs data from SDP and WRITEs it to a device.  The $I
 ;;190416,21,2,0 value of the SDP device should be in variable DIO and the $I value
 ;;190416,21,3,0 for the output device in IO.  The DLP variable should contain the open
 ;;190416,21,4,0 parameters of the SDP device.
 ;;190416.1,0 FIND SDP END^F^^SDPEND;E1,250^D ^DIM
 ;;190416.1,9 @
 ;;190416.1,21,0 ^^1^1^2940909^
 ;;190416.1,21,1,0 MUMPS code that tests for the end of SDP.
 ;;2619,0 ZSAVE CODE^F^^ZS;E1,250^D ^DIM
 ;;2619,9 @
 ;;2619,21,0 ^^4^4^2940909^
 ;;2619,21,1,0 MUMPS code that will save a routine to disk.  The name of the routine
 ;;2619,21,2,0 must be in variable X.  The source code of the routine should be stored
 ;;2619,21,3,0 in ^UTLITY($J,0,%Y).  Each node of the array will become a line of the
 ;;2619,21,4,0 routine.
