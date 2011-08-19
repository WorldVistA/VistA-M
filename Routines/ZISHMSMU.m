ZISHMSMU ; IHS/DSM/MFD - HOST COMMANDS FOR UNIX ; [ 06/03/96  10:58 AM ]
 ;;8.0;KERNEL;;JUL 10, 1995
 ;
 ; Excepted from IHS SAC 6.1.5, 6.1.2.2 and 6.1.2.3 memo dated 16Nov93.
 ;
 ; Rename to %ZISH in the managers account
 ;
OPEN(ZISH1,ZISH2,ZISH3) ; -----  Open unix file.
 ;  S Y=$$OPEN^%ZISH("/directory/","filename","R")
 ;error    1=no dev
 ;         2=open new fl with 'R'
 ;         3=passed fls by ref
 ;         4=invalid fi len
 ;
 ; ---------------------------------------------------------------
 ; PROGRAMMERS NOTE:  IHS/ADC/GTH - 06-03-96
 ; The VA's K8 version of %ZISH added another parameter to $$OPEN,
 ; the "handle name" of the file, but put the parameter at the
 ; beginning of the formal parameter list, instead of at the end,
 ; causing backwards incompatibility problems.
 ; This version is the IHS's version, with three parameters.
 ; ---------------------------------------------------------------
 ;
 NEW ZISHDF,ZISHIOP,%ZIS,POP,ZISHQ,IOUPAR
 ;
 ; -- Directory format.
 D DF(.ZISH1)
 ;
 ; -- Pass by value, or quit.
 I $O(ZISH2(0)) S ZISHX=3 Q ZISHX
 ;
 ; -- Check filename length.
 D FL(.ZISH2)
 I ZISH2=4 Q ZISH2
 ;
 S ZISHDF=$S(ZISH1'="":ZISH1_ZISH2,1:ZISH2)
 ;
 ; -- Open MSM host.
 F ZISHIOP=51:1:54 I '$D(IO(1,ZISHIOP)) S IOP=ZISHIOP,%ZIS("IOPAR")="("""_ZISHDF_""":"""_ZISH3_""")" D ^%ZIS Q:'POP
 I POP Q 1
 ;
 ; -- Check new filename with "R" privileges.
 I ZISH3="R" D
 .U IO I $ZA=-1 S ZISHQ=2 D ^%ZISC
 ; Excepted from SAC 6.1.5, 6.1.2.2 and 6.1.2.3 memo dated 16Nov93.
 ;
 I '$D(ZISHQ),'$D(ZTQUEUED) U IO(0)
 Q $S($D(ZISHQ):ZISHQ,1:0)
 ;
DEL(ZISH1,ZISH2) ; -----  Delete file(s).
 ;  S Y=$$DEL^%ZISH("/directory/","filename")
 ;                               ,.array)
 NEW ZISHDA,ZISHF,ZISHX,ZISHQ,ZISHDF,ZISHC
 ;
 ; -- Directory format.
 D DF(.ZISH1)
 ;
 ; -- Set array if filename(s) passed by value.
 I '$O(ZISH2(0)) S ZISH2(1)=ZISH2
 ;
 ; -- Get filename(s) to act on.
 ; -- No '*' allowed.
 F ZISHDA=0:0 S ZISHDA=$O(ZISH2(ZISHDA)) Q:'ZISHDA  S ZISHF=ZISH2(ZISHDA) I ZISHF["*" S ZISHX=1,ZISHQ=1 Q
 I $D(ZISHQ) Q ZISHX
 F ZISHDA=0:0 S ZISHDA=$O(ZISH2(ZISHDA)) Q:'ZISHDA  S ZISHF=ZISH2(ZISHDA) D
 . I ZISH1'="" S ZISHDF=ZISH1_ZISHF
 . S ZISHC="rm "_$S(ZISH1'="":ZISHDF,1:ZISHF)
 . D JW
 .Q
 Q ZISHX
 ;
FROM(ZISH1,ZISH2,ZISH3,ZISH4,ZISH5) ; -----  Get unix file(s) from.
 ;  S Y=$$FROM^%ZISH("/dir/","fl","mach","qlfr","/dir/")
 ;                           "fl*"
 ;                           .array
 Q 20
 ;
SEND(ZISH1,ZISH2,ZISH3) ;Send unix fl
 ;  S Y=$$SEND^%ZISH("/dir/","fl","mach")
 ;                           "fl*"
 ;                           .array
 NEW ZISH,ZISHPARM
 S ZISH1=$G(ZISH1) ; If directory not passed, use system.
 I '$L($G(ZISH2)) Q "-1^<file not specified>"
 I '$L($G(ZISH3)) Q "-1^<destination not specified>"
 S Y=$$LIST(.ZISH1,ZISH2,.ZISH2) ; Put array of files in ZISH2()
 ;I OS=AIX S ZISHPARM="-nc"
 S ZISHPARM="-nc"
 ; -n = suppress sending results in UNIX mail message to the user
 ; -c = pack file(s) with 'compress' before sending
 ;I OS=SCO S ZISHPARM="-p"
 ; -p = pack the file before the send request
 F ZISH=1:1 Q:'$D(ZISH2(ZISH))  S ZISHC="sendto "_ZISHPARM_" "_ZISH3_" "_ZISH1_ZISH2(ZISH) D JW
 Q ZISHX
 ;
LIST(ZISH1,ZISH2,ZISH3) ; -----  Set local array holding filename(s).
 ;  S Y=$$LIST^%ZISH("/dir/","fl",".return array")
 ;                           "fl*",
 ;                           .array,
 ;
 NEW ZISHC,ZISHDA,ZISHDF,ZISHX,ZISHLN,ZISHF,X,Y,POP,ZISHIOP1
 ;
 ; -- Directory format.
 D DF(.ZISH1)
 ;
 ; -- Init ZISHAUTO.$J.
 S ZISHC="rm ZISHAUTO."_$J
 D JW
 ;
 ; -- Set array if filename(s) are passed by value.
 I '$O(ZISH2(0)) S ZISH2(1)=ZISH2
 ;
 ; -- Get filename(s) to act on.
 ; -- Append listing to ZISHAUTO.$J.
 F ZISHDA=0:0 S ZISHDA=$O(ZISH2(ZISHDA)) Q:'ZISHDA  S ZISHF=ZISH2(ZISHDA) D
 . S ZISHDF=$S(ZISH1'="":ZISH1_ZISHF,1:ZISHF)
 . S ZISHC="ls "_ZISHDF_" >> ZISHAUTO."_$J
 . D JW
 .Q
 ;
 ; -- Open ZISHAUTO.$J to read.
 ; -- Create the 'Return Array' to pass back to user.
 S ZISHIOP1=ION_";"_IOST_";"_IOM_";"_IOSL
 S ZISHX=$$OPEN("/usr/mumps/","ZISHAUTO."_$J,"R")
 I ZISHX Q ZISHX
 F ZISHLN=1:1 U IO R X Q:$$STATUS=-1  S ZISH3(ZISHLN)=$P(X,"/",$L(X,"/"))
 D ^%ZISC
 S IOP=ZISHIOP1
 D ^%ZIS
 ;
 ; -- Remove ZISHAUTO.$J.
 S ZISHC="rm ZISHAUTO."_$J
 D JW
 ;
 Q ZISHX
 ;
MV(ZISH1,ZISH2,ZISH3,ZISH4) ; -----  Rename a file.
 ;  S Y=$$MV^%ZISH("/from_dir/","from_fl","/to_dir/","to_fl")
 ;
 NEW ZISHC,ZISHX
 ;
 ; -- Directory format.
 D DF(.ZISH1)
 D DF(.ZISH3)
 ;
 ; -- Check for pass by value, or quit.
 I $O(ZISH2(0))!($O(ZISH4(0))) S ZISHX=3 Q ZISHX
 ;
 ; -- Check for 'from' and 'to' directory.
 S ZISH2=$S(ZISH1="":ZISH2,1:ZISH1_ZISH2)
 S ZISH4=$S(ZISH3="":ZISH4,1:ZISH3_ZISH4)
 ;
 S ZISHC="mv "_ZISH2_" "_ZISH4
 D JW
 Q ZISHX
 ;
PWD(ZISH1) ; -----  Print working directory.
 ;  S Y=$$PWD^%ZISH(.return array)
 ;
 ; ---------------------------------------------------------------
 ; PROGRAMMERS NOTE:  IHS/ADC/GTH - 06-03-96
 ; The VA's K 8 version makes $$PWD a parameter-less extrinsic, which
 ; makes it backwards incompatible with IHS.  This is the IHS's
 ; version of $$PWD.
 ; ---------------------------------------------------------------
 ;
 NEW %ZIS,POP,X,Y,ZISHC,ZISHDA,ZISHDF,ZISHF,ZISHIOP,ZISHLN,ZISHQ,ZISHX,ZISHSYFI,ZISHIOP1
 ;
 ; -- Init ZISHAUTO.$J.
 S ZISHC="rm ZISHAUTO."_$J
 D JW
 ;
 S ZISHC="pwd > ZISHAUTO."_$J
 D JW
 ;
 ; -- Open ZISHAUTO.$J to read.
 ; -- Create the 'Return Array' to pass back to user.
 S ZISHIOP1=ION_";"_IOST_";"_IOM_";"_IOSL
 S ZISHX=$$OPEN("/usr/mumps/","ZISHAUTO."_$J,"R")
 I ZISHX Q ZISHX
 F ZISHLN=1:1 U IO R X Q:$$STATUS=-1  S ZISH1(ZISHLN)=X
 D ^%ZISC
 S IOP=ZISHIOP1
 D ^%ZIS
 ;
 ; -- Remove ZISHAUTO.$J.
 S ZISHC="rm ZISHAUTO."_$J
 D JW
 ;
 Q ZISHX
 ;
JW ; -- MSM extrinsic.
 S ZISHX=$$JOBWAIT^%HOSTCMD(ZISHC)
 ; Excepted from SAC 6.1.5, 6.1.2.2 and 6.1.2.3 memo dated 16Nov93.
 Q
 ;
DF(X) ; ----- Directory format.
 Q:X=""
 S X=$TR(X,"\","/")
 I $E(X,$L(X))'="/" S X=X_"/"
 Q
 ;
STATUS() ; ----- EndOfFile flag.
 Q $ZC
 ; Excepted from SAC 6.1.5, 6.1.2.2 and 6.1.2.3 memo dated 16Nov93.
 ;
QL(X) ;Qlfrs
 Q:X=""
 S:$E(X)'="-" X="-"_X
 Q
 ;
FL(X) ; ----- Filename length.
 NEW ZISHP1,ZISHP2
 S ZISHP1=$P(X,"."),ZISHP2=$P(X,".",2)
 I $L(ZISHP1)>14 S X=4 Q
 I $L(ZISHP2)>8 S X=4 Q
 Q
 ;
