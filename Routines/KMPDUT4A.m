KMPDUT4A ;OAK/RAK; Multi-Lookup Global/Array Check ;2/17/04  10:47
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
CHECK() ;extrinsic function
 ;--------------------------------------------------------------------
 ;  return:  0 - if successful
 ;           1 - if error found
 ;
 ;  check variable 'ARRAY' for correct global or local array format
 ;--------------------------------------------------------------------
 I '$D(ARRAY) D  Q 1
 .W !?7,"...variable 'ARRAY' is undefined..."
 I $G(DIC)']"" D  Q 1
 .W !?7,"...variable 'DIC' is undefined..."
 .D FTR^KMPDUTL4("Press <RET> to continue")
 I $E(ARRAY)="^",(ARRAY'["(")!(ARRAY["()")!($E(ARRAY,$F(ARRAY,"("))']"")!($E(ARRAY,$F(ARRAY,"("))=",") D  Q 1
 .W !?7,"...global must have a subscript (ex: '^TMP($J' )..."
 ;
 ;global array must be either ^TMP or ^UTILITY - just to be safe
 I $E(ARRAY)="^" I $E(ARRAY,2,($F(ARRAY,"(")-2))'="TMP",($E(ARRAY,2,($F(ARRAY,"(")-2))'="UTILITY") D  Q 1
 .W !!?7,"...global names must be either '^TMP' or '^UTILITY'..."
 ;
 ;if local array
 I $E(ARRAY)'="^" D 
 .;remove '()' from local array if no subscript
 .I $E(ARRAY,$F(ARRAY,"("))=")"!($E(ARRAY,$F(ARRAY,"("))']"") D 
 ..S ARRAY=$TR(ARRAY,"(",""),ARRAY=$TR(ARRAY,")","")
 ;
 ;if subcript array add closing parenthesis and remove trailing comma
 I ARRAY["("!($E(ARRAY)="^") D 
 .I $E(ARRAY,$L(ARRAY))'=")" S ARRAY=ARRAY_")"
 .I $E(ARRAY,($L(ARRAY)-1))="," S ARRAY=$E(ARRAY,1,($L(ARRAY)-2))_")"
 Q 0
