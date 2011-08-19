ZFOO ;ISF/RWF - GTM Routine to invoke an arbitrary entry point ;5/9/2002
 ;;8.0;KERNEL;**275**;Jul 10, 1995
 ;To run under VMS,
 ;  mumps ZFOO.M
 ;  link ZFOO.OBJ
 ;  In a com file
 ;  $ forfoo="$" + f$parse("user$:[gtmmgr.r]ZFOO.exe")
 ;  $ forfoo "argument"
 ;To run under Linux
 ;  mumps ZFOO.m
 ;  chmod u+x,g+x ZFOO.o
 ;  In shell script
 ;  $gtm_dist/mumps -run ZFOO "argument"
 ;
 ;Set the interupt
 S $ETRAP="D ^%ZTER HALT",$ZINTERRUPT="I $$JOBEXAM^ZU($ZPOSITION)"
 I $L($ZCMDLINE) D @$ZCMDLINE Q
 Q
