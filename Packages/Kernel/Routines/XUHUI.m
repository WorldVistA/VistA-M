XUHUI ;SFISC/SO-Main Field Event Trigger Routine ;1:05 PM  7 Nov 2002
 ;;8.0;KERNEL;**236,266**;Jul 10, 1995
 ;This routine comprised three(3) entry points:
 ;HUI(), HUIKEY(), and OPKG()
 ;
 ;PCHK1: Is the business rules check used for the top level for file
 ;#200, called from AXUHUI xref.
 ;
 ;PCHK2: Is the business rules check ussed for the KEYS multiple
 ;sub-file #200.051
 ;
 ;GETVAR: Sets up the variables that are passed thru
 ;TaskMan to the various options that are to be unwound.
 ;
 ;TASK: Sets up the variable list that is to be passed
 ;thru TaskMan and tasks the job.
 ;
 ;CLEAN: Kills any Name Spaced variables that are not implisivly Newed
 ;
HUI(XUHUIOP,XUHUINM,XUHUIA,XUHUIXR) ;This is the HUI Entry Point
 ;XUHUIOP tells the Unwinder to use either 101 for Protocol file or
 ; 19 for Option file, default = 101
 ;XUHUINM is the Name(#.01) value of the option to launched
 ;XUHUIA is a code S = Set xref; K = Kill xref; default = S
 ;XUHUIXR is the name of the xref
 ;
 N ESC S ESC=0
 D PCHK1 Q:ESC
 D GETVAR
 D TASK
 D CLEAN
 Q
 ;
GETVAR ; Get the variables that are to be passed via Taskman
 S XUHUIFIL=DIFILE ;File #, IA #3586
 I $D(DIFLD) M XUHUIFLD=DIFLD ;Field #, IA# 3586
 I '$D(DIFLD) S XUHUIFLD=""
 S XUHUIXR=$G(XUHUIXR)
 M XUHUIDA=DA ;IEN(s) of record, IA# 3586
 M XUHUIX=X ;New Style 'X' array
 M XUHUIX1=X1
 M XUHUIX2=X2
 Q
 ;
TASK ;Creat a task
 ;Check to see if Protocol DISABLED ;266
 N ESC
 S ESC=0
 I 'XUHUIOP D  Q:ESC
 . N IEN,DISABLE
 . D CLEAN^DILF
 . S IEN=$$FIND1^DIC(101,"","X",XUHUINM)
 . I $D(DIERR) D CLEAN^DILF S ESC=1 Q
 . D CLEAN^DILF
 . S DISABLE=$$GET1^DIQ(101,IEN_",",2)
 . I $D(DIERR) D CLEAN^DILF S ESC=1 Q
 . D CLEAN^DILF
 . I DISABLE'="" S ESC=1 ;Protocol is DISABLED
 . Q
 N ZTSAVE,ZTDTH,ZTIO,ZTRTN,ZTDESC,ZTREQ,ZTSK ;266
 S XUHUIA=$S('$D(XUHUIA):"S",XUHUIA="":"S",1:XUHUIA)
 S ZTSAVE("XUHUIA")=""
 S ZTSAVE("XUHUIFIL")=""
 S ZTSAVE("XUHUIFLD")=""
 S ZTSAVE("XUHUIXR")=""
 S ZTSAVE("XUHUIDA*")=""
 S ZTSAVE("XUHUIX*")=""
 S ZTSAVE("XUHUINM")="" ;Name of top level Protocol or Option
 S XUHUIOP=$S('$D(XUHUIOP):101,XUHUIOP="":101,1:XUHUIOP)
 S ZTSAVE("XUHUIOP")=""
 S ZTDTH=$H,ZTIO="",ZTRTN="DEQUE^XUHUI",ZTREQ="@"
 S ZTDESC="TASKED FIELD CHANGED EVENT ("_$S(XUHUIA="S":"SET)",1:"KILL)")
 D ^%ZTLOAD
 Q
 ;
DEQUE ;From: TaskMan
 S X=XUHUINM
 S DIC=$S(XUHUIOP=101:"^ORD(101,",XUHUIOP=19:"^DIC(19,",1:"")
 D EN^XQOR
 D CLEAN ; Kill off XUHUI* variables that are passed via Taskman
 Q
 ;
HUIKEY(XUHUIOP,XUHUINM,XUHUIA,XUHUIXR) ;HUI Key check Entry Point
 ;XUHUIOP tells the Unwinder to use either 101 for Protocol file or
 ; 19 for Option file, default = 101
 ;XUHUINM is the Name(#.01) value of the option to launched
 ;XUHUIA is a code S = Set xref; K = Kill xref; default = S
 ;XUHUIXR is the name of the xref
 N ESC S ESC=0
 D PCHK2 Q:ESC
 D GETVAR
 D TASK
 D CLEAN
 Q
 ;
OPKG(XUHUIOP,XUHUINM,XUHUIA,XUHUIXR) ;All Other Package Entry Point
 ;XUHUIOP tells the Unwinder to use either 101 for Protocol file or
 ; 19 for Option file, default = 101
 ;XUHUINM is the Name(#.01) value of the option to launched
 ;XUHUIA is a code S = Set xref; K = Kill xref; default = S
 ;XUHUIXR is the name of the xref
 D GETVAR
 D TASK
 D CLEAN
 Q
 ;
PCHK1 ;
 I '$D(^XUSEC("PROVIDER",DA))#2 S ESC=1 Q  ;User is not a Provider
 Q
 ;
PCHK2 ;
 I $P($G(^DIC(19.1,DA,0)),"^")'="PROVIDER" S ESC=1 Q  ;Key Not the PROVIDER key ;266
 Q
 ;
CLEAN ;Kill of XUHUI variables
 K XUHUIFIL,XUHUIFLD,XUHUIDA,XUHUIX,XUHUIX1,XUHUIX2
 Q
