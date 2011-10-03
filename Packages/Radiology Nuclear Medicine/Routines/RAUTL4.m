RAUTL4 ;HISC/CAH,FPT,GJC AISC/SAW-Utility Routine ;2/9/98  12:37
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
EN1 ;ENTRY POINT FOR INPUT TRANSFORM FOR FIELD 5, FILE 74
 S RAX=$G(^RARPT(DA,0))
 I X="R",$D(^RA(79.1,+$P(^RADPT(+$P(RAX,U,2),"DT",(9999999.9999-$P(RAX,U,3)),0),U,4),0)),$P(^(0),U,17)'["Y" K X W !,"This Imaging Location does not allow the use of 'RELEASED/NOT VERIFIED' status!" G EXIT
 G EXIT:X'="V" S RACI=$S($D(RACNI):+RACNI,1:+$O(^RADPT(+$P(RAX,U,2),"DT",9999999.9999-$P(RAX,U,3),"P","B",+$P(RAX,U,4),0)))
 I '$D(^RADPT(+$P(RAX,U,2),"DT",9999999.9999-$P(RAX,U,3),"P",RACI,0)) K X W !?3,"Exam information is missing.  Unable to continue." G EXIT
 S RA0=^RADPT(+$P(RAX,U,2),"DT",9999999.9999-$P(RAX,U,3),"P",RACI,0),RAY=$S($D(^RAMIS(71,+$P(RA0,U,2),0)):$P(^(0),U,7),1:"N")
 I RAY'["Y",$D(^VA(200,+$P(RA0,U,12),0)) S RAY=$S($D(^("RA")):$P(^("RA"),U),1:"N")
 I RAY["Y",'$D(^VA(200,+$P(RA0,U,15),0)) K X W !?3,"Staff review is required to verify this report!" G EXIT
 I '$P(RA0,U,12),'$P(RA0,U,15) K X W !?3,"You must have at least an interpreting 'resident' or 'staff' entered before you can verify this report!" G EXIT
 I $D(^RA(79,+$P(^RADPT(+$P(RAX,U,2),"DT",(9999999.9999-$P(RAX,U,3)),0),U,3),.1)),$P(^(.1),U,16)="Y",$O(^RARPT(DA,"I",0))<0 K X W !?3,"An impression was not entered. Verifying is not allowed!"
 ; Handle the situation where a report moves from no report status
 ; (null) to a report status of verified.  This situation happens at
 ; sites when creating stub reports through the Imaging software.
 I $P(RAX,"^",5)="",(X="V") D
 . X:$D(^DD(74,5,1,2,2))#2 ^(2) ; kill 'ARES' xref
 . X:$D(^DD(74,5,1,3,2))#2 ^(2) ; kill 'ASTF' xref
 . Q
EXIT K RA0,RAX,RAY Q
ASK ;Prompt for range of entries, parse response
 ;INPUT VARIABLES:     ;ch
 ; RAF1: If defined, a list or range of numbers are permitted i.e,
 ;       1,2,3-8.  If not defined, only single number input is permitted.
 ; RACNT=highest possible number in range
 ; ^TMP($J,"RAEX",n)=array of acceptable numeric responses
 ;OUTPUT VARIABLES:
 ;  RADUP(n)=array of all selected numeric responses
 K RADUP S (RAERR,RAI)=0
 S X=$$USRSEL($D(RAF1)#2,$G(RACNT)) Q:X="^"!(X="")
 ; X returns: a single # -OR- a list of #'s i.e, 1-3,8 or 2,3,4 -OR- '^' 
 I '$D(RAF1),'$D(^TMP($J,"RAEX",+X)) W !!?3,*7,"Item ",+X," is not a valid selection.",! G ASK
 I '$D(RAF1) S X=+X,Y=^TMP($J,"RAEX",+X) Q
PARSE ; Parse out the list of numbers entered by the user.
 S RAI=RAI+1,RAPAR=$P(X,",",RAI) G EX:RAPAR="" I RAPAR?.N1"-".N S RADASH="" F RASEL=$P(RAPAR,"-"):1:$P(RAPAR,"-",2) D CHK G ASK:RAERR
 I '$D(RADASH) S RASEL=RAPAR D CHK
 K RADASH G ASK:RAERR,PARSE
 ;
CHK I $D(RADASH),+$P(RAPAR,"-",2)<+$P(RAPAR,"-") S RAERR=1 W !?3,*7,"Invalid range of numbers specified." Q
 I RASEL'?.N!(RASEL'=+RASEL)!(RASEL?16.N.E) D  Q
 . W !?3,$C(7),"Item ",RASEL," is not a valid selection.",!
 . S RAERR=1
 . Q
 I '$D(^TMP($J,"RAEX",RASEL)) W !?3,*7,"Item ",RASEL," is not a valid selection.",! S RAERR=1 Q
 I $D(RADUP(RASEL)) W !?3,*7,"Item ",RASEL," was already selected.",! S RAERR=1 Q
 S RADUP(RASEL)="" Q
EX S X="" I 'RAERR,$D(RADUP) S X=1
 Q
 ;
UPPER ;Convert X to uppercase letters, return as Y
 S Y=$$UP^XLFSTR(X)
 Q
ORDEL ; Inform the 'Rad' user that the 'Order' field is null!
 ; Called from the [RA STATUS ENTRY] template.
 W !!?5,"The value for the 'Order' field has been deleted, this"
 W !?5,"Examination Status is now inactive/invalid.  Please use"
 W !?5,"the 'List Exams with Inactive/Invalid Statuses' option to"
 W !?5,"generate a report showing all inactive/invalid exams.",!,$C(7)
 Q
EMAIL ; Sent the message off to the req. physician
 Q:'$D(DUZ)#2  ; DUZ not defined!
 Q:'($D(^TMP($J,"RA AUTOE"))\10)  ; no report data, abort
 N XMDUZ,XMSUB,XMTEXT,XMY S XMDUZ=.5
 S XMTEXT="^TMP($J,""RA AUTOE"","
 S XMSUB="Rad/Nuc Med Report ("_$P($G(^RARPT(RA74IEN,0)),"^")_")"
 S XMY(RARPHYS)="" D ^XMD K ^TMP($J,"RA AUTOE")
 Q
ENV() ; Check the current environment the software is running under.
 ; If package is being installed DO NOT fire off message (0)
 ; If package wide variables are missing, DO NOT fire off message (0)
 Q:'$D(RACCESS(DUZ))\10!('$D(RAIMGTY))!('$D(RAMDIV))!('$D(RAMDV))!('$D(RAMLC)) 0 ; not in package
 Q:$D(XPDNM) 0 ; in environment check OR pre/post install routine
 Q 1
INCR(X) ; increment a variable by one
 S X=X+1,RAACNT=X
 Q RAACNT
 ;
USRSEL(RABOOL,RACNT) ; Allows the user to select a number or list of
 ; numbers within a certain range.
 ; Vars: RABOOL=1 if a list of #'s can be entered i.e, 1-3,8 -or- 2,3,4
 ;             =0 a single number is the only valid input
 ;        RACNT=the upper value within the valid range of numbers
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A",1)="Type a '^' to STOP, or"
 S DIR("A")="CHOOSE FROM 1-"_RACNT_": "
 I RABOOL D  ; setup DIR to accept a list of #'s within our range
 . S DIR(0)="LACO^1:"_RACNT_":0",DIR("?",1)="Please enter a number or range of numbers seperated by a dash,",DIR("?")="or two or more numbers seperated by a combination of commas and dashes."
 . Q
 E  D  ; setup DIR to accept a single number within our range
 . S DIR(0)="NAO^1:"_RACNT_":0",DIR("?",1)="Enter the number corresponding to the exam you wish to select.",DIR("?")="A list or range of numbers will not be accepted."
 . Q
 D ^DIR S:$D(DTOUT)!($D(DUOUT)) Y="^" ; exit iff timeout or '^'
 ; this code effects the selection of exam record data when presented
 ; to the user from options: 'Profile of Rad/Nuc Med Exams', 'Case
 ; No. Exam Edit' & 'Select Report to Print by Patient'.
 ; Called from ^RAPTLU (patient exam lookup)
 S:$E(Y,$L(Y))="," Y=$$COMMA(Y)
 Q Y
COMMA(Y) ; If the last character in a string is a comma, strip it off
 ; example: 1-100, becomes 1-100
 N RA F RA=$L(Y):-1 Q:$E(Y,RA)'=","
 Q $E(Y,1,RA)
